Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB01221B21
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 06:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725270AbgGPEPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jul 2020 00:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPEPK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 00:15:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B1C061755;
        Wed, 15 Jul 2020 21:15:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so5497927wrm.4;
        Wed, 15 Jul 2020 21:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=/3B9A674EQfjQa8s5j2tFu+PNv0/P6AJozav9RBzKBs=;
        b=jQAGzKs40+u5PfuX4oC97UuJZrMs4G6Aq6m+2YC+TGqpgpTzShrfzi12bv1RXsMI7J
         1Om7DcMpi2okDxe33FH2+wQgNuwie8n39E9qq+kR7bvyZg3ku9eFeBBrPCLSgBL2ZVLA
         JoMWOpT9lZ5O/zAQu/FRvhcP28sSLrGaUv9ajEX1ZH+NakX7on24mq99R+WaMQ3ChQ4G
         l8y7DIs8EdMUX7lh8khpaiy6TgzpvK0LWbpeOLeBWwVtCjAdo4iuRQiLIop6owvFwcI4
         b0mLYecXgTQBcstsrz/QN80nX3y54h9coJr39Dg0XtiHOThblyJZnohqYClM4HVwjntl
         +YQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=/3B9A674EQfjQa8s5j2tFu+PNv0/P6AJozav9RBzKBs=;
        b=MdsuqJ9LvYvZxvTfZdq351keDrADfm3dOXtzrhnIAWpimzgDmJ/bf+tuOIdIyyX8wn
         wzio5cxOYbsFNn0vcLTGtMQMY54qpdTsdo9R76k+bzrGhAWO8MWlNgucaw32ypJS7c2T
         pszBC5zWqoJJG5DQkTxZdIeV/Q71rh+bhV8oiuneQbyFvEzE5zaKTn1YrP691xMxxdDH
         y6L/eg7RKWEND5YmdpeXDMXWjmeoGIdzcHsD6Ohjvgd0D1/WU8xTdiOvoUQZQgoVPohr
         RLBIubN3FNf/eRh+p8fEQ7d5MQe+Gv9z4oWTCOekZof5x3dJc+CNwNb2xm3gTKNJ6XUo
         zv3g==
X-Gm-Message-State: AOAM530rBaXvKoKNiPMbzDkdq8QMeK88OAWRlP7IFIuYpJWKmVEV7jz6
        wXazPvSO21VhzR8W2r+VtiM=
X-Google-Smtp-Source: ABdhPJxZLZohu0lb79Fzv4Qv7qvyRt8Xt9bGz8aNabW4ubonLDft59n3+6lq6IRt8CxL9c1y7gJAdw==
X-Received: by 2002:adf:c142:: with SMTP id w2mr2802839wre.337.1594872908107;
        Wed, 15 Jul 2020 21:15:08 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id x18sm6694844wrq.13.2020.07.15.21.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 21:15:07 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:15:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-5-npiggin@gmail.com>
        <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
        <1594613902.1wzayj0p15.astroid@bobo.none>
        <1594647408.wmrazhwjzb.astroid@bobo.none>
        <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
In-Reply-To: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Message-Id: <1594868476.6k5kvx8684.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mathieu Desnoyers's message of July 14, 2020 12:13 am:
> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrot=
e:
>=20
>> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>>> serialize.  There are older kernels for which it does not promise to
>>>> serialize.  And I have plans to make it stop serializing in the
>>>> nearish future.
>>>=20
>>> You mean x86's return from interrupt? Sounds fun... you'll konw where t=
o
>>> update the membarrier sync code, at least :)
>>=20
>> Oh, I should actually say Mathieu recently clarified a return from
>> interrupt doesn't fundamentally need to serialize in order to support
>> membarrier sync core.
>=20
> Clarification to your statement:
>=20
> Return from interrupt to kernel code does not need to be context serializ=
ing
> as long as kernel serializes before returning to user-space.
>=20
> However, return from interrupt to user-space needs to be context serializ=
ing.

Hmm, I'm not sure it's enough even with the sync in the exit_lazy_tlb
in the right places.

A kernel thread does a use_mm, then it blocks and the user process with
the same mm runs on that CPU, and then it calls into the kernel, blocks,
the kernel thread runs again, another CPU issues a membarrier which does
not IPI this one because it's running a kthread, and then the kthread
switches back to the user process (still without having unused the mm),
and then the user process returns from syscall without having done a=20
core synchronising instruction.

The cause of the problem is you want to avoid IPI'ing kthreads. Why?
I'm guessing it really only matters as an optimisation in case of idle
threads. Idle thread is easy (well, easier) because it won't use_mm, so=20
you could check for rq->curr =3D=3D rq->idle in your loop (in a suitable=20
sched accessor function).

But... I'm not really liking this subtlety in the scheduler for all this=20
(the scheduler still needs the barriers when switching out of idle).

Can it be improved somehow? Let me forget x86 core sync problem for now
(that _may_ be a bit harder), and step back and look at what we're doing.
The memory barrier case would actually suffer from the same problem as
core sync, because in the same situation it has no implicit mmdrop in
the scheduler switch code either.

So what are we doing with membarrier? We want any activity caused by the=20
set of CPUs/threads specified that can be observed by this thread before=20
calling membarrier is appropriately fenced from activity that can be=20
observed to happen after the call returns.

CPU0                     CPU1
                         1. user stuff
a. membarrier()          2. enter kernel
b. read rq->curr         3. rq->curr switched to kthread
c. is kthread, skip IPI  4. switch_to kthread
d. return to user        5. rq->curr switched to user thread
		         6. switch_to user thread
		         7. exit kernel
                         8. more user stuff

As far as I can see, the problem is CPU1 might reorder step 5 and step
8, so you have mmdrop of lazy mm be a mb after step 6.

But why? The membarrier call only cares that there is a full barrier
between 1 and 8, right? Which it will get from the previous context
switch to the kthread.

I must say the memory barrier comments in membarrier could be improved
a bit (unless I'm missing where the main comment is). It's fine to know
what barriers pair with one another, but we need to know which exact
memory accesses it is ordering

       /*
         * Matches memory barriers around rq->curr modification in
         * scheduler.
         */

Sure, but it doesn't say what else is being ordered. I think it's just
the user memory accesses, but would be nice to make that a bit more
explicit. If we had such comments then we might know this case is safe.

I think the funny powerpc barrier is a similar case of this. If we
ever see remote_rq->curr->flags & PF_KTHREAD, then we _know_ that
CPU has or will have issued a memory barrier between running user
code.

So AFAIKS all this membarrier stuff in kernel/sched/core.c could
just go away. Except x86 because thread switch doesn't imply core
sync, so CPU1 between 1 and 8 may never issue a core sync instruction
the same way a context switch must be a full mb.

Before getting to x86 -- Am I right, or way off track here?=20

Thanks,
Nick
