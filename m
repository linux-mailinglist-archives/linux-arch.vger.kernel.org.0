Return-Path: <linux-arch+bounces-10841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D34A61E91
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 22:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73BB5462AC0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029D2066DB;
	Fri, 14 Mar 2025 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fyX3ALUT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EDE2063E5
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988381; cv=none; b=ZLg3kwK9q+/4Co19DS4NgiToBltGm+a8qwCnuCrhVFCdqGyAXkmd7r42Y/GOvodCnc8LXIbBK7sl3bkcARa/lWDmPrr0nJoobd/WTLlEufB4MD6HXTX57vN7alvVshrVRgGXTHM8UfpnNufhJgrW9/ErpS1L3hQP21xP8Dq5UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988381; c=relaxed/simple;
	bh=f+s1qRILk5w2zoTzbSGEFuSk9CM1mNXrrF3BbhojAEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hp5Rvj0jFbsLzjY2QJdtTtY0RgJm8OGSWUDc+GDKK8N1/wWSfJ766Hs5UDO+ZtQV7nHoe/w8N8dAoaF4/9lpwBInWgAdj5yjwXF83B6HI0hfuRX3/FmCf1g2H044ErePi3Dg+M9Lk5/Obq9mOC6kUa+gEoTsbEGYU/u5EBVyJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fyX3ALUT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239aa5da08so52105985ad.3
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988378; x=1742593178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3DM8zy+WllPP0TujEXFZ0Ycc0zGrpNRrMRWPkPmGZc=;
        b=fyX3ALUT21XzQ/tTLHBP7zn7xTYZoRJxjttTGzdYai98Qgks3LfWXQ+tURAKXuLkuh
         4sL9sYmPlm7yM0YcCxfFdEkqHxN3Kv3DVi1yaZQho7KpogPYTfEBVqS7W1qukJmLpCKu
         BaKcF9qJMYo+DonDW1zRu1zJEXdw6089RhKlsdkjmrKAJoxCkc+btprY5NJqmDxT9IHg
         1S8lxIOmVZ/c1R4Pimmy83SIcw3QFPI0LJGzzLUmu6/KcmvNk9HK9bB5lr5+GUL4qssD
         L8bG4WxbPPGn3ZVYpgFsPOA2B2vAlLDaPwkIS77clRg2W5GY+8wlci3kQwP8A34QBj12
         KH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988378; x=1742593178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3DM8zy+WllPP0TujEXFZ0Ycc0zGrpNRrMRWPkPmGZc=;
        b=nK7cOHlOdxHvBY20YXrzRrOg30fb+KAKfr41PvXe2ruNAoI8cl3sdj8cnSc+iUj05y
         ZVwM+9k46zQ4f6c6w/ozd1E0H0OjJZyCKJw40JIh/J+pw60u7/7sdYa6cr3LJK8sXu/P
         ZosxuCMOFb3Fu0jPYNn4i6pSJx/py2blnTiWbtLPSVDBnCCArOWqcimgZDvliBEnGDIn
         qtoKe1uoEMJuJ0a3HgLBJUuBoqzQJJy9SsjqrEG4qMWxvxRmWdd/IbocsMI2aa9wp9Bu
         RH3kfwsF0V9GU3dRcNP8D0UbtuDQ6BAuZPA//PkqpqjQ4yHVqowHiy2JZYZmsGXYE50Y
         TXyw==
X-Forwarded-Encrypted: i=1; AJvYcCXAue1S4aKyU/usZ9W/L77cxccOcfFgYY8l/Arf/jY4MLxDpwvfozfbfsSPKa/eMGRZauZnvLeVE65x@vger.kernel.org
X-Gm-Message-State: AOJu0YzaqrEEmgJty30KfddqB7IAg8xBt5o3TF2+XulWCPFT4/B6A+0m
	D6Q5xlF8MqLjq8nMkNcAvkFnmeEVda4EK+LGYRnbmpHm1+CcxNT2EmdyIJXTWg8=
X-Gm-Gg: ASbGncsNTS99E1VDVQdTucFWQXdSLTkD6pE/1z6CCBGcA9twAiKWuoOhk3xbyTgeaJO
	OWFQF4JU7vuegZs9TEnHrO+GjQ9WhyUiCH8FMrAzqOaQzAS1/gR9NilBKrT9GO8f6ZGXixzl2Pn
	7LLkuihwaAz/iajbJD6VhTRMl/X8F0fKLZHYC4ETGYf9LfHSL6/K2K3ojLLsr/Dhuxa2HENVr/x
	qZ7k/mXZ592JD6ZONLJ8Vqa118sVRDtgUiT6PgNIokFx6U4eIwk3rBw/qZ1+odYbZMkZQ8s7XPB
	4MMQIj4ew9BevoMsFU1vhVqDegMrzKPGJ3XvI6Re4VGgUJuIV6CjOTQaEaRf+lpdTA==
X-Google-Smtp-Source: AGHT+IEd6y00tJpY5AwKZ0G453WB85qrfmfVkSTQW7JFb/Aht1BlD2RcJLOAn300bIU+BiCy9clyEg==
X-Received: by 2002:a17:902:cec5:b0:224:abb:92c with SMTP id d9443c01a7336-225e0b19692mr43817135ad.50.1741988377710;
        Fri, 14 Mar 2025 14:39:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:23 -0700
Subject: [PATCH v12 04/28] riscv: zicfiss / zicfilp extension csr and bit
 definitions
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-4-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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

zicfiss and zicfilp extension gets enabled via b3 and b2 in *envcfg CSR.
menvcfg controls enabling for S/HS mode. henvcfg control enabling for VS
while senvcfg controls enabling for U/VU mode.

zicfilp extension extends *status CSR to hold `expected landing pad` bit.
A trap or interrupt can occur between an indirect jmp/call and target
instr. `expected landing pad` bit from CPU is recorded into xstatus CSR so
that when supervisor performs xret, `expected landing pad` state of CPU can
be restored.

zicfiss adds one new CSR
- CSR_SSP: CSR_SSP contains current shadow stack pointer.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..2f49b9663640 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -18,6 +18,15 @@
 #define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
 #define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
 
+/* zicfilp landing pad status bit */
+#define SR_SPELP	_AC(0x00800000, UL)
+#define SR_MPELP	_AC(0x020000000000, UL)
+#ifdef CONFIG_RISCV_M_MODE
+#define SR_ELP		SR_MPELP
+#else
+#define SR_ELP		SR_SPELP
+#endif
+
 #define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
 #define SR_FS_OFF	_AC(0x00000000, UL)
 #define SR_FS_INITIAL	_AC(0x00002000, UL)
@@ -212,6 +221,8 @@
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_LPE			(_AC(1, UL) << 2)
+#define ENVCFG_SSE			(_AC(1, UL) << 3)
 #define ENVCFG_CBIE_SHIFT		4
 #define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
 #define ENVCFG_CBIE_ILL			_AC(0x0, UL)
@@ -230,6 +241,11 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/*
+ * zicfiss user mode csr
+ * CSR_SSP holds current shadow stack pointer.
+ */
+#define CSR_SSP                 0x011
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM

-- 
2.34.1


