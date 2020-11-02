Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96C12A22AF
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 02:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKBBI0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 Nov 2020 20:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbgKBBIZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 Nov 2020 20:08:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48CC0617A6;
        Sun,  1 Nov 2020 17:08:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604279303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uGtzWR3XDWVzxJPeTJwUrr+92QjqUI1P4Rl6d07MCc=;
        b=XrgDk26VSw3lMWxT80X6p2BiIELFfSd45uXmpqg40hcbZPvcaSEbWpk3R+GxKbboSmpFo7
        63BVEl/BSGohNcNmokSUofaOuAyVB8TF4zkcITLfRQimdDp0/NzDabt6xoWCRv1KCKeW7F
        JBfHL2Zd4jfQiOa73d8ngQE8XEVUJ3AcbNTfvECT7y8NW8OaNw3Ie/CbXJDQBPmopC0hi6
        3UpqoW4N6M5pY4xkTcBxiJGRWb665zE7gX5m+PKTKEvvjyV6Hoqyt5gxZLMHwAEcjlgo+r
        WdCkNHrQQLMZuU+RDrUNzqVy0E0MpRf3weVrn07sYqVIDzra4XxQNgHUkZAAnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604279303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uGtzWR3XDWVzxJPeTJwUrr+92QjqUI1P4Rl6d07MCc=;
        b=w804GlJ3cTjryaWI6xXsdwM5po9NFzF1/LMSPDCaZtr/gWtzM/1QwrA9gqRhs9hURGxtuJ
        nFG9PzKRhgh+hKBA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
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
        linux-xtensa@linux-xtensa.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
In-Reply-To: <20201029221806.189523375@linutronix.de>
References: <20201029221806.189523375@linutronix.de>
Date:   Mon, 02 Nov 2020 02:08:23 +0100
Message-ID: <87k0v48t14.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 29 2020 at 23:18, Thomas Gleixner wrote:
>
> There is also a still to be investigated question from Linus on the initial
> posting versus the per cpu / per task mapping stack depth which might need
> to be made larger due to the ability to take page faults within a mapping
> region.

I looked deeper into that and we have a stack depth of 20. That's plenty
and I couldn't find a way to get above 10 nested ones including faults,
interrupts, softirqs. With some stress testing I was not able to get over
a maximum of 6 according to the traceprintk I added.

For some obscure reason when CONFIG_DEBUG_HIGHMEM is enabled the stack
depth is increased from 20 to 41. But the only thing DEBUG_HIGHMEM does
is to enable a few BUG_ON()'s in the mapping code.

That's a leftover from the historical mapping code which had fixed
entries for various purposes. DEBUG_HIGHMEM inserted guard mappings
between the map types. But that got all ditched when kmap_atomic()
switched to a stack based map management. Though the WITH_KM_FENCE magic
survived without being functional. All the thing does today is to
increase the stack depth.

I just made that functional again by keeping the stack depth increase
and utilizing every second slot. That should catch Willy's mapping
problem nicely if he bothers to test on 32bit :)

Thanks,

        tglx

