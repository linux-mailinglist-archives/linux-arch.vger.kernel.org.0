Return-Path: <linux-arch+bounces-11038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2FA6C4D6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 22:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF3F460C14
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0A22CBF8;
	Fri, 21 Mar 2025 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="mxIWHDCe"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26422D4F9
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591280; cv=none; b=GaM7VZwG/ebTJTmchcJ9JmbmXq1u8HLRAdcfWOn0UP0dicGqNAXbpDf+te560vWIDEYUiBUWUR8jNZfXYk1yRw4vs8NHPQtY+vINPosn/i0m9POCYKH31zgf4JFGBFz3vLAde9G5LeVEvBHUHQ8OtblWaKU4mzMZhqomC9Q+2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591280; c=relaxed/simple;
	bh=pRTN18mZjehBMY6cltsFf8sEbzCBSl3WgAjrrN95J08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gos5irNTABawD1o0PcXKJ4amS6zYen0+0jlbiv84wG0eFGxmcdJ+KEPnjPsF/iMSLHJm1UqCfPEVUOnUO4zgkyhhvN8zOoeAcME6BDswQVxfavgUXZRzp3XSe50QOuGvUwXBq6Vpq8mxKObl9/bjfii7cx9TXgBc+E7Fvg5Okxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=mxIWHDCe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <fd8e4380-eba3-4602-b925-d81c0afed6d8@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742591266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlC6VNAA0VKAuMw2O3RagiC9hLYLd/5P5o/W8WtfpYs=;
	b=mxIWHDCeeOon6AofoQVDS+HDSKfYnVbPF754rvwIAwLC/90cv4eaY2l7cOOmH71p4z4pYd
	3eb/sNdx0t06NJ6Uv2tnHtnP7ig3INMcIuHTY+GjKlFICWFi4gdK0pxJXanvDLMc7kxmIu
	WYCfKmw/2vvmgzkPVEOWRWMv3zdx5T9+nqqyL/0hgimAd77zQKiQMlMz7e2EzLfEnaxF8E
	CJhtGjidv1dnu83bXQXOaPz2SvRScNjw0/nZgHIa58dpHyTWxmCXc3zDdeOck9kezpPwPU
	Z8SR5t09thvptD8qA8BdOh+isZLwUBLvO9jsPbc83RG3UEXWlKwnC0wnBoX/zQ==
Date: Fri, 21 Mar 2025 22:07:41 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] riscv: introduce asm/swab.h
To: Eric Biggers <ebiggers@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-arch@vger.kernel.org
References: <20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com>
 <20250319-riscv-swab-v2-2-d53b6d6ab915@iencinas.com>
 <20250321033718.GA98513@sol.localdomain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <20250321033718.GA98513@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 21/3/25 4:37, Eric Biggers wrote:
> On Wed, Mar 19, 2025 at 10:09:46PM +0100, Ignacio Encinas wrote:
>> +#define ARCH_SWAB(size) \
>> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
>> +{									\
>> +	unsigned long x = value;					\
>> +									\
>> +	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,			\
>> +			     RISCV_ISA_EXT_ZBB, 1)			\
>> +			     :::: legacy);				\
> 
> Is there a reason to use this instead of
> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB) which seems to do the same thing,
> including using a static branch?

I just followed what's already in arch/riscv/include/asm/bitops.h

However, I changed it to

	if(riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {
		asm volatile (".option push\n"
			      ".option arch,+zbb\n"
			      "rev8 %0, %1\n"
			      ".option pop\n"
			      : "=r" (x) : "r" (x));
		return x >> (BITS_PER_LONG - size);
	}

	return  ___constant_swab##size(value);

and it seems gcc generates the exact same code. I tested it with 
arch/riscv/lib/csum.c (which uses swab32) and both versions generate the
exact same object file.

This certainly looks easier to read. If there are no complaints I'll
send a v3 using a plain if with riscv_has_extension_likely.

Thanks for pointing it out!

