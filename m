Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD2F364C
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfKGRyU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 12:54:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60368 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfKGRyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 12:54:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Hj18W001450;
        Thu, 7 Nov 2019 17:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=cP3odovDn+b8l22dKmKV8q2Mp2Ep7jYU9ngn8YvoPEM=;
 b=kkeppDWvq5LseXZ7DDEvhTVO157mnZGu2hk+C2ampz6VYdXmimU/BI55qnSltRC7wvqb
 JvK2X4EoTDAz19GgqiYLpegozuIkVm0ah6krBTu2h0njH2HQ1GX2zUNHW7pzerIEL4/L
 rclTXKC5HUVechhOgMd7MbdTXECda04KULLkYhowwdzlw38jQ/U7r+lWut8Er6RDshBv
 ZgkmtJxp2yTq5G4Qb8NvQ7+eXbg37waxFHbdxPFnxgaEWAcgH76lj5gm+VWPCqZQ76mD
 XeBGa/sifmgf3XhFQL1tJIShcNhm3xaVI/5A5SIu0cDfjl41yYlQljQpsyQXBwl0X7K/ yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w41w0yx6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:53:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Hj29l038325;
        Thu, 7 Nov 2019 17:51:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w41wffu1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 17:51:27 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7HpHGR009182;
        Thu, 7 Nov 2019 17:51:17 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 09:51:16 -0800
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
Subject: [PATCH v6 0/5] Add NUMA-awareness to qspinlock
Date:   Thu,  7 Nov 2019 12:46:17 -0500
Message-Id: <20191107174622.61718-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070165
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Minor changes from v5, mainly based on feedback from Longman:
-------------------------------------------------------------

- Make the intra node handoff threshold a configurable parameter 
via the new kernel boot command-line option "numa_spinlock_threshold".

- Add documentation of new command-line options in kernel-parameters.txt.

- Small fix in cna_try_change_tail() (use cmpxhg_relaxed()).

- Small fix in cna_init_nodes() (return 0).

- Minor changes in cna_pass_lock(). 


Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. After acquiring the MCS lock and
before acquiring the spinlock, the lock holder scans the main queue
looking for a thread running on the same node (pre-scan). If found (call
it thread T), all threads in the main queue between the current lock
holder and T are moved to the end of the secondary queue.  If such T
is not found, we make another scan of the main queue after acquiring 
the spinlock when unlocking the MCS lock (post-scan), starting at the
node where pre-scan stopped. If both scans fail to find such T, the
MCS lock is passed to the first thread in the secondary queue. If the
secondary queue is empty, the MCS lock is passed to the next thread in the
main queue. To avoid starvation of threads in the secondary queue, those
threads are moved back to the head of the main queue after a certain
number of intra-node lock hand-offs.

More details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 25 runs) of the
total number of ops (x10^7) reported at the end of each run. The 
standard deviation is also reported in (), and in general is about 3%
from the average. The 'stock' kernel is v5.4.0-rc5,
commit 7c5e136a02ba, compiled in the default configuration. 
'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
the speedup is calculated dividing 'patch-CNA' by 'stock'.

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  2.726 (0.107)  2.729 (0.096)  1.001
  2  2.656 (0.113)  2.666 (0.116)  1.004
  4  4.147 (0.085)  4.255 (0.135)  1.026
  8  5.388 (0.146)  6.642 (0.155)  1.233
 16  6.688 (0.152)  8.035 (0.162)  1.202
 32  7.389 (0.203)  8.751 (0.192)  1.184
 36  7.420 (0.179)  8.818 (0.173)  1.188
 72  6.489 (0.122)  9.403 (0.252)  1.449
108  6.163 (0.078)  9.504 (0.177)  1.542
142  5.736 (0.105)  9.371 (0.181)  1.634

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.533 (0.001)  0.534 (0.002)  1.003
  2  0.787 (0.020)  0.801 (0.022)  1.017
  4  1.418 (0.031)  1.421 (0.022)  1.002
  8  1.745 (0.112)  1.736 (0.104)  0.995
 16  1.779 (0.104)  1.696 (0.090)  0.953
 32  0.923 (0.060)  1.634 (0.109)  1.771
 36  0.899 (0.087)  1.636 (0.108)  1.821
 72  0.837 (0.038)  1.615 (0.086)  1.928
108  0.841 (0.044)  1.715 (0.087)  2.041
142  0.802 (0.040)  1.734 (0.085)  2.163

and will-it-scale/lock2_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  1.590 (0.013)  1.583 (0.010)  0.995
  2  2.714 (0.054)  2.697 (0.051)  0.994
  4  5.251 (0.311)  5.252 (0.217)  1.000
  8  4.358 (0.301)  4.309 (0.305)  0.989
 16  4.219 (0.140)  4.161 (0.114)  0.986
 32  2.547 (0.117)  4.134 (0.084)  1.623
 36  2.560 (0.071)  4.127 (0.122)  1.612
 72  1.982 (0.086)  4.097 (0.106)  2.067
108  2.114 (0.089)  4.082 (0.105)  1.930
142  1.923 (0.100)  4.024 (0.086)  2.093

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the results for the leveldb ‘readrandom’ benchmark:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.533 (0.014)  0.533 (0.016)  1.001
  2  0.667 (0.029)  0.669 (0.027)  1.003
  4  0.699 (0.018)  0.714 (0.026)  1.021
  8  0.692 (0.020)  0.696 (0.026)  1.005
 16  0.730 (0.029)  0.733 (0.027)  1.004
 32  0.726 (0.034)  0.978 (0.118)  1.348
 36  0.740 (0.042)  1.099 (0.111)  1.485
 72  0.671 (0.033)  1.167 (0.021)  1.739
108  0.633 (0.017)  1.161 (0.028)  1.834
142  0.606 (0.016)  1.144 (0.018)  1.887

Additional performance numbers are available in previous revisions
of the series.

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 Documentation/admin-guide/kernel-parameters.txt |  18 ++
 arch/arm/include/asm/mcs_spinlock.h             |   6 +-
 arch/x86/Kconfig                                |  19 ++
 arch/x86/include/asm/qspinlock.h                |   4 +
 arch/x86/kernel/alternative.c                   |  70 ++++++
 include/asm-generic/mcs_spinlock.h              |   4 +-
 kernel/locking/mcs_spinlock.h                   |  20 +-
 kernel/locking/qspinlock.c                      |  77 +++++-
 kernel/locking/qspinlock_cna.h                  | 315 ++++++++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h             |   2 +-
 10 files changed, 512 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.11.0 (Apple Git-81)

