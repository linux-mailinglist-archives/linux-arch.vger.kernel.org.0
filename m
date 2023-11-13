Return-Path: <linux-arch+bounces-209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE557E9A0F
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 11:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B03B280C8E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B061C6B3;
	Mon, 13 Nov 2023 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwQBMe9b"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097818645
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 10:19:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500BAD75
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 02:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699870757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNgc0nsmtJybyQg4c0uU1d4cY9GVSwWYNoMAmxmhuWY=;
	b=EwQBMe9bPyIXTur/xRB5kuWztk5ggmo7ijZvaghBUHINolpGCgUfXeTrIInzRH9Eq5q/GA
	SfAwo50octtMeVrPJHeTufZ9zz0nVjb/ciQPyELXEWkrGhrs6sXOfVnphp8hQDniZjujU8
	qD3lOXkg+p/gIa0qhY/dRQCh3RXnBNg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-XBVXPQ12Mp-CkzVQy0TipQ-1; Mon, 13 Nov 2023 05:19:16 -0500
X-MC-Unique: XBVXPQ12Mp-CkzVQy0TipQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41cdc2cc0b4so74745841cf.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 02:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699870755; x=1700475555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNgc0nsmtJybyQg4c0uU1d4cY9GVSwWYNoMAmxmhuWY=;
        b=R5YEZkPpXlOeELppPSA/Jsf1ja06BHf3233wEv+P2N9mbyXHaIiYVHgTuAx2J+O/0d
         vye1yAl2tabrRbm0K9RZfOvBc5RdlynYVp3WEZWx4H4GdXuRWAPfeoriJmVJDubW0G+1
         Bs7yyGrvD8Lb9MY/3SedpxlNfUBWx5Q6taZj7HCjVM1xjwyPC4/1gg66tDI3GMbLmF3I
         dv4y8b7t3hNgl4Zb/x9CTCtN9X2hPmP+UHweCBH6ygLuNsDBqcj5A1jBZygiKZzxAw4i
         Vi7dw6YtXpTwohuP87hx8RQ8WNV5Stwm1T55L3DC8T1zU7QnGtyATTRaq2uv34xR2ZFd
         oxCQ==
X-Gm-Message-State: AOJu0Yy0qJZuFJZgCkS7w29aFIETKURS38jEyo5MJD2rCn8Fja2uq24p
	b092b87kyLsy0Q2Wl5Dya6ttUjPSK9WN3HzpS95x+vZ1kwCX48FOafb+3FrK97cyTO24l4RXocs
	YoZFhRzMaQVQ9CD7LUsy3DrAmLuWiC0RbUZTF0w==
X-Received: by 2002:a05:622a:285:b0:410:9668:530a with SMTP id z5-20020a05622a028500b004109668530amr8724921qtw.21.1699870755452;
        Mon, 13 Nov 2023 02:19:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL7sVVCGiV4pXAxptHPh8ckOedsYDVGGDqgxsAA6O/8S6nCJJFCuquI5x232xm/lXJhy9Q2703pld34yoErrY=
X-Received: by 2002:a05:622a:285:b0:410:9668:530a with SMTP id
 z5-20020a05622a028500b004109668530amr8724897qtw.21.1699870755140; Mon, 13 Nov
 2023 02:19:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <ZUlPwQVG4OTkighB@redhat.com>
 <CAJF2gTSY5dO3iTxidiXSrAyWRRnjsW3WsFZASDpmw0P70rfVvA@mail.gmail.com>
