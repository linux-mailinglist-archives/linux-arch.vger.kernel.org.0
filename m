Return-Path: <linux-arch+bounces-4788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B290191A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 03:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C7281D8E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 01:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADBF6FC7;
	Mon, 10 Jun 2024 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCjiOesZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BCF6FBE;
	Mon, 10 Jun 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717981627; cv=none; b=kjp7kqoLMOqvg9yUZ6h5R4IfDOZqjHYHGj62Eq2Z0se82uXjSqD+6qJSnAOPXjCntur7M03rX5Ek32aM/tJps9mcG4dB7YoZdvRWEgLEI1UKtcog3TG+K0mniyMrAGBWV3SHqwMJbgEWHUx4lPHErNJuIFfGMzi4yisjKTxX3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717981627; c=relaxed/simple;
	bh=llXkpggXveFU6654/TgOBhqhMle5TsCoJJHlEm1JmUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjr6UX8QYGPxZQs5qF1SiO38FEa6s/AOmrED1bCUICq8vDJcgLR2bPM3Z1RpgsJihGCCt2A380jlaSzWM6HedJzYVqHZQVlVkXG7W1STux7jii+R3IDRk7cvY6BGKCXJDkdnLyV2OJ7jMAMSjGMGXs2bn/Z7VaQ32GgLtKSv9sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCjiOesZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217c7eb6b4so8513855e9.2;
        Sun, 09 Jun 2024 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717981624; x=1718586424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxexgitnAFK64gEkUcCw6okZUu3p3cJ0rX20mz7M3Zc=;
        b=fCjiOesZ/FoUk/lJtJueIFKaaSqSwu/U3zXdclc6HoewgPOxgCmZqN0sG7AP9PPOAF
         o/akSeu0bKNutWPCf+UIBt06WeUc33nmykrGVqr6gURkuiqu6Ui3RvgNILy+P00oLdZM
         gmKEkS2yjb4rb8vgFu4JX2alxWZtQPI9Zhz09VxpMx3tH7T7dKxwk+5oapTlmN2AyhM+
         r9llk5Z09QnUf3ySwDBXoQnD9cj1p4088qXolC0UbeTI2YYelUa0lk00iIzYUMwuQv5I
         yNkR8RsV8EtYTdtTOLXkBf/t4jLlZsEU3TUg/NpvBEWdzNopuVCUkEAeXgPXRz8NFvMl
         0nAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717981624; x=1718586424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxexgitnAFK64gEkUcCw6okZUu3p3cJ0rX20mz7M3Zc=;
        b=dwJCzCb37mzfxPGhzCvGtjwAfNaki/wpNeoI87+zE8VffDks0lo+JkquPHn2U90uvc
         0V7o5EhBio3gXaDV7gElYaJtWxx0xjm+3yhySmny+Ym9FAsj3TthqBWpfGDxMsPUKhx3
         FwCRp9TLSFyfCZRUnWQYBq2ERMmPpxrVySOBLmtVroh/b0qIT9SdHx3e0o3B6YzZCWp1
         T2Mn/b8ptta2jYu8d55I2H8Nb4I0kCY+K2bjEcE7Wq491mvQACcyKlXQFh/hjfBQiAGD
         DBQeSO0TuMBdL/ufgIw4xkb0vKkxR2XsVBmWwZaJQAUOX5doFEEgFfgPo+/nAAaoTdw4
         /i7w==
X-Forwarded-Encrypted: i=1; AJvYcCUuC2Y5EPCENM9/UW+BJVb8MG+NLnXLXAa8emvJxfDgC3U9fxz2QHVUEgny7hABPFmQqr3eVMZVoGdtqmKktVdd1ZeOXw5Fqv9pOtLdRlMaOG7wHMeEmu8KoAWO2LQtrCIp1ZoOVAksn5uihmXh6lJ7d21k0tpX6jVX5g+amvUU9EmRGEd10pU6u8yFQiw7bSoI+Pcfc9A61lExaTiwHpn2K3oq4FCQ5Hib/tHAVDXQCvSD/nbYUwtUZX+HRhQPgPA+KRz0F/GefuAmZbrtaD9UDiCU3I7BejgIUuHDA/fl7yek55DjU3euKxgaBxZDvzlNujn835cpqya7ENNUnkX7MnlWKAI6fSh+CsCgu7Wy0LzzMbYcefOj8w4r54V/QX/oy2wuK7l0/+oSmddXfAVHeRECkxSCBtSL/zMcR8JWclV5JCKA6pp70jodW0uhg7/4QDVvapTGyMncdVlHoSpfG5lrUEaEA8R9UJRiAfGRmeD9b9ET83Dzn6EmyPcJ5GH41fAiNQ==
X-Gm-Message-State: AOJu0YyUiyo+Krd34j4ml7CscD789pgzjaVzI000gbievReELFuSJhej
	Y55s4WV91txoAU0s4oCLTtNpQ/9p0oqRPSdfPx7DXvwdHEdywpFUZGfqmBvx
X-Google-Smtp-Source: AGHT+IGiwrtnS4zP6MNJtTKdG8jEv39z6ImpNSFgjPDVv0bMAQhFuKOxum4ABgd9WZdj4NwTABxwOQ==
X-Received: by 2002:a05:600c:1d88:b0:421:7e76:b85c with SMTP id 5b1f17b1804b1-4217e76b8b1mr27476215e9.23.1717981623544;
        Sun, 09 Jun 2024 18:07:03 -0700 (PDT)
Received: from [192.168.42.136] ([148.252.129.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2c7396sm124424005e9.33.2024.06.09.18.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 18:07:02 -0700 (PDT)
Message-ID: <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
Date: Mon, 10 Jun 2024 02:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Ahern <dsahern@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>,
 Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 01:37, David Wei wrote:
> On 2024-06-07 17:52, Jason Gunthorpe wrote:
>> IMHO it seems to compose poorly if you can only use the io_uring
>> lifecycle model with io_uring registered memory, and not with DMABUF
>> memory registered through Mina's mechanism.
> 
> By this, do you mean io_uring must be exclusively used to use this
> feature?
> 
> And you'd rather see the two decoupled, so userspace can register w/ say
> dmabuf then pass it to io_uring?

Personally, I have no clue what Jason means. You can just as
well say that it's poorly composable that write(2) to a disk
cannot post a completion into a XDP ring, or a netlink socket,
or io_uring's main completion queue, or name any other API.

The devmem TCP callback can implement it in a way feasible to
the project, but it cannot directly post events to an unrelated
API like io_uring. And devmem attaches buffers to a socket,
for which a ring for returning buffers might even be a nuisance.

-- 
Pavel Begunkov

