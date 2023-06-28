Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59425740E68
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjF1KMS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:12:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229964AbjF1KGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9wcMc002628;
        Wed, 28 Jun 2023 10:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ab3NqT1eN5qPIMRWWy0PIsxg+fHYQaOZWEASX1j+nMY=;
 b=SvJakEzwCJKE+leFMKFMZkJfXCme71z1CkeJlEcKg1W94LeJem5/p1UV6fzSF2fqspXg
 QHXTp+B3C3yQse8TH49DAIds37NUpdNLftXNQwIKpQ7Pvy05YzU0h0aNDuGyVrhmMhiH
 8UsR1i2tQbk4hoRA2sap94Y8O6sWh0tQsA5ZGu96n0XwX9PF7UiwjuuoPDlU0gOF8qdg
 sD1+QtDCbwmfOCY/NFAcFSrQwJP0J5M65AIsQvHSr2Kv+nNOvuFO/S7+Nmslw8+Cs/du
 5cxZ/25SXE/rwjqvh1XWL+pxL7bxuwyJLe1yZ5s5kSI8+b7KwYy5xpXv2tJXm6SovKTd Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjps86x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:10 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S9xrh7007119;
        Wed, 28 Jun 2023 10:06:10 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjps86ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S0WgYh022148;
        Wed, 28 Jun 2023 10:06:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre2fah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA65w645220458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E76B320063;
        Wed, 28 Jun 2023 10:06:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CE4520065;
        Wed, 28 Jun 2023 10:06:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:04 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 5/9] cpu/SMT: Create topology_smt_thread_allowed()
Date:   Wed, 28 Jun 2023 12:05:54 +0200
Message-ID: <20230628100558.43482-6-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JzRn1H1YDd8NyxOEUyoOjpSqrGjoeAEy
X-Proofpoint-ORIG-GUID: mpzW3XEdm9-icHNIVchv0PJper00EMFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Some architectures allows partial SMT states, ie. when not all SMT
threads are brought online.

To support that, add an architecture helper which checks whether a given
CPU is allowed to be brought online depending on how many SMT threads are
currently enabled. Since this is only applicable to architecture supporting
partial SMT, only these architectures should select the new configuration
variable CONFIG_SMT_NUM_THREADS_DYNAMIC. For the other architectures, not
supporting the partial SMT states, there is no need to define
topology_cpu_smt_allowed(), the generic code assumed that all the threads
are allowed or only the primary ones.

Call the helper from cpu_smt_enable(), and cpu_smt_allowed() when SMT is
enabled, to check if the particular thread should be onlined. Notably,
also call it from cpu_smt_disable() if CPU_SMT_ENABLED, to allow
offlining some threads to move from a higher to lower number of threads
online.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
[ldufour: slightly reword the commit's description]
[ldufour: introduce CONFIG_SMT_NUM_THREADS_DYNAMIC]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/Kconfig |  3 +++
 kernel/cpu.c | 24 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 205fd23e0cad..c69e9c662a87 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,9 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
 
+config SMT_NUM_THREADS_DYNAMIC
+	bool
+
 config GENERIC_ENTRY
 	bool
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e354af92b2b8..29bf310651c6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -466,9 +466,23 @@ static int __init smt_cmdline_disable(char *str)
 }
 early_param("nosmt", smt_cmdline_disable);
 
+/*
+ * For Archicture supporting partial SMT states check if the thread is allowed.
+ * Otherwise this has already been checked through cpu_smt_max_threads when
+ * setting the SMT level.
+ */
+static inline bool cpu_smt_thread_allowed(unsigned int cpu)
+{
+#ifdef CONFIG_SMT_NUM_THREADS_DYNAMIC
+	return topology_smt_thread_allowed(cpu);
+#else
+	return true;
+#endif
+}
+
 static inline bool cpu_smt_allowed(unsigned int cpu)
 {
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (cpu_smt_control == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
 
 	if (topology_is_primary_thread(cpu))
@@ -2283,6 +2297,12 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
+		/*
+		 * Disable can be called with CPU_SMT_ENABLED when changing
+		 * from a higher to lower number of SMT threads per core.
+		 */
+		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
+			continue;
 		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
 		if (ret)
 			break;
@@ -2317,6 +2337,8 @@ int cpuhp_smt_enable(void)
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
 			continue;
+		if (!cpu_smt_thread_allowed(cpu))
+			continue;
 		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
 		if (ret)
 			break;
-- 
2.41.0

