Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCD635192C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 19:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhDARv5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 13:51:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhDARq7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 13:46:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FOvvj070236;
        Thu, 1 Apr 2021 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=hiWxUtZ4UrasjC/KrUrvadeOLXqzQeinrezAY9cI9k8=;
 b=RVp+L3Pl1GJzyn56WKXlIEUemMFn9pcxTX/KCkCaueUNO37IOkev8aKXJZqK+pWNJ7iu
 DIWEcuT34YdaMNuW2t6ESaTUEWY50Z+MyjRAzcpj7+Bhok7lm4RHtl9DCH7CjW5lhbnI
 zvlT8vztGX0nOr8VSohJtfoHu/G06K9KAy0DGpBn7i0V2u3wdJuy3gLxpxrT6zGtWON9
 Mr/TAQBiR3nmIIMrqPCY4E97+ClI5538yTAFyPJWlT23lOuvhbEuBoUTQ8E/D0QoZrfw
 cQNaG8MPxxenthQo7bEs8mfJpDWt2bsCS6MELVE2BpURRBu+ONEfR4TU0AfJbY2SyKT3 vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37n2a029c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131FLCAR100856;
        Thu, 1 Apr 2021 15:32:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37n2abdcx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 15:32:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131FW9rT031849;
        Thu, 1 Apr 2021 15:32:10 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 08:32:09 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v14 0/6] Add NUMA-awareness to qspinlock
Date:   Thu,  1 Apr 2021 11:31:50 -0400
Message-Id: <20210401153156.1165900-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
X-Proofpoint-GUID: hT3XKPPqpBvko5QewSulvlWXsfxwBalB
X-Proofpoint-ORIG-GUID: hT3XKPPqpBvko5QewSulvlWXsfxwBalB
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010104
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Change from v13:
----------------

Fix regression in stress-ng.
Reported-by: kernel test robot <oliver.sang@intel.com>

The fix is to move common-case stores into the 'partial_order' field
of the queue node from cna_wait_head_or_lock() (where those stores
can cause a cache miss during lock handover) to cna_init_node().

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
from the average. The 'stock' kernel is v5.12.0-rc5,
commit 99d4e8b4e609b, compiled in the default configuration. 
'CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set;
The speedup is calculated by dividing the result of 'CNA' by the result
 achieved with 'stock'.

#thr  	 stock     CNA / speedup     
  1  2.675 (0.088) 2.707 (0.100) / 1.012
  2  2.781 (0.172) 2.790 (0.148) / 1.003
  4  4.314 (0.115) 4.403 (0.205) / 1.021
  8  5.085 (0.140) 7.292 (0.210) / 1.434
 16  5.846 (0.114) 9.340 (0.186) / 1.598
 32  6.282 (0.127) 10.074 (0.197) / 1.603
 36  6.382 (0.144) 10.243 (0.198) / 1.605
 72  6.175 (0.086) 10.482 (0.179) / 1.698
108  6.037 (0.073) 10.354 (0.164) / 1.715
142  5.796 (0.072) 10.275 (0.193) / 1.773

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock     CNA / speedup
  1  0.515 (0.002) 0.514 (0.001) / 0.999
  2  0.774 (0.018) 0.780 (0.019) / 1.009
  4  1.408 (0.030) 1.421 (0.034) / 1.009
  8  1.785 (0.082) 1.724 (0.115) / 0.965
 16  1.878 (0.118) 1.775 (0.114) / 0.945
 32  0.914 (0.072) 1.755 (0.105) / 1.920
 36  0.877 (0.064) 1.738 (0.100) / 1.981
 72  0.810 (0.047) 1.658 (0.086) / 2.047
108  0.835 (0.036) 1.756 (0.091) / 2.103
142  0.809 (0.038) 1.766 (0.069) / 2.184

and will-it-scale/lock2_threads:

#thr  	 stock     CNA / speedup
  1  1.605 (0.003) 1.606 (0.005) / 1.000
  2  2.814 (0.077) 2.793 (0.068) / 0.992
  4  5.318 (0.352) 5.463 (0.357) / 1.027
  8  4.241 (0.265) 4.025 (0.366) / 0.949
 16  4.125 (0.124) 3.914 (0.159) / 0.949
 32  2.458 (0.113) 3.950 (0.131) / 1.607
 36  2.457 (0.075) 3.924 (0.080) / 1.597
 72  1.836 (0.102) 3.909 (0.104) / 2.129
108  1.868 (0.098) 3.871 (0.106) / 2.072
142  1.780 (0.124) 3.894 (0.089) / 2.188

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the throughput results (ops/us) for the leveldb ‘readrandom’
benchmark:

#thr  	 stock         CNA / speedup
  1  0.493 (0.034) 0.520 (0.026) / 1.053
  2  0.796 (0.046) 0.838 (0.033) / 1.053
  4  1.172 (0.076) 1.211 (0.043) / 1.033
  8  1.215 (0.096) 1.207 (0.116) / 0.993
 16  0.986 (0.136) 1.070 (0.129) / 1.085
 32  0.756 (0.036) 1.148 (0.021) / 1.519
 36  0.701 (0.032) 1.147 (0.017) / 1.636
 72  0.625 (0.016) 1.149 (0.024) / 1.839
108  0.612 (0.015) 1.146 (0.014) / 1.872
142  0.606 (0.013) 1.131 (0.025) / 1.867

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

 .../admin-guide/kernel-parameters.txt         |  19 +
 arch/arm/include/asm/mcs_spinlock.h           |   6 +-
 arch/x86/Kconfig                              |  20 +
 arch/x86/include/asm/qspinlock.h              |   4 +
 arch/x86/kernel/alternative.c                 |   4 +
 include/asm-generic/mcs_spinlock.h            |   4 +-
 kernel/locking/mcs_spinlock.h                 |  20 +-
 kernel/locking/qspinlock.c                    |  82 +++-
 kernel/locking/qspinlock_cna.h                | 455 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 593 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.24.3 (Apple Git-128)

