Return-Path: <linux-arch+bounces-7218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E5975C2D
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D7A282186
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D276145B00;
	Wed, 11 Sep 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0WO7YUi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821EC5337F;
	Wed, 11 Sep 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088867; cv=none; b=BirXDFMxIg5phxos4qu1tPy3ctlMZU90Y0bhrmtmUp8y0igzpvJsPuW7AYoOedYf3hPl3DzwCYKUwYFAWpP3DMJ4okO0aOEQQ0KYC1h4OjNw/IS2RQpMhMW0F6LdYlgDzZaVbEbMN3IO3N6oUoI6GJwiv41FSlA4qv64UPi4hQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088867; c=relaxed/simple;
	bh=bVbGtxGuWI4Z1fkzT2AsweByfrIJXRgaPe01VRr9Jzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6jIn4KqcSv8cy4AyYDle0khhl3kk238CuieTDbkIq9CBvpUGGcImoHZG5QK+PfnCygvSRUR2i+RgMoWGbkYE05XOQAVbaYhdwQ5+xTkJZ3lbs6VK1BNc1jZICctT0+xW0LpbNxWWb/HtRh33tR/PJKLb4usoPcnf95q/8n33hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0WO7YUi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20570b42f24so3492375ad.1;
        Wed, 11 Sep 2024 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726088866; x=1726693666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmSVp3V+cDwfdxKteKgPEolOk0B0IUNuuO5wfRUxw0g=;
        b=g0WO7YUisD59cPlsdFFXZVTEOZraLPPmw57cJ25Q7/exul96nGqkVzBzemqkureP9Z
         qVtGgYjG+Elgh6UseGf6dSIi+NbBhZGuEyt6ji1o04B54i1+zk2B/bMM++4QSSlQVEtP
         BrGj8JOb7B5Zn2jomQU890wTY+/Ikc6VqrXapoxfKa9UcIovxdvDfDiJRNJfpEjE93lc
         y9u2Gz9cDoMx/it8i09fajPN9LrQUQEh8+7Em++ItnQixZ1sjoxFD6oCxesUFXElwVFU
         Jf3cXxWo+gU4NKqsEn5uelgQzNhm9WbyiQiGq5RNqIdz/nHk1S+nWZMHZ0kYLk9VHzSh
         zp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088866; x=1726693666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmSVp3V+cDwfdxKteKgPEolOk0B0IUNuuO5wfRUxw0g=;
        b=lf6v3LnG4UquK+j4ZyXNJtz4xkO/AxPNZZkDEnZGQopvc7SpwHstiRviiHUSvi9Ba3
         vq7ExGv4mrA2F4htqUfPI14Glgvo1Ur7vDuhHRGaXvBMJBmxDIRKerFtVoTFiGAv4rPZ
         3bUG2ZpW936XC/KKjvSlmVMtY7eTRVKNs4XZZ1vUECQSKY4DjVxhC3bE9pF2ZXTG/3ca
         jJAhlgRbUjF6tRoGM8pLm63rCnErcy/M3mBlya66F8dh5LF1WiVpwh258a2ScsKK9MGu
         q2fu8v+Ii6qd4wAiNN9gOgJiObNhuMnotYgd8VR6DhCeU1uHPROiqekSndhnPvIWxUgZ
         O8MA==
