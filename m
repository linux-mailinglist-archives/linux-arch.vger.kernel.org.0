Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6D2CDE73
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgLCTFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbgLCTFb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 14:05:31 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAA3C061A51
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 11:04:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t37so1978681pga.7
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 11:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MGVJZBDXNN6LdEStSCVvQ7DYrKz46JI0zY/CXjUt84Y=;
        b=Xpngdm+dVlFRitn2i9O7Ckeyv9yY5k8xWK55Ab3b6x7eM5kQJiJc/IgV7V86j4qg2H
         amLk/0khYfIAjNlik2isDsQqYyz/ilBOzlQEBFZ6DMpPi+cGaj2elvUtLpjhXqYOb5AQ
         G8O3zDWWSiyFmCjEcIyMyecmxlJYoXBN3ba0ejgO7NgjloiouWAheLWWDP6mQUpPft7Q
         TPaUsJh85PI/1XvIG5kAonobzDqw9iwKWWP9UhM+EPX9ckPS/f0zd3Uz30kVeLTa1gyS
         3EMIdCE3a12qF/S3m/RfefmgYZg6Asg+OeFN+wPWNzMo63obakJbrKvpbdNA1dD5NNhd
         7Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MGVJZBDXNN6LdEStSCVvQ7DYrKz46JI0zY/CXjUt84Y=;
        b=buv9nwXe+KS+T/SDKikgRnZ5BJW/O12ImvkAPwSHGAsFUpsx+1LjPFZXRLv4hlSEjp
         mLzKy3E+0Dx5k8S2vhHTcDH301XTHajzsTrJGcdB6KT+AJJLfnXFNINsyRZIxaBfEvVs
         g2PG3Q2CwIDN/1uDYhhSI9/dYBExYMv7wKBMBp7NpKh+juFarJ0IzDIuPqBe/FwFmjbB
         UPfnEcrQ87jLXqKHC4RLYoaGrBVBDCv48SmPHPwN9P1IDq3y1KiYnJ8RZOIDlLaJ0uk3
         //xSbfO24UkBV1XRXeiE3wg9Iq68Ka+M2lX5+BXofndW0JkoOzaFbn80qTi44xu2tEX4
         EJwg==
X-Gm-Message-State: AOAM5305vBkuzAXAg7VoYW1o+uFwO7po/GON8kyWGPtYUNkJPqkOZf5G
        /qV6KNCLqUzRtG0MtbkIBm9h+Pg9Eg/lX2Ceoy4KRA==
X-Google-Smtp-Source: ABdhPJygUP1cIJwRL7tVCs5S0BP8zl26VHCEvSZgnDfJ1ubHqNbQexJfBHlekI9nVH0KVp4PeLXnxJUT/QE7eXpWKqU=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr374126pfy.15.1607022290861; Thu, 03 Dec
 2020 11:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20201203170529.1029105-1-maskray@google.com>
In-Reply-To: <20201203170529.1029105-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Dec 2020 11:04:39 -0800
Message-ID: <CAKwvOd=8trq9qndYvf8KD4_3XVfaT_BXcNZhrKP67-YH9WQL0g@mail.gmail.com>
Subject: Re: [PATCH] firmware_loader: Align .builtin_fw to 8
To:     Fangrui Song <maskray@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>, dwmw@amazon.co.uk,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 9:05 AM Fangrui Song <maskray@google.com> wrote:
>
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
>
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error.
>
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..3cd4bd1193ab 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -459,6 +459,7 @@
>         }                                                               \
>                                                                         \
>         /* Built-in firmware blobs */                                   \
> +       ALIGN_FUNCTION();                                               \

Thanks for the patch!

I'm going to repeat my question from the above link
(https://github.com/ClangBuiltLinux/linux/issues/1204#issuecomment-737610582)
just in case it's not naive:

ALIGN_FUNCTION() C preprocessor macro seems to be used to realign
code, while STRUCT_ALIGN() seems to be used to realign data.  It looks
to me like only data is put into .builtin_fw.  If these relocations
require an alignment of 8, than multiples of 8 should also be fine
(STRUCT_ALIGN in 32 for all toolchain version, except gcc 4.9 which is
64; both are multiples of 8 though).  It looks like only structs are
placed in .builtin_fw; ie. data.  In that case, I worry that using
ALIGN_FUNCTION/8 might actually be under-aligning data in this
section.

Though, in https://github.com/ClangBuiltLinux/linux/issues/1204#issuecomment-737625134
you're comment:

>> In GNU ld, the empty .builtin_fw is removed

So that's a difference in behavior between ld.bfd and ld.lld, which is
fine, but it makes me wonder whether we should instead or additionally
be discarding this section explicitly via linker script when
CONFIG_FW_LOADER is not set?


>         .builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {      \
>                 __start_builtin_fw = .;                                 \
>                 KEEP(*(.builtin_fw))                                    \
> --
> 2.29.2.576.ga3fc446d84-goog
>


-- 
Thanks,
~Nick Desaulniers
