Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8975C29A89B
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896674AbgJ0KAf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 06:00:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38781 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896655AbgJ0J7q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 05:59:46 -0400
Received: by mail-il1-f193.google.com with SMTP id p16so945699ilq.5
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2020 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=usfplqa+qJQAziOe1mo6w6IfKhsrwJJj00MeXYg7IhA=;
        b=SvptCW0h3KqyWUTvUvXBMtFiEBk6j6OpalEJoZylz2xyXcj5kZmUTFVVLFJfSHJjDF
         JbIfNqzq2EujC9158/ZYxRmo0aG+Hndm39nz68uAAFn1yEkXBo0G925CUp/NSSUacDN2
         utMN1gWJDQwzy99ypoFeRr1l+QpnSLJFzdynRaayIHPcUToy0m6vmIh7sCyF1sBMoTn2
         ud5J5CJmUMsvm0RgumUbXEdTg+qxD0XJwVkksBJhLJDQkhpuEt69/+ofHZs4bx5Tro2I
         WJvD4AGKeU6cpdTCE7uNyN134l6aFL3Ok63AoohakPmseNRCvzqZrSPme5zi2IlGFkqT
         B2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=usfplqa+qJQAziOe1mo6w6IfKhsrwJJj00MeXYg7IhA=;
        b=r1XR6+HVZ9ClIRbn60YMxRlw+5lM1J4TBQcwWkS7/7b6RvZv8DUCAZDu4gifsdMG6u
         P7Kn+UZMvHPxwpzJ7ArANDr2KR+yIGHnKJxdyEfuzpY/PccBbR1pZDWswudWKZ4RF/eo
         hlWOmk5SsF0+Tq5y6CqxE//IzW1nyoD6srXjJ6rdNqNSRJ8YEgLWcJ9qaNWZ8VRelc1D
         Gax8hA/kgnrmTofwHXkIQ+7tbafMtidFmKOn4BjXFBtnZ/bqu7lxlGxA6cSCfn4vg5hX
         mcYtEslhlngMdgT//KlNBeU09sqcDHR4wpEyBHtPsEoeqQ6BcSN0IrIXBsI884zM8w8/
         Kujg==
X-Gm-Message-State: AOAM532cDRsvf8YLAArNbKn+3HEDWujwmREH0xDENeL8Ta09l4/aV3Er
        blmSy7w6Pb33IjHjbwRYo4E18vhU+wN4uPiWMjwECA==
X-Google-Smtp-Source: ABdhPJx0OWukHLrAYRuR0iUMopMDG1i2ka1ksbrqEfNxUTFAw6vjeqAtMwNdohBWK2MqZk+rPW64KGdBzSPJIPTEH+U=
X-Received: by 2002:a92:d20e:: with SMTP id y14mr418095ily.252.1603792785654;
 Tue, 27 Oct 2020 02:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-6-npiggin@gmail.com>
 <20200826152510.GB24545@gaia> <1598458759.6wa1mql9py.astroid@bobo.none>
In-Reply-To: <1598458759.6wa1mql9py.astroid@bobo.none>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 27 Oct 2020 15:29:34 +0530
Message-ID: <CA+G9fYvejffDjf5JVymq1mfbyCUOKTqbCPE0fSM8_5CXaXCm8A@mail.gmail.com>
Subject: Re: [PATCH v2 05/23] arm64: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 26 Aug 2020 at 21:50, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Excerpts from Catalin Marinas's message of August 27, 2020 1:25 am:
> > On Thu, Aug 27, 2020 at 12:52:31AM +1000, Nicholas Piggin wrote:
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
>
> Thank you, I see I stupidly mis-rebased this patch too :( Sorry
> I'll fix that.

arm64 build error caused due to this patch on linux next 20201027 tag.

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild defconfig
#
#
#
set -e
cd /linux
export ARCH=3Darm64
export HOSTCC=3Dgcc
export CC=3Dgcc
export CROSS_COMPILE=3Daarch64-linux-gnu-
scripts/kconfig/merge_config.sh -O build 'build/.config' 'build/frag.config=
'
#
#
# make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image
#
In file included from ../arch/arm64/include/asm/mmu_context.h:257,
                 from ../arch/arm64/include/asm/efi.h:10,
                 from ../arch/arm64/xen/../../arm/xen/enlighten.c:19:
../include/asm-generic/mmu_context.h:34:19: error: redefinition of
=E2=80=98init_new_context=E2=80=99
   34 | static inline int init_new_context(struct task_struct *tsk,
      |                   ^~~~~~~~~~~~~~~~
In file included from ../arch/arm64/include/asm/efi.h:10,
                 from ../arch/arm64/xen/../../arm/xen/enlighten.c:19:
../arch/arm64/include/asm/mmu_context.h:180:1: note: previous
definition of =E2=80=98init_new_context=E2=80=99 was here
  180 | init_new_context(struct task_struct *tsk, struct mm_struct *mm)
      | ^~~~~~~~~~~~~~~~
make[3]: *** [../scripts/Makefile.build:283:
arch/arm64/xen/../../arm/xen/enlighten.o] Error 1
In file included from ../arch/arm64/include/asm/mmu_context.h:257,
                 from ../include/linux/mmu_context.h:5,
                 from ../kernel/sched/sched.h:54,
                 from ../kernel/sched/core.c:13:
../include/asm-generic/mmu_context.h:34:19: error: redefinition of
=E2=80=98init_new_context=E2=80=99
   34 | static inline int init_new_context(struct task_struct *tsk,
      |                   ^~~~~~~~~~~~~~~~
In file included from ../include/linux/mmu_context.h:5,
                 from ../kernel/sched/sched.h:54,
                 from ../kernel/sched/core.c:13:
../arch/arm64/include/asm/mmu_context.h:180:1: note: previous
definition of =E2=80=98init_new_context=E2=80=99 was here
  180 | init_new_context(struct task_struct *tsk, struct mm_struct *mm)
      | ^~~~~~~~~~~~~~~~
make[3]: *** [../scripts/Makefile.build:283: kernel/sched/core.o] Error 1


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

full build log link,
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/813497297


--=20
Linaro LKFT
https://lkft.linaro.org
