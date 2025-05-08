Return-Path: <linux-arch+bounces-11874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D4AB01AB
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5DA417CB02
	for <lists+linux-arch@lfdr.de>; Thu,  8 May 2025 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD78928640B;
	Thu,  8 May 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="IZZE0R//"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414B20D4E2
	for <linux-arch@vger.kernel.org>; Thu,  8 May 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726344; cv=none; b=RIrnyUDkeFbP3JJfoGHZF0xSvtsrSJhzod7Cyc0ZNCoEJM54IaAgjIdtARHky3kR778lzOlTFWcuYOJiS/DvXewK905RjWjXyJy/VctP6RQMXWqq2PoEECB7P4RrIlbbc8P04HTzYnQSY/1NeouFoseJoH8XOYM2SqI0kLBrlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726344; c=relaxed/simple;
	bh=0uONWRNF15Jv8uIv0B45XQKpseOb6seBoGqZpXZcw1s=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=rOuTB7JLkpnGTuFfVquPJHQM3ihmuab11IwFJWgDTFMn1c1yc8hLiJMv0MRug4AWHnJbSjbs/nDI8APy4TPYo6iZzhFPBawHWW8K43ZvdCdbvChcgsVrsfooM6PrCDt7na57jn9BTEnZqMxquH+xXw5O13Hnjt2HVBavd/4ZSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=IZZE0R//; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30a8fd40723so1337106a91.2
        for <linux-arch@vger.kernel.org>; Thu, 08 May 2025 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1746726340; x=1747331140; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dEAIpsuCysn8s52UezknC02k+EhomijIPzdPSULwJfQ=;
        b=IZZE0R//+7aiPGIhTrnZj55Zbew9EGCK+JHrwLw0KAa41v3/s6Z9jfamK0WzqYJPCv
         hkBDSA4PSLhdP8O3HMMVsdxqvEaBi0ba6H1VJxQL/gRno0Vqs97M39ffN0gBRWzLBoD6
         ANRjU5EnJLWzUPJTlKAHiHYdjLnve2Zqsq1z9xTq9wjbovVm+YWMyZ3h82cNP6UHUK45
         e8IdrbxxoBo4Hiexx3/eIMv9RymfeiR6PbPYAHb4CQhHmwvthoJewJg4dFkXOGxwGlZe
         mf43vhNp7OYZsXIIpV1IyjeRslZg9EnKguG1QYR96v7ETpGjPss0OaBIwdocX1FARb/0
         fq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746726340; x=1747331140;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEAIpsuCysn8s52UezknC02k+EhomijIPzdPSULwJfQ=;
        b=ZMXGG6YZGqWMND5r/hV3CkidIp3wS1ViZ0iJCkILoYKo6EGpmcBCLCalkRI0oeicnL
         Kx/oHcBmJOLDRrvrfy9GWz235dDbeQ5C49ibtI0FStR1Vk0LMX6vq1u2cAThGq/6b/Sy
         gvxQZG+r8sU3a1MOcV9jUcUwg4BBxSNBdopDYce8/1fGIl1X8ntJAAx4A2S8Z1cSB2Lx
         KBv6b03dVy5jedL+vsaLc02ILVt7nCG+zFqxme4C8AnbQ0+6cUt6JWwDZ0eDcl49sLu/
         ju/wN+yfuVIapzNYTUB4dhXrPRTrPKnZ7C3sQmgwKlPRGdSkkxKnhSt/L+ABtmy/0nar
         5Dmg==
X-Forwarded-Encrypted: i=1; AJvYcCXFF+Xnr5oTLsZSc6SUrb3MyG87ldQbo8emrolsFgB0SrzKa+D29+LvJdkz7wHoSilCAlZf8++Iz482@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5LqKRAq2uMLoNN28mnWnn3hTaHkBk32n7uOiACyqsxxPS3dS
	BOHxvB0P0fZrLYCOm5UzcEQqsfIiMOAWOABk+yaTCzJS5hJdJIoXmvg7ABiXNh4=
