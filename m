Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3076FDD7
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjHDJxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 05:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHDJxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 05:53:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B7E7E;
        Fri,  4 Aug 2023 02:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A22B61F81;
        Fri,  4 Aug 2023 09:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9649C433CD;
        Fri,  4 Aug 2023 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691142830;
        bh=lFjC4WLEGW/Lxj/DKzfS0u7bd1MtVnM5jRt8bx/kdNk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/VzISMGkKFqczwmYJ4NAmOw3dS0sIOEO0ctYzxw9EQ6Kko8QvOjgIE8opzZOBZbR
         cX4y+S/JUHzaynL1Q16fkyqqYCTZd9tDFAblMvFU+216yOBP/0Q2EK2PiwXYpse50c
         RoAlXihP8eWkF0xwhCdnXwZ/U28pTyDnwZ4rbTMKc9N5sPyhdHmYzBI9o1SqwXUdC7
         zAV0xUK9j42iWztIu+R3CEgGOCx3aCUZb+rPYJPRvV2QAyhjSvzwI72eO7DxWrMwJM
         kg5zYCCtKaBaaNLGGUIHq9Odtc/K+JgHJv8HRRvvnlgwQRO8p7NZ7DpqJcRfAqT4wD
         DFJg/1LqDbr7w==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso2429607a12.3;
        Fri, 04 Aug 2023 02:53:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxw9GsTbCcwsL/JIbzTX/5OmHop32o6xNdXeXHzBEEUB5WKiUXU
        w7M0KDSK22MbYQyBz5GIXY2gTPr8fWGXJ5LhtRk=
X-Google-Smtp-Source: AGHT+IF8AAzraBkBm5B+nYL1Q5LtSEgdlWGk+4YKUvg6xeg0Cs+wG7JxM0ZjqXkqLm7lj5kiuhRQcz1AnJfqJltrKHY=
X-Received: by 2002:aa7:dd14:0:b0:523:10c7:317c with SMTP id
 i20-20020aa7dd14000000b0052310c7317cmr1120233edv.41.1691142828721; Fri, 04
 Aug 2023 02:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230802164701.192791-1-guoren@kernel.org> <20230802164701.192791-8-guoren@kernel.org>
 <20230804-refract-avalanche-9adb6b4b74e9@wendy>
In-Reply-To: <20230804-refract-avalanche-9adb6b4b74e9@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 17:53:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTfLmCe7eDhfPU1qFTBoVZN8oFACEd4NmTyZaAVtdMK-w@mail.gmail.com>
Message-ID: <CAJF2gTTfLmCe7eDhfPU1qFTBoVZN8oFACEd4NmTyZaAVtdMK-w@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 4, 2023 at 5:06=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> Hey Guo Ren,
>
> On Wed, Aug 02, 2023 at 12:46:49PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > According to qspinlock requirements, RISC-V gives out a weak LR/SC
> > forward progress guarantee which does not satisfy qspinlock. But
> > many vendors could produce stronger forward guarantee LR/SC to
> > ensure the xchg_tail could be finished in time on any kind of
> > hart. T-HEAD is the vendor which implements strong forward
> > guarantee LR/SC instruction pairs, so enable qspinlock for T-HEAD
> > with errata help.
> >
> > T-HEAD early version of processors has the merge buffer delay
> > problem, so we need ERRATA_WRITEONCE to support qspinlock.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig.errata              | 13 +++++++++++++
> >  arch/riscv/errata/thead/errata.c       | 24 ++++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h   | 20 ++++++++++++++++++++
> >  arch/riscv/include/asm/vendorid_list.h |  3 ++-
> >  arch/riscv/kernel/cpufeature.c         |  3 ++-
> >  5 files changed, 61 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 4745a5c57e7c..eb43677b13cc 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -96,4 +96,17 @@ config ERRATA_THEAD_WRITE_ONCE
> >
> >         If you don't know what to do here, say "Y".
> >
> > +config ERRATA_THEAD_QSPINLOCK
> > +     bool "Apply T-Head queued spinlock errata"
> > +     depends on ERRATA_THEAD
> > +     default y
> > +     help
> > +       The T-HEAD C9xx processors implement strong fwd guarantee LR/SC=
 to
> > +       match the xchg_tail requirement of qspinlock.
> > +
> > +       This will apply the QSPINLOCK errata to handle the non-standard
> > +       behavior via using qspinlock instead of ticket_lock.
>
> Whatever about the acceptability of anything else in this series,
> having _stronger_ guarantees is not an erratum, is it? We should not
> abuse the errata stuff for this IMO.
>
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index f8dbbe1bbd34..d9694fe40a9a 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -342,7 +342,8 @@ void __init riscv_fill_hwcap(void)
> >                * spinlock value, the only way is to change from queued_=
spinlock to
> >                * ticket_spinlock, but can not be vice.
> >                */
> > -             if (!force_qspinlock) {
> > +             if (!force_qspinlock &&
> > +                 !riscv_has_errata_thead_qspinlock()) {
> >                       set_bit(RISCV_ISA_EXT_XTICKETLOCK, isainfo->isa);
>
> Is this a generic vendor extension (lol @ that misnomer) or is it an
> erratum? Make your mind up please. As has been said on other series, NAK
> to using march/vendor/imp IDs for feature probing.
The RISCV_ISA_EXT_XTICKETLOCK is a feature extension number, and it's
set by default for forward-compatible. We also define a vendor
extension (riscv_has_errata_thead_qspinlock) to force all our
processors to use qspinlock; others still stay on ticket_lock.

The only possible changing direction is from qspinlock to ticket_lock
because ticket_lock would dirty the lock value, which prevents
changing to qspinlock next. So startup with qspinlock and change to
ticket_lock before smp up. You also could use cmdline to try qspinlock
(force_qspinlock).

>
> I've got some thoughts on other parts of this series too, but I'm not
> going to spend time on it unless the locking people and Palmer ascent
> to this series.
>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
