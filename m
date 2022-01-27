Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB1249E0D4
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiA0L2K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 27 Jan 2022 06:28:10 -0500
Received: from mail-eopbgr90041.outbound.protection.outlook.com ([40.107.9.41]:23037
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240312AbiA0L2H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqlHO7IblNmn2uA0ksQGHTuN3jNbyqSSqlQZ8TTWcp9dSD9Xqo8Q8WrY7Y5rYOFUpXudlNniIyeng30ErL6A9R0KNojjISdI9NdNlNedFh/hrjVBHKJuvpj73BjqfHFzB0Jakj5x7KCXXaN7JGoKnG+J3HchtPMqurRdK73GfMuonFqzMak+Jx4dEqK0SWIfMhyPm2Wjq6hDIKciYD8BgtDTZGBQvmyu0BpPBwWB2rHgwggRhWfbm475qJ8oS7GJ1B9YcYnbbzbs3N/xwr39vq9Tuj1ePeq+28kG7YCyeK4KnrNGqdRKhhKjRW+TLSpL4em2EL1z4m+S/E2B+NFGuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUPprGAP1KBC2ZtiRxj1EG8BE+y2WpU/+J274WLJhvU=;
 b=aRcDLbAZCSsrUHbNSEORs8fB858XiIW6jh76GrS54BOBc4+8muxUl9RbtvRDQmWMcON8Ndnzt3IT4zSRw9K7l6Ag5561bJCHDpPMbFPhNaQY7PlQP+SzI/uCVhgKUfcz5difnEtJwXKtJnbcnX81DNem9iv/Aak5ohNfB9t10IJiXi6HD4pcvb4Utxu5i0Z84Wd0aUj4e8kzHqZLMAOYM5Fx84ZXZxjNC1nI6GIyiDvAPUmrIIVMdS8q1eCH9bp7HFqzRksQI5Q2S74D0zNxEGjAi38n3F1i/YJXGiiO1fKKuclNdEwwjn3zmatxyg+r/BjSCm/gVFYvQqmHLjKBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:28:06 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:28:06 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v2 3/5] modules: Introduce data_layout