In-Reply-To: <CAJF2gTSY5dO3iTxidiXSrAyWRRnjsW3WsFZASDpmw0P70rfVvA@mail.gmail.com>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Mon, 13 Nov 2023 07:19:01 -0300
Message-ID: <CAJ6HWG51S=W3cEm4TL2HKvpB3rfhv+u2u0ac9+aGcE+f-iW4iA@mail.gmail.com>
Subject: Re: [PATCH V11 00/17] riscv: Add Native/Paravirt qspinlock support
To: Guo Ren <guoren@kernel.org>
Cc: paul.walmsley@sifive.com, anup@brainfault.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, palmer@rivosinc.com, longman@redhat.com, 
	boqun.feng@gmail.com, tglx@linutronix.de, paulmck@kernel.org, 
	rostedt@goodmis.org, rdunlap@infradead.org, catalin.marinas@arm.com, 
	conor.dooley@microchip.com, xiaoguang.xing@sophgo.com, bjorn@rivosinc.com, 
	alexghiti@rivosinc.com, keescook@chromium.org, greentime.hu@sifive.com, 
	ajones@ventanamicro.com, jszhang@kernel.org, wefu@redhat.com, 
	wuwei2016@iscas.ac.cn, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 1:24=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Nov 6, 2023 at 3:42=E2=80=AFPM Leonardo Bras <leobras@redhat.com>=
 wrote:
> >
> > On Sun, Sep 10, 2023 at 04:28:54AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > patch[1 - 10]: Native   qspinlock
> > > patch[11 -17]: Paravirt qspinlock
> > >
> > > patch[4]: Add prefetchw in qspinlock's xchg_tail when cpus >=3D 16k
> > >
> > > This series based on:
> > >  - [RFC PATCH v5 0/5] Rework & improve riscv cmpxchg.h and atomic.h
> > >    https://lore.kernel.org/linux-riscv/20230810040349.92279-2-leobras=
@redhat.com/
> > >  - [PATCH V3] asm-generic: ticket-lock: Optimize arch_spin_value_unlo=
cked
> > >    https://lore.kernel.org/linux-riscv/20230908154339.3250567-1-guore=
n@kernel.org/
> > >
> > > I merge them into sg2042-master branch, then you could directly try i=
t on
> > > sg2042 hardware platform:
> > >
> > > https://github.com/guoren83/linux/tree/sg2042-master-qspinlock-64ilp3=
2_v5
> > >
> > > Use sophgo_mango_ubuntu_defconfig for sg2042 64/128 cores hardware
> > > platform.
> > >
> > > Native qspinlock
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > This time we've proved the qspinlock on th1520 [1] & sg2042 [2], whic=
h
> > > gives stability and performance improvement. All T-HEAD processors ha=
ve
> > > a strong LR/SC forward progress guarantee than the requirements of th=
e
> > > ISA, which could satisfy the xchg_tail of native_qspinlock. Now,
> > > qspinlock has been run with us for more than 1 year, and we have enou=
gh
> > > confidence to enable it for all the T-HEAD processors. Of causes, we
> > > found a livelock problem with the qspinlock lock torture test from th=
e
> > > CPU store merge buffer delay mechanism, which caused the queued spinl=
ock
> > > becomes a dead ring and RCU warning to come out. We introduce a custo=
m
> > > WRITE_ONCE to solve this. Do we need explicit ISA instruction to sign=
al
> > > it? Or let hardware handle this.
> > >
> > > We've tested the patch on SOPHGO sg2042 & th1520 and passed the stres=
s
> > > test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> > > comparison between qspinlock and ticket_lock on sg2042 (64 cores):
> > >
> > > sysbench test=3Dthreads threads=3D32 yields=3D100 lock=3D8 (+13.8%):
> > >   queued_spinlock 0.5109/0.00
> > >   ticket_spinlock 0.5814/0.00
> > >
> > > perf futex/hash (+6.7%):
> > >   queued_spinlock 1444393 operations/sec (+- 0.09%)
> > >   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> > >
> > > perf futex/wake-parallel (+8.6%):
> > >   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
> > >   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> > >
> > > perf futex/requeue (+4.2%):
> > >   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
> > >   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)
> > >
> > > System Benchmarks (+6.4%)
> > >   queued_spinlock:
> > >     System Benchmarks Index Values               BASELINE       RESUL=
T    INDEX
> > >     Dhrystone 2 using register variables         116700.0  628613745.=
4  53865.8
> > >     Double-Precision Whetstone                       55.0     182422.=
8  33167.8
> > >     Execl Throughput                                 43.0      13116.=
6   3050.4
> > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    7762306.=
2  19601.8
> > >     File Copy 256 bufsize 500 maxblocks            1655.0    3417556.=
8  20649.9
> > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7427995.=
7  12806.9
> > >     Pipe Throughput                               12440.0   23058600.=
5  18535.9
> > >     Pipe-based Context Switching                   4000.0    2835617.=
7   7089.0
> > >     Process Creation                                126.0      12537.=
3    995.0
> > >     Shell Scripts (1 concurrent)                     42.4      57057.=
4  13456.9
> > >     Shell Scripts (8 concurrent)                      6.0       7367.=
1  12278.5
> > >     System Call Overhead                          15000.0   33308301.=
3  22205.5
> > >                                                                      =
  =3D=3D=3D=3D=3D=3D=3D=3D
