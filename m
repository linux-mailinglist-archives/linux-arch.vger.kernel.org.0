Return-Path: <linux-arch+bounces-1556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F4F83BA15
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90812B25E7E
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395551CA9F;
	Thu, 25 Jan 2024 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VD6IcpkB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF41CA8D
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164239; cv=none; b=hogba/y8VE6e/XYZVEVsfui0oe2gf+JGkAFEGTkgiqqSQMEUFF/T8dYvgMMxQNM9CKZkN0D6JhO14s6hsWJsa21qKfMzY/XHd10d9qkbUmUSHvl09ifxYtQAWZrTp4+LCaVfVeNWlb/WTtaf9ISEEVVnyIIgLtUuDC4cH4GCszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164239; c=relaxed/simple;
	bh=b6pOo15AgYPdAPBfrIdYjpImaIq/GWbTeby6XBVJhrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoG78wvcekJXYYTTE9dHa/mHxuHaHwBHzpgFkp2i7fvSJaao9DiWH8KMKMSJK/SDU0h1noyvTWU+6d8huWH0Tr7UW64dio1NFBcqSQSQiEh4yKw63Nar+0nYEq6S36PT20PqlcCulUzqcLhnINv1QSChRqYunfBNVd0cAsQFM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VD6IcpkB; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5999f3f6ce9so2177964eaf.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164236; x=1706769036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP7pro+U4WPopmqRl450Qrpf0qO4ThfR1Q3D92bPINc=;
        b=VD6IcpkBsIp6JvAN4VwTs5ezDGu5M4uUFlO2NPgk3VGautCJYtVtM75PAKDqWty2f8
         SgxHd30KV6kqbJPYNfe3dNOu8Cqi6WHO5u7Rvuf4XIkIJ1tvvfA8Tbn9i1MjrVYl4phu
         XMCOzUIaam1/Ow5uH82dQ4tl5PCJsEjYL77JUvoIcnv6mwD9OdYbSuEt8UBd1M5lHI3i
         SPPgKX3udRMymLIEG4AVpnwGR9s/dqWZ6TsRiBXB2ZjN6N6E8oFGtk1ptU035M/3/SU0
         /HP81xd5etP/1ov95QcPW0TichReo1ZMV4RxdU30Dx1umtGuPzKxvyBzmzO73/d3OzGI
         rN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164236; x=1706769036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP7pro+U4WPopmqRl450Qrpf0qO4ThfR1Q3D92bPINc=;
        b=gjD/jJuZ9HZF6Qe8RxASi25kq14EYq/IKRdZuWizaRe0ksseH85UNNN2YcUiQvBSA+
         u1UPX5SPYiM4UlyewNpMEOp66BQkUjNhx/bsPvk0IYEqq9lsBlGPfMmrRdCBme2OzD8+
         m5Dwf2jjc7C4BOAtaXk7kpD6eDOeVoQE5NA03UqMaipQhrWZzrVKJJens941pnyukF++
         VT1f1+nPSRUicIUhE66x2HJsCWsQgJ5eiQyeCMGDhu6w69dsC+78lADCrDOrKyhi5w8v
         3E3uq5dOc+7Fw3Tkpvc0pJ62gLJnUDImtNzmv7a7VIfzmM+c36BOkVqXsYMShk/gkAuH
         MkcQ==
X-Gm-Message-State: AOJu0YyGNjvTUcZ71kNtjb0+6XEa5D8SCxQbES8oBr6SbkjVWI3XsnAy
	RiWZa2tT9rGr9qWMxccO9J+JvVuh6KHaWj8z6EfwTZdAsdsozkAlTp0AEm6eNbg=
X-Google-Smtp-Source: AGHT+IEUnFo9OyFSd3Rs68nw+k/GOuuePp10Q4ebNQClafZksd6E7VRe2DbLJ7NX3SXPskd8vBCNUQ==
X-Received: by 2002:a05:6358:2910:b0:175:4fc2:1ab4 with SMTP id y16-20020a056358291000b001754fc21ab4mr756379rwb.45.1706164236125;
        Wed, 24 Jan 2024 22:30:36 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:35 -0800 (PST)
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
Subject: [RFC PATCH v1 27/28] riscv: Documentation for shadow stack on riscv
Date: Wed, 24 Jan 2024 22:21:52 -0800
Message-ID: <20240125062739.1339782-28-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

