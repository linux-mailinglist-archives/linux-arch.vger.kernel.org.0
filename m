Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE71461AA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 06:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWFpX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 00:45:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgAWFpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 00:45:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so1626418wrl.13
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2020 21:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dhaSiajlLJy3RCstW1Wok1ELZDJt5jnnFEHfck4kgA=;
        b=srT44r3/1SbNdevUdQ9bRBy6SwEXY/02irxN+XL8wHgIDa5Gt0+V0FEwHhidbMcR6M
         BhRrTNOfiTV/bqTjedt7rzstSl75yNFgA9Xh6Z/NzoQU6gSIOFWU7+IWH5J9qKDz7kc/
         xEfLD2tLDo/XeFfbhcnXTXuW6nFgfXmYxV9uMkRe/Mf46YpGZdyyZ4B4KhlSb5qmluDi
         cIojFHALTVqjpGujeH0O/w7/d83vqIbY0/KVTu3LFvlgRy38fYGPzVyN45an5Q9b/Y8e
         OQaeKoHgWBhZZkeTOY/oj78yWUmV7UwxPw2hAFBVc/3Xy0EXKR75C7y572p5uI0cuCLc
         dWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dhaSiajlLJy3RCstW1Wok1ELZDJt5jnnFEHfck4kgA=;
        b=uYF0fMfGkr0Pe5SOE9HgMe3WMIrfzu47E/gdEaoeuzpV8R6ir4ILlE2xsThzuTVehx
         XYbmCMexsh4i441s+h3MhzQU03uznfN8wR8JzXUT5TUnKFNzclRu+aq2976vSzcoXQZZ
         XlMSslyvERrw2FV0x2bAxIi8phJqMeYPgFAtiFJd/4Yh+6RHFQsv2ZXjwohqVHeqcdbI
         29NktpN+5vwFa04RoiBtbhc8e9K0QPl9gJjMYu8Lkg2wDfW4BepQIA2sKo8vAaOrn2hq
         s7tnfaTjQnzlylFzzwIDOZ64oZK1rfCRVqVVmQJLM26OdAl7Z+8O8RzdbYEh5HP2JPcj
         PAOA==
X-Gm-Message-State: APjAAAUsemYTD5TF+WKPtjF/tp0jaIbkQ182kFXTd+kTPCF5WwkHRq22
        nMYzzMnTBLh6z3eIYd/VLcDbFRBizt6weitO+Lc6+y61/HQV4Q==
X-Google-Smtp-Source: APXvYqzcyARxSCYh9QXhcwiwMl3YP9yKSjIhV20ejTbeIMjXgUtVd49l+y7ALLEykXf+KKxL00lLsYxavevqYQFLh/E=
X-Received: by 2002:adf:eb09:: with SMTP id s9mr15396459wrn.61.1579758320776;
 Wed, 22 Jan 2020 21:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20200116143029.31441-1-guoren@kernel.org> <20200116143029.31441-3-guoren@kernel.org>
In-Reply-To: <20200116143029.31441-3-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Jan 2020 11:15:09 +0530
Message-ID: <CAAhSdy0LPZC-nMRWpovTdLd-b421WK6UAdLJzdQ2RfnxEqRo0Q@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] riscv: Extending cpufeature.c to detect V-extension
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 16, 2020 at 8:01 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Current cpufeature.c doesn't support detecting V-extension, because
> "rv64" also contain a 'v' letter and we need to skip it.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Anup Patel <Anup.Patel@wdc.com>
> ---
>  arch/riscv/include/uapi/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c      | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/uapi/asm/hwcap.h b/arch/riscv/include/uapi/asm/hwcap.h
> index dee98ee28318..a913e9a38819 100644
> --- a/arch/riscv/include/uapi/asm/hwcap.h
> +++ b/arch/riscv/include/uapi/asm/hwcap.h
> @@ -21,5 +21,6 @@
>  #define COMPAT_HWCAP_ISA_F     (1 << ('F' - 'A'))
>  #define COMPAT_HWCAP_ISA_D     (1 << ('D' - 'A'))
>  #define COMPAT_HWCAP_ISA_C     (1 << ('C' - 'A'))
> +#define COMPAT_HWCAP_ISA_V     (1 << ('V' - 'A'))
>
>  #endif /* _UAPI_ASM_RISCV_HWCAP_H */
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index a5ad00043104..c8527d770c98 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -30,6 +30,7 @@ void riscv_fill_hwcap(void)
>         isa2hwcap['f'] = isa2hwcap['F'] = COMPAT_HWCAP_ISA_F;
>         isa2hwcap['d'] = isa2hwcap['D'] = COMPAT_HWCAP_ISA_D;
>         isa2hwcap['c'] = isa2hwcap['C'] = COMPAT_HWCAP_ISA_C;
> +       isa2hwcap['v'] = isa2hwcap['V'] = COMPAT_HWCAP_ISA_V;
>
>         elf_hwcap = 0;
>
> @@ -44,7 +45,8 @@ void riscv_fill_hwcap(void)
>                         continue;
>                 }
>
> -               for (i = 0; i < strlen(isa); ++i)
> +               /* Skip rv64/rv32 to support v/V:vector */
> +               for (i = 4; i < strlen(isa); ++i)
>                         this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>
>                 /*
> --
> 2.17.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
