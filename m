Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417F82E1892
	for <lists+linux-arch@lfdr.de>; Wed, 23 Dec 2020 06:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgLWFq6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Dec 2020 00:46:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50366 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLWFq6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Dec 2020 00:46:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5iQDc037107;
        Wed, 23 Dec 2020 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=gXVY/WoP/raeAmFueRDSPYWEL1jYcUS6IybvQWOvMNM=;
 b=eLMXhHI29SPrVhu4+Ulp2nU8egn5Y0KDkFCQJU9pbN4tENH+ei6tyPZk8eRfx8L5Fbzu
 ByAoD3tkafUKSGyLAcfR7TqzCG7+huDVWc7lwa5UFKUJsYG83uUBmIhL8oaK6zkfePdY
 SKFhO2WY01MjvnOt2VU+qjD0kxPz4y7wHdaaIP4xa6W/xBJpSFlWXM9Y5gLpM2uxGZcJ
 2DziYU0BFbAKcwGIad8Vtf7QaJRAk0E6XOaQm5tdk5/tYDdyQYxtboPs2iUGpD5A1gEw
 mfqkXpCj052lzgSzBImpPRZlvm9eTwaqvjfiNDtQ3+r30riLD/uGDtl1cSiV4LYZMPlx Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35k0cw6ba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Dec 2020 05:45:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BN5ec2f062410;
        Wed, 23 Dec 2020 05:45:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35k0eu0ufe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 05:45:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BN5j6Pt014400;
        Wed, 23 Dec 2020 05:45:06 GMT
Received: from neelam.us.oracle.com (/10.152.128.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Dec 2020 21:45:05 -0800
From:   Alex Kogan <alex.kogan@oracle.com>
To:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        alex.kogan@oracle.com, dave.dice@oracle.com
Subject: [PATCH v13 0/6] Add NUMA-awareness to qspinlock
Date:   Wed, 23 Dec 2020 00:44:49 -0500
Message-Id: <20201223054455.1990884-1-alex.kogan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9843 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012230042
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Change from v12:
----------------

Added a shuffle reduction optimization (SRO, last patch in the series)
in order to address the regression in unixbench.
Reported-by: kernel test robot <oliver.sang@intel.com>

I note that despite my initial experiments, a more thorough testing 
on our system did not reproduce the regression.

The rest of the series remains unchanged.

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
from the average. The 'stock' kernel is v5.10.0-rc7,
commit ca4bbdaf1716, compiled in the default configuration. 
'CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set;
'CNA-wo-SRO' is the modified kernel with NUMA_AWARE_SPINLOCKS set 
and without the last patch in the series (the SRO optimization).
The speedup is calculated by dividing the result of the corresponding 
variant by the result achieved with 'stock'.

#thr  	 stock     CNA-wo-SRO / speedup     CNA / speedup
  1  2.707 (0.127) 2.693 (0.100) / 0.995  2.718 (0.101) / 1.004
  2  3.262 (0.075) 3.250 (0.132) / 0.996  3.246 (0.098) / 0.995
  4  4.331 (0.125) 4.804 (0.184) / 1.109  4.733 (0.143) / 1.093
  8  5.092 (0.148) 6.996 (0.206) / 1.374  7.000 (0.194) / 1.375
 16  5.865 (0.119) 8.763 (0.161) / 1.494  8.778 (0.217) / 1.497
 32  6.314 (0.098) 9.837 (0.256) / 1.558  9.720 (0.167) / 1.539
 36  6.434 (0.101) 9.929 (0.259) / 1.543  9.988 (0.208) / 1.552
 72  6.342 (0.080) 10.416 (0.244) / 1.642  10.224 (0.203) / 1.612
108  6.168 (0.080) 10.490 (0.199) / 1.701  10.334 (0.173) / 1.675
142  5.895 (0.119) 10.480 (0.171) / 1.778  10.424 (0.222) / 1.768

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock     CNA-wo-SRO / speedup     CNA / speedup
  1  0.508 (0.001) 0.507 (0.001) / 0.997  0.508 (0.001) / 0.999
  2  0.755 (0.021) 0.764 (0.018) / 1.012  0.757 (0.017) / 1.002
  4  1.409 (0.027) 1.417 (0.024) / 1.006  1.387 (0.027) / 0.984
  8  1.726 (0.092) 1.657 (0.129) / 0.960  1.654 (0.135) / 0.959
 16  1.878 (0.099) 1.811 (0.100) / 0.964  1.761 (0.087) / 0.938
 32  1.012 (0.040) 1.705 (0.086) / 1.685  1.685 (0.081) / 1.666
 36  0.930 (0.088) 1.726 (0.090) / 1.855  1.727 (0.086) / 1.856
 72  0.826 (0.037) 1.645 (0.079) / 1.991  1.621 (0.076) / 1.962
108  0.845 (0.028) 1.685 (0.072) / 1.993  1.688 (0.073) / 1.997
142  0.827 (0.035) 1.712 (0.069) / 2.070  1.696 (0.064) / 2.052

and will-it-scale/lock2_threads:

#thr  	 stock     CNA-wo-SRO / speedup     CNA / speedup
  1  1.587 (0.004) 1.564 (0.003) / 0.985  1.577 (0.002) / 0.994
  2  2.802 (0.057) 2.752 (0.049) / 0.982  2.776 (0.065) / 0.991
  4  5.365 (0.352) 5.368 (0.196) / 1.001  5.348 (0.297) / 0.997
  8  4.161 (0.270) 4.001 (0.402) / 0.962  4.032 (0.389) / 0.969
 16  4.144 (0.130) 3.940 (0.159) / 0.951  3.917 (0.133) / 0.945
 32  2.444 (0.097) 3.996 (0.102) / 1.635  3.969 (0.130) / 1.624
 36  2.429 (0.070) 3.891 (0.087) / 1.602  3.894 (0.096) / 1.603
 72  1.847 (0.095) 3.929 (0.108) / 2.128  3.942 (0.094) / 2.135
108  1.903 (0.117) 3.898 (0.108) / 2.048  3.901 (0.105) / 2.050
142  1.841 (0.124) 3.929 (0.097) / 2.135  3.921 (0.105) / 2.130

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the throughput results (ops/us) for the leveldb ‘readrandom’
benchmark:

#thr  	 stock     CNA-wo-SRO / speedup     CNA / speedup
  1  0.535 (0.017) 0.531 (0.022) / 0.991  0.532 (0.020) / 0.993
  2  0.845 (0.046) 0.837 (0.034) / 0.991  0.840 (0.048) / 0.994
  4  1.097 (0.133) 1.055 (0.130) / 0.962  1.127 (0.119) / 1.027
  8  1.091 (0.190) 1.109 (0.187) / 1.017  1.082 (0.213) / 0.992
 16  0.986 (0.161) 1.139 (0.145) / 1.155  1.073 (0.170) / 1.088
 32  0.739 (0.032) 1.154 (0.016) / 1.562  1.155 (0.022) / 1.564
 36  0.693 (0.022) 1.164 (0.020) / 1.680  1.147 (0.021) / 1.655
 72  0.623 (0.015) 1.136 (0.021) / 1.824  1.128 (0.021) / 1.811
108  0.610 (0.017) 1.135 (0.018) / 1.861  1.123 (0.020) / 1.842
142  0.602 (0.010) 1.118 (0.021) / 1.855  1.115 (0.022) / 1.850

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
 kernel/locking/qspinlock_cna.h                | 458 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 596 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.24.3 (Apple Git-128)

