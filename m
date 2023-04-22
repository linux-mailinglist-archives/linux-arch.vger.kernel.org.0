Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BC6EB6D4
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjDVCUU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjDVCUJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:20:09 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D7359A;
        Fri, 21 Apr 2023 19:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl0znskAVDvviTe0eOb9iEorssbHkVbAafu/JQFNLfPyxjCrsHJTTuz2Xijsw0HbP9ouh/rEVUhTKy/OXhpXcudHb/MPRrPYDNGPzBwm3DFjYhAjEm0kEwpjfcvEUgGvPugDJdfWIRXKcsFLjQ17GktSCllq3J+/lTRz5HbUb/x038Yrl2LL4zO4LskV5QpdeCaIevNGHSdbfbPG4oc0iXI86tM+g5QMLzWiQbTuYgWol933gzte2KEf+ofILbz+F0FvXY67bJlselofE/F9qfrf8wCc4gCDGf5ixXnX8jGsnAG6WMdnGZSp3kZGdxfLnPyikyT5BpbK00KUrKfi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4uuvpZIn5e0Rfx2QAmnmA9Qsc2/gmvKc2dBDzzOTkc=;
 b=OVgrNd8GE5iZqSDkDQRxJFoy2SJTmdFbHBb6XDN/e/L2s0CS72cWNNPBoCBsCnyUjYgG9YALEMQAYobUeU32xeGaPxJ/a6IfQEbI8UElNoD5ZQvYlx7Q5NKZ+bb9KFAktYoUpR772GaQzBUa+2C8r6fMKMbDraEqoOyjrlrHJfP1LkOT0B4+B5Kav6SX7OR4Y1UEX9mWZLGN6AT7vfUftiuxNfbgtscGOaMo08bc1EThih6dwq60LwtMhU+Rg681hWRhIG2hGnuzeF9Lll/xmGQbybUF+WieTxep7kfZD8OJI/HTDKn51zyWJs0tewjFt83h9M8L/rALLUUbUa5N8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4uuvpZIn5e0Rfx2QAmnmA9Qsc2/gmvKc2dBDzzOTkc=;
 b=JWy+xl2h87LiJey+4uyFOw7mcvfsIpimWEzxD+zenEDP1+4RXdjWzI/WrWyYZKMZLw1UVOxkPNWBl5onx6+7LI7uqj/X2hIiohhAVJrTCDLid03U1qZcC5pH9zGo5VBxF6WiDfgfo4ZJ1PQ6GMpRSC1WZbCVwHyOkmD3nU7twTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:40 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:39 +0000
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
Subject: [PATCH v5 6/6] x86/hyperv: Fix serial console interrupts for TDX guests
Date:   Fri, 21 Apr 2023 19:17:35 -0700
Message-Id: <20230422021735.27698-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422021735.27698-1-decui@microsoft.com>
References: <20230422021735.27698-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:8::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM6PR21MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: 70738538-3c4e-4692-b301-08db42d806c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFoHNzf1rHRlHg37onlSbgFwkqcPOopxgM+Ee3TJDvzdBhUQw8FDCic4EWrXmNWBW1o3MhdQOG1QNWv1nxUiRzILy0tRcAw4cgn/PYvvSRvNdcPIgna80yi8UUkCt38+og+6tiZVet1n6Vh5YlVxTbEHtJFWnm2BNzGAp9t+gUlGl9ihZMaNX7ASTB2R5uXerE5y3rwP0JmioRNehX8os3vNvReTd1wdVvjec7pW2k7wnKv5NJWrNECViZ0N5U8tO4sd9D0UxzYNcjA5W9eYrazUYuoatQt/4UlyczLCdCf4Xg86HyaViv/xzmdQYzuoB1ajuVepsef3uA3I+GRHNv/rkADSEj1JFdtkttUW3jQlnlhEdDGTvm5MWIN8/9GuQSEpLE3wRLYNp1tis3/7pfbY1x+mkfb9Buz7QkFPdpZNOFhHX1GLNJDDsdmXS9hVY52XjVY0A1C8X3l2VuO3k3GFRu4qIV1Yfpavch9Ry0sh5zRSX3GQBHGsA759F+yaH5T/njBCbW+IOnH9XQln4eqolZ5jvD+ZRub9B4XerFLpE40BkWJicFFYqWHULaFyvsxShep7wcUk/iQTVk8yfgugynOVYanIDM7zjsgtgbt/p09B4vExN/B7kGTIr6apkJtpIy/1+Om3YAmvNc8JXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(8676002)(8936002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(82960400001)(921005)(82950400001)(66556008)(316002)(786003)(6636002)(2906002)(5660300002)(10290500003)(7416002)(186003)(107886003)(86362001)(1076003)(6512007)(6506007)(36756003)(83380400001)(2616005)(6666004)(52116002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObH5N+OsBbwl8nPcslKPbBwPKwEoQF3Ntgtbl/DZ/qZwgtRrSNQSeQPXh+Ey?=
 =?us-ascii?Q?UbWzv52JIqEcV1N9alGoiBHrKByClnvsZPWQ39B331XT8yKQX7SJmCGudzeA?=
 =?us-ascii?Q?A49uiLv+YBu2X3hovW8vitf2/qVGfIUTT9NzwMeK4wX/1GXrTw5klTywowHT?=
 =?us-ascii?Q?8IEdDW+JHw/9R2SNtOCukNlJG8bugxTTib9A4ljw1mlRqJok3FGl/A6UnQsa?=
 =?us-ascii?Q?K1TbW5m8BA9LhUfhYr/8jjbnlMooZRIbb+dEjydXd7KZ4E/W1Is547DyjV2o?=
 =?us-ascii?Q?kUBfh3QIHIXLfzVMlLrXE9JXdHbQqFuKKdmUX6PHB+dR+7rv+apzZN5aATyD?=
 =?us-ascii?Q?a16kueqB4UZDhHQ1PK/s9+Ys3YcZkQiMSGE7xWdDXBqXr3i1iefSUBLWIJlJ?=
 =?us-ascii?Q?seMZftc9kI+rBEoe1+sHXJViGahC8/CtFa7SwobgOyOSnI03vF5TMki+h8vV?=
 =?us-ascii?Q?MMafPoQ8dY64/p0bqwTV7/nAoMio+uSjdDPnV/r150b7WV0Yd84o/s8FOWOo?=
 =?us-ascii?Q?Ag3OMDgFrKEydPg8enm+ED8W1ez2UWxpdmDq5t/X6XnRUwLyRx1zkaOY57Vt?=
 =?us-ascii?Q?pxbMe8cPnViWm4St5Hx4XtfyliF80zONQGVrfbHDfDImgoSA86SdN5uDIHX5?=
 =?us-ascii?Q?yyH5DRHMkoeBntfnSJx0Rtn3dQed9MUA+p80h3zS9ZnZGNLByV7Ay/4Lmf+B?=
 =?us-ascii?Q?ePKKQ4yzd0kxxaDM3CUz5V5DQ6dr8FG8rBBsS1Np3LiCYX7MtcN/W+embZKj?=
 =?us-ascii?Q?V2k0IO0JZfY76I/aBlWYYEaBuIrBKZs5Dh8Axqk37Rm/YUp0SfD2kLVtQQq2?=
 =?us-ascii?Q?mWZYMqeyJT3nNmKAM45v3DxR7YPNWMS6jCSzqM0dMof3p2Lfayv8R4xt4faG?=
 =?us-ascii?Q?w+A+Jp/Jex/X5W3HRP1htSlf1pgaK8fIhCtKpa+1SLQpbQptayFpLsaXGuAA?=
 =?us-ascii?Q?xQE3NHrPIg0RE+iaVtlbHDpZthuOLXP0IYa9Sw9miNeBHIflYQOTt2i9Ttz1?=
 =?us-ascii?Q?2EVQNC6kvMgK3ry1Q8KNoe6wsJ0i9wno9scabzIPKSAZO+ZX6m7KJ1nXW1X5?=
 =?us-ascii?Q?roz/CJlo9qa+8eJJFHnOoN5kZsPSdsRUKN5vm6RCWT3Pdz8U3hZnOeBF3iN+?=
 =?us-ascii?Q?ZS+fVtApAxB4H3LgnOLXbT69rEUI/4GEdjy+XLF1Qghtu+Dzuwk+EvpxpdFJ?=
 =?us-ascii?Q?YWOeLtKGvwsTTjjtS0a6RIUA345ekOS9q2sxK4GdEH8DQ3otdb0Yqguo+sBQ?=
 =?us-ascii?Q?ucR/jWJMAXf0HYovedbiwjxMLn/ekwmZlUGtMkZhY86XJcKavHHmRZFkZ1Sq?=
 =?us-ascii?Q?Cj1mdfnz1Tkl9nLZuVmMl/NTg6iHmqw0tX4b1yDgcihwsa/WJgj1Sr0l5CqJ?=
 =?us-ascii?Q?6byjL+bLwJ+YaWVKZnyiwhux9nxjBY1YWBCkYiWAJdGYFUoO4dpRMeNjtgk3?=
 =?us-ascii?Q?6JTBLQ48wWsIKqfjnCqAsh8ymvJWdLbDrAU3jta/Ph/KkNJ32fDSvrCziMlY?=
 =?us-ascii?Q?Sumn6a7DzsD9ERhOKyipYIYVTwDTOV2uwE4RfuatTN1VmvndLH1feWFYBZkl?=
 =?us-ascii?Q?Iqf/YaZwm2v+umg4ag0zTgRAPZyxDBcwBhBFvCTgjKwI+mPz4Wz75Wgs1ijc?=
 =?us-ascii?Q?c1346ZskR+mVx9zpx2KKtlOHqn1cKRRuMsxs9OGEpvOD?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70738538-3c4e-4692-b301-08db42d806c7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:39.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBAA1m8IiHIQe50fKZgZfgWVu6xBBWPjm6sqBDrTkrSitfXRvjDtJ2MePYjUbAl8ml7SPJwzvSRVFjGlkjRgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a TDX guest runs on Hyper-V, the UEFI firmware sets the HW_REDUCED
flag, and consequently ttyS0 interrupts can't work. Fix the issue by
overriding x86_init.acpi.reduced_hw_early_init().

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Changes since v1:
    None.

Changes in v5:
    Improved the comment [Michael Kelley]
    Added Michael's Reviewed-by.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e9106c9d92f8..942170ea6a5d 100644
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
+ * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() here,
+ * except don't change 'legacy_pic'. It keeps its default value
+ * 'default_legacy_pic'. mp_config_acpi_legacy_irqs() sees a non-zero
+ * nr_legacy_irqs(), and eventually serial console interrupts works properly.
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