> > >     System Benchmarks Index Score                                    =
   12426.1
> > >
> > >   ticket_spinlock:
> > >     System Benchmarks Index Values               BASELINE       RESUL=
T    INDEX
> > >     Dhrystone 2 using register variables         116700.0  626541701.=
9  53688.2
> > >     Double-Precision Whetstone                       55.0     181921.=
0  33076.5
> > >     Execl Throughput                                 43.0      12625.=
1   2936.1
> > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    6553792.=
9  16550.0
> > >     File Copy 256 bufsize 500 maxblocks            1655.0    3189231.=
6  19270.3
> > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    7221277.=
0  12450.5
> > >     Pipe Throughput                               12440.0   20594018.=
7  16554.7
> > >     Pipe-based Context Switching                   4000.0    2571117.=
7   6427.8
> > >     Process Creation                                126.0      10798.=
4    857.0
> > >     Shell Scripts (1 concurrent)                     42.4      57227.=
5  13497.1
> > >     Shell Scripts (8 concurrent)                      6.0       7329.=
2  12215.3
> > >     System Call Overhead                          15000.0   30766778.=
4  20511.2
> > >                                                                      =
  =3D=3D=3D=3D=3D=3D=3D=3D
> > >     System Benchmarks Index Score                                    =
   11670.7
> > >
> > > The qspinlock has a significant improvement on SOPHGO SG2042 64
> > > cores platform than the ticket_lock.
> > >
> > > Paravirt qspinlock
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > We implemented kvm_kick_cpu/kvm_wait_cpu and add tracepoints to obser=
ve the
> > > behaviors. Also, introduce a new SBI extension SBI_EXT_PVLOCK (0xAB04=
01). If the
> > > name and number are approved, I will send a formal proposal to the SB=
I spec.
> > >
> >
> > Hello Guo Ren,
> >
> > Any update on this series?
> Found a nested virtualization problem, and I'm solving that. After
> that, I'll update v12.

Oh, nice to hear :)
I am very excited about this series, please let me know of any update.

Thanks!
Leo

