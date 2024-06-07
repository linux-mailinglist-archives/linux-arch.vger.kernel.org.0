Return-Path: <linux-arch+bounces-4746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D510690039B
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F7F1F29725
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 12:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96D193099;
	Fri,  7 Jun 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtQAu4d4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9351850B7;
	Fri,  7 Jun 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763469; cv=none; b=ihspyxSIkcpuqeAjV+svjm+SkQD9qNXYX9PJkfxVmIC+UWD9oys+w1j7+dWZavBsOxIpzshgJ1BxvcNHI+y5XEG+wifOv3T+MwunJVuYIR75/9556gnf6zzfP3iw3ZCl1jkiNxN4VHU3Vzta36xYVqPpyS+opBRpz8S0aJdNnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763469; c=relaxed/simple;
	bh=RuDIhSbO/ax8zNd2ran6Gzbl4un6OLukSdQSWrPKP5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/zTJTJicgj4W/5Q/iphzeMeSZekEl003bNzHzMCLNpIAo9mkXFcy4U63VjHZcE2g6FeSklUFNyJ9VKakOtL/876BMoGTs9R2hljDJPqzv/KIZYijP6ntyTlyTbP/Msj6wEdANSSnEyY6qJZWOuUQj8kbICpjfv9/nba0aUBYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtQAu4d4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a4ce82f30so2517618a12.0;
        Fri, 07 Jun 2024 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717763466; x=1718368266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0t9qQNDQyMfGhvDGBq4R0rinqRtCXO9/OSll4uI/+M=;
        b=mtQAu4d4XlKrMSJMuzE18hRv2rGbyDiD8PeDYFQlpjxKEyese7Q53wrKH5y7oUV0Vr
         28Qp+AbcRgTV1Aj01fBvOek2LMZJJq+L1zIi+bVehdV1sc7kg/D3jeO5vx9U+4RPtgdj
         yG5aQ4H8tE0lj9y4eoETprXJN5qaDbqIzTTuND1LdErfoZ7rBxqdXznx2oJ2T8QSIVy8
         FtxPTyaQAF56ka1alhP2g8ln+GjH9WO/SAwT9RiEjJfjKjAQcNVLgGeujJ2EDs6C6vq2
         ACzakRjCQ1ieHSg76vaxICyfybb0GzAyUmjCS3hazrsU6dcFucLDCGTE82AUtwFRdkjl
         DhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763466; x=1718368266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0t9qQNDQyMfGhvDGBq4R0rinqRtCXO9/OSll4uI/+M=;
        b=rVPli6S6EASMiI6mheun6Fu7IdqWS0g86MxC91RVtpvRtYzd0Ym6bXyXJdopMh/G9P
         5YJ+6trasR1YR3mn+L32bD0RRjdqNIH6P0SYFA3WQtWR2d8DnYDGFQuYnPX9fbOwWS+h
         Cr3WRu5Mognrwpf7qksd4cqnQ6S0B0Kxa0z83Z4p8mGLRMot/IXxo74XMOeovzpl+YeU
         MBNdf8PyF6haaXaKF3sNI9bNM1bpem+TYKQ49voCMbNNqFiVhwQ+lSGmdHn4692gQXYi
         eue+2+OfiQ2WAyD95yeAiaXm3WT2GKyxaFSm0a5G2PE1O+MjQ92W2zdn4Ao8hFuKVIHf
         4dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbzO0U9d0UxOjnBfIPvPW7Gdcbi5u0nij75sNJ5L4YyKV4sZgQGtHUeq66OaVOZa7o364L06hUFtvNsDFqd0vxSeLvmGOLo1MtNJTJ+7frSgpJW+i1+DS2na40+SehZOM37Mr0BiTz2FI9uZmKYRKTrBuYpgKhvqNwzvPBPnSE3kObE9hkFuLR2O9iTHySWC5pRHbhRvGESefDVs7oDwA30CdzphslEQ4djsZhDgKJ5Vns1ub9j68emOaQ6vR2havGFxd47HE5RbX8Tb3uC7C/CBW+2uiluVSaAhN8X6aCdj6sWrgqc18IhKFqOqYfx568thGB7uzkCvq3w6PSfuO/UrNtSX1OsAGWXr7V1S5Io+3nSWIfe5xXbJ47OUj0IuzqLa9Wn0EG8belrI7GHf8Sm1JjBcerIXKq7aHDqyzobGQz3oqz44ztxZ7Oe2GXxjq2aOFSecydfh5NrIpinOkmti1IUiuB051L4p+gA==
X-Gm-Message-State: AOJu0YxgtfnolRWsE5AWPrSQtME2r7j+voX3VOENYEATnhwPyfy2SeV9
	Mwgz4ifZaW31IES/mqKYgPTqjiMbshWU1djPEoUeIvXtVuWN1bp7
X-Google-Smtp-Source: AGHT+IH5SNInb5yZq3Cuj7U8oACNWHmzMuuF2G63X2k2tjaQ/s20PtWq1uTiQglncTLckDH15vmQlg==
X-Received: by 2002:a50:c181:0:b0:57c:5ec9:f5d9 with SMTP id 4fb4d7f45d1cf-57c5eca001emr1193325a12.31.1717763466203;
        Fri, 07 Jun 2024 05:31:06 -0700 (PDT)
Received: from [192.168.42.93] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d8d0sm2682019a12.8.2024.06.07.05.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 05:31:05 -0700 (PDT)
Message-ID: <ff4e0e14-9f3e-4d8b-a2a6-75dfc1f6e96b@gmail.com>
Date: Fri, 7 Jun 2024 13:31:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/14] page_pool: convert to use netmem
To: Steven Rostedt <rostedt@goodmis.org>,
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-7-almasrymina@google.com>
 <20240605214837.44efcc6f@gandalf.local.home>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240605214837.44efcc6f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/24 02:48, Steven Rostedt wrote:
> On Thu, 30 May 2024 20:16:05 +0000
> Mina Almasry <almasrymina@google.com> wrote:
> 
>> @@ -42,51 +42,52 @@ TRACE_EVENT(page_pool_release,
>>   TRACE_EVENT(page_pool_state_release,
>>   
>>   	TP_PROTO(const struct page_pool *pool,
>> -		 const struct page *page, u32 release),
>> +		 netmem_ref netmem, u32 release),
>>   
>> -	TP_ARGS(pool, page, release),
>> +	TP_ARGS(pool, netmem, release),
>>   
>>   	TP_STRUCT__entry(
>>   		__field(const struct page_pool *,	pool)
>> -		__field(const struct page *,		page)
>> +		__field(netmem_ref,			netmem)
> 
> Why make this of type "netmem_ref" and not just "unsigned long"?
> 
>>   		__field(u32,				release)
>>   		__field(unsigned long,			pfn)
>>   	),
>>   
>>   	TP_fast_assign(
>>   		__entry->pool		= pool;
>> -		__entry->page		= page;
>> +		__entry->netmem		= netmem;
> 
> You could have this be:
> 
> 		__entry->netmem		= (__force unsigned long)netmem;
> 
>>   		__entry->release	= release;
>> -		__entry->pfn		= page_to_pfn(page);
>> +		__entry->pfn		= netmem_to_pfn(netmem);
>>   	),
>>   
>> -	TP_printk("page_pool=%p page=%p pfn=0x%lx release=%u",
>> -		  __entry->pool, __entry->page, __entry->pfn, __entry->release)
>> +	TP_printk("page_pool=%p netmem=%lu pfn=0x%lx release=%u",
>> +		  __entry->pool, (__force unsigned long)__entry->netmem,
> 
> And not have to expose the above text to user space (look at the format
> file it produces).
> 
> It being of type "netmem_ref" in the ring buffer is useless.

netmem is a pointer with one bit serving as a flag, considering
mangling it might be better to %p it and perhaps also print its
type (page* vs iov) separately.

-- 
Pavel Begunkov

