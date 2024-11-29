Return-Path: <linux-arch+bounces-9185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2489DBECF
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 03:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363FD281A2E
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 02:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83814F9F3;
	Fri, 29 Nov 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtmXh4ZE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20821386DA;
	Fri, 29 Nov 2024 02:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732849145; cv=none; b=jPnG2PjIrB3RrcTBM9dvo9qpan+LAx6BNNSkZB2isojdSCNSmGrx234BdkKOS9EQU+bX4SdzVM+tf0+4Tsn2qI6hj/FHlAviwbSD5v28lLazpwscs600pOiiJqo/eR/3t6ygLNAE3m51zgP8fllyefFX0VAXEgXid9TOZZzc0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732849145; c=relaxed/simple;
	bh=7lawv7c93Ol7bC0uQMx7VkSwmiXWsn3NufyEJ2i4Osc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqSazqcoXtSJBXIXQnRPpkuT2nN57ZzyX7khrmUSX50lCTtu3GzOsK6bvp8IxfV64O2OnMIfXdDpAtv47q4lgsT1VSzZGdy/KzfiP7sgoCma7wIdwkRnQE05plsQn7F2G6QF0b2PJEBQTM5zHJvm/ODIpZrVFCG179VsU5sAZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtmXh4ZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDA4C4CEDA;
	Fri, 29 Nov 2024 02:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732849145;
	bh=7lawv7c93Ol7bC0uQMx7VkSwmiXWsn3NufyEJ2i4Osc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QtmXh4ZERNLb6OPcYstFEG8tBw26vHjAhoFHmc0TzfMaqbJV/2j8pLHHoXuCbgSVD
	 1tLQf1ENdZ31gloI2qXj2KmcV/93GH9RT5TBT05TxNHspZDBSkTa8l8Rfjc5LG6S7I
	 2PKN3VNuw1yG7EUIAz0VcXzlZCvSXUOkLAHtHisBgOP0xH2DD88ugHrmP6MUfMv89G
	 CWJNT2Rih3Ll542SyDcAV/Ln3qFHAnH2akt/Yqz4/Ha42r6mVwvfWj/fiB5E88eY+i
	 z6nwX1cfdt1Y03gSh8TTrBc+tAxvtZy+6TYXSradBrXszXbM+F+LXH/Ov3bacn2L1U
	 dlme0SCcyJJug==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa55da18f89so197235366b.0;
        Thu, 28 Nov 2024 18:59:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrUnSYlUZo3ev3L+LVk99JYIJDJSDj7PbUhoU3SzTR2hRAcADep1bmsZIMubcGAcROsgGfiicNTJH+@vger.kernel.org, AJvYcCV4ieIr8Of1Z+/VWiK4Vs3WoJR9XPaTDabSfSzFgAxMj+VUN+xd3QxsgD8VSCNJtwQsvZV/w75Jn9u/@vger.kernel.org, AJvYcCWxIvL2ssZ46b5SEhnaIJkjPsRfRbfaBunqW+25zHAuJguZxCSs7CFgjxSlUiolLq2rqiqXIVsDMnrVNw==@vger.kernel.org, AJvYcCXGUuX5qadzGOg2shUJnga418iYsIVzqLpSVoamB5Yg14PYNxv0o8DIBPoucq8khFELFJf5LYX8U0C2+0oC@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/bQ3q1YLw5TGwOiOv4vNJ1U8gAz/gAhO4GuJRINRD2RvLwBj
	iGEEv2wt+1s40dHkeKmSst0nwHAqtx9SSayddbfuF6+QEFZJP1Y7grKzoiF1dGerLFO82k7nn8Q
	9Q84YUkyp/flGmlADBLluNf1E16g=
X-Google-Smtp-Source: AGHT+IGXsWIz6S7Gj9hihXsycLLkKYBZfM/UOHTMWk0SKqAkGs9hEWvOWwJ4jUCAj8QeutXTl4Ighsgfm18qf4wpZQ8=
X-Received: by 2002:a17:907:7711:b0:aa5:2ec5:369b with SMTP id
 a640c23a62f3a-aa580f0f12fmr777882366b.17.1732849143643; Thu, 28 Nov 2024
 18:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com> <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck> <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr> <20241128-goggles-laundry-d94c23ab39a4@spud>
 <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
In-Reply-To: <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 29 Nov 2024 10:58:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
Message-ID: <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
To: Conor Dooley <conor@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor.dooley@microchip.com>, 
	Will Deacon <will@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 8:55=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Nov 29, 2024 at 12:19=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Nov 28, 2024 at 03:50:09PM +0100, Alexandre Ghiti wrote:
