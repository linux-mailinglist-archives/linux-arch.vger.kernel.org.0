Return-Path: <linux-arch+bounces-10103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3A1A2FA9B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 21:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EE3188540B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FEB262D08;
	Mon, 10 Feb 2025 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ox1qEj9/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A31E262178
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219264; cv=none; b=ULSeFMjSaYvP4KGIQF7RPHBfx1BNzH9VwvKj0zxQvPdb86DtNqbcKbLHr1Vr5FHEUeIwoen9DY3C+2V4OAtstcp3orqYFzV//HqtyyL4JZ2HALmtO7efe95c15F9FfEsjWSm6mmU4PDsaE2rvsvYjK19T00ZmyZHQvRSoGyeook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219264; c=relaxed/simple;
	bh=Eua84f2QnuJ0+u1eEfH6+3KRo1p7kHINzNbKNk8bPkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXxiTHbJpZnCBIzn3GARNqAcQWZmo0S9fDOdURH0zsHfcNudAK29YwT4GDb1mbwZQtQfyp9n63cajLJku5oQj+jSE0mbOjXltqngmuVLUFIsYh4KyAXqh5l0vx+n+LTtH0S/J0/o2Ye3S6WuF0qm+o5UZZoSM0yP4F8mBnB0lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ox1qEj9/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f4500a5c3so93767905ad.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219262; x=1739824062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=Ox1qEj9/ta39TC7S3n4ObyzPvseFq1fDw9iDUqF6RnLr3aqFd8V/97GYnNvKojGVUy
         hJAevFaQJt6+FhtPv+BnEX8rt/OnKHtBOjxUH3XMY8zxC+TAGcBJzqOSAKausEB9+dAC
         lB4xRjZUk5xi4YiIQ40whB+YUGvlyPRviQ3W3wBcBQxWttDR3Jv7vKJqvcNM4+fOiORy
         NoJ5x5qAWIsDJ3GtPTRm01x9H8tsPUuCQ/j6RWuWxqT7008SUWmwSGAwOyae4vwwwy7W
         7terdv657O4kSWVOkfBh8Cq/jZmAbQsPgX4KswzmpA7jAP1lxfnzkHCYCzBHNPDIQnTw
         UaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219262; x=1739824062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LN1OOVFFK55bIQe9Bj7KSCICvDpdODqLxcVYOIQy28=;
        b=pY7vtEQJKwu5yduGG2W8UsbtntqIt6JEQjT060z/zX8sN5VopyG0D1tnGNM1bvV6bs
         BoT8lzAlipAxzCCimwZtLh+a1bkxhDSgnuKWIHAze+veWWa3azUQ/Zy7KQeMAwGfXMDs
         PzugclVqrcQR/iJ+eLkfqD+sd5taZC6mDqj18PseqN6tH63fxw8kQSME4XvpKoW0D8xk
         1gBBHZRhDnBB33uyejo+vHIGRJ20P6TCLS0HVBbP9XJw8LU3iOU6M40rJM0zF3iVhEwo
         dh5XNdAGBhrOpVvIBnX/QFxigzIEjBakUFg7flHps3z98CDwUGUFmh6axlHHEamC9Fes
         uxVw==
X-Forwarded-Encrypted: i=1; AJvYcCW0f1uFn4Cuw7vfMBjiYQ3zSSTbc04iOKReahIfYwaR9r1nDs6DtoO0h+s7EtwPYPmxcfIqhCSq4sPM@vger.kernel.org
X-Gm-Message-State: AOJu0YzoV+BOSMXk1EiTtk0K0JPPSJcJMbzisw3KWzpjITA4qiNMPbc3
	0CIWELAjOFsrbWisWP8bTKcWtwm2BWSiYnXAVUgezi4VdeuJZfNqEm0YsfE8DfE=
X-Gm-Gg: ASbGncv79q8o1Lc8BRCP+kK/xiWxgMpg8EH3hHB4YAFFc987CgxMMCkBN6R3+mWJzw9
	em3Xtk4GoaplBmFmq+depWcVey7b66VclSmzIU/QmxZNRs09bZLict97BLRaWzMIzVcC3x9SLhL
	HCeIqgOtGJNr28sjumITD6vQgCZjOI+myTUJ9trTUrE7C0xm3coI8+DKjE7Iss7TMLYX/tUYYML
	eDEYZLKVZmzi3Qu0XNwEWjv0cN+umc/y0bTyyzy7vWsgMRVXPyLmi6eLQh30JCsjIEir14BGN6A
	Go5dLaeqaGIqDOt0Fzfsfa0ELA==
X-Google-Smtp-Source: AGHT+IGvJHthtMMIotmYr/CK0oOoURKWcK3k+qdOAPpSTfBW1H5FZ/zO8d2C9jHOqU/wdcn1U6s6JQ==
X-Received: by 2002:a17:903:2311:b0:21f:3e2d:7d36 with SMTP id d9443c01a7336-21f4e6ceb59mr270827895ad.1.1739219261893;
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:57 -0800
Subject: [PATCH v10 24/27] riscv: create a config for shadow stack and
 landing pad instr support
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-24-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`,
`ARCH_HAS_USER_SHADOW_STACK` and DYNAMIC_SIGFRAME for riscv.

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
2.34.1


