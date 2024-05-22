Return-Path: <linux-arch+bounces-4485-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499538CBF1E
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59FC1F233ED
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 10:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41F823DD;
	Wed, 22 May 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm5KIxXj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0DA823BC;
	Wed, 22 May 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372982; cv=none; b=Avboe+edLPZpcLAwdPL98XnpKB8gh3XRDYAp7H3s8IbHl9rqfjTtfoPfIh23WF9uANxplZwRvZIFdFROtUZlv+ohp97M8fGlHdZ7eLkD5GrIpn293IZqgqX0eklZAZpBNLlCtRLitI39SPAtrILPBNTnZ5cw4rDfA9SH6ntSAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372982; c=relaxed/simple;
	bh=PuiENNcIxoAJNh/6feyvzTKMvSktpJ7bAqS7xzAUPRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o601Fp4cN86rK1KRasiAUZGqYZm64dLwq9lDVUItYxhdxhpoArrUiMmPvk3HxPgjtV6FTAN94R1IN3cZ+pzOUvJNoRiG9spuowKNlZ3BkL4FpmfSZTGMOzcGbwFrn/+zlMnX0yBfL2UbChaOGKy84ukr4vC+w94546BliW9Gm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm5KIxXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95213C32781;
	Wed, 22 May 2024 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716372981;
	bh=PuiENNcIxoAJNh/6feyvzTKMvSktpJ7bAqS7xzAUPRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lm5KIxXjdHC7FeqU6m1CSLL2Gv7eOvVSuPP5fau1+0X/X7J72UGZhOcmo5Np9wzrj
	 dDGDl3UZrlq27nJgutJ81+nXUyYXwg/cgGlukkI+lK5hxi+GRL2EoHsnhXsCbgSIWT
	 z5iMOrQMx0LXWOmVfy6dq+DUcRs7ExZKNl25w5pXVB718sVWbf4tJoVHXOMJKO/UkP
	 2brMh0RMr6zDpgHIkyrdn6zVD4M84531lSwGjBPi0FF4zkECJLN4do8TOrdvSM3l88
	 RmzLCnqzEa6XIxNrsxfmQJ5tYKYMks02q+NFKbtJIPA1UBk0A/K50BX8LJqf8UmRO8
	 HfqA7zH2CS4AA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fdc9af005so9255959e87.3;
        Wed, 22 May 2024 03:16:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSnZ0XyprHHsfZuQxiI9gI53mhEBje6YnTaePbseYDeEK5SM91y6Wb/VCId+kRNHr4WrUe1IiN05P9/YUhL2U2I60un6nx+1O0Ywna6tIhTaIB1Qn6bFizqVG1wJtPrva+WY1x2+AlEA==
X-Gm-Message-State: AOJu0Ywj+vGCjEvw/XOJwHbRRboRgm+31Xw1E7efiE+gD1hBCRR4br8H
	KQ90liO3Gfw/Z0Q2s/bbk+78K0MaGvxikszNPz1D/rGDGfbcN3hV2qde6Khn79Og18oDnQ7F46t
	Ay9KFFQv6F+yv4ScwqhlMeG7TPNo=
X-Google-Smtp-Source: AGHT+IEzRmY7x0F5b5z9o88qkPTe9jNI0CmLsrsI7PVvHFgbw5Ry0ao2qe4WsX9BgjRXAgujQNADKSqyiLvG+6SomMc=
X-Received: by 2002:a19:5512:0:b0:520:676a:7322 with SMTP id
 2adb3069b0e04-526c0b5db7bmr1253546e87.46.1716372980327; Wed, 22 May 2024
 03:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520124212.2351033-5-masahiroy@kernel.org> <202405211448.fglQOQ9W-lkp@intel.com>
In-Reply-To: <202405211448.fglQOQ9W-lkp@intel.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 22 May 2024 19:15:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYG_BYttk+YS_Y5AepVb_gM5T8FtEJSmhuS-y2j1gRgg@mail.gmail.com>
Message-ID: <CAK7LNAQYG_BYttk+YS_Y5AepVb_gM5T8FtEJSmhuS-y2j1gRgg@mail.gmail.com>
Subject: Re: [PATCH 4/4] kbuild: remove PROVIDE() for kallsyms symbols
To: kernel test robot <lkp@intel.com>
Cc: linux-kbuild@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:13=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Masahiro,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on masahiroy-kbuild/for-next]
> [also build test ERROR on linus/master masahiroy-kbuild/fixes next-202405=
21]
> [cannot apply to v6.9]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kb=
uild-avoid-unneeded-kallsyms-step-3/20240520-204508
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build.git for-next
> patch link:    https://lore.kernel.org/r/20240520124212.2351033-5-masahir=
oy%40kernel.org
> patch subject: [PATCH 4/4] kbuild: remove PROVIDE() for kallsyms symbols
> config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/2024=
0521/202405211448.fglQOQ9W-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240521/202405211448.fglQOQ9W-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405211448.fglQOQ9W-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):


Thanks, I will move kallsyms step 0 before btf creation.




--=20
Best Regards
Masahiro Yamada

