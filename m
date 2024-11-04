Return-Path: <linux-arch+bounces-8834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C59BB276
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8291F1F220A2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 11:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E091C4A32;
	Mon,  4 Nov 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mluckDeM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F41C4A2B;
	Mon,  4 Nov 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717721; cv=none; b=JTqpQa6XLglfAdaqFNuDad1Wjb9oQPuk4FkQfxryqZIDdy3guZNg0/BRl5ygQJj+XwTKTYApZ/8g8BgWWxRCQa7BkdprdKRDfV+gVHoWTnbssAr281uKgQJfULB0T5pyEWgQ3m22zyxTUKEzUdzAnNtTEEowyb4e+Oa3pWHSPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717721; c=relaxed/simple;
	bh=Xsd60VaJMVJJJZwPYCiMbYDsq4aVLjYnOCS09bBiIXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6cL5fvZBv+zmEffI+XQ3SiFEXtxoxZeMTm6smTG4nIFRjTEtbLpBZzIvO3phr5YWn0rbeePDIpl5C5bPcvZfD7f1CvvvfWbY8csiTiIFhPtj3b3Au7z8P3nVos0RfxGUyCKja/wVBDBlNXCXTJCd5k7fJFuqNtR4dYqfsBTk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mluckDeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810BDC4CED5;
	Mon,  4 Nov 2024 10:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717721;
	bh=Xsd60VaJMVJJJZwPYCiMbYDsq4aVLjYnOCS09bBiIXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mluckDeMk6i5aN2XBOA1zfp0B5xurNz8wOuuO6UKYkZqld8M1vPhMjikatVUxYIq1
	 o/o2n4QC5unxoa1BCq0QEJuuUGosOaiWVlAfms7oPabM1IPV7T5QCnjD432LtwU6jM
	 qNyRNziXoq7Y5K909RLvlKf7uf+1MvZd6Ak8eCwV7pk3wdhybH+DxGdKIZqFxDiZgi
	 /iQnjicc1WrBfd1q+/hj/6yterw6uw+CgPyujA3SNAenk3a2+tEKgLA1Q7vvvsnEYL
	 Fa4fRc5HTw91i3Ikfsm6UaVHVMpdSHGkU3B2sp1paNLh1UwprUskCBwrZH7BP89RDz
	 Po3mKNTx8CmzQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso57807281fa.2;
        Mon, 04 Nov 2024 02:55:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURVbc2V3WeKxNTxTfQFbEMkq1xfReT+d82xiZRYFOVzGscoxL5kQYU8Xe3hmjZHl5jP5GLvJJYh/2l@vger.kernel.org, AJvYcCUT5e5bWXiA/hasTRnbN9yoMGIp4rjtAcLlgvssbentTzExdf/H/tm5ooTxYywucWJZXJymlu0Cvt2U9RVk@vger.kernel.org, AJvYcCUmoSWHgbYQWkM3VMkFWHiB3AZ+c40UTNM/L3hYlfgK5xJNccHdAKLABJn03xbOyBccVWSXAcyftgzFRA==@vger.kernel.org, AJvYcCVdoz444u4Zp09JQs1amMQhMK7cWsgqAb7BU7DYtywuVTjBiA//aB38Vyvighbi9S8OSydLuOEOOdFWvw==@vger.kernel.org, AJvYcCW+sJwmGrCaq51A6hWw2r9N4LIXoaMTpeNgJC+RPXiJsIRvX/WHj3lB/H/hCz9sst9J+jRxDI1vl0O+xQ==@vger.kernel.org, AJvYcCX8bEV+Po7jr8aaIUfUl5SAxaz3E9cO0OvSEEYDVMhmn2Jw8pFtV+R9MF7qi75izZn4lqRPsHpRAEXeQQ==@vger.kernel.org, AJvYcCXk7Grx4/0vPFia4ry3ko9yt0F7VPMAegRT1le+uRHvBTn8+tHmsNeKVd7U4twO6A0PygmjnthqHV2DLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCMDGCtYWO/2MwvIBQ8Miy4LrGMRLVO6/bo1v8iXKd5MiJ3CQ
	KSACdsfpQ7l6tULbNeiBQFWTWA5blxRl/D4BJ/UV97GahtJgF2rpG8oaRl5BwDhERorQ0s5UfrV
	NW6UmA4g4j2poQN/q5T85S5aC0xc=
X-Google-Smtp-Source: AGHT+IFk0/CXdpRr9EA2xNrpgIcdFsD8CEdy30mzTFb0ZlXY/QnyWMuejDDml1MTkf5LmjGORWJ2C6sLEZMa+NCqqXc=
X-Received: by 2002:a2e:be9f:0:b0:2fb:8c9a:fe3f with SMTP id
 38308e7fff4ca-2fedb7c8904mr72976731fa.22.1730717719875; Mon, 04 Nov 2024
 02:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103223154.136127-1-ebiggers@kernel.org> <20241103223154.136127-4-ebiggers@kernel.org>
