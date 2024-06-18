Return-Path: <linux-arch+bounces-4957-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80D90C3D9
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 08:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495321C204F8
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 06:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26A61FCE;
	Tue, 18 Jun 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L0vABP1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D104D9E9;
	Tue, 18 Jun 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693009; cv=none; b=ndqwo70nFhbeeiZJ/NeA7X1PQ6ABSApEugC0yR3G1mKUweLTKSDWbzwAkJTgDSBmFpeoq4WRQzOxpjWxLmLA1N5/LP9N1mNyLgf6KzS7P2sUEbqKwb6E7LF9K3R7Pc3JVOeSa0PhqetAAPCgoSCBwN7IPm5oU8P/35o9rfHM2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693009; c=relaxed/simple;
	bh=VpgJPad+08pstL0ZoWCCeKae7OP1hyR3SvT9SVEit8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1S9Ml0ETnhzxiWDRsN3PDrwZJlH7MXJTuMEHFUPfFqNv7I7Z3L198yjSOTx4YBJEZWzRBCtF/Te3o5EEUNoUCCLcbzXrGZ7Prw4gqwAyf51bV0gwEnSnRYmvBnBZls8XICaBQ3nfnpuEVoP3pxEaQatAfzDRQ6/v++zoZ3BRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L0vABP1f; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xIkCb0DXrPi2i+bQKQrhJv9RbtgOZyK9PyIWQ2EUHTE=; b=L0vABP1f825b9Xo3raJ9hulo7A
	Uo4uoOV2vhy7muoBeOW/TB5V/l0+kHaLHQUt8KX+GAt5Yj7YUqmyxPlhKYuf2lTo2JtLbVsZ+YVsj
	QDPFYKr34JiZXCBcVZawwjtADj1qK6BHJJ9KCkk7nauvWFPo4H28zswTZmzR+elu7xmP5o8OgPJE/
	VXRo151WFZrse5FpNgbTZ0TUQoMKvf6i3fmi1+rDXvDP3xbW4odddxZfbMBKD4jbqRY01eGdJOaYS
	nj5A1ODp12D2/vsnP8NnbsAW27Om+ZgazSCXtrr3rm5KnhqNG/JGBFlIPcQTcR7OWaXaJ5CJGPTqd
	NS3QCLmQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSYo-0000000DqmO-2M4P;
	Tue, 18 Jun 2024 06:43:18 +0000
Date: Mon, 17 Jun 2024 23:43:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
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
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZnEshp0VICflc6Bg@infradead.org>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <ZmAgszZpSrcdHtyl@infradead.org>
 <ee9a55cd-7541-4865-ab2a-9e860b88c9e4@gmail.com>
 <Zmfv6_uWAVavYJNj@infradead.org>
 <8ca3e144-75f3-4e57-9ae0-cc88f245094e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca3e144-75f3-4e57-9ae0-cc88f245094e@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 17, 2024 at 07:04:43PM +0100, Pavel Begunkov wrote:
> > There should be no other memory source other than the page allocator
> > and dmabuf.  If you need different life time control for your
> > zero copy proposal don't mix that up with the contol of the memory
> > source.
> 
> No idea how I'm mixing it up when I was explaining exactly this
> all along as well as that the callback (and presumably the call
> site in general) you was so eager to nack is used exactly to
> implement the life time control.

And that's exactly my point.  You want to use one callback to mix
allocation source and life time control.  That's the perfect recipe
to create an un-extensible un-composable mess.


