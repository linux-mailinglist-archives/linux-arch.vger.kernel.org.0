Return-Path: <linux-arch+bounces-1899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877AC843BE9
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 11:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3982528638A
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8169969;
	Wed, 31 Jan 2024 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPC98Zp5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147269D2A
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695959; cv=none; b=g0b2fzE/17tvocSbPiVvCwVkENIpw77L57d9eUODj787cmu6/EKdqe7Yus/stJenWRQel55r9i41a1Ix5xJUR0vKRVOmvFRkv4hO6azvG13YKl+eHGMW4U13Dy0jaSqNqRP+mynU/eV8QkNxQiZc4N1j/rbYAHd88B0cSdsOI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695959; c=relaxed/simple;
	bh=nv5wJpKycfGiQ4mJFb7n+bEsRPMw+mys3ZONIKMGZjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvLwyX8QuOnYGW2bG+oorj+J7oyOuL4lvV882SYFE5AZNQRhMjehlRc8867AEQGOwuNJpnPp/0wbcchyZvloPa6R2fpYQuUnNvopTre39duREK+2TL5s+uYwj2eFejQJvrjWdzM1+DZKwiDAC7mdHbUvAKdXhG68VETBASuY3GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPC98Zp5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so705032166b.0
        for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 02:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706695953; x=1707300753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVbxQinrEqswh5zspngm/qhQyfWoDB43WXLHzJl9zEw=;
        b=wPC98Zp5HRTOKTBUzkyILR/Qn/HF2g5OBdk+gtgt1SRKrWkHoARd5bPwMoqzLs/hD6
         iG0uDz2/bdHUJkH9Mmy5z0IBPbQ+GlYqMZ507nXj0rl9eHOPDQfQlbtVunnPt3+6XyfD
         Jv6HhEoi54f5FX4hZgRlPMGYBnT5TmZS9l+B4+jotCwcPXxlNpaOC4bpr68i4haRmFBh
         zoedeoufq4T5yUHPPbrJzpfsjafyEretkxwbTtzlEAogDYeUqUKwW1JBeoDrKv3dQcJJ
         qeGAZfR7sRtgXAAnyGQrKHMGPbq4wxxjXGjX8bnByJK/jC+eItOh9WMBw4ljsTOf36+s
         +svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706695953; x=1707300753;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVbxQinrEqswh5zspngm/qhQyfWoDB43WXLHzJl9zEw=;
        b=H4oYr3oCCNb7Yr5ZQb30pn97yW+zgonQKuwecT66BrUVuPektrju2RSRt/N9JnNLzF
         Cpikj6uQY5mQOo/TGtAx7xrn45f4pASLyUeOxwFAL9uinoNk43Hn9lsE9Q/8WEblnjk9
         BJLtNFZllKe350nViDp8TWemKy4YF72/irD/M4jQURfak1f+napBgdqo9H7jiBszgu73
         6wjZIbE88AtLRED1yJGf0sLrl1rJgWlBptYk5gEtX9gsr+zmXfFV25U9DNykjB29St2Y
         VvOEtg6cJBJrGP1gzpDM0Q48i3YxkRSm/h5gGwkaq+syL76g8NJc5HlHalHMUUJ/TCod
         pkWg==
X-Gm-Message-State: AOJu0Yz9O7zXiNjxdl9BY9O/JXc2ycdAmHB6MyRq9jTfaoXueK7M36XB
	LZlKW2ZE+j/z/FrRTzQ50nMZDKK1ZLymlkjKB+nDu1RpC3asXRgsEGDlIoL9ADU=
X-Google-Smtp-Source: AGHT+IG0ldG9tCGI3ca/halEauDPGz9QmAEuZycnuZMyKBlpMivFD8YGbuuhUWQDcVNR/SHMcqrVvw==
X-Received: by 2002:a17:906:e215:b0:a2d:79b6:bbea with SMTP id gf21-20020a170906e21500b00a2d79b6bbeamr823941ejb.64.1706695952952;
        Wed, 31 Jan 2024 02:12:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; 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
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3689bde88esm188662ejc.153.2024.01.31.02.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 02:12:32 -0800 (PST)
Message-ID: <8a15ae5e-e949-4177-9737-84aa471c300d@linaro.org>
Date: Wed, 31 Jan 2024 11:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 31/31] kvx: Add IPI driver
Content-Language: en-US
To: Yann Sionneau <ysionneau@kalrayinc.com>,
 Yann Sionneau <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jules Maselbas <jmaselbas@kalray.eu>,
 Guillaume Thouvenin <gthouvenin@kalray.eu>,
 Clement Leger <clement@clement-leger.fr>,
 Vincent Chardon <vincent.chardon@elsys-design.com>,
 =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
 Julian Vetter <jvetter@kalray.eu>, Samuel Jones <sjones@kalray.eu>,
 Ashley Lesdalons <alesdalons@kalray.eu>, Thomas Costis <tcostis@kalray.eu>,
 Marius Gligor <mgligor@kalray.eu>, Jonathan Borne <jborne@kalray.eu>,
 Julien Villette <jvillette@kalray.eu>, Luc Michel <lmichel@kalray.eu>,
 Louis Morhet <lmorhet@kalray.eu>, Julien Hascoet <jhascoet@kalray.eu>,
 Jean-Christophe Pince <jcpince@gmail.com>,
 Guillaume Missonnier <gmissonnier@kalray.eu>, Alex Michon
 <amichon@kalray.eu>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Shaokun Zhang <zhangshaokun@hisilicon.com>,
 John Garry <john.garry@huawei.com>,
 Guangbin Huang <huangguangbin2@huawei.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Bibo Mao <maobibo@loongson.cn>,
 Atish Patra <atishp@atishpatra.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Qi Liu <liuqi115@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>,
 Janosch Frank <frankja@linux.ibm.com>, Alexey Dobriyan
 <adobriyan@gmail.com>, Julian Vetter <jvetter@kalrayinc.com>,
 jmaselbas@zdiv.net
Cc: Benjamin Mugnier <mugnier.benjamin@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-audit@redhat.com,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-32-ysionneau@kalray.eu>
 <995eb624-3efe-10fc-a6ed-883d52d591bb@linaro.org>
 <269edff0-d989-4ac8-b0c3-bce31283806b@kalrayinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <269edff0-d989-4ac8-b0c3-bce31283806b@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 10:52, Yann Sionneau wrote:
> Hello Krzysztof,
> 
> On 22/01/2023 12:54, Krzysztof Kozlowski wrote:
>> On 20/01/2023 15:10, Yann Sionneau wrote:
>>> +
>>> +int __init kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, void *))
>>> +{
>>> +	struct device_node *np;
>>> +	int ret;
>>> +	unsigned int ipi_irq;
>>> +	void __iomem *ipi_base;
>>> +
>>> +	np = of_find_compatible_node(NULL, NULL, "kalray,kvx-ipi-ctrl");
>> Nope, big no.
>>
>> Drivers go to drivers, not to arch code. Use proper driver infrastructure.
> Thank you for your review.
> 
> It raises questions on our side about how to handle this change.

I am sorry, but responding with one page of hardware description is
totally unrelated to the code I am questioning here and does not make it
easier for me to respond. I understand that you want me to learn entire
new KVX architecture to be able to provide good review, but it is just
not possible, sorry. We all have quite limited time around here, so we
all expect concise and precise answers.

Best regards,
Krzysztof


