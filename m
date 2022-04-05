Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229534F460E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiDENYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381352AbiDEMy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 08:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B733429CAC
        for <linux-arch@vger.kernel.org>; Tue,  5 Apr 2022 04:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649159875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tf5cml5DKG34+H+/7P2EmXNj5BSxC+Di2E2isNkLxI=;
        b=en4YBQCHvkYBN4SIWnA1KZxiwUcwRl6eDizBNbd7KaJAKk8SHO89C6j0vdQ5SevWf1oiDT
        kZybj9pJTD1ZSGVumcHfD5G8O1Yyb5V54SPUQDIJnoasAsLlH4N0scsTweaWly6DEHDp3p
        nAhypvbbbhjmg3Ofuix7hwJ9tyuaL4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-biSEfP3JNCeiEzc6IAGj7Q-1; Tue, 05 Apr 2022 07:57:54 -0400
X-MC-Unique: biSEfP3JNCeiEzc6IAGj7Q-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1148954wmj.5
        for <linux-arch@vger.kernel.org>; Tue, 05 Apr 2022 04:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4tf5cml5DKG34+H+/7P2EmXNj5BSxC+Di2E2isNkLxI=;
        b=vr0YwhK7cxbIO2kGuH1WPjnIDnXXNLRDWqtGXs90sC+NuAlmL04tDXh45po4VSrC6y
         Pe/V5E/zGjVYJkIUG8moMDNNvXqoXsaxbsUUwFV4NENwtIcwBDTbU39btzvXeoqu6IZo
         w4QoVpCONIIUtzE3ADD3HTV8bGtXE3rkYwEKfI+gILG2PtXvfKOviY9aGyakoWnW55o2
         mX4G65yOgtNtO8t5cgOhD+0iPlOSAlWPm29vX/2/beBg2oxZPi867rRpzKNjGQdX4UfJ
         +qkoDjl0tO5VAMwAMDWxBzQbBfZQkaAyLwHPCABKMrQuy8POzyDo2RI1FSxnB1+tfPLC
         MDqg==
X-Gm-Message-State: AOAM531/6n+CKiFyM/74AgZsp7k3GZ/m0rIdK5B4jv91WcXdqFrwHbBa
        q3vhAZwrptZRQoneaAE/iXE8LIvNdQrp47+8mW/C4vcqiegzvAA05g3TZPkwH747ouXjvJ6kcoT
        j/Al6DB4j1iS5hKRXyxB3+w==
X-Received: by 2002:adf:8050:0:b0:206:40a:a770 with SMTP id 74-20020adf8050000000b00206040aa770mr2535500wrk.380.1649159873349;
        Tue, 05 Apr 2022 04:57:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgqTZayIX4u/UnvkTDHW17PSUoPyzp3WUxX6v1B27xgUyGVSxDLohCf9WBiOzGI5DL0p4UMA==
X-Received: by 2002:adf:8050:0:b0:206:40a:a770 with SMTP id 74-20020adf8050000000b00206040aa770mr2535488wrk.380.1649159873090;
        Tue, 05 Apr 2022 04:57:53 -0700 (PDT)
Received: from redhat.com ([2.52.17.211])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm1992438wmh.31.2022.04.05.04.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:57:52 -0700 (PDT)
Date:   Tue, 5 Apr 2022 07:57:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <20220405075738-mutt-send-email-mst@kernel.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-9-masahiroy@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
> Arnd mentioned a limitation when including <stdint.h> from UAPI
> headers. [1]
> 
> Besides, I'd like exported headers to be as compliant with the
> traditional C as possible.
> 
> In fact, the UAPI headers are compile-tested with -std=c90 (see
> usr/include/Makefile) even though the kernel itself is now built
> with -std=gnu11.
> 
> Currently, include/uapi/linux/virtio_ring.h includes <stdint.h>
> presumably because it uses uintptr_t.
> 
> Replace it with __kernel_uintptr_t, and stop including <stdint.h>.
> 
> [1]: https://lore.kernel.org/all/CAK8P3a0bz8XYJOsmND2=CT_oTDmGMJGaRo9+QMroEhpekSMEaQ@mail.gmail.com/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
>  include/uapi/linux/virtio_ring.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index 476d3e5c0fe7..6329e4ff35f4 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -31,9 +31,7 @@
>   * SUCH DAMAGE.
>   *
>   * Copyright Rusty Russell IBM Corporation 2007. */
> -#ifndef __KERNEL__
> -#include <stdint.h>
> -#endif
> +
>  #include <linux/types.h>
>  #include <linux/virtio_types.h>
>  
> @@ -196,7 +194,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
>  	vr->num = num;
>  	vr->desc = p;
>  	vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> -	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> +	vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
>  		+ align-1) & ~(align - 1));
>  }
>  
> -- 
> 2.32.0
> 
> 

