Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7B149E0D2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbiA0L2F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 27 Jan 2022 06:28:05 -0500
Received: from mail-eopbgr90073.outbound.protection.outlook.com ([40.107.9.73]:28482
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240285AbiA0L2E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:28:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+cOta/AdEQmjDLtQcmgwPHdwJDZGSvwYLM7mhfahM3mT/logBpquoFR6YcYj55NnwXDfrriK18oHOn74f2YnHmdMo/Ba+ymT/WpfOZkgWA4tyrehu8UwX+jlWuaDltA7rANpJOBoNY/Uz9KquJ4ta+PDXxWZOrhJBMBNnq2QXOCKqTb1etuJotcEu1MvNf5yseNUAR4TO5wYE0de08tPSuijV5temlb04fro+AcWXaOFpIeS94ftoOvXxpqCZNOYgSbgOS7nWzBF/LubJt4KjEMptKoxJpyg0jvKVK+lJwp1H+fmnOQrocynA1mEMr2uenzxcmbSpCUU/pYIoP4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9nOWJ2p8JO3cNb1x0dPdEgMBG0k4rQWeltrEXRW9PE=;
 b=Z+6IxgiJbyodTC39snyEaflMr9NfQ71xnNRjF94eg6fQ3WKRAI6XLyfnvbWf5XHmK5yXR45yHWlHPEbcP3kAbFtriLgcGMdUMioT0CgjrWrRJbn5PkFaS6EsJcecdkYpfLFFvXxmHQMU/mkSzeAveeC/lRDObjBtoL3ozstEofF1FrOjxysDkGB8YoZfcv3JiiSKfk0hJg5bbNmVenAJbXI5LOBNAtTCbaPzRlHmigRhOvFkgtZG+5P+bMottzHvspCewLlDgcvLy9PDBwRSXlXCo2tvsDf6mxcyjtYkka4wlNrVRW8k5W+8nYO3xW4VrTAe1gD9PJ7FLOyglY/KMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:28:02 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:28:02 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v2 2/5] modules: Prepare for handling several RB trees
