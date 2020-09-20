Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D794A2712FB
	for <lists+linux-arch@lfdr.de>; Sun, 20 Sep 2020 10:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgITItY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Sep 2020 04:49:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITItY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2020 04:49:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600591762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yl4SJva1ZaL/QSosb5XX7oiMR9yOUZ2hryRMeN6gUOs=;
        b=h8jv+yltDHIngnBBGJjPbxbwRp4WWvfUYCE010JZcD8mxV4UaeO8dLdDu13Q2cG+LY8JOQ
        h6npHbPhilGj3v1VUqWxvnxWjS/ksALdSUA+5C9fXgz9TR+62SaZPqFm9CDQlxwGmO5sxH
        Og/nMSeW9my8zlDQTOZZtLu/e9zkMmPgdx5NK5E8Rcfn4iS1ni7EpBlci97FKZLWMkER3O
        +JFJopKrMaT622cTfw+fq7PTs6AJTMpiNhuh5DlxWwRcA1+vumWCIqGRFavPq8Rwh2wOji
        LMGpm7pbhOs/2HMUMaIGkJEZas3RBbG5QRgXaIHLQPqkcnXaia1X2M3U1G452Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600591762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yl4SJva1ZaL/QSosb5XX7oiMR9yOUZ2hryRMeN6gUOs=;
        b=ZMmhQ6D75ka6LNiomg7OC2DwIv8yEqOFqmHU4LlJlX/duWyJlSPDqvfBsTbUq7MYp5KhFm
        dW4ZRnByLA6ZBcCQ==
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
In-Reply-To: <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
Date:   Sun, 20 Sep 2020 10:49:21 +0200
Message-ID: <87k0wode9a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 20 2020 at 08:41, Thomas Gleixner wrote:
> On Sat, Sep 19 2020 at 10:18, Linus Torvalds wrote:
>> Maybe I've missed something.  Is it because the new interface still
>> does "pagefault_disable()" perhaps?
>>
>> But does it even need the pagefault_disable() at all? Yes, the
>> *atomic* one obviously needed it. But why does this new one need to
>> disable page faults?
>
> It disables pagefaults because it can be called from atomic and
> non-atomic context. That was the point to get rid of
>
>          if (preeemptible())
>          	kmap();
>          else
>                 kmap_atomic();
>
> If it does not disable pagefaults, then it's just a lightweight variant
> of kmap() for short lived mappings.

Actually most usage sites of kmap atomic do not need page faults to be
disabled at all. As Daniel pointed out the implicit pagefault disable
enforces copy_from_user_inatomic() even in places which are clearly
preemptible task context.

As we need to look at each instance anyway we can add the PF disable
explicitely to the very few places which actually need it.

Thanks,

        tglx

