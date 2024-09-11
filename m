Return-Path: <linux-arch+bounces-7219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16626975C31
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D0F2857E9
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438EF14A093;
	Wed, 11 Sep 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdM5hPYj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7F143887;
	Wed, 11 Sep 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088899; cv=none; b=bFjIV2rk+vCMidTI8nsjLKuOW4f2T3C+4Iely52l+MNn3jvvQRoJe9lncAu4hPST/HME+KR+zJhLCpY/KHiA7OiUUt9c0pIYWtAEa7a3cciLIE0JRmvxd7xg8WltYggBAAQ+oBO5XtSkENmbhsnxzqiTkHEbA+V4wfbtyzRn/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088899; c=relaxed/simple;
	bh=8YzKnIPK6QOgVCe6EcsGGisdrK4u2VhErOce/JaY5Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWK7btQ77a61KzK/lv/R0aMQyNmujus5a/VvU7FvlEPCEDuRX5pGyYgXWmsLAFIrwtmCAVB66QeM8Kc628kUpRFqZjdV+XP/gGDRNHGC6/LfXwaBBwCLbcAKrVbPsx2CxEbyC9A2Rr8Ln+8lH/AxqxJ+bLsvl25qWf/WiaOf55Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdM5hPYj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8f06c2459so183850a91.0;
        Wed, 11 Sep 2024 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726088897; x=1726693697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGFR71RW6ZEzotKUOgWaG2Cc/4HnhyZYAtkaXk64Pbs=;
        b=cdM5hPYjiw0bOZN3NE0wlG/6YXcRW0mHu2T5LYYUb/KkE0SZ7mMZ+t07+q1/cLe7G0
         9mO//MCvFp9UoF4Unb4w5fPGSIqtbUFE2ONqQxdZ0rWD2AwlQPgYzJJEpTsmsC1enHNY
         NoghAjRBsMUv5ebXloJdySjpNui9p8Cx7Qm3ELucJKDMJd+fdwAbPdOP/8tJVkBSqfr8
         Bxk79L9w66BJYMD9O0dBoqM4gnlO2Y+x6y/SeRvWn1dtZ04AreBzBbZoYQ0FK1qGUdhX
         IQEJ5dvDtBgVRUOyiT2fLTZsoecF8Kk2gklHS6elHOwQ8ytSkx0FbmFydZqnGWUl1xJd
         PpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726088897; x=1726693697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGFR71RW6ZEzotKUOgWaG2Cc/4HnhyZYAtkaXk64Pbs=;
        b=EDUA0awfukYFNxoQLHAk4MDtPjJHdeIBR49o/DPl4Dc1ABC/2wJr3AoPmUn1hXV04B
         PCkeemseX/9Thh9vsXQbLqot8PDxD0NDU2MuPSDpbz4Z33S+UpkJRdL6bdJfz7YXXqFV
         IsngKskyRWoUGMKw6bqXpEjTaOuf4VWWQROE7CjiLS2kT2RCePvMZ60bJKBETNqdCJlR
         Jrz9B6OXcAZ1ptpedlwoGwR9KjxLx3CsVD3bP8XZjJ7H2jI1xIAKSOZEAAD9i9aaq7Uz
         Semjp8PrFZHY74LuItraJaDxotTHSu3THP/4GHQXh8fLrgRNkdFUyBLw7rtx6gJvwDjd
         6eAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQPPt1RyOuI0G9mTaVzx/xrIYo827uc1Z4HfOd9CFmBzSPtYtBP1wigRIWpREaxH8/8dabmMipDgV/Sg==@vger.kernel.org, AJvYcCVng26vSDkTNkYExHY8WNQ3Jph8IMHRAcrHU2VY3mp8Ier9LOcbT8ztOKowkBbYHUrdC+U=@vger.kernel.org, AJvYcCX0/rB2sagnXDqX47eIoXo+wgPfG1VKa0F9UwWk5Z93zHwjbEOs8kRQaW9hApXcIW3cOZEoF2R31SuEhX9c@vger.kernel.org
X-Gm-Message-State: AOJu0YwCn2yE+KkmoehT7oTV0l9u41Zvw2sydBLG4O8m9P6BxSA5osRI
	6nkBPH232FKwgLcEfxTYzG4GRmtssHZTia/GHOIGXuJ/bb7eAhf5jglWN/0JSpPlgSsdgGBYnDs
	lTBRkLX6x368CM/iM6T+eZ0XAngU=
X-Google-Smtp-Source: AGHT+IHnqafspbH4Q8lQh3k2OjnAE3WY2+DXLqTUo1EWoBZIL6eo11ZY1l+fgdQLm8Hal5U0+TBaV3HszitSTOCPLN0=
X-Received: by 2002:a17:90b:4c41:b0:2d8:e5a3:f6a5 with SMTP id
 98e67ed59e1d1-2db9ffbf9ffmr577756a91.13.1726088896956; Wed, 11 Sep 2024
 14:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911110401.598586-1-masahiroy@kernel.org> <20240911110401.598586-3-masahiroy@kernel.org>
In-Reply-To: <20240911110401.598586-3-masahiroy@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Sep 2024 14:08:04 -0700
Message-ID: <CAEf4BzZ6kT6saDPO52P9p_MAR2XXRrrDX5r7xqDoLy3+y9rquQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf: require pahole 1.21+ for DEBUG_INFO_BTF with
 default DWARF version
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, linux-arch@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:04=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> As described in commit 42d9b379e3e1 ("lib/Kconfig.debug: Allow BTF +
> DWARF5 with pahole 1.21+"), the combination of CONFIG_DEBUG_INFO_BTF
> and CONFIG_DEBUG_INFO_DWARF5 requires pahole 1.21+.
>
> GCC 11+ and Clang 14+ default to DWARF 5 when the -g flag is passed.
> For the same reason, the combination of CONFIG_DEBUG_INFO_BTF and
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is also likely to require
> pahole 1.21+. (At least, it is uncertain whether the requirement is
> pahole 1.16+ or 1.21+.)
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>

Make sense

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index eff408a88dfd..011a7abc68a8 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -380,7 +380,7 @@ config DEBUG_INFO_BTF
>         depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>         depends on BPF_SYSCALL
>         depends on PAHOLE_VERSION >=3D 116
> -       depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >=3D 121
> +       depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >=3D 121
>         # pahole uses elfutils, which does not have support for Hexagon r=
elocations
>         depends on !HEXAGON
>         help
> --
> 2.43.0
>

