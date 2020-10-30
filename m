Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115442A0EBD
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 20:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgJ3TfW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 15:35:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgJ3TfV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 15:35:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604086519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjnQMCzBdzGXaCOpmbjT8Ur9FZq3y7opRBflIXIldZw=;
        b=db633F26JvpFY6g0OD9+HbOB2bGDkf74GvzdnzaI3Jackio3Pxmuc4jaTjmmTn0rWAIpK+
        FwvojioAnGZiiH15k8FN/MiA2IKJM2U7IeHO0IsBZqBGgEsd8kwilqueFED/GNpoidpnzO
        yy2TxOvoKUkHNkNBXz892WSrXAjSj1bek74dJCnwm2fooU7rVOQjFed7q+Vvsmw9zNfHs4
        G2wInIc2Xh8w8e1+gsfiziPOVyn2tk/4xzLJndeycG1E0X5k3bHmibgmZZcOeJXy9ENlqt
        1WjhiLEbUG/fvEPPOJsLp5CaNR4eEbW+SMl/VHUu0cW+yWNLKzRpz7CwuUxChg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604086519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KjnQMCzBdzGXaCOpmbjT8Ur9FZq3y7opRBflIXIldZw=;
        b=il7YKHjaiUFmDOQKgI3UCsxgkMmYaTjOnYVZzaPy8He727Hr6NRROPSIn6WIMwC/jiW6Jw
        nlMa3TiG03b3UjDQ==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
In-Reply-To: <20201030130627.GI27442@casper.infradead.org>
References: <20201029221806.189523375@linutronix.de> <20201030130627.GI27442@casper.infradead.org>
Date:   Fri, 30 Oct 2020 20:35:18 +0100
Message-ID: <87k0v7mrrd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30 2020 at 13:06, Matthew Wilcox wrote:
> On Thu, Oct 29, 2020 at 11:18:06PM +0100, Thomas Gleixner wrote:
>> This series provides kmap_local.* iomap_local variants which only disable
>> migration to keep the virtual mapping address stable accross preemption,
>> but do neither disable pagefaults nor preemption. The new functions can be
>> used in any context, but if used in atomic context the caller has to take
>> care of eventually disabling pagefaults.
>
> Could I ask for a CONFIG_KMAP_DEBUG which aliases all the kmap variants
> to vmap()?  I think we currently have a problem in iov_iter on HIGHMEM
> configs:

For kmap() that would work, but for kmap_atomic() not so much when it is
called in non-preemptible context because vmap() might sleep.

> copy_page_to_iter() calls page_copy_sane() which checks:
>
>         head = compound_head(page);
>         if (likely(n <= v && v <= page_size(head)))
>                 return true;
>
> but then:
>
>                 void *kaddr = kmap_atomic(page);
>                 size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
>                 kunmap_atomic(kaddr);
>
> so if offset to offset+bytes is larger than PAGE_SIZE, this is going to
> work for lowmem pages and fail miserably for highmem pages.  I suggest
> vmap() because vmap has a PAGE_SIZE gap between each allocation.

On 32bit highmem the kmap_atomic() case is easy: Double the number of
mapping slots and only use every second one, which gives you a guard
page between the maps.

For 64bit we could do something ugly: Enable the highmem kmap_atomic()
crud and enforce an alias mapping (at least on the architectures where
this is reasonable). Then you get the same as for 32bit.

> Alternatively if we could have a kmap_atomic_compound(), that would
> be awesome, but probably not realistic to implement.  I've more
> or less resigned myself to having to map things one page at a time.

That might be horribly awesome on 32bit :)

Thanks,

        tglx
