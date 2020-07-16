Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0547221BE6
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 07:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgGPFS1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 01:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgGPFS0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 01:18:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC21AC08C5C0
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 22:18:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e8so4264770pgc.5
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=pjSAQ6Btld2fycHWHEXEy5l6TD0W6bB4dFccT/gpVM8=;
        b=SzLH2bWvof9kr76xot8dGve40BlKMean/0Ynh3Mixvp/iYGI6jslyiT1H/1n9Qj1ow
         Mh6ujatjCTcxc2s25k7iA9sn8U89yBeRY8ebObRWZj6HYuZXFeSDTBb/EWPHPkSP4FNU
         WwDuuMXK/rQCsP66Mjz/JMKuDuyf2EqCTf0wV7Jeao4eNmnGi3HcAtNuOo1DPvCl3PrS
         G8xS6Xv4Ca2XuthzckdOpVp0+F0+/78sRIME7/YVN8R9H8xTFBhlymC5jiziD9Jh1/PT
         1dEIfLgzq81IlVYg4rVZj6jYicZCgwuZlDfimKz4575Fr0aZwG6NbpNsQCvhpVa8sGpY
         J2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=pjSAQ6Btld2fycHWHEXEy5l6TD0W6bB4dFccT/gpVM8=;
        b=jP62hyH/Qp3CffMpilzqZ012RfmdI2oI4lsHzE5w+1m0PNENcjzM3z7tDN4VxyYNwn
         JG4m1wj6ZONWi/tS3yREGN2yFoG1QPOQbHt9dxa33+99ckc2946VE78V2vQrv6FCAG5L
         ULbl+55J5svr+d8vAjVMvxyYnlbsa6LMCkPl8VLflGG5GPeOtktZyMnjss1E/S4UoTDU
         l/+QeWRDMbNsY87GttX7++jKpaIxRi9bh8n0Wsh90zAVkqUYlyx8xKdFinOhddQHFpzu
         J4yB95o+nLMo7Y1aBMLEh/rURvBs0Q8z/sNyOX0hQpOE5WvFZllgwMIVpeyfV3Jb9E9K
         80oA==
X-Gm-Message-State: AOAM532oaBQg4xD96WrtobIUTnj3aYIh4l9zsvz+kU0Sev46HyLZDn7U
        Y1twuM3G47BIMDSbXTyZFddCYA==
X-Google-Smtp-Source: ABdhPJz36lMtXy7jtJjFqq3zOAV60PvUS/Hlk91z+f9BEuTeTezdLYpRcGCyT7+UAXDv2D+6odC4ig==
X-Received: by 2002:a63:444b:: with SMTP id t11mr2886208pgk.134.1594876706172;
        Wed, 15 Jul 2020 22:18:26 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c8f2:5437:b9af:674c? ([2601:646:c200:1ef2:c8f2:5437:b9af:674c])
        by smtp.gmail.com with ESMTPSA id k7sm3623730pgh.46.2020.07.15.22.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 22:18:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Date:   Wed, 15 Jul 2020 22:18:20 -0700
Message-Id: <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
In-Reply-To: <1594868476.6k5kvx8684.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> =EF=BB=BFExcerpts from Mathieu Desnoyers's message of July 14, 2020 12:13 a=
m:
>> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrot=
e:
>>=20
>>> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>>>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>>>> serialize.  There are older kernels for which it does not promise to
>>>>> serialize.  And I have plans to make it stop serializing in the
>>>>> nearish future.
>>>>=20
>>>> You mean x86's return from interrupt? Sounds fun... you'll konw where t=
o
>>>> update the membarrier sync code, at least :)
>>>=20
>>> Oh, I should actually say Mathieu recently clarified a return from
>>> interrupt doesn't fundamentally need to serialize in order to support
>>> membarrier sync core.
>>=20
>> Clarification to your statement:
>>=20
>> Return from interrupt to kernel code does not need to be context serializ=
ing
>> as long as kernel serializes before returning to user-space.
>>=20
>> However, return from interrupt to user-space needs to be context serializ=
ing.
>=20
> Hmm, I'm not sure it's enough even with the sync in the exit_lazy_tlb
> in the right places.
>=20
> A kernel thread does a use_mm, then it blocks and the user process with
> the same mm runs on that CPU, and then it calls into the kernel, blocks,
> the kernel thread runs again, another CPU issues a membarrier which does
> not IPI this one because it's running a kthread, and then the kthread
> switches back to the user process (still without having unused the mm),
> and then the user process returns from syscall without having done a=20
> core synchronising instruction.
>=20
> The cause of the problem is you want to avoid IPI'ing kthreads. Why?
> I'm guessing it really only matters as an optimisation in case of idle
> threads. Idle thread is easy (well, easier) because it won't use_mm, so=20=

