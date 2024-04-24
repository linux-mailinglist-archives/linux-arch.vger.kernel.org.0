Return-Path: <linux-arch+bounces-3933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2EF8B1361
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B46D3B22F1B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0172A78C7D;
	Wed, 24 Apr 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nau83yEZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31402E83C
	for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986263; cv=none; b=l2Yyfg7cP+RYYCz9hSr3dRGJ8vTZFlP8eAlAqmOxtDRKjmgrn5X3HkjomTm+XPuyF9qZapmnEFRdUgD3GXx9OrMmzTntl5va5hgQBYYDJcaXSN/Eqx+S3ck2YGZhqs/ONGw55JJ2hZ32iFO4H8K7HN6jzImakGlwzm8O+beYIXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986263; c=relaxed/simple;
	bh=FYeUwjmTkimRdEar0nMCEB+zeOzWgwm4wTKMgd4cZTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyXPThqzzHGMI0+mKTOHPycqn5WTwCZi/lTVMYw9blox5DiyMOOjaDe15T7g/MKbeMfe67qbIOSJvoyrePNXWRLbd4CXxnOv5aDGd/YuDoM2mYPGzkJmH1B8dYggcj5748WoLKqIkzSKLHYO8bTJ69aiy1DoVr00n6HXTs+bTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nau83yEZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so1470475ad.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Apr 2024 12:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713986261; x=1714591061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo2K8jVQRi43xxtGN8MvYubFuFXJHBPNUxXy1Vyz154=;
        b=nau83yEZNXyYb15/5p9shTigu/gxX+KDznIIqt5wX0MFYqK2fWZisbPTxy+lftlnP8
         0rq0EvC0g+l4WSNfI73VJJiHgCtu5IlWYMGiPA5QM/BK9Um16cv1d6PKsnUXDekNu9ko
         yR1ho75BwN2n3UcKSEMuYtbQBnjKXtG7ex7/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986261; x=1714591061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vo2K8jVQRi43xxtGN8MvYubFuFXJHBPNUxXy1Vyz154=;
        b=osW7Hb6AgyRwrQOfMXbCMlHESjl4WsvFhAJvgH0tdcRTqqrJ97i8SKDzCol7i3dIcC
         WY48CDiGLWkxGJnkbq14Nd5absTg1QU9nHqEHDd6VUfFSPY/6U9gPd1hj69VCb6DdkLv
         XWKXr+fZBwZ0abFAoB9tlPjmMQPKgOSjNYYdMDDxPmNND10ZdE3pxhpv9PwR0DgI1Xev
         boL/agXSDO4ebyzahGi47S3c2NUgsnAfW3QHJCzNq5QTtAIjaOaLklVDhNTK9QBVCMfD
         0ONbSfbg1eRaL203GJUmVi6hgeJRXMidi0cz5owqzonNM+KXmVnHh0JXVWeCQgfuwKak
         gUHg==
X-Forwarded-Encrypted: i=1; AJvYcCUnRGbvvwbUolemeW2l+JUATmUkBQPTP3JMuMfB1hNZHxaCi95QI/E6g1uzmdMuhkK9xuWMrfFBI6L/bb9KwRmTlUxgQA/l/yxmNA==
X-Gm-Message-State: AOJu0YwggYhhT3v6ORw2B3sbf2pvkZ+77czYvgfBtFZdErrpH4Ulyzu3
	sCnaR9f3BKt3nNo0eqLKXw71Kw0RdjHvX+Jl0aKGJ6069atRPUePivYhWx78UA==
X-Google-Smtp-Source: AGHT+IHRQ9hlNd8Q/9S+swXrlzFZSC66Zi7MONSBZn2dTrR2Cr0f8ozzcVQ3tJLvlRKVSkey9HjOwQ==
X-Received: by 2002:a17:902:9a0a:b0:1e2:88c9:6c08 with SMTP id v10-20020a1709029a0a00b001e288c96c08mr3007206plp.49.1713986261101;
        Wed, 24 Apr 2024 12:17:41 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001e8b81de172sm10657799plh.262.2024.04.24.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 12:17:40 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] locking/atomic/x86: Silence intentional wrapping addition
Date: Wed, 24 Apr 2024 12:17:34 -0700
Message-Id: <20240424191740.3088894-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424191225.work.780-kees@kernel.org>
References: <20240424191225.work.780-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=keescook@chromium.org;
 h=from:subject; bh=FYeUwjmTkimRdEar0nMCEB+zeOzWgwm4wTKMgd4cZTs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKVrROPsWV+7wAsNj0gHWR6QvLgSLyEzC1bVpp
 NVRrZ63HliJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZila0QAKCRCJcvTf3G3A
 JkgzD/483ESp9GunXhngEBu3wqcJ70FbQue3kCmbpZPgaJNUscH+iguBQUrzVLdn7cu87nT79UE
 3xRAFrXdq5GSxPYCb92aPEvd8aADFJvKoDecGHPMGvZZr8kounYftdQ8SEpVM9oCDOjPyjA+KbY
 MeySHGPTKhpplullPe8MqxiQHrtIoquHhMmPCgei09S6htYIiB8sqQA5TU0xWKlYx7WFL1vnzPI
 5T2ndbMr6XQDFTlro5lIHHCPD4sXQQzkXxTcIAj3bNuGLnaKaJK1VAjG73ZDSlATjlSEkI4gwTe
 ONZaFwDrJBOJAk3CSrkxoK/DvAba4x+V0xqqUTX2v6iKZ5c3A5pcNuWX8si2iEPTgtyF7A4U+3H
 rEmjb2JKW+/zvKMc06jW2biYhQFLBOSCK8Cglq39Fg0nVhw4bLokjyM+9dneyphXqyV1k/FGfkY
 tbOSZtbZ6FOSnFbEmmELsvsZce6ReBSibvd6VPR347wmA7fNATxiOxhZULH5Kt04r84/4bJx3SL
 APbwpN8bVPbPRu9wywmI87MrMFEYOTXQqp2gJjba4fn0y5aGIWmrlroPuF68mNwDWGHb8AlHI8F
 Aycb/DYtsP8itByLJZTj9bWXlZJf/UxERnyLFLxuJGIETgsD3jCajtE/J8bdow6dwZZ0NAJKlw6 npZGDZtqE/FCMNg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Use add_wrap() to annotate the addition in atomic_add_return() as
expecting to wrap around.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/atomic.h      | 3 ++-
 arch/x86/include/asm/atomic64_32.h | 2 +-
 arch/x86/include/asm/atomic64_64.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 55a55ec04350..a5862a258760 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_ATOMIC_H
 
 #include <linux/compiler.h>
+#include <linux/overflow.h>
 #include <linux/types.h>
 #include <asm/alternative.h>
 #include <asm/cmpxchg.h>
@@ -82,7 +83,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
 
 static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
-	return i + xadd(&v->counter, i);
+	return wrapping_add(int, i, xadd(&v->counter, i));
 }
 #define arch_atomic_add_return arch_atomic_add_return
 
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 3486d91b8595..608b100e8ffe 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -254,7 +254,7 @@ static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
-	while ((old = arch_atomic64_cmpxchg(v, c, c + i)) != c)
+	while ((old = arch_atomic64_cmpxchg(v, c, wrapping_add(s64, c, i))) != c)
 		c = old;
 
 	return old;
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 3165c0feedf7..f1dc8aa54b52 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -76,7 +76,7 @@ static __always_inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
 
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
-	return i + xadd(&v->counter, i);
+	return wrapping_add(s64, i, xadd(&v->counter, i));
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-- 
2.34.1


