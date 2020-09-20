Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7427164B
	for <lists+linux-arch@lfdr.de>; Sun, 20 Sep 2020 19:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgITRYx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Sep 2020 13:24:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgITRYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2020 13:24:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600622689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELUNMLCQYXoHQWzGjHTiBi/GvrgBrzUdsStDgdETjPA=;
        b=tzqY9X8fLvmtivfsbNK0pUu8YiUj7NKf7+bQzIN33nK/SwghNMa2rz52k7m9LEaGnDxB4p
        5uJRP8jzSGhdLLpPzoF07YS1dppzeAHFuaRXBxkQ6eQFewoBrpPutv3yBGdR9YKqd5UnMc
        Lfw64Wh81l4jTzfijbUVM/G1PeB+l9wpVjsRPd3Xz3aQUHw9+Bu78ZLn5k1aNaH9Pkc5ms
        Lg9Dct8esi3AxOTl0URAWW4pIL6LMaz6yDqISWtV082sZby+eUJYHhPHZSuxMGdcllbxYl
        qQ/7nvxbGePtOn6SDA8Bi+zAxXBj+TvBWAwr7ALWt4wsGLJLJU/NhQ4k2+3KDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600622689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ELUNMLCQYXoHQWzGjHTiBi/GvrgBrzUdsStDgdETjPA=;
        b=Ajg419VRwVNBaCnESvnWBGYX1dQ8DDFprO3wwe5+UvEno+/XgboH3A5bxhtY6hr785JAXL
        VPGuKWoChMzzg9BQ==
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:GENERIC INCLUDE\/A..." <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>, X86 ML <x86@kernel.org>,
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
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        arcml <linux-snps-arc@lists.infradead.org>,
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
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of kmap_atomic & friends
In-Reply-To: <20200920082353.GG438822@phenom.ffwll.local>
References: <20200919091751.011116649@linutronix.de> <CAKMK7uHTVJL2jGtCg61zG=myiF1BSk+yDdRYikcm-Mq_1TQWMQ@mail.gmail.com> <CAKMK7uENFDANQKebS_H0bhHeQRijrp1aVHQqyZPute3KBZ+fVQ@mail.gmail.com> <87pn6hc6g1.fsf@nanos.tec.linutronix.de> <20200920082353.GG438822@phenom.ffwll.local>
Date:   Sun, 20 Sep 2020 19:24:49 +0200
Message-ID: <87h7rscqe6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 20 2020 at 10:23, Daniel Vetter wrote:

> On Sun, Sep 20, 2020 at 08:23:26AM +0200, Thomas Gleixner wrote:
>> On Sat, Sep 19 2020 at 12:37, Daniel Vetter wrote:
>> > On Sat, Sep 19, 2020 at 12:35 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>> >> I think it should be the case, but I want to double check: Will
>> >> copy_*_user be allowed within a kmap_temporary section? This would
>> >> allow us to ditch an absolute pile of slowpaths.
>> >
>> > (coffee just kicked in) copy_*_user is ofc allowed, but if you hit a
>> > page fault you get a short read/write. This looks like it would remove
>> > the need to handle these in a slowpath, since page faults can now be
>> > served in this new kmap_temporary sections. But this sounds too good
>> > to be true, so I'm wondering what I'm missing.
>> 
>> In principle we could allow pagefaults, but not with the currently
>> proposed interface which can be called from any context. Obviously if
>> called from atomic context it can't handle user page faults.
>  
> Yeah that's clear, but does the implemention need to disable pagefaults
> unconditionally?

As I wrote in the other reply it's not required and the final interface
will neither disable preemption nor pagefaults (except for the atomic
wrapper around it).

Thanks,

        tglx
