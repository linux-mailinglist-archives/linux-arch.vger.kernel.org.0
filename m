Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266A5BA22F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 23:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIOVHx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 17:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiIOVHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 17:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E8B93227;
        Thu, 15 Sep 2022 14:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09BFE62699;
        Thu, 15 Sep 2022 21:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE2C433D6;
        Thu, 15 Sep 2022 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663276070;
        bh=ubg4i5YlfYJ6scG2ITwu9cE1IPvtdkwcRwNy86IfiVU=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=NULC6DLc5IlNv/tkUftQeolM+VBnoHSQr5R0d0rIDdb8Vr1NOlM66beQKYA5RMu51
         5VH4cSyNptiu3LOju06TiIrdu00EzALj8SCBglJUvKHhIqG7wLUoYXxTyjJEL2d/Vb
         LJvM7HflPtQC8XOz7Til1rEfg87dKsSwj1xVO2V8=
Date:   Thu, 15 Sep 2022 14:07:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/43] Add KernelMemorySanitizer infrastructure
Message-Id: <20220915140748.843a2ebc2efb35f509b56ef4@linux-foundation.org>
In-Reply-To: <20220915140551.2558e64c6a3d3a57d7588f5d@linux-foundation.org>
References: <20220915150417.722975-1-glider@google.com>
        <20220915140551.2558e64c6a3d3a57d7588f5d@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 15 Sep 2022 14:05:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> For "kmsan: add KMSAN runtime core":
> 
> ...
>
> @@ -219,23 +212,22 @@ depot_stack_handle_t kmsan_internal_chai
>  	 * Make sure we have enough spare bits in @id to hold the UAF bit and
>  	 * the chain depth.
>  	 */
> -	BUILD_BUG_ON((1 << STACK_DEPOT_EXTRA_BITS) <= (MAX_CHAIN_DEPTH << 1));
> +	BUILD_BUG_ON(
> +		(1 << STACK_DEPOT_EXTRA_BITS) <= (KMSAN_MAX_ORIGIN_DEPTH << 1));
>  
>  	extra_bits = stack_depot_get_extra_bits(id);
>  	depth = kmsan_depth_from_eb(extra_bits);
>  	uaf = kmsan_uaf_from_eb(extra_bits);
>  
> -	if (depth >= MAX_CHAIN_DEPTH) {
> -		static atomic_long_t kmsan_skipped_origins;
> -		long skipped = atomic_long_inc_return(&kmsan_skipped_origins);
> -
> -		if (skipped % NUM_SKIPPED_TO_WARN == 0) {
> -			pr_warn("not chained %ld origins\n", skipped);
> -			dump_stack();
> -			kmsan_print_origin(id);
> -		}

Wouldn't it be neat if printk_ratelimited() returned true if it printed
something.

But you deleted this user of that neatness anyway ;)


