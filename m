Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38077486DF
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjGEOwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGEOwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 10:52:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC3171C;
        Wed,  5 Jul 2023 07:52:17 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365ElGXV023139;
        Wed, 5 Jul 2023 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eghw/3jsf8X6N0Igwt2c6fLaqubc5utwhiNSkDKQhas=;
 b=SgYrLFq6QZfZsy4LwQERtsa/6A5Z9GHK7z7RDXzoqKXylwXyVZO15Z+bkXzFe8N/3Cid
 uP/ZaTxU6QhlAHHz9Eq0U1NAGZ+ySvtNBojyrn2NK3EyQj69tpgUNpY8rpQDAtqbNPAL
 IhzlhqEF+9Sd8b+LAgz7/y8jbXAaBGAmw4RDQHILrQW3Qv5z4t5SXf6+3lxZIu046aIo
 MiH51Q2IrurFzN9rlVuSD6iq6e+lcPrkiPUlFhD1IeDiyAf9/smHV/2g+MdGUqyYR+KR
 Lx4jw6R5JulgVzuP38zGUiIEejGRdzi/RYuiAI7vf0rrzRbBk/s+madfu4faZw+7pNXQ Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak3r4xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365Em1Ue025590;
        Wed, 5 Jul 2023 14:51:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak3r4wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3658ghEf027447;
        Wed, 5 Jul 2023 14:51:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4tnj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365EprrJ42599110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:51:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44D5220043;
        Wed,  5 Jul 2023 14:51:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E49820040;
        Wed,  5 Jul 2023 14:51:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.79.178])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:51:52 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, rui.zhang@intel.com
Subject: [PATCH v4 06/10] cpu/SMT: Create topology_smt_thread_allowed()
Date:   Wed,  5 Jul 2023 16:51:39 +0200
Message-ID: <20230705145143.40545-7-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BE-rrbvZ-IJ7iXGJ8YZsr6WSStYGW-ER
X-Proofpoint-GUID: WCUxuvHEbhpUoPoDGhgrTsvrfPSL6IG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050131
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
index aff2746c8af2..63c5d6a2022b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,9 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
 
+config SMT_NUM_THREADS_DYNAMIC
+	bool
+
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
 	bool
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 70add058e77b..9a8d0685e055 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -645,9 +645,23 @@ static int __init smt_cmdline_disable(char *str)
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
@@ -2642,6 +2656,12 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
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
@@ -2676,6 +2696,8 @@ int cpuhp_smt_enable(void)
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

