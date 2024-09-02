Return-Path: <linux-arch+bounces-6917-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565A968A01
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054A71C227F0
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A51A2629;
	Mon,  2 Sep 2024 14:31:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C881A2621;
	Mon,  2 Sep 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287518; cv=none; b=Oj2N5iGaP2ukWuZEXQ0AV2cdbjxtd93+0AJcG68lOdFR1thxG3AF0T7lL76GmcT8u92M1sExlEqPsaGCXhCQh9XaMNwaiQkU1m3nlzS+RN2sQWoRZ7eDOoFIXMk6mggFuChZGaj3Er3NV9Iw9ggQmO+uWc+AzOtNiIg6zjf1dk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287518; c=relaxed/simple;
	bh=NinPol/5jH8iZIp9ViyJ67vB5kkv2NMJPZMjlB/Poq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk03nUeZ9X0DK6stK1+SetaLxJdAvdVEPbREum971StwicYYW5DT4GOUArNX4yFJyJbsIpZNTzSBzNwZ83glvp1G6rz9xLBWfqfxnvSJw+/H0OFazAhgRy6HtDTy97LQEGSq/Qfydqe2ZKC4KihxQH8YWKCmlsbPmyLkq0eE/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78F25FEC;
	Mon,  2 Sep 2024 07:32:16 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504883F73B;
	Mon,  2 Sep 2024 07:31:48 -0700 (PDT)
Date: Mon, 2 Sep 2024 15:31:43 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <ZtXMT3qSFgneeZb9@J2N7QTR9R3>
References: <20240902125312.3934-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902125312.3934-1-adhemerval.zanella@linaro.org>

On Mon, Sep 02, 2024 at 12:52:57PM +0000, Adhemerval Zanella wrote:
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	/*
> +	 * If a task belongs to a time namespace then the real VVAR page is mapped
> +	 * with the VVAR_TIMENS_PAGE_OFFSET offset.
> +	 */

This confused me, and I see that it is truncated from the existing
commit in arch/arm64/kerne/vdso.c:

	If a task belongs to a time namespace then a namespace specific VVAR is
	mapped with the VVAR_DATA_PAGE_OFFSET and the real VVAR page is mapped
	with the VVAR_TIMENS_PAGE_OFFSET offset.

... and IIUC the "namespace specific VVAR" page doesn't have the RNG
data, right? It'd be good to spell that out, e.g.

	/*
	 * The RNG data is in the real VVAR data page, but if a task
	 * belongs to a time namespsace then VVAR_DATA_PAGE_OFFSET
	 * points to the namespace-specific VVAR page and
	 * VVAR_TIMENS_PAGE_OFFSET points to the real VVAR page.
	 */

It does feel weird that everything else has to work around timer
namespaces rather than that being limited to the timer code, so we'll
probably want to flip that if we add anything else to the VDSO, or have
a separate VVAR_RNG page.

> +	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> +		return (void*)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
> +	return &_vdso_rng_data;
> +}

[...]

> diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
> new file mode 100644
> index 000000000000..95682d29c4bf
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +typeof(__cvdso_getrandom) __kernel_getrandom;
> +
> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
> +{
> +	asm goto (
> +	ALTERNATIVE("b %[fallback]", "nop", ARM64_HAS_FPSIMD) : : : : fallback);
> +	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
> +
> +fallback:
> +	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
> +		return -ENOSYS;
> +	return getrandom_syscall(buffer, len, flags);
> +}

The asm it pretty painful to read, and AFAICT what you actually want
here is alternative_has_cap_likely(), which we could use were that not
using alt_cb_patch_nops behind the scenes.

I reckon it's worth making the work for the VDSO first (patch below);
that way you can make this much nicer:

ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags,
			   void *opaque_state, size_t opaque_len)
{
	if (alternative_has_cap_likely(ARM64_HAS_FPSIMD)) {
		return __cvdso_getrandom(buffer, len, flags,
					 opaque_state, opaque_len);
	}

	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
		return -ENOSYS;
	
	return getrandom_syscall(buffer, len, flags);
}

... though the conditions for returning -ENOSYS look very odd to me; why
do we care about fast-pathing that specific case rather than forwarding
that to the kernel, and does __cvdso_getrandom() handle that correctly?

Mark

---->8----
From b7ee23e4ec47805527c9d7c2ee6b02328fe8437a Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 2 Sep 2024 15:08:12 +0100
Subject: [PATCH] arm64: alternative: make alternative_has_cap_likely() VDSO
 compatible

Currently alternative_has_cap_unlikely() can be used in VDSO code, but
alternative_has_cap_likely() cannot as it references alt_cb_patch_nops,
which is not available when linking the VDSO. This is unfortunate as it
would be useful to have alternative_has_cap_likely() available in VDSO
code.

The use of alt_cb_patch_nops was added in commit:

  d926079f17bf8aa4 ("arm64: alternatives: add shared NOP callback")

... as removing duplicate NOPs within the kernel Image saved areasonable
amount of space.

Given the VDSO code will have nowhere near as many alternative branches
as the main kernel image, this isn't much of a concern, and a few extra
nops isn't a massive problem.

Change alternative_has_cap_likely() to only use alt_cb_patch_nops for
the main kernel image, and allow duplicate NOPs in VDSO code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/alternative-macros.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
index d328f549b1a60..c8c77f9e36d60 100644
--- a/arch/arm64/include/asm/alternative-macros.h
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -230,7 +230,11 @@ alternative_has_cap_likely(const unsigned long cpucap)
 		return false;
 
 	asm goto(
+#ifdef BUILD_VDSO
+	ALTERNATIVE("b	%l[l_no]", "nop", %[cpucap])
+#else
 	ALTERNATIVE_CB("b	%l[l_no]", %[cpucap], alt_cb_patch_nops)
+#endif
 	:
 	: [cpucap] "i" (cpucap)
 	:
-- 
2.30.2


