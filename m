Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8512A6F7980
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEDWzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEDWzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:55:01 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355C11D80;
        Thu,  4 May 2023 15:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUUxYgSPOQ6gBHLL8mrJLyODeI7hSxL0NvZPTOmEM2EId0T9J83XNDhoYGhzK5kKKgZfmKrjQHLKv8xSPDDGgvGgdA3sZdmex2qmN2bOdGOvF9/Sseyzns0Fl5XBMhZmZx7lS+kEsHOKhVFLQMaiurJssgo6FHyHphj5iaGcKHlYw38j4dA3cDvUa+I6aZsgKYp1hcIYr8KS7HfQRxpSSS0gPaJMIiGT2+aSsqar05uaZZ1XGFYv7ey20rQ1aoseNPSNZNSeQqYiiSSvm7W9ZMluHXH5uf50jypQ5Gc9O3MoO259gw3HOTzzI89hLvVJzUxZhZyj5DTQTmpD0k3oiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYTwF3ysij5dBJdPszhBGN2we1FO+93mfEPlBFvWdXg=;
 b=j49jUn4pitL4m+98pEvK+Zw5nkDqqzbIea5n2JVe2eEUKz67w5wev2uJTJL1urPRpjReI+0FZ0VoOgjLmrRjdsr+XD9dCPe/LLWLi43gj+/xdBN7we/fMe78MiI6ZMWulzCI/rmMyO3p2jrYjX2p3he0uuqjVP+Q+1K1Fvgn8CohY0zgFCMz3PJmJusViIT6dGzPTOgRMr1l3cxGv1diUJCvF7S1sfJ/NeCW4j+86e5zAKjPoI8EV+dN2y5yVVGbPJs1bGiouUBklx23va9uLBywSqJ7+LvPsSyVgMnKPBrlzsy250IqStDf5tiMMt5z71IMxZReWXHse9Dzlz+dtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYTwF3ysij5dBJdPszhBGN2we1FO+93mfEPlBFvWdXg=;
 b=FD9Ib+U/RzqjOSs2BhuEybcJYIS4bBEzCXb+YwudwGW4LtbBFjCCOx9eYfyelEso5ihdijcwrgLFHIUK8QXnmLHhU7l6XoKBFteXo6sboL7lv2wpaNqu1fyMxOvgM8tZDbDco6H34vmEEjREuiBtCsxtlzQT4roj/aZi/D0VYY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:58 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:58 +0000
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
Subject: [PATCH v6 6/6] x86/hyperv: Fix serial console interrupts for TDX guests
Date:   Thu,  4 May 2023 15:53:51 -0700
Message-Id: <20230504225351.10765-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230504225351.10765-1-decui@microsoft.com>
References: <20230504225351.10765-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:930:d2::10) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|SA0PR21MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: f3293166-61be-40d2-a6a8-08db4cf2958a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAJcCdgylsL89XcP7cmTJO4YkNXdz854a1jID+JQKeWnrUXcMpxvENQp+L5z2c8IXesWtdQMJLEsT2tZBVT2n6IyPx5sDFsA9/JRE81zXRVjBFRYIwExMYRn9r19+0OvHbKxQ/HyuL9ovaJRDG2eOUCvwTiiM326kAaTAzXM9UwLKHMQ/GFgItf1NB9WYjGHjO72gSxY0rtXy+nTeWW1fx/d07Gsl1BukFSylp0uog10oq3LU8UqUXJW0Nuq2ry9lu/56W8C1JjKzXRMuYmAErdXGVcIPLZRmQ/rNzHTDabDOKQcdoMAUMLfq1Maig9XJ21UczAQ1qmZ3ptIAC6h0zILbFGUF4zL3TU+ABfFTxQclwmcau0WwwPJjt1g0z19+z/Dj8h7NpfiU/Lg/2JFU/JjuzyoNJZrnexA6mJl1x2gADzqQRqSELugdwMUYypAtQhVwVu0sCHirRfivbQHKJbufzp8DGjHfeijwyaiToA50vqhr6R9BF/rBaCdaRbgbrhiyQSXWFmFCyD6AbXMwEHEcPc5I8XEqBUvF58MuY1y+2eNiQGIuRtrFUFHH0yaEI0G8naiTNoAq/SRJkXVrLFN7z31bF1cNxYKBndmRaBnf+/lBQtvc3OYSj1JXUl/Krk1lgdyU85qXZcQYZ7y6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1WKmsivE/J79iGEW1IXzXaH607YVDPCGnOTRrrMDCjsiW8SJz1oF+u/y2cHV?=
 =?us-ascii?Q?icQ8ngiJTLIDnIrK/qQDdF53TiG2HQ66OJwGQzbTkYWlIPSRqQO2FmXx8HYX?=
 =?us-ascii?Q?3dUMeo5f+FPZg+kccn/kwrgrn6MFnwHEfuWJ5RkQA9+riPcgt9o5Il2pJmZJ?=
 =?us-ascii?Q?sVqHZJCjTrE4cOy1GsrGha+KUr9VAmoTxTk6tUtmcyZTl9XxeLQnQFKu4lY+?=
 =?us-ascii?Q?vczIMCfh2nR+cgLxcQe+jNUkEPShqeCTCtpwZAnST0rzmEr+E9xICKIgl7J4?=
 =?us-ascii?Q?c6R2rISnFpzioAn7meaOKoOv2izU/BZJqXdmEd20KaDCClUCxkcPbTI0mSyJ?=
 =?us-ascii?Q?6yP4LBHUWyJtS7+985BsW9qviwnWx73SQ0dim7qU692z4Ajvs3yKugjiCy+e?=
 =?us-ascii?Q?SsRWlkXOaSGl2tKZXPKaNei6wd36YXJsByqc5awQmRb9saWwh3hijsjqXUwL?=
 =?us-ascii?Q?1e3fEzw0UCbkIrsrgEpgAnDJsIXHhhPt73yDdjlAtrRxM/1qaTyw/etBt7vH?=
 =?us-ascii?Q?WjGEeP6m2sI5XoH1WLYGkJtg4xDSe2uy8a4+jHxFbtZ6zCqUDT8WquiVZpnd?=
 =?us-ascii?Q?ZUiNEg3mZCkk0oJrWY9OCtg3rdxHUleidA20Oxt0vHuEQ55aH3w+Q5Tuk8Em?=
 =?us-ascii?Q?ZyUYPKnyqz7mxpSLtcKHneA31KYe1JjYLHu5kdiSVCD4Ffhs7XUyp5FuYLHw?=
 =?us-ascii?Q?zrDuIIGIyp+ji+5HcS4OUg+/VJojByjFGmSzAen0DGW8QSo4Tc289qbp7t9v?=
 =?us-ascii?Q?PkoJ5QjM020VZgq7WK25DQpew2SzkWUmhAkt+HLRHOX9guodKbqfwfqt5iGC?=
 =?us-ascii?Q?85WO2+DMWQtx1zsin6Mwp4UfE25nJZz1dVpihg1shCZmmca1Ppr6hXYuRGer?=
 =?us-ascii?Q?l4bgheDfVzrVBzumw3Lshlq2UwpRBjDXwR6D6KbXpW07ZmwUz8UP7nlNPqK2?=
 =?us-ascii?Q?M2EJ0TGl8FyLeXk2f0fAs36Tu08ttn70A4YClzENBi0/KEt1Cp2irPwEmOAO?=
 =?us-ascii?Q?88/X9rvS8dZD54g/MW4X0G9OWYhhpHsmHRnFFiobJD4mPY/pwgdGSx4KTWVd?=
 =?us-ascii?Q?kj97443wGWvOzBeZP8OdZ37tqdvBy1GEhUftXSeGIQsuHSvXk3LrV/1eA6ho?=
 =?us-ascii?Q?GTjWHHAVpl4mX8SrXVocG6Xt1W7A4Fz36TaKNGekaGMuM0dgH/5rOkya32Oi?=
 =?us-ascii?Q?gvaCFvhUGbiEIeYQJM4ONeqNcXKHkVLqe1zJIICbxmXXdEUDYhtbpBqYJhGK?=
 =?us-ascii?Q?Gs1ydV5qC6dQkJKs5EQMX0v6D7v36+AwQVPWdxhHfVvN3B24h7X25jITUKeI?=
 =?us-ascii?Q?4WQayFxNiq95+29i4PUxSaibDk9KhA+5joqks6lGtuRw+kRGMVSPu8qKf2zh?=
 =?us-ascii?Q?Xwy3RtUIv9OHCu13b/g4aX+JlXHUP6VDNCSg0Yh0Rq7Ezr/lvgff7r1Q4HAz?=
 =?us-ascii?Q?4uwVCNfpTZf8XcHcGvVxIzD1Psq8wmCgihxLs5S9k2BAI3bsUtaSU3ILkoyr?=
 =?us-ascii?Q?lOvPYoj6P2rxHl0qGYyxB6aN7M7N0UNVaWmfagJuvQoxmMEpy1WUCbcFWqSY?=
 =?us-ascii?Q?BHVwiixGpZ0kWm61ZEtXrkKRZrmHRSMgKAdKPZg46JxnHJvvwhMBdADMhk5s?=
 =?us-ascii?Q?cF0ogG67zlu69XOnvfkICQh9IqMRMoxCaSlnrhI1CTVY?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3293166-61be-40d2-a6a8-08db4cf2958a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:57.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjgrHM01i2VG3p6XPKEonYXleZiyTcLmld6iJSE1Kq/YpKlSMMJ5CByQe/+ODOplZAA7paata2Fv7CN2UuG46Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
    None.

Changes in v5:
    Improved the comment [Michael Kelley]
    Added Michael's Reviewed-by.

Changes in v6: None.

 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b95b689efa07..d642e3624286 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -313,6 +313,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -424,6 +444,8 @@ static void __init ms_hyperv_init_platform(void)
 
 			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+
+			x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 		}
 	}
 
-- 
2.25.1

