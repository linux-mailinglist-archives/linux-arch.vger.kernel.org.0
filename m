Return-Path: <linux-arch+bounces-4789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBE901925
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 03:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEBA1C214EB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 01:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A241876;
	Mon, 10 Jun 2024 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxTfbDoC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5015CE;
	Mon, 10 Jun 2024 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717981950; cv=none; b=dW874Or8EP5ScmdTYNK//bXcpk0a1JHlmELoOpgxcE5zSihOuXrdzze6C9F97hHipe1GMzdhxdY8VBkDzsznp8NdOiMwX1wAg56hCHw1ku2eEtR5jLx8DCT3H+SuBrp4sL89GjNC4quG5V/iv0ryV9YiJoVU8ebYuqvIlyx5a98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717981950; c=relaxed/simple;
	bh=EsX5TKziqgKhjkWYw5NLeEdQUsicnvMiY7lDy1rAcv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS53eTtVtLLHIc+NH+9WjqwavPBq1JH26jNYDr4VKjrV/8+6bh9uik+h4vdM0Z5o5nKzjGgOVQGVkBJk8TUwuDwQy0Q0PfXC+qjWEDw3WLmxa9fJuB32Oe7TVB0Uaq2hejnz7wK/zvOOLbcOXr39D7ew/re3I/P+oKmhxiBAB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxTfbDoC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4218180a122so4707665e9.1;
        Sun, 09 Jun 2024 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717981947; x=1718586747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNJduADeWsFPxp+m1I5nZ3f95BR1hPfUvUg61woS5Tg=;
        b=HxTfbDoC89Qf0MsImNbmIKWJTh32SI6iwMqfT9O/prOG0vt11PFGr7UpiXnFmvZ4vy
         Wc47ZP6Uzy4rk3CxWfdcBz6qrXfLrzeFlRRw5ostrVsVMqO+q62hVC1pRKraekq1WoKQ
         LnMl0MFZ3z5qkS9V6GGpXRnAQU7pjQZI7tYa/NtlHApZZDneKwbUdOrOrkuw9PKk+IVD
         3aDYridbIjvo0Ts9nBInmFZpE0e5egbWK2Y0xDa4cxmNh8yi4BzMSINR5QdgAybdmglD
         S+NEIVK//kO1QdQv80fQqoJkXkhtjudMX9NngNDzJcYAD77vVny1VyLK2c/zv4dgTosH
         CvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717981947; x=1718586747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNJduADeWsFPxp+m1I5nZ3f95BR1hPfUvUg61woS5Tg=;
        b=efXW7TGUbjzhTPjWaR3M9JNJ0TT3hgr52fwW/08d1zSl2DJVHKIK1ywXDJxFP8jUCN
         uXoRYY2NQSfdmNBD01VXcvn91lh3Gdcj1bmXmAJGssewVLk4uU1++8i46KUHPYU1E8n4
         +CAZNxNElM41PIhqeqWnXjew7TpUURKPkdd4YJJpDo746OeOvb6GVs6LKgrjbHcrrzGB
         FtySB9tx+pyxrvxCw7olwdkkURLL2b7Q5EjJjg03MDhC8LnwCb72fA2/mcQLUARsKeV0
         se95wMBEIfASmdqiEZjY7F+BRSlYNM7xdD8UMNoNXcgJXZOjef14KP6ehd7LX+o6MgWw
         sZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfJIJOllN6tFckACsP6Lf/NQTIgbkmtqGKN/oJaX8Tpyu/yZghmDPq8EIRo96HHTtzmeiavEzs9xye/Eea3iluOv57I22neaWt/E7WpKyGF+En0q/Vh0Fzix/D9TKXOLbrA3E/szeDgIBGA/ZkNOiWYWw+AE4QSS/r+4emUzHt6FPQEK5vSDtnRaWnLTKscsHHNP+qyJPRYTMJoyq8X1VCzpeuSEEiSInwcomynMT9xikjgErSvKm6DGmU9Az2J6VyqsoOTHhF9++mYtlA/KxqkyUEK/KA4DrBEi0aPWrGkKsdj0xgi3QMYt+BuTVkLgjHzPDlYdxmszrJ0PVeVweBhn0fF/PRYOeRgcBdq4mEbEDBZ9X5jBMn6aecPDKJmR/yue9ZUmyzAMZ6cSCXaaFpaFBeXJCbjQME/yIS5O2QcMLOKHoFuph4aPax1JHOUGMDxpKHBl5ur94KaBU6pMXwAdXpBdpXl/Waz+BipEKdgrQ+xrM8xGYkPYXar2pHEBBujS3VQw==
