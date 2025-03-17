Return-Path: <linux-arch+bounces-10901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F44A64CB5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 12:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD2C173485
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C01519B4;
	Mon, 17 Mar 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="THULKh4Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66A233728;
	Mon, 17 Mar 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211100; cv=none; b=i3Mw5bsrYO5b+r2dWEZPIeY9/DcsUGhx5NkZwZBZwpLdrYYZm3wHFGjf3TRERarBITDxZYbqo/jLmBKUjP6dKpjBq4BMxfItm77C9MU9PiHV903XvLR+2VG7fhrIlWAP9AeVixUtYA7NWOjXGdqCynZExgZ+p+CPRvqV+VDyNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211100; c=relaxed/simple;
	bh=+wUagchdp7sYd7E3QkBkSDACazRJklfq9k+LiWjgVqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=De5swgtWOfrQM/EjwIuv155w9nZTZcX8nDgyui7BzbmWbRPW5W5ALQIA/ioTyLprreRRYtf6F2gjTwaxXsfcWmir5fHjWGwyLNjeU7wbdO6EiR3y2Kss9BVhhGAtg1dsFZGl4qE7kax2LK5bCv3p7WqS0Sh1tXFo6P6RV8KSX9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=THULKh4Q; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1742211091;
	bh=nfHTB/nIl+RDq3rL3kY2G+Hq2s8UAbra95K2RlIfv/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=THULKh4QeDj55AGiFjLvKR+ppiee88dNU1yxt7aAdWCXRewUJdRUk+1hEnpKs5vnk
	 8cN8/X9HSmCrSl7icuzk389a6XR3oUfqtWruR4sSbc/nIuBeHSJSKIqUYh/FlDi23G
	 nkrv4kmO9QetcPTFpFiXpUBuULetOEIp9su0DIBRRiQkc1Z/y7is3xcXThvcY8yLrJ
	 01mZVeWIgX+XwpT50e4SFKqqEfCpqQ9MgzXR9PwVFEbpiGkAKlE94Q12ksS1BrFJun
	 82FcMT/zCyL1BoG4qzRICkOVKy/3J/0u1OcRuH4J2iJUXGewuGDBA9SqIVT2Q2Blk5
	 zrnx8kdaVEaEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZGXqN4Vq7z4wbv;
	Mon, 17 Mar 2025 22:31:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Julian Vetter
 <julian@outer-limits.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org
Subject: Re: [PATCH 4/6] powerpc: asm/io.h: remove split ioread64/iowrite64
 helpers
In-Reply-To: <20250315105907.1275012-5-arnd@kernel.org>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-5-arnd@kernel.org>
Date: Mon, 17 Mar 2025 22:31:25 +1100
Message-ID: <87senbdhbm.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> In previous kernels, there were conflicting definitions for what
> ioread64_lo_hi() and similar functions were supposed to do on
> architectures with native 64-bit MMIO. Based on the actual usage in
> drivers, they are in fact expected to be a pair of 32-bit accesses on
> all architectures, which makes the powerpc64 definition wrong.
>
> Remove it and use the generic implementation instead.
>
> Drivers that want to have split lo/hi or hi/lo accesses on 32-bit
> architectures but can use 64-bit accesses where supported should instead
> use ioread64()/iowrite64() after including the corresponding header file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/include/asm/io.h | 48 -----------------------------------
>  1 file changed, 48 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

