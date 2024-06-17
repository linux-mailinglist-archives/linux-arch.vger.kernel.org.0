Return-Path: <linux-arch+bounces-4949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA89490B907
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 20:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942581C23C71
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D0518FC96;
	Mon, 17 Jun 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJneLveE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C754225AE;
	Mon, 17 Jun 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647487; cv=none; b=GfGSawuAgcXqM2kiRpEhKoOethkJNie0cJwYg30L8v4/3SfOdAnFnR56kdsijuRZOkMkgEJe5rzc/GFIXy9dwKKZEmea4qzrFpJmJh9us0OMkb1gzaO1MLq/FTD75tTxDUH64hvCwohjqHoh15Ev0CLC+0+xsvBEXJsPSQxwg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647487; c=relaxed/simple;
	bh=pfdi2NaOk46tIntpMOstyS8y6kiXRZ34C/9ZfCXdwYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AmgkhWpsT5jPR8CPj80cQjEvbwZnnOvIZqQmE0QUbHJlkXjNKiwK1gEBllH6x5VbiHXV1iqOu3Tuw8lx+sREJCke7wS9w3P4XAIZuT7AB6F4EEUeu6eukkAwPKZsqN7SjpMqyO5z/+Nf4bQHkJ0v5KBsYoDTApON3UizkrMIT7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJneLveE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f04afcce1so588969366b.2;
        Mon, 17 Jun 2024 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718647484; x=1719252284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQyicpxwAULydNdPul5CanbOSkDhlTf845qwPFgw1wc=;
        b=ZJneLveEuZAntB50UxrO3xXDDYTiLHharmnpuhHX5ntC4Ya2oabuFbYCiG7UOL84mM
         FZbVBR0nTPKtP4ft1NUTPmG/smNJfxVt9nl2rrLUvnancZJVBp+gocnSSMl3KfmAW0QI
         whhXqByXjMLbzh8DvBmilGQdSZKPNEV9TpLWpv9JvA+KkSZGTc5yWkfPMWqyzea0nnhJ
         TKND7lvp0wmRlNzS4YTEtCNPRvva7o8/1CCofpFZBheTl4Uiy3JYLE7sTFPVGs0mSVfS
         brcZl6e7jtIOf1R4EjRKIUaTV0Pf+dV6FddPaHQ6oRnFTaqLKHChMTUa22ot2rSCWRHN
         dZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647484; x=1719252284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQyicpxwAULydNdPul5CanbOSkDhlTf845qwPFgw1wc=;
        b=wity4DcxgGGAa8A+5jnsO7M3I2HCz7FhzXZHMjh9mx7Sw2DOEKYNBBHj8sBzkbwvTF
         tafVVWPUW/R/bUNejnNHyNHW6AoGSUH/beD+x8Y3TCyYcTH8S7YnZno0yNxQzDeur80O
         YThNAzukF9y4x93vw9BnSKC1YsAMgfVW60B1xn70ojDWPV57E3T6a65fE+XentI8ZFrQ
         EdTIGxdVBVQOvcQMeelKz64ZRpv3qOjS0R51kN2Qq+jSDSEwEO0AXO8IJL1o9DuvwSLw
         tKNsB732G3gdLY6Sr+uR1lXPdJtmc+r20rCumQ/Ms+/R5ID8qwCzmeiUAGWy2+EUrIs8
         ANFg==
X-Forwarded-Encrypted: i=1; AJvYcCVrcKuHSmqpBsw4YbRj5StLkU8O1QRKxTQroyMU1dXGz81QO6rFhPfsqdnsXf5FFFrAhj9Frdax+UCuveAUhNipZjTxEyhnGMl7hkY68Q/HjteZ+rHopPQQVNBzNDbKyv2P8gGDZOhhZBus+SdosHcJmREBv7hWL1vl4QaXoDE1JPGtf63l9TsUGydXOIKERXCcaiaNPLy202YOqkyb0OsiIHI8pwJb4MK8vFNE31kep3o1IzfiLuOl3e1eGn9h46U+YnUYjh8luwBWqk4Ncq8lsu6lkrsy+HKA0dbjqhKwe0HJG1IRoKBEs+vx++EKrXd7WxQldsthv0XqbaW+M9yfPIK0wzEYaRD5qPBoI7idWq4+jzYBNHhY1BNPHE22bos+lMNHFYS3q6Ozv1v5Qg1CszNBXT5owufDpG6DHKBUXz44ad3bUZQDELYjscwE0FByWQBRaLzYAX71A6E68sfMZWQ17jfCoMwEzEQ2EDZL1tKZfG279xeIqt72lE0Hh+F7otqj0w==
X-Gm-Message-State: AOJu0YwQncgJluHU1bGHuHtf5Sx8mfqorOEFamfhhpsUI9RAUVbf+Ick
	1doxufvYO5inq78F0NQxxr007SfYqG3s7YISDlqy9KrP5BuZe52I
X-Google-Smtp-Source: AGHT+IEQqAbEKNSe2wLoBHNV8O+lFcqmwSNfGoItySBVqd4bPLItaNT2RIOOF/IoJpNrae6EG5ULKQ==
X-Received: by 2002:a17:907:d30c:b0:a6f:7c2d:475d with SMTP id a640c23a62f3a-a6f7c2d49d6mr537069166b.58.1718647483541;
        Mon, 17 Jun 2024 11:04:43 -0700 (PDT)
Received: from [192.168.42.223] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f63f7e9d8sm429037566b.182.2024.06.17.11.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 11:04:43 -0700 (PDT)
Message-ID: <8ca3e144-75f3-4e57-9ae0-cc88f245094e@gmail.com>
Date: Mon, 17 Jun 2024 19:04:43 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
 David Ahern <dsahern@kernel.org>,
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
 <ZmAgszZpSrcdHtyl@infradead.org>
 <ee9a55cd-7541-4865-ab2a-9e860b88c9e4@gmail.com>
 <Zmfv6_uWAVavYJNj@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Zmfv6_uWAVavYJNj@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 07:34, Christoph Hellwig wrote:
> On Fri, Jun 07, 2024 at 02:45:55PM +0100, Pavel Begunkov wrote:
>> On 6/5/24 09:24, Christoph Hellwig wrote:
>>> On Mon, Jun 03, 2024 at 03:52:32PM +0100, Pavel Begunkov wrote:
>>>> The question for Christoph is what exactly is the objection here? Why we
>>>> would not be using well defined ops when we know there will be more
>>>> users?
>>>
>>> The point is that there should be no more users.  If you need another
>>
>> Does that "No more" stops after devmem tcp?
> 
> There should be no other memory source other than the page allocator
> and dmabuf.  If you need different life time control for your
> zero copy proposal don't mix that up with the contol of the memory
> source.

No idea how I'm mixing it up when I was explaining exactly this
all along as well as that the callback (and presumably the call
site in general) you was so eager to nack is used exactly to
implement the life time control.

-- 
Pavel Begunkov

