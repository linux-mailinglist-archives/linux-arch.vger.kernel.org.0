Return-Path: <linux-arch+bounces-6171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9049994FBC8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 04:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8F8B21F6D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3108134A0;
	Tue, 13 Aug 2024 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVaZWKkN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFCA29;
	Tue, 13 Aug 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723516249; cv=none; b=V5izTlFcrpY5q6W3kkouSoFeHMJUMzddY96REswlCDFoJ7Xo8ae9LiUvX0gIy/dY9eNxcxpt8X/RYq8QdFWZn76fT89MhL/teuBPqzDd+65JLXN0DrknPnPLZ8FqIwOW8N4KEkJqiKFDi/jtG40YHlPyGNZ5vYk5YFSRdxS/N8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723516249; c=relaxed/simple;
	bh=9e9KglRKObt9HIy9bVLZvo+BzNPCvjGTLk6blKUMM+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRaN6TQK/X9+hXiJzBO0nK7REVrtPTwiDH8NFTxqPtaD9VPPVqAbPrQQnyvi1fz35C3WGk5HZoLE0P52t0hVWkpCiTucKvcblMiOJk3o/DdRQ5JOGH5mddEvsihISKgb4VfMQ9ATthT8DnrHjCk9mOTEYyq1wFGNCN0Fzhgrsaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVaZWKkN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280bca3960so39091345e9.3;
        Mon, 12 Aug 2024 19:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723516246; x=1724121046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKrMThMFjWs/aD3lNtT8IXEfZvkhz9Tsh1qYW/MU/qc=;
        b=JVaZWKkNkw0UzaWw9nleP59NmzbA6ptwLgY5khojPJ/zfOpgcAYE8dwpzZvFrRMDqA
         LiB3u1QjNPUo1G47Gq2x4e20W1ZfSNXOAByOxv/u4Mjmqa/u5Q/WMCMjHEcydlo5eaZ6
         51aFQDY2sEK83cv62wFmSyM/f3vVoIbavQBPDc/etUk3uKf+sDG2Zasag9chAr5FNUmW
         XIOg9Qqo+b2v0EqFdSoIHaKPxjKhvAYMSTlnfTe6cbgtd1GStdluurrvWOTUFuZ0buYv
         5zEMs9mJGHh40lWspmgnL3j9/pnuAUUq8YrGhQgPQrkzyeIlEQCfDl0iBXLWSPm4blg1
         tTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723516246; x=1724121046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKrMThMFjWs/aD3lNtT8IXEfZvkhz9Tsh1qYW/MU/qc=;
        b=Z/D4n+MqBYwwIrXGG91/kj5N0WUoOOq0x14jDfzybPOY/qPBWFuzv6MbaXZQukBxd8
         Srbtmfr88Dk4nctw7DT1dpaRQPsvuflp/Gj90TsCsVll1HfRzx5w+kUM5cmQGh4saW6T
         EL7I0qEDYFq+QGqslIm7hZPTJ3JHDOt0zeBVIfaD1vooNTHiY1+9MB9dXCI2CS47jtE7
         Hf47JeeTQ28bjYIOErMjl1fQquRh7CD1Js1LJ9nM+Uug5FmuQza+z/qOSBg0BD9NSBkN
         bC6uOjiMSgx4DAwJJaWc8//xoXu3bfrG1uXSJ1dSrFb8Nnp/48gprAn1Qxm2Zkit776c
         r5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNkn6jxwGvKLWwDpl18PPTMuM93ezajj/MJre3I/ensSCRKhU/zo+EQF+K8mvYL+YBT7FCrJ1jpPL50yyCpcsk/bdbO8g/K19Ba8dslVajNfNVhk/1+TH0xNwhNVj9S9acGe1fBiHV+PYqwW5R4t8hUGMENlNZn38BJxm7IaNaUZXbqepR/vBn1UGYSOWGxBA+iBo24hkZnFGcvko4bRCGzFlLOHuo/YJnxWoCaURdyLRBxD656X/YFis8A6tTuekuXT/bqBq5ns08gWzjMAIDOZA9FZQn0cA0PS9zBekNhrMCPXYpQPT4koQCQ3r3JJzCVLf3/HbNUuSo+frNoPnVGfjufs9ZOgaU5Z3CvHtHJEVH3JUQ+qExlvhWJULzj3+vYwnB7FCb0OUPDvLdZRpAkwQkftHykbnJYM2fBNBlS51vT6f6IPcb+oBox995m7jIyYiq2HpOLmF/7EovO4Hm/K8VmolZHtmJloLjUv34MLGNcwkQS2T+KBE5OoVbNMivmtkkGA==
