Return-Path: <linux-arch+bounces-4749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EC90069C
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1E1C2155D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE731991D3;
	Fri,  7 Jun 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb7DMqcA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D5197A99;
	Fri,  7 Jun 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770455; cv=none; b=P+d8uN1rueupnANN+Tx2fOFLxfBIx18FXDQdejiCSV+m7Wswa23PMmCQpkA1g1TiOquNnJZrN/60BhPKjgpOdDdOduvYZlbpPHJtfKTaMITy0e9qvTRJByEUAH1VqLdsRNslYQ9VGyhm5w0tRZ+nZaFSbpJ42wPFw7lpiNrZsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770455; c=relaxed/simple;
	bh=KPoMrsS5snh8BDGlOijeafq2go5qhS6jTOpT7vzHlQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1idzG+TscsfE4qdOTkNqE4eLLOfNo6WaEqI886aoAQNPOAeiTJUTYxE17jIJo8z5I59xpo1cu8W+56xXO4XjnX0Rv8X7l8et/gODHQzMsSzfyVnHCghuosrrAx11VIlE3X4YXke930sWnTGR/pOXIGI/Fp734eWZOaxJnifiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb7DMqcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BBCC32786;
	Fri,  7 Jun 2024 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770455;
	bh=KPoMrsS5snh8BDGlOijeafq2go5qhS6jTOpT7vzHlQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rb7DMqcArkZvyfBzLSVJUlQlV/Ck/+6ESPZxN5arnY7H9q7XJGMPPBAE6V2HkFmBt
	 ncwTlfI/t3hucXH/VxlO/fez1rU2hLs6i/UEpdUTN54W2IQMZ7n1U4OQrWgA1LmJR0
	 zqDW98yT8BuLgAvCcObpxLiQFfHY2URX5ybVl931TqQhYmhE6iZq2PBE2DaWde/7Eq
	 ovQkSS/Be7X8r3wJ/i72g+jHgwGd7hyJUkX9jN5/oboTDeg43lJjOz4IMLmY5nFrs6
	 IyllF283aguUwgY+ZXHesUmBojvGPxRsoSaw6Pxmz4XZKaEL7YdgXyxtgphJeI0HVU
	 EnAm4F9g8Gk9Q==
Message-ID: <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
Date: Fri, 7 Jun 2024 08:27:29 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>,
 Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 7:42 AM, Pavel Begunkov wrote:
> I haven't seen any arguments against from the (net) maintainers so
> far. Nor I see any objection against callbacks from them (considering
> that either option adds an if).

I have said before I do not understand why the dmabuf paradigm is not
sufficient for both device memory and host memory. A less than ideal
control path to put hostmem in a dmabuf wrapper vs extra checks and
changes in the datapath. The former should always be preferred.

I also do not understand why the ifq cache and overloading xdp functions
have stuck around; I always thought both were added by Jonathan to
simplify kernel ports during early POC days.

