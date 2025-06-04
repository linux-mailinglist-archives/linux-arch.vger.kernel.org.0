Return-Path: <linux-arch+bounces-12240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28890ACE377
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 19:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DE33A88E3
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9F25D21A;
	Wed,  4 Jun 2025 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1t6DWDGX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581725D200
	for <linux-arch@vger.kernel.org>; Wed,  4 Jun 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057450; cv=none; b=ewQrbKkFo1rfK6zVkfq6rgkVFQlS6xa5Y83JDWBpsrKH3e/at/sZjq9c/lRBFRXD6MVp4nZmsTgxTjfVBVozHdD5/DTM+vzOXftLtidBF1ZWzoFajjp6bLO0M7YCmoskE1uRz4l1S9uPLJsmP9zDuOec0KVweSgTKzQKws+SFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057450; c=relaxed/simple;
	bh=YhfdOBzKEEebS8YngpHiUP828c0FLw+RSd9OBhsOuOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/jb09V48iiuTuHvLtpb3aFkgrFUp1jCM1Yis649BKEnWeUCHIBu/m/3VhD6c1EoEgKnsvYY0ecHEB7HN4yzzvO8ZXdqPsLoT7eclFzCNoYHXHOU0VIJp8P8JDC1rzu1gW1Jfe0p3aB0LOVw7zhM+WAnmfUS7E3sjt5cXOve2UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1t6DWDGX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so79324a91.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Jun 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057448; x=1749662248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=1t6DWDGXL85bnyW6DwbcUA4nnIMzJ3z5/DMR1vtpsHCG+IV9kF4eduBG1tA9SvxLHS
         fpd08CRFsamOhZcZs0RiKju06O+dMwx9KpHEsK2KUmk1LQVud8Yxjf0cGSOGThunFbdf
         GxYLa0LNr9zkWKq/7TMoGjtfnFkH8xuxQEMPivrmzlw8LOwVXqviJAdAwxLh+R1eDHdA
         /uEwmNhcX0L6VB5bVc7Mq+K/LunZhYixShUCdvfxDPw2Fo++xPc36JC94nlOMiEDFOfu
         g9SY9mxf7vnQa32GBKkVKCTWh0UTMXgzEhMh73RrIjlK5awJCG+4efkE/jcMRX5lMo3s
         Ds/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057448; x=1749662248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zd01FxT3OlMOzWqIaODnmoUPnuHtuVmONb+HNJjd/YM=;
        b=QbUwZtlKbQDzqlKqBSs6MGySE6gM5SrgWcHxtjYmE8Bk73HalcJ4v0So4BbqrkBsoC
         DP98/OLMFRV7pcCv/cGnkM9Td5bUKe2YE5V5oLTurPa209PSmDRHyQnVjiJlljpl/X9r
         qB/Z2SVg4OgI4+cPxLTfGWwuXM+DPp53ALAe+twN5g1/THX58ekeBy47Nxg4Q1tumc7g
         OomI/ZpKAmg8WmqZSOkr1FM4D+/O7Qf96ozZoXh4WN9lvNe19E7kd13K8XfNfC6qYTPr
         7OIKp6mjqoR1hynzUIDE99nrMIbYKMvHWVGzjcH13kyd2Z+8ghfv3EbEI1Wd6pjRcBIG
         ixOw==
X-Forwarded-Encrypted: i=1; AJvYcCU4Kp+qWMqcECmjxTOf3oQ2wBrJS6r69YpNvXLYaOwkh6q6b6IDX+6Nu3EYmkSGO9dpSQb+IJlnElnj@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNoDwcMT63AT/2Wmm6zS5+kWXk6bfp58LRVOsQXY56nopwqUd
	lwdIJq0eOdLMnsE1d1RijcttHaMY0Ej9pQ9iN/fpFagxwjBxzNHsLnqcq7DVZBkaICs=
X-Gm-Gg: ASbGnct72crSkb5YAoNKMIudsJxJCn67Nhs25VP/Zz5U23t6uvLWNP158HF6TNppDxy
	eKlmiaIAq85ZFvub0QmNyjpRQCjXytQ5FzKYFrL+xR6PUqKHc28XcL3fca2Ks8FHh+q0WyulnRf
	IRnFblcz26Ta4wVkUvHcWipmFqRFOde8uMa1fvExA57LGAimQCsqeHmZigxPSXUYk0mN1Eg8RBp
	KNIOz0iYlJ8rWLr3wztSK4M5d4G9OXsevmwTG7dhvzKOcZ9fXDNhDgursixuIeYoXC51Dgh+ygQ
	JsxeqPgyVZS8n63XyJBIqiykhNEtO5XzmPdbO68CG72gVfPFkOUROXhauv6rxQ==
X-Google-Smtp-Source: AGHT+IFWkJ78wFMwg3GliR7Galn0PbhhfnyCNBUVVp6rLtdMWNFL3ewFiC9H95Yfi/uZOn7VC4Cxkg==
X-Received: by 2002:a17:90b:3c4d:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-31310fc4f72mr4513419a91.7.1749057447912;
        Wed, 04 Jun 2025 10:17:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:17:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:48 -0700
Subject: [PATCH v17 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-24-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
index bbec87b79309..147ae201823e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -256,6 +256,27 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool n
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


