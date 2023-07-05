Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758D77486D7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGEOwM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjGEOwK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 10:52:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF18FF;
        Wed,  5 Jul 2023 07:52:09 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365ElGWS003026;
        Wed, 5 Jul 2023 14:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WfdHG/IFibjPqDV5js/ljbtxgQ4mhrxtxUvpA1+ay/Y=;
 b=fUP2f6sD37eNq1w+y3JOd1a3RjqxE4EKI0Eav2kVx5OKFRqYY18wnMFWBBNL0Jaaq+rW
 3MyHw6EynkrbYUixtyYZtRsJgYRqQMvLKmjnjyOiMIIbmp9Gx9tUUPAFy7AmphpMwlIB
 2jit9HoaCpDbPTA0wWDBv5XIDdRvqvbt3Tn4z9eZ6L2Z9tmcaUyFGKKBdb0pqNuQCsR9
 6E5Npuai7ojWhrUycGZCh7J+GMqXhaXhibwh3v7h4XL1gzNcM1thZ0AbLd/zqlhoPnhF
 IzBZU4ui6ueVnxK6PxP8kZvBHPTgxBDoI7wRiRol/pno89hOM0+Vs8XhlzWMziBIZwM4 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak5g37s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:52 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365ElwrU005006;
        Wed, 5 Jul 2023 14:51:52 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak5g36d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3650sFUn032566;
        Wed, 5 Jul 2023 14:51:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4tn97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365Eplgc19268256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:51:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CC3B20040;
        Wed,  5 Jul 2023 14:51:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F6092004D;
        Wed,  5 Jul 2023 14:51:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.79.178])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:51:46 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, rui.zhang@intel.com
Subject: [PATCH v4 01/10] cpu/hotplug: remove dependancy against cpu_primary_thread_mask
Date:   Wed,  5 Jul 2023 16:51:34 +0200
Message-ID: <20230705145143.40545-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h5_Kjgx80_GIwbjYFqO2hSx4w1lecSek
X-Proofpoint-ORIG-GUID: ho0Gpv-QUkWpRbe_O5ZDGgt5gyT2EbpG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The commit 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to
CPUHP_BP_KICK_AP_STATE") introduce a dependancy against a global variable
cpu_primary_thread_mask exported by the X86 code. This variable is only
used when CONFIG_HOTPLUG_PARALLEL is set.

Since cpuhp_get_primary_thread_mask() and cpuhp_smt_aware() are only used
when CONFIG_HOTPLUG_PARALLEL is set, don't define them when it is not set.

There is no functional change introduce by that patch.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 kernel/cpu.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 88a7ede322bd..03309f2f35a4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -650,22 +650,8 @@ bool cpu_smt_possible(void)
 }
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
 
-static inline bool cpuhp_smt_aware(void)
-{
-	return topology_smt_supported();
-}
-
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_primary_thread_mask;
-}
 #else
 static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
-static inline bool cpuhp_smt_aware(void) { return false; }
-static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
-{
-	return cpu_present_mask;
-}
 #endif
 
 static inline enum cpuhp_state
@@ -1793,6 +1779,16 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+static inline bool cpuhp_smt_aware(void)
+{
+	return topology_smt_supported();
+}
+
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_primary_thread_mask;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state
-- 
2.41.0

