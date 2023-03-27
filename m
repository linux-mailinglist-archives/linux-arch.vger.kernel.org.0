Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541606CA564
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjC0NRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjC0NRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 09:17:21 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAF1FCA;
        Mon, 27 Mar 2023 06:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfgGCupc5PovLn2RYW2YcHW3yzMSNHvcd/4P3A1fY8EK5qdqcIF6ZypEuzryYWLWXagqo3eRvBfjCTYuUhoUc3RKk0CHix840JsyDaBxZdJteIzaK0n6tWLkNiwQWjezTHAznBYLCs3A0Tw+TwrWCMmHF5tI6lsHkoE88NkbuWqvWu2lSqbz5NEyggqAB1YKVc+sbfaTYCQYXf2ie5BfL/u8sNdixzfS/U3YYrVScQ4s+d6tp3Vvn1PtlQV+utd221WOSB55OMQFGx/apF9rYJGbkHnA9mQ80198tExs4Pvb+pa67j7d1LB4H+ep65LbVil+PGQYDuoLj84oL91gRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xupBTUcaU1e7hATDzHTPvE57L+mAHynBW8Havvc1O0=;
 b=k7S/MAQhf3l0l+adjPFFa3IttiaxEWCnrTCQJ468bBWwJR8mTzTqzvW6Wgtk12rtEdQwsTCWq8T/nILcT+y0CatLuU6AVQ75M88zyr5T+LSfd5+cenN4/xdvc2LT9FmMM9xoLDlscrk4KJDkTO0MWBYahWUFhMwJNpd1eI7D4suYUQ6DsBXOifhQ4RkqMV36Z1lPpQikNBSRDfTypO2IUEetcMs6C4AxumiIjiDeBpYn30YffNEMZ7pTCfeU9jmhoUoFQgCVr704Urx3Q8nEYCZeLK9Pw/4+qg6kSkpsalupwOyvTV4WZllQIHbtr6H8QmQBIhf+TKDCyf4y8kLy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xupBTUcaU1e7hATDzHTPvE57L+mAHynBW8Havvc1O0=;
 b=cHJvZ5irLlcOspcEp0whHCBt5WacwOM3kTBsM4vi/swaubrmlcpEkVFZSmcknqdgJKzHuK/m3+xsmvgVt59R0GcJYPIJRiQN9uZ+I1IvQ06VhVYyRbLwpHxDQkLx8Ym9bfPcnVwwz8a1iBWmtKtrloJt1OlFONvzsb/U2GPiqa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SA3PR21MB3960.namprd21.prod.outlook.com (2603:10b6:806:2fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.11; Mon, 27 Mar
 2023 13:17:17 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%3]) with mapi id 15.20.6254.016; Mon, 27 Mar 2023
 13:17:17 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/2] x86/hyperv: Add callback filter to cpumask_to_vpset()
