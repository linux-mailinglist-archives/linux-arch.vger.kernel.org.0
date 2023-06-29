Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B9A742874
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 16:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjF2Occ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 10:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjF2OcX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 10:32:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F22D71;
        Thu, 29 Jun 2023 07:32:22 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TEM4FV021839;
        Thu, 29 Jun 2023 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tBJniILrv67rMmqL7C9oGbfvlECwbA5Rr3vj+TgxJL4=;
 b=rzCI52eOkJaXVbPb56DJibIkBW1IkZ8xJjT4ZN8U5X8Pwxtn3I77WEBeZ/Hp8LC0nvi0
 m9LnIw5ifKDzZYBvPFUYqN9zkisevjY+09P/ITJa2Y7Lpq9zalu/iSkwDf5scqiL7s4t
 3FP1fumZn8HwLB8uNBGCqI3ZGiFih49WRCpOY+Tt4uKQO9B1rf+ugp6rgrNzgk2hsjqZ
 HDuzY0yCUBPQhxCpLzUgE32EeGjHm5bUJYl1qNjsyFOLFq/DjxtstEty66UyGQxEQPki
 /3VPSyG7XYfPM/kVqHNkBM4mBEv5okNx7N2MxuipCFVVditDvs1JURtTYMzDVvzd4wE7 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbnbg8k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:59 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TENqgR028006;
        Thu, 29 Jun 2023 14:31:58 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhbnbg8hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:58 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35TCK0JU017046;
        Thu, 29 Jun 2023 14:31:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre3d9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 14:31:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35TEVrBP42009078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 14:31:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 939D92004B;
        Thu, 29 Jun 2023 14:31:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2633120043;
        Thu, 29 Jun 2023 14:31:53 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.101.4.33])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jun 2023 14:31:53 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v3 4/9] cpu/SMT: Remove topology_smt_supported()
Date:   Thu, 29 Jun 2023 16:31:44 +0200
Message-ID: <20230629143149.79073-5-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629143149.79073-1-ldufour@linux.ibm.com>
References: <20230629143149.79073-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qiVFcStK5BVp-ebjaBqwVhU4DJaxKQFL
X-Proofpoint-ORIG-GUID: ccMO6OyyLrajABBsnGOtEUtC8U9iLACB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

