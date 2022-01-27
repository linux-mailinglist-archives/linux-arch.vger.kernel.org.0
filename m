Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A249E0D0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiA0L2A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 27 Jan 2022 06:28:00 -0500
Received: from mail-eopbgr90044.outbound.protection.outlook.com ([40.107.9.44]:6865
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240246AbiA0L2A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOLkGziZeuma7k5n2HPX0dwtoqgwH2MSdy0OWv4OKEhbK0O/jveUSXb5B9MKxdh6QhTdrVSC5o7lpv/ASQA6+x2Dwu9KYYRltYlTFxy8zaXSWkntPn0Yg1qjYSPI12bzThJ1FGtVt2s0XwRaM5JKdtzf0Rq1kLMktQbWTsd5NZMrWsew8WKWYjJ4RwEHw3Rs85TMu9pMt0+KG/dVBbbKPIEnjitCj/nboXr5IJ/U8JfzH5k29eNbZeuhey6vPNejdmbzxdKXFWhwA0Ldmc0p+S34c6ZyKVMxAOSPzCbLica7ghAt3eNyZ4xtMD9f3q8viMgWKdO4QCio9f0Ks6mHlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuoAcwdro5/8HcduMJqG9w864tNel6knvYxF7+65CzM=;
 b=B4S6oHFymRTSap4c/p08QLB/kmiC2qoQUP+MsEyPob9NXQYn5iNm1PN4/mYdrn6cnt/nVpphaDer2YAa1bGniaX29QrRE3UON9oKuzOemAh/pvepEq/03iVTTuvxkRFEFNnRq2MjmHJ9BZfjZhYg0m2rU42IZuhIwEjY98wo4f3DGVBKRkhuwvp3mGFMwF6ADNSI7MrYwwe8f9L1NfbcYH6N2oA1Eg0rYQwc9hqGlwx9VOUihPTUAoBrHgb/Phs15XdupGRBeWPvymVrlOzWcTbNcyfSth8Z9/dxXoujLUKEF35eWuY0lIB6uoXR3YJBenAchhuoPRPsDgJ6ZxmePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:27:57 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:27:57 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v2 1/5] modules: Always have struct mod_tree_root
