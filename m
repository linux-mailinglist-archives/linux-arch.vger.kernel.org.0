Return-Path: <linux-arch+bounces-4815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869DC902B73
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 00:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D63F1F22822
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B093152161;
	Mon, 10 Jun 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DV1B8yAB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B214F9F4
	for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057709; cv=none; b=lbOSaXSwhFi2LMhhivjkuOTrQx/cW1YxmMbE/AH2SVyOJ8ytxNzO5++Wh0cadEHOOWLFSgZ/8o9HFrHuaTLps+xD7uDfqE9R9ENfDXCx4tIvTQ+GJJGP6rA/j6nLdzkc2LY8Q7JLJSveqNPSFoiozjv6LjcV93L7njRkQQfaJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057709; c=relaxed/simple;
	bh=z+wd9sAGfEDNr43zUFts3rXiT7ShOZVNnrA/+9o7y3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0v0KcUBPKZyt+DdHP+yNpYtVpMC8jzkp75Y/1TQwZeQxUdnAufYXyX3zriIISp5WkvCsxP+WXKZJYtkQeD7fwbApwFoSybIqMKqWe5F+gkXCJ697aYVMTIqh/m05HQF7i7WNF7DRST5+GPZYTFGz4sswqFec2elFac+XoeZQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DV1B8yAB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-43fecdecd32so26994161cf.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718057705; x=1718662505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYxIeKtLL3lQwNiFRr25O1e9GIX4G5slG5d4Uc4G46M=;
        b=DV1B8yABKh8zcLUmgBZlPAFY0iTcPLR8YOx7LLCpFjMnV7rXNkaRxAYuvwk3C7PPOH
         jZB05ZxEeozQlYPvsSKrdHH9XRsHaWMfRgA07nc67PzNRXJVUcgHaMaIwTLkn/0NBaej
         Y+DkdkBwr03IdCK/sG3d/54s8BvaqhWBnl/jBki+4FuzFDk5MC/R7srQTW0MtfyTEffw
         S/cazkXqzTrhTNLq77EhsuipjQDoKG+ONrmQBCCYr/YTuVzQ2K1qnCx+gVlmf+ptUByB
         YHBold4jl4t0CXl3DWfVhfY0nGwvEmmEftLaTtJM4KO8eLCbZeisPO65pggAcwOIB0GE
         jnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718057705; x=1718662505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYxIeKtLL3lQwNiFRr25O1e9GIX4G5slG5d4Uc4G46M=;
        b=gXHNbMp+Xt1s2lVn69qDC6I61agwQVSHFp+uk/TqdSG0oynSpU0zKO3VGtV9FydmaF
         Usa7OrAJKopd6IO2nw1J19E6ZxAATux5Jx1+jpW44LzPIREnDL9VY8uxX0tL0FPZhTIS
         /Gt8EmTZedOdauIS2zZKckX4pWmTLNrNq4F+31gv0dqv9tHWZZdYUUUus2xm3Bhx7ANF
         qXIbdrVWcnkqd8uqXin5XdGfCWxvb9Ami9aXnhAYMAcUCCUcprE65sHARo6AA7q6E+yS
         PZke+7mku9Iq7/HnoN3lQG1JdDmaLzQc+upMaZCCvmE/fHuL2GpDigimD45ebpLyVo44
         9KEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA35n+ywMPWyA9uoRHNgls/Uv9U2OztGcZd4HVDxzmkCYenrripjTCn0X4AcZdgKm3yau2l73KfeCrGZUL9mDg9q+5+QR0uoSiaQ==
X-Gm-Message-State: AOJu0YxdBstytwNVl9kLRKIpcq0egolF8qHNAXCSRyJVdjjYZC2MRgCp
	jKFvWCb6OxVujItmea7W0XA/FCksJzTBSiesVzaYyv0GW7uZS5F7XMubjpNTYUI=
X-Google-Smtp-Source: AGHT+IGNwK7dorh82QSLW5MV/WzZAixZNPt6ZilaFo6ceP30TQ1KYPRJL2ImTAjvrOrdYOBtAU+f5Q==
X-Received: by 2002:a05:6214:4a06:b0:6b0:72ef:2877 with SMTP id 6a1803df08f44-6b072ef2a2bmr79573716d6.40.1718057705068;
        Mon, 10 Jun 2024 15:15:05 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b076a42242sm20947266d6.59.2024.06.10.15.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:15:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGnI4-00FsKs-9Z;
	Mon, 10 Jun 2024 19:15:00 -0300
Date: Mon, 10 Jun 2024 19:15:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>,
	Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
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
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <20240610221500.GN791043@ziepe.ca>
References: <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
 <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>

On Mon, Jun 10, 2024 at 08:20:08PM +0100, Pavel Begunkov wrote:
> On 6/10/24 16:16, David Ahern wrote:

> > > There is no reason you shouldn't be able to use your fast io_uring
> > > completion and lifecycle flow with DMABUF backed memory. Those are not
> > > widly different things and there is good reason they should work
> > > together.
> 
> Let's not mix up devmem TCP and dmabuf specifically, as I see it
> your question was concerning the latter: "... DMABUF memory registered
> through Mina's mechanism". io_uring's zcrx can trivially get dmabuf
> support in future, as mentioned it's mostly the setup side. ABI,
> buffer workflow and some details is a separate issue, and I don't
> see how further integration aside from what we're already sharing
> is beneficial, on opposite it'll complicate things.

Again, I am talking about composability here, duplicating the DMABUF
stuff into io_uring is not composable, it is just duplicating things.

It does not match the view that there should be two distinct layers
here, one that provides the pages and one that manages the
lifecycle. As HCH pushes for pages either come from the allocator and
get to use the struct folio or the come from a dmabuf and they
don't. That is it, the only two choices.

The iouring stuff is trying to confuse the source of the pages with
the lifecycle - which is surely convenient, but is why Christoph is
opposing it.

Jason