X-Gm-Gg: ASbGncs3U43hSfA9qCfuR4euwUPk5PtUe23SoKN4ztpLQOK+KACKBx4V1vuRRmgsXrz
	BSwUxL+eEfswPuoUKYGX0x9JSibktTGGunGReoXrI7ICWUSnS7corHqMpdhLB6G0cVOl7yZmrWp
	aDQSTLybHP15UNjnng6CGqQDaBR0N69b99C5fYPVPYDClKRGCgFzeJaS8OERZPwc9SkCphqBI0G
	ZSI2YFELUwVXMiYDn6J8r/jBSlRQgXFRCpnQcSO4QFmTEyorlrKO6gWSa6z9l3Yele7Kb31g46a
	tBBNL0Qifs/axFJIuDd+WRDL3LEJhpnLIg==
X-Google-Smtp-Source: AGHT+IHeD97pMTFuyKCP/YT5KvCO+fk1gqZ4VsKAgAj3Z3vrsQq843QhamFknnUEu4uFYy+vJhv0hg==
X-Received: by 2002:a17:90b:3f04:b0:308:539d:7577 with SMTP id 98e67ed59e1d1-30c3b915960mr891237a91.0.1746726340334;
        Thu, 08 May 2025 10:45:40 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39e6101dsm259626a91.36.2025.05.08.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:45:39 -0700 (PDT)
Date: Thu, 08 May 2025 10:45:39 -0700 (PDT)
X-Google-Original-Date: Thu, 08 May 2025 10:45:38 PDT (-0700)
Subject:     Re: [PATCH v4 07/13] crypto: riscv/sha256 - implement library instead of shash
In-Reply-To: <20250428170040.423825-8-ebiggers@kernel.org>
CC: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
  linux-s390@vger.kernel.org, x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jason@zx2c4.com,
  Linus Torvalds <torvalds@linux-foundation.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ebiggers@kernel.org
Message-ID: <mhng-0b1a0c43-eff8-4ea0-9aaa-46727504555c@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

