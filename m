Return-Path: <linux-arch+bounces-2674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84385EF35
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 03:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A31C225A4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 02:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2E17755;
	Thu, 22 Feb 2024 02:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bDqLaH4M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69561754F
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569458; cv=none; b=rN3vpuw6iUZsM8QcsCqDKWBrKD3/RSF1TBNpwB3Fbk0jSxngTu9BVY3iYCZ0MtPEuWzi0Pa35pGadl9Y8CR4foFxvo9vbu1e1rRIQxjmudQGVPwSh2qyWbt8k0gi3MVaAm5KUhKyrc4eJXgGA6OY9f7mk/u+G9+V7xU5Z90RB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569458; c=relaxed/simple;
	bh=loWpjUeaU5B9E/ejxOfrGk83272NpESpvlB1T6y7RcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKVudTO9EvgZ6k+wGknB8rw8thv8jBMP+RJTEW3woFk1i9Xnabzn302yuzove6qdbnqcSS6cO8cavzdBfBQCjCIEDeofqU0ATl5TlyDWDgGqwJ7hTLptkzNGzMhgqwwT7+9Yh+A5OSzqidwNKpHbsnfbD3au6/UkWPHF73YuKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bDqLaH4M; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c15bef14c3so2796020b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 18:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569456; x=1709174256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZGrNzxe3gyC6VQWPSLHOaYx0WPaI3IQ/8Jr8tyLxsyE=;
        b=bDqLaH4Mz6HBVCQH8/bzqJM/xjCxIxcGrIh8PIEU0TYPLwt6nH79zDhos0DOTlmk/R
         sewKpdEG84CTfUkO4fqkKo+KLgPemD7mqj176D+7eicT/3SoHLmguQVgQkvNX5ol1zoE
         1W7S3IroWirVSWaPWLLTcdWP2uQMrDsflRj7BxPghmFDaR2YAXMEKZSs0qejzkCxbjGA
         SPlxggHVkvmjfUHi8n+B1W5tu/YIAmEF7fyYfycUAhwAiGUCgm2UfQa7df201Dg9OBTJ
         /MxdofkD0gNu3TRQycgc42xIeApQf4q278El0L7milqb7PMFVtXnJXTxROIBSCctm+Os
         siJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569456; x=1709174256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGrNzxe3gyC6VQWPSLHOaYx0WPaI3IQ/8Jr8tyLxsyE=;
        b=R7K+oKOdtQ3odsnMKvQiBydHKdibxgJi9zfC8zDlroOXx6mObyXeeni8OyRQr2LYB7
         bf5ZhGO0w8Ewq9ai52e+jXnngNsqDgK7imbqFihJcf1tTq5HDiJB4PK7fJgSQsfx9uIR
         yK1+YrbuWLIdgL+cBAPz8dXvvh240eJ3UmOkzdNqE6utVIcWdt2hLR32MIiXUS5X9bU7
         f+QeJ4hitalkTxr6aXDY2X249lSmI/18p5IMAFTR9CzD4Xiz+aOAtYqfuOQY+BP2ReuE
         GRX5tOh5IFrXJryRRZFd1dNw8Zs5pWHwDth/Qh2/Ake9mZ4YJsjl/2V3yD1t4IhWCjHP
         1xUw==
X-Forwarded-Encrypted: i=1; AJvYcCXsjPyVzw+KWWzXs7FzaT6MaGdT4SCOEmdtwI1kxgTchTCvWyQ+KBhtgEkf+OqTFj8FANMoaMXTqke32toNBbNN/VLeqsfmIrD2Hw==
X-Gm-Message-State: AOJu0YzJLXMNimIsmlkBk5QVx4V7YKRpL7wOpGCj4dATYqZ4wxEulNFk
	OWxugtkk0u6V0sjG4MHxtjBdPlvjSjKGUG6NeP5URI/CIeFRM1y3HzcPU8SmBEOIPkRnBfaq9UM
	z
X-Google-Smtp-Source: AGHT+IHr4SZnfJdYWs07MIcE+jUM6/a0JrEuqqzI8zGh/SYhR/8eR1eYgSYBAmBjDUh92jlYMvK//Q==
X-Received: by 2002:a05:6359:45a9:b0:17b:335c:fa07 with SMTP id no41-20020a05635945a900b0017b335cfa07mr13781339rwb.32.1708569455998;
        Wed, 21 Feb 2024 18:37:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:35 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 21 Feb 2024 18:37:13 -0800
Subject: [PATCH 3/4] parisc: checksum: Remove folding from csum_partial
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-parisc_use_generic_checksum-v1-3-ad34d895fd1b@rivosinc.com>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=1119;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=loWpjUeaU5B9E/ejxOfrGk83272NpESpvlB1T6y7RcU=;
 b=xtNabUDylbAE6Wad/8orZRl3dAazwQY8qAbie+Ef8VKsiWBGicqZfawURBgIzMindz5keC/GQ
 JFElQKZrZefDR+vZaVkejbXrGuxRi9Xb6hk2IyfNMsmFd1KK3OjfEjC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The parisc implementation of csum_partial previously folded the result
into 16 bits instead of returning all 32 bits and letting consumers like
ip_compute_csum do the folding. Since ip_compute_csum no longer depends
on this requirement, remove the folding so that the parisc
implementation operates the same as other architectures.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/parisc/lib/checksum.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index 05f5ca4b2f96..eaa660491e24 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -95,14 +95,11 @@ unsigned int do_csum(const unsigned char *buff, int len)
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
  */
-/*
- * why bother folding?
- */
 __wsum csum_partial(const void *buff, int len, __wsum sum)
 {
 	unsigned int result = do_csum(buff, len);
 	addc(result, sum);
-	return (__force __wsum)from32to16(result);
+	return (__force __wsum)result;
 }
 
 EXPORT_SYMBOL(csum_partial);

-- 
2.34.1


