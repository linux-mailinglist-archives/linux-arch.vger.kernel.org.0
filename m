Return-Path: <linux-arch+bounces-3480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5889C863
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CA0285B8F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C9140E5C;
	Mon,  8 Apr 2024 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2EAEEGQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F38126F0A;
	Mon,  8 Apr 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590471; cv=none; b=cbHXdu42OrOV7ykJUvlUdzgJ5+sIeoNH4vabPtPFWME4KFDDv/gtE5ndujGRv7s0xHnVbO177Kh7UFb4msbxp4nDMQNblZn2I3GucZALFypSBcL4KygdhiY1/B92KGef+kaj9v/JwsNuj+ZkzFhO1s4GzH2T60EVaggdPV8LDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590471; c=relaxed/simple;
	bh=4YKRX0MlfiV5mpfCzOeBNiJQnPi5WzZXviugTinSpNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QArUo6xInyOSGsy43zIZHs0a4wTh6fA4eALBmXPfrxvr0HaNti7YcbJ5tNYL59ueU+z8jK42WlJAABRnYW03heLiQ7QmDH56OynF/s1kZW2zo9KHpsCuE45doPkMOAEYbazFSEh1CjbK3klHFALpZaUZ5bB8Y7TwYCaj4YE+b14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2EAEEGQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so439601b3a.1;
        Mon, 08 Apr 2024 08:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712590469; x=1713195269; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XzmG06Fco0ZTrSThkuHAMjjsKBRNcTmAqJu1Q2E5r5g=;
        b=g2EAEEGQARbhbZodLg1Q71essx5NxOLt1+t7HXWuEBtP2GFhJ48uvE/BeeBMYYwu9g
         yHs2iUYxM04BIDYiTV/mswHbYfKJxCyAybPY6rmR617sk1z27w/nUfjsTu6GvgoYidrV
         K9icdU93ee85M1IMHlzcl3j+qPEMarUlF4m3t8N895aDUkyzAW4nufEt7eiaGp83PYz6
         5smDlNPatzvuC95Q5VDHHGSfqocjm5x7YZTlQIG9gZb5bnxxEWmlPenZpUkYjO1d1iaj
         dn1dyabZvQTnlDklvshhhPnd/JpckcVfjfbePZQaY4onHO1fiDW7PNk6eVizXYnOwKI+
         5OFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590469; x=1713195269;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XzmG06Fco0ZTrSThkuHAMjjsKBRNcTmAqJu1Q2E5r5g=;
        b=R4/W27N65uwZMzN5dBdxizc8EfDzgMoLLqbuaOA/0Di+Llxw3lCW5Bmd6+3VoE6OnB
         4o8ra0hpMIM5S8ifhcsbZf4Y1ENFe7x6yXrCsTnW+w321oAcJxHcXySQJnPDXKE3wxaS
         eJ+ppH/24+91xcB7DAkifBPe0r8X9ARlTR75l19//Y9CW5w8AdqGsikLe3g27Lbqh2vx
         SvPHsCVHKdUUNfCy7faDRfWXvy4SqQ6yi0p+yUEe9rJTMn57n+Zh66RTXXtQluMBBGV7
         21fbB9dIAD4nhFa08EjG0Enk6gg8CEOKM7kO4ba0A0lAlEQ4w3PeMOUxGQ0v0DJWUOYO
         Ky/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYOzx06o08AlNy3qbEm8GGTgh6TmnlinybgbKX3mNfSOtPQ3wu6YGtfpO/+cvQ/06LYY1KskWCsIXo5/b5TN42p36iulmykd6L5gkrahmiI6XR1TcT99K9CjJieL++ydGVDC5g2xziNq6r56dPCiwJxZs8OAao4zF4l8ezyLvjFj7cJqzttsckJ7C4YonAtRZyNgtMzhKa43/1wF6ibUU/BFbGx8ZgFm5V5ZjjwSVgN019kGz6llBBQ37yP6irppi5AUEcFuyRO/afe3t+ShpeLbj9aSzoLm0uYPF8ZpVF23W6Sd/DLp0SI0JFVyaesSG539uieH37eeK+WsxbTghxYb5lKaad/ppa9pFg0GlKBZqo/u0eJ5ir4e/SQzgxtlTuTT/9ksgxlbWEUWnrrLQY6Y0qi25Wl46Ib7IFfxeV6CH7KmfECCf3HxbSa04NQGJOdq2bv40V4SVw/hHYLLX8+yztF4vX3YPQo8ah9z7gj8WICPqAk6I9c2aJ8dn0egu0o2RjXQ==
