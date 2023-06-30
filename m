Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8FF743DE8
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjF3OvL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 10:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjF3OvL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 10:51:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7499
        for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2023 07:51:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso22036925e9.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Jun 2023 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688136665; x=1690728665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BS2JmbhlyqV1OiBMiMoAD4fmogA6urExoXH6/e0E3h4=;
        b=r0DgVkeZAqiFtjYGYh+cknwVQBEtLfnC5sZNiOyABoThCH8ldigsmwYGel71TW6ayK
         U7XBpXuCupru6Uz5UShxj8RskB4XUfH3CKMP+c6gbzbivRgJHyaj/6a8FouKUfJJM0Fk
         RhscgVFoXjV1y9QrnD7dtyZFyjX6Eh5KV+W2Y8gO6v15FSMeYfYqA6hyd4aFGxsCRWDJ
         NaG+2oN75OrnmRipkSxaU04hLt4XzFmg8fkd7fx0T3zoHACv3yIJQHxTsiZ1zhrxH/03
         EKrsf2SywVav379o3ChacWdkvxNoN7OHo1V/Osw2igZpuBt8ghHZ/hIpks3cT50ZJsBv
         MEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136665; x=1690728665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BS2JmbhlyqV1OiBMiMoAD4fmogA6urExoXH6/e0E3h4=;
        b=LCOGb8Ilt8ub8FaCkbgTEAMk+m8O5OiI3tTjZmZeG6RNiNy/jPKR3T7mdOMKvgWByJ
         7XzmUqs4z5EhW/nMbb0xKuZqyt8kLQx/a7d8CUFWJ9/B9QR5GiEy2sebaHi4qTA/1RmS
         ZX9fJsKPdvPCESgCZq/HCgg0QzIlsmTOJ+J9JrKVVubNaXDmG84aQ0iaRUm8uWBrDtar
         M6BGh4cnB6ibyUvpvl+prMWPFUccM2BopLZxkbYrx8yIDODx6ly/jKySS2gAoVIZNgkE
         bJtcUh+CQq+it4+7jBKDABPkFwEnCtY2gciLrhuUuGu7DiXv2kKnKZ+otgJNrifALAa3
         Ib8A==
X-Gm-Message-State: ABy/qLYyYJE5cQikzn2M01DuVu/xh/5+O2129E3+zmQ6+wvTYiWBglJj
        d79WmYxLYC7/EU2t0x0mPGl1TDeIkj7R/KDIu4QecQ==
X-Google-Smtp-Source: APBJJlG2KkRBOgQGWJcnvkQGMMpO0goqwAJnB68ElefWSP7c7I5ZBP4Nhen9dPkukyNSN9SiT1GpMw==
X-Received: by 2002:a5d:46c5:0:b0:314:1c0d:8a55 with SMTP id g5-20020a5d46c5000000b003141c0d8a55mr2049864wrs.35.1688136664927;
        Fri, 30 Jun 2023 07:51:04 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b00313e90d1d0dsm16587678wrw.112.2023.06.30.07.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:51:04 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:50:56 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Message-ID: <20230630145056.GB2872423@aspen.lan>
References: <20230222033021.983168-1-guoren@kernel.org>
 <20230222033021.983168-5-guoren@kernel.org>
 <ZJ2PBosSQtSX28Mf@wychelm>
 <CAJF2gTRPYDxDpia=o6oqbt_8_5hqAQk-pwY1uPwUjcxCFg1EPw@mail.gmail.com>
 <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTRViivgy3njDc1k7A-jaSFUsyo2VPg2JwEAwx=H3mR4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 30, 2023 at 07:22:40AM -0400, Guo Ren wrote:
