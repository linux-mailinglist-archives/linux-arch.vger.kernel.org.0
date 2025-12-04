Return-Path: <linux-arch+bounces-15154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73F6CA537E
	for <lists+linux-arch@lfdr.de>; Thu, 04 Dec 2025 21:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB97431A02A2
	for <lists+linux-arch@lfdr.de>; Thu,  4 Dec 2025 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4D34B414;
	Thu,  4 Dec 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="a586IL1I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA06234B41C
	for <linux-arch@vger.kernel.org>; Thu,  4 Dec 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878648; cv=none; b=epPPEb7VoX+t3ISPpQL+ivG9ZQeYqHF2VadRYewwx9bmxOCDpeCawjNGCLO1oYZQ1qhW+tYl5VoDTAMWNKAgP9gR17j3pRPhFXnkVUpmSsJqDy0oOeskX/wArRCgA1kcl1xazcDO1Nq4IoSJDiRNIEFbm+eJPKdy2OMtFY9xyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878648; c=relaxed/simple;
	bh=ZNC9a/En39m8CKIDJtxwHFeTcpc9wzeOUsHgDemdXXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpIwCPlmBsj590UM8vpkk16/3UuiFx4SpPK9xBv2HyUn9u7XHcUEUAgyPEqXyvc+QY9r8ipi3dolVA/cy3CrhqPpOLckkIuctl7dlsPF8T4/sPVkVyrsRE0TE0yUWTy5SmDDXhCFtmpaimwBcEEHsUJK05h2mhlXn+OBSxGqOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=a586IL1I; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso2107781b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Dec 2025 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878645; x=1765483445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dse2BU+tFA5XFpg+kLbFKrS+f5gCoIar5kBy1XNyEFE=;
        b=a586IL1I58Hzh+fn7LWKXcYw3WoV4V3PLjP628IFnql6RdMFryjQwfdz7t/Doe2a9p
         i4WEc7ZLQSDiPzy1gOvVA9cdWTreJapgsG4+1XM2ZCuiNdHop177GdDuz2/RDmIPB4cD
         +pCUkyLGOB+D5Ehik/oh38YWlD7YLzqj8B+/JYnfRS3qsOAp1MQ3kc0dMLCHsJL6pES3
         yK41cJlrHJcJVvBQDAYNphZ+6uLqbP8SPUlKxhiDpbYz+JSEwcAG2gIQzeqCvUc58wYz
         GWQ16bduRHTjHKfbDm/RHZqIfGgDz5je9gghLGDrQfDf15d/+1/YX87RNarffE3GvBDf
         Rx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878645; x=1765483445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dse2BU+tFA5XFpg+kLbFKrS+f5gCoIar5kBy1XNyEFE=;
        b=IMr0xuT3S5piT1IXXNnfAn0oQO/hvr26shvu+clwVz7ReA/iucRU86/vUUt5TQFRCc
         jcazT3uGBhl1xzak5kJTLBoOHnLtk0iXkkbrSt3T204ovV90baCBQsRXdk5/4444fksm
         GvDOhVqHK9ZzEYpZlhd1pl1Vau+pRMLzwoE5dIMW1V+23c1cC1WDmOnkB4OxH0AK5Lbn
         Vz9ohbpS0J1+a9krKd1wFyOxSC9EcCMSOIyijfdIXCbZbRHA0ngs7+Ohnz+DPpDihyvl
         VkJb8VSFPQAf4947/Ja+bB356gcUMR8l6SjcNB/tIAlnmI8ZV3MQCIsteEFaKSwlGI1V
         q7eg==
X-Forwarded-Encrypted: i=1; AJvYcCUw/1zg1LlakyC/h882nUoIDUF1ayfdpxMGRefHLWEh8hTTzDBTo0Jj/spv17ewfGMSVdU0b556IFuH@vger.kernel.org
X-Gm-Message-State: AOJu0YwBiBNq0z6qurNDZiFdIDig6Tw1ddPBKfh7zraLuedDJK/xOdTP
	3UfKcdZ02CMvdJ5LfVhBq+eG8hAkkVrptiq+x9Rn3JpMUHr+okh5IrWXnfcVaUwoPho=
