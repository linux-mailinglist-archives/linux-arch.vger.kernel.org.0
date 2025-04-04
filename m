Return-Path: <linux-arch+bounces-11288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769DAA7C31B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 20:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB8F189F9BC
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFAC219A90;
	Fri,  4 Apr 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="X7/KzN87"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFF21859F
	for <linux-arch@vger.kernel.org>; Fri,  4 Apr 2025 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743790419; cv=none; b=ry5P9EPFy++dHkvvWfiyh9qJtA2jmYIUlLRq2/2hQomhU2uyd/hfvKgpNmfNjG2lGsOM9fcJFGB4jml/VhBOEXoBB3Z7ruTU4wJpyBt3E02lQy9O6HBw5n0XhT49OXJKQ+N2pCRwhOaprAGyMhMdOiBiKmR7eMENVzisD75SZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743790419; c=relaxed/simple;
	bh=18hN5x2RADFXLM5oIMb+dmlprtIX5ukfJpyHhTr93nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxMpv2SocMtHi1jAV0zElRn0ynFMJOYMz7TOZINFos4Lg7KhHfEPPVG71RDYNdy0OJof3W3alnDbqxFTRjQ4gD+Z0JnHBt9zihXKykSP1GHCZgUAoaK2cFtWONfEiirzofrKYoWbCHXvr0WxICJtwF6W+9OuWAQK4D1suK+vwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=X7/KzN87; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <d03cb69d-d9a3-46fb-a283-d429a9389606@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743790405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVNe9DB4JVS7mxluiBxcFesLyFlFXgqdxhl/MDOzqcY=;
	b=X7/KzN87/UO8MjCyQhAFLFpd4xU4Rssl/ezCIa3HYBH0BOtlU/YCJSSqcZERqRM4yKYu8A
	yMgGqdW/7vIuBTYE67LVQN6hxapbTAuWawGihHgrN8uS4frbqmiAK6cErBHgI2KNfm4r7m
	yiDIp6BGrDZj93AUpKiTQZJJWivU7jFr/DZTs3njv1dAgahFs4hmePYI8CumIlaU4G5gCZ
	NMENgUzoNCwqr612hNffJ/t8O42gPP1I/0yHjzl2xBQQArcDxfbBxEkL1+CiQ0GGzkhiP4
	FCZypS8QGicnAUx90Gj93LPTSr4iGs/DsdNl4j0zDU7RtLVftfXntQv1lL4Hug==
Date: Fri, 4 Apr 2025 20:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
To: Ben Dooks <ben.dooks@codethink.co.uk>,
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
 <99b7b45a-4b18-4f0d-a197-4dccbb6c2352@codethink.co.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas <ignacio@iencinas.com>
In-Reply-To: <99b7b45a-4b18-4f0d-a197-4dccbb6c2352@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/4/25 17:55, Ben Dooks wrote:
> On 03/04/2025 21:34, Ignacio Encinas wrote:
>> +#ifdef CONFIG_64BIT
>> +ARCH_SWAB(64)
>> +#define __arch_swab64 __arch_swab64
>> +#endif
> 
> I suppose if we're 64bit we can't just rely on values being in one
> register so this'd need special casing here?

Oops... I somehow decided that __arch_swab64 wasn't worth having for
CONFIG_32BIT. I can't tell how useful it is to have it, but it is
doable and already present in the codebase (include/uapi/linux/swab.h):

	__u32 h = val >> 32;
	__u32 l = val & ((1ULL << 32) - 1);
	return (((__u64)__fswab32(l)) << 32) | ((__u64)(__fswab32(h)));

I'll excuse myself on this one because I'm not sure I have ever used a
32 bit CPU (other than the very occasional and quick school project)

Thanks for catching this one! I'll make sure to add __arch_swab64 for
the 32BIT version mimicking the snippet from above.