Thread-Topic: [PATCH v2 1/5] modules: Always have struct mod_tree_root
Thread-Index: AQHYE3Dv9+i+4LBYlku5GPEgOH7pTg==
Date:   Thu, 27 Jan 2022 11:27:57 +0000
Message-ID: <51394dd54e861e723645940a191f7d54dcd2abbb.1643282353.git.christophe.leroy@csgroup.eu>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643282353.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d088cbc0-7156-40db-0676-08d9e18811af
x-ms-traffictypediagnostic: MRZP264MB3227:EE_
x-microsoft-antispam-prvs: <MRZP264MB32273599A979C5EAAB92232AED219@MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9oN2bWKFpRPJcdSztL4I/tyhDmdejaQolh/DY+yqv8gFnUYDQX8QjHrg3KZTJMC3tKDbMUX66oCzi2NPaFKsLaxUkqd8vHfXwg9zwZv6olQ1QBagnwiGzQEY8bF6y5kWtqRF1lCDND8K2NeLAZ797uoDihzQdipngTO1iNjhzZ01eZ+ymWdh2VLk4H8ZHok0EnMyPZPxRW87ZXXAjHG28OFE194Q71kW/5PMf+kaM9YnrrfCF9Zrd918fWz0rNLOZAxFrBSlmSlHWA8DuMTm5sskY5uqQgZGl6uML/RWY7BqifZHYyNcMZoyMQTafveglnVwxpaFbhC08cUnfTQS/gn8ZIR6+3CJG51N7eyhuCM2LNqUecJ0JZ5lb3T3TuZ0LLS8NRAG8wp8Ikr0J9xZiU8JM2V8gX2eGSGTFOev464ImLcd52eW73B32fKTLLm0GOe57AIGlCtzJThBRey8dyDtMiou5TTyKBwpkpTLMOo9M8SlHbY8XowIfK12gNsugX3YxG9QPTfvH4WgLnOOSM1k/bQkAUy5Wu6XXRHmZh0KOoO2kYPla7tp9h4CO2kRy0pnP7GedhrzHdTYpsp4bZyLR5szUB2Jp8zN047Y4nYSVrZhVVbp0FE1aSrqVSFNICd0/0fiv5YAPSLqb7Ku+rSdwxkXkUuOozR3M3hQPvgSzOp/HRmzz+jpEGmgZvuh87pPX2GTDCRe8MYhNZUAzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(66946007)(6506007)(6512007)(76116006)(508600001)(66476007)(5660300002)(66446008)(66556008)(91956017)(44832011)(4326008)(64756008)(8936002)(8676002)(2616005)(36756003)(6486002)(71200400001)(38070700005)(2906002)(83380400001)(122000001)(26005)(186003)(38100700002)(110136005)(54906003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fD56qYGhwLuaiLUTlHZzZQhMz+1+d9d9ZJL/rVM2oGeUVSI4QGjlmWRQC1?=
 =?iso-8859-1?Q?Lpv2Ct0iVAAaQT5+gBaSRjQQYbpquv2DdtOWIJgx9dSq2zgzh/zN8k032L?=
 =?iso-8859-1?Q?p1BbunStz9eHzZ8o7V0mnNWErTUh9W2x2hKBh/m8BFaOdvaDbzwpVV9Tz/?=
 =?iso-8859-1?Q?YyH3kINpeGZjXtpbDgcl+bi8cX6f/GtH3aMM339kuUCV1ofTNQ1UGtIbNh?=
 =?iso-8859-1?Q?ywStk6jskOkdrIp93FEd4aqK4Lejjrw+a9qlrSl2WY6PYpC8y/5VU03v0i?=
 =?iso-8859-1?Q?56aHyCeF1CS4lZb+0fodhRTy9JTsEd1YNdkY+9J5zNxTOt0j4LHZnJRa/A?=
 =?iso-8859-1?Q?VBUdRnUrxwp6H+ww83GpLiskZILL7dIPcxp3sfm0w382ubTgP8vobu4vvm?=
 =?iso-8859-1?Q?plbmaeTzlGOBjH8w5GxEVLB8YvNK/uveQf7Mb+gizUKLm42bRv4QAGP702?=
 =?iso-8859-1?Q?ufE2cOlDwPct6vP0v5bP3LtKcJW4YT+DextjTh6yY8dPcW9NW2UqRUExvK?=
 =?iso-8859-1?Q?ivlx415GV9O6FchxYCqWJfnbNaAsqGRwp7SUUObFVAonTiD6++iaW4+pnX?=
 =?iso-8859-1?Q?qAZTVH5fKAvGLYIi3pDj+UaTZ0y7H4dCf2ZKGcv287b6y63ASXOFL0fkQl?=
 =?iso-8859-1?Q?/ZPECUtY9wihw5LHk0MDuJJtN/jWSJFpDHXVnw6D/MHBWBPUSTsl6egaYx?=
 =?iso-8859-1?Q?BB+RH8ga/qem/+s72cKvmJ0Pe1FEqQr2cBTjgmEhktyxKJJBve12OLFid3?=
 =?iso-8859-1?Q?B2JyjQQPsKr5nylmkhtSDqnSBMJOTRvvpXTIAkkLEM9xnLCELcvGC9Kw2C?=
 =?iso-8859-1?Q?5EJUohmJgzeUnc6ceOksrMqNTFcSGHyC67I+oHmGLYkvLfrGDAZhEEXafr?=
 =?iso-8859-1?Q?j+IlNaAD56x1qjyNnOVVeVBx2KfGTmC6Pwd1z409KLEA8FElBFscE0SfCv?=
 =?iso-8859-1?Q?E5QcZuUpdsb+UpRrS70//nxxvlG0ki34PnybzKK0PA8myyUSem59yLnqSn?=
 =?iso-8859-1?Q?CfXYO76lOXPArqN8nj8YZKQ1m6PJs8cNfWeC/3fAun0VCc6YnvZ/6YX+IC?=
 =?iso-8859-1?Q?694MQunl7+aC9Et0DnlbLLRKHMkSh/tkZD6/wZduiJXhkXYYZETqxukHNc?=
 =?iso-8859-1?Q?9J+bn2oGX/Z6Tr5zmGGULmxMsreaoKZ3GtPOZgBIfaVK2YvBrtVjdHKda5?=
 =?iso-8859-1?Q?cPOWKPJVQFmSPuxwuR+Am6WZnYWgjK9xRdVXtppUkFDeqDTwkV1oltky2k?=
 =?iso-8859-1?Q?f5+2M6qO2fd0y7nOJNWQwq4El1faRBVHqfxzR9RtTqyigTSaTsQ757iaBS?=
 =?iso-8859-1?Q?YJfQOKUneTgrlMJm5LFg5FkUTl6/usMivPBVJVu24TjSw08MjhbIxIgb3z?=
 =?iso-8859-1?Q?I867i5jITyVHX2BP9c1YvBbRpf5Y0TBl8T5uMtI6YSaCrzhA7v88YWw9G7?=
 =?iso-8859-1?Q?bx7+AKhWJn0F5Sp+dyg0Kh+8b0QtDYcvNPjNxfhOrP2+NiV0GLFQ5Z8RSa?=
 =?iso-8859-1?Q?d0T3GG+IWLMUBudgpY21A1pwr/l4KCU+7Wy3JepL/PdRc5em0ia9MHvi5u?=
 =?iso-8859-1?Q?rPXcgzbEgYIYn5SDmRCefadlPA9BmKINkfMFlDScgaxnf6oyLq7N1B2DAy?=
 =?iso-8859-1?Q?R+qsgj86qS9W3tyZADmpqm8Yo5tJGIsq/7QQ5t+l2kzR4qHsHBJDAOt6fs?=
 =?iso-8859-1?Q?UNJ7fcMsJKcucqDfTSeEHHe0z7mzKk1kty63Ob3/xjg6nJBO0lrXwJFt2t?=
 =?iso-8859-1?Q?cSocRufd2nQp+TKFBeDLSib8k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d088cbc0-7156-40db-0676-08d9e18811af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:27:57.7808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oB6sgKYi0SLQFVvkfSRcCOz9/fIaeVLrwxbjUn/5iUU7PC9je9Z1y0ClLkhudPeEaSbj0uxCHLCcFdrUjQB6uDQqqQ7/wLVUQEBf2zJRaTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3227
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to separate text and data, we need to setup
two rb trees.

This also means that struct mod_tree_root is required even without
MODULES_TREE_LOOKUP.

Also remove module_addr_min and module_addr_max as there will
be one min and one max for each tree.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 24dab046e16c..c0f9d63d3f05 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -85,7 +85,7 @@
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
  * 2) module_use links,
