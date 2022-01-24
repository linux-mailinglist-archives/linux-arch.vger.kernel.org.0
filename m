Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64945497BD4
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiAXJXK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jan 2022 04:23:10 -0500
Received: from mail-eopbgr120058.outbound.protection.outlook.com ([40.107.12.58]:40064
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233552AbiAXJWi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 04:22:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVZ8ojzhT8ZyaUdD3eTp2OrppvIDJ43bYLykyL3sAIyFzCHKl3WTl0o3q5OU/qRv1by+7z5mIYeK6h/om5szE8Yvlhp5oUbFe6H4H1iHdXXHdwZJEwPTCIbnoaU1Lbe1mnGOVuhZkBlfvKs3VXMbCU3BUlc0TT4ZVR+g+GYan08rxiulsvBu+svWaPzRy7alrJROC2Zyj8UhCMAXE3DfUa/f/CpwhivoqP9/3VeioJiFam6H2G1S2vbplHh0OEF/zjDSJtFX8xFn/3lfEGgzKUQ6mrXWOl4vMstIo9+4YLu1PkOQIqe9qILfbry4sqgzEbD5SLrJi3B5p66PUSk8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vYHN3GX5aVxixYLF0RC1M6EWpoRCEfxGB8h8Addwkk=;
 b=RBRegFexI30dgrrX88hyFWh7Qi8jxtLMlpNC23pBeWD+6ZCy4/CfLzlIdSrR8ulpnqfI7vd6BJtHFffeglNKSq68ycd7TTj8bR8drxHQnOTW3HhBxNFdDzneyqkJRU75Eh+DFVAysNXKi4xqb8MQElAbqZkjsK3jN44kn7mPGvO7fwpK4w2/0uyDMLCci1ltfOU0/ZyuZUVFXQTyGYhadtMCdI9TpP8CW82XVyQIAehJfyNV2kNaRYdC/dYXGXtffcRp49mo6kh6H8pYTATPqgoR6kKPIn6Ch6e1rh/cqql2apsJ79CfVwtdMIMgBvlHmpv7YStRdZacAJXXTENX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:22:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:22:25 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 4/7] modules: Prepare for handling several RB trees
