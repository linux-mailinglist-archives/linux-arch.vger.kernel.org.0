Return-Path: <linux-arch+bounces-948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C481075C
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1410528246B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FE4139D;
	Wed, 13 Dec 2023 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLHbNY0C"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44ED2
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:09:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c32df9174so55231475e9.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429789; x=1703034589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i1d9QvoS4OxhYISeUTScW7akaFRcF7KdLSyFQ8hFdE=;
        b=MLHbNY0Czd3wPe32uDHEc/p1QFAuW5t37BjMpcSQ2JrBYEKt/Wqd1QbsTFzgLXsEN+
         e3zrFyeJbLcDbesFlbaAbJ4AkhT9MSKbiUSpFqgK+n3Ihyw51fmrpHKKATAsVyY7MeGB
         fWBqPUvZmrKqbfVAVled2XVKP8ba27dIcf7oKvZ76EK+crAx7CGdVTPrRzYOlRNuhU7p
         pvX0DfSrYhSZXjFc5E5n9LKb5R4aBzuu2LPN/nbNqGeYnsUe4ftFMqYIqRFh+WScy9yx
         UD8XfTMfQyY0XR1pW3zgLXJ425d57zXmHsWNryMgdpTfLKmrQXK9O2funHSfzgsFvrjJ
         mWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429789; x=1703034589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i1d9QvoS4OxhYISeUTScW7akaFRcF7KdLSyFQ8hFdE=;
        b=p1KuNrj2ZdtGgN6uP7Js+amiCe5iZdIkJeEaK/dst/Nxo5o2NzkfJPShvSj9tOSHgA
         kx0PRS08DWsHURb8/oA0aZoWjKc+BvmLF23o34Y53S4s5R0Ksegk8FFS9l5tZALMycuj
         PjGHXFcF0lioQOXkxWrX9y5o/OsD6MAno4gUNJHg0Yo0emcHcLS22AsJlHk9opUMGGH/
         ubDI/Y1nWhLKMDiy0nT9dqck/VB+JFydFL4SAjZTbAUidpd+dWTiuub4oiDRlphGHta6
         y1tUBQwBU+l/hB92LyQAF8AkItM/FDop5gFmB8/efrNlJlxL8z9ZZhJxCLIOsOtSWPkU
         0cjA==
X-Gm-Message-State: AOJu0YxVUsjLYpYgJF28YsdHCxR2uytPQZ6Gro+AJDVzvOMM2n8SOmYJ
	UR6kwiroVC/iwvixTxEBHXu7E4uXeepex/y0BwOEqg==
X-Google-Smtp-Source: AGHT+IFHv6ulP97j2C3dKg3abBYpoQRGbAehnWd7YHUNtYhyRmrdi8aZpqMGubt6wRgBcXdnMdT0ZlS6rLmxwPeMcJk=
X-Received: by 2002:a05:600c:4f86:b0:40c:48fb:ea01 with SMTP id
 n6-20020a05600c4f8600b0040c48fbea01mr1374675wmq.209.1702429789212; Tue, 12
 Dec 2023 17:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com> <20231212122535.GA3029808@nvidia.com>
 <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
 <20231212143942.GF3014157@nvidia.com> <CAHS8izNHtemjjkMf43grCHP1RZ=2UFiMtgea0M6+PaAgC=DDMQ@mail.gmail.com>
 <20231212150834.GI3014157@nvidia.com>
In-Reply-To: <20231212150834.GI3014157@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 17:09:35 -0800
Message-ID: <CAHS8izMdKYyjE9bdcFDWWPWECwVZL7XQjtjOFoTq5_bEEJvN6w@mail.gmail.com>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory provider
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 7:08=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Dec 12, 2023 at 06:58:17AM -0800, Mina Almasry wrote:
>
> > Jason, we set the LSB on page_pool_iov pointers before casting it to
> > struct page pointers. The resulting pointers are not useable as page
> > pointers at all.
>
> I understand that, the second ask is about maintainability of the mm
> by using correct types.
>
> > > Perhaps you can simply avoid this by arranging for this driver to als=
o
> > > exclusively use some special type to indicate the dual nature of the
> > > pointer and leave the other drivers as using the struct page version.
> >
> > This is certainly possible, but it requires us to rename all the page
> > pointers in the page_pool to the new type, and requires the driver
> > adding devmem TCP support to rename all the page* pointer instances to
> > the new type. It's possible but it introduces lots of code churn. Is
> > the LSB + cast not a reasonable compromise here? I feel like the trick
> > of setting the least significant bit on a pointer to indicate it's
> > something else has a fair amount of precedent in the kernel.
>
> Linus himself has complained about exactly this before, and written a cle=
anup:
>
> https://lore.kernel.org/linux-mm/20221108194139.57604-1-torvalds@linux-fo=
undation.org/
>
> If you mangle a pointer *so it is no longer a pointer* then give it a
> proper opaque type so the compiler can check everything statically and
> require that the necessary converters are called in all cases.
>
> You call it churn, I call it future maintainability. :(
>
> No objection to using the LSB, just properly type a LSB mangled
> pointer so everyone knows what is going on and don't call it MM's
> struct page *.
>
> I would say this is important here because it is a large driver facing
> API surface.
>

OK, I imagine this is not that hard to implement - it's really whether
the change is acceptable to reviewers.

I figure I can start by implementing a no-op abstraction to page*:

typedef struct page netmem_t

and replace the page* in the following places with netmem_t*:

1. page_pool API (not internals)
2. drivers using the page_pool.
3. skb_frag_t.

I think that change needs to be a separate series by itself. Then the
devmem patches would on top of that change netmem_t such that it can
be a union between struct page and page_pool_iov and add the special
handling of page_pool_iov. Does this sound reasonable?


--
Thanks,
Mina

