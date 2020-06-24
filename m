Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C45207E09
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgFXVCN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388706AbgFXVCM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:02:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5BC0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:02:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so1784862pfn.7
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0CH5zhnz6ayOh3mQsnUEqy/k37rjt1CS3Xrl+QPqsk=;
        b=ERVcY1k3sSjCpLOAr8awDULH6hHwCvyEkuApK5Qd/yy5SDCViDdkIB8JSQ5L/xRD+d
         8Y592Pat2k/ChLh9OYujlbJnjlGNVLx/ZpfbEt1sE8kMlvWJzHlDhj0x+JLWI/sCQ71m
         Qc98XVDBN4Tj5eQLSTeQur2SwoHWInWoHJEhUCCE5GXRfarr8qGepXCtm5phPzsnQ/fx
         r0chNzaABXZLlufMpQ+880lEY1eRlM2cvfZqGUG3SBnyMqYm4bUW8z+wyLj5pHtSzavu
         pLpwIlYwlO/U6gNgApMNdpJIBGZ6tRJTmGgBOtagYfhNoPIS0UxFZGw9u/o29RNxq2va
         8lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0CH5zhnz6ayOh3mQsnUEqy/k37rjt1CS3Xrl+QPqsk=;
        b=WcSDO8Fa5uEGQFABFv84ysaWpS5lEaNUmp2YqKGr5om0D/Vp4pXOmtBHFblaamV/58
         4J5PXQjB/uSCi0mNlZGKCYKy9TqVChyPk36R6bBmS/dDu2wtkwWH5jDpjoTfnEXUQGXL
         lbidYaYY+tpAk8v7yV6Gx5P19nsflqu5SYSHVMdrnwY9UxK9h2CrYYrmYn8Tz75l+Tmb
         kbk/i7qQhpAmrjl2Gi80jhSy194oxE/vYd2Hes4PLIS6SpyElWTCPB3C3vqEC3k4S+nc
         rOu842zuPi60YV67iG0Yxhf+J+wWwdHW9Hnsws5uD0SAy56KbvT6AejQPWssqTMDOajX
         zTPQ==
X-Gm-Message-State: AOAM5316pZOb8Kgi719cao6BNR/NDhwNf76KRAhG7ZHm9Rnrf8Z37npo
        0pe2S66sCUAeSpnXVWQCqromHuDfc3Lx0jvDe12g4A==
X-Google-Smtp-Source: ABdhPJy3pMPiQAGPmTVujSMRX6922OqjtLRlYCZUOTerucVNVRzOs/5XjS34LxJ/ndw7kmB1zYWqmSiQ8V38zGtrKuE=
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr31723451pfu.169.1593032530992;
 Wed, 24 Jun 2020 14:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-8-samitolvanen@google.com>
In-Reply-To: <20200624203200.78870-8-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 14:01:59 -0700
Message-ID: <CAKwvOdkY2M9+BgA5FELK+7bjv1sZYMuTmVOztCYijas_OHfVDQ@mail.gmail.com>
Subject: Re: [PATCH 07/22] kbuild: lto: merge module sections
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
> LLD always splits sections with LTO, which increases module sizes. This
> change adds a linker script that merges the split sections in the final
> module and discards the .eh_frame section that LLD may generate.

For discarding .eh_frame, Kees is currently fighting with a series
that I would really like to see land that enables warnings on orphan
section placement.  I don't see any new flags to inhibit .eh_frame
generation, or discard it in the linker script, so I'd expect it to be
treated as an orphan section and kept.  Was that missed, or should
that be removed from the commit message?

>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile               |  2 ++
>  scripts/module-lto.lds | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>  create mode 100644 scripts/module-lto.lds
>
> diff --git a/Makefile b/Makefile
> index ee66513a5b66..9ffec5fe1737 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -898,6 +898,8 @@ CC_FLAGS_LTO_CLANG += -fvisibility=default
>  # Limit inlining across translation units to reduce binary size
>  LD_FLAGS_LTO_CLANG := -mllvm -import-instr-limit=5
>  KBUILD_LDFLAGS += $(LD_FLAGS_LTO_CLANG)
> +
> +KBUILD_LDS_MODULE += $(srctree)/scripts/module-lto.lds
>  endif
>
>  ifdef CONFIG_LTO
> diff --git a/scripts/module-lto.lds b/scripts/module-lto.lds
> new file mode 100644
> index 000000000000..65884c652bf2
> --- /dev/null
> +++ b/scripts/module-lto.lds
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
> + * -ffunction-sections, which increases the size of the final module.
> + * Merge the split sections in the final binary.
> + */
> +SECTIONS {
> +       __patchable_function_entries : { *(__patchable_function_entries) }
> +
> +       .bss : {
> +               *(.bss .bss.[0-9a-zA-Z_]*)
> +               *(.bss..L* .bss..compoundliteral*)
> +       }
> +
> +       .data : {
> +               *(.data .data.[0-9a-zA-Z_]*)
> +               *(.data..L* .data..compoundliteral*)
> +       }
> +
> +       .rodata : {
> +               *(.rodata .rodata.[0-9a-zA-Z_]*)
> +               *(.rodata..L* .rodata..compoundliteral*)
> +       }
> +
> +       .text : { *(.text .text.[0-9a-zA-Z_]*) }
> +}
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
