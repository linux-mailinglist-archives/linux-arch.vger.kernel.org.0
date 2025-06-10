Return-Path: <linux-arch+bounces-12319-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DDDAD3EBD
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A3717C318
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 16:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E4E241105;
	Tue, 10 Jun 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cfGWd+OD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266319B3CB
	for <linux-arch@vger.kernel.org>; Tue, 10 Jun 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572594; cv=none; b=FijnbUEAAUGKOQN2DTvUas6joBFDodnAyq8YoqDT3frHC36hzOV2KU/qQHKt+f483Hk6Rw3GkFgBVUuFlltRiNNNAOf2I5iiGRaQozr0w5AUUa25LRFy2PvKOL1CScxOxNNNORhKioTmBQKu6rIlXcGCDEQcr323HD9cM9LJ3cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572594; c=relaxed/simple;
	bh=pSarTRCzQuRL/R7ATW6/ZUy90+VuBzjUwmj0wBd4rF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oX8xy+PS/29d0jOoG/F+zUM3szbn6U4ChkN3NMQuu3yB8n/JO7uUjlGl+FYsIVLi6+Cq6AWISM0RYv1+0JKvrYmK0ziZJ/9wK6CQisXbLrEW4pZ3XLzxMgsQX9Nt0s6yv0toU9FYpihCYjKCSYC1ZitZCaez0ujYTBUWRa91vRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cfGWd+OD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b122f2feso4245635ad.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Jun 2025 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1749572592; x=1750177392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Duyi2eYfEOWURmM5RwkHbBgHFP1RL7l3Jtl3iemhVW0=;
        b=cfGWd+ODd8qHlJ+BRwzQe3sqboRtM6FnENCpdWYK/eGxcjLLdw6Zpcl8FhibUZiHds
         qNnYzh9A9g6lK4rEMWOiNx2owJxwiiL6Of+FN2wf2EWzzZQuC0Vi6Ho10ntZ1n8Hju4R
         qbMUFu7qKbJTHng+tWPpz0w6u1G2x78oLlx20iI7TJR5p5Phagf3XOgFxW7LlaOpCLHT
         zv9Op7f8+QsH62ZlbXy3DGh7OhuwV+yFvKHmKvJ9UM9os8ZdNG4h/24V/D/2Om/jjGV7
         KlRAusGeDZamr1HjUnA4nkKdoQ63FLsb5D5JmDkX70WezzHmsbwkxCN0dFOavi9USVY0
         uJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749572592; x=1750177392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Duyi2eYfEOWURmM5RwkHbBgHFP1RL7l3Jtl3iemhVW0=;
        b=W4FhdEi72hcBDvvP74Z0UCJy6b2tF/DxEPcpuc4P5zbkk8oqJSv40yedlg/tOLIwZe
         CxSRaVIFwHiGiKjBKU5RFbl7lnE5leK65lqXT+9up8NR5NUCT8soIBC5yrBFQXDs1RMs
         znzMT+6Vo3y/Gvt5/8psytAPtogSaRb658sfz0UsR6PPK4Z8MleuRii9ALP4+INigh6Q
         i809iBpDQlewe1J7cRi3WxoGXXNk3Wa6aUhXbuH1n6fF47S+2snRapQnxoMwNd3we/XC
         DJFvyM+yEF3f3KQA21jlN29h0jw4b54F0t5uVoLFRG76vr85WOG7qFiOfVw6WZjvHEsN
         7Iyg==
X-Forwarded-Encrypted: i=1; AJvYcCVxmiYFJRreCcDeLs82v1W26G9Kn7oN1CJUJ94cALmQmty8ZFmHohgny7YNaA0xUjxAUu1g0YmWohdg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXkpbs8PVbsqH68Pl+sNnG/CyzUr6DPz17h6O+PB4oENz79mY
	2tX53ul1wrsECkDV1EltDYpdLKDpZDzHBGR6rCZca1aILVH6A1gPF1uvpToTCDawy4A=
