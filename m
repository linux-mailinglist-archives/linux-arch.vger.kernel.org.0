Return-Path: <linux-arch+bounces-4385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A98C49AD
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 00:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F92B22FFE
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E295584D07;
	Mon, 13 May 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eROTGHQI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498053E30;
	Mon, 13 May 2024 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715640008; cv=none; b=Nu8+mucn9dqBq37FKKfLlMQMo943Bu2xolDmow9wtZeyjpQJkTmfuuQBZYz27KIfUAGUs7IprO0bewoVUY5uBGeVfQVGRtinFheLOk62iVWPgk2+pxSXtCU/m7aK1/+mupjC+9UkVmRpaumrHb6EoZ2MVWm3AB69ykSZUcRpwtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715640008; c=relaxed/simple;
	bh=x/Nx1D89T1lHlU5B5CqZ/p8dOgkTvhf1i6pKCzFa02k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0XVc1la8nwsBJUyFnR/M6790IQsjjbjKETfAQYFWclzXQ/3tNPy9pmkqBYCHJy7kqrK3/PXrrXuxsNaIk3pZNV+W5abTfUuSLDNavBIJRcZ+FPW6O0wvBPD212LUZrapdCCEK35zg/A0m4jjBgT6AbKJCiMj50Zn+edFdH15B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eROTGHQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC92C4AF09;
	Mon, 13 May 2024 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715640008;
	bh=x/Nx1D89T1lHlU5B5CqZ/p8dOgkTvhf1i6pKCzFa02k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eROTGHQIRn/ruz3M/3Z51w7eviTp1FSvYe3lW2x9/oR/a3Z5Isxj1Z9guaGMWAp2+
	 zfDLKe9ysI4+bY/XJHjj0YK9k6wEEAa7QUh8BtQrfTvxGYFOCiCUUY+vHbDHLTQjWH
	 ASOG4RUDXnuwmBYEW0aErhsPf4zrqDIjqgK/NdceGDsCJiEuemskHrRTmb1i+U/AYB
	 WToNfHl4haQcCjwGrnF4Q2PRIH1D+80qVAbjRENSrvyRR4K+HGhAXMj3mkLoYDd4p3
	 cT+sN1+5vp9nSXPSQ1CE9SH0LaotGQr6ZIlXFVteQIwbTEfE8X8aBe+zjIdafIiGgz
	 HxQ4ChTteGBxg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so6113414e87.1;
        Mon, 13 May 2024 15:40:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6Toda41xdG9KxX9gROtvXXcQb24I/KplU/XYp1CmbejPafHqMod+VYNAX51baxpdVjMnZ3OI0qxggM/3BHPVrzUPiUaHfjJ/j/nvVSGwQSxTASZWc2JT6aFQO3+xQktN0mTG9f0B5Luvg5Xy3X7VKrurT2hgNT3YkKKgV3mJzs33oDBTRhBJpMw==
X-Gm-Message-State: AOJu0YzGsHVmFO4Xm+Noa1KwWZDZm1J5Xm1JTEMKm0dxjfnKZwlADysf
	K5MqMEBVZnIrr/7QTnBx9cJWfu06lDKbn6+R2sR1NDNEKdU9kS796d6Axm844CUl+jn6onFpVVQ
	bICKtQd9R8hEh4Ne6qBSXdc5QX6o=
X-Google-Smtp-Source: AGHT+IHbHNx5gwjCrmuc7c1K5c3QgIyJyryN7uuHy1ZDptb5sJxd7YMZEqQk+hD1Ap+n2OC5zmc0Q0L5IFdcn6mTIQY=
X-Received: by 2002:a05:6512:6c7:b0:522:2dd4:bb30 with SMTP id
 2adb3069b0e04-5222dd4bba8mr6686133e87.54.1715640007187; Mon, 13 May 2024
 15:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506133544.2861555-1-masahiroy@kernel.org> <202405131136.73E766AA8@keescook>