Thread-Topic: [PATCH 4/7] modules: Prepare for handling several RB trees
Thread-Index: AQHYEQPmKXwkfhrzcEa1kF7tzAaVuQ==
Date:   Mon, 24 Jan 2022 09:22:25 +0000
Message-ID: <f30ef8282bd5ee4136895104961dfca9bf253287.1643015752.git.christophe.leroy@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5088db47-4151-481c-fab0-08d9df1b08bf
x-ms-traffictypediagnostic: PR1P264MB1742:EE_
x-microsoft-antispam-prvs: <PR1P264MB1742972B448EE95DFAAD6C2FED5E9@PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dFhZUmIazp9Jrwd2v6gwR2tVK15LQ8eSsuEH6hVsrjy/jUwndFiBPj2Q4rzmO6ZeDA3vUXFhoTzacHD97jQ4AvgtkhU/9kyONp14IF8zT2UMixzrSsMriaJLgEPUPkMk/pZvWstUSScA/UTeDCSD+GCGWs/dZI3iQQehG5T4t8z8AagXpt8FeB4cnLsA9XYeyrj4L+B5p6j+h0T5Ib9exuong2VmZhvTDc80KtckYW0IPSWLjzyYYIaz2HL/+iOacRyLlZm0MfjSldFH/9rwQ+R52LNNTDGiuefb4GUNLuAvnWEn79Vcnp9kBmqkIO43eq+XLL9ovJVHqN75gBR2Unus7E0NnIkI6pRn2yaoL9wM5c1r6Q2CFz1/HdvSvsBBFH4ghXIXeAQtEXpGvjzevEy6ZMva3Ie0joJ76E5yu3r/hx/Y3GrEbwdO7mIo5FlXAMGyRxLQmj0xgjhFSTLjzNl/j4iZiVknLhnnDtOO8fqXc2e+Pc50VFMkF0GHpCfFi58bxZEcBErwDiNleisDyz/hpsCQj6wCKFOZiiYLk7RT0SmedMjy6cAwmDYw11B/7TgRgOtN/VxJfeqe6Xjs71cdNPylZAcotqznyozzxzJfYsni8eGoEv8TnYxzCNDeakKzk7F77qZRUZq7V0jSs72tFfTTQchoFLRyT1QVty0n5rWWRRGhedBW7uUNhWtrqo4JmX5mrCOF9hon1KLhnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(91956017)(316002)(6486002)(54906003)(110136005)(6512007)(508600001)(64756008)(2616005)(86362001)(8676002)(186003)(26005)(5660300002)(66446008)(83380400001)(2906002)(76116006)(38100700002)(122000001)(44832011)(71200400001)(38070700005)(6506007)(66946007)(4326008)(36756003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7zqyxdmFF8DLDS3ZjG5YQdRhquLnp/LdU68jo24RjQkINQz7gGiVPfsG3h?=
 =?iso-8859-1?Q?oHZXEgaucLeNYCN+NwWFl9IkQl54G/lx7gpSFtef5KxPi7EW1ClRtBAq07?=
 =?iso-8859-1?Q?hmI/TYvUvhsvXRODU6JP/V60JwngN/Y5f+4rmLEQHpMx+FPa/bjxWXoOW1?=
 =?iso-8859-1?Q?CJPVAGsnRGy+oCZlIkyDVWzLj9f/oRhXcUCiN4WIde6NWbc1n2Yz2fWJmC?=
 =?iso-8859-1?Q?Gaj+NCfSsVdwDXDxzrteGXD2pkDOkF9Tbace+aI66hXGioTQMj8vr87YS3?=
 =?iso-8859-1?Q?lJdQ2oS07zzzIMxsS+9fGbLnRJmxfTnWn5PssWrBE81rEOR47px/FykVn7?=
 =?iso-8859-1?Q?nFiOFZx+13T2GtSxfPH2/Q0wm6fdL5W8GuQGJH7ny6/9Qjhqoe9uKguXw4?=
 =?iso-8859-1?Q?/Yibm0R2KfeoF5QWVotFVJKiWt6Jb6ZMyCK1yjcbKzsvlwtOZL0lPjsitN?=
 =?iso-8859-1?Q?j/3P8kMypOj8DXbaZbjSLxiMBAxgFafyh/KiolAWsg7eIK85ybzUzc7JV3?=
 =?iso-8859-1?Q?Ce4/K6ErZQbhjXEfCSQa/gEviK3hPoAhn2P/u4BZUGvfrQtrt7MxSeSUvX?=
 =?iso-8859-1?Q?RM6TIF44DYXam3scxaQtcZgvrfbMIu/7rHjcXS0x6SUXXQ/F8gEabvbTfw?=
 =?iso-8859-1?Q?edLq35XJX5Um78a/4TWyj07gaGC4xRkjRXQ6NtCgrS0gJJLOl0c+8O3EXZ?=
 =?iso-8859-1?Q?0puaKOyTpoyDpmZVW9/g1TgPM94QAAWrjClbM0JBPwNZ4Q+kvEHqE7t3k1?=
 =?iso-8859-1?Q?yytp3MgncBo0F0J/8H+Sgh9ICNenyShJc7+NIf49KT6t8fJY5fJor4yYeT?=
 =?iso-8859-1?Q?77sdiCqQx1MDNBkrXs1nSP6ueVaQecqQe26vMJamWPjYS6iumTcsxcSHBN?=
 =?iso-8859-1?Q?YDBoOIbDB/LaPH2nLhinWEAbIDIShB0yENTM8qosDnb4xm3m/nQJR26MkC?=
 =?iso-8859-1?Q?dkORl7GJ6wSaZrFg8QVx4ZDSvISzTL9ALvfuoWBdSlq0gajYkC9ts0P5Lr?=
 =?iso-8859-1?Q?oKzQ14OIM0YyzPFvwHMbQ6o94G+HyOIL8WoapxsrVkITuzSdtT2BDXMAjn?=
 =?iso-8859-1?Q?BbWjJAZ1uxH7FW/85RvndqTwyv+xjU6nRftmoSx7j09VCygQ6yawzRus2D?=
 =?iso-8859-1?Q?kHaHK8x+loelbhE7UXNlBmbzi2Jv8tq1li+g7MuSkJ1ecDHQVqF1oZbVhT?=
 =?iso-8859-1?Q?2xyiLQgRMXiSeQ6x/Isdy5w+l0KJ/09zRAOHcEXoDHPsOshSStlxUPtEmu?=
 =?iso-8859-1?Q?0z6UYVtuijv/P0vXbEpAL4qbjvAiiKqb06TD3C3RwglHXQfTBNDRNWMRgn?=
 =?iso-8859-1?Q?OgBw058r1jvW0AdAsPIF94As7BYbPa3IwEwn6R8jU8l8CaKWYouT+XlyPJ?=
 =?iso-8859-1?Q?pBTaZqOqW5nJmati5sUDjeflK5WrSpb9WZygjaE5jyRlIhule3aMJL6o2Z?=
 =?iso-8859-1?Q?jwKVC0i7XF0b3exWNYeDboNto13NtJsv+qJv8GLlQ/sdUioDWctfIIJjgs?=
 =?iso-8859-1?Q?2dyKjaWjyaIwpCoENg+G6E2HIEr0ZZb8/hjD2035fUh6V9lkMaTvwdKHv3?=
 =?iso-8859-1?Q?kpVW8y2OoNiJGSglg+rfqexTdQ7iJiTefUmJStFcYJHQjnMSgn7llZ6WOO?=
 =?iso-8859-1?Q?6djjiuaeFnEU7tpvLVJwr5wDVYAbA2fEoDqw0izWAhkhMpha3ObankcZYr?=
 =?iso-8859-1?Q?gNltramBtz1y8bBvnHkID2enbPb79bp2NjvJcA248Ty1cIqc3s/13Qb94I?=
 =?iso-8859-1?Q?aF94N8SXRYXYHRok9u1zhUnVA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5088db47-4151-481c-fab0-08d9df1b08bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:22:25.2765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kASDSAnqtDinizX+Ln70QKZDBkZYiI1Iuw9yYRPi5EeSW1b3tN3CcCXqmVxOgyzWJsJNo8g0D6MzCyh2bfJI+jUj1b8eZH8L8rc3eOm9YRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1742
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
index 346bc2e7a150..051fecef416b 100644
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
@@ -4719,7 +4719,7 @@ struct module *__module_address(unsigned long addr)
 
 	module_assert_mutex_or_preempt();
 
-	mod = mod_find(addr);
+	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
 		if (mod->state == MODULE_STATE_UNFORMED)
-- 
2.33.1
