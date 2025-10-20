Return-Path: <linux-arch+bounces-14200-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FBBF361C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 22:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4130425A66
	for <lists+linux-arch@lfdr.de>; Mon, 20 Oct 2025 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB012E2DDE;
	Mon, 20 Oct 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="bx8csSAb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6962DCC04
	for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991762; cv=none; b=XuKp+EzgqmoHtbLwjjAR/WRLzPfXPR+/Mqd/SN7H6/Lhat2VO1+JPQBjstnjcfFgx+a9FBRHMYuvH2yv0b7p5pKQ1WH/GDw/x0yaT+0N7YMuVpVeekviLRHis8jGXqKIgSQP1MaZLo7cn1Az02Y53+4GbM8KuA/B9OYB1PfWxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991762; c=relaxed/simple;
	bh=h7+45OcDo8mC8F+qfVwlj7BDk87UYY0zWzUeH8BF0jY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRW8bfLaaq8U5uwaQ87KWHab6Gv17mO9r1NGyKs3GdnlPzHsz+y/+flSzux8ua9rSJLKkslw4gNc5dmvdkbYX08gtphw752X2JRTq9OM+2J8mxIxSQSIewoJ3VebssmFyTHL4LJgO2xRGNFPgG52RjYOL8uAmSmB1r9iBT0lY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=bx8csSAb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27c369f898fso68885825ad.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Oct 2025 13:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991759; x=1761596559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJyf5Mfx2dyzbSqpH6VID/K8048gVV4D981NLyY4E6w=;
        b=bx8csSAbXrK+UDpKw6v9spD5zMeYyOdQn8Jv5XQkT9tjnraW8Zhq3xuHZb11POFPGS
         YxF09kM+TgeTxx+9HG/ulytpQBGd0NrODrH3BRF5/NU6FAX/0kgXZvbQEIYrDQTjsrOg
         aH/qS5bfzUZrsgHiaLoSC2lPn0xjoB5/LjSutwXdluwjdBABXsDturE+uqPnKyEhNRH/
         L6wiUiYFE1xaeJhQcoJm9gdWtHQsJsSbCjp0KVD3x2AukjN7nHpnkvkp2AXAGNipakhi
         TNnOrXetApfQryvGSXJuZ0QKJW/DTgy05Teotcmj3n0nfJxxx3UZKy1LMK/3SqRXCt3/
         w8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991759; x=1761596559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJyf5Mfx2dyzbSqpH6VID/K8048gVV4D981NLyY4E6w=;
        b=o04RbeLfoRAqJArk4nYGibr/07FSzGG+99jHUA2fxJgg1kGsQwLuFEsvMQIrqq+PUe
         bWVlZ6KdrfoieHRgc84GwjL3SjYCWBfc55IUA36DMeHFJN2m3fjvqlFN+PpHiPEu151A
         mWPgQRLMZjLPSK7PQGOAXwSn0j4wpNxM5hs8zspV+FoIySTnms/QDFuV5ZSphaliWRto
         r9gF02JuMXJDXiygYWkufBrSOCdnkcl4dpgAvLOZNOC2x0pfbYniYmEwNm57ynQcmpiV
         kZhsJ+uu+ONZIl/l5xGo9sbQceRVpIcPqpbMBsx4PEQDPdgU2cP7Djg/OcHNovh39dnW
         /7FA==
X-Forwarded-Encrypted: i=1; AJvYcCXH1orRkgRT8N1d0O2noPEtPL5GVUS1sZvg4qOpumBpAazxzaySLeDiT0HLLm8H/uGhCXp/yAfY4bP0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3fAPrND10pVHZUdFBvHJc2usH/0C4wV6HFSHT5gz8NLrW9AC
	6tpM15TX2CDzr3DFhScDoQPzevaTTUvzuj9enUsIbP8OLaJPIVcgG3M3Ts/1vwStZFY=
X-Gm-Gg: ASbGncuKzM84M1D+1a7oo9DufHfQISBhSGW18AFfO6NsMCwnUgQMI8gIoYd7gS2VTO1
	fA49vF8ytJfwIvZcxh/GCpHC2gDHZUMNczmjQ6xfH6E9Wac/RnUbkoGRbnialA4IVA05gZyUK2b
	i+rpKEIOmx80+wt8ov+zgGxEfoD3RnSwbDoSJro3OVznKmomVRaCq4V7VxvpGplK+mSo0MrtTrU
	snHkcDHs32BoBwszFp/RSjgBdg1IUYt+NHTb4SehE4/R6N6tUxZ2bS+wd/jmeG2XAyzOKT12a0z
	GEGK6jOs5pE/1V981jwWqWpeZ5RhlRxeC4mr29jC9mKc0dTo/boIQiCSuLZYq2PemJXZaOq/9oO
	YieigUUncY4XcDlVnY9v/gk7DD7Dmq0cTTrh7SvtHrPhqNzwUxBdbQgKo/9VIxZAOMc6kY+9615
	BnpBnRl5T7pg==
X-Google-Smtp-Source: AGHT+IG6TVxooarevlSjW8zrVFT+uyU8PdreEG2r0xgjTATLXR8OeKKNJ35yKTRzDmtjqbRnxjjd+w==
X-Received: by 2002:a17:902:d4c4:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290ca121e99mr205845775ad.36.1760991759471;
        Mon, 20 Oct 2025 13:22:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:22:39 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:30 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-1-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..2032d3f195f1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -380,6 +380,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.45.0


