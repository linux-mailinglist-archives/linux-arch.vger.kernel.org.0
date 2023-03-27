Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589A46CA569
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 15:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjC0NR1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 09:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjC0NRW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 09:17:22 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C61723;
        Mon, 27 Mar 2023 06:17:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbM1D/zetlQ6RNFDMqa/LrvX6DmkEpOAMlVA86TaRlRFwjFH6Vd7TZvZx0jSa4IX9UZ7RRuTAyNGU4nKBZr3jgfrxgrjuVyEcq4w4POpwlwTG05dg6woRj8YKuvoz4IdGK6CrS7N7Z7jj+kO/r1egiH1uZMqh4tk7KjHA1aQB93sdb0NRWCP0hieW55JVIenkJjUFBSgyeNiHImjRAgc2QrRDoKo9yVkibKITlgew+yXlL8WyOkBNTd7223B9Hbr124pnSsvPtjQ3+hGjZOkVjdfwITY0reD7zBD7GH/+Wdl0S+G+tRqJ2RPAMFwHcekj72dd51oQHaeOSGFapqyTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wivdlfXRZHaFecrxciooBcchDqO+eaAuuDzZW4Ha+w=;
 b=XHJqwkGEWHmNnoGIomgbKX9KUR/bQoUWm0F0MBCBoQsRstEXXsQ6cJSP5MI/r0H/zugDlrk3lLHwf9zQk3Yt/BBO35QcOsjovxJWfZu4iJlpZMJjjJ/a5i9yPk7nDbNXLfdBRRMXCGV3Af4+809gSdj//VmGZdofoS8PajXZIguTplMG2K9JjBSS/MBmdoM31TvIl6HVus1nwdeaFBBd0w2laVGEyHHAkPvr0wTsc6vt8eIC618UIjeFz47P35XgoJD3k4diFK2gDAEPgwOYJAlwsNP9jTjJ32+SrMOeOV6vUXjgbSughsbm9vrYyDAF+/5USvQDJ+qxJxBhYf/PUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wivdlfXRZHaFecrxciooBcchDqO+eaAuuDzZW4Ha+w=;
 b=ESmlUFjbxjsQhHnOrPPphPK17SYI7i7EOAL2hPILRT44TqJ6r7N9KZLGvJKnMxm6nGrwBSUoPiIhhkBsz7492boSNPSEaZepse116CR/EUsjwSduoNzXjfiQsj0AXs+C1regiwIVTK3X0cho+9EsGHhj+kkBA+xiMPXQZiiie3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA3PR21MB3960.namprd21.prod.outlook.com (2603:10b6:806:2fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.11; Mon, 27 Mar
 2023 13:17:18 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6254.016; Mon, 27 Mar 2023
 13:17:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 2/2] x86/hyperv: Exclude lazy TLB mode CPUs from enlightened TLB flushes
