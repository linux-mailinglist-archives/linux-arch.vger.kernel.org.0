Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF46B79C1F5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 03:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjILBtR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 21:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjILBs7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 21:48:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C8130FB8;
        Mon, 11 Sep 2023 18:22:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB896C4AF6B;
        Tue, 12 Sep 2023 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694480802;
        bh=l4+CNsWaJdhkXR0vkKkAiHJ2iQogyvfkUk7FzvHK3AU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rDRIA4d6KAD5REBFXHv8wxLdpkWXtR/ABreMbVOKR1Z842Q1IY2CrC1HXeIj0ZugJ
         EXDPGPvX9IibEzN74L3a7ldtnF3uqIFhLY7YoHImX5G41brZSb+8Ej/ioxIieDNPE7
         EOSb67RxTTZtlrcliGrquXC8rYsE5WpXHQev4fbvySjhS/6HhV5WZ/4mm+aJUgLxW3
         QXsM2P+8thLUgQT6KsFyjlf/KYxk4TUJYoBN4JMhyT9/CdlMi+EYcYEe0apCG2FJGs
         1kQYlRKXTPINHgKX2v2fYG7Fa+vLY2ZFsBH1NySCgMULXNb6V3rjSA3wobObxXvv4X
         meLNkytj/8PFw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52a5c0d949eso6377282a12.0;
        Mon, 11 Sep 2023 18:06:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx0a/UHX3JXqFSrobU/M6cB+j/o3+em6OPq0WuKg0ta0BHrQFBR
        BsYipR0Ew3KC6wklropm7zW8PBZRC2cQDQNJO4s=
X-Google-Smtp-Source: AGHT+IH4FhF/kTxPNgAVFbni63ODW/AwqSUOKFR7sTv2qzDRT5kLd8ExzVW67eg6HZD7guqGdyMOiuukWtzDSS5Upc0=
X-Received: by 2002:a17:907:2c67:b0:99d:e617:abeb with SMTP id
 ib7-20020a1709072c6700b0099de617abebmr8061187ejc.23.1694480801055; Mon, 11
 Sep 2023 18:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-8-guoren@kernel.org>
 <11f2a7a5-5219-a46e-5d16-4bdd400f5d9b@redhat.com>
In-Reply-To: <11f2a7a5-5219-a46e-5d16-4bdd400f5d9b@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 09:06:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTFhcwprGoBvrS7bw1pBUWSPPZxsujjpgheQ4L80wBnXg@mail.gmail.com>
Message-ID: <CAJF2gTTFhcwprGoBvrS7bw1pBUWSPPZxsujjpgheQ4L80wBnXg@mail.gmail.com>
Subject: Re: [PATCH V11 07/17] riscv: qspinlock: Introduce qspinlock param for
 command line
To:     Waiman Long <longman@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, boqun.feng@gmail.com, tglx@linutronix.de,
        paulmck@kernel.org, rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, conor.dooley@microchip.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 11:22=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
>
> On 9/10/23 04:29, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Allow cmdline to force the kernel to use queued_spinlock when
> > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt |  2 ++
> >   arch/riscv/kernel/setup.c                       | 16 +++++++++++++++-
> >   2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 7dfb540c4f6c..61cacb8dfd0e 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -4693,6 +4693,8 @@
> >                       [KNL] Number of legacy pty's. Overwrites compiled=
-in
> >                       default number.
> >
> > +     qspinlock       [RISCV] Force to use qspinlock or auto-detect spi=
nlock.
> > +
> >       qspinlock.numa_spinlock_threshold_ns=3D   [NUMA, PV_OPS]
> >                       Set the time threshold in nanoseconds for the
> >                       number of intra-node lock hand-offs before the
>
> Your patch series is still based on top of numa-aware qspinlock patchset
> which isn't upstream yet. Please rebase it without that as that will
> cause merge conflict during upstream merge.
Okay, thx for pointing it out.

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren
