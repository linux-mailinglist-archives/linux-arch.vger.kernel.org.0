Return-Path: <linux-arch+bounces-4696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A38FC01A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 01:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960031C2267E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 23:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389A14D446;
	Tue,  4 Jun 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4DYnlGoH"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC714D6E1;
	Tue,  4 Jun 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544694; cv=none; b=jhKIw31WhFvYnKXyu0H5IsHZo7f77H+UuN1+R4PLDribxd3dsikuF2rcxsSBc7yGxeJK4X0F/qFCjvTvZF2ZlHC+1OUynEycIJCgMT76JP4yfWYALzl+cp+leMnnhzvl0dtEDxWpL3L8w3YMpEf2Ngf1YvXasrOjv4JVaEvWVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544694; c=relaxed/simple;
	bh=5vLaTMhC/f80cHfutQVA8NT+YBHXfBWGgHaK2vOxNpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpDFON7lauewfG4hkWenVziJ1Kgl/ErIQFvYq4Oo7OjpNCysu5PTlAQGzS+/HlBl2OaFfl499s6FmqDfDvPDem2n+JKy59+AlAxmiDYY4LzFX/SMaOj2TQT/RTWHR8lG+TYxcKkdHsBl4c/3V9EiX9UtfM8V+YV1sJfQdnZQvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4DYnlGoH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PhT9KFFOExWQF20U3AwXuDAmtkcJMJ2i2CdJFaJH1tU=; b=4DYnlGoH09CVVe9B8D6eWoe6IX
	DObz3+SkqGCNdjLs+aUSWP4imauIabFyOz0tYAXBGAaspL4LEEykxzsBt1MplXhQMcu03p7QOuQAx
	8TnzwFCM/jMxcD752sO5+qJexRWAe9BvXi/lZ0eAt2OWIDNwwpRUDYNeI+HKaBzM6AbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEdpV-00GqyR-E0; Wed, 05 Jun 2024 01:44:37 +0200
Date: Wed, 5 Jun 2024 01:44:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v10 05/14] netdev: netdevice devmem allocator
Message-ID: <3be107ce-3d9f-4528-b9f7-1c9e38da0688@lunn.ch>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-6-almasrymina@google.com>
 <bea8b8bf1630309bb004f614e4a3c7f684a6acb6.camel@redhat.com>
 <20240604121551.07192993@gandalf.local.home>
 <20240604163158.GB21513@ziepe.ca>
 <20240604124243.66203a46@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604124243.66203a46@gandalf.local.home>

> Interesting, as I sped up the ftrace ring buffer by a substantial amount by
> adding strategic __always_inline, noinline, likely() and unlikely()
> throughout the code. It had to do with what was considered the fast path
> and slow path, and not actually the size of the function. gcc got it
> horribly wrong.

And what did the compiler people say when you reported gcc was getting
it wrong?

Our assumption is, the compiler is better than a human at deciding
this. Or at least, a human who does not spend a long time profiling
and tuning. If this assumption is not true, we probably should be
trying to figure out why, and improving the compiler when
possible. That will benefit everybody.

       Andrew