> On Fri, Jun 30, 2023 at 7:16 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Jun 29, 2023 at 10:02 AM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > >
> > > On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > This patch converts riscv to use the generic entry infrastructure from
> > > > kernel/entry/*. The generic entry makes maintainers' work easier and
> > > > codes more elegant. Here are the changes:
> > > >
> > > >  - More clear entry.S with handle_exception and ret_from_exception
> > > >  - Get rid of complex custom signal implementation
> > > >  - Move syscall procedure from assembly to C, which is much more
> > > >    readable.
> > > >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> > > >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> > > >  - Use the standard preemption code instead of custom
> > > >
> > > > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > > > Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> > > > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > > > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Ben Hutchings <ben@decadent.org.uk>
> > >
> > > Apologies for the late feedback but I've been swamped lately and only
> > > recently got round to running the full kgdb test suite on the v6.4
> > > series.
> > >
> > > The kgdb test suite includes a couple of tests that verify that the
> > > system resumes after breakpointing due to a BUG():
> > > https://github.com/daniel-thompson/kgdbtest/blob/master/tests/test_kdb_fault_injection.py#L24-L45
> > >
> > > These tests have regressed on riscv between v6.3 and v6.4 and a bisect
> > > is pointing at this patch. With these changes in place then, after kdb
> > > resumes the system, the BUG() message is printed as normal but then
> > > immediately fails. From the backtrace it looks like the new entry/exit
> > > code cannot advance past a compiled breakpoint instruction:
> > > ~~~
> > > PANIC: Fatal exception in interrupt
> > It comes from:
> > void die(struct pt_regs *regs, ...
> > {
> > ...
> > if (in_interrupt())
> >         panic("Fatal exception in interrupt");
> > ...
> >
> > We could add a dump_backtrace to see what happened:
> > if (in_interrupt()) {
> > +      dump_backtrace(regs, NULL, KERN_DEFAULT);
> Sorry, it should be:
> +        dump_backtrace(NULL, NULL, KERN_DEFAULT);
> We need current stack info, not exception context.

I added this... and I also stopped kgdb from intercepting the panic()
since that interferes with the console output from dump_backtrace().

~~~
# /bin/echo BUG > /sys/kernel/debug/provoke-crash/DIRECT
[    3.380565] lkdtm: Performing direct entry BUG

Entering kdb (current=0xff6000000380ab00, pid 98) on processor 0 due to NonMaskable Interrupt @ 0xffffffff8064b844
kdb> go
Catastrophic error detected
kdb_continue_catastrophic=0, type go a second time if you really want to continue
kdb> go
Catastrophic error detected
kdb_continue_catastrophic=0, attempting to continue
[    3.381411] ------------[ cut here ]------------
[    3.381454] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
[    3.381609] Kernel BUG [#1]
[    3.381632] Modules linked in:
[    3.381734] CPU: 0 PID: 98 Comm: echo Not tainted 6.4.0-rc6-00004-ge6e9d4598760-dirty #126
[    3.381817] Hardware name: riscv-virtio,qemu (DT)
[    3.381885] epc : lkdtm_BUG+0x6/0x8
[    3.381959]  ra : lkdtm_do_action+0x10/0x1c
[    3.381978] epc : ffffffff8064b844 ra : ffffffff8064afb4 sp : ff200000008c3d30
[    3.381991]  gp : ffffffff810665a0 tp : ff6000000380ab00 t0 : 6500000000000000
[    3.382002]  t1 : 0000000000000001 t2 : 6550203a6d74646b s0 : ff200000008c3d40
[    3.382012]  s1 : ff60000003988000 a0 : ffffffff80fc0260 a1 : ff6000003ffad788
[    3.382023]  a2 : ff6000003ffb9530 a3 : 0000000000000000 a4 : 0000000000000000
[    3.382034]  a5 : ffffffff8064b83e a6 : 0000000000000050 a7 : 0000000000040000
[    3.382045]  s2 : 0000000000000004 s3 : ffffffff80fc0260 s4 : ff200000008c3e70
[    3.382056]  s5 : ff600000033223a8 s6 : 00000000000f0cc0 s7 : ff60000002211000
[    3.382066]  s8 : 00ffffffafc50c08 s9 : 00ffffffafc4b9b8 s10: 0000000000000000
[    3.382077]  s11: 0000000000000001 t3 : 461f715700000000 t4 : 0000000000000002
[    3.382087]  t5 : 0000000000000000 t6 : ff200000008c3b58
[    3.382097] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    3.382139] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
[    3.382245] Code: 0513 9245 b097 0039 80e7 7f20 bf39 1141 e422 0800 (9002) 1141
[    3.594697] ---[ end trace 0000000000000000 ]---

At this point we expect a shell prompt since we should have taken the BUG(),
killed the echo process and returned to the shell. However in v6.4 we get the
following instead (including the instrumentation you asked for):

[    3.594801] [<ffffffff80005e3a>] dump_backtrace+0x1c/0x24
[    3.594826] [<ffffffff800059f0>] die+0x228/0x238
[    3.594835] [<ffffffff80005b38>] handle_break+0x9a/0xe0
[    3.594843] [<ffffffff809f30d6>] do_trap_break+0x48/0x5c
[    3.594854] [<ffffffff80003ee4>] ret_from_exception+0x0/0x64
[    3.594862] [<ffffffff8064b844>] lkdtm_BUG+0x6/0x8
[    3.594959] Kernel panic - not syncing: Fatal exception in interrupt
[    3.595005] SMP: stopping secondary CPUs
[    3.596444] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
~~~


Daniel.
