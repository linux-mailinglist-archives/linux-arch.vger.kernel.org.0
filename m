Return-Path: <linux-arch+bounces-3349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0885589456D
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 21:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF6A1C2157B
	for <lists+linux-arch@lfdr.de>; Mon,  1 Apr 2024 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAA853E12;
	Mon,  1 Apr 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22uWaDKI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCE53360
	for <linux-arch@vger.kernel.org>; Mon,  1 Apr 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999361; cv=none; b=mUz1jZ5FsfH7RN3VsXLZDYnAlHpb5t1gWXXhJcOn/hp2RqHOyW/CDZrnzRfznNDml+eyFHIUNTA70j3Dpwl2AfeuguhmL2UfYptZVhwdy/dGSOrdsULgwe4S4sMIN77rDh7tZLcwj8F2nMZmlZQmrzflQGgUaK6HQ+0viGNna2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999361; c=relaxed/simple;
	bh=8oUFGMmpkpqLpkNpA3EMKT/yDO5+7f6Bm1WN7AwolPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZ2R1mcch2/uajl4wt1TCMvalFlAtIFkC53u460XaBoThTefWmZPGi9tYUcAxGIgpyYvBL6kiS+grKgp0ta/BEn89DTIATipXS8VDOM3jjslFg3FCcDNTQkHGzoHMdU2+IcvTZ7lnXJcK+PSj40oY5VnyUIia05JRnM+D9+VEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22uWaDKI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a472f8c6a55so545753866b.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Apr 2024 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711999357; x=1712604157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRKdoK98qnZzkUcUn3OGBOuDQ1g75ltD3kRhKb3BL0c=;
        b=22uWaDKINClGQOvJi06fBpyOOT7pMDPbf3vKhzp0A0EZNqEMJZEU9ZEQI+hZSku6MG
         bDpe0EjXvO13ddBX37ofmNnPNsgpJXqGc4AuCCQ8nuthzsZBfIFoF3l84MfjgVpQ/rMz
         X8r0RgAF5nL/37G5R4ZMVUu7g7ccxrgvXJyBok31bWJ4U/eF8uRTx4l9dRQ4jGtBlNPe
         xA9xU5PEKcZ6Mo8JfTxnSnXSqVcfGA88I4+hdQ1b5EIF6VP5bvS6Re5X1nESesLYTzOM
         keFQM0jW7oXypgbtrwSnBZZnye/NvRo6H4FNnGy3aoPjs0A0kSwZBaIAE8vZ+9L09KAa
         hy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999357; x=1712604157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRKdoK98qnZzkUcUn3OGBOuDQ1g75ltD3kRhKb3BL0c=;
        b=QrBz12xnvWyxYDpg1wXy+NYohrdaWwWN03KOFbtHJZI6A2kuyFn4KXu7uELJyz6GqJ
         7XJwUIYq+08rL7QGFIINNtOeWFOdzDLMzxc9O4Be191cRHW810w9lveffzFzEj7gFkZD
         rIcpGLPdAwdNeOYfXR2eLoA+fhh6cB+A6qCDFYUwbzux8aK/yjvW19nx6C84NBMDrTAw
         zUrDa5cS5T38h74UjQ8p+J+wISzImle8OAKs38BP+RpW2G9UDFydF7K2U73M3Bt1Ytih
         YUknd0Kd/lycCfAbfzLBtVeMZoJMGwEDR6khbwNj2ccY/tkvXueqDlFArlspqPut/AgU
         qYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUXHDj8JW5S+b+z6RdFdBrhdWvYOoQh66fGBp8DYkRy2wxXl9gpdBpanigU/MAb/TLX35PDvbSIoGEH9lDlReSwU9SBQ6XwUENFgQ==
X-Gm-Message-State: AOJu0YxSOnLH8QAqR/QrH76us0HRrOR/g0FGwjUpR3E1dLmin0aKHXvO
	QpFnQgagc+14Ta9ltaz/Od4a832ruq6YyTodYLypzYwYDRhP5qblcngm9t9wLDposdZmmWTzcqe
	zqL+nf3+m1CLRBMjS/osZtLCj0/V0SrkhcUFZ
