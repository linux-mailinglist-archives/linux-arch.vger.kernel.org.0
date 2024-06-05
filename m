Return-Path: <linux-arch+bounces-4705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8A8FC655
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 10:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDD4B2954C
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460249638;
	Wed,  5 Jun 2024 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1ixOcqM"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E984962C;
	Wed,  5 Jun 2024 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575823; cv=none; b=sASmmRyDBQgL7wVQbK/zMkKLl5Ar2cdiHC8V+dZflx2AKRkFZhd1yEh2WDQWbwrsFN/cE8x4Uhp5+Sun2xhb6bVzgjK7kdLCrpb5pgWhxalZXn8A2vZqxmRgwbqBW96HhInEsGZYAYxEsIqIIP1YqAf1n6+1vbhq6jmyIfPwe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575823; c=relaxed/simple;
	bh=+6qBXpM4CAtIHbKGm8U2EPi2QBj6ZSNnA68LJ18zkas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD7KuGWeu+K/As377jJhqHGKZ7/O9sr5Qxd8qNKjJf/ccaNyVG4nc9hEAP2NayB8iIFuLHc1j2t/Qws+CttLzqFtZ8syBLzfNieQ51GEaG+CCW3iG9UhjejDTExvtRc2mRMS8RbuKx6NEmJ112xtqAhGoFegBdVeI+k2VydCumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P1ixOcqM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=7xhPdfPc2smXf6F7HsxZ8sv5bz75m1tU4HsrWy1Cu+4=; b=P1ixOcqMYBL1qNqoRQQlMNBcnO
	cJczue4oUfXvh/G4zstXTx292PLJhGaQv23TkAd4cXeR9h8E7cvo2TJC+0SHMai9QBHndQ8hZLSTc
	0xw66kP3ze14ks9DdH6S+RPoyBybl6k/w0BakZRcP3JhTtO1Rbgl1uiOE7yuJ5sW/Wvh6s1wZHVcv
	AEMzPhyWgdqcKSbzV3/PAyCLrKF1l1wsuGU4ZMULxbQuYrL6RKDrJCdn1M3WQkm1oA5sshSZQBPOc
	Q06JS4sW51P1TfL7UaM6Cdr8ZP7QEo9pg7z+entRzmuY6z8rDrtSKtNr+anTt1+bR/0zNSiXcX0y8
	zeYEKWZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sElvi-00000005BX0-0Tmg;
	Wed, 05 Jun 2024 08:23:34 +0000
Date: Wed, 5 Jun 2024 01:23:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZmAghrRrj_KGgSQR@infradead.org>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 03, 2024 at 07:17:05AM -0700, Mina Almasry wrote:
> On Fri, May 31, 2024 at 10:35 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
> > > I'm unsure if the discussion has been resolved yet. Sending the series
> > > anyway to get reviews/feedback on the (unrelated) rest of the series.
> >
> > As far as I'm concerned it is not.  I've not seen any convincing
> > argument for more than page/folio allocator including larger order /
> > huge page and dmabuf.
> >
> 
> Thanks Christoph, this particular patch series adds dmabuf, so I
> assume no objection there. I assume the objection is that you want the
> generic, extensible hooks removed.

Exactly!  Note that this isn't a review of the dmabuf bits as there
are people more qualified with me.

> To be honest, I don't think the hooks are an integral part of the
> design, and at this point I think we've argued for them enough. I
> think we can easily achieve the same thing with just raw if statements
> in a couple of places. We can always add the hooks if and only if we
> actually justify many memory providers.
> 
> Any objections to me removing the hooks and directing to memory
> allocations via simple if statements? Something like (very rough
> draft, doesn't compile):

I like this approach, thanks! 

You might still want to keep the static key, though.

