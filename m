Return-Path: <linux-arch+bounces-3196-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FB88C285
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 13:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13B1B20FB1
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 12:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3F6AF85;
	Tue, 26 Mar 2024 12:47:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826D139E;
	Tue, 26 Mar 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457245; cv=none; b=IBTf+jFr+Ryz/oWCtPW+jwPzqOtRqqzL3t+Hby9L56GTsbtUXyk8J6rmEIkyS74tGB6jhSByQaeG83hz8efzzJnTJUqYuZTxeOtWxQhVRAupG+ihckYmZK50kkpSGLeIheqyZvzwC0otJuc+tftsxAgvO6NAkvc5SqJHQHJaKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457245; c=relaxed/simple;
	bh=sGJsi5QL5OEY3rakPIBQalfrmkZhP62VUd/1rO/Tex0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DfJ3VN04r+4INdHxV48V0lQz7d8EB/2PUJWx4xT/AyraDzO1NeWNm5TTs4gNneBDn5ZyU0L1WgouB7fI+dbSciSGO++epSeV5V4pkSLMGKO2QxZBCzrx3syGdYVbPsKWz5GEmA2DiywhOEv3/abWddIsQNVDlfidgA0bjAM2jq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V3qJ843l4z2BhYv;
	Tue, 26 Mar 2024 20:44:40 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E2C9140120;
	Tue, 26 Mar 2024 20:47:19 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 20:47:18 +0800
Subject: Re: [RFC PATCH net-next v6 00/15] Device Memory TCP
To: Mina Almasry <almasrymina@google.com>, YiFei Zhu <zhuyifei@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Richard
 Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky
	<ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
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
 <6208950d-6453-e797-7fc3-1dcf15b49dbe@huawei.com>
 <CAHS8izMwTRyqUS0iRtErfAqDVsXRia5Ajx9PRK3vcfo8utJoUA@mail.gmail.com>
 <CAHS8izPR+SioMKNv3=2ajK=GGOE26BTaxOMykHJfjttqYjx1wQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ca9ab650-3f77-509c-7a29-6d7dd775b6d1@huawei.com>
Date: Tue, 26 Mar 2024 20:47:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izPR+SioMKNv3=2ajK=GGOE26BTaxOMykHJfjttqYjx1wQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/26 8:28, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 11:38 AM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Tue, Mar 5, 2024 at 4:54 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>
>>> On 2024/3/5 10:01, Mina Almasry wrote:
>>>
>>> ...
>>>
>>>>
>>>> Perf - page-pool benchmark:
>>>> ---------------------------
>>>>
>>>> bench_page_pool_simple.ko tests with and without these changes:
>>>> https://pastebin.com/raw/ncHDwAbn
>>>>
>>>> AFAIK the number that really matters in the perf tests is the
>>>> 'tasklet_page_pool01_fast_path Per elem'. This one measures at about 8
>>>> cycles without the changes but there is some 1 cycle noise in some
>>>> results.
>>>>
>>>> With the patches this regresses to 9 cycles with the changes but there
>>>> is 1 cycle noise occasionally running this test repeatedly.
>>>>
>>>> Lastly I tried disable the static_branch_unlikely() in
>>>> netmem_is_net_iov() check. To my surprise disabling the
>>>> static_branch_unlikely() check reduces the fast path back to 8 cycles,
>>>> but the 1 cycle noise remains.
>>>>
>>>
>>> The last sentence seems to be suggesting the above 1 ns regresses is caused
>>> by the static_branch_unlikely() checking?
>>
>> Note it's not a 1ns regression, it's looks like maybe a 1 cycle
>> regression (slightly less than 1ns if I'm reading the output of the
>> test correctly):
>>
>> # clean net-next
>> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 8 cycles(tsc)
>> 2.993 ns (step:0)
>>
>> # with patches
>> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 9 cycles(tsc)
>> 3.679 ns (step:0)
>>
>> # with patches and with diff that disables static branching:
>> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 8 cycles(tsc)
>> 3.248 ns (step:0)
>>
>> I do see noise in the test results between run and run, and any
>> regression (if any) is slightly obfuscated by the noise, so it's a bit
>> hard to make confident statements. So far it looks like a ~0.25ns
>> regression without static branch and about ~0.65ns with static branch.
>>
>> Honestly when I saw all 3 results were within some noise I did not
>> investigate more, but if this looks concerning to you I can dig
>> further. I likely need to gather a few test runs to filter out the
>> noise and maybe investigate the assembly my compiler is generating to
>> maybe narrow down what changes there.
>>
> 
> I did some more investigation here to gather more data to filter out
> the noise, and recorded the summary here:
> 
> https://pastebin.com/raw/v5dYRg8L
> 
> Long story short, the page_pool benchmark results are consistent with
> some outlier noise results that I'm discounting here. Currently
> page_pool fast path is at 8 cycles
> 
> [ 2115.724510] time_bench: Type:tasklet_page_pool01_fast_path Per
> elem: 8 cycles(tsc) 3.187 ns (step:0) - (measurement period
> time:0.031870585 sec time_interval:31870585) - (invoke count:10000000
> tsc_interval:86043192)
> 
> and with this patch series it degrades to 10 cycles, or about a 0.7ns
> degradation or so:

