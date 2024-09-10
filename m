Return-Path: <linux-arch+bounces-7177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A48973527
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1324C1F2471E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09019190499;
	Tue, 10 Sep 2024 10:44:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BA46444;
	Tue, 10 Sep 2024 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965098; cv=none; b=f6eTPSoq/hD6tfkwTr1X7WCnDipoHQWfdmtV7+ue9txRJ+QnQf3uo93r7tUpxrI4PYsH1hndNlHs+GI47cKtRuychri0Mi4xDzhMTF301PZghgPEOegMqdia3WsFAk/wzMcIIf95OsOw5cTrLe23TmRepmvVrOPaaKUrXc7qRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965098; c=relaxed/simple;
	bh=F8sISKqp3IEU8uMytKNoaGuZbOEzp2sNMpq+JwuhFk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bXaAl3vj0bYxyro30eMtw23Q5OWsK/b1uKsFlOFf+WftW4NJvViiEWPyAybVOrJU3g6MyjGOm086QRoGxKKThnYzjQ98U+JiCKwNuhxgZ91PhspCZHdp4g1WqdM8iOvv8oDwKe66DTNAbvU+uHqR9pG66wKYbB36O8MhK7G52Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X30gr3F0jz2Dc4S;
	Tue, 10 Sep 2024 18:44:24 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7AD5E1402E0;
	Tue, 10 Sep 2024 18:44:52 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 18:44:51 +0800
Message-ID: <95e6c282-1e4f-458b-9e40-9b626d64b3bd@huawei.com>
Date: Tue, 10 Sep 2024 18:44:51 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
To: Mina Almasry <almasrymina@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
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
 <42c202e6-8c4c-494f-8c28-17d66ed75880@huawei.com>
 <CAHS8izMX+9F1NngbPx6w7ikKR9TgPvm+jMwZ8168NJYhFC7sVQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAHS8izMX+9F1NngbPx6w7ikKR9TgPvm+jMwZ8168NJYhFC7sVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/10 0:54, Mina Almasry wrote:
> On Mon, Sep 9, 2024 at 4:21 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/9/9 13:43, Mina Almasry wrote:
>>
>>>
>>> Perf - page-pool benchmark:
>>> ---------------------------
>>>
>>> bench_page_pool_simple.ko tests with and without these changes:
>>> https://pastebin.com/raw/ncHDwAbn
>>>
>>> AFAIK the number that really matters in the perf tests is the
>>> 'tasklet_page_pool01_fast_path Per elem'. This one measures at about 8
>>> cycles without the changes but there is some 1 cycle noise in some
>>> results.
>>>
>>> With the patches this regresses to 9 cycles with the changes but there
>>> is 1 cycle noise occasionally running this test repeatedly.
>>>
>>> Lastly I tried disable the static_branch_unlikely() in
>>> netmem_is_net_iov() check. To my surprise disabling the
>>> static_branch_unlikely() check reduces the fast path back to 8 cycles,
>>> but the 1 cycle noise remains.
>>
>> Sorry for the late report, as I was adding a testing page_pool ko basing
>> on [1] to avoid introducing performance regression when fixing the bug in
>> [2].
>> I used it to test the performance impact of devmem patchset for page_pool
>> too, it seems there might be some noticable performance impact quite stably
>> for the below testcases, about 5%~16% performance degradation as below in
>> the arm64 system:
>>
> 
> Correct me if I'm wrong here, but on the surface here it seems that
> you're re-reporting a known issue. Consensus seems to be that it's a
> non-issue.
> 
> In v6 I reported that the bench_page_pool_simple.ko test reports a 1
> cycle regression with these patches, from 8->9 cycles. That is roughly
> consistent with the 5-15% you're reporting.

From the description above in the cover letter, I thought the performance
data using the out of tree testing ko is not stable enough to justify the
performance impact.

> 
> I root caused the reason for the regression to be the
> netmem_is_net_iov() check in the fast path. I removed this regression
> in v7 (see the change log) by conditionally compiling the check in
> that function.
> 
> In v8, Pavel/Jens/David pushed back on the ifdef check. See this
> entire thread, but in particular this response from Jens:

It seemed the main objection is about how to enable this feature
for the io_uring?

And it seemed that you had added the CONFIG_NET_DEVMEM for this
devmem thing, why not use it for that?

> 
> https://lore.kernel.org/lkml/11f52113-7b67-4b45-ba1d-29b070050cec@kernel.dk/
> 
> Seems consensus that it's 'not really worth it in this scenario'.

I was only reading through the above thread, it didn't seemed to
reach to consensus as Jesper pointed out the performance impact
for the XDP DROP case in the same thread.

https://lore.kernel.org/lkml/779b9542-4170-483a-af54-ca0dd471f774@kernel.org/

> 

