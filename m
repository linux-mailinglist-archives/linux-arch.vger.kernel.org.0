Return-Path: <linux-arch+bounces-5176-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBF91B08B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 22:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D351C21998
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 20:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52A19EEA9;
	Thu, 27 Jun 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq2RCfGz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89897406F;
	Thu, 27 Jun 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520693; cv=none; b=oY6O0LnrlI2UXOI5dGXYscIUptKRo0ALZlHdRNgyVQJiQR+VzDizV1AULq2e2kBGj0wcNOs3XugwHNLpTW9wXgmxtBV5Fi2Q3HxGHIJFjiLIXafyb9B670nDpJwMju3VI2U7ku1mzgoN2ZJfaU4jWiqlYfuJLRtGV5UxWqD/YN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520693; c=relaxed/simple;
	bh=BVd54t8V4yKL8SKq4Rb7omF+EHGftWCggGNhkkhUTrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbYucVRPU3dOMTLhbDtk1WyWeSTspc90HohGizwGnfM7ODl/oBx3Vvjnwln6As2CAWGNC+J2Gpy+qhJnU1Ae677r6f3s8gSK05oGRxGbNL9aAkhvuVS2LXIMwXjU5O6w5Ds59lWqmh4uFIwjjS2EQbapbOt6ouie+MvC3t3kWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq2RCfGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3370FC2BBFC;
	Thu, 27 Jun 2024 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719520692;
	bh=BVd54t8V4yKL8SKq4Rb7omF+EHGftWCggGNhkkhUTrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aq2RCfGz4duksXUC/Ro09d4mdUrL2HO3rip3byDd+QuyDD8cNPr1eCL+3dY1DtY8e
	 uXjxU3NBu2WfTEiWoGyW+QTBc4FA0EHq1t0SW3573ctREq0SWP0yN7A+oA4EDP5X4x
	 XxtIIlpuOldYd/c4p2A30+1BW7YH6bCdXhsu4/kKCVxOJohr8TwYW9PDpbN+rY6u0r
	 g2qx1g8xEuf85sy1eN2YRz93lNEWUNUUFUd1/sbENqAK6gSKw88I//hM9sjDmh1C99
	 Mba2sR93tzi4TgGidxaGQrPcwZduqxOZDQ9TILxLEsgZNlbOpCM3nQ4D6VedAsGLBC
	 FRNkwQU0t/iBw==
Date: Thu, 27 Jun 2024 13:38:09 -0700
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
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin
 <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v14 13/13] selftests: add ncdevmem, netcat for
 devmem TCP
Message-ID: <20240627133809.0700722f@kernel.org>
In-Reply-To: <CAHS8izOd_yYNJ6+xv35XoCvF7MzqachPVrkQJbic8-h=T1Vg_A@mail.gmail.com>
References: <20240625195407.1922912-1-almasrymina@google.com>
	<20240625195407.1922912-14-almasrymina@google.com>
	<20240626150822.742eaf6a@kernel.org>
	<20240626174634.2adec19d@kernel.org>
	<CAHS8izOd_yYNJ6+xv35XoCvF7MzqachPVrkQJbic8-h=T1Vg_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 12:55:38 -0700 Mina Almasry wrote:
> `git clean -fdx && make  headers_install && make -C
> ./tools/testing/selftests/net` works
> 
> `git clean -fdx && make  headers_install && make -C
> ./tools/testing/selftests/net ncdevmem` doesn't work with this error:

Hm, I haven't tested this exact combination. Makefiles are fun!

I think in this case you're just hitting the built-in make rule,
you're not exercising our Makefile logic much. This should make 
it work:

diff --git a/tools/testing/selftests/lib.mk
b/tools/testing/selftests/lib.mk index 429535816dbd..a274ae8cd72b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -45,7 +45,7 @@ endif # LLVM
 
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
-       OUTPUT := $(shell pwd)
+       OUTPUT := .
        DEFAULT_INSTALL_HDR_PATH := 1
     endif
 endif

But it will probably break the makefile for others?

All our targets are defined (or magically redefined) as $(OUTPUT)/name
if you call make directly OUTPUT is not defined, so our rules would
mathc on /name, which obviously doesn't exist. Adding OUTPUT=. on
command line would also work (I think):

make -C ./tools/testing/selftests/net OUTPUT=. ncdevmem

Another option would be for OUTPUT to contain the trailing /, always,
to avoid the /name problem, but:

$ git grep '$(OUTPUT)/' -- tools/testing/selftests/ | wc -l 
414

so good luck changing that :(

Long story short what you're trying doesn't really appear to be
supported by kselftest makefile infra, so don't worry about it.

