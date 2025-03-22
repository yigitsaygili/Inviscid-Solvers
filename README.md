# Inviscid-Solvers
Two-dimensional aerodynamic analysis and flow solver attempts. Mostly small scripts with emphasis on airfoil analysis.

## Flat Plate Boundary Layer Model
An application of finite difference approximation of a two-dimensional, steady laminar flow over a surface that is a flat plate. Then we define the computational domain that is specified in the problem with a length in x-direction of 1 m and y-direction of 0.025 m. Then the domain is divided into the small elements of calculation to form a simple structure of mesh. The output is taken as a velocity contour over the flat plate.

![bl_img](https://github.com/user-attachments/assets/c4eccacf-5dd1-4790-aa2f-a051838dd68f)

For comparison with Blasius solution we can investigate the table below. In the table we consider dimensionless length parameter 𝜂 and first derivative of 𝑓′ which is proportional to the x-component of velocity in the boundary layer (𝑓 = 𝑢/𝑈𝑒).

![blasius_img](https://github.com/user-attachments/assets/d9abfc7c-d52d-41d7-aec6-674841b4f83d)


## Source Panel Method for Cyllinder
The Source Panel Method is a computational technique used in aerodynamic analysis to model the flow over objects, such as a cylinder. It involves discretizing the surface of the cylinder into a series of panels, each of which is assigned a source strength. By solving the resulting system of equations, the method approximates the velocity field around the cylinder, allowing for the calculation of aerodynamic parameters like lift and drag. This approach is particularly useful for simulating potential flow around objects in inviscid, incompressible fluid dynamics, providing a simplified yet effective way to analyze flow behavior.
