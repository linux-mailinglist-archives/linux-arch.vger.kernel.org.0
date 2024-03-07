Return-Path: <linux-arch+bounces-2886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F55874EB7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 13:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A131C2216E
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 12:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622412A142;
	Thu,  7 Mar 2024 12:15:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC444129A7D;
	Thu,  7 Mar 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813739; cv=none; b=KPTA8dK7cCg52Bmpo5MmX+2VioQPz3kiPv+WhJu8tFCWRgsXL+BwiwKYFzO59ypyyTGwSI3Ip/Xnk7cxB/XSdQsJ0TcQS7N28uxpcg+qU1A5ewvzFk2MbbWKYCY4eBfw4O4JE637bhSlMaDnkq50c8nfDWd+fnW4SpmZKYVL3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813739; c=relaxed/simple;
	bh=33Uzy2N/rqj/7YQgQGuWOf/5Tv1toMJF0Qi0AcbhFw0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=daHia+g5WZ7eODuIVAll5m8QwdGKqk00OLE0IvF8P6SZV7ETbWPIs2RfpKSz6iT7ggoEThqt1pPvRqiq3lSg0uJPztCHDmqMQnoSFsMn4ChBBZ9SznujZovIg76PZ12yj/2cv0iSKnwXhoarG6SjrIUj7nymYXGgpU8EkHdlcF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Tr7Vw2yQsz1Q9QH;
	Thu,  7 Mar 2024 20:13:28 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C1EA14059C;
	Thu,  7 Mar 2024 20:15:27 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 20:15:26 +0800
Subject: Re: [RFC PATCH net-next v6 05/15] netdev: support binding dma-buf to
 netdevice
To: Mina Almasry <almasrymina@google.com>
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
 Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-6-almasrymina@google.com>
 <da42cea9-c169-599e-f087-d38c419e3dab@huawei.com>
 <CAHS8izM7GbvWHrH=h9q0oG0DMU649EjT1udNEW_8F-hGeC15EQ@mail.gmail.com>
 <aa892723-7396-998d-db06-166c28fba1e0@huawei.com>
 <CAHS8izNJFnKGn9nrJ3kRxGwhvjiDey_bfrxQNfsfj=S9hZR_UA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <76266a89-8ec1-6a4c-716b-da422f0b2cd5@huawei.com>
Date: Thu, 7 Mar 2024 20:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izNJFnKGn9nrJ3kRxGwhvjiDey_bfrxQNfsfj=S9hZR_UA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/3/7 6:10, Mina Almasry wrote:

...

>>>>> +static int netdev_restart_rx_queue(struct net_device *dev, int rxq_idx)
>>>>> +{
>>>>> +     void *new_mem;
>>>>> +     void *old_mem;
>>>>> +     int err;
>>>>> +
>>>>> +     if (!dev || !dev->netdev_ops)
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     if (!dev->netdev_ops->ndo_queue_stop ||
>>>>> +         !dev->netdev_ops->ndo_queue_mem_free ||
>>>>> +         !dev->netdev_ops->ndo_queue_mem_alloc ||
>>>>> +         !dev->netdev_ops->ndo_queue_start)
>>>>> +             return -EOPNOTSUPP;
>>>>> +
>>>>> +     new_mem = dev->netdev_ops->ndo_queue_mem_alloc(dev, rxq_idx);
>>>>> +     if (!new_mem)
>>>>> +             return -ENOMEM;
>>>>> +
>>>>> +     err = dev->netdev_ops->ndo_queue_stop(dev, rxq_idx, &old_mem);
>>>>> +     if (err)
>>>>> +             goto err_free_new_mem;
>>>>> +
>>>>> +     err = dev->netdev_ops->ndo_queue_start(dev, rxq_idx, new_mem);
>>>>> +     if (err)
>>>>> +             goto err_start_queue;
>>>>> +
>>>>> +     dev->netdev_ops->ndo_queue_mem_free(dev, old_mem);
>>>>> +
>>>>> +     return 0;
>>>>> +
>>>>> +err_start_queue:
>>>>> +     dev->netdev_ops->ndo_queue_start(dev, rxq_idx, old_mem);
>>>>
>>>> It might worth mentioning why queue start with old_mem will always
>>>> success here as the return value seems to be ignored here.
>>>>
>>>
>>> So the old queue, we stopped it, and if we fail to bring up the new
>>> queue, then we want to start the old queue back up to get the queue
>>> back to a workable state.
>>>
>>> I don't see what we can do to recover if restarting the old queue
>>> fails. Seems like it should be a requirement that the driver tries as
>>> much as possible to keep the old queue restartable.
>>
>> Is it possible that we may have the 'old_mem' leaking if the driver
>> fails to restart the old queue? how does the driver handle the
>> firmware cmd failure for ndo_queue_start()? it seems a little
>> tricky to implement it.
>>
> 
> I'm not sure what we can do to meaningfully recover from failure to
> restarting the old queue, except log it so the error is visible. In
> theory because we have not modifying any queue configurations
> restarting it would be straight forward, but since it's dealing with
> hardware then any failures are possible.

Yes, we may need to have a clear semantics of how should the driver
implement the above interface, for example if the driver should free
the memory when fail to start a queue or the driver should restart
the queue when fail to stop a queue? Otherwise we may have different
driver implementing different behavior.

From the disscusion you mentioned below, does it make senses to
modeling rdma subsystem by using create_queue/modify_queue/destroy_queue
semantics instead?

> 
>>>
>>> I can improve this by at least logging or warning if restarting the
>>> old queue fails.
>>
>> Also the semantics of the above function seems odd that it is not
>> only restarting rx queue, but also freeing and allocating memory
>> despite the name only suggests 'restart', I am a litte afraid that
>> it may conflict with future usecae when user only need the
>> 'restart' part, perhaps rename it to a more appropriate name.
>>
> 
> Oh, what we want here is just the 'restart' part. However, Jakub
> mandates that if you restart a queue (or a driver), you do it like
> this, hence the slightly more complicated implementation.
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20231106024413.2801438-13-almasrymina@google.com/#25590262
> https://lore.kernel.org/netdev/20230815171638.4c057dcd@kernel.org/

Thanks for the link.

I like david's idea of "a more generic design where H/W queues are created
and destroyed - e.g., queues unique to a process which makes the cleanup
so much easier." , but it seems it is a lot of work for networking to
implement that for now.

> 

