Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820F79C245
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 04:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbjILCIK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 22:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbjILCC6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 22:02:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F489303AB;
        Mon, 11 Sep 2023 18:34:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97150C116A5;
        Tue, 12 Sep 2023 01:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694482451;
        bh=hny5DKN7nnmKvKb+KypTMSMKYkZuAQjCXV58rWadSh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EnwrZ0pORbyPZa7JmqTgAS0cKxJLWQTUgkwwewaqdq6cj8vZjSFjcBQu/SUyCohiJ
         JeaI2N8X/TzAYu2qBzfzJKkD48dWBa1Ql9XnNMy4PagVQtswUDUli69UfDY+RD58Te
         m3MjiDynHMMoJ2oGsklnJgRfnsiNlM7CA66evTxxxBJlE9QwJLvzOmp1FqGeYp56s1
         L8mPgmGzsgk4NIaRXiRCo0lokkHJEtXRZnZitlusbk0h4Ix/DUc+DOZq47Gf727VHE
         0fZ6VYAndfIUq8cFuE0YghCE00JHvLqvDD6kwgljJxyaur4xPUKeTRAxAeYUuz0Kx9
         afOp3YCyAWNgg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-502153ae36cso8147089e87.3;
        Mon, 11 Sep 2023 18:34:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNj/U4ZQJESWEuUyy+4pLcP8e19vTEXl6hyaMuA3xfVA3xz1Je
        9JL8DIfaJrp4SyicfM4tkrX/k1WMZBcl7uZgCqE=
X-Google-Smtp-Source: AGHT+IEmU61GOGMCu0W//Xu8QTjfIgZ9mUeXY9BPbpPxM4T4RRtRdPOH27C8ssirhpnfS38Xp4cxFKSk0f4MPp6i4kw=
X-Received: by 2002:a05:6512:252c:b0:4ff:9efd:8a9e with SMTP id
 be44-20020a056512252c00b004ff9efd8a9emr10514533lfb.7.1694482449831; Mon, 11
 Sep 2023 18:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com>
 <20230910-baggage-accent-ec5331b58c8e@spud> <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
 <20230910-facsimile-answering-60d1452b8c10@spud> <CAJF2gTSP1rxVhuwOKyWiE2vFFijJFc2aKRU2=0rTK9nDc8AbsQ@mail.gmail.com>
 <20230911-nimbly-outcome-496efae7adc6@wendy>
In-Reply-To: <20230911-nimbly-outcome-496efae7adc6@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Sep 2023 09:33:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSDtnc7WRAZ0eLjiwZHZFbOcPZaQ_c8LiLcctBNsKCaA@mail.gmail.com>
Message-ID: <CAJF2gTTSDtnc7WRAZ0eLjiwZHZFbOcPZaQ_c8LiLcctBNsKCaA@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, paul.walmsley@sifive.com,
        anup@brainfault.org, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, palmer@rivosinc.com, longman@redhat.com,
        boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org,
        rostedt@goodmis.org, rdunlap@infradead.org,
        catalin.marinas@arm.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
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

On Mon, Sep 11, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Mon, Sep 11, 2023 at 11:36:27AM +0800, Guo Ren wrote:
> > On Mon, Sep 11, 2023 at 3:45=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sun, Sep 10, 2023 at 05:49:13PM +0800, Guo Ren wrote:
> > > > On Sun, Sep 10, 2023 at 5:32=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> > > > >
> > > > > On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> > > > > > On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > > >
> > > > > > > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org w=
rote:
> > > > > > >
> > > > > > > > Changlog:
> > > > > > > > V11:
> > > > > > > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > > > > > > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked pat=
ch v3.
> > > > > > > >  - Remove abusing alternative framework and use jump_label =
instead.
> > > > > > >
> > > > > > > btw, I didn't say that using alternatives was the problem, it=
 was
