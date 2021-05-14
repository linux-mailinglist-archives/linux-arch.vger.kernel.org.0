Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B17381170
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhENUKY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 16:10:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhENUKW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 16:10:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK4wKJ003075;
        Fri, 14 May 2021 20:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XIXP6H7V7DdcZmhwJrMCwGnBWYwS335MqQkEGFbFM+o=;
 b=ZaaUUFkEXoX5xiOAhX91jSwR0ESspMnA9jlBwHgKsvpSoovlD5KQYPNdk/4xOpCCPPj0
 I7iDhxUMJJzDkR7yCsZBarTPykjgXxO8y+HVAoTcnhEEjapnLrlNaZvog8XZdTaoYJRe
 ASEGSdSNhW2a0n6xfboZH6lQKBGHFZBRrEyRlh+fFrsICfKNdKtUtbCN8GK9Dd6Qrm0G
 BOBq6V77E1cRrctVkA2pmMl/6dAINmzMy1/P2EiAPH4N0QPoW4ujlIZavudgfBmDIP/z
 rMfjAEuqL0aYG/0UgaY72aeRmtR7N035UJNAIR49GOGqg3F23WCJOki54/VAOIZyW75/ KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38gpndd92a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EK4sd6079510;
        Fri, 14 May 2021 20:08:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 38gppf8bn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:08 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EK87eE102525;
        Fri, 14 May 2021 20:08:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 38gppf8bm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 20:08:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 14EK7rjJ011932;
        Fri, 14 May 2021 20:07:53 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 13:07:53 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v15 0/6] Add NUMA-awareness to qspinlock
Date:   Fri, 14 May 2021 16:07:37 -0400
Message-Id: <20210514200743.3026725-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CQ2IeJfea9oFx90D7WAPE0fWvSMLLgiC
X-Proofpoint-GUID: CQ2IeJfea9oFx90D7WAPE0fWvSMLLgiC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105140159
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes from v14:
----------------

- Change the way the main queue is scanned and reordered in
cna_wait_head_or_lock(), based on Peter's suggestion.

In detail: instead of inspecting only one queue node, we now scan
(and move nodes into the secondary queue) as long as the lock
remains busy. This simplified the code quite a bit, as we don't need
to call cna_order_queue() again from cna_lock_handoff(). 

- Use local_clock() instead of relying on jiffies to decide when to
flush the secondary queue, per Andy's suggestion.

- Use module_param() for numa_spinlock_threshold_ns, so it can be tweaked
at runtime, per Andy's suggestion.

- Reduce the default value for numa_spinlock_threshold_ns to 1ms based on
the comments from Andy and Peter. The performance numbers below include
results with the new default as well as with the value of 10ms, which was 
the default threshold in previous revisions of the series.

Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS lock. Spinning threads are
organized in two queues, a primary queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. After acquiring the MCS lock and
before acquiring the spinlock, the MCS lock holder checks whether the next
waiter in the primary queue (if exists) is running on the same NUMA node.
If it is not, that waiter is detached from the main queue and moved into
the tail of the secondary queue. This way, we gradually filter the primary
queue, leaving only waiters running on the same preferred NUMA node. Note
that certain priortized waiters (e.g., in irq and nmi contexts) are
excluded from being moved to the secondary queue. We change the NUMA node
preference after a waiter at the head of the secondary queue spins for a
certain amount of time. We do that by flushing the secondary queue into
the head of the primary queue, effectively changing the preference to the
NUMA node of the waiter at the head of the secondary queue at the time of
the flush.

More details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 25 runs) of the
total number of ops (x10^7) reported at the end of each run. The 
standard deviation is also reported in (), and in general is about 3%
from the average. The 'stock' kernel is v5.12.0,
commit 3cf5c8ea3a66, compiled in the default configuration. 
'CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set and
the new default threshold of 1ms for flushing the secondary queue
(numa_spinlock_threshold_ns); 'CNA-10ms' is the same as CNA, 
but uses the threshold of 10ms. The speedup is calculated by dividing 
the result of 'CNA' and 'CNA-10ms', respectively, by the result
achieved with 'stock'.

#thr  	 stock      CNA          / speedup  CNA-10ms    / speedup
  1  2.695 (0.108) 2.704 (0.099) / 1.003  2.712 (0.077) / 1.006
  2  2.753 (0.187) 2.785 (0.171) / 1.012  2.822 (0.174) / 1.025
  4  4.355 (0.139) 4.417 (0.179) / 1.014  4.361 (0.181) / 1.001
  8  5.163 (0.119) 7.017 (0.195) / 1.359  7.369 (0.186) / 1.427
 16  5.944 (0.134) 9.110 (0.242) / 1.532  9.187 (0.233) / 1.546
 32  6.310 (0.082) 9.710 (0.156) / 1.539  9.827 (0.161) / 1.557
 36  6.374 (0.112) 9.777 (0.141) / 1.534  9.830 (0.124) / 1.542
 72  6.170 (0.139) 9.922 (0.190) / 1.608  9.945 (0.136) / 1.612
