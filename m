Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB23479E8A3
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjIMNHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 09:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbjIMNHd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 09:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF86619BD
        for <linux-arch@vger.kernel.org>; Wed, 13 Sep 2023 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694610407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1N8nXpfMCNYLFwc5DqM2IQ2ttQ6FxXsVgYdelfbJc5Y=;
        b=T9eY3mODb/4Jr7k0DOfaEKR0YP+59bxDxTVLT9rdri9zvh0GZdUPHyLOGr0Z+9ksgXCuXh
        eXIQTQcxrse1G/0U0CO6ho7entgPHDCmBQmQJtquQsdowuaQ0Y0BaNqOtLwFIGkzflEw14
        lW60X+9MkzYFsZOZZENFNyjmv6kvMYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-QRcYUWmXNfChTXcc_wePhw-1; Wed, 13 Sep 2023 09:06:42 -0400
X-MC-Unique: QRcYUWmXNfChTXcc_wePhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B7A2101FAA1;
        Wed, 13 Sep 2023 13:06:41 +0000 (UTC)
Received: from [10.22.32.174] (unknown [10.22.32.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A80792904;
        Wed, 13 Sep 2023 13:06:37 +0000 (UTC)
Message-ID: <0ea8d0e7-6447-3a60-8cf4-d6a4e89fa8be@redhat.com>
Date:   Wed, 13 Sep 2023 09:06:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V11 04/17] locking/qspinlock: Improve xchg_tail for number
 of cpus >= 16k
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>, Leonardo Bras <leobras@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-5-guoren@kernel.org>
 <f091ead0-99b9-b30a-a295-730ce321ac60@redhat.com>
 <CAJF2gTSbUUdLhN8PFdFzQd0M1T2MVOL1cdZn46WKq1S8MuQYHw@mail.gmail.com>
 <06714da1-d566-766f-7a13-a3c93b5953c4@redhat.com>
 <CAJF2gTQ3Q7f+FGorVTR66c6TGWsSeeKVvLF+LH1_m3kSHrm0yA@mail.gmail.com>
 <ZQF49GIZoFceUGYH@redhat.com>
 <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJF2gTTHdCr-FQVSGUc+LapkJPmDiEYYa_1P6T86uCjRujgnTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/13/23 08:52, Guo Ren wrote:
> On Wed, Sep 13, 2023 at 4:55 PM Leonardo Bras <leobras@redhat.com> wrote:
>> On Tue, Sep 12, 2023 at 09:10:08AM +0800, Guo Ren wrote:
>>> On Mon, Sep 11, 2023 at 9:03 PM Waiman Long <longman@redhat.com> wrote:
>>>> On 9/10/23 23:09, Guo Ren wrote:
>>>>> On Mon, Sep 11, 2023 at 10:35 AM Waiman Long <longman@redhat.com> wrote:
>>>>>> On 9/10/23 04:28, guoren@kernel.org wrote:
>>>>>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>>>>>
>>>>>>> The target of xchg_tail is to write the tail to the lock value, so
>>>>>>> adding prefetchw could help the next cmpxchg step, which may
>>>>>>> decrease the cmpxchg retry loops of xchg_tail. Some processors may
>>>>>>> utilize this feature to give a forward guarantee, e.g., RISC-V
>>>>>>> XuanTie processors would block the snoop channel & irq for several
>>>>>>> cycles when prefetch.w instruction (from Zicbop extension) retired,
>>>>>>> which guarantees the next cmpxchg succeeds.
>>>>>>>
>>>>>>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
>>>>>>> ---
>>>>>>>     kernel/locking/qspinlock.c | 5 ++++-
>>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>>>>>>> index d3f99060b60f..96b54e2ade86 100644
>>>>>>> --- a/kernel/locking/qspinlock.c
>>>>>>> +++ b/kernel/locking/qspinlock.c
>>>>>>> @@ -223,7 +223,10 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
>>>>>>>      */
>>>>>>>     static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
>>>>>>>     {
>>>>>>> -     u32 old, new, val = atomic_read(&lock->val);
>>>>>>> +     u32 old, new, val;
>>>>>>> +
>>>>>>> +     prefetchw(&lock->val);
>>>>>>> +     val = atomic_read(&lock->val);
>>>>>>>
>>>>>>>         for (;;) {
>>>>>>>                 new = (val & _Q_LOCKED_PENDING_MASK) | tail;
>>>>>> That looks a bit weird. You pre-fetch and then immediately read it. How
>>>>>> much performance gain you get by this change alone?
>>>>>>
>>>>>> Maybe you can define an arch specific primitive that default back to
>>>>>> atomic_read() if not defined.
>>>>> Thx for the reply. This is a generic optimization point I would like
>>>>> to talk about with you.
>>>>>
>>>>> First, prefetchw() makes cacheline an exclusive state and serves for
>>>>> the next cmpxchg loop semantic, which writes the idx_tail part of
>>>>> arch_spin_lock. The atomic_read only makes cacheline in the shared
>>>>> state, which couldn't give any guarantee for the next cmpxchg loop
>>>>> semantic. Micro-architecture could utilize prefetchw() to provide a
>>>>> strong forward progress guarantee for the xchg_tail, e.g., the T-HEAD
>>>>> XuanTie processor would hold the exclusive cacheline state until the
>>>>> next cmpxchg write success.
>>>>>
>>>>> In the end, Let's go back to the principle: the xchg_tail is an atomic
>>>>> swap operation that contains write eventually, so giving a prefetchw()
>>>>> at the beginning is acceptable for all architectures..
>>>>> ••••••••••••
>>>> I did realize afterward that prefetchw gets the cacheline in exclusive
>>>> state. I will suggest you mention that in your commit log as well as
>>>> adding a comment about its purpose in the code.
>>> Okay, I would do that in v12, thx.
>> I would suggest adding a snippet from the ISA Extenstion doc:
>>
>> "A prefetch.w instruction indicates to hardware that the cache block whose
>> effective address is the sum of the base address specified in rs1 and the
>> sign-extended offset encoded in imm[11:0], where imm[4:0] equals 0b00000,
>> is likely to be accessed by a data write (i.e. store) in the near future."
> Good point, thx.

qspinlock is generic code. I suppose this is for the RISCV architecture. 
You can mention that in the commit log as an example, but I prefer more 
generic comment especially in the code.

Cheers,
Longman

