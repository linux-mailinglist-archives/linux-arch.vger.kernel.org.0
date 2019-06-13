Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE21643C13
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfFMPdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:33:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728340AbfFMKfU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:35:20 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DASjbn028228
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:19 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t3k7rmt7d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 06:35:19 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Jun 2019 11:35:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Jun 2019 11:35:13 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5DAZBxH51052790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 10:35:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7E5AE04D;
        Thu, 13 Jun 2019 10:35:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80A0FAE045;
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
Subject: [PATCHv2 2/3] s390: improve wait logic of stop_machine
Date:   Thu, 13 Jun 2019 12:35:09 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
References: <20190613103510.60529-1-heiko.carstens@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19061310-0016-0000-0000-00000288BD35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061310-0017-0000-0000-000032E5F7D9
Message-Id: <20190613103510.60529-3-heiko.carstens@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=998 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130082
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The stop_machine loop to advance the state machine and to wait for all
affected CPUs to check-in calls cpu_relax_yield in a tight loop until
the last missing CPUs acknowledged the state transition.

On a virtual system where not all logical CPUs are backed by real CPUs
all the time it can take a while for all CPUs to check-in. With the
current definition of cpu_relax_yield a diagnose 0x44 is done which
tells the hypervisor to schedule *some* other CPU. That can be any
CPU and not necessarily one of the CPUs that need to run in order to
advance the state machine. This can lead to a pretty bad diagnose 0x44
storm until the last missing CPU finally checked-in.

Replace the undirected cpu_relax_yield based on diagnose 0x44 with a
directed yield. Each CPU in the wait loop will pick up the next CPU
in the cpumask of stop_machine. The diagnose 0x9c is used to tell the
hypervisor to run this next CPU instead of the current one. If there
is only a limited number of real CPUs backing the virtual CPUs we
end up with the real CPUs passed around in a round-robin fashion.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/processor.h |  3 ++-
 arch/s390/kernel/processor.c      | 17 ++++++++++++-----
 arch/s390/kernel/smp.c            |  2 +-
 include/linux/sched.h             |  2 +-
 kernel/stop_machine.c             | 14 +++++++++-----
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index b0fcbc37b637..445ce9ee4404 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -36,6 +36,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/cpumask.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
 #include <asm/cpu.h>
@@ -225,7 +226,7 @@ static __no_kasan_or_inline unsigned short stap(void)
  * Give up the time slice of the virtual PU.
  */
 #define cpu_relax_yield cpu_relax_yield
-void cpu_relax_yield(void);
+void cpu_relax_yield(const struct cpumask *cpumask);
 
 #define cpu_relax() barrier()
 
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 5de13307b703..4cdaefec1b7c 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -31,6 +31,7 @@ struct cpu_info {
 };
 
 static DEFINE_PER_CPU(struct cpu_info, cpu_info);
+static DEFINE_PER_CPU(int, cpu_relax_retry);
 
 static bool machine_has_cpu_mhz;
 
@@ -58,13 +59,19 @@ void s390_update_cpu_mhz(void)
 		on_each_cpu(update_cpu_mhz, NULL, 0);
 }
 
-void notrace cpu_relax_yield(void)
+void notrace cpu_relax_yield(const struct cpumask *cpumask)
 {
-	if (!smp_cpu_mtid && MACHINE_HAS_DIAG44) {
-		diag_stat_inc(DIAG_STAT_X044);
-		asm volatile("diag 0,0,0x44");
+	int cpu, this_cpu;
+
+	this_cpu = smp_processor_id();
+	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
+		__this_cpu_write(cpu_relax_retry, 0);
+		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
+		if (cpu >= nr_cpu_ids)
+			return;
+		if (arch_vcpu_is_preempted(cpu))
+			smp_yield_cpu(cpu);
 	}
-	barrier();
 }
 EXPORT_SYMBOL(cpu_relax_yield);
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35fafa2b91a8..a8eef7b7770a 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -418,7 +418,7 @@ void smp_yield_cpu(int cpu)
 		diag_stat_inc_norecursion(DIAG_STAT_X09C);
 		asm volatile("diag %0,0,0x9c"
 			     : : "d" (pcpu_devices[cpu].address));
-	} else if (MACHINE_HAS_DIAG44) {
+	} else if (MACHINE_HAS_DIAG44 && !smp_cpu_mtid) {
 		diag_stat_inc_norecursion(DIAG_STAT_X044);
 		asm volatile("diag 0,0,0x44");
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 11837410690f..1f9f3160da7e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1519,7 +1519,7 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 #endif
 
 #ifndef cpu_relax_yield
-#define cpu_relax_yield() cpu_relax()
+#define cpu_relax_yield(cpumask) cpu_relax()
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 2b5a6754646f..b8b0c5ff8da9 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -183,6 +183,7 @@ static int multi_cpu_stop(void *data)
 	struct multi_stop_data *msdata = data;
 	enum multi_stop_state curstate = MULTI_STOP_NONE;
 	int cpu = smp_processor_id(), err = 0;
+	const struct cpumask *cpumask;
 	unsigned long flags;
 	bool is_active;
 
@@ -192,15 +193,18 @@ static int multi_cpu_stop(void *data)
 	 */
 	local_save_flags(flags);
 
-	if (!msdata->active_cpus)
-		is_active = cpu == cpumask_first(cpu_online_mask);
-	else
-		is_active = cpumask_test_cpu(cpu, msdata->active_cpus);
+	if (!msdata->active_cpus) {
+		cpumask = cpu_online_mask;
+		is_active = cpu == cpumask_first(cpumask);
+	} else {
+		cpumask = msdata->active_cpus;
+		is_active = cpumask_test_cpu(cpu, cpumask);
+	}
 
 	/* Simple state machine */
 	do {
 		/* Chill out and ensure we re-read multi_stop_state. */
-		cpu_relax_yield();
+		cpu_relax_yield(cpumask);
 		if (msdata->state != curstate) {
 			curstate = msdata->state;
 			switch (curstate) {
-- 
2.17.1

