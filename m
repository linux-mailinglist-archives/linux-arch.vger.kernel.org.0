Return-Path: <linux-arch+bounces-11285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A07A7C13D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 18:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDC41884F53
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A8202C24;
	Fri,  4 Apr 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="CMoZfn0b"
X-Original-To: linux-arch@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F48F40;
	Fri,  4 Apr 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782767; cv=none; b=CJKizr5wCHp0mpMjc96P3UTVfvaCy1OA2cWdl+MZ3lth56QDfshd4ikhTe0Gby5BABCbCaOQSOaemui0ROwrU8YL4o10IXTPxTanC+GdgmIFVjXx46EbN3XJDaYFlwbFy7A+7pczIInNwJ8/Jt5Aqm0eTspzuDCrJjpte1tS6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782767; c=relaxed/simple;
	bh=h0m2ltk/yahnMpwzhBU6LS7s8iVqs9Trjicgv7I68qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLD+7s3/M9qi9bz4yfpviGr3qw4lX04BeEn6mrLCCOPUTEXizBMz3nhBJrg4k+A06X23YHkXOb6QJcUD2kMjxMVZqXUaOkLKHpozsmqkz6G2NX6hQkPvgobxYjXXs7XcJleepzLwWQs8lP+ZTSemFMR1cQO6sS59mSErQ74OO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=CMoZfn0b; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3Dq33gVSdG7/GVh1X/6GStOXIb4c7W9pMbRnMJT/Cic=; b=CMoZfn0bPTc1dNxN51Rdtogvv9
	0DgPQ2MgaPm0LdEr/ausHDqAtHL/DCJIRLguXWnvEmgVqt4G1crDmzWZTojD0tUwzX8M2ckasmQ+W
	Viae4O3tG0SihbK5Py/Qo6q/wfsoIn/nZQRuUHG7GXrVGx3Sb5RNtbuhx+JyiMjt1LdKoCtalshmW
	uvuyOoXXi4MsioiDoV5GrDPCASYTn0IJq8V/VrJI/s2rUD4iatOb+np/XjVPH1UGTeTW6QrK6ehBY
	ls6dns03HsesJ5t+APxPzG1GKSTODM3gK3qIy7eeEpTi9D/JgKh21Qw9oa55k8BKeKgwyoe+bgmx1
	MtpY4I0A==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1u0jGq-00Bg3M-Jc; Fri, 04 Apr 2025 16:47:53 +0100
Message-ID: <aa29e983-78b9-430b-b8a6-e64de5f4ca12@codethink.co.uk>
Date: Fri, 4 Apr 2025 16:47:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
To: Ignacio Encinas <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-arch@vger.kernel.org
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 03/04/2025 21:34, Ignacio Encinas wrote:
> Implement endianness swap macros for RISC-V.
> 
> Use the rev8 instruction when Zbb is available. Otherwise, rely on the
> default mask-and-shift implementation.
> 
> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
> ---
>   arch/riscv/include/asm/swab.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/swab.h b/arch/riscv/include/asm/swab.h
> new file mode 100644
> index 000000000000..7352e8405a99
> --- /dev/null
> +++ b/arch/riscv/include/asm/swab.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_RISCV_SWAB_H
> +#define _ASM_RISCV_SWAB_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +#include <asm/cpufeature-macros.h>
> +#include <asm/hwcap.h>
> +#include <asm-generic/swab.h>
> +
> +#if defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE)
> +
> +#define ARCH_SWAB(size) \
> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
> +{									\
> +	unsigned long x = value;					\
> +									\
> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
> +		asm volatile (".option push\n"				\
> +			      ".option arch,+zbb\n"			\
> +			      "rev8 %0, %1\n"				\
> +			      ".option pop\n"				\
> +			      : "=r" (x) : "r" (x));			\
> +		return x >> (BITS_PER_LONG - size);			\
> +	}                                                               \
> +	return  ___constant_swab##size(value);				\
> +}
> +
> +#ifdef CONFIG_64BIT
> +ARCH_SWAB(64)
> +#define __arch_swab64 __arch_swab64
> +#endif
> +
> +ARCH_SWAB(32)
> +#define __arch_swab32 __arch_swab32
> +
> +ARCH_SWAB(16)
> +#define __arch_swab16 __arch_swab16
> +
> +#undef ARCH_SWAB
> +
> +#endif /* defined(CONFIG_RISCV_ISA_ZBB) && !defined(NO_ALTERNATIVE) */
> +#endif /* _ASM_RISCV_SWAB_H */
> 

I was having a look at this as well, using the alternatives macros.

It would be nice to have a __zbb_swab defined so that you could do some
time checks with this, because it would be interesting to see the
benchmark of how much these improve byteswapping.

How about:

#define ARCH_SWAB(size) \
static __always_inline unsigned long __zbb_swab##size(__u##size value) \
{								\
	unsigned long x = value;				\
								\
	asm volatile (".option push\n"				\
		      ".option arch,+zbb\n"			\
		      "rev8 %0, %1\n"				\
		      ".option pop\n"				\
		      : "=r" (x) : "r" (x));			\
	return x >> (BITS_PER_LONG - size);			\
}                                                               \
								\
static __always_inline unsigned long __arch_swab##size(__u##size value) \
	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB))       \
		return  __zbb_swab##size(value)			\
	return ___constant_swab##size(value);			\	


We might need to define  __zbb_swab##size to BUG or something if it
isn't available.

Also, I wonder if it is possible to say to the build system we must
have ZBB therefore only emit ZBB for cases where you are building a
kernel for an known ZBB system.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

