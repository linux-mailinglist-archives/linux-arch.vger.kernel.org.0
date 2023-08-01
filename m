Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20E976A6A1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Aug 2023 04:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjHACAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 22:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjHACAf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 22:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD1C19B4
        for <linux-arch@vger.kernel.org>; Mon, 31 Jul 2023 18:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690855183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoiBxXOmx6CpsDJVeX/Pql9MtD1ohfFLvpt/Vo7JoTM=;
        b=Nyx9SikCglmyLvBo79MIWnQFfb5M12yGWCoW0mOMJ5TrDABm7csTGC/KKXmkMcb1SrQz4t
        Cv+sGFvQ5pl7nQzJxeVAuKzDEswlGYDN1aGB23bAKksKobu2ciSWsUNNC+5efPpb1ac/CC
        UvUkVLpshUOe+dqlyJYsUIbtKhrGN10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-ToP1tb8vPf28vrStPja-Jw-1; Mon, 31 Jul 2023 21:59:37 -0400
X-MC-Unique: ToP1tb8vPf28vrStPja-Jw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85DDB891F21;
        Tue,  1 Aug 2023 01:59:35 +0000 (UTC)
Received: from [10.22.10.62] (unknown [10.22.10.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12E161121325;
        Tue,  1 Aug 2023 01:59:33 +0000 (UTC)
Message-ID: <f34ddf7f-3ed9-6118-8106-eb9df110c44c@redhat.com>
Date:   Mon, 31 Jul 2023 21:59:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Content-Language: en-US
To:     bibo mao <maobibo@loongson.cn>, guoren@kernel.org,
        David.Laight@ACULAB.COM, will@kernel.org, peterz@infradead.org,
        mingo@redhat.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230731023308.3748432-1-guoren@kernel.org>
 <c603e7f1-a562-6826-1c86-995c8127abee@redhat.com>
 <2437ac29-29f0-34f9-b7cb-f0e294db7dc6@loongson.cn>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <2437ac29-29f0-34f9-b7cb-f0e294db7dc6@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/31/23 21:37, bibo mao wrote:
>
> 在 2023/7/31 23:16, Waiman Long 写道:
>> On 7/30/23 22:33, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The arch_spin_value_unlocked would cause an unnecessary memory
>>> access to the contended value. Although it won't cause a significant
>>> performance gap in most architectures, the arch_spin_value_unlocked
>>> argument contains enough information. Thus, remove unnecessary
>>> atomic_read in arch_spin_value_unlocked().
>>>
>>> The caller of arch_spin_value_unlocked() could benefit from this
>>> change. Currently, the only caller is lockref.
>>>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: David Laight <David.Laight@ACULAB.COM>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> ---
>>> Changelog
>>> V2:
>>>    - Fixup commit log with Waiman advice.
>>>    - Add Waiman comment in the commit msg.
>>> ---
>>>    include/asm-generic/spinlock.h | 16 +++++++++-------
>>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
>>> index fdfebcb050f4..90803a826ba0 100644
>>> --- a/include/asm-generic/spinlock.h
>>> +++ b/include/asm-generic/spinlock.h
>>> @@ -68,11 +68,18 @@ static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
>>>        smp_store_release(ptr, (u16)val + 1);
>>>    }
>>>    +static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>>> +{
>>> +    u32 val = lock.counter;
>>> +
>>> +    return ((val >> 16) == (val & 0xffff));
>>> +}
>>> +
>>>    static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
>>>    {
>>> -    u32 val = atomic_read(lock);
>>> +    arch_spinlock_t val = READ_ONCE(*lock);
>>>    -    return ((val >> 16) != (val & 0xffff));
>>> +    return !arch_spin_value_unlocked(val);
>>>    }
>>>      static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>>> @@ -82,11 +89,6 @@ static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
>>>        return (s16)((val >> 16) - (val & 0xffff)) > 1;
>>>    }
>>>    -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>>> -{
>>> -    return !arch_spin_is_locked(&lock);
>>> -}
>>> -
>>>    #include <asm/qrwlock.h>
>>>      #endif /* __ASM_GENERIC_SPINLOCK_H */
>> I am fine with the current change. However, modern optimizing compiler should be able to avoid the redundant memory read anyway. So this patch may not have an impact from the performance point of view.
> arch_spin_value_unlocked is called with lockref like this:
>
> #define CMPXCHG_LOOP(CODE, SUCCESS) do {                                        \
>          int retry = 100;                                                        \
>          struct lockref old;                                                     \
>          BUILD_BUG_ON(sizeof(old) != 8);                                         \
>          old.lock_count = READ_ONCE(lockref->lock_count);                        \
>          while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {     \
>
> With modern optimizing compiler, Is it possible that old value of
> old.lock.rlock.raw_lock is cached in register, despite that try_cmpxchg64_relaxed
> modifies the memory of old.lock_count with new value?

What I meant is that the call to arch_spin_value_unlocked() as it is 
today will not generate 2 memory reads of the same location with or 
without the patch. Of course, a new memory read will be needed after a 
failed cmpxchg().

Cheers,
Longman

