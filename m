Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE5479690
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhLQVwD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 16:52:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhLQVv7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 16:51:59 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639777918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AT2D4l2B7gM1XeRgIpRAp9+Ku96ZpvKzPu5JSMbwNS0=;
        b=ZKVZHy79OUfLqeNlY9BPm+IvQJe2D/rq0NPmuXGTrAdH2NuBVX3cp0XeXpgNjpAhLFtf1Q
        azRrW/FLt5o8aRZhLfVTVcXhk+OYYTSpWP6MO6LLiEQ5eYlq/ZoMcPZ4/njjSgv/ihUALI
        XK0Tv4HliXC9VVuGFg9ouO7bjtA8ty63t5A/Owsq2rrigd/zwmMfRinDtX8fsyk1AzqEBk
        hFVkeoqDJEbDjygS8i97ohoTbxMn/PKKngPeHYLo8B1wbrrjDrVT4mlKD9niijSkc1pkT+
        2VRtsefqu+Lpk3i/9dWUorDuihvUE2+AjE3hQR7rDoTxz0xU8QjbV7UelGD/+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639777918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AT2D4l2B7gM1XeRgIpRAp9+Ku96ZpvKzPu5JSMbwNS0=;
        b=h6Nbh3aDlpBkkO5FE3mZMJIvZzB5kYR0sUKQn8VSX+/j1dQO8KrxZq3IrXhnx140ZkPHM8
        1FKGLyqknjKHxpAg==
To:     Alexander Potapenko <glider@google.com>, glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 39/43] x86: kmsan: handle register passing from
 uninstrumented code
In-Reply-To: <20211214162050.660953-40-glider@google.com>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-40-glider@google.com>
Date:   Fri, 17 Dec 2021 22:51:57 +0100
Message-ID: <87bl1ec32a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Alexander,

On Tue, Dec 14 2021 at 17:20, Alexander Potapenko wrote:
> When calling KMSAN-instrumented functions from non-instrumented
> functions, function parameters may not be initialized properly, leading
> to false positive reports. In particular, this happens all the time when
> calling interrupt handlers from `noinstr` IDT entries.
>
> Fortunately, x86 code has instrumentation_begin() and

It's not only x86 code:
>  kernel/entry/common.c           | 3 +++

> @@ -76,6 +77,7 @@ __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
>  	nr = syscall_enter_from_user_mode(regs, nr);
>  
>  	instrumentation_begin();
> +	kmsan_instrumentation_begin(regs);

Can we please make this something like:

       instrumentation_begin_at_entry(regs);

or some other sensible name which hides that kmsan gunk and avoids to
touch all of this again when KFOOSAN comes around?

Thanks,

        tglx



