Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886F731D06
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbjFOPta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jun 2023 11:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbjFOPtC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2023 11:49:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84602D49;
        Thu, 15 Jun 2023 08:49:00 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FFfnd1004326;
        Thu, 15 Jun 2023 15:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mXs6gwj2eCRX2IPjfYmQ/36SBWEbWvuOsFEbBfkdNfA=;
 b=LMcXj9k7+2kd3iheIQTbVl4il8Z84RUrtBBZzP7kg8Xnnt58z5Oug07HCUmydH+211Zl
 J/p8pJlTaa2ssyaB2tFeeCf6EdjmRa8pN5hRDtDIngAE5TUSE29WJur7+dBEhy1VS2PT
 LjIZ8ufmICJ9daplIhii8Gb9Rw1Qw7GOEVf0Ctrg14mRyse+sMtxDRzQ/BtwGMysa+bf
 Fl92gF2TuwOLJwWQXicp4wOL3E/V8hsAx3l/9tG4OzrPO3KdbH7h2XSvIfb0sn8FHZAK
 dGwJx5YohWtxQUKGCoSN+L6rQTOIrsVe/wEx9aJl2i3gM0f9cZFyV3Tz9QpX5C1z+ZjN Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r855fh8bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:48:42 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FFgW7t010623;
        Thu, 15 Jun 2023 15:47:32 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r855fh42r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:47:32 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35F2kCxO030742;
        Thu, 15 Jun 2023 15:46:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r4gt53pbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 15:46:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35FFkeZI43254166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 15:46:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94F9D2004B;
        Thu, 15 Jun 2023 15:46:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CD9120043;
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
Subject: [PATCH 07/10] cpu/SMT: Allow enabling partial SMT states via sysfs
Date:   Thu, 15 Jun 2023 17:46:32 +0200
Message-ID: <20230615154635.13660-8-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615154635.13660-1-ldufour@linux.ibm.com>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QZffo4F3DHL1OtroLkrhyTU5lF0vyb9b
X-Proofpoint-ORIG-GUID: 0sckBeqcPr-K8FHnGUSAMwyWHXxhIUAz
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

There is a hook which allows arch code to control how many threads per
core are supported. To retain the existing behaviour, the x86 hook only
supports 1 thread or all threads.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 kernel/cpu.c                                  | 39 ++++++++++++++++---
 2 files changed, 34 insertions(+), 6 deletions(-)

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
index ae2fa26a5b63..248f0734098a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2507,7 +2507,7 @@ static ssize_t
 __store_smt_control(struct device *dev, struct device_attribute *attr,
 		    const char *buf, size_t count)
 {
-	int ctrlval, ret;
+	int ctrlval, ret, num_threads, orig_threads;
 
 	if (cpu_smt_control == CPU_SMT_FORCE_DISABLED)
 		return -EPERM;
@@ -2515,20 +2515,38 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
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
+		else if (num_threads > 1 && topology_smt_threads_supported(num_threads))
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
+	orig_threads = cpu_smt_num_threads;
+	cpu_smt_num_threads = num_threads;
+
+	if (num_threads > orig_threads) {
+		ret = cpuhp_smt_enable();
+	} else if (num_threads < orig_threads) {
+		ret = cpuhp_smt_disable(ctrlval);
+	} else if (ctrlval != cpu_smt_control) {
 		switch (ctrlval) {
 		case CPU_SMT_ENABLED:
 			ret = cpuhp_smt_enable();
@@ -2566,6 +2584,15 @@ static ssize_t control_show(struct device *dev,
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

