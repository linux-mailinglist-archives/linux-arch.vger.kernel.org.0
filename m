Return-Path: <linux-arch+bounces-4542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9058CFFEE
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 14:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B6DB23E9D
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3848C15D5DF;
	Mon, 27 May 2024 12:23:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC43C463;
	Mon, 27 May 2024 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812594; cv=none; b=crvWafTi045foNSzNHAiYGWDEzSFUGx+sO3X36zfVnFnR1VADXNz+BqMzQ0vV8i88CL2rQ5fkqDKQGEKsZ+u3cSl+7ix0AUqJ8hQnd/KUeBXPWZ/f+dVo6YwurPm40x+eYe/DGr2HzDUZyDHUSxoy+qUvSrzju69Z184sqecELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812594; c=relaxed/simple;
	bh=g+274Zd16a/afuTgix5rR0iNpzqwOmfPQ4ggj7SGsRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV/96fbmme+SfgESMdzIFc0hEycWg+D2Eg2X3TUpTtdBuPDnHlDGvENeaIg5nBSPnnDk4bwu4a2zm7a+b5pDO9IyFzIlHkyw201dDxPqs9aE0S8NUBPN5VmUjSJyXHjPpPNhHS0dRxgDkQhb/Q6bPaj/DegWXNs+QgPuM0dbirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4VnvVd0hshz9v7J2;
	Mon, 27 May 2024 20:05:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1AABA1400D5;
	Mon, 27 May 2024 20:23:02 +0800 (CST)
Received: from [10.221.98.131] (unknown [10.221.98.131])
	by APP2 (Coremail) with SMTP id GxC2BwBHgCQZe1RmtJIACQ--.46068S2;
	Mon, 27 May 2024 13:23:01 +0100 (CET)
Message-ID: <1a3c892c-903e-8fd3-24a6-2454c2a55302@huaweicloud.com>
Date: Mon, 27 May 2024 14:22:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
To: Andrea Parri <parri.andrea@gmail.com>, stern@rowland.harvard.edu,
 will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 jonas.oberhauser@huaweicloud.com
References: <20240524151356.236071-1-parri.andrea@gmail.com>
Content-Language: en-US
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <20240524151356.236071-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBHgCQZe1RmtJIACQ--.46068S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1ftw1kJF4xKFyUZFWxtFb_yoW7CFWxpr
	43Gr47Jr4Utw1UGw1DXr4UJF18Ar1FkrW8Xr18Gr18ZF1jkr98Ww1UJr18XryUJryUta17
	Xw1UKr18Gr4UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/

On 5/24/2024 5:13 PM, Andrea Parri wrote:
> tools/memory-model/ and herdtool7 are closely linked: the latter is
> responsible for (pre)processing each C-like macro of a litmus test,
> and for providing the LKMM with a set of events, or "representation",
> corresponding to the given macro.  Provide herd-representation.txt
> to document the representation of synchronization macros, following
> their "classification" in Documentation/atomic_t.txt.
> 
> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
> - Leaving srcu_{up,down}_read() and smp_mb__after_srcu_read_unlock() for
>    the next version.
> 
> - Limiting to "add" and "and" ops (skipping similar/same representations
>    for "sub", "inc", "dec", "or", "xor", "andnot").
> 
> - While preparing this submission, I recalled that atomic_add_unless()
>    is not listed in the .def file.  I can't remember the reason for this
>    omission though.
> 
> - While checking the information below using herd7, I've observed some
>    "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
>    IAC, that's also excluded from this table/submission.
> 
> 
>   .../Documentation/herd-representation.txt     | 81 +++++++++++++++++++
>   1 file changed, 81 insertions(+)
>   create mode 100644 tools/memory-model/Documentation/herd-representation.txt
> 
> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
> new file mode 100644
> index 0000000000000..94d0d0a9eee50
> --- /dev/null
> +++ b/tools/memory-model/Documentation/herd-representation.txt
> @@ -0,0 +1,81 @@
> +    ---------------------------------------------------------------------------
> +    |                     C macro | Events                                    |
> +    ---------------------------------------------------------------------------
> +    |                 Non-RMW ops |                                           |
> +    ---------------------------------------------------------------------------
> +    |                   READ_ONCE | R[once]                                   |
> +    |                 atomic_read | (as in the previous row)                  |
> +    |                  WRITE_ONCE | W[once]                                   |
> +    |                  atomic_set |                                           |
> +    |            smp_load_acquire | R[acquire]                                |
> +    |         atomic_read_acquire |                                           |
> +    |           smp_store_release | W[release]                                |
> +    |          atomic_set_release |                                           |
> +    |                smp_store_mb | W[once] ->po F[mb]                        |

