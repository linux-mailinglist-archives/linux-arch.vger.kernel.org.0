Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43685743A9B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 13:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjF3LQS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 07:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjF3LQR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 07:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C610B;
        Fri, 30 Jun 2023 04:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD1DB61721;
        Fri, 30 Jun 2023 11:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D38CC433B6;
        Fri, 30 Jun 2023 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688123775;
        bh=Qg6mtJKrAYAKJ/g+ZZims8G6rMhWUl/iHHzBDRbgkt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FAt/tTKQD2GJsTXXg46D0dmIOpXB7x8kqbM9hJKn6kR3dWvDwvb1piYc0BJDmWRM7
         CJ5AnqZSgnE3r8jXkawG7AlPkd70Pxa8eStDuoq8haB+WZIogBI8fk8hjHeCGLrdKQ
         /ja/9udU6YLY8jqGJfbBUn6PHCSmKdiP4I5bE6vVrA2tIw+MPtm2Mmg610+bLdj01a
         8MHmsGuFDLMg+pDfxWVJ8dG2+7ES27HIqTaUWzI1EEV3iY3PX/jaX5eqBZpfS6wnzI
         Gaw6Sv5LliIFsCQ/Ei+/KtrPL0VNPGZx+klbvhVVyBH24/3xceTHmlfosoBbQK3Yn1
         RQfTQ8BY1j4wg==
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so12348455e9.1;
        Fri, 30 Jun 2023 04:16:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDzAXtxfBeZJNeKCWvEW9wy3Ok1CpFLRFx4+P81vgYtUnFC/ifRg
        k3lCfohQfLbW9Mr+/DB8ONzlnZBkU917vSjmt1k=
X-Google-Smtp-Source: ACHHUZ40bhVMwu6PtmLXC7PKR9i31qcI1Ik0b5RtktK7GbB/gRM2EyRl/TpExinoDJ8sTXblct7BlMBvZcymTfy6wuI=
X-Received: by 2002:a05:600c:21c5:b0:3f9:c0f8:de72 with SMTP id
 x5-20020a05600c21c500b003f9c0f8de72mr1790329wmj.7.1688123773271; Fri, 30 Jun
 2023 04:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm>
In-Reply-To: <ZJ2PBosSQtSX28Mf@wychelm>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 30 Jun 2023 07:16:01 -0400
X-Gmail-Original-Message-ID: <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
Message-ID: <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 10:02=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
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
> Apologies for the late feedback but I've been swamped lately and only
> recently got round to running the full kgdb test suite on the v6.4
> series.
>
> The kgdb test suite includes a couple of tests that verify that the
> system resumes after breakpointing due to a BUG():
> https://github.com/daniel-thompson/kgdbtest/blob/master/tests/test_kdb_fa=
ult_injection.py#L24-L45
>
> These tests have regressed on riscv between v6.3 and v6.4 and a bisect
> is pointing at this patch. With these changes in place then, after kdb
> resumes the system, the BUG() message is printed as normal but then
> immediately fails. From the backtrace it looks like the new entry/exit
> code cannot advance past a compiled breakpoint instruction:
> ~~~
> PANIC: Fatal exception in interrupt
It comes from:
void die(struct pt_regs *regs, ...
{
...
if (in_interrupt())
        panic("Fatal exception in interrupt");
...

We could add a dump_backtrace to see what happened:
if (in_interrupt()) {
+      dump_backtrace(regs, NULL, KERN_DEFAULT);
        panic("Fatal exception in interrupt");
}



>
> Entering kdb (current=3D0xff60000001a2a280, pid 104) on processor 1 due t=
o
> NonMask
> able Interrupt @ 0xffffffff800bb3c4
> [1]kdb> bt
> Stack traceback for pid 104
> 0xff60000001a2a280      104       92  1    1   R  0xff60000001a2ac50
> *echo
> CPU: 1 PID: 104 Comm: echo Tainted: G      D
> 6.3.0-rc1-00003-gf0bddf50586d #119
> Hardware name: riscv-virtio,qemu (DT)
> Call Trace:
> [<ffffffff800050dc>] dump_backtrace+0x1c/0x24
> [<ffffffff808458f8>] show_stack+0x2c/0x38
> [<ffffffff80851b00>] dump_stack_lvl+0x3c/0x54
> [<ffffffff80851b2c>] dump_stack+0x14/0x1c
> [<ffffffff800bc4b8>] kdb_dump_stack_on_cpu+0x64/0x66
> [<ffffffff800c3d2a>] kdb_show_stack+0x82/0x88
> [<ffffffff800c3dc0>] kdb_bt1+0x90/0xf2
> [<ffffffff800c4206>] kdb_bt+0x34c/0x384
> [<ffffffff800c1d28>] kdb_parse+0x27a/0x618
> [<ffffffff800c2566>] kdb_main_loop+0x3b2/0x8fa
> [<ffffffff800c4c5a>] kdb_stub+0x1ba/0x3a8
> [<ffffffff800bbba8>] kgdb_cpu_enter+0x342/0x5ba
> [<ffffffff800bc3da>] kgdb_handle_exception+0xe0/0x11a
> [<ffffffff8000810c>] kgdb_riscv_notify+0x86/0xb4
> [<ffffffff8002f210>] notify_die+0x6a/0xa6
> [<ffffffff80004db0>] handle_break+0x70/0xe0
> [<ffffffff80852462>] do_trap_break+0x48/0x5c
> [<ffffffff80003598>] ret_from_exception+0x0/0x64
> [<ffffffff800bb3c4>] kgdb_compiled_break+0x0/0x14
> ~~~
>
>
> Daniel.



--=20
Best Regards
 Guo Ren
