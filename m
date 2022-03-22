Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C04E482A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiCVVPl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 17:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiCVVPl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 17:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7814192
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647983651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIVLkwlhPM3w906YxQwZL+nXYzlTqcHmn11/FV0IJ2I=;
        b=Vo0jLs4Et8LNC/vvncdtyRc9LmfTrqI+CxTG+Foa9/PZbx991eKw62bvfd27KlZvpC2LQp
        8fDY2pO1fTQ6sWb7+OBteX+IdvbRleJUeiFYu2hWynWImOZVgFwVIqOblrPByU3xo8doke
        IjxuBxtsEmkxIIUQOaaHu29zJlIS9lM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-gAQqERV8OKCorngkS2_1Ew-1; Tue, 22 Mar 2022 17:14:06 -0400
X-MC-Unique: gAQqERV8OKCorngkS2_1Ew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5727803B22;
        Tue, 22 Mar 2022 21:14:05 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 793A440D0166;
        Tue, 22 Mar 2022 21:14:05 +0000 (UTC)
Message-ID: <cbf542d9-d3d4-9de8-5a96-4d5fcea69f6a@redhat.com>
Date:   Tue, 22 Mar 2022 17:14:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [OpenRISC] [PATCH V2 1/5] asm-generic: ticket-lock: New generic
 ticket-based spinlock
Content-Language: en-US
To:     Stafford Horne <shorne@gmail.com>
Cc:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        boqun.feng@gmail.com, peterz@infradead.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org
References: <20220319035457.2214979-1-guoren@kernel.org>
 <20220319035457.2214979-2-guoren@kernel.org> <Yjk+LGwhc50zvsk2@antec>
 <54d6221d-0c4f-9329-042d-4f74c4ea288f@redhat.com> <Yjo6bI+DWolVT/bQ@antec>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yjo6bI+DWolVT/bQ@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/22/22 17:06, Stafford Horne wrote:
> On Tue, Mar 22, 2022 at 11:54:37AM -0400, Waiman Long wrote:
>> On 3/21/22 23:10, Stafford Horne wrote:
>>> Hello,
>>>
>>> There is a problem with this patch on Big Endian machines, see below.
>>>
>>> On Sat, Mar 19, 2022 at 11:54:53AM +0800, guoren@kernel.org wrote:
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> This is a simple, fair spinlock.  Specifically it doesn't have all the
>>>> subtle memory model dependencies that qspinlock has, which makes it more
>>>> suitable for simple systems as it is more likely to be correct.
>>>>
>>>> [Palmer: commit text]
>>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>>
>>>> --
>>>>
>>>> I have specifically not included Peter's SOB on this, as he sent his
>>>> original patch
>>>> <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
>>>> without one.
>>>> ---
>>>>    include/asm-generic/spinlock.h          | 11 +++-
>>>>    include/asm-generic/spinlock_types.h    | 15 +++++
>>>>    include/asm-generic/ticket-lock-types.h | 11 ++++
>>>>    include/asm-generic/ticket-lock.h       | 86 +++++++++++++++++++++++++
>>>>    4 files changed, 120 insertions(+), 3 deletions(-)
>>>>    create mode 100644 include/asm-generic/spinlock_types.h
>>>>    create mode 100644 include/asm-generic/ticket-lock-types.h
>>>>    create mode 100644 include/asm-generic/ticket-lock.h
>>>>
>>>> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
>>>> new file mode 100644
>>>> index 000000000000..59373de3e32a
>>>> --- /dev/null
>>>> +++ b/include/asm-generic/ticket-lock.h
>>> ...
>>>
>>>> +static __always_inline void ticket_unlock(arch_spinlock_t *lock)
>>>> +{
>>>> +	u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
>>> As mentioned, this patch series breaks SMP on OpenRISC.  I traced it to this
>>> line.  The above `__is_defined(__BIG_ENDIAN)`  does not return 1 as expected
>>> even on BIG_ENDIAN machines.  This works:
>>>
>>>
>>> diff --git a/include/asm-generic/ticket-lock.h b/include/asm-generic/ticket-lock.h
>>> index 59373de3e32a..52b5dc9ffdba 100644
>>> --- a/include/asm-generic/ticket-lock.h
>>> +++ b/include/asm-generic/ticket-lock.h
>>> @@ -26,6 +26,7 @@
>>>    #define __ASM_GENERIC_TICKET_LOCK_H
>>>    #include <linux/atomic.h>
>>> +#include <linux/kconfig.h>
>>>    #include <asm-generic/ticket-lock-types.h>
>>>    static __always_inline void ticket_lock(arch_spinlock_t *lock)
>>> @@ -51,7 +52,7 @@ static __always_inline bool ticket_trylock(arch_spinlock_t *lock)
>>>    static __always_inline void ticket_unlock(arch_spinlock_t *lock)
>>>    {
>>> -       u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
>>> +       u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
>>>           u32 val = atomic_read(lock);
>>>           smp_store_release(ptr, (u16)val + 1);
>>>
>>>
>>>> +	u32 val = atomic_read(lock);
>>>> +
>>>> +	smp_store_release(ptr, (u16)val + 1);
>>>> +}
>>>> +
>> __BIG_ENDIAN is defined in <linux/kconfig.h>. I believe that if you include
>> <linux/kconfig.h>, the second hunk is not really needed and vice versa.
> I thought so too, but it doesn't seem to work.  I think __is_defined is not
> doing what we think in this context.  It looks like __is_defined works when a
> macro is defined as 1, in this case we have __BIG_ENDIAN 4321.

You are right. __is_defined() only for 1 or not 1. So it can't be used 
for __BIG_ENDIAN.

I was not aware of that. Anyway, the <linux/kconfig.h> include is not 
really needed then.

Cheers,
Longman

