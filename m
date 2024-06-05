Return-Path: <linux-arch+bounces-4698-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E3C8FC0CB
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A5BB26763
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F586FD0;
	Wed,  5 Jun 2024 00:27:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174417552;
	Wed,  5 Jun 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547264; cv=none; b=MWcfVAZ4n+u5XEkGbtkX4bt0zSHcZAekEvsYzTEBQBnjz97qmANH9Su9V5ZK5AEXDoo3CGFRCVDe+puYNex/5HX30OmHgbPkx5SPnMBLJqc8rXm2oFWe51AcE08CDUVo54uyZbWXjTWYjHPI+kJalp0S1S+agYQ6qr+i092ZHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547264; c=relaxed/simple;
	bh=4ioJ7jsTZe7TCII2oIQNctHCar1QWaLEso6N0VtfjuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MecI/+6KlnBZVdfTskfYl+KMczTNbj0JaVTsDLmPD9rtPeAM8ItLbqSXfcbQ1jVHEr05iO6QnIW/XhTfZSVrTyjsyNXxFZ0vWwt6Bp28vA9dztj73rb7Wn2CdNoxzObjwwP8CAsZgHLvDdrZgKrzdNC65Hqji7yuifvoYi9dpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC87EC2BBFC;
	Wed,  5 Jun 2024 00:27:37 +0000 (UTC)
Date: Tue, 4 Jun 2024 20:27:38 -0400
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
Message-ID: <20240604202738.3aab6308@gandalf.local.home>
In-Reply-To: <3be107ce-3d9f-4528-b9f7-1c9e38da0688@lunn.ch>
References: <20240530201616.1316526-1-almasrymina@google.com>
	<20240530201616.1316526-6-almasrymina@google.com>
	<bea8b8bf1630309bb004f614e4a3c7f684a6acb6.camel@redhat.com>
	<20240604121551.07192993@gandalf.local.home>
	<20240604163158.GB21513@ziepe.ca>
	<20240604124243.66203a46@gandalf.local.home>
	<3be107ce-3d9f-4528-b9f7-1c9e38da0688@lunn.ch>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Jun 2024 01:44:37 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Interesting, as I sped up the ftrace ring buffer by a substantial amount by
> > adding strategic __always_inline, noinline, likely() and unlikely()
> > throughout the code. It had to do with what was considered the fast path
> > and slow path, and not actually the size of the function. gcc got it
> > horribly wrong.  
> 
> And what did the compiler people say when you reported gcc was getting
> it wrong?
> 
> Our assumption is, the compiler is better than a human at deciding
> this. Or at least, a human who does not spend a long time profiling
> and tuning. If this assumption is not true, we probably should be
> trying to figure out why, and improving the compiler when
> possible. That will benefit everybody.
> 

How is the compiler going to know which path is going to be taken the most?
There's two main paths in the ring buffer logic. One when an event stays on
the sub-buffer, the other when the event crosses over to a new sub buffer.
As there's 100s of events that happen on the same sub-buffer for every one
time there's a cross over, I optimized the paths that stayed on the
sub-buffer, which caused the time for those events to go from 250ns down to
150 ns!. That's a 40% speed up.

I added the unlikely/likely and 'always_inline' and 'noinline' paths to
make sure the "staying on the buffer" path was always the hot path, and
keeping it tight in cache.

How is a compiler going to know that?

-- Steve

