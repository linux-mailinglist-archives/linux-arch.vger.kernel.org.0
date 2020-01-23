Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF21461A6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgAWFpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 00:45:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWFpA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 00:45:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so1625721wrl.13
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2020 21:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQFSVaPDWWaPdmtn/1E6R2bbXGcBvm7LU1/hWkgtmnw=;
        b=Dl9gZ/DJ2AT3Xr/0RRA+Sbi3NK5lX+C8MO+aZhLy/zYhEKXK3+OILOcnsaxaWZsy2C
         LoxiyVtwZTA4NxUjH0q4ytf13LPxizT+eiZmnyv9IwJ32EFXc1eWAazN+9Xbjmw6JZvl
         XSXVv8yBmxD4tEc2h4jtwDBf8vMeoFJI5hprg1IElHZh0Cvr2Kw7mHDNHKY5z/oc84Fb
         6pTS2P2vplQQdKQLJC5DiWiTjAdBwdow9wCdYplVq0TcXR87xhjJAoKz569QLYvExuaB
         aFxdh4XOTH7jHVeJ0KXHU1cfvuQF9N02WXsVKo+qUfKnWRfBXvhh4ma03KSZA2poBlEi
         PtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQFSVaPDWWaPdmtn/1E6R2bbXGcBvm7LU1/hWkgtmnw=;
        b=i3JCTs9JafroaYZ4wSUAumHYiFgmiOwgaRhVIUOh4Q7KYmraHsIyE3FBT+QwUvWA9b
         dKO5ZXzVKhzpWYK2PRFGwyVeWd8eLjzyZXgN0NGi7hJWHPxP/hoQ5CHS2aN7pK8KSSRZ
         J3pK6L5TNCKYsGD4e0dfCxWLZkWkMrOeluHkmVvHlCTLK79roJRmzCAcoYSLSemiNumQ
         szw1Ir7EzAtetrSs1xQ6nR9DLzbuF0QMxEhebsrvtO4uXWalXf7ua4piaPta5v4VhziQ
         QfNUJpXKidFcLDQhLmfVpLPuBuxw37ER7dT/uO4aGtdjxKCiGUCus8uViiWvORf/E7Qw
         m6Kg==
X-Gm-Message-State: APjAAAV7W0+gq9AnnJ8woVrvf1lrejyTkNxBwaBBAfq/sxJqkCR5AFNp
        Nu8Y6/umJ3PlYOVeiMz77FslTGFPWNx3yyOlT1X7Kg==
X-Google-Smtp-Source: APXvYqxFx3acHhfHKtlNettHSRNPLnlsI6PD2cRjHTPUId0DG7CREieo2bxT1jP74Wv0NcoVtafTFyY9u+09F5aObD8=
X-Received: by 2002:a5d:620b:: with SMTP id y11mr15177157wru.230.1579758297609;
 Wed, 22 Jan 2020 21:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20200116143029.31441-1-guoren@kernel.org> <20200116143029.31441-2-guoren@kernel.org>
In-Reply-To: <20200116143029.31441-2-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Jan 2020 11:14:46 +0530
Message-ID: <CAAhSdy3pe4NNS4Gv3dxfe36mMQAB4wis3+wN2OzBmVF7BehK=A@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] riscv: Rename __switch_to_aux -> fpu
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
> The name of __switch_to_aux is not clear and rename it with the
> determine function: __switch_to_fpu. Next we could add other regs'
> switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Anup Patel <Anup.Patel@wdc.com>
> ---
>  arch/riscv/include/asm/switch_to.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
> index 407bcc96a710..b9234e7178d0 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -44,7 +44,7 @@ static inline void fstate_restore(struct task_struct *task,
>         }
>  }
>
> -static inline void __switch_to_aux(struct task_struct *prev,
> +static inline void __switch_to_fpu(struct task_struct *prev,
>                                    struct task_struct *next)
>  {
>         struct pt_regs *regs;
> @@ -60,7 +60,7 @@ extern bool has_fpu;
>  #define has_fpu false
>  #define fstate_save(task, regs) do { } while (0)
>  #define fstate_restore(task, regs) do { } while (0)
> -#define __switch_to_aux(__prev, __next) do { } while (0)
> +#define __switch_to_fpu(__prev, __next) do { } while (0)
>  #endif
>
>  extern struct task_struct *__switch_to(struct task_struct *,
> @@ -71,7 +71,7 @@ do {                                                  \
>         struct task_struct *__prev = (prev);            \
>         struct task_struct *__next = (next);            \
>         if (has_fpu)                                    \
> -               __switch_to_aux(__prev, __next);        \
> +               __switch_to_fpu(__prev, __next);        \
>         ((last) = __switch_to(__prev, __next));         \
>  } while (0)
>
> --
> 2.17.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
