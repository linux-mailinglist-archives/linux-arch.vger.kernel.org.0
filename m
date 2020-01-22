Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD3145400
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 12:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAVLpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 06:45:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33621 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgAVLpo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 06:45:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so6467827lji.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2020 03:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5u9m/mXXv3qGtttJOr+ZQn1NxnHC+oWL5hWs/7rdpQ=;
        b=SUl/bopx2bJT7lmPLWd3o6amTlItaE15S5QUQfpwhG6UqVhYZ2Jg2lvsdxAxz/6qC9
         Ich5ivJBKveIjiwnfrUDkpXtD/imTj/icyVWY8pSc1Rwvly1XEFvO++i/UqDXwN+babS
         9RCM/fSTAK0LsLdHswNo3m4uFnjF9XLoLLIsbSAzdhZUylVamYpnfBh3vdMOyB70VR8Z
         Amw8oBRcU/K9bIdyzw97J0CAuwdFIA4Jzz1wejySdc+kLIhuwDoU04KPhg7MAdLmSvf2
         AFX8yOIOTYA3NR+XYKUSWizt04FzuJcoi1ZJeJwmg9i7GnHqYozyO3DA7e4xvN8DWcKB
         pvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5u9m/mXXv3qGtttJOr+ZQn1NxnHC+oWL5hWs/7rdpQ=;
        b=IvKjVzqReA3cnuljyDwT4ZtdtKoSqsVZ1T7SZ8jZp7DYY+yUeY91B4NYN6c/r6lQ9N
         26+3sGmK3mqdZT+rHSaqkNrnGgaSKD+m/Ep+pV1tDWP63IWZT1T+LpWc445C8QkS/zIW
         E8P69Nv6isO3dT70wETwpb0XXfA/FmFBqombT3YzL0naleyJsJ14Fp0U1w73pflB9iDi
         Iyk8Hh7cEixI3ztKh2LrEQODP7w53QZxOJJ3rNivhiYpyMn1tlkoQYV3QK/GIcht6AU6
         EFo/W+j7AflJ2wy0yTcYYZ5iLxpifsAr++YWaPOwGIw0pDEK5Df1esn44TFvKVueP+GH
         W/hg==
X-Gm-Message-State: APjAAAWx1/PATI6X29Xu+NLHPl9IB7WdE4pfI574NoTrL7MFTmcdKkS2
        isCOT4iNnHgLwJJ4UZXuOjZtiOwe4wy4qvFg/59GHQ==
X-Google-Smtp-Source: APXvYqxepdt1nLuP0XWlvF18+vx5QEljXf8IakWWWuD2ONWwD2IDzKv7dxNfcNDOYiBfRJoQtOTepLrUdy4OOP5K0r0=
X-Received: by 2002:a2e:8698:: with SMTP id l24mr18861072lji.94.1579693541815;
 Wed, 22 Jan 2020 03:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20200115035920.54451-1-alex.kogan@oracle.com>
In-Reply-To: <20200115035920.54451-1-alex.kogan@oracle.com>
From:   Lihao Liang <lihaoliang@google.com>
Date:   Wed, 22 Jan 2020 11:45:30 +0000
Message-ID: <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
To:     Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com,
        will.deacon@arm.com, arnd@arndb.de, longman@redhat.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com,
        jglauber@marvell.com, dave.dice@oracle.com,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alex,

On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
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

Thanks for your patches. The experimental results look promising!

I understand that the new CNA qspinlock uses randomization to achieve
long-term fairness, and provides the numa_spinlock_threshold parameter
for users to tune. As Linux runs extremely diverse workloads, it is not
clear how randomization affects its fairness, and how users with
different requirements are supposed to tune this parameter.

To this end, Will and I consider it beneficial to be able to answer the
following question:

With different values of numa_spinlock_threshold and
SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
sockets have to wait to acquire the lock? This is particularly relevant
in high contention situations when new threads keep arriving on the same
socket as the lock holder.

