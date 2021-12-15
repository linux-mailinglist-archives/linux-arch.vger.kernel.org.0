Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8ED475A75
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbhLOORS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 09:17:18 -0500
Received: from foss.arm.com ([217.140.110.172]:53282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243269AbhLOORS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 09:17:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 981E4143B;
        Wed, 15 Dec 2021 06:17:17 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52853F774;
        Wed, 15 Dec 2021 06:17:12 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:17:09 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
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
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/43] kmsan: disable physical page merging in biovec
Message-ID: <Ybn45VpVhjeSqt/S@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-34-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-34-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:40PM +0100, Alexander Potapenko wrote:
> KMSAN metadata for consequent physical pages may be inconsequent,

I think you mean 'adjacent'/ rather than 'consequent' here, i.e.

| KMSAN metadata for adjacent physical pages may not be adjacent

> therefore accessing such pages together may lead to metadata
> corruption.
> We disable merging pages in biovec to prevent such corruptions.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> 
> Link: https://linux-review.googlesource.com/id/Iece16041be5ee47904fbc98121b105e5be5fea5c
> ---
>  block/blk.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/block/blk.h b/block/blk.h
> index ccde6e6f17360..e0c62a5d5639e 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -103,6 +103,13 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
>  	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
>  	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
>  
> +	/*
> +	 * Merging consequent physical pages may not work correctly under KMSAN
> +	 * if their metadata pages aren't consequent. Just disable merging.
> +	 */

Likewise here.

Mark.

> +	if (IS_ENABLED(CONFIG_KMSAN))
> +		return false;
> +
>  	if (addr1 + vec1->bv_len != addr2)
>  		return false;
>  	if (xen_domain() && !xen_biovec_phys_mergeable(vec1, vec2->bv_page))
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
