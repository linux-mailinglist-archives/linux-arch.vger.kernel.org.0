Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31DBABB07
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbfIFOew (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 10:34:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34582 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbfIFOev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 10:34:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86ESriM027760;
        Fri, 6 Sep 2019 14:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ln1msFuxC55XcLawoP4IETAw+oUA/Gzn1XLSwiKdyYk=;
 b=PembAiKl/orRaB127QDeBbz156VTQlaJdhuhixItzqyiZg5585oV+hUTAPPP3rYp7Oo6
 vkIfUbnm2Lqv0fjS113HjHJ0N62AV5JtcmC2esurZ7LLu+JuRVEZnIYNJFXPN038SrhP
 7j4LdWAHFkxgn/U8DFO+RHZop4/KHV0E1ZXli6Djz3euW3WCX1+0RSkLXjwCCid/OQ78
 OJMbh7/F9b4oygxlT5ptOvyohjwvR4IJWvbx+o9B/JGenm4URk6HLXy+ynmO7ze2W4kw
 74AC8EPrl0Sdm3Lm9ZAJ1u2qszQlY1omxdlM6P8J7rixIyoGU2YuJdtH0oCG7vj3rgAM Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uus4kg2we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x86EX60T045366;
        Fri, 6 Sep 2019 14:33:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uu1b9t3ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Sep 2019 14:33:07 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x86EWq02027208;
        Fri, 6 Sep 2019 14:32:52 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Sep 2019 07:32:52 -0700
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com,
        rahul.x.yadav@oracle.com
Subject: [PATCH v4 0/5] Add NUMA-awareness to qspinlock
Date:   Fri,  6 Sep 2019 10:25:36 -0400
Message-Id: <20190906142541.34061-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909060153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9372 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909060153
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Changes from v3:
----------------

- Store encoded pointer in @locked, as suggested by Longman.
As a result, mcs_node size is now intact.

- Add a new kernel boot command-line option "numa_spinlock=on/off/auto",
which may override the selection of the NUMA-aware spinlock during boot,
as requested by Longman.

- Add a dependency on QUEUED_SPINLOCKS to NUMA_AWARE_SPINLOCKS and fix 
the help text, as requested by Longman.

- Init the cna_node state in early_initcall(), so we do it only once
instead of every time the node is used, as suggested by Longman.

- Rename macros & functions, refactor cna_try_find_next() (former 
find_successor()), as suggested by Peter.

- Add more commentary, including textual graphics to CNA, as suggested by
Longman and Peter.

- Change the argument in probably() to num_bits, as suggested by Peter.


Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. At the unlock time, the lock
holder scans the main queue looking for a thread running on the same
node. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue. To avoid starvation of threads in the secondary queue,
those threads are moved back to the head of the main queue
after a certain expected number of intra-node lock hand-offs.

More details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 25 runs) of the
total number of ops (x10^7) reported at the end of each run. The 
standard deviation is also reported in (), and in general is about 3%
from the average. The 'stock' kernel is v5.3.0-rc2,
commit 74e6314df6bc, compiled in the default configuration. 
'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
the speedup is calculated dividing 'patch-CNA' by 'stock'.

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  2.692 (0.094)  2.660 (0.100)  0.988
  2  2.634 (0.122)  2.631 (0.136)  0.999
  4  4.152 (0.090)  4.370 (0.152)  1.052
  8  5.420 (0.112)  6.978 (0.237)  1.288
 16  6.593 (0.141)  8.597 (0.253)  1.304
 32  7.335 (0.168)  9.296 (0.223)  1.267
 36  7.505 (0.195)  9.329 (0.251)  1.243
 72  6.552 (0.180)  9.846 (0.256)  1.503
108  6.194 (0.114)  9.901 (0.196)  1.599
142  5.706 (0.093)  9.866 (0.193)  1.729

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.537 (0.001)  0.539 (0.001)  1.003
  2  0.808 (0.021)  0.799 (0.022)  0.988
  4  1.434 (0.031)  1.425 (0.024)  0.994
  8  1.727 (0.102)  1.725 (0.115)  0.999
 16  1.714 (0.094)  1.739 (0.082)  1.015
 32  0.929 (0.070)  1.677 (0.081)  1.804
 36  0.935 (0.087)  1.694 (0.079)  1.812
 72  0.842 (0.040)  1.687 (0.069)  2.004
