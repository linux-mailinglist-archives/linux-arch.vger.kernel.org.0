Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F602A119E
	for <lists+linux-arch@lfdr.de>; Sat, 31 Oct 2020 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJ3X0K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 19:26:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3X0J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 19:26:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604100366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BysKp1h3o8sBMwB2TAPG1V2I6LPAOQLiaGarMRHzzeQ=;
        b=msLkbucZt6Zr2TdRRib4dyDR0Hmqjd9PCcJZcYk2Y1Kr1ZHeC/yu/EIwOLyVB56b5rrdpp
        OdacYuXpMYpjP9QvQoxSkUy4+15KZ7mnez1Lt6Lta84CJdyeg+J/0zUeLEoJRKfOx53S17
        dCpw0E5DGGOzwLCo8DNxzDNhnmNdmwNB6oX0FgcV8OsiJcfbj1iTy+odpmjKWyPbeoJbMv
        smX85NvwI3DS8olPym6LnXfgy7AKd0tQ6O98pWv/VYPzafvQyU//DV2jk5nWx0metTssku
        W29H4CAvM6xIk6KZE+gueTFcCV2msyvYHhyoy0vdg3fzuoyZKUA7dZJxYuDW2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604100366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BysKp1h3o8sBMwB2TAPG1V2I6LPAOQLiaGarMRHzzeQ=;
        b=ukQ/zD3pRqCynz3kjYH2vqm7QEULUzQexquSIj29pG2BIqkPvy5LfqQiDopGo7rLLtVPFL
        ef6qN/D2BkNlx2CQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list\:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
In-Reply-To: <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com> <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de> <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com> <87sg9vl59i.fsf@nanos.tec.linutronix.de> <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com>
Date:   Sat, 31 Oct 2020 00:26:05 +0100
Message-ID: <87pn4zl2ia.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30 2020 at 15:46, Linus Torvalds wrote:
> On Fri, Oct 30, 2020 at 3:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> To me, your patch series has two big advantages:
>
>  - more common code
>
>  - kmap_local() becomes more of a no-op
>
> and the last thing we want is to expand on kmap.

Happy to go with that.

While trying to document the mess, I just stumbled over the abuse of
kmap_atomic_prot() in

drivers/gpu/drm/ttm/ttm_bo_util.c:      dst = kmap_atomic_prot(d, prot);
drivers/gpu/drm/ttm/ttm_bo_util.c:      src = kmap_atomic_prot(s, prot);
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:   kmap_atomic_prot(d->dst_pages[dst_page],
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:   kmap_atomic_prot(d->src_pages[src_page],

For !HIGHMEM kmap_atomic_prot() just ignores the 'prot' argument and
returns the page address. 

Moar patches to be written ... Sigh!

Thanks,

        tglx