> > > On 28/11/2024 15:14, Conor Dooley wrote:
> > > > On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> > > > > On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> > > > > > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote=
:
> > > > > > > In order to produce a generic kernel, a user can select
> > > > > > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the =
ticket
> > > > > > > spinlock implementation if Zabha or Ziccrse are not present.
> > > > > > >
> > > > > > > Note that we can't use alternatives here because the discover=
y of
> > > > > > > extensions is done too late and we need to start with the qsp=
inlock
> > > > > > > implementation because the ticket spinlock implementation wou=
ld pollute
> > > > > > > the spinlock value, so let's use static keys.
> > > > > > >
> > > > > > > This is largely based on Guo's work and Leonardo reviews at [=
1].
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778=
638-1-guoren@kernel.org/ [1]
> > > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > This patch (now commit ab83647fadae2 ("riscv: Add qspinlock sup=
port"))
> > > > > > breaks boot on polarfire soc. It dies before outputting anythin=
g to the
> > > > > > console. My .config has:
> > > > > >
> > > > > > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > > > > > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > > > > > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
> > > > > I pointed out some of the fragility during review:
> > > > >
> > > > > https://lore.kernel.org/all/20241111164259.GA20042@willie-the-tru=
ck/
> > > > >
> > > > > so I'm kinda surprised it got merged tbh :/
> > > > Maybe it could be reverted rather than having a broken boot with th=
e
> > > > default settings in -rc1.
> > >
> > >
> > > No need to rush before we know what's happening,I guess you bisected =
to this
> > > commit right?
> >
> > The symptom is a failure to boot, without any console output, of course
> > I bisected it before blaming something specific. But I don't think it i=
s
> > "rushing" as having -rc1 broken with an option's default is a massive p=
ain
> > in the arse when it comes to testing.
> >
> > > I don't have this soc, so can you provide $stval/$sepc/$scause, a con=
fig, a
> > > kernel, anything?
> >
> > I don't have the former cos it died immediately on boot. config is
> > attached. It reproduces in QEMU so you don't need any hardware.
> If QEMU could reproduce, could you provide a dmesg by the below method?
>
> Qemu cmd append: -s -S
> ref: https://qemu-project.gitlab.io/qemu/system/gdb.html
>
> Connect gdb and in console:
> 1. file vmlinux
> 2. source ./Documentation/admin-guide/kdump/gdbmacros.txt
> 3. dmesg
>
> Then, we could get the kernel's early boot logs from memory.
I've reproduced it on qemu, thx for the config.

Reading symbols from ../build-rv64lp64/vmlinux...
(gdb) tar rem:1234
Remote debugging using :1234
ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.h:49
49              atomic_cond_read_acquire(&lock->val, ticket =3D=3D (u16)VAL=
);
(gdb) bt
#0  ticket_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/include/asm-generic/ticket_spinlock.h:49
#1  arch_spin_lock (lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/arch/riscv/include/asm/spinlock.h:28
#2  do_raw_spin_lock (lock=3Dlock@entry=3D0xffffffff81b9a5b8 <text_mutex>)
at /home/guoren/source/kernel/linux/kernel/locking/spinlock_debug.c:116
#3  0xffffffff80b2ea0e in __raw_spin_lock_irqsave
(lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/include/linux/spinlock_api_smp.h:111
#4  _raw_spin_lock_irqsave (lock=3Dlock@entry=3D0xffffffff81b9a5b8
<text_mutex>) at
/home/guoren/source/kernel/linux/kernel/locking/spinlock.c:162
#5  0xffffffff80b27c54 in rt_mutex_slowtrylock
(lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1393
#6  0xffffffff80b295ea in rt_mutex_try_acquire
(lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:319
#7  __rt_mutex_lock (state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/kernel/locking/rtmutex.c:1805
#8  __mutex_lock_common (ip=3D18446744071562135170, nest_lock=3D0x0,
subclass=3D0, state=3D2, lock=3D0xffffffff81b9a5b8 <text_mutex>) at
/home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:518
#9  mutex_lock_nested (lock=3D0xffffffff81b9a5b8 <text_mutex>,
subclass=3Dsubclass@entry=3D0) at
/home/guoren/source/kernel/linux/kernel/locking/rtmutex_api.c:529
#10 0xffffffff80010682 in arch_jump_label_transform_queue
(entry=3Dentry@entry=3D0xffffffff8158da28, type=3D<optimized out>) at
/home/guoren/source/kernel/linux/arch/riscv/kernel/jump_label.c:39
#11 0xffffffff801d86b2 in __jump_label_update
(key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>,
entry=3D0xffffffff8158da28, stop=3Dstop@entry=3D0xffffffff815a5e68
<__tracepoint_ptr_initcall_finish>, init=3Dinit@entry=3Dtrue)
    at /home/guoren/source/kernel/linux/kernel/jump_label.c:513
#12 0xffffffff801d890c in jump_label_update
(key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
/home/guoren/source/kernel/linux/kernel/jump_label.c:920
#13 0xffffffff801d8be8 in static_key_disable_cpuslocked
(key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
/home/guoren/source/kernel/linux/kernel/jump_label.c:240
#14 0xffffffff801d8c04 in static_key_disable
(key=3Dkey@entry=3D0xffffffff81a1abb0 <qspinlock_key>) at
/home/guoren/source/kernel/linux/kernel/jump_label.c:248
#15 0xffffffff80c04a1a in riscv_spinlock_init () at
/home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:271
#16 setup_arch (cmdline_p=3Dcmdline_p@entry=3D0xffffffff81a03e88) at
/home/guoren/source/kernel/linux/arch/riscv/kernel/setup.c:336
#17 0xffffffff80c007a2 in start_kernel () at
/home/guoren/source/kernel/linux/init/main.c:922
#18 0xffffffff80001164 in _start_kernel ()
Backtrace stopped: frame did not save the PC
(gdb) p /x lock
$1 =3D 0xffffffff81b9a5b8
(gdb) p /x *lock
$2 =3D {{val =3D {counter =3D 0x20000}, {locked =3D 0x0, pending =3D 0x0},
{locked_pending =3D 0x0, tail =3D 0x2}}}

>
> >
> > > Does the polarfire soc provide Ziccrse?
> >
> > I don't think that is relevant because ziccrse is not listed in the dts=
,
> > so the kernel should not be assuming that LR/SC has a forward progress
> > guarantee. It's not even getting as far as riscv_spinlock_init() given
> > several things before that should be emitting logs, so it doesn't even
> > get to make any decisions about Ziccrse.
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren

