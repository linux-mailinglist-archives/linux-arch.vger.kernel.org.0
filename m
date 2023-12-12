Return-Path: <linux-arch+bounces-920-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B234080EF77
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ABB1F2166A
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA526745F4;
	Tue, 12 Dec 2023 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Di+xUrDN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E5E9
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 06:58:31 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50e0ba402b4so736072e87.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702393110; x=1702997910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzl81dpk3U9T9CudLlEFGkOzt7MaXHqDfkakdpQfiFo=;
        b=Di+xUrDNquCXrbE4D+7pfjphiGfnnFvnJ9/Q4O0j/kgCgfP9AwhW6edileG02zHDCK
         Ug2WZfJv083gx7y1zC5N5OA4s2BF+Hgsf4WwxYweX2huuzD1r9O1C3Nf8JmTd223jhpo
         +5K34kx0JBlvAkN3qJK0TBeNvaqFoyOzPY09+zdHmT/gWAZ249Fuiyo7zUphSdV5997y
         vj8XnTZFDeNqWujeHGTInKUIXjEymntsdhGdsU/8Ku2S46luA28K2kGokU9NNgogSVdF
         LfZgPfe/YbCJ/TAWwjQD4MwRNdA17G43XaNJaX/g0EqK03F/9MT2NYNODogcWcseI4zZ
         s8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393110; x=1702997910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzl81dpk3U9T9CudLlEFGkOzt7MaXHqDfkakdpQfiFo=;
        b=fAINzS9lABRMg5x7vftN1Ne5Ef2T3Uwix72iDlD2x9kZ4sL9nA+GOmsYrXp0h2EG7s
         RSEgK1ZB9I7No/6uVQSquEUfVw9li/rbVGNXwtwiBFa6gKurKOa/XNc8Bf79L5X19NNg
         emzDBWmMPovAuM2hOQJza99az8wI1v+yHUd5+p10gSp2CfO8bh87O61WLK0P5dkSQS1G
         VMXNHC91D6yJfeGC7HX9HzgqY33W/L33LLa9RlWRBMcmRvz4EIipiXfeaF/N+kz88cGD
         eMFWnuKpnpgL43heWFFEVtpqbG1e4Jv64PMuMnjpsVuJAqRzYzH1v9cCODZ3hfZsGyB7
         Z8Ug==
X-Gm-Message-State: AOJu0Yzbb7kU1Rch5K3UDIgwDnjNomWXVdwtNg4ECcbxTTPR8g6vSDxA
	/r3//23h5xP3EevrJou/vyJIbLGcYxnwn/I45HmImg==
X-Google-Smtp-Source: AGHT+IERGuBL77UBvy25wKoqAwiWF0N6xvXc57i2t65+NTiYJO5PTJJ6k/4UPi+3laDB/s1BgrFICZhicXsZkg8qeMk=
X-Received: by 2002:ac2:5b4f:0:b0:50b:fa9b:1649 with SMTP id
 i15-20020ac25b4f000000b0050bfa9b1649mr3304569lfp.73.1702393109803; Tue, 12
 Dec 2023 06:58:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com> <20231212122535.GA3029808@nvidia.com>
 <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com> <20231212143942.GF3014157@nvidia.com>
In-Reply-To: <20231212143942.GF3014157@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 06:58:17 -0800
Message-ID: <CAHS8izNHtemjjkMf43grCHP1RZ=2UFiMtgea0M6+PaAgC=DDMQ@mail.gmail.com>
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

On Tue, Dec 12, 2023 at 6:39=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Dec 12, 2023 at 06:26:51AM -0800, Mina Almasry wrote:
> > On Tue, Dec 12, 2023 at 4:25=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Thu, Dec 07, 2023 at 04:52:39PM -0800, Mina Almasry wrote:
> > >
> > > > +static inline struct page_pool_iov *page_to_page_pool_iov(struct p=
age *page)
> > > > +{
> > > > +     if (page_is_page_pool_iov(page))
> > > > +             return (struct page_pool_iov *)((unsigned long)page &=
 ~PP_IOV);
> > > > +
> > > > +     DEBUG_NET_WARN_ON_ONCE(true);
> > > > +     return NULL;
> > > > +}
> > >
> > > We already asked not to do this, please do not allocate weird things
> > > can call them 'struct page' when they are not. It undermines the
> > > maintainability of the mm to have things mis-typed like
> > > this. Introduce a new type for your thing so the compiler can check i=
t
> > > properly.
> > >
> >
> > There is a new type introduced, it's the page_pool_iov. We set the LSB
> > on page_pool_iov* and cast it to page* only to avoid the churn of
> > renaming page* to page_pool_iov* in the page_pool and all the net
> > drivers using it. Is that not a reasonable compromise in your opinion?
> > Since the LSB is set on the resulting page pointers, they are not
> > actually usuable as pages, and are never passed to mm APIs per your
> > requirement.
>
> There were two asks, the one you did was to never pass this non-struct
> page memory to the mm, which is great.
>
> The other was to not mistype things, and don't type something as
> struct page when it is, in fact, not.
>
> I fear what you've done is make it so only one driver calls these
> special functions and left the other drivers passing the struct page
> directly to the mm and sort of obfuscating why it is OK based on this
> netdev knowledge of not enabling/using the static branch in the other
> cases.
>

Jason, we set the LSB on page_pool_iov pointers before casting it to
struct page pointers. The resulting pointers are not useable as page
pointers at all.

In order to use the resulting pointers, the driver _must_ use the
special functions that first clear the LSB. It is impossible for the
driver to 'accidentally' use the resulting page pointers with the LSB
set - the kernel would just crash trying to dereference such a
pointer.

The way it works currently is that drivers that support devmem TCP
will declare that support to the net stack, and use the special
functions that clear the LSB and cast the struct back to
page_pool_iov. The drivers that don't support devmem TCP will not
declare support and will get pages allocated from the mm stack from
the page_pool and use them as pages normally.

> Perhaps you can simply avoid this by arranging for this driver to also
> exclusively use some special type to indicate the dual nature of the
> pointer and leave the other drivers as using the struct page version.
>

This is certainly possible, but it requires us to rename all the page
pointers in the page_pool to the new type, and requires the driver
adding devmem TCP support to rename all the page* pointer instances to
the new type. It's possible but it introduces lots of code churn. Is
the LSB + cast not a reasonable compromise here? I feel like the trick
of setting the least significant bit on a pointer to indicate it's
something else has a fair amount of precedent in the kernel.

--
Thanks,
Mina

