Return-Path: <linux-arch+bounces-69-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3A47E4C6E
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 00:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4605C281444
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 23:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6793065F;
	Tue,  7 Nov 2023 23:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTyao1M5"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DE33065B
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 23:04:08 +0000 (UTC)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732B10D4
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 15:04:07 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ba962d534eso2553256241.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699398247; x=1700003047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwSWVxQJlefO2RXGLXTB5EQnzK3f7Ti0RFRCIocUVAs=;
        b=RTyao1M5gnN7cTlDG7d8LPAKzFJX0V4Trw6manexGrhKIxZDKzaDzD15ayTI7EefhD
         8ySq2N4mYEadI5EXDaY97Y8kfbO1RYF1rXnTOWrGCboGiAHtiKIk9DMBgklfURF3ILpM
         OXtHaii+Woesd5DF3er0h7i2sEe9SuKBuo0bQWBso8HD3QSK1IlXAMm5HtNyMszSPhHm
         222h64CvspTt7hz5sPbehPaYkyPJEE8SNUaMAgCM6FwZRzqpiTz3Bm14ho/nleKoSGxh
         LDhEV9QZMQBB1QNx+mmnQ+aO4PtmMFv4fXL5f4BfzrnfZBucrb6PbVg/nMhjhatNuzmq
         EWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398247; x=1700003047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwSWVxQJlefO2RXGLXTB5EQnzK3f7Ti0RFRCIocUVAs=;
        b=d/nCVZBLfzBD3TqWE8zRMHt7NkO6C7dPiENcaGoIBx1rPOqWdWlY9Nvf3eEcVU3h9E
         ZGv/5pwXtLDO8pF9pHazdVuy4TXuUFNAIytikr5DMBZ/zcc6lHlPEcgwpFoiYiiqclvx
         rKIcW4qb9HVXdxOpkI7Irb+gPWLXWqOAg/hg0UIhcZWYRkZKJfDC8fZAySiays2ewS4C
         wUIyEJmJSJqVUAVx1PG/pJQMJLL44aIunB/C2xW28hB0kHp4DiLUVbwSVn5zs+x7dvHo
         Ad1SN7U0/GLQSaN52d4nfFAzbMgkklCciVEN2II1grHv56Sr4aNIpNqdQkJt23Tm9aK8
         hSXA==
X-Gm-Message-State: AOJu0YxGSo6uS59FLwCcNEGyT63zdkGu1zmsN0yiG/+hWznPMwJlXAe+
	+z4UA59BXipvUL5KZeJ8rNjMoxOEMyi96s6CUcpaHA==
X-Google-Smtp-Source: AGHT+IGkIzXyZBaE32+WMwF+duu/QcIsXXrFXzLPRCigy40o3oogjiTft3g4ezREIoF7S18+m0g5FcLRymLotkSR3mA=
X-Received: by 2002:a67:e09b:0:b0:45f:8b65:28f0 with SMTP id
 f27-20020a67e09b000000b0045f8b6528f0mr105754vsl.12.1699398246594; Tue, 07 Nov
 2023 15:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com> <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com> <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
In-Reply-To: <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 15:03:53 -0800
Message-ID: <CAHS8izMKDOw5_y2MLRfuJHs=ai+sZ6GF7Rg1NuR_JqONg-5u5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
To: David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:55=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/7/23 3:10 PM, Mina Almasry wrote:
> > On Mon, Nov 6, 2023 at 3:44=E2=80=AFPM David Ahern <dsahern@kernel.org>=
 wrote:
> >>
> >> On 11/5/23 7:44 PM, Mina Almasry wrote:
> >>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>> index eeeda849115c..1c351c138a5b 100644
> >>> --- a/include/linux/netdevice.h
> >>> +++ b/include/linux/netdevice.h
> >>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
> >>>  };
> >>>
> >>>  #ifdef CONFIG_DMA_SHARED_BUFFER
> >>> +struct page_pool_iov *
> >>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
> >>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
> >>
> >> netdev_{alloc,free}_dmabuf?
> >>
> >
> > Can do.
> >
> >> I say that because a dmabuf can be host memory, at least I am not awar=
e
> >> of a restriction that a dmabuf is device memory.
> >>
> >
> > In my limited experience dma-buf is generally device memory, and
> > that's really its use case. CONFIG_UDMABUF is a driver that mocks
> > dma-buf with a memfd which I think is used for testing. But I can do
> > the rename, it's more clear anyway, I think.
>
> config UDMABUF
>         bool "userspace dmabuf misc driver"
>         default n
>         depends on DMA_SHARED_BUFFER
>         depends on MEMFD_CREATE || COMPILE_TEST
>         help
>           A driver to let userspace turn memfd regions into dma-bufs.
>           Qemu can use this to create host dmabufs for guest framebuffers=
.
>
>
> Qemu is just a userspace process; it is no way a special one.
>
> Treating host memory as a dmabuf should radically simplify the io_uring
> extension of this set.

I agree actually, and I was about to make that comment to David Wei's
series once I have the time.

David, your io_uring RX zerocopy proposal actually works with devmem
TCP, if you're inclined to do that instead, what you'd do roughly is
(I think):

- Allocate a memfd,
- Use CONFIG_UDMABUF to create a dma-buf out of that memfd.
- Bind the dma-buf to the NIC using the netlink API in this RFC.
- Your io_uring extensions and io_uring uapi should work as-is almost
on top of this series, I think.

If you do this the incoming packets should land into your memfd, which
may or may not work for you. In the future if you feel inclined to use
device memory, this approach that I'm describing here would be more
extensible to device memory, because you'd already be using dma-bufs
for your user memory; you'd just replace one kind of dma-buf (UDMABUF)
with another.

> That the io_uring set needs to dive into
> page_pools is just wrong - complicating the design and code and pushing
> io_uring into a realm it does not need to be involved in.
>
> Most (all?) of this patch set can work with any memory; only device
> memory is unreadable.
>
>


--=20
Thanks,
Mina