>
> >
> > Thanks!
> > Leo
> >
> >
> > > Changlog:
> > > V11:
> > >  - Based on Leonardo Bras's cmpxchg_small patches v5.
> > >  - Based on Guo Ren's Optimize arch_spin_value_unlocked patch v3.
> > >  - Remove abusing alternative framework and use jump_label instead.
> > >  - Introduce prefetch.w to improve T-HEAD processors' LR/SC forward p=
rogress
> > >    guarantee.
> > >  - Optimize qspinlock xchg_tail when NR_CPUS >=3D 16K.
> > >
> > > V10:
> > > https://lore.kernel.org/linux-riscv/20230802164701.192791-1-guoren@ke=
rnel.org/
> > >  - Using an alternative framework instead of static_key_branch in the
> > >    asm/spinlock.h.
> > >  - Fixup store merge buffer problem, which causes qspinlock lock
> > >    torture test livelock.
> > >  - Add paravirt qspinlock support, include KVM backend
> > >  - Add Compact NUMA-awared qspinlock support
> > >
> > > V9:
> > > https://lore.kernel.org/linux-riscv/20220808071318.3335746-1-guoren@k=
ernel.org/
> > >  - Cleanup generic ticket-lock code, (Using smp_mb__after_spinlock as
> > >    RCsc)
> > >  - Add qspinlock and combo-lock for riscv
> > >  - Add qspinlock to openrisc
> > >  - Use generic header in csky
> > >  - Optimize cmpxchg & atomic code
> > >
> > > V8:
> > > https://lore.kernel.org/linux-riscv/20220724122517.1019187-1-guoren@k=
ernel.org/
> > >  - Coding convention ticket fixup
> > >  - Move combo spinlock into riscv and simply asm-generic/spinlock.h
> > >  - Fixup xchg16 with wrong return value
> > >  - Add csky qspinlock
> > >  - Add combo & qspinlock & ticket-lock comparison
> > >  - Clean up unnecessary riscv acquire and release definitions
> > >  - Enable ARCH_INLINE_READ*/WRITE*/SPIN* for riscv & csky
> > >
> > > V7:
> > > https://lore.kernel.org/linux-riscv/20220628081946.1999419-1-guoren@k=
ernel.org/
> > >  - Add combo spinlock (ticket & queued) support
> > >  - Rename ticket_spinlock.h
> > >  - Remove unnecessary atomic_read in ticket_spin_value_unlocked
> > >
> > > V6:
> > > https://lore.kernel.org/linux-riscv/20220621144920.2945595-1-guoren@k=
ernel.org/
> > >  - Fixup Clang compile problem Reported-by: kernel test robot
> > >  - Cleanup asm-generic/spinlock.h
> > >  - Remove changelog in patch main comment part, suggested by
> > >    Conor.Dooley
> > >  - Remove "default y if NUMA" in Kconfig
> > >
> > > V5:
> > > https://lore.kernel.org/linux-riscv/20220620155404.1968739-1-guoren@k=
ernel.org/
> > >  - Update comment with RISC-V forward guarantee feature.
> > >  - Back to V3 direction and optimize asm code.
> > >
> > > V4:
> > > https://lore.kernel.org/linux-riscv/1616868399-82848-4-git-send-email=
-guoren@kernel.org/
> > >  - Remove custom sub-word xchg implementation
> > >  - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock
> > >
> > > V3:
> > > https://lore.kernel.org/linux-riscv/1616658937-82063-1-git-send-email=
-guoren@kernel.org/
> > >  - Coding convention by Peter Zijlstra's advices
> > >
> > > V2:
> > > https://lore.kernel.org/linux-riscv/1606225437-22948-2-git-send-email=
-guoren@kernel.org/
> > >  - Coding convention in cmpxchg.h
> > >  - Re-implement short xchg
> > >  - Remove char & cmpxchg implementations
> > >
> > > V1:
> > > https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljcl=
ark@mac.com/
> > >  - Using cmpxchg loop to implement sub-word atomic
> > >
> > >
> > > Guo Ren (17):
> > >   asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
> > >   asm-generic: ticket-lock: Move into ticket_spinlock.h
> > >   riscv: Use Zicbop in arch_xchg when available
> > >   locking/qspinlock: Improve xchg_tail for number of cpus >=3D 16k
> > >   riscv: qspinlock: Add basic queued_spinlock support
> > >   riscv: qspinlock: Introduce combo spinlock
> > >   riscv: qspinlock: Introduce qspinlock param for command line
> > >   riscv: qspinlock: Add virt_spin_lock() support for KVM guest
> > >   riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
> > >   riscv: qspinlock: errata: Enable qspinlock for T-HEAD processors
> > >   RISC-V: paravirt: pvqspinlock: Add paravirt qspinlock skeleton
> > >   RISC-V: paravirt: pvqspinlock: Add nopvspin kernel parameter
> > >   RISC-V: paravirt: pvqspinlock: Add SBI implementation
> > >   RISC-V: paravirt: pvqspinlock: Add kconfig entry
> > >   RISC-V: paravirt: pvqspinlock: Add trace point for pv_kick/wait
> > >   RISC-V: paravirt: pvqspinlock: KVM: Add paravirt qspinlock skeleton
> > >   RISC-V: paravirt: pvqspinlock: KVM: Implement
> > >     kvm_sbi_ext_pvlock_kick_cpu()
> > >
> > >  .../admin-guide/kernel-parameters.txt         |   8 +-
> > >  arch/riscv/Kconfig                            |  50 ++++++++
> > >  arch/riscv/Kconfig.errata                     |  19 +++
> > >  arch/riscv/errata/thead/errata.c              |  29 +++++
> > >  arch/riscv/include/asm/Kbuild                 |   2 +-
> > >  arch/riscv/include/asm/cmpxchg.h              |   4 +-
> > >  arch/riscv/include/asm/errata_list.h          |  13 --
> > >  arch/riscv/include/asm/hwcap.h                |   1 +
> > >  arch/riscv/include/asm/insn-def.h             |   5 +
> > >  arch/riscv/include/asm/kvm_vcpu_sbi.h         |   1 +
> > >  arch/riscv/include/asm/processor.h            |  13 ++
> > >  arch/riscv/include/asm/qspinlock.h            |  35 ++++++
> > >  arch/riscv/include/asm/qspinlock_paravirt.h   |  29 +++++
> > >  arch/riscv/include/asm/rwonce.h               |  24 ++++
> > >  arch/riscv/include/asm/sbi.h                  |  14 +++
> > >  arch/riscv/include/asm/spinlock.h             | 113 ++++++++++++++++=
++
> > >  arch/riscv/include/asm/vendorid_list.h        |  14 +++
> > >  arch/riscv/include/uapi/asm/kvm.h             |   1 +
> > >  arch/riscv/kernel/Makefile                    |   1 +
> > >  arch/riscv/kernel/cpufeature.c                |   1 +
> > >  arch/riscv/kernel/qspinlock_paravirt.c        |  83 +++++++++++++
> > >  arch/riscv/kernel/sbi.c                       |   2 +-
> > >  arch/riscv/kernel/setup.c                     |  60 ++++++++++
> > >  .../kernel/trace_events_filter_paravirt.h     |  60 ++++++++++
> > >  arch/riscv/kvm/Makefile                       |   1 +
> > >  arch/riscv/kvm/vcpu_sbi.c                     |   4 +
> > >  arch/riscv/kvm/vcpu_sbi_pvlock.c              |  57 +++++++++
> > >  include/asm-generic/rwonce.h                  |   2 +
> > >  include/asm-generic/spinlock.h                |  87 +-------------
> > >  include/asm-generic/spinlock_types.h          |  12 +-
> > >  include/asm-generic/ticket_spinlock.h         | 103 ++++++++++++++++
> > >  kernel/locking/qspinlock.c                    |   5 +-
> > >  32 files changed, 739 insertions(+), 114 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/qspinlock.h
> > >  create mode 100644 arch/riscv/include/asm/qspinlock_paravirt.h
> > >  create mode 100644 arch/riscv/include/asm/rwonce.h
> > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > >  create mode 100644 arch/riscv/kernel/qspinlock_paravirt.c
> > >  create mode 100644 arch/riscv/kernel/trace_events_filter_paravirt.h
> > >  create mode 100644 arch/riscv/kvm/vcpu_sbi_pvlock.c
> > >  create mode 100644 include/asm-generic/ticket_spinlock.h
> > >
> > > --
> > > 2.36.1
> > >
> >
>
>
> --
> Best Regards
>  Guo Ren
>


