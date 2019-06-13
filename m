Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA243C42
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFMPex (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:34:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728348AbfFMKfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:21 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DARxXb185488
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:19 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t3mjp8wxx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:19 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 11:35:18 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 11:35:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DAZC7B34800052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:35:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C2EAE045;
        Thu, 13 Jun 2019 10:35:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECA94AE059;
        Thu, 13 Jun 2019 10:35:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jun 2019 10:35:11 +0000 (GMT)
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCHv2 3/3] processor: get rid of cpu_relax_yield
Date:   Thu, 13 Jun 2019 12:35:10 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061310-4275-0000-0000-00000341F9C2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061310-4276-0000-0000-00003852130E
Message-Id: <20190613103510.60529-4-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=728 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

stop_machine is the only user left of cpu_relax_yield. Given that it
now has special semantics which are tied to stop_machine introduce a
weak stop_machine_yield function which architectures can override, and
get rid of the generic cpu_relax_yield implementation.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 6 ------
 arch/s390/kernel/processor.c      | 4 ++--
 include/linux/sched.h             | 4 ----
 include/linux/stop_machine.h      | 1 +
 kernel/stop_machine.c             | 7 ++++++-
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 445ce9ee4404..14883b1562e0 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -222,12 +222,6 @@ static __no_kasan_or_inline unsigned short stap(void)
 	return cpu_address;
 }
 
-/*
- * Give up the time slice of the virtual PU.
- */
-#define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(const struct cpumask *cpumask);
-
 #define cpu_relax() barrier()
 
 #define ECAG_CACHE_ATTRIBUTE	0
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 4cdaefec1b7c..6ebc2117c66c 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -7,6 +7,7 @@
 #define KMSG_COMPONENT "cpu"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/stop_machine.h>
 #include <linux/cpufeature.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -59,7 +60,7 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(const struct cpumask *cpumask)
+void notrace stop_machine_yield(const struct cpumask *cpumask)
 {
 	int cpu, this_cpu;
 
@@ -73,7 +74,6 @@ void notrace cpu_relax_yield(const struct cpumask *cpumask)
 			smp_yield_cpu(cpu);
 	}
 }
-EXPORT_SYMBOL(cpu_relax_yield);
 
 /*
  * cpu_init - initializes state that is per-CPU.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1f9f3160da7e..911675416b05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1518,10 +1518,6 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 }
 #endif
 
-#ifndef cpu_relax_yield
-#define cpu_relax_yield(cpumask) cpu_relax()
-#endif
-
 extern int yield_to(struct task_struct *p, bool preempt);
 extern void set_user_nice(struct task_struct *p, long nice);
 extern int task_prio(const struct task_struct *p);
diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 6d3635c86dbe..f9a0c6189852 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -36,6 +36,7 @@ int stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 int try_stop_cpus(const struct cpumask *cpumask, cpu_stop_fn_t fn, void *arg);
 void stop_machine_park(int cpu);
 void stop_machine_unpark(int cpu);
+void stop_machine_yield(const struct cpumask *cpumask);
 
 #else	/* CONFIG_SMP */
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b8b0c5ff8da9..b4f83f7bdf86 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -177,6 +177,11 @@ static void ack_state(struct multi_stop_data *msdata)
 		set_state(msdata, msdata->state + 1);
 }
 
+void __weak stop_machine_yield(const struct cpumask *cpumask)
+{
+	cpu_relax();
+}
+
 /* This is the cpu_stop function which stops the CPU. */
 static int multi_cpu_stop(void *data)
 {
@@ -204,7 +209,7 @@ static int multi_cpu_stop(void *data)
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield(cpumask);
+		stop_machine_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1

