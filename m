Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9868C6CF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBFT11 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBFT1Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:27:24 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4778B1B304;
        Mon,  6 Feb 2023 11:27:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSK4Nexj4voJLTMxvtzjNgVQkwCZP1Yh+oWBZkiMhGGan9QRhrI6R4nNnVX6ns9G5wwTgA5k6GXnTiZ8J5Nu7T8PnxglJMb65Ei/jZ6ecxbaHMytRNN9I1cEbcrDaY6qsOsYowWSKnjxe12fc5Jbm8OamJx0aZ6J1Bh58F0v3G62p0yIybHPzxI8qnYn1PnXDB93sMzqEfR14/lTRzMlbj6AG7K275Uy+lDJWqJwkTaPCM0RpMWLO0sWKug0bc2ZhqYnhvjgVUA09KEGtmLtlBUy/T1uW8Q4cgMcomjPvmZ6SjHmmWA03SsHLnAdP/mv8bVl4M/8EX9zm5o4VegipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjO05eTW3a1P+z+oLLl/bYDbWPd1xbIdTNx3vKZgpbU=;
 b=fFTUJPWrN6t+2k4ohLOxPffSjTP0fZGanVhmYqXjLk6gOY0ehl8GtNtSjJckEFsc16bOA1AP1GPnHNLuLDc9NKLhh6Z+LJj1TkDk6Fl/EY4YTVG31QVGptwHs/9roVjZLpsnyxWGmTWI4dXHD9X7JDReJ75gdohjus3TURbyqstuXzSBrMLr+a6PAwhcPxPd0aMvHQcm03Jthv/Iica6QMvQcPR7Sm/+5j7lNkb19z4SWVp/Ldxmfbh6Qjf1nlK8w92CSYViTZEOIYOcNr6rn7CIUOqS564kkPWOypsPRhiGG1jEjGCXKIfkakb3ahfRu2cp6PTZNI4p2QYmwCGh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:31 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:31 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 6/6] x86/hyperv: Fix serial console interrupts for TDX guests
