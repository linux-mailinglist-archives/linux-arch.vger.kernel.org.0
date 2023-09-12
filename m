Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D752B79C1ED
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 03:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbjILBtG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 21:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjILBs4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 21:48:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C85118D55;
        Mon, 11 Sep 2023 18:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F34C4AF5E;
        Tue, 12 Sep 2023 01:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694480928;
        bh=vPBtjeXZPsX8uMaq9qwgKEv+1PCvHrRzIWtKBohUeVk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HV8j/1foh3iKGbddE+oh/8T8Agp46qlTjejJvqAwChtOJSpPVYuFV1tIAkYIVaYUA
         K4VgsVQPAVuVrQbVcVH0V0nHGhHHEHid4URTR6QIroK4Grv/vZ3pi7ECsy6miD5o/j
         67sMuCUxb2Zj6K4VKYIMQXxexoSR0LRCxxDoEDxhCJOVeTweA+gdxTzNDod00CWWOi
         fBS6cM+HGI6TlOc4N6MApsSoe0nAFK8q1+YyipDrraZ/SR3gNGsEB606x9Vx7qtFTt
         mli0gr9Qci1MvwbF16IdaiVBymPD9QKkT/GPPmJQgALVyypYaYclHn98c9EOYuk9mM
         h7+2P4jrntJ+A==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9a63b2793ecso642675666b.2;
        Mon, 11 Sep 2023 18:08:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNCNkkpjG4zyh+kmHBF/KBMGWei3dvMJlwWg1GJMMCg1fmYCSR
        tMv2AY+vYIBHT4VwNY6iHf3IoH86pXOKBUTXz7E=
X-Google-Smtp-Source: AGHT+IGzCHN4mbb9AV6M5P3xYllprNXyZ+f6yZI8Aqw1YDdEyhI15mU09G08slBaULRW+BgPstHqnFZshoO7b1fogcM=
X-Received: by 2002:a17:907:2c77:b0:9a2:185b:5376 with SMTP id
 ib23-20020a1709072c7700b009a2185b5376mr8328061ejc.49.1694480926903; Mon, 11
 Sep 2023 18:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-8-guoren@kernel.org>
 <5ba0b8f3-f8f5-3a25-e9b7-f29a1abe654a@redhat.com>
In-Reply-To: <5ba0b8f3-f8f5-3a25-e9b7-f29a1abe654a@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 09:08:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
Message-ID: <CAJF2gTT2hRxgnQt+WJ9P0YBWnUaZJ1-9g3ZE9tOz_MiLSsUjwQ@mail.gmail.com>
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

On Mon, Sep 11, 2023 at 11:34=E2=80=AFPM Waiman Long <longman@redhat.com> w=
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
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index a447cf360a18..0f084f037651 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -270,6 +270,15 @@ static void __init parse_dtb(void)
> >   }
> >
> >   #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > +bool enable_qspinlock_key =3D false;
>
> You can use __ro_after_init qualifier for enable_qspinlock_key. BTW,
> this is not a static key, just a simple flag. So what is the point of
> the _key suffix?
Okay, I would change it to:
bool enable_qspinlock_flag __ro_after_init =3D false;

>
> Cheers,
> Longman
>


--=20
Best Regards
 Guo Ren
