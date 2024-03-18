Return-Path: <linux-arch+bounces-3018-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4287E249
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 03:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888071C208BD
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 02:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3625200D5;
	Mon, 18 Mar 2024 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="iV4pzRO6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCF1EB38
	for <linux-arch@vger.kernel.org>; Mon, 18 Mar 2024 02:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710730188; cv=none; b=QO/JOAB3BY4M69aM2v6bN9BH5pT8zjMZH8OxVVp2O5IEk8TPCLJLo2GhGhpyvgEJjnuZJpAaVc4ao0DKEGN2bbBGJSO7bEwDiKhzda8X+mzNyp3dtA+o+LvdxqWWQ8Mt9QvTu32SER9Rg1HJsV/3SKZ5rmQUcdGjQYOZm+7D6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710730188; c=relaxed/simple;
	bh=ybVBqVNCXzGJGuz6lwF+tzdhl5wD9gmQp2PXPNadGZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4Mi97IkUSekmnkT9bxM8eKLTylT1PW1wFLvMUywzyqJ7W2d5nCTJbAahZXDIr1yF6PC+8CZJ7JhBl6UpXj4LcEvPvf7zZ5AWbwQ0tQxleGbhTt1afRBGxN0FZRhgzwzJjtAoy/mSCfuyVoMdif5862vShfCKMluyCMqZsNInMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=iV4pzRO6; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc8b280155so2579785a34.0
        for <linux-arch@vger.kernel.org>; Sun, 17 Mar 2024 19:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710730186; x=1711334986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QE0CXFBu76tpBM6gpoJrOe0mC6QUf5XbAI8puJxCLjs=;
        b=iV4pzRO6P3GXwlCKnBLXNP1M23gu1zQrspv6JPJ8fStuXR6pQ39ApKrDntPI5tx/uE
         /MnuWm41o/lbyJAypmV8amaK7R/DY9hx5GRXs/0r9iXayTGjDZNX/3a3xzI+TRbmrgc5
         CKaIjiPutwDoASk/sLDAWwavRiaWn0pBM9030+PUUupT3yeK7y4jPmhcyEMY7r4Hl52y
         XWNfIYJJTMt5wTngWdOXFC2+N/RSAkoF1vsgGy7/X1ZW8EIw0zE/PfsaGzUF6O4qnNcM
         v/ZuzSbzmtn0escS9ERzZ4uMFZQ9IggD068oFEU9q2JSyZaFtYe56f0HASQWjPvNI5se
         3jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710730186; x=1711334986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QE0CXFBu76tpBM6gpoJrOe0mC6QUf5XbAI8puJxCLjs=;
        b=DA1c3bUD6mfOIPi7nsg3fyjP0iJCclehRxrCF9EyrGANBfFRK809+lHfhlJoG2fm1/
         Fd4enWtChBL99pKJ5lpKo+wRfoHvYBLjx0coUwFOPrhvmHVcM0qr9dFQc6YZFFGynfQ+
         g3PrA1zc3VLz9TgO0cOhn3/aXGECgmZybBlmnwxQTf14CwZmuHvi6ly2/B+wvrVs/CXV
         Xypr3kvx3qb6QU/zLoq0zc9T/jA9igAWWkgt148qm5dON6DAJ9svojkZxPhXwKf73uC5
         WaSndJYzMN15eo/cW/kSC4RwSHe2VJsdbZykKzC1z/V7zFCo9CEGF4UeRcAL1OcOXHuA
         idcg==
X-Forwarded-Encrypted: i=1; AJvYcCXDJAWJfRMfiRq/XUnZfDKNlv8FvgRoufbihx3WsI0+oaJUWbKU4TP+ep6Gv1ECNCCOwsChQbeOIZEzqfSWzGKgGQxj+3r2SX9EyQ==
X-Gm-Message-State: AOJu0YyDVvkc4y9/G9g+WGT0QNRpV3bdp1rwXhA408NQVXZkJsrp1pG4
	LDWnpoz1ZXBcoDqiJ6/Bx09bYyXra6HqiYApl08ZnfC0IK9kjEe8Z35q0anazyg=
X-Google-Smtp-Source: AGHT+IENq8waTwhUkJrEOrb8DEHjfl4QDem6FZJYYGTlmjRRGItMoHQ4P2wTQfIoEZJr502KAVnEEA==
X-Received: by 2002:a05:6870:8e05:b0:222:d6a:9ae8 with SMTP id lw5-20020a0568708e0500b002220d6a9ae8mr10284561oab.35.1710730185882;
        Sun, 17 Mar 2024 19:49:45 -0700 (PDT)
Received: from [192.168.1.24] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id i189-20020a62c1c6000000b006e66a76d877sm7120229pfg.153.2024.03.17.19.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 19:49:45 -0700 (PDT)
Message-ID: <b938514c-61cc-41e6-b592-1003b8deccae@davidwei.uk>
Date: Sun, 17 Mar 2024 19:49:43 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 02/15] net: page_pool: create hooks for
 custom page providers
Content-Language: en-GB
To: Christoph Hellwig <hch@infradead.org>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-3-almasrymina@google.com>
 <ZfegzB341oNc_Ocz@infradead.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZfegzB341oNc_Ocz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-17 19:02, Christoph Hellwig wrote:
> On Mon, Mar 04, 2024 at 06:01:37PM -0800, Mina Almasry wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> The page providers which try to reuse the same pages will
>> need to hold onto the ref, even if page gets released from
>> the pool - as in releasing the page from the pp just transfers
>> the "ownership" reference from pp to the provider, and provider
>> will wait for other references to be gone before feeding this
>> page back into the pool.
> 
> The word hook always rings a giant warning bell for me, and looking into
> this series I am concerned indeed.
> 
> The only provider provided here is the dma-buf one, and that basically
> is the only sensible one for the documented design.  So instead of
> adding hooks that random proprietary crap can hook into, why not hard
> code the dma buf provide and just use a flag?  That'll also avoid
> expensive indirect calls.

I'm working on a similar proposal for zero copy Rx but to host memory
and depend on this memory provider API.

Jakub also designed this API for hugepages too IIRC. Basically there's
going to be at least three fancy ways of providing pages (one of which
isn't actually pages, hence the merged netmem_t series) to drivers.

> 

