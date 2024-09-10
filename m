Return-Path: <linux-arch+bounces-7181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B9973ADB
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37AC285ED2
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398F198840;
	Tue, 10 Sep 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rY8ck2js"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACC196DA2;
	Tue, 10 Sep 2024 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980560; cv=none; b=f7izQJOvC0fN0y00rrZwyEJm2P5NcQwRT7lY0JUtGT7U6tcbqN/lpZvr9ijjJxpm86Wc2Six6jRz/RbgAY8LzvzB7DQDQE3nxAhFqsfRO8kvHlZ7Zl3iDci2zmnUUC+8XwEyfilG91aSXz0zv3HMV4fIWnCAnMaoFfXGTd501+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980560; c=relaxed/simple;
	bh=FJ6zm9ztQkddgg9BMRdptbyUDCBfyLReaFgmGr4LsgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuoJFFHRaFkA4/qvtKdIYfKnB7ZRQi68RORQvzlyRbmfKfVpTcZFtGi0TQcJeO/kR0nxz6m0j1b9IAZBtsrs77wYUQ4PIWGO7zEV31fOt2rYuQL/nvqXdKzAmKwCrhcQI8VO3EVptwY0WS4NUBz+LD750u/pi0uyYZTMXW3BwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rY8ck2js; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2682EC4CEC3;
	Tue, 10 Sep 2024 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725980560;
	bh=FJ6zm9ztQkddgg9BMRdptbyUDCBfyLReaFgmGr4LsgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rY8ck2js0UYnZ+lzCzjXzN3NLreOXLM+sL2KgeTrrKdVvIHu/Avxx+sWE/tAL7h1i
	 gTcnTSieTyPiU4JAtFmBG+J/VnAPkmWl4U2Q6SvjRUPM4wPITWB57FaX5ft1BhKuQS
	 epSZF8b1fQRZT/dmjp9T56BFd61hvPb+eKvfhkT9dCkv99fgx/WXpYSooj7s1PBKYS
	 tMU7dZvpyuS8B3wklFmD5MdEaVcOKOAPjU/njfU+oOxHwXTB9X1jDtER/XS44bMPL4
	 6Zzyvz/7o/gX6Qaa0SnOLSWdHLqB9tAQuHMUPSF9VrqXGSp6i/IScMfY7vwIX6St5y
	 D52NfG5uwMpYw==
Date: Tue, 10 Sep 2024 08:02:37 -0700
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
 <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert
 Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, "=?UTF-8?B?QmrDtnJuIFTDtnBl?=
 =?UTF-8?B?bA==?=" <bjorn@kernel.org>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
Message-ID: <20240910080237.2372cfa6@kernel.org>
In-Reply-To: <20240909054318.1809580-1-almasrymina@google.com>
References: <20240909054318.1809580-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Sep 2024 05:43:05 +0000 Mina Almasry wrote:
> Device memory TCP (devmem TCP) is a proposal for transferring data to and/or
> from device memory efficiently, without bouncing the data to a host memory
> buffer.

Mina, if you'd like to see this in v6.12 -- please fix the nits and
repost ASAP.

