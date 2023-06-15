Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F3731CF5
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbjFOPrW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jun 2023 11:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjFOPrT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2023 11:47:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A68E4;
        Thu, 15 Jun 2023 08:47:18 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FF7P7s002298;
        Thu, 15 Jun 2023 15:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HyPT7JhScHY14W+4yC0YwDdKiDyYVhW1/dxqq65NYJI=;
 b=krst2C3+gXxJYDbopCRfm9DLkau3GcMzBDl6WZsSs9dkP9+4AkKPonlJAQQa540MppPm
 DGQ1U8MRiiwsawGTqB8ZXKviXFlosyErjdOWd16+5GuxQASB1AiPWHpI4uzzw4blbPIy
 vkBdMj94a4iLoJqlGGBbtO92idqvjaGgR6xNxU87jrFVO+CLgzNX48S/r3LPi2MdLNid
 udwsoDhUzQPlYNi/m3d5eiVV/epvCS0RH3VPyTwPQKzm2CZLyhGHvj4AqJHuUl3EDpIc
 /J7ArH2xM0AIsT/sFM7zmZPZjs8u8AASB4qYFj4N2cJwVHTBrM3OChsNP7PFxwyKY2MM Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r84qb1yhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:46:45 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FFGq7A014158;
        Thu, 15 Jun 2023 15:46:44 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r84qb1yfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:46:44 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F2kCxN030742;
        Thu, 15 Jun 2023 15:46:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt53pba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:46:41 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35FFkd3N19989232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 15:46:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7773120040;
        Thu, 15 Jun 2023 15:46:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3C2220043;
        Thu, 15 Jun 2023 15:46:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.144.159.119])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Jun 2023 15:46:38 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de
Subject: [PATCH 05/10] cpu/SMT: Create topology_smt_threads_supported()
Date:   Thu, 15 Jun 2023 17:46:30 +0200
Message-ID: <20230615154635.13660-6-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615154635.13660-1-ldufour@linux.ibm.com>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GKY_m6eO-S-9CF-jGda-6u9bAXCzu_wL
X-Proofpoint-ORIG-GUID: nvzwFDIsa5kbDWYfeiYiz2CuKupDqmI2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_12,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=497 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150136
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

A subsequent patch will enable partial SMT states, ie. when not all SMT
threads are brought online.

To support that, add an arch helper to check how many SMT threads are
supported.

To retain existing behaviour, the x86 implementation only allows a
single thread or all threads to be online.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/smpboot.c       | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 87358a8fe843..232df5ffab34 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -143,6 +143,7 @@ int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
 int topology_phys_to_logical_die(unsigned int die, unsigned int cpu);
 bool topology_is_primary_thread(unsigned int cpu);
+bool topology_smt_threads_supported(unsigned int threads);
 #else
 #define topology_max_packages()			(1)
 static inline int
@@ -155,6 +156,7 @@ static inline int topology_phys_to_logical_die(unsigned int die,
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
+static inline bool topology_smt_threads_supported(unsigned int threads) { return false; }
 #endif
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3052c171668d..d163ef55577b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -278,6 +278,18 @@ bool topology_is_primary_thread(unsigned int cpu)
 	return apic_id_is_primary_thread(per_cpu(x86_cpu_to_apicid, cpu));
 }
 
+/**
+ * topology_smt_threads_supported - Check if the given number of SMT threads
+ *				    is supported.
+ *
+ * @threads:	The number of SMT threads.
+ */
+bool topology_smt_threads_supported(unsigned int threads)
+{
+	// Only support a single thread or all threads.
+	return threads == 1 || threads == smp_num_siblings;
+}
+
 /**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
-- 
2.41.0

