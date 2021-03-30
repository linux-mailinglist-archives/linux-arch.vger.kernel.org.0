Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF034E9E5
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbhC3OKC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 10:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231782AbhC3OJg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 10:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617113375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjceWuLqxTVqN7nJGF6xvHg+l6EBFWCS4ZdW7zopx+w=;
        b=dLzJampl+ANg7MqeRIQ1PLJDAtYMm2YUxHFytHgCwP3pEkC2rzp4TXMn3fSejqpXD2cNYn
        FYTIgo/Kn847ZItLkaWfa3KzRHLf2Sf8qZJWedFnq0onFoL2X7x1b+LcChj5Yk/FBu/yfZ
        oGFOURpg2Uy3YmEvXSjGhXw6RRoEoC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-KiW6mmzYOV6OSjZf91Aqfg-1; Tue, 30 Mar 2021 10:09:32 -0400
X-MC-Unique: KiW6mmzYOV6OSjZf91Aqfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 903ECDF8A0;
        Tue, 30 Mar 2021 14:09:30 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-202.rdu2.redhat.com [10.10.118.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE2A35D9CC;
        Tue, 30 Mar 2021 14:09:27 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <4d0dbaa0-1f96-470c-0ed0-04f6827ea384@redhat.com>
Date:   Tue, 30 Mar 2021 10:09:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/29/21 11:13 PM, Guo Ren wrote:
> On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
>>> u32 a = 0x55aa66bb;
>>> u16 *ptr = &a;
>>>
>>> CPU0                       CPU1
>>> =========             =========
>>> xchg16(ptr, new)     while(1)
>>>                                      WRITE_ONCE(*(ptr + 1), x);
>>>
>>> When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
>> Then I think your LL/SC is broken.
>>
>> That also means you really don't want to build super complex locking
>> primitives on top, because that live-lock will percolate through.
> Do you mean the below implementation has live-lock risk?
> +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> +{
> +       u32 old, new, val = atomic_read(&lock->val);
> +
> +       for (;;) {
> +               new = (val & _Q_LOCKED_PENDING_MASK) | tail;
> +               old = atomic_cmpxchg(&lock->val, val, new);
> +               if (old == val)
> +                       break;
> +
> +               val = old;
> +       }
> +       return old;
> +}
If there is a continuous stream of incoming spinlock takers, it is 
possible that some cpus may have to wait a long time to set the tail 
right. However, this should only happen on artificial workload. I doubt 
it will happen with real workload or with limit number of cpus.
>
>> Step 1 would be to get your architecute fixed such that it can provide
>> fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
>> in building complex systems with it.
> Quote Waiman's comment [1] on xchg16 optimization:
>
> "This optimization is needed to make the qspinlock achieve performance
> parity with ticket spinlock at light load."
>
> [1] https://lore.kernel.org/kvm/1429901803-29771-6-git-send-email-Waiman.Long@hp.com/
>
> So for a non-xhg16 machine:
>   - ticket-lock for small numbers of CPUs
>   - qspinlock for large numbers of CPUs
>
> Okay, I'll put all of them into the next patch :P
>
It is true that qspinlock may not offer much advantage when the number 
of cpus is small. It shines for systems with many cpus. You may use 
NR_CPUS to determine if the default should be ticket or qspinlock with 
user override. To determine the right NR_CPUS threshold, you may need to 
run on real SMP RISCV systems to find out.

Cheers,
Longman

