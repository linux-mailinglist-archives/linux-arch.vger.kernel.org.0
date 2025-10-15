Return-Path: <linux-arch+bounces-14149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEA6BE024F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3F50764E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80B33CEA2;
	Wed, 15 Oct 2025 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="EO4IrLok"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5C369995
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552086; cv=none; b=u83sA6IKePOAfu7kkWe3vrEMsmRWbdKtW13xYlEvUQ6gWhI1K8NxVx0rgnC8GkbIovfbvRn5uvbtnaSMLLocbohftwvBni0hjP9Nui2H/res0hkMkVkD+qr633yM0wz0ZfrOAWIU7h5ikQ24a49RtF3/rAuvWRp4Al5K8iLVrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552086; c=relaxed/simple;
	bh=7LCUsE6kNUEwcM1QtIZIjQu/BHRL3vY+rwSlBm5MqpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkPhaNphG4W71ypiPwjK++KPIzTmHBLAD+wWdkM21IlsHbKwv28njJlWMqFTDMdSklsZrZeg2ojVhxJcG/Me9uQdhzuLlDvyHxeyy+1rpfKLeQSSMeE/buzGmD2BfjeLcN9B+6RsQGdQNKEa78OgzJ2adzq9rn/x6HpdPZAofek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=EO4IrLok; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso6133864b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552083; x=1761156883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG1CujsNwBaYp55w8jydf3By/QJhyDp8hEQZ+a6RoEM=;
        b=EO4IrLokiQBWqTNovxZDEUcfXTS/D7uv5bm0SA+55giGnDhnHhsMCpTK02NSX62CBd
         axZuq/D0Y2Xn6YzkPBIJB9TPQ8SmjWLpw5QOYY/O5Y5LK761VO1+lB6OPedShP/v2xBZ
         ugnzqRNtWuqXKbMO6HcAjQYrKnQEWdwOC0Sb1voK+me0YKZcFRUwCMVEAnvtT14k84fr
         evJaEPIZ7PEYpZHWP426nKjfIX0lMNbIAgT0mF15jF7+Rh4xLSJwLaYI3u8X4/Nx7GAK
         JX7s88gD+DZIkjsvIxGhOozxFo7/CQ55t6DToYXPho8pP9cHSKVT0FYWQo6oYzkeO9f6
         B8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552083; x=1761156883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG1CujsNwBaYp55w8jydf3By/QJhyDp8hEQZ+a6RoEM=;
        b=PQQqnzY1CEEkl8iSZFOHnxGAJEaM6go0mxD1IXm6QLMH8sFsuwZsvyhTDrLItLeewH
         nTdqjGlouhd9x/wtvigIJx+xRqvGVdkDhvgi37dB/iOSSINoxC3DzYQQN9YeK2g82B6y
         kG1MGPubra1sMOdcyMQKGf08OFiFhN4aXddCTUqZfS6O+vqz6Z8SrXiY9lCugQU7LZ3X
         +xuIbS1gr1Ma3sj+Yi2zWinTU4b91DpVD49AYDujrBqWdELGhQiKaYxqDSnzCENrWP8b
         lrCJnimI2umwnnEmeyTTfp3IeoYmAE1hTI3JkU6E6WI7r++gMdbi0oQmeECGG0+ueFzq
         pydg==
X-Forwarded-Encrypted: i=1; AJvYcCWsGvykU+baqnDwuaywXIOrSr2ejo7Q0Kp0GlgeuSkuT5Mj4+sR8muywGPFvCaS/rXPTS7uQkr2pqMt@vger.kernel.org
X-Gm-Message-State: AOJu0YyHVwyOiD/7dVqYjJRo8vxs87amq+1RG4Vy/UBVUvr/vWxh8M4x
	toIcTcBMKxFZRBasaRUVh0x60EHK67vHCylarLHCRtmQcvpmyNCib2JU65QWwPBtY3w=
X-Gm-Gg: ASbGncsYEd7GQsN15505fwkSK/OGVYDiuzCKE7DZM8YdOj1iCDsnjjTVmPN/PQ2GxC5
	IYp2X5gKKUXNhlscTV7ZeBc9Jy71XsIE/AbqIpRaPcDiaQ7138InFV2A0NEDeWMOCPzdXIyBhmq
	roc6o4W+hXUMNXeEuAtC5CzskmLEmvJ8ct9Knviyq/11hX2iwGfDe3gtXN3a3dMjL7Iakcrz8sf
	r/IYm6s5q9Z4JoIrraKdbkfBb+yoviHR9u77fWLsJ7e0/cM6AGxJDwtF3gKv5WJdPQz6AnNs38j
	f89MxrvELnnmuZaJVpnnH5EA4tHuYbHjUq9jtQz7sZKLFv72JAcQZsu+Lcxx3xiwET+wDboKb0I
	3MNyCFUEgmMjdBKYgEKdTs4xSdOJ+JcYj+m/LIgW3ZB+xHyTXwrZJnexJ78HCsS4g40bxzkpf
