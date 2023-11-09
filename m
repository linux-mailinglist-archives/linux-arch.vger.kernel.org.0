Return-Path: <linux-arch+bounces-81-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAE7E61A6
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 02:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AED41C209E3
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC707F8;
	Thu,  9 Nov 2023 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="twBcydj1"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929A7F2
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 01:00:44 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B3C2590
	for <linux-arch@vger.kernel.org>; Wed,  8 Nov 2023 17:00:44 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc2f17ab26so2448645ad.0
        for <linux-arch@vger.kernel.org>; Wed, 08 Nov 2023 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1699491643; x=1700096443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+m1/eec3BAI+VxQgeWP5nozlTdhs+GvhhRREFgPtnw=;
        b=twBcydj177gEe6trQmjXVoEAVUA814gQxanP2tNi0bC3WYu6GFBi1NTJRuGFMc7qcb
         N1KFTTsThKZvuYzaT5/e43BdLn98gA4KcYLDiodnOM9uamizS8mZ9pXr73tQHJjWEjHi
         g9H1P6xpegWWj9yuDLHtWitsfInUyguJwyoGEy8ZNIbkP0BgIllWYEhtXdtsjPAqaAV7
         5jjzjuj9NNgm7m2bXKd8/ghLRdWG1Lf80THlMHFiVTNR9MpuDFRZUIrpZDMmqvafM0jH
         rzsw88LY2cGiakpGyVwhgep1rMZP8RoXur38b63NkiS9x71ETQvVDbUGwbahhix27iXP
         W6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699491643; x=1700096443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+m1/eec3BAI+VxQgeWP5nozlTdhs+GvhhRREFgPtnw=;
        b=moOMsvPG4i2NZDYeHvuMPZrrUZ8lAHeixw8fjLMnGpa3q7UQJlu2EPoE8Jt4eVS7H1
         DLmbBGyBtdntkjyWLYG5IV9Jm3a9TbOFuKDlEtWT3AgP5AXptF2YYHvpOy8eobiNtNT3
         0Cg/yqtwR0P5YsFo5GLijswMqJ02jP41raOl3DIqQtGIsm2p9m6fWOR1xOVMNMXipzqz
         IuX83hRHUC2Kwzs+MEvtekul1yUguODgAGIwBHywHFfhEa6oYStBsaSSESrANSUwti+8
         yqp6jn3oIAi9Q4soSG0Zifynw9BtKgDANzIsS0Z5w9JbB+fV/+c4nZpQ1dkgOUtKS2sb
         kVVA==
X-Gm-Message-State: AOJu0YzpQULayGYbb+Bq4tpKa8lYimeaooSqvwkkNBG2aGOgc1puxqpD
	n1bTj28IYwcFXIeAQb8JdmIu3g==
X-Google-Smtp-Source: AGHT+IGqOk5pLGreahWyU5Tyhch5OGepp+ms2LPYRQxo1oPkx1W4LYvgzN77Bieh5CFVk1MoPdYbhQ==
X-Received: by 2002:a17:902:d2cf:b0:1cc:6acc:8fa4 with SMTP id n15-20020a170902d2cf00b001cc6acc8fa4mr4025647plc.32.1699491643400;
        Wed, 08 Nov 2023 17:00:43 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:887f])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b001b0358848b0sm2287468plp.161.2023.11.08.17.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 17:00:43 -0800 (PST)
Message-ID: <b1476f8e-1b4b-497a-9e80-aff679ca8b4b@davidwei.uk>
Date: Wed, 8 Nov 2023 17:00:39 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
Content-Language: en-GB
To: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
 <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023-11-07 14:55, David Ahern wrote:
> On 11/7/23 3:10 PM, Mina Almasry wrote:
>> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>>
>>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index eeeda849115c..1c351c138a5b 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>>  };
>>>>
>>>>  #ifdef CONFIG_DMA_SHARED_BUFFER
>>>> +struct page_pool_iov *
>>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>>
>>> netdev_{alloc,free}_dmabuf?
>>>
>>
>> Can do.
>>
>>> I say that because a dmabuf can be host memory, at least I am not aware
>>> of a restriction that a dmabuf is device memory.
>>>
>>
>> In my limited experience dma-buf is generally device memory, and
>> that's really its use case. CONFIG_UDMABUF is a driver that mocks
>> dma-buf with a memfd which I think is used for testing. But I can do
>> the rename, it's more clear anyway, I think.
> 
> config UDMABUF
>         bool "userspace dmabuf misc driver"
>         default n
>         depends on DMA_SHARED_BUFFER
>         depends on MEMFD_CREATE || COMPILE_TEST
>         help
>           A driver to let userspace turn memfd regions into dma-bufs.
>           Qemu can use this to create host dmabufs for guest framebuffers.
> 
> 
> Qemu is just a userspace process; it is no way a special one.
> 
> Treating host memory as a dmabuf should radically simplify the io_uring
> extension of this set. That the io_uring set needs to dive into
> page_pools is just wrong - complicating the design and code and pushing
> io_uring into a realm it does not need to be involved in.

I think our io_uring proposal will already be vastly simplified once we
rebase onto Kuba's page pool memory provider API. Using udmabuf means
depending on a driver designed for testing, vs io_uring's registered
buffers API that's been tried and tested.

I don't have an intuitive understanding of the trade offs yet, and would
need to try out udmabuf and compare vs say using our own page pool
memory provider.

> 
> Most (all?) of this patch set can work with any memory; only device
> memory is unreadable.
> 
> 

