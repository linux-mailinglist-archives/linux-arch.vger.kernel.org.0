Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF1679A1E2
	for <lists+linux-arch@lfdr.de>; Mon, 11 Sep 2023 05:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjIKDgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 23:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjIKDgr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 23:36:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA411B;
        Sun, 10 Sep 2023 20:36:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212C2C433B7;
        Mon, 11 Sep 2023 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694403402;
        bh=weTZp8zL3bWb5z0GQP+eoq1kF+g4ZFnVOzhk58dn504=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XcQPuw6rt2SnGfuvugsIuIKJy5rB+AhY7hasYT4M+p4qvciFwGF2qmFcj64JP/Y1Z
         ydtRL4BCbu9ArpmsxMtgxDONtG41ULcTgFkPE/p+P+7tpxv7pkOFUCKELlTGBlserA
         Z7gcUJ3l8ZBC5ASAafNu1nAKgF06erI+8kwxtIWQ1kdATR+JJHks4UB0mKL5SxJLoR
         Wove4bdXZN3UcLUO/rD6dHpUhX/CuyZK1bFQvhFNPhhXC/xJRLbeNrvZc+8jBo62Z6
         sA6CP3USYT3s3lSAdIwx/LbK1WdzikTHcEE+3gp1Zxve3orNLFaakCohDCvqhwevac
         QU9TzwqT0JZhw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99c3c8adb27so493501866b.1;
        Sun, 10 Sep 2023 20:36:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTM7SY9rIDzThowoUW259tWlUEghv/BA1wAlj4Bko97plymc8x
        +jQ5z2g6tG+/Xfl1Q+oySe/eR/gtmj6dXj/S05o=
X-Google-Smtp-Source: AGHT+IFhNn3iSN5211iDeQune5ZsTnjOXUdLsXbdqVCgdz89o+T7M0sY5KDD0X1TlWnwIpUOOvy5g06IJUHz0bughjs=
X-Received: by 2002:a17:906:30da:b0:99d:fc31:242f with SMTP id
 b26-20020a17090630da00b0099dfc31242fmr6921871ejb.66.1694403400391; Sun, 10
 Sep 2023 20:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud> <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
 <20230910-facsimile-answering-60d1452b8c10@spud>
In-Reply-To: <20230910-facsimile-answering-60d1452b8c10@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 11 Sep 2023 11:36:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
Message-ID: <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To:     Conor Dooley <conor@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        leobras@redhat.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 11, 2023 at 3:45=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Sep 10, 2023 at 05:49:13PM +0800, Guo Ren wrote:
> > On Sun, Sep 10, 2023 at 5:32=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> > > > On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > > > >
> > > > > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote=
:
> > > > >
> > > > > > Changlog:
> > > > > > V11:
> > > > > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > > > > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v=
3.
> > > > > >  - Remove abusing alternative framework and use jump_label inst=
ead.
> > > > >
> > > > > btw, I didn't say that using alternatives was the problem, it was
> > > > > abusing the errata framework to perform feature detection that I =
had
> > > > > a problem with. That's not changed in v11.
> > > > I've removed errata feature detection. The only related patches are=
:
> > > >  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> > > >  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > > >
> > > > Which one is your concern? Could you reply on the exact patch threa=
d? Thx.
> > >
> > > riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > >
> > > Please go back and re-read the comments I left on v11 about using the
> > > errata code for feature detection.
> > >
> > > > > A stronger forward progress guarantee is not an erratum, AFAICT.
> > >
> > > > Sorry, there is no erratum of "stronger forward progress guarantee"=
 in the V11.
> > >
> > > "riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors" st=
ill
> > > uses the errata framework to detect the presence of the stronger forw=
ard
> > > progress guarantee in v11.
> > Oh, thx for pointing it out. I could replace it with this:
> >
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 88690751f2ee..4be92766d3e3 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -310,7 +310,8 @@ static void __init riscv_spinlock_init(void)
> >  {
> >  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> >         if (!enable_qspinlock_key &&
> > -           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) {
> > +           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM) &&
> > +           (sbi_get_mvendorid() !=3D THEAD_VENDOR_ID)) {
> >                 static_branch_disable(&combo_qspinlock_key);
> >                 pr_info("Ticket spinlock: enabled\n");
> >         } else {
>
> As I said on v11, I am opposed to feature probing using mvendorid & Co,
> partially due to the exact sort of check here to see if the kernel is
> running as a KVM guest. IMO, whether a platform has this stronger
KVM can't use any fairness lock, so forcing it using a Test-Set lock
or paravirt qspinlock is the right way. KVM is not a vendor platform.

> guarantee needs to be communicated by firmware, using ACPI or DT.
> I made some comments on v11, referring similar discussion about the
> thead vector stuff. Please go take a look at that.
I prefer forcing T-HEAD processors using qspinlock, but if all people
thought it must be in the ACPI or DT, I would compromise. Then, I
would delete the qspinlock cmdline param patch and move it into DT.

By the way, what's the kind of DT format? How about:
        cpus {
                #address-cells =3D <1>;
                #size-cells =3D <0>;
+              qspinlock;
                cpu0: cpu@0 {
                        compatible =3D "sifive,bullet0", "riscv";
                        device_type =3D "cpu";
                        i-cache-block-size =3D <64>;
                        i-cache-sets =3D <128>;

--
Best Regards
 Guo Ren