Thread-Topic: [PATCH v2 2/5] modules: Prepare for handling several RB trees
Thread-Index: AQHYE3DyBqcLvucNM06Xc/qiNZ0+aw==
Date:   Thu, 27 Jan 2022 11:28:02 +0000
Message-ID: <62ba4349b97f2e52be2bdcad4474e244ca2a83d6.1643282353.git.christophe.leroy@csgroup.eu>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643282353.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 803532f9-02c7-4bfd-6a46-08d9e1881484
x-ms-traffictypediagnostic: MRZP264MB3227:EE_
x-microsoft-antispam-prvs: <MRZP264MB32270FB0F91A0B2B1E925C19ED219@MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLtHWkobq758/HvDnrom7w9fCAgIEMeXED7g5WKFF3kCxGZaOoSQHoT5zhqx6XfS7vLbh1U+d1SqQioUH+UWvJF6eOgzBj1kSvyVDc5dN4hH9CgtUbbZjtKUnJ/Kddd1kl+maRGyST/XzEtUqJsD62lj4JCvm1WArOwO7iyTRlhPSQ5MhSGqsBnKVSwm/fXeDZgRCJ3JDlGEJpE7WZiZujLJ42s2Jf20vxx5aiOb9FN7R3VQlNs4x1kbWynWhhAWTsxdXefwbZycPLYwZZ0Y2k04jHnv3ZLt+fBCo2qJ5gdjfBEtdFC2x+IQNq56vM4mS7gZvEiPE7DlKH+IJrP13gH4riCOSio66p7BLgdc/sriKTthV2onsvrv0DUjxhyphUxyoJxNleh/830WLEFN8klTntlE4lAGrYWDSvQJuGSLck0FqeR7ir7EXBz72fnr/7q+V9DN5cyRH71dDhD9VRodquIfcJQ3kt4uTyw97KLNKJd/rP8Y7wBm6HfSG52hr0LiBuMxvVHMjAXjjaLEoibTUtk3EHlhHppAd1/7d7+y0u4Px3TWZg5mBp5ubFXJHgBCFBlPqORcXDuHKDXvExeY7glqB+iXURviHlTf8WOcwojQDpWftw//5/f3nL6EfPoSNAqgQSu0WI1V9BXXCa5Ay21Pw+CTHQaP+UzODOTAtRVl/k14GINBI2wsp1b1m3iCAB82y6tIY2xa+Zor8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(66946007)(6506007)(6512007)(76116006)(508600001)(66476007)(5660300002)(66446008)(66556008)(91956017)(44832011)(4326008)(64756008)(8936002)(8676002)(2616005)(36756003)(6486002)(71200400001)(38070700005)(2906002)(83380400001)(122000001)(26005)(186003)(38100700002)(110136005)(54906003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xPkmDEGvJRVxpEipNxx2YOsJQAmit3g2pApBpmhnMIw3lxAdcLF9KxEd9r?=
 =?iso-8859-1?Q?gGTFIfvVhdmdWtSTmjBbUjxyX5ZEjnLhP/O7NqyNO6Tlcoe3bEQ5Pv53M1?=
 =?iso-8859-1?Q?+E+ia93ka5/bzPLJnc/opFf0LKpVySDB9Bk1n2I45GB3legBjMwR7f6vhU?=
 =?iso-8859-1?Q?buRdTaiXX/cWLlq0oYm/VjpqeJ/Xs6S4qHt9afw6dg4vJZda1z2Yt5jMbI?=
 =?iso-8859-1?Q?3q9piYd1aqskCXG9nPhmgKiWb7szW+zBWj+yVD1IVRc6m9KvM57Bf3prIT?=
 =?iso-8859-1?Q?O+wToayh1WkppM+P/OEnfa2pyJPHx4I1XT+xHAyhFAKRpsu+QGCRMh23k5?=
 =?iso-8859-1?Q?3rJfwCfBccyeHqFcgbt32fp0WsfKit7QGUKY4q9MZws9ugeh7og6GHt2OY?=
 =?iso-8859-1?Q?7jPdNeicUJ+l6IuzogF9UqfG41TjhmxsIxzFQLzMAqo4KXh6eAeIWarNK0?=
 =?iso-8859-1?Q?xEh/g1uDjyQK7hKE91bhspc//QwxEWPzZ33syG++fT1flobJChaAXmBMN9?=
 =?iso-8859-1?Q?9kj3qkwSgn5oMSRyEkjVS7LkoDmxTQsPozb5cFNpyG82S/dJXbY4x4M39m?=
 =?iso-8859-1?Q?/ulkR2n1TxNlCW2bGtNlkJhXDdNANHv1xp9fyeY6v6N3kfWuPgv72azFN5?=
 =?iso-8859-1?Q?e1kljUAa9B4w6GnyPjxHc3QHbPIM5/QED3J0wBEI4RsERBo2wrlRqIVJhy?=
 =?iso-8859-1?Q?5KReukA89GnEA9NUoebbjXNYk3Vd5mxFINEgDJnaI14Xq4iG/P6aLEY0hK?=
 =?iso-8859-1?Q?fMh+3F6SE+nb7whRPiF7V7tCTH7TLcAAqg1eT/cCulHUcros8Dy+Zq2960?=
 =?iso-8859-1?Q?58DQwzipFlFv0bdxGMJ1X8VYFjiFpuvxNGKWOjtgygkoXOKuMcHRoyIEuR?=
 =?iso-8859-1?Q?CxJk8W+Z6fw5GdSLKTcGzkpX7nfxfb3+87I5Sb958F+jb/Y+Z1XVxWkKZ5?=
 =?iso-8859-1?Q?5enPRJdn5l7aR71DqbAybTY9iiQg4uVwOEyRvGMwPmNRJ7hoZMSermdzmP?=
 =?iso-8859-1?Q?HGy3qHsbD1ya356JolmWT34kM2eqUkS4W1HxbgqToYxHmBrjDHvZwLG/gn?=
 =?iso-8859-1?Q?+QlVMOAWIMXZe04qvF1vhmBSJ7qC6PqYrsB9odyWkZzmGJ6tBWhb93Dn3l?=
 =?iso-8859-1?Q?wXO2YhfDEuArfkiKGL1K7HnRP86082t80JHbyOL5dcTHbL0t1euYi5cthN?=
 =?iso-8859-1?Q?gA9xWkww/TqBf4Wzy6Xpyr+RfYRF8VZ/edrOdGuipWf2RDSNKb83iCIaPU?=
 =?iso-8859-1?Q?S8IwPHOXccIlLg/Ft1hke6sgkR5n3HjBb2xi7+oKgc/ahsaOPhL3Lf65Sy?=
 =?iso-8859-1?Q?WoBcNJhH4SPw8q3GTc6RD2N1unreqJmrnoFK4ZjDtqcDsFE8Eab4JcEGKk?=
 =?iso-8859-1?Q?lejIHOGnZJjH1NuGZuuxOk2K1LbIa3g2Pn6gIHYr191uiTBpC6kKy4ARfx?=
 =?iso-8859-1?Q?Fla3nqWMhlxv885geM4SZRpVRT3zTzS15Dmv3ULrpJGADRLhsnaEKpB47H?=
 =?iso-8859-1?Q?pb7Xkf1BIKinvx0xvdN6qbSqhHO+aohi869wdSrbCaRG0BV5csY85NM5Dr?=
 =?iso-8859-1?Q?19tcyYrUX55KEH6fGy5Cz9EiAvKf2NJfu5HLwQ0dTLd8i4n9/0MaRlAyPv?=
 =?iso-8859-1?Q?X1d2LVwo8PKCGwGAHHo+LP6HQbUNcUXxO82bk4eVQ0qzloaJDnCqB84mqm?=
 =?iso-8859-1?Q?DgVO9Fx9P7JGdik6erK4cihqXVtipLDz/fDLpsgq/Roh5Krjjj74BHY9O6?=
 =?iso-8859-1?Q?13zKJq8GicLe+7O4ptHsUpX70=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 803532f9-02c7-4bfd-6a46-08d9e1881484
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:28:02.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dp7W8NYyMpbN4tQ10HNYOgKv9wArmy7G6QN1lGuU7MxDVO0uOhQMI8C1NL7qUSqaDcJK3uvOHqokfIrH4hSdbYaNg6h+5OS2LT/pqnX2Cqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3227
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to separate text and data, we need to setup
two rb trees. So modify functions to give the tree
as a parameter.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index c0f9d63d3f05..2b9a3d9d3c0d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -159,14 +159,14 @@ static const struct latch_tree_ops mod_tree_ops = {
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
@@ -178,28 +178,28 @@ static void mod_tree_insert(struct module *mod)
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
 
@@ -212,7 +212,7 @@ static void mod_tree_insert(struct module *mod) { }
 static void mod_tree_remove_init(struct module *mod) { }
 static void mod_tree_remove(struct module *mod) { }
 
-static struct module *mod_find(unsigned long addr)
+static struct module *mod_find(unsigned long addr, struct mod_tree_root *tree)
 {
 	struct module *mod;
 
@@ -231,22 +231,22 @@ static struct module *mod_find(unsigned long addr)
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
  */
-static void __mod_update_bounds(void *base, unsigned int size)
+static void __mod_update_bounds(void *base, unsigned int size, struct mod_tree_root *tree)
 {
 	unsigned long min = (unsigned long)base;
 	unsigned long max = min + size;
 
-	if (min < mod_tree.addr_min)
-		mod_tree.addr_min = min;
-	if (max > mod_tree.addr_max)
-		mod_tree.addr_max = max;
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
@@ -4739,7 +4739,7 @@ struct module *__module_address(unsigned long addr)
 
 	module_assert_mutex_or_preempt();
 
-	mod = mod_find(addr);
+	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
 		if (mod->state == MODULE_STATE_UNFORMED)
-- 
2.33.1
