Return-Path: <linux-arch+bounces-10840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A010A61E7D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 22:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49594884F45
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 21:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB9205AB4;
	Fri, 14 Mar 2025 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MzbqRqCW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31F2054F2
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988374; cv=none; b=Gw7LWr0V4RyrRFhyAqG4IF78VZ5MxlUG2ivJ+XZkolS52ah8RFuLt3ty/PW094HqJM5Sj1AKcKyAEJaV9L0FTM1q75N3LnFzmtZRxzqpitNwtgfomT9pEOTAA6GSOQ4uYgbJlbyIhApmXJKdFXDkxOaouzrWBdN8CqQKrXVbRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988374; c=relaxed/simple;
	bh=DjlSjyKZg5L1RJtFrw9Awsbe+InTSaQHdJt80sHp1pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kINYg/7O3T/2FFMCmLy3Ux2Dysgz08r2gi4fQ5vxJkGbLzYY4G5rogIBJCEtBNwfWOFx3lgEVWfxHQ4afgb0Z24cQkoZVN6pk1vJOV0GKbVHW5GvBljYsVhexWxyMpRAX9Cyrgyj8FoycFrEOue0c8n2oVuWeePQ1+9k7iv8Kmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MzbqRqCW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so51668505ad.2
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988372; x=1742593172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=MzbqRqCWSJ8CtszHi/mnADnI6VJCkta3sH5rI3oL/sEu//8DIaiOQyQyLio8dWhrdR
         LECyZG2hqGQPpt213s+1YoheO8WCRAVw5uWpe1tc+ZRdN2K+HLkAfEzOZO3P7l/WnCLI
         3as/gR34036PfDskYCQR6ryxllVt1nY/86xryJbFDm2nn1NQuMq5hL33PST+Wz65JrQG
         wTFnurV5aywd+Toz+ArM3w+7YFaj9AiOmw3fKH2P74tV0SluPHzVOoJ78jeeLNnpZZZE
         tdgu6zIIzJDa4ilF79lYUChDfWUmBm17g8CmGd9qbXxZ0OBPUSmMkeo+3vjA/fOEExbV
         WQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988372; x=1742593172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHEXIimjUTXAyC0fOzh8XAkym19Q72QcmDI6hc+cq4k=;
        b=fTVq/8SPOT2rP6tNOhuRgrCYYDrByUE0kKTUg7tbE3gYO8EaK6P0BDHONAwBL0wCVH
         G07Q8uJslNAU6jyWw5IKCPvXrzTCtmQ7BtcKa/ezbaHD2KV8We7njQzSY1JSIymhVVbn
         q+Wj1G+JIcO+kmRy1zbb2/TkzTgIIW3lMdZrzMamz0VyZ22HiHpI8lR2FKeQDyCmlXUw
         JSqlt253+Lj8EKuSYaXRzdvfXxkC67AVxQU11SbQ0v1M6R/nlzOlB/bvHh5WKxeCTQU5
         9d4IX7kbZm7PJqQQOglQMsrx17klyV1ie9FuGPKdcSeGnruy4tXXAyOebZdYnLfrHUBo
         LaHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzLBgrs+dg8GtbaqjVt7SSoeCTrY/HdVuAZl9FzaXzPT+9Rn1Iu/8FVEO+rMss8VHoUWI4t0TbvjMU@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFWGd/sFRly0nM00N9/wEf/VXS57Rkwrg2riND2XA53SATbwu
	3GFyxiy4g6zr5UR1Ocf67I6oevTPYvP5AUYx1K77RURrbFzvTMZq4CglF1xgdgo=
X-Gm-Gg: ASbGncsIaakq6qsxggqDs1oOo6/CB0EfSuhTsiJ1X5CyvvRSOc/d+DmHwtV85cGy/i6
	vMXr/CEFt/ai8mA5QXVyVZAb6RG4B/dWdKsDm1ck9AIGGkgX7JOydpTwuq5K5DCvAYH++dPqszy
	vtz3LJTyhawmJhxVB6++ZNxLpiTGxfp5iwUmwvACd6L3r7bogp3GMVnwF25e/62vJnEeFNBVBl+
	+WuQ2wvWXpB7qCWYK4T0GaaO8pttKQhU0ExLY3px+osyktFqv5fAQwyAB31IoZiZJicBVACqchZ
	U4H2InnJY4tkIh7LFMdphaXVlovn8n6bVPqJF4aG2DBOzNg/c1J7uGw=
X-Google-Smtp-Source: AGHT+IHD2xqF6ISXqrc66wt93NwJ9QpiMUhs8Y+9GVF8Ev9srJWeDiSZWraNiRIMMMrHSoWJEgWxBw==
X-Received: by 2002:a17:902:d50e:b0:215:94eb:adb6 with SMTP id d9443c01a7336-225e0aee9bbmr48831645ad.40.1741988372408;
        Fri, 14 Mar 2025 14:39:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:21 -0700
Subject: [PATCH v12 02/28] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-2-e51202b53138@rivosinc.com>
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


