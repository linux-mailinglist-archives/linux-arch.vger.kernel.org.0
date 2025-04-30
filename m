Return-Path: <linux-arch+bounces-11746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECCAA3F84
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD632927B0F
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 00:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F1E2882D6;
	Wed, 30 Apr 2025 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OIh9BZPH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB327E7F0
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972265; cv=none; b=IHQuNw54Q8SA5wJwAGpIQq2wAVrpZVuOBH06nr7reCgeRp+NPR0XTC1sNVUOeDiBkSm+SVktpMfg7MXo+4rM9slGtSCnLT9hDg5dWkW2hZ+0c5QrflaRDdHYCJ0JXTM/ncVuvg37TYK4lNYFFUIQo5QgaHlo5Yl0BmG2c8CDA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972265; c=relaxed/simple;
	bh=GE8Gm6miTPIzkm/uWfW2yRIZ2hw1s9BGH/sbAx2eJGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9BT8pKcwq/ddFFKmX1u3/sgyHrFQ9avzhqu8t0uEJ931hXj2edHvDaFGyluWKsLAYY4vpfW05u57+cTx7fygnQvaYx2BT7GjA3QjVuPnlYFba12IDVxSj92cim5jvPx09EKbmCJaUdte3t8wE/QfZFS0U0F5EMvnElE323esHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OIh9BZPH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2260c91576aso56493385ad.3
        for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972262; x=1746577062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNzeP/w/trhTL6cWe9Pecwh1mzcoQfn9vSNH+Q0tuaw=;
        b=OIh9BZPHwJ6jYY0goxjKk+XEnTQzcCvm0OuYYaiLa9J6Y9Dd6Ktfpvec8jXD8xHAx0
         1jfF0QZUfIB/sVKqGE648PcEoZ5ZVFJtgcQhQlbFldTm70ilB6NfbJsul/VMMA5nc/sh
         X7oa4o2E1BzFudbIIdwhnCs0/8tnCtJH6QqMXbq1LkX8WF/vtwzz1FZPoLqQGPxBYboG
         QyXY1/lcvxftV7guWaQ+2gY/eBQ6DR9IXJecxlQspEimEoPtkCIvlBzvVW/SYqJ8Wm78
         3sHQGg6vc+hO8jRZN4SAnm62vbYbOOBdEy6KUGrx4moBZ15/JDlosz3vilV2u41dp/oD
         OZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972262; x=1746577062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNzeP/w/trhTL6cWe9Pecwh1mzcoQfn9vSNH+Q0tuaw=;
        b=tMfgz+XG5Z9b7QHndyG4VfICtVtFB79vlEK/80sKbVpMOrUB6deUN/pizjWPtjvoQ9
         mx0uTKKA8gI2gtDuJEsTEX5Cdaipe5lN469UuSke9fMe8Y8Z1tV8gq5+iq9Indss3XKN
         IEzep6etT7CQiJZ/CehB6UsnjN3r3IgXBgVcUTIDE4c7b/ACzf5X1VwGAn9MgbRXqjdp
         neCwBI5Xh3hqTTl+Tk827QoNtZ6ccP/q8VJONrS3xrKXQlTx3ef33pXmYKJtAyc3gW8I
         sUOVNIOXKLlm80wfggsZb+SK35ybGxnzG4e2BCaxTj2xKDAj7NX4+ibJl6hE075sHgK/
         5kvg==
X-Forwarded-Encrypted: i=1; AJvYcCU6BdJj3+XqldnLZVNNwVnmxaGX1ZjYQqSN39e6dm4aEDCrqwgNheq6OIObX56YE046B8WAPhFAuJqr@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLrAQwEQR1Hp08m+eyo22JhJjVoOUySlP0ghyr8L6doJ/WFUE
	Dz/nebfkyFLXUnlixA/Y3kILKGBPXY+Bt49QITHQEXC3f5uNoZIjry3ZWI3xuEk=
X-Gm-Gg: ASbGncshQeykPNqvFmh8ZDDTwdgrbxo2SGitKZHFn7S0tyz+kdiJwkc9g6A+u1y+wNz
	1POKahek7w380KMWLzja3Rq2ku19xnZ1/aIud6/7t0opwwCmcmRXY7VYIg3MTvrEA/Us3xb3UiR
	6/Wga4q9L05COMKoAir2asUeRF/pawFvd045lIPukZkoVPvf2FQOU+4hreUZqKuj5N8I0Qiw0kX
	mqj0pGUgmJq7DIdhjIO3dnvjYMSHeXoQXyspiBc0Ccc9d68PIRhJDLvzVYb7jmL4LjJLkMQPQph
	YpYn8xt7uM4YQXcz3Qyzw+O1LOTR9uWeJS8N5I7Boev4nICTeMf1q8kPMVoi9g==
X-Google-Smtp-Source: AGHT+IE8bdn8tLEphSjIyMJDkn6ceb8Wnl4C2tXu5He9G7slYh6azYWKOO5c5aQwZY8zwfz/0/Deyg==
X-Received: by 2002:a17:903:2ec6:b0:215:b1a3:4701 with SMTP id d9443c01a7336-22df57a3f9cmr6603965ad.13.1745972262508;
        Tue, 29 Apr 2025 17:17:42 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:41 -0700
Subject: [PATCH v14 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-24-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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
index bbec87b79309..31ba88f42b1c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -256,6 +256,26 @@ config ARCH_HAS_BROKEN_DWARF5
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


