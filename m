Return-Path: <linux-arch+bounces-4243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA88BE9E6
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23C9B26033
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF214F8BD;
	Tue,  7 May 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKuM9kIF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD8747F;
	Tue,  7 May 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100906; cv=none; b=PUOn3eiI6iwi1NKXygWHwM8g0LtoqUQmoV4xkeTTA/ov/KB8lVK0msPEeLKs1SRTRFF6aMMYHWfAKkJ9gcCbL8/nRMBcXL1uuEpgEZFVlJKwKEbNttQfNhkfqVN+bTHPw61PAh9uQDat8aGc/sJ4+sBL57hzAn28rvMhw772PLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100906; c=relaxed/simple;
	bh=w2F56fiWPcf3I7Mdw2SWi3X1Jhti8Ih4jgxuRbud9h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nh2zxiJ0Mt+ofzGVLLJ8gQoWOSReGo9j0eWG1qtpIQJQZC0IA45Z918j7wvesx4W10et6QCSBkw5QmRlMw13lDFzugaLfQXxqiLDfMKnrPmPNmvu7pIsxX54quL/xFiyJ28cPeMk+MbTLRcWeTn9azFAXhrzipqZ3S/UFgx9Zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKuM9kIF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b782405d5so35528355e9.2;
        Tue, 07 May 2024 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715100904; x=1715705704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dF9l/kgRlz0B5vWAs2atat+U+Sdoi0d3PjFaa8gJGnw=;
        b=aKuM9kIFVQWqKmaTHy+os7H0DqcqgEUt1BUiomV2TUsYKMVs2xjJChnn+MSshvCFdx
         /PnMHUkPs1otUDw4GTYd0Ehhv1phXeaSg0UBuI8AxOWFpqLAa08d1hMXw6bWF15mANZw
         ItewV1yNygyyM5rAfOoYr8gdsiZpbq6HRK8jRFLA0nuY+9Qtsfz8ky17qxby/uV7iyiE
         VWFDC7kWP0tzzS+b0d65fFp4dNKX6fjG1sOPsK7FmA4rKJMMB/CbNPrBz6VyRwd8BhoN
         C1ShwLLzOcC/KjA25Ky691Y/1fBdyeVQZS42eylyeB3eGenV21MhmDIT6oSYfpwTXRWo
         3qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100904; x=1715705704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dF9l/kgRlz0B5vWAs2atat+U+Sdoi0d3PjFaa8gJGnw=;
        b=g57z0eQJ3HGh4y+RNT9NfAgUByYXUJtOkvpPiGBVXWirQidAyIejEDF7VqTj6AhKEW
         h8dmepsg22Zom/W/KRpGXqBjA7zTkEZzq+T9olA0VnSC1zBoXBULwnCxzMSE7bsxH/Vt
         WRI3HtwD7CnYTruKua/Klx08kUpIHZ58IgByXitUpadiP3WeD7KaROoJxTqP/r3gQvBJ
         kkOoARxRGEjZyxX3389uI5EU9gmpUWqTneUZWc3QtMUxaSTPGaOMT8s9NHtjBbkjReWV
         J0GwzdjEeqChjkcB5xtYkrYMOEVMgMz6nT+cjs5oCOTf0hYitB7yayioQ+QiGYYHx7BF
         sn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpBDGgY1n2F76L31sps4cYmoUhT9HY0585kXqSG4VgGBRYXamm0lfZ1O3ky6Ky0UGW580F64EGSAMQsGUiqpbn2YVO4sLLotb7KpoUZCArCBK9oaOmuvx9oakO0ZakzMqr8L2WX+tPEKVYwt64Ev28Cea6QZTnHj78xJIAdS9pR4rAiE75ysr3FVuhtPNv5A8U2uyoe9Nlw1H+P5ac72ZuAKr8bwvuTPSWGcfPmPPOBm7QsVVn8fKlOG1P70o0eoavIM2hiL+hJ4xDuoCpbmQqCmfjeenwSq/yNc5QNN2W037t+hz7Uo2HIj+Jy9jDBsH0/TScKSwKCATBg8P0eYWdfVm/IxLhkNALZf0/dUddA1verD5TYTh8klwX1HxlxQS7ORCLuFbri0SGU0MtJ4L7QBHF0mRoi2JW2bt2vgpiMC4720ssp2jrBzOVbKvfnbZRyA3rQGeo7du2XQiPxbeLlKdyrDNzWdX7gEFsGngX9+z7G4Q1n0CGzBKL8cAKDlYnrevoow==
