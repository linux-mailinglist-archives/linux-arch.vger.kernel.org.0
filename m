Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C205BA217
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIOU6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 16:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiIOU6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 16:58:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A766745D;
        Thu, 15 Sep 2022 13:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA3D62691;
        Thu, 15 Sep 2022 20:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6C0C433D7;
        Thu, 15 Sep 2022 20:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663275520;
        bh=jc/TYaw+WPP6gHYLDH7WEd6O++ikGzJoRAZP9o8Co78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AiKuJ0pUVZax0M8NxOVJiRNYB9QOB0hIswUf9Rx7aEZjIQcqyxU3YQYd1CEiHKqvx
         CgDQwUOrECpX+88YLy5eMnQpBd1zGGmE/Vy6xJIFuI7knZ+7XtQocgRlD+55dy1HJs
         wjJ5zRa15PyH0SzLmIgdWUDepJL3U0dk5p2YuWe0=
Date:   Thu, 15 Sep 2022 13:58:38 -0700
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
Subject: Re: [PATCH v7 27/43] kmsan: disable physical page merging in biovec
Message-Id: <20220915135838.8ad6df0363ccbd671d9641a1@linux-foundation.org>
In-Reply-To: <20220915150417.722975-28-glider@google.com>
References: <20220915150417.722975-1-glider@google.com>
        <20220915150417.722975-28-glider@google.com>
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

On Thu, 15 Sep 2022 17:04:01 +0200 Alexander Potapenko <glider@google.com> wrote:

> KMSAN metadata for adjacent physical pages may not be adjacent,
> therefore accessing such pages together may lead to metadata
> corruption.
> We disable merging pages in biovec to prevent such corruptions.
> 
> ...
>
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -88,6 +88,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>  	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
>  	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
>  
> +	/*
> +	 * Merging adjacent physical pages may not work correctly under KMSAN
> +	 * if their metadata pages aren't adjacent. Just disable merging.
> +	 */
> +	if (IS_ENABLED(CONFIG_KMSAN))
> +		return false;
> +
>  	if (addr1 + vec1->bv_len != addr2)
>  		return false;
>  	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))

What are the runtime effects of this?  In other words, how much
slowdown is this likely to cause in a reasonable worst-case?
