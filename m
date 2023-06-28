Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878D740E63
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 12:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjF1KMJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 06:12:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231609AbjF1KGc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 06:06:32 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9tYA1014948;
        Wed, 28 Jun 2023 10:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XyTXGi5dDkMgiNgwSNnfdPOzG8/bxcLtUSBua5iss9Q=;
 b=VrNRNZJRXZId5cvve4gNmkezZ/hi7aLMY7UaaSzq6cq7v543uyFaKEE2pMt9hlrD+a0d
 JNlSMw2IDchqCVi2TKYa1nac1cyDUI6CZsECQ1wmW5IgI8COuivWgVxkwHmLxlEjil9T
 f4Hq/oxZ1xwrkKO2xaOn2+SM3vWKKaU1qkJ6m2c4YwuWNGM7TvgXbCP/hty1hUGQ9Jj1
 /5ngu6DjyiY799UtgkkycWPfG5+bead86Lx6FClOjmy3g6tthjolRa1VLQmJA4tdRC5j
 egO+URILScP5A8fuy4Kw36aZPTpawYLFuqRR5t5ZqZN/TAnjZGKwlVSYpNODdoU78SvV tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjnjrdp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:17 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S9tWIw014893;
        Wed, 28 Jun 2023 10:06:16 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgjnjrden-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S9bSZp027083;
        Wed, 28 Jun 2023 10:06:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr451w62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:06:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SA65DY38994250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 10:06:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEECA20043;
        Wed, 28 Jun 2023 10:06:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11DDC2004F;
        Wed, 28 Jun 2023 10:06:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.41.43])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 10:06:04 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de
Subject: [PATCH v2 6/9] cpu/SMT: Allow enabling partial SMT states via sysfs
Date:   Wed, 28 Jun 2023 12:05:55 +0200
Message-ID: <20230628100558.43482-7-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628100558.43482-1-ldufour@linux.ibm.com>
References: <20230628100558.43482-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yoZpdj3kz_2G64vs7Z7XWWklIUvzxkC_
X-Proofpoint-ORIG-GUID: 05PDmMmyroMBZnXRdPjO5Sm0_onczHBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280088
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Add support to the /sys/devices/system/cpu/smt/control interface for
enabling a specified number of SMT threads per core, including partial
SMT states where not all threads are brought online.

The current interface accepts "on" and "off", to enable either 1 or all
SMT threads per core.

This commit allows writing an integer, between 1 and the number of SMT
threads supported by the machine. Writing 1 is a synonym for "off", 2 or
more enables SMT with the specified number of threads.

When reading the file, if all threads are online "on" is returned, to
avoid changing behaviour for existing users. If some other number of
threads is online then the integer value is returned.

Architectures like x86 only supporting 1 thread or all threads, should not
define CONFIG_SMT_NUM_THREADS_DYNAMIC. Architecture supporting partial SMT
states, like PowerPC, should define it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[ldufour: slightly reword the commit's description]
[ldufour: remove switch() in __store_smt_control()]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 kernel/cpu.c                                  | 58 ++++++++++++++-----
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f54867cadb0f..3c4cfb59d495 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -555,6 +555,7 @@ Description:	Control Symmetric Multi Threading (SMT)
 			 ================ =========================================
 			 "on"		  SMT is enabled
 			 "off"		  SMT is disabled
+			 "<N>"		  SMT is enabled with N threads per core.
 			 "forceoff"	  SMT is force disabled. Cannot be changed.
 			 "notsupported"   SMT is not supported by the CPU
 			 "notimplemented" SMT runtime toggling is not
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 29bf310651c6..e0111c1a2f98 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2517,11 +2517,19 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 
 #ifdef CONFIG_HOTPLUG_SMT
 
+static bool cpu_smt_num_threads_valid(unsigned int threads)
+{
+	if (IS_ENABLED(CONFIG_SMT_NUM_THREADS_DYNAMIC))
+		return threads >= 1 && threads <= cpu_smt_max_threads;
+	return threads == 1 || threads == cpu_smt_max_threads;
+}
+
 static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ctrlval, ret;
+	int ctrlval, ret, num_threads, orig_threads;
+	bool force_off;
 
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
 		return -EPERM;
@@ -2529,30 +2537,39 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
 	if (cpu_smt_control == CPU_SMT_NOT_SUPPORTED)
 		return -ENODEV;
 
-	if (sysfs_streq(buf, "on"))
+	if (sysfs_streq(buf, "on")) {
 		ctrlval = CPU_SMT_ENABLED;
-	else if (sysfs_streq(buf, "off"))
+		num_threads = cpu_smt_max_threads;
+	} else if (sysfs_streq(buf, "off")) {
 		ctrlval = CPU_SMT_DISABLED;
-	else if (sysfs_streq(buf, "forceoff"))
+		num_threads = 1;
+	} else if (sysfs_streq(buf, "forceoff")) {
 		ctrlval = CPU_SMT_FORCE_DISABLED;
-	else
+		num_threads = 1;
+	} else if (kstrtoint(buf, 10, &num_threads) == 0) {
+		if (num_threads == 1)
+			ctrlval = CPU_SMT_DISABLED;
+		else if (cpu_smt_num_threads_valid(num_threads))
+			ctrlval = CPU_SMT_ENABLED;
+		else
+			return -EINVAL;
+	} else {
 		return -EINVAL;
+	}
 
 	ret = lock_device_hotplug_sysfs();
 	if (ret)
 		return ret;
 
-	if (ctrlval != cpu_smt_control) {
-		switch (ctrlval) {
-		case CPU_SMT_ENABLED:
-			ret = cpuhp_smt_enable();
-			break;
-		case CPU_SMT_DISABLED:
-		case CPU_SMT_FORCE_DISABLED:
-			ret = cpuhp_smt_disable(ctrlval);
-			break;
-		}
-	}
+	orig_threads = cpu_smt_num_threads;
+	cpu_smt_num_threads = num_threads;
+
+	force_off = ctrlval != cpu_smt_control && ctrlval == CPU_SMT_FORCE_DISABLED;
+
+	if (num_threads > orig_threads)
+		ret = cpuhp_smt_enable();
+	else if (num_threads < orig_threads || force_off)
+		ret = cpuhp_smt_disable(ctrlval);
 
 	unlock_device_hotplug();
 	return ret ? ret : count;
@@ -2580,6 +2597,15 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
+	/*
+	 * If SMT is enabled but not all threads are enabled then show the
+	 * number of threads. If all threads are enabled show "on". Otherwise
+	 * show the state name.
+	 */
+	if (cpu_smt_control == CPU_SMT_ENABLED &&
+	    cpu_smt_num_threads != cpu_smt_max_threads)
+		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
+
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
-- 
2.41.0