- * 3) module_addr_min/module_addr_max.
+ * 3) mod_tree.addr_min/mod_tree.addr_max.
  * (delete and add uses RCU list operations).
  */
 static DEFINE_MUTEX(module_mutex);
@@ -96,6 +96,16 @@ static void do_free_init(struct work_struct *w);
 static DECLARE_WORK(init_free_wq, do_free_init);
 static LLIST_HEAD(init_free_list);
 
+static struct mod_tree_root {
+#ifdef CONFIG_MODULES_TREE_LOOKUP
+	struct latch_tree_root root;
+#endif
+	unsigned long addr_min;
+	unsigned long addr_max;
+} mod_tree __cacheline_aligned = {
+	.addr_min = -1UL,
+};
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 
 /*
@@ -149,17 +159,6 @@ static const struct latch_tree_ops mod_tree_ops = {
 	.comp = mod_tree_comp,
 };
 
-static struct mod_tree_root {
-	struct latch_tree_root root;
-	unsigned long addr_min;
-	unsigned long addr_max;
-} mod_tree __cacheline_aligned = {
-	.addr_min = -1UL,
-};
-
-#define module_addr_min mod_tree.addr_min
-#define module_addr_max mod_tree.addr_max
-
 static noinline void __mod_tree_insert(struct mod_tree_node *node)
 {
 	latch_tree_insert(&node->node, &mod_tree.root, &mod_tree_ops);
@@ -209,8 +208,6 @@ static struct module *mod_find(unsigned long addr)
 
 #else /* MODULES_TREE_LOOKUP */
 
-static unsigned long module_addr_min = -1UL, module_addr_max = 0;
-
 static void mod_tree_insert(struct module *mod) { }
 static void mod_tree_remove_init(struct module *mod) { }
 static void mod_tree_remove(struct module *mod) { }
@@ -239,10 +236,10 @@ static void __mod_update_bounds(void *base, unsigned int size)
 	unsigned long min = (unsigned long)base;
 	unsigned long max = min + size;
 
-	if (min < module_addr_min)
-		module_addr_min = min;
-	if (max > module_addr_max)
-		module_addr_max = max;
+	if (min < mod_tree.addr_min)
+		mod_tree.addr_min = min;
+	if (max > mod_tree.addr_max)
+		mod_tree.addr_max = max;
 }
 
 static void mod_update_bounds(struct module *mod)
@@ -4546,14 +4543,14 @@ static void cfi_init(struct module *mod)
 		mod->exit = *exit;
 #endif
 
-	cfi_module_add(mod, module_addr_min);
+	cfi_module_add(mod, mod_tree.addr_min);
 #endif
 }
 
 static void cfi_cleanup(struct module *mod)
 {
 #ifdef CONFIG_CFI_CLANG
-	cfi_module_remove(mod, module_addr_min);
+	cfi_module_remove(mod, mod_tree.addr_min);
 #endif
 }
 
@@ -4737,7 +4734,7 @@ struct module *__module_address(unsigned long addr)
 {
 	struct module *mod;
 
-	if (addr < module_addr_min || addr > module_addr_max)
+	if (addr < mod_tree.addr_min || addr > mod_tree.addr_max)
 		return NULL;
 
 	module_assert_mutex_or_preempt();
-- 
2.33.1
