Return-Path: <linux-arch+bounces-3110-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151058875A9
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E6F1F23CD2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 23:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AF182895;
	Fri, 22 Mar 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka5PHCyY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225A7EF05;
	Fri, 22 Mar 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149588; cv=none; b=a2h41iclxISNtDykq63G75cGAjlPziiNcrggb6+v2qlIEi29BkIMEoJwODhxjqvxXZw037Tk8RPJxJPZAX1VQjvW3QCAI4MEzE86qgMfQ1ofgWRHAZduLJOyE4umIFLiaiEsZnoWOsxax9Rw/3Q2GJgFLo2zcwM8YsoAzbxicSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149588; c=relaxed/simple;
	bh=msieq1rlX+OhvWYoM0YV5KS97Dsg2PJYaBtuHVmZvcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7Z0zjKFbLW2twVBovyLEITwGs2kEFiBvyAVEAKpsdXtE/I5dwwEkED+9gN5c8MvbeekxI9f4GDl8iy4RSUVHlny9rKMbj3kPdBIDa5rW7SR6qTyZQZ5UGuLmxK53ukuIli31AFhVyIug2TA6Jy/HxH2fbsqXU67llLohuOZwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka5PHCyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F27C433C7;
	Fri, 22 Mar 2024 23:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711149587;
	bh=msieq1rlX+OhvWYoM0YV5KS97Dsg2PJYaBtuHVmZvcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ka5PHCyYmoZX9PsvxUAGJqdDBExkTkresHF1kC0nKcGUkpNWTtXfCM9eM3lON00E/
	 sdTUglbJIwNhSuRIDCc+Shrxp7Q7F8OSC60m4cCVgaPGJWVHsM13+iCe/YoHIFFgiu
	 5HybDp8YS06v2Xztbb1h0oBMyxoqE2gUndhvBCAbY26U2oBUOD1EZxE7LZ38fBL/QI
	 5JZ0BUBtxg5FufRT6Zts8zD6NNC0atF7skifKgwBOdLblk5mTaX0LRELnaXdtdEHfX
	 1o+GQ6VMkk+C/AzTNXltKD4XdDE8tCJ68h7rFM9MN2K/6Z5mQBQ5/GwiPbhToKc2vD
	 QsSjoQ81Meb1g==
Date: Fri, 22 Mar 2024 16:19:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Wei <dw@davidwei.uk>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
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
 Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, Shailend
 Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Message-ID: <20240322161944.4eba02b6@kernel.org>
In-Reply-To: <CAHS8izMT1Smz6UWu2uwAQRqgZPU7jTfS3GKiA_sDw9KLqoP-JA@mail.gmail.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
	<20240305020153.2787423-3-almasrymina@google.com>
	<ZfegzB341oNc_Ocz@infradead.org>
	<b938514c-61cc-41e6-b592-1003b8deccae@davidwei.uk>
	<ZfjMopBl27-7asBc@infradead.org>
	<CAHS8izMT1Smz6UWu2uwAQRqgZPU7jTfS3GKiA_sDw9KLqoP-JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 10:40:26 -0700 Mina Almasry wrote:
> Other designs for this hugepage use case are possible, I'm just
> describing Jakub's idea for it as a potential use-case for these
> hooks. 

I made it ops because I had 4 different implementations with different
recycling algorithms. I think it's a fairly reasonable piece of code.

