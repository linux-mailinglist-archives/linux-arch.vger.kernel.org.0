Return-Path: <linux-arch+bounces-8530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB49AFB46
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8911028158B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66091B6CF6;
	Fri, 25 Oct 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bns4FpYE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDC1B6D00;
	Fri, 25 Oct 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842028; cv=none; b=qLf9bmpvuzV8fzTR/ceCcJoUpy26QN9f2q8JZDpFXlmJjaaRGiO5xiaRm8+DCbEx4+1hFN3WyijFCdkBk/BtI1WlavGBAChvTm0ZNfpkeygv6jZfNCo2logiB93hOTr5m+468vgfHPV0qL3AbUzS8BG+1Xwc97Hub/ydNtUbzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842028; c=relaxed/simple;
	bh=MU0jg6+43zlNLQVd5aws5IUywfNhZ0pf6SBTcrSFP0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msrv8eVTgXLRaDR0K4ZaIOcLUg40meGpI4+l/Z97oBrW6wRqjcYy0ZZ7gb+lR1aeC2K71cdAjcK1Q8EnN6O/U3r8MKKAM1MyJsYo7dTxLwlWhNrxG8Z1D3GiVcQr8Ec6x3AxiLeJuYzHyvcUkXznDqHtxDVCD/H36EvvQPnXfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bns4FpYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD1C4CEC3;
	Fri, 25 Oct 2024 07:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729842028;
	bh=MU0jg6+43zlNLQVd5aws5IUywfNhZ0pf6SBTcrSFP0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bns4FpYEweNUDYPWIatTemxTcPXBriNtb6rjMCIGvpZQbQ7/qRGjK2NUk57EKd8ri
	 Mk7HPhv+F7E7+ne72q/Ef8D3KErbLL714tyOI87uCXXzpqZPjXEj/i4/+9MWReDl8T
	 31XCgHFlQsFjl2p95RIKGtfYYk1e4JVgIerVkCXXYdafVkZcg3QKpbq5FXjAqZ38fM
	 DtIUhA6qC/BFjMOrnIVEq9dcd5psyxRFBFdvdxlZAU53TWdpVzWckgliF8es3kpb65
	 T8IX9T0uVRiGneDDJjNiP5c9pbh4ac6m1We4OCbuxBE3WORWLtjtdEfr9QTbaV9H3L
	 0RlKKzK9CtgkA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e59dadebso2249464e87.0;
        Fri, 25 Oct 2024 00:40:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAdcneLh/Jws74xknc45IZeTEe2oK6Y69+tVBiYoEj/qt+RcbmIb24PrS0Yk1dBAvk29QFalANx4ixXw==@vger.kernel.org, AJvYcCW80iP/cw78mwBoxiazcIaMp46Ss9ASatJB3w/3sU7Y98UMR3/4tQTIlcVmtbO/FNdxjEhxRc2zDbkITA==@vger.kernel.org, AJvYcCWPQSZCyhlvaeHuT9D6M1WAaY09cKDfSHPANOapyuIpYAEiD+i3pv2J3M0TMYewN6bJ5kQ4xm6RaFEKB3sW@vger.kernel.org, AJvYcCWUGbfqEO2I8386+2LsYl82NCyqnvpOA+iWbT1jCasE83dc1CGSKbsjGyWJYilhSp8Y00dNfDzQE1B8rA==@vger.kernel.org, AJvYcCWc1CJSV4iR81S8Ez/FWPtUfoS3wmWvrU3KC4Oy6D5DWeumUddqhIjoLtYwQbILekhJgwtEWPQ/8fx3@vger.kernel.org, AJvYcCWwnkYupm8hkTFzLR6MEIKC1LqDq5vgKx+LOXyDhZwKgYIUC71sM0qupPCZHqFx2etFbOY7ue93eLBJOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvxTD7Kmf8juWMyZ6YXDkR1k1FEJXcMc/72l+/3L15+sUXv57y
	ScS/gjRt+63bb2+8EfcwtL2dsPQlkrX4SSgZ7ivXf9xLUGTOiLnXXe+Uz6kZo5ghdFVyJJwP2pU
	Z1zzFD5dUVjukdsPbavc02vgWask=
X-Google-Smtp-Source: AGHT+IEDAFlBfPHEymedMPiV9v2ocdpZeEcg/F0dpwJWqR1hIRTo+DXjnmCVJHCSWsx5j4Mh2CDnA31kbRPsOrauBps=
X-Received: by 2002:a05:6512:3c8c:b0:539:8f3c:457c with SMTP id
 2adb3069b0e04-53b23e9d130mr2447127e87.53.1729842026517; Fri, 25 Oct 2024
 00:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021002935.325878-1-ebiggers@kernel.org>