X-Google-Smtp-Source: AGHT+IFnZAdqBNjychftax9hJ9HmWGsuFKJlToxmGxuKATUcrfF8Wqh8ADOKipJFMzVFEgjjXqwoqI01MVv3yIjrd3E=
X-Received: by 2002:a17:906:f289:b0:a46:d978:bf02 with SMTP id
 gu9-20020a170906f28900b00a46d978bf02mr6594862ejb.34.1711999356578; Mon, 01
 Apr 2024 12:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com> <ZfegzB341oNc_Ocz@infradead.org>
 <CAHS8izOUi6qGp=LSQb_o5oph-EnhNOuhLkPSfbQRU3eniZvbdA@mail.gmail.com>
 <ZgC5JoSiWAYf3IgX@infradead.org> <CAHS8izO5-giYhM1bVCLLOXRXq-Xd0=pi0kPq5E1-R=3i=XihmQ@mail.gmail.com>
 <ZgUc07Szbx5x-obb@infradead.org>
In-Reply-To: <ZgUc07Szbx5x-obb@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 1 Apr 2024 12:22:24 -0700
Message-ID: <CAHS8izM8iLC9J1xSHScMrMkVyoY5HZ_nFMRO4V7HYarHhZhk6Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>, Marc Harvey <marcharvey@google.com>, 
	"Cong Wang ." <cong.wang@bytedance.com>
Cc: shakeel.butt@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:31=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Tue, Mar 26, 2024 at 01:19:20PM -0700, Mina Almasry wrote:
> >
> > Are you envisioning that dmabuf support would be added to the block
> > layer
>
> Yes.
>
> > (which I understand is part of the VFS and not driver specific),
>
> The block layer isn't really the VFS, it's just another core stack
> like the network stack.
>
> > or as part of the specific storage driver (like nvme for example)? If
> > we can add dmabuf support to the block layer itself that sounds
> > awesome. We may then be able to do devmem TCP on all/most storage
> > devices without having to modify each individual driver.
>
> I suspect we'll still need to touch the drivers to understand it,
> but hopefully all the main infrastructure can live in the block layer.
>
> > In your estimation, is adding dmabuf support to the block layer
> > something technically feasible & acceptable upstream? I notice you
> > suggested it so I'm guessing yes to both, but I thought I'd confirm.
>
> I think so, and I know there has been quite some interest to at least
> pre-register userspace memory so that the iommu overhead can be
> pre-loaded.  It also is a much better interface for Peer to Peer
> transfers than what we currently have.
>

I think this is positively thrilling news for me. I was worried that
adding devmemTCP support to storage devices would involve using a
non-dmabuf standard of buffer sharing like pci_p2pdma_
(drivers/pci/p2pdma.c) and that would require messy changes to
pci_p2pdma_ that would get nacked. Also it would require adding
pci_p2pdma_ support to devmem TCP, which is a can of worms. If adding
dma-buf support to storage devices is feasible and desirable, that's a
much better approach IMO. (a) it will maybe work with devmem TCP
without any changes needed on the netdev side of things and (b)
dma-buf support may be generically useful and a good contribution even
outside of devmem TCP.

I don't have a concrete user for devmem TCP for storage devices but
the use case is very similar to GPU and I imagine the benefits in perf
can be significant in some setups.

Christoph, if you have any hints or rough specific design in mind for
how dma-buf support can be added to the block layer, please do let us
know and we'll follow your hints to investigate. But I don't want to
use up too much of your time. Marc and I can definitely read enough
code to figure out how to do it ourselves :-)

Marc, please review and consider this thread and work, this could be a
good project for you and I. I imagine the work would be:

1. Investigate how to add dma-buf support to the block layer (maybe
write a prototype code, and maybe even test it with devmem TCP).
2. Share a code or no-code proposal with netdev/fs/block layer mailing
list and try to work through concerns/nacks.
3. Finally share RFC through merging etc.

--
Thanks,
Mina

