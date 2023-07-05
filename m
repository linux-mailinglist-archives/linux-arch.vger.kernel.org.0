Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7D7486E1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGEOwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jul 2023 10:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjGEOwS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2023 10:52:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61892171D;
        Wed,  5 Jul 2023 07:52:17 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365Ekj68005598;
        Wed, 5 Jul 2023 14:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=tJlxBeFLH1zJuNcKtOG9Kiw+Qsw7LANxcoxxZR0ZEeQ=;
 b=pI8AV6E95Ia99k/yZEQLfbjWMu0md0sN7fK7e7MJ8yqCjw0cz3QkGHYhENaJuKkTA634
 xfuTzoY2JUKm9nhOfuY+Nx5SLLzVYeV4E/WvtT7y1ijfoDCRmnvHi9cbTgWXWVejqD5I
 +E9GQiXdJyfrfd77coNW9EN+vzcrKFNLZuZcgmaYYfO8mBa+hHcqq/+wUWSlx2RM/g8M
 4zNQ60ypxR+sP6ZvmVYo6BLhBKWEAv3v6sNMlwGxmMWadOwbrINX3bJ3JLAHkMd8ixe4
 9iw8PueEQQ14oOeZqd3z37DSjM0Vd7edf/VDgS+K6kL4cDSO2xSZj5bFerW7JS/HLUFx hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak2862w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 365El2gS007142;
        Wed, 5 Jul 2023 14:51:59 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rnak28623-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:58 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 365ABBm1028795;
        Wed, 5 Jul 2023 14:51:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4sxyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 14:51:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 365Epsx028443264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jul 2023 14:51:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EF012004B;
        Wed,  5 Jul 2023 14:51:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68C3420040;
        Wed,  5 Jul 2023 14:51:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.79.178])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jul 2023 14:51:53 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        bp@alien8.de, rui.zhang@intel.com,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4 07/10] cpu/SMT: Allow enabling partial SMT states via sysfs
Date:   Wed,  5 Jul 2023 16:51:40 +0200
Message-ID: <20230705145143.40545-8-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705145143.40545-1-ldufour@linux.ibm.com>
References: <20230705145143.40545-1-ldufour@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HZk01MGvn19Coo4SBEer_4GEhH2N-XbY
X-Proofpoint-ORIG-GUID: IUoF4MPGlBusBdlbgE583q2LrSihE0Hy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_06,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306282340.Ihqm0fLA-lkp@intel.com/
[ldufour: fix build issue in control_show()]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |  1 +
 kernel/cpu.c                                  | 60 ++++++++++++++-----
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ecd585ca2d50..6dba65fb1956 100644
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
index 9a8d0685e055..7e8f1b044772 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2876,11 +2876,19 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
 
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
@@ -2888,30 +2896,39 @@ __store_smt_control(struct device *dev, struct device_attribute *attr,
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
@@ -2939,6 +2956,17 @@ static ssize_t control_show(struct device *dev,
 {
 	const char *state = smt_states[cpu_smt_control];
 
+#ifdef CONFIG_HOTPLUG_SMT
+	/*
+	 * If SMT is enabled but not all threads are enabled then show the
+	 * number of threads. If all threads are enabled show "on". Otherwise
+	 * show the state name.
+	 */
+	if (cpu_smt_control == CPU_SMT_ENABLED &&
+	    cpu_smt_num_threads != cpu_smt_max_threads)
+		return sysfs_emit(buf, "%d\n", cpu_smt_num_threads);
+#endif
+
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
-- 
2.41.0

