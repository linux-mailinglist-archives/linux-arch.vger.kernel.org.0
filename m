Return-Path: <linux-arch+bounces-7554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CD498C307
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B26F1C232DD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4381D0E17;
	Tue,  1 Oct 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uQpLD4zx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8C1D0DF7
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798905; cv=none; b=g2AGPn+DMmmmbQmkB7p3jisqjhIAgeXy5PEB7ibzN3hcbSyzY69IKzV3uYdVSkIGlxK2FM3ayu1XPfYyQKt5x3Xd02xEpwC8F4NdVOKeyW+GnA79jzLXw7CgxW/bOSJNflN8tXhQjJjv2I8kppWw+VDBKECOLAjEHE+DAazK1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798905; c=relaxed/simple;
	bh=BeiMS+xyfmhJj3g3y2WUDREZYbmsnXkNmVasjeb888o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHu7jrw0nVkORUVDSzxyfJb0W4k1D6i+hsy2wQG/Nr/kbp5+RnTd6zPXGgYerr9m1Mpr0qVAyuAhLkHmU8y0TsnH6K5vUoh72R0x4wdgUwUx/4W0TLDmQBNvB1m1fkxwPSpBzpTciDW84IryNZxrha/MduUvkf1yiPkpmbuNDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uQpLD4zx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e078d28fe9so4162027a91.2
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798902; x=1728403702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhmPwONIKNZXNlLItF/RqS4Q7SWFxV+hpF07L6+CC7I=;
        b=uQpLD4zxwDOz57J3w/HRwBH+b2V6sAwhihtGKB9erjSUr7qC6fhrazuuqWrPkYaMz7
         nwEk7gqq2OHo/P9sCpEYOVpadX9x3DTyIJBWN6jHnfuPQf0NEDA6otb/nOKPRlWF8f8S
         mEdI8ezk55yv3+X6BY/aR8fTkyQIrLGijt9n2ctewbcfbql3jDcc3uQKmDSAnZBg/pAY
         3S9Qp+M+Y2GRcUISTBdLyDg37q3+yejkSLvGTMaG5fjBoBr8y91naoxt+IKsFF4tTZmt
         tp5Z7HAIyy8iyn9EPhNfgR0bpSRMqXxynzocw5dE+P7qplRcLEX7livbLQFQBzAcNYIm
         h5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798902; x=1728403702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhmPwONIKNZXNlLItF/RqS4Q7SWFxV+hpF07L6+CC7I=;
        b=VuYYx+vYx7RZet5EO1eVQgp0ucAEs+Y/LKBhzzEEiPsytdmKHYb4MsAoHqJoE0vJIr
         0YjNOuB6TvTVH2CjK9O8ABv+HXy8D9KqkxCbz18lN64sBu/ityC0CgObgVlkhLgkLmKq
         sTjZ1PJ7MmJUicfXYqKVAKwzaF0yyGCS7Q6VV3XQSZ2NY4Pf9kjSWvrSkvbEyhMS4Q7O
         UC2St2AzfafAGlE9veQDlA/cbBW6BkdoVQ715YxW5JIv4H1Kqmm5ZSAVRcUKAfVM12Zf
         VYp3vJ1ggzkBM4BOLf6/h1frLE0Hx7drLq8sfDQl5Ja5vFEO8KB8CCdBOiUHYiD0j0uv
         LJVg==
X-Forwarded-Encrypted: i=1; AJvYcCUV/wLiS7LjuhGEd86MaIqKMK6uV0d7dQSNELsr5B++KlsQxrzq7HqHYh/ML17bD+UGeKCkEjGEeRtC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywex/+t5fwQZ6knULJ9hZZ/Lf7+8/bz28RA0pyK2oXoJrXCWrLA
	+dYIccPb680MU+LXZoLusZJAsscKhmNCVsKhxpDivZwFdmzQYTXu3bCm/P9WMg8=
X-Google-Smtp-Source: AGHT+IGoHYwx0kgKc4DgNgP0JzAT3h8W5Ogawl58DVURujvW6qbBVCpds5FTC6xsaK05crpycEn+DA==
X-Received: by 2002:a17:90b:33c2:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2e1846a0525mr238965a91.21.1727798902396;
        Tue, 01 Oct 2024 09:08:22 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:08:22 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:36 -0700
Subject: [PATCH 31/33] riscv: Documentation for landing pad / indirect
 branch tracking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-31-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

Adding documentation on landing pad aka indirect branch tracking on riscv
and kernel interfaces exposed so that user tasks can enable it.

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
index 000000000000..a188d78fcde6
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
+to enable indirect branch tracking for user mode applications on RISV-V
+
+1. Feature Overview
+--------------------
+
+Memory corruption issues usually result in to crashes, however when in hands of
+an adversary and if used creatively can result into variety security issues.
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
+	Such form of indirect control transfer are still immutable and don't rely
+    on memory and thus rs1=x7 is exempted from tracking and considered software
+    guarded jumps.
+
+``lpad`` instruction is pseudo of ``auipc rd, <imm_20bit>`` with ``rd=x0`` and
+is a HINT nop. ``lpad`` instruction must be aligned on 4 byte boundary and
+compares 20 bit immediate withx7. If ``imm_20bit`` == 0, CPU don't perform any
+comparision with ``x7``. If ``imm_20bit`` != 0, then ``imm_20bit`` must match
+``x7`` else CPU will raise ``software check exception`` (``cause=18``) with
+``*tval = 2``.
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
+then kernel will enabled indirect branch tracking for the task. Dynamic loader
+can issue this :c:macro:`prctl` once it has determined that all the objects
+loaded in address space support indirect branch tracking. Additionally if there
+is a `dlopen` to an object which wasn't compiled with ``zicfilp``, dynamic
+loader can issue this prctl with arg1 set to 0 (i.e.
+:c:macro:`PR_INDIR_BR_LP_ENABLE` being clear)
+
+* prctl(PR_GET_INDIR_BR_LP_STATUS, unsigned long arg)
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
+Linux kernel will treat this as :c:macro:`SIGSEV`` with code =
+:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.

-- 
2.45.0