> you could check for rq->curr =3D=3D rq->idle in your loop (in a suitable=20=

> sched accessor function).
>=20
> But... I'm not really liking this subtlety in the scheduler for all this=20=

> (the scheduler still needs the barriers when switching out of idle).
>=20
> Can it be improved somehow? Let me forget x86 core sync problem for now
> (that _may_ be a bit harder), and step back and look at what we're doing.
> The memory barrier case would actually suffer from the same problem as
> core sync, because in the same situation it has no implicit mmdrop in
> the scheduler switch code either.
>=20
> So what are we doing with membarrier? We want any activity caused by the=20=

> set of CPUs/threads specified that can be observed by this thread before=20=

> calling membarrier is appropriately fenced from activity that can be=20
> observed to happen after the call returns.
>=20
> CPU0                     CPU1
>                         1. user stuff
> a. membarrier()          2. enter kernel
> b. read rq->curr         3. rq->curr switched to kthread
> c. is kthread, skip IPI  4. switch_to kthread
> d. return to user        5. rq->curr switched to user thread
>                 6. switch_to user thread
>                 7. exit kernel
>                         8. more user stuff
>=20
> As far as I can see, the problem is CPU1 might reorder step 5 and step
> 8, so you have mmdrop of lazy mm be a mb after step 6.
>=20
> But why? The membarrier call only cares that there is a full barrier
> between 1 and 8, right? Which it will get from the previous context
> switch to the kthread.
>=20
> I must say the memory barrier comments in membarrier could be improved
> a bit (unless I'm missing where the main comment is). It's fine to know
> what barriers pair with one another, but we need to know which exact
> memory accesses it is ordering
>=20
>       /*
>         * Matches memory barriers around rq->curr modification in
>         * scheduler.
>         */
>=20
> Sure, but it doesn't say what else is being ordered. I think it's just
> the user memory accesses, but would be nice to make that a bit more
> explicit. If we had such comments then we might know this case is safe.
>=20
> I think the funny powerpc barrier is a similar case of this. If we
> ever see remote_rq->curr->flags & PF_KTHREAD, then we _know_ that
> CPU has or will have issued a memory barrier between running user
> code.
>=20
> So AFAIKS all this membarrier stuff in kernel/sched/core.c could
> just go away. Except x86 because thread switch doesn't imply core
> sync, so CPU1 between 1 and 8 may never issue a core sync instruction
> the same way a context switch must be a full mb.
>=20
> Before getting to x86 -- Am I right, or way off track here?

I find it hard to believe that this is x86 only. Why would thread switch imp=
ly core sync on any architecture?  Is x86 unique in having a stupid expensiv=
e core sync that is heavier than smp_mb()?

But I=E2=80=99m wondering if all this deferred sync stuff is wrong. In the b=
rave new world of io_uring and such, perhaps kernel access matter too.  Heck=
, even:

int a[2];

Thread A:
a[0] =3D 1;
a[1] =3D 2:

Thread B:

write(fd, a, sizeof(a));

Doesn=E2=80=99t do what thread A is expecting.  Admittedly this particular e=
xample is nonsense, but maybe there are sensible cases that matter to someon=
e.

=E2=80=94Andy

>=20
> Thanks,
> Nick
