# Inviscid-Solvers
Two-dimensional aerodynamic analysis and flow solver attempts. Mostly small scripts with emphasis on airfoil analysis.

## Flat Plate Boundary Layer Model
An application of finite difference approximation of a two-dimensional, steady laminar flow over a surface that is a flat plate. Then we define the computational domain that is specified in the problem with a length in x-direction of 1 m and y-direction of 0.025 m. Then the domain is divided into the small elements of calculation to form a simple structure of mesh. The output is taken as a velocity contour over the flat plate.

![bl_img](https://github.com/user-attachments/assets/c4eccacf-5dd1-4790-aa2f-a051838dd68f)

For comparison with Blasius solution we can investigate the table below. In the table we consider dimensionless length parameter 𝜂 and first derivative of 𝑓′ which is proportional to the x-component of velocity in the boundary layer (𝑓 = 𝑢/𝑈𝑒).

![blasius_img](https://github.com/user-attachments/assets/d9abfc7c-d52d-41d7-aec6-674841b4f83d)


## Source Panel Method for Cyclinder
The Source Panel Method is a computational technique used in aerodynamic analysis to model the flow over objects, such as a cylinder. It involves discretizing the surface of the cylinder into a series of panels, each of which is assigned a source strength. By solving the resulting system of equations, the method approximates the velocity field around the cylinder, allowing for the calculation of aerodynamic parameters like lift and drag. This approach is particularly useful for simulating potential flow around objects in inviscid, incompressible fluid dynamics, providing a simplified yet effective way to analyze flow behavior.

## Hess Panel Method for Airfoils
The Hess Panel Method is a numerical technique used in aerodynamic analysis to solve potential flow problems around complex shapes, such as airfoils or bodies of arbitrary geometry. It discretizes the surface of the object into panels and assigns a constant source or sink strength to each panel. By solving the governing Laplace equation for the velocity potential, the method calculates the flow field around the object, allowing for the determination of aerodynamic forces like lift and drag. The Hess Panel Method is widely used for its efficiency in simulating inviscid, incompressible flows and its ability to handle complex geometries with relatively low computational cost.

## Thin Airfoil Theory
Thin Airfoil Theory is a simplified aerodynamic analysis method used to estimate the lift coefficient of an airfoil at small angles of attack. It assumes that the airfoil is thin and that the flow remains attached to the surface, neglecting viscous effects. Based on potential flow theory, the method calculates the circulation around the airfoil and relates it to the lift generated. Thin Airfoil Theory is particularly useful for predicting the aerodynamic performance of symmetric airfoils at subsonic speeds, providing a foundational understanding of airfoil lift characteristics in idealized conditions.
