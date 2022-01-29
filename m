Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385B44A30DD
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiA2RCK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 29 Jan 2022 12:02:10 -0500
Received: from mail-eopbgr120075.outbound.protection.outlook.com ([40.107.12.75]:14542
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243925AbiA2RCI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jan 2022 12:02:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlIwTWhhzB0KgRw9pNUZU1mGDBOI3kfWgnz4sFQxctjd4up8MgHSDPOgkmuS6za+hM/BOfFtKJWG1sstK9kHpodwv61sPxcVwCAuecQ02qOfTm+oId0MsypLhRAmbuT0ZCl2LCg3tv3vG03HcM6NZPhN5WTqucHWBtPbMfLvimDyu2pkphlKoWp8skiiDHPzpR6HFv5l87yrLVZVpBtmFGyRJjDWUBULx4MrKiQTcfCboUq2DWLTa5joMMihuUIxTCKDitcu+FjftTFEIcS0cVWesytmFf6588bRu/ZVQKc+O0/upv+OHJqwd5dw+ZQ4uZJg+ADMaYquneh/z84ekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLPBHDvXBMkQgGlRIh1tkuwHuf0uvhx2Y4O1zkh+ryw=;
 b=IwtV3Rl0eLpc26MnYR04jDyPdju1+/1pPkmuqAGxBFo81iq94cZobyTwWTtFo6fngzdU7MAQg/t+tlUemeJJcAO4M2ki52Wcp+NzqoBPjFsA4AvrgwELwNnQ+B2FWoUZN31Qsq5IF8iTiergVsKaOWe9fJsiMZ6oxz9beYj7vW4Lc7iJ2sW52AAvTlclNL3Si/hLoi5Gl2HDeFekFFICSR6cw6rCjDaMxTQJ60cVObjTfWa9rrUj1Cv1Lq5pVBRI+vzU/Nh7p4PPf0aLfhxKdJfhGJgJOLp/jcxpqjP0wP+Nc5c6xoka54dtgR53t85Ml+qQpH+KU44A1JGkg6K1nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 17:02:05 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 17:02:05 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v3 2/6] modules: Prepare for handling several RB trees
