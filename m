Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4A2A0631
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 14:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgJ3NHB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 09:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3NHB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 09:07:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DAC0613CF;
        Fri, 30 Oct 2020 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rfcpHo3sYbHG9663+/oEKU5+yDacWVNSfCtmxqY30IA=; b=JKDGOHNWU/V8Y+2rs/k7xDcd+D
        ywFaOKdh66CG7CRxohaMqHaFLXYS9D8UEmY4cTPadxISCv3CHKX+79wCldI0LV8nLjJimNpRjUFot
        BbcFgkfMoOoVVqbSn6at/tUwkE3W4TeiBSkn85uGjZxEhlxcEUEn86bKSTG6W3x+/e6w76iTiIDMo
        +S7YG45wv9UKO0gFrKbYfO0n5SfTbF1pG2kSlc2FKZXNaKU1XoICbQHjohPVjgTGHFNPIe1Xmtc6u
        jm1U+Hxe5+XhivRe6Qrj/AgJuMiGDjrS/uMW8LgIirsxF3LkwsBxbZgQIkCutkdRTk0XP+Op+X95w
        kA9B9H+g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYU6t-0002Yw-HM; Fri, 30 Oct 2020 13:06:27 +0000
Date:   Fri, 30 Oct 2020 13:06:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic
 & friends
Message-ID: <20201030130627.GI27442@casper.infradead.org>
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029221806.189523375@linutronix.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 29, 2020 at 11:18:06PM +0100, Thomas Gleixner wrote:
> This series provides kmap_local.* iomap_local variants which only disable
> migration to keep the virtual mapping address stable accross preemption,
> but do neither disable pagefaults nor preemption. The new functions can be
> used in any context, but if used in atomic context the caller has to take
> care of eventually disabling pagefaults.

Could I ask for a CONFIG_KMAP_DEBUG which aliases all the kmap variants
to vmap()?  I think we currently have a problem in iov_iter on HIGHMEM
configs:

copy_page_to_iter() calls page_copy_sane() which checks:

        head = compound_head(page);
        if (likely(n <= v && v <= page_size(head)))
                return true;

but then:

                void *kaddr = kmap_atomic(page);
                size_t wanted = copy_to_iter(kaddr + offset, bytes, i);
                kunmap_atomic(kaddr);

so if offset to offset+bytes is larger than PAGE_SIZE, this is going to
work for lowmem pages and fail miserably for highmem pages.  I suggest
vmap() because vmap has a PAGE_SIZE gap between each allocation.

Alternatively if we could have a kmap_atomic_compound(), that would
be awesome, but probably not realistic to implement.  I've more
or less resigned myself to having to map things one page at a time.
