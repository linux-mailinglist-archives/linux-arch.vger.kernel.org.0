Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF44A30E0
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352886AbiA2RCN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Sat, 29 Jan 2022 12:02:13 -0500
Received: from mail-eopbgr120075.outbound.protection.outlook.com ([40.107.12.75]:14542
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235519AbiA2RCJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jan 2022 12:02:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwj5rChqPGMlOGFbzFLQkN4dUem+WT/uqY4ya483X9lX4TnF3fJkVSsW1ruP04/OiA3gTt2p/F2TTXARUb3hYHQBdo/Ni41zvoUgbE1Gr/Vx/z+M/KFHWF6XZ3H9rKVDzy33dvUAXotdJPDpxkqKJ+pr3IXjAoU3bn3eNrKS+zcbmIjGzIJtvLiTM5xt9zOSjQe4Dmba6/GTCs/nRsoIhY8TtfhPfNpBNUXIIjSBkFLZfvoVHPaP0OWxkRK0vP+3ym+UgBuj+aQ3Mb1Z5v4rHvbffMEjBoBuE6nFqS5HM3wVmz1+CQxK8VZ3HTy8PAxc+uRazC+mMjeX70YTflilpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTNNVKGZrQ6aWs2Xbf+ccCMIkXy5woQGxkZ8cpu0eKk=;
 b=bElG2vwO9Gaeq/ViM3jPkXuK20heQptN/DYH+s1rD2bUsjog2P9aku6fFW2JlZW0NMf0bPWdIEuXVuZoKWMtpWj3GNW6rZDlJlJkcvr0BF0EDT7ndqxuQIUosa7pz3Xu3kSpp8WNnBmIntAWiI3lP2h+gYnrbiLPieTrRKC9CZFSgO7l3+hCNeI9vcwl4CthFJPMi3LWVj+yRV6C4ePCd3lu4zIjO8yfl8XSXLRVTHgyMlkFW5RHYmU9Vvjrgp1PUEqoUuEpiQjoafPmg/E0+/FCwBJ1wD4NuCOyHk7jWKmTss5UNV+hFELBzoEE41kz+6eLiT7gunbSpJUHXeYNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Sat, 29 Jan
 2022 17:02:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 17:02:07 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH v3 3/6] modules: Introduce data_layout
