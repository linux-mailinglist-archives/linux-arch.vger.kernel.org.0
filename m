Return-Path: <linux-arch+bounces-9258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97239E5A09
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8922863B5
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AACE225762;
	Thu,  5 Dec 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxjowGR6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862E521D588;
	Thu,  5 Dec 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413389; cv=none; b=NaaT9hD6+C4vffHI9Sua8ZbksDa0+G50umC3C3aPVuSKCSz9U6Svdo87rxKWjV5eSI9YRdqAsn89scVtMnWrS3Cr0EsM8WlyX3hDBiwcAqkDrrA6M0GtnQ5Kumd1F0ZczPZ3VanjBf+Hr5Aqh41mX1XXzAjSRSLsAjV88cRCnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413389; c=relaxed/simple;
	bh=JLONeVzsZCBy3eSNw681X3ItRvbVGoCCoYm7SMR5mOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9NCppen2CCznQrVDfngIuKeHZqrhvzK6wVkZO6eTTbn5VA3AjrBbrWU84e0K3UUXkftRXaDwWl3IRHdVLuA/mXlr5B8QU2cxrqWftyrG6PJg3ajjDH9b4AfLnt3Z+OHrpegVJLgGYKyVBqmP23YXL/4FS2WVFeaBUFIe1fPz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxjowGR6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349cc45219so11071835e9.3;
        Thu, 05 Dec 2024 07:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413386; x=1734018186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odscJvo7yyRgZdWr5SFETqd0CUulL/qOTPh5EL6fxjU=;
        b=lxjowGR64rzsBDN6zab6RwPQyAgR849OXaTYtocgrU8drOfCtmTQkbAiv575SSE9bg
         8iFu7C8x4O9SEFH8uAe+9GWep9mwWBVisPRfJkRSlwl5uYj1uTsCSD652DaIn1s/i9Hu
         YiwjlTY7tu/zTB8sallw7wHC4OTA694FIsIRhn0mViCEW05BLkyw8Z7UiORp6qglRxOo
         vFGoWGhXl5YK9X6jRD12OTqxL9hMg1cUl+vnBiY7fDcItQnW+Y5OTEBqwrnnrrIkViSI
         0C47J+9x+nphGddfVannzaqNH6RKH0BiExTdkPAv/+1R5EOccDKtQ69bOpFR1HTe6te6
         J7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413386; x=1734018186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odscJvo7yyRgZdWr5SFETqd0CUulL/qOTPh5EL6fxjU=;
        b=Kj6mc+Y0CX2QzXB3PHkjBzNtjjGegqmi4kI1Q27f27V59IIMBChpfldXZzdqd6TVa1
         iK6EvhI44oYxUCoqiRPr6NJVfXSC830rgUfqfEbpjtCuu4AND2kXlQBH/T0UH8oVaJqS
         dIq8+J3RC8VLRbaLxalxF/9jfXrD/X87wec6GSHpIOuYkYgtlipAilymR0Nw6vIr416n
         Mw/2F6sHzwQAXpiEhmcYJY3wN7cHhgi0M2LziaDltj9Py9zdFHn5QERAbGOnLARYMTV0
         +fntFyKP/1H1f+nq+ZeYA17Akl1l8cLsic+m/1ZfhbG1lpa47kIpoo+ZmWdzC8QgwJe1
         gkqg==
X-Forwarded-Encrypted: i=1; AJvYcCUAt3bayb+WhQepWQHi0zF09b7+ecZe2iV7L4WKpgpB3yhZGiEpwaAdv3DEDpYQSRla77YiEXEb@vger.kernel.org, AJvYcCUp39vJux0c+Zwo3C6hYprjydNqmIo4QIP/X1NdaR033VtZvovlEn4woeUbmLlWSBjxK7Q7bVV0BY0Y@vger.kernel.org, AJvYcCVlie8ugT4SUVnTA/mfiSONRSfciMsJSINLKMfhByBn9QiJIk1X8+1DP68+WelA94qw6h98MDwP6pe1XC/6@vger.kernel.org, AJvYcCXqAGg7+g32ARsv+eXOoKhmOSg+mYFcUqgtUXbg7IW+8ccv8F7QkSRO8VlYR5fZJ4RyyUAj/asuV1aHULkGz6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK5mLL0E/SlRWw2AgPDDFZ1VXX/6OreOpB0ljZue/0bTaLRE3Y
	rSQtWp4GEm0HIU6oFbsYvACArQiS5dxYNfgmNMAcLhnmFcCoNESt
X-Gm-Gg: ASbGnctX0dha/A0xJ+IpiK+DJ7t+ZpzNi+Zap5tni8YVtIZxd6apIKuxedV+dfWkgJP
	UKREJWwZz8btJxByTCXr5WQBFFtSCuPOD1Hnv6ZEdmjcSBijXqveQo4ZOI0hg+xr00zYudzf5Fu
	mDH5u0ofix+3rBkjajlgi7u8+ScyTM5lLCvh/vseuKJYNk1aI6jeBu7hieoA/CsbZYcsE0mAKvr
	X2VvTcDXdPZD3kpSrsldv4GFQOuheP4TskSGV2o5UjbB0rwck/zp2NFwdQ=
X-Google-Smtp-Source: AGHT+IF5RwdGt4iaJz3BNz5kdah1/Sk6wyASmafTW1KvNAjQ+M3+nH5m+qMafwPkfEqTJkWyuAIxsw==
X-Received: by 2002:a05:600c:19cc:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-434d09b4fdfmr111120535e9.10.1733413385757;
        Thu, 05 Dec 2024 07:43:05 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:43:05 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 6/6] percpu/x86: Enable strict percpu checks via named AS qualifiers
Date: Thu,  5 Dec 2024 16:40:56 +0100
Message-ID: <20241205154247.43444-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241205154247.43444-1-ubizjak@gmail.com>
References: <20241205154247.43444-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch declares percpu variables in __seg_gs/__seg_fs named AS
and keeps them named AS qualified until they are dereferenced with
percpu accessor. This approach enables various compiler check
for cross-namespace variable assignments.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
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
v2: - Add comment to remove test for __CHECKER__ once sparse learns
      about __typeof_unqual__.
---
 arch/x86/include/asm/percpu.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 27f668660abe..6be1eafa76ec 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -95,9 +95,23 @@
 
 #endif /* CONFIG_SMP */
 
-#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
-#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+/*
+ * XXX: Remove test for __CHECKER__ once
+ * sparse learns about __typeof_unqual__.
+ */
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && \
+    defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
+# define __my_cpu_type(var)	typeof(var)
+# define __my_cpu_ptr(ptr)	(ptr)
+# define __my_cpu_var(var)	(var)
+
+# define __per_cpu_qual		__percpu_seg_override
+#else
+# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
+# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
+#endif
+
 #define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
-- 
2.42.0


