Return-Path: <linux-arch+bounces-2672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF97B85EF2E
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 03:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB291F2246F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 02:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86614A8F;
	Thu, 22 Feb 2024 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="n2S1A4KI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DAB125D7
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 02:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569455; cv=none; b=W3Ifbhe/HDRmZkwb+SnJzo2QNW/P9F5ES19bkllv5Eo+Z5zFP0K3CgwXzXgvB3We28QtgQ8pYtLwYMERKQ3lkA809H0iJ0a3NSKZ5Bxotycplv1klfjPhkuYN+//ou6FuFmkmAuxVTMzcUnO2yiWt4bx6D2yih1iZzIT9wSHsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569455; c=relaxed/simple;
	bh=sNekCmUtLWlwQH/XsGvAEvEx2UjQ+qNezBis71mVY4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5fWoRSD8RHIkFMz1/dFQTTT3t6p71sRdjmF+11SngaHHtD2LQHrjDKZPkkmgDSAv8Zmon821Mxp5vVgV240QWrrcgyTe4LjBoa8uAiZD231z99O5JXDh1ZMquN2VyHZduWyddQ15TQpY1ghEDLMD/sM5ZBClcGFjKiGNwoB6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=n2S1A4KI; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so2563758b3a.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569453; x=1709174253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbWwM7zPic1o2n8E79ikwcyfydTfqLLzWcN1NjJT53s=;
        b=n2S1A4KI4xKCMwYeYxrEQa4nzp2ZiNEv2cCqdoud4K9FNa5ZsAkcltDavzafgVQLYK
         DLmvmFCaJPyxeJAEy2fsUV06b0Pbyi2QDgI7bkp31JIMIQnH1Z/AjkDhUaXgPeig203V
         gIpadKz8m5LIz8JVXyvIIX9a2Q/rsI8TnfZTDh343Unb7wWAEoaUCVGKYJ8ApvXG5bLC
         sodA37sAzLXTDbwj51LrZesjKmsun+EssLEKV1JwwgV5+Vy2qs6lw/6AnCUPJccEV+CB
         shO70xyy/kS3OBWWdCkmEGxeZBUBKgZgn9ijewsibTKFJwBoJXxO5T+N8BuqhpxQCeQd
         6C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569453; x=1709174253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbWwM7zPic1o2n8E79ikwcyfydTfqLLzWcN1NjJT53s=;
        b=AmACwXR5F7liopNQxabOr7wtUhOIgDsbV4OQ4AZSWJV1MtzrJVsz9UYDseBQ50gvk1
         y8C74Sy6BcTI2ZOh7nHo0ZZ3n5K6m+A2cqpKRx5yeDe77JNZ50hd01p+xibb2/tOcWzw
         dxtlgAiDY2iigyjfRX9z7TPRARX29Xu/BXtwykI3v/+RxwS3Vqc04btXIRd8BT7eiBo+
         avtTfN+hgiAPsQfJ7cI/GQqceMBAMe2VKuqop5DF6Ohz7NOdGj9dbsDo7KFp5lVfqZ5f
         c0WWuuI8Wqo90M9kuey/J7Mrho0bckr+SK0ynmimn9FjYPOJMdxQ1DrRqeDbCfiQC0ii
         DWRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWui6GDZGWiemT9+HlhWkf9vDUMK6+xS2r800KywoEF3TXva/jksYH4FqQuGXj5Jq+xzcQU/XOh6DLdn4sEFZ/cBLporLv7sLNs+g==
X-Gm-Message-State: AOJu0YxxaEie9xlf1SV9WC/8CO/TM2q/2D4LhswLGtI2w5ksE3zX7xt9
	pwFhmojxAk6V6FUv0Vpjf3HozAZxtPvl2+6Mqiy3OJxp9hhr3FhQZzym7rMG3DE=
X-Google-Smtp-Source: AGHT+IFtZGKup9T6YYI7PmRS1JDh3YEQ7nwhJf2ABKpiAKBuUhTyJtqhoSWcShDrWUosyp9JWBH/MQ==
X-Received: by 2002:a05:6a00:da:b0:6e4:c5a1:e41d with SMTP id e26-20020a056a0000da00b006e4c5a1e41dmr1396178pfj.29.1708569453628;
        Wed, 21 Feb 2024 18:37:33 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:33 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 21 Feb 2024 18:37:11 -0800
Subject: [PATCH 1/4] asm-generic headers: Allow csum_partial arch override
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-parisc_use_generic_checksum-v1-1-ad34d895fd1b@rivosinc.com>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=1437;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=sNekCmUtLWlwQH/XsGvAEvEx2UjQ+qNezBis71mVY4E=;
 b=g+fjMFlNSWfcCrlu2uFDLLNXHSUDovxevoYfasXSOOsYTDbSYie7Kx4HZ/ltvBWgwxDLH99EH
 QhtbgMGsTK1C6kG7qoIseYXNTILqnnfDUH9Um6xbzAAZtYxm8RUNSa+
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Arches can have more a efficient implementation of csum_partial.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/asm-generic/checksum.h | 2 ++
 lib/checksum.c                 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index ad928cce268b..3309830ba2cb 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -4,6 +4,7 @@
 
 #include <linux/bitops.h>
 
+#ifndef csum_partial
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -17,6 +18,7 @@
  * it's best to have buff aligned on a 32-bit boundary
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
+#endif
 
 #ifndef ip_fast_csum
 /*
diff --git a/lib/checksum.c b/lib/checksum.c
index 6860d6b05a17..c115a9ac71d9 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -110,6 +110,7 @@ __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 EXPORT_SYMBOL(ip_fast_csum);
 #endif
 
+#ifndef csum_partial
 /*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
@@ -134,6 +135,7 @@ __wsum csum_partial(const void *buff, int len, __wsum wsum)
 	return (__force __wsum)result;
 }
 EXPORT_SYMBOL(csum_partial);
+#endif
 
 /*
  * this routine is used for miscellaneous IP-like checksums, mainly

-- 
2.34.1


