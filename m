Return-Path: <linux-arch+bounces-2805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E0F87186B
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 09:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F021282A41
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E324D9FF;
	Tue,  5 Mar 2024 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SrN0IcvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUrkj7qE"
X-Original-To: linux-arch@vger.kernel.org
Received: from flow1-smtp.messagingengine.com (flow1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394104CB4E;
	Tue,  5 Mar 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628140; cv=none; b=h+0luxEIpaPJseDzbk4hoVWqk574NMrbFXjY7XdLIe62IyrtSrw/obMFQ409b3SewnFXwTGks0Tibm8AkJUdmcNMFOSGVuKvJkTMoDw0URYmJaKdB7Ia7oRg4OfXkBZMRwNrzYPPH6TRHG/EkBDYaPpVMUD1yHN5S1YahO4gh1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628140; c=relaxed/simple;
	bh=NmJCAuRJ199Nz8coLDr4s+3BbQ9AxZ5w+P+Jx63NVw4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=KKQ27b7rQWyv1YzcEjRRSKF6uIk9CsJMtCEOwknbNukNVyrM1TulLEWP42KquIABrfI7Xav2nPz1uy6eG/99XGdLDJny/KzmRSVmEC+C18PkeUKPVz84vtmGPpBcBj4I9WcuXUXy8jeOv6T5CYR9Nq/BoKEOwHw8tLXOFt6JpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SrN0IcvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUrkj7qE; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 242C720025A;
	Tue,  5 Mar 2024 03:42:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Mar 2024 03:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709628137; x=1709635337; bh=QeA3EPMJnw
	t6NmNxY9VsOPm58VedM11auwf8kvd3l10=; b=SrN0IcvG+CPxJAPHYHVIf2JkQi
	6aTKoGPcbuZZ+5LZpt4LV5ol9w0MZc8VMYPm3QDT41tKe1Zme80Xkas3iZkqGu9J
	LTPWeQ+TvEW8x4RAL/4J1D+DIa+H5tSyYjMFrT4iYOV9kPTbgRY5B3Efv/NL0mqt
	Sh5qihCFAmYE9z/QTckbjm7bpnkdE7ivuu018LlM12hdoIChh/aTF2CfCC+zTNNg
	pWmFTJRKJgwCNAdhzgIYZAHUSyD9jd2lnbIGwavGslxLcsYVhab6FQ6scVAmndm9
	hMb3+wijmaQdDbkVyhWGsnkzQWVJrNiXlLndvxBgJ1DuOG0An7zgcsKngtUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709628137; x=1709635337; bh=QeA3EPMJnwt6NmNxY9VsOPm58Ved
	M11auwf8kvd3l10=; b=cUrkj7qER6QQIRnFKUiYlatAQ6/yN/ydi4yFtlZ9uhjS
	WnNinuJoMczVcnGJU0rimQ2ZdK3O6eY+HYnVX9hFyRf7kjMXjkvV/cQmG+um5o4b
	ENJHeVypTHbd+sOrT08zSgiit73d1Nl4JuEcXvthyJmpiOTrCwlZhCgDqepSPhgV
	OJpMvS3cKimyU9P9MYHQMAid0av8Y5uDjTTX5EEJDRKHP7+0pBi94UyisQGx7hfH
	nU409xIVBbJ6bcGpNKQItGs7wM3HkrH11fUt+iM/4VBFUhGEOQkvdH7G9mq7KPB4
	MwtBYmps+wYULvq9bmvxLikKnCQB69nzHTI3tPLsoA==
X-ME-Sender: <xms:59rmZXj1XBjvZwSrYxeBx8j1_jqi3bw7y54_kDvpY3ZSDIYdhngplA>
    <xme:59rmZUBwtIZC6ilN9khiLUcbA2-QkOWWQp6FN9gou6hREYvUE8u0cHCSLe6Dyq1u2
    4w97V8hRBQ0MfgeTtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:59rmZXGjDWqVGnJLCSgHG3LcDhp31ym5yhfHmOz3DkxYLj8W2aygig>
    <xmx:59rmZUSJtVcRW7HmjnEA9PDWLnzxKhpw9WvZ47Ik0VWJ9MZ1_fO3TQ>
    <xmx:59rmZUxOkjBpcRl6B-6KwBqKNgDbwLAcbzqjMgh3agbGc-NMjdXQJQ>
    <xmx:6drmZYU71T9jFIxEdqIBdh47g3ojPXXfUrlQ1gCPYBk62M5eGYCJWqqJa6c>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5045FB6008D; Tue,  5 Mar 2024 03:42:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2d926be-695a-484b-b2b5-098da47e372e@app.fastmail.com>
In-Reply-To: <20240305020153.2787423-13-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-13-almasrymina@google.com>
Date: Tue, 05 Mar 2024 09:41:55 +0100
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
Subject: Re: [RFC PATCH net-next v6 12/15] tcp: RX path for devmem TCP
Content-Type: text/plain

On Tue, Mar 5, 2024, at 03:01, Mina Almasry wrote:
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	79
> +#define SO_DEVMEM_DMABUF	80
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	79
> +#define SO_DEVMEM_DMABUF	80
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD		0x404B
> +#define SO_DEVMEM_LINEAR	98
> +#define SO_DEVMEM_DMABUF	99
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
>  #define SO_PEERPIDFD             0x0056
> +#define SO_DEVMEM_LINEAR         0x0058
> +#define SO_DEVMEM_DMABUF         0x0059
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,11 @@
>  #define SO_PEERPIDFD		77
> +#define SO_DEVMEM_LINEAR	98
> +#define SO_DEVMEM_DMABUF	99

These look inconsistent. I can see how you picked the
alpha and mips numbers, but how did you come up with
the generic and parisc ones? Can you follow the existing
scheme instead?

> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 059b1a9147f4..ad92e37699da 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -20,6 +20,16 @@ struct iovec
>  	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
>  };
> 
> +struct dmabuf_cmsg {
> +	__u64 frag_offset;	/* offset into the dmabuf where the frag starts.
> +				 */
> +	__u32 frag_size;	/* size of the frag. */
> +	__u32 frag_token;	/* token representing this frag for
> +				 * DEVMEM_DONTNEED.
> +				 */
> +	__u32  dmabuf_id;	/* dmabuf id this frag belongs to. */
> +};

This structure requires a special compat handler to run
x86-32 binaries on x86-64 because of the different alignment
requirements. Any uapi-visible structures should be defined
to avoid this and just have no holes in them. Maybe extend
one of the __u32 members to __u64 or add another 32-bit padding field?

       Arnd

