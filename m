Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612B269FB5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIOHZa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgIOHY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 03:24:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D540C061788;
        Tue, 15 Sep 2020 00:24:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600154684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBI2zNFANGXkWYE4Qif9cyGi7S1uMUtiVcafI/NKee0=;
        b=Gm/q+1/LmIgUKVhaBfxbtH41gZrDIBH8IS1H4zgztvnc5soB5Q5S9GFvwqD6AMThAJg7Eu
        ICkbMzhHS8winOchbTgcb1qlmuZD7JVBas9osW7dkmUkrA19fW7G1Z84ERIdydT1XwABtV
        b3YTiGY6/hGrgHGqtbAMSZ6WiChgMDc5V88LWXOoC6nxdSrZr6KYOF2hnpnoShLvzpGVZ4
        qfLpRcJbnCwBly7jDRkK74aDmCV0ZOOHMRl3SoG6khP3VCoWYVF9b0W5VeuBj1d+MuAvxt
        6cYp5N7yEfk2d6IXe87eOWbHI/ZdUwoUn1UDCyhqgpi5uCSq9M8lJDN8rwQv1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600154684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBI2zNFANGXkWYE4Qif9cyGi7S1uMUtiVcafI/NKee0=;
        b=MuKXrmlhK1T+BH9XqoTgVQdGqBSQY5pVtsbiA531viHwxJXMJTBsBB/Iwr2EqMuOspN/XP
        6hM/wG9/ctqUbmCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
In-Reply-To: <CAHk-=wir6LZ=4gHt8VDdASv=TmEMjEUONuzbt=s+DyXPCvxaBA@mail.gmail.com>
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com> <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com> <CAHk-=wjOV6f_ddg+QVCF6RUe+pXPhSR2WevnNyOs9oT+q2ihEA@mail.gmail.com> <CAMj1kXHrDU50D08TwLfzz2hCK+8+C7KGPF99PphXtsOYZ-ff1g@mail.gmail.com> <20200915062253.GA26275@gondor.apana.org.au> <CAHk-=wir6LZ=4gHt8VDdASv=TmEMjEUONuzbt=s+DyXPCvxaBA@mail.gmail.com>
Date:   Tue, 15 Sep 2020 09:24:44 +0200
Message-ID: <87een35woz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 14 2020 at 23:39, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 11:24 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> > But another reason I tried to avoid kmap_atomic() is that it disables
>> > preemption unconditionally, even on 64-bit architectures where HIGHMEM
>> > is irrelevant. So using kmap_atomic() here means that the bulk of
>> > WireGuard packet encryption runs with preemption disabled, essentially
>> > for legacy reasons.
>>
>> Agreed.  We should definitely fix that.
>
> Well, honestly, one big reason for that is debugging.
>
> The *semantics* of the kmap_atomic() is in the name - you can't sleep
> in between it and the kunmap_atomic().
>
> On any sane architecture, kmap_atomic() ends up being a no-op from an
> implementation standpoint, and sleeping would work just fine.
>
> But we very much want to make sure that people don't then write code
> that doesn't work on the bad old 32-bit machines where it really needs
> that sequence to be safe from preemption.

Alternatively we just make highmem a bit more expensive by making these
maps preemptible. RT is doing this for a long time and it's not that
horrible.

The approach is to keep track about the number of active maps in a task
and on an eventual context switch save them away in the task struct and
restore them when the task is scheduled back in.

Thanks,

        tglx


