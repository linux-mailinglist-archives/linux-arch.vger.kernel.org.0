Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4327D21CE73
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 06:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGME6X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 00:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGME6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 00:58:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C536C061794;
        Sun, 12 Jul 2020 21:58:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so5490263pfe.5;
        Sun, 12 Jul 2020 21:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=P9lvh6IbVzCStjX6UUqQ4hMLI1Givor5C1Gp3Fr1r88=;
        b=twLvAk0ZReArj6wfcl7hQ//jm11HXj/KFahAEPL+UM6ujjMxhZiF0A0GOyw2PNcD6n
         mpih/dpKWaQtDJIw68Mh6Mc/STHYFqpCPq5h12R3J5lg6CFdfbcacHxe/Hbw2um73nEr
         bYGFr3b9Btax772OMVBYuUmLxSf7OP35btmVMCe+X8dfchC/n+BTM4c9hQJgnzjZKXNs
         cOlxmSMsn5/NM+lPQSJGSh167XGYYbPSShRi+exUS8TdpmMudsYE/pFUxAFqyIS6bzXB
         byoyuNxro9XNx2Xd0kYoj7WbW86Izvr05PEjwIPv3cEJydPxXqXYo3/liFM/xZSJ6Hgq
         jchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=P9lvh6IbVzCStjX6UUqQ4hMLI1Givor5C1Gp3Fr1r88=;
        b=QKhSaCCTUPm9xhSOXkuADiMpFmdELqJ/bnAnlXiKe2IWKGV37DXbgNc8JqwuLiQRm9
         FEcT4arhPj21WUsd0ZrWdhTqWNeUiRdYmye8zTuD8e4LAqn2CUYe89F70Cz1OJIRppir
         /GPszMCwWGYntMrzR8Y2NiBK5SkbP3Mmeypt0pZoxpqBwmpE9sDfBiBUL9IXEyp7TO+c
         JWleqW/nx24slJULX9DQ95L4wI4oAMVahydyK/cRSujoy+ryNOFgMi+ikPbrVkaz0Dvi
         A9EpeD4AfahRE6HbvgfOWcZOTU5F6kmriBdwRKCkL3bjKTwoYUQi1OS9HCjFk5opnSU4
         879w==
X-Gm-Message-State: AOAM5323px8mmIzWnFrgIfHoNBIDmcv1qSHDRNGbPJ8rKu4ftQfEQxKa
        yHzT1uQ4cgwuJfDaQ5xnWU/7ThPI
X-Google-Smtp-Source: ABdhPJyVdzyfh+4/fnCB+gvx/RI5CNBM3ozikU//q1BXlfMf+CY/xIg+P4iZrF3k5Z/5NYCTX1F4YQ==
X-Received: by 2002:a63:4543:: with SMTP id u3mr62898286pgk.398.1594616302094;
        Sun, 12 Jul 2020 21:58:22 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id g5sm13135499pfh.168.2020.07.12.21.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 21:58:21 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:58:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86@kernel.org
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-8-npiggin@gmail.com>
        <20200710093556.GY4800@hirez.programming.kicks-ass.net>
In-Reply-To: <20200710093556.GY4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1594615574.lowminiy4u.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 10, 2020 7:35 pm:
> On Fri, Jul 10, 2020 at 11:56:46AM +1000, Nicholas Piggin wrote:
>> On big systems, the mm refcount can become highly contented when doing
>> a lot of context switching with threaded applications (particularly
>> switching between the idle thread and an application thread).
>>=20
>> Abandoning lazy tlb slows switching down quite a bit in the important
>> user->idle->user cases, so so instead implement a non-refcounted scheme
>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
>> any remaining lazy ones.
>>=20
>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>> with as many software threads as CPUs (so each switch will go in and
>> out of idle), upstream can achieve a rate of about 1 million context
>> switches per second. After this patch it goes up to 118 million.
>=20
> That's mighty impressive, however:

Well, it's the usual case of "find a bouncing line and scale up the
machine size until you achieve your desired improvements" :) But we
are looking at some fundamental scalabilities and seeing if we can
improve a few things.

>=20
>> +static void shoot_lazy_tlbs(struct mm_struct *mm)
>> +{
>> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
>> +		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm,=
 1);
>> +		do_shoot_lazy_tlb(mm);
>> +	}
>> +}
>=20
> IIRC you (power) never clear a CPU from that mask, so for other
> workloads I can see this resulting in massive amounts of IPIs.
>=20
> For instance, take as many processes as you have CPUs. For each,
> manually walk the task across all CPUs and exit. Again.
>=20
> Clearly, that's an extreme, but still...

We do have some issues with that, it does tend to be very self-limiting
though, short lived tasks that can drive lots of exits won't get to run
on a lot of cores.

It's worth keeping an eye on, it may not be too hard to mitigate the IPIs
doing something dumb like collecting a queue of mms before killing a
batch of them.

Thanks,
Nick