Thread-Topic: [PATCH v3 3/6] modules: Introduce data_layout
Thread-Index: AQHYFTHy2PWsHrGmbE6uWGTz7rHarg==
Date:   Sat, 29 Jan 2022 17:02:07 +0000
Message-ID: <230bfd896f24ca7a9281783aaa8c0ebfebd0bc7e.1643475473.git.christophe.leroy@csgroup.eu>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643475473.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9907be1-0d72-41fd-9cb9-08d9e3491553
x-ms-traffictypediagnostic: PR0P264MB2584:EE_
x-microsoft-antispam-prvs: <PR0P264MB2584BF801B0D45DFCFC2EC7DED239@PR0P264MB2584.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iq97BXGY3xTjE2pQr3Bv/DGSnbK/EvvQDwaXF0hz/28ju31ugMDHkrG6Zqzu7jhP4oxiPfW8MhyLjNSUSMEM0rBNtS/OYH2ftymealO8rpDR4vv1L4+GaOVcSJfsp1BqpnPi5Qa9yItlfF5qwcfFAqYmeWgvUhk9LHap4sqEzM0DPVrC7bkUSHTvQI7eWxRb2sNTkUut+qjYn03Qqnv3I6IO+Pnr+gpyT7sqwBUdXipbYb6ut5UhH+odk3+liUYAuln66zFfWe/Jxe0HUGmIbCT1ks88TDOcSRMd4Lt3eiQPzwqHwIqUW+7Em8Q/m9UvkitqXm2CyN676dUvQzEEhBwQk0XlDqQEXNo0Hw9c6BXsAr+fii37mGqqqpCXgVk5TYntXE7SgqHMA3+otLXdEMTiA5WAWdVycB6dTDCJRG9nN6vw71ObRjMumTnMcvaktIjN8yxCQbcE1MG4ZKUp+31Ga5LsE8a1eKH9XX6X1okamO3Ko8vWP/M48ZS0FYVB6Cwq27xk5uB2nSC+Ued7Owro8MdAxFiNkj7WE21Sj+lMVB+V74Hja55QlqFriy/o/xDpTVu+PDw4vDeNyuGPoIyMK1XcnM65vXHxRz4++xXqd4WzxmGrYD5hflfCflnudzCB7IUJ1hkmxbU+7lsqnOEDba9kJujxfFCL99wfvZZ7CGqvSnRQRebF1ltUntHXoIFqsUc1dxVRWSl2Fe/Kbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(110136005)(6512007)(2906002)(86362001)(6486002)(508600001)(4326008)(122000001)(38100700002)(91956017)(316002)(76116006)(26005)(64756008)(6506007)(8936002)(186003)(5660300002)(44832011)(66476007)(66556008)(71200400001)(66946007)(8676002)(66446008)(83380400001)(2616005)(36756003)(38070700005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0v+yEAVCI16SgamjFHO0Z3sbSWvruoIdxXXeoJfEMOWDUVyNlqiiVCXGGr?=
 =?iso-8859-1?Q?zqXlMOkB8VgOGc0vuh51kbPLbI9MhsSP0RI1e1v+yFb09oFn9FQHkZk61f?=
 =?iso-8859-1?Q?wzvM6LlaprgffxUqza9wYlOz5YTvwvy60ZI2ZgqQQXeYbmqu5WynrXq0l8?=
 =?iso-8859-1?Q?XukqaMzxhx8rtaZpDKLdVmW1b6POgsfZFWbyaTO12IYoTQZfTw/yiw0I0X?=
 =?iso-8859-1?Q?WGB8/Z0zxEj92lDGNvIfAsS5cyWfKaUrMyBP+LBUMkImkln9XCcqqqehxH?=
 =?iso-8859-1?Q?UdtYVVkch8EzrTPqd5PmmJLEQm6cnFvV8NW1biP6gBZ72oPQYdAGN4LSbY?=
 =?iso-8859-1?Q?B6YLNdyxb6XLmm8bZLFJXnCN/p/FbVtfHM+cF4wsUlL5NG3dANQgQ3QnH3?=
 =?iso-8859-1?Q?IkULgyyhOPhT2wbaPe5lSrpWBUZSBl7m82YSAmQAxajosroc+jUmgz6E4r?=
 =?iso-8859-1?Q?nhI6NZ9cRRN/+qvxx/KzxTsItrL1ZCA5fTsBjLNKwVNu0o2JCB54pCiW7E?=
 =?iso-8859-1?Q?2NA+pKSLEt+ns5H/iBLpDifmMdyYeXT+BH46YxZezt8rq/G1S1MiPv892R?=
 =?iso-8859-1?Q?51nw5NJH/NMUotFQsZeD5wZfTzzaOM/FZU6KlGT+JrmpnP9E4wIeo60H4t?=
 =?iso-8859-1?Q?QDZztrlIPnB5sGSZZNQB7yBERhKH1wC3gWuKEoNUXqN2VtOILBwQ3pKp7w?=
 =?iso-8859-1?Q?0qY+ACAQyq5a0xxTZvMzBB+N5Lb8+ZGCfkW3772TCEgFQ4sqh6UQl+Rdw/?=
 =?iso-8859-1?Q?5yNfCKG1sbctk6n2xyRVwTzxOqyx51CrHo32Aw1yG836OnDuPWP7+Yoee7?=
 =?iso-8859-1?Q?ODrWqudaCIHPkFQfpQVxDaygsVs9NGhQwKBeis0i8oD1iQjdwcRfrnoyi6?=
 =?iso-8859-1?Q?jqXdlhxp2aUWMyGiW2JyAlEhA+QW4C2Xl1ReMDirnS0ShXf2LbvzTCCHHu?=
 =?iso-8859-1?Q?btxErS2PwOjGnq7oY8iZK8KPt3brPZ0qlUq4bM2Lz52D1GzbcYG0P2RlZr?=
 =?iso-8859-1?Q?4/YvtWyD5iDiUn9cdCS2IoEZ/IuSIqPdYS2nBVLihjFOQBJDw8eP4rIPOt?=
 =?iso-8859-1?Q?0+pxdju4GNU5rxFe/aL0F2MmdYMYvZ090TdbwTqmEMNYM/FZG1CwwL8B56?=
 =?iso-8859-1?Q?tYAkjlYI3HxHYYNt31Hbb91SbIuPhxZ381cD5ySzlZMM1L+m2IQPwvn1MU?=
 =?iso-8859-1?Q?z0JKr7x4HoAf7SEWRkJVWpU05C/0xqf1sd8tiakf5G3UufzUjs/gEIoxGN?=
 =?iso-8859-1?Q?7s6F+J+RazPPJnWCcK72fFzuc9POU+c/SzPDBtcDjac+AjnYaTFTYPCzMA?=
 =?iso-8859-1?Q?witzE8AXHK3+kTPF0el+14O8YIju1YEB9d3MPGeI+9dhBPEaEpuAFLZV/R?=
 =?iso-8859-1?Q?GRwLNqfiAFWdRa9N14T8kSyrhiXv8saJwTv1YAuy/FWXAnCYI0fSB6Icyz?=
 =?iso-8859-1?Q?STBgOvCdiPpXvq+7xCaal67J6RZ3Vw3D306c1L49dshqG9cbcm+bZqaRwj?=
 =?iso-8859-1?Q?GccwOfAgWj31hVEnxi2wGVqIOPV9jqopKCQRwI68DUclJs+GEz29MdlCQE?=
 =?iso-8859-1?Q?tuWey+1//7jG6NhpF+JT9gTRKomymW0344FN6fKJB2J7X38saYUOpTJSnU?=
 =?iso-8859-1?Q?aXWJe60+d6M5rmUBxI/FUQDTiBAKArkh14CN6Na/4iNKR8fO+zB0qta4ul?=
 =?iso-8859-1?Q?npC9IHh7oNtumVvf8SEpVGB6CVcGPS5Gkch0hYpFSTcovPizmbBb2p6u5h?=
 =?iso-8859-1?Q?VSFSaUIOEqCkTn6d1JnzmrQCI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9907be1-0d72-41fd-9cb9-08d9e3491553
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 17:02:07.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyP7tzVeMg8dYNazcxzKki42tPitgbR/rJB6c4nNvHriB4MJ7VrMUIU8YMwX0aU+X8RzfSW5eodI+mWlmnNssZc4F+6pO+gjZihvr6mVRyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2584
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
index 163e32e39064..11f51e17fb9f 100644
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
@@ -2014,19 +2016,20 @@ static void module_enable_ro(const struct module *mod, bool after_init)
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
@@ -2204,7 +2207,7 @@ static void free_module(struct module *mod)
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -2451,7 +2454,10 @@ static void layout_sections(struct module *mod, struct load_info *info)
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
@@ -2460,15 +2466,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
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
@@ -2721,12 +2727,12 @@ static void layout_symtab(struct module *mod, struct load_info *info)
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
@@ -2770,9 +2776,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
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
@@ -3468,6 +3474,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->init_layout.base
 				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+		else if (!(shdr->sh_flags & SHF_EXECINSTR))
+			dest = mod->data_layout.base + shdr->sh_entsize;
 		else
 			dest = mod->core_layout.base + shdr->sh_entsize;
 
@@ -4173,7 +4181,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
-- 
2.33.1
