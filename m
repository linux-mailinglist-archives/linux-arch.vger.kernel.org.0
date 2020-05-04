Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB51C3CFB
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgEDO2y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 10:28:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728641AbgEDO2y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2020 10:28:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EHbo1063496;
        Mon, 4 May 2020 14:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=94tGbpbZfrGPx3PEjMKqajez4HYY6/WnYiRMTWfEfxw=;
 b=J3RmePcR8ShrP9iW8ROqyeXm145NYHpekoIbMSM0ekGOLfQtOEQ9ulAhaiGKtTVU0IMz
 iXxjbhxvn6qw003ElQAWZ9WP3F8Vw+Vy4VkO4kmXsMnzQFNNV1SrB2VbUcpEwQqZgIaw
 J+O/3cKNbFh3/CTBRhm90ZSjP+U8dECBFINzMOWqhMCeajnrd8mWsRBQxkUnta0uPHDd
 NYaoSF4UpCOWgSeKdPJ08KijlEwwtdUI9iDA3NuCXd+aD6iR6quaXFlRAgowHt/vprhP
 GSxUJlILuylz/MHb4/Fz3jSbnsQ8gn9/KQ1onFL9+flK+ht+2anuRncWCAYMZGzMw7Md 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09qy6kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:18:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044E5Vqi062768;
        Mon, 4 May 2020 14:18:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30sjnasb8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:18:09 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044EHxd0000815;
        Mon, 4 May 2020 14:17:59 GMT
Received: from [192.168.0.159] (/108.20.144.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:17:59 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v10 0/5] Add NUMA-awareness to qspinlock
From:   Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20200403205930.1707-1-alex.kogan@oracle.com>
Date:   Mon, 4 May 2020 10:17:56 -0400
Cc:     linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        dave.dice@oracle.com, Alex Kogan <alex.kogan@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DE89034-0388-4F62-A75D-898EE53D45A7@oracle.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040118
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Peter, Longman (and everyone on this list),

Hope you are doing well.

I was wondering whether you have had a chance to review this series,
and have any further comments.

Thanks,
=E2=80=94 Alex

> On Apr 3, 2020, at 4:59 PM, Alex Kogan <alex.kogan@oracle.com> wrote:
>=20
> Changes from v9:
> ----------------
>=20
> - Revise the series based on Peter's version, adopting names, style, =
etc.
>=20
> - Add a new patch that allows to prioritize certain threads (e.g., in=20=

> irq and nmi contexts) and avoids moving them between waiting queues,
> based on the suggestion by Longman.
>=20
> - Drop the shuffle reduction optimization from the series (new =
performance
> data did not justify it).
>=20
> - Do not call cna_init_nodes() as an early_initcall (call it from=20
> cna_configure_spin_lock_slowpath() instead), based on the comment from=20=

