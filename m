Return-Path: <linux-arch+bounces-15064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B91C7FED1
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 11:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383843A93CE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F6274B32;
	Mon, 24 Nov 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmPZhg1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LjoG/p8R"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7D1D555;
	Mon, 24 Nov 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980441; cv=none; b=tZb/oRkjFz5CCKthH+cjrZ6prRti07tbgP+UXcFLahTFP8BJ6eNyPehvy3y/EWnpuehFG8GZ2H23NwCVrS9NcHo29f6HtU86GENep4R/ebTcRwqPUyYZSyJK1Zbef2pC8DA0Rx9F6lFPvg0gFcj2iU/YmRwAOsJgnae4sAxsxSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980441; c=relaxed/simple;
	bh=zVF0pssYx/aD9hfannkSvINx8rgMzcrmzWpuQtmSRqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poKOaKZoOhSxrjTte2GM/pxNnvg4QWXiIi9E9yv59P4ghh10MoI0xNu9+nyhp5A7dwhP8UMwdu6HNrIKEj1dQp2pUhCKjSbpxpgq2NR7NXtpYDoUsOltcSIsM1CuL7b1QUYNs7dj3RkVzE2yA0Oe/Z9ofk/h5b4nJRP5/QXlxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmPZhg1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LjoG/p8R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763980437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDvnFMrZR0/fwpKzOwSpmViR7udLCjy52/JaaSKqEOk=;
	b=wmPZhg1XZoz3UWC7RAX2YUKFRl4CC7teREVXdNX73BPIZRFD3J/ziLtBuT4Q5LLndbpIHt
	YZk7/XYn/pTcqWm01qu+fDoPSTPrhta96qeg6GKImoBqPhhUD81wtlc1EQDHKauCtqZxnJ
	UV9/3aICC7UmD2LKxHFpy4M3cV4BcP6xC1NAhuT/8VYhqwJDRFkSwvN2OlPMZVtFhBgD60
	NC2kbayijM5MYEBv41YI5iQ3q1CROu0UPI5O+wB28rsB+6kEGg0nmLlEzodmqV6ODxftiv
	/ALDYcHd9Ytj7vFFD4x7aMH4lNspVoT/+N2RMSkl9/N0Y3oMHMNdjHOTEl9AIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763980437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDvnFMrZR0/fwpKzOwSpmViR7udLCjy52/JaaSKqEOk=;
	b=LjoG/p8R19K60Ncuo24Hp7CnVRdM/p/NWn5lJFmPTkTTBQlN8m8z+fBGDie2hy0EuDasDY
	R2Asrc0FZYATD0Bw==
To: K Prateek Nayak <kprateek.nayak@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Prakash Sangappa <prakash.sangappa@oracle.com>, Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V4 00/12] rseq: Implement time slice extension mechanism
In-Reply-To: <8cefc4be-b11a-414c-b3f4-280c900be67b@amd.com>
References: <20251116173423.031443519@linutronix.de>
 <8cefc4be-b11a-414c-b3f4-280c900be67b@amd.com>
