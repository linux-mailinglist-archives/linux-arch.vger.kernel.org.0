Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E10781FC9
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjHTUdJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjHTUdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:03 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB07A3;
        Sun, 20 Aug 2023 13:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FizFhm84Qk42Fd870XYqXNoZiN29RrGL2vDUEVGYAUvyWOmWbL6m3O5h8QgqQeNoXSHPBgDy1D7OwhtoXXhzcpDapG/QjU+lcXMUcYQBhk21qeRFJCpZtS+FiWI+VimCYdvunOCdD/aEKzmHvuzLIYNQHJXRSKP5lGnCw70wy6PIuPUyfaUNZ3Aj9RjVZA+KQ34b6v2HZNf2fOmU/53IxC5eE2dCAgEVodKqElxt8L66J0TIJWC1XRtDhPMg0KZ9/HWMTmIpj90HB9sLIjCItozAQ8pxF2A2m5rNYSOuG3QCygy9krbdi1j30qDWiH/6yzOC8RPsZT8mSL8Vv65qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGkuVw/CHk5JOvWqYgSQBOvi8J/WE5fmYVGLH1WsC9c=;
 b=HTT+snFD/NBKj/uOisih/Vph8sVJRYOgH9FO5nifL9PB3KDouxhsJFJ7pg+H9BC/Fct8iUJg9ghPaWLO0aVEsL9Q+5gqrhr/7L2WLMo1ZcMf5jzQOEg/6l9hVXHdbOJH4TnXffzRPdxGEbTc0nXrfBDnw3Oj+UUgnjKOaWBSYnONQslv3fiso4gFyKBPIcHR147JqDjHvTbxnMAwG3KAE8Nv0GE4lM0vDnJfODkWibwmYieemwC555bkis6mXbbQx6YTj3PfSortqIS2kRdJ/99FnTXX7/vYTx/GjJ6KYl98F1jXL4pM0ZnkkAKUWKsqllOcUUN4l03L+7tupOYVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGkuVw/CHk5JOvWqYgSQBOvi8J/WE5fmYVGLH1WsC9c=;
 b=aH97A9yb1UK5inJy+x2/SrRWYIXEQqyaYevfTQfAGBx2RynNn65DTyPn89sgDOktVdhtXUF5MhNlCWywoxp/J6RH14ch6JrM7PhZx8o164zjCvM5TzOr0WwVIjhoONHZMRKhMy1PjOo6xriUddJD3KaiSi71CAFajWpfISUe+28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:02 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:02 +0000
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
Subject: [PATCH v2 4/9] x86/hyperv: Fix serial console interrupts for fully enlightened TDX guests
Date:   Sun, 20 Aug 2023 13:27:10 -0700
Message-Id: <20230820202715.29006-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230820202715.29006-1-decui@microsoft.com>
References: <20230820202715.29006-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: 214028cc-59cd-4d1f-1677-08dba1bbf338
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7UqEjaK+QMYPj8XQNEcb3SfABe64HMNMNv2tJs2Nk4jh/tJwZ15ciBqt+yafnhMMvzdOKsZDi7rIcqKkHx6d2UYdH2jrd8KqIRQMBCFSWaDZvI7FxBqCb7YOHUvjg4ly5oeJ4e3vBroNvudKGnuSXcdyv0LOIoYP+bVWFg7cJ/uYdc7y4nxyYH9+9S322YQl2avT+cuVTCy3UFyeyTWFs2KsAoTP6IPSxBzS2r0Be0ZxrPE4tBLftm9tYir9487mFd7DebywZCOiIocYbPhPxpIocRsJ1U1kvkG4vyC23Fg8llyImLK6HLnXsDsVVVTNVTlUyrVl9clLiEDLy9AkrFrEk1xQYtlTLbB3S4ZPqcXFdf+UU2aX3UutOJlzA6fOmrr4DxX8/2z/F3lUujHImYxVsLfUaNSxRxb6jmKAW6QkXQ72KUT7tprzV8nVcWu/DChjVcHcBoF4Yzbte9efHZS37g4w4G+QBh2+qYRwaK+FbprPJiZKMcB6kAGG203snimNCRUNdgXA+hNinXf+0Fg2e81sRSNjmxyFvqAWj8gZRXxYcxrXg+YNIbOCbeOr6PAVcwXa+mta9hBDijtTmIelALMELQ8eY8nO6F3glr3RPvVFgRI7omKAsLUtvnPMlk/WAFsvMCoElIbEO8D75c/3fqIA7r7+8SzJfi4aN6pBen/NPdjvlwp93TGm2TL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQhVKw4gSS/BcCqJiuGAszfF3ZUJz9nKi0Y3iFaJnHKmgp8Dh84Ry0ZsEvLW?=
 =?us-ascii?Q?RkvE16IH2ghqxuGW0HX4XopWd+Z+Z2tVE2SnDcrtVrBrE9kSwbFrHFSmGS4l?=
 =?us-ascii?Q?/yddlKaZg0IhrRso4R1pYPHjqP8NFRDmnyYt/ZObta3OYqdp23wAyHHAQnR8?=
 =?us-ascii?Q?2E7bz/pgfQO8oo1EtYnj1d4REouJ48NEBeMG2TCPVQzlkY0ATSCbXWdw7uEc?=
 =?us-ascii?Q?8GAV0/P3K4HecsoWQvIdA3nTtFp79yzQwDCbvqOeeRNlqj5197fHNQIBlNex?=
 =?us-ascii?Q?jE4bezedJQJZHQXnIkgyJQisfnUnlCHFY6YxZ5gFUzny2a6c889MCIWSATTE?=
 =?us-ascii?Q?Vh8Kq1+zxqNK43TW7dLQoTa6aAdzagWNJi/DoMbaaBG3QoADlbe0yqBpspzH?=
 =?us-ascii?Q?gROOP9fLMvIcJwSH/fLfGN+005FU8sOCX1KxWqLpT/MYA3fQz3dYqghoX6jB?=
 =?us-ascii?Q?KI40N986HjhwEAqpAkd1q+BwtIeLqqtDuY+hTIfdRmiw7CnMpxyDV+38egQo?=
 =?us-ascii?Q?2hL6NntL/+oW5oUR0l1rV2Kzv3JJ1E2/eXFTg4WtqsQG2ikqWFKhd2L7eVdy?=
 =?us-ascii?Q?f054cM0zZ4UZcONuVLA3EjihpyV72zAMWY0N43Zw7Wq3aGHuEL8Lvo7PUfQU?=
 =?us-ascii?Q?akm8B4KTY3wmzhd0B8yMmaie1HeXiBptkzw12id93iqC7sjh3mmFUX9uHenM?=
 =?us-ascii?Q?k0O1ABlRM3GZ/G2/tFDRS08Bqfi9eTA6VPl3pCuUZOz3fGr+QZ/MYoRmCSOr?=
 =?us-ascii?Q?cOHhYa5No6TxwesiIMI4V83ndl/qFFKoWQ/9rfzIAJu1lNm36rpxxxyXOFWt?=
 =?us-ascii?Q?UJgBjwdHwLLrHhSgaxt5p8oJjMhJAl8r2XUyyT8LdWtEzmuISaJjMTZeL7+A?=
 =?us-ascii?Q?K2Jw1YSnyQsIyg+DG/bquH5jThnprOjdqJKi5xWuDiaZ9eRMImB+7hBelEwQ?=
 =?us-ascii?Q?0WTqmfgxhqITfCWNO7UGuib4OqokjjUL8O3cRAITOYO5hE1exlsFvO/2Qxzb?=
 =?us-ascii?Q?Vhr03PFK4KnXiKTWwzdt5yaNKkMEw4E3Nea8LufT0p7WIICkUeHs8XxRqewc?=
 =?us-ascii?Q?9AAHISgBemurhhtz5U6X4iQSeOVUeCqvWNWXGB/6FKVN/gv3cj5ldaeuebRu?=
 =?us-ascii?Q?HTrDBE1KgQM0Wc6vTAtNxT+Cc4RlEfYGRNwZN7S96ctaD6UiF5oLMPlCxOF0?=
 =?us-ascii?Q?BiduW+ZNrGREOuyXq1DOtK5Bmq/H7KEFTePZ7/i+GmTDceqvC+9EwTb/ofgo?=
 =?us-ascii?Q?Yw5a8UB/QXrIYePImSalyOf4cW73DsiBdSQxFPMsgwqkWokWrMq+Di7IRuta?=
 =?us-ascii?Q?CnOgs6iogs+6TcQYkpUGkyHMhYX+0wqMeBWE/LiWdi6YAZkZlKfcw4Vlduh2?=
 =?us-ascii?Q?wxj+x8/kBZfB7H3G8jtIDF9SJ6+aL84ybchuyBtkNDPbnQYQHmPt7UuAFH1F?=
 =?us-ascii?Q?wWNiUr6D7N8zFSdZipFYKmFVB6GGOAzqs4+o4bRJXc3Iib4EzBW8vmJMOs1B?=
 =?us-ascii?Q?ihbvX2nV5pmQIO/0NhEcDeZbjAs0h45uIAGTBjsozlwU/URwem5sQOapQT8T?=
 =?us-ascii?Q?DaZFQ1Ma7kCQIK/G9n3naMdDB8wBcidoq/sqIoj2K9JXS8WDE7xp9siTtmUO?=
 =?us-ascii?Q?WRg3L/iCBAbQVHWd/Y+PtW1EAQYo4oS/p23OK+h3ILq8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214028cc-59cd-4d1f-1677-08dba1bbf338
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:01.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gn33Wp+GWIBPGa9PFFnMzlRg/bYnlPXbYqV3WrNDuQQHA7jKrHPWu94CTBoe7XQAqgy2Wmb4nHvVGHGcJmmTYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2: None

 arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 2282f91716100..14baa288b1935 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -323,6 +323,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
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
@@ -441,6 +461,8 @@ static void __init ms_hyperv_init_platform(void)
 
 				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
 				ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+				x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
 			}
 		}
 	}
-- 
2.25.1

