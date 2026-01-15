Return-Path: <linux-arch+bounces-15799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF0D22104
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DC20300671E
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 01:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E351D54FA;
	Thu, 15 Jan 2026 01:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKjxxgi6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFA41C63;
	Thu, 15 Jan 2026 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441696; cv=none; b=onjDkbnGq0qgiDMhZoW0SthZ6ecYERnHWik+hCf0pT5S2mKt0rlFZjQ2eeiFq7mXXGNWhHK9VwoDaisXFuq8kxWp5N68R9zfGV3RiomblPFnlxF4TtMFXcuObhfi9lzbenhVCX/xPsGYUSgIuQZlMgtJAs9DynkjPVQWkE03iZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441696; c=relaxed/simple;
	bh=7HNAeMi2T/uDNpYQR9hHBVD/6+a8rzClGOYvvjwq8mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fewnQPa8F2p/Y5Owl8IINA6+IbtJ1wm30GPUzXAazKKaEweEPZXZemBzHoeyZ00fKKc8Wj9xoRkUVn9txCaF7ry/CcG1iMfLqQa2PxBi4oIN3j1oveRTdoMjgl2evJnekTY0M6OEg++aV2dWcglPMrtdrFxpsVcMZ1OzmwQr/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKjxxgi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94FDC4CEF7;
	Thu, 15 Jan 2026 01:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768441695;
	bh=7HNAeMi2T/uDNpYQR9hHBVD/6+a8rzClGOYvvjwq8mw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=KKjxxgi6pkvKqpGcosBI0OO8t4PlI3ToyT8DxeRAibOyZcKZmMUn/aXHm8KH1sRgr
	 5PgKnvrT0BuIUgLQ5a+/Xb/fZZYz89v/P6e0Hsh4CaZNLnZEZDhuMMilx8PYmo+yUF
	 nj7eXPBxh/Aa9qWVn2KMyX/zPzpSnamQQ2irxg6R5uVTEgVzS0+di5gpEwz5dsSVdV
	 QlgNGwsPb+J//L/F8DHXiJjq6DuYhCO90S+i5pErzyn7Aq1u54wGIfye2ooOYIlo5i
	 6K3mt5fk5GZ/K326+yXLPIzCB6fbaQAou8qL3lZXh4hwCwpPrx67C1ZPhZvlnn+jLt
	 33n9zp5e8gVjg==
Date: Wed, 14 Jan 2026 18:48:13 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Arnd Bergmann <arnd@arndb.de>
cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
    Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
    Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH RESEND v2] asm-generic: Remove pud_user() from
 pgtable-nopmd.h
In-Reply-To: <61ef32ebc3ea2e926de2bebecf3b5c3a10989fca.1767720453.git.chleroy@kernel.org>
Message-ID: <d7d3d58e-8b48-ddca-1afd-d2181b2872c3@kernel.org>
References: <61ef32ebc3ea2e926de2bebecf3b5c3a10989fca.1767720453.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Arnd,

On Tue, 6 Jan 2026, Christophe Leroy (CS GROUP) wrote:

> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_user() in include/asm-generic/pgtable-nopmd.h
> 
> But pud_user() only exists on ARM64 and RISCV and is not expected
> by any part of MM.
> 
> Add the missing definition in arch/riscv/include/asm/pgtable-32.h
> and remove it from asm-generic/pgtable-nopmd.h
> 
> A stub pud_user() is also required for ARM64 after
> commit ed928a3402d8 ("arm64/mm: fix page table check compile
> error for CONFIG_PGTABLE_LEVELS=2")
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Who should take this patch ? I expected it to be merged by Arnd as asm-generic maintainer but this is the second time I resend.
> 
> Should the patch go via riscv tree instead as the undue pud_user() was initialy introduced by riscv ?
> 
> v2: Change ARM64 pud_user macro to pud_user(pud)

This one looks like it should go upstream through you?

If you'd prefer arch/riscv to pick it up, let us know.


thanks,

- Paul

