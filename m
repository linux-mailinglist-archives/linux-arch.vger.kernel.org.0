Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055C62D9E6
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE2KB0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 06:01:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfE2KB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 06:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kIMbddNkHXghmps6hNcFGND377pg1jMOBcSZ29+JswM=; b=Yzc20FEHVCPJ9ZORtOsdeVIlW
        qlK1rz6WIzxNj+u1eNT8uCq+HK9lz33KU6hE54Ijh3PH4XyYrRCrrWgDBZhCiqtKX/cjEVJNpkZ8g
        xwqWSm5zOVGtGn1f5KKdyc3K5p/X8oddDjfRE76L6GdactyMFDnu746NZL0FoZ3SOVm/I8glr0J8w
        G8NPLiNFloCnHwPpqfHtBvTc73E0/EsVWmOZ6ouDCi12I+gP89tW9WG8UG0ftOFx7/osie8YgFRu7
        D2Kx2G6WxqTE+43HJ1ERg/RE3gRKJE/N5cu8Byl+vV01yomxmibTNt4ylwKBKoxH+qErh+4kEc7UP
        0dDJ8EyeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVvOY-0003zL-7S; Wed, 29 May 2019 10:01:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB46C20729088; Wed, 29 May 2019 12:01:16 +0200 (CEST)
Date:   Wed, 29 May 2019 12:01:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529100116.GM2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 29, 2019 at 11:20:17AM +0200, Marco Elver wrote:
> For the default, we decided to err on the conservative side for now,
> since it seems that e.g. x86 operates only on the byte the bit is on.

This is not correct, see for instance set_bit():

static __always_inline void
set_bit(long nr, volatile unsigned long *addr)
{
	if (IS_IMMEDIATE(nr)) {
		asm volatile(LOCK_PREFIX "orb %1,%0"
			: CONST_MASK_ADDR(nr, addr)
			: "iq" ((u8)CONST_MASK(nr))
			: "memory");
	} else {
		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
	}
}

That results in:

	LOCK BTSQ nr, (addr)

when @nr is not an immediate.