In-Reply-To: <20241103223154.136127-4-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Nov 2024 11:55:08 +0100
X-Gmail-Original-Message-ID: <CAMj1kXErAGvJ+ZK1SMQQKVbbZVhjxaWzn0gmV-xxtsoWSuwT9g@mail.gmail.com>
Message-ID: <CAMj1kXErAGvJ+ZK1SMQQKVbbZVhjxaWzn0gmV-xxtsoWSuwT9g@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] lib/crc32: expose whether the lib is really
 optimized at runtime
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 3 Nov 2024 at 23:34, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Make the CRC32 library export a function crc32_optimizations() which
> returns flags that indicate which CRC32 functions are actually executing
> optimized code at runtime.
>
> This will be used to determine whether the crc32[c]-$arch shash
> algorithms should be registered in the crypto API.  btrfs could also
> start using these flags instead of the hack that it currently uses where
> it parses the crypto_shash_driver_name.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm64/lib/crc32-glue.c  | 10 ++++++++++
>  arch/riscv/lib/crc32-riscv.c | 10 ++++++++++
>  include/linux/crc32.h        | 15 +++++++++++++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/arch/arm64/lib/crc32-glue.c b/arch/arm64/lib/crc32-glue.c
> index d7f6e1cbf0d2..15c4c9db573e 100644
> --- a/arch/arm64/lib/crc32-glue.c
> +++ b/arch/arm64/lib/crc32-glue.c
> @@ -83,7 +83,17 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
>
>         return crc32_be_arm64(crc, p, len);
>  }
>  EXPORT_SYMBOL(crc32_be_arch);
>
> +u32 crc32_optimizations(void)
> +{
> +       if (alternative_has_cap_likely(ARM64_HAS_CRC32))
> +               return CRC32_LE_OPTIMIZATION |
> +                      CRC32_BE_OPTIMIZATION |
> +                      CRC32C_OPTIMIZATION;
> +       return 0;
> +}
> +EXPORT_SYMBOL(crc32_optimizations);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("arm64-optimized CRC32 functions");
> diff --git a/arch/riscv/lib/crc32-riscv.c b/arch/riscv/lib/crc32-riscv.c
> index a3ff7db2a1ce..53d56ab422c7 100644
> --- a/arch/riscv/lib/crc32-riscv.c
> +++ b/arch/riscv/lib/crc32-riscv.c
> @@ -295,7 +295,17 @@ u32 __pure crc32_be_arch(u32 crc, const u8 *p, size_t len)
>  legacy:
>         return crc32_be_base(crc, p, len);
>  }
>  EXPORT_SYMBOL(crc32_be_arch);
>
> +u32 crc32_optimizations(void)
> +{
> +       if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBC))
> +               return CRC32_LE_OPTIMIZATION |
> +                      CRC32_BE_OPTIMIZATION |
> +                      CRC32C_OPTIMIZATION;
> +       return 0;
> +}
> +EXPORT_SYMBOL(crc32_optimizations);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Accelerated CRC32 implementation with Zbc extension");
> diff --git a/include/linux/crc32.h b/include/linux/crc32.h
> index 58c632533b08..e9bd40056687 100644
> --- a/include/linux/crc32.h
> +++ b/include/linux/crc32.h
> @@ -35,10 +35,25 @@ static inline u32 __pure __crc32c_le(u32 crc, const u8 *p, size_t len)
>         if (IS_ENABLED(CONFIG_CRC32_ARCH))
>                 return crc32c_le_arch(crc, p, len);
>         return crc32c_le_base(crc, p, len);
>  }
>
> +/*
> + * crc32_optimizations() returns flags that indicate which CRC32 library
> + * functions are using architecture-specific optimizations.  Unlike
> + * IS_ENABLED(CONFIG_CRC32_ARCH) it takes into account the different CRC32
> + * variants and also whether any needed CPU features are available at runtime.
> + */
> +#define CRC32_LE_OPTIMIZATION  BIT(0) /* crc32_le() is optimized */
> +#define CRC32_BE_OPTIMIZATION  BIT(1) /* crc32_be() is optimized */
> +#define CRC32C_OPTIMIZATION    BIT(2) /* __crc32c_le() is optimized */
> +#if IS_ENABLED(CONFIG_CRC32_ARCH)
> +u32 crc32_optimizations(void);
> +#else
> +static inline u32 crc32_optimizations(void) { return 0; }
> +#endif
> +
>  /**
>   * crc32_le_combine - Combine two crc32 check values into one. For two
>   *                   sequences of bytes, seq1 and seq2 with lengths len1
>   *                   and len2, crc32_le() check values were calculated
>   *                   for each, crc1 and crc2.
> --
> 2.47.0
>
>

