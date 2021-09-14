Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5A40AADD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhINJb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 05:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhINJb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 05:31:27 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23357C061574;
        Tue, 14 Sep 2021 02:30:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id f65so11595629pfb.10;
        Tue, 14 Sep 2021 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XTjWIiEXl9oku1kTLwi9+pqlnMZMr1CiGdU7Q7ifRlE=;
        b=O24NXUEn+Xi0N8/37yoJePSjWeb6kWoZNVMaj3l7DnMN2Luv2IyhG0B8T8FoZcoNbc
         LI7otGZF7HO/xtbYyOjVMYy1pnYL/Tn2XZ90oH7lrVsX1FFCKbg7+F6WRC1/zMHfGgpn
         JQarz7LA1qIduqH6ft6zkslcCac/x3m57uYLD8/v89EBiGD98qCkwHB8mwv5exVqGJ1l
         ano+X3eHj9FIpc9wu/plcqext624NwhbImZZGie0D9H3tgE+tTSCJzG3uBD2CwPRtc/f
         0pyxkFcBv9diMLwG89UQsoqZoCzZIfP7NCA0conOpBWViIqg6gYZvJN3qOnktQTRWhiB
         kjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XTjWIiEXl9oku1kTLwi9+pqlnMZMr1CiGdU7Q7ifRlE=;
        b=RmU+KjPgYZKr/nfG9WHWVJFQfGWItSWqFdhYeUuwaUpO1USGh6Z4IjBWaKzIGs/w7h
         lH8mzNkEvVDm2DJOmKApukVOhqQtB6KhECYjv8CvUjNmWuIdyf09LRrSoQFSFPjNOjkF
         6ixNZz8aUtraUrWX6HdAI3xRqcr1+yx4gOO+36gMWEzk5xmkfExxignfcLrznEANrmfE
         mg04olJ5obV8xrthMjjs3XL3WVo4ronp+nm+FaRUCgMgJqTrTe9Fg3O0IVyfUIRei5so
         aQrZBG27KMIL2/MBBjuE+mg8htz+HvtLAse9WMLnCpsRTK77IqrRMWb3ej+++wPDds1c
         y1Nw==
X-Gm-Message-State: AOAM531LfLW4jSP12N4iuSRXLUT433R+TbNT8yWPMkH+86BD2oY/LGxJ
        XW8vF0oIzXq1ATxJ152nWYJdWXsQNB6ECIWgmSA=
X-Google-Smtp-Source: ABdhPJyGFjJFvY8LAqFYXYnURxFhVUaHrRJUH4Fje+MaSbpJ1+PdIQ7ZKa6ANfe86KXkMHoPm++hJrVmV/inGr7NOsU=
X-Received: by 2002:a63:651:: with SMTP id 78mr14840469pgg.306.1631611808531;
 Tue, 14 Sep 2021 02:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631583258.git.chenfeiyang@loongson.cn> <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
In-Reply-To: <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 14 Sep 2021 17:30:14 +0800
Message-ID: <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        arnd@arndb.de, Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Zhou Yanjie <zhouyu@wanyeetech.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Sept 2021 at 16:54, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A8 2021/9/14 2:50, Feiyang Chen =E5=86=99=E9=81=93:
> > Convert MIPS to use the generic entry infrastructure from
> > kernel/entry/*.
> >
> > v2: Use regs->regs[27] to mark whether to restore all registers in
> > handle_sys and enable IRQ stack.
> Hi Feiyang,
>
> Thanks for your patch, could you please expand how could this improve
> the performance?
>

Hi, Jiaxun,

We always restore all registers in handle_sys in the v1 of the
patchset. Since regs->regs[27] is marked where we need to restore all
registers, now we simply use it as the return value of do_syscall to
determine whether we can only restore partial registers in handle_sys.

+       move    a0, sp
+       jal     do_syscall
+       beqz    v0, 1f                          # restore all registers?
+       nop
+
+       .set    noat
+       RESTORE_TEMP
+       RESTORE_STATIC
+       RESTORE_AT
+1:     RESTORE_SOME
+       RESTORE_SP_AND_RET
+       .set    at

Thanks,
Feiyang

> Thanks.
> - Jiaxun
> >
> > Feiyang Chen (2):
> >    MIPS: convert syscall to generic entry
> >    MIPS: convert irq to generic entry
> >
> >   arch/mips/Kconfig                         |   1 +
> >   arch/mips/include/asm/entry-common.h      |  13 ++
> >   arch/mips/include/asm/irqflags.h          |  42 ----
> >   arch/mips/include/asm/ptrace.h            |   8 +-
> >   arch/mips/include/asm/sim.h               |  70 -------
> >   arch/mips/include/asm/stackframe.h        |   8 +
> >   arch/mips/include/asm/syscall.h           |   5 +
> >   arch/mips/include/asm/thread_info.h       |  17 +-
> >   arch/mips/include/uapi/asm/ptrace.h       |   7 +-
> >   arch/mips/kernel/Makefile                 |  14 +-
> >   arch/mips/kernel/entry.S                  | 143 +-------------
> >   arch/mips/kernel/genex.S                  | 150 +++------------
> >   arch/mips/kernel/head.S                   |   1 -
> >   arch/mips/kernel/linux32.c                |   1 -
> >   arch/mips/kernel/ptrace.c                 |  78 --------
> >   arch/mips/kernel/r4k-bugs64.c             |  14 +-
> >   arch/mips/kernel/scall.S                  | 136 +++++++++++++
> >   arch/mips/kernel/scall32-o32.S            | 223 ---------------------
> >   arch/mips/kernel/scall64-n32.S            | 107 ----------
> >   arch/mips/kernel/scall64-n64.S            | 116 -----------
> >   arch/mips/kernel/scall64-o32.S            | 221 ---------------------
> >   arch/mips/kernel/signal.c                 |  59 +-----
> >   arch/mips/kernel/signal_n32.c             |  15 +-
> >   arch/mips/kernel/signal_o32.c             |  29 +--
> >   arch/mips/kernel/syscall.c                | 148 +++++++++++---
> >   arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
> >   arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
> >   arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
> >   arch/mips/kernel/traps.c                  | 225 ++++++++++++++++-----=
-
> >   arch/mips/kernel/unaligned.c              |  19 +-
> >   arch/mips/mm/c-octeon.c                   |  15 ++
> >   arch/mips/mm/cex-oct.S                    |   8 +-
> >   arch/mips/mm/fault.c                      |  12 +-
> >   arch/mips/mm/tlbex-fault.S                |   7 +-
> >   34 files changed, 594 insertions(+), 1342 deletions(-)
> >   create mode 100644 arch/mips/include/asm/entry-common.h
> >   delete mode 100644 arch/mips/include/asm/sim.h
> >   create mode 100644 arch/mips/kernel/scall.S
> >   delete mode 100644 arch/mips/kernel/scall32-o32.S
> >   delete mode 100644 arch/mips/kernel/scall64-n32.S
> >   delete mode 100644 arch/mips/kernel/scall64-n64.S
> >   delete mode 100644 arch/mips/kernel/scall64-o32.S
> >
>