X-Gm-Message-State: AOJu0YwZs1yFSBL0veNDh42YRYeXG3l6nIedPtaf7vYjzimRwG+f9HBz
	QwCCNJRyQ1P5tVA6tda3rDvVJVi8pM0270M0RgrHyEo7NKPqZ67X
X-Google-Smtp-Source: AGHT+IHDaD1xgXKiE70wxK20VeOXv7YAKZBIIZIbJBgPUlJwOc+Otz/U6x6lGExUj8MSrU2BCjmLtQ==
X-Received: by 2002:a05:600c:5113:b0:421:f346:6b06 with SMTP id 5b1f17b1804b1-421f3466f07mr3105805e9.28.1717981946528;
        Sun, 09 Jun 2024 18:12:26 -0700 (PDT)
Received: from [192.168.42.136] ([148.252.129.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215814f141sm158668365e9.42.2024.06.09.18.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 18:12:26 -0700 (PDT)
Message-ID: <5cc208d6-6116-4e9d-a48e-67290adc573a@gmail.com>
Date: Mon, 10 Jun 2024 02:12:24 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>
Cc: David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <8f44ca2a-8910-418f-b4a6-ca1e051484ba@gmail.com>
 <a8df4459-30bf-4414-aeca-2f67c461adc4@gmail.com>
 <CAHS8izNcYMsSpTNVSGRJHK6u+kDxnFab5Km1rYy8b++0FeUNgA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNcYMsSpTNVSGRJHK6u+kDxnFab5Km1rYy8b++0FeUNgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/24 17:59, Mina Almasry wrote:
> On Fri, Jun 7, 2024 at 8:47 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 6/7/24 16:42, Pavel Begunkov wrote:
>>> On 6/7/24 15:27, David Ahern wrote:
>>>> On 6/7/24 7:42 AM, Pavel Begunkov wrote:
>>>>> I haven't seen any arguments against from the (net) maintainers so
>>>>> far. Nor I see any objection against callbacks from them (considering
>>>>> that either option adds an if).
>>>>
>>>> I have said before I do not understand why the dmabuf paradigm is not
>>>> sufficient for both device memory and host memory. A less than ideal
>>>> control path to put hostmem in a dmabuf wrapper vs extra checks and
>>>> changes in the datapath. The former should always be preferred.
>>>
>>> If we're talking about types of memory specifically, I'm not strictly
>>> against wrapping into dmabuf in kernel, but that just doesn't give
>>> anything.
>>
>> And the reason I don't have too strong of an opinion on that is
>> mainly because it's just setup/cleanup path.
>>
> 
> I agree wrapping io uring in dmabuf seems to be an unnecessary detour.
> I never understood the need or upside to do that, but it could be a
> lack of understanding on my part.
> 
> However, the concern that David brings up may materialize. I've had to
> spend a lot of time minimizing or justifying checks to the code with
> page pool benchmarks that detect even 1 cycle regressions. You may be
> asked to run the same benchmarks and minimize similar overhead.
> 
> The benchmark in question is Jesper's bench_page_pool_simple. I've
> forked it and applied it on top of net-next here:
> https://github.com/mina/linux/commit/927596f87ab5791a8a6ba8597ba2189747396e54
> 
> As io_uring ZC comes close to merging, I suspect it would be good to
> run this to understand the regression in the fast path, if any. If
> there are no to little regressions, I have no concerns over io uring
> memory not being wrapped in dmabufs, and David may agree as well.

That's the easiest part as io_uring only reusing call points
you added for devmem and thus doesn't add anything new on top
to hot paths.

-- 
Pavel Begunkov

