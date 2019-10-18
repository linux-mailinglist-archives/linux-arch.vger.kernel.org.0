Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA154DCAD3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfJRQTy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbfJRQTy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:19:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA51610C0943;
        Fri, 18 Oct 2019 16:19:53 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFA125D9CA;
        Fri, 18 Oct 2019 16:19:51 +0000 (UTC)
Subject: Re: [PATCH v5 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com
References: <20191016042903.61081-1-alex.kogan@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <312ebdff-b1fe-489d-384a-bb3f268500f1@redhat.com>
Date:   Fri, 18 Oct 2019 12:19:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191016042903.61081-1-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 18 Oct 2019 16:19:53 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/16/19 12:28 AM, Alex Kogan wrote:
> Changes from v4:
> ----------------
>
> - Switch to a deterministic bound on the number of intra-node handoffs,
> as suggested by Longman.
>
> - Scan the main queue after acquiring the MCS lock and before acquiring 
> the spinlock (pre-scan), as suggested by Longman. If no thread is found 
> in pre-scan, try again after acquiring the spinlock, resuming from the
> same place where pre-scan stopped.
>
> - Convert the secondary queue to a cyclic list such that the tail’s @next
> points to the head of the queue. Store the pointer to the secondary queue
> tail (rather than head) in @locked. This eliminates the need for the @tail
> field in CNA nodes, making space for fields required by the two changes
> above.
>
> - Change arch_mcs_spin_lock_contended() to arch_mcs_spin_lock(), and
> fix misuse of old macro names, as suggested by Hanjun.
>
>
> Summary
> -------
>
> Lock throughput can be increased by handing a lock to a waiter on the
> same NUMA node as the lock holder, provided care is taken to avoid
> starvation of waiters on other NUMA nodes. This patch introduces CNA
> (compact NUMA-aware lock) as the slow path for qspinlock. It is
> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>
> CNA is a NUMA-aware version of the MCS lock. Spinning threads are
> organized in two queues, a main queue for threads running on the same
> node as the current lock holder, and a secondary queue for threads
> running on other nodes. Threads store the ID of the node on which
> they are running in their queue nodes. After acquiring the MCS lock and
> before acquiring the spinlock, the lock holder scans the main queue
> looking for a thread running on the same node (pre-scan). If found (call
> it thread T), all threads in the main queue between the current lock
> holder and T are moved to the end of the secondary queue.  If such T
> is not found, we make another scan of the main queue after acquiring 
> the spinlock when unlocking the MCS lock (post-scan), starting at the
> node where pre-scan stopped. If both scans fail to find such T, the
> MCS lock is passed to the first thread in the secondary queue. If the
> secondary queue is empty, the MCS lock is passed to the next thread in the
> main queue. To avoid starvation of threads in the secondary queue, those
> threads are moved back to the head of the main queue after a certain
> number of intra-node lock hand-offs.
>
> More details are available at https://arxiv.org/abs/1810.05600.
>
> We have done some performance evaluation with the locktorture module
> as well as with several benchmarks from the will-it-scale repo.
> The following locktorture results are from an Oracle X5-4 server
> (four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
> cores each). Each number represents an average (over 25 runs) of the
> total number of ops (x10^7) reported at the end of each run. The 
> standard deviation is also reported in (), and in general is about 3%
> from the average. The 'stock' kernel is v5.4.0-rc1,
> commit d90f2df63c5c, compiled in the default configuration. 
> 'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
> the speedup is calculated dividing 'patch-CNA' by 'stock'.
>
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>   1  2.674 (0.118)  2.736 (0.119)  1.023
>   2  2.588 (0.141)  2.603 (0.108)  1.006
>   4  4.230 (0.120)  4.220 (0.127)  0.998
>   8  5.362 (0.181)  6.679 (0.182)  1.246
>  16  6.639 (0.133)  8.050 (0.200)  1.213
>  32  7.359 (0.149)  8.792 (0.168)  1.195
>  36  7.443 (0.142)  8.873 (0.230)  1.192
>  72  6.554 (0.147)  9.317 (0.158)  1.421
> 108  6.156 (0.093)  9.404 (0.191)  1.528
> 142  5.659 (0.093)  9.361 (0.184)  1.654
>
> The following tables contain throughput results (ops/us) from the same
> setup for will-it-scale/open1_threads: 
>
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>   1  0.532 (0.002)  0.532 (0.003)  1.000
>   2  0.785 (0.024)  0.779 (0.025)  0.992
>   4  1.426 (0.018)  1.409 (0.021)  0.988
>   8  1.779 (0.101)  1.711 (0.127)  0.962
>  16  1.761 (0.093)  1.671 (0.104)  0.949
>  32  0.935 (0.063)  1.619 (0.093)  1.731
>  36  0.936 (0.082)  1.591 (0.086)  1.699
>  72  0.839 (0.043)  1.667 (0.097)  1.988
> 108  0.842 (0.035)  1.701 (0.091)  2.021
> 142  0.830 (0.037)  1.714 (0.098)  2.066
>
> and will-it-scale/lock2_threads:
>
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>   1  1.555 (0.009)  1.577 (0.002)  1.014
>   2  2.644 (0.060)  2.682 (0.062)  1.014
>   4  5.159 (0.205)  5.197 (0.231)  1.007
>   8  4.302 (0.221)  4.279 (0.318)  0.995
>  16  4.259 (0.111)  4.087 (0.163)  0.960
>  32  2.583 (0.112)  4.077 (0.120)  1.578
>  36  2.499 (0.106)  4.076 (0.106)  1.631
>  72  1.979 (0.085)  4.077 (0.123)  2.061
> 108  2.096 (0.090)  4.043 (0.130)  1.929
> 142  1.913 (0.109)  3.984 (0.108)  2.082
>
> Our evaluation shows that CNA also improves performance of user 
> applications that have hot pthread mutexes. Those mutexes are 
> blocking, and waiting threads park and unpark via the futex 
> mechanism in the kernel. Given that kernel futex chains, which
> are hashed by the mutex address, are each protected by a 
> chain-specific spin lock, the contention on a user-mode mutex 
> translates into contention on a kernel level spinlock. 
>
> Here are the results for the leveldb ‘readrandom’ benchmark:
>
> #thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
>   1  0.532 (0.007)  0.535 (0.015)  1.006
>   2  0.665 (0.030)  0.673 (0.034)  1.011
>   4  0.715 (0.023)  0.716 (0.026)  1.002
>   8  0.686 (0.023)  0.686 (0.024)  1.001
>  16  0.719 (0.030)  0.737 (0.025)  1.025
>  32  0.740 (0.034)  0.959 (0.105)  1.296
>  36  0.730 (0.024)  1.079 (0.112)  1.478
>  72  0.652 (0.018)  1.160 (0.024)  1.778
> 108  0.622 (0.016)  1.157 (0.028)  1.860
> 142  0.600 (0.015)  1.145 (0.035)  1.908
>
> Additional performance numbers are available in previous revisions
> of the series.
>
> Further comments are welcome and appreciated.
>
> Alex Kogan (5):
>   locking/qspinlock: Rename mcs lock/unlock macros and make them more
>     generic
>   locking/qspinlock: Refactor the qspinlock slow path
>   locking/qspinlock: Introduce CNA into the slow path of qspinlock
>   locking/qspinlock: Introduce starvation avoidance into CNA
>   locking/qspinlock: Introduce the shuffle reduction optimization into
>     CNA
>
>  arch/arm/include/asm/mcs_spinlock.h |   6 +-
>  arch/x86/Kconfig                    |  19 +++
>  arch/x86/include/asm/qspinlock.h    |   4 +
>  arch/x86/kernel/alternative.c       |  41 +++++
>  include/asm-generic/mcs_spinlock.h  |   4 +-
>  kernel/locking/mcs_spinlock.h       |  20 +--
>  kernel/locking/qspinlock.c          |  77 ++++++++-
>  kernel/locking/qspinlock_cna.h      | 312 ++++++++++++++++++++++++++++++++++++
>  kernel/locking/qspinlock_paravirt.h |   2 +-
>  9 files changed, 462 insertions(+), 23 deletions(-)
>  create mode 100644 kernel/locking/qspinlock_cna.h
>
I have reviewed this patchset. Asides from a few issues I had raised in
earlier emails, I don't see other problems in the code. Thanks for your
hard work. I think we are almost there.

Cheers,
Longman