Even if the absolute value for the overhead is small, we seems have a
degradation of about 20% for tasklet_page_pool01_fast_path testcase,
which seems scary.

I am assuming that every page is recyclable for tasklet_page_pool01_fast_path
testcase, and that code path matters for page_pool, it would be good to
remove any additional checking for that code path.

And we already have pool->has_init_callback checking when we have to use
a new page, it may make sense to refactor that to share the same checking
for provider to avoid the overhead as much as possible.

Also, I am not sure if it really matter that much, as with the introducing
of netmem_is_net_iov() checking spreading in the networking, the overhead
might add up for other case too.

> 
> [  498.226127] time_bench: Type:tasklet_page_pool01_fast_path Per
> elem: 10 cycles(tsc) 3.944 ns (step:0) - (measurement period
> time:0.039442539 sec time_interval:39442539) - (invoke count:10000000
> tsc_interval:106485268)
> 
> I took the time to dig into where the degradation comes from, and to
> my surprise we can shave off 1 cycle in perf by removing the
> static_branch_unlikely check in netmem_is_net_iov() like so:
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index fe354d11a421..2b4310ac1115 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -122,8 +122,7 @@ typedef unsigned long __bitwise netmem_ref;
>  static inline bool netmem_is_net_iov(const netmem_ref netmem)
>  {
>  #ifdef CONFIG_PAGE_POOL
> -       return static_branch_unlikely(&page_pool_mem_providers) &&
> -              (__force unsigned long)netmem & NET_IOV;
> +       return (__force unsigned long)netmem & NET_IOV;
>  #else
>         return false;
>  #endif
> 
> With this change, the fast path is 9 cycles, only  a 1 cycle (~0.35ns)
> regression:
> 
> [  199.184429] time_bench: Type:tasklet_page_pool01_fast_path Per
> elem: 9 cycles(tsc) 3.552 ns (step:0) - (measurement period
> time:0.035524013 sec time_interval:35524013) - (invoke count:10000000
> tsc_interval:95907775)
> 
> I did some digging with YiFei on why the static_branch_unlikely
> appears to be causing a 1 cycle regression, but could not get an
> answer that makes sense. The # of instructions in
> page_pool_return_page() with the static_branch_unlikely and without is
> about the same in the compiled .o file, and my understanding is that
> static_branch will cause code re-writing anyway so looking at the
> compiled code may not be representative.
> 
> Worthy of note is that I get ~95% line rate of devmem TCP regardless
> of the static_branch_unlikely() or not, so impact of the static_branch
> is not large enough to be measurable end-to-end. I'm thinking I want
> to drop the static_branch_unlikely() in the next RFC since it doesn't
> improve the end-to-end throughput number and is resulting in a
> measurable improvement in the page pool benchmark.
> 

