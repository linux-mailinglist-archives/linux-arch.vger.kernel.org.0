Return-Path: <linux-arch+bounces-5177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05A91B0D3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCDA1C24C9E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 20:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9726D7406F;
	Thu, 27 Jun 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm14q7G0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948219F49C;
	Thu, 27 Jun 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719521263; cv=none; b=F6KYTp9qln4e2C9yZ7+Htv2tNwe9hdGzxMo7aMM0wlTAgOkhlp0XfTr/R7mfLUkhfYMZApKDeM9F4E/CHLkGYQGw59bEFH7mUfsQlHP0PWuND1xGupX3m6Iec0UjYkEYBK7B+ZP1DRdqqMrGKqVHYFqWdaw6EDTW8WSZnnuMIAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719521263; c=relaxed/simple;
	bh=A5AMW+ZLMpX4csf8vnGmP52U32Ex4ZiXhPpAfEuGJIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChNBTvjtJNeBD8/HgEQmU3kwoU/Jwu2TbQMoMIdL594Dpgz+E1Ov4gCElmWBbL/uD1i55IgkwXrq6viT+dYbvWuCbmNGVo+vYKYYLCJ+mPoZ3Is/in5kFwtRRgnXdcuce4BlfWkThbz0W0sxNYR4kjUsnhyPYk+1wtCnXeF1Bwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm14q7G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8520C2BBFC;
	Thu, 27 Jun 2024 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719521262;
	bh=A5AMW+ZLMpX4csf8vnGmP52U32Ex4ZiXhPpAfEuGJIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm14q7G0XfP2HRyb1ZONJ+pqWBWPdhH2d6IjA0ofu+ehRYg/250v2wrmD+hEAIzhy
	 5caUG+fhduRYCsICV5ZrbBJAXKlcmtzxiOCz6jFU00UwMVMtD6dbVR0LU5kxOr3Vzi
	 0cAbW2JKPpLqSba16PMnQX/dcfAOoGDpmPAXuSdllZi6nWn1C7I2SU1ch36qi0pxGU
	 IihY3N5vgcgKBWatl6HEJmjhiMyCz8n3KjAwTl+PBG+9aUmYsI19ix1s++aG1UBGv+
	 aAFQxni9Alv0KyIBRf2yCiEWUthS2Fyw4DdcUmhxlFEm6zWfMYW2ck/kevCRcJ1ha3
	 waS1l0dqJcZJQ==
Date: Thu, 27 Jun 2024 13:47:38 -0700
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
Message-ID: <20240627134738.163f97e3@kernel.org>
In-Reply-To: <CAHS8izNBB3+axWFR6cQChAawu194UqzVZ+oZp=c+H5TD4Nd8Zw@mail.gmail.com>
References: <20240625195407.1922912-1-almasrymina@google.com>
	<20240625195407.1922912-14-almasrymina@google.com>
	<20240626150822.742eaf6a@kernel.org>
	<20240626174634.2adec19d@kernel.org>
	<CAHS8izOd_yYNJ6+xv35XoCvF7MzqachPVrkQJbic8-h=T1Vg_A@mail.gmail.com>
	<CAHS8izNBB3+axWFR6cQChAawu194UqzVZ+oZp=c+H5TD4Nd8Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 13:36:57 -0700 Mina Almasry wrote:
> `make -C ./tools/testing/selftests/net TARGETS=ncdevmem`, which works.

AFAIU the most supported incantation would have to be something rather
insane, like:

make -C tools/testing/selftests TARGETS=net TEST_GEN_PROGS="$(pwd)/tools/testing/selftests/net/tls" TEST_GEN_FILES=""

but yes, don't worry.

