Return-Path: <linux-arch+bounces-6297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD660955B91
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 08:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830761F21D37
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E914012;
	Sun, 18 Aug 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nes0/oKc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A748A1078F
	for <linux-arch@vger.kernel.org>; Sun, 18 Aug 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963623; cv=none; b=IX7nVfJaIu9crznojRTJH4YlreDIMTyodkG9pG0Tz5kDqLiWnJCGkotnfsYMyYmEupmX/kUSQv266xETgfABafhei5aSkFqFlAWTVNu4gB9w/JK+BDLaPAOX7vMvA9jKcRDE3fguxBD91lpMzxQxD0giZ8A00pykDOXOy9lfSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963623; c=relaxed/simple;
	bh=65N1YDYmlpEvDTK31Deo5Fyg9F/mpaT1yLpXU+1oUBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHA/svOZAJtaC/sqg8m0tU+7bvNsUDz+noS3Uheo8xySocnfaiSLtTHrc3EUHUcuMnkVlY3V3gyvxPYMw9JKDA2D4LRH1cSCkSUXBVBOF3dVzn687aK0BaWi794RkYTckvULs6hYabdEgedzVVmPHEfBiJUYb5MLvh7w6kcVCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nes0/oKc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37198a6da58so1424855f8f.0
        for <linux-arch@vger.kernel.org>; Sat, 17 Aug 2024 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723963619; x=1724568419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlqxfa1Dgyr/RCZKCOdmB4jO+WlSQVOulpijR1tIjck=;
        b=nes0/oKcOBBBsfpaVKOoE3KX0Ydi2gRP19gxbtxc03GUOF5MUdL94i+J2+A26H0fHK
         t7ESmr9UpHJrrJO2REL9xtdCKGfLd8BW2VzBolDQuf1uoR+/DbqqlccDtagvLtTzqz20
         Me/MIk9hE0pfGj8d61jPnQqJOMPrbkwq10g4dwBx2fwnsxSU3lpX0HWfbfwbnhmIe1ns
         kNv8+WbLwI4K2TIJK2RQBZbIjuJFfklA8ILGCaSuy0gxjZKhTOWooHbT28Ged9jhB30W
         8tlqWV/lrmI+ni/+gTFqhgRL0cFNs2bC0T0wKJD0HiS6n34jr7151Taw47yyiwp0M8Oy
         3VFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723963619; x=1724568419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlqxfa1Dgyr/RCZKCOdmB4jO+WlSQVOulpijR1tIjck=;
        b=KTptQW0JEsqF6/gtcPs4noUIJKinmp2SMI86oqLejuBR7mTDEvS/E1xZ/RtLQyVC9x
         kookehGYlpyfTtEvafSWM5pym9C1EAAWOogCtv+p0iV2vnZfFJ9b/jUfCyy/4d1na+ov
         J1FpCDURhr/Br9l706OKKAl0YgXJCWYQmOxDKgpxP+mVORWfUGbC9NrbfYl5M2wT4ooO
         uPT5ILwaqVkgg3jaoasFInZpy5TssMy1UTr5yCINvOfHFFk7jZ92tG+FNjq2JhvElWKM
         g3ahH4FnGJe42sAQfF1IMR7Zo2y52D/4fNB3N1qBqP5XIJbt8pJCbGJ6UPl+J9h7XYif
         SCfw==
X-Forwarded-Encrypted: i=1; AJvYcCW49+GrDWsBaPSWduIRtA066S9nIkAyDIqXpo7K5oZoFhpnshfZhDBQe5kfFnUotdM+8V4wyg7F8/Lpm54Bbgl9kd3N1rjJ9HMXkw==
X-Gm-Message-State: AOJu0YzeQE3Yi39fNjw6IBV5sAKkGg0NUrxWwGj7/jwHWlZoE/vV6FzV
	hIpyS2iHPebrMZ2OWMyghrvyBNzheV3d9RiRX9KVQ8WjdtC9dQcoCeFSco/cHMU=
X-Google-Smtp-Source: AGHT+IFwS3MzzU8TURVJ4Ap0a8/3o7r3oh1yyMOzNik5dKrEar+UZ6Tut2SPaHafSLHiL9m2WkM9gg==
X-Received: by 2002:a5d:694a:0:b0:367:dc45:55ab with SMTP id ffacd0b85a97d-371944561f9mr6249467f8f.25.1723963618917;
        Sat, 17 Aug 2024 23:46:58 -0700 (PDT)
Received: from alex-rivos.guest.squarehotel.net ([130.93.157.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898b89bdsm7269358f8f.112.2024.08.17.23.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 23:46:58 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 11/13] riscv: Add ISA extension parsing for Ziccrse
Date: Sun, 18 Aug 2024 08:35:36 +0200
Message-Id: <20240818063538.6651-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240818063538.6651-1-alexghiti@rivosinc.com>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Ziccrse string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f5d53251c947..9e228b079a6d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,7 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_ZABHA		86
+#define RISCV_ISA_EXT_ZICCRSE		87
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 67ebcc4c9424..ea9c255bbe3d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -314,6 +314,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.39.2