X-Gm-Gg: ASbGncs86PQ4pxzZPFjoVKoUfnjNaTA1zzVVaTVu6VWg/CPZ+tmp/KbdKuYwFEDVMkZ
	mxgVCTCOSI9S1Me2Z+pz7O0IhFWERvq4WWD72GgWEWkgnlUbcT1D/8vQdNCSrT0n0SExbFnTDVE
	zHKo31EMmN+VjqeLU3X5d3qvoyeHauffAyCQ4z/qwN4VxfJOWYEtlli6acys8J5gy7gUJ4t8tGu
	mf0KXK83mr7b186kPFeDbM4QPMLKYv0rakbUatLY6Ene24p0yXIzkmdQ1+7CiUdv5Rbqb+ACPO/
	N68XQ334SVkM/e47X5NWhvpWU+K4+z7O8RPZN9Ioa5Yzehvhrhf9uN1IoFECSzY9q2V/1/OUJ9Y
	2XbK5MUMCUpYv/agdXp37rv0IAix0OsKpqZcODOxpL5TMd3hQbBo9dVzVTpUJSzxdnYrcq1BNGJ
	ivAjG8tLy0CNgEPDnG5S28
X-Google-Smtp-Source: AGHT+IE6g5en90WXrl3ZEnboKqts+eBcZS3P4Z0a/whlRK6sw4bJgNhh+d5L/+hs3tXCG2T1uDOqfQ==
X-Received: by 2002:a05:701a:c949:b0:11d:f682:e475 with SMTP id a92af1059eb24-11df682e6f1mr1767600c88.40.1764878644680;
        Thu, 04 Dec 2025 12:04:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:04 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:03:52 -0800
Subject: [PATCH v24 03/28] riscv: zicfiss / zicfilp enumeration
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-3-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, 
 Andreas Korb <andreas.korb@aisec.fraunhofer.de>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878635; l=3702;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=ZNC9a/En39m8CKIDJtxwHFeTcpc9wzeOUsHgDemdXXU=;
 b=5o2zU5rsxOxcJKC2p1yqW7GuhtDJPFoThZH8CdeiyFSiUJMGHC8P2JMq2k+6z9+4nWVfwRGik
 1gzSe/qpXZgCW6LPHP+kjurdK3b0lQ02ZbqKtkuHdzcrl2GjgJMK9O/
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

This patch adds support for detecting zicfiss and zicfilp. zicfiss and
zicfilp stands for unprivleged integer spec extension for shadow stack
and branch tracking on indirect branches, respectively.

This patch looks for zicfiss and zicfilp in device tree and accordinlgy
lights up bit in cpu feature bitmap. Furthermore this patch adds detection
utility functions to return whether shadow stack or landing pads are
supported by cpu.

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h | 12 ++++++++++++
 arch/riscv/include/asm/hwcap.h      |  2 ++
 arch/riscv/kernel/cpufeature.c      | 22 ++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index fbd0e4306c93..481f483ebf15 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -150,4 +150,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+static inline bool cpu_supports_shadow_stack(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFISS));
+}
+
+static inline bool cpu_supports_indirect_br_lp_instr(void)
+{
+	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
+		riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICFILP));
+}
+
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index affd63e11b0a..7c4619a6d70d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -106,6 +106,8 @@
 #define RISCV_ISA_EXT_ZAAMO		97
 #define RISCV_ISA_EXT_ZALRSC		98
 #define RISCV_ISA_EXT_ZICBOP		99
+#define RISCV_ISA_EXT_ZICFILP		100
+#define RISCV_ISA_EXT_ZICFISS		101
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 67b59699357d..17b9e77bafc3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -274,6 +274,24 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 	return 0;
 }
 
+static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int riscv_cfiss_validate(const struct riscv_isa_ext_data *data,
+				const unsigned long *isa_bitmap)
+{
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+		return -EINVAL;
+
+	return 0;
+}
+
 static const unsigned int riscv_a_exts[] = {
 	RISCV_ISA_EXT_ZAAMO,
 	RISCV_ISA_EXT_ZALRSC,
@@ -461,6 +479,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
+					  riscv_cfilp_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
+					  riscv_cfiss_validate),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),

-- 
2.45.0


