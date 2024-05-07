Return-Path: <linux-arch+bounces-4238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198F8BE84B
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5AC11C24B09
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653916EBF9;
	Tue,  7 May 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y846Owug"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670616E89D;
	Tue,  7 May 2024 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097910; cv=none; b=Iew4z9Z0ZTY6Sd2OAJlJD9L9iOhQGdUDzbXORXvjZ1CInd53MmCJA3D8uv7SefnCqwnJwNbs5375QlgB1PkLbYbXrmZv8PupQGMJfzUeBrIPRWEQAvxBUMnPnlbmrF9lPkCECfxXVpeWbS0y0FshXyShgLy6gRfmZpJsbcaklGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097910; c=relaxed/simple;
	bh=sA2umYUzVqo4sIQG3H0UoFRjYkGw+DSiOpJ4aIgmcyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gk71p9ab2kB5O6oCIe62kGbuKYL55eKR9Mdj+PXqTfGtzfBy7WqVE00MVaFXofaJrvF7Gnt5S7xUrEL1EJo2buMdDmpecGOI4BZMztNF0oUTtSYtKAddZzvw4Qyf/dkA1PTt4fQp8g2vbq5GgJuv2kKbKR4x4luTnUJpvfYJsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y846Owug; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so37140121fa.3;
        Tue, 07 May 2024 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715097907; x=1715702707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSQgqNCjfPNhMe7ojJ0nUJfRe4KU5PbZ7UhYGgtrTLA=;
        b=Y846Owug7hdoFWqIK7Z9zcq2lfrc0oVzS/k38PJ95hQaZKFmt6oBRhJhFaJ+V9e25M
         XRLDf6Mp6GoJvxmPYlZWRSCLcE+O5xmtHzJ5MRdDm5dK2WrEDq4nwpJmUdimoUNh5Zek
         oFv9eurtzT4Dau/7gLz9cuwSK4tvjRAlJsgO9/SR2BM8bOld4S+zsEjFCoC7uSTnqHf1
         gXrUumK3ED8mBnEDsv2WswtmmSCJZVTEqEw4G7AJWbOulLuEAqi8XY/Wc4tI4VlovWPf
         kkwVzW26ZoWZi55JwvmZTMJSDu9wGcu0505BTs5zF9QpivvFZv/l/tDx1xZn5EfHsrnw
         bGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097907; x=1715702707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSQgqNCjfPNhMe7ojJ0nUJfRe4KU5PbZ7UhYGgtrTLA=;
        b=u3LuwZV+xaTGkgxcnK/3fYCgYd6CGB/jiYq+Xy2o9J0mwFIwUVXvjrCLqIl4goLBi8
         ZOn1p6gzEgcHaC1M9tN9sk0jTfVe0VzLqVT4MgZMSWVUcxRQZ4Bbu8sd63a+nmvicTyC
         zzOvusEoQzK1d84UggRVshRSns1tT4k70ifSaIHH5hI2tuzKJ2NzdUZsBSSfAcfJl8VU
         vsUVmWClhTeD9pOyOpKz+VyIzMm6VlDfgB5J+xK1N6kHO6gH8E/Uedfy3etWsmng23U5
         3KmTtzV0gXIKPOAUr3Xkp9JLK4xw+bzgha7wkMgwpy4397AkPFVIp29rzpWIx8/6F+UD
         rG8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6QK/gxVO4+escKphijfZj/EyIQmt4OzSQwN0lh+ERswUiezQ+xnca8JCQOpZrh0ykuYDutlbRWtywPeDbG7WTI/eGCCDMlTtf4PRcDarlkeNvwQBMb+RImLC153pQhplZsb80GGYy65lseRSl0JYFgokvG1AVlLcpCoUDukEM1FySCBrCdLersfIF+ESfgWo9mJVkeHpGo+z/EeiPsmOs9afB60gp9D52Pz+0DBOINo2joYXftHIhtL3nLIbdJz0FmRAZVnL8TlZVF+98S1u6gSFDZ0y5Dbot+smApBI5gzHDEB0abgPjPfMPjKbVEKoQlSpncVBua5F6ZU1xM6O3A6jxBzA/OgPRlL6RQzE6URfsttm0ufZLbrbFwaSqmZ3p09EzepkyWE0W6sy9PM/SOJQt8vISGWLAfbyXl6tZTUFFLyHrEGw2ZPrTLoZsEjObIYAdRLcODf16VugSLzQ2KffoNkGqG/DCjGM+fg==
X-Gm-Message-State: AOJu0YySpL3ndg5lii/8OAgDlS9rugtuRGtp0rA6KH8+g23Wn68JrH7P
	QUzLkoPAmV/g3ClH7ecmy1NhccJhHVDWXFXIkAmkmS7Ypud+OG1kCAnoIliF
X-Google-Smtp-Source: AGHT+IGNn8GJzZkbQWg++AR3CoLJpjM4EU80rGYnW6RmraNNFb9jJOD55eI48eU1CcAelZqaFIYOUA==
X-Received: by 2002:a2e:bc13:0:b0:2da:9ed:9b43 with SMTP id 38308e7fff4ca-2e447085614mr353561fa.31.1715097906664;
        Tue, 07 May 2024 09:05:06 -0700 (PDT)
Received: from [192.168.42.69] ([85.255.235.91])
        by smtp.gmail.com with ESMTPSA id bd13-20020a05600c1f0d00b0041c012ca327sm20235666wmb.45.2024.05.07.09.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:05:05 -0700 (PDT)
Message-ID: <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
Date: Tue, 7 May 2024 17:05:12 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
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
 Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZjjHUh1eINPg1wkn@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/24 13:04, Christoph Hellwig wrote:
> On Fri, May 03, 2024 at 01:10:44PM -0700, Mina Almasry wrote:
>> Is the concern still that folks may be able to hook proprietary stuff
>> into this like you mentioned before[1]?
> 
> That is on concern.  The other is that people will do stupid stuff

We're not now banning all virtual function tables because there is
a chance someone might probably conceivably do perhaps something
proprietary, aren't we? Let's just patch up all ways they might
use it if there is any left.

> even in tree if you give them enough rope, and they should not have
> that rope when the only sensible options are page/folio based kernel
> memory (incuding large/huge folios) and dmabuf.

I believe there is at least one deep confusion here, considering you
previously mentioned Keith's pre-mapping patches. The "hooks" are not
that about in what format you pass memory, it's arguably the least
interesting part for page pool, more or less it'd circulate whatever
is given. It's more of how to have a better control over buffer lifetime
and implement a buffer pool passing data to users and empty buffers
back.
It's a different from storage where a user passes a buffer before it
initiates a read, data is sent by the other socket end. TCP devmem
uses dmabuf, io_uring keeps pages (of normal user memory).


>> cp net/core/page_pool.c net/core/dmabuf_pool.c
>>
>> and then modify it such that the net stack maintains 2 page_pools?
>> There are a lot of cons to that:
> 
> No.  Just have branches for page based vs dmabuf in a few places.
> 

-- 
Pavel Begunkov