Thread-Topic: [PATCH v2 3/5] modules: Introduce data_layout
Thread-Index: AQHYE3D0IIMspQerl0CD9FPcUHWeOg==
Date:   Thu, 27 Jan 2022 11:28:06 +0000
Message-ID: <daeabd7283cf311115a3c0c36af37a8e60a00ed3.1643282353.git.christophe.leroy@csgroup.eu>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643282353.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 970c8b1e-51b0-445d-628b-08d9e18816b7
x-ms-traffictypediagnostic: MRZP264MB3227:EE_
x-microsoft-antispam-prvs: <MRZP264MB322774BC7E559FDC5779BF70ED219@MRZP264MB3227.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUk93dzYuySvNNte1V76LLdrl3JGzgEZ0qzkaoF6KGkcd9FAeHc36CTCiZscAi1p6MeRcFLDvP+vQbySNx2O/Ju3wvDu0GXs0S3+CaMKKkPYmYba1lmRhhskoEhJv7d4Ec9+OrM8KGXEA6pBQAsBFQFDWUsZwKs3T5QZXZnaS6udiwo9yKo9GB3PPxOw82FAWMRxQufnNoFmpma88A0MDxM2i64ldkdR0LtDFn7LCHmzOXzRcLY5bMmG01u3N9Dy5ndn532Ry8jz0sTC1OkYjEKkWJjuRDCrH2BwGH6p//CFC1MUBsNH6LbBxdKISWlvu4ppceUE4yUhwvYQ6vtzqy/cdilmWSFRmrVyiM2bNq5r8dQqquplN02mMofZBQgIW0Kd1Q39IJT6yezMtaD2bmsNRPX2fV7bSmIIR6vPQFb6lGpCNlA4yXVaUKqW/ADXqBGxMeWFqI7UTaAQWj2wlhRS92uGDT+eogz1o8rS9AHAIFOUehte1obckH+mKsnl8Ih1+Q8jduVyCvcTLN2LNVdLqa//Q5e7PIfEzX14ntu8Zgln2QxgvbSAybOVdthGeW7aXKafTZLKB2aGSucANswKCCArhBbqaRT1Gkmu4fc0TjaaBbrwnc4p/oYsrTBt/FMZhKgMWoL/qfWQOmxLu69Tryazpl2lcKM5bJ9IaAp/xEdmnukeUzc0WseOdS4KesJ2efRX499F+mQd3kuckA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(66946007)(6506007)(6512007)(76116006)(508600001)(66476007)(5660300002)(66446008)(66556008)(91956017)(44832011)(4326008)(64756008)(8936002)(8676002)(2616005)(36756003)(6486002)(71200400001)(38070700005)(2906002)(83380400001)(122000001)(26005)(186003)(38100700002)(110136005)(54906003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EKmANtKIYL9G/CI5FQPxp8IwlmEjnl4QS4goanl5rIfvnthy8zTiQjPEJB?=
 =?iso-8859-1?Q?48VjC0/cOmGfROpC+R6YLo+mqtcjbp/zWaBVxhsrm1a8XzWuaewU9alLcQ?=
 =?iso-8859-1?Q?PobtmeTA/30dhRVYJ07d484WFGYtkJvRzcbE2kueoMvBEKSADQpPDCbOrH?=
 =?iso-8859-1?Q?k3v3TM2P3TgLbrBCgTH+vVUpEVcSYMPsQbwDa/MV2+ntxtOd24kzAFbpLb?=
 =?iso-8859-1?Q?P9JWLrcPwYv70t7iX3mf/bxRjgEwI52uFFwjYTrgmlqJM/3kBNkqsihDpd?=
 =?iso-8859-1?Q?htoOxFZId9rNkKufq+psJTFnwN9DPp/vcy+qdoMRYgo9569LC/BMXH0FNm?=
 =?iso-8859-1?Q?Kp43jVzA7twv9Z8vxygj+ZeL7t1QwpNvfsUUjclP9nTSHJiqAdrJ8fPcVP?=
 =?iso-8859-1?Q?nQccnjhY7iC6AL2QN+351uNzLV0RlyW9vOw8j5StPIO1SM6tQA1yQTsKLD?=
 =?iso-8859-1?Q?DVxQU02QdDH3zOxj6h4M0Czuu95WwxvgM1DgHXWsxl7drgNbkgvgTNRHuy?=
 =?iso-8859-1?Q?5A5FegEPxNYK3vTfCwdggvEV6j6Mtlh/2rkRJQXutqX/JOjnRtovBMNodD?=
 =?iso-8859-1?Q?CpCH7SxmkjpC7Rj8anD1E3pgEmWj05AL9HfSIx6PAvNI9qgcpQb5xBjCBv?=
 =?iso-8859-1?Q?9RRJMWdXrfqFerFnyAAu5Tq6iYXKJFXoApb5KfccfgoDgnBT1c+9xx704M?=
 =?iso-8859-1?Q?AcEYpznH8vUZjiNmNxCI/AxAj5lCloFp3nKutz65zcyiHM4vDgPx0TBIPA?=
 =?iso-8859-1?Q?taA+Ae9R1c5ZT01jHk299gDW+JRW1Cf9mIHWijrxeqruyBTOQTS9uqIky4?=
 =?iso-8859-1?Q?N41hlm1BjKgmwUzX6ow5lqnrdZ7oWRr1BlTblFDWrOVoNkLyCr6ikMOlCT?=
 =?iso-8859-1?Q?fD6QUG5e9OGnhhWpMZSxe7uBlIcRyDsvUt3TDsd/ZYHHwyQImloN45sJAO?=
 =?iso-8859-1?Q?BOKOsyEzHeXiHoRZltLpOxKoUjgKcgSe35oYUHpLPx5cxRz2sEd/x/XoLM?=
 =?iso-8859-1?Q?uKD4dffTI3lyvxawQW9nVj6s3J4fmWhyJTupCq1+g1hOFpBncxY0aVdZaf?=
 =?iso-8859-1?Q?NKguBfqPlTG3aMKn8/l5GB7KM6xOqj5ZMZw1DAdwBEISRjsqquQuDRwcZy?=
 =?iso-8859-1?Q?TDCcL3KeG6mJsEtvmMmOzrNl5eXUfSeH0Dy3wqJ5qFQYIu5cCBGSZIw17B?=
 =?iso-8859-1?Q?ojR2OqBGFrqLb9TriE1rRuRGcRMeLDgX70QVhwxv6r1jA1GBAjTet+7eea?=
 =?iso-8859-1?Q?/grzwZmgilE4+tI5T5YKBXo/BkFHQvEYPPhwJLb9xHwNIrQY+Go7aR2OqA?=
 =?iso-8859-1?Q?lnRSh/Gz4P19wOBKtL6As32WhUNZLT/chbi9FstODUVpzezUf3O1QY7DdL?=
 =?iso-8859-1?Q?er9EK0uM/Tn3I+eOo2ccff3aM/ULlqsbJOe3+byHynkWam8npXVTWksFu7?=
 =?iso-8859-1?Q?vOcs8zyURQD7VuDCmzurSHmPq9aSMWBGw/Rg0H55Tm9X55T1t+t4a40ci3?=
 =?iso-8859-1?Q?e8cSnMDW76isYqqj3/job9/JSbk59KxRCanRKhs16MIyAAIySyITg82OQH?=
 =?iso-8859-1?Q?y/Zs6csVJ54Lpc9LbGZtRIaGA5ag2t2sSSBJhQr3ki4q3vDN2ftGp3H+E7?=
 =?iso-8859-1?Q?nQLHLiZXijq26bYGcRt+GeYCEZtaXtOnd6mxIn6QzISj8uqLCNFH7KiEY2?=
 =?iso-8859-1?Q?Es1fsTotSFZOE8NRhnQphxY7kSA7pXuDnB12aQWWJqXY76d47UcTeD+aDP?=
 =?iso-8859-1?Q?2wvzII9vLWej10znFHEqoNZC8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c8b1e-51b0-445d-628b-08d9e18816b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:28:06.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/qmunLGKyHUNVe77SEuHTd+HLHJ+UEBx7C0M5EmmGoexIbJsDJJFUL5vbLiJgT2Q9Y5U/dAryH+n+Na8jzOZvIjsL+Sf+WkaZ4YVwj/3Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3227
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to allow separation of data from text, add another layout,
called data_layout. For architectures requesting separation of text
and data, only text will go in core_layout and data will go in
data_layout.

