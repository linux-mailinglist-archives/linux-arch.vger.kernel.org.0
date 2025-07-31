Return-Path: <linux-arch+bounces-12992-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BEAB17967
	for <lists+linux-arch@lfdr.de>; Fri,  1 Aug 2025 01:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C5058017F
	for <lists+linux-arch@lfdr.de>; Thu, 31 Jul 2025 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FC27FD46;
	Thu, 31 Jul 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3WW+1+89"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824927FB05
	for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003966; cv=none; b=lRiJ6z/uPyhKXvau2qzbT8SQDPlIbOPxtJHVqrb1MmvECxiPKhaPLuKokknWaOeoWyG1vACb9xgZTKjaoX4dfkPKQJbev33jOn6Yzaj4hNDpracIka53gxGJSMwS+Ht1zt4zZ8daBzjFfSHwQFrPxJoa29PW1wTDGfEHuHuFWf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003966; c=relaxed/simple;
	bh=3rWM+6ai+GAHLkW+NDrA2ZDlcBd4pzb4hc2PSkPwx/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kazr8V284K+lwod2D08mAtjVivfc3Rh59Ct2dswQNrsv1lel/urI2WaxBkygxUjjQoUhrn6Ck+N4MKXHCluaeRycBcPRTJk5SYBjGB4zT9RW86VQgy1k0+d2z2BnK3CdNpsqFdFMZIpYiqxzz3VW4Gm8MUfi/le6WjT8k63B1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3WW+1+89; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bdc73f363so175829b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 31 Jul 2025 16:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003964; x=1754608764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AetdkWsxzLbheuZJ3kb+4mhEhv1uz8fN4NCKhkFj5X4=;
        b=3WW+1+89GrGqIRUcnWC8S3IqQs//0CNWXN/TdYWW+0ZxImOPxz2aMvJccR7N2Ae9SG
         SxGdo50LtHzE8GH6kUYxjv/leq1uFrLZZCk/j9CaoRpR71qe5bSvtymSF1rrV2rHF4Cj
         l34pp5J5NTBN/68zJiS7eaNNcks2zUe4nVDrLTxM5aFob/vfCg8+KmDhc9mfnRkXYRq+
         4142K1+onHJ6NwgqJ0baDHXU4yfoZesve7GkeRJ+GbG0K/C1rbleOpRCbkeLnLV31fbi
         kUh3bIhx0kdC1fuP8yuwwfbNAxuDzy6M5PP2ghFqBgVpNMbKJWe6QnoYXpmIAoDo2bSI
         jTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003964; x=1754608764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AetdkWsxzLbheuZJ3kb+4mhEhv1uz8fN4NCKhkFj5X4=;
        b=c2jJLCc132nYxntnLsi/6UBzxozqzpZxEi2M4RW3LXZEYQ0uhdmtNB7azzqpiDkfwX
         k8vFtAu93/5jKvJlAzUbAXZtWwBXK/fS7I7SfEACBUE/kaSBTGtI2htUNw96N6qT4t3+
         U+LDxrlhB48WMCfeZt1Ze+tyss0IZXuqsGKFhY329o2fzdEe+06GTx7YfbNNzM0txkbl
         9px8xZ3LH8VdhYC8vI1beGqvblI6bCIVznJdNwKBU3aMZWfzT9nsmFYVYayw6MYeME6e
         6y+CJxpKm5mEFZyfZ61nKZMNENx2voERSN7BAd2t9Z9WKN9Lr5cXa9E2x5J/GqIY0WLT
         DXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc8fhNDafpK3oWOaH5uQwyKpb9F77P6+YHY1226DSoNsa+BS+WMrsN33wazKSxKfAb9SMI3bePboHS@vger.kernel.org
X-Gm-Message-State: AOJu0YzsldqqpLs4l85yMx5xzdQHdCi2TT1sjZhet/UfIuO9MyjpFmxa
	Wofye0nzES43nrSnXTRAT5DDIz1HGhOt8Y5ynQELOfWmUhi5a16/bMQpH+rjah6206A=
X-Gm-Gg: ASbGncu6jvN3PQSCh2WZtaR282mCxuBETN07VCaBBJMd3yBuETGoD+8isKFLcfdDAtX
	VTlPPRAgX8JZLLYVcWrsBfMvfd9fYbYMYb5qY6JVxPbkrcbX8Kb1g4kB1t5lXSDvQDKMRIRV1bf
	XB+b8i3lsItpwOhYxt7SivgY325WzG4GGPUkXtYNaq+wgoIHzIoMvNW0z5kdNWKGTt9xd49hAhc
	678CCQQegxmkXdAZtpAs4BzO9vZYtPCioJiN2r2tUkz6SKwV2NoMQRaL3K7Y8WnXc3WkB6aMDK1
	hvIqGw0adiw0/XfUE227mNdpsKivEOIgxcKr8cs60fdNRxyEiYYngBD1XG8PHVTA4UwXlx3q39x
	iGxxdQob9onFlaFqqSIKDxG6WRDYLhE5g31X5sPRKN4E=
X-Google-Smtp-Source: AGHT+IHQbINJSIJX3DRCY7VWQRNn4wGJVllkshwYu6z4COruD7/LM4Lj3NJ+5unK+IoBRvria/ND6w==
X-Received: by 2002:a17:903:1aee:b0:235:eb8d:7fff with SMTP id d9443c01a7336-24096b0404cmr123206725ad.28.1754003964051;
        Thu, 31 Jul 2025 16:19:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:12 -0700
Subject: [PATCH v19 02/27] dt-bindings: riscv: zicfilp and zicfiss in
 dt-bindings (extensions.yaml)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-2-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
index ede6a58ccf53..9cfe4381f3cf 100644
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


