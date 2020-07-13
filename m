Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C621DAF9
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 17:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgGMP7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 11:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMP7S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Jul 2020 11:59:18 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5802B20791
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594655957;
        bh=KyCw4fkjqGBP+Ng7/LXUCofxHSgPOYAylS5bQauPuV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J6B1/an87Uz+Ik5Zm/ikXniJFfkB0OJpKuPGtOS2jbFknhgYBK84N6z3WsA+39h32
         PIVdl90MO3IcY5znDYwiVHWLvaEypp3S2PIYeR4tpEiDakNY6jKisITSFJqHaHAgj5
         vtQuv/rRYW1/UBP9ICpJLNgkUogL19k2zGmWv098=
Received: by mail-wr1-f53.google.com with SMTP id a6so17100036wrm.4
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2020 08:59:17 -0700 (PDT)
X-Gm-Message-State: AOAM531DYeoo3KCOxBPO2jtGrei+ftSfo2v0vcyQ5y/rTTij4H8jO1Ya
        4YgcLLUEoMrhTHI7D0VNX8zTs9j4HbgeBsAS4Zbj+Q==
X-Google-Smtp-Source: ABdhPJxU2n3wnRIWWwiKNhxrwmUD4JY7g5VTemgvAdq6OBgmfsRoQL9sAN5gakJjmLDCt30osVAF5ooJLNn0n7EpJd8=
X-Received: by 2002:adf:e482:: with SMTP id i2mr11665wrm.75.1594655955925;
 Mon, 13 Jul 2020 08:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-8-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-8-npiggin@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Jul 2020 08:59:04 -0700
X-Gmail-Original-Message-ID: <CALCETrWbD=3SUOuq9P7Syb+a1DoBjjem8hq9_HCvn7wyqETkpw@mail.gmail.com>
Message-ID: <CALCETrWbD=3SUOuq9P7Syb+a1DoBjjem8hq9_HCvn7wyqETkpw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
>
> Abandoning lazy tlb slows switching down quite a bit in the important
> user->idle->user cases, so so instead implement a non-refcounted scheme
> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> any remaining lazy ones.
>
> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second. After this patch it goes up to 118 million.
>

I read the patch a couple of times, and I have a suggestion that could
be nonsense.  You are, effectively, using mm_cpumask() as a sort of
refcount.  You're saying "hey, this mm has no more references, but it
still has nonempty mm_cpumask(), so let's send an IPI and shoot down
those references too."  I'm wondering whether you actually need the
IPI.  What if, instead, you actually treated mm_cpumask as a refcount
for real?  Roughly, in __mmdrop(), you would only free the page tables
if mm_cpumask() is empty.  And, in the code that removes a CPU from
mm_cpumask(), you would check if mm_users == 0 and, if so, check if
you just removed the last bit from mm_cpumask and potentially free the
mm.

Getting the locking right here could be a bit tricky -- you need to
avoid two CPUs simultaneously exiting lazy TLB and thinking they
should free the mm, and you also need to avoid an mm with mm_users
hitting zero concurrently with the last remote CPU using it lazily
exiting lazy TLB.  Perhaps this could be resolved by having mm_count
== 1 mean "mm_cpumask() is might contain bits and, if so, it owns the
mm" and mm_count == 0 meaning "now it's dead" and using some careful
cmpxchg or dec_return to make sure that only one CPU frees it.

Or maybe you'd need a lock or RCU for this, but the idea would be to
only ever take the lock after mm_users goes to zero.

--Andy
