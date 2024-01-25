Return-Path: <linux-arch+bounces-1529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D911B83B990
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5BF1C22DEE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6771A10A28;
	Thu, 25 Jan 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hxX1AvC1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27A10A17
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164084; cv=none; b=CNdGimsu5xRIvsKcqBqoRxkzbC4hQoBevs0tiRS35yXDTpiIrHThK/7YO8sz72gwBPZ+8A5rTssjzMAe2a3mVM0vpRwbu//GZyvhqmZbsU+urRH4nszy9s5vM/b4EqQCAE84rrDfwnKchBmSgVYCLYxqOcJK6Eg1/kn10TzR/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164084; c=relaxed/simple;
	bh=lnx+tfjEQPKcKjjGQ3TIEcWAGP0U6meHIgyDhly6uJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZP7IN0N7/wS+SpckMiD76XPrigKGDBwZneMaLbkdxcGmcHSK82X1I+tKBGUaKWfOrnaNLFwg7TcxrtI+9uNGiGuzLgGt22CvFYJWzyEnTF4QsRnhThBpSfAPB2igNRgr8J/umiC0+qloatP5jXXA3xp0nt8PBrtog/36MTioJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hxX1AvC1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4941837a12.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164081; x=1706768881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QXTHyjxL8kR5Po7d+GYATRHdwro/16lDMpxqrKjx/Ag=;
        b=hxX1AvC1gctKiKWzodO7eklaFILtevC0fQldChZ80hVhyC7e7FWJ1yTCCI2/92LBFM
         udqqxyab/zar9yFPuenVpbMJYc8+BpLQtRDpZbBu3jf6/zEA2sFVkSYBmMU3Hw3fVubH
         NlmpycOU7SKzP/V3/kqww4CIHfRY/xzQGJ5xtjTQRWIPXzlDjUrC25QYxlxiwlKkBkUX
         CU4T/dPyeNH20PSAZYGk4wIf4mRcqEuVcJL2fAYrwThBc6zQdTV9keljJ7k9WBlB3JLl
         lA1vetvpFGPrHS53yxgBcXEl4gFcJo6TmkJ1yJcfIUlgxLdqu7Nce2suGmaIddpz+q8S
         NlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164081; x=1706768881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXTHyjxL8kR5Po7d+GYATRHdwro/16lDMpxqrKjx/Ag=;
        b=wdNeDNCtylOv7pXEDzdMhDu2udlevqElIdemFwNo942FA3OP3PAx5E45wypo5EOPG8
         NbyjA9aBuM3frf0crm1DVI0P4UeWcmsR2nl+71nmlTNQbbQ4Lqxc0e/0NdGR6ulNnJbV
         Hzc3t0rjZfebC+83VrCUcZAyTmH6ZkXaQ/4KSM5AZpSqW/c1FXn3vGHe90u1QepflRZW
         4AsKz4DSlqWgew8+gjds+jKEiJ8ZhOAgE82nqCy0qA5PfZKKUHuylTGq+vwpCO8WckoC
         zo7jqsLSlS+B0QSH8C5lMsbzL6URvrnkZcswNZsNxZH7U8VvzayIygPsAq75Sd9vzPAA
         xdMw==
X-Gm-Message-State: AOJu0Yymj/Hm/SOdGWoLeNOPkGQUxZEVL3TBr+nWzzxTqy95uM++eLGe
	ejhCvl1+H/7fAqO+K6n1KxVbOZ7SFTay/wqRXQTtRYwtWwp4kFizxHug5ukzkCg=
X-Google-Smtp-Source: AGHT+IHI/WMAhl2PB+/aXrDdR8LPiiPrRqLK2yfdwW0qIQIbS5kaetCk3DdXJz5Rd4D4N6P34jxx3A==
X-Received: by 2002:a05:6a20:938f:b0:19b:211a:e62d with SMTP id x15-20020a056a20938f00b0019b211ae62dmr712796pzh.25.1706164080770;
        Wed, 24 Jan 2024 22:28:00 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:28:00 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 00/28] riscv control-flow integrity for usermode
