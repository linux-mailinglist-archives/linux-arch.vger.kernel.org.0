Return-Path: <linux-arch+bounces-9919-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5268A1DA2D
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B573A8082
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6011632E4;
	Mon, 27 Jan 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1NAwXsv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A9433CB;
	Mon, 27 Jan 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994045; cv=none; b=tqWQjAmK7TQcdMu+587RPXGB2P8RrCKPC7jIf3QM+gdS1Wx0MKoRNth03GUstXTc48l7psASBMXVgj8Qph5dOcbszxdrej2n/4JrqZSF6bG8NYpAQuZCrH5RYENVNwi/lQVm944wMKgdQ4AiWn6uUFYZJUMcG4l0KpMTOab8jm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994045; c=relaxed/simple;
	bh=ogmAtJgEaFLWhDuyZKKcCqZcT06MJkx7e0moOOTVcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOx5bl4YyUGzfmyru+yhBGZnenIDU7/3PhNUhiv60wkxUSWMe4O/sFRiBIWGVf1d/+xq9eYFE65GUIxni4+6dLbndGKXvdT7iDNyB/XFAddJf0T2Lb+GoJDnMCbXbWaYjtO+RJUhH/LRO5iRzhZ6MfkpTWGPuctQoEDmtSUKRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1NAwXsv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1010201366b.1;
        Mon, 27 Jan 2025 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994042; x=1738598842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=B1NAwXsvMciORuJURVCZ8WUkCjZ1Em7U9BI1FjEHxco3vImD2VYWn/VfnHauy9yAfo
         uec8j+P206TP0kx2a2OeSBrGHyJIb/zy+pYWS9RIQ4KjZiToXvZNb27Y+yeuZnV3L9Ot
         8Ahc9uGZZUFduXPZbgcxOxdAwj+TFJqjVCiU5Qb0hQBpR2SJyL2NjzTZ3HPlBkv2liIr
         hfHdw9Aey2FDN83olHh0G5iqeWEePb129gFcqLMReF979ZmRsgcKq6pw+8+2VkfNBPVj
         05Sd2hsuplFuBka8xXs0z4ucr+YaQsrII+5Uk5VMerS+w1VyAOaizZQqc3SNPxRvtVvX
         dCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994042; x=1738598842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=PAPUFwLPz/xGh9EJ9Aa7A5Xuf5GZESf4Gwc1jFzOnzgwNuHUXWSfiGxtDDUR3Qf3vu
         hTghqQfvldf5zh0/GBS/BnA9TWAnB6++Pj+hFYe4UJTsAUEdq67qR3IJm3K13a333Qnp
         Be+GlaD/WWPagDHd2xEsyWJMEBeqK9te9mzHbqEPnpRr2Kt0BrMAMFLXxilksg8iNwQY
         KU9ifjEfk3vdM29KGfZSGWH4qkwcGioW1WXGYtjaEozAeYU1S6MnJdUHhvsmCQpg48if
         Ik/xwC5l2hj6tlKbjEbGUJDv/QCVk5LcEii4wu5ZtfU+S+IJWY/dIqP9j6zNzdgjqsjH
         cUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA07g3SnLDQt+q02Vysho2xYAaaoeyCH+nDy/lISqhExoAVqznS0C+ADTarFZ0aQ6i0HPfJJM9HB0t@vger.kernel.org, AJvYcCWBJB6NO5e6P2T9Ji1n6ykt3Evk9+ooIjoQkdQoTqIw1wYR9eEFfEnQ7GFdJpjwF7aS5PMguCS8@vger.kernel.org, AJvYcCX/Ci3EkPzmQuoEERbhA25yR/6yGlzPaX7wPE7UFq4QfhMHgw2Q1CpbNtig4mstK/Xtp3lex2qZHdtOR4Zc@vger.kernel.org, AJvYcCXtqod+qzhd8zG50p2Po48iCGWOAetklhhudnrHkoe8sIx3JEk9OzsS1dJHuoGfYugZJL+XqzDbGfKaco5ljPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdXXG+sgJ7R32wqOo6sa7Hp2dZ6aVnQnIi/ME/mB0KfMQ4vMN
	1RLRWpclU22aNMfbwHKz+Aggri4rS1vUc52QkixCgs4Xbz9xSnQ1
X-Gm-Gg: ASbGncu8PrWYURQqBhCrlzUAIbY+0gbhwdvbm1EjFFYWvzd30kEyWcmnI6UXe7rPi1n
	0zjMVkRCvpp2U+PzJKpr4uv7d+kjbdskXraNJUbku2CxQnmIWr6HAuePKUHR2DayAYnhOvgsQCC
	llyEg0vf6fJJEaq8Uj1iSxwQmNrv7frkNrgSZLf7AcLE2+THa5BMyUJrBt2J9DmC8Qdpzfbm5SF
	zjHm1xFiOlGveGndTGeiHYiZqfp5T9yAopCkM2CiMjmbYrGvvTRreY/gBSK/M1iHZ5yVyvcGHLt
	P+JFaRNCSfF0ig==
X-Google-Smtp-Source: AGHT+IGxHekg6wyKtSsIHlBYr5ZZfkRZgv/1+kkXgRb8vYd9lhSt2dayN8UQWL8xHzS8S9+szifYTg==
X-Received: by 2002:a17:907:930c:b0:aa6:557a:c36f with SMTP id a640c23a62f3a-ab38b378436mr3836172866b.46.1737994041908;
        Mon, 27 Jan 2025 08:07:21 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:21 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 1/6] x86/kgdb: Use IS_ERR_PCPU() macro
Date: Mon, 27 Jan 2025 17:05:05 +0100
Message-ID: <20250127160709.80604-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250127160709.80604-1-ubizjak@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IS_ERR_PCPU() when checking the error pointer in the percpu
address space. This macro adds intermediate cast to unsigned long
when switching named address spaces.

The patch will avoid future build errors due to pointer address space
mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..102641fd2172 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -655,7 +655,7 @@ void kgdb_arch_late(void)
 		if (breakinfo[i].pev)
 			continue;
 		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL);
-		if (IS_ERR((void * __force)breakinfo[i].pev)) {
+		if (IS_ERR_PCPU(breakinfo[i].pev)) {
 			printk(KERN_ERR "kgdb: Could not allocate hw"
 			       "breakpoints\nDisabling the kernel debugger\n");
 			breakinfo[i].pev = NULL;
-- 
2.42.0


