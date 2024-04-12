Return-Path: <linux-arch+bounces-3619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA51E8A2FF1
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEEF1C20BCC
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 13:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D983CC8;
	Fri, 12 Apr 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="HR0FYA6s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3ACE542
	for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930090; cv=none; b=airRyURQtpqllhfeLKlVmfjtp7UGiq9F4gC9VnHaJJ4mtQZh0t3hCvYEqHHEw4IqysMd9V/e+/znsFU4DW9WKoFG+v5UbMY+Kj5oMjtCB/gsWT8ssKe9jF7JBjeZRoGHB7OapG48TYJCfqitI8x0bE98EB7O9Vx1XzZiGhkq0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930090; c=relaxed/simple;
	bh=vzZDCSF+kVOp0Lt6aAnjTGFDPDyqI/182rQxYNpYQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a39aVGzTYkhFlfVg/3i7ChT6P8tDN0RQEbXy6NlTziFpXU9s8UfVvmwx0PWX/qt+cMqAo7enU5g1FgnaMsmwPX7GMWlmK0jFLNQdwygRLTUfUB8NHZd52EPAXdckhPhBbn2Km0qe7DrKeEKT15ZNL21IQ3dPUzHrRR3Mfwpxca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=HR0FYA6s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51b008b3aeso110943966b.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2024 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712930087; x=1713534887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2fQ11RQlzmXFE9029rSHanI+TkjNjC7if1EAKo5wgPM=;
        b=HR0FYA6spSo7iIPtxTvqjsVUyRDoYi/FUhuMxLHhrvWsO8TYpFLWJcM7vhBK56Dv7U
         +kZCNYGwp/aONa0+q5H9hrcO5Y0vpheyJE8VVocNnfaSfkXk/Flr2KPb0P7rO+RwAJYO
         aA2dXR1jDItR3n+4XFcRtuNk/L48yQcDLbhNbt/THbg+avIxc2SjGZisWAGWkWcuGYYt
         F2kz6/0+xtnErfjSfeFldLa0n/JuDdR3vgykTUeHKpDrnIiHTuw5QOrzeQYWoOVbuOSz
         8A7GVRpSuwE9N4GLl5f70CFLO7MLgiC359rTtI0VT/kZSBsEQv+rN+i/bWiRATyen6jc
         C1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930087; x=1713534887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fQ11RQlzmXFE9029rSHanI+TkjNjC7if1EAKo5wgPM=;
        b=PY+nZwguj4DtCZP7QFLlsUFkrTDC+qy8XfRBhUAfqyK98uXZIqOQ/ZaDawDCyUJq21
         uTLIokyEvk59/jXie/7swHiOmRI8kS6WSpEOgN94lkNA+tkmd1kprI0Bz/IqbfYoDNdS
         kexIikRj7mavkqjdBoicmvR3JFxwPHNC4ggExms3AEErOUOwG3eBD48P8dj1X52Q1VbB
         ISl3NKejrvB9ihsTy2g2g809Zfh/Rk8XI3nJ547c0BF/RxIRFiszNYaPsM/m0aSICl7H
         Mn7KPIgIp7ihTl/XU5/DnvZY+CMlhvFmkYhiJyZJo3pfRFE+Lsz2K2A27u41+evK8NI+
         es7g==
X-Gm-Message-State: AOJu0Yyb8yRBMAmCDF+DFHk5KKmQyUDqrV5QGTQDUqDPORhrkNgl6Zgt
	PwCFZ43Qe39ltQWfBZIDjqCN6XMye0VgL4pCnEmvJmi2K26PXR3O1eMdWWN/6l8=
X-Google-Smtp-Source: AGHT+IF850IG4CKSDch1swr8IAF7wkkB0yqEyQ8/ZgeJyByhW8mQWl4Bn6m9PzQQWJJiMFjydqCcqw==
X-Received: by 2002:a17:906:80c7:b0:a51:bc68:fa94 with SMTP id a7-20020a17090680c700b00a51bc68fa94mr1961360ejx.21.1712930087545;
        Fri, 12 Apr 2024 06:54:47 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id q23-20020a170906a09700b00a519ec0a965sm1839412ejy.49.2024.04.12.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:54:47 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bug: Improve comment
Date: Fri, 12 Apr 2024 15:54:07 +0200
Message-ID: <20240412135406.155947-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parentheses to WARN_ON_ONCE() for consistency.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6e794420bd39..6dc1c855a2d1 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -72,7 +72,7 @@ struct bug_entry {
 #endif
 
 /*
- * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
+ * WARN(), WARN_ON(), WARN_ON_ONCE(), and so on can be used to report
  * significant kernel issues that need prompt attention if they should ever
  * appear at runtime.
  *
-- 
2.44.0


