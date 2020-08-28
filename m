Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691A5255869
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 12:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgH1KKk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 06:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1KKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 06:10:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5058C061264;
        Fri, 28 Aug 2020 03:10:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o196so417165qke.8;
        Fri, 28 Aug 2020 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+hJXI9cFE9rCcx7qtPV2P2e4rn3Gd6KJdCgG1Ajq7Wo=;
        b=J6jNWBRuWcWYeswiJHbzRkDdQe007vh1kwvU+6h1q+PnXiMD3M126l+Per5aQfKju0
         dmij3mBKZv1HflieLr4BbJ93ClRkO7YoaWLdR5T7jqrVSD2vtziPY0cO7QmEZJjzIDs+
         L+7/Aqfmo0DZmmsa54fzWAOuxPkMktI2qqymu5dJULq4pX/6adxCTub3R+k9FUNB/+aO
         4zxiL66Iz2/GPIQaUSMv+ZA/UaRLLzhp4i3hTL7Qr+l+9rNcZXrhorGYnyDn/rBWL6wt
         UCv7bxWwr5Pnd8bvHDhuX3RmcDfCo4135vhgS0KN908wsLXWo80wiZ53s7xtmLPQjkNT
         4JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+hJXI9cFE9rCcx7qtPV2P2e4rn3Gd6KJdCgG1Ajq7Wo=;
        b=GzFUwdi53Sytv0KUFimZTaXT962U2LIQAeoZyFibcTugnuzYBXqfhekc6u6D9j4SM8
         qXWKlYg8700Ak8j+qEF8363WgkSGysSXSmXMTJCR7czzdb0RPtp8dYRcrELpSGvP2fhr
         vrXzwbDwXzZvxWm6VDT/T+Yul4oKLgtWCK6QsOocG5yu84jZaSqj+ABWflX6cStXnej1
         lVE+zNlvLXmw9OpbJ/Bs84oHl/VOxJF2UvKcZE+OsgXsxXuxWPre2i2CJX/D0hgbX/eo
         O9/rPE32Uqo0CVmXtyIs/3/V86vtQJ3xq1zEy3Bg+juWd8IKCgjckjAS4jSKT1jCMMiy
         XSvg==
X-Gm-Message-State: AOAM532cVRgLD4kJEqOe+UakrhvZ8xIoSWEJs9D6Nm8neVpOof+6Ik57
        AfCv5TJlz0NnfVuaxPoBhFGV8PTS+lLwCV6W4dI=
X-Google-Smtp-Source: ABdhPJwOnd1RLFSro/DqkTyh21rvNgHPl4tBMJGboubBvMieApXh+jk5M+injx416qXZDO0/JzoVqAQPmPgLMf87wQg=
X-Received: by 2002:a37:b347:: with SMTP id c68mr452648qkf.430.1598609432041;
 Fri, 28 Aug 2020 03:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145249.745432-1-npiggin@gmail.com> <20200826145249.745432-13-npiggin@gmail.com>
In-Reply-To: <20200826145249.745432-13-npiggin@gmail.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 28 Aug 2020 18:09:54 +0800
Message-ID: <CAEbi=3egP4PtAvP-PGEM_QvmmvgtZP34Qx-4c7zzi7upU2=WjA@mail.gmail.com>
Subject: Re: [PATCH v2 12/23] nds32: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=8826=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:53=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Cc: Nick Hu <nickhu@andestech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Vincent Chen <deanbo422@gmail.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/nds32/include/asm/mmu_context.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/as=
m/mmu_context.h
> index b8fd3d189fdc..c651bc8cacdc 100644
> --- a/arch/nds32/include/asm/mmu_context.h
> +++ b/arch/nds32/include/asm/mmu_context.h
> @@ -9,6 +9,7 @@
>  #include <asm/proc-fns.h>
>  #include <asm-generic/mm_hooks.h>
>
> +#define init_new_context init_new_context
>  static inline int
>  init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  {
> @@ -16,8 +17,6 @@ init_new_context(struct task_struct *tsk, struct mm_str=
uct *mm)
>         return 0;
>  }
>
> -#define destroy_context(mm)    do { } while(0)
> -
>  #define CID_BITS       9
>  extern spinlock_t cid_lock;
>  extern unsigned int cpu_last_cid;
> @@ -47,10 +46,6 @@ static inline void check_context(struct mm_struct *mm)
>                 __new_context(mm);
>  }
>
> -static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_stru=
ct *tsk)
> -{
> -}
> -
>  static inline void switch_mm(struct mm_struct *prev, struct mm_struct *n=
ext,
>                              struct task_struct *tsk)
>  {
> @@ -62,7 +57,6 @@ static inline void switch_mm(struct mm_struct *prev, st=
ruct mm_struct *next,
>         }
>  }
>
> -#define deactivate_mm(tsk,mm)  do { } while (0)
> -#define activate_mm(prev,next) switch_mm(prev, next, NULL)
> +#include <asm-generic/mmu_context.h>
>
>  #endif

Acked-by: Greentime Hu <green.hu@gmail.com>
Thank you. :)