I expect this one to be hard-coded in herd7 source code, but I cannot 
find it. Can you give me a pointer?

In fact, dartagnan uses W[Mb] ... another clear example of the need for 
documentation as this one.

> +    |                      smp_mb | F[mb]                                     |
> +    |                     smp_rmb | F[rmb]                                    |
> +    |                     smp_wmb | F[wmb]                                    |
> +    |       smp_mb__before_atomic | F[before-atomic]                          |
> +    |        smp_mb__after_atomic | F[after-atomic]                           |
> +    |                 spin_unlock | UL                                        |
> +    |      smp_mb__after_spinlock | F[after-spinlock]                         |
> +    |   smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
> +    |               rcu_read_lock | F[rcu-lock]                               |
> +    |             rcu_read_unlock | F[rcu-unlock]                             |
> +    |             synchronize_rcu | F[sync-rcu]                               |
> +    |             rcu_dereference | R[once]                                   |
> +    |          rcu_assign_pointer | W[release]                                |
> +    |              srcu_read_lock | R[srcu-lock]                              |
> +    |            srcu_read_unlock | W[srcu-unlock]                            |
> +    |            synchronize_srcu | SRCU[sync-srcu]                           |
> +    ---------------------------------------------------------------------------
> +    |    RMW ops w/o return value |                                           |
> +    ---------------------------------------------------------------------------
> +    |                  atomic_add | R*[noreturn] ->rmw W*[once]               |
> +    |                  atomic_and |                                           |
> +    |                   spin_lock | LKR ->lk-rmw LKW                          |

What about spin_unlock?

> +    ---------------------------------------------------------------------------
> +    |     RMW ops w/ return value |                                           |
> +    ---------------------------------------------------------------------------
> +    |           atomic_add_return | F[mb] ->po R*[once]                       |
> +    |                             |     ->rmw W*[once] ->po F[mb]             |
> +    |            atomic_fetch_add |                                           |
> +    |            atomic_fetch_and |                                           |
> +    |                 atomic_xchg |                                           |
> +    |                        xchg |                                           |
> +    |         atomic_add_negative |                                           |
> +    |   atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
> +    |    atomic_fetch_add_relaxed |                                           |
> +    |    atomic_fetch_and_relaxed |                                           |
> +    |         atomic_xchg_relaxed |                                           |
> +    |                xchg_relaxed |                                           |
> +    | atomic_add_negative_relaxed |                                           |
> +    |   atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
> +    |    atomic_fetch_add_acquire |                                           |
> +    |    atomic_fetch_and_acquire |                                           |
> +    |         atomic_xchg_acquire |                                           |
> +    |                xchg_acquire |                                           |
> +    | atomic_add_negative_acquire |                                           |
> +    |   atomic_add_return_release | R*[once] ->rmw W*[release]                |
> +    |    atomic_fetch_add_release |                                           |
> +    |    atomic_fetch_and_release |                                           |
> +    |         atomic_xchg_release |                                           |
> +    |                xchg_release |                                           |
> +    | atomic_add_negative_release |                                           |
> +    ---------------------------------------------------------------------------
> +    |         Conditional RMW ops |                                           |
> +    ---------------------------------------------------------------------------
> +    |              atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
> +    |                             |                 ->rmw W*[once] ->po F[mb] |
> +    |                             |     On failure: R*[once]                  |
> +    |                     cmpxchg |                                           |
> +    |           atomic_add_unless |                                           |
> +    |      atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
> +    |                             |     On failure: R*[once]                  |
> +    |      atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
> +    |                             |     On failure: R*[once]                  |
> +    |      atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
> +    |                             |     On failure: R*[once]                  |
> +    |                spin_trylock | On success: LKR ->lk-rmw LKW              |
> +    |                             |     On failure: LF                        |
> +    ---------------------------------------------------------------------------

I found the extra spaces in the failure case very hard to read. Any 
particular reason why you went with this format?

Hernan