Thread-Topic: [PATCH v3 2/6] modules: Prepare for handling several RB trees
Thread-Index: AQHYFTHxTvyQXbQLfkCX5PUzwy1VGA==
Date:   Sat, 29 Jan 2022 17:02:05 +0000
Message-ID: <4332de93cfe4eaaf756825d5f72cc7c9fae13c34.1643475473.git.christophe.leroy@csgroup.eu>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643475473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8beb2b4-6937-4366-c451-08d9e3491418
x-ms-traffictypediagnostic: PR0P264MB2584:EE_
x-microsoft-antispam-prvs: <PR0P264MB25848E466EBB815CB47DDB06ED239@PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWGKN3C4Ej/d4sZlgyU4S3Sd0Ju1XH5zpBai7ucXgvF99VmB+7Ed909QOn0KuZs/6wZPwUqV8aRbPvOhjWwSgWnIGLfvFr9Dl5KQ83sceKllHwEorLvFPUsFduUVw9PKwoDjhsWxH++hMteK8pP/767QbgQyFz/gHEx9hIDQW+hQ7AMIp1omi2Uyr0psNousiqjoviXSjQ0O2Ww4S512Qi0doFRNaBx1PQgi5RWHvy8a4h937oSiPaQ3aFHICnCqeR/swx7mQcMgBw3wz+5bOMkTo0rfW1oKyl650iXIzDA9O3bqL6wtUtUWIWeh02ID8Pih6nbKm71bsMgpfY1B+MZhAFB6L9JURozmB0j04vDvxHfofZLxARII/MeeUmN0GLjgj6oE0Bp7s18gyk+fAvQSkHC2EyVmRVJLjaVKAJkkDYRLU2IbbN1zrtpMvq5qPE7X2wpKs0w3vfxIgbsENbqYiXzv121YYe5KKIXuAR8Aac5ZE2NbRWGW3iwdlRBZZXPF3AkAX3JGVYKD0aizIss+8m8Na1Pijj24QveEPoPoitJCI16x68JCU7iLCLI+HpMId3ngZeFa58uzjvRSFRjYZFhwKQID3WGDc8AuDvF837nfIPNVaOXyIfJC8YrVckQ8kJPFRBQcHRxFYbsNbUmlw6Kupuc7dnmTZMIVD1d8kcsmJPrFC4qyeQpjqSZKChehMxwNM5ELKUsq4WxhrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(6512007)(2906002)(86362001)(6486002)(508600001)(4326008)(122000001)(38100700002)(91956017)(316002)(76116006)(26005)(64756008)(6506007)(8936002)(186003)(5660300002)(44832011)(66476007)(66556008)(71200400001)(66946007)(8676002)(66446008)(83380400001)(2616005)(36756003)(38070700005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JaN9RSDWGBfJlk/b/5Qfr7ACyycMar17QOeH+RCzl6lSu41ZgDUVo4cqHY?=
 =?iso-8859-1?Q?0JwAa92AB5P/ivhEzu/TVtA4v6fk7Nxnj3vX/0E5dXtxRzRIm2AVBNpfiY?=
 =?iso-8859-1?Q?NjTdW/usKK4hyrF2TKJq8NbpjNnNYcMu++nfNWk4bJbdzQWmmE83lY1wbC?=
 =?iso-8859-1?Q?FEjhzTMOlEW/U8q2Oh66h/O7MH9O7JNdatcoM0jlAGNBqEWgu+h/CZZzUH?=
 =?iso-8859-1?Q?yk+WeJ51FN/kQ50Q7ziidbeo2o7YyVbMs3Ao23i2MSPduSuLJD1CxR4MbQ?=
 =?iso-8859-1?Q?/5R4OKC6KiyymgqOnuhycozI95f/7TpqPL6paaXwqzzBwtl7EzCbnk3vQp?=
 =?iso-8859-1?Q?XlwN7AFd3MJr3BTqc9lQDoQwyHAtskxJNoBFm9vU4IVhw4a8gL9j7I+Ce7?=
 =?iso-8859-1?Q?vLijNCdoO24WTO6ZnlbVGBZHMwDord6zJldbesbux5FjTQlIkxxeSXz21A?=
 =?iso-8859-1?Q?FBrtDaTEKy6aaIULrpS1CQ3fKXDybxfGKZ+m1Dox5Zs3L0TMFTP7BY2EZ9?=
 =?iso-8859-1?Q?xUmotPo0hw6VKxkqnwif7VHBXuArtRt2vr8yiuPmbS4LqEKj/1NwcYkUdh?=
 =?iso-8859-1?Q?M4raa35ii38VDXc4TL4SsTwlKq0SxLl0QtG5SkROwJGzsnapxDpimDi0tK?=
 =?iso-8859-1?Q?FAkwzi0cyjTaCfjPmeLu29sXs+IQcnGt5YxWhz5NIbEusBDJ3iBN9RrThD?=
 =?iso-8859-1?Q?4EpiFB8/hpaAf12KVfkA1ikfPtXdhhc8d4oQz5zUy/yrJdPl9TqepiSMJU?=
 =?iso-8859-1?Q?XZ27hbhx1966XE3yXtbj5sEKeL5IDwxqwx0q5uM9tGP5F9t6Uwsat907hV?=
 =?iso-8859-1?Q?yg4IZJ6etr3rpGXuNfOnSMoI0UwvrXK5NxWTdldUWS+QXx6VER/uz07X96?=
 =?iso-8859-1?Q?nrV5mVTOWJCMvfFPaQ5tx5p9huQ2I9siKMSE7F1hg9qFHtGbWLwg9Z/pYp?=
 =?iso-8859-1?Q?5hsCdhuLEwibm+aRIcBXVzoEafyfPUozjJkYyXi8BjIhcgT8ePO8oCPVlD?=
 =?iso-8859-1?Q?sP+fELXDmUnWiS0Cx4GejLhAU5UkAssdPWybNymoueRK1q5j5tXip7vKTW?=
 =?iso-8859-1?Q?AZklJ64W2Ra9S++mQi2GNnt5qewGSI92ekMznULxSyK/O194bCkCuYsTYo?=
 =?iso-8859-1?Q?hE5ETIZ734MUH0oJdERepOA6eNtEXNwTo+D4oQkD6PtOZupPHdDs6gvV0j?=
 =?iso-8859-1?Q?OLItgbRZsRFb22Xd1uTqZ9CwTm8AkZbWw0Q664evllQE6ppq/dqanMuVK9?=
 =?iso-8859-1?Q?PZNdieAN6PD0WoiXmbt/ezEEFWyHCwaaHE7+J97QW3Bi59FM25Ow7C3IWI?=
 =?iso-8859-1?Q?003rQIGQuYRLMuDJEYrY4vv0hWLCJWlQtPEK/se0XJJMnxm+//8oWwjpcj?=
 =?iso-8859-1?Q?id5Is5o9DHPUYLC6SUyL51faUPb1gEAvQFnfEYLdJvMb/R1x8xx6Nj215I?=
 =?iso-8859-1?Q?3XPyy8kB7valDGzVxWgoHcCE0Kq8AnpLk/mSyIIau7GBqxHhBbbfcqvrDd?=
 =?iso-8859-1?Q?BmdwtdLh+OZ2BkM89u7tvdJvv29Wh+ehVks+cdlAoSiANevuXqEYMrhM9+?=
 =?iso-8859-1?Q?7RhnyGv/vB12/OUOwT2bPTt41fht+gULDHmvNNObU/+J7z8noTSFjpP4iM?=
 =?iso-8859-1?Q?k5M0K3CAMGQPtZwucMJAIYIRCJ5OyJmNrYjVXSVgIOyNoD/V/lEXGPAEKN?=
 =?iso-8859-1?Q?J/OZMwBSUkY8kWEoBiHmpuckwWnhTUXf1D4lIlgT80YbfQwHPrQr1+0y6q?=
 =?iso-8859-1?Q?sJvVtaMGkfCIWNIJ9UdpCl42s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8beb2b4-6937-4366-c451-08d9e3491418
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 17:02:05.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdH7KpXpLR/SPVoBEu5F8ZKXySA9jFWD/oO3FnfyWuPiW9sB0K30qo4RJusuH7jHu9KByUnzLuzMMX7KzbnmhWKLV4Ggy0gEW6HrN7Q2g+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to separate text and data, we need to setup
two rb trees.

Modify functions to give the tree as a parameter.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 080193e15d24..163e32e39064 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -162,14 +162,14 @@ static const struct latch_tree_ops mod_tree_ops = {
 	.comp = mod_tree_comp,
 };
 
-static noinline void __mod_tree_insert(struct mod_tree_node *node)
+static noinline void __mod_tree_insert(struct mod_tree_node *node, struct mod_tree_root *tree)
 {
-	latch_tree_insert(&node->node, &mod_tree.root, &mod_tree_ops);
+	latch_tree_insert(&node->node, &tree->root, &mod_tree_ops);
 }
 
-static void __mod_tree_remove(struct mod_tree_node *node)
+static void __mod_tree_remove(struct mod_tree_node *node, struct mod_tree_root *tree)
 {
-	latch_tree_erase(&node->node, &mod_tree.root, &mod_tree_ops);
+	latch_tree_erase(&node->node, &tree->root, &mod_tree_ops);
 }
 
 /*
@@ -181,28 +181,28 @@ static void mod_tree_insert(struct module *mod)
 	mod->core_layout.mtn.mod = mod;
 	mod->init_layout.mtn.mod = mod;
 
-	__mod_tree_insert(&mod->core_layout.mtn);
+	__mod_tree_insert(&mod->core_layout.mtn, &mod_tree);
 	if (mod->init_layout.size)
-		__mod_tree_insert(&mod->init_layout.mtn);
+		__mod_tree_insert(&mod->init_layout.mtn, &mod_tree);
 }
 
 static void mod_tree_remove_init(struct module *mod)
 {
 	if (mod->init_layout.size)
-		__mod_tree_remove(&mod->init_layout.mtn);
+		__mod_tree_remove(&mod->init_layout.mtn, &mod_tree);
 }
 
 static void mod_tree_remove(struct module *mod)
 {
-	__mod_tree_remove(&mod->core_layout.mtn);
+	__mod_tree_remove(&mod->core_layout.mtn, &mod_tree);
 	mod_tree_remove_init(mod);
 }
 
-static struct module *mod_find(unsigned long addr)
+static struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
 {
 	struct latch_tree_node *ltn;
 
-	ltn = latch_tree_find((void *)addr, &mod_tree.root, &mod_tree_ops);
+	ltn = latch_tree_find((void *)addr, &tree->root, &mod_tree_ops);
 	if (!ltn)
 		return NULL;
 
@@ -215,7 +215,7 @@ static void mod_tree_insert(struct module *mod) { }
 static void mod_tree_remove_init(struct module *mod) { }
 static void mod_tree_remove(struct module *mod) { }
 
-static struct module *mod_find(unsigned long addr)
+static struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
 {
 	struct module *mod;
 
@@ -234,22 +234,22 @@ static struct module *mod_find(unsigned long addr)
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
  */
-static void __mod_update_bounds(void *base, unsigned int size)
+static void __mod_update_bounds(void *base, unsigned int size, struct mod_tree_root *tree)
 {
 	unsigned long min = (unsigned long)base;
 	unsigned long max = min + size;
 
-	if (min < module_addr_min)
-		module_addr_min = min;
-	if (max > module_addr_max)
-		module_addr_max = max;
+	if (min < tree->addr_min)
+		tree->addr_min = min;
+	if (max > tree->addr_max)
+		tree->addr_max = max;
 }
 
 static void mod_update_bounds(struct module *mod)
 {
-	__mod_update_bounds(mod->core_layout.base, mod->core_layout.size);
+	__mod_update_bounds(mod->core_layout.base, mod->core_layout.size, &mod_tree);
 	if (mod->init_layout.size)
-		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
+		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size, &mod_tree);
 }
 
 #ifdef CONFIG_KGDB_KDB
@@ -4742,7 +4742,7 @@ struct module *__module_address(unsigned long addr)
 
 	module_assert_mutex_or_preempt();
 
-	mod = mod_find(addr);
+	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
 		if (mod->state == MODULE_STATE_UNFORMED)
-- 
2.33.1
