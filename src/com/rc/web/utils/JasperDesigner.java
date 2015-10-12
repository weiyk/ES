package com.rc.web.utils;

import java.io.File;   
import java.lang.reflect.InvocationTargetException;   
import java.util.Iterator;   
import org.apache.commons.beanutils.BeanUtils;   

import net.sf.jasperreports.engine.JRChild;
import net.sf.jasperreports.engine.JRException;   
import net.sf.jasperreports.engine.JasperCompileManager;   
import net.sf.jasperreports.engine.JasperReport;   
import net.sf.jasperreports.engine.design.JRDesignBand;   
import net.sf.jasperreports.engine.design.JRDesignStaticText;   
import net.sf.jasperreports.engine.design.JasperDesign;   
import net.sf.jasperreports.engine.xml.JRXmlLoader;   

/**
 * 
 * <p>application name:      jasper设计</p>
 
 * <p>application describing:jasper设计</p>
 
 * @author zhou
 * @version ver 1.0
 */
public class JasperDesigner {   
    private static final String flagTextKey = "customFlagText";   
  
    public static JasperReport getJasperReport(String xmlFilePath,   
            String[][] sizeGroup) throws JRException {   
        JasperDesign design = getJasperDesign(xmlFilePath);   
        JRDesignBand columnHeader = (JRDesignBand) design.getColumnHeader();   
  
        reSetColumnHeaderHeight(columnHeader, sizeGroup);   
        reSetshapeAndPosition(columnHeader, sizeGroup);   
        addElementToColumnHeader(columnHeader, sizeGroup);   
        return JasperCompileManager.compileReport(design);   
    }   
    private static JasperDesign getJasperDesign(String filePath)   
            throws JRException {   
        return JRXmlLoader.load(new File(filePath));   
    }   
    private static void reSetColumnHeaderHeight(JRDesignBand columnHeader,   
            String[][] sizeGroup) {   
        columnHeader.setHeight(columnHeader.getHeight() * sizeGroup.length);   
    }   
    private static JRDesignStaticText getFlagTextInDesign(   
            JRDesignBand columnHeader) {   
        return (JRDesignStaticText) columnHeader.getElementByKey(flagTextKey);   
    }   
    private static void reSetshapeAndPosition(JRDesignBand columnHeader,   
            String[][] sizeGroup) {   
        JRDesignStaticText flagText = getFlagTextInDesign(columnHeader);   
        Iterator<JRChild> children = columnHeader.getChildren()   
                .iterator();   
        JRDesignStaticText element;   
        while (children.hasNext()) {   
            element = (JRDesignStaticText) children.next();   
            if (element.getX() > flagText.getX()) {   
                element.setX(flagText.getX() + flagText.getWidth()   
                        * sizeGroup[0].length);   
            }   
            if (!flagTextKey.equals(element.getKey())) {   
                element.setHeight(element.getHeight() * sizeGroup.length);   
            }   
        }   
    }   
    private static void addElementToColumnHeader(JRDesignBand columnHeader,   
            String[][] sizeGroup) {   
        JRDesignStaticText flagText = getFlagTextInDesign(columnHeader);   
        columnHeader.removeElement(flagText);   
        for (int i = 0; i < sizeGroup.length; i++) {   
            for (int j = 0; j < sizeGroup[i].length; j++) {   
                try {   
                    JRDesignStaticText newElement = (JRDesignStaticText) BeanUtils   
                            .cloneBean(flagText);   
                    newElement.setText(sizeGroup[i][j]);   
                    newElement.setX(flagText.getX() + flagText.getWidth() * j);   
                    newElement.setY(flagText.getY() + flagText.getHeight() * i);   
                    columnHeader.addElement(newElement);   
                } catch (IllegalAccessException e) {   
                    e.printStackTrace();   
                } catch (InstantiationException e) {   
                    e.printStackTrace();   
                } catch (InvocationTargetException e) {   
                    e.printStackTrace();   
                } catch (NoSuchMethodException e) {   
                    e.printStackTrace();   
                }   
            }   
        }   
    }   
}  