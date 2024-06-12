Return-Path: <linux-arch+bounces-4853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E837905B47
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 20:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D230B23C3E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AE4CB5B;
	Wed, 12 Jun 2024 18:42:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC564C62E;
	Wed, 12 Jun 2024 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217748; cv=none; b=N0H3jbGswNP+71rsW2hbwY20AAHIIUOJypXQsna2XtUjr1bh+tUmSyVSA6fLEAHI0rkAu7gV/CMAwxS48Pd5E1EalGtnQvUJhGEHqtJgQfcIM/dGUuHAcx3AWMhdXts/NOBFAX9o2XUezGM1n1u9wpxQTVeIgG7EfDx36a+bGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217748; c=relaxed/simple;
	bh=KOyH5IiVpwS6pxgBIHsJ42RKqSXLK0TJcXQo9wh6hBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rywvEsPAvIOib5siVRjYlInx0KKldaQg+CMlQ9d9g3Daz6w/byQxHAg43gRC53eI+qwy5V2Tft2fYdBbBLmZAve1LEWL9uu7ePzvaiagYVFMc1zo19lAdJwIFp6cPzTkeK2Ep4X7o652dY1S4sRAkUOGUV89D6Bow30AB5z2ZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEA461042;
	Wed, 12 Jun 2024 11:42:50 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4BA3F64C;
	Wed, 12 Jun 2024 11:42:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 19:42:22 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 4/7 v2] arm64: add 'runtime constant' support
Message-ID: <ZmnsDqP9T0b1z6ML@J2N7QTR9R3.cambridge.arm.com>
References: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <20240611172010.287427-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611172010.287427-1-torvalds@linux-foundation.org>

On Tue, Jun 11, 2024 at 10:20:10AM -0700, Linus Torvalds wrote:
> This implements the runtime constant infrastructure for arm64, allowing
> the dcache d_hash() function to be generated using as a constant for
> hash table address followed by shift by a constant of the hash index.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> v2: updates as per Mark Rutland

Sorry, I just realised I got the cache maintenance slightly wrong below.

> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +	__le32 *p = lm_alias(where);
> +	__runtime_fixup_16(p, val);
> +	__runtime_fixup_16(p+1, val >> 16);
> +	__runtime_fixup_16(p+2, val >> 32);
> +	__runtime_fixup_16(p+3, val >> 48);
> +	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 4));
> +}

We need to do the I$ maintenance on the VA that'll be executed (to
handle systems with a VIPT I$), so we'll need to use 'where' rather than
'p', e.g.

	caches_clean_inval_pou((unsigned long)where,
			       (unsigned long)where + 4 * AARCH64_INSN_SIZE);

Note: the D$ and I$ maintenance instruction (DC CVAU and IC IVAU) only
require read permissions, so those can be used on the kernel's
executable alias even though that's mapped without write permissions.

> +/* Immediate value is 6 bits starting at bit #16 */
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +	__le32 *p = lm_alias(where);
> +	u32 insn = le32_to_cpu(*p);
> +	insn &= 0xffc0ffff;
> +	insn |= (val & 63) << 16;
> +	*p = cpu_to_le32(insn);
> +	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 1));
> +}

Likewise:

	caches_clean_inval_pou((unsigned long)where,
			       (unsigned long)where + AARCH64_INSN_SIZE);

Mark.