X-Google-Smtp-Source: AGHT+IHIuPapqKaEgJQDooYNegliwk6TBhWvUDTrNLkBFXNxNP1x5VscPPMJdzsUIVRc6YQ1lTVYMQ==
X-Received: by 2002:a17:902:f64d:b0:26c:e270:6dad with SMTP id d9443c01a7336-2902741e4a0mr313345865ad.60.1760552082633;
        Wed, 15 Oct 2025 11:14:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:58 -0700
Subject: [PATCH v21 26/28] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-26-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/arch/riscv/index.rst   |   1 +
 Documentation/arch/riscv/zicfilp.rst | 115 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index eecf347ce849..be7237b69682 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -14,6 +14,7 @@ RISC-V architecture
     uabi
     vector
     cmodx
+    zicfilp
 
     features
 
diff --git a/Documentation/arch/riscv/zicfilp.rst b/Documentation/arch/riscv/zicfilp.rst
new file mode 100644
index 000000000000..3575c7db2cef
--- /dev/null
+++ b/Documentation/arch/riscv/zicfilp.rst
@@ -0,0 +1,115 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Author: Deepak Gupta <debug@rivosinc.com>
+:Date:   12 January 2024
+
+====================================================
+Tracking indirect control transfers on RISC-V Linux
+====================================================
+
+This document briefly describes the interface provided to userspace by Linux
+to enable indirect branch tracking for user mode applications on RISC-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result into crashes, however when in hands of
+an adversary and if used creatively can result into a variety security issues.
+
+One of those security issues can be code re-use attacks on program where adversary
+can use corrupt function pointers and chain them together to perform jump oriented
+programming (JOP) or call oriented programming (COP) and thus compromising control
+flow integrity (CFI) of the program.
+
+Function pointers live in read-write memory and thus are susceptible to corruption
+and allows an adversary to reach any program counter (PC) in address space. On
+RISC-V zicfilp extension enforces a restriction on such indirect control
+transfers:
+
+- indirect control transfers must land on a landing pad instruction ``lpad``.
+  There are two exception to this rule:
+
+  - rs1 = x1 or rs1 = x5, i.e. a return from a function and returns are
+    protected using shadow stack (see zicfiss.rst)
+
+  - rs1 = x7. On RISC-V compiler usually does below to reach function
+    which is beyond the offset possible J-type instruction::
+
+      auipc x7, <imm>
+      jalr (x7)
+
+    Such form of indirect control transfer are still immutable and don't rely
+    on memory and thus rs1=x7 is exempted from tracking and considered software
+    guarded jumps.
+
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate with x7. If ``imm_20bit`` == 0, CPU doesn't perform
+any comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must
+match ``x7`` else CPU will raise ``software check exception`` (``cause=18``)
+with ``*tval = 2``.
+
+Compiler can generate a hash over function signatures and setup them (truncated
+to 20bit) in x7 at callsites and function prologues can have ``lpad`` with same
+function hash. This further reduces number of program counters a call site can
+reach.
+
+2. ELF and psABI
+-----------------
+
+Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_FCFI` for property
+:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
+
+3. Linux enabling
+------------------
+
+User space programs can have multiple shared objects loaded in its address space
+and it's a difficult task to make sure all the dependencies have been compiled
+with support of indirect branch. Thus it's left to dynamic loader to enable
+indirect branch tracking for the program.
+
+4. prctl() enabling
+--------------------
+
+:c:macro:`PR_SET_INDIR_BR_LP_STATUS` / :c:macro:`PR_GET_INDIR_BR_LP_STATUS` /
+:c:macro:`PR_LOCK_INDIR_BR_LP_STATUS` are three prctls added to manage indirect
+branch tracking. prctls are arch agnostic and returns -EINVAL on other arches.
+
+* prctl(PR_SET_INDIR_BR_LP_STATUS, unsigned long arg)
+
+If arg1 is :c:macro:`PR_INDIR_BR_LP_ENABLE` and if CPU supports ``zicfilp``
+then kernel will enable indirect branch tracking for the task. Dynamic loader
+can issue this :c:macro:`prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there
+is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
+
+* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long * arg)
+
+Returns current status of indirect branch tracking. If enabled it'll return
+:c:macro:`PR_INDIR_BR_LP_ENABLE`
+
+* prctl(PR_LOCK_INDIR_BR_LP_STATUS, unsigned long arg)
+
+Locks current status of indirect branch tracking on the task. User space may
+want to run with strict security posture and wouldn't want loading of objects
+without ``zicfilp`` support in it and thus would want to disallow disabling of
+indirect branch tracking. In that case user space can use this prctl to lock
+current settings.
+
+5. violations related to indirect branch tracking
+--------------------------------------------------
+
+Pertaining to indirect branch tracking, CPU raises software check exception in
+following conditions:
+
+- missing ``lpad`` after indirect call / jmp
+- ``lpad`` not on 4 byte boundary
+- ``imm_20bit`` embedded in ``lpad`` instruction doesn't match with ``x7``
+
+In all 3 cases, ``*tval = 2`` is captured and software check exception is
+raised (``cause=18``)
+
+Linux kernel will treat this as :c:macro:`SIGSEGV` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.

-- 
2.43.0


