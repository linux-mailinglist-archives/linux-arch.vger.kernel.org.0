Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802602712B8
	for <lists+linux-arch@lfdr.de>; Sun, 20 Sep 2020 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgITGlG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Sep 2020 02:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgITGlG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2020 02:41:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D03C061755;
        Sat, 19 Sep 2020 23:41:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600584063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CoLGj4bgeeSGrBtXaSAQtCzCSINs+vZ2LYYnDPrnZo8=;
        b=ZbudrrXW3BmBlMSesKPCFcaOuHlyqPwGJ2rDhOMbxt3mPAnInwIbTwlFWdXYV8k68cqtaX
        KfEuU6M33k6TNgEv2z3BoREDlGO2O9Fw5TgP2+5hcpWK7uStRqjbWtSKwO3gS4QCuyivwy
        26cuDkJvS5X9yMAUHVa9s0UJUt+J6543xHxV5P3DaWXrCCPeOCRdXjTt3mHzSFT/GSvW6o
        JaVOcgOKbttRfnVUr6cHm/Y19mE/tWAhhxXhM/hU7XhieUh+8YV+lRCkQmefuoxYeKpcBS
        Vf7k79LGubJaArfFULHNmfuj7TyKvSea5/MDMs+6uMgB8Li/jQ7m/qvIhWo6HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600584063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CoLGj4bgeeSGrBtXaSAQtCzCSINs+vZ2LYYnDPrnZo8=;
        b=hJcFT5y1jFrtCoruYoZORnqggnYSJ5Wm/G+vHz1SccOLs4xq3SNs6bWtqMz5RIfu775hAi
        dKKPo41u4g/pn4AQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list\:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
In-Reply-To: <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
Date:   Sun, 20 Sep 2020 08:41:02 +0200
Message-ID: <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19 2020 at 10:18, Linus Torvalds wrote:
> On Sat, Sep 19, 2020 at 2:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> this provides a preemptible variant of kmap_atomic & related
>> interfaces. This is achieved by:
>
> Ack. This looks really nice, even apart from the new capability.
>
> The only thing I really reacted to is that the name doesn't make sense
> to me: "kmap_temporary()" seems a bit odd.

Yeah. Couldn't come up with something useful.

> Particularly for an interface that really is basically meant as a
> better replacement of "kmap_atomic()" (but is perhaps also a better
> replacement for "kmap()").
>
> I think I understand how the name came about: I think the "temporary"
> is there as a distinction from the "longterm" regular kmap(). So I
> think it makes some sense from an internal implementation angle, but I
> don't think it makes a lot of sense from an interface name.
>
> I don't know what might be a better name, but if we want to emphasize
> that it's thread-private and a one-off, maybe "local" would be a
> better naming, and make it distinct from the "global" nature of the
> old kmap() interface?

Right, _local or _thread would be more intuitive.

> However, another solution might be to just use this new preemptible
> "local" kmap(), and remove the old global one entirely. Yes, the old
> global one caches the page table mapping and that sounds really
> efficient and nice. But it's actually horribly horribly bad, because
> it means that we need to use locking for them. Your new "temporary"
> implementation seems to be fundamentally better locking-wise, and only
> need preemption disabling as locking (and is equally fast for the
> non-highmem case).
>
> So I wonder if the single-page TLB flush isn't a better model, and
> whether it wouldn't be a lot simpler to just get rid of the old
> complex kmap() entirely, and replace it with this?
>
> I agree we can't replace the kmap_atomic() version, because maybe
> people depend on the preemption disabling it also implied. But what
> about replacing the non-atomic kmap()?
>
> Maybe I've missed something.  Is it because the new interface still
> does "pagefault_disable()" perhaps?
>
> But does it even need the pagefault_disable() at all? Yes, the
> *atomic* one obviously needed it. But why does this new one need to
> disable page faults?

It disables pagefaults because it can be called from atomic and
non-atomic context. That was the point to get rid of

         if (preeemptible())
         	kmap();
         else
                kmap_atomic();

If it does not disable pagefaults, then it's just a lightweight variant
of kmap() for short lived mappings.

> But apart from that question about naming (and perhaps replacing
> kmap() entirely), I very much like it.

I thought about it, but then I figured that kmap pointers can be
handed to other contexts from the thread which sets up the mapping
because it's 'permanent'.

I'm not sure whether that actually happens, so we'd need to audit all
kmap() users to be sure. If there is no such use case, then we surely
can get of rid of kmap() completely. It's only 300+ instances to stare
at and quite some of them are wrapped into other functions.

Highmem sucks no matter what and the only sane solution is to remove it
completely.

Thanks,

        tglx