108  6.002 (0.089) 9.651 (0.176) / 1.608  9.847 (0.125) / 1.641
142  5.784 (0.079) 9.477 (0.089) / 1.638  9.641 (0.113) / 1.667

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock      CNA          / speedup  CNA-10ms    / speedup
  1  0.503 (0.004) 0.501 (0.001) / 0.996  0.503 (0.002) / 1.000
  2  0.783 (0.014) 0.773 (0.011) / 0.988  0.774 (0.016) / 0.989
  4  1.422 (0.025) 1.398 (0.030) / 0.983  1.403 (0.025) / 0.987
  8  1.753 (0.104) 1.641 (0.132) / 0.936  1.675 (0.134) / 0.956
 16  1.851 (0.097) 1.760 (0.103) / 0.951  1.774 (0.119) / 0.959
 32  0.905 (0.081) 1.708 (0.081) / 1.888  1.738 (0.069) / 1.922
 36  0.895 (0.058) 1.726 (0.065) / 1.928  1.735 (0.081) / 1.938
 72  0.823 (0.033) 1.610 (0.067) / 1.957  1.647 (0.067) / 2.002
108  0.845 (0.035) 1.588 (0.054) / 1.878  1.740 (0.067) / 2.058
142  0.840 (0.030) 1.546 (0.042) / 1.839  1.740 (0.048) / 2.070

and will-it-scale/lock2_threads:

#thr  	 stock      CNA          / speedup  CNA-10ms    / speedup
  1  1.551 (0.003) 1.558 (0.006) / 1.005  1.558 (0.003) / 1.005
  2  2.722 (0.064) 2.704 (0.063) / 0.993  2.727 (0.058) / 1.002
  4  5.286 (0.178) 5.360 (0.151) / 1.014  5.360 (0.135) / 1.014
  8  4.115 (0.297) 3.906 (0.383) / 0.949  4.062 (0.366) / 0.987
 16  4.119 (0.121) 3.950 (0.131) / 0.959  4.009 (0.132) / 0.973
 32  2.508 (0.097) 3.805 (0.106) / 1.517  3.960 (0.091) / 1.579
 36  2.457 (0.101) 3.810 (0.072) / 1.551  3.931 (0.106) / 1.600
 72  1.913 (0.103) 3.530 (0.070) / 1.845  3.860 (0.078) / 2.018
108  1.891 (0.109) 3.410 (0.079) / 1.803  3.881 (0.097) / 2.052
142  1.752 (0.096) 3.236 (0.080) / 1.847  3.774 (0.078) / 2.155

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the throughput results (ops/us) for the leveldb ‘readrandom’
benchmark:

#thr  	 stock      CNA          / speedup  CNA-10ms    / speedup
  1  0.533 (0.011) 0.539 (0.014) / 1.012  0.536 (0.013) / 1.006
  2  0.854 (0.022) 0.856 (0.017) / 1.003  0.857 (0.020) / 1.004
  4  1.236 (0.028) 1.238 (0.054) / 1.002  1.217 (0.054) / 0.985
  8  1.207 (0.117) 1.198 (0.122) / 0.993  1.155 (0.138) / 0.957
 16  0.758 (0.055) 1.128 (0.118) / 1.489  1.068 (0.131) / 1.409
 32  0.743 (0.027) 1.153 (0.028) / 1.551  1.147 (0.021) / 1.543
 36  0.708 (0.027) 1.150 (0.024) / 1.623  1.137 (0.026) / 1.605
 72  0.629 (0.016) 1.112 (0.019) / 1.767  1.134 (0.019) / 1.802
108  0.610 (0.012) 1.053 (0.018) / 1.725  1.130 (0.017) / 1.853
142  0.606 (0.013) 1.008 (0.020) / 1.664  1.110 (0.023) / 1.833

Further comments are welcome and appreciated.

Alex Kogan (6):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Avoid moving certain threads between waiting queues
    in CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 .../admin-guide/kernel-parameters.txt         |  18 +
 arch/arm/include/asm/mcs_spinlock.h           |   6 +-
 arch/x86/Kconfig                              |  20 +
 arch/x86/include/asm/qspinlock.h              |   4 +
 arch/x86/kernel/alternative.c                 |   4 +
 include/asm-generic/mcs_spinlock.h            |   4 +-
 kernel/locking/mcs_spinlock.h                 |  20 +-
 kernel/locking/qspinlock.c                    |  82 +++-
 kernel/locking/qspinlock_cna.h                | 425 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 562 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.24.3 (Apple Git-128)

