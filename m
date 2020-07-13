Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22521D384
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jul 2020 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMKHV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jul 2020 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgGMKHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 06:07:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997CC061755;
        Mon, 13 Jul 2020 03:07:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so9431677qtq.11;
        Mon, 13 Jul 2020 03:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hra1SVxTdrHnmSqT77/bjMGWIFkz435wwiQ+ZLnZoDI=;
        b=ptiRUWo4gXYQycmEkPKTyJJZRN7Bj54mqkYIggzhcdgIJddti3yb3pwt2oKuq5Q0Y0
         WjRZjIT2ThsoI09IUDHLACAsItQWoXa0IyjIue11vonhfNd670q6xTS4V3v97YgiDQMA
         9yR5LmgfcdAQcV0tZN6ZvDXveHjOeIcK+uy24VE8hssRLCTGam408lxayc6b7XsN6Q7P
         /Hg5geh/iVhe2vjX46XGDIe3OpMNLs4eV7XDlhV5kAKDDMQ93DvVh1CI0Lqh5zWXIOu9
         6sZow05O2kidzix7prq9gGoF0WJeZHV8Y+YxmAp2F367+5dENJvvpy2Aqcwb5eiIAX0R
         J+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hra1SVxTdrHnmSqT77/bjMGWIFkz435wwiQ+ZLnZoDI=;
        b=jTrUxht2E1x/Jw3GYYYmUzBBNUi9lDYZz9oM7nav2+kZAmuJgSfhdZbUSX1+B/dnAe
         R8DP182GBUiwrrJCF1XTz9tQHttVeRJODaK9gi35VHU5t8LS8aCL7hmjt07wBNScNM2d
         if/MDxREonRT3fdOCb4lJzffgUnmbXm2BA2X3rvmx+76PxdVwPqLJqnlv2e1QNQ2V6Az
         RaaeAkaACPD9pfBbPRsHbz4rLhHQpafOsYbS/y5MiKZ2fyk7aEsME/fCb73bHbv8fJR1
         eSbbEvVL+Gfk0pICU6dV2BdZ5BLw9cx8Z0CBUWo+/Nx39qi6JzXon5NrPTyU/mFzdQ6K
         SCMQ==
X-Gm-Message-State: AOAM530WB9FDWrj4tsFfhYqgssl+cFXU/g7/RdglvCXwWCOL851BZFe/
        Q8cCDs6UJMM2CcKsWeH67vBZsJRZmWsPrHVC4WE=
X-Google-Smtp-Source: ABdhPJx2Tkh9kzNP5zejlcgntpWG6iqUsWwAdhz/7Y2gf+TeAPNupDdNYWVSICr1330Epz0MkIk6TUJ4OuKUEr4Uoj0=
X-Received: by 2002:ac8:19c4:: with SMTP id s4mr79036237qtk.117.1594634839691;
 Mon, 13 Jul 2020 03:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de> <20200710135706.537715-6-hch@lst.de>
In-Reply-To: <20200710135706.537715-6-hch@lst.de>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 13 Jul 2020 18:06:42 +0800
Message-ID: <CAEbi=3fk9u9n5vcENFuSMkob81+hg2r2dd0oN2FfaqLg0eosSw@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christoph Hellwig <hch@lst.de> =E6=96=BC 2020=E5=B9=B47=E6=9C=8810=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=889:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add helpers to wraper the get_fs/set_fs magic for undoing any damange
> done by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/kernel/sdei.c         |  2 +-
>  arch/m68k/include/asm/tlbflush.h | 12 ++++++------
>  arch/mips/kernel/unaligned.c     | 27 +++++++++++++--------------
>  arch/nds32/mm/alignment.c        |  7 +++----
>  arch/sh/kernel/traps_32.c        | 18 ++++++++----------
>  drivers/firmware/arm_sdei.c      |  5 ++---
>  include/linux/uaccess.h          | 18 ++++++++++++++++++
>  kernel/events/callchain.c        |  5 ++---
>  kernel/events/core.c             |  5 ++---
>  kernel/kthread.c                 |  5 ++---
>  kernel/stacktrace.c              |  5 ++---
>  mm/maccess.c                     | 22 ++++++++++------------
>  12 files changed, 69 insertions(+), 62 deletions(-)
>
[...]
> diff --git a/arch/nds32/mm/alignment.c b/arch/nds32/mm/alignment.c
> index c8b9061a2ee3d5..1eb7ded6992b57 100644
> --- a/arch/nds32/mm/alignment.c
> +++ b/arch/nds32/mm/alignment.c
> @@ -512,7 +512,7 @@ int do_unaligned_access(unsigned long addr, struct pt=
_regs *regs)
>  {
>         unsigned long inst;
>         int ret =3D -EFAULT;
> -       mm_segment_t seg =3D get_fs();
> +       mm_segment_t seg;
>
>         inst =3D get_inst(regs->ipc);
>
> @@ -520,13 +520,12 @@ int do_unaligned_access(unsigned long addr, struct =
pt_regs *regs)
>               "Faulting addr: 0x%08lx, pc: 0x%08lx [inst: 0x%08lx ]\n", a=
ddr,
>               regs->ipc, inst);
>
> -       set_fs(USER_DS);
> -
> +       seg =3D force_uaccess_begin();
>         if (inst & NDS32_16BIT_INSTRUCTION)
>                 ret =3D do_16((inst >> 16) & 0xffff, regs);
>         else
>                 ret =3D do_32(inst, regs);
> -       set_fs(seg);
> +       force_uaccess_end(seg);
>
>         return ret;
>  }

Hi Christoph, Thank you.
Acked-by: Greentime Hu <green.hu@gmail.com>