Date: Wed, 24 Jan 2024 22:21:25 -0800
Message-ID: <20240125062739.1339782-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

It's been almost an year since I posted my last patch series [1] to
enable CPU assisted control-flow integrity for usermode on riscv. A lot
has changed since then and so has the patches. It's been a while and since
this is a reboot of series, starting with RFC and v1.

Securing control-flow integrity for usermode requires following

    - Securing forward control flow : All callsites must reach
      reach a target that they actually intend to reach.

    - Securing backward control flow : All function returns must
      return to location where they were called from.

This patch series use riscv cpu extension `zicfilp` [2] to secure forward
control flow and `zicfiss` [2] to secure backward control flow. `zicfilp`
enforces that all indirect calls or jmps must land on a landing pad instr
and label embedded in landing pad instr must match a value programmed in
`x7` register (at callsite via compiler). `zicfiss` introduces shadow stack
which can only be writeable via shadow stack instructions (sspush and
ssamoswap) and thus can't be tampered with via inadvertent stores. More
details about extension can be read from [2] and there are details in
documentation as well (in this patch series).

Using config `CONFIG_RISCV_USER_CFI`, kernel support for riscv control flow
integrity for user mode programs can be compiled in the kernel.

Enabling of control flow integrity for user programs is left to user runtime
(specifically expected from dynamic loader). There has been a lot of earlier
discussion on the enabling topic around x86 shadow stack enabling [3, 4, 5] and
overall consensus had been to let dynamic loader (or usermode) to decide for
enabling the feature.

This patch series introduces arch agnostic `prctls` to enable shadow stack
and indirect branch tracking. And implements them on riscv. arm64 is expected
to implement shadow stack part of these arch agnostic `prctls` [6]

Changes since last time
***********************

Spec changes
------------
- Forward cfi spec has become much simpler. `lpad` instruction is pseudo for
  `auipc rd, <20bit_imm>`. `lpad` checks x7 against 20bit embedded in instr.
  Thus label width is 20bit.

- Shadow stack management instructions are reduced to
    sspush - to push x1/x5 on shadow stack
    sspopchk - pops from shadow stack and comapres with x1/x5.
    ssamoswap - atomically swap value on shadow stack.
    rdssp - reads current shadow stack pointer

- Shadow stack accesses on readonly memory always raise AMO/store page fault.
  `sspopchk` is load but if underlying page is readonly, it'll raise a store
  page fault. It simplifies hardware and kernel for COW handling for shadow
  stack pages.

- riscv defines a new exception type `software check exception` and control flow
  violations raise software check exception.

- enabling controls for shadow stack and landing are in xenvcfg CSR and controls
  lower privilege mode enabling. As an example senvcfg controls enabling for U and
  menvcfg controls enabling for S mode.

core mm shadow stack enabling
-----------------------------
Shadow stack for x86 usermode are now in mainline and thus this patch
series builds on top of that for arch-agnostic mm related changes. Big
thanks and shout out to Rick Edgecombe for that.

selftests
---------
Created some minimal selftests to test the patch series.


[1] - https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
[2] - https://github.com/riscv/riscv-cfi
[3] - https://lore.kernel.org/lkml/ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk/T/#mb121cd8b33d564e64234595a0ec52211479cf474
[4] - https://lore.kernel.org/all/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[5] - https://lore.kernel.org/lkml/CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com/
[6] - https://lore.kernel.org/linux-mm/20231122-arm64-gcs-v7-2-201c483bd775@kernel.org/