Date:   Mon, 27 Mar 2023 06:16:07 -0700
Message-Id: <1679922967-26582-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679922967-26582-1-git-send-email-mikelley@microsoft.com>
References: <1679922967-26582-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SA3PR21MB3960:EE_
X-MS-Office365-Filtering-Correlation-Id: d2cec5f0-a4d9-44d8-7991-08db2ec595b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ch/bgHkZ1Ldh+zQrGBC+7iSfguH/lTpTupfkUuFYIhEdhbg84oVqqi23NftCs35ODo5X8kSeoAeuw38nUvUQ9VhMyu/Uc8UqUGUFFLrqNoARoKLYS/RSuL063ZRa/IP/UwesLltT11r4SX9g8+39sc03uc/1Ok3Bm21eRJg800WJPEHAljLK71vznkfErgap46IO7IiuoXNEK99Dsg/8a8gA7e+DvhkvLVUS3Ct450UxsJANeKTnZiVGaIAABZSUYdiRGXCqfexl73u30/+E3Qo48v1QfseIqgA+mKnp7I8kIfk9lyae1VMkBdvveJB2TG1ghQj23BeniiPl7Ap+oUBczwqcC02pN2JW2vBA+WRUB8bVwdruqCdxfi82BOh3oRb8Gf5Ltv6mdLli7LZfoAOY1ohNBq/heEUY47t4mKlDxt9DmyRc0cLI8CniGlHZwPaEatIp8188QVYrHXNFvGEl5KQv4uG9a5a/rEcoyHIvFyrXThbdEy3k5sNrMvypUrNOQ7qtvG2Ln61083/s7t2NdTfqJTUqX18ZmgtCyqevmC3mcLJe8ZVEKlzSbUURJ/njYGmt0Sfb08nlkQAaqXc6V93WOX6ad34BZu4ytf4YFsFFu/qfZUzeB25z0oJlE6JOEeNbln/LlEouVJNuy9GWaAaYNi2PYFc9V0AB97RazsKpNT4rWj7wQWICy+L5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(41300700001)(4326008)(82950400001)(26005)(2616005)(921005)(6506007)(6486002)(82960400001)(8936002)(86362001)(66946007)(66556008)(5660300002)(66476007)(8676002)(6512007)(10290500003)(83380400001)(2906002)(38100700002)(38350700002)(107886003)(7416002)(36756003)(6666004)(316002)(52116002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YP9169tbuVsR/+nA9t9DPTwJhb7Trm/bj29oeeH4tok7O9a4UIJY01ponSNY?=
 =?us-ascii?Q?J/8QfjTGi7pX8fwgpORhnGEtBFMZi+DeOSAiYuNlU3bXV629HKfmYCKk3agm?=
 =?us-ascii?Q?3eO8Ia2xF6mcLqjOH0q/PtcYbNTpduOdDQzj0cUzIOz0XBwtfEaHWiiqe8cZ?=
 =?us-ascii?Q?qqaFtYO2uoX60G/+gziF19zDq95xdI4+9ZGFmy2cu7MUOerMJjf+3/gJVbNX?=
 =?us-ascii?Q?LT4PzVSpcCYieEJsohJa0IXyOhS7EwHjsOuFXqkj3PZJO1eTZdaAL7v/0V4s?=
 =?us-ascii?Q?J4m2BMJ8mpLRN2GgR04TqYzc68nmHuY2+xLthbPHjdULUO2sgTENi/cFebSA?=
 =?us-ascii?Q?M51vJFdZMnvG957h90VVWVKhmPXPHe6mNvziTuMvcgUJ81o98N9ulg1UMl1j?=
 =?us-ascii?Q?SqSdD3Ffx0wYGsmo6dYK5FEiMMmUBhME9jxt2loxgSlm33ijPgbHQu7Ot5Sm?=
 =?us-ascii?Q?ISrcOp3a1h7UW89XY57+KnExHn0lUnlun19/IY3YYOSuFiqhCTia0bEUVuCl?=
 =?us-ascii?Q?4ZdctoE9O/Lh8Ys/FIsesvWyhd3FsJkkL93H/xz3nhNevYo4iu4B4MfYaNz0?=
 =?us-ascii?Q?LhCzPSHexNw8UoYwlxFNnEgv3h/PoOaaf/CoWHK+IvPEYVi6t3TqfQFx21lH?=
 =?us-ascii?Q?wh+EsP77ThGNVE75O5hNp95yA4CbC3ebZcDMM38H6xxg7HC5wlZjs0BuZmqP?=
 =?us-ascii?Q?mqFPAKJZOpauSHGji4mWVDnaUBcmPMN2IkA1RnWZt5dy/iS6yNV8Vzev5bkQ?=
 =?us-ascii?Q?lm5hpHkoVKsosBtT3ABAcbH1Pomt2clsyRUnrSzR8ERuEBW7eN3y2EFd9CzN?=
 =?us-ascii?Q?fmHi0z1xp2buNMC9rDGl8fhYK9ekHI74uH42pVfe9wqPqSa/AGK30697GxAx?=
 =?us-ascii?Q?DfCmplm1nvnvCAV9MpWGwhP5uPVRCSYrM/vq8BD6qDEahA+2h2D9KhNalIKy?=
 =?us-ascii?Q?C2jtt/AALZvgwhpoheHuMZ7A6QTaVz0Hhv8CX7AlQXRBDskL+K/SCHc2dXRw?=
 =?us-ascii?Q?PBhx+RfNMlJLqm7qM05sRBsxPSjkGf+hMw8E/zlSbVAAk9fTtvWvb6cBDzw0?=
 =?us-ascii?Q?49Uu+DIj1O6i7D0f/iobURqb+BbbVE8Ipt55lQU1/g9ZVrxv7ZUDn3Wtj1Rd?=
 =?us-ascii?Q?JPMg8fmRfuvvJ+kQ6k8S1wUxoK22PaMWaWMFFbQyiq/fzGmXvOSdJy6WroBO?=
 =?us-ascii?Q?4rhnB96Ah7gxQ7QkNGoINRojilrTf/zA8SfEJ6KSqFipwr7DmVNgxhMsKnJE?=
 =?us-ascii?Q?m208pXF1JkuWJZUZOa0WI3LTMhsRPBsE7hfHkt0gbmXdx7uBjGFtYGprDW+b?=
 =?us-ascii?Q?GT+0zUggKHR/wiuQMJoyCyVfQr4OMiFlCbU/4tHyOQwIMgeIvY3PU4xkUAfY?=
 =?us-ascii?Q?M4RCi9Dse1bzTqseMyL/CfnCCm81Xy0z+DWnvvdd10BwIVVi4sTyLMhCIjSS?=
 =?us-ascii?Q?A4fzngC3vVvSAAHaNrIV8StoU6+ekF/850sbYsRPC3yPCndZdP4ufM29jst6?=
 =?us-ascii?Q?MOiYkmIqVaerg1xLBBKa5xBwWB2dBMEXVEJJKvYM+OMzvNwK+bxatADc3vgt?=
 =?us-ascii?Q?/0B9gpNmMMjc+uSre/B+VzK/A9yy3s/Vkqn8N+xH?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2cec5f0-a4d9-44d8-7991-08db2ec595b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:17:15.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7m6soiOALhqtLTR8otuiWmCLOlfQZHJ0UG6KBTG07trWupd66+LCuhW6AHMGPKmGrG4FXx/2vPieD9OLfXykQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3960
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the case where page tables are not freed, native_flush_tlb_multi()
does not do a remote TLB flush on CPUs in lazy TLB mode because the
CPU will flush itself at the next context switch. By comparison, the
Hyper-V enlightened TLB flush does not exclude CPUs in lazy TLB mode
and so performs unnecessary flushes.

If we're not freeing page tables, add logic to test for lazy TLB
mode when adding CPUs to the input argument to the Hyper-V TLB
flush hypercall. Exclude lazy TLB mode CPUs so the behavior
matches native_flush_tlb_multi() and the unnecessary flushes are
avoided. Handle both the <=64 vCPU case and the _ex case for >64
vCPUs.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 0ad2378..8460bd3 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -52,6 +52,11 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
+static bool cpu_is_lazy(int cpu)
+{
+	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+}
+
 static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 				   const struct flush_tlb_info *info)
 {
@@ -60,6 +65,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	struct hv_tlb_flush *flush;
 	u64 status;
 	unsigned long flags;
+	bool do_lazy = !info->freed_tables;
 
 	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
 
@@ -112,6 +118,8 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 			goto do_ex_hypercall;
 
 		for_each_cpu(cpu, cpus) {
+			if (do_lazy && cpu_is_lazy(cpu))
+				continue;
 			vcpu = hv_cpu_number_to_vp_number(cpu);
 			if (vcpu == VP_INVAL) {
 				local_irq_restore(flags);
@@ -198,7 +206,8 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-	nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
+	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
+			info->freed_tables ? NULL : cpu_is_lazy);
 	if (nr_bank < 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
-- 
1.8.3.1

