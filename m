Return-Path: <linux-arch+bounces-4388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEFC8C4A10
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 01:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE011F21C8A
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4F85636;
	Mon, 13 May 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ4+eKX9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8C446BD;
	Mon, 13 May 2024 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715643078; cv=none; b=pkcuLdlTR8fO/SZlvGe+Ae00t54/L6kVUjuzosgQIOeuzI1C8ITt6o3Nd70yfX78jxGSviS+vv2whGofolgeHQSbDoTuNe3w4n/AIf9d6kUxsXFT09xuN+YDHW937/jvTseMT3Ltx2dkQk6/+gmjs2zQinlBIS7IbXTUPtJ77Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715643078; c=relaxed/simple;
	bh=edYEvfVF7LrKCEOZSZcW2VnvwSmiDi2QkoyU4leeWL4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGpCKcoY/w6Gln9pm+E5v3EZag0SfSBcqz1EyQLe43Y+miE4IpBPQ4AWaqsqI7iDxUDKEnBMUZBhktO1YpqkOtTJaM/UGIEFtBRsQoxgK5R6QHxGZsOE/jIO9TCXaZp7y4nz/vNz70f1ijAvblhNpKELP3DD+f82BYQUxZ9/W/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ4+eKX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EFC113CC;
	Mon, 13 May 2024 23:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715643077;
	bh=edYEvfVF7LrKCEOZSZcW2VnvwSmiDi2QkoyU4leeWL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJ4+eKX9Jjb5n009vEa+fw3qm93HTsbq6E/2kjaqWw2wukzg/halQAfNZEZXm/LE4
	 VseHIcoczFEhUFNJrX+hE4brEcaqhJYLF5QDeawrQXHzGtVSeWHqMAph2zfIoqyKzs
	 dOJA+Rc3OrJVxsqBTVfE67aPPpe9lMIgv3q46l/7C7ygJVD9GHoY5L6Ff+NHFHfw2i
	 EpUgZS3K/R4TIL0bsax/NTea+fsRH6i/BQKSVamsq7sDeOuVD37dm9gghM9OITGk7Y
	 MbBxbNA6+ZDp6bsz2N1nY5IAOc0jzEJb0dHK2wgUTlLTS0Qe7idImQezxoSFuJYfYW
	 r/H0ew9pGJ3Hg==
Date: Mon, 13 May 2024 16:31:14 -0700
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
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, "Christian
 =?UTF-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Pavel Begunkov
 <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe
 <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand
 <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v9 00/14] Device Memory TCP
Message-ID: <20240513163114.52b44f66@kernel.org>
In-Reply-To: <20240510232128.1105145-1-almasrymina@google.com>
References: <20240510232128.1105145-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 16:21:11 -0700 Mina Almasry wrote:
> Device Memory TCP

Sorry Mina, this is too big to apply during the merge window :(
-- 
pw-bot: defer

