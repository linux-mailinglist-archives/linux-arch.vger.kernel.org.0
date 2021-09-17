Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDED740F394
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbhIQHy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 03:54:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhIQHy5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 03:54:57 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MPosX-1mEiKr2zlD-00MrVl; Fri, 17 Sep 2021 09:53:34 +0200
Received: by mail-wr1-f47.google.com with SMTP id q26so13649189wrc.7;
        Fri, 17 Sep 2021 00:53:34 -0700 (PDT)
X-Gm-Message-State: AOAM533EhJK3HuQUtYj48pB6j9+oAiQplLYHOzFmQxg3wLSIAHVTqFn1
        hv+tXqBiCJE0tmtEkkFlLg8xTGhfEgzV9/5gyck=
X-Google-Smtp-Source: ABdhPJyYWqWKnqFY/a4Kf/vPsS0c2qB8QMRqZuZJ195s1S/CG3F7FL+9spSmhLrD/p0ncHSxJEX5URv+rnTr+QzwxYo=
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr10388372wrs.71.1631865214272;
 Fri, 17 Sep 2021 00:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn> <20210917035736.3934017-6-chenhuacai@loongson.cn>
In-Reply-To: <20210917035736.3934017-6-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 09:53:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0E3fRJU9VCRp7MQz-jBC0nHi1DwjPGtymEg3vJJoDqrg@mail.gmail.com>
Message-ID: <CAK8P3a0E3fRJU9VCRp7MQz-jBC0nHi1DwjPGtymEg3vJJoDqrg@mail.gmail.com>
Subject: Re: [PATCH V3 05/22] LoongArch: Add build infrastructure
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mBZTQjaYb8WtQneFumZYpiPFBqPGsxI08ewCpal0jnFkIIFYxo4
 diiQZjq429f8FuIIBDj65MWfDzFCjw/D/iuXcNarN5XIfSTmQ97Mt9aguKcm/al0NwlBsmh
 hfMAtcltz+Gd7mGXcaSREBdDn8FeDfWP9j/B2Z93Sp//az05nvvBGYxusyXBVKvJ5uB2G2Q
 eJJOcHHYEPjvsSJXhm4tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RO7CjDrpNx0=:WyNYbowOlsbISWCJb0bhlX
 KeZ8N3MfXgj5Df/k/yEFYbaqJlA7yI9BGTg8v0f7syrYEvyGE1W1jIuthb5s63SigUBJN1xee
 uPHN7Ni7F5RynqmgXahK/TDQuoj9WX7NTvjgquJqjAL7DVeoWTV+g0aMDbOh8su/z1KtopLXM
 OpVOfbhimz84hvHvDRD0gXci6EsdxoYem/njTdCwG0X4Q9KAjkJ8c0FWKHYRYwJq5ywtr3rqE
 GcImYrRKN9DIRrT+ThKXE+xVro1nB9uy+S68XLIaUC8I51fgFro3C20isUBGUDkVbN3xO3COg
 ZRhpjbIdV1wrZ0kLUNmMopTbyIgHM8OHUfj2ni8Q6U1lAwlBVaMymRpGsSJ7Y8fsyrK/A0TRD
 xAi43MjIV/BrWFGJ8MF4tkwBpAgBPkj/FMmaMbp/cnBTiunPSs3u+rrduS/t7J4vHJhYXgQDO
 l9N5noa25VPSaaDpicx5/DERnNKRqd47xYEtTYbaS7jJuP0HPWB+FH/Jkc9emc5QgdmdesolY
 ObQBh4a4cmaKrbwdKhAG3pbnIO5RbHgLbecOE5jmOF7C1pi4nyKgn4bV2crw6z9fSOriO5SH/
 ByMxoqgrEGB+NuINGuuX3vV2mswKr0OAT59xvSmiGRHSHY3agCVvj3HsydPZSn6cyVZIhhb8U
 u+RrSgHbeJ2KRNbrdWO7VTu8Q0MiQzdv5g0euCdY+JIF98rNQtP7CgZoFNEBvXNpgGcft0osJ
 /GN1DgGLc3zO1G/w0qVsyaBN0cJhLJRBuVIq4TjgCo0cj4Tv0rH67+8PfVtCw4o3HDsGvbOvg
 hqz5E4ETMHHGBV5Rvtu4aMrCF4bx4aZiOuPY2My1XiyGRAio+U/t+zfxYlsOeq9jMVy59zFuO
 KE0IZLhbDkO02qEBThAA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn>
