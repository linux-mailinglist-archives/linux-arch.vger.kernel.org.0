Return-Path: <linux-arch+bounces-11287-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52325A7C2D9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 19:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AB93B5315
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881E215178;
	Fri,  4 Apr 2025 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="OJWqMBN1"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5620ADD8
	for <linux-arch@vger.kernel.org>; Fri,  4 Apr 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789236; cv=none; b=cRWJw1+Eqwb9wCAStnu6a7opJkiorm4MICMiK1hNMLGj/05jKtoU38KHU0yxUQKFG/Y2AJAS3dkb4PEsLQFhg04mKeCycwuSFldbxESjsfYnHAR0IOMzu8cNxfRwY+ggPifdHRc7NcgknyebeiMb/SS/e+HdfnpSdxWnhugG62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789236; c=relaxed/simple;
	bh=NukG3uMrPNlDIzqm6kxfZKYvKoPfRKbsl1MqHOykOZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFeh56mynwYXUWH/Z9RbP8IAEx4WTKs965BC47KOe64n9Ibw9TwgZ8DzizZ3azyYlZyErrlbFnE6MX80vmDUSnAktXiUR8xWJWW8JBN37isnkTAYlEKX5Ty5rBt6+ZbadElaMghxibXk0z+2klmQ6BiaHhSxK515CUQhUKGfjsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=OJWqMBN1; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <5348670b-1bbf-4948-9b3a-9da210debf03@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1743789231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1W01rl80m0H+/UfHPagC4644fJ169vg9eQeKL5M7SrY=;
	b=OJWqMBN1YxCoLFXWKHl/O9O9Rc2L/2yYoFUoofAtfxbdw6A1EN6Gd63XQ5lMZig7zs20+N
	m8EsYSHFfkr7fFUY5mJ8teFtWcfBQ3Y80cgrUkWCp+txnJCF1uPRwJz3tt2Q7HO8Ltwyc8
	Fr+yw+f9VdHtOPG2JSkoQoVCw67eY8i63qxC1obKnR7gYXbZZli5aPQERgGFnXlGNMw7md
	V3OEj6QxRM9nevr9NylA3vhJ5M0uLtn3ADVLt/btIzcRfMq6DFtQM5oZi5xhi3uqHkjYCD
	e1VO0jacI8rz+YDDg3Ad3yF2fsxFtrdO32O2w1gWUTaJ5y3i+PoyL6mP8SBaGg==
Date: Fri, 4 Apr 2025 19:53:46 +0200
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
 <aa29e983-78b9-430b-b8a6-e64de5f4ca12@codethink.co.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas <ignacio@iencinas.com>
In-Reply-To: <aa29e983-78b9-430b-b8a6-e64de5f4ca12@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/4/25 17:47, Ben Dooks wrote:
> I was having a look at this as well, using the alternatives macros.
> 
> It would be nice to have a __zbb_swab defined so that you could do some
> time checks with this, because it would be interesting to see the
> benchmark of how much these improve byteswapping.

I get your point, but isn't what you propose equivalent to benchmarking 
__arch_swab vs ___constant_swab? 
 
> Also, I wonder if it is possible to say to the build system we must
> have ZBB therefore only emit ZBB for cases where you are building a
> kernel for an known ZBB system.

You can disable ZBB instructions if you do RISCV_ISA_ZBB=n. 

config RISCV_ISA_ZBB
	bool "Zbb extension support for bit manipulation instructions"
	depends on TOOLCHAIN_HAS_ZBB
	depends on RISCV_ALTERNATIVE
	default y
	help
	   Adds support to dynamically detect the presence of the ZBB
	   extension (basic bit manipulation) and enable its usage.

	   The Zbb extension provides instructions to accelerate a number
	   of bit-specific operations (count bit population, sign extending,
	   bitrotation, etc).

	   If you don't know what to do here, say Y.

However, statically assuming ZBB instruction support is another beast
and I don't really have an informed opinion about this. Perhaps in a few
years?

Thanks for the review!

