Return-Path: <linux-arch+bounces-11457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219F8A93C5B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 19:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBD6189FEF9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Apr 2025 17:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B422A4D8;
	Fri, 18 Apr 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="rNiJphm8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D42288D2
	for <linux-arch@vger.kernel.org>; Fri, 18 Apr 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998631; cv=none; b=BTn5p5YAyqbZW4se+Yty0iAFg4w1q1+vtkskbXNAsbvQQOyokopqnEC7CLXZk1Rw7svmunmBKA3vgpV+/6XXw8mteGxkcXZQQRXhtG8jrxuCihJMuRxUCbOgzGqXlenZQmXtK0nnkdwhiSB9CD9A4vcuR0V1iTKzGulZ8YPCWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998631; c=relaxed/simple;
	bh=AzeVQAOnRtcbGIrt74vKKg1t+G+1IlWiUF0f/IMwOvY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=YEdeBH9KdsAqBSf1isOS3ODMPhO6RniKzw9phul7zk5RdtUz/zzX6ga/vkuxPTjQgHtNXGmhdM/1SHDMt02dRyJQXjqfkK/ZbINOSFz3hkjNKanV8wl9GWZH3zRwVaIY1VFzOPMg2fCb2/J14vuiThyRNC1NOSd+guO82zzniJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=rNiJphm8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2255003f4c6so26212795ad.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Apr 2025 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1744998628; x=1745603428; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xitBrw85Cpa/PH99l1OqltSYYTa4EEM01UtrGh+UZZU=;
        b=rNiJphm8duOFgq6fY8LWfc4D1iONPxu1H7i0MNHYxtwgxPNdD3kJcvIi6To+ZsBfKQ
         K39iwYzygNtLkY+mRH5CTJeRHWm85WrOxQXHk/PtkJW53j2/F7Yl6L+7RQ8GMNiIqXie
         nF9gkCu/IPPH2xyeSMC/QEGOpizuxFfwzDWQpLMQZL2Pzj2Tyl4n6bq5VkxrLUW2tgiT
         vpzP5YT+CAqsQVZ1ZW2cxlF+ii69k8o8RztIXXFNYlYERdCoVtGeGNn5y0tVoAiknCxb
         shJ7BEaPcCc64rTSkc2dTI1BLvrxrNmTfXguc+Hb2vTBN6jDl/K1hdRoNq2ndjHwwqzB
         +sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998628; x=1745603428;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xitBrw85Cpa/PH99l1OqltSYYTa4EEM01UtrGh+UZZU=;
        b=hxQ+2Ay9HqttAKjjcn6mqczc2iQL7KBICxSfGmi3SBsiu1GlsIHE5yodQ+zjw1klPb
         bbROe6KBGMOJUhD7V303RdGjxgIVV0Zw7QYu27FbZtq1F6VlpPAEfUfY1SReTxxQV/pv
         qs7JTnDlOJSGwOCGvhzsHTttApKKQbU4wHDEXVZnSUeX/M74KryFaHnMQPn2W16i2gFj
         5Gql/Bz4gKQUxl0wMAGkJIq74vQR8L1i+EK7217char6BahaSpdeMsTFG7n5WsjFutcI
         eQt/B6jInujyrDoXYETxh1lT20pqJ5PmXdGoDIq5J3TGhaW2X10qXhAf5guDxAdsfjkH
         5RAA==
X-Forwarded-Encrypted: i=1; AJvYcCVbYJJsLj9LqyLY0KMBL2WyAuOxzlrW3MBG1ZFjTjeeDsLa+x/jEeI7rziGKnGRx/xN0pY0pHXhUAJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUiHVhJdSfpFcV5mAzyLrbIaK/jskQVmB6+Gq+x+qzdND9N/r
	lDonTI/01d9H696oMsGq+rxo9bbdHIJRr7zOQuNaNK2I0QY1jo1KD+jv50LEGRc=
X-Gm-Gg: ASbGnctQW8gGeDqXk0jEEwVI77xeydgqW1P3+/Eb+NecWcN+LQybuDDpMA32ZyYVxYs
	kNgCuXf60cVotXH8QBU68lg6s/huyvQy86FWPLcKqtXmtkwubmTNVlK/98QKlmidpboyMIHoq6u
	U069GZsThb2g/fOWpvCoVBmNcVDySmgUNtP+pP3VqZSN1OECxU3vQr2DyM1r5U+jLfrFs66xyfs
	SdsUxDunQbrXGapKk9gngmZay8wdDGWVM8omT6dJxSmApwtSRQ6Jlm0IYbiv6uPdHNxslKZGM8p
	enFSziuUEHlzuxcio8sV506JJsoHB9XCrA==
