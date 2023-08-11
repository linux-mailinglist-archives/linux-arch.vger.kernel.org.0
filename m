Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1621C779A97
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjHKWUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjHKWTp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:45 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1A2D55;
        Fri, 11 Aug 2023 15:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoCMEGYxreULpB7YM5GmItqGCcwNsccnE36QorE5YUnpiK6wWPO6OD/D55kSNIT1ZRL7G/uA6sVZikJhuh55WnnEutr0RQTFhw7gW+Bk1a1z9BYaFVmTF0Pr9K2Wtm7o93dJAyTljerRzuGaBISPF9ceEO1mgXWBI7vsBkTwcs7zTQOESNxtkC8CppBzKEAe5Hbp59SnfQAX5PD4NVDuuWKx7zgVNVBpXRtwXsr+mYVknqiVSTScbP0Z3bQx+qhEChrC3o5YE9UAQFamk/1c6Lplsgn1Di1dADFMjJtnajkaIQNqNj7D0q2srhqR9FYKMvGRKKsvhNiGti7Sf9akjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz9119zCdTDX/H5MP13eu2zZggOvfE9FQGMTo7FiWGI=;
 b=NRupShIG+vZQ4MiaT2O/+5J3Kb9m8bq+ti/z6KxPqTPOn3br/VMYFv0tVBWG1ELbGYqrM8R2HmeNvIfpF+vAjqqclkPAJzgzWPoiBy7eQtPnQymHAmBWbfd8BMvLZKi6rKrzYpschMlr/hur7gtb/xt/CGb5Ye44KByaLsDcf/j5lrT9px6mb9F1pRC6ZmJ+ezAMk77APKn514DaY/h77C5Jwi71C+o0JxWeOKrLPeyoAlvW7ZxojabrMN6J6DT5Jw32DlqAYKZ4Z0d7DQoJxqG6jILEBvoiUBjOZNo+uQ5hbBynOZC/VvudeeDDAaRvXfWEaidPZLyWfb5p/fuhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz9119zCdTDX/H5MP13eu2zZggOvfE9FQGMTo7FiWGI=;
 b=LiGvdPlyNX77chcy9YP/31g9VDX3FXTV1hG6Guz6pKJazDU0D2heOV0gWOfAjIpjwPhtzkt2c18ZzUUQowYvFImdnp+JYGUOvy6lRghbgpNEeYub5babm5QVfZE3tMR0ljszzkDSKpUQ7suVS/AeSHsB6OLKsaBWmI93tcDEuLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:38 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4/9] x86/hyperv: Fix serial console interrupts for fully enlightened TDX guests