> Longman.
>=20
>=20
> Summary
> -------
>=20
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA node as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA nodes. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>=20
> CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> organized in two queues, a primary queue for threads running on the =
same
> node as the current lock holder, and a secondary queue for threads
> running on other nodes. Threads store the ID of the node on which
> they are running in their queue nodes. After acquiring the MCS lock =
and
> before acquiring the spinlock, the lock holder scans the primary queue
> looking for a thread running on the same node (pre-scan). If found =
(call
> it thread T), all threads in the primary queue between the current =
lock
> holder and T are moved to the end of the secondary queue.  If such T
> is not found, we make another scan of the primary queue after =
acquiring=20
> the spinlock when unlocking the MCS lock (post-scan), starting at the
> node where pre-scan stopped. If both scans fail to find such T, the
> MCS lock is passed to the first thread in the secondary queue. If the
> secondary queue is empty, the MCS lock is passed to the next thread in =
the
> primary queue. To avoid starvation of threads in the secondary queue, =
those
> threads are moved back to the head of the primary queue after a =
certain
> number of intra-node lock hand-offs. Lastly, certain threads (e.g., in
> in irq and nmi contexts) are given a preferential treatment -- the =
scan
> stops when such a thread is found, effectively never moving those =
threads=20
> into the secondary queue.
>=20
> More details are available at https://arxiv.org/abs/1810.05600.
>=20
> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 25 runs) of the
> total number of ops (x10^7) reported at the end of each run. The=20
> standard deviation is also reported in (), and in general is about 3%
> from the average. The 'stock' kernel is v5.6.0-rc6,
> commit 5ad0ec0b8652, compiled in the default configuration.=20
> 'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set;=20
> the speedup is calculated dividing 'patch-CNA' by 'stock'.
>=20
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>  1  2.702 (0.100)  2.712 (0.122)  1.003
>  2  3.691 (0.162)  3.672 (0.138)  0.995
>  4  4.285 (0.108)  4.256 (0.124)  0.993
>  8  5.117 (0.133)  5.972 (0.258)  1.167
> 16  6.273 (0.196)  7.628 (0.274)  1.216
> 32  6.757 (0.122)  8.544 (0.225)  1.264
> 36  6.761 (0.091)  8.691 (0.170)  1.285
> 72  6.569 (0.132)  9.280 (0.225)  1.413
> 108  6.167 (0.112)  9.410 (0.171)  1.526
> 142  5.901 (0.117)  9.415 (0.211)  1.595
>=20
> The following tables contain throughput results (ops/us) from the same
> setup for will-it-scale/open1_threads:=20
>=20
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>  1  0.511 (0.002)  0.525 (0.003)  1.027
>  2  0.774 (0.018)  0.769 (0.017)  0.993
>  4  1.352 (0.023)  1.372 (0.032)  1.014
>  8  1.675 (0.090)  1.660 (0.136)  0.991
> 16  1.665 (0.114)  1.583 (0.092)  0.951
> 32  0.966 (0.038)  1.637 (0.087)  1.694
> 36  0.973 (0.066)  1.570 (0.081)  1.613
> 72  0.844 (0.040)  1.620 (0.091)  1.919
> 108  0.836 (0.040)  1.670 (0.084)  1.999
> 142  0.799 (0.043)  1.699 (0.087)  2.127
>=20
> and will-it-scale/lock2_threads:
>=20
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>  1  1.581 (0.004)  1.576 (0.007)  0.997
>  2  2.699 (0.059)  2.687 (0.067)  0.996
>  4  5.240 (0.234)  5.155 (0.252)  0.984
>  8  4.370 (0.241)  4.111 (0.342)  0.941
> 16  4.152 (0.112)  4.113 (0.164)  0.991
> 32  2.579 (0.099)  4.099 (0.127)  1.589
> 36  2.604 (0.066)  4.005 (0.104)  1.538
> 72  2.028 (0.091)  4.024 (0.112)  1.984
> 108  2.079 (0.106)  3.997 (0.093)  1.923
> 142  1.858 (0.103)  3.955 (0.109)  2.129
>=20
> Our evaluation shows that CNA also improves performance of user=20
> applications that have hot pthread mutexes. Those mutexes are=20
> blocking, and waiting threads park and unpark via the futex=20
> mechanism in the kernel. Given that kernel futex chains, which
> are hashed by the mutex address, are each protected by a=20
> chain-specific spin lock, the contention on a user-mode mutex=20
> translates into contention on a kernel level spinlock.=20
>=20
> Here are the results for the leveldb =E2=80=98readrandom=E2=80=99 =
benchmark:
>=20
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>  1  0.530 (0.013)  0.533 (0.011)  1.006
>  2  0.839 (0.043)  0.847 (0.031)  1.010
>  4  0.758 (0.021)  0.764 (0.018)  1.008
>  8  0.677 (0.022)  0.682 (0.016)  1.008
> 16  0.714 (0.023)  0.814 (0.027)  1.140
> 32  0.765 (0.040)  1.168 (0.032)  1.527
> 36  0.706 (0.023)  1.139 (0.066)  1.614
> 72  0.624 (0.017)  1.184 (0.026)  1.898
> 108  0.605 (0.013)  1.147 (0.023)  1.894
> 142  0.593 (0.012)  1.131 (0.019)  1.908
>=20
> Further comments are welcome and appreciated.
>=20
> Alex Kogan (5):
>  locking/qspinlock: Rename mcs lock/unlock macros and make them more
>    generic
>  locking/qspinlock: Refactor the qspinlock slow path
>  locking/qspinlock: Introduce CNA into the slow path of qspinlock
>  locking/qspinlock: Introduce starvation avoidance into CNA
>  locking/qspinlock: Avoid moving certain threads between waiting =
queues
>    in CNA
>=20
> .../admin-guide/kernel-parameters.txt         |  18 +
> arch/arm/include/asm/mcs_spinlock.h           |   6 +-
> arch/x86/Kconfig                              |  20 +
> arch/x86/include/asm/qspinlock.h              |   6 +
> arch/x86/kernel/alternative.c                 |   2 +
> include/asm-generic/mcs_spinlock.h            |   4 +-
> kernel/locking/mcs_spinlock.h                 |  20 +-
> kernel/locking/qspinlock.c                    |  82 +++-
> kernel/locking/qspinlock_cna.h                | 407 ++++++++++++++++++
> kernel/locking/qspinlock_paravirt.h           |   2 +-
> 10 files changed, 544 insertions(+), 23 deletions(-)
> create mode 100644 kernel/locking/qspinlock_cna.h
>=20
> --=20
> 2.21.1 (Apple Git-122.3)
>=20

