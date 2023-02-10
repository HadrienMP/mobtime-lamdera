import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('http://localhost:8000/');
  await expect(page).toHaveTitle(/Team Time/);
  await expect(page).toHaveURL('http://localhost:8000/');
});


test('redirect to home when arriving directly to a room', async ({ page }) => {
  await page.goto('http://localhost:8000/room/test');
  await expect(page).toHaveTitle(/Team Time/);
  await expect(page).toHaveURL('http://localhost:8000/');
});

// test('get started link', async ({ page }) => {
//   await page.goto('https://playwright.dev/');

//   // Click the get started link.
//   await page.getByRole('link', { name: 'Get started' }).click();

//   // Expects the URL to contain intro.
//   await expect(page).toHaveURL(/.*intro/);
// });
