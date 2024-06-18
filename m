Return-Path: <linux-arch+bounces-4958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5790C7CF
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668FE285E09
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5831156F24;
	Tue, 18 Jun 2024 09:20:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE915689A;
	Tue, 18 Jun 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702428; cv=none; b=rQxBkoBOyhtyG+ck7Fg74g60796VvwCkaiZPnjk+XplcQCSoInjJWekEhMyBur5m5gOqUO4PgnXx3AbqoodtiuhfwaEb0Uuk+QjzANrWV7wCbt3LM4s8gfYAVejXL+U2UFt6gBLAQiI6k/O07y/OamyKeME3ouA6vHleGWCFnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702428; c=relaxed/simple;
	bh=jOwNCGoJB4Q6mWbq2nQmdNNxx8dVV/0d7DQP4mau0A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAaOAsLjhxPADobCxldBI396oHQqujhDdvYTtgI7/0onUHdO+5goix7WP0hNkLmGkWnzQ0ZGH5OsSYEDV3IRfiyVYi+X6glh1qANLONOvsW1WQzLKC7wEjWJblgpNhJMAGKkbOtQ2apS7LsQUU2O+6MdVBOic7NHZt4mbleunMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4W3LP172ylz9v7Hk;
	Tue, 18 Jun 2024 17:02:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 97EE414025A;
	Tue, 18 Jun 2024 17:20:10 +0800 (CST)
Received: from [10.221.99.159] (unknown [10.221.99.159])
	by APP1 (Coremail) with SMTP id LxC2BwDnQVE8UXFmh3+mAA--.10067S2;
	Tue, 18 Jun 2024 10:20:09 +0100 (CET)
Message-ID: <07513d65-386d-1bfb-f5ad-8979708d5523@huaweicloud.com>
Date: Tue, 18 Jun 2024 11:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>, Andrea Parri <parri.andrea@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
 npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, jonas.oberhauser@huaweicloud.com
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <ZnC-cqQOEU2fd9tO@boqun-archlinux>
From: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
In-Reply-To: <ZnC-cqQOEU2fd9tO@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDnQVE8UXFmh3+mAA--.10067S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ArW7uw1fJFyftr1rWr15Arb_yoW3ArWUpr
	WfGr43tr1UXw15Ww1DXr1UtF18C3yrKw48Grn5Gr18ZF1jkrn0yw17try8XFyUAryDJa17
	Xr1UKF1DXr1UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 6/18/2024 12:53 AM, Boqun Feng wrote:
