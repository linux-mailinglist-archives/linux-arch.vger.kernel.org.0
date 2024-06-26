Return-Path: <linux-arch+bounces-5161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B49919A5F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 00:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44244285557
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230E819309C;
	Wed, 26 Jun 2024 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azand2s9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9B18FC9D;
	Wed, 26 Jun 2024 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439706; cv=none; b=on0tWNEyBQtEtz+DaP8sfJaqaDDuXUzSQatzn8eA+1DBZkVc2Qq+ateQd9Azv43SjM/OMlyBUVf2fgMJM7rnVbU8fl5xGrSOCp+T0bMS7hbwzeLot6kvqprEimfB3dtegpR+YUDVoHpu4PQCLBtCF8pSPM1qf5pAYueFcRXX1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439706; c=relaxed/simple;
	bh=5d7H9/borh2oqA2du5mHYiDRGDELCSRd3Xk3e6IKGpk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RY8dfRrQK/38MpWf+P58rr1ijKJISkpc0xIzVZ2iMZGiWFQH6FJ1qvQshMJmH0jhKpblSEXphGzvsywsj9oSCw0CyunSxwIU1Ep9puVywXw8z79inzN1bsj91LuvG80M6IzIaCWq80fIKIqAvHhbktwEbmvi59V9c+v2KkndlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azand2s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFCDC116B1;
	Wed, 26 Jun 2024 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439705;
	bh=5d7H9/borh2oqA2du5mHYiDRGDELCSRd3Xk3e6IKGpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Azand2s9PJ5hpj1pJhfR2k36lgYX4q5EVbYEyRHHreykGtMrk+xW0MQHsApc0A76v
	 R1ziYuRsJSA+U/KWvr5SnBpOp8/FKkRiM6PI0nOu1ho2WTtUmR6G5sIpL6x7taOS74
	 BKU7UERaSnhVXfErVlfARVzsOmJFhRxiu5ZNmdcpweU0PcrGPzi9VXvWtjUYhKPfz4
	 PU9tdlZOctUnOe/hbtETyla9PYMBK4jPfl5YaFALjxIDPqvgUbpKhQGLjYAm+LNu/A
	 FcxJ5FSoDrgKEIR6AfIX7N+H0c4Zxj7PfzVnZeblZVvSM942WHMP2TU9Mpm39Qb57l
	 1EyKxF3wvDs6w==
Date: Wed, 26 Jun 2024 15:08:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v14 13/13] selftests: add ncdevmem, netcat for
 devmem TCP
Message-ID: <20240626150822.742eaf6a@kernel.org>
In-Reply-To: <20240625195407.1922912-14-almasrymina@google.com>
References: <20240625195407.1922912-1-almasrymina@google.com>
	<20240625195407.1922912-14-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 19:54:01 +0000 Mina Almasry wrote:
> +CFLAGS += -I../../../net/ynl/generated/
> +CFLAGS += -I../../../net/ynl/lib/
> +
> +LDLIBS += ../../../net/ynl/lib/ynl.a ../../../net/ynl/generated/protos.a

Not as easy as this.. Please add this commit to your series:
https://github.com/kuba-moo/linux/commit/c130e8cc7208be544ec4f6f3627f1d36875d8c47

And here's an example of how you then use ynl.mk to code gen and build
for desired families (note the ordering of variables vs includes,
I remember that part was quite inflexible..):
https://github.com/kuba-moo/linux/commit/5d357f97ccd0248ca6136c5e11ca3eadf5091bb3

Feel free to repost as soon as you got it fixed.
-- 
pw-bot: cr

