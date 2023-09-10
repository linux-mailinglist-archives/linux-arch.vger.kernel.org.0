Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB886799D8D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Sep 2023 11:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjIJJtf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 Sep 2023 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJJte (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Sep 2023 05:49:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B31CC9;
        Sun, 10 Sep 2023 02:49:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FEAC433CD;
        Sun, 10 Sep 2023 09:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694339368;
        bh=FVbTyTYGkD/2rsb+c2iBU+8LpogWn5/bcs1vtUZzC7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tw6Ow9U9eAMf7zSrY4eHJYZFLjv/NM3x5a6xUPB6TMtCX5j2kABX+QWf5LeEe0K5c
         V396CGEwQpyEvtyhFLKzwgdgCHaDNPMGZ2LkqnHCaEdvfeWcBF3XueZ5KPmnGRFRGq
         SqW9U+CZGvlcQCAP/NV1WuGDnjrFcw0wlpSRFp2k2sQlYAlT2qAoCyvS6xjcxPw07D
         6XNuNWZkotT5oNEjHdrix6YUxqW/6hOlb4v4A7fvgCe6bnMYv17dFEi4UQm+EPMGW/
         haQJOOMNPP8QxBhc2c0yT2jO4cQrBvBRtYyts3LexZNDGZsBRYSLLbEoXrD+QeE0sR
         STdZBogqJkqGA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99bdcade7fbso425591566b.1;
        Sun, 10 Sep 2023 02:49:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzP3phoEOqw6bcpZcerEuZ9Y51cOqGJBInzZxVHSYeogMKvMPcQ
        1pPfgoqDm0WoExnNAzBJ2BfpJjeadOIVD6HJjvw=
X-Google-Smtp-Source: AGHT+IFebFcltTIfF/6OhHnfq0bf8TerZi1uxhJIuc+47iS1v4AmYwXI87kynct8S8UjRMHcgJiImK3yZpjbw08MGbc=
X-Received: by 2002:a17:906:10cf:b0:9a9:e41c:bcb3 with SMTP id
 v15-20020a17090610cf00b009a9e41cbcb3mr5498515ejv.59.1694339366810; Sun, 10
 Sep 2023 02:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910-esteemed-exodus-706aaae940b1@spud>
 <CAJF2gTRQd_dNuZHNwfg3SwD0XERaYXYUdFUFQiarym40kpxFRQ@mail.gmail.com> <20230910-baggage-accent-ec5331b58c8e@spud>
In-Reply-To: <20230910-baggage-accent-ec5331b58c8e@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 10 Sep 2023 17:49:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
Message-ID: <CAJF2gTS8Vh5XdMUcgLA_GJzW6Nm3JKHxuMN9jYSNe_YCEjgCXA@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 5:32=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Sep 10, 2023 at 05:16:46PM +0800, Guo Ren wrote:
> > On Sun, Sep 10, 2023 at 4:58=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
> > >
> > > > Changlog:
> > > > V11:
> > > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> > > >  - Remove abusing alternative framework and use jump_label instead.
> > >
> > > btw, I didn't say that using alternatives was the problem, it was
> > > abusing the errata framework to perform feature detection that I had
> > > a problem with. That's not changed in v11.
> > I've removed errata feature detection. The only related patches are:
> >  - riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> >  - riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> >
> > Which one is your concern? Could you reply on the exact patch thread? T=
hx.
>
> riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
>
> Please go back and re-read the comments I left on v11 about using the
> errata code for feature detection.
>
> > > A stronger forward progress guarantee is not an erratum, AFAICT.
>
> > Sorry, there is no erratum of "stronger forward progress guarantee" in =
the V11.
>
> "riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors" still
> uses the errata framework to detect the presence of the stronger forward
> progress guarantee in v11.
Oh, thx for pointing it out. I could replace it with this:

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 88690751f2ee..4be92766d3e3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -310,7 +310,8 @@ static void __init riscv_spinlock_init(void)
 {
 #ifdef CONFIG_RISCV_COMBO_SPINLOCKS
        if (!enable_qspinlock_key &&
-           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM)) {
+           (sbi_get_firmware_id() !=3D SBI_EXT_BASE_IMPL_ID_KVM) &&
+           (sbi_get_mvendorid() !=3D THEAD_VENDOR_ID)) {
                static_branch_disable(&combo_qspinlock_key);
                pr_info("Ticket spinlock: enabled\n");
        } else {

--=20
Best Regards
 Guo Ren
