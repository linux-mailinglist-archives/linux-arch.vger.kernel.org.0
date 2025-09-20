Return-Path: <linux-arch+bounces-13701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0CB8BADF
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 02:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484133A8CA5
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7A52F99;
	Sat, 20 Sep 2025 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3hzw6hs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424E2AD31;
	Sat, 20 Sep 2025 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758327280; cv=none; b=EMQvUnT70qSC4bTbvcw9syA70N2HOwjo8rIxBqAo+wNOP/YRpID12snS7zeoSYkkRdTXUcosty9KHGnHCN3sUy9RBobIznuW6kAOhJa0DPPTtqwNR3AdPJcOQhX0A2jF4yCzXPBZnOfaypJkzNE+GAvJldOnjqSSIoLnHobn668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758327280; c=relaxed/simple;
	bh=O0bDy6Ix2CSa2N0Q4JTxtP6HuLT6aOmOzysAyCGa/JQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uBkdrQkhYDYx6sf9jQToGhx/utbu77DidDWgtp5Er1DyDKp1c/dFdjXcp+VMDOHT6LbJ6F7XNw0aQOzCggwANm7pKXSieOmMN4OIGMDZs5my1tsE+DPDosTnmFAX4/Va6xB4f9OLcdcKEaKZytK3OlV2XqL/GhOBDBacQR3sCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3hzw6hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96FC4CEF0;
	Sat, 20 Sep 2025 00:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758327280;
	bh=O0bDy6Ix2CSa2N0Q4JTxtP6HuLT6aOmOzysAyCGa/JQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=L3hzw6hsVszuDiJHPBCY82Amym8WdjwMr0g4coY501cIx1Z/cbkmYyw7MErPFCgVY
	 9zOiRwZwy5zm841JL2MsK2jzXeQ3zuoERdnS/L8wMExSvv1T0o7mYbdFrsEWlA4SkK
	 3svAd1LFwZ7z30kKWvM0DWesAGVpKsw7bZJco19Lm5M47zZgjVJZtlKLQMBsZ7yYaA
	 FJfwNW5bTkOWmd9ZQMsw1BtXtJxClMXZcosYuHHq5MUc0nBPwOIMN0/MJI58CzbCdH
	 z1MYamA/HTdmcm+e+/bELj1O9aqgYTVQyFTPfnXkV3EothiEolqhY+/B6Fha//O50S
	 IdN4mLe8ZgdZQ==
Date: Fri, 19 Sep 2025 18:14:34 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-riscv@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, 
    Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Peter Xu <peterx@redhat.com>, 
    Oscar Salvador <osalvador@suse.de>, 
    Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v2] asm-generic: Remove pud_user() from pgtable-nopmd.h
In-Reply-To: <c2c9fc69871a7caaa205e237ff73557f19f5e176.1755509286.git.christophe.leroy@csgroup.eu>
Message-ID: <d9f45fdb-4ecd-23b0-6c98-846be24976aa@kernel.org>
References: <c2c9fc69871a7caaa205e237ff73557f19f5e176.1755509286.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Aug 2025, Christophe Leroy wrote:

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
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Paul Walmsley <pjw@kernel.org> # riscv


- Paul

