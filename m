Return-Path: <linux-arch+bounces-14298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C42AC015C6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 15:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7051884405
	for <lists+linux-arch@lfdr.de>; Thu, 23 Oct 2025 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA852314D24;
	Thu, 23 Oct 2025 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="E4/7ITCB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2931691E
	for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225941; cv=none; b=ajEty3C4yJAgK5XAc3RNNBNdiEXEIFL5BdVWIeEF6Og/KyKX9jDthrZFxbcww9o4dTU1qn7V1WbCQ3qNlxMd6LW+9PZRNpnXFL0VVW4BOeS/XIXQ86fjgqtbd6s6dpFFnmGzfsPaEoMm0Lnb3/lk+tPII2RSW+CDMwYXmnwAxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225941; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3MTuNjOygYxVpY+5/moRlfFr7KHJSKJduc+bGDVnnKyabjogCAQSe/JZs7+ouMWQVkdWpdou7i77RnL7csgDhCuKevuXSkTMvqAOSAJXjXhmRwYBea4/OeCJsng6W7UBXFLTYXaBjhbiiq+oMhjjTzY6LjI2oXuBhhIyacJGkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=E4/7ITCB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26a0a694ea8so6267595ad.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Oct 2025 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1761225939; x=1761830739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=E4/7ITCBWptg72BiEBB3U0Y+HLUU4GATknwICuFutAexZPdv4pMZWSZhcpO8Edwrkx
         zcis20coaEekRXCV7qkgbWBC+/55gwvA/+eXuCRpvZOpY/A8DSZgqT3rOzIAOqJZFBdo
         nixvpcnXF4FVxwaj1jvRzuKBQfYJX96JXmB568BmU4KHswqhqIA6F59fBPbz3rSDb1Wk
         q+jaRovJNf3dFAKlTEL7xN35MdPywwsNWOP7qyw34Erk6uYm2k+swJbYFI31gyEA3wtu
         SsN5LwkvbciaTMy8e2AOGw5wbyr9mZHVGHmvIgb1lxJ0/FW2g9HLjJ1T4ZzWyAd3KqkQ
         rK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225939; x=1761830739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=Un1CHXrKlsi5Op3iDkHfX0yF87DqlHc0wnUOUDMuWj05jEkL27G2VZePjuylBR67FR
         T3IFKhth8y11sPnxX+vaU2ntWRVCruHaJYFx1IwVf4N/2pOCdobo7LRGuVp92jkTrNzw
         MYCAAiqxH0xEy4kd0jhXFpsqBlELC/8ZXWP6F4HTA9bzkCyqk80JTlYdaMvdn/no+PfK
         RgsbwNdJEPv2AvbeVIvObC9ToXffSoIJMLIIFq+3EIgVLkQAdRIvjKLDYB/p9uNwQRbf
         1T0fP6YjMgeF5v/1CxPxqlkFEQuZmiZf+VD7oxkI+40VdSWhbTnYWTT7g1d/CGUvuYYv
         83Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWszsvNnlCbt1JVXhEbNYtjX0S19azHKXtZv/t6Tck0Km0NNxCetQbpvpzu6kucMzldYGlRq4UDst0Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzjSrMqPg4ZeQeTipzww79Zwo0hLGtr6IE9LWs+U+o5Sg4Pf3mZ
	1RPMCgvlw3RisOrQTxfMzNcniiDtLZPkRfTFdzH5QGGeDOhBByqpRXlvJhD90A1M58k=
X-Gm-Gg: ASbGncvQtQk9Yj1CfAsFPakjIzuNDAP3H2ICADKLUMAnxm9c6MhAmehDKMgjTOHsU4m
	owskLTsm4ui6Bo9Svx++4dmiVCDyZb65xzuzQTnLtMj5qkuju05wjPHmCmXeoaJwpRD30mlHh1/
	ZaMMx/RLpOJPbHlKt/Rxgn8cCGvbXfK162IBhTwcix5mT1cwd5dh4uOPW88BtR7CzGFFLSw+qNy
	TqmCIv2lvDiyE/gf2IIFMtAum8VkA0SgFSv3daQlim9CEbp/HwAErWunnjsuMdqy6D0BPLCZikA
	Lnkww7OzFSK2CK11ln7fN3BqtdGz9N3x5gu6XjjE2tqnwtkGjz8H+IRV2bfAwEbXUHX2htsa6Qd
	/04BnOLrRiN08JtiCeZM5fgfQ9+D/ajugm75ysrNbnB/D2pNzUa90hQVt1nQzxslJbdVOxL5Hso
	mFgHXBA3xsOY/rO4fyO6SZ
X-Google-Smtp-Source: AGHT+IHiowaMdQQMukarKWR4DwE59dag2M41jW8yOYSmyuKRWbrYlIpW80BNasPiFne9iuxrtQYkag==
X-Received: by 2002:a17:902:e889:b0:27e:f1d1:74e0 with SMTP id d9443c01a7336-290c9ca3304mr315130655ad.17.1761225938726;
        Thu, 23 Oct 2025 06:25:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm23432035ad.103.2025.10.23.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:25:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 23 Oct 2025 06:25:30 -0700
Subject: [PATCH v22 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-v5_user_cfi_series-v22-1-1d53ce35d8fd@rivosinc.com>
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
2.43.0


