describe("Frontend", () => {
  it("loads homepage and shows backend message", () => {
    cy.visit("http://localhost:3000");
    cy.contains("DevOps Assignment");
    cy.contains("Status: Backend is connected!");
    cy.contains("You've successfully integrated the backend!");
    cy.contains("Backend URL: http://localhost:8000");
  });
});

