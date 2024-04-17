Return-Path: <linux-arch+bounces-3777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE48A8C04
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 21:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54F91F22CBD
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 19:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708625624;
	Wed, 17 Apr 2024 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThUs+zBK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677724B34
	for <linux-arch@vger.kernel.org>; Wed, 17 Apr 2024 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713381658; cv=none; b=epWBOGfPNo5e7jO8PJdC3ZCIKkZhdKKLssQVSPN1PAWzkJQTS/r/hpVlR+ITaWCgZ8l8NruMg7W3BDp4hjpwpdP9I5tA4gazjBSyNjyRR1+hmfPle83KZex0fWt/KX5HpnVqT30kEgfHbY0y4VSc50q5G76ZTUxmv/ySZWJ5hxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713381658; c=relaxed/simple;
	bh=Z3bCMaGhwbj6srUu4nYse27BveBCdxJ6ls99+RXNmvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcjWPqGbLi88NEe4gZHtBrMenprMBVdffIHDZdJufmEQllRbNm7snUuHaQ1tMXgTtUklw7fSGk8pC+94T4gP9+jqRecXjyDvqTegwjgDxvQU37+UMjK1O58m+sxgNMVfLbOG8W1yfBzUtTpWrBBxc7c8DpFihkpPWHqMkx0C5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThUs+zBK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so146886b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 17 Apr 2024 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713381656; x=1713986456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ORRZpXUfxr9ItRDDr0g7BO8pI4LaWWkmIOzOV1lUjes=;
        b=ThUs+zBKSaponbb58Dod6Z1IGSmlxw4Jpi+7ppdNpbhVobZZfXcwvIlBUzj+QnxvBG
         kwj+XCcOvud8clC5wr/3MmbXBZr+l+OHAbupDcSvfkEJ3ynDAl9BUikip+WbrjFVIg7V
         b774TsOVcobqdEYTexydbT9MDoawO2vPpHum9ZcI7/upqCNARAgNCcqJDVETFl8Kl1nz
         15ASyQBLSEN7sX9YO8AnGppQZsuK9OdYmanZz3NGTL+0ExqiSVM4GRwduLimHtY1Ev33
         dqGoKDpvjR6fycJ61phEwiwgfKsw5w4ECcPBz8jOYtj5dpK/yo6cPx8cwSnUIAi2vQKl
         k4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713381656; x=1713986456;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORRZpXUfxr9ItRDDr0g7BO8pI4LaWWkmIOzOV1lUjes=;
        b=Y/wrLxn5FIojkXdi6AKjtOYFXrZLS+Te+Gp6Ak62VdHRvo8tiqepZb+13aYN+P3MFi
         Wo2+Xl/XeXT/9hjQcu+IBnl0E6E/zTnckgO/ybxuttdHgRfzNQVzaxnS3M7aV163lISW
         YUYuSpUlBBtmdG6kQGUu8fZMRkXokO8Ap/FsHCJHs2lWmqpk7avCLuK76qv8pCGzAe48
         RbEdgrnET4JcTU33ZKvz2nwE/BWZPIjW9aNg+UyRA+JB4O5pkEWjZaxVGrioynTFhQ6X
         Ht9BLOGEB+8andC5Y4MCrsaBO4FGwtfMLGPdAhw9QbGUlE3cXXlX4SDQmcfvvGeALQSW
         KAJg==
X-Forwarded-Encrypted: i=1; AJvYcCUdGgdMlCh/mNb2hDB+0qVU4tuIvQZgfwvhEEY8aTie7c8/X7rdEYx2Po7WwQevGbdjEwflK6wUAyHYrXxN5FDkmWyiUkmXwcK7Qw==
X-Gm-Message-State: AOJu0YzorVrjZzCZ1o69Vfvfe3A0Eh8vDG09t02RUGYcluN+5P0DFVN7
	VNQHmPHKJ22HfxOM+B3lGK0FJPGaeHVtYOL9OnrPY5Ca1W+PEBpSfHQKRKnei7s=
X-Google-Smtp-Source: AGHT+IFFegkq8waqKyMERwq6fCuZal4ckYIGZjxrkGrrejjVKhdDcv8GCWbIasobPrTueNDkPh41oA==
X-Received: by 2002:a05:6a21:27a8:b0:1aa:5f1f:79d1 with SMTP id rn40-20020a056a2127a800b001aa5f1f79d1mr709847pzb.1.1713381656202;
        Wed, 17 Apr 2024 12:20:56 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.145])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006ed045af796sm11536pfq.88.2024.04.17.12.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 12:20:55 -0700 (PDT)
Message-ID: <7eeef2c6-7375-4e41-aad6-ca0a39e95e2e@linaro.org>
Date: Wed, 17 Apr 2024 21:20:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 30/31] kvx: Add power controller driver
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
 Janosch Frank <frankja@linux.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: Benjamin Mugnier <mugnier.benjamin@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-audit@redhat.com,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-31-ysionneau@kalray.eu>
 <f69adaf2-6582-c134-5671-4d6fd100fcf1@linaro.org>
 <c20b433f-97ef-7faa-5122-9949af41f2fb@kalrayinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c20b433f-97ef-7faa-5122-9949af41f2fb@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2024 16:08, Yann Sionneau wrote:
> Hello Krzysztof, Arnd, all,
> 
> On 1/22/23 12:54, Krzysztof Kozlowski wrote:
>> On 20/01/2023 15:10, Yann Sionneau wrote:
>>> From: Jules Maselbas <jmaselbas@kalray.eu>
>>>
>>> The Power Controller (pwr-ctrl) control cores reset and wake-up
>>> procedure.
>>> +
>>> +int __init kvx_pwr_ctrl_probe(void)
>>> +{
>>> +	struct device_node *ctrl;
>>> +
>>> +	ctrl = get_pwr_ctrl_node();
>>> +	if (!ctrl) {
>>> +		pr_err("Failed to get power controller node\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
>>> +		pr_err("Failed to get power controller node\n");
>> No. Drivers go to drivers, not to arch directory. This should be a
>> proper driver instead of some fake stub doing its own driver matching.
>> You need to rework this.
> 
> I am working on a v3 patchset, therefore I am working on a solution for 
> this "pwr-ctrl" driver that needs to go somewhere else than arch/kvx/.
> 
> The purpose of this "driver" is just to expose a void 
> kvx_pwr_ctrl_cpu_poweron(unsigned int cpu) function, used by 
> kernel/smpboot.c function __cpu_up() in order to start secondary CPUs in 
> SMP config.

I might be missing here some bigger picture and maybe my original
comment was no appropriate, but IIUC, you might now create dependencies
between arch code and drivers. That's also fragile.

> 
> Doing this, on our SoC, requires writing 3 registers in a memory-mapped 
> device named "power controller".
> 
> I made some researches in drivers/ but I am not sure yet what's a good 
> place that fits what our device is doing (booting secondary CPUs).
> 
> * drivers/power/reset seems to be for resetting the entire SoC
> 
> * drivers/power/supply seems to be to control power supplies ICs/periph.
> 
> * drivers/reset seems to be for device reset
> 
> * drivers/pmdomain maybe ?
> 
> * drivers/soc ?
> 

Bringup of CPU? Then I would vote for here. You also have existing
example: r9a06g032-smp.c

But anyway the point is to make it clear - either it is a driver or core
code. Not both. The original code was not looking like any other CPU
bringup code.

Best regards,
Krzysztof