X-Forwarded-Encrypted: i=1; AJvYcCVt3QDFvluSJrhoXy35Hz6Kw5DxW0ylOqPk5jYNmY2AS+9T7MfPLo3DQXpLPTWRWQiwhkcYdSLAU3YRknMw@vger.kernel.org, AJvYcCWX1dFe2kUHAKDwu8f+79UDIGaDXBzhXXn0qD17sgV3KQHPcJPtfyEr3F1NiFziJwwRBb7Q/V8wlbBZtYa9@vger.kernel.org, AJvYcCWdIRhJSFknCepXvAPSuxQrn+t5HQSN/vPPig+88B9RD65JJz/TCptFUmCta9dZPg0Gj69zuNHF6kMVlw==@vger.kernel.org, AJvYcCWzijSpZgUCSMD9DYhYT+L0VuzbT3TUca8ysuxYQRJbnxgjlggBQS+LnVnmOZy6ZQ/mWD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQj8a+9piMLtjpyvPHjoXaEFe31zGxNLCVjel4FIxQykCbSlb
	A/IJDxVlntZLfsLgwNUQOTHnwQ4zbp0o52TswCxBc4gamca0KfSS1eOmYwqg3q07CDM6WOa/iof
	e7NK0QicnaobOs6wUeg5+m1eUpDs6Aysr
X-Google-Smtp-Source: AGHT+IE9dQgSG0i6FgqWJll/BTQUgaH6pcRhMEwm6Bbm7RzobzCVqpXqphOC1MwbfwUA0ZKOXBO5Dc1esgP+gqi9GIk=
X-Received: by 2002:a17:90a:d791:b0:2cb:5112:740 with SMTP id
 98e67ed59e1d1-2dba0062abemr513816a91.26.1726088865608; Wed, 11 Sep 2024
 14:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911110401.598586-1-masahiroy@kernel.org> <20240911110401.598586-2-masahiroy@kernel.org>
In-Reply-To: <20240911110401.598586-2-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:07:33 -0700
Message-ID: <CAEf4BzaMAj06RSAyVeaK-fWMEFJjEf6XDXZGzkk7K3k+n1q-nQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] btf: move pahole check in scripts/link-vmlinux.sh to lib/Kconfig.debug
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:04=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
> DEBUG_INFO_BTF.
>
> When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selected,
> DEBUG_INFO_BTF can be enabled without pahole installed, but a build error
> will occur in scripts/link-vmlinux.sh:
>
>     LD      .tmp_vmlinux1
>   BTF: .tmp_vmlinux1: pahole (pahole) is not available
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
>
> We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
> discussed [1].
>
> However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
> added CONFIG_PAHOLE_VERSION at all. Now several CONFIG options, as
> well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
> guarded by PAHOLE_VERSION.
>
> The remaining compile-time check in scripts/link-vmlinux.sh now appears
> to be an awkward inconsistency.
>
> This commit adopts Nathan's original work.
>
> [1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancellor@=
gmail.com/
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  lib/Kconfig.debug       |  3 ++-
>  scripts/link-vmlinux.sh | 12 ------------
>  2 files changed, 2 insertions(+), 13 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5e2f30921cb2..eff408a88dfd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -379,12 +379,13 @@ config DEBUG_INFO_BTF
>         depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>         depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>         depends on BPF_SYSCALL
> +       depends on PAHOLE_VERSION >=3D 116
>         depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >=3D 121
>         # pahole uses elfutils, which does not have support for Hexagon r=
elocations
>         depends on !HEXAGON
>         help
>           Generate deduplicated BTF type information from DWARF debug inf=
o.
> -         Turning this on expects presence of pahole tool, which will con=
vert
> +         Turning this on requires presence of pahole tool, which will co=
nvert
>           DWARF type info into equivalent deduplicated BTF type info.
>
>  config PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index cfffc41e20ed..53bd4b727e21 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -111,20 +111,8 @@ vmlinux_link()
>  # ${1} - vmlinux image
>  gen_btf()
>  {
> -       local pahole_ver
>         local btf_data=3D${1}.btf.o
>
> -       if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -               echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> -               return 1
> -       fi
> -
> -       pahole_ver=3D$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+=
)/\1\2/')
> -       if [ "${pahole_ver}" -lt "116" ]; then
> -               echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version=
) is too old, need at least v1.16"
> -               return 1
> -       fi
> -
>         info BTF "${btf_data}"
>         LLVM_OBJCOPY=3D"${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>
> --
> 2.43.0
>

