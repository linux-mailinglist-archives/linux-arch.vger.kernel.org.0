Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7157E9AAE0
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731252AbfHWI4m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 04:56:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44225 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbfHWI4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Aug 2019 04:56:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so10468890qtg.11;
        Fri, 23 Aug 2019 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTnwn95++Op3SfWaQCpErhny3AGKGOkNMopDRr3KEu0=;
        b=XGM9hG+O9FrtwGIUWPwCuNTLzgN5bUJNVOdp91Dv6P29Tf98HvbRWmcKJgXEV2Sltk
         a/FGMeI+jQm6Cnbljsb4PP7+Rps+vijt9Tl+Ok3H7Nx9hPDNqdeBNSNT9uGApXuKB77p
         znW6hCrBJaBUzMIyr7X5xCXO8zJPz7mf9NAsllLvQQJyWI8SLKyx8qo2EOi4S2KjifRA
         YNijyfUgRbsPX6iKiJtYYHGxQJ2WSTJgruCSddFw2ven0W06L34HaA6/YHUKDbjT3elK
         rtdipgAhPX6uK1bSEXs0Y8/KAFRGawESHEzu8GmwFTS39BbHuwHJ1xRa5G1CdI2CxYji
         vytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTnwn95++Op3SfWaQCpErhny3AGKGOkNMopDRr3KEu0=;
        b=BbZnykNjILalLM/ZoBKG9r+duO/lRSZ1kT1UXahAT8rHYBj+jFjymyYY5FqpWmJ9Mt
         BPNerFHPmlss5gOprNg8KbN+acAtTyZt2fUnCEpkwHBtRPYSxlZKY5LzSOoFQ8cSKEpo
         w4F0SkEz9OH7v4rJzsDH+UP6vQQiWlon2AvU57XwjLeV6Dul4dKg56mi0FcNzc2CbUMm
         uiw4z2jBO5wTge9+w/+PGWsA9IbDFNURIxd1M3Gh6VyMj3W5NemcUX8Wk6bqRUVjdl3A
         1/X/zQcj0Zz/DiEoiTEaE5bUZl69VSTVpSMikdcmNvPY28lWviMjxaDDKU2ZyEYUJkAo
         11iA==
X-Gm-Message-State: APjAAAWgjnMH2jrxJO2ebolVZwd0Ol4czvp3++qgkGH+jcScl0zm9I+x
        iY29h5OoO05L9D0kOIOQEIYtiB+DL1GEmpdQlGQ=
X-Google-Smtp-Source: APXvYqyL3NooS+2ggd9zdNLJemCTsHJDuV1xwpwNqzfrpaDL4nGuZMIk0c7+MO0U4L91B22FYl5jAdI4ch3Cf5er3Uk=
X-Received: by 2002:ac8:2d2c:: with SMTP id n41mr3667775qta.28.1566550600739;
 Fri, 23 Aug 2019 01:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566540652.git.han_mao@c-sky.com> <820d80272fc5627b8d00e684663a614470217606.1566540652.git.han_mao@c-sky.com>
In-Reply-To: <820d80272fc5627b8d00e684663a614470217606.1566540652.git.han_mao@c-sky.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 23 Aug 2019 16:56:04 +0800
Message-ID: <CAEbi=3fbe9zbsLyfA=s9gHtAFJrp5Ox0jWoAqcZudQ_xODicgA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] riscv: Add perf callchain support
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mao,

Mao Han <han_mao@c-sky.com> =E6=96=BC 2019=E5=B9=B48=E6=9C=8823=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=882:16=E5=AF=AB=E9=81=93=EF=BC=9A

>
> This patch add support for perf callchain sampling on riscv platform.
> The return address of leaf function is retrieved from pt_regs as
> it is not saved in the outmost frame.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Makefile                |   3 +
>  arch/riscv/kernel/Makefile         |   3 +-
>  arch/riscv/kernel/perf_callchain.c | 115 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 120 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_callchain.c

I just tested "./perf record -e cpu-clock --call-graph fp ls" on
Unleashed board and I got this failure.
I take a look at it. It seem failed in here. Do you have any idea?
It seems fine in Qemu.

1 *frame =3D *((struct stackframe *)frame->fp - 1);
ffffffe0001a198c: 00863a83 ld s5,8(a2)
ffffffe0001a1990: ff093903 ld s2,-16(s2)

./perf record -e cpu-clock --call-graph fp ls
[ 9619.423884] hrtimer: interrupt took 733000 ns
[ 9619.977017] Unable to handle kernel paging request at virtual
address ffffffffffffff94
[ 9620.214736] Oops [#1]
[ 9620.289893] Modules linked in:
[ 9620.391378] CPU: 0 PID: 264 Comm: ls Not tainted
5.3.0-rc5-00003-gb008f6bcd67c #4
[ 9620.640176] sepc: ffffffe0001a198c ra : ffffffe0001a199a sp :
ffffffe000093720
[ 9620.880366] gp : ffffffe00097dad8 tp : ffffffe000082e40 t0 : 00000000000=
46000
[ 9621.120564] t1 : 0000000000000002 t2 : 0000000000000007 s0 : ffffffe0000=
93760
[ 9621.360768] s1 : ffffffe000093788 a0 : 0000000000000003 a1 : 00000000000=
00000
[ 9621.600991] a2 : ffffffffffffff8c a3 : 0000000000001fa0 a4 : 00000000000=
00010
[ 9621.841181] a5 : 0000000000000002 a6 : 0000000000000001 a7 : ffffffe079b=
34e10
[ 9622.081400] s2 : ffffffffffffff9c s3 : ffffffe000000000 s4 : 00000000000=
01ff8
[ 9622.321618] s5 : ffffffe000093da0 s6 : ffffffe00097d540 s7 : ffffffe07a1=
517a0
[ 9622.561811] s8 : 000008bf01c7ff60 s9 : ffffffe000235b2a s10: 00000002000=
00120
[ 9622.802015] s11: 0000000000000001 t3 : ffffffe079b34e00 t4 : 00000000000=
00001
[ 9623.042194] t5 : 0000000000000008 t6 : ffffffe0009208d0
[ 9623.218785] sstatus: 0000000200000100 sbadaddr: ffffffffffffff94
scause: 000000000000000d
[ 9623.490850] ---[ end trace 49043f28e856d84d ]---
[ 9623.644217] Kernel panic - not syncing: Fatal exception in interrupt
[ 9623.855470] SMP: stopping secondary CPUs
[ 9623.985955] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---