X-Gm-Message-State: AOJu0YwcFJIAOg6DBsic/Gb3gnjT5zWImrA0tRUFYlNotbrkL9GK56pM
	H5h12J7MII8snt7VEGC3aFrBH22GNot97N71JiaJNE2/yPuvm7Ep
X-Google-Smtp-Source: AGHT+IHBXATYsnCAi18Pnmd94XM8gXF1KK2c5ntBdRmFa9x8kfwO+o1mRSI9SAgTVsohRvBTBjU3lg==
X-Received: by 2002:a05:6a00:8618:b0:6ed:1c7:8c65 with SMTP id hg24-20020a056a00861800b006ed01c78c65mr9832006pfb.10.1712590468982;
        Mon, 08 Apr 2024 08:34:28 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:13a8:4fe8:4da1:7ea2])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78d47000000b006e5808b472esm6878408pfe.95.2024.04.08.08.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:34:27 -0700 (PDT)
Date: Mon, 8 Apr 2024 08:34:26 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Marc Harvey <marcharvey@google.com>,
	"Cong Wang ." <cong.wang@bytedance.com>, shakeel.butt@linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZhQOgjkna94y9VBx@pop-os.localdomain>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
 <ZfegzB341oNc_Ocz@infradead.org>
 <CAHS8izOUi6qGp=LSQb_o5oph-EnhNOuhLkPSfbQRU3eniZvbdA@mail.gmail.com>
 <ZgC5JoSiWAYf3IgX@infradead.org>
 <CAHS8izO5-giYhM1bVCLLOXRXq-Xd0=pi0kPq5E1-R=3i=XihmQ@mail.gmail.com>
 <ZgUc07Szbx5x-obb@infradead.org>
 <CAHS8izM8iLC9J1xSHScMrMkVyoY5HZ_nFMRO4V7HYarHhZhk6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM8iLC9J1xSHScMrMkVyoY5HZ_nFMRO4V7HYarHhZhk6Q@mail.gmail.com>

On Mon, Apr 01, 2024 at 12:22:24PM -0700, Mina Almasry wrote:
> On Thu, Mar 28, 2024 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 26, 2024 at 01:19:20PM -0700, Mina Almasry wrote:
> > >
> > > Are you envisioning that dmabuf support would be added to the block
> > > layer
> >
> > Yes.
> >
> > > (which I understand is part of the VFS and not driver specific),
> >
> > The block layer isn't really the VFS, it's just another core stack
> > like the network stack.
> >
> > > or as part of the specific storage driver (like nvme for example)? If
> > > we can add dmabuf support to the block layer itself that sounds
> > > awesome. We may then be able to do devmem TCP on all/most storage
> > > devices without having to modify each individual driver.
> >
> > I suspect we'll still need to touch the drivers to understand it,
> > but hopefully all the main infrastructure can live in the block layer.
> >
> > > In your estimation, is adding dmabuf support to the block layer
> > > something technically feasible & acceptable upstream? I notice you
> > > suggested it so I'm guessing yes to both, but I thought I'd confirm.
> >
> > I think so, and I know there has been quite some interest to at least
> > pre-register userspace memory so that the iommu overhead can be
> > pre-loaded.  It also is a much better interface for Peer to Peer
> > transfers than what we currently have.
> >

Thanks for copying me on this. This sounds really great. 

Also P2PDMA requires PCI root complex to support this kind of direct transfer,
and IIUC dmabuf does not have such hardware dependency.

> 
> I think this is positively thrilling news for me. I was worried that
> adding devmemTCP support to storage devices would involve using a
> non-dmabuf standard of buffer sharing like pci_p2pdma_
> (drivers/pci/p2pdma.c) and that would require messy changes to
> pci_p2pdma_ that would get nacked. Also it would require adding
> pci_p2pdma_ support to devmem TCP, which is a can of worms. If adding
> dma-buf support to storage devices is feasible and desirable, that's a
> much better approach IMO. (a) it will maybe work with devmem TCP
> without any changes needed on the netdev side of things and (b)
> dma-buf support may be generically useful and a good contribution even
> outside of devmem TCP.

I think the major difference is its interface, which exposes an mmap memory
region instead of fd: https://lwn.net/Articles/906092/.

> 
> I don't have a concrete user for devmem TCP for storage devices but
> the use case is very similar to GPU and I imagine the benefits in perf
> can be significant in some setups.

We have storage use cases at ByteDance, we use NVME SSD to cache videos
transferred through network, so moving data directly from SSD to NIC
would help a lot.

Thanks!

