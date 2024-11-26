Return-Path: <linux-arch+bounces-9168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608E9D9C73
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB021282ADE
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473491DE2BD;
	Tue, 26 Nov 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PasuyTDP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609A1DD894;
	Tue, 26 Nov 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641839; cv=none; b=itKSidX8luTIg9N6j+muFV+b0uBHY6jQq4w2o9BBCorOxrVGMu3hB4nKX2whErDrRR6i8ox+NunZzebVimhXQgTd+V0iNz9J3bAQnoa34kmKfXyrgBiSr68vvqkLar4ORQk3AOL8AQr3EJ0aVjAU7HCutJF6LP7nbngaYDb8GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641839; c=relaxed/simple;
	bh=VvmlP5AH+fUUSyvPi8wqWT4LAcAAvQBDSvVszq80Jb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFpt1ZD+zRBbHm56iKPBI6RZb+Q1JKhIENYOiitJYO/uO4TFV6ei54wvV5GPm5o5TOQ8nujWH9UZlvOVWamtvoXhnE613KSzVETyZ8H9KlGt9eICPC0C4HmV9tMsA5pYRfnE3nWWeX4nONDeHI9jM5YB1X+mmvFEayU0GMW3U9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PasuyTDP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa549f2f9d2so357243466b.3;
        Tue, 26 Nov 2024 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641835; x=1733246635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scK7sUlNwfpZu+VLLnedXLuF+xaa2OfJ8eCpocRXk/o=;
        b=PasuyTDPIk+o30QbnbRZ9C/o5ajDIAxXS9t9r6TDH1csdPiywxtBIkL+z2PSImqoqI
         0M4E2YVOI/Q345nbId3Q4KXJmLAWaLFvfmdYZlXuIuRi2H1pNIHu6gJfcC9CHxM/jSg0
         CS8yjlbQ4KNvLFAEhGIx6uR9xl7X2G/Qekve27tSAmlOmid8E8kJ64RHnXJSGwHTVQlI
         zxxV+Wl0yfccnYKu6XUtbXfxXw/DVSJBSTKPyPLbi4RIf5Xr2TpckZfwy+kW+XDhGG4p
         DfLc54eglsxNp2gzdl5MRAW1bDvrSL1eU0dQlsQUaUqzYW0NtyYzinCXtA4X0WnxtLei
         9+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641835; x=1733246635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scK7sUlNwfpZu+VLLnedXLuF+xaa2OfJ8eCpocRXk/o=;
        b=sLX+anlf57r8e3f7v9BVC8waDSLChRywlsMR24k+kIbJs14N9RjLFYqXX0DksQnHoT
         Yab4kEhmTJ7TUt5s7iXnoyIuRGHzJKALOGYVs+4Uc9sDKBNDi6EYPyKPiRRtZ6hqxcr2
         zpbSW1Zn0iDRIqqDT1eAWEn9omszb8uvSIZZduSScHRHc/hYxdQVcMeKzT/UYgLEIs3n
         0nV/EldJPsaC+WSTku/6SAq8kM0uUJGFBvpKHRcBuFO2FzQ9LxzSd82psQ6TjYJkmpDV
         e549UtdWdw+GZT946AiScAg4m9+I05qbteUqIpJJGnfHOToVL6gHp7W+CHR1kR0vQCaC
         R+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU06t6cUSSKuC6YxloIGulxr+g3Uk8In5d64H0VmhsnhxHMYtVnQA9CyCMoFqN2kDKPgidD7O+n@vger.kernel.org, AJvYcCU43YYm0UelqpVDDl2rFLCctfllCWEL6W3QmCB3ral+COdqSPMEEzCVCA5XHFBp2Sp7xB83Th4qBNOiBgOh@vger.kernel.org, AJvYcCVkwuOFHtBem1gKZ50dXyYnFk+VREDaYlRqfDolg7KalSm9aGYhq88stifNr7ofdPw2Qorf18gaE3QH@vger.kernel.org, AJvYcCWXwwEDwrxnxWhvyY1X05QcjFTGP2dQrmBlmPBIwCxoP36yaIvgZH8XEkR5o8LNyhc157HPmEZn31z+poV7@vger.kernel.org, AJvYcCWYJX0XCOuLAlf1yXOCpJcDVdDcKjEIUsLKhhSXeZHsDoKG/KVSgHepKm3mjL8HPKP1CwkPx+eV2DGEo0hD6uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFe/DPxLZsOcibMlS+NS2//0DTiOCDdm1mDXRBmJ8DPltrXdpB
	90gzp39lj9ZZJOKoOVvhhK5mQoTjgIqIfa48pqdJWcx37E+gu8+EYzBtHp3H7yk=
X-Gm-Gg: ASbGnctzco8PwIGw85XzpKKPy4lCzmRXBkH6bp4miLAm5kgSgMlE1GSrLZa8EXhGJ0f
	AbHeHh6YUMxzjdvURQYW66rAUPxeA8v63tE+c7/A8YGdD/0rZ8k+JM/mDf3dFLAMEp+QZfgoq+G
	GFuSmwFBkJIgz+2CX6lwEGqapB3bxyxHtwiiF/Bavd+7ZVfsAUdqVqiaDT1wOlNQhsb1BN80HST
	/wSax31qh6OSUYh4iZPgesZMKOKcGrtbJmIJnkKbhAi7qib1cQ5s2Qxs8c=
X-Google-Smtp-Source: AGHT+IFUI0YUp1+RBJSqcGYBOc1FhgIJEm5xni8unk9E56g4XY//7qbTg95Zcg5DcOFquH1FM+TtEQ==
X-Received: by 2002:a17:906:1daa:b0:aa5:3748:2ee3 with SMTP id a640c23a62f3a-aa537483463mr1076090466b.50.1732641835429;
        Tue, 26 Nov 2024 09:23:55 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:23:55 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
Date: Tue, 26 Nov 2024 18:21:19 +0100
Message-ID: <20241126172332.112212-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241126172332.112212-1-ubizjak@gmail.com>
References: <20241126172332.112212-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof operator
when available, to return unqualified type of the expression.

Current version of sparse doesn't know anything about __typeof_unqual__()
operator. Avoid the usage of __typeof_unqual__() when sparse checking
is active to prevent sparse errors with unknowing keyword.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org
---
 include/linux/compiler.h | 13 +++++++++++++
 init/Kconfig             |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 469a64dd6495..bb0bde335129 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -321,6 +321,19 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * Define unqual_typeof() to use __typeof_unqual__() as typeof
+ * operator when available, to return unqualified type of the exp.
+ *
+ * XXX: Remove test for __CHECKER__ once
+ * sparse learns about __typeof_unqual__.
+ */
+#if defined(CONFIG_CC_HAS_TYPEOF_UNQUAL) && !defined(__CHECKER__)
+# define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
+#else
+# define TYPEOF_UNQUAL(exp) __typeof__(exp)
+#endif
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0f..c1f9eb3d5f2e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -894,6 +894,9 @@ config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
+config CC_HAS_TYPEOF_UNQUAL
+	def_bool $(success,echo 'int foo (int a) { __typeof_unqual__(a) b = a; return b; }' | $(CC) -x c - -S -o /dev/null)
+
 config CC_IMPLICIT_FALLTHROUGH
 	string
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
-- 
2.42.0


