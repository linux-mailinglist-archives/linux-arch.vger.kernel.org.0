Return-Path: <linux-arch+bounces-3147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0867889231
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 08:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3052F2933B0
	for <lists+linux-arch@lfdr.de>; Mon, 25 Mar 2024 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9859A1B5DD8;
	Mon, 25 Mar 2024 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iF7DWwIh"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8D2733F2;
	Sun, 24 Mar 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323325; cv=none; b=V4i42sNwmFtejMoS6ppzpbJFpUqNNR6iU+iyog+EbCKmThdCMoybhazaS3dU8Nr23OUyz6qkz/AbangdluQmAr5yMEhRq+oiBv3/XnzjvNWbsoxNQYuauHUb3h0jrNQFSx9tNGR4vtByFbXUc010kkGyPumHyZJ7s35GkfyQCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323325; c=relaxed/simple;
	bh=w3DndtsjG6zas1wfMjz8RZMmPG7WJq8zOlcY33vgO1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTGa00yHWOCy0w9IMnpQoUD3KDYqfX8zJuKF7G5p/jTW/laVf4vZcyQtujh32imp6F9s1ERucJSJIB8fOD4a3UhusvJjgPcHVOCP5uBemqwVo2T0NKQeDWirKAAGtt3IusoP0zZPFh5YbyqpItiOrGTj67v2cHiF9CoF13e3tTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iF7DWwIh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ghVT0JSAZhWZjIMzPkaSyKQMLg9eo2J9vvVmkWYzHY0=; b=iF7DWwIhKNw1JXqENX4aC5VQuT
	Q+y8J0fuVGe5AwYlRzm3NLZujnu/cR27zhXmnagtXn8d3D3rIzlQWL/6pWHpEyOsjyQKu9U2fsYdZ
	0j1Mu5FqrQQdlfn/nychyLmO+m2AXW7q8ktbLO3WvzRguveQN+9kvatO/5ZHsKHKGvl81OGqJ/bIy
	sZGsGxnt09H55+3KNacdrD6wCQHPICcVluG/tqUD+roC24jyBL7Ek0i83zLxKbvBPSHsaoG9qMe/T
	QWvbXHUSflmRJN4m5L8+F8u1KOq4Yn6T495UloKN1oQ8QbpHceqV4E+DC4cZ93dBQ+vH4TaLdVtcg
	S6F8ELJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roXMv-0000000Dtyv-0e3z;
	Sun, 24 Mar 2024 23:35:13 +0000
Date: Sun, 24 Mar 2024 16:35:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Wei <dw@davidwei.uk>,
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
	Pavel Begunkov <asml.silence@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZgC4sWfHFGTY9HzY@infradead.org>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
 <ZfegzB341oNc_Ocz@infradead.org>
 <b938514c-61cc-41e6-b592-1003b8deccae@davidwei.uk>
 <ZfjMopBl27-7asBc@infradead.org>
 <CAHS8izMT1Smz6UWu2uwAQRqgZPU7jTfS3GKiA_sDw9KLqoP-JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMT1Smz6UWu2uwAQRqgZPU7jTfS3GKiA_sDw9KLqoP-JA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Mar 22, 2024 at 10:40:26AM -0700, Mina Almasry wrote:
> Hi Christoph,
> 
> Sorry for the late reply, I've been out for a few days.
> 
> On Mon, Mar 18, 2024 at 4:22 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sun, Mar 17, 2024 at 07:49:43PM -0700, David Wei wrote:
> > > I'm working on a similar proposal for zero copy Rx but to host memory
> > > and depend on this memory provider API.
> >
> > How do you need a different provider for that vs just udmabuf?
> >
> 
> This was discussed on the io_uring ZC RFC in one of the earliest RFCs.
> Here is a link to Pavel's response:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231106024413.2801438-6-almasrymina@google.com/#25589471

Undesirable is not a good argument.  We need one proper API that
different subsystems share for this use case (this is the same Feedback
I gave Keith for the similar block proposal btw, not picking on the net
folks here).

If dmabuf/udmabuf doesn't work for that we need to enhance or replace
it, but not come up with little subsystem specific side channels.


