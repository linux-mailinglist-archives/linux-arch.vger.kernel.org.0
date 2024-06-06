Return-Path: <linux-arch+bounces-4722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7668FDC3B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 03:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975091C22EE0
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2024 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979D13FEE;
	Thu,  6 Jun 2024 01:43:36 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83BEEDB;
	Thu,  6 Jun 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638215; cv=none; b=bef72ZMolWjS1exCy6K7USv+Cg1WlOfniXz5PEYOLozAk/owXfflb1PizaGpP2cgmi+LJYAuaEhd49gK6L87Xopf0oylOndDP9rJH0t+8e6VS/jX1mOtd9qcKwgDBc6Ep4WUiBdg61pep9tE770B/BT3GevwMJlPgGyX4ZHpa1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638215; c=relaxed/simple;
	bh=njaB7xwtRqM5zOvkd98x7fcmkQz3EohBYZ74D1OJmrE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag59Kyqhh0Y0qvsTi7wR/n1DIwtS8oktj4g4CKKPWJa6NGaUHRaLDahdGgk/5r4r1sV4HTMQ9jbwToM2KOATid75U+jNZZC2aub7SXDnRYDS8En2wBPv3oO3ukKof5yJ936xqStuI21cA9eHO1M5fHScDAs8h3YXgpx4Z/CS6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A6C3277B;
	Thu,  6 Jun 2024 01:43:28 +0000 (UTC)
Date: Wed, 5 Jun 2024 21:43:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Paolo Abeni <pabeni@redhat.com>, Mina
 Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Pavel Begunkov
 <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v10 05/14] netdev: netdevice devmem allocator
Message-ID: <20240605214331.34d9583e@gandalf.local.home>
In-Reply-To: <cbf3e752-8f7e-4e74-a709-8b812bdc36c0@lunn.ch>
References: <20240530201616.1316526-1-almasrymina@google.com>
	<20240530201616.1316526-6-almasrymina@google.com>
	<bea8b8bf1630309bb004f614e4a3c7f684a6acb6.camel@redhat.com>
	<20240604121551.07192993@gandalf.local.home>
	<20240604163158.GB21513@ziepe.ca>
	<20240604124243.66203a46@gandalf.local.home>
	<3be107ce-3d9f-4528-b9f7-1c9e38da0688@lunn.ch>
	<20240604202738.3aab6308@gandalf.local.home>
	<cbf3e752-8f7e-4e74-a709-8b812bdc36c0@lunn.ch>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 02:52:29 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > How is a compiler going to know that?  
> 
> It might have some heuristics to try to guess unlikely/likely, but
> that is not what we are talking about here.
> 
> How much difference did 'always_inline' and 'noinline' make? Hopefully
> the likely is enough of a clue it should prefer to inline whatever is
> in that branch, where as for the unlikely case it can do a function
> call.

Perhaps, but one of the issues was that I have lots of small functions that
are used all over the place, and gcc tends to change them to function
calls, instead of duplicating them. I did this analysis back in 2016, so
maybe it became better.

> 
> But compilers is not my thing, which is why i would reach out to the
> compiler people and ask them, is it expected to get this wrong, could
> it be made better?

Well, I actually do work with the compiler folks, and we are actually
trying to get a session at GNU Cauldron where Linux kernel folks can talk
with the gcc compiler folks.

I've stared at so many objdump outputs, that I can now pretty much see the
assembly that my C code makes ;-)

-- Steve

