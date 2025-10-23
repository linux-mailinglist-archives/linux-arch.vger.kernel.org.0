Return-Path: <linux-arch+bounces-14299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179B4C0160B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1567189CC32
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4883320CD8;
	Thu, 23 Oct 2025 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YDanNtvS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A5319851
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225944; cv=none; b=lUM+FroYomGSsNlp1Ahif0X0Qs8Wgc9WrKn29J7H3dULJj4qLi6VxqeP/fhugwQZC68tK4RPlK60GsANfZ5SwOfJCbcZ0n1mN4YjuImAZ/ZmpemKsUI+jQo+s5Rvc8Q234+cJxlQTQ1ab0lOezNfbKcv1zCV69rCgW7JzjDu5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225944; c=relaxed/simple;
	bh=onQZPDO/5PI+EGQWomoauY3V7EJZG9au2H7fkbOgnBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhEBX29FOww+uBsEgDemoZl1Xd/BoMp86kx0PACGfGGX3CtUEIvRTuq6gMrlWzEX9LFUOAtqG/Ppp1ecla/ukkXBAfz5c6/4BmGuOPhaJ820e0Opcb7qWul612RBiOxE7u8OKVKJ8baUTQFCU+lDoDYlCH0GGFEjW7vPP1+pFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YDanNtvS; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-290d14e5c9aso10365085ad.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225941; x=1761830741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=YDanNtvSMz4xyaPeBcbGIHZA8YhFkYywg4srsnSROEljXZ/CSraF4OnYeRWAfB5evS
         WJh+o/vj4r+DX8x3JGdL+cL+DkimdX1XT/bMyl3V7rkwV5EoNmpj3OgeqxK1V0VMEO35
         i2MxZXt3ftkDqKqbNSxzfYjkYg5Xn4Ctwju+wkjlBLr4MygHBWAF8qHPpWKFfGVN3+J+
         Vaf2WPjeCQANuJpWBGG49bBeaA1KIVqijFIpbHz+C3so02R60ZKGKBE4N8Zuv/sk27rs
         71odVAyUjiEEdIuOfL4FjlMsnMeBBqVVGWt1EUPyRpTGRIHr66e9fuDlsxiyB/HCccaU
         HPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225941; x=1761830741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Vc18KrWuMNfUoArR2DO1WTDm9aMJ2VnekXi8RaYkOI=;
        b=o3GEkspCxSqYVZfXJ0oRTF42/DrPzrIhzk8AsdmUD2N9kvjVJ2YsC/nvoR4UwPrCac
         MNcdAkCrZ2Jr4mJaKDKgj7NC1zC+NlSL5ZB59VkGXqpwBVg6eZS4cTX5grnDiO0cPh+i
         ea9sSEd9Byqp6gaoHBbs/tTmmzKlWsiyryca4o3Ej+9lOoVzOvmUyTxuuZB8q7ZaQWir
         gMICn6NmpWTWRJ0IptnNkZ18pnDyNLMtt89nb8J92roLXqPP1TCrQWHfIKuv3zij4Rbu
         6YagfzA6+iTo6axAfYvsMB+SJtcwpPy5DQ7ihkjPt6/HeBG89Af/1/mLUgKEYKDOhMs/
         6M7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIt/YMLx2RZG0J6bDhmwbMkHd92366ZKRXF2/2B5d3x6ziM9rCobTTjWo2BbhaMY45dCYq1s9ltIz6@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEEyuSWQdqMRGcdsD6Th0ntWTADVnG4+76gzRUgWPL3HIMKUX
	wWXb+2SdJbKzONIZJXrQFk6GY6BSynm7TpLIF+7hLHG2NiAtRa0JFIXozScd5PXOZ2U=
X-Gm-Gg: ASbGncsVCesVHrc5lLTTY6SMBFuMFaUSPLHjaRq8DD5WOzHJ6WC8A1m4DTTCQwxwdTm
	k2VwmHUNE/kq73uVrbJHnRGU0ZX36VVvRGOlhk9jiQsQC4b5X0rShzSuCRxGBDvVQzN4jha2g36
	RqGmg+G/sAAnnvUDB0rjzCy1MJL2DZSEp1OZR/kGH9BXVNnyHftrwBFPLYYFk8U38MWIqTGj6v+
	0zHJA7hSdXeNyh1v7NUoIy5xUo4VBqcIpo66L8jyRg2M4xb5dIs8JKREx6KYPNTW+LdugQVgvGZ
	waNISK4ICLyXrZnjtAx5p/u2GlyRR3ltPSipCOY7Zs+Pg0lYg5x2xSCEmbnGKJta4Ynp0sJYyLk
	Ziy90UKmb9ytItzmvrVHshV7KrxCXB36C+95yfKc0faPnMtF1Io4oQOOQp1r4krIaHGshdlmyKT
	+BEUVlbVmG4POeU1VfelfW
X-Google-Smtp-Source: AGHT+IGl4K3EWqXzwvKFEGfUV31SHiJxvtb202KqFHfU8YvsQJIOKEaNW7S6Y9DyIV9G23eYEwYAmQ==
X-Received: by 2002:a17:903:41c6:b0:25d:37fc:32df with SMTP id d9443c01a7336-290cb65c914mr349494795ad.47.1761225941004;
        Thu, 23 Oct 2025 06:25:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:31 -0700
Subject: [PATCH v22 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-2-1d53ce35d8fd@rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
In-Reply-To: <20251023-v5_user_cfi_series-v22-0-1d53ce35d8fd@rivosinc.com>
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
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 543ac94718e8..3222326e32eb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -444,6 +444,20 @@ properties:
             The standard Zicboz extension for cache-block zeroing as ratified
             in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
 
+        - const: zicfilp
+          description: |
+            The standard Zicfilp extension for enforcing forward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
+        - const: zicfiss
+          description: |
+            The standard Zicfiss extension for enforcing backward edge
+            control-flow integrity as ratified in commit 3f8e450 ("merge
+            pull request #227 from ved-rivos/0709") of riscv-cfi
+            github repo.
+
         - const: zicntr
           description:
             The standard Zicntr extension for base counters and timers, as

-- 
2.43.0


