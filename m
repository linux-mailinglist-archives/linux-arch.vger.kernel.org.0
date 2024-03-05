Return-Path: <linux-arch+bounces-2808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304DD871F8E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB771C22A58
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA91E85944;
	Tue,  5 Mar 2024 12:54:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640B58AB6;
	Tue,  5 Mar 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643292; cv=none; b=WNjjBZ0cH6it0nAGwU79vaNbgOi9IgmfHVlh6af3v3aCHN4v992VQYqgf3lvK7bpTDst+vTNF3hoBAmX4ELjdcfM4XftLv6apQ7aWlvEq6JJ8TOc43yrfWiT428Yt9KDGC0NQvF66FyUu5kpp9ZX+1DGAltRANgh1kBTUkJT9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643292; c=relaxed/simple;
	bh=dBll0MMe1cd+COq57v39zRTivh0aNAY6WcRafFYM2J8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RvhzBhkAw8qz3BVDSHI+CLCGlmP1Keqk6FfQCNlG+VaX2YwffXxybJfgJ/yfzPC6eOz461gcPnvGDIjnvAXuHZqnFWZVf+GVHFUZ6DTchEhJkBQrxzDrM4f/kY3k9oFJ+B+toY0dxPizz5C2AWU1r/+uDSr8I/ND2nFNOl5PtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TpwVc6CY4zbcjb;
	Tue,  5 Mar 2024 20:54:00 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D491214037C;
	Tue,  5 Mar 2024 20:54:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 20:54:42 +0800
Subject: Re: [RFC PATCH net-next v6 00/15] Device Memory TCP
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard Henderson
	<richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann
	<arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Ahern <dsahern@kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, Pavel Begunkov <asml.silence@gmail.com>, David
 Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand
	<shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel
 Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6208950d-6453-e797-7fc3-1dcf15b49dbe@huawei.com>
Date: Tue, 5 Mar 2024 20:54:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305020153.2787423-1-almasrymina@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/5 10:01, Mina Almasry wrote:

...

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
> 

The last sentence seems to be suggesting the above 1 ns regresses is caused
by the static_branch_unlikely() checking?

