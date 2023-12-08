Return-Path: <linux-arch+bounces-823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7B380ADAF
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 21:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BDB2B20BF1
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83AC57336;
	Fri,  8 Dec 2023 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEL0ZfNj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4C810DE;
	Fri,  8 Dec 2023 12:20:08 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c317723a8so14465735e9.3;
        Fri, 08 Dec 2023 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702066806; x=1702671606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uOW35AO1MljF8VXrGiU+7YQ0Sxg9Sin/49gICtGehP4=;
        b=XEL0ZfNjqeU7BrX1xdyEx6DUG2Xg0X0WDF7UaIPhES5Z39zlai5xKx5Are2fOk5+9h
         +pagOJCQm2zHOYD27vCVwsMW40LEmI62upbSI8zbNJ8vJm/1CGqliz4xfROAZiOgKtcn
         tpgeLSrB2Cyaf/C9dWgpUFjFGyzylpRqdJ3TJmPOVtvnHCJwac1rP3ow7mTY/tsQ2WC3
         5pyNyc9Qe3J+6g92rqB+3WHZ1YRq9Rv2qjkt3RaLb17QbeGWJbbXhUxwBpBC+2MLve1q
         ZJRdu3j+6/ykyapdXbQ9I31Onz9F+srT1ZjYV3Gzjpj4rE2WAE9Zhl9UBhBChWp8yYQw
         KOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702066806; x=1702671606;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOW35AO1MljF8VXrGiU+7YQ0Sxg9Sin/49gICtGehP4=;
        b=LHQ7FOArxk9arwJABnVZdFZSwF/UDCAI1DX7SiqCimLh1ldGx0VOduIWGwYGwYWbJa
         QnbrxqhAg49Vbkd0Msy/jKG4JzGdWTpSGF/RRPlFqDsuJ5TEeXnQmrqmOnO/zjzDEeZW
         tt1/gc24jTPhpPQtFcTNwoidtmG0Gmtb9TPxzZy7jpMH5w9eCXYxq3VhbZPnwJZ8jJa2
         FDWMogjGdwwBIzZI09EPbQ51nDJDdFKdG7QKhcV1zHJ3vf4FsQzDw6FLLGS3CdBBKsHL
         h47dlCRNXXldTM+ROFGxm4xDtYg2VtuwHZvyQnWvaMH5QS83J+z0T6Vsc35O9Y8w9sp5
         /GLA==
X-Gm-Message-State: AOJu0YyJY1h1PQCOMCX/4ji7UY2fZ25c6+9r5eNZ9L2HwJhfM5M8h5dZ
	fQ3jk5fwL2ovOOX8oUv17Xw=
X-Google-Smtp-Source: AGHT+IHPBOEeXi/rqbz7qszufoY2A9OT7UPzmbehyZD259vtVrFzNVCxBNaFELhPk/sbfSi3pdVMng==
X-Received: by 2002:a05:600c:3411:b0:40b:37ec:41b3 with SMTP id y17-20020a05600c341100b0040b37ec41b3mr298018wmp.31.1702066806283;
        Fri, 08 Dec 2023 12:20:06 -0800 (PST)
Received: from [192.168.8.100] ([85.255.232.89])
        by smtp.gmail.com with ESMTPSA id bh15-20020a05600c3d0f00b0040b4ccdcffbsm3947710wmb.2.2023.12.08.12.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 12:20:06 -0800 (PST)
Message-ID: <fbdba904-e24c-43e8-9278-cde7fbe74053@gmail.com>
Date: Fri, 8 Dec 2023 20:12:57 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>,
 Mina Almasry <almasrymina@google.com>, David Ahern <dsahern@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com>
 <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
 <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
 <CAF=yD-Ln4v8orUne8E7D2_eHu39PWPCrMR3Qtuh312pCu=erng@mail.gmail.com>
 <CAHS8izOU06ceKyc5oVZhdCKJqmeRdcRyJBFpjGe=u2yh=V52dQ@mail.gmail.com>
 <7ce2d027-1e02-4a63-afb7-7304fbfbdf90@kernel.org>
 <CAHS8izM_qrEs37F=kPzT_kmqCBV_wSiTf72PtHfJYxks9R9--Q@mail.gmail.com>
 <6f853286-e463-b684-cc1e-405119528697@gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <6f853286-e463-b684-cc1e-405119528697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/23 16:07, Edward Cree wrote:
> On 09/11/2023 02:39, Mina Almasry wrote:
>> On Wed, Nov 8, 2023 at 7:36 AM Edward Cree <ecree.xilinx@gmail.com> wrote:
>>>   If not then surely the way to return a memory area
>>>   in an io_uring idiom is just to post a new read sqe ('RX descriptor')
>>>   pointing into it, rather than explicitly returning it with setsockopt.
>>
>> We're interested in using this with regular TCP sockets, not
>> necessarily io_uring.
> Fair.  I just wanted to push against the suggestion upthread that "oh,
>   since io_uring supports setsockopt() we can just ignore it and it'll
>   all magically work later" (paraphrased).

IMHO, that'd be horrible, but that why there are io_uring zc rx
patches, and we'll be sending an update soon

https://lore.kernel.org/all/20231107214045.2172393-1-dw@davidwei.uk/


> If you can keep the "allocate buffers out of a devmem region" and "post
>   RX descriptors built on those buffers" APIs separate (inside the
>   kernel; obviously both triggered by a single call to the setsockopt()
>   uAPI) that'll likely make things simpler for the io_uring interface I
>   describe, which will only want the latter.
> PS: Here's a crazy idea that I haven't thought through at all: what if
>   you allow device memory to be mmap()ed into process address space
>   (obviously with none of r/w/x because it's unreachable), so that your
>   various uAPIs can just operate on pointers (e.g. the setsockopt
>   becomes the madvise it's named after; recvmsg just uses or populates
>   the iovec rather than needing a cmsg).  Then if future devices have
>   their memory CXL accessible that can potentially be enabled with no
>   change to the uAPI (userland just starts being able to access the
>   region without faulting).
> And you can maybe add a semantic flag to recvmsg saying "if you don't
>   use all the buffers in my iovec, keep hold of the rest of them for
>   future incoming traffic, and if I post new buffers with my next
>   recvmsg, add those to the tail of the RXQ rather than replacing the
>   ones you've got".  That way you can still have the "userland
>   directly fills the RX ring" behaviour even with TCP sockets.
> 

-- 
Pavel Begunkov