X-Google-Smtp-Source: AGHT+IHTtFpIUh9V1D/hgIg7h0JnpsXp9Bovo24GVumcqsEBZfrWrJPuzOPDear/0hml7HCNfS1GQA==
X-Received: by 2002:a17:903:98f:b0:221:7eae:163b with SMTP id d9443c01a7336-22c53627298mr52330365ad.46.1744998628042;
        Fri, 18 Apr 2025 10:50:28 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde845sm19513745ad.236.2025.04.18.10.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:50:27 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:50:27 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Apr 2025 10:50:25 PDT (-0700)
Subject:     Re: [PATCH 08/15] crypto: riscv - remove CRYPTO dependency of library functions
In-Reply-To: <20250417182623.67808-9-ebiggers@kernel.org>
CC: linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
  linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Jason@zx2c4.com,
  Ard Biesheuvel <ardb@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ebiggers@kernel.org
Message-ID: <mhng-78030c23-f066-4b83-8d7b-c1720725199d@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

On Thu, 17 Apr 2025 11:26:16 PDT (-0700), ebiggers@kernel.org wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Continue disentangling the crypto library functions from the generic
> crypto infrastructure by removing the unnecessary CRYPTO dependency of
> CRYPTO_CHACHA_RISCV64.  To do this, make arch/riscv/crypto/Kconfig be
> sourced regardless of CRYPTO, and explicitly list the CRYPTO dependency
> in the symbols that do need it.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/riscv/Kconfig        |  2 ++
>  arch/riscv/crypto/Kconfig | 12 ++++++------
>  crypto/Kconfig            |  3 ---
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..baa7b8d98ed8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1349,8 +1349,10 @@ source "drivers/cpuidle/Kconfig"
>
>  source "drivers/cpufreq/Kconfig"
>
>  endmenu # "CPU Power Management"
>
> +source "arch/riscv/crypto/Kconfig"
> +
>  source "arch/riscv/kvm/Kconfig"
>
>  source "drivers/acpi/Kconfig"
> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
> index 27a1f26d41bd..08547694937c 100644
> --- a/arch/riscv/crypto/Kconfig
> +++ b/arch/riscv/crypto/Kconfig
> @@ -2,11 +2,11 @@
>
>  menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
>
>  config CRYPTO_AES_RISCV64
>  	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTS"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_LIB_AES
>  	select CRYPTO_SKCIPHER
>  	help
>  	  Block cipher: AES cipher algorithms
> @@ -25,43 +25,43 @@ config CRYPTO_CHACHA_RISCV64
>  	select CRYPTO_LIB_CHACHA_GENERIC
>  	default CRYPTO_LIB_CHACHA_INTERNAL
>
>  config CRYPTO_GHASH_RISCV64
>  	tristate "Hash functions: GHASH"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_GCM
>  	help
>  	  GCM GHASH function (NIST SP 800-38D)
>
>  	  Architecture: riscv64 using:
>  	  - Zvkg vector crypto extension
>
>  config CRYPTO_SHA256_RISCV64
>  	tristate "Hash functions: SHA-224 and SHA-256"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_SHA256
>  	help
>  	  SHA-224 and SHA-256 secure hash algorithm (FIPS 180)
>
>  	  Architecture: riscv64 using:
>  	  - Zvknha or Zvknhb vector crypto extensions
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SHA512_RISCV64
>  	tristate "Hash functions: SHA-384 and SHA-512"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_SHA512
>  	help
>  	  SHA-384 and SHA-512 secure hash algorithm (FIPS 180)
>
>  	  Architecture: riscv64 using:
>  	  - Zvknhb vector crypto extension
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SM3_RISCV64
>  	tristate "Hash functions: SM3 (ShangMi 3)"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_HASH
>  	select CRYPTO_LIB_SM3
>  	help
>  	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
>
> @@ -69,11 +69,11 @@ config CRYPTO_SM3_RISCV64
>  	  - Zvksh vector crypto extension
>  	  - Zvkb vector crypto extension
>
>  config CRYPTO_SM4_RISCV64
>  	tristate "Ciphers: SM4 (ShangMi 4)"
> -	depends on 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
> +	depends on CRYPTO && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
>  	select CRYPTO_ALGAPI
>  	select CRYPTO_SM4
>  	help
>  	  SM4 block cipher algorithm (OSCCA GB/T 32907-2016,
>  	  ISO/IEC 18033-3:2010/Amd 1:2021)
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 2467dba73372..8c334c9f2081 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1424,13 +1424,10 @@ endmenu
>
>  config CRYPTO_HASH_INFO
>  	bool
>
>  if !KMSAN # avoid false positives from assembly
> -if RISCV
> -source "arch/riscv/crypto/Kconfig"
> -endif
>  if S390
>  source "arch/s390/crypto/Kconfig"
>  endif
>  if SPARC
>  source "arch/sparc/crypto/Kconfig"

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I'm assuming you want to take this with the rest, thanks!

