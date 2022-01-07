Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71E5487B4B
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 18:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiAGRWM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 12:22:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiAGRWM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 12:22:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08565210EB;
        Fri,  7 Jan 2022 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641576131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UI+Qu+ntgMHu9DPaL+mEKxd+gHSWitvbHxpVywBZ1V4=;
        b=Mi4bJf/og/2zbr6waXD5G8AkMgEwGRLT+vXVlwBJjZLnPwi/ZKzW57EM5ugVnCb2u7clRd
        7ZI+blAa737FdZzwD4+u3N0xtFeyswqJJhDoK9ZN8I1GMaQ15fhGbsl1DAimjYJGeAhpAK
        7X39KdrWAKyAF/9yYUvJtMlBi1BQlmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641576131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UI+Qu+ntgMHu9DPaL+mEKxd+gHSWitvbHxpVywBZ1V4=;
        b=IuOIC538emYqTz4YdjduIVikz+dOrQXeD31mk0m5oXYH5skO0o8959jcJpx3+86UKPEZ+k
        mgO72vYi6bqEQHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 866A913D17;
        Fri,  7 Jan 2022 17:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T0ILIMJ22GH1RAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 07 Jan 2022 17:22:10 +0000
Message-ID: <82de6739-a070-695b-bbc8-dfa931aa5e00@suse.cz>
Date:   Fri, 7 Jan 2022 18:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 16/43] kmsan: mm: call KMSAN hooks from SLUB code
Content-Language: en-US
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
        Vegard Nossum <vegard.nossum@oracle.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-17-glider@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211214162050.660953-17-glider@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/14/21 17:20, Alexander Potapenko wrote:
> In order to report uninitialized memory coming from heap allocations
> KMSAN has to poison them unless they're created with __GFP_ZERO.
> 
> It's handy that we need KMSAN hooks in the places where
> init_on_alloc/init_on_free initialization is performed.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/I6954b386c5c5d7f99f48bb6cbcc74b75136ce86e
> ---
>  mm/slab.h |  1 +
>  mm/slub.c | 26 +++++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 56ad7eea3ddfb..6175a74047b47 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -521,6 +521,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>  			memset(p[i], 0, s->object_size);
>  		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
> +		kmsan_slab_alloc(s, p[i], flags);
>  	}
>  
>  	memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
> diff --git a/mm/slub.c b/mm/slub.c
> index abe7db581d686..5a63486e52531 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -22,6 +22,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/kasan.h>
> +#include <linux/kmsan.h>
>  #include <linux/cpu.h>
>  #include <linux/cpuset.h>
>  #include <linux/mempolicy.h>
> @@ -346,10 +347,13 @@ static inline void *freelist_dereference(const struct kmem_cache *s,
>  			    (unsigned long)ptr_addr);
>  }
>  
> +/*
> + * See the comment to get_freepointer_safe().
> + */

I did...

>  static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  {
>  	object = kasan_reset_tag(object);
> -	return freelist_dereference(s, object + s->offset);
> +	return kmsan_init(freelist_dereference(s, object + s->offset));

... but I don't see why it applies to get_freepointer() too? What am I missing?

>  }
>  
>  static void prefetch_freepointer(const struct kmem_cache *s, void *object)
> @@ -357,18 +361,28 @@ static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>  	prefetchw(object + s->offset);
>  }
>  
> +/*
> + * When running under KMSAN, get_freepointer_safe() may return an uninitialized
> + * pointer value in the case the current thread loses the race for the next
> + * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
> + * slab_alloc_node() will fail, so the uninitialized value won't be used, but
> + * KMSAN will still check all arguments of cmpxchg because of imperfect
> + * handling of inline assembly.
> + * To work around this problem, use kmsan_init() to force initialize the
> + * return value of get_freepointer_safe().
> + */
>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
>  {
>  	unsigned long freepointer_addr;
>  	void *p;
>  
>  	if (!debug_pagealloc_enabled_static())
> -		return get_freepointer(s, object);
> +		return kmsan_init(get_freepointer(s, object));

So here kmsan_init() is done twice?

>  
>  	object = kasan_reset_tag(object);
>  	freepointer_addr = (unsigned long)object + s->offset;
>  	copy_from_kernel_nofault(&p, (void **)freepointer_addr, sizeof(p));
> -	return freelist_ptr(s, p, freepointer_addr);
> +	return kmsan_init(freelist_ptr(s, p, freepointer_addr));
>  }
>  
>  static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
