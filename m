Return-Path: <linux-arch+bounces-6177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BD950892
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5131C22733
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077FD1A00DF;
	Tue, 13 Aug 2024 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkTipgfN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF919EEA4;
	Tue, 13 Aug 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561847; cv=none; b=NoKkcQUWD9ZplkoXfSil+RbXjR7CQLgWDlP23Uyjd9QbXeQBfJCs1Bxh2AZFWISBsTtZZfxLeW+3+lSDdyNzpQlMzeCxQw16NJvFfSReEfbwV216Bl9Rv581KNN5NHrzgfP1aAkn1ilgzHgT6VjnTCKwB8AZ+2a6WbICiAdDbZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561847; c=relaxed/simple;
	bh=pI7NJo+riq8hIU+FO7xdB5P09ot+AEQTqkbS5XscNBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRCynsBC0PWWu7wYMWOB7+uG1HHNXY5nrwiRfMIg2140cWK7m9pJ97L6G1m8Kf2bzvRIKyeRMwFcwznWygtVi+3SJ38dsmFMBPf0C5gpXWcyhRfZYUSDb0sJoT6829oQkDjpSoaYn+gPg/hBwrdrm3Df/CtwPVkSow318gv7Ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkTipgfN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83597ce5beso36948366b.1;
        Tue, 13 Aug 2024 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723561844; x=1724166644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DL27af2hm+nu7cPx2f4++LeZQVixre2oogzMUuwPfE=;
        b=WkTipgfN7tfNmCBVk8tyjNMGCE8t4WgwY3vP+Yeyt5r8qrsd5JBVoNxEpOClqvS0AQ
         8jTfWZjbWItdTkZAApW4OJZmdb3oH3Wwxan/6Q50vjPUpBIh67mrkbZdtqNGK7J14oRA
         8GMP3+Hh/9p7MVgc7dlaWCtixGvzlQacnZdifbsqsHNkvaZYMjsVcpGlPVHx8UCmfp8d
         Ty9DUXELEJ7F4Zx9ICUq3vVe3kWgEfI5KKS+BBnL5AuUwYxioa3QnVRaMYBVp5hDqmlV
         VtU0RKj6PN4mgRxDtsszlUgMlsPJH+HtTwfFN5uRb2UvvpJxWPQpQxId2IJnbFPNGpOS
         JKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561844; x=1724166644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DL27af2hm+nu7cPx2f4++LeZQVixre2oogzMUuwPfE=;
        b=Ab3KjIVvYo/s9M4VBVQWE+Z/4EDXQXmB80TtXlJAdnGHTfUAVxUEUdVCeeo67+hrIb
         ofRfhYZ/ciaCVwBciPOQBRqICoie7D1fHPcGq2kRuR1PDKelcIPZygn2Q49KGku6AFw1
         xQxuwbHSusJqGJaKiZ7Rzq3kZXQVIYvxMRQhNXugT6kAltoBP1/OIZh2gL9uvXOHeEcb
         gkMIJfodMoS+PbVxua2uP9rYNNU17LVTfPEU2RAkbVfNewz/BVbf7FY4pU8ILp9D346C
         UPl7AdvGI8dRkXmo4JLvqKVkfcisSTb4sWP7x4XEs5xmfExwvW0OQy7FHy6HhoO1HQSk
         t/vA==
X-Forwarded-Encrypted: i=1; AJvYcCUWclAuE22nJxRlMOVWqvkF7aAMPNgXxfbNC8pmSkjoZd86KQOE+D/29eZmxTzNFoWCVe20h2xmbqZIOAHkclc4KwevTMkYmf/15yTlh7dhx86MVJ6lS1DDusy/yfR9VBtk7Wz6MfSaRTBLRORw34Q1A8NdQji8dMxQzA3eGevwL0yFNoUqyOxvG9hjoG3pNeUOSHi2qNQOuVXqfN0v0BMuB5ublIk0EU3sOpk09KUM75W9YFSL8MJVfxVB89HDuIF26ltFPcZtegDMFqG63WiA3QuzaDBHO1qWHOSLxoqYlWwqd+DjS3/Bv3Yi9M3/zWZJpBOFuiX7KvO0vCK/LtcagFNWWdQaVHeExlg8Q7K9WOL3ySPMGMeaGDyU6U0A+HDeeeWjs9OoULPRb+brHU6m7clutlEphIB9fHYUQY5RRamhh6EzdLo4UCgZNNQHvCUynaNzMYrAUVeGINK4qi06p7fk7GQjT9Oy8//oPVWULlgVfF22w+q3N2l5S2ihPplTtynn5Q==
X-Gm-Message-State: AOJu0YwxnD18hWqDzhOQKUUPKxQsa/uCpiZOfpOZ8sTbOFSzzCUMIOt3
	9T81ZXxSVcIhYoLk6FN0LQXOhOxfvWV4lqqLw0qcnwdOUd3rpzo3
X-Google-Smtp-Source: AGHT+IEgp9b07/X8lBe3DTl0aD8UgrdTViu9k66B0d84BfuLitHAtBI4O1Nbqhy82P2v7UD6nlULfg==
X-Received: by 2002:a17:907:3e13:b0:a6e:f869:d718 with SMTP id a640c23a62f3a-a836278bc29mr290666b.21.1723561844057;
        Tue, 13 Aug 2024 08:10:44 -0700 (PDT)
Received: from [192.168.42.131] (82-132-214-244.dab.02.net. [82.132.214.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f414e18csm77141966b.177.2024.08.13.08.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 08:10:43 -0700 (PDT)
Message-ID: <6a779dbb-ad3a-47cf-bb8e-1a50732a9694@gmail.com>
Date: Tue, 13 Aug 2024 16:11:15 +0100
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
 <5a51b11d-9c35-42a5-879b-08dc7ca2ca18@gmail.com>
 <20240813073917.690ac1cc@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240813073917.690ac1cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 15:39, Jakub Kicinski wrote:
> On Tue, 13 Aug 2024 03:31:13 +0100 Pavel Begunkov wrote:
>> I'm getting lost, so repeating myself a bit. What I think
>> would be a good approach is if we get an error back from
>> the driver if it doesn't support netiov / providers.
>>
>> netdev_rx_queue_restart() {
>> 	...
>> 	err = dev->queue_mgmt_ops->ndo_queue_mem_alloc();
>> 	if (err == -EOPNOTSUPP) // the driver doesn't support netiov
>> 		return -EOPNOTSUPP;
>> 	...
>> }
>>
>> That can be done if drivers opt in to support providers,
>> e.g. via a page pool flag.
>>
>> What I think wouldn't be a great option is getting back a
>> "success" from the driver even though it ignored
> 
> page pool params are not the right place for a supported flag.
> Sooner or later we'll want to expose this flag to user space.

Fair enough, it appeared to me that's what you was suggesting

"What comes to mind is adding an "I can gobble up net_iovs from this
pool" flag in page pool params (the struct that comes from the driver),
and then on the installation path we can check ..."

We can also move it from pp flags to queue API callbacks, however if we
want to expose it to the userspace, I'd imagine we need a queue flag set
by the driver, which then can be queried by netlink or whichever
interface is appropriate. And it can be used can be used to fail
netdev_rx_queue_restart() for queues/drivers that don't support mp.

netdev_rx_queue_restart() {
	if (rxq->mp_params && !rxq->netiov_supported)
		fail;
}

Perhaps, I don't understand what approach you contemplate, but
maybe Mina has cracked it.

-- 
Pavel Begunkov

