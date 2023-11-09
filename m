Return-Path: <linux-arch+bounces-106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 005797E6E3F
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA772280DE4
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E61E539;
	Thu,  9 Nov 2023 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1PdBEEb"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340A208BC;
	Thu,  9 Nov 2023 16:07:20 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFB9325A;
	Thu,  9 Nov 2023 08:07:19 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so666291f8f.0;
        Thu, 09 Nov 2023 08:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699546038; x=1700150838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLnVRYPlFfc13GAjjN2Xsp7jGpHoZsbxAdnsHea6XjM=;
        b=S1PdBEEbQjC//UPEJlQzyAeUAkuHeKKJJ9YxSwGJsBWIinlJkTs+futdHjvOEVf1FC
         i1Lq84/hnwkn4XeC5I0BBN/0oIHI5af7Fi3x6itpWXj6tG56p2o+2ARGn2y3UatsLXoM
         2BRCpof7VunFpfVP3P0nRrTARM2YsPO0VE0dPjXa8wqDzjKgoixES1wF4kmsqRx0ezw9
         h3fikdiuHtuXCTH3ejazBRyAvX0r13K29IX5G5vNdpNq2cBxgpRFb+JkL0Tem9jL0+K7
         pAhZsBr6i3kJ2w4D3MLLjQvI1ypeSrlzcBEEphirMcF7RjNd0iiclyA2FqT68ZsCnMv5
         hM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546038; x=1700150838;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLnVRYPlFfc13GAjjN2Xsp7jGpHoZsbxAdnsHea6XjM=;
        b=R/MbwkS/v8iIbH06fbpsFkDdZD9+AYldSwwIVdg6X9PNPW5NkpenkDc9jDsYzVHhTT
         J7VrGwVPZB1LflTmKfBY70EhNcRqlMD+LA/5rW2XJg0SdxntYLDp1NQWRunqbhaJU1xL
         R/nOoJEzR6nzeRqBGN8bC1Qmhe4pReIQ4u/3QvTL83ZSyyHXzyc1nsSFDuwXSgRTlGQ5
         AEwJ/V44dN0PXF/XYwUkQOkK0XgXxazJi4TwIMlWcGFERrmzfY9SWsBHzBRfbMqkQzfv
         4Sz63UHyC5/kfLXFw0DSlEyRgW4+jh2nSoqU/uXcTN16mJVwgTt1V7mIz/OjCDpj+naD
         /Osw==
X-Gm-Message-State: AOJu0YwiZkdiOR1l2yn/EgV10xBCIJqDIqkgH4smPRNFKS8MUyVbibSC
	xeGsTXVc6tTg8V3ClCJS6Yk=
X-Google-Smtp-Source: AGHT+IGVRroWe9+M86SBSGyIl3Qj9MvOmsO9RPSIFo66Ff8BWlVF0jn+QQTFhXSBQi9W892f6tI7Bg==
X-Received: by 2002:a05:6000:1888:b0:32f:87e8:707d with SMTP id a8-20020a056000188800b0032f87e8707dmr7113717wri.5.1699546037464;
        Thu, 09 Nov 2023 08:07:17 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d42ca000000b0032f7fab0712sm7577069wrr.52.2023.11.09.08.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:07:17 -0800 (PST)
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>, David Ahern <dsahern@kernel.org>
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6f853286-e463-b684-cc1e-405119528697@gmail.com>
Date: Thu, 9 Nov 2023 16:07:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izM_qrEs37F=kPzT_kmqCBV_wSiTf72PtHfJYxks9R9--Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 09/11/2023 02:39, Mina Almasry wrote:
> On Wed, Nov 8, 2023 at 7:36 AM Edward Cree <ecree.xilinx@gmail.com> wrote:
>>  If not then surely the way to return a memory area
>>  in an io_uring idiom is just to post a new read sqe ('RX descriptor')
>>  pointing into it, rather than explicitly returning it with setsockopt.
> 
> We're interested in using this with regular TCP sockets, not
> necessarily io_uring.
Fair.  I just wanted to push against the suggestion upthread that "oh,
 since io_uring supports setsockopt() we can just ignore it and it'll
 all magically work later" (paraphrased).
If you can keep the "allocate buffers out of a devmem region" and "post
 RX descriptors built on those buffers" APIs separate (inside the
 kernel; obviously both triggered by a single call to the setsockopt()
 uAPI) that'll likely make things simpler for the io_uring interface I
 describe, which will only want the latter.

-ed

PS: Here's a crazy idea that I haven't thought through at all: what if
 you allow device memory to be mmap()ed into process address space
 (obviously with none of r/w/x because it's unreachable), so that your
 various uAPIs can just operate on pointers (e.g. the setsockopt
 becomes the madvise it's named after; recvmsg just uses or populates
 the iovec rather than needing a cmsg).  Then if future devices have
 their memory CXL accessible that can potentially be enabled with no
 change to the uAPI (userland just starts being able to access the
 region without faulting).
And you can maybe add a semantic flag to recvmsg saying "if you don't
 use all the buffers in my iovec, keep hold of the rest of them for
 future incoming traffic, and if I post new buffers with my next
 recvmsg, add those to the tail of the RXQ rather than replacing the
 ones you've got".  That way you can still have the "userland
 directly fills the RX ring" behaviour even with TCP sockets.