Date:   Mon,  6 Feb 2023 11:24:19 -0800
Message-Id: <20230206192419.24525-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230206192419.24525-1-decui@microsoft.com>
References: <20230206192419.24525-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MWH0PFEDFF6182D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faa25e7-6c81-46a4-bb8a-08db08780ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KGyxOl9ajzvNwXaadzoHyw6LFkmFuKiwzWNHhuoAi/pBmpvLqfrpKY+xWs+NXLVm6pjsXM31HTGj8IQ7FDHMsULaN2WpbL47cdu9oZg8KFdgPG3DQMzmELn/iDz9Id2FvbYifVq1OjL+0aZ4l8/yChWHsOzoeCyMqh0MbWFo/3GXD1FzdZZ4ZDAo+Oivnc/S2d5iiyU2VnL30PV6NxbKfK32BQoGJHM+E/QRv34nVLTeQBr84pRw+++wyrLT8DoBbeX9Nmz2qlJlffUkIZMvT50Jh/+xsrHRGEGikTfYG3oUjjmyE31mX6HElGEzINkrQgogs4Wf9tg1RwBGhx+4vSkm+IlhgyPXNAibn1jA+V4a0ogMBW7UQtURysH78p0IviGRA3kx3UCsabe8HjsSyHjokJZ6p451axMs8fDDqoJ49IDHETKRfTtu2zDoxynwiDcr2flVO1RaXFRQ15vss5y+U4czuoCwkLPNym8l3YhfwdO0DY0iyPMz4M2ARHd7B5JTehEf/Jd5eRSQfA7Dzie6p5o94NeqoVbVd9A8tySEdPNHX02lUWNXRgiIC3oNUEdN1+DGcB+Ummp+3nqGiUoyDmJRllR0WV3SEq9DeYnmH7ASqtwXWKrIiCss8uLvL9d7x4ykhcRCFe7yP/v0Lfz0GvbDwQ4hE62lNgH7jrbtxnKfY7yd+EknjG8RqMbwZrEBID0Rhka8PvMTfnErTZsPo6xDpV41gNEhBUPX7rY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oh4odJvg0vIib6wybUU7jELS/q0h9WPLVez5VrDdcc7KZUCJoFbDK+ceNdOW?=
 =?us-ascii?Q?hWKXaAuezB9tzA1ms0E3YyyEGKFxCCydLmhG/UzIEeuSdgfawKV4i9Uzp3/A?=
 =?us-ascii?Q?ejc3Ar/SnBOyXFExZ72c1MgdYo8jeG6XAfaGXAVlMuPxaC8r+I3nwgOW0FLf?=
 =?us-ascii?Q?SxFqk6saNuZOj5ZlFesbV4gKyvE4JT9cKI/cARjZOb6Mki1985/jUgSk3vqz?=
 =?us-ascii?Q?mzHUUkJVi3I72wune5QB7ttaUk9RJAy7R8+MmHFlW4CR0N8pOp5qIm+PQbtU?=
 =?us-ascii?Q?RV4R75tQKnnB3mLZO7D0+tXH5KrJtOTdf9CGbcmNC+1glAtaoQjA7SHYzwR4?=
 =?us-ascii?Q?Q6i3rxxLeKrztkwYb0excb4IXpfCLCHVysq5Z5E3Yavcf6GJXSp6LEPcwAa0?=
 =?us-ascii?Q?Eey16fjUAna5fm3Ovd7jil/+tFYTobwb3Tm5FrKCQDJkHN8Iy93XAOU9sQz3?=
 =?us-ascii?Q?Mem4DgNZ0UbUbybGaCspebCNtGbb5n2KwzI79HfP98X+1tVczZp8V3XezFj4?=
 =?us-ascii?Q?5e69vFgKfDcDFSFLLqnfzqBxcoKDINxt6iFKp3ndhF/vAVXm2/5c2a9Oc/FB?=
 =?us-ascii?Q?ePY2/Xj07BzSlbV7ui3PXCOS3DSWRAY6S98Pe2hgt5oQopevIoTjXPBxghfP?=
 =?us-ascii?Q?X9TT3TbLA6ZpxIERjNFXGG0nrWMECH0YU9R9Ol2Mt94VZaj4BuJBFmKuod/e?=
 =?us-ascii?Q?adhFsiwZprsMHdrZoPA1EPtSXx7NtgjRHiKjJgBbrsOIwbeSYYtPPsTLFf0o?=
 =?us-ascii?Q?0kL6vg61/BB/jLFNEdABwTttmqsxfzqh4DvnP+h+FCHz092MJ9ti3lQ4RIid?=
 =?us-ascii?Q?3kzk8+jw/W1d4Gh6NV2E+NdntrxRL5kdeZ0ZNq/Sz6yuQoqOMiWdBCzRtHmo?=
 =?us-ascii?Q?RwrFpE87bKGLqSAlX7Mp5MUknmLDHgCImXTT/pn6JlDuR/CA+xjNCzh9qNh1?=
 =?us-ascii?Q?bAhjeekLBBrsVh+rdxG5Hqc4BCVscH+eUYxCC7qPWpn9kHGlIIdM4Vh1npF0?=
 =?us-ascii?Q?Ra0PWjkgiTJqD/NwYAQ06mTlFvParRRwsI6InT54D3EKoZ9vACmxJ/GFEfre?=
 =?us-ascii?Q?VGeJw4wAZdk5jcKi4gfW6vrEzp7CohF0WWLA2lmno9kMZ8LSsrfMt4PSNF7r?=
 =?us-ascii?Q?/0m255nYJNWWdmG5ulJMDjWdcS12xFWfYRK+b9s0YBqLWIrwN+vfjtji9O+1?=
 =?us-ascii?Q?EUZpOnbP6PN5YyVcJYXzfeNO1+t1h+VC6Vp+8ey67TzGtjIFNXw0brZXsFNn?=
 =?us-ascii?Q?hlzCyREh9dKA2MzgXca6s5D5gFCwSjkQOTOvLAEvIz0g5cZCLXnWH6dg4K2G?=
 =?us-ascii?Q?rdYexN9CZlNxln0eNq/XG1vyhHcpXaUI586afsb6toXB6rzJiEFL78Ace3AV?=
 =?us-ascii?Q?hhXzMZikTr2tX3cVvUcZXPwK7XFYgakMyO1nsg8OAxYTHoV+sWziuIa6QPK6?=
 =?us-ascii?Q?q1E+MVJESDu5wouHRuScWWJcIC1dwGUnVgePP7l/ZWivPAlRAAAhCsUm0W0D?=
 =?us-ascii?Q?cqxeGu9uu+3FR6f+Ax9f86UgpyuKTZxPtBXGnnL5NfTFWp+5N9UCuYZIT+1d?=
 =?us-ascii?Q?8hOCWjjC/dxF4iyFjGYhiqRQus7fCj1GuKtrBCdKz4ytLbI4LmuvpnVgKJLX?=
 =?us-ascii?Q?z36ciuZUHSIiXE4HESUtuWXFlGB9UPygBxDJgali/h7n?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faa25e7-6c81-46a4-bb8a-08db08780ce5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:30.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQIiBputIz8vYCvUBuKJGdp8ay7OETxzK3HJ5wRsuANrY5gYdItPqJadJsJTO4tbd2+1s9WnuX+aK6alfXSp+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a TDX guest runs on Hyper-V, the UEFI firmware sets the HW_REDUCED
flag, and consequently ttyS0 interrupts can't work. Fix the issue by
overriding x86_init.acpi.reduced_hw_early_init().

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

This patch appears in the patchset for the first time.

 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 6a57af60ec9f..26490bc5a060 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -253,6 +253,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 }
 #endif
 
+/*
+ * When a TDX guest runs on Hyper-V, the firmware sets the HW_REDUCED flag: see
+ * acpi_tb_create_local_fadt(). Consequently ttyS0 interrupts can't work because
+ * request_irq() -> ... -> irq_to_desc() returns NULL for ttyS0. This happens
+ * because mp_config_acpi_legacy_irqs() sees a nr_legacy_irqs() of 0, so it
+ * doesn't initialize the array 'mp_irqs[]', and later setup_IO_APIC_irqs() ->
+ * find_irq_entry() fails to find the legacy irqs from the array, and hence
+ * doesn't create the necessary irq description info.
+ *
+ * Copy arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() but doesn't
+ * change 'legacy_pic', so it keeps its default value 'default_legacy_pic' in
+ * mp_config_acpi_legacy_irqs(), which sees a non-zero nr_legacy_irqs(), and
+ * eventually serial console interrupts can work properly.
+ */
+static void __init reduced_hw_init(void)
+{
+	x86_init.timers.timer_init	= x86_init_noop;
+	x86_init.irqs.pre_vector_init	= x86_init_noop;
+}
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax;
@@ -367,6 +387,8 @@ static void __init ms_hyperv_init_platform(void)
 
 			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+
+			x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 		}
 	}
 
-- 
2.25.1

