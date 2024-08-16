Return-Path: <linux-arch+bounces-6239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A230953E77
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 02:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1D41C22070
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D638C06;
	Fri, 16 Aug 2024 00:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5thZ3pI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F61392;
	Fri, 16 Aug 2024 00:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769757; cv=none; b=h8cvPFFX8XhTqcL7liAWy2zmtyljkv9NUIIiDDEn0fi+dD03JhNsV0WDZzVVh81hazZyXi3U54A2RpiQW3CFZ1tQCYI82P3oB5fD5RNHg1T7Vv7LIOH1qP4eZDhTYnFcaKkxdgw/tIeKF7R3wtPo3Tr1aDvHLyiTBLDphRLucP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769757; c=relaxed/simple;
	bh=ZcHo/CbFLNbPU3TGom7ZDR4V5kCpLxNvdVNXgVhQZtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFRJbOovW4FZHEZ3y0I58RY/tH4BfJyAXzfNUsIkU1kVedVRgGdYwHCVFFcn0qKDQvngHXfmIm0FpQIaMD5jRUG+D5bNmhQUKnk34d7PjxAw3FT45hnBijr8albl/Kyuvh1lTFOU3zb2hrUAvd3mDOk9gdi1iMMZO32FLSdFRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5thZ3pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191E9C4AF09;
	Fri, 16 Aug 2024 00:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723769756;
	bh=ZcHo/CbFLNbPU3TGom7ZDR4V5kCpLxNvdVNXgVhQZtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5thZ3pIG8CdZTJ7ULX66/YI+PW4xX2vuXdbIpeULwVF/4EhtQt+rxGELEUCN7/fK
	 uVUKkj17/jDJllEyftu2zgNowQqVq+c12dY/Q+ZGfCBnYA2PJgEuSJdPU9lx91tViQ
	 SPIk6cnl8p9R/vfLN7XYeBfVi+1OGgGgPS9UiypNGKXk2iTboS8UVF/Yn0dnwh8MDk
	 DkyGkBwK2vbF14dHWxS26BO7IjCgkd+FuzxY6VuHQK9qo31BNgG2IoK6Jm8sFkZbrl
	 us8xI4/cgRelVrDFTzCZakYFqcLo5kMWjIjiqj96VgGQJpkvazoYEFmVfHke7JA2Ga
	 wRcm6f17hNcUw==
Date: Thu, 15 Aug 2024 17:55:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem
 memory provider
Message-ID: <20240815175553.51d9f0fe@kernel.org>
In-Reply-To: <20240813211317.3381180-7-almasrymina@google.com>
References: <20240813211317.3381180-7-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 21:13:08 +0000 Mina Almasry wrote:
> +EXPORT_SYMBOL(page_pool_mem_providers);

not sure if this export is needed, but it doesn't appear to be needed
by this patch?

