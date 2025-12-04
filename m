Return-Path: <linux-arch+bounces-15171-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA2FCA53AE
	for <lists+linux-arch@lfdr.de>; Thu, 04 Dec 2025 21:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9580830F1EA7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Dec 2025 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA8635293E;
	Thu,  4 Dec 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="McIF2QDm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F834DB65
	for <linux-arch@vger.kernel.org>; Thu,  4 Dec 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878683; cv=none; b=H+4iw94ZR9ampQ5nwTjUC+E4RsdYzK3ajkB2VePr28k9GZLV930Cvx6G5iFLe33t8xLCEsMOP+leK+jCaD6Tus8izjXNupCT6xepPdf35XWH95jTjU10ndJ+/449yNEVyWzP1p1V+T0V1K31Ju3sn2cZCEv6G1b3cyDv8pCaSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878683; c=relaxed/simple;
	bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxeYF//q/Gni1+hW9Dudx8yd56nTFaQnmCPfI2jVIf0KkhwIFvQQ9GvdgD2gb+XGFL9+rk3uxbK8f/tETCpDlVdROKHOO/v8P4k56Jd4fN2H/enMa/VEzVDUcUKW8f+S+tRZlcnXe8kkj7k4bcV49JhaZI6wLU5gXDpms8EOjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=McIF2QDm; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-bc8198fbaf8so1155541a12.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Dec 2025 12:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764878679; x=1765483479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=McIF2QDmlMmRS6IiK5z+fC7KEpPH2atdMt9l1wAsasOvh8Pq+fd3xz6jp6kN5tiznB
         JXPad+wxfW/wbhqbrKZWetkW+tVet9nXHaRtlQvcJtEzt5C/9hK7U1n4l0n+uo/BYedv
         tM5Io9J8Y3Veydq/wyjcXHKpBOSG17jqignomYMrRwxanUhnuZ+S6ciNKJj9zjiVEKND
         GAvNE5PtM+ySINMzrt7jx5jEcCrC8G6VuTiOlOFX7+S4eJ3IPCtElhMZXFW8eTPxcA3Q
         lEP6yfVrv5jRYlQs04qinAPaznWX5/8PeWmRTkRtEt0KxK/ERHbd8jeyzZASIpsz5RXX
         xC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764878679; x=1765483479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=jOPLRa/Pl3/Z9PCYAj2NnOvqGNBe5sXo92am6Fgz7RTLThv90O6DAhCXHS6Uw+BL6J
         4kt7oLloaYP6d2ybXBJPu04y1BhpzxsAlGmfeVG+obXqBfoDqi3/ghOZkoX9E2lUTpe/
         EqhStVt1zPkLAekoAc4uEjSUM9m/CjSzSWcz+jWKvApJZqAnVDs8P9zdMxcmpCzsmag8
         BwY1L3rIcbSFkOJq9wOKLTcdJLYEaL7wv5xvy3dQ/bwQTMAv0jvuX4TZagzJBhme9NAr
         sTZPkm9o8aaVgf+npCiKXO2vs3kp7parebJFyLYVM4Cbe/qIznvoNugjGZJ9xeHtjhIM
         /yFw==
X-Forwarded-Encrypted: i=1; AJvYcCU7F4EkS6jJMj+4j8/4l0xkfsb6+ILdrG8mOuhPU7irJUxT/0Eytiv+js3COyVrBTtdplu/RFxSlBvu@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlWiW9iX+Qsq1V3hO8EhMmqL/J9h0VGjeAfX9PmRLK40VqUgk
	JabGLwRC9jBVHZO2vnBlzEa0AunKisbNlY88zEEjclXEr8nnG1uyX5/eBzjiqrhLQJU=
X-Gm-Gg: ASbGncsGt0fvNwyRJzq2Q+Y+8QEL5WEsj4y/pNez14A9HOCuFRhZb2vCbeB0/B1Fo66
	XzTS2TRkqSuaiqG2t6nzVJDaWB30Gqw8qFMCL8SCFT3Vw6gA33sJNShk7lnwvk2w8gI4wo1lt0g
	ZcrLIZW72OGCcgdTXgsy2pV6hO2MPXe+UFiXRNSCGSXGKsSA6kKHT//NHe18W2FxffMDSylEoZ6
	YTm9iJXKMXxoD/cn65LWxChCzNC4OUryLZRtFHzomI3Mfx7W3ZMvEqdnAH3m146wYLLNvcWjM2w
	AHfjQxC1MssN2ol6F9y3kD3Ku0oTz3RX27h2rtn3C8EDE0JcMPLj9aBgxyvyU79t7hPWxXRRfJn
	wW86vRA/PjtWuUpWrR7t+V1BHlfPLGnK2X9Sl+ADGnUw9kW8V+YcG03z6qo6MqpIHt2v6OXqfgY
	FglDGMBEsGnqW2ZU2h0mra
X-Google-Smtp-Source: AGHT+IH8WfNOBR0WYTIAjC7h4KWRD4arxZjj56t6ot/oIQda4VPJ+vPnGe9pfxDTosFlvlQPrVkwhQ==
X-Received: by 2002:a05:7300:2d06:b0:2a4:4e38:9a39 with SMTP id 5a478bee46e88-2ab92e786eemr5009491eec.34.1764878678491;
        Thu, 04 Dec 2025 12:04:38 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm10417454c88.6.2025.12.04.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 12:04:37 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 04 Dec 2025 12:04:09 -0800
Subject: [PATCH v24 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-v5_user_cfi_series-v24-20-ada7a3ba14dc@rivosinc.com>
References: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
In-Reply-To: <20251204-v5_user_cfi_series-v24-0-ada7a3ba14dc@rivosinc.com>
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
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764878636; l=1494;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
 b=2TL36FQBTxYHJECnsPKiEOH953BZcSJpF1TPScxWirFZpsiwieknY9HPgz7ctQuE/tNNnQFHX
 qay7b5jPJ7wCN1QiFJshFM+JS1yjoWqf4sTvAxW/wwYUz2revUqCcLB
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.45.0