108  0.842 (0.049)  1.737 (0.074)  2.063
142  0.823 (0.049)  1.744 (0.085)  2.119

and will-it-scale/lock2_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  1.601 (0.013)  1.615 (0.006)  1.009
  2  2.719 (0.060)  2.741 (0.060)  1.008
  4  5.269 (0.392)  5.336 (0.272)  1.013
  8  4.061 (0.302)  4.210 (0.311)  1.037
 16  4.081 (0.113)  4.170 (0.133)  1.022
 32  2.503 (0.104)  4.029 (0.120)  1.610
 36  2.493 (0.104)  3.987 (0.111)  1.599
 72  1.966 (0.092)  3.968 (0.118)  2.019
108  2.084 (0.116)  3.951 (0.121)  1.896
142  1.925 (0.123)  3.877 (0.088)  2.014

We also evaluated the patch on a single-node machine (Intel i7-4770 with 
4 hyperthreaded cores) with will-it-scale, and observed no meaningful
performance impact, as expected. For instance, below are results for 
will-it-scale/open1_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.866 (0.003)  0.867 (0.001)  1.001
  2  1.463 (0.014)  1.463 (0.019)  1.000
  4  2.656 (0.052)  2.671 (0.052)  1.005
  6  2.872 (0.054)  2.857 (0.045)  0.995

Furthermore, we evaluated the patch in the paravirt setup, booting the 
kernel with virtme (qemu) and $(nproc) cores on the same Oracle X5-4 server
as above. We run will-it-scale benchmarks, and once again observed 
no meaningful performance impact. For instance, below are results for
will-it-scale/open1_threads:

#thr  	 stock 	      patch-CNA   speedup (patch-CNA/stock)
  1  0.743 (0.009)  0.747 (0.011)  1.005
  2  0.615 (0.031)  0.611 (0.040)  0.993
  4  0.629 (0.027)  0.619 (0.034)  0.984
  8  0.580 (0.023)  0.574 (0.022)  0.991
 16  0.676 (0.019)  0.680 (0.019)  1.006
 32  0.566 (0.046)  0.562 (0.026)  0.992
 36  0.545 (0.047)  0.544 (0.025)  1.000
 72  0.358 (0.010)  0.361 (0.011)  1.009
108  0.353 (0.013)  0.356 (0.012)  1.010
142  0.350 (0.010)  0.355 (0.008)  1.013

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the results for the leveldb ‘readrandom’ benchmark:

#thr  	 stock        patch-CNA    speedup (patch-CNA/stock)
  1  0.535 (0.010)  0.530 (0.020)  0.990
  2  0.659 (0.023)  0.675 (0.030)  1.024
  4  0.709 (0.017)  0.707 (0.028)  0.998
  8  0.671 (0.026)  0.670 (0.024)  0.999
 16  0.716 (0.017)  0.717 (0.020)  1.002
 32  0.741 (0.036)  1.040 (0.090)  1.403
 36  0.727 (0.042)  1.152 (0.086)  1.585
 72  0.639 (0.028)  1.192 (0.023)  1.863
108  0.621 (0.024)  1.181 (0.028)  1.902
142  0.604 (0.015)  1.158 (0.028)  1.919

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename arch_mcs_spin_unlock_contended to
    arch_mcs_pass_lock and make it more generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 arch/arm/include/asm/mcs_spinlock.h |   4 +-
 arch/x86/Kconfig                    |  19 +++
 arch/x86/include/asm/qspinlock.h    |   4 +
 arch/x86/kernel/alternative.c       |  41 ++++++
 kernel/locking/mcs_spinlock.h       |   8 +-
 kernel/locking/qspinlock.c          |  69 ++++++++-
 kernel/locking/qspinlock_cna.h      | 276 ++++++++++++++++++++++++++++++++++++
 7 files changed, 409 insertions(+), 12 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.11.0 (Apple Git-81)

