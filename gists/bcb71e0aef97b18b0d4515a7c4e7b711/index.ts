// Modified / modernized version of https://github.com/puppeteer/examples/blob/master/lighthouse/chromelauncher_puppeteer.js

/**
 * Copyright 2018 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * @author ebidel@ (Eric Bidelman)
 */

/**
 * How to:
 * 1. Use chrome-launcher module to launch chrome
 * 2. Connect to that browser instance using Puppeteer.
 * 3. Run Lighthouse on the page.
 */

import * as chromeLauncher from 'chrome-launcher';
import got from 'got';
import * as puppeteer from 'puppeteer';

(async () => {
  const URL = 'https://www.chromestatus.com/features';

  const opts: chromeLauncher.Options = {
    // chromeFlags: ['--headless'],
    chromePath: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    logLevel: 'info',
  };

  // Launch chrome using chrome-launcher.
  const chrome = await chromeLauncher.launch(opts);

  // Connect to it using puppeteer.connect().
  const resp = await got(`http://localhost:${chrome.port}/json/version`);
  const { webSocketDebuggerUrl } = JSON.parse(resp.body);
  const browser = await puppeteer.connect({
    browserWSEndpoint: webSocketDebuggerUrl,
  });

  const page = await browser.newPage();

  await page.goto('https://www.example.com');

  // TODO: Do something on the page

  browser.disconnect();
  await chrome.kill();
})();
