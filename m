Return-Path: <linux-arch+bounces-219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092937EB488
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 17:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765711F2534E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Nov 2023 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB241A94;
	Tue, 14 Nov 2023 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiko082U"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D164341A8E;
	Tue, 14 Nov 2023 16:11:06 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486BB12C;
	Tue, 14 Nov 2023 08:11:05 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66cfd35f595so29861386d6.2;
        Tue, 14 Nov 2023 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699978264; x=1700583064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WcBBKnTEqaoj3LxtGCYhc7t/cWobqHG+KSslQabs03I=;
        b=jiko082Ua1lfJDUQiLyoKwfG4+tg/Zq2/lpZ0rN+zmUtHB+nhwDjwiisusEiHMiHeF
         JzQz7qTgeVzIorGtR1fv+qZHdXiDmVpR0WOYFhWEV5XfwwRNSaPBFXeQZDQKCSKVAS21
         KdROydjR/E38ZRACuls+YVdof3UVbl0YtkWV0w0WL86FA3j/axlorSIAVxf9WnHfHch1
         J9xllmqzbDG1IZyMHHlujzYFaqjmUJnJZiVnFxuRUDrOpb93fJugSG9dG70mbUXQPDHf
         5HZYEdWSn6dF+av2EHeemNH+cdhs7oESWuJhEF0BBmNGb/FFiWFU+UNpRycXYxnxn36z
         I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978264; x=1700583064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcBBKnTEqaoj3LxtGCYhc7t/cWobqHG+KSslQabs03I=;
        b=ZbwkeihKhLbBIuKCgy8cPLk+ePiOqBKInOr0oG09XpWJxL10imCfLS0Qqmz3/Dwcby
         HM3kja1Cy9WI+4xgWbF0qMlzMwx1D76HsNWXn92cWtv2gk7qfqsuRZk67VWzgHc4Ibel
         jMsCFUIr8mcJH87lC8hoA/W0WQUZjzQOH/SAZwikFBTDA7hLzwZCy2I0d+DYzMAx+C8T
         kT2A+ei9sF++h40jExsy7DKRG5TuB6oScuNqlv96OCsyx2idkXj9bXQSJuBLQy/dGuxf
         XnVtMoX61T1KByCd92f7gDS+zqnI/OXi/aa7EJPUko9HOAFWPCCM7tQopKZtJcR85uTg
         Ie4w==
X-Gm-Message-State: AOJu0Yz1XCrys4BFIIpFNrY7TKec8m1IWEehhPNnXFiuB3y1rJfnmiQd
	ZZaQeXlVH17oipcAwbpOeEU=
X-Google-Smtp-Source: AGHT+IFP/S3WR7/gOKNC8Du/goDp8eEHlLIGAtwXreEQAWZa6gXfFFZ7r8yADmexKAwCka48pB7dfg==
X-Received: by 2002:a05:6214:1245:b0:66d:6af7:4571 with SMTP id r5-20020a056214124500b0066d6af74571mr4183692qvv.17.1699978264358;
        Tue, 14 Nov 2023 08:11:04 -0800 (PST)
Received: from [172.25.81.254] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id g1-20020a0cf841000000b00656329bb3b1sm3023598qvo.10.2023.11.14.08.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 08:11:03 -0800 (PST)
Message-ID: <2aa9c139-eee8-c707-6e62-5415c26c2a1a@gmail.com>
Date: Tue, 14 Nov 2023 16:09:51 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/12] netdev: netdevice devmem allocator
To: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>,
 David Wei <dw@davidwei.uk>
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
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-6-almasrymina@google.com>
 <3b0d612c-e33b-48aa-a861-fbb042572fc9@kernel.org>
 <CAHS8izOHYx+oYnzksUDrK1S0+6CdMJmirApntP5W862yFumezw@mail.gmail.com>
 <a5b95e6b-8716-4e2e-9183-959b754b5b5e@kernel.org>
 <CAHS8izMKDOw5_y2MLRfuJHs=ai+sZ6GF7Rg1NuR_JqONg-5u5Q@mail.gmail.com>
 <3687e70e-29e6-34af-c943-8c0830ff92b8@gmail.com>
 <f59c200f-4659-4c71-8c83-4457d0b08fe1@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <f59c200f-4659-4c71-8c83-4457d0b08fe1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/23 17:19, David Ahern wrote:
> On 11/10/23 7:26 AM, Pavel Begunkov wrote:
>> On 11/7/23 23:03, Mina Almasry wrote:
>>> On Tue, Nov 7, 2023 at 2:55 PM David Ahern <dsahern@kernel.org> wrote:
>>>>
>>>> On 11/7/23 3:10 PM, Mina Almasry wrote:
>>>>> On Mon, Nov 6, 2023 at 3:44 PM David Ahern <dsahern@kernel.org> wrote:
>>>>>>
>>>>>> On 11/5/23 7:44 PM, Mina Almasry wrote:
>>>>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>>>>> index eeeda849115c..1c351c138a5b 100644
>>>>>>> --- a/include/linux/netdevice.h
>>>>>>> +++ b/include/linux/netdevice.h
>>>>>>> @@ -843,6 +843,9 @@ struct netdev_dmabuf_binding {
>>>>>>>    };
>>>>>>>
>>>>>>>    #ifdef CONFIG_DMA_SHARED_BUFFER
>>>>>>> +struct page_pool_iov *
>>>>>>> +netdev_alloc_devmem(struct netdev_dmabuf_binding *binding);
>>>>>>> +void netdev_free_devmem(struct page_pool_iov *ppiov);
>>>>>>
>>>>>> netdev_{alloc,free}_dmabuf?
>>>>>>
>>>>>
>>>>> Can do.
>>>>>
>>>>>> I say that because a dmabuf can be host memory, at least I am not
>>>>>> aware
>>>>>> of a restriction that a dmabuf is device memory.
>>>>>>
>>>>>
>>>>> In my limited experience dma-buf is generally device memory, and
>>>>> that's really its use case. CONFIG_UDMABUF is a driver that mocks
>>>>> dma-buf with a memfd which I think is used for testing. But I can do
>>>>> the rename, it's more clear anyway, I think.
>>>>
>>>> config UDMABUF
>>>>           bool "userspace dmabuf misc driver"
>>>>           default n
>>>>           depends on DMA_SHARED_BUFFER
>>>>           depends on MEMFD_CREATE || COMPILE_TEST
>>>>           help
>>>>             A driver to let userspace turn memfd regions into dma-bufs.
>>>>             Qemu can use this to create host dmabufs for guest
>>>> framebuffers.
>>>>
>>>>
>>>> Qemu is just a userspace process; it is no way a special one.
>>>>
>>>> Treating host memory as a dmabuf should radically simplify the io_uring
>>>> extension of this set.
>>>
>>> I agree actually, and I was about to make that comment to David Wei's
>>> series once I have the time.
>>>
>>> David, your io_uring RX zerocopy proposal actually works with devmem
>>> TCP, if you're inclined to do that instead, what you'd do roughly is
>>> (I think):
>> That would be a Frankenstein's monster api with no good reason for it.
> 
> It brings a consistent API from a networking perspective.
> 
> io_uring should not need to be in the page pool and memory management
> business. Have you or David coded up the re-use of the socket APIs with
> dmabuf to see how much smaller it makes the io_uring change - or even
> walked through from a theoretical perspective?

Yes, we did the mental exercise, which is why we're converting to pp.
I don't see many opportunities for reuse for the main data path,
potentially apart from using the iov format instead of pages.

If the goal is to minimise the amount of code, it can mimic the tcp
devmem api with netlink, ioctl-ish buffer return, but that'd be a
pretty bad api for io_uring, overly complicated and limiting
optimisation options. If not, then we have to do some buffer
management in io_uring, and I don't see anything wrong with that. It
shouldn't be a burden for networking if all that extra code is
contained in io_uring and only exposed via pp ops and following
the rules.

-- 
Pavel Begunkov

