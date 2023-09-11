Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8179B5C3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjIKVFn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjIKNES (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 09:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09130CD7
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694437409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSJPoGx10J6x6+0exgf8zlMMy8M925rAu1G76vFf9bs=;
        b=IObvMmJ0omDhwgLKdnl2mqweNoiiK5akCmdGZmKt+Z/b/swZYsOHC4CNCghOKyBpGU4cJO
        mjVyVfhGyKnK5fixDzjtpgt6sjZ7rsb8+AiD9ptLPHnPz84t9CuzBfImgbBphUAr2VEV+B
        Leg7xbhw43JuiesKBSIIKcfVyk6jpJE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-HRl8HX2aMzS5sXQtod1MAA-1; Mon, 11 Sep 2023 09:03:23 -0400
X-MC-Unique: HRl8HX2aMzS5sXQtod1MAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E90643C1DC25;
        Mon, 11 Sep 2023 13:03:21 +0000 (UTC)
Received: from [10.22.32.237] (unknown [10.22.32.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 460CC40C6EA8;
        Mon, 11 Sep 2023 13:03:20 +0000 (UTC)
Message-ID: <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
Date:   Mon, 11 Sep 2023 09:03:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
 <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/10/23 23:09, Guo Ren wrote:
> On Mon, Sep 11, 2023 at 10:35 AM Waiman Long <longman@redhat.com> wrote:
>>
>> On 9/10/23 04:28, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The target of xchg_tail is to write the tail to the lock value, so
>>> adding prefetchw could help the next cmpxchg step, which may
>>> decrease the cmpxchg retry loops of xchg_tail. Some processors may
>>> utilize this feature to give a forward guarantee, e.g., RISC-V
>>> XuanTie processors would block the snoop channel & irq for several
>>> cycles when prefetch.w instruction (from Zicbop extension) retired,
>>> which guarantees the next cmpxchg succeeds.
>>>
>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>> ---
>>>    kernel/locking/qspinlock.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>> index d3f99060b60f..96b54e2ade86 100644
>>> --- a/kernel/locking/qspinlock.c
>>> +++ b/kernel/locking/qspinlock.c
>>> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>>>     */
>>>    static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>>>    {
>>> -     u32 old, new, val = atomic_read(&lock->val);
>>> +     u32 old, new, val;
>>> +
>>> +     prefetchw(&lock->val);
>>> +     val = atomic_read(&lock->val);
>>>
>>>        for (;;) {
>>>                new = (val & _Q_LOCKED_PENDING_MASK) | tail;
>> That looks a bit weird. You pre-fetch and then immediately read it. How
>> much performance gain you get by this change alone?
>>
>> Maybe you can define an arch specific primitive that default back to
>> atomic_read() if not defined.
> Thx for the reply. This is a generic optimization point I would like
> to talk about with you.
>
> First, prefetchw() makes cacheline an exclusive state and serves for
> the next cmpxchg loop semantic, which writes the idx_tail part of
> arch_spin_lock. The atomic_read only makes cacheline in the shared
> state, which couldn't give any guarantee for the next cmpxchg loop
> semantic. Micro-architecture could utilize prefetchw() to provide a
> strong forward progress guarantee for the xchg_tail, e.g., the T-HEAD
> XuanTie processor would hold the exclusive cacheline state until the
> next cmpxchg write success.
>
> In the end, Let's go back to the principle: the xchg_tail is an atomic
> swap operation that contains write eventually, so giving a prefetchw()
> at the beginning is acceptable for all architectures..
> ••••••••••••

I did realize afterward that prefetchw gets the cacheline in exclusive 
state. I will suggest you mention that in your commit log as well as 
adding a comment about its purpose in the code.

Thanks,
Longman

>> Cheers,
>> Longman
>>
>

