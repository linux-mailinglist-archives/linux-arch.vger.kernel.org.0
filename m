Return-Path: <linux-arch+bounces-5657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676893DE1E
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 11:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB881C21767
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC3B481B7;
	Sat, 27 Jul 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUfStM4g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADA548E0;
	Sat, 27 Jul 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722072061; cv=none; b=u5Krl2v7gBQz7Djacccc26zUR6l6q7vJ/0xoG0xMoHrlWMHTKQPAjQQcFPQGK+e2f1/GOiFdxz3L5rq8flssfWAdp9WmMz2bliQWVIhjA51jcYmkoef8pbeNeaNmp+pSbR1w07rHrGdCMDFg4Q81wR2ErzizC6RCecw/t5bZ0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722072061; c=relaxed/simple;
	bh=ThQdrmdK+EMALR/mguXOUSvlEXDj9D2TPtTM/KgqOgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJUEN2R5qZyBWUwLOwdDtNq1RCqIqjRyYhJ36vy1SdEr/DwUFRJzE/ioZsF5ofRFtiLfHPXvlSJTBMc7HjkMDdWOUCUJOwGLZuzXFjloYIgLvJ5xkPqnRuOsIrg1lB2VVeulWCpHs0I6lPDKEoAdKodDmANsDDosqM+jdPUmn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUfStM4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB52C32786;
	Sat, 27 Jul 2024 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722072060;
	bh=ThQdrmdK+EMALR/mguXOUSvlEXDj9D2TPtTM/KgqOgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iUfStM4g3uD8cr+8hZS7Lj2VMa31bZNh3aRUWTTbUIUBpEobmm07Z1IEUo/ISgA8c
	 4SOb4h8YK+pWAaDrmL2YMY3rgNTqSqIq+ZetaSz/yewhrsVIIeIULiAj0A061kSb2O
	 GonIbl0dk02BEs+5SSpZOsZDvIwT96vcB294IK8mSF2UdRydmIizpDNrWPbBv304Hj
	 mVREeIIbfQx4KFGQM7ZEWSIZ6DcnVc5T/xRY5GPFmNBZ3Jo9JaKdRDjCLU7UlPmIRV
	 v9tC3H5scWjr9BVs78YeUQUtCxtSJ7KjCtIQDQ1VSuHcaI3Jjf2NoTUP8BGiDDgNOZ
	 s16e21m6madQA==
Message-ID: <1e3dbe67-5210-4b76-b1de-c1afaf4c9fcc@kernel.org>
Date: Sat, 27 Jul 2024 11:20:49 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
To: Arnd Bergmann <arnd@arndb.de>, Roman Kisel <romank@linux.microsoft.com>,
 bhelgaas@google.com, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
 <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ce8c1e88-2d2f-44de-bd43-c05e274c2660@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2024 11:17, Arnd Bergmann wrote:
> On Sat, Jul 27, 2024, at 10:56, Krzysztof Kozlowski wrote:
>> On 27/07/2024 00:59, Roman Kisel wrote:
>>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
>>>  		cur_res = &res->sibling;
>>>  	}
>>>  
>>> +	/*
>>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
>>> +	 * might default to 'not coherent' on some architectures.
>>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
>>> +	 */
>>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>>> +
>>> +	if (!of_property_read_bool(np, "dma-coherent"))
>>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
>>
>> Why do you need this property at all, if it is allways dma-coherent? Are
>> you supporting dma-noncoherent somewhere?
> 
> It's just a sanity check that the DT is well-formed.
> 
> Since the dma-coherent property is interpreted by common code, it's
> not up to hv to change the default for the platform. I'm not sure
> if the presence of CONFIG_ARCH_HAS_SYNC_DMA_* options is the correct
> check to determine that an architecture defaults to noncoherent
> though, as the function may be needed to do something else.
> 
> The global "dma_default_coherent' may be a better thing to check
> for. This is e.g. set on powerpc64, riscv and on specific mips
> platforms, but it's never set on arm64 as far as I can tell.

Kernel's task is not to validate the DT. Even if it was, above code
works poor. What if someone adds 'dma-noncoherent'?

The job of the bindings and DT schema is to validate and check DT if is
well formed.


Best regards,
Krzysztof


