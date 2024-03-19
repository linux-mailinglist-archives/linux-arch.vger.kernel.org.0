Return-Path: <linux-arch+bounces-3031-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679487F63A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363491C21C20
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5377C08E;
	Tue, 19 Mar 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keAe1F3R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981A7C082;
	Tue, 19 Mar 2024 03:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820722; cv=none; b=egIgQUS3Qlog8vtGOESlPVooaQitU2Wg4vS/SRN2AJZN9Zvp8uUNSfglh/7vNI5Pxmn0TEldBpX0UHjZGbELlDZSPKIvGxe5tPlnixqBv9cx2z8Nqhu7gU/OfQr09CJwOvfE7NmAGf2z9n7KBu4nTo+6E3VYZAqALd52QQG3JSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820722; c=relaxed/simple;
	bh=mN37mmNJoVPK7QQbBgzp74gamlmqhD1FiCj4eiKeAF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8LiEJ2OE9XcnJmcsj2kwd/M6xbhCt0pf+eFMLgySZWSlNBDv6T4k1rqcwc/l6/Tn5fcJYdFehIsHgasnhktcd+WmSJP8Te57Xye/Ml9+G5p8OWLUJWDSmVvTQmUvV6LdS9JTgfiPypUqOkAlrDTVGxZ0t3muGaVJwxp4ohOAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keAe1F3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C8CC43399;
	Tue, 19 Mar 2024 03:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710820722;
	bh=mN37mmNJoVPK7QQbBgzp74gamlmqhD1FiCj4eiKeAF4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=keAe1F3RmmMP7Tie2NPjB+RHrEJqCcgRIqxePZoFdX+JZqG6E6EtVp1t0FF1W/3Gd
	 2X4R/WXDYSBc2QOf9COgXT09ZHWEAsSuQr78UDso0juuyjzWgHwN9mLdr4VenzNl2E
	 xLdqrdKG/B92gDxbtqLmGvqYEdUbKQs9csRJ4KGbo7ZyKL1qm4H9N9QLT0J+SwyBMJ
	 /48VU9ImizfiBbW9o6GCsOC6S0BWPKOaD9DN9tjcEkaB0RIMVPjdP0woOrdA07+Vh5
	 IGpVL3rNrQh8/UEHHzX7KNXONvCid8eps1A8QRs0UASlCMv0Y6whnMla0XYtnlesr9
	 vL5J1poDQDfCw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d094bc2244so68493201fa.1;
        Mon, 18 Mar 2024 20:58:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5+IYnkBL/n9/KUZ/HSKaG4XVKc+GF0M8yqZ2XqbPmI9HmLWX4OPaDRHpfw2fb3lPhmwiU/WTRX6DKRIdaF/iCQtc2+JZwlnSUIRdexIvHa3qRhLCET9n8GxJt+a9rombzpp1MCGaQPg==
X-Gm-Message-State: AOJu0YyjJIntTgYkfUS83lLdK+azSqzafoy8AWhWDLa6XmGN989N81LW
	5tjTujVKol3ELsLrDsVEde0qXDwxczEFsDyfAUbHC17LPd1u934o1LDlQrGsG0Dn8aj65TFwAwN
	lLFWOU/13PejT4ZQrr2xTlk2AcIw=
X-Google-Smtp-Source: AGHT+IFd2NGeNInZNlqtCpeiOvr1bD0MueLHfLC9SzxOiRd+5Xj4+sNLruulsJoDVw+pvqZy8NDOCch016Rg+/64beM=
X-Received: by 2002:a2e:9092:0:b0:2d4:8db2:f79c with SMTP id
 l18-20020a2e9092000000b002d48db2f79cmr771170ljg.50.1710820720895; Mon, 18 Mar
 2024 20:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315024435.350013-1-chenhuacai@loongson.cn>
In-Reply-To: <20240315024435.350013-1-chenhuacai@loongson.cn>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 19 Mar 2024 11:58:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjt+wcmbgZm-2WHNM+_3pMy7=BPYVy8B22M9qZZnuZWA@mail.gmail.com>
Message-ID: <CAJF2gTTjt+wcmbgZm-2WHNM+_3pMy7=BPYVy8B22M9qZZnuZWA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Select ARCH_HAS_CURRENT_STACK_POINTER in Kconfig
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
	linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:45=E2=80=AFAM Huacai Chen <chenhuacai@loongson.c=
n> wrote:
>
> LoongArch has implemented the current_stack_pointer macro, so select
> ARCH_HAS_CURRENT_STACK_POINTER in Kconfig. This will let it be used in
> non-arch places (like HARDENED_USERCOPY).
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f90949aa7cda..277d00acd581 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -15,6 +15,7 @@ config LOONGARCH
>         select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>         select ARCH_HAS_ACPI_TABLE_UPGRADE      if ACPI
>         select ARCH_HAS_CPU_FINALIZE_INIT
> +       select ARCH_HAS_CURRENT_STACK_POINTER
>         select ARCH_HAS_FORTIFY_SOURCE
>         select ARCH_HAS_KCOV
>         select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
> --
> 2.43.0
>
Yep, you forgot that.

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

