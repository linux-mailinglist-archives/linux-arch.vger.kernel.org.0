Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C31F26D3C5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 08:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQGjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 02:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgIQGjI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Sep 2020 02:39:08 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9432221EE;
        Thu, 17 Sep 2020 06:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600324746;
        bh=ul//1MPvzGwsu0j/p6Y16UQQiQFQ34KaxNZPDGcZMVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mw0q6VsGKZSFgivkdhqZqaa1GHQ+h/o6ugTYlZ/YT0G0RHbfrovTuLZZuzoA5pUnF
         wJg0apvet0ngR44Tjw+Tvg5QeG7+2mmNq4j0ZhNOyK0aJNvGsVGIhD5hQbTfDCbHLd
         5SByiVmcuhH1Ub9AEWMq5cwgQbtMqszTmeZAjj1s=
Received: by mail-ot1-f43.google.com with SMTP id m12so947241otr.0;
        Wed, 16 Sep 2020 23:39:06 -0700 (PDT)
X-Gm-Message-State: AOAM532hY+5hG6wookvX1E3/5qVdqjXfKii62vLLa+RoQoBe698W+EUx
        CQQQC8BKulb/QpTecnw/dQQNPSBtXCpuBWbrKwM=
X-Google-Smtp-Source: ABdhPJzDVArhOd+kLFt2rL9MQKKEsWovIySrg3UJwo0Iv+0lzRuvHpB/w00LX+tWqnD2g7LiiG7vR8NQyDodmLekHG0=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr18298736otk.108.1600324745877;
 Wed, 16 Sep 2020 23:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200914204209.256266093@linutronix.de> <CAHk-=win80rdof8Pb=5k6gT9j_v+hz-TQzKPVastZDvBe9RimQ@mail.gmail.com>
 <871rj4owfn.fsf@nanos.tec.linutronix.de> <CAHk-=wj0eUuVQ=hRFZv_nY7g5ZLt7Fy3K7SMJL0ZCzniPtsbbg@mail.gmail.com>
 <87bli75t7v.fsf@nanos.tec.linutronix.de> <CAHk-=wht7kAeyR5xEW2ORj7m0hibVxZ3t+2ie8vNHLQfdbN2_g@mail.gmail.com>
 <CAKMK7uHAk9-Vy2cof0ws=DrcD52GHiCDiyHbjLd19CgpBU2rKQ@mail.gmail.com>
 <20200916152956.GV29330@paulmck-ThinkPad-P72> <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
In-Reply-To: <CAHk-=wjsMycgMHJrCmeetR3r+K5bpSRtmVWfd8iaoQCYd_VYAg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Sep 2020 09:38:54 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHbKVY_3s_DX_iv0gDbM+mcnP2Eh9ZkeXMPA9sZQVvapw@mail.gmail.com>
Message-ID: <CAMj1kXHbKVY_3s_DX_iv0gDbM+mcnP2Eh9ZkeXMPA9sZQVvapw@mail.gmail.com>
Subject: Re: [patch 00/13] preempt: Make preempt count unconditional
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 16 Sep 2020 at 21:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But something like a driver list walking thing should not be doing
> different things behind peoples back depending on whether they hold
> spinlocks or not. It should either just work regardless, or there
> should be a flag (or special interface) for the "you're being called
> in a crtitical region".
>
> Because dynamically changing behavior really is very confusing.
>

By the same reasoning, I don't think a generic crypto library should
be playing tricks with preemption en/disabling under the hood when
iterating over some data that is all directly accessible via the
linear map on the platforms that most people care about. And using
kmap_atomic() unconditionally achieves exactly that.

As I argued before, the fact that kmap_atomic() can be called from an
atomic context, and the fact that its implementation on HIGHMEM
platforms requires preemption to be disabled until the next kunmap()
are two different things, and I don't agree with your assertion that
the name kmap_atomic() implies the latter semantics. If we can avoid
disabling preemption on HIGHMEM, as Thomas suggests, we surely don't
need it on !HIGHMEM either, and given that kmap_atomic() is preferred
today anyway, we can just merge the two implementations. Are there any
existing debug features that could help us spot [ab]use of things like
raw per-CPU data within kmap_atomic regions?

Re your point about deprecating HIGHMEM: some work is underway on ARM
to implement a 3.75/3.75 GB kernel/user split on recent LPAE capable
hardware (which shouldn't suffer from the performance issues that
plagued the 4/4 split on i686), and so hopefully, there is a path
forward for ARM that does not rely on HIGHMEM as it does today.
