Return-Path: <linux-arch+bounces-11190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5CA7593C
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 11:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D204188AF69
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551219AA5D;
	Sun, 30 Mar 2025 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVwYvOID"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811D3232;
	Sun, 30 Mar 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743328519; cv=none; b=VUS9mrRF8/p0mp6+BEkKDKAqjIC9ffu0Vf+jDt6m8Ejv4UNWSpAaKDifsaCsGK5z+3Ogx6ltafkJSUAyoJ+mUgmy9TcW6aDoezQ35zzhH9vFMjhbDD0S2ODxqKjIVNJO5ZwVWOGbfSxGQzlAqZwQt/KYjhQbnhAastlXsjFyrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743328519; c=relaxed/simple;
	bh=5JcLcytBRlmqq09jrH9DsNQgRgGQPz51SsbBw3q5JSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxoyufvwoRumKlPIpTU4IjeQCwx+o2HoBcZpaL8nY88LSC3T/woOOsKMPDz8E9A5mrMatXOP4iA/uLKsKcQ63Ipc2v2fdP93gpYY6gcqaAQUNz62UfPtzMrOl0dW6jlCeq4mB0fF4+2QV7T4KTsWnlvymi8lLdKCXY4YGe2jrv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVwYvOID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7102C4CEED;
	Sun, 30 Mar 2025 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743328518;
	bh=5JcLcytBRlmqq09jrH9DsNQgRgGQPz51SsbBw3q5JSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LVwYvOIDxdCP0Z9BjL3B1PAHmQd53fCbPCe/8WOgLcx1ljiuXcCB9ADzvsgrEEe7N
	 J94UI9F1F43dVael8ZKw1WrBuL3Z8/K01PAuFyK7QiPLBN6nFeQ/4lCtBWE6PGKg+k
	 AATkpLpk7JltkfNCvra7WIZyxcrPpu0ZfnDz+0crF5lR6jU3TahgKiKt29zC974P/p
	 BLnyAJcEmlTXSgR0RsYJfH/b43X7GogMb1dfG3N44taBxdk6Pkt2UaoeKV31gy9kPC
	 bUQX4ziINEwxmfZh6H2syHazgTlPuXw7zvRmWKCwu4l5B/eufTJ22wNH9Q0ywZ3M1d
	 Zeam7t1/znD7A==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5eb5ecf3217so6579228a12.3;
        Sun, 30 Mar 2025 02:55:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU69d1Ayxz6FFh6uTEWIxsfek783QOEbjCBFrb8VtmDI7ZCdhDhCL9fHj0S6/nEg326BjmYbvcEIVVB@vger.kernel.org, AJvYcCVk/kxmCwFg8UdoJt0MyD4E4xoWMlDWF8PcnBoa9qaNXjaIxbKs9qrVSx2wo1oSJrvOXDFkDrTTJnBJMn+s@vger.kernel.org, AJvYcCWfTXWMF22e+mu073QbZ0njNa+PIs1au3Q3xqIAdqWh2VaiHqaQTD6bTXpQAzttp/BOciLcAWfcvJS+IA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH53+Mze8qeUZ1KKPlGs6qKYrrdeSFdzqLb2ExewKdxyWlWMix
	4n+entGa5TjepzNSEWPE27aJu5C/lF5Tr53bRQ0aRoNd534vOWRhGKg2u0Cf4yN/GAQDEIi5fzT
	Wh03WZncWoon1hy5JLnsbZ2z/jfg=
X-Google-Smtp-Source: AGHT+IE+jFr2hSf27y/s5sTiGjkAaHOpg05In4illWNF6eBuAiUU/eLj5n9SWJwueOHAvvfk8n3IXs3JbaDs3TMErMA=
X-Received: by 2002:a17:907:6092:b0:abf:3cb2:1c04 with SMTP id
 a640c23a62f3a-ac738a0f3b3mr442616566b.9.1743328517187; Sun, 30 Mar 2025
 02:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224112042.60282-1-xry111@xry111.site> <20250224112042.60282-4-xry111@xry111.site>
In-Reply-To: <20250224112042.60282-4-xry111@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 30 Mar 2025 17:55:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5-h3iJSDAkXz2dnW6JQRGJm03EFG2KLL_Ak1q83LMKAA@mail.gmail.com>
X-Gm-Features: AQ5f1JoPN8zLi6dXxQbDVe9ayOBCDaGT24wARYK2-Hg0w9-96JHC_84wcc-aObw
Message-ID: <CAAhV-H5-h3iJSDAkXz2dnW6JQRGJm03EFG2KLL_Ak1q83LMKAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] LoongArch: vDSO: Remove --hash-style=sysv
To: Xi Ruoyao <xry111@xry111.site>
Cc: Guo Ren <guoren@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Fangrui Song <i@maskray.me>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Mon, Feb 24, 2025 at 7:21=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> glibc added support for .gnu.hash in 2006 and .hash has been obsoleted
> far before the first LoongArch CPU was taped.  Using
> --hash-style=3Dsysv might imply unaddressed issues and confuse readers.
>
> Some architectures use an explicit --hash-style=3Dboth here, but
> DT_GNU_HASH has already been supported by Glibc and Musl and become the
> de-facto standard of the distros when the first LoongArch CPU was taped.
> So DT_HASH seems just wasting storage space for LoongArch.
>
> Just drop the option and rely on the linker default, which is likely
> "gnu" (Arch, Debian, Gentoo, LFS) on all LoongArch distros (confirmed on
> Arch, Debian, Gentoo, and LFS; AOSC now defaults to "both" but it seems
> just an oversight).
>
> Following the logic of commit 48f6430505c0
> ("arm64/vdso: Remove --hash-style=3Dsysv").
>
> Link: https://github.com/AOSC-Dev/aosc-os-abbs/pull/9796
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index fdde1bcd4e26..abaf87c58f9d 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -37,7 +37,7 @@ endif
>  # VDSO linker flags.
>  ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
>         $(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
> -       --hash-style=3Dsysv --build-id -T
> +       --build-id -T
>
>  #
>  # Shared build commands.
> --
> 2.48.1
>

