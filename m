Return-Path: <linux-arch+bounces-7153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDE9716A6
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353971C2307F
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9611B652C;
	Mon,  9 Sep 2024 11:21:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA81B6521;
	Mon,  9 Sep 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880879; cv=none; b=WIlk2qmlacjvxjsTBasZjLd38TEjj0MH8WEWoDkInhQ61/L38l/oc/qqM8XbuK4u7ll97VATLNlGb+O7/A+tN8Lrvgj5X+BHRS/HlKFjQuzp41RmetOJCcGkbHJ4Q2cPn62Dwr8i4obv418EASIckD08nAc4qaSKPIRpMjjLR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880879; c=relaxed/simple;
	bh=5iq6aZDboxm6ZGBWINtqBy3Uim6XKZaYNeKYLJYVdrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+QWNY54DCqy2zPPoRVSSJkjj/8uwEAgnKXVw2dSQREBsXaWSt9Hw0Ja/hQCu7pfykQLvUYrMxnddHws8bYTwatmDsPArnoyA0m4xW2lxXO4i7QM+l8X8Nxa3GtVk9YDMHLdviWi5ihRH19TvZFqUOCeOIF3Xmyqm2WTVi/ZerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X2PXm2Sy2z1xv0C;
	Mon,  9 Sep 2024 19:21:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EE4911400DC;
	Mon,  9 Sep 2024 19:21:13 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Sep 2024 19:21:13 +0800
Message-ID: <42c202e6-8c4c-494f-8c28-17d66ed75880@huawei.com>
Date: Mon, 9 Sep 2024 19:21:05 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
	<arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon
	<jonathan.lemon@gmail.com>, Shuah Khan <shuah@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Pavel Begunkov
	<asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe
	<jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
References: <20240909054318.1809580-1-almasrymina@google.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20240909054318.1809580-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/9 13:43, Mina Almasry wrote:

> 
> Perf - page-pool benchmark:
> ---------------------------
> 
> bench_page_pool_simple.ko tests with and without these changes:
> https://pastebin.com/raw/ncHDwAbn
> 
> AFAIK the number that really matters in the perf tests is the
> 'tasklet_page_pool01_fast_path Per elem'. This one measures at about 8
> cycles without the changes but there is some 1 cycle noise in some
> results.
> 
> With the patches this regresses to 9 cycles with the changes but there
> is 1 cycle noise occasionally running this test repeatedly.
> 
> Lastly I tried disable the static_branch_unlikely() in
> netmem_is_net_iov() check. To my surprise disabling the
> static_branch_unlikely() check reduces the fast path back to 8 cycles,
> but the 1 cycle noise remains.

Sorry for the late report, as I was adding a testing page_pool ko basing
on [1] to avoid introducing performance regression when fixing the bug in
[2].
I used it to test the performance impact of devmem patchset for page_pool
too, it seems there might be some noticable performance impact quite stably
for the below testcases, about 5%~16% performance degradation as below in
the arm64 system:

Before the devmem patchset:
 Performance counter stats for 'insmod ./page_pool_test.ko test_push_cpu=16 test_pop_cpu=16 nr_test=100000000 test_napi=1' (100 runs):

         17.167561      task-clock (msec)         #    0.003 CPUs utilized            ( +-  0.40% )
                 8      context-switches          #    0.474 K/sec                    ( +-  0.65% )
                 0      cpu-migrations            #    0.001 K/sec                    ( +-100.00% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.13% )
          44576552      cycles                    #    2.597 GHz                      ( +-  0.40% )
          59627412      instructions              #    1.34  insn per cycle           ( +-  0.03% )
          14370325      branches                  #  837.063 M/sec                    ( +-  0.02% )
             21902      branch-misses             #    0.15% of all branches          ( +-  0.27% )

       6.818873600 seconds time elapsed                                          ( +-  0.02% )

 Performance counter stats for 'insmod ./page_pool_test.ko test_push_cpu=16 test_pop_cpu=16 nr_test=100000000 test_napi=1 test_direct=1' (100 runs):

         17.595423      task-clock (msec)         #    0.004 CPUs utilized            ( +-  0.01% )
                 8      context-switches          #    0.460 K/sec                    ( +-  0.50% )
                 0      cpu-migrations            #    0.000 K/sec
                84      page-faults               #    0.005 M/sec                    ( +-  0.15% )
          45693020      cycles                    #    2.597 GHz                      ( +-  0.01% )
          59676212      instructions              #    1.31  insn per cycle           ( +-  0.00% )
          14385384      branches                  #  817.564 M/sec                    ( +-  0.00% )
             21786      branch-misses             #    0.15% of all branches          ( +-  0.14% )

       4.098627802 seconds time elapsed                                          ( +-  0.11% )

After the devmem patchset:
Performance counter stats for 'insmod ./page_pool_test.ko test_push_cpu=16 test_pop_cpu=16 nr_test=100000000 test_napi=1' (100 runs):

         17.047973      task-clock (msec)         #    0.002 CPUs utilized            ( +-  0.39% )
                 8      context-switches          #    0.488 K/sec                    ( +-  0.82% )
                 0      cpu-migrations            #    0.001 K/sec                    ( +- 70.35% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.12% )
          44269558      cycles                    #    2.597 GHz                      ( +-  0.39% )
          59594383      instructions              #    1.35  insn per cycle           ( +-  0.02% )
          14362599      branches                  #  842.481 M/sec                    ( +-  0.02% )
             21949      branch-misses             #    0.15% of all branches          ( +-  0.25% )

       7.964890303 seconds time elapsed                                          ( +-  0.16% )

 Performance counter stats for 'insmod ./page_pool_test.ko test_push_cpu=16 test_pop_cpu=16 nr_test=100000000 test_napi=1 test_direct=1' (100 runs):

         17.660975      task-clock (msec)         #    0.004 CPUs utilized            ( +-  0.02% )
                 8      context-switches          #    0.458 K/sec                    ( +-  0.57% )
                 0      cpu-migrations            #    0.003 K/sec                    ( +- 43.81% )
                84      page-faults               #    0.005 M/sec                    ( +-  0.17% )
          45862652      cycles                    #    2.597 GHz                      ( +-  0.02% )
          59764866      instructions              #    1.30  insn per cycle           ( +-  0.01% )
          14404323      branches                  #  815.602 M/sec                    ( +-  0.01% )
             21826      branch-misses             #    0.15% of all branches          ( +-  0.19% )

       4.304644609 seconds time elapsed                                          ( +-  0.75% )

1. https://lore.kernel.org/all/20240906073646.2930809-2-linyunsheng@huawei.com/
2. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

> 


