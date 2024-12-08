Return-Path: <linux-arch+bounces-9307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605889E87DB
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26AF164184
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7519883C;
	Sun,  8 Dec 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/IJhnA5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931319340D;
	Sun,  8 Dec 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690849; cv=none; b=esvJ+ctvfg5ldhIaYcv4LAInB1DZmKhY/64FnoT6lNCB0dCUVSpNlFxL2GvOZDmA3kO41qJ7ADtQLERFnh6IpUvpfT1BF3xptXiP9pXGG+oiJsLy1UZjwG8ERvXK26X+aue615UOvy/Uxgy4soD1v3YLcVchxWiMsOE89pm4dXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690849; c=relaxed/simple;
	bh=unFCMuepgf1SQbq5AYrK8xHbDJUoge6TMBDvQpYj520=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7w09Nf2+JGNTwIURyDIGPLHAh9LvbflttuTeVFsxyevSyX3y3rcsBbOgJCYlMj4izzX/GuBsacLFOiMt68PYpMtWR2rsgvBDyxN/JqE+UOib0jF6c//dJHyHyDjEeIaeJMReJvLs+Uz6Ci3EV8OT2pqs740EGFx6JBzOQROWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/IJhnA5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e84b65e7so14658745e9.3;
        Sun, 08 Dec 2024 12:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690846; x=1734295646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+7I9gi8mucGgoO85kNahA3U27ot3S0RhfZIOhPcQEg=;
        b=C/IJhnA5iTjRrIlp33Zdxc55D3nyPccd+8y5VaHLD3mIlFpVnpP2Yn21EYY+WW5IMH
         umAqnotSk9shNZQS1vj1EbcI8CW37sKZ07WT6Aa1mxPsUKTkOnE2QhqQdrTaqctSGAHC
         lIUP3bzNWHsN4B/0zigUGmoH2nYISvPiTVRswiWg23dSEvHj9TJ8dL9vjLNP5uTnzSks
         /EZfwHs/ELFvPntIm7kJ9Z+aPnh3jLFiM4ffPe8E3yxv6E3jCes0LYIleeQrpvJ8PRdI
         22DsohcZH5qYe0L4urYhII4g9261eelViBRE7zVC9klKPKPS3pbVlfJNWbgRW1SVMY1q
         9G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690846; x=1734295646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+7I9gi8mucGgoO85kNahA3U27ot3S0RhfZIOhPcQEg=;
        b=NBfAn/AkL9M6Q7taPmXiG7IeJMscFJpGIAvR+xXeh1PzjVuWSg9HVO1fSZ+BwqmMMj
         Pg9jTwPXsP4QXwnJODuGtUgGPy78MIekqM9neheAlJnQUbMUJ3GsLAmeGasnsP1Bd4ll
         TtTGH1fROZoIvVnHymrNRZjTfEmu8RfYc/Z63wHxP2SeRpVNYNvnDuNYpdT4wAQe0Fnb
         VE+/AAxcpWtm2rgsATm56pNwZElj4qWcU+1hQYVIQ3J3wxddOU+XRKvikywzaO5phQUk
         EWjXsgmTa+v+rzBcu43ONoOLfzsBVKJpiRJzitFCEzxLTS+TpN4En5fuLwh+y4tk3VKh
         eTAA==
X-Forwarded-Encrypted: i=1; AJvYcCUgOO7VNPNnZTbHvRCy83KbZw76f/wrZjLt6qRHUAk0N+e5aCXz1fl0zv2SwxHHzPZ60dj0GeK+id/hI0CHsEE=@vger.kernel.org, AJvYcCVcV7nJflQACZkTgt9TScQxZnD0X/F0yXdITwxjloCKmetvlrUhFx0KLBqOc4E0nJ6grN8ygxkDXzPZ@vger.kernel.org, AJvYcCXC5CiThquRObyG99kuzfzF8fa/2q17CDTNO/hSgiBRyack1LacVSImstw+udZBuFLK9JpmZpZ50Bv8/KoA@vger.kernel.org, AJvYcCXq2g2HWb4h3x7VrOc2Nbw4lTqxwkY1lElMLJ+QIkxGaThOR+BkUC35cKiJwrk86qvMp6+k8UZx@vger.kernel.org
X-Gm-Message-State: AOJu0YyknRA3IelCrfHiHFCKI4wNgmphuXBuFNpBgKcgq3JhlX7tSX2m
	sWOBMShFrWPjAzJRzYe3DHIEKFG0j27G/fx5pPctH1v0q7ck0SZ0
X-Gm-Gg: ASbGncurTQ4E8it7d2J1ZYMxHsGImp4Q3jglmP/4jbeXs1xIUYSXQZObtSgrl2eb92n
	Ktv/H/85zrq4Cz3fRNPYPV6chAH+jVqVeErhPBWGz593si0ch1XpVnmIj39XBolWU+Q7tEE1qIA
	LTnHp3Apvh/vDFJ111swLsdjJ1m9eznQaAy0jiDwYnPUC9IqlKq0pWJQDMIkLLweRQAOvdIMTZF
	XztGEW3ImJjBsY3zkyEabVBNumD3dzMPyWxtGqiYe4dnL3FdOn1jf/gLvU=
X-Google-Smtp-Source: AGHT+IEEx0rgQYQ9iMyor+TEsls9yO5cspee9cXj1IHwee/pJe4BPDGI+xtnRRqbb2a2nmwevxjJVw==
X-Received: by 2002:a05:6000:471c:b0:385:fac7:89b9 with SMTP id ffacd0b85a97d-3862b3e4483mr7723302f8f.59.1733690845640;
        Sun, 08 Dec 2024 12:47:25 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:24 -0800 (PST)
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
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/6] compiler.h: Introduce TYPEOF_UNQUAL() macro
Date: Sun,  8 Dec 2024 21:45:17 +0100
Message-ID: <20241208204708.3742696-3-ubizjak@gmail.com>
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

Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof operator
when available, to return unqualified type of the expression.

Current version of sparse doesn't know anything about __typeof_unqual__()
operator. Avoid the usage of __typeof_unqual__() when sparse checking
is active to prevent sparse errors with unknowing keyword.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org
---
 include/linux/compiler.h | 13 +++++++++++++
 init/Kconfig             |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 469a64dd6495..ec0429d7a153 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -321,6 +321,19 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
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


