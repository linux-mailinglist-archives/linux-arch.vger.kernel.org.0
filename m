Return-Path: <linux-arch+bounces-15234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4998ACA8DA5
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E403306259E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 18:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA5534C820;
	Fri,  5 Dec 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Uf39Gdby"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAA334AB1C
	for <linux-arch@vger.kernel.org>; Fri,  5 Dec 2025 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959830; cv=none; b=i1BgLUI+DCwQeIoLvhL4kbb2MXhg9gaX6h72J6h6ChJo6R/2/5jR1dB6BKUQSKt7wqi7uL5qouusE3iycIOUvpw0l5Ze9XZBr423RY3QHSRO9NXKqhV8gwH6XIVaFPLYBAQwQttJ1bdaBQx3LaZB0oalhP+meqOU+RHos+f6si8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959830; c=relaxed/simple;
	bh=nBM+gKOHTmPMkti0DTh5flAX5grcW8t0U+G6mikLn4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfyzLP7LzqjFJkJMofn9JbnSeJMuAVuxKqIaVJFAz3F5T0POuBp0tVvtr9RgNkod7qRPjZPC2YQQxxuaLmXrDGJ+LgRpFG0T/3dUZFRUrftbrxHw7ZxoksKJ7PqMS6xhOn4+dbrbQVjAilZ63qTDDZX9Y9kij5Unyxu0ZRkB7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Uf39Gdby; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1596718a12.3
        for <linux-arch@vger.kernel.org>; Fri, 05 Dec 2025 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959824; x=1765564624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FldpuJVG3boWADnTyrci9WEZv61t3vqu/iLtDVGsedQ=;
        b=Uf39GdbyDJpxG6/UIPdzRK2vLMyumU7XVJoDePuaiUicMSpX68gfPdMRjx5uPdZo5Y
         HgOTDXXp4XKs1ImwH3oVcpE2t/pKmD8e7CZJCpfWuIQkerq9E4RvoWqkF0QoqXG7Btp5
         r0De2bDypsgR4zVuKZPyPohw/kamU4682Ghoc1cHD//mrAbFjp1h80c08lrPlCYKPq0W
         njRTRicRFZCLrrMgEFGBfq7kwZ4qFF8KoRGUUS9PiPZmaVfyscciGxcKbiBtxpVl4aOD
         9hOSb0Raz7Tn3cG352TmSycNvtdiMR/OZ17CdYeBHLn6xNnDrnyl8GVdZqpYFHc33Azh
         kjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959825; x=1765564625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FldpuJVG3boWADnTyrci9WEZv61t3vqu/iLtDVGsedQ=;
        b=muD6bSxH6I3+LtUsDhIzk3wSz0EL99pGvw4dz7OTKnvriPhRCSkiZTyaUIqE3NEwp2
         MSZLmGJ0hO1TScmAuEAwOO1pfyc39jzXrlVx/0saIFqiRoJB9DZmiVjgJkZyV8wXazvQ
         bgW3b9sn2G6G6xDuZsyDWYzE5XAgRjQykkd2S+8t0t7BOMpOGBR/gtQhY+tGGV7/8/QN
         NXu6Ymjzb8zVmlV+rcQL5VbbGbEG5fHhBszCF0ZqelPGTs1EWv20gwX1a6bokymkuATa
         IZZut1+Z6ahdd5pGHaF8GP1QPCv3Rc9YrdfI9tyt1eQI8g8ec5wM7b7PgXtf/fxNSyhP
         paGA==
X-Forwarded-Encrypted: i=1; AJvYcCWLSfqglEvpIpuBbMAQ9QmLptaq9TXHoidfZ6P6ul58QDBwLn6sdfsVeqXdEfLnIskTFXcnO09jqCSO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Mux3ALXuct5pEG3YFUdfO0XVAVXQhve6/bfZl/AqBJ345Eo/
	mT0i/dk4zoL52DpxqaUyjujOY2iWWswrjv7Lo6SO4EDyf/UXJKlZHs5onFuCFuBubl8=
X-Gm-Gg: ASbGnctV2iYWNxCGZtbVrYhbetAGYaPTaPtkzqPoYziC31XeJVtQuz7C/azbGMdxE5z
	S3/kHooSys2IqeKDcrvF4zxk1vNMdIGjSHoLC03GDPzsQFTrulOu4jHIvOYqurS9DBFNopFjqbX
	NuAvfP9YvOY0oAET2IKfCNfmt/dN8DoR5xZr+FQdw0aJ3uQ8C/JYB0BXuVbY9hj5l9HtI6lVUui
	aYdYxbRKbWwKB3ux3aFJC7gNhedjDsqrFWSnrVZPD/zR6VSqOdywuO0fpJflraSwGVXhLSoaP1H
	fbpJmw0FUanEw9njaAaugcaBf/a+XDiQ2VmUM8ny6Fu2KFGiaxHV/Eu/L/7TNt60qjrK87bmH92
	TXxXP1GZju3VtByYPCIM8Cgw0yO1UazuNAZsoWQRpWJB5e0+2akeGLj3PiEfIHssVE7+6Pc2G79
	Zzg03m9YsrrARTg5kuYaefTdVfDoEPp2Q=
X-Google-Smtp-Source: AGHT+IHWIa+CUlLJ0qe8tt+iE2caT6nKD2wfDSY1g0hDmU5iV9uKmwprZ5K8BpaoIbktQvNqImb1UA==
X-Received: by 2002:a05:7301:60c:b0:2a4:87e2:bcca with SMTP id 5a478bee46e88-2abc712e3acmr123339eec.13.1764959824396;
        Fri, 05 Dec 2025 10:37:04 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:03 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:36:53 -0800
Subject: [PATCH v25 07/28] riscv/mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-7-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1430;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=nBM+gKOHTmPMkti0DTh5flAX5grcW8t0U+G6mikLn4g=;
 b=oyiVB2mV2Xr0Lyb4BupLSuiXGMjHkUrkc1x6guHAqwdwHbYglV/kn8YYY3hQ4vZqsYqYf0IH/
 luTeFhKyqPYALE6hb1xL5HYvgU1E78HSbMsFrb/HbDOtyeGcM4VZWOy
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Andreas Korb <andreas.korb@aisec.fraunhofer.de>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4c4057a2550e..e4eb4657e1b6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -425,6 +425,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -765,6 +770,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.45.0


