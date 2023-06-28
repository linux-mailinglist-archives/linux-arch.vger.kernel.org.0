Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5A740E60
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjF1KMF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:12:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55748 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbjF1KGu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SA340d000680;
        Wed, 28 Jun 2023 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tBJniILrv67rMmqL7C9oGbfvlECwbA5Rr3vj+TgxJL4=;
 b=HWRJg2u1lwxVdlG6NU5q/mBljBJTGNCZEQJJJakJg9JxWy3KBzrScNXcxfWzk+0kAtzk
 LbhlNO3LnBtjUZtxIP+BHd1QeL8wYGRDt7EzVulZMZ2R4ZHccQgVh2V1p+41SiSaQM5l
 NQakTyYiaeEJ+7W+OJQiF5mkayoGWHW6HufDPWTm19hIaW6hSA0nOtDSG+sp6IWGQB3y
 OVCKXL/ygYPe7eDt/Vsdhl4f0il0mmU4oaB9Rb6ahPC7FgtsuwaUH87V7JpCD6Xv681i
 ygTJ4gMT5fPkhueORzoA7mKZScV58RpYVFlUqMiatwAbL/Tsag9SSGrrtQ23n7iA5EM6 hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjs0r4kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:35 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35SA3HJg001801;
        Wed, 28 Jun 2023 10:06:24 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjs0r4b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:24 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RNvb77026359;
        Wed, 28 Jun 2023 10:06:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre2faf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA64nx20447786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17302005A;
        Wed, 28 Jun 2023 10:06:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2608720067;
        Wed, 28 Jun 2023 10:06:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:03 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 4/9] cpu/SMT: Remove topology_smt_supported()
Date:   Wed, 28 Jun 2023 12:05:53 +0200
Message-ID: <20230628100558.43482-5-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hYi_HeAVfqzMW4iPjLnc1a-Hrswq_G9v
X-Proofpoint-GUID: O6HFOq1oVYm6U4lM_DruPdAMcNVeWxvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306280088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the maximum number of threads is now passed to
cpu_smt_set_num_threads(), checking that value is enough to know if SMT is
supported.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/x86/include/asm/topology.h | 2 --
 arch/x86/kernel/smpboot.c       | 8 --------
 kernel/cpu.c                    | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 66927a59e822..87358a8fe843 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -143,7 +143,6 @@ int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
-bool topology_smt_supported(void);
 #else
 #define topology_max_packages()			(1)
 static inline int
@@ -156,7 +155,6 @@ static inline int topology_phys_to_logical_die(unsigned int die,
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
-static inline bool topology_smt_supported(void) { return false; }
 #endif
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 352f0ce1ece4..3052c171668d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -278,14 +278,6 @@ bool topology_is_primary_thread(unsigned int cpu)
 	return apic_id_is_primary_thread(per_cpu(x86_cpu_to_apicid, cpu));
 }
 
-/**
- * topology_smt_supported - Check whether SMT is supported by the CPUs
- */
-bool topology_smt_supported(void)
-{
-	return smp_num_siblings > 1;
-}
-
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
diff --git a/kernel/cpu.c b/kernel/cpu.c
index edca8b7bd400..e354af92b2b8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -442,7 +442,7 @@ void __init cpu_smt_set_num_threads(unsigned int num_threads,
 {
 	WARN_ON(!num_threads || (num_threads > max_threads));
 
-	if (!topology_smt_supported())
+	if (max_threads == 1)
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
 
 	cpu_smt_max_threads = max_threads;
-- 
2.41.0

