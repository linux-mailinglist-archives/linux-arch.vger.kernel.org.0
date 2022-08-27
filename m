Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D935F5A3453
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 06:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiH0ERe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 00:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0ERd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 00:17:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744CD73933;
        Fri, 26 Aug 2022 21:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E99B460A39;
        Sat, 27 Aug 2022 04:17:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299E8C433D6;
        Sat, 27 Aug 2022 04:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661573851;
        bh=6Iz/eGwmp2OnF5aKahMz1qTW0tTKm7mlFOFhFDxX1AA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0wwPwPqYjbGm6Ce5o/Y1H+DJmaTo4tbspFfmRDrZEp4vlLxYw57ALtc0CXFnvMbGh
         VFCSnWNxDc7JkINYWGfzPhl/loGQPXhQADf4HucY5q1H3K85IqB7J0Fx6rs5x3gQei
         vqaTpKDnySwwiXOltZ9lClnMZEmM8Ob5p56kBsi0=
Date:   Fri, 26 Aug 2022 21:17:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user()
 and put_user()
Message-Id: <20220826211729.e65d52e7919fee5c34d22efc@linux-foundation.org>
In-Reply-To: <20220826150807.723137-5-glider@google.com>
References: <20220826150807.723137-1-glider@google.com>
        <20220826150807.723137-5-glider@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 26 Aug 2022 17:07:27 +0200 Alexander Potapenko <glider@google.com> wrote:

> Use hooks from instrumented.h to notify bug detection tools about
> usercopy events in variations of get_user() and put_user().

And this one blows up x86_64 allmodconfig builds.

> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -5,6 +5,7 @@
>   * User space memory access functions
>   */
>  #include <linux/compiler.h>
> +#include <linux/instrumented.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/string.h>
>  #include <asm/asm.h>

instrumented.h looks like a higher-level thing than uaccess.h, so this
inclusion is an inappropriate layering.  Or maybe not.

In file included from ./include/linux/kernel.h:22,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/nospec-branch.h:14,
                 from ./arch/x86/include/asm/paravirt_types.h:40,
                 from ./arch/x86/include/asm/ptrace.h:97,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:13,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:67,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from init/do_mounts.c:2:
./include/linux/page-flags.h: In function 'page_fixed_fake_head':
./include/linux/page-flags.h:226:36: error: invalid use of undefined type 'const struct page'
  226 |             test_bit(PG_head, &page->flags)) {
      |                                    ^~

[25000 lines snipped]


And kmsan-add-kmsan-runtime-core.patch introduces additional build
errors with x86_64 allmodconfig.

This is all with CONFIG_KMSAN=n

I'll disable the patch series.  Please do much more compilation testing
- multiple architectures, allnoconfig, allmodconfig, allyesconfig,
defconfig, randconfig, etc.  Good luck, it looks ugly :(

