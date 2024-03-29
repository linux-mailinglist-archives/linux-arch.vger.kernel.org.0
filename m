Return-Path: <linux-arch+bounces-3335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC9892347
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 19:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D107A1F23180
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F6130E3B;
	Fri, 29 Mar 2024 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJxG6mya"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3E1DA4C;
	Fri, 29 Mar 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736674; cv=none; b=FHwXcSIoqOWT/jA4+3M7W0prkk273mJI1XOBicapBRVBdzE2kAiWoB16hGgMzWlaxJwNUjRsvr9Qr/RLtzjzyxbT6nvo3UwmzpI/whB0fxInjjfja3ajxb+MuhBU2diTyfaCu5WL/hDNL2ft6I5L0EUT6srxxL9MVKVmyF+59/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736674; c=relaxed/simple;
	bh=Vuh15MQ64+WP/qmGDOm7OXDGS1/VqD57AMvXjy6gqFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWboHDYutd8rU2Dk/NdvC4Oif0gCxrTMLdEz+xaT3iNooZOxEYPzngwirSC+dru6ECsOWQjodmLg8jmjKDbrDyO4s9JdUQIgQef17LMQ1nF+ajk/no5RTeIa/91I3xQpKid5imxWddA18pDC4DsKFdOflSrySNCxXWV/1VsKjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJxG6mya; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so2283780a12.1;
        Fri, 29 Mar 2024 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711736670; x=1712341470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTcT6FpmZPDdNNZs+4hv9a25uOfPmQTokoJd2Ybvc8w=;
        b=aJxG6myatJabBXke68OBs551dl8SxYWJABiCN8VqpNGapPd9TKtDIobWzcf7NCxi9W
         aZAKmnlbaXlQ4iaJLJrTpD/RGrzGYti6a4y5mMoJAbbkQXuSQG0q/LaRuXJRU1afJRsG
         30ZgDmguBIXHp/ELpNTIJrZN2m51G6nrdsTM+nQjuCUrfByH3gnxUPb4ZB0MfbjoSSLT
         +nKxmgyBrs2jJyL2XmD1LSigKVdDKicgdDJlgc0ey2Ip6a/hHvOsl33ZpTPfKJqfUQws
         cMVouFv0Ae2qII5W/9giPPx0MYDmXCsazSMVFbMjKcrfeXLbNlnI4sJsZ5SGCQ/amehk
         EZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736670; x=1712341470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTcT6FpmZPDdNNZs+4hv9a25uOfPmQTokoJd2Ybvc8w=;
        b=dip9HWllPg0kK4FYxwJPZeVdS/6vBkxb75H4qsKSvrh2B0knUVJsxSR1T6G20lKQnH
         FyLqi5LW1QcVaImH0ESBrJ3QrQV+hfP0H32bslBX2L+IIEl6cd8DfEcKf9wzR7dML/cI
         KdMUexiaKczwb+UbjPUZYBh+jRUWmTgja1s+/stieMUS11uGqO3v2/6ygyfPgGRFRn8k
         WRPq8I/sFaeYt4BRYaDnqv3FavCX4bSR5X+I9hrHgRbBhz9WT1oGKHvWq5/hfskq+422
         U7QI8uyZvJsn8Vm1iGVwzCTx071fo4JOwZ21CjQUlx4UhUK/BgaGKNXtmMCcTy4aFF0P
         Pp0A==
X-Forwarded-Encrypted: i=1; AJvYcCV8Vg1/ZeLEsqdvnLtf6zbWdRk6C35Zq9lykG6KvQvcUhAVDwXyY48+S2GdLRHxbsyreUGUZhpLfybKiETFA0Ll4YkVjv+y0yEvJMbmul0U/RJbwMN9FsFVVyZi/dIVSXGiCTOZHJx6M7eUcjiYSrLoPrGFq0IBU4BOkETrvg==
X-Gm-Message-State: AOJu0YwDDAJV2i3tqgL27p5B3OUeA3Q+usdmgp6SgVYZaykYJe24Augb
	Ck3tlTE1cXx8Zo3vrzOMtPIDv02u2hwbIvdTuBkqj9925Y4Q2qCvQ8pUgM2wqSS+wCZvbXqMklY
	a3dxRG36pWzqobJipEXbU8fZBsCs=
X-Google-Smtp-Source: AGHT+IFsDflBbt8eyH8AA5Ww8LHUaL9BgK2B3vWkAUWBTMPDlWZRocD2cQm01IS8ipOY7tuShkuhGvMJvLn3CtHeZF0=
X-Received: by 2002:a17:90a:b78b:b0:29f:76d4:306a with SMTP id
 m11-20020a17090ab78b00b0029f76d4306amr3867934pjr.24.1711736670529; Fri, 29
 Mar 2024 11:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329093356.276289-5-ardb+git@google.com> <20240329093356.276289-8-ardb+git@google.com>
In-Reply-To: <20240329093356.276289-8-ardb+git@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 11:24:18 -0700
Message-ID: <CAEf4BzYyTjb9MKAD8nP52+9Nx=eNyWxAwfWDBEO881+YuH_XTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf: Avoid weak external references
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:35=E2=80=AFAM Ard Biesheuvel <ardb+git@google.com=
> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> If the BTF code is enabled in the build configuration, the start/stop
> BTF markers are guaranteed to exist in the final link but not during the
> first linker pass.
>
> Avoid GOT based relocations to these markers in the final executable by
> providing preliminary definitions that will be used by the first linker
> pass, and superseded by the actual definitions in the subsequent ones.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 ++
>  kernel/bpf/btf.c                  | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index e8449be62058..141bddb511ee 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -456,6 +456,8 @@
>   * independent code.
>   */
>  #define PRELIMINARY_SYMBOL_DEFINITIONS                                 \
> +       PROVIDE(__start_BTF =3D .);                                      =
 \
> +       PROVIDE(__stop_BTF =3D .);                                       =
 \

should this be guarded by CONFIG_DEBUG_INFO_BTF condition?

>         PROVIDE(kallsyms_addresses =3D .);                               =
 \
>         PROVIDE(kallsyms_offsets =3D .);                                 =
 \
>         PROVIDE(kallsyms_names =3D .);                                   =
 \
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 90c4a32d89ff..46a56bf067a8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5642,8 +5642,8 @@ static struct btf *btf_parse(const union bpf_attr *=
attr, bpfptr_t uattr, u32 uat
>         return ERR_PTR(err);
>  }
>
> -extern char __weak __start_BTF[];
> -extern char __weak __stop_BTF[];
> +extern char __start_BTF[];
> +extern char __stop_BTF[];

kernel/bpf/sysfs_btf.c also defines __weak externs for these symbols,
you probably need to adjust that as well?

Other than that looks good to me:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  extern struct btf *btf_vmlinux;
>
>  #define BPF_MAP_TYPE(_id, _ops)
> --
> 2.44.0.478.gd926399ef9-goog
>
>