Deepak Gupta (27):
  riscv: abstract envcfg CSR
  riscv: envcfg save and restore on trap entry/exit
  riscv: define default value for envcfg
  riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
  riscv: zicfiss/zicfilp enumeration
  riscv: zicfiss/zicfilp extension csr and bit definitions
  riscv: kernel handling on trap entry/exit for user cfi
  mm: Define VM_SHADOW_STACK for RISC-V
  mm: abstract shadow stack vma behind `arch_is_shadow_stack`
  riscv/mm : Introducing new protection flag "PROT_SHADOWSTACK"
  riscv: Implementing "PROT_SHADOWSTACK" on riscv
  riscv mm: manufacture shadow stack pte
  riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
  riscv mmu: write protect and shadow stack
  riscv/mm: Implement map_shadow_stack() syscall
  riscv/shstk: If needed allocate a new shadow stack on clone
  prctl: arch-agnostic prtcl for indirect branch tracking
  riscv: Implements arch agnostic shadow stack prctls
  riscv: Implements arch argnostic indirect branch tracking prctls
  riscv/traps: Introduce software check exception
  riscv sigcontext: adding cfi state field in sigcontext
  riscv signal: Save and restore of shadow stack for signal
  riscv: select config for shadow stack and landing pad instr support
  riscv/ptrace: riscv cfi status and state via ptrace and in core files
  riscv: Documentation for landing pad / indirect branch tracking
  riscv: Documentation for shadow stack on riscv
  kselftest/riscv: kselftest for user mode cfi

Mark Brown (1):
  prctl: arch-agnostic prctl for shadow stack

 Documentation/arch/riscv/zicfilp.rst          | 104 ++++
 Documentation/arch/riscv/zicfiss.rst          | 169 ++++++
 arch/riscv/Kconfig                            |  16 +
 arch/riscv/include/asm/asm-prototypes.h       |   1 +
 arch/riscv/include/asm/cpufeature.h           |  18 +
 arch/riscv/include/asm/csr.h                  |  20 +
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/mman.h                 |  42 ++
 arch/riscv/include/asm/pgtable.h              |  32 +-
 arch/riscv/include/asm/processor.h            |   2 +
 arch/riscv/include/asm/thread_info.h          |   4 +
 arch/riscv/include/asm/usercfi.h              | 106 ++++
 arch/riscv/include/uapi/asm/ptrace.h          |  18 +
 arch/riscv/include/uapi/asm/sigcontext.h      |   5 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/asm-offsets.c               |   6 +-
 arch/riscv/kernel/cpufeature.c                |   4 +-
 arch/riscv/kernel/entry.S                     |  32 ++
 arch/riscv/kernel/process.c                   |  16 +
 arch/riscv/kernel/ptrace.c                    |  83 +++
 arch/riscv/kernel/signal.c                    |  45 ++
 arch/riscv/kernel/sys_riscv.c                 |  19 +
 arch/riscv/kernel/traps.c                     |  38 ++
 arch/riscv/kernel/usercfi.c                   | 497 ++++++++++++++++++
 arch/riscv/mm/init.c                          |   2 +-
 arch/riscv/mm/pgtable.c                       |  21 +
 include/linux/mm.h                            |  35 +-
 include/uapi/asm-generic/mman.h               |   1 +
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |  49 ++
 kernel/sys.c                                  |  60 +++
 mm/gup.c                                      |   5 +-
 mm/internal.h                                 |   2 +-
 mm/mmap.c                                     |   1 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/cfi/Makefile    |  10 +
 .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 +++
 .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 ++++
 .../testing/selftests/riscv/cfi/shadowstack.c | 376 +++++++++++++
 .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
 40 files changed, 2050 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/arch/riscv/zicfilp.rst
 create mode 100644 Documentation/arch/riscv/zicfiss.rst
 create mode 100644 arch/riscv/include/asm/mman.h
 create mode 100644 arch/riscv/include/asm/usercfi.h
 create mode 100644 arch/riscv/kernel/usercfi.c
 create mode 100644 tools/testing/selftests/riscv/cfi/Makefile
 create mode 100644 tools/testing/selftests/riscv/cfi/cfi_rv_test.h
 create mode 100644 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.h

-- 
2.43.0


