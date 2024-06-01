Return-Path: <linux-arch+bounces-4639-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD88D6E15
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 07:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0617285DE3
	for <lists+linux-arch@lfdr.de>; Sat,  1 Jun 2024 05:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C97DDB8;
	Sat,  1 Jun 2024 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HKdrUCcb"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ABAB645;
	Sat,  1 Jun 2024 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717220130; cv=none; b=ncUJ+67RK5bkMTNskJsB9JSWGTRsMWecrDIsPIXoJccVjN8DSk/TIuGo5Iv6m44UpNvRbhBp1FwBqJvuUyaoid715e75RdcTgcRCMLFLkyNbLcnAO3qKyid5w1r3aNkaakidM/Z3OwJWcRcWRIMZHkhWKCcp0XYXptbC7v9WIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717220130; c=relaxed/simple;
	bh=Qcg2EsWp+MetVfVlJ1MsRloFldhkkthqt6s0XSJGGUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNBROIVzzRad9bD4fki+dKwX/enbEizuT9BVZjQByrJXz1Mi/vGyRxNbpTbc5d5r2bhithO+moS1qz2G3RcCHxWU59Xxt6JDQiwvEwDYkY2E2Km5/btk7e5ZdQ/870GV/tV1XuU11sY6dP1+D8L/Skgh6BO24PBeGtWf9gxSsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HKdrUCcb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=456lYLJFZKzRl4SbmbA36m1MZ6kwxd5EdW3HB35jgrg=; b=HKdrUCcbh7nuL8yjXhHjQH/2c7
	U49VdUoahQ9mXcAW41e+bwbDxOi+Vq+eFNiyQVP2sy8gBiQ6/Hs6+GeSqxfWD/fEs3RKX4yjsxvrB
	QBk3NOphsBeQ5nznYjVhhCXtbxYIF7rSg/FLAq5/WvFZcw7b0toA8m5usAMU+ni1+Y1TWlial5hme
	KvsVSNOSB79AJSWThDvRC+li8uz2EJJdKOhF707Lf0dpLWLJF6cjRoFrWm8dEvxyi/ImC8yGynqHB
	uNmkck8LcVheHGVvgWeTovxzhvSb0cCLQIyOyRoHvtbV3ADVSDQFcZmf/3qL/6AwY4q8Fs+FMEG7K
	BxU0btmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHOb-0000000C0oj-3fR7;
	Sat, 01 Jun 2024 05:35:13 +0000
Date: Fri, 31 May 2024 22:35:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
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
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZlqzER_ufrhlB28v@infradead.org>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530201616.1316526-3-almasrymina@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 30, 2024 at 08:16:01PM +0000, Mina Almasry wrote:
> I'm unsure if the discussion has been resolved yet. Sending the series
> anyway to get reviews/feedback on the (unrelated) rest of the series.

As far as I'm concerned it is not.  I've not seen any convincing
argument for more than page/folio allocator including larger order /
huge page and dmabuf.