X-Gm-Message-State: AOJu0Yz8k54iFeURo2jo29iLzMWOo5yiAK19SLmyxk9Of7JuImPyanP8
	4Nm2iiyHlg85Pb3QkAnzybiImE1JKuYDysnopsVw1VvjW6r03fMG
X-Google-Smtp-Source: AGHT+IH7DHe6/ECg4cq2RKtLIjPPmczYwSJQD4jpcfKG6nOXnELQiScPGDQJbCXwTIzCZULoDPCQXg==
X-Received: by 2002:a05:600c:4747:b0:41c:2313:da8d with SMTP id 5b1f17b1804b1-41f7093c658mr4744345e9.0.1715100903326;
        Tue, 07 May 2024 09:55:03 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b0041adf358058sm20132504wmq.27.2024.05.07.09.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:55:03 -0700 (PDT)
Message-ID: <54b1bf11-0f9a-4e9e-9e5c-7d81e066fc7c@gmail.com>
Date: Tue, 7 May 2024 17:55:09 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christian Brauner <brauner@kernel.org>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Florian Westphal <fw@strlen.de>, Yunsheng Lin <linyunsheng@huawei.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Aleksander Lobakin <aleksander.lobakin@intel.com>,
 Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Richard Gobert <richardbgobert@gmail.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>,
 Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca> <ZjpVfPqGNfE5N4bl@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZjpVfPqGNfE5N4bl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 17:23, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 01:18:57PM -0300, Jason Gunthorpe wrote:
>> On Tue, May 07, 2024 at 05:05:12PM +0100, Pavel Begunkov wrote:
>>>> even in tree if you give them enough rope, and they should not have
>>>> that rope when the only sensible options are page/folio based kernel
>>>> memory (incuding large/huge folios) and dmabuf.
>>>
>>> I believe there is at least one deep confusion here, considering you
>>> previously mentioned Keith's pre-mapping patches. The "hooks" are not
>>> that about in what format you pass memory, it's arguably the least
>>> interesting part for page pool, more or less it'd circulate whatever
>>> is given. It's more of how to have a better control over buffer lifetime
>>> and implement a buffer pool passing data to users and empty buffers
>>> back.
>>
>> Isn't that more or less exactly what dmabuf is? Why do you need
>> another almost dma-buf thing for another project?
> 
> That's the exact point I've been making since the last round of
> the series.  We don't need to reinvent dmabuf poorly in every
> subsystem, but instead fix the odd parts in it and make it suitable
> for everyone.

Someone would need to elaborate how dma-buf is like that addition
to page pool infra. The granularity here is usually 4K and less
(hw dictated), what user receives cannot be guaranteed to be
contiguous in memory. Having thousands of dma-buf instances is
not an option, so a completion would need to include a range
where data sits. Then who controls lifetime of buffers? If it's
dma-buf, then at least it needs to track what sub-buffers are
handed to user and what are currently in the kernel. How it would be
accounted? ioctl_return_subrange(dmabuf, [range]), sounds like
a bad idea for performance. To cover user memory it'd also need
to be read from userspace, ioctl here wouldn't be an option, but
let's say it's somehow done in the kernel.

That's not all the list, but in short, even though I haven't been
following dma-buf developments too closely, I have hard time seeing
how it can be a replacement here.

-- 
Pavel Begunkov

