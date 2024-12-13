package com.project.dailyeat.calendar;


public class MenuDTO {
    private int menuNum;
    private String id;
    private String postdate;
    private String name;
    private double  gram;
    private double  calories;
    private double  carbs;
    private double  protein;
    private double  fat;
    private double  sugar;
    private double  nat;
    private String selectedMealType;

    public int getMenuNum() {
        return menuNum;
    }

    public void setMenuNum(int menuNum) {
        this.menuNum = menuNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPostdate() {
        return postdate;
    }

    public void setPostdate(String postdate) {
        this.postdate = postdate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getGram() {
        return gram;
    }

    public void setGram(double gram) {
        this.gram = gram;
    }

    public double getCalories() {
        return calories;
    }

    public void setCalories(double calories) {
        this.calories = calories;
    }

    public double getCarbs() {
        return carbs;
    }

    public void setCarbs(double carbs) {
        this.carbs = carbs;
    }

    public double getProtein() {
        return protein;
    }

    public void setProtein(double protein) {
        this.protein = protein;
    }

    public double getFat() {
        return fat;
    }

    public void setFat(double fat) {
        this.fat = fat;
    }

    public double getSugar() {
        return sugar;
    }

    public void setSugar(double sugar) {
        this.sugar = sugar;
    }

    public double getNat() {
        return nat;
    }

    public void setNat(double nat) {
        this.nat = nat;
    }

    public String getSelectedMealType() {
        return selectedMealType;
    }

    public void setSelectedMealType(String selectedMealType) {
        this.selectedMealType = selectedMealType;
    }

    @Override
    public String toString() {
        return "MenuDTO{" +
                "menuNum=" + menuNum +
                ", id='" + id + '\'' +
                ", postdate='" + postdate + '\'' +
                ", name='" + name + '\'' +
                ", gram=" + gram +
                ", calories=" + calories +
                ", carbs=" + carbs +
                ", protein=" + protein +
                ", fat=" + fat +
                ", sugar=" + sugar +
                ", nat=" + nat +
                ", selectedMealType='" + selectedMealType + '\'' +
                '}';
    }
}
