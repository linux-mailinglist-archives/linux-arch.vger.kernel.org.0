Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D4511AB2
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiD0Nfj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 09:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbiD0Nfj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 09:35:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8A4756A;
        Wed, 27 Apr 2022 06:32:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651066344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7MGqKhcR2rK4bHhpyakvKk80PXfTvRpOEHw1CHocKs=;
        b=ohn+hC646sn2jflwe2+UxebhGiwPyBV84sJRxiAvyqE37QW7aGwEfptKKOcUr3GZ10ZGJO
        OK5sYNE/5x1GOtersnl4dBFpoxCEkYLpcHbf6zuIs/HjJsUQuhbYWTRIsF2BLKeE7EPZUT
        h+qiVebu5bZsClGL1aLHWFs9tBrvecF74Qxr29uhbym2tYsLjtJbiw7fhzfHj+2+unjHXy
        dVr2VwG+u3k3PQ0XxUQgqmFy6FCIBp95Hh3k7a0U6gcS13RuTKUADQ8fRSQ68kmWkShqAx
        U/Odt/SoCJYK6j45Dny0vD2N7WOyZ2n5EsUXkEohvuxsvRSwmyMwsH6cgyXa5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651066344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7MGqKhcR2rK4bHhpyakvKk80PXfTvRpOEHw1CHocKs=;
        b=bCDiX4Fi9GAN0Y217Gcsro/3hVbm6FpepZEqlCHPe0fNNCAHEf2xbGEkJ8g5sLfVYuqOV2
        ZiOzp4zTqL7wE2BQ==
To:     Alexander Potapenko <glider@google.com>, glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/46] kmsan: entry: handle register passing from
 uninstrumented code
In-Reply-To: <20220426164315.625149-29-glider@google.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-29-glider@google.com>
Date:   Wed, 27 Apr 2022 15:32:23 +0200
Message-ID: <87a6c6y7mg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26 2022 at 18:42, Alexander Potapenko wrote:

Can you please use 'entry:' as prefix. Slapping kmsan in front of
everything does not really make sense.

> Replace instrumentation_begin()	with instrumentation_begin_with_regs()
> to let KMSAN handle the non-instrumented code and unpoison pt_regs
> passed from the instrumented part.

That should be:

     from the non-instrumented part
or
     passed to the instrumented part

right?

> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -23,7 +23,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
>  	CT_WARN_ON(ct_state() != CONTEXT_USER);
>  	user_exit_irqoff();
>  
> -	instrumentation_begin();
> +	instrumentation_begin_with_regs(regs);

I can see what you are trying to do, but this will end up doing the same
thing over and over. Let's just look at a syscall.

__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
{
        ...
	nr = syscall_enter_from_user_mode(regs, nr)

  		__enter_from_user_mode(regs)
              		.....
			instrumentation_begin_with_regs(regs);
			....

                instrumentation_begin_with_regs(regs);
                ....                     

	instrumentation_begin_with_regs(regs);

	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
		/* Invalid system call, but still a system call. */
		regs->ax = __x64_sys_ni_syscall(regs);
	}

	instrumentation_end();

        syscall_exit_to_user_mode(regs);
		instrumentation_begin_with_regs(regs);
  		__syscall_exit_to_user_mode_work(regs);
  	instrumentation_end();
  	__exit_to_user_mode();

That means you memset state four times and unpoison regs four times. I'm
not sure whether that's desired.

instrumentation_begin()/end() are not really suitable IMO. They were
added to allow objtool to validate that nothing escapes into
instrumentable code unless annotated accordingly.

Thanks,

        tglx
