Return-Path: <linux-arch+bounces-4029-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529F8B4330
	for <lists+linux-arch@lfdr.de>; Sat, 27 Apr 2024 02:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384E11C22B7A
	for <lists+linux-arch@lfdr.de>; Sat, 27 Apr 2024 00:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9994A936;
	Sat, 27 Apr 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AgC/7NYC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21FC6116
	for <linux-arch@vger.kernel.org>; Sat, 27 Apr 2024 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177083; cv=none; b=kDANQh5Uad5ACCT9OG+/vUU2iChym5AKrFEZB+PIuPIVJStmxHrVsye+o471JkaZirDmr4zUsZafvEZKSHUsBtwMj5XczZONFwOZfjxP+tIz3/QHp+E2YOTyTE0Qjqq7QPvYx1jCTCX/kiD5bZ5q4uuNG5Umo0nDNn8SpQAN7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177083; c=relaxed/simple;
	bh=0aSA9Pba2BWIzUUYQ9GkL6vLk2UckKSWzOIifjNVJiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0ZvmMqotqCzmLQzlHRz/C2fk3h0TZPO/x8HEWSwvLZ8/OclxnB25VWEmxHHZ6SkN2XiwtRXsP5N1a4z5A59OoftFbrhUkQQkHsSI+862Tr3HflNo409UeHD/oOps+i6MKZ2Ycv4xPT42ahbo9o1LexUNYhbg3da1eZGzT2x1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AgC/7NYC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f074520c8cso2802348b3a.0
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714177080; x=1714781880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqmTGkP664boJRzjhc7S0Gtd26iWZty8vGuCMms+S1o=;
        b=AgC/7NYCMplu5sZrQLKtcdcy0J5IYHgECA7F0YZXUqNqNOXU19lhFKfOXT3xz9HBHm
         aHSDH1wC8AxHevdJ6m0DHRgvDMHmLaG4dl5p5WlxF0rkeWIDDpQf6+/vs/WKxCaWRkOO
         +DWkQAGW1SPuPbsMzIXaK8xDJX7qswST2wvwk1MJYacVMW2xQ45pE61smx3C8EwwXPuW
         awpf9dXfvZlvzuoKvLafDs2B7FQ9mpcqrwFWVO05Q/Vtd0tsmbX7rloPjFrOTCOHjtcS
         02LpVAPkl3/9HWbmN9qq6lna9icZRcOTtcvnl8k4fdWiJ679IXUxXrRXH2nL2APcACMb
         kMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714177080; x=1714781880;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqmTGkP664boJRzjhc7S0Gtd26iWZty8vGuCMms+S1o=;
        b=K3Ql7kLPKkeMoOqLAFYqdKQAua9supRHs/8JmcPncRe+g/kEwfJEOkZQORPVIUxhTZ
         xUMX9+2grluW5xOIPXTTT/nVmMv7i+FO7xcHabJtqUbuUk3UkVfLHmhSYaXPoKtAk90P
         fRun1xObaseHQrmJfAgGIMki/o+Q32eTsm87OjMVw66pojlqhxnM0IMdJuCLqYbbbBKg
         lOAUzK1meZf2hSHai/Ivyrz+Ha4wjeZY89e9sdT1O0BRXsA/UrWFb235N5/B9HWDdu/J
         cYxdWwzntPz2iqiSFjJ8pnKqFVXtUUv/ZrdfNJvJH9XFSybgOQlvsS4ClF58ArKoh0NV
         /m0g==
X-Forwarded-Encrypted: i=1; AJvYcCViMyIzR1M+EYeRjXfDWW5vKr6IYRn56aFbxbd/UmgzlxddHjNGU43dkeWA8gmbL9rYk6l0Ay1AlgGoPX7oX5fsISFEui3xzC4Yyw==
X-Gm-Message-State: AOJu0YzzBHRQKA05gv5oQaHSf1yhYiU6jGs36kX+eUQidG5coCrTDJAS
	6C/HG1Te9nk1WU3lYmwHLJCLhbcx/VeCu9S182d5sRm2VuhLmY/3OkKahWxv0J0=
X-Google-Smtp-Source: AGHT+IFUGAssCWxanm0G+5JJGXLl3jlzm6HCFUo2+VTIRf+pchJBS1TwIepfoN9/ZtJkA2EtuVR6aQ==
X-Received: by 2002:a17:903:8ce:b0:1eb:5682:1ec0 with SMTP id lk14-20020a17090308ce00b001eb56821ec0mr584629plb.45.1714177080246;
        Fri, 26 Apr 2024 17:18:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::4:916b])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902778900b001e51b690b7dsm16004827pll.295.2024.04.26.17.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 17:17:59 -0700 (PDT)
Message-ID: <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
Date: Fri, 26 Apr 2024 17:17:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
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
 Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240403002053.2376017-8-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-02 5:20 pm, Mina Almasry wrote:
> @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
>   */
>  typedef unsigned long __bitwise netmem_ref;
>  
> +static inline bool netmem_is_net_iov(const netmem_ref netmem)
> +{
> +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)

I am guessing you added this to try and speed up the fast path? It's
overly restrictive for us since we do not need dmabuf necessarily. I
spent a bit too much time wondering why things aren't working only to
find this :(

