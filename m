Return-Path: <linux-arch+bounces-4943-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B890B3C8
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 17:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D9CB29B5C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBC19B3C9;
	Mon, 17 Jun 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH+kglPm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90A1AC247;
	Mon, 17 Jun 2024 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631744; cv=none; b=RfjjhFZVOtOd6voTF6HIlEs0tVuNu4DNF263aL68mXp9NKoP7Naw5sTtnazLgh5myfC7nCcq0g/Yp/phKGPKsl+EdYaq1iGmg5wM9ENf1TgVapBGzadofGhGqrvfNYZWKhIyGXd484VmGBTduSCyjHDvV5JwIJi4cWHVLL47azM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631744; c=relaxed/simple;
	bh=XybUM66pzGC133M0KdH1g4ly7r8A7aRbNbucQeFTvoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVJwPXDpo4cruv2WUbf9woXr/J8/1u/8dgFy6hrZt1Y9wwGd7cNwT1mWjBlDpBWR2WvV/8eD9j0NPtlY9DhaiganXQoK8tDZWv5zDRgkoc7bVt1z7L0+EiYW67N/0QQsrvkokFZt+Qi9GPMCFgBUvbvFN0ydL5fPrTejK9tKfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH+kglPm; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec0f3b9bb8so28211021fa.1;
        Mon, 17 Jun 2024 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718631741; x=1719236541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLq64Jy1y7qzLgBK9Is0sT9q7OKvIVCzHqdhb6LFXBE=;
        b=PH+kglPmYmPRJdM1VACdOF/ZtV91wTm/HR5WjlXGN+4UsLQtOg4S2Im+ZXgjyWRQZE
         QoG7gLHQIIHNi5FWP+EY24AL8ahgatYlEONYAKtuvl2Z01qpdx5l6MP1xUPfLj/iaw+z
         T3EYF8ftty5zuLTidXsaF5GwhKd/VUR6YBnkF6Ent/YjnXuLKqkagOlw7vDTPRLb/CD/
         4+2DXuxstxEdeeK/R6K5JKD+se3wlqeGa5Ks3VElvpe5UHxM+ngKEM7hlfuuZYygTf6V
         gPCCFo/SVYdwuKsxs1jqFWZMX4DReWbWIUPyFKjaENy/Im89+xvCtNE4F3wjY6zDEHVZ
         9GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631741; x=1719236541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLq64Jy1y7qzLgBK9Is0sT9q7OKvIVCzHqdhb6LFXBE=;
        b=Smpn7pPN5JUEqj+nrQOwX9jiy7meyfYrj0uzOBtrxgDcB70BWDeMRmt0yVqQ5+UQaN
         IKwxhdk6KEyWYZc+h4h9SOUrpvSPgggiz6Yj7NX2Xma+i98qBG2nbHI/6Fs6lMbjUoTA
         xLSisZI57YqNgQLgkLbcPgEdfkHU4SDSXWoiwmMh7ehKb86aH3aJb6RgInaqyURxTjSo
         Dw0oszm4AYY2RbjNMVZPqnQ8HSJY/CgH3rn3uawpk5j5oHik/k6yL1K8aCq5KFRqggvc
         FunVP51Hxtv1c6mvjUJzS0brZuaptd4qLtF1/+2SWSC8xkSdb7gIwPx1S/5pFTzJ4Rbl
         5DWg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCtEAUQP/OpgC5DwAG6tWlpZCOaeGZ5rA9rUn8Dag39pdmnt1T7mBOFeS3gPiTzBOSlZY56P9lbWqANISI6lqnD77CGlKYJyhIsSKXM84gsrQAVMpS7qLtBGfrrsoUwYoqDQYpdqaNBl6zRxeGbwabDC11NEnRv3YgJ72Wqsb9trBKqJhaqurpLwd5NbS5tBhxJ1/+8rd94aaZB/SfIsMBuxlFK+XosCaTdi3wNU0Ioml7RG+jY814LPCsmFm6/AXsORCOUU7pW9BqgRFUpD8MqvAm69GN6snTxG2tc56ydJY3Rt+ZOxlr5P3GadvWHO86Fji0e3CLBVeRXdm3rCD4fFRMuATOf1qnTJW14kJSnCxO3ldAwP4rVkKXFl1/GciJB7NjbdtInRbuWaaEDmamkuz7eXv3Sf0bSxehGIrJ1MqXpowkvrdtu2dPKfzRofePgiR4v6Qx3dQAsvUPC5W2+u7wynkpu4W5GrOPSamSt3u9yxar/JPHdT+9mMWBR/VMxyUQnCE21XaDb53Lm9EeFrRHpxF3OcQXLIxZYiYnavVL6skXDZg
X-Gm-Message-State: AOJu0Yx17SlP6Qcm2/FmZNNXpbJQr5CSMMZqvLHRZE3bHLAe4iDj3j6Q
	U4GRM9cLX2+SlbyS6ytnWLVU9fqwaLjh0Dwg+JjDio2rI7k9E8lC
X-Google-Smtp-Source: AGHT+IGqHzJEUi1a7luh9jW8SHVbZk8TdcfnJo2RG3dm48EiRHLhDHgyG2l2mawW7oSV97i58gBdzA==
X-Received: by 2002:a2e:a443:0:b0:2ec:1a8b:c380 with SMTP id 38308e7fff4ca-2ec1a8bc478mr51361181fa.45.1718631740813;
        Mon, 17 Jun 2024 06:42:20 -0700 (PDT)
Received: from [192.168.42.82] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce12fsm6461432a12.7.2024.06.17.06.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 06:42:20 -0700 (PDT)
Message-ID: <8bc8c6db-e25e-42ce-8cd2-be50b4a735e2@gmail.com>
Date: Mon, 17 Jun 2024 14:42:21 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/13] netdev: netdevice devmem allocator
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-5-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-5-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> Implement netdev devmem allocator. The allocator takes a given struct
> netdev_dmabuf_binding as input and allocates net_iov from that
> binding.
> 
> The allocation simply delegates to the binding's genpool for the
> allocation logic and wraps the returned memory region in a net_iov
> struct.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
-- 
Pavel Begunkov