For architectures which keep text and data together, make data_layout
an alias of core_layout, that way data_layout can be used for all
data manipulations, regardless of whether data is in core_layout or
data_layout.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module.c | 52 ++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 2b9a3d9d3c0d..2b70b997a36d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -81,6 +81,8 @@
 /* If this is set, the section belongs in the init part of the module */
 #define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))
 
+#define	data_layout core_layout
+
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -2011,19 +2013,20 @@ static void module_enable_ro(const struct module *mod, bool after_init)
 	set_vm_flush_reset_perms(mod->init_layout.base);
 	frob_text(&mod->core_layout, set_memory_ro);
 
-	frob_rodata(&mod->core_layout, set_memory_ro);
+	frob_rodata(&mod->data_layout, set_memory_ro);
+
 	frob_text(&mod->init_layout, set_memory_ro);
 	frob_rodata(&mod->init_layout, set_memory_ro);
 
 	if (after_init)
-		frob_ro_after_init(&mod->core_layout, set_memory_ro);
+		frob_ro_after_init(&mod->data_layout, set_memory_ro);
 }
 
 static void module_enable_nx(const struct module *mod)
 {
-	frob_rodata(&mod->core_layout, set_memory_nx);
-	frob_ro_after_init(&mod->core_layout, set_memory_nx);
-	frob_writable_data(&mod->core_layout, set_memory_nx);
+	frob_rodata(&mod->data_layout, set_memory_nx);
+	frob_ro_after_init(&mod->data_layout, set_memory_nx);
+	frob_writable_data(&mod->data_layout, set_memory_nx);
 	frob_rodata(&mod->init_layout, set_memory_nx);
 	frob_writable_data(&mod->init_layout, set_memory_nx);
 }
@@ -2201,7 +2204,7 @@ static void free_module(struct module *mod)
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -2448,7 +2451,10 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || module_init_layout_section(sname))
 				continue;
-			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
+			if (m)
+				s->sh_entsize = get_offset(mod, &mod->data_layout.size, s, i);
+			else
+				s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
 			pr_debug("\t%s\n", sname);
 		}
 		switch (m) {
@@ -2457,15 +2463,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			mod->core_layout.text_size = mod->core_layout.size;
 			break;
 		case 1: /* RO: text and ro-data */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_size = mod->core_layout.size;
+			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.ro_size = mod->data_layout.size;
 			break;
 		case 2: /* RO after init */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
-			mod->core_layout.ro_after_init_size = mod->core_layout.size;
+			mod->data_layout.size = debug_align(mod->data_layout.size);
+			mod->data_layout.ro_after_init_size = mod->data_layout.size;
 			break;
 		case 4: /* whole core */
-			mod->core_layout.size = debug_align(mod->core_layout.size);
+			mod->data_layout.size = debug_align(mod->data_layout.size);
 			break;
 		}
 	}
@@ -2718,12 +2724,12 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	}
 
 	/* Append room for core symbols at end of core part. */
-	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
-	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
-	mod->core_layout.size += strtab_size;
-	info->core_typeoffs = mod->core_layout.size;
-	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = debug_align(mod->core_layout.size);
+	info->symoffs = ALIGN(mod->data_layout.size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod->data_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod->data_layout.size += strtab_size;
+	info->core_typeoffs = mod->data_layout.size;
+	mod->data_layout.size += ndst * sizeof(char);
+	mod->data_layout.size = debug_align(mod->data_layout.size);
 
 	/* Put string table section at end of init part of module. */
 	strsect->sh_flags |= SHF_ALLOC;
@@ -2767,9 +2773,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	 * Now populate the cut down core kallsyms for after init
 	 * and set types up while we still have access to sections.
 	 */
-	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
-	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
-	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
+	mod->core_kallsyms.symtab = dst = mod->data_layout.base + info->symoffs;
+	mod->core_kallsyms.strtab = s = mod->data_layout.base + info->stroffs;
+	mod->core_kallsyms.typetab = mod->data_layout.base + info->core_typeoffs;
 	src = mod->kallsyms->symtab;
 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
 		mod->kallsyms->typetab[i] = elf_type(src + i, info);
@@ -3465,6 +3471,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->init_layout.base
 				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+		else if (!(shdr->sh_flags & SHF_EXECINSTR))
+			dest = mod->data_layout.base + shdr->sh_entsize;
 		else
 			dest = mod->core_layout.base + shdr->sh_entsize;
 
@@ -4170,7 +4178,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
-- 
2.33.1
