Return-Path: <linux-arch+bounces-2821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEED872829
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6196328443E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 20:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B6112881F;
	Tue,  5 Mar 2024 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQCcdh2M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6B386644
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668825; cv=none; b=fzDD/TaKn58UuhEKfZelPHL1sCBUJeEFzqhOQr1C47/iJG+OZ02KFddlt21a0tSiuA47Yc5hyjts1zo1wb9o+kj9Vq7rPBv56ZbtPx1HsP+6z/NdolOWP/cYv2gEudUPT6ta4jOidashAkQMv+f0RBrlpF+v9XLtMpimoiczl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668825; c=relaxed/simple;
	bh=zvCIxr8VBjsKzdRKj72ITiWaaPuXwUFhasVmFGiaDtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tu+ID3pLgZdmNCqOuv1E4v6wPWYBvyabeHLIPLlArmd54EDWsKSDS+qufwGH/+BEDAodOAqYfq1CHKUENPkU8aZn2GHf8qL79ToHVf4UXHjoAuTtuQH8QboFy2Yf3zk01s1MWT2fLH6mj3X4KeDJdGbOVWhAOnn8axG4ow/ch3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQCcdh2M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a450bedffdfso346914866b.3
        for <linux-arch@vger.kernel.org>; Tue, 05 Mar 2024 12:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709668821; x=1710273621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um7HQJN8N4J1bd3DjjlCtIBtcKYJjLGAY5O7WX29jhs=;
        b=GQCcdh2MldH/YcpNngEOhJ93Lez+BG92jbvj3xTQKZfXfuaZNCzmOOZbV2gDMd4//R
         RUDIXcB0aVfS9WSwFs7IJJQ/y1Qy/nicYVfdFQluHtxSMfgcamUEChzZrV6bE5RVAg+d
         8x7sUhgoYrXyQAD3Q6LRJGRQxNsdjrhT6qN4tKbeqfoxWmkzMvDIL7erP/n5qj18xKHf
         R8fBtNcxgwib9+mtc8yx+839STKOJlbtiDxY5Rzdvlj2/s7kRdLuo4E2+Lxyc/t5v71o
         hE27KoRkiuOaRQejDkoDPRhF+QXyaz5wGJRSvG72AT2vKBH6JSBdgt/ZHxE3VsBBvnf8
         rw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668821; x=1710273621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um7HQJN8N4J1bd3DjjlCtIBtcKYJjLGAY5O7WX29jhs=;
        b=f5JiKTvB7Ch7lmTa9dj7gpSWWASYYR8S+e41QQWdyKgU8+NtzRrQLnDxGdVKRJUNhY
         0aNSeeyEqIymBB/VfNgcE3sIWxHPdMHlPW58TAUHFKbNM0WFwbAGSNvUREP+pReEdz93
         yzcdiwC3nAUhL9JdQ/rmAGFXLNie4mh9cO292FDwDGTCWpwOP3YfxfSKM1T5MITUbyLO
         G1cj1pSflKx9Oy/DQIs6Jl6mT9wVkiOji/3p4L3c9xMsQCADf0mIsP107eBh743A6STY
         nSCZi7FnSBjZ6RV/PjZPHx6MBBpTT3HZ3ePvF6bzHnyUnemmdULuDg6TfvecXXy3A2uP
         DdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlQsdL9dwxFCuaBXxaBcc+qC+1hdtwoqpruAz/JjXp5+OCm6U0a2+Fn3H1OM6j6OJl1lZ1nUWUSh0NUkoFnc7QbzXaPxCaX+6rQ==
X-Gm-Message-State: AOJu0Ywtb+Ps6NypLmswCELaX9OMN45DFJgE2a0vW542BjZnUiKsWQCt
	TItcJjU+gaOI12esyV06+ukFX+2G/dKNGLG8CWrZKKunB7rNuJzvvNhphwZuuQ5AndDCIz+O0G0
	1eErDZgJq58n5G6WC+Fp6sX6FwUYz2XM+jZIA
X-Google-Smtp-Source: AGHT+IHytdC7v7Vx7sLFDUTdLyz9HH4/B980RlTrZABliOPKZSD4E6pDWhlNI6pqEZujcxK31LaEVTdzhieo1tJYP+0=
X-Received: by 2002:a17:906:394b:b0:a43:6146:a4df with SMTP id
 g11-20020a170906394b00b00a436146a4dfmr7667230eje.21.1709668820535; Tue, 05
 Mar 2024 12:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com> <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
In-Reply-To: <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 5 Mar 2024 12:00:08 -0800
Message-ID: <CAHS8izPhvRDPVHr8mY2FffPCLYjKqaazjy5NFcnJSnLK+CdyCA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
To: Arnd Bergmann <arnd@arndb.de>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, shuah <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:05=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:
>
> > +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> > +                    struct netdev_dmabuf_binding **out)
> > +{
> > +     struct netdev_dmabuf_binding *binding;
> > +     static u32 id_alloc_next;
> > +     struct scatterlist *sg;
> > +     struct dma_buf *dmabuf;
> > +     unsigned int sg_idx, i;
> > +     unsigned long virtual;
> > +     int err;
> > +
> > +     if (!capable(CAP_NET_ADMIN))
> > +             return -EPERM;
> > +
> > +     dmabuf =3D dma_buf_get(dmabuf_fd);
> > +     if (IS_ERR_OR_NULL(dmabuf))
> > +             return -EBADFD;
>
> You should never need to use IS_ERR_OR_NULL() for a properly
> defined kernel interface. This one should always return an
> error or a valid pointer, so don't check for NULL.
>

Thanks for clarifying. I will convert to IS_ERR().

> > +     binding->attachment =3D dma_buf_attach(binding->dmabuf, dev->dev.=
parent);
> > +     if (IS_ERR(binding->attachment)) {
> > +             err =3D PTR_ERR(binding->attachment);
> > +             goto err_free_id;
> > +     }
> > +
> > +     binding->sgt =3D
> > +             dma_buf_map_attachment(binding->attachment, DMA_BIDIRECTI=
ONAL);
> > +     if (IS_ERR(binding->sgt)) {
> > +             err =3D PTR_ERR(binding->sgt);
> > +             goto err_detach;
> > +     }
>
> Should there be a check to verify that this buffer
> is suitable for network data?
>
> In general, dmabuf allows buffers that are uncached or reside
> in MMIO space of another device, but I think this would break
> when you get an skb with those buffers and try to parse the
> data inside of the kernel on architectures where MMIO space
> is not a normal pointer or unaligned access is disallowed on
> uncached data.
>
>         Arnd

A key goal of this patch series is that the kernel does not try to
parse the skb frags that reside in the dma-buf for that precise
reason. This is achieved using patch "net: add support for skbs with
unreadable frags" which disables the kernel touching the payload in
these skbs, and "tcp: RX path for devmem TCP" which implements a uapi
where the kernel hands the data in the dmabuf to the userspace via a
cmsg that gives the user a pointer to the data in the dmabuf (offset +
size).

So really AFACT the only restriction here is that the NIC should be
able to DMA into the dmabuf that we're attaching, and dma_buf_attach()
fails in this scenario so we're covered there.

--=20
Thanks,
Mina

