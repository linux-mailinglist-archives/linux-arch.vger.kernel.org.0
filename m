Return-Path: <linux-arch+bounces-2922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF687796E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 02:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B611F213FC
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 01:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8D7F8;
	Mon, 11 Mar 2024 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPm6Sx4E"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AFA10E3;
	Mon, 11 Mar 2024 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710119559; cv=none; b=PBgRMeTH3eE3HtmcUB//hIJjJubSogc2ZVWGYicHaFdRfr4JpCr8oSIma+yrrc4k3iTqcWvCbOZfKiQAz4XTLWsRLULu/8IF89KufRfoRMuQnAJVeVZ/HigZ7dMO30F4pkO7+HAyZkVXb6srHVEdthmIlHfdTW19hkuwWcCjR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710119559; c=relaxed/simple;
	bh=2z5jInwHvNUuGQ13fZ+9l+YxupANHQadDhz4Wpt4Yg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMaDHusuOG6qDO06CyVMw2Hohhh/ZhKvidGRBjK3tWhgbcrhVRNu+h6J1lyQKyY1Gtv3xjpCon9/qlyF3xj/BUe//bCqFTY3JBwEiB9/EsWSH/JPx0dyKhThdqGski8izbGoDMYdmvHCjJzeBpohVhWQkDWUxzeQhemEAii7L64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPm6Sx4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CBFC433C7;
	Mon, 11 Mar 2024 01:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710119558;
	bh=2z5jInwHvNUuGQ13fZ+9l+YxupANHQadDhz4Wpt4Yg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cPm6Sx4E1EG59Iov80OXl2MFAXOcYsH6sW5GBiEeM0WcaeXdKWeKnjLgnzkJAJNUQ
	 ZGzu+uinfXZiBrCQs/BnKum3xWBjuxiG2Jnz71jbsD0IMC436SUkVVtHUBc/15b5J5
	 FlPk3Ywx0H9l5f6XBzTHnrtsVcxrCsUls2TXOjJDboqFM5zle++N9DatBuzt45gQv9
	 A18j7hc9e2S5CULTkLup888zf+AZXZNNkNXEhSYF1+RpxOAoMtWrJsod25hXkO9GSU
	 RHXZrgsBmlzTI8CgfJbqud+ntqAvcBQ37IkpFwFwxWMNfwcwgLu6iaf5Hgq8eaTHuq
	 I4nNxU2JaTS7Q==
Message-ID: <9bd5ff0c-2f56-4fa5-9a78-f3b8981c970f@kernel.org>
Date: Sun, 10 Mar 2024 19:12:34 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Mina Almasry <almasrymina@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Jiri Olsa <jolsa@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-2-almasrymina@google.com>
 <54891f27-555a-4ed1-b92f-668813c18c37@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <54891f27-555a-4ed1-b92f-668813c18c37@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/24 4:47 PM, David Wei wrote:
> 
> I'm working to port bnxt over to using this API. What are your thoughts
> on maybe pulling this out and use bnxt to drive it?
> 

I would love to see a second nic implementation; this patch set and
overall design is driven by GVE limitations.