Adding documentation on shadow stack for user mode on riscv and kernel
interfaces exposed so that user tasks can enable it.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/zicfiss.rst | 169 +++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/arch/riscv/zicfiss.rst

diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/riscv/zicfiss.rst
new file mode 100644
index 000000000000..f133b6af9c15
--- /dev/null
+++ b/Documentation/arch/riscv/zicfiss.rst
@@ -0,0 +1,169 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+=========================================================
+Shadow stack to protect function returns on RISC-V Linux
+=========================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable shadow stack for user mode applications on RISV-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result in to crashes, however when in hands of
+an adversary and if used creatively can result into variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt return addresses present on stack and chain them together to perform
+return oriented programming (ROP) and thus compromising control flow integrity (CFI)
+of the program.
+
+Return addresses live on stack and thus in read-write memory and thus are
+susceptible to corruption and allows an adversary to reach any program counter
+(PC) in address space. On RISC-V `zicfiss` extension provides an alternate stack
+`shadow stack` on which return addresses can be safely placed in prolog of the
+function and retrieved in epilog. `zicfiss` extension makes following changes
+
+	- PTE encodings for shadow stack virtual memory
+	  An earlier reserved encoding in first stage translation i.e.
+	  PTE.R=0, PTE.W=1, PTE.X=0  becomes PTE encoding for shadow stack pages.
+
+	- `sspush x1/x5` instruction pushes (stores) `x1/x5` to shadow stack.
+
+	- `sspopchk x1/x5` instruction pops (loads) from shadow stack and compares
+	  with `x1/x5` and if un-equal, CPU raises `software check exception` with
+	  `*tval = 3`
+
+Compiler toolchain makes sure that function prologs have `sspush x1/x5` to save return
+address on shadow stack in addition to regular stack. Similarly function epilogs have
+`ld x5, offset(x2)`; `sspopchk x5` to ensure that popped value from regular stack
+matches with popped value from shadow stack.
+
+2. Shadow stack protections and linux memory manager
+-----------------------------------------------------
+
+As mentioned earlier, shadow stack get new page table encodings and thus have some
+special properties assigned to them and instructions that operate on them as below
+
+	- Regular stores to shadow stack memory raises access store faults.
+	  This way shadow stack memory is protected from stray inadvertant
+	  writes
+
+	- Regular loads to shadow stack memory are allowed.
+	  This allows stack trace utilities or backtrace functions to read
+	  true callstack (not tampered)
+
+	- Only shadow stack instructions can generate shadow stack load or
+	  shadow stack store.
+
+	- Shadow stack load / shadow stack store on read-only memory raises
+	  AMO/store page fault. Thus both `sspush x1/x5` and `sspopchk x1/x5`
+	  will raise AMO/store page fault. This simplies COW handling in kernel
+	  During fork, kernel can convert shadow stack pages into read-only
+	  memory (as it does for regular read-write memory) and as soon as
+	  subsequent `sspush` or `sspopchk` in userspace is encountered, then
+	  kernel can perform COW.
+
+	- Shadow stack load / shadow stack store on read-write, read-write-
+	  execute memory raises an access fault. This is a fatal condition
+	  because shadow stack should never be operating on read-write, read-
+	  write-execute memory.
+
+3. ELF and psABI
+-----------------
+
+Toolchain sets up `GNU_PROPERTY_RISCV_FEATURE_1_BCFI` for property
+`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+4. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of shadow stack. Thus it's left to dynamic loader to enable
+shadow stack for the program.
+
+5. prctl() enabling
+--------------------
+
+`PR_SET_SHADOW_STACK_STATUS` / `PR_GET_SHADOW_STACK_STATUS` /
+`PR_LOCK_SHADOW_STACK_STATUS` are three prctls added to manage shadow stack
+enabling for tasks. prctls are arch agnostic and returns -EINVAL on other arches.
+
+`PR_SET_SHADOW_STACK_STATUS`: If arg1 `PR_SHADOW_STACK_ENABLE` and if CPU supports
+`zicfiss` then kernel will enable shadow stack for the task. Dynamic loader can
+issue this `prctl` once it has determined that all the objects loaded in address
+space have support for shadow stack. Additionally if there is a `dlopen` to an
+object which wasn't compiled with `zicfiss`, dynamic loader can issue this prctl
+with arg1 set to 0 (i.e. `PR_SHADOW_STACK_ENABLE` being clear)
+
+`PR_GET_SHADOW_STACK_STATUS`: Returns current status of indirect branch tracking.
+If enabled it'll return `PR_SHADOW_STACK_ENABLE`
+
+`PR_LOCK_SHADOW_STACK_STATUS`: Locks current status of shadow stack enabling on the
+task. User space may want to run with strict security posture and wouldn't want
+loading of objects without `zicfiss` support in it and thus would want to disallow
+disabling of shadow stack on current task. In that case user space can use this prctl
+to lock current settings.
+
+5. violations related to returns with shadow stack enabled
+-----------------------------------------------------------
+
+Pertaining to shadow stack, CPU raises software check exception in following
+condition
+
+	- On execution of `sspopchk x1/x5`, x1/x5 didn't match top of shadow stack.
+	  If mismatch happens then cpu does `*tval = 3` and raise software check
+	  exception
+
+Linux kernel will treat this as `SIGSEV`` with code = `SEGV_CPERR` and follow
+normal course of signal delivery.
+
+6. Shadow stack tokens
+-----------------------
+Regular stores on shadow stacks are not allowed and thus can't be tampered with via
+arbitrary stray writes due to bugs. Method of pivoting / switching to shadow stack
+is simply writing to csr `CSR_SSP` changes active shadow stack. This can be problematic
+because usually value to be written to `CSR_SSP` will be loaded somewhere in writeable
+memory and thus allows an adversary to corruption bug in software to pivot to an any
+address in shadow stack range. Shadow stack tokens can help mitigate this problem by
+making sure that:
+
+ - When software is switching away from a shadow stack, shadow stack pointer should be
+   saved on shadow stack itself and call it `shadow stack token`
+
+ - When software is switching to a shadow stack, it should read the `shadow stack token`
+   from shadow stack pointer and verify that `shadow stack token` itself is pointer to
+   shadow stack itself.
+
+ - Once the token verification is done, software can perform the write to `CSR_SSP` to
+   switch shadow stack.
+
+Here software can be user mode task runtime itself which is managing various contexts
+as part of single thread. Software can be kernel as well when kernel has to deliver a
+signal to user task and must save shadow stack pointer. Kernel can perform similar
+procedure by saving a token on user shadow stack itself. This way whenever sigreturn
+happens, kernel can read the token and verify the token and then switch to shadow stack.
+Using this mechanism, kernel helps user task so that any corruption issue in user task
+is not exploited by adversary by arbitrarily using `sigreturn`. Adversary will have to
+make sure that there is a `shadow stack token` in addition to invoking `sigreturn`
+
+7. Signal shadow stack
+-----------------------
+Following structure has been added to sigcontext for RISC-V. `rsvd` field has been kept
+in case we need some extra information in future for landing pads / indirect branch
+tracking. It has been kept today in order to allow backward compatibility in future.
+
+struct __sc_riscv_cfi_state {
+	unsigned long ss_ptr;
+	unsigned long rsvd;
+};
+
+As part of signal delivery, shadow stack token is saved on current shadow stack itself and
+updated pointer is saved away in `ss_ptr` field in `__sc_riscv_cfi_state` under `sigcontext`
+Existing shadow stack allocation is used for signal delivery. During `sigreturn`, kernel will
+obtain `ss_ptr` from `sigcontext` and verify the saved token on shadow stack itself and switch
+shadow stack.
-- 
2.43.0


