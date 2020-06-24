Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1037207DF9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbgFXU7N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbgFXU7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:59:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7759C061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so1598393pld.13
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWM/30Wl1IsQgoPaDiN0rPEEBtrHBKt/BJnnp0eLWds=;
        b=pd1+e0uXRIvGNNQgZ7G0+2YkwsDFhSclmocO1GbaT5UM3c6xBTX7UYJjCsai0aiyT7
         fIoijSJoU+eUl8voyiO0IOyBsavQt6eREqkk3whDlDlHejxDQRKECAFiVGUe/CKDHaTc
         EpZ2md8ULTkAVVBJ6O72PRwIcg/GiVClV1rha8JNSiYzT4/v2ecYsi++FLxwW19Hw/Gd
         Fr/Z+ikfp69sRAivcJnbajJT1/5/Qn2W6vWHskjofe5p2ZJr6Cthm+UKTVG2rZslsDkG
         xO7mHbrOSScz4BsI8HgHuMYhqH42CQPx5Ip80xrwiQdph3TwAg+m578XBSL3rfWRIGQZ
         ATEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWM/30Wl1IsQgoPaDiN0rPEEBtrHBKt/BJnnp0eLWds=;
        b=jg3S9mMxPWrEaR7S7BxBFc5U8fUbHHQmAR37UDV9VQvjx9vxRjZMTtnPau0AgIlwnm
         Vdo3lamzrroz44VMdIjlJrqYzwVTir6k7hE86bTV+xRdfbdFsebo7VW5EofjtpwL+vjt
         Xt+W1JWoDJ7/zRrPun+p/WfrTJ8SxG2Ey6v8J+trnvgZ+vQad5QHDPW2RiCID3A+bV32
         5UBjGV0zac5gjk/dUuxH6tzXSgw1fc09Z5Zr9Uo1qeH5ltwCvuSrVoG5DcC5Va4oE61X
         Gox+6u2uiFWiBCpt3E3WfZFWpRrtX+MXYNCxdcOd8S3c8+2sdlT5p6vdFyp9E05CLwwD
         P46w==
X-Gm-Message-State: AOAM533hglVE1sZVYfO/nqqxTtXzdDl0Jk6YUuvrab+PP36VaSOtq61F
        YRkGiRfbbR8YBTL8iDf18xNuQ9BjldEP2xHwohLshQ==
X-Google-Smtp-Source: ABdhPJxCHHL5VXpLPing5E72KwPslmx5t7evOEk09T9ji09mKT6bSRCDPTi/AxhdrzEhszh9gGm6vbYGZSEoMtti7/U=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr5252324pjc.101.1593032350091;
 Wed, 24 Jun 2020 13:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-18-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-18-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 13:58:57 -0700
Message-ID: <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Filter out CC_FLAGS_LTO for the vDSO.

Just curious about this patch (and the following one for x86's vdso),
do you happen to recall specifically what the issues with the vdso's
are?

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 556d424c6f52..cfad4c296ca1 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
>  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
> -KBUILD_CFLAGS                  += $(DISABLE_LTO)
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> +                               $(CC_FLAGS_LTO)
>  KASAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
>  OBJECT_FILES_NON_STANDARD      := y
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
