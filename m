Return-Path: <linux-arch+bounces-4822-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A09032B7
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 08:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049112818A6
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 06:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FA17166D;
	Tue, 11 Jun 2024 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tk+dXBXX"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B718F5A;
	Tue, 11 Jun 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087664; cv=none; b=ZSO3oCk8tiWs8pqRkZDtSo+Nzm6+SREKLsz8PgcygqQcwisZbWVLezKxRj3NF4voll6YQcWYkecVs6Tpz5/BydKBnzvqXO8Gb5uDokipZPdrxdHX/fwUDZ9O1W5jWKLBzAWfP0xkN2B7ferJdNzwFnop0KAI6ZINHxSeLK0VMOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087664; c=relaxed/simple;
	bh=HD6zuN/YU9GfTvnsSFMgwOJWHu0eEEC9QbPLvuRX1c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA1oZR+6Z0YtT+afqBQsXVtKi/Y34eYCkxjtA40UvqhALkI8bmcHZWMx/selLdGkPxHvZnBKMOGFAGNAaN62AAcwVdqaPoHXKX/zeTgMju+Hrz8BSFdmv9eNFZqPG+0ZUUItF5q44PklN2SQJ2/WtmAAFOxKCRSvN5KkhscvbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tk+dXBXX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hzKsVpPKje036bzKOnuX4U/056zgkgQVmUIf1wvq07g=; b=tk+dXBXXnk+zd0X6cNVDuqRLwz
	8yla0aeDdhwXFJ5H8iEksLC/i+v8TgdhFIN0LrVDrz2eU4w6hqwkIAkpocyNUX4FO8vIuauY1ocdQ
	IkB79AVkz2KMdYCaIZvu6zf1rUP4dybZcAUKcaJ/teL9/hO0Uegap6UhilSpklGsaM6rTnhS//YmH
	7OMCj1MhnKEKhaT1tyODcZC89YNawnzk6gECL6aqJ4gYeUPwBWI1GsvQm0fn46ZSwIKv8aXfaH8zN
	Z2LY5bDtuzpTNWTbmi3g/LNfCMxo1svf/LzeWeNgyyGk+GVWq7vtPAlG6ZBgyil8yUn31T6UUKzTj
	Kg/+ijvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGv5H-00000007iHI-2R65;
	Tue, 11 Jun 2024 06:34:19 +0000
Date: Mon, 10 Jun 2024 23:34:19 -0700
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
Message-ID: <Zmfv6_uWAVavYJNj@infradead.org>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <ZmAgszZpSrcdHtyl@infradead.org>
 <ee9a55cd-7541-4865-ab2a-9e860b88c9e4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9a55cd-7541-4865-ab2a-9e860b88c9e4@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 07, 2024 at 02:45:55PM +0100, Pavel Begunkov wrote:
> On 6/5/24 09:24, Christoph Hellwig wrote:
> > On Mon, Jun 03, 2024 at 03:52:32PM +0100, Pavel Begunkov wrote:
> > > The question for Christoph is what exactly is the objection here? Why we
> > > would not be using well defined ops when we know there will be more
> > > users?
> > 
> > The point is that there should be no more users.  If you need another
> 
> Does that "No more" stops after devmem tcp?

There should be no other memory source other than the page allocator
and dmabuf.  If you need different life time control for your
zero copy proposal don't mix that up with the contol of the memory
source.


