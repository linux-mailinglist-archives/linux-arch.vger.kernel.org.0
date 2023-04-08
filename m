Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30066DBD0E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDHUtt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDHUto (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:44 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020023.outbound.protection.outlook.com [52.101.56.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38E8B752;
        Sat,  8 Apr 2023 13:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L71lEBW9Dh10rGT71T1ihrbfnnGoiA51q34YmXOwtYJjh3CGm/IlxJuvVfjUlRnJkyrBjKOCuWjD2TsTyhvrBvG2TRdvNL7NMUlpXW7Pfudnk+GmUA7pquDdYn6jnrDjmX0MG+ND2bUrW4exKngQ697UcmybrULSdzK9gQRONSANV4Ak4u85qEZ9BYM5lMthv3EJZiKcVWO3ffFdXBDvjzVVDypKR3L/7jxw+8Bqoy3E3DXCehNMB80Bjh9iNPbqs47I+pbQboA1Q2PF+Q6884F20T4IGbpb5p0PmRwTObwhtMyCkwWSJnJ3HZXnT2pRkZ9V3KtAagCFHyPm5Mgu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdLR7U+eYdNzw5TcfNruWTluG40uXqBcyz6GVbJIGEA=;
 b=n6Z21jV5Fq4ZsA7VcWsCB8XOLZRzsNAB4wkYle3W8o5214UjBo08N1PkLoWs39P351n399yex4xfXB08ojIv6Y2hqHYgeHo7ZQ6ohhj00j9oMfSW+cgXKZjUfH6bECTpWizl+b53wwK19/BdeubjdNcijLboWuxvRWT35PlNL81RBiTlC310L3wrLi/WkB5uIbMh6fECILOh3HnQqWbpgC+ktQtICJfdhShKVq86+QmRj6DG2XdiKOpjU3L6ORMeGiLqafdkFEq2ewVPmHQ3cNrQzYDiuddsffeWvW582sJi+FynMkmMTZ00wweqDe2ezr4gL0lqLzyD9ftAk+ZdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdLR7U+eYdNzw5TcfNruWTluG40uXqBcyz6GVbJIGEA=;
 b=T5xdLFhL1FSWcDbkm2KHOq7GNh+LJa1FUi6ThhSevWeTz0eceTK8087bv8hJtQyxjVJ/lbEvarmBysxzxpRasQdiwfsmmTbT1iBCkNQXtnwueqgQ5JN85x/qwcPaa4A9K7lJ9gik6Rj+wuBlZk94CdLS9daSF2mUsBhxQ9BDQrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:38 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:38 +0000
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
Subject: [PATCH v4 6/6] x86/hyperv: Fix serial console interrupts for TDX guests
Date:   Sat,  8 Apr 2023 13:47:59 -0700
Message-Id: <20230408204759.14902-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230408204759.14902-1-decui@microsoft.com>
References: <20230408204759.14902-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BYAPR21MB1336:EE_
X-MS-Office365-Filtering-Correlation-Id: b36d130f-7762-42fb-89cf-08db3872c4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBLRgLxdEONZWVQm/6uv7spJf7g1orO0wXtGe1oOvtD/uu6UvGsAv02KDIv6ri1b+8Rc6z+DMqK+fLDiNCVLcpwrC1TPNk4kDFdJwLGx2V9Cyt6gZb/xNSyn2ugSosfsArPkjgyh1N/exCQxKsxly0n28EFPey22K4LRa1Cy4oXPtHSjyR1Wwoz0Hbq1aMnCcE6GlARjFZRPdyTduc96kZaYQ2Slfvl7v5Fu5J8vTcAOuXYvE+l6WO3Mg0u8bOFJU+f3BPLaJklpeG+aRt9T4TyE26b3PmIUU9U3ltiVW3SGLpUVzJnkC5uSfDBmmzQqVWr8pFI3SLthSUk0jw+AA61cGlRnztLJqU4zNzEjJ4/mZaQryYxP8V8eGK4kQhprlvZEPVed46w6yEEim1hkRonlbEEEQ2ajt5JI4DLa/QiARSfGRCiUdKgOKb9yB5Pyic5GrR8o2T7QOjcdzzKJAyC483w+GLUHcA1B7HGs0xGpSzlfSL1osqCVIT76dUDidrvDv22XLZGCvB89zX19DhWeWWdO2Lh37hdRt3FxA4jvwowIsHcQF92f3i63pl2232q7mOz7Fzj2UfhB9oeGiFAAVs8k4m+jDdCyjQo7uAbhcOCIP43KL/hgkzXSB1J9tlmO7ol8BVINnHsj0/u6zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZm3Ujk2Zy0o7SOe3OBkDeuOGaaNjob/UA5Rp0jQe2dXYVzRDRVHrASJ3jwe?=
 =?us-ascii?Q?6eyV+AOYUsJTR82zGIsnfv1zonBEp1f6MhcPoko4T9WGVtl8sjP3WKKnHQRx?=
 =?us-ascii?Q?S1bNerQOaHui4U9+wKez7jbi3mYCFG4hHTpZdnA5RXb727rZcV5cKT8gk8Uu?=
 =?us-ascii?Q?4g0HxaP664tE+oYPu/V8xav25KQE6vwBznRIpgzGwzICYq24od72/zcOrk6Q?=
 =?us-ascii?Q?ZNepIri/NBPuW1MVxqRE39I7RxYt1jUKFez5pSSBWmsfTaYpy8ruHSdJGN5+?=
 =?us-ascii?Q?JS+lPVNltWWkqIlP++lVLZN+j1mtFfSIjNFFPE7dEa6d7p9mPq8jjxwzCu/m?=
 =?us-ascii?Q?5tiXl/g0pCfDuX6CB3FdIgawTgMP/902TpnuMZ94mPIpTgZbrL11P/9a+JNO?=
 =?us-ascii?Q?35+gpwB6XS6qUfi5DazBupUqiFZ4ynr1U+n5o0tMoM+O5LymkkqszJ2EVDdr?=
 =?us-ascii?Q?dnOZhV1dOh3Z10273hHpH0Y8fT+9UWAZ+kmbvl7jri4Us/bC3B+Vhzz1LMIC?=
 =?us-ascii?Q?GSqsQzGvsFK3v6VNe2xZWXVAAhSBjgZeHV7wnCaBEUgegqgtGMvo57Y48CSM?=
 =?us-ascii?Q?2Co1k3M9RFU5Jgr2Ns+0Y1A3KRAp58Mfoyqe1ctgUkgdRwj/aR2H2RB4rZvQ?=
 =?us-ascii?Q?R6M8Ifx9vf4DuUhX28mIdcxBaxswK4Qo4JgRTDprjP+N5Xsg6yctSxi01UWT?=
 =?us-ascii?Q?D6pGG4R+V9XQ7MwjZ9sCnNE+XLYtKEAh8pcJIR675FJ2JVCokglsD/jBdfo2?=
 =?us-ascii?Q?7w/N69n9uS3iqldMoVOFVswK1Qri3T6b1uxyC9g3lMn5PMiP/+MJggvCRzhl?=
 =?us-ascii?Q?6V5jxbY3oLxgKsi5Nw+4CGVv9krLn4PsAy+ZqL4Leey2y6CIlkleeWTeHKZq?=
 =?us-ascii?Q?TLFqqwArh6FCh8x3S8pEgZPzncLoF2DRdiljvqKrHEsoP/N0g2Sb8S0X/QPr?=
 =?us-ascii?Q?o9VZHYTpYzn8N51bNMh83rp9iDVcCf7GdMddHRtDrJ+Kxg8Yj59Et33Nsbmr?=
 =?us-ascii?Q?UMW4HhDC2fI0MOvPEEO/qRGI1yiinbYNoPU/iBv+77kHR+R09YJAV34cgAUJ?=
 =?us-ascii?Q?NvigbJ4hyRd4xddThNME0PTOY556x+wgzvE/QK8CB35P7GDrruF7HDdM8EH5?=
 =?us-ascii?Q?KdNQ5tcVz0LoOL87yjaoCE9yWxKnJM8LPD+lbE5qNjUqQKLeVcRjglYo070m?=
 =?us-ascii?Q?vVa/GGELvwwUIbdZDlFVEW2yUjx86AVcl6W8DdDcthi35RDtVHn/odrKko7l?=
 =?us-ascii?Q?uONixGtXTgxZ4/DwZ51WkqHuHUpkdODnwXSHlX1VemBWhPWCcBO9SZfGHFeJ?=
 =?us-ascii?Q?fy+VfvCV0+jTyEfIy9mn1vZ1brAXNmOi/k7Xp8C/dgAyY2Ln+b5NA3XVaMTV?=
 =?us-ascii?Q?iVqfXfmCsEErvU6E/O8jFeZmI6rP3u9ppoYT6+tdjpMWndTpmTl++60T6wUU?=
 =?us-ascii?Q?+hVlx3F93/LTDR4MsoaPXnrcI0xvvVqYCs1f0IVqrcGQqoyyaKNSMCUAawoR?=
 =?us-ascii?Q?QuGvCR3ck0RpeDqkB4ab2OFejJqfNmApwo+TXgAB3gOVk28Jupv1w16CQS04?=
 =?us-ascii?Q?MT8+9WARfChoyPIMR8ZLHJq5dGuQXAfb796TT/lCPtI6EvuI819CHPCXDQiq?=
 =?us-ascii?Q?VnyU0F3+cb6/Mpn7V8g49sRW6BtHE5KwmmwelyIKnGW6?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d130f-7762-42fb-89cf-08db3872c4ad
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:38.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXDHG1fqd8W4AQeQE2y9Wv0JWoNCrmkgRFusi0po5n4ep4ZZdMapeyV4S+Cu+MeKA4corgTG/hJMn1iAM09Djw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

Changes since v1:
    None.

 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e9106c9d92f81..deedced0f2bb0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -318,6 +318,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -425,6 +445,8 @@ static void __init ms_hyperv_init_platform(void)
 
 			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+
+			x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 		}
 	}
 
-- 
2.25.1