In-Reply-To: <20241021002935.325878-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 25 Oct 2024 09:40:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHDo8dijRbSVuHzTddMhp4A+nc1t8AgvoENmS=DZ-kAOQ@mail.gmail.com>
Message-ID: <CAMj1kXHDo8dijRbSVuHzTddMhp4A+nc1t8AgvoENmS=DZ-kAOQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] Wire up CRC32 library functions to arch-optimized code
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 02:29, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This patchset is also available in git via:
>
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc32-lib-v1
>
> CRC32 is a family of common non-cryptographic integrity check algorithms
> that are fairly fast with a portable C implementation and become far
> faster still with the CRC32 or carryless multiplication instructions
> that most CPUs have.  9 architectures already have optimized code for at
> least some CRC32 variants; however, except for arm64 this optimized code
> was only accessible through the crypto API, not the library functions.
>
> This patchset fixes that so that the CRC32 library functions use the
> optimized code.  This allows users to just use the library instead of
> the crypto API.  This is much simpler and also improves performance due
> to eliminating the crypto API overhead including an indirect call.  Some
> examples of updating users are included at the end of the patchset.
>
> Note: crc32c() was a weird case.  It was a library function layered on
> top of the crypto API, which in turn is layered on top of the real
> library functions.  So while it was easy to use, it was still subject to
> the crypto API overhead.  This patchset provides CRC32C acceleration in
> the real library functions directly.
>
> The updated CRC32 library design is:
>
> - Each arch's CRC32 code (all variants) is in arch/$ARCH/lib/crc32*.
>   This adopts what arm64 and riscv already did.  Note, the crypto
>   directory is not used because CRC32 is not a cryptographic algorithm.
>
> - Weak symbols are no longer used.  Instead there are crc32*_base() and
>   crc32*_arch(), and the appropriate ones are called based on the
>   kconfig.  This is similar to how the ChaCha20 library code works.
>
> - Each arch's CRC32 code is enabled by default when CRC32 is enabled,
>   but it can now be disabled, controlled by the choice that previously
>   controlled the base implementation only.  It can also now be built as
>   a module if CRC32 is a module too.
>
> - Instead of lots of pointless glue code that wires up each CRC32
>   variant to the crypto API for each architecture, we now just rely on
>   the existing shash algorithms that use the library functions.
>
> - As before, the library functions don't provide access to off-CPU
>   crypto accelerators.  But these appear to have very little, if any,
>   real-world relevance for CRC32 which is very fast on CPUs.
>
> Future work should apply a similar cleanup to crct10dif which is a
> variant of CRC16.
>
> I tested all arches in QEMU using CONFIG_CRC32_SELFTEST and the crypto
> self-tests, except for mips which I couldn't figure out how to do.
>
> This patchset has the following dependencies on recent patches:
>
> - "crypto - move crypto_simd_disabled_for_test to lib"
>   (https://lore.kernel.org/linux-crypto/20241018235343.425758-1-ebiggers@kernel.org/)
> - "crypto: x86/crc32c - jump table elimination and other cleanups"
>   (https://lore.kernel.org/linux-crypto/20241014042447.50197-1-ebiggers@kernel.org/)
> - "arm64: Speed up CRC-32 using PMULL instructions"
>   (https://lore.kernel.org/linux-crypto/20241018075347.2821102-5-ardb+git@google.com/)
> - "crypto: Enable fuzz testing for arch code"
>   (https://lore.kernel.org/linux-crypto/20241016185722.400643-4-ardb+git@google.com/)
> - "crypto: mips/crc32 - fix the CRC32C implementation"
>   (https://lore.kernel.org/linux-crypto/20241020180258.8060-1-ebiggers@kernel.org/)
>
> Everything can be retrieved from git using the command given earlier.
>
> Since this patchset touches many areas, getting it merged may be
> difficult.  One option is a pull request with the whole patchset
> directly to Linus.  Another is to have at least patches 1-2 and the
> above dependencies taken through the crypto tree in v6.13; then the arch
> patches can land separately afterwards, followed by the rest.
>
> Eric Biggers (15):
>   lib/crc32: drop leading underscores from __crc32c_le_base
>   lib/crc32: improve support for arch-specific overrides
>   arm/crc32: expose CRC32 functions through lib
>   loongarch/crc32: expose CRC32 functions through lib
>   mips/crc32: expose CRC32 functions through lib
>   powerpc/crc32: expose CRC32 functions through lib
>   s390/crc32: expose CRC32 functions through lib
>   sparc/crc32: expose CRC32 functions through lib
>   x86/crc32: update prototype for crc_pcl()
>   x86/crc32: update prototype for crc32_pclmul_le_16()
>   x86/crc32: expose CRC32 functions through lib
>   lib/crc32: make crc32c() go directly to lib
>   ext4: switch to using the crc32c library
>   jbd2: switch to using the crc32c library
>   f2fs: switch to using the crc32 library
>
...
>  89 files changed, 1002 insertions(+), 2455 deletions(-)

Very nice cleanup!

For the series:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

