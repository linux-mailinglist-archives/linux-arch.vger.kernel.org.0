Return-Path: <linux-arch+bounces-2675-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BAB85EF39
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 03:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E91F2255F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8EA17BCA;
	Thu, 22 Feb 2024 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jilndtav"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E717577
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569459; cv=none; b=U4j5CXwD3L48I+B2iaor4sjKTcJGmG/86bxh3T8Ck7DZqhcoAHEvzqbqcmwwrtyklvaBr9l0BiVKFH4qE5IOwfja/w2kA1rfU1lnJLBxEeJ/Feg7g/7v8bdsOZ77MozFGQaQqE6s8wycJfJC4g9LKy6BnDYBkOKH3cei08w3xoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569459; c=relaxed/simple;
	bh=mYOv5YQT1yDdOTCAzi4OkkPsYH4iMvZEO+odMa9t9OU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOreJzAG3plR9os5Y+qjZk1fUpBu161z0SOryv4Q1DXrs7qAjdHQxpkKjMWOXu3+pF7sbH0losgZ0PlsSUyZ2j/ZHijHvznXl67xe4kXuLJUJVdyI4UPD05s/CMs7nM4Nt+BeE41y/dEuwsPARI9rX96erTOfsRne+ZwPtHHIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jilndtav; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e22e63abf1so3451454b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 18:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569457; x=1709174257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6YZh5OBHggNhG2iazj7ayAHylZjnHIget6Lw5n4A74=;
        b=jilndtav6wK9tlin1vZ80mFJXVjji8doG7sZyl7JpysdxrkyxaOefh6QIAmLsoXFgj
         wNTbNODr/2hOaE7wIOvZWUmgtrP0HweIbG2zpPvCS3A/rrjc3YTpU7k9x2/WEVCQT/SK
         pJXf415f+RZt3z466pXUGS5I+zPL6761GDxu5FvNSVOlhEvuQUzT0VR1WkqlupHQSoI7
         M7rGYjUmygHH3KA0VoUKceZbVHGW/oFAwZJf6Und66esSukQHLQWqE0FCkhyYSkbwLW6
         v1whZDp+GwAJxQtw3Eu3DY+IQ+9l9VPoDjXTzyaccYq+V5w6JBJv6qylE8q7bsWSf0mQ
         L3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569457; x=1709174257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6YZh5OBHggNhG2iazj7ayAHylZjnHIget6Lw5n4A74=;
        b=hCVaf0k5cXSFSSVkyfzTJa94Ajgr/VP4EIxKljKPfOk2m/RDNgc/mgMyITdYUi30Wp
         Oulsjd3mn6ApYIekkG45ZZOhGssLoJpX99fXUjO2R8UXtCOHRVkEsaPasNPdDThtAF5j
         wCUWwrbwMWviQbrMm1QOoILKnZs4L9+SQYJH66RL/teEDMMuUBgl/LSWMEX47HxHWruW
         1pM1p2MF6ggF+QLcNLWVJHqu9lDNmXK0fuEB+rQ5h3yJCe+IHxyPSrUGySMNrsqYccgg
         ax3Z/GA2Ejgz+4CBn0IorsTALWM/TKq/szs3rLKzljD4aS8ouNN/5xyvfrNiluTqpzRv
         AG7w==
X-Forwarded-Encrypted: i=1; AJvYcCXdGKFpQtngjDmeFxtsgpzNR8kYQWQz3Ktj6Iw2kUHXeKi6DhYPK04kLeeT52twUVOmQuAaHm4wcqPx8VAhpL2EYmbq3ycVBuwo6g==
X-Gm-Message-State: AOJu0YyBa8wO4QVOOygQCng5rxBRvL0EZIo0Fu98+8GzINpt8fR9wnkT
	4IQVaJzeH+/+tRoVHhJaie8au0CrPLVnKRzuB/9nG60Zefi/gxUgb+4+Fs2y5ks=
X-Google-Smtp-Source: AGHT+IE3upPGQXOLuSEUYyLoC9ayLGnKcG6FlBuS7HyfXj6mdUciEX9+OmA1mgOUixbXnJmCmqn9Pw==
X-Received: by 2002:a62:e306:0:b0:6e4:cf7c:6c28 with SMTP id g6-20020a62e306000000b006e4cf7c6c28mr15413pfh.22.1708569457164;
        Wed, 21 Feb 2024 18:37:37 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:36 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 21 Feb 2024 18:37:14 -0800
Subject: [PATCH 4/4] parisc: checksum: Optimize from32to16
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-parisc_use_generic_checksum-v1-4-ad34d895fd1b@rivosinc.com>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=833;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=mYOv5YQT1yDdOTCAzi4OkkPsYH4iMvZEO+odMa9t9OU=;
 b=kcPBmJJuQfkQSLxjGXYurjNDqCrgbi6FLLWky02d0x0JjqeH/QjvkkY9LAedCaybC9FPI+/Uo
 2tOaKUsjuarDrM9ZBbUaloDo2KRy4cHqTwp5CTnTJDmua6pJs9ksfxQ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Replace the shifting and masking of x with a rotation. This generates
better assembly.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/parisc/lib/checksum.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index eaa660491e24..1ae8cc730d13 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -27,11 +27,8 @@
 
 static inline unsigned short from32to16(unsigned int x)
 {
-	/* 32 bits --> 16 bits + carry */
-	x = (x & 0xffff) + (x >> 16);
-	/* 16 bits + carry --> 16 bits including carry */
-	x = (x & 0xffff) + (x >> 16);
-	return (unsigned short)x;
+	x += ror32(x, 16);
+	return (unsigned short)(x >> 16);
 }
 
 unsigned int do_csum(const unsigned char *buff, int len)

-- 
2.34.1


