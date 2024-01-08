Return-Path: <linux-arch+bounces-1290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28268267E2
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 07:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1C1C217A6
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F48B79CD;
	Mon,  8 Jan 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehxx9LLd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D6379DE;
	Mon,  8 Jan 2024 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2045bedb806so1671584fac.3;
        Sun, 07 Jan 2024 22:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704694609; x=1705299409; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R96nFtUAHcvK+Syyw7DXDD2f4NflWNpk/wdXNthWbzI=;
        b=ehxx9LLdjRFHfsVMpsrdenN9NZuOs8NJSmXFuz8thZMoWg6dKQT59fOL1MBwP1WA/y
         M+8LpcdG4u1r3jxDL9m7mqvz61GAvZ2LuubxndkmZhbkSanrt2LUWIwXuMMYn7k1ImWh
         hapqsRWHIOkne3GtXjRZFNEc0kLRCBqWahJ51jr7g2hxmIDaaNq08uEWd5rtJlG8ZeG7
         jP6o+tf8ow879kpDJ4Gp+qCIrlFHFyJKJ9jKtUwtG/ZgUypqWjdVbzqHALqOyl+h3g0F
         XUyGFvTvamLWpsav6AO41df+Mep2FnQFZgdrAomh/WfQjaBdMEmES+vBNotfvPRtpHJa
         bZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704694609; x=1705299409;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R96nFtUAHcvK+Syyw7DXDD2f4NflWNpk/wdXNthWbzI=;
        b=S1gj4k8adxtfZ5AF16vVxzSoYv14vpp4X9+3xeFhjOvQRmUe7VZeDtSM5G0RYcVf63
         QodtB34Tel/PiedzmsxpfDI8NVOpHcY3Q3ZhIF3LChboxw7OFWTe4t1DnT1V8kYVyykj
         VlhKcJpBSgoENXAkp1Pra2Myyinl2JeVmC7S/qAqaO3612xuBO+BrWziSTzrdzgFs4ol
         krPSWnrj/tdG0HWsEUGtzmSS+iKgXTR3guxcYDJtSMuQHKlEVKJH+QvpUNtn3XuS9tL9
         65tRVnL67pE2GTgsu632xy0MHLKSQIITVRUsnGL5EwLKYv3jsxGiWqE0QvDaygLZC6Az
         nwQw==
X-Gm-Message-State: AOJu0Yzo6ijRQYkYE79yJ9/6sGxoklrT2+RhoPDPjzCtyiV9lOuN1u/Z
	sWGASkJGdvSW3SiYjv23Mkc=
X-Google-Smtp-Source: AGHT+IGM41Cgc2Loe8AEzfxl/LX42E5QQD9J+La3nidUPkLnPHcx80eiqLpXgjHIxCPMBHCwZclhug==
X-Received: by 2002:a05:6358:5384:b0:175:67e3:f9be with SMTP id z4-20020a056358538400b0017567e3f9bemr3641697rwe.31.1704694608850;
        Sun, 07 Jan 2024 22:16:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a4a:2478:1813:e8c2])
        by smtp.gmail.com with ESMTPSA id nc6-20020a17090b37c600b0028649b84907sm5464921pjb.16.2024.01.07.22.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:16:48 -0800 (PST)
Date: Sun, 7 Jan 2024 22:16:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] asm-generic: make sparse happy with odd-sized
 put_unaligned_*()
Message-ID: <ZZuTTRCUFqWzA1y-@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

__put_unaligned_be24() and friends use implicit casts to convert
larger-sized data to bytes, which trips sparse truncation warnings when
the argument is a constant:

  CC [M]  drivers/input/touchscreen/hynitron_cstxxx.o
  CHECK   drivers/input/touchscreen/hynitron_cstxxx.c
drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (aa01a0 becomes a0)
./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (aa01 becomes 1)
./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits from constant value (ab00d0 becomes d0)
./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits from constant value (ab00 becomes 0)

To avoid this let's mask off upper bits explicitly, the resulting code
should be exactly the same, but it will keep sparse happy.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202401070147.gqwVulOn-lkp@intel.com/
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/asm-generic/unaligned.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 699650f81970..a84c64e5f11e 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -104,9 +104,9 @@ static inline u32 get_unaligned_le24(const void *p)
 
 static inline void __put_unaligned_be24(const u32 val, u8 *p)
 {
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be24(const u32 val, void *p)
@@ -116,9 +116,9 @@ static inline void put_unaligned_be24(const u32 val, void *p)
 
 static inline void __put_unaligned_le24(const u32 val, u8 *p)
 {
-	*p++ = val;
-	*p++ = val >> 8;
-	*p++ = val >> 16;
+	*p++ = val & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = (val >> 16) & 0xff;
 }
 
 static inline void put_unaligned_le24(const u32 val, void *p)
@@ -128,12 +128,12 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 
 static inline void __put_unaligned_be48(const u64 val, u8 *p)
 {
-	*p++ = val >> 40;
-	*p++ = val >> 32;
-	*p++ = val >> 24;
-	*p++ = val >> 16;
-	*p++ = val >> 8;
-	*p++ = val;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
 }
 
 static inline void put_unaligned_be48(const u64 val, void *p)
-- 
2.43.0.195.gebba966016-goog


-- 
Dmitry

