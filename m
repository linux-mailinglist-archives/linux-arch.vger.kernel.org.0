Return-Path: <linux-arch+bounces-9309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000169E87DF
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B004D281965
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872BE199236;
	Sun,  8 Dec 2024 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfXmwqqI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAB198E92;
	Sun,  8 Dec 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690852; cv=none; b=MY7uCNrRH3nyr7SX7B13SHXwOpY1P5/4ZyrH1kCavbUACQXnhWcQx3SDKV5RSP6EuNu0+RlO1eAv5U9WAQKgzyFxQG/rSm1scUqA/oaIOpvBpY5BJ0hzAzUZ/97p+OVDigjPokc4TLsndZgFi7hXwtvLcns6W5BrnfhIWuv8t9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690852; c=relaxed/simple;
	bh=Ze7dVGfYMmVKuhY42eH7V+YVP/tYMVSM7o7rJH/EuB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSawShsul74ShzpQoY6kDcmx9xv7kRtKValgMCxD2oUsGcx+FZ/cvMV7iLR8H78m9+VaUQakdCdE2T02AXB36daWznpFdUIsTi6/H+fL3ORCdBcIMFNOYO2C/1yCVJXQZv63VsinropND0prgtho2cHR+Ik727PkMrRNGRHA5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfXmwqqI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so2595670f8f.1;
        Sun, 08 Dec 2024 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690849; x=1734295649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl02e1tbeNqkkscoGaVtIPs3YTZ0CcynxSRpc+0Q2zA=;
        b=IfXmwqqIv47Iu1UT254IrAXLcmIL2rHZS36dngWOibr/DoOTUIZFITXft/LwheJcln
         Q9U686BuYbAlG3DaaMPNF0yEmF3hnXqac0cMdr3Rqdqojk8ih5WUeE6YJrPPgPADfpBV
         OzkemphpzYml8TJtTOCTuVclQd05WxX9pG8gJZc+B6W2FdY4X80eHGRBNT/V+6XUk7Ew
         T5vH84ubTkFLcb5ToSLAEkyOp4osebrWGSKPXxOGOgYnBaQ049pI2+HsNHNe9VUUNon7
         UODxbbeNoHRpnM1cLBMebhlyjvud53L5TkN0XqqjS35NLvkEF/rq8gefZbbtWLi6MQ+y
         HKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690849; x=1734295649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sl02e1tbeNqkkscoGaVtIPs3YTZ0CcynxSRpc+0Q2zA=;
        b=tkULpjEHYwGb2k0LZOGU7GANDHbWMeRb71qmkSOX6sK9WdF+3MeUcw0GnhqibF6KjF
         xzNlQgfoMIcM2pRCao0e4mtAVFCa3sRSysfedd2QF48z826VH+92i2iN+qCPiYvZb/Az
         AckHtCV9auJdbxQ21vqh1SHh/CYozhfdVPTgrVubC0LKGzv3kidv7+govPQX7GuC3E28
         SipnKWX/y34+wRN0zQnX3W7h3rnVNLSTh92vWuPO66nlV8Er7wg4Td/kHKs0C0pBBNPg
         UYCjwZKyieTbzTX70csKpSB/t+1lVnPiRhtr0TZ5BHfoZiF38QPw+SyugUkzvp4w837t
         +NbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MBN3nIvoXh/LI+zwZnSSjF+MffCw5qiQs3zRq88ORPL38aQ3LOpoccq8CPMqPJBHjFSOcFKteGZz@vger.kernel.org, AJvYcCW/FqjU3jPUsiZ0BlMXosp6psRilO19m5hz6KJ74EjjACl3gOW+t+6a09zupWAbVnoNbkmKHLo/@vger.kernel.org, AJvYcCWU86HdLtaqIPtPkJQOw04j9AIMPc2gTkxwY0jeFZ8B/vnWSFShBGlbqjiSNREw0AT0ChckW/DEItaMu/iueEg=@vger.kernel.org, AJvYcCXZzyNqi8q+giDZL4ppEnZMf6pKoU7PVMT7tHD9xEUcWKsEaoHadiLcSQk/kWhl2R95kupfra7+/ZX+jU3K@vger.kernel.org
X-Gm-Message-State: AOJu0YyQILox+cwuHyQe5DP24XaLFr48vmIcc2zmLexKuWB6Y/HYejkJ
	E0oN1ETCVlaffiMQGv7zV8sWbvGhfhESdVv1zpZtrf1AjQtvbIkC
X-Gm-Gg: ASbGncuEcWtYkZ43ki42OB4/HxCYBRcN9soramQdBVcfHXMSvtqNIV8ESnKGYM3WPwI
	J+I4VDkZr+CPJMegBf4V1hHcMCzw+BlYs4gvhtgJ/BnPDQpu9sH55Bu0gSWEtzwzBdRBzdJSGBV
	VYumTECQwiaGBW3x/ikJ8I6HCo4m1pLgU/90cIXdTzOvpOEJY+s8BoMYnG1KcW31VSRsnlaYv6R
	UEZ+P3rnpe6i+uQnpkBPuGgxlLnmTBAtWowBUTsQF1pFhcApwp+tbAqSsM=
X-Google-Smtp-Source: AGHT+IEhGoPt0DRcYf/EuijpX+E47Uzih3ytt4xJbhowf411wPQtgH//qgvD2xRwzWN0Epd0De+3cA==
X-Received: by 2002:a05:6000:a14:b0:385:f0c9:4b66 with SMTP id ffacd0b85a97d-3862b39b9b4mr8976505f8f.33.1733690848668;
        Sun, 08 Dec 2024 12:47:28 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:28 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 4/6] percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
Date: Sun,  8 Dec 2024 21:45:19 +0100
Message-ID: <20241208204708.3742696-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use TYPEOF_UNQUAL() macro to declare the return type of *_cpu_ptr()
accessors in the generic named address space to avoid access to
data from pointer to non-enclosed address space type of errors.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h | 8 ++++++--
 include/linux/percpu-defs.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 666e4137b09f..27f668660abe 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,10 +73,14 @@
 	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
 									\
 	tcp_ptr__ += (__force unsigned long)(_ptr);			\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
 })
 #else
-#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	BUILD_BUG();							\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)0;			\
+})
 #endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 266297b21a5d..2921ea97d242 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -223,7 +223,7 @@ do {									\
 #define PERCPU_PTR(__p)							\
 ({									\
 	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
-	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
+	(TYPEOF_UNQUAL(*(__p)) __force __kernel *)(__pcpu_ptr);		\
 })
 
 #ifdef CONFIG_SMP
-- 
2.42.0


