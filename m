Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793801470E0
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 19:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAWSgt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 13:36:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34328 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWSgt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 13:36:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so1814248pgf.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 10:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Du75DAz6gc6OUr1fY7FgpBOCLXXoZnGoDrqj+IQyVuc=;
        b=MoeIwIkj0ihYvrUBOmCwHNkYR4q6x4Sw0Cz+yPfY1OzKFCRPoDzMtx4ElTUYyTYtk7
         nm3TyJLxCQsAGwIN5e0lAzXQQbwaQQa0k8WjRQmEsVSrk+E5dut6bE7iXxEqbw1gaNd0
         7dkx2r7zFuEGDYxMdNXnFZ/hOfnMW4QYY5cfgpJx4FXR3WwIMIfW//Ip3tB+FsRs9bDF
         RsDQR/fVkpo3xqSkqoo2x+ppR6SF2eS4Y3Fzvgq5LiZNrM1mhK2fS3sVl89aj4Fz13k3
         Cwrxl52LnLmwczYMnx/duVHbF9JXiXzrceg+vHRrbkXejX7GBAh5/gTEgWLsXMtepcYn
         4IUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Du75DAz6gc6OUr1fY7FgpBOCLXXoZnGoDrqj+IQyVuc=;
        b=SJPXJ29lwUiVt5towtirt54neYYvuiPbjgvJnEX7A/tYdDTU62DvwuQ/1Q2z7vFuKJ
         LTX5mN7AOnkflwLjrPDIBZO6FobwUUNJjS7vwZxGJ5IWbwI3tLBmatJb0jrPshWzc17A
         jzpBZT5CbU24mJO7mpQMLSsQAIGjz4M4AdQo0lMLdZzvso0hFHghnNStUTldHtuCGjKW
         2laAehix8PhJy+GF/U/xT5C51SSKWfhap6VX1KKr26OGNnsQ4ks4yTKDiOC21uw1fZld
         8/Aox9PX7IwIn2qj/Ap/etWF9Qk1Yvd5ZZkdnnrxvEB6f/Sx2xFrOmh0zfJn2aNbx6HC
         ttGg==
X-Gm-Message-State: APjAAAUM737PLXag6W85+M7BK+/3zOadbZSk2d4Pu1o8VMKcQEgE4eu9
        bQBTngbzdicDOdht1rnzQFyRydOtiguzI2wmMJiO3A==
X-Google-Smtp-Source: APXvYqzF1ufdUeg3XR7qqSc7Ev+wkbpiMXUi17btU/iZKt/BGrI8ecPaVhYXLQWrDvCoRqCUIV7DuLTqSNMiKYeevHs=
X-Received: by 2002:a62:e215:: with SMTP id a21mr8683542pfi.3.1579804608647;
 Thu, 23 Jan 2020 10:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-10-will@kernel.org>
In-Reply-To: <20200123153341.19947-10-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 23 Jan 2020 10:36:37 -0800
Message-ID: <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
>
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also know to have codegen
> issues which can lead to silent miscompilation:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> Raise the minimum GCC version for kernel build to 4.8 and remove some
> tautological Kconfig dependencies as a consequence.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
I wouldn't mind if this patch preceded the earlier one in the series
adding the warning, should the series require a v2 and if folks are
generally ok with bumping the min version.

> Cc: Arnd Bergmann <arnd@arndb.de>

Arnd had previously mentioned that one of the older RHEL releases
still supported was using a version of GCC < 4.8.  I don't know enough
about RHEL to know if packages are available to use newer compilers on
that distribution?  Or if it's a common version that kernel developers
are using?  It feels like eventually a workaround for a known compiler
bug becomes too burdensome to maintain, at which point we bump the
minimum version required.  In the future, it may be worthwhile for us
to discuss kernel toolchain upgrade process, and potentially document
it.

> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  Documentation/process/changes.rst |  2 +-
>  arch/arm/crypto/Kconfig           | 12 ++++++------
>  crypto/Kconfig                    |  1 -
>  include/linux/compiler-gcc.h      |  5 ++---
>  init/Kconfig                      |  1 -
>  scripts/Kconfig.include           |  3 ---
>  scripts/gcc-plugins/Kconfig       |  4 +---
>  7 files changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index 2284f2221f02..f2cbfa901cc8 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -29,7 +29,7 @@ you probably needn't concern yourself with pcmciautils.
>  ====================== ===============  ========================================
>          Program        Minimal version       Command to check the version
>  ====================== ===============  ========================================
> -GNU C                  4.6              gcc --version
> +GNU C                  4.8              gcc --version
>  GNU make               3.81             make --version
>  binutils               2.21             ld -v
>  flex                   2.5.35           flex --version
> diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
> index 2674de6ada1f..c9bf2df85cb9 100644
> --- a/arch/arm/crypto/Kconfig
> +++ b/arch/arm/crypto/Kconfig
> @@ -30,7 +30,7 @@ config CRYPTO_SHA1_ARM_NEON
>
>  config CRYPTO_SHA1_ARM_CE
>         tristate "SHA1 digest algorithm (ARM v8 Crypto Extensions)"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         select CRYPTO_SHA1_ARM
>         select CRYPTO_HASH
>         help
> @@ -39,7 +39,7 @@ config CRYPTO_SHA1_ARM_CE
>
>  config CRYPTO_SHA2_ARM_CE
>         tristate "SHA-224/256 digest algorithm (ARM v8 Crypto Extensions)"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         select CRYPTO_SHA256_ARM
>         select CRYPTO_HASH
>         help
> @@ -96,7 +96,7 @@ config CRYPTO_AES_ARM_BS
>
>  config CRYPTO_AES_ARM_CE
>         tristate "Accelerated AES using ARMv8 Crypto Extensions"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         select CRYPTO_SKCIPHER
>         select CRYPTO_LIB_AES
>         select CRYPTO_SIMD
> @@ -106,7 +106,7 @@ config CRYPTO_AES_ARM_CE
>
>  config CRYPTO_GHASH_ARM_CE
>         tristate "PMULL-accelerated GHASH using NEON/ARMv8 Crypto Extensions"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         select CRYPTO_HASH
>         select CRYPTO_CRYPTD
>         select CRYPTO_GF128MUL
> @@ -118,13 +118,13 @@ config CRYPTO_GHASH_ARM_CE
>
>  config CRYPTO_CRCT10DIF_ARM_CE
>         tristate "CRCT10DIF digest algorithm using PMULL instructions"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         depends on CRC_T10DIF
>         select CRYPTO_HASH
>
>  config CRYPTO_CRC32_ARM_CE
>         tristate "CRC32(C) digest algorithm using CRC and/or PMULL instructions"
> -       depends on KERNEL_MODE_NEON && (CC_IS_CLANG || GCC_VERSION >= 40800)
> +       depends on KERNEL_MODE_NEON
>         depends on CRC32
>         select CRYPTO_HASH
>
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 5575d48473bd..bd8540f56efc 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -320,7 +320,6 @@ config CRYPTO_AEGIS128
>  config CRYPTO_AEGIS128_SIMD
>         bool "Support SIMD acceleration for AEGIS-128"
>         depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
> -       depends on !ARM || CC_IS_CLANG || GCC_VERSION >= 40800
>         default y
>
>  config CRYPTO_AEGIS128_AESNI_SSE2
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index d7ee4c6bad48..e2f725273261 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -10,7 +10,8 @@
>                      + __GNUC_MINOR__ * 100     \
>                      + __GNUC_PATCHLEVEL__)
>
> -#if GCC_VERSION < 40600
> +/* https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 */
> +#if GCC_VERSION < 40800
>  # error Sorry, your compiler is too old - please upgrade it.
>  #endif
>
> @@ -126,9 +127,7 @@
>  #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
>  #define __HAVE_BUILTIN_BSWAP32__
>  #define __HAVE_BUILTIN_BSWAP64__
> -#if GCC_VERSION >= 40800
>  #define __HAVE_BUILTIN_BSWAP16__
> -#endif
>  #endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP && !__CHECKER__ */
>
>  #if GCC_VERSION >= 70000
> diff --git a/init/Kconfig b/init/Kconfig
> index bdc2f1b1667b..46729aa2ca0b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1257,7 +1257,6 @@ config LD_DEAD_CODE_DATA_ELIMINATION
>         bool "Dead code and data elimination (EXPERIMENTAL)"
>         depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>         depends on EXPERT
> -       depends on !(FUNCTION_TRACER && CC_IS_GCC && GCC_VERSION < 40800)
>         depends on $(cc-option,-ffunction-sections -fdata-sections)
>         depends on $(ld-option,--gc-sections)
>         help
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 4e645a798b56..5b7dc6635c4e 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -43,6 +43,3 @@ gcc-version := $(shell,$(srctree)/scripts/gcc-version.sh $(CC))
>
>  # Return y if the compiler is GCC, n otherwise
>  cc-is-gcc := $(success,$(CC) --version | head -n 1 | grep -q gcc)
> -
> -# Warn if the compiler is GCC prior to 4.8
> -$(warning-if,$(if-success,[ $(gcc-version) -lt 40800 ],$(cc-is-gcc),n),"Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.")
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index e3569543bdac..a0f669cd224f 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -1,9 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -preferred-plugin-hostcc := $(if-success,[ $(gcc-version) -ge 40800 ],$(HOSTCXX),$(HOSTCC))
> -
>  config PLUGIN_HOSTCC
>         string
> -       default "$(shell,$(srctree)/scripts/gcc-plugin.sh "$(preferred-plugin-hostcc)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
> +       default "$(shell,$(srctree)/scripts/gcc-plugin.sh "$(HOSTCXX)" "$(HOSTCXX)" "$(CC)")" if CC_IS_GCC
>         help
>           Host compiler used to build GCC plugins.  This can be $(HOSTCXX),
>           $(HOSTCC), or a null string if GCC plugin is unsupported.
> --
> 2.25.0.341.g760bfbb309-goog
>


-- 
Thanks,
~Nick Desaulniers