On Mon, 28 Apr 2025 10:00:32 PDT (-0700), ebiggers@kernel.org wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Instead of providing crypto_shash algorithms for the arch-optimized
> SHA-256 code, instead implement the SHA-256 library.  This is much
> simpler, it makes the SHA-256 library functions be arch-optimized, and
> it fixes the longstanding issue where the arch-optimized SHA-256 was
> disabled by default.  SHA-256 still remains available through
> crypto_shash, but individual architectures no longer need to handle it.
>
> To match sha256_blocks_arch(), change the type of the nblocks parameter
> of the assembly function from int to size_t.  The assembly function
> actually already treated it as size_t.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/riscv/crypto/Kconfig                     |  11 --
>  arch/riscv/crypto/Makefile                    |   3 -
>  arch/riscv/crypto/sha256-riscv64-glue.c       | 125 ------------------
>  arch/riscv/lib/crypto/Kconfig                 |   7 +
>  arch/riscv/lib/crypto/Makefile                |   3 +
>  .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    |   4 +-
>  arch/riscv/lib/crypto/sha256.c                |  62 +++++++++
>  7 files changed, 74 insertions(+), 141 deletions(-)
>  delete mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
>  rename arch/riscv/{ => lib}/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S (98%)
>  create mode 100644 arch/riscv/lib/crypto/sha256.c
>
> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
> index 4863be2a4ec2f..cd9b776602f89 100644
> --- a/arch/riscv/crypto/Kconfig
> +++ b/arch/riscv/crypto/Kconfig
> @@ -26,21 +26,10 @@ config CRYPTO_GHASH_RISCV64
>  	  GCM GHASH function (NIST SP 800-38D)
>
>  	  Architecture: riscv64 using:
>  	  - Zvkg vector crypto extension
>
> -config CRYPTO_SHA256_RISCV64
> -	tristate "Hash functions: SHA-224 and SHA-256"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> -	select CRYPTO_SHA256
> -	help
> -	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
> -
> -	  Architecture: riscv64 using:
> -	  - Zvknha or Zvknhb vector crypto extensions
> -	  - Zvkb vector crypto extension
> -
>  config CRYPTO_SHA512_RISCV64
>  	tristate "Hash functions: SHA-384 and SHA-512"
>  	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_SHA512
>  	help
> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> index 4ae9bf762e907..e10e8257734e3 100644
> --- a/arch/riscv/crypto/Makefile
> +++ b/arch/riscv/crypto/Makefile
> @@ -5,13 +5,10 @@ aes-riscv64-y := aes-riscv64-glue.o aes-riscv64-zvkned.o \
>  		 aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
>
>  obj-$(CONFIG_CRYPTO_GHASH_RISCV64) += ghash-riscv64.o
>  ghash-riscv64-y := ghash-riscv64-glue.o ghash-riscv64-zvkg.o
>
> -obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
> -sha256-riscv64-y := sha256-riscv64-glue.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
> -
>  obj-$(CONFIG_CRYPTO_SHA512_RISCV64) += sha512-riscv64.o
>  sha512-riscv64-y := sha512-riscv64-glue.o sha512-riscv64-zvknhb-zvkb.o
>
>  obj-$(CONFIG_CRYPTO_SM3_RISCV64) += sm3-riscv64.o
>  sm3-riscv64-y := sm3-riscv64-glue.o sm3-riscv64-zvksh-zvkb.o
> diff --git a/arch/riscv/crypto/sha256-riscv64-glue.c b/arch/riscv/crypto/sha256-riscv64-glue.c
> deleted file mode 100644
> index c998300ab8435..0000000000000
> --- a/arch/riscv/crypto/sha256-riscv64-glue.c
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * SHA-256 and SHA-224 using the RISC-V vector crypto extensions
> - *
> - * Copyright (C) 2022 VRULL GmbH
> - * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
> - *
> - * Copyright (C) 2023 SiFive, Inc.
> - * Author: Jerry Shih <jerry.shih@sifive.com>
> - */
> -
> -#include <asm/simd.h>
> -#include <asm/vector.h>
> -#include <crypto/internal/hash.h>
> -#include <crypto/internal/simd.h>
> -#include <crypto/sha256_base.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -
> -/*
> - * Note: the asm function only uses the 'state' field of struct sha256_state.
> - * It is assumed to be the first field.
> - */
> -asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
> -	struct crypto_sha256_state *state, const u8 *data, int num_blocks);
> -
> -static void sha256_block(struct crypto_sha256_state *state, const u8 *data,
> -			 int num_blocks)
> -{
> -	/*
> -	 * Ensure struct crypto_sha256_state begins directly with the SHA-256
> -	 * 256-bit internal state, as this is what the asm function expects.
> -	 */
> -	BUILD_BUG_ON(offsetof(struct crypto_sha256_state, state) != 0);
> -
> -	if (crypto_simd_usable()) {
> -		kernel_vector_begin();
> -		sha256_transform_zvknha_or_zvknhb_zvkb(state, data, num_blocks);
> -		kernel_vector_end();
> -	} else
> -		sha256_transform_blocks(state, data, num_blocks);
> -}
> -
> -static int riscv64_sha256_update(struct shash_desc *desc, const u8 *data,
> -				 unsigned int len)
> -{
> -	return sha256_base_do_update_blocks(desc, data, len, sha256_block);
> -}
> -
> -static int riscv64_sha256_finup(struct shash_desc *desc, const u8 *data,
> -				unsigned int len, u8 *out)
> -{
> -	sha256_base_do_finup(desc, data, len, sha256_block);
> -	return sha256_base_finish(desc, out);
> -}
> -
> -static int riscv64_sha256_digest(struct shash_desc *desc, const u8 *data,
> -				 unsigned int len, u8 *out)
> -{
> -	return sha256_base_init(desc) ?:
> -	       riscv64_sha256_finup(desc, data, len, out);
> -}
> -
> -static struct shash_alg riscv64_sha256_algs[] = {
> -	{
> -		.init = sha256_base_init,
> -		.update = riscv64_sha256_update,
> -		.finup = riscv64_sha256_finup,
> -		.digest = riscv64_sha256_digest,
> -		.descsize = sizeof(struct crypto_sha256_state),
> -		.digestsize = SHA256_DIGEST_SIZE,
> -		.base = {
> -			.cra_blocksize = SHA256_BLOCK_SIZE,
> -			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
> -				     CRYPTO_AHASH_ALG_FINUP_MAX,
> -			.cra_priority = 300,
> -			.cra_name = "sha256",
> -			.cra_driver_name = "sha256-riscv64-zvknha_or_zvknhb-zvkb",
> -			.cra_module = THIS_MODULE,
> -		},
> -	}, {
> -		.init = sha224_base_init,
> -		.update = riscv64_sha256_update,
> -		.finup = riscv64_sha256_finup,
> -		.descsize = sizeof(struct crypto_sha256_state),
> -		.digestsize = SHA224_DIGEST_SIZE,
> -		.base = {
> -			.cra_blocksize = SHA224_BLOCK_SIZE,
> -			.cra_flags = CRYPTO_AHASH_ALG_BLOCK_ONLY |
> -				     CRYPTO_AHASH_ALG_FINUP_MAX,
> -			.cra_priority = 300,
> -			.cra_name = "sha224",
> -			.cra_driver_name = "sha224-riscv64-zvknha_or_zvknhb-zvkb",
> -			.cra_module = THIS_MODULE,
> -		},
> -	},
> -};
> -
> -static int __init riscv64_sha256_mod_init(void)
> -{
> -	/* Both zvknha and zvknhb provide the SHA-256 instructions. */
> -	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
> -	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
> -	    riscv_isa_extension_available(NULL, ZVKB) &&
> -	    riscv_vector_vlen() >= 128)
> -		return crypto_register_shashes(riscv64_sha256_algs,
> -					       ARRAY_SIZE(riscv64_sha256_algs));
> -
> -	return -ENODEV;
> -}
> -
> -static void __exit riscv64_sha256_mod_exit(void)
> -{
> -	crypto_unregister_shashes(riscv64_sha256_algs,
> -				  ARRAY_SIZE(riscv64_sha256_algs));
> -}
> -
> -module_init(riscv64_sha256_mod_init);
> -module_exit(riscv64_sha256_mod_exit);
> -
> -MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
> -MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS_CRYPTO("sha256");
> -MODULE_ALIAS_CRYPTO("sha224");
> diff --git a/arch/riscv/lib/crypto/Kconfig b/arch/riscv/lib/crypto/Kconfig
> index bc7a43f33eb3a..c100571feb7e8 100644
> --- a/arch/riscv/lib/crypto/Kconfig
> +++ b/arch/riscv/lib/crypto/Kconfig
> @@ -4,5 +4,12 @@ config CRYPTO_CHACHA_RISCV64
>  	tristate
>  	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	default CRYPTO_LIB_CHACHA
>  	select CRYPTO_ARCH_HAVE_LIB_CHACHA
>  	select CRYPTO_LIB_CHACHA_GENERIC
> +
> +config CRYPTO_SHA256_RISCV64
> +	tristate
> +	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	default CRYPTO_LIB_SHA256
> +	select CRYPTO_ARCH_HAVE_LIB_SHA256
> +	select CRYPTO_LIB_SHA256_GENERIC
> diff --git a/arch/riscv/lib/crypto/Makefile b/arch/riscv/lib/crypto/Makefile
> index e27b78f317fc8..b7cb877a2c07e 100644
> --- a/arch/riscv/lib/crypto/Makefile
> +++ b/arch/riscv/lib/crypto/Makefile
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>
>  obj-$(CONFIG_CRYPTO_CHACHA_RISCV64) += chacha-riscv64.o
>  chacha-riscv64-y := chacha-riscv64-glue.o chacha-riscv64-zvkb.o
> +
> +obj-$(CONFIG_CRYPTO_SHA256_RISCV64) += sha256-riscv64.o
> +sha256-riscv64-y := sha256.o sha256-riscv64-zvknha_or_zvknhb-zvkb.o
> diff --git a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
> similarity index 98%
> rename from arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
> rename to arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
> index f1f5779e47323..fad501ad06171 100644
> --- a/arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
> +++ b/arch/riscv/lib/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
> @@ -104,12 +104,12 @@
>  	sha256_4rounds	\last, \k1, W1, W2, W3, W0
>  	sha256_4rounds	\last, \k2, W2, W3, W0, W1
>  	sha256_4rounds	\last, \k3, W3, W0, W1, W2
>  .endm
>
> -// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[8], const u8 *data,
> -//					       int num_blocks);
> +// void sha256_transform_zvknha_or_zvknhb_zvkb(u32 state[SHA256_STATE_WORDS],
> +//					       const u8 *data, size_t nblocks);
>  SYM_FUNC_START(sha256_transform_zvknha_or_zvknhb_zvkb)
>
>  	// Load the round constants into K0-K15.
>  	vsetivli	zero, 4, e32, m1, ta, ma
>  	la		t0, K256
> diff --git a/arch/riscv/lib/crypto/sha256.c b/arch/riscv/lib/crypto/sha256.c
> new file mode 100644
> index 0000000000000..18b84030f0b39
> --- /dev/null
> +++ b/arch/riscv/lib/crypto/sha256.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * SHA-256 (RISC-V accelerated)
> + *
> + * Copyright (C) 2022 VRULL GmbH
> + * Author: Heiko Stuebner <heiko.stuebner@vrull.eu>
> + *
> + * Copyright (C) 2023 SiFive, Inc.
> + * Author: Jerry Shih <jerry.shih@sifive.com>
> + */
> +
> +#include <asm/simd.h>
> +#include <asm/vector.h>
> +#include <crypto/internal/sha2.h>
> +#include <crypto/internal/simd.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +asmlinkage void sha256_transform_zvknha_or_zvknhb_zvkb(
> +	u32 state[SHA256_STATE_WORDS], const u8 *data, size_t nblocks);
> +
> +static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_extensions);
> +
> +void sha256_blocks_arch(u32 state[SHA256_STATE_WORDS],
> +			const u8 *data, size_t nblocks)
> +{
> +	if (static_branch_likely(&have_extensions) && crypto_simd_usable()) {
> +		kernel_vector_begin();
> +		sha256_transform_zvknha_or_zvknhb_zvkb(state, data, nblocks);
> +		kernel_vector_end();
> +	} else {
> +		sha256_blocks_generic(state, data, nblocks);
> +	}
> +}
> +EXPORT_SYMBOL(sha256_blocks_arch);
> +
> +bool sha256_is_arch_optimized(void)
> +{
> +	return static_key_enabled(&have_extensions);
> +}
> +EXPORT_SYMBOL(sha256_is_arch_optimized);
> +
> +static int __init riscv64_sha256_mod_init(void)
> +{
> +	/* Both zvknha and zvknhb provide the SHA-256 instructions. */
> +	if ((riscv_isa_extension_available(NULL, ZVKNHA) ||
> +	     riscv_isa_extension_available(NULL, ZVKNHB)) &&
> +	    riscv_isa_extension_available(NULL, ZVKB) &&
> +	    riscv_vector_vlen() >= 128)
> +		static_branch_enable(&have_extensions);
> +	return 0;
> +}
> +arch_initcall(riscv64_sha256_mod_init);
> +
> +static void __exit riscv64_sha256_mod_exit(void)
> +{
> +}
> +module_exit(riscv64_sha256_mod_exit);
> +
> +MODULE_DESCRIPTION("SHA-256 (RISC-V accelerated)");
> +MODULE_AUTHOR("Heiko Stuebner <heiko.stuebner@vrull.eu>");
> +MODULE_LICENSE("GPL");

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I assume you want to keep these all together somewhere, so I'm going to 
drop it from the RISC-V patchwork.

