Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845072732C7
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgIUT2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 15:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53520 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUT2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 15:28:01 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600716477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NioanSWzd78GxCsWYULMNfEWngL7gbmu+5wZKJGKPtI=;
        b=HxqY5bgmLL1k0f3vQQxKwcT5ry3L+n9eWbaa33JpgBbIQhQKyF5a3ij8mv6CpgblAufPcl
        /NboBbVSLMzTqFGT0TjywuRmfs5bzTYeJmHXAxo0CVpHx+Vc+AcZ01mg2TfMdqQ2YBFUr0
        T0biE/Xj6CpNppEeI1NN60+4LlXdME7cpu0hU+LkVE2Ap5bde7RRe7hWtZJQkXhhKWa8iV
        9G4YL/t1/f3WBUyUCaKsXVKPluf5ho1Tri7IYKrkld4lHHpsIFR2kj//UAVDisud0CvF9E
        Y+o/6lfteq1OBhGqZU5+eNzFDwvEzWDxVn5dG5jL6fLqKaz4jlZKqLWOR91+lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600716477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NioanSWzd78GxCsWYULMNfEWngL7gbmu+5wZKJGKPtI=;
        b=K+USVXwNO19/CLwxF7hr/zQjzSe76M0Cqo3jC86XX3is24rhnFQjsCVAxPA8kns3xbx5QG
        vlmVOJebsjPrOqAg==
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
In-Reply-To: <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com> <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de> <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de> <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com> <87a6xjd1dw.fsf@nanos.tec.linutronix.de> <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
Date:   Mon, 21 Sep 2020 21:27:57 +0200
Message-ID: <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21 2020 at 09:24, Linus Torvalds wrote:
> On Mon, Sep 21, 2020 at 12:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> If a task is migrated to a different CPU then the mapping address will
>> change which will explode in colourful ways.
>
> Right you are.
>
> Maybe we really *could* call this new kmap functionality something
> like "kmap_percpu()" (or maybe "local" is good enough), and make it
> act like your RT code does for spinlocks - not disable preemption, but
> only disabling CPU migration.

I"m all for it, but the scheduler people have opinions :)

> That would probably be good enough for a lot of users that don't want
> to expose excessive latencies, but where it's really not a huge deal
> to say "stick to this CPU for a short while".
>
> The crypto code certainly sounds like one such case.

I looked at a lot of the kmap_atomic() places and quite some of them
only require migration to be disabled to keep the temporary map
stable.

Quite some code could be simplified significantly especially those
places which need to do copy_from/to_user inside these
sections. Graphics is the main example here as Daniel pointed out.

Alternatively this could of course be solved with per CPU page tables
which will come around some day anyway I fear.

Thanks,

        tglx
