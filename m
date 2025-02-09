Return-Path: <linux-arch+bounces-10065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A8A2E027
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 20:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F193A5A3A
	for <lists+linux-arch@lfdr.de>; Sun,  9 Feb 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C841DFE3A;
	Sun,  9 Feb 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4omaFgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A441119A;
	Sun,  9 Feb 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739128249; cv=none; b=FQ8Kf5sBhMl1ZAJ0FeKIhSSRW/BBn8Vq6SLQhu6T307gtmeIUWDILG3GQDksWXomzePyrGEgCYFTHl/jp2YDaJZSRA9g8gaPngWFB9ejeLN3UuQ4E0YhKoxIDJk3e5HdyMoGBpfgqvSrvZaL7v8E9e3i4cO5P/h12tc2fkNi08o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739128249; c=relaxed/simple;
	bh=cmFX9cBUsQmhCvU2ldft3X0AVo62ZY1+VRM5pS+6LDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHwsaAzakVdMLD+Kc8fqlCVSNFOGQoorvzYyGpEWeFCHrKL/dZBgOnTd9f3dN/3/15np+WuEMx0wv7nrJ7wkQBwg6/h85h+ORSjzcTyZV1fvKjD5kokME5Fj0Wca++nhSJnUrJwLt1jCcg39m2yyt/LsX9MevbojIhiVxwSZRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4omaFgg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439307d83f0so6831935e9.3;
        Sun, 09 Feb 2025 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739128245; x=1739733045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PIfDrYoTT3Z0KtMYk3b2jja3w+ILiNOJ+8sCw8lZMI=;
        b=m4omaFgg6lnENbEbIYyZEiJDhDx+0e2dcQVo2WnKP/573XZwrpIUIoYFUA2mSdpy8m
         qR+M8AemDId2/pcTPbad8wOGQD1jI/y13Knw3sNFZiN6bG1PpsQj17E53is8diPWk/zO
         TW1Ui5uGbO5MC+CZyoPA62ZrhMBdyagQSdWZd1/4NxYcP7yI3KCQh54Wq+6CRrjfm+03
         iBRc/rjXmqmCftN2dz9IIgVJYizdtOQdE0ULKVPL33PqNwQwhKQkpuwKjhiCIw20/YBm
         wrGJDNnS+zB7EysyddgLCXidfKJA030JX8/eEJgAaSWoS9V7BVHYQX8oEMJowETyUDfC
         Luog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739128245; x=1739733045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PIfDrYoTT3Z0KtMYk3b2jja3w+ILiNOJ+8sCw8lZMI=;
        b=C+qkc1k5tbLpaDcTtXc74/AvIu1ynteufr/gFtTgKrSeE10QzDVg3FgxV1rzgy8K+g
         bjEwfpkBtvE0ex6MAw5j2mL6xRE5AcbTk2MJL9rguMQHgbKL0Iex142Jj+hUyxDABADx
         N2rMoM2iJPvlOH9JTGJ+fZcVYayklbRSxzgPs1gW+yoalmt3pg8klJYasPhpnAhFDCtY
         lIpw0r5MDGQmEQyKeB710SyvcYqk6fSsnGkUx6BU+WZHDQlnIS5SXyVkezE5aKoOWLLy
         anS0CLc8MOzViBL2kBfoUx04TdtSshq3xSRFDYnZCZKUa3UDyTNaxg7PorhYlvXuJ93i
         0NRw==
X-Forwarded-Encrypted: i=1; AJvYcCVniHsMrRi+8bEYVJv25lb7o0wkSJEGi1qv00hmOKs7RdUqLAjIikEZDfcq/d3tsdhwd9lAoxCs7F+Cnhh4@vger.kernel.org, AJvYcCXEkyZ9TG/pgnaOcS/hs5B0Kn+2FOUzIClr3/FNwWBmUNVOsF+h/HfGxygcXZBYs10rVu4w9MG+Y3zw@vger.kernel.org
X-Gm-Message-State: AOJu0YycxNFwE4rYAuaGsR3XrDVcGq2u8vB4QsCVDGrMyzpmy++NCyCN
	6YUg58Dhkp96JLiF3LOFsVlZnWtFRcxZ830mMnKRenCTsUlF2mM1
X-Gm-Gg: ASbGncstda7bbC84Ld0p6TE8mSPTKxCEnykWt0UWzcoHT2oWnQEHcFfa/uJlnJg53xo
	s4elOuuqOHJaHrkvMjUbA8FZY4Zwg8aReY/DUb+kS6h+51VL4rIc/ooXPYbyZGDlg6t02sMjHNj
	LGnBtuGMUDBXxPn/WDd0/CHbtyuLjMtBWZ+1z3WxdV65oUXrwMX5Lb5cHUyuLK8mkkRHPUHJudI
	lSvXDsP1Mys/VEqp5/uK2ZjVqMAQ1T8tP9O18Fq4sNqneWAIzAXvzdPap39STrw5TZ9BLHoqvYw
	Oykt8syLyZAwjjhbANKfzgp77piqG+cqhCUEwk6ZL4Wfey0TPFkXFJdQwnXaCS/6DvB4HgV8
X-Google-Smtp-Source: AGHT+IEqBrgVZ4srRjI2KDjmFb2+XeA2Lt+fPqJ9+a+4DCSdHTgh8qGul9BTPBUwumfDKQtVWy4saA==
X-Received: by 2002:a5d:5885:0:b0:38d:b926:958e with SMTP id ffacd0b85a97d-38dc9101a71mr7868032f8f.16.1739128245412;
        Sun, 09 Feb 2025 11:10:45 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd0fac67sm7216740f8f.54.2025.02.09.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 11:10:45 -0800 (PST)
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
Subject: [PATCH 1/1] x86: In x86-64 barrier_nospec can always be lfence
Date: Sun,  9 Feb 2025 19:10:08 +0000
Message-Id: <20250209191008.142153-1-david.laight.linux@gmail.com>
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
(probably) added so lflence/mfence could be added to synchronise rdtsc.
For old cpu (I think the code checks XMM2) no barrier was added.

I'm not sure why that code was used for barrier_nospec().
I'm sure it should actually be rmb() with the fallback to a
locked memory access on old cpu.

In any case all x86-64 cpu support XMM2 and lfence so there is
to point using alternative().
Separate the 32bit and 64bit definitions but leave the barrier
missing on old 32bit cpu.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 arch/x86/include/asm/barrier.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 7b44b3c4cce1..7eecce9bf4fe 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -45,7 +45,11 @@
 	__mask; })
 
 /* Prevent speculative execution past this barrier. */
-#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
+#ifdef CONFIG_X86_32
+#define barrier_nospec() alternative("", "lfence", X86_FEATURE_XMM2)
+#else
+#define barrier_nospec() __rmb()
+#endif
 
 #define __dma_rmb()	barrier()
 #define __dma_wmb()	barrier()
-- 
2.39.5