Date: Mon, 24 Nov 2025 11:33:56 +0100
Message-ID: <87h5ujiusr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 24 2025 at 12:40, K. Prateek Nayak wrote:
> On 11/17/2025 2:21 AM, Thomas Gleixner wrote:
> I got a chance to test the series with Netflix's userspace locking
> benchmark [1] which ended up looking very similar to the test
> Steven had written initially when discussing the PoC except this
> can scale the number of threads.
>
> [1] https://www.github.com/Netflix/global-lock-bench/
>
> Critical section is just a single increment operation. Metric is
> average time taken to run a fixed amount of critical sections across
> #Threads over 3 runs.
>
> Here are the results of running the test with the default config on
> my 256CPU machine in a root cpuset containing 32CPUs to actually hit
> the contention:
>
> o rseq/slice with no benchmark modifications and "rseq_slice_ext=0"
>
>   | Threads |    Threaded (s) |   Threaded/s |
>   +---------+-----------------+--------------+
>   |       1 |         .026103 | 383493128.79 |
>   |       2 |         .086320 | 116134267.40 |
>   |       4 |         .669743 |  14937390.67 |
>   |       8 |        1.105109 |   9053764.30 |
>   |      16 |        1.863516 |   5366809.94 |
>   |      32 |        7.249873 |   1379590.12 |
>   |      64 |       14.360199 |    696486.76 |
>   |      96 |       21.909887 |    456458.03 |
>   |     128 |       29.126423 |    343358.95 |
>   |     192 |       43.112188 |    231980.16 |
>   |     256 |       57.628748 |    173554.39 |
>   |     384 |       86.274354 |    115909.73 |
>   |     512 |      114.564142 |     87289.97 |
>
>
> o rseq/slice with modified benchmark and "rseq_slice_ext=1"
>
>   | Threads |    Threaded (s) |   Threaded/s | %diff (s) |
>   +---------+-----------------+--------------+-----------+
>   |       1 |         .036438 | 274437690.71 |     40%   |
>   |       2 |         .147520 |  68851845.82 |     71%   |
>   |       4 |         .829240 |  12176948.03 |     24%   |
>   |       8 |        1.259632 |   7993476.42 |     14%   |
>   |      16 |        1.988396 |   5029209.62 |      7%   |
>   |      32 |        9.844307 |   1015837.43 |     36%   |
>   |      64 |       14.590723 |    685979.41 |      2%   |
>   |      96 |       18.898278 |    529171.84 |    -14%   |
>   |     128 |       23.921747 |    418033.09 |    -18%   |
>   |     192 |       33.284228 |    300673.66 |    -23%   |
>   |     256 |       42.934755 |    232934.87 |    -25%   |
>   |     384 |       61.794499 |    161924.64 |    -28%   |
>   |     512 |       82.005069 |    121951.34 |    -28%   |
>   
>   ( Lower %diff is better )
>
>
> Until the contention begins (> 32 threads), there is a consistent
> regression which I believe can be attributed to the additional
> overhead in the critical section from setting the slice_ext
> request, however, once heavy contention begins, there is a clear
> win with slice extension.

Yes, that's about right.

I just played with that benchmark on a random machine and a cpuset of 28
CPUs (primary threads of second socket). First naive attempt doing:

        request_slice();         // sets the request bit
        lock();

        unlock();
        check_slice();          // clears the request bit, checks grant, yield 

Threads        noslice                          slice                       t    ops
      1        0.006 s  155101817 ops/s         0.008 s  128339525 ops/s    20%  -17%
      2        0.060 s   16709158 ops/s         0.071 s   14207646 ops/s    18%  -14%
      4        0.150 s    6681970 ops/s         0.150 s    6681428 ops/s     0%    0%
      8        0.311 s    3217183 ops/s         0.290 s    3448088 ops/s    -6%    7%
     16        0.624 s    1602136 ops/s         0.581 s    1723563 ops/s    -7%    7%
     32        1.170 s     855494 ops/s         1.018 s     983453 ops/s   -13%   14%
     64        2.287 s     437461 ops/s         1.414 s     708871 ops/s   -38%   62%
    128        4.353 s     229926 ops/s         2.010 s     499227 ops/s   -53%  117%
    256        8.321 s     120311 ops/s         3.210 s     314349 ops/s   -61%  161%

Then I modified lock():

     request_slice();
     while (!trylock) {
     	check_slice();
        pause();
        request_slice();

And it becomes this:

Threads        noslice                          slice                       t    ops
      1        0.006 s  167464787 ops/s         0.008 s  126824764 ops/s    32%  -24%
      2        0.038 s   26868534 ops/s         0.044 s   23020570 ops/s    16%  -14%
      4        0.119 s    8411120 ops/s         0.126 s    7930586 ops/s     6%   -5%
      8        0.241 s    4157058 ops/s         0.257 s    3896290 ops/s     6%   -6%
     16        0.463 s    2161893 ops/s         0.468 s    2149853 ops/s     0%    0%
     32        1.037 s     965391 ops/s         0.888 s    1127000 ops/s   -14%   16%
     64        2.018 s     495862 ops/s         0.880 s    1136807 ops/s   -56%  129%
    128        3.834 s     262185 ops/s         0.874 s    1144878 ops/s   -77%  336%
    256        7.704 s     129885 ops/s         0.875 s    1143316 ops/s   -88%  780%

It's interesting that both runtime _and_ ops/s stay stable once contention is hit.

Thanks,

        tglx

