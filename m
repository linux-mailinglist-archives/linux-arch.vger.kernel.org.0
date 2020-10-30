Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B82A019C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Oct 2020 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3Jjv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Oct 2020 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3Jjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Oct 2020 05:39:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C05C0613CF;
        Fri, 30 Oct 2020 02:39:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604050789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAnK7jywPa1GOe2OuqwDJLyZGDzUuixXtlwihZHVsUc=;
        b=DJVMSRd0qSrh4qYCn9wA493aNBmMgpWEcC+DvdpwzaRDvlM9GLKnEgKej1q9Pjzm9R+Wbs
        SDi3g+IJ46Uix1vGIe/ZYW4m61MI+Iaw5AZAFaLpBqWgGMlssdhbZlo/f7rBhKNBzNp0ql
        AfNrswKRF+YJTa9uIYVgSjvVSA2hm+3Uo8FE2CUbADDpAaUi5+pLITUyecfHGq85dCGrM6
        ye41RcUorO4bMmTTQADOv++RFFw5xbZssFQqXyqHenRIXBZCR3WWb7IZDjqY6k6VEbvE3u
        Tfhh5ZTwPL+4DOCzh5iRmbXJG66Efnr9i/wjo97sHGpkIG/AcCkDrLPDQ7sJmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604050789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAnK7jywPa1GOe2OuqwDJLyZGDzUuixXtlwihZHVsUc=;
        b=xjkTScsjovLjMF5jCfSAo4zF71pVuZpjsm7SHzu9Cw8PlE4P8sLRwcUur1ZnT3ITuwSffU
        9R+g3a6sInOEqeDg==
To:     Christoph Hellwig <hch@lst.de>
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
In-Reply-To: <20201030072508.GA18471@lst.de>
References: <20201029221806.189523375@linutronix.de> <20201030072508.GA18471@lst.de>
Date:   Fri, 30 Oct 2020 10:39:49 +0100
Message-ID: <87a6w4njbu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 30 2020 at 08:25, Christoph Hellwig wrote:
> On Thu, Oct 29, 2020 at 11:18:06PM +0100, Thomas Gleixner wrote:
>>  - Consolidating all kmap atomic implementations in generic code
>
> I think the consolidation is a winner no matter where we go next.  Maybe
> split it out in a prep series so we can get it in ASAP?

Yes, patch 2-15 can just go without any dependency. The only thing which
needs a bit of thought is naming. See the other reply to Linus.

Thanks,

        tglx
