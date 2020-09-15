Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378C526AB8C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 20:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgIOSJp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 14:09:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37018 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIOSJQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 14:09:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FHxqcl172803;
        Tue, 15 Sep 2020 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=iBGwFtDJQwKDTanZplyFMP1ELSKxvvgTUW3+kTna1IY=;
 b=PG+lcgR1wxd2HJ4BifmJW9O3xBMJS42PbVmZOi4tNAProTnHAWCcJaM0CvJG98RDG0qR
 FvO9pya5/45sdaW0VuTb+AJrHcR8WyAQplU9phEWfJApWiDVVtQJGB+C6ANcYnq7GcXG
 cUKEkL3hJuQTY8qcsh3qrbAjRcPFSeYvDN3uA9awrNsWbkfRoWC/OHUPf/S/TM0r1bLz
 1bLGJTgwdanq19rw4ORECotLqm9snv3Wqrx/7EhAvU/ubtqACKcMw6Vylp8NqI2eT4aV
 7VK6rmaJ8vVbKl0oIR85FIgXCNqJRNUMWMkYRjdzOIudZkUYrqlC94D7ZudokzArrh+X cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrqxs0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 18:07:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FI5RPL144404;
        Tue, 15 Sep 2020 18:05:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33h885mg9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 18:05:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08FI5jfv009831;
        Tue, 15 Sep 2020 18:05:45 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 18:05:45 +0000
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v11 0/5] Add NUMA-awareness to qspinlock
Date:   Tue, 15 Sep 2020 14:05:30 -0400
Message-Id: <20200915180535.2975060-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150145
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes from v10:
----------------

- Revise the scan function to move waiters into the secondary queue
one at a time. This way, the worst case complexity of cna_order_queue()
decreases from O(n) down to O(1), as we always “scan" only one waiter.

- Make the decision on when to flush the secondary queue and
force lock transition to a waiter on a different NUMA node to be
timer-based rather than a counter-based one, as suggested in a patch
povided by Longman.

- Make prioritized waiters to inherit the NUMA node id of the primary
queue, to maintain the preference even if the prioritized waiter is on a
different node. This is based on the patch provided by Longman.

The relative performance numbers with the revised series (included below)
have not changed much.

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
from the average. The 'stock' kernel is v5.9.0-rc4,
commit f4d51dffc6c0, compiled in the default configuration. 
'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
the speedup is calculated dividing 'patch-CNA' by 'stock'.

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  2.682 (0.100)  2.695 (0.075)  1.005
  2  2.810 (0.155)  2.797 (0.145)  0.995
  4  4.273 (0.134)  4.294 (0.159)  1.005
  8  5.071 (0.108)  6.755 (0.198)  1.332
 16  5.840 (0.125)  8.940 (0.188)  1.531
 32  6.246 (0.113)  9.866 (0.220)  1.580
 36  6.355 (0.096)  9.968 (0.215)  1.569
 72  6.129 (0.116)  10.231 (0.210)  1.669
108  5.921 (0.084)  10.246 (0.208)  1.731
142  5.763 (0.089)  10.186 (0.238)  1.768

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.498 (0.003)  0.513 (0.001)  1.029
  2  0.793 (0.014)  0.803 (0.017)  1.012
  4  1.429 (0.027)  1.455 (0.027)  1.019
  8  1.667 (0.089)  1.687 (0.132)  1.012
 16  1.785 (0.047)  1.716 (0.068)  0.961
 32  1.000 (0.064)  1.738 (0.107)  1.737
 36  0.934 (0.073)  1.744 (0.076)  1.867
 72  0.823 (0.043)  1.651 (0.071)  2.007
108  0.821 (0.031)  1.695 (0.063)  2.065
142  0.787 (0.027)  1.723 (0.069)  2.190

and will-it-scale/lock2_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  1.600 (0.002)  1.614 (0.004)  1.009
  2  2.792 (0.066)  2.813 (0.060)  1.007
  4  5.395 (0.379)  5.210 (0.500)  0.966
  8  4.285 (0.278)  4.125 (0.413)  0.963
 16  4.168 (0.134)  3.960 (0.146)  0.950
 32  2.450 (0.106)  3.999 (0.141)  1.632
 36  2.403 (0.106)  3.922 (0.106)  1.632
 72  1.842 (0.098)  3.913 (0.091)  2.124
108  1.888 (0.116)  3.937 (0.074)  2.085
142  1.806 (0.113)  3.894 (0.107)  2.156

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the results for the leveldb ‘readrandom’ benchmark:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.529 (0.023)  0.525 (0.029)  0.993
  2  0.829 (0.045)  0.847 (0.036)  1.021
  4  1.122 (0.112)  1.144 (0.132)  1.020
  8  1.126 (0.145)  1.124 (0.186)  0.998
 16  1.029 (0.145)  1.207 (0.024)  1.173
 32  0.721 (0.037)  1.158 (0.026)  1.605
 36  0.690 (0.043)  1.159 (0.028)  1.680
 72  0.622 (0.016)  1.136 (0.020)  1.826
108  0.608 (0.013)  1.144 (0.017)  1.882
142  0.602 (0.014)  1.122 (0.020)  1.864

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Avoid moving certain threads between waiting queues
    in CNA

 .../admin-guide/kernel-parameters.txt         |  19 +
 arch/arm/include/asm/mcs_spinlock.h           |   6 +-
 arch/x86/Kconfig                              |  20 +
 arch/x86/include/asm/qspinlock.h              |   4 +
 arch/x86/kernel/alternative.c                 |   4 +
 include/asm-generic/mcs_spinlock.h            |   4 +-
 kernel/locking/mcs_spinlock.h                 |  20 +-
 kernel/locking/qspinlock.c                    |  82 +++-
 kernel/locking/qspinlock_cna.h                | 421 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 559 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.21.1 (Apple Git-122.3)

