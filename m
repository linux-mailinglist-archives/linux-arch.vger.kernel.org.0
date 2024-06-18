Return-Path: <linux-arch+bounces-4961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7024F90CA89
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 13:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BEF281E5F
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26901553BD;
	Tue, 18 Jun 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd6H5iZd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD4155395;
	Tue, 18 Jun 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710813; cv=none; b=uQ0rJ0wKVL85mgx+TmU5WKhCxrQ3Ca07md+Ki3wfxWta6cWLOg3WoqjHWPPkL5UbK1Upf0iHeb9vC/5slQnaBYuauxtmY+POSN4m0VxlgLhRdhb+bpcHNgHJKulgtJhWgYKblk8aTK/WAZAYlUZyg5LxWg+0ZnBg598L+ExSgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710813; c=relaxed/simple;
	bh=3lZSziatHbH2qXjBGEliNz48M5CThCwzTut2GQxW/ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvcAhQ6KrYtT+/HjjdV+oKBqxgUonSMjclSzpXDJfs0pMiVmZKJiOpBQYvmhBpqmwQI2MPeeO8OIcz/W3cWJX9/xCRpc1zrEG6ohYIoCa5BRhg2KMuPIKebQAZ6T6c8fUDX5LaJPkrSFr7uM+mNYZ1YqAAFI0Q1U9Z/dIB4Drlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd6H5iZd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d046f4afdso122887a12.1;
        Tue, 18 Jun 2024 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718710810; x=1719315610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkL4gZeTFn58PzKiilUj2Jvl065qOPmkOqhQzjfXBnk=;
        b=Zd6H5iZdbt8XYrfM2c+f7fRN7pCzYXBksdwvBb0rdNXRBxONFTQDLayIHoZ+1CEXKx
         z5SllyqlzVGi80jVh73AHKRsH63GWMac+aeveM04pcuDmZP3mQhIq+kDiQSgqsl+PGet
         n2lFAa/p//6cKg4gLSasMyAPxS++8j9SsE6skJXnJr+4caGKSQZK52PxFMaAgFSHyBw2
         xxwmtUNapB+zvvO5B40i627zWXlyDuTyJ+NYd7XmRE4N0k2mCuc16vfgnmgTKWCEAw5Q
         nqNxF+LnbjDvaUmE6l26Wc1Nv0okGS/vz197nZPs/bg5jUAu462HfoQ5ybiXZ6ERwqPd
         u82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718710810; x=1719315610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkL4gZeTFn58PzKiilUj2Jvl065qOPmkOqhQzjfXBnk=;
        b=GBIGOqzZq2XAW3KCDfN1EmVQyLepGq+cuu03oMyOBwF62P2ge1xhW6DCCHwXAR/V6z
         qK3NcRTvKYGKqDIBYWBR5lx+3RHk/ioWyoQMi8kU12n6OQjF+cYeAa5bEkF7kVNLgLkM
         leIZvWTsbppJ6qxN7oscPR0OQAjouGf9zlBuErWadQrWQ7BbwiieGxBjAJkUVWtH/pnK
         wTDAJbLWM4ZSPx52JkuQN7lfqDp+uDqs9OXomhA8z1OAJxVms54czAoJZGj/OMYQP7Xd
         yoabcgPQykIpbg7bou3mtvhH1ukLohtoh0qtJk54nHMwy0g58wNjkUybgU3QYROu7cTW
         j4xw==
X-Forwarded-Encrypted: i=1; AJvYcCXgN38X9zN+uyEV7T0gxN+LeuE8FuV37KNXm+hxNG32EirvvuIINK58S9tJ6MGhDQHTeoyB8dgB+SH44W7RqRvvOeMI3b2KgDWB7+KVAvEsxNqiAqAdkn3osk6hXf1WT64Emb1jDRvlmGDNvqlkdiys2kTTpEv9nZcny5GdsiXu3DhpTozBEFTBZXR/ezLo8TOevHbDnTNAIJug4t4f3opiNBBcZ1P68bgiMAVVSOZoe63pddRSQfQuUR1xvEWVnHB4ZXBub6vQq3B7KaVR2POFLbIAceNCpvN95jFyDLfmV9KLezQhzvFueSxSgPkK5jCf/RJAb/lSoza+Np3Ve7NLEuceYu2e/OEyfMTUgmQqu5ZzMg2EOC7wtjxLecLd30jOSKyQKWBRGpEUaDk/bpGxdMUBTQKfj/HxM2i3ZfCPt5kRtSiaZYcfqsW2s9wAS9ABejpYn0QGCv67XGdS72p2RjhgwnodsyCcFtOmIFpdILL08SCCdcBX2PE9pnXKjoiFrqQThQ==
X-Gm-Message-State: AOJu0Yyu+0jmklM2ZhBMzxVNr2twcG2AiZG115jlFy82HSOI/NAL6onb
	luNa5JP8WtLN487yuqGa7DYBUPTaas/6TBVPyMLdm/nSfLyaZ2KX
X-Google-Smtp-Source: AGHT+IHTXs6888aBCQaVqx3Ld2cescOW04wu9+DX8hnGCFhgSs6AKtIOVIvQW1zhvtYJcvE1BCkIfg==
X-Received: by 2002:a50:c30b:0:b0:579:d673:4e67 with SMTP id 4fb4d7f45d1cf-57cbd6c7495mr9752771a12.26.1718710810253;
        Tue, 18 Jun 2024 04:40:10 -0700 (PDT)
Received: from [192.168.42.11] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9515sm7685752a12.41.2024.06.18.04.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:40:09 -0700 (PDT)
Message-ID: <204af618-03f7-4f2e-bbcb-7111011f78bf@gmail.com>
Date: Tue, 18 Jun 2024 12:40:09 +0100
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
 <8ca3e144-75f3-4e57-9ae0-cc88f245094e@gmail.com>
 <ZnEshp0VICflc6Bg@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZnEshp0VICflc6Bg@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 07:43, Christoph Hellwig wrote:
> On Mon, Jun 17, 2024 at 07:04:43PM +0100, Pavel Begunkov wrote:
>>> There should be no other memory source other than the page allocator
>>> and dmabuf.  If you need different life time control for your
>>> zero copy proposal don't mix that up with the contol of the memory
>>> source.
>>
>> No idea how I'm mixing it up when I was explaining exactly this
>> all along as well as that the callback (and presumably the call
>> site in general) you was so eager to nack is used exactly to
>> implement the life time control.
> 
> And that's exactly my point.  You want to use one callback to mix
> allocation source and life time control.  

No, it only takes the role of life time control and doesn't
care about the source. The allocation source step with
corresponding initialisation happens separately and
priorly, at initialisation time.

> That's the perfect recipe
> to create an un-extensible un-composable mess
-- 
Pavel Begunkov

