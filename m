Return-Path: <linux-arch+bounces-9908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB542A1C53F
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 22:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBD116553D
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 21:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05757204583;
	Sat, 25 Jan 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRUuz4gM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD2FC0A;
	Sat, 25 Jan 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737839793; cv=none; b=h/S2nyQOaJGg9GV+ltHIBrs3GJYUmLDxogK11XAdFEFz5zha1C21LAnCi/Na7Cq/JePhyDJnlSkYjP9h1NXLd4gWsaQ2WBTHtuYt7cf704w9lnVBBhIm/bruZHmWBD/8x5vpmNcb9bUTW49yZAqgJcrGqCgu6Ta2L0woREWYBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737839793; c=relaxed/simple;
	bh=SDFlf87Z4JWEowvZf5Iq5Pm0A9BrVo26wj1wJxRWjqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnOcaxKTpRC/TPLFLXdxBsxITRVLdJ8lvB4u4Kn6Dva7dssN52O8gecoHbN8WTOkoAjpyX0k+3ezaJPqyShKQaB3MiXIIHLw/vorHpSfESUA9/LxL9FJiDK69KczParYC0rccs+iTmREcf1P50J3GhjiMTMfe47W1Nk1hO/QbBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRUuz4gM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283d48so22640415e9.1;
        Sat, 25 Jan 2025 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737839790; x=1738444590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ze29MjfXx3RmpsDYVSXrKwETuiQHNIWKeyGusIsqrg=;
        b=PRUuz4gMG1E2wJlLvKZ0D34ufZpipp3fpt1iE9xFqym7kdGAW9hAazKprlCh39bEJT
         Pe9ZmFxw2ZlpDgLo/hkWoz6iMa5B7OPnwCfzcSjJUSx1Pb1/wWuGnEl63nogZDtri3Mj
         KtMdNcjxy0q1cm1o/K05NyC/9iSpO2+4xc7b7YEP/6IaZv8Myv45QeHzoH1WwzWe6XOW
         MPioCCv4ZK+C7sM1Y0KQXlyfx0dRJoffvjCr+iwyIVCn3Qp6wd4/TJeS3AZs8WDJ21zU
         +gIP+jD4XncnVEFBPwjNBhovTeDItlLr/I1kXFSmMXJa3mH9WoSjD8YUijHL5xruGD4Z
         L4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737839790; x=1738444590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ze29MjfXx3RmpsDYVSXrKwETuiQHNIWKeyGusIsqrg=;
        b=ukYINQkSjZWHRK8txa0YJo8eKHQ0iR+enpT6bddv/51j05cjZIMPlpWsrn/wL3yu7c
         Vio7p67+DEVuecMztFqvSUesyJ3T1+N2Duf+JzvePNBUN/a0V8XGnzCnmggj7RGPM9lP
         1thZogXvfBZYTVC0GCef73Kt3AkRx/zir0lDU8HvoERNROOPOrUhhbypDXsRiAr1ICrH
         RyL2qSyzGRMnS0fb9HFZYYa9isLnppk2ZUmsiH1FIJ2ws91k3Mf9VsAc1aRDhfDYBWIS
         s0jCpP4mvmc/xBij5Ks73mRi64XBHmvFs4RrSV7mKMf/52bL78LLKOY6t977NfhcDVAW
         7cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvG6FTo4zXkR8KjdZFCVCLV/8tcug6kT4V/CU7UiuJ3iDxSoeqkk5JlkdO82vjPNo9IAKfbzOkgqxA@vger.kernel.org, AJvYcCVB3KBTCtbd/zFgBswSr9qoKV9VcIbrSF0maihp98QiQAF4j+wkdN8Eljj79K026j4wS8lpsOLJofE/iL0FJQ==@vger.kernel.org, AJvYcCW8IBF27XvwQVo48uMtxa/V/OSDx5wg1/fmZbvkqIiyzYlGXbbsr2rsIzDF5n5FE3oL4KeRFllZpNlhZKNzg75OwFUKS6DJ@vger.kernel.org, AJvYcCX8RAyfNO9dSZ/aKUP2NKqdEhMmZHnzwa8RvehldZ14oGy9H+aQiNxBDTkrgUrka6E4xUpCI/h5LWd6v7wf@vger.kernel.org, AJvYcCXPlx58JRf5zjZN5cBg3sdxezomCOfTZrf6iFE/YitwmfR5MJsCzlEMN7zJfcGUUDpKyCLkAPZwh84S@vger.kernel.org, AJvYcCXy4wC8Vsw7mUG2YCLHQzMeDbWICtPSQ4Hwkq4ppHZ7q03S3OfI3SKBuPvKDV2HZSXzZ3t5gUw55YdpGTHy@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiQ2aF6EgXXZHOwlx4Typ8km4MGvQ0gLbuoI+vuvRe8KCGiax
	d9viHbZHjDlfTXcSPV3Lw5tSIX9O6Xb2lzSWHvuxvMLUAMkldU2b
