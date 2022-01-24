Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA6497BD0
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbiAXJWi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jan 2022 04:22:38 -0500
Received: from mail-eopbgr120058.outbound.protection.outlook.com ([40.107.12.58]:40064
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233555AbiAXJWZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 04:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSt+E/XURznZulAGhlMbiovc4yen7GRZN0F++FGe/XtZoow0OioJ9D2FrdHaftvImjCoavIwwUDHCxui2BbsbqSS5hyPglPMyaJJVAytNTStk+eZ+DpjqpkXJVeZfijNKYsSdzeGolIvJfPjy6E7sqXSwYp/BLzGGWDISq4C1OUgXZyxMyEUMUsrZS3wfspDCTDUEUQik+Kz+Hi+hMpbio8pdP7r3JrWGo8reHFSvAIJTSzjZEzqFJkb6sW/3suDNgMOYn1EeC40hPHTSnFKM3pUIgi5Z648u3iYee/v0MUjMI5L9Xzg+7H59nQQ1XMBPTcjDsVkk1o9tqOqsfOr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhTJ7QX3WkRpDwshxUt7QYbimHh3etVoyWuIW07lriA=;
 b=OCd9qBACfC9U1S7+GsND4RxyQ+S5Ck7cNGBKVJMvk2QDhqhMrXSguYsQPodaF0IxF7ObqouSxAS5UCHYiDCmjDjxZRRM7EDMjZ/ufPD8Mg4FD9FydpovcYSUrX3W2EnPG3QnHnByFVQGQi/2nOCQKvht7W1lPcwdnNfmYtWQhYLzksYQ5TZMr+cFua27Iwao0DA1ma4Gril1DL+kNsZepCeUkHpBpitheQB3WJ1eDXClSt1CS8cCG2fCJ/O48lCrYg36xjuAYzylAb15JLw7AznGDL1gU8nKkCDAj4mxp+2kaTIOOq0TeWwXNZtlPsBO3Dnxenk48eWDwVMpr3Mo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:22:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:22:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 3/7] modules: Always have struct mod_tree_root
