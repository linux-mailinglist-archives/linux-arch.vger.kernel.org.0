Return-Path: <linux-arch+bounces-11286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C133A7C290
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E902189A94A
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CF2192E2;
	Fri,  4 Apr 2025 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="Hl5AQsdv"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AAA217730
	for <linux-arch@vger.kernel.org>; Fri,  4 Apr 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788120; cv=none; b=oNUW79JM5QkqNq9AwGt+H1oUUvtu2/cKepESxr+CLnC3mVv7xpeLb9e3qAvrh+Td/JYfXTavDoeIR7n/CaHQaWwkXgpOKHrDbE4b7YOaTCBBzcRygSq03XcTrygDNyl44oSYvvscbZN03Gd/xzwW6n+YNqZMA4UtGnLWW0Df/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788120; c=relaxed/simple;
	bh=4qZMCacvIW/TYVtR6WWATCEGDTnUzOK2HOxQ7ZgRspo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGvZG3WrVwQKU2/Ad8IttTLC2cXb3HmwMJC7ANv1y0bXxqIMlbapURipsLGYaMwNRO2r8XwuCkQ0dUhr7fefoz/apFj+mcBq0ACAvfNKKRsQ/qcGb+HDAppbbSP+HKlGuHsGorbgbPZQxFgJYpj25lls67XCh2kvk8PymFFTrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=Hl5AQsdv; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <b3f8e641-9690-4792-974c-c895d2e4531a@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743788106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N2/fZZA4UL9XJIEHQ+/bBTVFu2hgzKlDY3S+eN0cDvg=;
	b=Hl5AQsdv2ftxLfGgWfsSkVOMa+4AgcivN/fnTLwoWKanl5iGKyiragWuaSPdPfjF2x0FGX
	zseE+ZwxVKLbsoZn+le3RmgYE5pbbj9YdfFnsF9fi1glUuSZL7ESp/Jj2oD12892ktWqCv
	7q+ttQIaUabPjTD7bOfoTHuqFbLqNp3+wBi1uMKoNw6Yldd0Pm+XzzM8rvipfZiyKAe2cW
	0zSRTFJ8CN1xo3GnysgVRKLiRiSEs/Gu8EF2P33sv6Xxi0we/InQTI8PC30T8e50Dt/5pC
	WdxOGZ+Q0tTMDcEw/hvNvZnLVYZSbFAdBf/uxfZ+BN547fsyn1I2soTwOFQRUg==
Date: Fri, 4 Apr 2025 19:35:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
 <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas <ignacio@iencinas.com>
In-Reply-To: <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/4/25 7:58, Arnd Bergmann wrote:
> On Thu, Apr 3, 2025, at 22:34, Ignacio Encinas wrote:
>> +#define ARCH_SWAB(size) \
>> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
>> +{									\
>> +	unsigned long x = value;					\
>> +									\
>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
>> +		asm volatile (".option push\n"				\
>> +			      ".option arch,+zbb\n"			\
>> +			      "rev8 %0, %1\n"				\
>> +			      ".option pop\n"				\
>> +			      : "=r" (x) : "r" (x));			\
>> +		return x >> (BITS_PER_LONG - size);			\
>> +	}                                                               \
>> +	return  ___constant_swab##size(value);				\
>> +}

Hello Arnd!

> I think the fallback should really just use the __builtin_bswap
> helpers instead of the ___constant_swab variants. The output
> would be the same, but you can skip patch 1/2.

I tried, but that change causes build errors:

```
undefined reference to `__bswapsi2'

[...]

undefined reference to `__bswapdi2
```

I tried working around those, but couldn't find a good solution. I'm a 
bit out of my depth here, but I "summarized" everything here [1]. Let me
know if I'm missing something.

[1] https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/

> I would also suggest dumbing down the macro a bit so you can
> still find the definition with 'git grep __arch_swab64'. Ideally
> just put the function body into a macro but leave the three
> separate inline function definitions.

Good point, thanks for bringing it up. Just to be sure, is this what you
had in mind? (Give or take formatting + naming of variables)

#define arch_swab(size, value) 						\
({                      						\
	unsigned long x = value;					\
									\
	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
		asm volatile (".option push\n"				\
			      ".option arch,+zbb\n"			\
			      "rev8 %0, %1\n"				\
			      ".option pop\n"				\
			      : "=r" (x) : "r" (x));			\
		x = x >> (BITS_PER_LONG - size);			\
	} else {                                                        \
		x = ___constant_swab##size(value);                      \
	}								\
	x;								\
})

static __always_inline unsigned long __arch_swab64(__u64 value) {
	return arch_swab(64, value);
}

Thanks!

