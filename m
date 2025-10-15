Return-Path: <linux-arch+bounces-14124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D828EBE005F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 20:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD5C3AC801
	for <lists+linux-arch@lfdr.de>; Wed, 15 Oct 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8110302CD6;
	Wed, 15 Oct 2025 18:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SlxRf0vR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A630103D
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552026; cv=none; b=VXRF/0MVuuPBMK8laaP1e9uxTXCCgzbBfmrZl6oJj10HTqf/hzube8QDRQtpswp/AywpnTbpoVfcYX4JjKGPWAMymv077XzItx+iLqQnOvJBbl3W7Z8k8/RJeZLTwIw9JXcd4roiaet9tqQMxltJXn5b0dsc4TikExekn0Asc6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552026; c=relaxed/simple;
	bh=pkBAvc0IieGGas1vvYQtOkKUWHcQF724uRmRqVMGgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dAaTHRXkkotEl0xg9dMvf8qQBEmAMSplbZUULvFj3kwlT8vb924CC7b+zvGGcDmX+1LksNB9W7UTsPghGGDEzW1z+Ii3qj+KCn4uF8cqKPypYMoKTxZizYTRxzlDbseHyjGmTHQBlSZzojAPoFkEvIq7TwSN6CuaDFp24Z6t69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SlxRf0vR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so6330787b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2025 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552024; x=1761156824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=SlxRf0vR86f+JdCivXZVuho/Ou6syE5bOrJYIXDsr1N2NnwLQbpE78vAaPkCMa2gD5
         dswCw9Tpnzgdx6fOQImJ8FDo+uaL3zooSIaAr+OoRC8AO09sxFOyX7JBhGbv/SSEO08I
         7DXG5Rf+/bP+fG56dUZF39Nz3Yp2eE3Fs9Fo07/ICgZd66wTBnJ5CeBSNjUvdgl4SwI7
         u7zTs60+yqT8Qr0oNNkHlkGcEyjErRmMPy7p2zj0XGysRaFXGPknSakU64SwZqU/UwHx
         TlMkA8o4Mt6Szf6U7VMqHfptggkKy0v3e470kSwy0S9ofTiwojfRpcJHy8gsEqDwbHMF
         vWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552024; x=1761156824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuPJu5G7SzSWQtkc01838lduYo70q11KgqBzT6e6NXg=;
        b=s7i4Ci0w1QdM/CiNJ9DBMuq9x5Pt2BwZjT1GLFX1Kbqaz0milQV/axpvdvdlX1IJzd
         0F7Q8k/enIV9qAgFkZ1STGwhxfutc3Hzj/PxgOYGMNM5y6Y/vVWq7fUuWwoqIR9WVAgR
         c6F4nBcmhHWDCVlNVqXfbvlgPOm1wmAu/H2ScxokIf8dj4YrMmOw6jbQtoc21/0wbcds
         epKDJhqg+jyuNWDS0uiAtNdBnCIwJozFotOah6bJQZlkBIjDq80/8YmmAk1Ok2YaKX5l
         wLg0IhUK1qKrtDkxfKY8y9OIsqhKeeGXXRRZITsFU1eDb1GxLe9hI9XZUw5icG4jfhi0
         6qSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNNxI+quhejgBH25U6RD5D0RUgcMOO/vm/g46Qydc4ecxK6v++YczdZqT8yDnfBMKBqJd67mjKANmS@vger.kernel.org
X-Gm-Message-State: AOJu0YxQm6oIOw3Hjs2mvuAlNGLqhaWs/cS6DcPaMsrkyxHbViVD0Z9U
	krUOjOI8TG7ri4gERWJkGZ/JfYtsCTpgfVAPgYJZFsVOvHn0Rbu/nhYdGkPsqvEAgOQ=
X-Gm-Gg: ASbGncv0e45ZBVNA1C7uurNyppshkq0HI6Pmuyw3txaBKGUIGtDipjJWCm2JDzcl56Q
	ZRgyqZuWo1tjaK4dgcc5+if6w40i7JejTpAVchBLzszT+7KyNY6oNSMhiQucWnF7vloU2o0T71k
	80oXgOGsry26by24Mc1MYCgw9u4Ja5bc41TCIlsCo2l2u1LAHIygHBegmxntRYVt487BJv5CiKS
	GtgZ/f0u+rKVd10sQthevFbR4frGdy4J/EpZ87d1vmVa7ngCiDeNDTt0vr1pP3KPTx1gv5EPDss
	B15aTUZqNDfqJJ9VkLKd+8huPxNLowvS1l9iX/evrxuVYIgNMIorKJ00WDAnh76/YJlxWPyQPc8
	v73RiJN2qgIn3zvQjLanKWqQd9w2Brir1F5B15CZdCJemZ7vOS8RwfL7LNsfnYg==
X-Google-Smtp-Source: AGHT+IE532Sc+sFZCiNmEvoJegTZ+cHh1Xu19llh3mJ+MHzVrRYzHyEQ1nhDnGpeZ7e3G8zwayd1Xg==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr339106065ad.14.1760552023763;
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:13:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:33 -0700
Subject: [PATCH v21 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-1-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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


