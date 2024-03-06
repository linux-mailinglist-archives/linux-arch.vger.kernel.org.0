Return-Path: <linux-arch+bounces-2837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 508888739F7
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745FF1C21777
	for <lists+linux-arch@lfdr.de>; Wed,  6 Mar 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED120134721;
	Wed,  6 Mar 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjNVNX0r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464715B03B;
	Wed,  6 Mar 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737181; cv=none; b=exHvIKQEjOU/Anx+92tAruNGmEoXaQ9p05EYkUo1GnLmeCKugaeW+XEOuxJRgsuKErsFzI921N/vCrkGp9VOEWQaHg0QvphaIdJx48q94FG+H09FK2QuCF74R/xUvy51n4T+3uTVyj7/8llkXxXXcOYdRdyTJn2tWFs+JuT7Wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737181; c=relaxed/simple;
	bh=wWfmjk4jJc0azJs5MAtNsWXdDU8hGOFf9AsXbM5PzFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9HIK7KwUWCIBBvk2oQ4/bu4dLJ8eSjckAyDvqFfTJSlAnZAQj3WCCCEoapzCoGF1GTXEgZx7xVpLuYOEfbU5xoasLPctpm5RaDM6PeUfLGNSaNbM6Cu/SgkmVhr4feGrX+JXm0lPC0Dg9eMtKkqIglWhe53AzO6Li+1Jc1AaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjNVNX0r; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d153254b7so4708756f8f.0;
        Wed, 06 Mar 2024 06:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709737178; x=1710341978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3KTBSf8CRlcIZfoKRwDp/o4UHKfshbIbaLHqnkKL/Q=;
        b=XjNVNX0rLvgSbah451dBNV75h6uXG0ZSzZudNMr8hTabBjVjKCAM93NEiCStHOoiO2
         VKDvgZ7Mh4tODw4Ei1m3tfOw+Eq4fnvrzWch5lACXDJt/wY34D+TNLirBgL6eLQ8EF66
         neuWhiqg8HoepNaILTpG+sNNFeZCpI4620BGmxec6/srCDCbYnQgQsRMy5RJQueBWJal
         9CHAa8TUf/+CijO7NF3taJwT/tUeMMi67czTFE1p3g3x8w1pAKQ9LvBu8jrKrydymE7k
         24l8K5WFHlKSt1r6C7OcxDfHYRqflw5twj4VyE9NoZyS2KCVDZEN8VzDgo/SC2io5F96
         JpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737178; x=1710341978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3KTBSf8CRlcIZfoKRwDp/o4UHKfshbIbaLHqnkKL/Q=;
        b=QO/Bixoif5RCybFujEyiyjtfJLT12vAPp3c6aOhwdweXF9sMvA5fM8+XaMyWm1jHpB
         xuna0K/5KRKUOBOokt9SmFLTU2CcPKY7V01J+VNANBUuV3DtvXjjsKmMEClz1ZcIq/T8
         ucGBO6rZkKDgyul3NPVOYxyM24OZ5xUKN0tF45dS36+BkUN2T+Y33U1N//pKHEeDwcnl
         fr9+dYVQX5BpPcYvuayWCU3ZEr2cqMXy7d+SHDcuJIJCVkXCpFrNgYjDoeYk0HSgu14Q
         z70+GX/ifYbNQNzzwVKd+VMZoT4p+5e0EsJCCLrINScHRnBh6AzR6jiY6veloFmiCUnD
         fRbw==
X-Forwarded-Encrypted: i=1; AJvYcCW77HW/Q910jJXLnbJPA3p4ZUT/zTGFq5L7KuSvYaBeDODRUmtsnYHqhYGrI7fLBvCCd3W9jROaApfCr7Ic8LWNuLRb0V6VHU7FqCpSDwJyr+dZPZu9+hyCgFKuRcE3XFJLJRijwnXAxCpKHojQnFWUxiQzcnP0keGkOR61wj4tEkPyO1TE0aGQAKTNUbUrzhE5mprTob1BAhT5V/exiCE59j7ovgbD/ch7Wbk6gRAFOrdZlic/oGk4NGphyNOmPyPEkP7KLfp6LO8sMSllHF+1k447VV5SIPNJqbtUod7/9DuINK6BL2rX8u+DmiBixAlxghGXO09rwv8d0qmQlQdc59O4mL0/AMN1+YXlKoeUL6Ek8p8dcN+9AhbHl+9XjVOMUGjjEr2tybz7lu9nDoDSNhUP4XBVNBL6fsnEw2wwcvHKtOEK56KjfNpJS8//cFbsnOZfjkbWgiVmYVDlwaqXLcBiuD4R8YA4gyJU9w==
X-Gm-Message-State: AOJu0YzgCutdh7CIapmyelX2J0pTMqFyhM17kcSRg7DwhE6oPEqesA3U
	n0wE25iyRPdNhI2Oi0qkjTj4XuXY4TLSmaQItIDnvT6SKrkLuN7Z
X-Google-Smtp-Source: AGHT+IFqyav+emKmFSd0bSOzFBUFGtQwTCEQWXrbswWn1syNw+koJNQ7CeSt912Wgj47JjnPQnfG0g==
X-Received: by 2002:a5d:6b4a:0:b0:33e:1b80:ae95 with SMTP id x10-20020a5d6b4a000000b0033e1b80ae95mr10870719wrw.11.1709737178481;
        Wed, 06 Mar 2024 06:59:38 -0800 (PST)
Received: from [192.168.8.100] ([85.255.233.174])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d58ea000000b0033d4cf751b2sm17698519wrd.33.2024.03.06.06.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 06:59:38 -0800 (PST)
Message-ID: <b85b36bd-7082-47a5-bf46-50cff8eb60be@gmail.com>
Date: Wed, 6 Mar 2024 14:58:38 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v6 09/15] memory-provider: dmabuf devmem
 memory provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
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
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-10-almasrymina@google.com>
 <383c4870-167f-4123-bbf3-928db1463e01@davidwei.uk>
 <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izP_PzDJVxycwZe_d_x10-SX4=Q-CWpKTjoOQ5dc2NSn3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/6/24 02:42, Mina Almasry wrote:
> On Tue, Mar 5, 2024 at 6:28 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-03-04 18:01, Mina Almasry wrote:
>>> +     if (pool->p.queue)
>>> +             binding = READ_ONCE(pool->p.queue->binding);
>>> +
>>> +     if (binding) {
>>> +             pool->mp_ops = &dmabuf_devmem_ops;
>>> +             pool->mp_priv = binding;
>>> +     }
>>
>> This is specific to TCP devmem. For ZC Rx we will need something more
>> generic to let us pass our own memory provider backend down to the page
>> pool.
>>
>> What about storing ops and priv void ptr in struct netdev_rx_queue
>> instead? Then we can both use it.
> 
> Yes, this is dmabuf specific, I was thinking you'd define your own
> member of netdev_rx_queue, and then add something like this to
> page_pool_init:

That would be quite annoying, there are 3 expected users together
with huge pages, each would need a field and check all others are
disabled as you mentioned and so on. It should be cleaner to pass
a generic {pp_ops,pp_private} pair instead.

If header dependencies is a problem, you it can probably be

struct pp_provider_param {
	struct pp_ops ops;
	void *private;
};

# netdev_rx_queue.h

// definition is not included here
struct pp_provider_params;

struct netdev_rx_queue {
	...
	struct pp_provider_params *pp_params;
};

-- 
Pavel Begunkov

