Return-Path: <linux-arch+bounces-1271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC87823ECF
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111EE1C21517
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96520B12;
	Thu,  4 Jan 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="LGTUgZun"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF720B03
	for <linux-arch@vger.kernel.org>; Thu,  4 Jan 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso2574145e9.3
        for <linux-arch@vger.kernel.org>; Thu, 04 Jan 2024 01:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1704361226; x=1704966026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YlDF5S3qUTU5QPT5mBE5A0Nk1MSHd0M5Wjrqa263X0Q=;
        b=LGTUgZuns2UK43hgsiLPZp7mV+A45H4iN83S80O1Zszomp3OqcwJAi5z8JeBPJAxtz
         Odq8wjqDVd4LI4rhZysL1ZysNkn0zwJcTW+5TlEXxxLDZVNgG2CrZdH8Go60C09vxfk9
         oHwP47GWGspq8jX49i+9JCNAZmctPqjgXg816hqDVFaDYMEDbkvBMY+r2AwlRHGhllxq
         ym0xBM8iKxYSYu6sg9pI81MoYzNAaXv+pf4W++L8YVhVXn8U2zYt2mxY+Lf74fofwbFL
         fwe2593BWRoNe2vxpzrRyRQ1CUaSFxDoHukXIG24aXqh7W88rnYBeG/EEZnz8XWURYhU
         M38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704361226; x=1704966026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlDF5S3qUTU5QPT5mBE5A0Nk1MSHd0M5Wjrqa263X0Q=;
        b=ES7X1Lt+X/DhhY55ic2vAs4sctecNp3eLHcZHNnv+sRjVcEYNak2bjP8qNzHyIAd99
         Jya3NajUJHIVRxbEBtMx+H/OpKpqnmUON5w1CXkGO7SiX9XRNbfhtU6d01+q1BhpT9ZD
         I9mZ74ZI3MU1AsjVMdiDoE0oQJoGaXEjQkiB/S2dxzmNEuaqA/nxgGYogEneo+817P7N
         T8RJO+AHT0oVvm1lfnXygUtIwxJm+cAjRbK0bdxxmbgC0FdspU5AD/kvakiSJHhptszR
         JGaUNSYax3RFSSnDDzNJzyE5ABzHsWiWuGwZiXYy2hH8vMo3/o/ZUU0EEHucqs7VjI7X
         oCwA==
X-Gm-Message-State: AOJu0Yzqt2skfr2dmAkbDpF8up9RuF0tFOMEp5+Bv6S5KzFVAzwubtjA
	xFsPAfXE6l+rJIosDkPKGaT/VvtFpHVWNw==
X-Google-Smtp-Source: AGHT+IFGfzUUBJguFmLEmftFdE5E2K/7R99GTIosSx+X8OI/6mP563Po5F1/jCfPKhCbejNNCEleYQ==
X-Received: by 2002:a05:600c:4749:b0:40d:91a2:7133 with SMTP id w9-20020a05600c474900b0040d91a27133mr172541wmo.100.1704361226124;
        Thu, 04 Jan 2024 01:40:26 -0800 (PST)
Received: from opal.home ([2a00:23c6:2008:8201:78d6:5cf5:348a:952b])
        by smtp.gmail.com with ESMTPSA id w18-20020adff9d2000000b003375083ff8esm1745909wrr.32.2024.01.04.01.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:40:25 -0800 (PST)
From: Stuart Menefy <stuart.menefy@codasip.com>
To: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	David McKay <david.mckay@codasip.com>
Subject: [PATCH] asm-generic: Fix 32 bit __generic_cmpxchg_local
Date: Thu,  4 Jan 2024 09:40:10 +0000
Message-ID: <20240104094010.394669-1-stuart.menefy@codasip.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David McKay <david.mckay@codasip.com>

Commit 656e9007ef58 ("asm-generic: avoid __generic_cmpxchg_local
warnings") introduced a typo that means the code is incorrect for 32 bit
values. It will work fine for postive numbers, but will fail for
negative numbers on a system where longs are 64 bit.

Fixes: 656e9007ef58 ("asm-generic: avoid __generic_cmpxchg_local warnings")
Signed-off-by: David McKay <david.mckay@codasip.com>
Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
---
 include/asm-generic/cmpxchg-local.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index 3df9f59a544e..f27d66fdc00a 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -34,7 +34,7 @@ static inline unsigned long __generic_cmpxchg_local(volatile void *ptr,
 			*(u16 *)ptr = (new & 0xffffu);
 		break;
 	case 4: prev = *(u32 *)ptr;
-		if (prev == (old & 0xffffffffffu))
+		if (prev == (old & 0xffffffffu))
 			*(u32 *)ptr = (new & 0xffffffffu);
 		break;
 	case 8: prev = *(u64 *)ptr;
-- 
2.39.3


