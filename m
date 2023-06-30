Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3E743AB9
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 13:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjF3LW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 07:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjF3LW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 07:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE80AC0;
        Fri, 30 Jun 2023 04:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AD8961727;
        Fri, 30 Jun 2023 11:22:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014F5C433B6;
        Fri, 30 Jun 2023 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688124174;
        bh=HIgffZnOosSIcjOP1dB+R/SNrBLEPOgvVYTtQ+OoMbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iC9Y0Eb2Z2MrXa6Y0C3L0itdnUhM4boFSN3EVF2hfwwESwXo2f0xnysTU4DH55i8q
         LPRCqB1weLDnb1l/6wVnR26XX6yvfBBjDiwiCnWAD+1Q8tj7lgbNPv9QNYG3oXhCYi
         jhoRAa0IscmrtkjZetLnY0SUfy6bT1P9ix6uoengTcF8SfJxq6sRNwBBw6YKmaHmat
         Hk+finD67UsNPxNmVWFr5EqEGCImxrkyJfW4S0fSJo6AEaxNGlsb1/ODu+nXFEyQHL
         DDaDryi0GmannFjCqZzQhFhLnJK/4U5QqwMzl9zCmtDH7+5Z/gF0qyEkmHLaUvG2DI
         YLz91LavDYzNw==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso21799755e9.0;
        Fri, 30 Jun 2023 04:22:53 -0700 (PDT)
X-Gm-Message-State: ABy/qLa7F0EXPppSbihLT1r4Fb/1QDkAsvTj4CwfD6AKtaGaYkAu9c7+
        kIs72V3WZCiDdGX4O+KdJrnpsWFdul48ZW66ehk=
X-Google-Smtp-Source: APBJJlEl3R3agomzm6d8TGvRI5Iv/j9uIUWV2C5RvtxdK+YCyx2E8/q4piZNcSGztOcV2x6OLVr/LPL52UVCqEccBUc=
X-Received: by 2002:a7b:c3c1:0:b0:3fb:c77e:80f6 with SMTP id
 t1-20020a7bc3c1000000b003fbc77e80f6mr1426408wmj.36.1688124172132; Fri, 30 Jun
 2023 04:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm> <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
In-Reply-To: <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 30 Jun 2023 07:22:40 -0400
X-Gmail-Original-Message-ID: <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
Message-ID: <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 30, 2023 at 7:16=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jun 29, 2023 at 10:02=E2=80=AFAM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > This patch converts riscv to use the generic entry infrastructure fro=
m
> > > kernel/entry/*. The generic entry makes maintainers' work easier and
> > > codes more elegant. Here are the changes:
> > >
> > >  - More clear entry.S with handle_exception and ret_from_exception
> > >  - Get rid of complex custom signal implementation
> > >  - Move syscall procedure from assembly to C, which is much more
> > >    readable.
> > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mod=
e
> > >  - Use the standard preemption code instead of custom
> > >
> > > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > > Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Ben Hutchings <ben@decadent.org.uk>
> >
> > Apologies for the late feedback but I've been swamped lately and only
> > recently got round to running the full kgdb test suite on the v6.4
> > series.
> >
> > The kgdb test suite includes a couple of tests that verify that the
> > system resumes after breakpointing due to a BUG():
> > https://github.com/daniel-thompson/kgdbtest/blob/master/tests/test_kdb_=
fault_injection.py#L24-L45
> >
> > These tests have regressed on riscv between v6.3 and v6.4 and a bisect
> > is pointing at this patch. With these changes in place then, after kdb
> > resumes the system, the BUG() message is printed as normal but then
> > immediately fails. From the backtrace it looks like the new entry/exit
> > code cannot advance past a compiled breakpoint instruction:
> > ~~~
> > PANIC: Fatal exception in interrupt
> It comes from:
> void die(struct pt_regs *regs, ...
> {
> ...
> if (in_interrupt())
>         panic("Fatal exception in interrupt");
> ...
>
> We could add a dump_backtrace to see what happened:
> if (in_interrupt()) {
> +      dump_backtrace(regs, NULL, KERN_DEFAULT);
Sorry, it should be:
+        dump_backtrace(NULL, NULL, KERN_DEFAULT);
We need current stack info, not exception context.


>         panic("Fatal exception in interrupt");
> }
>
>
>
> >
> > Entering kdb (current=3D0xff60000001a2a280, pid 104) on processor 1 due=
 to
> > NonMask
> > able Interrupt @ 0xffffffff800bb3c4
> > [1]kdb> bt
> > Stack traceback for pid 104
> > 0xff60000001a2a280      104       92  1    1   R  0xff60000001a2ac50
> > *echo
> > CPU: 1 PID: 104 Comm: echo Tainted: G      D
> > 6.3.0-rc1-00003-gf0bddf50586d #119
> > Hardware name: riscv-virtio,qemu (DT)
> > Call Trace:
> > [<ffffffff800050dc>] dump_backtrace+0x1c/0x24
> > [<ffffffff808458f8>] show_stack+0x2c/0x38
> > [<ffffffff80851b00>] dump_stack_lvl+0x3c/0x54
> > [<ffffffff80851b2c>] dump_stack+0x14/0x1c
> > [<ffffffff800bc4b8>] kdb_dump_stack_on_cpu+0x64/0x66
> > [<ffffffff800c3d2a>] kdb_show_stack+0x82/0x88
> > [<ffffffff800c3dc0>] kdb_bt1+0x90/0xf2
> > [<ffffffff800c4206>] kdb_bt+0x34c/0x384
> > [<ffffffff800c1d28>] kdb_parse+0x27a/0x618
> > [<ffffffff800c2566>] kdb_main_loop+0x3b2/0x8fa
> > [<ffffffff800c4c5a>] kdb_stub+0x1ba/0x3a8
> > [<ffffffff800bbba8>] kgdb_cpu_enter+0x342/0x5ba
> > [<ffffffff800bc3da>] kgdb_handle_exception+0xe0/0x11a
> > [<ffffffff8000810c>] kgdb_riscv_notify+0x86/0xb4
> > [<ffffffff8002f210>] notify_die+0x6a/0xa6
> > [<ffffffff80004db0>] handle_break+0x70/0xe0
> > [<ffffffff80852462>] do_trap_break+0x48/0x5c
> > [<ffffffff80003598>] ret_from_exception+0x0/0x64
> > [<ffffffff800bb3c4>] kgdb_compiled_break+0x0/0x14
> > ~~~
> >
> >
> > Daniel.
>
>
>
> --
> Best Regards
>  Guo Ren



--
Best Regards
 Guo Ren
