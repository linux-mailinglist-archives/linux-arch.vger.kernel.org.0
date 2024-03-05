Return-Path: <linux-arch+bounces-2806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CC8718EF
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFA1C21E56
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DF5026E;
	Tue,  5 Mar 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QqEGa4r9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffp1B3gr"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F074F5FB;
	Tue,  5 Mar 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629508; cv=none; b=NZ9iQQDGHosRng+QvrCGF8h9/4VC9Xy8zcS5hBwmlL/q35QDxHjfEYJg6ufG5FfSUlDIe0tz5ezJB0plftWPQH6gafw5gGagUau4KS0KAoc/19Wuo0ROVf3gndnnbO8ef6dCZC4XNcz2orQROJEF1kMRXAIUk10dUXGbbrv2oPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629508; c=relaxed/simple;
	bh=4vEnG02ligmP4LrcfFUAEQhjxpcNYEU0JASPzUPZp/M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=W1VVu1Si1ZDwvJJ3DAdwdqFC73HiHtrq2oeZtPDS/YjOQGr0/utmmhhj6mmO4SCxIi4+Bu+mCbUfAt/xU52Db25bFhNhrmC2XvHxQI2oiLuevyxqX/Ax9i0IdAvIuFtxjz7UZvKHD7jCSiVM2AHC6Ax5f8wMusndrfDK9Z752G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QqEGa4r9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffp1B3gr; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 1A19F20019D;
	Tue,  5 Mar 2024 04:05:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 04:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709629506; x=1709636706; bh=ekmA5RBZ+C
	vAhdFbvGw1i/0H90ih8Imy4vkxYH5RFbI=; b=QqEGa4r9McZtHb0OkTWoNz8Cpq
	3WBmpPrz7qLhXVEYkTwg2p1NZXE0ZhyPI3AGGHtk3Rv/6NgO/3CP1fqZLem04mw+
	p3QoPOKzICd6TT9+hGlCij5AL3X8IsefBDmdsE99xupmewgW3RrmknC5gyxXJbOw
	jjb0qxB3hB9IpVSiUX8KiO8OD8CotuEy+MCwukJYTqLmkUChHPnslGsiUHH80ixX
	7/8YwvTcAgqLDFbvugKmQQF+uJElLO4lZSxh9en9RUZFKmYgvZmvLhpJFcQgOHmq
	KzZftPdoJDQqIGjBH61cHjokDpY8jQRXwDhGnadzjPvAYKbxLHNV74MZUAPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709629506; x=1709636706; bh=ekmA5RBZ+CvAhdFbvGw1i/0H90ih
	8Imy4vkxYH5RFbI=; b=ffp1B3grSJGsi/Qye3ZKLhFJMQ1O408nhApMyl1xeWxi
	Qum93i6mosnxXBLaAF6pEU4kgYLMYRYuyr0O55RcCvsOPKlA/lebBzszAEw8z2fK
	9mofBQXhBfbShKN+Ba8Yojkb7Nxoh6nNgjM8ZSDUBGgXbrX3e0MZt8GqIq2CSVTI
	mDgwF/uh7lOKK0oGKfz1Tb6XIsJMTCdyrYZt5juoHDAmnQ3wdi2eDpGnLtWFnGqL
	J7d1N5nV5SbMZasfVQhYKnR5ss29BRpHTN3cfkLwwQjvILmEXNzeAURwmubqInXI
	8TtYwcEJnfRQ1DYVSE034kwvnTix4aFSb3YaQpm5gg==
X-ME-Sender: <xms:QeDmZcSqlvS65KrI11GB-bkUhHz-isjYI7nQhu-B8RPEsPR7_i7mOA>
    <xme:QeDmZZzpOC6xiOJ4Kf9Rq--PvDod7rPccVfneffAu_fgnMhhX2RAhCo_xCvh51EZw
    wSwBsiGcRAjzNGmPy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QeDmZZ33TWs8XgKTvXFCuCpVA3KhmWmH3cu9RPViDcsLMHWwKfbeIA>
    <xmx:QeDmZQDoSGyc0_M_whlWftbNiCCH84FJbBG25gHuwkXv2cDHzazJlA>
    <xmx:QeDmZViMvrdrAk59DNYRPuWpPy5dUJZk43FcY72xtPZo50BYNR5U7g>
    <xmx:QuDmZTHyG7KUIuLhz7aTYqvje-cX0WRnDtLO1v6tdbJjHzMl8IyCGI2fiB8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6329AB6008F; Tue,  5 Mar 2024 04:05:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e2f9342-4ee9-4b30-9dcf-393e57e0f7c6@app.fastmail.com>
In-Reply-To: <20240305020153.2787423-6-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
Date: Tue, 05 Mar 2024 10:04:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mina Almasry" <almasrymina@google.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Matt Turner" <mattst88@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Helge Deller" <deller@gmx.de>, "Andreas Larsson" <andreas@gaisler.com>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pavel Begunkov" <asml.silence@gmail.com>, "David Wei" <dw@davidwei.uk>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Shailend Chand" <shailend@google.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeelb@google.com>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Kaiyuan Zhang" <kaiyuanz@google.com>
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to netdevice
Content-Type: text/plain

On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:

> +int netdev_bind_dmabuf(struct net_device *dev, unsigned int dmabuf_fd,
> +		       struct netdev_dmabuf_binding **out)
> +{
> +	struct netdev_dmabuf_binding *binding;
> +	static u32 id_alloc_next;
> +	struct scatterlist *sg;
> +	struct dma_buf *dmabuf;
> +	unsigned int sg_idx, i;
> +	unsigned long virtual;
> +	int err;
> +
> +	if (!capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR_OR_NULL(dmabuf))
> +		return -EBADFD;

You should never need to use IS_ERR_OR_NULL() for a properly
defined kernel interface. This one should always return an
error or a valid pointer, so don't check for NULL.

> +	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
> +	if (IS_ERR(binding->attachment)) {
> +		err = PTR_ERR(binding->attachment);
> +		goto err_free_id;
> +	}
> +
> +	binding->sgt =
> +		dma_buf_map_attachment(binding->attachment, DMA_BIDIRECTIONAL);
> +	if (IS_ERR(binding->sgt)) {
> +		err = PTR_ERR(binding->sgt);
> +		goto err_detach;
> +	}

Should there be a check to verify that this buffer
is suitable for network data?

In general, dmabuf allows buffers that are uncached or reside
in MMIO space of another device, but I think this would break
when you get an skb with those buffers and try to parse the
data inside of the kernel on architectures where MMIO space
is not a normal pointer or unaligned access is disallowed on
uncached data.

        Arnd

