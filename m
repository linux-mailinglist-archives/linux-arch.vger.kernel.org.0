Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F312D319A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgLHSAo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgLHSAo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 13:00:44 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D3C061749
        for <linux-arch@vger.kernel.org>; Tue,  8 Dec 2020 09:59:57 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so7373058pll.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Dec 2020 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vC+DtXn0h/YwH+m7lTrhoayKAF6AvMOlxSoaUs6f0Qw=;
        b=YXOIjYUsT5Q8iO3uJgW6RGchkwNRc3yrbF4s3UOEuRdkb/oboZ2dtsGYRnGVvrVZ6G
         jWGEkGOqFRKVhpvOWMr1GedqB4CUmBTkoTrLB9P5QtkCWrwmh+pmwNMMCj1Ir0gj3ly2
         0pAPIcXU+1XDt4lpR8zybuSSuIHAKyfUx7HkvtKX6ESuz2YeTczfaRbj1x6Mzs/MiiO2
         fA7jg6hA8Nqw9ln2HSWoLZdxN4lukDyweQkhPssJgBLv73SNNnBVUXmrSe6OTqB2Wm2B
         Usw4dlrZVkPVWeO/eFSLtH5id60nrHq8IRZLbUvT7Ze1aRpyrCj6eyxkbMzF89RtBqzG
         1jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC+DtXn0h/YwH+m7lTrhoayKAF6AvMOlxSoaUs6f0Qw=;
        b=eOntnIkIYhR0jwfi0zwEphg+kLAgCY+8J/T4ZIxX/iLg+3oDiCRzAllDVYqpEt0HtP
         bu24UsO0YnOkxrNShzcRDzDFyefzWGPYLQrL4u74xzasHK+qOCS9HeTWR/h4jF4VkSzf
         tGCrrqS+mGPlsfHL342tXaqPGOWBubYgohMklM6g+VaDGlFJuUb+1WT9+bJNGgN2cC5Z
         ml7uMwaiJcl113eseoxLR7aYPCNfnExI78LSW0ebZ56HtZ/UgzgPxreQXik7BY7Xc0L2
         Z+H5QPX+/VAPP8tL74bVnN1H9VI/mH1LYexNBR+y0iAGF6cC+7JPj2KHZNe598X10LqE
         e7Vg==
X-Gm-Message-State: AOAM531uygq8kIA5sz331UWSm4DCgVlVPOetH9poZeQKLUv3xv+dRGzv
        mbhXE5So6RCqvWOOd3qtYBl0LxDd2thsY73QSoaxWv3XL+cGTw==
X-Google-Smtp-Source: ABdhPJyQp0/wPv19OW0732e/Fr/ER7bdM1OF8dikRA7UvJl9auQoPnqlNTrQKsD9/y2ExMecMuhrUG47rNfhzR+fCO8=
X-Received: by 2002:a17:902:8541:b029:da:fcd1:7bf with SMTP id
 d1-20020a1709028541b02900dafcd107bfmr9196778plo.56.1607450397283; Tue, 08 Dec
 2020 09:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
In-Reply-To: <20201208054646.2913063-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Dec 2020 09:59:46 -0800
Message-ID: <CAKwvOdmuwOPzZZHMh58syoorc4ED5-6_tbxCqhL0Gi65mq58-A@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
To:     Fangrui Song <maskray@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 7, 2020 at 9:46 PM Fangrui Song <maskray@google.com> wrote:
>
> arm64 references the start address of .builtin_fw (__start_builtin_fw)
> with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> relocations. The compiler is allowed to emit the
> R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> include/linux/firmware.h is 8-byte aligned.
>
> The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> multiple of 8, which may not be the case if .builtin_fw is empty.
> Unconditionally align .builtin_fw to fix the linker error. 32-bit
> architectures could use ALIGN(4) but that would add unnecessary
> complexity, so just use ALIGN(8).
>
> Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> ---
> Change in v2:
> * Use output section alignment instead of inappropriate ALIGN_FUNCTION()

Cool, this approach is what we already use for other global arrays;
such as __tracepoints_ptrs.  (I wonder why we don't use 4B alignment
for 32b...but 8 is a multiple of 4, so should be fine for 32b
targets).

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Build+Boot tested aarch64 and x86_64 with ld.lld and ld.bfd. Did not
test loading builtin firmware.

> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..b97c628ad91f 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -459,7 +459,7 @@
>         }                                                               \
>                                                                         \
>         /* Built-in firmware blobs */                                   \
> -       .builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {      \
> +       .builtin_fw : AT(ADDR(.builtin_fw) - LOAD_OFFSET) ALIGN(8) {    \
>                 __start_builtin_fw = .;                                 \
>                 KEEP(*(.builtin_fw))                                    \
>                 __end_builtin_fw = .;                                   \
> --
> 2.29.2.576.ga3fc446d84-goog
>


-- 
Thanks,
~Nick Desaulniers
