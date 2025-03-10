Return-Path: <linux-arch+bounces-10614-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF6A59843
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 15:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA5B7A64AA
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113F22D78F;
	Mon, 10 Mar 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fpB+ZLEG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B422D791
	for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618360; cv=none; b=Nhf+DfCb0hrJmGGsMQYV+mw6pv3dCyEdEWRXNogg3qPYn9rLZwcUderI3T07bg2ht2+MICNzbO1fMwy4HRuTq9Ehjx9E13z1CzmGDhhJhpKnPjFKtfhMULWIcEs+f6V5I+9j/PkaSq5BgoWCmjKFR3y9X9ObUlC2Q5xiijEQOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618360; c=relaxed/simple;
	bh=DjlSjyKZg5L1RJtFrw9Awsbe+InTSaQHdJt80sHp1pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cqIDq1xbaObeidKZLNRmmt7T5pXqP06HdBZqTbL8NmjWTIZRHLUrmanO0P8Sdqg8CJqvW0PaggYchgM8exMYVhA4cLko89IXWQcBic21m8WS2sWQm+qUrLkHGFi6UE2UomOOLBlzV8BB3UZUYsT0znscnkA8PNgqlRcZHLI9JbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fpB+ZLEG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22113560c57so80371155ad.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618358; x=1742223158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=fpB+ZLEGGOr4HB1489JPrDqL88yR4qlhADmJ5wM0+L0MyptC5pY5oC6/0Wxm5lFI20
         F1wpaZLQpsV5dGmdI0JwDL8/6rhwvenzHT+/6E+ntF/4Hy7/AkPqjjYwxQ80BGfp8Bhx
         fYWDPd+QRQwPq/LVuWC0p4Os/OVHNnHVk7k1cOHtsDsdIm8OIVUdi0orf+oWwYi48xJS
         0mWMd2QFO98Yk6JHt/hmWniv92TPVN51o4KC+0uorSmlU3UB6YJuKH6QBif9RRA/A1cx
         8RAAkElNPNwwOG5AhaYIRyNPqC6lh38HLwqu9npFfAHL0cMJnp6gOuZ+NjyzntEe4nTF
         4J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618358; x=1742223158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=lm52qeXw2xFmMqu+qXZq243gWMWn8D9GAYjuzaq0r1Sso2u11Q+ii6Ge9/ww+HZByl
         ppul/lu5bmw+UTC+pmmOxlkPWexhj98TfJbhPzknxvsz7rmGyOlRMjhj+t68TosPIdu7
         8/uxTFkeP2Qlf84RYLEryu7H8Xt+qLCjTsLFCMbEiuLP593MmZHz8aN+dOl0jRG6aeSU
         FELVogUxYutZ3WkUTVnncnevTz922ReLxJw8Apsu2dx6eUgwSwK5V7Q5RBuuyZ4tLT7t
         6YVXXXECZHIckfsTGFxe530fCiMmXfFX44Tj7vrmfVzh/n+mHYbUTVV3AFoFm1o5Jid8
         IV5A==
X-Forwarded-Encrypted: i=1; AJvYcCUcBhR5K+yu7yNB5Deu6pFatod0MpNz1QzcB9fOJsNKqECTryAVUdtPRCTihgie+SUCTfkLctcAD9O9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4vyoDhdKEtGRWpEU7Nvf0msEILjEemsZL1FidD+G74AD4lAN
	W2cKKK3++uZv1GvshNfScge2R1utrn11/h7CMzVrwyWd/ap8ekTN1vbL9Sh3fmg=
X-Gm-Gg: ASbGncv4kz9FVUdRpfBAIW8dQZbQf4r7lVRvZoO9UJH+Xo853UeD+NZOCEgNsXTO0FT
	Ut7wCfyOvpqbWnqnQ8tzq5l81S/2Z46X2mf4BoZP3s2up3qibr+j8Hr8zifGl7AgDK44UGqllIY
	GtoeGD3btyB9Gl+FK5+g1cH8eoWDhCdwCWIECxouIyfwlvD0MMXzECgwCGgmLMl4mzVZqWPTbtr
	7Xk6os0fuoU1a3TBgi04NizxEOsuHUzh1wYFEaeybk7Cjo+OXtN150DacO+XqeqEwrpkEPvqt3/
	Fvv30gvFX6W0r/igCLR6AtC0ZnZf2HuDLuKazWXBsyQ909//B/MoWec=
X-Google-Smtp-Source: AGHT+IHtkwbPi3YsMJ6A8ZQyEy1VJS3fRxtZo4fUkREMtAJmz9IifioPXZ2s22L3uz4hyDnWUTIX/g==
X-Received: by 2002:a05:6a21:2d08:b0:1ee:d687:c39b with SMTP id adf61e73a8af0-1f544c37a63mr24132640637.7.1741618357489;
        Mon, 10 Mar 2025 07:52:37 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:24 -0700
Subject: [PATCH v11 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-2-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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

Make an entry for cfi extensions in extensions.yaml.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index a63b994e0763..9b9024dbc8d2 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -426,6 +426,20 @@ properties:
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
2.34.1


