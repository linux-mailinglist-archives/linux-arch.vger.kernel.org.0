Return-Path: <linux-arch+bounces-13762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795E5B9D0F1
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 03:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B014282BD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62123ED5B;
	Thu, 25 Sep 2025 01:49:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A251C27;
	Thu, 25 Sep 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764997; cv=none; b=SXfX+sLGE1AlOvTP+GabzkzD2cgejP4fXKq/CEjsO1FU3MFGASTVH80RYLonyO9Ta9nfocRbWjOd8styp5xQgGQpMKew5C3Kh9iiaSdaT3G85o+HW5Q7V7X42/BdfMGaNt7byK42txPwofCHYMYugCMbeFTsNw6J/mcxmTXz0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764997; c=relaxed/simple;
	bh=hXgRfhO3Mng/XGi/pRU/x+1zhWbJ5p34r+FvO687Gcg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=MrTF6qoYKNlw1TPCYImKOiARR1sRUECLBMvD0PP4fK7ValgXnX9TvHcqKk4iiuzWv/h4YcV17oCKaw62d2TVP4PSyMX+KKYhf1orX/UtRxwAfE9gcHHTz+YSKb5Etx4227mI5kCM4cVbdpcSxORW9Xy1NrXkYFaLrKMfPZ0KpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cXGrx3h7Yz27hbN;
	Thu, 25 Sep 2025 09:50:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E4D121A016C;
	Thu, 25 Sep 2025 09:49:45 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:49:45 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 25 Sep 2025 09:49:44 +0800
Message-ID: <2fc167c7-9d32-4869-a0be-cd17e6701248@huawei.com>
Date: Thu, 25 Sep 2025 09:49:44 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] once: fix race by moving DO_ONCE to separate section
From: Qi Xi <xiqi2@huawei.com>
To: <bobo.shaobowang@huawei.com>, <xiexiuqi@huawei.com>, <arnd@arndb.de>,
	<masahiroy@kernel.org>, <kuba@kernel.org>, <edumazet@google.com>,
	<linux-arch@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>
References: <20250909112911.66023-1-xiqi2@huawei.com>
 <5c88f8c4-c06b-4eb9-8883-202d15130938@huawei.com>
Content-Language: en-GB
In-Reply-To: <5c88f8c4-c06b-4eb9-8883-202d15130938@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn200010.china.huawei.com (7.202.194.133)

kindly ping

On 09/09/2025 20:01, Qi Xi wrote:
>
> On 09/09/2025 19:29, Qi Xi wrote:
>> The commit c2c60ea37e5b ("once: use __section(".data.once")") moved
>> DO_ONCE's ___done variable to .data.once section, which conflicts with
>> DO_ONCE_LITE() that also uses the same section.
>>
>> This creates a race condition when clear_warn_once is used:
>>
>> Thread 1 (DO_ONCE)             Thread 2 (DO_ONCE)
>> __do_once_start
>>      read ___done (false)
>>      acquire once_lock
>> execute func
>> __do_once_done
>>      write ___done (true)      __do_once_start
>>      release once_lock             // Thread 3 clear_warn_once reset 
>> ___done
>>                                    read ___done (false)
>>                                    acquire once_lock
>>                                execute func
>> schedule once_work            __do_once_done
>> once_deferred: OK             write ___done (true)
>> static_branch_disable         release once_lock
>>                                schedule once_work
>>                                once_deferred:
>>                                    BUG_ON(!static_key_enabled)
> When simulating concurrent execution between DO_ONCE() and
> clear_warn_once (clears the entire .data..once section in 
> __do_once_done()),
> BUG_ON() can be easily reproduced.
>
> +#include <asm/sections.h>
>  void __do_once_done(bool *done, struct static_key_true *once_key,
>                     unsigned long *flags, struct module *mod)
>         __releases(once_lock)
>  {
>         *done = true;
>         spin_unlock_irqrestore(&once_lock, *flags);
> +       memset(__start_once, 0, __end_once - __start_once);
> +       pr_info("__do_once_done done: %d\n", *done); // *done equals 0
>         once_disable_jump(once_key, mod);
>  }
>
>>
>> DO_ONCE_LITE() in once_lite.h is used by WARN_ON_ONCE() and other 
>> warning
>> macros. Keep its ___done flag in the .data..once section and allow 
>> resetting
>> by clear_warn_once, as originally intended.
>>
>> In contrast, DO_ONCE() is used for functions like get_random_once() and
>> relies on its ___done flag for internal synchronization. We should 
>> not reset
>> DO_ONCE() by clear_warn_once.
>>
>> Fix it by isolating DO_ONCE's ___done into a separate .data..do_once 
>> section,
>> shielding it from clear_warn_once.
>>
>> Fixes: c2c60ea37e5b ("once: use __section(".data.once")")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qi Xi <xiqi2@huawei.com>
>> ---
>> v3 -> v2: apply the same section change to DO_ONCE_SLEEPABLE().
>> v2 -> v1: add comments for DO_ONCE_LITE() and DO_ONCE().
>> ---
>>   include/asm-generic/vmlinux.lds.h | 1 +
>>   include/linux/once.h              | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/asm-generic/vmlinux.lds.h 
>> b/include/asm-generic/vmlinux.lds.h
>> index 883dbac79da9..94850b52e5cc 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
>> @@ -384,6 +384,7 @@
>>       __start_once = .;                        \
>>       *(.data..once)                            \
>>       __end_once = .;                            \
>> +    *(.data..do_once)                        \
>>       STRUCT_ALIGN();                            \
>>       *(__tracepoints)                        \
>>       /* implement dynamic printk debug */                \
>> diff --git a/include/linux/once.h b/include/linux/once.h
>> index 30346fcdc799..449a0e34ad5a 100644
>> --- a/include/linux/once.h
>> +++ b/include/linux/once.h
>> @@ -46,7 +46,7 @@ void __do_once_sleepable_done(bool *done, struct 
>> static_key_true *once_key,
>>   #define DO_ONCE(func, ...)                             \
>>       ({                                     \
>>           bool ___ret = false;                         \
>> -        static bool __section(".data..once") ___done = false;         \
>> +        static bool __section(".data..do_once") ___done = false;     \
>>           static DEFINE_STATIC_KEY_TRUE(___once_key);             \
>>           if (static_branch_unlikely(&___once_key)) {             \
>>               unsigned long ___flags;                     \
>> @@ -64,7 +64,7 @@ void __do_once_sleepable_done(bool *done, struct 
>> static_key_true *once_key,
>>   #define DO_ONCE_SLEEPABLE(func, ...)                        \
>>       ({                                    \
>>           bool ___ret = false;                        \
>> -        static bool __section(".data..once") ___done = false;        \
>> +        static bool __section(".data..do_once") ___done = false;    \
>>           static DEFINE_STATIC_KEY_TRUE(___once_key); \
>>           if (static_branch_unlikely(&___once_key)) {            \
>>               ___ret = __do_once_sleepable_start(&___done);        \

