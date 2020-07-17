Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF94222F94
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgGQAAc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 20:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgGQAAc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 20:00:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE68C061755;
        Thu, 16 Jul 2020 17:00:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so4486081pfc.6;
        Thu, 16 Jul 2020 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ImNiZtmXUEslFcxDwYTJ2V9XDT5Gl9sBS0NfevXsnnY=;
        b=MukQto0jRHUB4yiJDf8IKC4tB6sGzWl/LcJo9HLPE/bkd1kmrX9hGCtCDR5//wUoy2
         vRcf0HCTe9AuTFsgW3Sks6FN5aGElPRZIOw8zuUk+KdKriPEH/mIEVvLQzDLTI15AG0q
         mFYQfgsopKFs+/ZFPZnfJNgkxGHYsM+PLZvwWWABKgpflzLAFiu2MRs5Z8uU8NxMzvh2
         3UB2zjBnZojmtCHtXYsU3Tz2RzCim3B2KUS4X3yT+ydnT2ua6/w1qF1NkQDE9qUJC1QM
         7nbOar1/6Xd4h/Y75r1K8DiEV6G+5kRKWaJxAvD7p+l3JrRTFqnNib5GoeWwmv6z0wCZ
         G0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ImNiZtmXUEslFcxDwYTJ2V9XDT5Gl9sBS0NfevXsnnY=;
        b=UWQ9qyZYnATA8d0/c5VHfdEbGgcETtsxEHh7CeCrOK7zzqkU1KqM9nFKy7PDepLUWI
         kXhHuvZYb0mLdt0mf5P4lKHrWzHClZdt7ojwwBZMGeyQPRZnH7osM7JkiqrQkmadK2Rj
         BNWqsqixOwDLIavD+c4V7GInnlw418eeQrfnMbV6ru/IBaD5a2cQJdNuTbp0th5JlrqM
         Ubv/MtojKpUi8LEstBkeqal1ZuGpEMVUiMGQE5qLiAcWDOE7bvswzdhNJojrexKaMlE+
         ek4yQgAesyOf0OR3CWAfMCrK8UshPH4lvQxqCKFt7VmOcXYxBK9tMNB6U/1Pe0CtWGQ/
         QXdg==
X-Gm-Message-State: AOAM530vRO9kEk4wF0wLdc+dW6hkQ8u8YX2ZqRL0295AcdEkvXwnROuW
        KbWr/ux7A1w8TUztP48PpEQ=
X-Google-Smtp-Source: ABdhPJyxJEjlVUAM1TRDOicDFoR9jUfM3MI04m9Y+hFjm51bezMj4uAtGtwPvuODOW9Kom5yT1vlRw==
X-Received: by 2002:a65:6710:: with SMTP id u16mr6358665pgf.45.1594944030371;
        Thu, 16 Jul 2020 17:00:30 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id cl17sm953913pjb.50.2020.07.16.17.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 17:00:29 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:00:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
        <1594647408.wmrazhwjzb.astroid@bobo.none>
        <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
        <1594868476.6k5kvx8684.astroid@bobo.none>
        <1594873644.viept6os6j.astroid@bobo.none>
        <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com>
        <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
        <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
In-Reply-To: <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1594942495.8qcz211iwc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 17, 2020 4:58 am:
> ----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers mathieu.desnoyers@e=
fficios.com wrote:
>=20
>> ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>>=20
>>> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com w=
rote:
>>>> I should be more complete here, especially since I was complaining
>>>> about unclear barrier comment :)
>>>>=20
>>>>=20
>>>> CPU0                     CPU1
>>>> a. user stuff            1. user stuff
>>>> b. membarrier()          2. enter kernel
>>>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
>>>> d. read rq->curr         4. rq->curr switched to kthread
>>>> e. is kthread, skip IPI  5. switch_to kthread
>>>> f. return to user        6. rq->curr switched to user thread
>>>> g. user stuff            7. switch_to user thread
>>>>                         8. exit kernel
>>>>                         9. more user stuff
>>>>=20
>>>> What you're really ordering is a, g vs 1, 9 right?
>>>>=20
>>>> In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
>>>> etc.
>>>>=20
>>>> Userspace does not care where the barriers are exactly or what kernel
>>>> memory accesses might be being ordered by them, so long as there is a
>>>> mb somewhere between a and g, and 1 and 9. Right?
>>>=20
>>> This is correct.
>>=20
>> Actually, sorry, the above is not quite right. It's been a while
>> since I looked into the details of membarrier.
>>=20
>> The smp_mb() at the beginning of membarrier() needs to be paired with a
>> smp_mb() _after_ rq->curr is switched back to the user thread, so the
>> memory barrier is between store to rq->curr and following user-space
>> accesses.
>>=20
>> The smp_mb() at the end of membarrier() needs to be paired with the
>> smp_mb__after_spinlock() at the beginning of schedule, which is
>> between accesses to userspace memory and switching rq->curr to kthread.
>>=20
>> As to *why* this ordering is needed, I'd have to dig through additional
>> scenarios from https://lwn.net/Articles/573436/. Or maybe Paul remembers=
 ?
>=20
> Thinking further about this, I'm beginning to consider that maybe we have=
 been
> overly cautious by requiring memory barriers before and after store to rq=
->curr.
>=20
> If CPU0 observes a CPU1's rq->curr->mm which differs from its own process=
 (current)
> while running the membarrier system call, it necessarily means that CPU1 =
had
> to issue smp_mb__after_spinlock when entering the scheduler, between any =
user-space
> loads/stores and update of rq->curr.
>=20
> Requiring a memory barrier between update of rq->curr (back to current pr=
ocess's
> thread) and following user-space memory accesses does not seem to guarant=
ee
> anything more than what the initial barrier at the beginning of __schedul=
e already
> provides, because the guarantees are only about accesses to user-space me=
mory.
>=20
> Therefore, with the memory barrier at the beginning of __schedule, just o=
bserving that
> CPU1's rq->curr differs from current should guarantee that a memory barri=
er was issued
> between any sequentially consistent instructions belonging to the current=
 process on
> CPU1.
>=20
> Or am I missing/misremembering an important point here ?

I might have mislead you.

 CPU0            CPU1
 r1=3Dy            x=3D1
 membarrier()    y=3D1
 r2=3Dx

membarrier provides if r1=3D=3D1 then r2=3D=3D1 (right?)

 CPU0
 r1=3Dy
 membarrier()
   smp_mb();
   t =3D cpu_rq(1)->curr;
   if (t->mm =3D=3D mm)
     IPI(CPU1);
   smp_mb()
 r2=3Dx

 vs

 CPU1
   ...
   __schedule()
     smp_mb__after_spinlock()
     rq->curr =3D kthread
   ...
   __schedule()
     smp_mb__after_spinlock()
     rq->curr =3D user thread
 exit kernel
 x=3D1
 y=3D1

Now these last 3 stores are not ordered, so CPU0 might see y=3D=3D1 but
rq->curr =3D=3D kthread, right? Then it will skip the IPI and stores to x=20
and y will not be ordered.

So we do need a mb after rq->curr store when mm is switching.

I believe for the global membarrier PF_KTHREAD optimisation, we also=20
need a barrier when switching from a kernel thread to user, for the
same reason.

So I think I was wrong to say the barrier is not necessary.

I haven't quite worked out why two mb()s are required in membarrier(),
but at least that's less of a performance concern.

Thanks,
Nick