> On Mon, Jun 17, 2024 at 10:17:59PM +0200, Andrea Parri wrote:
>> tools/memory-model/ and herdtool7 are closely linked: the latter is
>> responsible for (pre)processing each C-like macro of a litmus test,
>> and for providing the LKMM with a set of events, or "representation",
>> corresponding to the given macro.  Provide herd-representation.txt
>> to document the representations of the concurrency macros, following
>> their "classification" in Documentation/atomic_t.txt.
>>
>> Suggested-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
>> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> 
> I have a question below...
> 
>> ---
>> Changes since v2 [1]:
>>    - drop lk-rmw links
>>
>> Changes since v1 [2]:
>>    - add legenda/notations
>>    - add some SRCU, locking macros
>>    - update formatting of failure cases
>>    - update README file
>>
>> [1] https://lore.kernel.org/lkml/20240605134918.365579-1-parri.andrea@gmail.com/
>> [2] https://lore.kernel.org/lkml/20240524151356.236071-1-parri.andrea@gmail.com/
>>
>>   tools/memory-model/Documentation/README       |   7 +-
>>   .../Documentation/herd-representation.txt     | 106 ++++++++++++++++++
>>   2 files changed, 112 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/memory-model/Documentation/herd-representation.txt
>>
>> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
>> index 304162743a5b8..44e7dae73b296 100644
>> --- a/tools/memory-model/Documentation/README
>> +++ b/tools/memory-model/Documentation/README
>> @@ -33,7 +33,8 @@ o	You are familiar with Linux-kernel concurrency and the use of
>>   
>>   o	You are familiar with Linux-kernel concurrency and the use
>>   	of LKMM, and would like to learn about LKMM's requirements,
>> -	rationale, and implementation:	explanation.txt
>> +	rationale, and implementation:	explanation.txt and
>> +	herd-representation.txt
>>   
>>   o	You are interested in the publications related to LKMM, including
>>   	hardware manuals, academic literature, standards-committee
>> @@ -61,6 +62,10 @@ control-dependencies.txt
>>   explanation.txt
>>   	Detailed description of the memory model.
>>   
>> +herd-representation.txt
>> +	The (abstract) representation of the Linux-kernel concurrency
>> +	primitives in terms of events.
>> +
>>   litmus-tests.txt
>>   	The format, features, capabilities, and limitations of the litmus
>>   	tests that LKMM can evaluate.
>> diff --git a/tools/memory-model/Documentation/herd-representation.txt b/tools/memory-model/Documentation/herd-representation.txt
>> new file mode 100644
>> index 0000000000000..2fe270e902635
>> --- /dev/null
>> +++ b/tools/memory-model/Documentation/herd-representation.txt
>> @@ -0,0 +1,106 @@
>> +#
>> +# Legenda:
>> +#	R,	a Load event
>> +#	W,	a Store event
>> +#	F,	a Fence event
>> +#	LKR,	a Lock-Read event
>> +#	LKW,	a Lock-Write event
>> +#	UL,	an Unlock event
>> +#	LF,	a Lock-Fail event
>> +#	RL,	a Read-Locked event
>> +#	RU,	a Read-Unlocked event
>> +#	R*,	a Load event included in RMW
>> +#	W*,	a Store event included in RMW
>> +#	SRCU,	a Sleepable-Read-Copy-Update event
>> +#
>> +#	po,	a Program-Order link
>> +#	rmw,	a Read-Modify-Write link
>> +#
>> +# By convention, a blank entry/representation means "same as the preceding entry".
>> +#
>> +    ------------------------------------------------------------------------------
>> +    |                        C macro | Events                                    |
>> +    ------------------------------------------------------------------------------
>> +    |                    Non-RMW ops |                                           |
>> +    ------------------------------------------------------------------------------
>> +    |                      READ_ONCE | R[once]                                   |
>> +    |                    atomic_read |                                           |
>> +    |                     WRITE_ONCE | W[once]                                   |
>> +    |                     atomic_set |                                           |
>> +    |               smp_load_acquire | R[acquire]                                |
>> +    |            atomic_read_acquire |                                           |
>> +    |              smp_store_release | W[release]                                |
>> +    |             atomic_set_release |                                           |
>> +    |                   smp_store_mb | W[once] ->po F[mb]                        |
>> +    |                         smp_mb | F[mb]                                     |
>> +    |                        smp_rmb | F[rmb]                                    |
>> +    |                        smp_wmb | F[wmb]                                    |
>> +    |          smp_mb__before_atomic | F[before-atomic]                          |
>> +    |           smp_mb__after_atomic | F[after-atomic]                           |
>> +    |                    spin_unlock | UL                                        |
>> +    |                 spin_is_locked | On success: RL                            |
>> +    |                                | On failure: RU                            |
>> +    |         smp_mb__after_spinlock | F[after-spinlock]                         |
>> +    |      smp_mb__after_unlock_lock | F[after-unlock-lock]                      |
>> +    |                  rcu_read_lock | F[rcu-lock]                               |
>> +    |                rcu_read_unlock | F[rcu-unlock]                             |
>> +    |                synchronize_rcu | F[sync-rcu]                               |
>> +    |                rcu_dereference | R[once]                                   |
>> +    |             rcu_assign_pointer | W[release]                                |
>> +    |                 srcu_read_lock | R[srcu-lock]                              |
>> +    |                 srcu_down_read |                                           |
>> +    |               srcu_read_unlock | W[srcu-unlock]                            |
>> +    |                   srcu_up_read |                                           |
>> +    |               synchronize_srcu | SRCU[sync-srcu]                           |
>> +    | smp_mb__after_srcu_read_unlock | F[after-srcu-read-unlock]                 |
>> +    ------------------------------------------------------------------------------
>> +    |       RMW ops w/o return value |                                           |
>> +    ------------------------------------------------------------------------------
>> +    |                     atomic_add | R*[noreturn] ->rmw W*[once]               |
>> +    |                     atomic_and |                                           |
>> +    |                      spin_lock | LKR ->po LKW                              |
>> +    ------------------------------------------------------------------------------
>> +    |        RMW ops w/ return value |                                           |
>> +    ------------------------------------------------------------------------------
>> +    |              atomic_add_return | F[mb] ->po R*[once]                       |
>> +    |                                |     ->rmw W*[once] ->po F[mb]             |
> 
> Just to double check, there is also a ->po relation between R*[once] and
> W*[once], right? It might not be important right now, but it's important
> when we move to what Jonas is proposing:
> 
> 	https://lore.kernel.org/lkml/20240604152922.495908-1-jonas.oberhauser@huaweicloud.com/

