Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E171B731D12
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344105AbjFOPuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jun 2023 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbjFOPtv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2023 11:49:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E32972;
        Thu, 15 Jun 2023 08:49:41 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FFHO81017919;
        Thu, 15 Jun 2023 15:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tx1at/2INEcqt7dGBW4108Z+7Xae9URY05LzYSvNwCU=;
 b=oV/JlHE0Hs1WYsHdl2ib3VJ6CIyJOPBgKPuxthz4h5/toJIJLxz3vbuqTHCboTCoHkFN
 L4KlEZV2hTM+svmKCgeY6Qx3LsEX4/8qTtsUs7HxPJZ8Xlyy2iq2ZUugvTQh7w4C0sHh
 MV3DGvnsX6gxfqRbtAvPGSxx7TV0nEsfJUlkQ5Il+HCnFgjZBwKZrN3Gt3HQ48i6NIqD
 FetBQAqNALGj2Txy61I5NFOC1DingecyUbYZIO/lD0WVK0tvZfNjPKhlULdDeAiln2L9
 1vXS1zrgbfKR0EBJiNNn8yLPuk4rPlGNv+5Jt6+REn6VE653D1agVn+dTqrGPrPe44xd cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r855fh8ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:49:23 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FFg3CK005425;
        Thu, 15 Jun 2023 15:47:39 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r855fh448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:47:38 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F9qZkE022078;
        Thu, 15 Jun 2023 15:46:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r4gt52r46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:46:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35FFkfpK63832370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 15:46:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A8BA20040;
        Thu, 15 Jun 2023 15:46:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A56AA20049;
        Thu, 15 Jun 2023 15:46:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.144.159.119])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 15:46:40 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de
Subject: [PATCH 08/10] powerpc/pseries: Initialise CPU hotplug callbacks earlier
Date:   Thu, 15 Jun 2023 17:46:33 +0200
Message-ID: <20230615154635.13660-9-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615154635.13660-1-ldufour@linux.ibm.com>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 720WsJ17gjf4onhBhdgXobi0K2pOniO2
X-Proofpoint-ORIG-GUID: 8RTAte20VFDW7BFPzPQT4RVceI8yfX45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_12,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

As part of the generic HOTPLUG_SMT code, there is support for disabling
secondary SMT threads at boot time, by passing "nosmt" on the kernel
command line.

The way that is implemented is the secondary threads are brought partly
online, and then taken back offline again. That is done to support x86
CPUs needing certain initialisation done on all threads. However powerpc
has similar needs, see commit d70a54e2d085 ("powerpc/powernv: Ignore
smt-enabled on Power8 and later").

For that to work the powerpc CPU hotplug callbacks need to be registered
before secondary CPUs are brought online, otherwise __cpu_disable()
fails due to smp_ops->cpu_disable being NULL.

So split the basic initialisation into pseries_cpu_hotplug_init() which
can be called early from setup_arch(). The DLPAR related initialisation
can still be done later, because it needs to do allocations.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 22 ++++++++++++--------
 arch/powerpc/platforms/pseries/pseries.h     |  2 ++
 arch/powerpc/platforms/pseries/setup.c       |  2 ++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 1a3cb313976a..61fb7cb00880 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -845,15 +845,9 @@ static struct notifier_block pseries_smp_nb = {
 	.notifier_call = pseries_smp_notifier,
 };
 
-static int __init pseries_cpu_hotplug_init(void)
+void __init pseries_cpu_hotplug_init(void)
 {
 	int qcss_tok;
-	unsigned int node;
-
-#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
-	ppc_md.cpu_probe = dlpar_cpu_probe;
-	ppc_md.cpu_release = dlpar_cpu_release;
-#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 	rtas_stop_self_token = rtas_function_token(RTAS_FN_STOP_SELF);
 	qcss_tok = rtas_function_token(RTAS_FN_QUERY_CPU_STOPPED_STATE);
@@ -862,12 +856,22 @@ static int __init pseries_cpu_hotplug_init(void)
 			qcss_tok == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_INFO "CPU Hotplug not supported by firmware "
 				"- disabling.\n");
-		return 0;
+		return;
 	}
 
 	smp_ops->cpu_offline_self = pseries_cpu_offline_self;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
+}
+
+static int __init pseries_dlpar_init(void)
+{
+	unsigned int node;
+
+#ifdef CONFIG_ARCH_CPU_PROBE_RELEASE
+	ppc_md.cpu_probe = dlpar_cpu_probe;
+	ppc_md.cpu_release = dlpar_cpu_release;
+#endif /* CONFIG_ARCH_CPU_PROBE_RELEASE */
 
 	/* Processors can be added/removed only on LPAR */
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
@@ -886,4 +890,4 @@ static int __init pseries_cpu_hotplug_init(void)
 
 	return 0;
 }
-machine_arch_initcall(pseries, pseries_cpu_hotplug_init);
+machine_arch_initcall(pseries, pseries_dlpar_init);
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index f8bce40ebd0c..f8893ba46e83 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -75,11 +75,13 @@ static inline int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
 
 #ifdef CONFIG_HOTPLUG_CPU
 int dlpar_cpu(struct pseries_hp_errorlog *hp_elog);
+void pseries_cpu_hotplug_init(void);
 #else
 static inline int dlpar_cpu(struct pseries_hp_errorlog *hp_elog)
 {
 	return -EOPNOTSUPP;
 }
+static inline void pseries_cpu_hotplug_init(void) { }
 #endif
 
 /* PCI root bridge prepare function override for pseries */
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e2a57cfa6c83..41451b76c6e5 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -816,6 +816,8 @@ static void __init pSeries_setup_arch(void)
 	/* Discover PIC type and setup ppc_md accordingly */
 	smp_init_pseries();
 
+	// Setup CPU hotplug callbacks
+	pseries_cpu_hotplug_init();
 
 	if (radix_enabled() && !mmu_has_feature(MMU_FTR_GTSE))
 		if (!firmware_has_feature(FW_FEATURE_RPT_INVALIDATE))
-- 
2.41.0

