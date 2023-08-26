Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E07897AC
	for <lists+linux-arch@lfdr.de>; Sat, 26 Aug 2023 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjHZPQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Aug 2023 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHZPQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Aug 2023 11:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0E171A;
        Sat, 26 Aug 2023 08:16:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E459A61213;
        Sat, 26 Aug 2023 15:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58519C433C7;
        Sat, 26 Aug 2023 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693062977;
        bh=lg99Ln+jiL+l84WPJ8FkQG+sfsE/5LrVsAW7P4iMBe8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=prtV+8v+7Zd3FkFrrlVOPYXKS5GDghMejcHIwvE3SF3+gfQ7mHpRXDtbxDYrhREVo
         fJmjhjxTfU8nUTcTUH2RmuekJRRvUXzGU9FE0YSTo7N5TubM9qr7CcM5crKzhoHfXI
         bDqqwksK5lbWbBCK6o3mNvyTzejpVHu9zLJ3EhL8PRiei42gVhiLr5ARn1Hjg8FYJ6
         eKyVlTIJsbDH3H8KvvO89GcjNakMp3eDS8EhWbkR2Op8g/+exIjwZHQwrqvw16CDVV
         IDi9OjL+U8ZarDKiSj9QTvvQJ6M2wcAPKsftGTMe7EXbGs819C7bCBefTgPEWVdxfs
         RqP8wAUJsV7cw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bbbda48904so27489241fa.2;
        Sat, 26 Aug 2023 08:16:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQgGq36MjNZMLM3QafnsvTqDZBG/5wwdX3e5D+HUX1KIo2UZ50
        27XxWtnWbsNY9jrhSsTTvrZFbIlb+5e1ButaWHg=
X-Google-Smtp-Source: AGHT+IGPIKsysUpDMCEnjX/8/4Qbrqdo2/TpRFOIReMMxqMxVVBU9Sz5d0482DxrT8nOCs2FMb4flHIpcqvsziHFR6k=
X-Received: by 2002:a2e:b80d:0:b0:2bc:fd7b:8ded with SMTP id
 u13-20020a2eb80d000000b002bcfd7b8dedmr1455984ljo.20.1693062975325; Sat, 26
 Aug 2023 08:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230825114224.3886577-1-chenhuacai@loongson.cn> <0b509186-bf01-2151-0954-d669075c1f71@xen0n.name>
In-Reply-To: <0b509186-bf01-2151-0954-d669075c1f71@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 26 Aug 2023 23:16:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6ugTh8XmgruyWYoL53hYGtj3035xM=Y_+AMrnK-caM5w@mail.gmail.com>
Message-ID: <CAAhV-H6ugTh8XmgruyWYoL53hYGtj3035xM=Y_+AMrnK-caM5w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Ensure FP/SIMD registers in the core dump file
 is up to date
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 26, 2023 at 3:52=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 8/25/23 19:42, Huacai Chen wrote:
> > This is a port of commit 379eb01c21795edb4c ("riscv: Ensure the value
> > of FP registers in the core dump file is up to date").
> >
> > The values of FP/SIMD registers in the core dump file come from the
> > thread.fpu. However, kernel saves the FP/SIMD registers only before
> > scheduling out the process. If no process switch happens during the
> > exception handling, kernel will not have a chance to save the latest
> > values of FP/SIMD registers. So it may cause their values in the core
> > dump file incorrect. To solve this problem, force fpr_get()/simd_get()
> > to save the FP/SIMD registers into the thread.fpu if the target task
> > equals the current task.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/fpu.h | 22 ++++++++++++++++++----
> >   arch/loongarch/kernel/ptrace.c   |  4 ++++
> >   2 files changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/=
asm/fpu.h
> > index b541f6248837..08a45e9fd15c 100644
> > --- a/arch/loongarch/include/asm/fpu.h
> > +++ b/arch/loongarch/include/asm/fpu.h
> > @@ -173,16 +173,30 @@ static inline void restore_fp(struct task_struct =
*tsk)
> >               _restore_fp(&tsk->thread.fpu);
> >   }
> >
> > -static inline union fpureg *get_fpu_regs(struct task_struct *tsk)
> > +static inline void get_fpu_regs(struct task_struct *tsk)
> Removing the return value from the signature means the function is no
> longer a getter, so maybe the name should get changed as well? Like
> "save_fpu_regs"?
OK, that makes sense and has been done in V2.

> >   {
> > +     unsigned int euen;
> > +
> >       if (tsk =3D=3D current) {
> >               preempt_disable();
> > -             if (is_fpu_owner())
> > +
> > +             euen =3D csr_read32(LOONGARCH_CSR_EUEN);
> > +
> > +#ifdef CONFIG_CPU_HAS_LASX
> > +             if (euen & CSR_EUEN_LASXEN)
> > +                     _save_lasx(&current->thread.fpu);
> > +             else
> > +#endif
> > +#ifdef CONFIG_CPU_HAS_LSX
> > +             if (euen & CSR_EUEN_LSXEN)
> > +                     _save_lsx(&current->thread.fpu);
> > +             else
> > +#endif
> > +             if (euen & CSR_EUEN_FPEN)
> >                       _save_fp(&current->thread.fpu);
> > +
> >               preempt_enable();
> >       }
> > -
> > -     return tsk->thread.fpu.fpr;
> >   }
> >
> >   static inline int is_simd_owner(void)
> > diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptr=
ace.c
> > index 2bb5ec55ae1e..209e3d29e0b2 100644
> > --- a/arch/loongarch/kernel/ptrace.c
> > +++ b/arch/loongarch/kernel/ptrace.c
> > @@ -148,6 +148,8 @@ static int fpr_get(struct task_struct *target,
> >   {
> >       int r;
> >
> > +     get_fpu_regs(target);
> > +
> >       if (sizeof(target->thread.fpu.fpr[0]) =3D=3D sizeof(elf_fpreg_t))
> >               r =3D gfpr_get(target, &to);
> >       else
> > @@ -279,6 +281,8 @@ static int simd_get(struct task_struct *target,
> >   {
> >       const unsigned int wr_size =3D NUM_FPU_REGS * regset->size;
> >
> > +     get_fpu_regs(target);
> > +
> >       if (!tsk_used_math(target)) {
> >               /* The task hasn't used FP or LSX, fill with 0xff */
> >               copy_pad_fprs(target, regset, &to, 0);
>
> Otherwise this should be fine. (I don't know why that helper is
> previously unused though...)
This helper was derived from MIPS but the call sites are missing, so fix it=
 now.

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
