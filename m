Return-Path: <linux-arch+bounces-5225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D700924185
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF811C20A8B
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAB41BA08F;
	Tue,  2 Jul 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KApZ9dfw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025F26AE4;
	Tue,  2 Jul 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932203; cv=none; b=d3fOirZqzJF2OhkWa5wd6HTFB6eS/eg/e8W0WyTiOZvQvzGShxErldMfZ/dA45dj/wfnZFSIJSNKXNOIvwx/kdOj4NrtvdJ8mKEtNx+tpLhLUWSvjFubq4CysKRqy5MkPgGGNG8b2zzsxDLYd6W9TwFEKfJDfmUUYJ2Lf07bdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932203; c=relaxed/simple;
	bh=9V2ogH/SJYyTvtEmDrX9sYfvP7KhZMqjjyAUZui03Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gI8mWWGbTd4R6AoBBG9PQEDCrU2ne6w+1+wlO2VT3WX9dpEzigvECMTEDNIUN1w4RyRGKCtSXHdF4dErxJ/a39a1jWkXmqhi94YpXZMm7HjxwTvTKuhCgfEE6478VmfhXS/Al85URLO3K0tSIeKZXMtG4In11PvYLrXUqQf2j0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KApZ9dfw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3674e1931b7so2933342f8f.2;
        Tue, 02 Jul 2024 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932200; x=1720537000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1O/aJn8vsv/arvmXTxuQEie1if3A4RdufXewAuUWOyI=;
        b=KApZ9dfwvzVnKiuOm9T1OgXa9iCOaCMVEyJV0e9u/XuP6A4l9Hh2or+IAFfUSY9tMt
         ti293czuPHA8fRJKTnR4+IFpQJE31ORZlTkdDyfuA4nw+rwbUoJEUCDsJwTNSb1ZXa/x
         2tFhZ15Erjfld0Sd61qKhm+kaJOx5selXpooBdOnC5ANJKtHViMjH4vkxkzwcrUmwsJi
         c+8vwx4so+Q2IuIWxVLAkVV6Xv155bD6LrBiekpwdTd24efdBHD9yOKS2tfhWqvRmI7P
         VxImEq2OCsHoHZ30h5isl/B7MMDxlEShQ40Yj4BIahBRznpPI3gztNMXJnIHcLoDK8Jl
         7YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932200; x=1720537000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1O/aJn8vsv/arvmXTxuQEie1if3A4RdufXewAuUWOyI=;
        b=Df8p3h3JXmk32MEHC/RhXJJ/4mFfDoNpAxveojhCcZC8ZqNiUpMJeq81SX1B0Ta1lm
         mppIWRrugzqiqvG2dtySULJSZLMmE7QYWIK9d19wT++iTB4aTMoGS169q2DR1/fOUX75
         oJjDn8nwcBvtEqjRfpac5c+7kNSoPShIYFOU9jF9X7Xyh4/MzJMd35wmgxCJOkA4oy/G
         2J5y06qafQrJecC77wXOkrpLLn96s0i3UL9lvExINoE99080MxRWm5Xa0Bkx+2iwtXD1
         qVRCMK+UmBWp7i7eYzIjYANzaWVYPQXPSmLJonmnILXoxlR3AoV+dposSjMFtVaRBJWt
         t/RA==
X-Forwarded-Encrypted: i=1; AJvYcCV12VrEq+8kMO637fS1R6Yq1e76tKqFoWRXkP5v9CekRcoUC0g/M9AEARFFLrokOP1NZ38WgTZ0onRQjcqG/5RJxNLJzO56LhV19f5UHPq+kV4VVtu/qVzpEZ9Qujne3dQ5/PYnI1MbkaBrHLidvW2Ebktclm0LXg65ThfVc1gDTSDLsUM5yXjRa8MXw70resFUSgVe6tcaATTRor36IpU31Ymy8zKtbCZKRURFoiFnsiXbXJsP05nzTYoC1GfdqXYcnNiJZQZstKiJaYH9JxbP7wnHxmx8V8UIr1xS5W8IpO+uRDpZbsHjR9Ho9Q6ivh0YifJ31UAfPkOsSFKd4IjVjrswM24Qdm9fCkhwTZPblzKGFmvIEbiYRKTQcxFL/AO2nhAyWBESOiVysZoMj8mMNdwW7O0yhkEpfpUljudvIgKwfvaoQbJYb03GjMt/wgNLAurWn0MaUiOhjYepVRz/e9WWD2UwVQ69s1ru0+AXikLpPcW2SSE17IV1Dg7crWGZEojUww==
X-Gm-Message-State: AOJu0YxxrjmqmZljpzJtsUV94x11XlFj7T1NyosCLN3dI6Kd/nMyJ7eb
	1uxR/dbt60GY/eZFtzO0tp/DGWJ6Y0+p/S7j/1Fucaq6lFO08Xa9
X-Google-Smtp-Source: AGHT+IEDS9QP4kQhr2RPA2dvCTTRVUMX3IHs1vr7q4LcbCSOZVwNq2UlHJCaLHCwFYt+fP7HWAZGgA==
X-Received: by 2002:adf:f98a:0:b0:35f:b03:bf45 with SMTP id ffacd0b85a97d-367756adf42mr6081448f8f.24.1719932200413;
        Tue, 02 Jul 2024 07:56:40 -0700 (PDT)
Received: from [192.168.42.74] ([148.252.146.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb92fsm13572218f8f.88.2024.07.02.07.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:56:40 -0700 (PDT)
Message-ID: <4db52d39-24ad-4034-882f-9336717b4706@gmail.com>
Date: Tue, 2 Jul 2024 15:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 11/14] net: add SO_DEVMEM_DONTNEED setsockopt
 to release RX frags
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
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-12-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240628003253.1694510-12-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/24 01:32, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done
> reading the devmem dmabuf frags returned as cmsg. The kernel will
> drop the reference on the frags to make them available for reuse.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Same, lost tag from v13

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

And, as a follow up, would be great to clean up the loop.
Helper functions and "continue" should help to bring the
indention down.

-- 
Pavel Begunkov