X-Gm-Gg: ASbGncuW70CpBWP8jyXYTaI35NCX6PG7puFtbyQ8DgjTjDpKgIp5bLk+ERNdsCZlCEX
	xHFBy15mGj3h5KHQ6QiTE5ZsdHvRjLftFgDQiu/f6Hs0NOAUqEu6sv/9kjo7bwY/UZxp6H/FkmM
	6+BC7S0U4f5hYiDPQFdvHILBrEOEZnmAUYY+wwbm/q2E2jy+3C7YM/KfBSt10kTEqoKH2e/VLzh
	DX7mPONH/xdCLUYYJLQ8SJXXp0AkGdCY4E/NJzqQgGhuUXlAQvBC/8mMyLxfaSWGX2UM73DeiqQ
	5OIxCp6nap8ybt28kobjuStLLNlHgxwNdq1cB/VuQX/Kvmc=
X-Google-Smtp-Source: AGHT+IELfmGSKKYpbr06m9ndT0x2MR7VyHmuIe6ybmA2w3pnO4RNREAKAULK2CdBNm2M6H6RrDIv/w==
X-Received: by 2002:a05:600c:138a:b0:435:194:3cdf with SMTP id 5b1f17b1804b1-438914292demr321258325e9.19.1737839790030;
        Sat, 25 Jan 2025 13:16:30 -0800 (PST)
Received: from ?IPV6:2a02:a58:920d:7400:ab8f:6de:fa7e:730a? ([2a02:a58:920d:7400:ab8f:6de:fa7e:730a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c3c8csm6626617f8f.90.2025.01.25.13.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 13:16:29 -0800 (PST)
Message-ID: <91eadb0b-d898-43ca-9c10-48363e1c3e7a@gmail.com>
Date: Sat, 25 Jan 2025 23:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>
In-Reply-To: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/20/25 19:44, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds:
> Either the module signing key is generated at build time, which makes
> the build unreproducible, or a static key is used, which precludes
> rebuilds by third parties and makes the whole build and packaging
> process much more complicated.
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a list of hashes of all modules built as part of the full
> kernel build into vmlinux.
> 
> Interest has been proclaimed by NixOS, Arch Linux, Proxmox, SUSE and the
> general reproducible builds community.
> 
> To properly test the reproducibility in combination with CONFIG_INFO_BTF
> another patch is needed:
> "[PATCH bpf-next] kbuild, bpf: Enable reproducible BTF generation" [0]
> (If you happen to test that one, please give some feedback)
> 
> Questions for current patch:
> * Naming
> * Can the number of built-in modules be retrieved while building
>    kernel/module/hashes.o? This would remove the need for the
>    preallocation step in link-vmlinux.sh.
> 
> Further improvements:
> * Use a LSM/IMA/Keyring to store and validate hashes
> * Use MODULE_SIG_HASH for configuration
> * UAPI for discovery?
> 
> [0] https://lore.kernel.org/lkml/20241211-pahole-reproducible-v1-1-22feae19bad9@weissschuh.net/

Hello,

Thank you for your work on helping to enable kernel lockdown coupled 
with reproducible builds.

This may be out scope for this patch series, however I think it is worth 
considering: How does one include hashes of modules that have not been 
built as part of the kernel into the array? For example a DKMS module or 
NVIDIA driver?

A solution that may be worth considering would be to include a list of 
modules hashes into the kernel command-line. It may be even worth 
considering keeping a dynamic array of hashes that can be locked at a 
given point in time?

All the best,
Mihai

> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Drop RFC state
> - Mention interested parties in cover letter
> - Expand Kconfig description
> - Add compatibility with CONFIG_MODULE_SIG
> - Parallelize module-hashes.sh
> - Update Documentation/kbuild/reproducible-builds.rst
> - Link to v1: https://lore.kernel.org/r/20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net
> 
> ---
> Thomas Weißschuh (6):
>        kbuild: add stamp file for vmlinux BTF data
>        module: Make module loading policy usable without MODULE_SIG
>        module: Move integrity checks into dedicated function
>        module: Move lockdown check into generic module loader
>        lockdown: Make the relationship to MODULE_SIG a dependency
>        module: Introduce hash-based integrity checking
> 
>   .gitignore                                   |  1 +
>   Documentation/kbuild/reproducible-builds.rst |  5 ++-
>   Makefile                                     |  8 ++++-
>   include/asm-generic/vmlinux.lds.h            | 11 ++++++
>   include/linux/module.h                       |  8 ++---
>   include/linux/module_hashes.h                | 17 +++++++++
>   kernel/module/Kconfig                        | 21 ++++++++++-
>   kernel/module/Makefile                       |  1 +
>   kernel/module/hashes.c                       | 52 +++++++++++++++++++++++++++
>   kernel/module/internal.h                     |  8 +----
>   kernel/module/main.c                         | 54 +++++++++++++++++++++++++---
>   kernel/module/signing.c                      | 24 +------------
>   scripts/Makefile.modfinal                    | 10 ++++--
>   scripts/Makefile.vmlinux                     |  5 +++
>   scripts/link-vmlinux.sh                      | 31 +++++++++++++++-
>   scripts/module-hashes.sh                     | 26 ++++++++++++++
>   security/lockdown/Kconfig                    |  2 +-
>   17 files changed, 238 insertions(+), 46 deletions(-)
> ---
> base-commit: 2cd5917560a84d69dd6128b640d7a68406ff019b
> change-id: 20241225-module-hashes-7a50a7cc2a30
> 
> Best regards,


