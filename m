Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845FE497BCC
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 10:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiAXJWY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jan 2022 04:22:24 -0500
Received: from mail-eopbgr90071.outbound.protection.outlook.com ([40.107.9.71]:13952
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233255AbiAXJWU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 04:22:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpbYaHdqniR4nPJ6vkxtFXMbmcQWuQbYIoz5FpxRoEss/4Km1zZlPV8p3ry7JkNjD6B43oSvj0jTErz0VQX0o23DC/SrbBlN975UHRUAXAGFNMGgCjII+d40TFRJTB4Bw3Q0epJLHwztZeJQq6XlG24YBlkdO/DnT8aP0GBS7niadkQZ41tn7/7fLbvE6HlapmiYZ+5V9XYPJDwB8TL9aYBV3WVlF0TFpjyd+jIa4Dj9rXxRjqJLhd/MgIie66M6mkffVGIaMPLOCoqRd1Lt/7RJfXMM/4q0bqJIkilkR68UHyip8+pPxsyox0G91CJBDC9UrCyMkOGo2ISoGERmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8RJ3jC6E9arBGQfSQkBiXWHNDOnWeX/ePWzBPoQFCk=;
 b=Tqa3DlJML6Se5hBWBlytlLpMvBlaHuKCtwZTEvGWIKqrj/9wHEPc/mi6Or3PCFAs2L2wNzPweDQMld7OptOiIRH1YoKsRCUb5yt4uvoESHcWuR1dyICJm24rAWNw8Tae9UECkB8upVdB3S89UXCdspr1LbVawqt7w38pZCQSBpMRufpAjU/GFoUs92ZKIvM7GDY7A18amQSZ1HhzqhsBvsseZaYDJaLkMFZreDhob0Z0s4zcZni8B9Co5pfc15OUGQZitlHC8inUYmJvjuAFIbOg8IwM7uDocSOpPYB0v6lyOZUgz7hWPJSjMbClmwhkyqcwkUwQKRn6udKk+0IXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0235.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 09:22:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:22:15 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Topic: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Index: AQHYEQPgKgdjFmN/j0GzHm/ZB6XnTA==
Date:   Mon, 24 Jan 2022 09:22:15 +0000
Message-ID: <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a477f472-47bb-4d73-d4d9-08d9df1b031c
x-ms-traffictypediagnostic: PR0P264MB0235:EE_
x-microsoft-antispam-prvs: <PR0P264MB0235C8A98EA262C80D9A8C88ED5E9@PR0P264MB0235.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yi3CwSSuGGlA3ba+4AkSnSjZVn/PqFNanVh4jhm9A5moBuaO4A4piu5tqAL28rXffKw1MNes43ipv0PpzLm7I1bpzkLwvbIg335Om05vW4DCyCttsCDWiM/Mn4QGWigJCSA9OqcftB6gCe4hLO1POTZNUSJ3lQOLmUl44E3TJTltkGUdvxOMxLCIXw2Ti54ZDb54OB2zqXl1lnIj7X6ph2jkBppYHQMfMLEwuXDbNj9vam0rUAA7gdKt7Crv3h7izQ7z5bYPci4+b6ZxBxhoaW1iimaQwZL+OULpxLxbGOimygzyLl3A9Nq/6iIHs5erY2AIaQ1GYC/INqxiyWqoBqVLLgYiem7Q8gOYzobq/OaiL+mNcL7+1JM0d+s42CsyPVnaWVk1bHpcFceUNDj5kt5e2gJG2VKJU4A7QTWZKBuuPPv//zgIRSdUP7P3dza7CnK+mCEvND6NNhFaexO4q+nYvw4a7Yba1DODZl+axTj1hgOb7wPKyYZIVBpn4UfpkutU/j3B/InmRPxJW5W6YgqEo+qLrUFhL3Jw23hdyU1AxdvQvm9VkX51TVBJFrxChDsXyCxvFT2P24eV6Ku3ahv2h44pQ1GMjwhfqn8FcSqegPS4nBEE/Oo55LAt0nOwFM6d1RRMoVHonPOcNBQ4v43DRXEptCFGjm3OhfsPx+WuiwK9EAT4wjVjGoJlLUU4C0RL+jrmxcj+lk1W5c9RSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6512007)(86362001)(66946007)(2906002)(4326008)(6506007)(66446008)(8676002)(64756008)(71200400001)(44832011)(36756003)(26005)(122000001)(66556008)(508600001)(186003)(66476007)(76116006)(38070700005)(91956017)(54906003)(5660300002)(110136005)(83380400001)(2616005)(6486002)(316002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cnz75I49SQedHiMgpuEyn/NmgV01t0blBoDNA97YLN4IWg5xEbk5JOk0sb?=
 =?iso-8859-1?Q?m6IlAkTWzfZAywTfHUc5WqPqs/O1VyaG8A+mpVHAF1cYAj0ifQq45W/aWE?=
 =?iso-8859-1?Q?D1JyprOwC7RCuro3eD1+o2WFyuYWlalIgG0FD19B4knCn1aB93l0boyA4f?=
 =?iso-8859-1?Q?hlPv2ohSDEJqZNCvu1ZWk7vPRE1BCEc07w3AXvNQaDWDf6x3qvPZTmjw1n?=
 =?iso-8859-1?Q?8NJBXwV13zU1s3F1jGvbYpWK2oVNyr185Zvh40v+vUmdfIQ5wdcUKwUt15?=
 =?iso-8859-1?Q?QAZiT21Jm5Gu5BNMKh5DVXYWpenRs62S6fa9AFhrejL8uxyPzYleXIKfjQ?=
 =?iso-8859-1?Q?cuP4erakTOHLVzIW/bbqvUtHxk+WDjEZzoRI/5cDvuiuPu6t7AgcxjVSnB?=
 =?iso-8859-1?Q?cyuDeWGIyErS3FjU/FNa8OaTsGvVx3mZNXwsKTHkyd5TzYINvMLiiGiIQ/?=
 =?iso-8859-1?Q?iwtI0sozRAexBC48vYCiPU497TBVMjT4xFamonslvlk9RfVmun5yVOdRc+?=
 =?iso-8859-1?Q?S8Ea3KkdxaDgo2e+3Nw6kXhJqK0XPRe0js3nRQP12OxoooHthyAdV6k99V?=
 =?iso-8859-1?Q?HT4r6ShZqGkF1AdyHRv4wihQdkxkPGb1wwuMkCal1bMVu44AmMqwHd2k00?=
 =?iso-8859-1?Q?WSMy8XlQ+Ug577P74D0q4SJD1zoJvciXLK/E/J14M4AxPh8FMXixD3R6TQ?=
 =?iso-8859-1?Q?QVzoFs7JNr7+igNinjb0CZuyZG4HGdQ/Pk6AdJYHrw/heD3n98h/26dwIE?=
 =?iso-8859-1?Q?5D7CdDFqRAFBnxy/pdtYnFfmmx5s3uWepaLh3EjrO+CK5lkKIEgKaRgoJG?=
 =?iso-8859-1?Q?DPNKtIoWIMc4RbUwg4x8JcFZIPa1ZIYmbUNae+/EBxvtYvGDx6M7FaAa7f?=
 =?iso-8859-1?Q?TUZMrkrr1I+hHQtYiGjYhz//89du1f/vHUrq05mHIMdNr6ZSS+TDMSIgtx?=
 =?iso-8859-1?Q?2ztaFzon6DSqLurAhjSK6kOUhhFFrju5rBNwH7sZpoHRzbpoU7hwDhjSDn?=
 =?iso-8859-1?Q?fQ9+EGhw/OO2Uo+YKIhU5+RGKlUCYR6/3ft+BsQNVkRbXozP5yFIIB7lpZ?=
 =?iso-8859-1?Q?BlC4ZBUkHPnWqLX5fEEcS5GU7WLCIwNUCnCZZyk4ueJGMYtbAczv332zuA?=
 =?iso-8859-1?Q?pnqt7Lyj2+XrXfg5GV/DndN7cgODE+wGr7YRKSJBlQK8rKRvrtD/CXUIn6?=
 =?iso-8859-1?Q?85vP4Ygbt4PKaiATWw6faBk1GPdFoTzptTvZlFRbLmWVJO/+vZqyZhmKp3?=
 =?iso-8859-1?Q?9VDxyAulG0C389R55k+qN0/lJ6mkh6rBMk2U91URxv00TUZ7Z13IS5x0RP?=
 =?iso-8859-1?Q?86alQVDywAIrJG94I8dbVLWK/ijUeqG6ENnKNJOm3CqROv7+vPNnzqvTJO?=
 =?iso-8859-1?Q?HcWh4hrLZf5Oj+bl6EQAIOFxWvLFpKAJa7zhijYb4lV6HD1DidGmwciDPN?=
 =?iso-8859-1?Q?lnu8pew3E6+KFnL8OPKerJA0zu7A/C63CJ3xEFSRgE8R8MEAPZciLi8GI4?=
 =?iso-8859-1?Q?++Zj5OjYAO0pq88ghXYJTS62JXzSPIHuYOjAOCxCbTBVh+84s5xpEgeMPb?=
 =?iso-8859-1?Q?ptD538Jn+MwDeJaOVzcMvUxsicSqTRL6/2v2xWJ90n1mCliFbGZxm53EJ2?=
 =?iso-8859-1?Q?PnSGzCjBWYvW4ObcKrgGJlKEMSpJMR8Nf6qo89yUQORAoiF0selKwwKRt7?=
 =?iso-8859-1?Q?HSTeDqyKJT1vlGMk+uryE25AfBIum34dKJ1uoW0qIg+Gu8DGskmdlaQe7+?=
 =?iso-8859-1?Q?4yKMoGxah5N7kRrr0Dx2c06Ws=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a477f472-47bb-4d73-d4d9-08d9df1b031c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:22:15.8499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qc0+ghyqbVfzqEDJTSTQUbOZIUQdd+1Cem/vdEaISQjSDxFkk2+j1tpE2fXvEE6m0GvWqt83UQclVbM8s+OiDTpWTPymzhENKvQ68JvhBps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0235
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

within_module_core() and within_module_init() are doing the exact same
test, one on core_layout, the second on init_layout.

In preparation of increasing the complexity of that verification,
refactor it into a single function called within_module_layout().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/module.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index c9f1200b2312..33b4db8f5ca5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -565,18 +565,27 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
 bool is_module_percpu_address(unsigned long addr);
 bool is_module_text_address(unsigned long addr);
 
+static inline bool within_range(unsigned long addr, void *base, unsigned int size)
+{
+	return addr >= (unsigned long)base && addr < (unsigned long)base + size;
+}
+
+static inline bool within_module_layout(unsigned long addr,
+					const struct module_layout *layout)
+{
+	return within_range(addr, layout->base, layout->size);
+}
+
 static inline bool within_module_core(unsigned long addr,
 				      const struct module *mod)
 {
-	return (unsigned long)mod->core_layout.base <= addr &&
-	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
+	return within_module_layout(addr, &mod->core_layout);
 }
 
 static inline bool within_module_init(unsigned long addr,
 				      const struct module *mod)
 {
-	return (unsigned long)mod->init_layout.base <= addr &&
-	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
+	return within_module_layout(addr, &mod->init_layout);
 }
 
 static inline bool within_module(unsigned long addr, const struct module *mod)
-- 
2.33.1
