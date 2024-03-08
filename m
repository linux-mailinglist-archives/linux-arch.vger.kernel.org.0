Return-Path: <linux-arch+bounces-2896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F760875C1B
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 02:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE11F21CF1
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 01:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377222638;
	Fri,  8 Mar 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1e2eFrn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0533DF;
	Fri,  8 Mar 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862776; cv=none; b=UMG+ykFwgGYbsR4qguTy/F54US982m0hXmhF+s88QD+q+i3d0ku6yuljlIb6D4vznmHqnbbdR65tGl6I8ZiHsjIgmcgU6LRBtUccoYtd9fP2vXLBWjTUvli88shNoUt5Y1j+pDPEorVy/7Hyy9HZl1Mu9j0oLF38qWmymPrKtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862776; c=relaxed/simple;
	bh=fz2pz2qjIfAAtut6NhHBeh0SUMiiU7K6EGRFxYVj02A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVF4repEcA03REBRJAZEyhk/EPvPhJISYYRh6As9yAptSBPoSynXEelY44jnccHpbwELLRhXqru7ruUyO6EfNsEC5Kg8JlEoatokj66HiWUqsOzpc4tu3PD3yK+H4MiL8ziPnA3oTuevIGnUI4MMt0fF1Nr1rWrY+0kydzPhXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1e2eFrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C15C433C7;
	Fri,  8 Mar 2024 01:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709862775;
	bh=fz2pz2qjIfAAtut6NhHBeh0SUMiiU7K6EGRFxYVj02A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1e2eFrnn2oGzuVI3SS8F8y9zj4WESKfPCGRxrfE8ZJwdFzIUuvscskwKoFmi+DTe
	 UQmZ0KaIT3FF+FRpvXC6we5R6cqKVQ7PxIT27sMixkPliMu3Q10jSkbVbV5UEqldl7
	 g/9r/3K4E7HEUji3HbNPzbY8omvaOXtRxaoIHdESIZ07gj3Ebg3Tdiz+dxppi8+jVN
	 BX5lADSuUgx4Ca1OlmwBB9024w6TIVf/My/1+BI6NipJq3nAC/RvlOAv/pJv1Kh/oq
	 jrMd8QyNrvFBw/AxA8zJ5pfQk2+B6Nc/DvQ9ALIqVkGZAgwr5qSmd+ZDwfJUQwO1jV
	 eIx8mkvdJmylw==
Date: Thu, 7 Mar 2024 17:52:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
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
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 14/15] net: add devmem TCP documentation
Message-ID: <20240307175251.309837e1@kernel.org>
In-Reply-To: <20240305020153.2787423-15-almasrymina@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
	<20240305020153.2787423-15-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 18:01:49 -0800 Mina Almasry wrote:
> +Intro
> +=====
> +
> +Device memory TCP (devmem TCP) enables receiving data directly into device
> +memory (dmabuf). The feature is currently implemented for TCP sockets.
> +
> +
> +Opportunity
> +-----------
> +
> +A large amount of data transfers have device memory as the source and/or

s/amount/number/

> +destination. Accelerators drastically increased the volume of such transfers.

s/volume/prevalence/

> +Some examples include:
> +
> +- Distributed training, where ML accelerators, such as GPUs on different hosts,
> +  exchange data among them.

s/among them//

> +- Distributed raw block storage applications transfer large amounts of data with
> +  remote SSDs, much of this data does not require host processing.
> +
> +Today, the majority of the Device-to-Device data transfers the network are

"Today" won't age well.

> +implemented as the following low level operations: Device-to-Host copy,
> +Host-to-Host network transfer, and Host-to-Device copy.
> +
> +The implementation is suboptimal, especially for bulk data transfers, and can

/The implementation/The flow involving host copies/

> +put significant strains on system resources such as host memory bandwidth and
> +PCIe bandwidth.
> +
> +Devmem TCP optimizes this use case by implementing socket APIs that enable
> +the user to receive incoming network packets directly into device memory.

> +More Info
> +---------
> +
> +  slides, video
> +    https://netdevconf.org/0x17/sessions/talk/device-memory-tcp.html
> +
> +  patchset
> +    [RFC PATCH v3 00/12] Device Memory TCP
> +    https://lore.kernel.org/lkml/20231106024413.2801438-1-almasrymina@google.com/T/

Won't age well? :)

> +Interface
> +=========
> +
> +Example
> +-------
> +
> +tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> +the RX path of this API.
> +
> +NIC Setup
> +---------
> +
> +Header split, flow steering, & RSS are required features for devmem TCP.
> +
> +Header split is used to split incoming packets into a header buffer in host
> +memory, and a payload buffer in device memory.
> +
> +Flow steering & RSS are used to ensure that only flows targeting devmem land on
> +RX queue bound to devmem.
> +
> +Enable header split & flow steering:
> +
> +::

You can put the :: at the end of the text, IIRC, like this:

Enable header split & flow steering::

> +
> +	# enable header split (assuming priv-flag)
> +	ethtool --set-priv-flags eth1 enable-header-split on

Olek added the "set" in commit 50d73710715d ("ethtool: add SET for
TCP_DATA_SPLIT ringparam"), no need for the priv flag any more.