Thread-Topic: [PATCH 3/7] modules: Always have struct mod_tree_root
Thread-Index: AQHYEQPkvRMP8VjwPkuoB6YwBo0YaA==
Date:   Mon, 24 Jan 2022 09:22:22 +0000
Message-ID: <bf5c13990066e562a48dcc5ff2d2b017aba9292b.1643015752.git.christophe.leroy@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1175ff-49d7-48cc-c83c-08d9df1b0708
x-ms-traffictypediagnostic: PR1P264MB1742:EE_
x-microsoft-antispam-prvs: <PR1P264MB174216DC644A2F755121C10DED5E9@PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIPfQT1k+ttsTMuUBVvjkFOfIdb1xK68aJ8gPAkc+MYW4J9vEiDiGHMU0SJfv5TReNI0CEbOoraJ4bBdoOSlrd7yl+hjmydTTCo6i0FfnK81HTNT7Hgkq/nbFAfxj9rtFyk27arz5PU2xLfbYRcpJ4xCG1t9laKFcYatOdflc0Dgq5qmhBO47xFBhxyPDqmAs9eaP9b4L10OZ86A8X1y9YbaTBDiw78ITmZr6X4WN7e+CRaxXjNSKDp9FrRnYqvgLXCl6KyyqGBHsCoU6eYMTfqLOp1I4kAVVaOrkRr/zIwAFUN19ODu7sLH1FAP+dLheGdMswuduLyPohDSIrda7SQ7tD33lkbagnYBmyC1i/GVb9pk/RhylJKan2+te166Ij3UX+OhcAkNoUjcv1YZSr6P+uZMQlf/NGhnxEA2/dHOjm4xkaupRpthb0vwgjkAvkl+GrVCXMAgfmIE4EbEJmXUfWH3PhjqrjluTS47r78jwbO8mEKybm0MW+h2kUjSoCBG+K86WkSZfgdcZaOfMinh10R4R7mVSdHJ3EIHh+Tovz5vzkUMRmDw7DoICL4s0YsxZ2YKgGoHqEcXLR4ZPCXKlRQtvOBxHSftFH91Pk9wSlfSGUFUcYlI4O0e3Y3Tt7nxfbV/B192TRPlbGJ4ydRLNRFLf+oFo07OB4Ee1UdqjuuDBmHMEwya/OVzeGCrLhKU9jfTQ6TxG5AftP6dCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(91956017)(316002)(6486002)(54906003)(110136005)(6512007)(508600001)(64756008)(2616005)(86362001)(8676002)(186003)(26005)(5660300002)(66446008)(83380400001)(2906002)(76116006)(38100700002)(122000001)(44832011)(71200400001)(38070700005)(6506007)(66946007)(4326008)(36756003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LRM3IeTpUDio9XbXSKJPUY8ItTeh7OlMG4uj8FBREfOkQ65KQHPlSZ4+dm?=
 =?iso-8859-1?Q?57IWshLfgGdiwY6vp7MU/EWDXNQQ5eO4/LZE26L6rEF6iQVsm1Obrhb0zl?=
 =?iso-8859-1?Q?dgpj/RXg9yNC4EDMP+GwcjmhUFcaGs2HcT9IgA0J77cxtw5iLf22eWkJUq?=
 =?iso-8859-1?Q?X+OtS1n/VLh1Je/tTFa9Oo375Ns7pud92ce0oJfwLwqA8jzvMGq64WiOtz?=
 =?iso-8859-1?Q?dlW1RbTdWVwsvIhDwumD24nq10h+5Ucy12NVpmWwiYLYUBJVNSP0NhaTN+?=
 =?iso-8859-1?Q?bZ/iWXl/ua2R3BPZQdQkvpAB6dNWBTF1ojcCMgmBMgPrPDTVIqgXy1le1E?=
 =?iso-8859-1?Q?Z+iOJwhMKzKuiNsoLbV1eX7I52eLznTzMjl3VTUXjvcSGzx9FTlpyjQR89?=
 =?iso-8859-1?Q?fGyNLVX8M1gYmq8qf8QMDasrs15oejgI1pJf0cLm0RcZSL+nPaQ89m5Wrj?=
 =?iso-8859-1?Q?1ie/zQHqRPVvKh07IrO6DMsI4LVqS9csIVkV/yo7JieBxzImWQKXywtd7o?=
 =?iso-8859-1?Q?nk1UTM9zhm2b+aSCYW6Ho8WxjK107VGF5bxqtN4flRU1fdxKJIU089J7KT?=
 =?iso-8859-1?Q?cpp9oP5B2zzqgmldfowKyFpi2GuB++fCXwcAXQz+q8zJJ1De2ooXQZcQez?=
 =?iso-8859-1?Q?iIZ65MFO+/KbvfUn+bT7b5g+b81LduaOhsZsvfTkUy0PBY/Wi5UfiQOhFi?=
 =?iso-8859-1?Q?8X5Km7jtN0yYRlepxfp/2FLo2yumUNc4RotrC+C5OgaXlA2BhkYi7QtXdu?=
 =?iso-8859-1?Q?WrqJI7nj+as39+4NzDIul0fDJ+vqFEWFisac8p44M+h5QetvevIn5cQ2It?=
 =?iso-8859-1?Q?Vml8ED8SDu7+y7JIwzdbmbkwduCoI1Rpd9ba3zrSLPBsPRZkF6Qb8veAaK?=
 =?iso-8859-1?Q?HsMXDlmwTQE3bQ24ZA54TrCs5RZeIkMi9mPBQrvFHTvYeimvSj48EV5Ves?=
 =?iso-8859-1?Q?MfIOBKxPs/Q5clFxgiOMl3cg6eCG5qLOtQWQXNfow+3l48PFzS+QDaPaty?=
 =?iso-8859-1?Q?eg70cCn2HxZq/JCJzTh4B5HmCsqWRPgTxi8a3BJiiqTRu496pwlso5N93r?=
 =?iso-8859-1?Q?aFs2/2DtJsC12IL8wyWxWFXk/1U5f+nYwAx5FeCiXjyn032cPSSFntxavP?=
 =?iso-8859-1?Q?5qcbE7+BwRum1Qd+BWr6LlMoBhQ30EpgivEe2Y4p+ZCoWVyua8o5RURC13?=
 =?iso-8859-1?Q?Ua7PjbD+JgifQ4CoE4Xt6FiS+PjyuRnujBoFhlO2uqUk8A/U2+3rLKXuq/?=
 =?iso-8859-1?Q?y1dd/qFViGbl92ynU5kgdtDRiYbyemQEsssBQnJcPttjbAyvMZXxYmJRBJ?=
 =?iso-8859-1?Q?7D2g48qYsou94RzO2tpKsDJ5yBb0zuHda2TnF4glPrlBAFNOYmuvsuszrB?=
 =?iso-8859-1?Q?BgdQ9RVhE8SGBNA+/gxT77Sj7G1lwZI5je/U3Clzkwl2HmtFj6GeY31Uy9?=
 =?iso-8859-1?Q?CrIv8NtJFXB7/dAHFXejK9f9iQeuMvaHXjTRk4EeqN4YJMzn6XpDPVHZ2P?=
 =?iso-8859-1?Q?S1qJVkQKCMsEX7ZWuIE51WK7LORXbf9gRnsahvKYwwSj7xbYgwYCTo7vcN?=
 =?iso-8859-1?Q?eb2OLrRIlUqIK+2QQKmBfvraSosd/ozWCaVmxkVmLySLXOIgQLQTC3b3iQ?=
 =?iso-8859-1?Q?PoWoBvGr2SUA41pGVBvFc+J+A2XBLtNnYUWXoJm8qwciY3UL/62mzEdQi+?=
 =?iso-8859-1?Q?q9PG1U5K4j7ipb9FUEa8wb+PZlozZjr/fXrdkWhJYMWvVZBH6Wok9c21Lr?=
 =?iso-8859-1?Q?HAVLuLax0cUchiyQmltxwtkPU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1175ff-49d7-48cc-c83c-08d9df1b0708
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:22:22.3669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jefnacka/hwUuHNJjIqB5m/kSJPzYXLhDkz8++8H8OMm9bDekn0iP1fzJeCm6jRR+Y8OAeev+RakZKFHVgwifl2eICu26El5bjpIQDLpdy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1742
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
index 201d27643c84..346bc2e7a150 100644
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
@@ -4526,14 +4523,14 @@ static void cfi_init(struct module *mod)
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
 
@@ -4717,7 +4714,7 @@ struct module *__module_address(unsigned long addr)
 {
 	struct module *mod;
 
-	if (addr < module_addr_min || addr > module_addr_max)
+	if (addr < mod_tree.addr_min || addr > mod_tree.addr_max)
 		return NULL;
 
 	module_assert_mutex_or_preempt();
-- 
2.33.1