Date:   Mon, 27 Mar 2023 06:16:06 -0700
Message-Id: <1679922967-26582-2-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb85640f-7a8e-4097-00ce-08db2ec59526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPZC4lPpQ5Pl5OzZbklPak16ddFUuWkyh1as54uTMLrFos/se9cyf7GPnQZTdIaLAuGMTJ3lWbLkixJHTa8QcFbcVPCeNOLyfD3Tdn/2axZ82OTMuKcDCOIW7Kp+c9wBH3XE0R7Zb3D+Tc8TsnBRmTNiDZji3vU2oXxzjT5jAqfggqO++Dhv5DaKRigDcBOj1DMLlyJJvQsX6A1lBMkKqB452i/79Ek243Ws6QzMiO82hu6kXbrMqzU32oYpLqoegwuXK9Uc8rNEKFRG8oj15QsKwcX+fKQ0NZYktx/6QdkbnC9kl+ewzhktORORBlojhfylNTbLOl+qnLPyWdzFzeMvS6THBYfLhxaazRdGj5IdGsDfbkFfhNsDbGDFcw/vuKxScTGdHk2AmsQQ6nf+wtIAWxTMsuimf66sGH9w/THkWhaFg7ET7D5kwQw8c7n7wZxPb1z+bCf+Ri6C6PWAm9Z13bICTpjXrtN1hKWuFr19Rt/nVy0XjkbHkJK5/rj7U3JCwqbm/qsQl/y3MgXz9bG3fl7+DxKCZcsdMmCh0z7XsCY81N1BxZCeG0bmg5urJLEythhHBrjwNumeoxXBuR0QK2O1/lNKqFIm61/+t7lCjpsWyAS+Mshdc/sPu6mFcToLp8ImX0C7va8UzoP1B2PPuyFONWOztJISwB26oFOeJPnP0PGIsbDlXqGTkXDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(41300700001)(4326008)(82950400001)(26005)(2616005)(921005)(6506007)(6486002)(82960400001)(8936002)(86362001)(66946007)(66556008)(5660300002)(66476007)(8676002)(6512007)(10290500003)(83380400001)(2906002)(38100700002)(38350700002)(107886003)(7416002)(36756003)(6666004)(316002)(52116002)(186003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIMo6sNFm5AjsTMW9ASboPlZCOdEqXrNLUAPgYX86gCYsXbVpCJIn0wEwVvu?=
 =?us-ascii?Q?tCwLSW2xa8olbT7EegqZXNhGnGHo7P32BtZASGZZ4qnBgJmdE1bpgjs+jWGA?=
 =?us-ascii?Q?Nx5VC0RgGhmpH8i7HdqDjIF04hKR/zeb85lJSMcLurbWGUw6r4MrfNZ4g4Iq?=
 =?us-ascii?Q?v5l5k6P4Gth3IUIBzRqQMg2e+znvg0L6CFhR4VJJNK751TqtbzFboyTFkw6u?=
 =?us-ascii?Q?fLCL47oSIcwE4lnQz2rVsokCnVSf0rEbxh9O4mjRcRAquqfU2sm40nnJKCDZ?=
 =?us-ascii?Q?JKmRPkK8ejoRhNqNsTUvYhjkjauzEpPRsHILZZsNHF4XYOBztrPyCWz3Qa76?=
 =?us-ascii?Q?by789PebGv251Mlr5MR5a5mGQVqW5mE1fACM5zb/qEKBa7VvCY8z+/9EClw0?=
 =?us-ascii?Q?Hgc3z9WvNzvAExap+eKAgk+qMuZLn3A4qHSUzFMF0hNTCdTRymNFZprRJuV/?=
 =?us-ascii?Q?dhEHHG31XvzLIMblIUrT4O4l3WvGyE8QnGY9iQmWOgzQTy4eDPyVJ9fw8gUk?=
 =?us-ascii?Q?NmvQ/34H4pats2Dwlrd7ASwTCSIaOEa7NB6Ak9NJs6+OAz2gsbcSqJGJpaPo?=
 =?us-ascii?Q?ajbjmygy+6npGAAyurqfWNybJAgIsNsr7lr5g2uRZfe04eOoW87ouyu5iQov?=
 =?us-ascii?Q?DiHZhTBP2IfMNalIUrtMY0ABHjxy7r8FqpYygH0x74y2LpDQUFs/V8jsF8Ui?=
 =?us-ascii?Q?w0DYiF6M0tUxW9bh18obHl12Z/g732nm8RqQ2GimtPTtINsj0MJLVp11Xk0X?=
 =?us-ascii?Q?YgIXyf5Rt2LjSVyvurBVpbq+oSno6phMiJmGFZXYwyudAiWBqZmS98L7xvz6?=
 =?us-ascii?Q?4AQKzt+SwNRgTNVx88U8dywdNC6G0JDsvbHMHvEmYlgXPvlpPYzWDl4r6aMB?=
 =?us-ascii?Q?6mchC7aBkrHe2POqW7dPSiZy5nSrQ5E5UFi9S7zQPQ1B+PrMX7G8jrPkPbGS?=
 =?us-ascii?Q?A3XGH31f9EIbdDWgMX37kfyhrVWHixZKN92u4gRsic8MakdaVnRCQVQeJR3S?=
 =?us-ascii?Q?xKh149IxE//2PV6aMHJv+s+65mq2pW8wuzFEnFeB/IngKHoJ6dWoTuiRAtDR?=
 =?us-ascii?Q?2aq0VLBacwjCwhxwuaQkcRXm6nr7ezbLJlnRSFAmFaorln01LP6s6/mQzR45?=
 =?us-ascii?Q?tfidpQiZDJZoO+Dykv7FXa7V8ziTmuPKvHdBa1tHdq1UjQRExt4poBqVPHN+?=
 =?us-ascii?Q?6p+I2+8gWIadrjQyX+KVC8ghatDEJj0TEFjJEjO6SznwrtBtW9F+9fMDQaEg?=
 =?us-ascii?Q?9nn8OmHAeeyetiWHMx5oDdNxGqZSVxOCColVQvXMKhZsZcvQPbkIgNTvtU+l?=
 =?us-ascii?Q?CcZWVK0BHXI/Q/naplY7YNyv8i5hhR4IVZQ6oCDsUNfWgg0RlqsoWXEkYyTf?=
 =?us-ascii?Q?XqMGF0IVBu/HzhZBBFKonlYcWBsaD1DhEcRtN5D9Pm4O7Q/NHRJlcT7kdrls?=
 =?us-ascii?Q?2SYxTvyu2zsXpwa98zSOyuE591z+bClTx3UEtuX3L7UCYkNdBZozx1r/d7nJ?=
 =?us-ascii?Q?n0/nB0qtvvQyXQEwIKI1p/hTCxkdCV0iGAwT8MBqmb57M82qk+WtDMJCRLTM?=
 =?us-ascii?Q?U4Wm1KyVIjsYkHRhCRPc80ZpnnS1Ize2IVpQaMWQ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb85640f-7a8e-4097-00ce-08db2ec59526
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 13:17:15.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6XvrxwwC//OWbZW2DM5ALv6ehlXFj6Cy4AFlJx4jjyTYE+hhU1U4XVX4sF9aDW/eVEyfX0lR46Aiaf+p+Hv0Q==
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

When copying CPUs from a Linux cpumask to a Hyper-V VPset,
cpumask_to_vpset() currently has a "_noself" variant that doesn't copy
the current CPU to the VPset. Generalize this variant by replacing it
with a "_skip" variant having a callback function that is invoked for
each CPU to decide if that CPU should be copied. Update the one caller
of cpumask_to_vpset_noself() to use the new "_skip" variant instead.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_apic.c      | 12 ++++++++----
 include/asm-generic/mshyperv.h | 22 ++++++++++++++--------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fb8b2c0..1fbda2f 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -96,6 +96,11 @@ static void hv_apic_eoi_write(u32 reg, u32 val)
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
+static bool cpu_is_self(int cpu)
+{
+	return cpu == smp_processor_id();
+}
+
 /*
  * IPI implementation on Hyper-V.
  */
@@ -128,10 +133,9 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	 */
 	if (!cpumask_equal(mask, cpu_present_mask) || exclude_self) {
 		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-		if (exclude_self)
-			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
-		else
-			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+
+		nr_bank = cpumask_to_vpset_skip(&(ipi_arg->vp_set), mask,
+				exclude_self ? cpu_is_self : NULL);
 
 		/*
 		 * 'nr_bank <= 0' means some CPUs in cpumask can't be
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index afcd9ae..402a8c1 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -210,10 +210,9 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 
 static inline int __cpumask_to_vpset(struct hv_vpset *vpset,
 				    const struct cpumask *cpus,
-				    bool exclude_self)
+				    bool (*func)(int cpu))
 {
 	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
-	int this_cpu = smp_processor_id();
 	int max_vcpu_bank = hv_max_vp_index / HV_VCPUS_PER_SPARSE_BANK;
 
 	/* vpset.valid_bank_mask can represent up to HV_MAX_SPARSE_VCPU_BANKS banks */
@@ -232,7 +231,7 @@ static inline int __cpumask_to_vpset(struct hv_vpset *vpset,
 	 * Some banks may end up being empty but this is acceptable.
 	 */
 	for_each_cpu(cpu, cpus) {
-		if (exclude_self && cpu == this_cpu)
+		if (func && func(cpu))
 			continue;
 		vcpu = hv_cpu_number_to_vp_number(cpu);
 		if (vcpu == VP_INVAL)
@@ -248,17 +247,24 @@ static inline int __cpumask_to_vpset(struct hv_vpset *vpset,
 	return nr_bank;
 }
 
+/*
+ * Convert a Linux cpumask into a Hyper-V VPset. In the _skip variant,
+ * 'func' is called for each CPU present in cpumask.  If 'func' returns
+ * true, that CPU is skipped -- i.e., that CPU from cpumask is *not*
+ * added to the Hyper-V VPset. If 'func' is NULL, no CPUs are
+ * skipped.
+ */
 static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 				    const struct cpumask *cpus)
 {
-	return __cpumask_to_vpset(vpset, cpus, false);
+	return __cpumask_to_vpset(vpset, cpus, NULL);
 }
 
-static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
-				    const struct cpumask *cpus)
+static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
+				    const struct cpumask *cpus,
+				    bool (*func)(int cpu))
 {
-	WARN_ON_ONCE(preemptible());
-	return __cpumask_to_vpset(vpset, cpus, true);
+	return __cpumask_to_vpset(vpset, cpus, func);
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
-- 
1.8.3.1

