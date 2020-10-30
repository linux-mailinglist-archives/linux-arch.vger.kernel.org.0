Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E962A11C2
	for <lists+linux-arch@lfdr.de>; Sat, 31 Oct 2020 00:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ3XxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 19:53:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ3XxG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 19:53:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604101982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz1Lo4xloh2gm7jGRA98jpsF7G0W8WZ1zm340/bMNFg=;
        b=zRWoFFCvgFXvkgiRgd2PrNXxw0olM8jN9MbSlnu8Yx/bkkIwLGoWTGgE5i+fkO7y7sfeaU
        x3+aPSzi0iAtwo1vhwTgPleVK5/xOYWH8N2RRruBT8TdPfY1yZYoa6ljibdSog6RQ3gP6b
        u9DvoOLBFkfo24RQ7jamXSeMyTSj793ZoUFCoaa1YGqH033ahp/DnCR4xlXAoXzFSpH1x6
        yOJ/OV0er2B/4NNw+gN17a5j9W4zYUWj6YivuiRxMsRVquNHl+BF1GTYOstjhD+cwgQEKq
        s06u8I7IY1uEbPndJCEK7r6MHG28vjegHSi8SyClVAIgl5+Ri/+FYGlgYb5bjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604101982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fz1Lo4xloh2gm7jGRA98jpsF7G0W8WZ1zm340/bMNFg=;
        b=KMZe+VR6xvtTrU+cGlKn5VqvqFkwQoQ6BREOoFpj295prEyjjry9cru4z4uwe8nMiBCbyb
        2nsiSuFASxudGAAw==
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
In-Reply-To: <87pn4zl2ia.fsf@nanos.tec.linutronix.de>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com> <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de> <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com> <87sg9vl59i.fsf@nanos.tec.linutronix.de> <CAHk-=wjjO9BtTUAsLraqZqdzaPGJ-qvubZfwUsmRUX896eHcGw@mail.gmail.com> <87pn4zl2ia.fsf@nanos.tec.linutronix.de>
Date:   Sat, 31 Oct 2020 00:53:02 +0100
Message-ID: <87mu03l19d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 31 2020 at 00:26, Thomas Gleixner wrote:

> On Fri, Oct 30 2020 at 15:46, Linus Torvalds wrote:
>> On Fri, Oct 30, 2020 at 3:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> To me, your patch series has two big advantages:
>>
>>  - more common code
>>
>>  - kmap_local() becomes more of a no-op
>>
>> and the last thing we want is to expand on kmap.
>
> Happy to go with that.
>
> While trying to document the mess, I just stumbled over the abuse of
> kmap_atomic_prot() in
>
> drivers/gpu/drm/ttm/ttm_bo_util.c:      dst = kmap_atomic_prot(d, prot);
> drivers/gpu/drm/ttm/ttm_bo_util.c:      src = kmap_atomic_prot(s, prot);
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:   kmap_atomic_prot(d->dst_pages[dst_page],
> drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:   kmap_atomic_prot(d->src_pages[src_page],
>
> For !HIGHMEM kmap_atomic_prot() just ignores the 'prot' argument and
> returns the page address. 
>
> Moar patches to be written ... Sigh!

Or not. This is actually correct by some definition of correct. For
the non highmem case pgprot is set via the set_memory_*() functions and
this just handles the highmem case.

Comments are overrrated...