> > > > > > > abusing the errata framework to perform feature detection tha=
t I had
> > > > > > > a problem with. That's not changed in v11.
> > > > > > I've removed errata feature detection. The only related patches=
 are:
> > > > > >  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> > > > > >  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD proces=
sors
> > > > > >
> > > > > > Which one is your concern? Could you reply on the exact patch t=
hread? Thx.
> > > > >
> > > > > riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > > > >
> > > > > Please go back and re-read the comments I left on v11 about using=
 the
> > > > > errata code for feature detection.
> > > > >
> > > > > > > A stronger forward progress guarantee is not an erratum, AFAI=
CT.
> > > > >
> > > > > > Sorry, there is no erratum of "stronger forward progress guaran=
tee" in the V11.
> > > > >
> > > > > "riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors=
" still
> > > > > uses the errata framework to detect the presence of the stronger =
forward
> > > > > progress guarantee in v11.
> > > > Oh, thx for pointing it out. I could replace it with this:
> > > >
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index 88690751f2ee..4be92766d3e3 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -310,7 +310,8 @@ static void __init riscv_spinlock_init(void)
> > > >  {
> > > >  #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> > > >         if (!enable_qspinlock_key &&
> > > > -           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) =
{
> > > > +           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM) &=
&
> > > > +           (sbi_get_mvendorid() !=3D THEAD_VENDOR_ID)) {
> > > >                 static_branch_disable(&combo_qspinlock_key);
> > > >                 pr_info("Ticket spinlock: enabled\n");
> > > >         } else {
> > >
> > > As I said on v11, I am opposed to feature probing using mvendorid & C=
o,
> > > partially due to the exact sort of check here to see if the kernel is
> > > running as a KVM guest. IMO, whether a platform has this stronger
>
> > KVM can't use any fairness lock, so forcing it using a Test-Set lock
> > or paravirt qspinlock is the right way. KVM is not a vendor platform.
>
> My point is that KVM should be telling the guest what additional features
> it is capable of using, rather than the kernel making some assumptions
> based on$vendorid etc that are invalid when the kernel is running as a
> KVM guest.
> If the mvendorid etc related assumptions were dropped, the kernel would
> then default away from your qspinlock & there'd not be a need to
> special-case KVM AFAICT.
>
> > > guarantee needs to be communicated by firmware, using ACPI or DT.
> > > I made some comments on v11, referring similar discussion about the
> > > thead vector stuff. Please go take a look at that.
> > I prefer forcing T-HEAD processors using qspinlock, but if all people
> > thought it must be in the ACPI or DT, I would compromise. Then, I
> > would delete the qspinlock cmdline param patch and move it into DT.
> >
> > By the way, what's the kind of DT format? How about:
>
> I added the new "riscv,isa-extensions" property in part to make
> communicating vendor extensions like this easier. Please try to use
> that. "qspinlock" is software configuration though, the vendor extension
> should focus on the guarantee of strong forward progress, since that is
> the non-standard aspect of your IP.
The qspinlock contains three paths:
 - Native qspinlock, this is your strong forward progress.
 - virt_spin_lock, for KVM guest when paravirt qspinlock disabled.
   https://lore.kernel.org/linux-riscv/20230910082911.3378782-9-guoren@kern=
el.org/
 - paravirt qspinlock, for KVM guest

So, we need a software configuration here, "riscv,isa-extensions" is
all about vendor extension.

>
> A commandline property may still be desirable, to control the locking
> method used, since the DT should be a description of the hardware, not
> for configuring software policy in your operating system.
Okay, I would keep the cmdline property.

>
> Thanks,
> Conor.
>
> >         cpus {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> > +              qspinlock;
> >                 cpu0: cpu@0 {
> >                         compatible =3D "sifive,bullet0", "riscv";
> >                         device_type =3D "cpu";
> >                         i-cache-block-size =3D <64>;
> >                         i-cache-sets =3D <128>;
> >
> > --
> > Best Regards
> >  Guo Ren



--=20
Best Regards
 Guo Ren
