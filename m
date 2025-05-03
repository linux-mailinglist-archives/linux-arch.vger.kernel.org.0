Return-Path: <linux-arch+bounces-11835-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16099AA7D51
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8D79C7E32
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418E27464F;
	Fri,  2 May 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hxJH1boS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A12741BC
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228715; cv=none; b=qprJssFAoBtB+tuuGriE3DBGrMQ1r37Dv7NSvV/0N+JL1aRyUela+NnCeyG47/4heWAAaOMmLiqUg6l4bxf9Zig1z7yMbeYUIHDUZyXFO7iCGFfB9Zc01dhSM9gBfimVV9C3Omgy3/Wg5O9crgqN8JPT9vxqjIsY71cbYpsjuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228715; c=relaxed/simple;
	bh=H29s14Nj8LT2FApT5gVFphwgkznxmrD03+6k4VfhZNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7sETwgv+yevpLAigux1nz6YDzCaRl0SmG1bC4gCvjPKp6rPD9cnpxOo/C+crYINNKefeNJLDEK+Gsa9x3ACMbtKqY5FbaqxUBxECdyEqcXGo6DEt1pa8OmFdsmxyIRt32w7mS9aVT6cBWExNevcNv3X8m6aCKp+AAeHEG/eejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hxJH1boS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so32184125ad.1
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228713; x=1746833513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHd3Vd8BT7ERvd76/ORFx6wuHZwSymRieroGATMtUTo=;
        b=hxJH1boStpgGnjn8V/cjAfkGyocRw29+jRz+m557hzClEz7AbhsYo+E2ch5yTon0Ob
         VYTRP9cEcEbqR3ljgA+hsYvk7B1TaAIsu3I/XlfKiXztbONMi8QCnwXu/W2lnF77/LwV
         VoBVkUZ/9t+C5FwSOB/4ilc/lz/wbr40LznZ4vggHvUgFNow/1INJ4fA5BryKjPxvpcA
         qIIEQvzu6SUs/Sa0wyBfn7/xLDpiSbllAdUPnhCHwaMuJJKmSNRgoPoakFNBoHVSEyRn
         YNHh0bG8JQF1jdNIi0cp/leSEkXrOEe5/MInjw3hH4Sf3GLTtWXq4mmts1QuZspVrop6
         FojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228713; x=1746833513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHd3Vd8BT7ERvd76/ORFx6wuHZwSymRieroGATMtUTo=;
        b=kLHZHToPiNYoVwi5svzvU5Tg9KKEx6OkCH19sV1TJbNFfQILgBzNsUb4JicAEM1zV3
         vKM6zcb0NLKTOGHpctGK2X1kP8ktSQRCTRAsTPyKwGq/ftilP2N1xjcLp001zf3JXkei
         JQWSVtZeJrMRqpaaTScdkjQRX1Mc/cfxfdaIWTCcnIT62scHN9wlhFEUmKc1DmCjK+27
         8ZsYd5/1xIhS3cZOig8mrGdd1hrQmMkMDhUTDJQiNlRED6yUXKlaMqMM4pen5GEgcABf
         UyY/cskPrVWX0xB9va0LLVTtiskfEzes2q/Soyg0IfJnAd34YgNdZRtRUgIw7ujbxQwX
         z3mQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhG6XmuQ9PwEfN1x8fnJAduiKW3VMx3dlCBfzfpNrLPMmFBKsfegWu6ZZ4ARAUD2znqFoeDvDjHlXw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7CjfqkOtixPh6RfgBCiL/xIWFuRGpQquHof/1dX81oflG2R13
	0FI/SlUzRvrNq4ud0+z+EIUT3P1OVe9p+qfbt/nfGRFt0Mw0NW/G+ljO4AqdCAQ=
X-Gm-Gg: ASbGncv+CoZhE8ufyIDdFDWWLFHePQT2n42nHTzGQD2zgXHuGUj9KLEWQss2tVH6OhI
	YNgnMElt90Neai6QzdP+MQM73qTmEssENLgmjSNqiurVwlL9+NH4KE/pEHFCcdofIMLPTDsySFd
	x+s756mNGBO8HrKnIK1wQZUc4teAtCZNyLDDV/0wi8lHmxySz1lvXfwQGG1SALJpIMnvzGSTLOv
	Rj5w3rXHJSxof6wALbuF+ZoIngM9Da6sJvmWHZG8offc5rQYWRsZzK5BVhZx3dbUxLIsQHgyINp
	4E8M5VVTkvLA/cgj0Fn3C8jfFkSl9LM9tt/+ifbHa/wrfmHiM40=
X-Google-Smtp-Source: AGHT+IHzgeDazwJkydeLFRDZlJB+78ZnpPCVIObI5561R3sveQ+bYTtJ7Gs3hSbcC1XBysdbzJSJkg==
X-Received: by 2002:a17:902:ecc2:b0:227:eb61:34b8 with SMTP id d9443c01a7336-22e1032b9efmr67449635ad.25.1746228712908;
        Fri, 02 May 2025 16:31:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:31:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:55 -0700
Subject: [PATCH v15 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-24-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bbec87b79309..19d5a3d5e0d6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -256,6 +256,27 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select RISCV_SBI
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select DYNAMIC_SIGFRAME
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8

-- 
2.43.0


