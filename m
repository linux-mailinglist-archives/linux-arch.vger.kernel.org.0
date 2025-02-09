Return-Path: <linux-arch+bounces-10069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC9A2E107
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 23:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC6E188641D
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB021E00BF;
	Sun,  9 Feb 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlUULZz7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F21DFE29;
	Sun,  9 Feb 2025 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138548; cv=none; b=drnFwSHMgIrcaeV+M+WsJCGsOjfuBnBMvIHpF3G0TeacJPfTe3yuuvXKs3CuuGHQRidXoZYvgPTAhCQd93Dtgz32AeAwKgzFOZKt2IUoIMJjq7B2WMRgDbgqA8bxVwyCDxLLQjDjLl56twG4pi3fqSNjmGXiTyclcTvppbwbr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138548; c=relaxed/simple;
	bh=n19fHMY0fBzL+SD4x4buAM62MKKVSOyuM/FO69KBres=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CSBSrE6wsnUE/Jj56kyfC4npnU1H2JchoV85SJpu7Mmisg5sdlMO9BKUkrcYUd9qBZAsm+b3APnr0ZDMdzWGMMrCsSpjeo7lKHNSaulI6Yn5xbRKb4CS6Lb3chfiWuxY+eknQ5odPIHAzoIwI5gxxPalOHVjroiuoakk+7WDjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlUULZz7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc9eba8a1so1986614f8f.1;
        Sun, 09 Feb 2025 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138545; x=1739743345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrCBrsBGQ+tCvXOABWtiT76sFUcDv+I/VrUzIQbDTzU=;
        b=IlUULZz7/mEyEXkkGWrFT54MeasS2ZNxzroeKAy1xnMSJLI9PJ18hh6y0Mj8kAriOh
         dtf6KlZe8rnVZGAvOEXygvjXGaC8m2rmR91+JPERrIbvkRiybFXxY09Gc4CWP5U2+0zb
         k4/BRdzLzTJ+eVJm1NQFZ+I+0u7Aqs2XvMz5s7Phd0pL5Kc/txuqy6yA5Hyt6f6rSjNH
         l6I3wUJFKuINaEZKzhJi058udCe7aQTQhfIWPQbe4CatpGzbsc8dl5qo5yNgKocsWfmS
         ZGrlBt1n5kLEhmtnSvhqoPtUGVofoHYB0E8fNa8ZHlt96CX69siPbhM+fiE3lgQR04j0
         FftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138545; x=1739743345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrCBrsBGQ+tCvXOABWtiT76sFUcDv+I/VrUzIQbDTzU=;
        b=FzELA7shXKb/UdGH5fSa7Bey4sPxulHZNX8+XHsvFrrolB3s2OWFMG7GFmOyutiVNf
         v6xjqPKl7AzBqoQI9wLmONHH8gNSqmnv6eCpdhe9MqWlHDeO3it50qye+TuJZ+h/uP35
         us8BXrJvs+tSQvf49kyifRQvwCqPPfiiPWqghOBIwDp62l2s0CQuAfuAj2boW3ycrIkh
         6Ht5a4uphmSOFwCOTgWoRMWEmtWvFlyYqcvHOxO9IvPAAESGVyBFMSHvOJvQPMst4dR4
         1Zjfq+tCVC9f4jER7YRtgFLJABQVrOSfsysJdNDbTqv5pP7+kGPEVjoRnsYtgoPtADAC
         giHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7PFAlWB88x+xAi4mZSZVhh0sSFFCxYFLoyi5sUy+VOTccZASpaKebDmFkxvH0lYYYOyLpxhpJu3dSFiVg@vger.kernel.org, AJvYcCWSZtGkL/fc0+ZRp+bF89+WQyO3Q9KhpB8tw97CTNFfIeMezH9gHECoEE2IjZF2wXjsp/lfm9mpUaI5@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAI/nhuuoxS8ieJgeU8L4Xbo5nCJYa7YgNV4rQw0zsgAnh9p/
	Hdx8PKN7hzmAQbfiyq5+V3zdCdE903ahJ0A82QIj/Pq7zuLU2sVm
X-Gm-Gg: ASbGncvhwy6BhMd3o2L4iqZ2d2PUIukuGJA/rqSaxXlDnzUl4a6FZ0O2YTiQaJGGjrM
	g+YwnUvr/+hACSoUsgOhvkutunupjN9zcWuFCBWzRkWw+MhjBWQDcyqF65b3ww+kpfb7sdtplvF
	7a1MwFHA/ncrQufIiztT5rafoesRgshytyUG+0kefBPxew92ffFd6Eh6uGqBEwJn+Bwjm7xzGi8
	sfNa5uNBh8SwvW648RJ0r3WZCzgL1F3xOUuldH8jwmZoLYwPl3AW7Brz1SxK0c7ux6Bef1XMOdJ
	+oqJFrp9GmpVvW1c4jsU3MRbG1Nkdlji4qxumo26wu3wBH3t7CSBQtA1usOFwwWwJALLXg3N
X-Google-Smtp-Source: AGHT+IGLh9i/kI8Ha8+Op3DoUswKsdryEtT21pr/+6nTQeWXoWEW/G6p3UUlYi/NxO5jEdod/Gguuw==
X-Received: by 2002:a05:6000:2ad:b0:38d:e02d:5f4c with SMTP id ffacd0b85a97d-38de02d60b1mr208725f8f.10.1739138545239;
        Sun, 09 Feb 2025 14:02:25 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd9a6153dsm2919003f8f.60.2025.02.09.14.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:02:24 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-arch@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2 1/1] x86: In x86-64 barrier_nospec can always be lfence
Date: Sun,  9 Feb 2025 22:02:22 +0000
Message-Id: <20250209220222.212835-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When barrier_nospec() was added the defintion was copied from the
one used to synchronise rdtsc.

On very old cpu rdtsc was a synchronising instruction.
When this change X86_FEATURE_LFENCE_RDTSC (and a MFENCE copy) were
(probably) added so lfence/mfence could be added to synchronise rdtsc.
For old cpu (I think the code checks XMM2) no barrier was added.

I'm not sure why that code was used for barrier_nospec().
Or why rdtsc ended up being synchronised by barrier_nospec().
lfence is the right instruction (well as good as you get).

In any case all x86-64 cpu support XMM2 and lfence so there is
to point using alternative().
Separate the 32bit and 64bit definitions but leave the barrier
missing on old 32bit cpu.

Signed-off-by: David Laight <david.laight.linux@gmail.com>

v2: use a explicit lfence rather than __rmb().
    Update commit message text w.r.t rdtsc.
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 arch/x86/include/asm/barrier.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7b44b3c4cce1..b9af75624cf5 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -45,7 +45,11 @@
 	__mask; })
 
 /* Prevent speculative execution past this barrier. */
-#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
+#ifdef CONFIG_X86_32
+#define barrier_nospec() alternative("", "lfence", X86_FEATURE_XMM2)
+#else
+#define barrier_nospec() asm volatile("lfence":::"memory")
+#endif
 
 #define __dma_rmb()	barrier()
 #define __dma_wmb()	barrier()
-- 
2.39.5


