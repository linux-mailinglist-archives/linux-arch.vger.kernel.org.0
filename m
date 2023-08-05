Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96479770D08
	for <lists+linux-arch@lfdr.de>; Sat,  5 Aug 2023 03:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHEB3M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 21:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjHEB3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 21:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BB01BE;
        Fri,  4 Aug 2023 18:29:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7149262192;
        Sat,  5 Aug 2023 01:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD037C433B8;
        Sat,  5 Aug 2023 01:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691198949;
        bh=Mi9BT5TmTOYp8D5/MKk0K3shTEe8rrQtwxXzKpBvInE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jVmDVz058rynQRv460/5xFeOfHC4aWI/h8txqFcizdgYszSwCvnnyDiqUgw0yzcli
         2dmeTeKaW6hiHOf/ywoD/iJW9Y+CbTuAJNpkX0xlNydkzz7s/mTCiYP6ndon8iLLdk
         tcXRsidnwXgF93D1rElRoDwizOBmeII46BN/3Y0DDkDAropObo8eZwSW7C0mQe8gDm
         CV+elHGx6yl2lL8UB3/mmGqLBYZxf92dCp+2AoTItHbtrwUUDY2wpcW83HXMvn14eT
         DKFtKErPMc6TyH6uz2Q61GPoRshL8WBcCNe6xJJE8zeMvV4ZNjIi1c1nuOppiaMhwn
         fKmCmzZqfZ/NA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso4494137e87.1;
        Fri, 04 Aug 2023 18:29:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YwC34cECCaqzMUSR0pHWUsgTBgjutIM/YNjSBgV0wgib6Bvomcp
        hkXEoVFjpK7yMVFd3K5SeFjvrTlgGs3fKNRGmxM=
X-Google-Smtp-Source: AGHT+IE6p4g5OFR65noZcoL88XhtNiTB2Nk7TEaCjoT1P6yXSQxlui/aV3s41RxzO/5Ljhzc5/XXIOsdZMU8RdvdCAY=
X-Received: by 2002:a05:6512:398a:b0:4fe:db6:cb41 with SMTP id
 j10-20020a056512398a00b004fe0db6cb41mr3321948lfu.39.1691198947513; Fri, 04
 Aug 2023 18:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230802164701.192791-1-guoren@kernel.org> <20230802164701.192791-8-guoren@kernel.org>
 <20230804-refract-avalanche-9adb6b4b74e9@wendy> <CAJF2gTTfLmCe7eDhfPU1qFTBoVZN8oFACEd4NmTyZaAVtdMK-w@mail.gmail.com>
 <20230804-throwaway-requisite-c73ebe3fee8c@wendy>
In-Reply-To: <20230804-throwaway-requisite-c73ebe3fee8c@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 5 Aug 2023 09:28:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSvjbDF9D0wepAHo65zEkMfg2b+KhsVRpSEK+Qg-q=1gw@mail.gmail.com>
Message-ID: <CAJF2gTSvjbDF9D0wepAHo65zEkMfg2b+KhsVRpSEK+Qg-q=1gw@mail.gmail.com>
Subject: Re: [PATCH V10 07/19] riscv: qspinlock: errata: Introduce ERRATA_THEAD_QSPINLOCK
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        xiaoguang.xing@sophgo.com, bjorn@rivosinc.com,
        alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
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

On Fri, Aug 4, 2023 at 6:07=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Fri, Aug 04, 2023 at 05:53:35PM +0800, Guo Ren wrote:
> > On Fri, Aug 4, 2023 at 5:06=E2=80=AFPM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> > > On Wed, Aug 02, 2023 at 12:46:49PM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
>
> > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpu=
feature.c
> > > > index f8dbbe1bbd34..d9694fe40a9a 100644
> > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
> > > >                * spinlock value, the only way is to change from que=
ued_spinlock to
> > > >                * ticket_spinlock, but can not be vice.
> > > >                */
> > > > -             if (!force_qspinlock) {
> > > > +             if (!force_qspinlock &&
> > > > +                 !riscv_has_errata_thead_qspinlock()) {
> > > >                       set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->i=
sa);
> > >
> > > Is this a generic vendor extension (lol @ that misnomer) or is it an
> > > erratum? Make your mind up please. As has been said on other series, =
NAK
> > > to using march/vendor/imp IDs for feature probing.
> >
> > The RISCV_ISA_EXT_XTICKETLOCK is a feature extension number,
>
> No, that is not what "ISA_EXT" means, nor what the X in "XTICKETLOCK"
> would imply.
>
> The comment above these reads:
>   These macros represent the logical IDs of each multi-letter RISC-V ISA
>   extension and are used in the ISA bitmap.
>
> > and it's
> > set by default for forward-compatible. We also define a vendor
> > extension (riscv_has_errata_thead_qspinlock) to force all our
> > processors to use qspinlock; others still stay on ticket_lock.
>
> No, "riscv_has_errata_thead_qspinlock()" would be an _erratum_, not a
> vendor extension. We need to have a discussion about how to support
> non-standard extensions etc, not abuse errata. That discussion has been
> started on the v0.7.1 vector patches, but has not made progress yet.
You convinced me, yes, I abuse errata here. I would change to Linux
standard static_key mechanism next.

>
> > The only possible changing direction is from qspinlock to ticket_lock
> > because ticket_lock would dirty the lock value, which prevents
> > changing to qspinlock next. So startup with qspinlock and change to
> > ticket_lock before smp up. You also could use cmdline to try qspinlock
> > (force_qspinlock).
>
> I don't see what the relevance of this is, sorry. I am only commenting
> on how you are deciding that the hardware is capable of using qspinlocks,
> I don't intend getting into the detail unless the powers that be deem
> this series worthwhile, as I mentioned:
> > > I've got some thoughts on other parts of this series too, but I'm not
> > > going to spend time on it unless the locking people and Palmer ascent
> > > to this series.
>

--
Best Regards
 Guo Ren
