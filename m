Return-Path: <linux-arch+bounces-5152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C89182ED
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4767B28E1A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD32F1850A9;
	Wed, 26 Jun 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqyNICxT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0C18412F;
	Wed, 26 Jun 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409346; cv=none; b=CbtbzpGcMB6j/cNSujC8Sz99Vpzociu4rJPW9H8Ssj4XqOKMamfgP6coOUwOk1t7RA+Zkctlh5RUakPZbsrNYGqGRkYHdhnkYLzgNe2unSOJ5Lhzm4CBDHIGOVubrZl6jKj6rz5bk8mUeUcZuhFdjLzLdr8wx5Vs9aunEv7hp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409346; c=relaxed/simple;
	bh=D6DrSixvJMhLJsy7OBcG0oar56V4B7uTvyItqNhYmNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqPPd2vInyzGGgW516zTd9WefAKZlQKBhxA9BlLHqoqk/kuUGHoNmEvbYzb05jLqeNHFf7wkYy6jPApvpY5fFywkVOoxKrwfoyK887pP5xdGFyEWihIqBjdN4jSzzajNTB8I+eoPAzCCpSIKmRRB8IqNZPqtfuQIT0of98VDfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqyNICxT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so331754a12.2;
        Wed, 26 Jun 2024 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409343; x=1720014143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FdmqDIycq2mg5V0lsvCxzsdDO8aUqmZjoj0FE/lExQ=;
        b=QqyNICxTpcHzL4hO/3SyrJqQqJ37KVaM2hX5WUpc+w9K2rPcBp3As4qzlbg91eOfFB
         an+hjPA6I/2YL9d53K6FHqp312LlKo+w8IxR1kpkrDoF/4DpZbtZR6SkMarCs+ysbhQo
         Pt7WGrEh848ZXvR1TQhkreHNRJ/4OB6xkbK0sfBtjgn79vpblF2P3yQr0IIBdVP8CspZ
         zRV5REH/bfq4VzBWB93AVgnzN1Kcpr8wzAtdyEdz7LRg1XD17m0dQMtOTDT1DFc1eFxI
         Q1bZkV4DDAD23+vux+VZ4CPMGVbBe5kZpmXcIcmMBFt91j23QHDazjyG78S0e2ijbpCM
         YcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409343; x=1720014143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FdmqDIycq2mg5V0lsvCxzsdDO8aUqmZjoj0FE/lExQ=;
        b=DKkFEiRFA8rl3tQ8aDR8eRivEGU6v7djP2F9mVHytWALLTOfeMIADxjpzBuCIPbSkb
         N0qm0FS2E5h9lQ5HxB7/MdCPbhDtcd5bEoU5EnDRBswcojgDY6eQsUXZtQuyBQcTE1xa
         peZf7l7jD/GkV74nHD4AWwNYLrp3yrp9mm5Z97A9C8uzeSQ0Mh82I0fW9dsnfTfeVimr
         oRDvjqwgoHlKL16XeN3cYrFbg71AnunsyvSko8Sdw3/zc5Y6+X6asUYlasa0kBOXLmMJ
         LFlsc8Px+qEDQbzZdyr9b5qEIv7PoE1BeVxUPsGWkKHtf5RDb2MlzoYfMrnb92nq2nA9
         h3jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstwAnh26W/mxm3bNzYY++a6OaFWhWS/Sx7qORkEJxOGlbUEnTnniMIABFx16/aj4qRzlq6l2tU2rzNdWdDfwH/90OBO9pyfxpV1VS2x6zeaBe+U3XeXvdTI+6VACHNGjnQKwZbLRqshIF9BHXbuQutjfWvz4ScJ0UrmNxsLGbQm2nSoU11zgyeDtgiaZzqeAo5NFtNN8i1Ks2zBgOM/VAbX/ovIuGfP6CR2G83Xs4g/3Esalo8VG9snyXGBj6uBFRKibuBnN3CDPmaRmzdyLRimYMl3GErmeghLK5UI4SDiUVIPtYTDu1TnBLBhds+z4Xkb5adUTr20P9JXl8XJbNt9d9lhw2Zo6zyJep6d9Vpf1zwvKeJu4fURf+/Cv8EmNFAWypgX9pJcIEUQLmhNMOedJXRNt3pwPj/Cd08ecWEBy6KPM1EZJQZEPQbrDb7Oy4kC9H364OBGDUrDChSxpR0rIYmpjE3CSLaoFqETFxmuUpuf804eZ8pjdKXr9QdSt8eRmEFg==
X-Gm-Message-State: AOJu0Ywcsq6hPgKSVc8CWw8eIYKISqZRzRhxVBq9Fio6fzT2SNrrhdCZ
	ZAtGe2zXnLmqArBAi6kVO9I2SPXirn7hviOnp8vyc38L2J2z8rEZ
X-Google-Smtp-Source: AGHT+IGSGpl/VlVQhxEFYrK07OrwK0X9sCyxv8xjTYoLcqAK5RzUy2KJrXSwjqhZzrye8okazO8J4A==
X-Received: by 2002:a17:906:c096:b0:a6f:86fd:72b8 with SMTP id a640c23a62f3a-a715f97972bmr751303866b.42.1719409343065;
        Wed, 26 Jun 2024 06:42:23 -0700 (PDT)
Received: from [192.168.42.3] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf48b24asm619850066b.57.2024.06.26.06.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:42:22 -0700 (PDT)
Message-ID: <6524676c-fbc0-4ea0-b320-f605d34da007@gmail.com>
Date: Wed, 26 Jun 2024 14:42:28 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 10/13] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240625024721.2140656-1-almasrymina@google.com>
 <20240625024721.2140656-11-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240625024721.2140656-11-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 03:47, Mina Almasry wrote:
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
> 
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
> 
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
> 
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
> 
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

