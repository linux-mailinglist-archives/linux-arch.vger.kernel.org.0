Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04D5A343C
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 06:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiH0EAP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 00:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH0EAN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 00:00:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419F5F98F;
        Fri, 26 Aug 2022 21:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF4CAB833B5;
        Sat, 27 Aug 2022 04:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A2EC433C1;
        Sat, 27 Aug 2022 04:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661572807;
        bh=f6Byd6ChECw5xYH+6Y2y1ZiARHvARqqCPTAE4lA8IIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WH42edJ2VD3Ojjg8chX+Cg2VHFV1gaB/4K28/BzPpkPRw8aeeF3M26GVWfNIrCF37
         52xwpinhWGUBISJY8M7CGFBt4MQlflsw8MwUISTbsV/gAfT3IanZnnQpMTn31QegaE
         VHPYBQpohuZjp/OaAtGOvl4UOb88I50wPCqk0UHg=
Date:   Fri, 26 Aug 2022 21:00:05 -0700
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
Subject: Re: [PATCH v5 11/44] kmsan: add KMSAN runtime core
Message-Id: <20220826210005.8e5f3bbef882c35d9c45102e@linux-foundation.org>
In-Reply-To: <20220826150807.723137-12-glider@google.com>
References: <20220826150807.723137-1-glider@google.com>
        <20220826150807.723137-12-glider@google.com>
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

On Fri, 26 Aug 2022 17:07:34 +0200 Alexander Potapenko <glider@google.com> wrote:

>
> ...
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -14,6 +14,7 @@
>  #include <linux/pid.h>
>  #include <linux/sem.h>
>  #include <linux/shm.h>
> +#include <linux/kmsan.h>
>  #include <linux/mutex.h>
>  #include <linux/plist.h>
>  #include <linux/hrtimer.h>
> @@ -1355,6 +1356,10 @@ struct task_struct {
>  #endif
>  #endif
>  
> +#ifdef CONFIG_KMSAN
> +	struct kmsan_ctx		kmsan_ctx;
> +#endif
> +
>  #if IS_ENABLED(CONFIG_KUNIT)
>  	struct kunit			*kunit_test;
>  #endif

This change causes the arm allnoconfig build to fail.

In file included from <command-line>:
./include/linux/page-flags.h: In function '_compound_head':
./include/linux/page-flags.h:253:44: error: invalid use of undefined type 'const struct page'
  253 |         unsigned long head = READ_ONCE(page->compound_head);
      |                                            ^~
././include/linux/compiler_types.h:335:23: note: in definition of macro '__compiletime_assert'
  335 |                 if (!(condition))                                       \
      |                       ^~~~~~~~~

[10,000 lines snipped]

A simple `make init/do_mounts.o' sets it off.

It's Friday night and I got tired of trying to work out why :(

I don't think it's kmsan's fault - seems to be somewhere between
include/linux/topology.h and its use of
arch/arm/include/asm/topology.h.

Shudder.  arm defconfig is OK.  I think I'll pretend I didn't see this
and push it out anyway and see if someone else has the patience.
