Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8648648D
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiAFMqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 07:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239013AbiAFMqr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 07:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641473206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QIcy/hKgWsl8HLsYFT8VKTJz9iU+YZ837pHBIwXvv1Q=;
        b=IhKCWiVxKmma4hx7vqrpgPZKqQEgMlj0ozvKJe1VJnjX1UKqK4Vo1Eb3Q3VBdB29U53/dL
        guRtLa6WXqXbsn/BhSr2Xi+y3+B+TMzJ8pd95v797/h0PURVRwYIPEfxMbxrvE9GLMM1o4
        MmLb/c1sb9eBxA1lvZm9atUNeX5H+Bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-vjeIq7nnPu24gaxjE7ePSw-1; Thu, 06 Jan 2022 07:46:45 -0500
X-MC-Unique: vjeIq7nnPu24gaxjE7ePSw-1
Received: by mail-wm1-f70.google.com with SMTP id c188-20020a1c35c5000000b00346a2160ea8so180724wma.9
        for <linux-arch@vger.kernel.org>; Thu, 06 Jan 2022 04:46:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QIcy/hKgWsl8HLsYFT8VKTJz9iU+YZ837pHBIwXvv1Q=;
        b=ZtmZaLWo7gkdxj1unhoWe9FpCQIjgH36E10Z6zvfnv6KYCZTTP7/QKpsiX1wc6t2in
         gL+cgTWGjTOIzbP086/nbRctiDXUFr1qL4pYxqvxggDUJia7YcG68bEBoFy1bJ5LD4yX
         06K2ncwYnvAyAtlRUNOiNsRGumBdoGHJR3/WwEPP1M6PBJ9zGApVE9/HNlnFQY01IVSa
         KtsbCSIiZ7GqEchn4godngEafAne38pWxjbomNUNfSNRyMhXsmwyMY5to68Exvrmj6PA
         NMVL/NPV5hVgvxZ+FeMaNj6w3NqMd3zBkIfbBClbyDH7NTzF/qc0d7DVFebGiNaHxihe
         IDdA==
X-Gm-Message-State: AOAM530emiWMfJMPKL00kwXdQiqpkcuQSklLjV63xvzPM7aQ8OH14XN6
        bBKiQkSaKkk79NyYRfGG2DI5cH4yEDNuh54jQ5Aj1tZOIYNNitsDGSKXTUFbljkzcJ9DAOL6JvN
        t+HYaNLntYkRr5EbwgMmFrw==
X-Received: by 2002:a05:600c:1e05:: with SMTP id ay5mr6993321wmb.131.1641473204125;
        Thu, 06 Jan 2022 04:46:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIetGTra+THB/8z93McN+42aVUsQxDpvJa2rz7fYmmyJpcjeJUiqxg8dTKkWQkvBsgXuZRAA==
X-Received: by 2002:a05:600c:1e05:: with SMTP id ay5mr6993312wmb.131.1641473203945;
        Thu, 06 Jan 2022 04:46:43 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:991b:6857:5652:b903:a63b])
        by smtp.gmail.com with ESMTPSA id g12sm2308053wrd.71.2022.01.06.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 04:46:43 -0800 (PST)
Date:   Thu, 6 Jan 2022 07:46:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
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
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/43] kmsan: virtio: check/unpoison scatterlist in
 vring_map_one_sg()
Message-ID: <20220106074032-mutt-send-email-mst@kernel.org>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-27-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-27-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:33PM +0100, Alexander Potapenko wrote:
> If vring doesn't use the DMA API, KMSAN is unable to tell whether the
> memory is initialized by hardware. Explicitly call kmsan_handle_dma()
> from vring_map_one_sg() in this case to prevent false positives.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

OK I guess

Acked-by: Michael S. Tsirkin <mst@redhat.com>

IIUC this depends on the rest of the patchset, so feel free to
merge.

> ---
> Link: https://linux-review.googlesource.com/id/I211533ecb86a66624e151551f83ddd749536b3af
> ---
>  drivers/virtio/virtio_ring.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 6d2614e34470f..bf4d5b331e99d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/hrtimer.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/kmsan-checks.h>
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>  
> @@ -331,8 +332,15 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
>  				   struct scatterlist *sg,
>  				   enum dma_data_direction direction)
>  {
> -	if (!vq->use_dma_api)
> +	if (!vq->use_dma_api) {
> +		/*
> +		 * If DMA is not used, KMSAN doesn't know that the scatterlist
> +		 * is initialized by the hardware. Explicitly check/unpoison it
> +		 * depending on the direction.
> +		 */
> +		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
>  		return (dma_addr_t)sg_phys(sg);
> +	}
>  
>  	/*
>  	 * We can't use dma_map_sg, because we don't use scatterlists in
> -- 
> 2.34.1.173.g76aa8bc2d0-goog

