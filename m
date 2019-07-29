Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621A078B9F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfG2MTV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 08:19:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41463 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfG2MTV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 08:19:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so59284661qtj.8;
        Mon, 29 Jul 2019 05:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r3aA+VaP9kq74504aLthQ04EU5sZHZvPto/jvI8ekQ=;
        b=S9rfrKy/5cS/omruAjpzDtXzCf241ehZM1OFHAIii3sj/yZmiiPK+CGl6+1a6vJBiy
         J7ccQeBsnSpItm2fQGbRpN2DI3QrfeI2IA5Mq5RqctmD5c29kk+2x9o6uiw5ox0x/T6t
         /PTzcRZiWNRoWLx+DLO/k7gAoheyUIKf6oLV8jYBwdJhwEt6bK7TFqhyubWxmjDpLaTT
         +QqgnkDK36jxt6qVR/+bYf3LKauOuazIWALxtGZ7I6fjJEdsIAjhQwFFOLWKSE7IEK/9
         hCyVhSiBgxpkmzezyO7UcVxcOw0l2o1G6qdGgbNKZCZMB2UAb/07vMPFsJJcqTs8+/Pn
         Zx/g==
X-Gm-Message-State: APjAAAX4PP0uhVG1zttHm0sHDix8jeZbWhupOGIIMUzwwVTaV8o6f+kt
        seJe2K7tZEG/FyPCdCWxZa+cOQMYlIcue4OKoB8=
X-Google-Smtp-Source: APXvYqxqMiasUmrTKUxTkbxHmu+BMI0vql1C86/J0y7f37QSRQHzhzvNm/LtZ0yuO/TrWEKOlPnvDMxKL72IjDIV1bY=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr77659385qtf.204.1564402760248;
 Mon, 29 Jul 2019 05:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190729095521.1916-1-ard.biesheuvel@linaro.org>
 <CAK8P3a1=6nW0d+LOp__tMepYwGCc5f+e6qb1D3wUtp6_79Yd-A@mail.gmail.com> <CAKv+Gu_8nNd-td5F9u0dgH7x1kF+r8sCL432MvzmxqNZqqW-gA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_8nNd-td5F9u0dgH7x1kF+r8sCL432MvzmxqNZqqW-gA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Jul 2019 14:19:04 +0200
Message-ID: <CAK8P3a2sa4DZyArsRNh-MMqL2dLv32-pgZhH+VdE8X2UKFjZTg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: make simd.h a mandatory include/asm header
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 29, 2019 at 12:45 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Mon, 29 Jul 2019 at 13:32, Arnd Bergmann <arnd@arndb.de> wrote:
> > It looks like there are a number of these that could be handled the
> > same way. Should we do that for the asm-generic tree afterwards?
> >
>
> I guess it depends whether any dependencies on those headers exist in
> code that is truly generic. If they are only needed by some common
> infrastructure that cannot be enabled for a certain architecture
> anyway, I don't think making it a mandatory header is appropriate.
>
> So I think the question is whether the first column and the number of
> per-arch instances of that header add up to 25 (disregarding the
> exception for arch/um for now)

Here is a list of how many architectures besides arch/um do not have a
given file
with either generic-y or as a private copy:

$ git grep -h generic-y arch/*/include/asm/Kbuild  | sort | uniq -c  |
sort -nr  | cut -f 2 -d= | while read file ; do for arch in
arch/*/include/asm ; do if [ ! -e ${arch}/${file} ] && ! grep -q
${file} ${arch}/Kbuild  ; then echo ${arch}/${file} ; fi ; done | grep
-v arch/um/ | echo `wc -l` $file ; done | sort -n
0 atomic.h
0 barrier.h
0 bitops.h
0 bug.h
0 bugs.h
0 cacheflush.h
0 checksum.h
0 compat.h
0 current.h
0 delay.h
0 device.h
0 div64.h
0 dma.h
0 dma-mapping.h
0 emergency-restart.h
0 exec.h
0 fb.h
0 ftrace.h
0 futex.h
0 hardirq.h
0 hw_irq.h
0 io.h
0 irq.h
0 irq_regs.h
0 irq_work.h
0 kdebug.h
0 kmap_types.h
0 kprobes.h
0 linkage.h
0 local.h
0 mm-arch-hooks.h
0 mmiowb.h
0 mmu_context.h
0 mmu.h
0 module.h
0 pci.h
0 percpu.h
0 pgalloc.h
0 preempt.h
0 sections.h
0 serial.h
0 shmparam.h
0 switch_to.h
0 timex.h
0 tlbflush.h
0 topology.h
0 trace_clock.h
0 uaccess.h
0 unaligned.h
0 vga.h
0 word-at-a-time.h
0 xor.h
1 asm-offsets.h
1 cmpxchg.h
1 spinlock.h
1 user.h
2 kvm_para.h
3 mcs_spinlock.h
4 extable.h
4 local64.h
9 parport.h
12 syscalls.h
13 param.h
14 seccomp.h
15 export.h
16 dma-contiguous.h
16 flat.h
16 msi.h
17 qrwlock.h
18 gpio.h
18 qspinlock.h
20 early_ioremap.h
20 set_memory.h
20 simd.h
20 vmlinux.lds.h
21 vtime.h
22 iomap.h
23 qrwlock_types.h
23 qspinlock_types.h
24 bpf_perf_event.h

      Arnd