This follows from rmw \subset po. However, this might not be immediately 
clear for the reader so having it explicit is a good idea.

Reviewed-by: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>

> 	
> So just check with you ;-) Thanks!
> 
> Regards,
> Boqun
> 
>> +    |               atomic_fetch_add |                                           |
>> +    |               atomic_fetch_and |                                           |
>> +    |                    atomic_xchg |                                           |
>> +    |                           xchg |                                           |
>> +    |            atomic_add_negative |                                           |
>> +    |      atomic_add_return_relaxed | R*[once] ->rmw W*[once]                   |
>> +    |       atomic_fetch_add_relaxed |                                           |
>> +    |       atomic_fetch_and_relaxed |                                           |
>> +    |            atomic_xchg_relaxed |                                           |
>> +    |                   xchg_relaxed |                                           |
>> +    |    atomic_add_negative_relaxed |                                           |
>> +    |      atomic_add_return_acquire | R*[acquire] ->rmw W*[once]                |
>> +    |       atomic_fetch_add_acquire |                                           |
>> +    |       atomic_fetch_and_acquire |                                           |
>> +    |            atomic_xchg_acquire |                                           |
>> +    |                   xchg_acquire |                                           |
>> +    |    atomic_add_negative_acquire |                                           |
>> +    |      atomic_add_return_release | R*[once] ->rmw W*[release]                |
>> +    |       atomic_fetch_add_release |                                           |
>> +    |       atomic_fetch_and_release |                                           |
>> +    |            atomic_xchg_release |                                           |
>> +    |                   xchg_release |                                           |
>> +    |    atomic_add_negative_release |                                           |
>> +    ------------------------------------------------------------------------------
>> +    |            Conditional RMW ops |                                           |
>> +    ------------------------------------------------------------------------------
>> +    |                 atomic_cmpxchg | On success: F[mb] ->po R*[once]           |
>> +    |                                |                 ->rmw W*[once] ->po F[mb] |
>> +    |                                | On failure: R*[once]                      |
>> +    |                        cmpxchg |                                           |
>> +    |              atomic_add_unless |                                           |
>> +    |         atomic_cmpxchg_relaxed | On success: R*[once] ->rmw W*[once]       |
>> +    |                                | On failure: R*[once]                      |
>> +    |         atomic_cmpxchg_acquire | On success: R*[acquire] ->rmw W*[once]    |
>> +    |                                | On failure: R*[once]                      |
>> +    |         atomic_cmpxchg_release | On success: R*[once] ->rmw W*[release]    |
>> +    |                                | On failure: R*[once]                      |
>> +    |                   spin_trylock | On success: LKR ->po LKW                  |
>> +    |                                | On failure: LF                            |
>> +    ------------------------------------------------------------------------------
>> -- 
>> 2.34.1
>>


