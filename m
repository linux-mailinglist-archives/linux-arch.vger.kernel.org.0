Return-Path: <linux-arch+bounces-5227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19197924249
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0FA28316E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FAB1BBBC8;
	Tue,  2 Jul 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kEkbHH/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITaMGUSc"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486761AD9E7;
	Tue,  2 Jul 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933937; cv=none; b=qFhGJxrsimjSVcupi/i2uUl3KOtmBokWE7CaubfYxG9Yj7qdrYTvRWBRAQLGn3/7MA+6jw9F6VASJPXQUvneIuYwW6AGHNWvcYzL7qAs2DDwh7Hy/8akiGkL8x/tm2ZMQuiR4b0An7Z7A9K/ZuwjtN89jv91yT76r7LmsSWUIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933937; c=relaxed/simple;
	bh=yRg+8F091FuUES+JYKaVyH2G6lgo5Hr0AeAjnDuBU74=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NrygjBQt21fiUZGQlq0tNCGsHpwtpaKc3OvR6wr7fkJtQk7qcV2Aa+axJX1dx6U39HVVK8JFlbLt1IEFDIzQTY8E44qjrEMtFhHfHHWxWcrp/jqXTGi3MT3gUkY2FcmjXOdODvCVObUKbBfhH9+8xw+cHXp1/XjNhafvnpss2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kEkbHH/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITaMGUSc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 48F9413804AD;
	Tue,  2 Jul 2024 11:25:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 02 Jul 2024 11:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719933933; x=1720020333; bh=//A1hzQZrR
	Fs+Jf7FIQ+nCDerLffGWLM2hRD5dKs7d4=; b=kEkbHH/XWCSn06of/wqt97JCcJ
	d63/Ez6gIB61Do7L3zzyqlwIy1tVZClPACYGlmn2ihv8WrN2RKGIuE/YWSDyC5X3
	NyOBG9hCHKcF6B3d0U6ABCoD0ABGEWQ4onpwFrpFKgwhkPriO5tL2mLgWIzO/S5V
	BK65nyq5m/J6OOYIDUMu7j60fcabWeGzEZ/nBnJlg794+Dt+QugkelVT9hEEp7Sw
	Fb6pognCnQ28sK53xdF4VE9qsQQ0GWTJbnxxBqYdwtuQTnzrL2C+BkxLIGKS77ML
	e992b6+4qaUoXXMBF0AqrVDeY8pVe53x+UuXMFbiYP/7AuoX43hHfXvDlb/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719933933; x=1720020333; bh=//A1hzQZrRFs+Jf7FIQ+nCDerLff
	GWLM2hRD5dKs7d4=; b=ITaMGUScvo3efaios+nmJ+l2HFnt+Ouk1xOR9SCejBQX
	X+nMNacgNPtPKVi4irj4dEYmGrr8FNITbhQUvWqAYQQPILNRrWJVHQULFVvNoLM7
	rTdtpiL1WJQ2qMf+/vYV45qnUD9+xhUBPDPwmPbuPForpfbAg5MR7IWuf4lWJOgu
	ZjcC9O6LcbgYKxFqEkJjij/TmMxzFEnaFEMin+DhBtFLzdFURKTy10k+bo8qqvn6
	Y6zNLEL+rF6C87PnO3yUyXaOLtKKo2b6FHT7E7qU6piIjRurUT67VkufhxxxVfli
	WkgrL30i15fkwtNeO2lCJCtYhLxBOKJhGEzhWh11AQ==
X-ME-Sender: <xms:7BuEZttoIOu3FgcnRTCwlUY9enW-fWdSGJA21XR6uYg7nZNfEvYT4A>
    <xme:7BuEZmeD2xZcTgq_x095S6hIFE_CXNZyvUj2JjppPZHG2X6yvowIK7ZB0ttBhCkdS
    mKq1RK7-XDTo4l4GAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7BuEZgzV2V9m7yHeP1-CY_1ToL-7saFDkeYbauhzrcIdP0hWxpdECQ>
    <xmx:7BuEZkPqG5nj4biEtgHDOMbrIFpZ-CZs4LyXyDGqrlwrKeiI3XmUng>
    <xmx:7BuEZt-0YpFxDaNOoYfGLVTo6xVdfiYwpii7nZD9L9GApKzNrmdlDg>
    <xmx:7BuEZkX5ATZdeALUPYBN_7NUDUsZodxq3UocvaVEljBw0ouzzUeugQ>
    <xmx:7RuEZhWiOkzLt1hDorcP0Kt54ntgBJmUM8iMCFrY5Nkd-AbR7KPNeG0_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A1149B60092; Tue,  2 Jul 2024 11:25:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35691b55-436c-4c52-b241-f0c5326227cb@app.fastmail.com>
In-Reply-To: <20240628003253.1694510-11-almasrymina@google.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-11-almasrymina@google.com>
Date: Tue, 02 Jul 2024 17:25:11 +0200
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
 "Paolo Abeni" <pabeni@redhat.com>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
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
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David Ahern" <dsahern@kernel.org>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 shuah <shuah@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pavel Begunkov" <asml.silence@gmail.com>, "David Wei" <dw@davidwei.uk>,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Yunsheng Lin" <linyunsheng@huawei.com>,
 "Shailend Chand" <shailend@google.com>,
 "Harshitha Ramamurthy" <hramamurthy@google.com>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Jeroen de Borst" <jeroendb@google.com>,
 "Praveen Kaligineedi" <pkaligineedi@google.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Kaiyuan Zhang" <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v15 10/14] tcp: RX path for devmem TCP
Content-Type: text/plain

On Fri, Jun 28, 2024, at 02:32, Mina Almasry wrote:
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -140,6 +140,11 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
> 
> +#define SO_DEVMEM_LINEAR	78
> +#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF	79
> +#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF

Something is still wrong with the number assignment:

> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,11 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
> 
> +#define SO_DEVMEM_LINEAR	78
> +#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF	79
> +#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
> 
>  #if __BITS_PER_LONG == 64

so alpha and mips use the same numbering system as
the generic version for existing numbers

> diff --git a/arch/parisc/include/uapi/asm/socket.h 
> b/arch/parisc/include/uapi/asm/socket.h
> index be264c2b1a117..2b817efd45444 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,11 @@
>  #define SO_PASSPIDFD		0x404A
>  #define SO_PEERPIDFD		0x404B
> 
> +#define SO_DEVMEM_LINEAR	78
> +#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF	79
> +#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF

parisc uses a different number, but you start using the
generic version here. This is probably fine but needs 
a comment.

> index 8ce8a39a1e5f0..25a2f5255f523 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,11 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
> 
> +#define SO_DEVMEM_LINEAR	98
> +#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF	99
> +#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF

These on the other hand look like a typo: did you
mean number 78 and 79 instead of 98 and 99?

Alternatively, you could continue with number 87,
which is the next unused number on sparc, and have
the same numbers on all architectures?

     Arnd

