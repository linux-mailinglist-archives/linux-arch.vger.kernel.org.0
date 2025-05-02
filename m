Return-Path: <linux-arch+bounces-11812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D397AA7CB8
	for <lists+linux-arch@lfdr.de>; Sat,  3 May 2025 01:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357181C038D7
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 23:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B7225775;
	Fri,  2 May 2025 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MyVNYd5M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B086D2222D4
	for <linux-arch@vger.kernel.org>; Fri,  2 May 2025 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228647; cv=none; b=K/nhdtWaORbu8PZXuARL4443vfA7XuFDuIcNIvjGBAgA83dljlGQJ34145dfsOb7A8nHlOiMNK0OBgV05xzok3DRSG0YyGi5ebDgjgxEkfpGMfHPGzU23E1Vb2tLCH8R/oDd5i/EhvwaxadTQ1ORX+8RXr6qrQ/8yoAWsfvFmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228647; c=relaxed/simple;
	bh=07JIHRwK+fbY/KS3WXdAQFowggDed4ZKoyBK3fLGucQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVzH82YUA2VwyIJr3CGImn3KsmHxn68YtJ8K7Y+Ee8AdnlcUes13b6r/rPzLSsIGzdxVFvaH0QDfUiZCKIS070l3vVbx/V+QQgcVIpF6ZZTkw7vd/JYkfiDIhNc36PoJ2zTwhwZJo8Gpd94LSA8UkhMZ9ESaA1W+Oa7QPQOsqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MyVNYd5M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b433so27508335ad.2
        for <linux-arch@vger.kernel.org>; Fri, 02 May 2025 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1746228644; x=1746833444; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkVK3bviqHN/t8JmfUhzYvFjjtQu0YyYqPmZLVGI/TA=;
        b=MyVNYd5MvdRqDqTLRdj3YkEXMkidA0l9HPQtEauag2kapZx5tf6GuYNy9+utUj4y3v
         0pwR1SzpPtn85ZKOGF65r4qwpKFtdt5cjZJmpVtVc4bzRcCYe65RQ0ukt9ZAqXuDS3Zc
         E8vubB0vS3bbeF+J48Ztcl+ybjOHHcxH/+PFnh81IWwrciPsHm5DG1f6x+6HzGyMsc/H
         ml5+GeELPBqYOK8mEYH6gtICLqQAiHF145slEAOhscn67BaIMynZMsDJvHjdbj+KMaLd
         KyQmkicx70+mJlZY6iq7EOzaaPyPID/tqqeymY2IIhvAsZV0d7e9TRZ3AG2+IFTkuljQ
         nGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228644; x=1746833444;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkVK3bviqHN/t8JmfUhzYvFjjtQu0YyYqPmZLVGI/TA=;
        b=Z756x1YrdpwAHXwq342704OxaSbblXfM1H1ZfgIqRKFWMR+VCezHCTsKm53R136VJy
         wLK9J6LmhzHPMyKCT+Q55H3f8ivTzcY+HPrHxyFtcJucemFaM6XwD6S85XPlpdAf27oc
         EYjFLjNg6IKA/Ab8rJqwsI/ztYyGIs0Ytq5MmJgUMORLGStc+5qWVMNrqsg8/FtJU37A
         YkMxEtcYjjAVUh8XhaEH3EToWH+A6bC655G8EH/r3SbbbMvl4meX132ylooQsu5dYY3V
         9ky+87+jPnp0RyRo7zvf1GFG/qksZILH4DfE7QfUgcNS2mtnDKj9PKg5Qx73V4zh40oZ
         COEg==
X-Forwarded-Encrypted: i=1; AJvYcCW/CIa8pw+rrLzBk4PWPknAt4onV1ZvDEC1GIM+uWjIHgPqwHvp++xPvPkQw+l4cBRXmg3yHd+slLav@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4cPVYDth6eQWnmmEbVMYtjNXYwELN0YZRc4JfnMuy4mCubROS
	etgMDW+6zlmG/+8YVXII4LrHMkAO79endcP6PEKRQThjtHNQ62uWNBQlEItH6qw=
X-Gm-Gg: ASbGncuQrQdbxgHHP3LIT5LH7lXuJ7VSZJWrhXfA04G5fNZqqqgtvcM5DOR5/wCPLTO
	6V4yHIHOUcKJa6sbAL/oD9jGtpWBns9vnDG9YgwBUb2YCq5K/dpM+dMM44Qhdx8lTCTXBKjb1J9
	YY1jP+QlfIHNIIBgwMtLqP5Yv//aDW9faZPwqzbVaMUf7IvkBrrT0gYyz5BBW1tpTIsrhCjwnxk
	9srWsp135Qrdq2ikyLDSl9/lYuEOi51dIUL5+tPtnSm1sq5l23MDiwALh/dNuHMVXPyOGguiuI0
	g0k17GyZeo5vqNZFehPznSW+sEF5kNc3khJlS9shN4OSisPohOnG/o+bTp8rkA==
X-Google-Smtp-Source: AGHT+IFdh3sLk6r+rFjqSN7jGE51d34L2PuxOmUSOaSxSjRwNX1uihuOq8DvaZzdvN042MVDHYvDfg==
X-Received: by 2002:a17:903:248:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-22e1031aabbmr69526825ad.12.1746228643932;
        Fri, 02 May 2025 16:30:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ff2sm13367055ad.180.2025.05.02.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 16:30:43 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 02 May 2025 16:30:32 -0700
Subject: [PATCH v15 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-v5_user_cfi_series-v15-1-914966471885@rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
In-Reply-To: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
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