X-Gm-Message-State: AOJu0YwbrkvAwVvs96/S7NoPPb84JbtT96tEW+LagBhupXe4/ws1kQjR
	MwIHbIU7fEMEHNmFAcziprIFHGicdZ2npDu1CmYa11oCS+kpoySj
X-Google-Smtp-Source: AGHT+IFcGtH1OGYfYfxBsWgRvAXHGpU7ZE/PdqDWYMcWWlG30R+CNhYXxUTKsBTiy9zS5HWhRnTsbg==
X-Received: by 2002:a05:600c:450d:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-429d480c40emr16491485e9.9.1723516245973;
        Mon, 12 Aug 2024 19:30:45 -0700 (PDT)
Received: from [192.168.42.116] ([85.255.232.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738e01sm204324535e9.11.2024.08.12.19.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 19:30:45 -0700 (PDT)
Message-ID: <5a51b11d-9c35-42a5-879b-08dc7ca2ca18@gmail.com>
Date: Tue, 13 Aug 2024 03:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/14] memory-provider: dmabuf devmem memory
 provider
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240805212536.2172174-1-almasrymina@google.com>
 <20240805212536.2172174-8-almasrymina@google.com>
 <20240806135924.5bb65ec7@kernel.org>
 <CAHS8izOA80dxpB9rzOwv7Oe_1w4A7vo5S3c3=uCES8TSnjyzpg@mail.gmail.com>
 <20240808192410.37a49724@kernel.org>
 <CAHS8izMH4UhD+UDYqMjt9d=gu-wpGPQBLyewzVrCWRyoVtQcgA@mail.gmail.com>
 <fc6a8f0a-cdb4-4705-a08f-7033ef15213e@gmail.com>
 <20240809205236.77c959b0@kernel.org>
 <CAHS8izOXwZS-8sfvn3DuT1XWhjc--7-ZLjr8rMn1XHr5F+ckbA@mail.gmail.com>
 <48f3a61f-9e04-4755-b50c-8fae6e6112eb@gmail.com>
 <20240812105732.5d2845e4@kernel.org>
 <CAHS8izPb51gvEHGHeQwWTs4YmimLLamau1c4j=Z4KGM8ZJrx5g@mail.gmail.com>
 <a6747b29-ed79-49d4-9ffe-b62074db1e09@gmail.com>
 <20240812165708.33234ed6@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240812165708.33234ed6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 00:57, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 20:10:39 +0100 Pavel Begunkov wrote:
>>> 1. Drivers need to be able to say "I support unreadable netmem".
>>> Failure to report unreadable netmem support should cause the netlink
>>> API to fail when the user tries to bind dmabuf/io uring memory.
>>>
>>> 2. Drivers need to be able to say "I want a header pool (with readable
>>> netmem)" or "I want a data pool (potentially with unreadable netmem)".
>>>
>>> Pavel is suggesting implementing both of these in 2 different flags.
>>>
>>> Jakub is suggesting implementing both with 1 flag which says "I can
>>> support unreadable netmem for this pool" , and guarding against #1
>>> with a refcount check to detect if a dmabuf pool should have been
>>> created but wasn't.
>>
>> That would be iffy IIUC, but I think Jakub just explicitly said
>> that the refcount trick was just for debugging purposes and not
>> for gauging errors like "providers are not supported by the driver".
>>
>> "Yup, the refcount (now: check of the page pool list) was meant
>> as a WARN_ONCE() to catch bad drivers."
> 
> Sorry, insufficient caffeine level in the morning.
> We can't WARN_ONCE(), indeed.

I'm getting lost, so repeating myself a bit. What I think
would be a good approach is if we get an error back from
the driver if it doesn't support netiov / providers.

netdev_rx_queue_restart() {
	...
	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc();
	if (err == -EOPNOTSUPP) // the driver doesn't support netiov
		return -EOPNOTSUPP;
	...
}

That can be done if drivers opt in to support providers,
e.g. via a page pool flag.

What I think wouldn't be a great option is getting back a
"success" from the driver even though it ignored

netdev_rx_queue_restart() {
	...
	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc();
	if (err)
		return err;

	// we get err==0 even if the driver doesn't support
	// providers, verify it is _actually_ installed
	if (rxq->mp_params) {
		// or walking pp list, same thing
		if (rxq->mp_params->refcount == 0)
			goto fail;
	}
}

And if we go with the first version, the refcount check can
also be added but as a warning. Maybe it's easier to put it
into code and discuss then.

-- 
Pavel Begunkov