wrote:> --- /dev/null
> +++ b/arch/loongarch/.gitignore
> @@ -0,0 +1,9 @@
> +*.lds
> +*.raw
> +calc_vmlinuz_load_addr
> +elf-entry
> +relocs
> +vmlinux.*
> +vmlinuz.*
> +
> +!kernel/vmlinux.lds.S

Can you double-check that 'make clean' and/or 'make mrproper' remove all the
generated files? This may already be the case, but I don't see how this is
done in your Makefile

> +
> +choice
> +       prompt "Page Table Layout"
> +       default 16KB_2LEVEL if 32BIT
> +       default 16KB_3LEVEL if 64BIT
> +       help
> +         Allows choosing the page table layout, which is a combination
> +         of page size and page table levels. The virtual memory address
> +         space bits are determined by the page table layout.
> +
> +config 4KB_3LEVEL
> +       bool "4KB with 3 levels"
> +       select PAGE_SIZE_4KB
> +       select PGTABLE_3LEVEL
> +       help
> +         This option selects 4KB page size with 3 level page tables, which
> +         support a maximum 39 bits of application virtual memory.
> + ...

Nice, this choice statement looks a lot better than the version you had before.

> +
> +cflags-y += -ffreestanding

I had not noticed this previously, but I think this should not be used here,
as -ffreestanding disables a number of optimizations for compiler builtins.

Did you just copy this from MIPS or do you have a particular reason this
is used here?

> +# Some distribution-specific toolchains might pass the -fstack-check
> +# option during the build, which adds a simple stack-probe at the beginning
> +# of every function.  This stack probe is to ensure that there is enough
> +# stack space, else a SEGV is generated.  This is not desirable for LoongArch
> +# as kernel stacks are small, placed in unmapped virtual memory, and do not
> +# grow when overflowed.
> +#
> +cflags-y += -fno-stack-check

This is already set in the global Makefile and can be removed as well

> +cflags-y += $(call as-option,-Wa$(comma)-mno-fix-loongson3-llsc,)
> +cflags-y += -U_LOONGARCH_ISA -D_LOONGARCH_ISA=_LOONGARCH_ISA_LOONGARCH64
> +
> +load-y                         = 0x9000000000200000
> +
> +drivers-$(CONFIG_PCI)          += arch/loongarch/pci/
> +
> +KBUILD_AFLAGS  += $(cflags-y)
> +KBUILD_CFLAGS  += $(cflags-y)
> +KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
> +
> +bootvars-y     = VMLINUX_LOAD_ADDRESS=$(load-y) PLATFORM="$(platform-y)"

I would argue that VMLINUX_LOAD_ADDRESS should not be configurable
here, instead all kernels should use the same value.

> diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
> new file mode 100644
> index 000000000000..41a76e675321
> --- /dev/null
> +++ b/arch/loongarch/include/asm/Kbuild
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0
> +generic-y += dma-contiguous.h
> +generic-y += export.h
> +generic-y += mcs_spinlock.h
> +generic-y += parport.h
> +generic-y += early_ioremap.h
> +generic-y += qrwlock.h
> +generic-y += qspinlock.h

The list is apparently from an older kernel and no longer needed for
files that are listed in include/asm-generic/Kbuild.

Please only list the files that are not already there.

        Arnd
