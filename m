Return-Path: <linux-arch+bounces-8852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309A9BC901
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025EB283352
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42731CFED9;
	Tue,  5 Nov 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="abc102v8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAD186284;
	Tue,  5 Nov 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798579; cv=none; b=Uqbq0wQZ4Gyb/In50hJN6A0QdKLyZoFL5zMdrkBZkGFYuVATQMeeG2/cXuD8EBYUavp0TnZ3v7cs6ndBhvE8IjESHHsOI3YVeRMuQFV0Dd486J4pM/uPDm2UbPaizsSUCWAqP5tmTnHEZ23bRsTO8Y01sdqJ4ffGyU3dokDKmPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798579; c=relaxed/simple;
	bh=0DJAaAp/sJ4GJO6GXcKD8xMWKOg86nk2Np9hVptfiZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZ5fTc/Tj9RU8ttW4FYi8TnbQ5YSJQPjRiuFTuCIg3kiyxaBBfJFafFcXgSfXc2sGXHzV2ao4ER1D5ZQL+GAK/rZslg/eZLsj7hseYWrsqbpcGjLkC04vaN+Dk5CjWd0LYtgC7tX4IdOzz/bsgqNg48dl9xzswBCPvtRC9Mlzg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=abc102v8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730798571;
	bh=xG1HQhXTKL81M9467zhA4KonLLpV3fuL2upt5lJSShY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=abc102v8sCEc4rZgo2gcKLbXmwgvq4GWFHOVFO2bCqlfFdeKKcRV4prB0lNuFM+1J
	 +nLMWJEv9C6S0GLYT8NTq4cofEwz+d0GOszV9URcE2cm6ZF5AylDoN/Z59rll0g/Oq
	 7WsqGbok2W4NpvuKkzkrDPAQmPNPSM6PFvziT+2hwmqDnVmGWCUcte8UycWZO0fqBM
	 8/j6kLdVKhMd+2mHPE+WS4RXiOWy1ZCSKS371LN4mAvJuEGSKgRrakUz5kUENSDU9q
	 PGCTVxGOMH7TPanX3MVM/rMyBsqI05mZE6yiJdVSS0qPm3mWfbV8Bv8MQn/EFJHce9
	 0DvIPNJTjgI8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XjNCv5y3Wz4wcl;
	Tue,  5 Nov 2024 20:22:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 08/18] powerpc/crc32: expose CRC32 functions through lib
In-Reply-To: <20241103223154.136127-9-ebiggers@kernel.org>
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-9-ebiggers@kernel.org>
Date: Tue, 05 Nov 2024 20:22:53 +1100
Message-ID: <87zfme826q.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Biggers <ebiggers@kernel.org> writes:
> From: Eric Biggers <ebiggers@google.com>
>
> Move the powerpc CRC32C assembly code into the lib directory and wire it
> up to the library interface.  This allows it to be used without going
> through the crypto API.  It remains usable via the crypto API too via
> the shash algorithms that use the library interface.  Thus all the
> arch-specific "shash" code becomes unnecessary and is removed.
>
> Note: to see the diff from arch/powerpc/crypto/crc32c-vpmsum_glue.c to
> arch/powerpc/lib/crc32-glue.c, view this commit with 'git show -M10'.
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/powerpc/Kconfig                          |   1 +
>  arch/powerpc/configs/powernv_defconfig        |   1 -
>  arch/powerpc/configs/ppc64_defconfig          |   1 -
>  arch/powerpc/crypto/Kconfig                   |  15 +-
>  arch/powerpc/crypto/Makefile                  |   2 -
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c      | 173 ------------------
>  arch/powerpc/crypto/crct10dif-vpmsum_asm.S    |   2 +-
>  arch/powerpc/lib/Makefile                     |   3 +
>  arch/powerpc/lib/crc32-glue.c                 |  92 ++++++++++
>  .../{crypto => lib}/crc32-vpmsum_core.S       |   0
>  .../{crypto => lib}/crc32c-vpmsum_asm.S       |   0
>  11 files changed, 98 insertions(+), 192 deletions(-)
>  delete mode 100644 arch/powerpc/crypto/crc32c-vpmsum_glue.c
>  create mode 100644 arch/powerpc/lib/crc32-glue.c
>  rename arch/powerpc/{crypto => lib}/crc32-vpmsum_core.S (100%)
>  rename arch/powerpc/{crypto => lib}/crc32c-vpmsum_asm.S (100%)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

...
> deleted file mode 100644
> index 63760b7dbb76..000000000000
> --- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
> +++ /dev/null
> @@ -1,173 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -
...
> -static int __init crc32c_vpmsum_mod_init(void)
> -{
> -	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
> -		return -ENODEV;
> -
> -	return crypto_register_shash(&alg);
> -}
> -
> -static void __exit crc32c_vpmsum_mod_fini(void)
> -{
> -	crypto_unregister_shash(&alg);
> -}
> -
> -module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crc32c_vpmsum_mod_init);
> -module_exit(crc32c_vpmsum_mod_fini);
> -
> -MODULE_AUTHOR("Anton Blanchard <anton@samba.org>");
> -MODULE_DESCRIPTION("CRC32C using vector polynomial multiply-sum instructions");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS_CRYPTO("crc32c");
> -MODULE_ALIAS_CRYPTO("crc32c-vpmsum");
...
> new file mode 100644
> index 000000000000..e9730f028afb
> --- /dev/null
> +++ b/arch/powerpc/lib/crc32-glue.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only
...
> +
> +static int __init crc32_powerpc_init(void)
> +{
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
> +	    (cur_cpu_spec->cpu_user_features2 & PPC_FEATURE2_VEC_CRYPTO))
> +		static_branch_enable(&have_vec_crypto);

For any other reviewers, this looks like a new cpu feature check, but
it's not. In the old code there was a module feature check:

  module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crc32c_vpmsum_mod_init);

And PPC_MODULE_FEATURE_VEC_CRYPTO maps to PPC_FEATURE2_VEC_CRYPTO, so
the logic is equivalent.

cheers