X-Gm-Gg: ASbGnctDrOmff9oog+XexXOKDE3pUQd9bEn5MzVbnHfqG6L54RNlf3sekYbblLKWGOp
	30JbHgJhUFhab3SrAZXF51HWgUTlS7l3OhD1up9FakIc1mRs7OdBMRJOjO3MkhzNiyJzpMUXgss
	lrbHazJVl9sSwC8Yasfpc8+NzqLPCZfXLmwURdDxFutiM53H1RgxSJXF/wF45AF/GZfOgX32a4A
	XHtiJsgFzjt6mfRd7m+pFRmGUMONgXuapJThWvrrs0Iy5N7cHiwC6YGKsOcae/zh5oO24rWC2zB
	BvpriRIZVpRw3Cjc6AZ2nzLP704x4wVeFVw2YPsVVJ+UW8yCI0/s5RP10W8LoaSQEi9rfgeENWu
	s9go0UxTam7GRxtPH
X-Google-Smtp-Source: AGHT+IFzRZ/2ilv/TWo2BZioT8NNZBq3mXBKm6pZaGbBq5g4DcH/rH2061k7qbX3Bt49Qj9jZ8ssgQ==
X-Received: by 2002:a17:902:e80e:b0:234:c549:da0c with SMTP id d9443c01a7336-23603f4afa2mr100700265ad.0.1749572592309;
        Tue, 10 Jun 2025 09:23:12 -0700 (PDT)
Received: from dev-cachen2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-236032ff2f7sm73294405ad.92.2025.06.10.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:23:11 -0700 (PDT)
From: Casey Chen <cachen@purestorage.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	surenb@google.com,
	kent.overstreet@linux.dev,
	arnd@arndb.de,
	mcgrof@kernel.org,
	pasha.tatashin@soleen.com,
	yzhong@purestorage.com,
	Casey Chen <cachen@purestorage.com>
Subject: [PATCH] alloc_tag: remove empty module tag section
Date: Tue, 10 Jun 2025 10:22:58 -0600
Message-Id: <20250610162258.324645-1-cachen@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The empty MOD_CODETAG_SECTIONS() macro added an incomplete .data
section in module linker script, which caused symbol lookup tools
like gdb to misinterpret symbol addresses e.g., __ib_process_cq
incorrectly mapping to unrelated functions like below.

  (gdb) disas __ib_process_cq
  Dump of assembler code for function trace_event_fields_cq_schedule:

Removing the empty section restores proper symbol resolution and
layout, ensuring .data placement behaves as expected.

Fixes: 0db6f8d7820a ("alloc_tag: load module tags into separate contiguous memory")
       22d407b164ff ("lib: add allocation tagging support for memory allocation profiling")
Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
---
 include/asm-generic/codetag.lds.h | 6 ------
 scripts/module.lds.S              | 5 -----
 2 files changed, 11 deletions(-)

diff --git a/include/asm-generic/codetag.lds.h b/include/asm-generic/codetag.lds.h
index 372c320c5043..a45fe3d141a1 100644
--- a/include/asm-generic/codetag.lds.h
+++ b/include/asm-generic/codetag.lds.h
@@ -11,12 +11,6 @@
 #define CODETAG_SECTIONS()		\
 	SECTION_WITH_BOUNDARIES(alloc_tags)
 
-/*
- * Module codetags which aren't used after module unload, therefore have the
- * same lifespan as the module and can be safely unloaded with the module.
- */
-#define MOD_CODETAG_SECTIONS()
-
 #define MOD_SEPARATE_CODETAG_SECTION(_name)	\
 	.codetag.##_name : {			\
 		SECTION_WITH_BOUNDARIES(_name)	\
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 711c6e029936..c071ca4beedd 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -50,17 +50,12 @@ SECTIONS {
 	.data : {
 		*(.data .data.[0-9a-zA-Z_]*)
 		*(.data..L*)
-		MOD_CODETAG_SECTIONS()
 	}
 
 	.rodata : {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
-#else
-	.data : {
-		MOD_CODETAG_SECTIONS()
-	}
 #endif
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
-- 
2.34.1