In this email, I try to provide some formal analysis to address this
question. Let's assume the probability for the lock to stay on the
same socket is *at least* p, which corresponds to the probability for
the function probably(unsigned int num_bits) in the patch to return *false*,
where SHUFFLE_REDUCTION_PROB_ARG is passed as the value of num_bits to the
function.

I noticed that the default value of p in the patch is 1/2^7 = 0.01, which is
somewhat counter-intuitive to me. If we switch sockets 99 times out of 100,
then fairness should be obvious. What I expected is a (much) higher value of
p, which would likely result in better performance, while having some degree
of fairness guarantee. Have you run some experiments by setting a lower
SHUFFLE_REDUCTION_PROB_ARG instead of the default value 7? It would be very
helpful to know the performance numbers.

Now let's do some analysis:

1. What is the probability P for the first thread on a different socket to
acquire the lock after *at most* N consecutive local lock handovers?

Note: N corresponds to the variable intra_node_handoff_threshold in the
patch, which is set to value 1 << numa_spinlock_threshold. Default value
is 1 << 16 = 64K.

Assuming mutual independence [1], we have P is equal to 1 - p^N, where p^N is
the probability of N consecutive threads running on the socket where the lock
was most recently acquired.

If p is 0.99, the probabilities of switching to a different socket after
N local lock handovers are as follows:

63.4% (N = 100)
86.6% (N = 200)
99.3% (N = 500)
99.996% (N = 1000)
99.99999999999933% (N =  64K)

2. We can ask the same question as above for the k-th thread on a different
socket from the lock holder. That is, what is the probability P for the k-th
thread on a different socket to acquire the lock after *at most* N
consecutive local lock handovers, assuming all these k threads in the queue
are running on different sockets (the worst case scenario). The analysis is
as follows (the case when k = 1 reduces to Question 1 above):

The total probability P is the sum of Pi for i = 0, 1, ..., N, where Pi is
the probability of having i *total* local lock handovers before the k-th
thread on a different socket can acquire the lock.

Pi can be calculated using formula Pi =  B_i_k * (p^i) * (1 - p)^k, where

-- B_i_k is the number of ways to put i balls into k buckets, representing
all possible ways the i local handovers occurred in k different sockets.
B_i_k is a multiset number and equal to (i + k - 1)! / (i! * (k-1)!) [2]

-- p^i is the probability of i local lock handovers

-- (1 - p)^k is the probability of k socket switchings

I've written a simple Python script to calculate the value of P.
Let's look at some concrete examples and numbers.

When p = 0.99, k = 3 (e.g. a 4-socket system), P is equal to:

8.5%   (N = 100)
33.2% (N = 200)
87.9% (N = 500)
99.7% (N = 1000)
99.99999999999937% (N = 64K)

When p = 0.99, k = 7 (e.g. an 8-socket system), the values of P are:

0.01% (N = 100)
0.52% (N = 200)
24.7% (N = 500)
87.5% (N = 1000)
99.3% (N = 1500)
99.99999999999871% (N = 64K)

I think this mathematical analysis would help users better understand the
fairness property of the CNA qspinlock. One can use it to plot a graph with
different values of p and N to tune the qspinlock for different platforms
and workloads.

Based on the analysis above, it may be useful to have
SHUFFLE_REDUCTION_PROB_ARG as a tunable parameter as well. Setting
SHUFFLE_REDUCTION_PROB_ARG to a lower value results in a higher value of p,
which would likely increase the performance. Then we can set
intra_node_handoff_threshold to have a bounded degree of fairness.
For instance, a user may want P to be around 90% for N = 100 on a 8-core
system. So they can set p = 0.9 and intra_node_handoff_threshold = ~150,
based on our analysis that P =  91.9% for N = 100, and 99.99% for N = 200,
when k = 7.

I hope this helps and please let me know if you have any comments or
if you spot any mistakes in our analysis.

Best,
Lihao.

References:
[1] https://en.wikipedia.org/wiki/Independence_(probability_theory)#More_than_two_events
[2] Theorem 2, https://en.wikipedia.org/wiki/Stars_and_bars_(combinatorics)
