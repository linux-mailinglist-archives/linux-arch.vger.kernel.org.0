Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A72B723A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgKQXVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Nov 2020 18:21:14 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgKQXVN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Nov 2020 18:21:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHNDche099783;
        Tue, 17 Nov 2020 23:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=B55fP1Z8KPo2li9ccILewNgHhCoVuSjNDHTjUJIREJw=;
 b=jBHTX1iyuNmjdzpMFHOH/OybWBjOIEaRu8Lo/jBKo1yk4KnRSlBY1YYw732bbztg2oV8
 G/h9zmQGBrTPzWT5Rn92glFvVqisjO3rA4WAkbBdDKpve0B27VF/HwcM3Yd4fcg2IpBO
 xlZDQEb/YmR6LSO4F4YNUPuJ45puydQ1wXRIr84eXgM13nxW8qzBC7kc3mqifvBRdQ7M
 OUnG1FUVpAQO/gLSJGqz7CvZhj0Or2oR5wLS+y1UjGM6H+5zkyxT8vFNlugo4d+Lh91h
 +6pzv+op8KIlXSBylP9PdlB5PpmIWYKUjyI1f11tIsxG0WBbksHayq4uTcPXkFx6p+o+ dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vn59rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 23:13:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHN5T04175582;
        Tue, 17 Nov 2020 23:13:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0rj1f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 23:13:34 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHNDUAG032675;
        Tue, 17 Nov 2020 23:13:30 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Nov 2020 15:13:29 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v12 0/5] Add NUMA-awareness to qspinlock
Date:   Tue, 17 Nov 2020 18:13:18 -0500
Message-Id: <20201117231323.797104-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170173
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Minor change from v11:
----------------

Fix documentation issue, as requested by Randy Dunlap and Longman.
The rest of the series is unchanged.

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
from the average. The 'stock' kernel is v5.10.0-rc2,
commit 4ef8451b3326, compiled in the default configuration. 
'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
the speedup is calculated dividing 'patch-CNA' by 'stock'.

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  2.672 (0.109)  2.679 (0.110)  1.002
  2  3.247 (0.161)  3.276 (0.136)  1.009
  4  4.376 (0.139)  4.820 (0.181)  1.101
  8  5.134 (0.137)  7.125 (0.164)  1.388
 16  5.875 (0.113)  8.903 (0.209)  1.515
 32  6.298 (0.105)  9.911 (0.254)  1.574
 36  6.439 (0.125)  9.972 (0.226)  1.549
 72  6.249 (0.109)  10.375 (0.209)  1.660
108  6.082 (0.063)  10.511 (0.190)  1.728
142  5.822 (0.058)  10.448 (0.177)  1.795

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.508 (0.002)  0.507 (0.002)  0.999
  2  0.759 (0.016)  0.767 (0.019)  1.011
  4  1.397 (0.032)  1.411 (0.029)  1.011
  8  1.694 (0.079)  1.656 (0.120)  0.978
 16  1.867 (0.107)  1.809 (0.121)  0.969
 32  1.006 (0.056)  1.752 (0.093)  1.742
 36  0.934 (0.099)  1.724 (0.064)  1.846
 72  0.804 (0.045)  1.632 (0.073)  2.030
108  0.828 (0.036)  1.690 (0.065)  2.041
142  0.784 (0.035)  1.701 (0.074)  2.168

and will-it-scale/lock2_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  1.590 (0.004)  1.603 (0.005)  1.008
  2  2.802 (0.057)  2.802 (0.063)  1.000
  4  5.478 (0.144)  5.396 (0.299)  0.985
  8  4.166 (0.304)  4.131 (0.402)  0.992
 16  4.147 (0.137)  3.983 (0.173)  0.961
 32  2.492 (0.067)  3.888 (0.125)  1.560
 36  2.471 (0.094)  3.908 (0.112)  1.581
 72  1.886 (0.092)  3.926 (0.106)  2.081
108  1.883 (0.101)  3.935 (0.096)  2.089
142  1.801 (0.112)  3.907 (0.111)  2.169

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the throughput results (ops/us) for the leveldb ‘readrandom’
benchmark:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.532 (0.013)  0.533 (0.023)  1.004
  2  0.836 (0.050)  0.843 (0.031)  1.009
  4  1.039 (0.163)  1.087 (0.151)  1.046
  8  1.095 (0.181)  1.178 (0.165)  1.076
 16  1.002 (0.144)  1.196 (0.019)  1.194
 32  0.726 (0.034)  1.163 (0.026)  1.601
 36  0.691 (0.030)  1.163 (0.020)  1.683
 72  0.627 (0.014)  1.136 (0.022)  1.812
108  0.613 (0.014)  1.143 (0.023)  1.865
142  0.610 (0.014)  1.120 (0.018)  1.838

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Avoid moving certain threads between waiting queues
    in CNA

 Documentation/admin-guide/kernel-parameters.txt |  19 ++
 arch/arm/include/asm/mcs_spinlock.h             |   6 +-
 arch/x86/Kconfig                                |  20 ++
 arch/x86/include/asm/qspinlock.h                |   4 +
 arch/x86/kernel/alternative.c                   |   4 +
 include/asm-generic/mcs_spinlock.h              |   4 +-
 kernel/locking/mcs_spinlock.h                   |  20 +-
 kernel/locking/qspinlock.c                      |  82 ++++-
 kernel/locking/qspinlock_cna.h                  | 421 ++++++++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h             |   2 +-
 10 files changed, 559 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.7.4

