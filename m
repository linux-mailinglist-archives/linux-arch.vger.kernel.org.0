Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC662A019B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 10:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJ3JjO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ3JjO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 05:39:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B16C0613CF;
        Fri, 30 Oct 2020 02:39:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604050752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWXvaZJ4n33nUPpVqCcdjcDSYO5R/m7YAVCZo4qnz/w=;
        b=Ijhg5aiOMjBRx5rip6SYYGDFE2m3YLjbUBNKk+3NGBAB4R2XV1b2EqqlklIKhs9UUNQWQk
        z/BOQowWvycG+wd7WP6RDL8dKFwe1UJ0MqD2fe1iCRjFdXzP4PF0WPpHnySjM4mSn8TEDZ
        +rgRtwXuNFbgN3K9VuqJ5Qlvu3gg80bUbRb6nNMR+/JhtI3yWewHHZND9q4GfI+B5nak5E
        Txo5XRuNfIVvWuFUn8S5xduuQjkyrzj/pylK3pN+rsWG4as9auyvNfq1rB+V6+q9oD9RYg
        uWDVVgapgL3toLNiaXgwAR/Xo8x02IWniqNGp0tW1Ptti3gNq/7xKk1DGerynA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604050752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EWXvaZJ4n33nUPpVqCcdjcDSYO5R/m7YAVCZo4qnz/w=;
        b=irizuuQYfZdKA41k2RTCVBIm8nOzrSmQrzmbTW+9NWSzofxsL3XYrjHU85eqQdOWzHFOzN
        nZb9SEwnLnGs5ZBQ==
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
        linux-xtensa@linux-xtensa.org
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
In-Reply-To: <87pn50ob0s.fsf@nanos.tec.linutronix.de>
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com> <87pn50ob0s.fsf@nanos.tec.linutronix.de>
Date:   Fri, 30 Oct 2020 10:39:11 +0100
Message-ID: <87blgknjcw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30 2020 at 00:41, Thomas Gleixner wrote:
> On Thu, Oct 29 2020 at 16:11, Linus Torvalds wrote:
> No, you're not misreading it, but doing it conditionally would be a
> complete semantical disaster. kmap_atomic*() also disables preemption
> and pagefaults unconditionaly.  If that wouldn't be the case then every
> caller would have to have conditionals like 'if (CONFIG_HIGHMEM)' or
> worse 'if (PageHighMem(page)'.
>
> Let's not go there.
>
> Migrate disable is a less horrible plague than preempt and pagefault
> disable even if the scheduler people disagree due to the lack of theory
> backing that up :)
>
> The charm of the new interface is that users still can rely on per
> cpuness independent of being on a highmem plagued system. For non
> highmem systems the extra migrate disable/enable is really a minor
> nuissance.

thinking about it some more after having sleep and coffee, we actually
could hide the migrate disable in the actual highmem part.

But then we really should not name it kmap_local. 'local' suggests
locality, think local_irq*, local_bh* ... kmap_task would be more
accurate then.

Toughts?

        tglx
