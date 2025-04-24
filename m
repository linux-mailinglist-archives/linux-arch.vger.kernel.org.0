Return-Path: <linux-arch+bounces-11547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDD9A9A3D7
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A392181D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47E622F743;
	Thu, 24 Apr 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hKhLV/dE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373B22DF8D
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479307; cv=none; b=aX67iqTUJk61jLC8fZ5YCIRE/Nm1uvES0+z0lBB4u2EeFPxdt8jEnN2lmfuI05kTfTmPlxzDdht8VOCWdTIbXDCRv1JhbDcyH6GcXtnHiURXxReMfYnAZ9G5RHpxwpUYevV20btR6eVmQ3kTGzS1O/3WXgEiiqv97CKLr7/9Jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479307; c=relaxed/simple;
	bh=QNV/OJ0MAi9tudaVFZ5sewMbWU80InTqxqBUk73lNbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaRZGVmshUVmL77Ew+6gs17UA/8R18TDHRrJL7LFb31E5UwNPhBANOZhLbDyd+N1fgy5zViYFlO+v4PvL3hiBbk7vTE2wUbqvCeVBDdcKm5YtmBFcrMP8RYkYtRiuHyCJX2CFJGCvzdUvkxpouRn16zJ3P2tomRMocjSBIOy/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hKhLV/dE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so7081315ad.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479305; x=1746084105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBVVSv3Y/KskuIA9vtQck5I4HmCuzlUiTDqTTZjwDSs=;
        b=hKhLV/dESTW8on+kH0n2GLICr4sRqP55SMRP8N2gd+uCxow8QtCWKqAg3KVENXHaOo
         QC9B/tBD+cylO2V8M3hdDz5OSBC5vZfXVjqEOgu11MUUEaA0tWrKAjmrH+3OBVFk/E5p
         t1Ply4pHwA6HD4+saswhcFzHFEKURmHsClT03xXcMb8dWLnhMmZqf24IIm+4J39OqslG
         k5cjgDf9OBpcRsYXNzILik3n3U3IKO41HokkzxfVRv1nUCbtQq5a+LoDzFC63aSybFNZ
         9IRi9p6mfpebMp4XPGtYlKfsSqr6wLJj1rqGB/MwJ1/lBBwiFIkpTkecAzyCkOBS6aa2
         SFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479305; x=1746084105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBVVSv3Y/KskuIA9vtQck5I4HmCuzlUiTDqTTZjwDSs=;
        b=WzX4V09rnIXVmcpWJdwI0rJABO/XTjmefcMoLM08CKyuLQ5fmzmDA9qL2b4xCo6l+M
         eocpbytHZiyVWVxFVaWn5cmxMhwE6NIYCCLgcdu6/ZsVl+JQ0yNYSzJlzpCxjRn9lRxN
         fv/EPL/VIvrrucN3dlSSQtB8R1X+6NE6wFMi6iCLB7VyzfxdpUSxtH/38HRzUsfI7jOE
         vV0Vk+sdWivcF+E5J2G0+w7NPIoQbyKIWrBBZmkVPq0Gurajso6w/oZ0WaAhvU8M43KN
         go0sbDTJ7r5utrjv8rAkyoal5mZC32FQNnFSp2uUBlOewEkFS43mbfiSUehVZ6xmw8lN
         rR5A==
X-Forwarded-Encrypted: i=1; AJvYcCWNG66sj9AddSaywHPPApzedjGtJzjq1FA7bxRLCPwNs3OfjKqHOyzjKfG2i827B4DCq1k280/tnzu8@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXChNDRGvkzEndzfg31x+STkIfdMVIt/5/oYkw5yUVvnBs+Er
	I/eWoahPuGMTNC3uXniMoBsXUBYm9ed29EGn9r7WVz3dVAbb3RrX+W+useQ++ew=
X-Gm-Gg: ASbGnctxBMmbHYW0HVcgY+ye1okw/iLSnVJmTNHXCPWuB0/t9CCncsoMcEuBMPHBJza
	3a1rvX7wVGBEkNXfFRj67NckqINH/E4RUSzUHWPS9uC9dpFkWVI1l7E1mo8+WcRPVk+uI5X50B5
	JLN45+t5ZSV0HMK6o0dLvmemMcOLuEK3+ecGRpUAC0S4pNuNYUTc1VoiQwTzZruQn+9R9y8NynD
	D/KvWdpEuAx8hyQiHAN3eyQZB3k3QWwz0oBLuCTOEVmz4ccVZnip2kraty4N/Rw8uGW6dWX3VLO
	xQ1/dkwzfycEN8xWPnU8ITPgE2cCw4UPtT3r6lxdEdYgBmvLH6Q=
X-Google-Smtp-Source: AGHT+IEz603dSSTLC0f4nDj+eBljayGhTKs2dK71FM32ph4jUbGIkkRXg43iXBmg3uxpH4oHFXtC1w==
X-Received: by 2002:a17:903:3c6c:b0:224:24d3:60f4 with SMTP id d9443c01a7336-22db3c0c083mr22910175ad.15.1745479305054;
        Thu, 24 Apr 2025 00:21:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:40 -0700
Subject: [PATCH v13 25/28] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-25-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 arch/riscv/Kconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..0a2e50f056e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -250,6 +250,26 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
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