In-Reply-To: <202405131136.73E766AA8@keescook>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 14 May 2024 07:39:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>
Message-ID: <CAK7LNARZuqxWyxn2peMCCt0gbsRdWjri=Pd9-HvpK7bcOB-9dA@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: remove many tool coverage variables
To: Kees Cook <keescook@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Marco Elver <elver@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Peter Oberparleiter <oberpar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Johannes Berg <johannes@sipsolutions.net>, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:48=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> In the future can you CC the various maintainers of the affected
> tooling? :)


Sorry, I was too lazy to add CC for treewide changes like this.
Anyway, thanks for adding CC.




> On Mon, May 06, 2024 at 10:35:41PM +0900, Masahiro Yamada wrote:
> >
> > This patch set removes many instances of the following variables:
> >
> >   - OBJECT_FILES_NON_STANDARD
> >   - KASAN_SANITIZE
> >   - UBSAN_SANITIZE
> >   - KCSAN_SANITIZE
> >   - KMSAN_SANITIZE
> >   - GCOV_PROFILE
> >   - KCOV_INSTRUMENT
> >
> > Such tools are intended only for kernel space objects, most of which
> > are listed in obj-y, lib-y, or obj-m.
>
> This is a reasonable assertion, and the changes really simplify things
> now and into the future. Thanks for finding such a clean solution! I
> note that it also immediately fixes the issue noticed and fixed here:
> https://lore.kernel.org/all/20240513122754.1282833-1-roberto.sassu@huawei=
cloud.com/
>
> > The best guess is, objects in $(obj-y), $(lib-y), $(obj-m) can opt in
> > such tools. Otherwise, not.
> >
> > This works in most places.
>
> I am worried about the use of "guess" and "most", though. :) Before, we
> had some clear opt-out situations, and now it's more of a side-effect. I
> think this is okay, but I'd really like to know more about your testing.


- defconfig for arc, hexagon, loongarch, microblaze, sh, xtensa
- allmodconfig for the other architectures


(IIRC, allmodconfig failed for the first case, for reasons unrelated
to this patch set, so I used defconfig instead.
I do not remember what errors I observed)


I checked the diff of .*.cmd files.





>
> It seems like you did build testing comparing build flags, since you
> call out some of the explicit changes in patch 2, quoting:
>
> >  - include arch/mips/vdso/vdso-image.o into UBSAN, GCOV, KCOV
> >  - include arch/sparc/vdso/vdso-image-*.o into UBSAN
> >  - include arch/sparc/vdso/vma.o into UBSAN
> >  - include arch/x86/entry/vdso/extable.o into KASAN, KCSAN, UBSAN, GCOV=
, KCOV
> >  - include arch/x86/entry/vdso/vdso-image-*.o into KASAN, KCSAN, UBSAN,=
 GCOV, KCOV
> >  - include arch/x86/entry/vdso/vdso32-setup.o into KASAN, KCSAN, UBSAN,=
 GCOV, KCOV
> >  - include arch/x86/entry/vdso/vma.o into GCOV, KCOV
> >  - include arch/x86/um/vdso/vma.o into KASAN, GCOV, KCOV
>
> I would agree that these cases are all likely desirable.
>
> Did you find any cases where you found that instrumentation was _removed_
> where not expected?




See the commit log of 1/3.


> Note:
>
> The coverage for some objects will be changed:
>
>   - exclude .vmlinux.export.o from UBSAN, KCOV
>   - exclude arch/csky/kernel/vdso/vgettimeofday.o from UBSAN
>   - exclude arch/parisc/kernel/vdso32/vdso32.so from UBSAN
>   - exclude arch/parisc/kernel/vdso64/vdso64.so from UBSAN
>   - exclude arch/x86/um/vdso/um_vdso.o from UBSAN
>   - exclude drivers/misc/lkdtm/rodata.o from UBSAN, KCOV
>   - exclude init/version-timestamp.o from UBSAN, KCOV
>   - exclude lib/test_fortify/*.o from all santizers and profilers
>
> I believe these are positive effects.




--=20
Best Regards
Masahiro Yamada

