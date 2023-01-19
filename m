Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A7673157
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 06:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjASFrN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 00:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjASFqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 00:46:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F00D7;
        Wed, 18 Jan 2023 21:46:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA0F61B80;
        Thu, 19 Jan 2023 05:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A02C433F2;
        Thu, 19 Jan 2023 05:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674107194;
        bh=PUo5jPPjJrkM2h7J25vyMD/6YvyXua6eq5cySfeUnL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9MU5Y5VA+Q7j9Bsqr41zeeMkXazs3w6TjEdm17vnSzmGII7qU6UIkQzWpKmeXomw
         fsNh0Pvkq1cMhKoSSrouRJmj0iqEHaCZQwj8DYc2RpmQ3pQAmAUbNoTRYR6o0BndTX
         Ms7eBXMjzyzk7g8GnJguA5tqklPd2/Dg4cE/k1Zijh+WB3+FxnCazG4D/nYrxmB3Xp
         HAxVoX0IkvT9soSbfQpnLz4AXV0UYqDIvBxcExRmNcRom8JlnCVS/FfEvLeQM2Lu7d
         RQO3cXxeBWgWiWbxTVqeqFLvzppzscGL4A9mSpYme76qW2P6Ct/PTFzsYKH0Gj1Ci7
         Sf0RMpeigvaIg==
Received: by mail-ej1-f49.google.com with SMTP id mp20so2849822ejc.7;
        Wed, 18 Jan 2023 21:46:34 -0800 (PST)
X-Gm-Message-State: AFqh2kpE0d1gC73/FRR2awnV2xJyCHFaam1G2JYNMKox/giy2snJdi0q
        l6DREI+xO+qDQKmkVQ+Vm85jWYHZ8bdfIIeMu2I=
X-Google-Smtp-Source: AMrXdXtTkjuLHW4UxR7ePpJ7YJ6QSALj/QyWmF+W0YzL6aodh8EK5LwiLXp4/6FXD/LPZuO++sEd9tICg/hWMKYDuoU=
X-Received: by 2002:a17:906:2b13:b0:84d:378a:6a83 with SMTP id
 a19-20020a1709062b1300b0084d378a6a83mr647668ejg.472.1674107192862; Wed, 18
 Jan 2023 21:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20230112095848.1464404-1-guoren@kernel.org> <20230112095848.1464404-5-guoren@kernel.org>
 <Y8EjAt3DC4WC062n@wendy>
In-Reply-To: <Y8EjAt3DC4WC062n@wendy>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 19 Jan 2023 13:46:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTXtkCnv4vHXS1H=L=gbbVd1wyijteq7WjgC4KiSPuHfw@mail.gmail.com>
Message-ID: <CAJF2gTTXtkCnv4vHXS1H=L=gbbVd1wyijteq7WjgC4KiSPuHfw@mail.gmail.com>
Subject: Re: [PATCH -next V14 4/7] riscv: entry: Convert to generic entry
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
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

Thx, I got that:

  LD      vmlinux
riscv64-unknown-linux-gnu-ld: arch/riscv/kernel/traps.o: in function
`do_trap_ecall_u':
/home/guoren/source/kernel/linux/arch/riscv/kernel/traps.c:245:
undefined reference to `handle_page_fault'
make[2]: *** [/home/guoren/source/kernel/linux/scripts/Makefile.vmlinux:34:
vmlinux] Error 1
make[1]: *** [/home/guoren/source/kernel/linux/Makefile:1252: vmlinux] Erro=
r 2
make[1]: Leaving directory '/home/guoren/source/kernel/build-nommu'
make: *** [Makefile:242: __sub-make] Error 2

Sorry.

And here is the fixup:

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0b764071de8c..69d619ddbcd5 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -268,6 +268,7 @@ asmlinkage __visible __trap_section void
do_trap_ecall_u(struct pt_regs *regs)

 }

+#ifdef CONFIG_MMU
 asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 {
        irqentry_state_t state =3D irqentry_enter(regs);
@@ -278,6 +279,7 @@ asmlinkage __visible noinstr void
do_page_fault(struct pt_regs *regs)

        irqentry_exit(regs, state);
 }
+#endif

 asmlinkage __visible noinstr void do_irq(struct pt_regs *regs)
 {

On Fri, Jan 13, 2023 at 5:23 PM Conor Dooley <conor.dooley@microchip.com> w=
rote:
>
> Hey Guo Ren,
>
> On Thu, Jan 12, 2023 at 04:58:45AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch converts riscv to use the generic entry infrastructure from
> > kernel/entry/*. The generic entry makes maintainers' work easier and
> > codes more elegant. Here are the changes:
> >
> >  - More clear entry.S with handle_exception and ret_from_exception
> >  - Get rid of complex custom signal implementation
> >  - Move syscall procedure from assembly to C, which is much more
> >    readable.
> >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> >  - Use the standard preemption code instead of custom
> >
> > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Ben Hutchings <ben@decadent.org.uk>
>
> Unfortunately from this patch onwards, the !MMU build is broken.
> Should be able to reproduce it with nommu_virt_defconfig.
>
> Thanks,
> Conor.
>


--=20
Best Regards
 Guo Ren
