Return-Path: <linux-arch+bounces-11282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B13FA7C103
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 17:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C22F67A6BAD
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 15:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B21F3B92;
	Fri,  4 Apr 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ixT9bgve"
X-Original-To: linux-arch@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D7D282EB;
	Fri,  4 Apr 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782081; cv=none; b=FYeb4GB4/uMvZpLfyZQgEVs6B10nyTE3lBOr/xpvd81088WFSZxZhOkLxwxCPyajUS0nvstEQw7nvQdyN6TloHj2DTUgnjv8kXnectln7bkgSuM11bm8KGQRoLA5ubXcm8MDNEjUnuuDgxDWiQwyyf6U8O54J+3yN66b749TiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782081; c=relaxed/simple;
	bh=8M0uTvGg35cr8T7CGwhcScWOijAyvKAp0NWeGZa5908=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNB/jqmX5dAPwiFEOnR8mjvRiZ7xHDXFfFuW/4I/bte6BDbhsdelDwlnR3O9As8k3IdO1CTs6guVG4rD3M66TKJxnkM1oSZ50HaPeIRCaKhwTewGgj/CJjkQqjMIIuioxY92CHLWrTK5MT+xKMJhTyPpACjOqMEh/PCVV1IfPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=ixT9bgve; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AbrG0A80aOGQCqeyijoooJcA958xcCPcGbolO2HX8Q8=; b=ixT9bgve0or2vCBIcFZmTJrpQZ
	eulyVEx2oyHCAwsp9RWPHJ5D5qWMUl1mbrq7NNmTM5dFeSU/rd2YIvc65Iy1u200Z7e9uPKaAmDkZ
	dRjEDo+jVfnKL3LGmOjh1TtqqX5fY2ZzELtGhBSVr0WJxRPs8b6KrL530K4iujfsZGAEfyfwvwun/
	jk3hV5FOI+ZP0am+3FT60oAYkcUYmOjR/1tbE/Vn1TgQDxTuRtpClsvYYznXmfZnQluFSq8F46Tdq
	07UBwfb7SPBZAqVOTChTQtw0vjphYr2UQ8XtsQj8KHubuLbOT8qa7bOeL05fgdO9dNIn2BkXiH1qi
	ZSx5AW/A==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1u0jN8-00BgIH-8s; Fri, 04 Apr 2025 16:54:23 +0100
Message-ID: <a7cdade3-8707-4464-8505-356dd5c0c49f@codethink.co.uk>
Date: Fri, 4 Apr 2025 16:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
To: Arnd Bergmann <arnd@arndb.de>, Ignacio Encinas <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
 <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 04/04/2025 06:58, Arnd Bergmann wrote:
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
> 
> I think the fallback should really just use the __builtin_bswap
> helpers instead of the ___constant_swab variants. The output
> would be the same, but you can skip patch 1/2.
> 
> I would also suggest dumbing down the macro a bit so you can
> still find the definition with 'git grep __arch_swab64'. Ideally
> just put the function body into a macro but leave the three
> separate inline function definitions.

I thought we explicitly disabled the builtin from gc... I tried doing
this and just ended up with undefined calls from these sites.,

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

