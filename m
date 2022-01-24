Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6AB497BD6
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 10:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiAXJXR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 24 Jan 2022 04:23:17 -0500
Received: from mail-eopbgr120058.outbound.protection.outlook.com ([40.107.12.58]:40064
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233695AbiAXJXK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 04:23:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP+3znfRf4xXXT4JXr/3CDuySIqgepl+vWeXQ2+8cUmTAjmjVk9i0vBMo+LPqz43zIq5Qhn0NSfw8OPbbgP0f4ARqL9mOyrPQEhHRvHUr5uqBlz1pPHEwa6U4X9nhmHi7nYW0kV4UfAIyqKfLPhrkW8zSpTNRhl/ZPqigBovoccdjX2yUnUYGVqigTplc177DMVo6ViSWhh4JTz7c5ZN8GZqfFCFLVtcL11I7NoEgLTzOLOo2QkwN1FgjCmWvi+A6atM23MRHNDBOEee+9+jzeXoF3QIYAzDZShx8MdYUgwLS2TCSRhFeWv5wizkRKO80ZFjV5ugVurl/JPJzSkgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTbVcR3jMufVBb5PW3NS2+4N3Hmnb6cMpE+GvX/CZYQ=;
 b=liyfcfw1rHZ231WXgSNKw/Yx1yTmIOp+p9JFcRZFSkcZ0nx2Dx0KWoX7x4GLKPQFBRaOxXbHqn4dvvKyWOBom8nixwg7UqITVi5taxBE4YLW54HsO5lMidejulmVVtK15HCCpTPf6QlvETGEhVyEkpEKd4f/InUYlGeaH0BO/1QEb5Xu0uPkaO7TLpTgAiQiFHuWCPA7gL4By6XnZiovRn+GuPLQ/RMUvRUgTvGmVwrzlRCMy9Mr0V33TaXb+c4tOBRD+ZeC1fnpzrX727O6u+lTA9kt0ZtMz6eZV9KgmqfRx/nxIxMFwAh3EHx5ysHyymObTDhMMZ5hJJIhbchZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:22:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:22:28 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: [PATCH 5/7] modules: Introduce data_layout
Thread-Topic: [PATCH 5/7] modules: Introduce data_layout
Thread-Index: AQHYEQPob8ByTEMNTUeq+xS9tS+mrg==
Date:   Mon, 24 Jan 2022 09:22:28 +0000
Message-ID: <b476fd5acd5090fe4c5a8a746c8f7447d708fd3d.1643015752.git.christophe.leroy@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1643015752.git.christophe.leroy@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ec41163-8959-4fa5-1fe2-08d9df1b0acc
x-ms-traffictypediagnostic: PR1P264MB1742:EE_
x-microsoft-antispam-prvs: <PR1P264MB1742B456A9A3430325AB9C5EED5E9@PR1P264MB1742.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RKTGnA0v6EjSwltQTYc/lJpZlhVKNmVB0FGSLOO9cb46Y24Magbb+W7CNX8N7I48vIot/Ru1230UnsSoXUKzmHPC1hLNmgcg+P/IcEvzsYRHIE4LHh301FaBGc1sph1HcIKgd+1B0AN+FV1xsHXAE6qKNP3BtN/c/yKxTQo6jF9EZVwovvbU8aQBXr59dYc5prgdJqnnwKbaEcq3Sq6fYZ25JTxzVa1lYmNVwgu4Z8eH/hg+V0ZiW/LlLnQymjHil8BZnm/zHl2zFtezsQP8f2IBO8JOV1wiWgz+fG3wTOvgIp6Q8CNOCQSqp8wWZmJnsnq+uUOtdspCNqEHVC1c4YBZmyDRIulsGAXUaiImYH0iKdrIUfuL7vqTNZvdFfpQVITMEKiWtJvIpVnSa8P40+fKI8RQNtzVpd5a7qPWl+NNOjviDX9gHder1FvHoHuCVCkyAUB+JGaSxJVqgPY9vG9vndkjBu9mQY+D7tz8rCethof38mWLB3ppJJZtngDdcvvCN/CWnkfwC5KJEuthbIjIuWiF7MMsbqw6Cd/BlZOSjvfRy5Gf7gvbXorf6oI+NLvRM8kIWjno4v1rIcNgw+eUR3DdyKiXpyOxiTzRvrDE3cE0FPwcLgT9lsv2fPBkYvGp8qkXzzUYBvyg5Zs+5RH9e92aMziPT/+XH6yEE6oUfp0wPZHmAz1UWWv7qsoH+aH+ROJHev182ezC28PBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(91956017)(316002)(6486002)(54906003)(110136005)(6512007)(508600001)(64756008)(2616005)(86362001)(8676002)(186003)(26005)(5660300002)(66446008)(83380400001)(2906002)(76116006)(38100700002)(122000001)(44832011)(71200400001)(38070700005)(6506007)(66946007)(4326008)(36756003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WWp3zRPzOikt3xarTNdczOAwGoUvpywJjA+cDj2Y8MpUxMbB73RDFIeJpX?=
 =?iso-8859-1?Q?TpREwLvczrJfe3WGZlE7tfcIMNubdUbe5CS1zi1Sptr7zY0Yz2aOr5gOfJ?=
 =?iso-8859-1?Q?QE/FDxFecg1vKbQkTovzMOe77V1bCVHQMSEj40Ne8MWCpYasdgpEOAqQro?=
 =?iso-8859-1?Q?6Z33vFNmIhvU7U3tRSnf1+V6tzXzD4odEMKBG5nqvYNhRNQTwpS3T9Xuvn?=
 =?iso-8859-1?Q?6GZ7lcIdoWpJpa3AE+XK2o7XWubfNsOe3sxVVZRnM2PEIZ+Hzf3B6CgpaB?=
 =?iso-8859-1?Q?UVaP+h9/mHfPbR0rT7lHYHcvgzTtsAYT3LlSEMT4iiDL8jGT3ty6AiIS3Q?=
 =?iso-8859-1?Q?wk58o08rzBekuhvkr+j3sQnRyRhoaj6mpidRzHwRrc8VBIcGkaWPDtLt0n?=
 =?iso-8859-1?Q?G/SbDtVv4BirB2aybpU3HWgpwrBHqBMSE1o0DjikR+OifzCOKljKIZZ434?=
 =?iso-8859-1?Q?nAirbKq+OVpFMOAgrCSopw03KXRIlh6CA2/duJ5mhWqPKKWKT1sWXBgsTD?=
 =?iso-8859-1?Q?SGwCKQjGEvPQXlP2MIX+dLxumakfL93GMTbkUbK5huKuRTnGTBINIsUQ4L?=
 =?iso-8859-1?Q?j4GpPixR8ak37r+5zzHGmgqPTQKbxCRyo/L30ksKQMUrp4n0G76yeqi3YI?=
 =?iso-8859-1?Q?ut7QnmrmETrEae6mDMXNr9XC/Tw4EYJEyjHW1T8MtNnKGFFPTZqehDzrEn?=
 =?iso-8859-1?Q?mPBd9MLvZibrc/x/AAQSVYIhS3zTuejA8018K3SgvrLVRRh2kQrtbyEM5E?=
 =?iso-8859-1?Q?h+jtFTOiCGObe/N/z+0wAst8mKagC5t/FxUafSwx/1eYCjBEq+9PX7+nHc?=
 =?iso-8859-1?Q?16OarM6SCpglI0S+q91UWOHkamfWs31/ZVLmY1LhYxbWKvJTpS+5IxCF8D?=
 =?iso-8859-1?Q?MaDMwxkun6JnkXOVgeCVOWmNhxPTmETS6K+KFY3eb5QCsTwm9GsLUf+jwF?=
 =?iso-8859-1?Q?efV7Nv5N8LrqN8V2ModP5/MqpL9Iwb+HD01SweA/0K9EvEzbCro7nuvngq?=
 =?iso-8859-1?Q?Nb5NGvqDAvoQH2GFtb10t0G4bxgRD/KyXOSrzBQAd5+BOBI0Vels9IcYEU?=
 =?iso-8859-1?Q?2dst7lUY7GDJyX+SIahsXqAxKet64WzkkfiYyYA/OfW5OzobvPxGg5fQLz?=
 =?iso-8859-1?Q?JLOJNPvDVIi3dV+k247euXaFaP53WlLobv1it2gaJPzq2M1s6FQeiczVW1?=
 =?iso-8859-1?Q?yCtxxn1JBGreRVzZ+C+jS/+4foleJn4qQxAvpyFyOKZhO4KBDhIObk5A+E?=
 =?iso-8859-1?Q?wRn35C+VvZY49HewRVs9ubTT3TLm5Y9Yz1ow1wyHbeYMajF7+Ztm5y/UUO?=
 =?iso-8859-1?Q?C2Y4PlAkRvsN9jRAyf0wJDisVScdrsvGDOOyvSFoIn+ZwtsatTb/7myk5T?=
 =?iso-8859-1?Q?duY9oUtpuMcuj+6ZquvgbWRIa//6zsQwC5E7rIFgY4PEv8UUaFB0WX4snx?=
 =?iso-8859-1?Q?4vOtTbytI+pmCITQXPKE7ugRoUpr0W6Z9YvCMb9oG8b/iQ0ULWXFRiPPKO?=
 =?iso-8859-1?Q?7p8YhCcxnd1yQFY7kQ0P2WcieDDuQPik7QR/nTazHlrKXMRTH1D4GliW7V?=
 =?iso-8859-1?Q?Rc+poROpEY0USt1vxD+VWqM9zyQQJPPzUEIsGVoVYbZH1LLFKjIhPHsvm2?=
 =?iso-8859-1?Q?YujvB8lLVornYjibhBUrzb7cWxfXYettLrYW1QKU+G7rUQlISBF9qEZB7B?=
 =?iso-8859-1?Q?1FFXlQID5f9VPZIQ9nWxWFCMAOOacoiVyOEY+Cq3uKUuq47S220VFCi/4c?=
 =?iso-8859-1?Q?M1mC9L1PknZg7pFWHyFArhgTY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec41163-8959-4fa5-1fe2-08d9df1b0acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:22:28.6803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8fiTlyMoImxU/5NzIKQdBij9UfX+3HY7nXRiD2V1PjBX8QPviJG0/bnTeXLAyDzBbIMJjrjl284K3dxQxcF+9whqdruaoo0Wk+Pp1qPfDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1742
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
index 051fecef416b..de1a9de6a544 100644
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
@@ -2012,19 +2014,20 @@ static void module_enable_ro(const struct module *mod, bool after_init)
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
@@ -2202,7 +2205,7 @@ static void free_module(struct module *mod)
 	percpu_modfree(mod);
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -2449,7 +2452,10 @@ static void layout_sections(struct module *mod, struct load_info *info)
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
@@ -2458,15 +2464,15 @@ static void layout_sections(struct module *mod, struct load_info *info)
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
@@ -2719,12 +2725,12 @@ static void layout_symtab(struct module *mod, struct load_info *info)
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
@@ -2768,9 +2774,9 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
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
@@ -3462,6 +3468,8 @@ static int move_module(struct module *mod, struct load_info *info)
 		if (shdr->sh_entsize & INIT_OFFSET_MASK)
 			dest = mod->init_layout.base
 				+ (shdr->sh_entsize & ~INIT_OFFSET_MASK);
+		else if (!(shdr->sh_flags & SHF_EXECINSTR))
+			dest = mod->data_layout.base + shdr->sh_entsize;
 		else
 			dest = mod->core_layout.base + shdr->sh_entsize;
 
@@ -4167,7 +4175,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	mutex_unlock(&module_mutex);
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
-	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
-- 
2.33.1