Date:   Fri, 11 Aug 2023 15:18:46 -0700
Message-Id: <20230811221851.10244-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811221851.10244-1-decui@microsoft.com>
References: <20230811221851.10244-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|DM4PR21MB3417:EE_
X-MS-Office365-Filtering-Correlation-Id: ff439420-10f5-4ed0-11d1-08db9ab90ceb
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7/OSJye2WQ06pNIvB+IO+x8iexSR9cTckBEPJLDjlG9b0r5tUsJ6Ffq+atjW2NV9vg6N07qBjjP0irrE+PZvFymE7ZG7+jRc2XpnU29sYnXxmhmqXMpPBvVX2NheE5hEYfWpo9xn+FGOZ7Um2A+j5nZf2xlTUrckAQNWL9ZJlu1m4Rv2j+XxHayPTZXyhkAvjfOEVgqAY6BcnAM661NGpTnZ4fOAlb0q1GwJB6I0xqBcSDOsx4qPapeEYopsSdj93yG/Fm/4h3vQPdLm1zZeHt+8XWwMSRX6NyEYWIFjKaQnZkZ/1YqR8/KGq5IoHmj2lGmhgUVovufELjYzwHWfyMZ9r0AB9bFVRBYjOeT3ZPfjp1zT4KJgoFO/uHZYSDTFWRVrVIyHv0VR9os2isHAyIjlSq4i3lSwGT6daJKDJK3nxkVus/jUT9PQu2dxQ/aLyURugC5Af9UQSKl5RMC/AXJAs48CAALOHK25cDfpSTXVEocPWzH3/CE1qg51XP3N9iCTAzrgrvWT8fZ3CNDu57uGYNms0hr7+thn+23uJXOSEsp0HvcFLMR3yR1xoPdcb4H6Bx97FL3LAcTiGaxiDJHo3h66dpItkrAQikfzExjOJycRoWpzOwlKy/EMpQDAh8sEL76s3keo6c6kYFyqhaIC2EeKNhjMyAAXAd62L+lbHmJhqDRgidhEO3k20nX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ta9M6uIT78W6b83jVk+oH4T3bcHmMrtiVkpDvlQDfOKzcrMBoaGj+DfBdixV?=
 =?us-ascii?Q?vKablcT8UeYVgMJiiKYWH5fCmlxxvPVUBe7n1a5P4FtTq9kJoIylu/1kB+7s?=
 =?us-ascii?Q?dvRPIQyVYiyjPMwhXVaDr7DojVt52d/y27+K4rRwcB/ZxysFNZQinWFyPR4Y?=
 =?us-ascii?Q?t+KZYDl38e6ZZGgo4uDjz20exZIIiQTEA7DGcxVbsW1eYmTAv1m565f47zHP?=
 =?us-ascii?Q?mlHzZi/mZvcgqwnDrm649+uaMmxdioHwKO77Gr0Lus4fx0prZqqNISLGHLR9?=
 =?us-ascii?Q?6MY0twd88bP6bEehmQOLYr7u9lheuKk3QMZadYt8ChJbDT5J/oDbGTmrzrYe?=
 =?us-ascii?Q?0kMcFJ4uGrzZXs3kpnUBPD581JAKoJYi0boZHTp1hZ6uSoAIRSTXEYQWhJog?=
 =?us-ascii?Q?3lRWA4P1fJXKL+ZKl5G0mCX7K2lWv7rD7MthmNqbnyIP94WzfzAFSJVgiTfC?=
 =?us-ascii?Q?JMPLoeCo5fQ5rniBXfwEvpzwP/vx/FUFCFEvxUMEvTp0cIUhd28n0ap924Q2?=
 =?us-ascii?Q?aYxC8wlxbZiXEDbt8LpADSJTnWA6idqYmLGRU2X/UsYIaI4qIvm4r4E3YlIG?=
 =?us-ascii?Q?BF49G3y1JWzkwHfq2aD0WzTGwPXNL/1BKh6Z4UdsYaI4CupfTbDc1qwaLe6M?=
 =?us-ascii?Q?DYWAU6H5i0F74vmrV+V3ikiRNHVc+zZdtPLRRl4NNUEG1mCnpAbqs3914PrP?=
 =?us-ascii?Q?hKzgOCxkX6dEBSqPh3c0lI4WGhLwv2PG0sZuUWlF/4+ao2lOCpGzWeOnol4l?=
 =?us-ascii?Q?oRL7s8/W0YJpIvTvVjDimbjYVkZeAC8x2dOiggJFJnTmRDYWYGJuB0vcGHcq?=
 =?us-ascii?Q?7Aw4jphWe467CBDhk3b/w/qDmPsgvrj/2r/b2gj1+x39KVwy8pf1mQ3qNxbF?=
 =?us-ascii?Q?fV652brywhW26AfDlrz/9WNuZl4vMZorNo85a01RYedX+tSewCK5c7bNwoHE?=
 =?us-ascii?Q?RBPwFCCp+/G5YfIeCQT38m6oyJZVJcgpn6k6o8GOjfj+Eb8BTtFSg93z7csT?=
 =?us-ascii?Q?lzssuVF9aiFBlA9Y0cfnbDcjyfxhls1rx2RI/baUYLoFwqSf+xH90YT69pQE?=
 =?us-ascii?Q?eN/NZvjWO/tyYoaEbvZ460rmEuRiYKjJN6TtJi2ClWLpkdN+ED6BjZIncrWa?=
 =?us-ascii?Q?xBHDme2rqVKuAqHV1/1w2VG8P44W+mzRIi+O+baKbaGsWv9pM5dldRYmJjz/?=
 =?us-ascii?Q?SjbypFCDkOJB6Qpu2qvWDrnF6Zxk4sd6uEyTbr55wuiMHacbS7wGnvxm9Un4?=
 =?us-ascii?Q?N68ypUZ8JkCMzJ2jPCv3hd75u9+8N8Yr8hJxrfgHVy1CEiDrsL8Wetn93FxV?=
 =?us-ascii?Q?6syLgP2R615h7khA4+btGmprcSBRubhmJkOtNswFzC/f6dpT1y93OIgOjy63?=
 =?us-ascii?Q?jLMHh4vBED40hPe7iKy4RAtr1LFFTq8T/8512DSgm0UT5Pifff7O7dQypFui?=
 =?us-ascii?Q?FRWvPnOQip1h5qCJCk6Cu8WZ0wTV5iEDdsA6MJNv86CrCT6QGC9asgYeVttd?=
 =?us-ascii?Q?f5NS3mDwvrLDXP7eMsxpYItFWcEy+ckFw6ljrxwMGdCtlBt0r3cTOeSs73X1?=
 =?us-ascii?Q?/MlTzzjhwHS7yvZm2LGmvf4UMLiLemFAnQ5O2QYoMrsuqtqVnA2M1fn/4+/j?=
 =?us-ascii?Q?K+lgvNEbetsxbRtWB8wrh7/qP4tJNxPPWzckpiWu3oV/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff439420-10f5-4ed0-11d1-08db9ab90ceb
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:38.1153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0Mz5ZWPMAnxtMRm/I8/tYPYIEJQTsWQzz8NgclBdvrOimnTS9xmDFp4qiS3hCJkcBiCT9RN90Y8WqIRhmjcOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a fully enlightened TDX guest runs on Hyper-V, the UEFI firmware sets
the HW_REDUCED flag and consequently ttyS0 interrupts can't work. Fix the
issue by overriding x86_init.acpi.reduced_hw_early_init().

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 507df0f64ae18..b4214e37e9124 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -324,6 +324,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 }
 #endif
 
+/*
+ * When a fully enlightened TDX VM runs on Hyper-V, the firmware sets the
+ * HW_REDUCED flag: refer to acpi_tb_create_local_fadt(). Consequently ttyS0
+ * interrupts can't work because request_irq() -> ... -> irq_to_desc() returns
+ * NULL for ttyS0. This happens because mp_config_acpi_legacy_irqs() sees a
+ * nr_legacy_irqs() of 0, so it doesn't initialize the array 'mp_irqs[]', and
+ * later setup_IO_APIC_irqs() -> find_irq_entry() fails to find the legacy irqs
+ * from the array and hence doesn't create the necessary irq description info.
+ *
+ * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() here,
+ * except don't change 'legacy_pic', which keeps its default value
+ * 'default_legacy_pic'. This way, mp_config_acpi_legacy_irqs() sees a non-zero
+ * nr_legacy_irqs() and eventually serial console interrupts works properly.
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
@@ -442,6 +462,8 @@ static void __init ms_hyperv_init_platform(void)
 
 				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
 				ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+				x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 			}
 		}
 	}
-- 
2.25.1

