Return-Path: <linux-arch+bounces-4699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806BF8FC0F8
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 02:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9058B2481F
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BED74409;
	Wed,  5 Jun 2024 00:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JcdyiTW3"
X-Original-To: linux-arch@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC13D6D;
	Wed,  5 Jun 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548767; cv=none; b=rueklj6qToe6W7NN4XzHxknqq1NjbIA/kl+lCods/CbBErJMpTWSqFNoFTBagnJdlaUhriVNAxq4bdlmdWzehJYhyqy8eD5MsFWuPpRbszRNanFFXurIqb53znroVLjUO/Ija6swEHISv2RqLcEk1QRNxfWNq+KH58HnxEgzKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548767; c=relaxed/simple;
	bh=oazLP4EwnwtllawJhyAlk4/fZjyXr7WsdQvrcbP4gqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOTQCxpf2mWufjo70ZYgqol645/0Mc4vdj6/v3Lh/SuPFiaGQpl3D2DFx5C3O88Xf51kZlkL67+NrCmGqOk2cEZZyX4meeLmbQCP1SQMUoimO8sjm1vP7CsvtEiMbaguWKp8p0RL/AuxtpvWJzB3BWqaGsJ1B9YppVnqB3prreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JcdyiTW3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9gO28Na5Or7X4vcdl0zpmmA5fJQ1WvuUB+1qpfVVnOc=; b=JcdyiTW3Sf1oOPzPXSGG4A/aQI
	WrKOAaIDGvv2yPHWxIHG9bpXlhSF04aVlo28aSx7pfIGBJe07oTz1j5n3BMr9xwV6BenDveB1ZG+I
	lvQQG0JnvATnP7QejGGclwEinZqkyj419Id1bNa88gtcy7vPcHzBA8yiRWYFrUGsp/m8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sEetB-00GrAt-5E; Wed, 05 Jun 2024 02:52:29 +0200
Date: Wed, 5 Jun 2024 02:52:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
Subject: Re: [PATCH net-next v10 05/14] netdev: netdevice devmem allocator
Message-ID: <cbf3e752-8f7e-4e74-a709-8b812bdc36c0@lunn.ch>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-6-almasrymina@google.com>
 <bea8b8bf1630309bb004f614e4a3c7f684a6acb6.camel@redhat.com>
 <20240604121551.07192993@gandalf.local.home>
 <20240604163158.GB21513@ziepe.ca>
 <20240604124243.66203a46@gandalf.local.home>
 <3be107ce-3d9f-4528-b9f7-1c9e38da0688@lunn.ch>
 <20240604202738.3aab6308@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604202738.3aab6308@gandalf.local.home>

> How is the compiler going to know which path is going to be taken the most?
> There's two main paths in the ring buffer logic. One when an event stays on
> the sub-buffer, the other when the event crosses over to a new sub buffer.
> As there's 100s of events that happen on the same sub-buffer for every one
> time there's a cross over, I optimized the paths that stayed on the
> sub-buffer, which caused the time for those events to go from 250ns down to
> 150 ns!. That's a 40% speed up.
> 
> I added the unlikely/likely and 'always_inline' and 'noinline' paths to
> make sure the "staying on the buffer" path was always the hot path, and
> keeping it tight in cache.
> 
> How is a compiler going to know that?

It might have some heuristics to try to guess unlikely/likely, but
that is not what we are talking about here.

How much difference did 'always_inline' and 'noinline' make? Hopefully
the likely is enough of a clue it should prefer to inline whatever is
in that branch, where as for the unlikely case it can do a function
call.

But compilers is not my thing, which is why i would reach out to the
compiler people and ask them, is it expected to get this wrong, could
it be made better?

   Andrew

