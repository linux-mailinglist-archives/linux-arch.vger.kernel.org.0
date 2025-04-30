Return-Path: <linux-arch+bounces-11723-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD784AA3ED5
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 02:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5014188FEDF
	for <lists+linux-arch@lfdr.de>; Wed, 30 Apr 2025 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9F214810;
	Wed, 30 Apr 2025 00:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Nzv7/mko"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7082139C9
	for <linux-arch@vger.kernel.org>; Wed, 30 Apr 2025 00:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972191; cv=none; b=NrfgltGy1xsnVvsWeouLlofA07oPp8LL+pKX+F3DfL0J1hDstt5W+0645149JVKtk3blUwuW9Y28wIZDzLyuJYAkCoN9u02NcCGo91I1ghS5t53FTu6PVXJgdAaTeB5tBX0X6519qBWFvYnIA7+tUfxm5JLCs2ZZfR1hQPO9I94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972191; c=relaxed/simple;
	bh=07JIHRwK+fbY/KS3WXdAQFowggDed4ZKoyBK3fLGucQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkylzEMVW10vPniTaYIB2CZ4aPLKNkeuMiBgYV8GBklUAoZQoGYhIjWHSZ90Z39HxDHu5p3M3Ah/h5bXal4LVxb9JbQUnt1p93VrHERELb0Vo0gQw+aRdbiobh7InzJgZfxW1GP7ky5uobgMFMgUuo2AogpicvU+IcaoLzzkRts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Nzv7/mko; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224019ad9edso100153915ad.1
        for <linux-arch@vger.kernel.org>; Tue, 29 Apr 2025 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972189; x=1746576989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkVK3bviqHN/t8JmfUhzYvFjjtQu0YyYqPmZLVGI/TA=;
        b=Nzv7/mkobhS1qwl3caSpbMi+f0htEk0T/vf7Qe1W5wYEr1P/pip/onTpADOa77EWPL
         VC5yH3qrd1yerG80gpoTNpBqBzsH/YKyr9yHicinym+UF5AFlA6btYIFcdbe01ZGQix+
         ur4iGwktyjesd2cnorq6wyIqROMMxpePJ2m2iRxx0h+IKFy7xzT6Q+pjxaqsS9kzfjl0
         CVNF0FtZtkP9ELctLcok37XoHeUgnpXyzSOMd7xGf21NX5v/MrHpwAEIWQWTXaRrD+ln
         XdX8GKmTUrslyWATKwGCsPw/EJqmlqpDP1ID9Fp5dqsXEG6b30GfgNlTohfxIHvz7Ja/
         yMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972189; x=1746576989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkVK3bviqHN/t8JmfUhzYvFjjtQu0YyYqPmZLVGI/TA=;
        b=L/Ra2E6SsDOgYBcqo/+K8c2T1Wv6EDGwAsBN/h30APWIbxp7W6wZbGGpOn45mp+mAK
         l1cRyJt4GxxpQJ1KUPczYlhdZZ7Wvev5USyI9N6Q7m+LuErbqRahLCbV5sFwNMZlklki
         KtxxhDUfRYoT5v0kLqg/B3Fy5bYQ1QoqnoT1S+Cm8Mr5DW6kFd8aDXfmrBlEtUQ/2K3c
         ZeOPbtSSjtqwyqmMYqzaG4z+n64XSR/tBL6S5eNJ8W9oxOGmhkMJWAtuAoGamf0A3DkP
         84iJZgSnS8Xld1uVl/8q4UWGdwA4eAvPBJ8E6xgqFTjgBUQUVexd9dVF1zrViXGvTTOS
         HZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXUGrr6SV5+gETzRKkBjJuskynDPwWH4ALMmTEOpd6GGCssik+6i5hxpFRoro/lJbUKGKfW37I1zMF6@vger.kernel.org
X-Gm-Message-State: AOJu0YzuUvDaNoD7LD2hhzqnJgUq48Bs5P4zPHwIgetHR5lAdm+KKJYk
	6gS4JSWLBm+vq8dbyhzlpTA2XxDWDHlVM1nAllM8tC9tx8kUW0w11dye9HLLaiA=
X-Gm-Gg: ASbGncvD1hPHfLlV8Mgwc7VwDrWPbirBaOc0zrmJ8GKXfOh737OQyMkZ6CE294D4qeO
	3xBX1OYUbyDc8uEjQxcV63jUjta6z4+lf6Q73jW3smb5cGpbJMo9QvRZltJBM/tCItfDsBAwqfV
	XWm+gMRpuca+0C3EilQBfV2V8m1D/GlP/tQRDXaL2ydKL+LEOeVOpKiOIeVhWmFsh1eyIfsPi8a
	DLhqI6LYXF/pJ185FbglmXDtWeIzQD2pjwGNBSpQ1H5oZm9Y6fqAmTcLJN0bdIFkEckW9thuuL7
	Yz6Gs4o95xgu0NxElULyKqh1qtVQPbtVY8edJP9btZdGzlWOVqM=
X-Google-Smtp-Source: AGHT+IEaCOo3UdLjB/YDRvV5wqIWEkwy6tQXnBD9FT8T9fOLPTePyGUVcVc/ygroOS4hwPE4lcSyLA==
X-Received: by 2002:a17:903:1983:b0:216:644f:bc0e with SMTP id d9443c01a7336-22df35192a3mr22839375ad.24.1745972189106;
        Tue, 29 Apr 2025 17:16:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:18 -0700
Subject: [PATCH v14 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-1-5239410d012a@rivosinc.com>
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

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954..3487f28fa0bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.43.0


