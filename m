Return-Path: <linux-arch+bounces-2671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D0F85EF2D
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 03:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15AF283C78
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 02:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE1514287;
	Thu, 22 Feb 2024 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gR0RANxi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B698111A1
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569455; cv=none; b=Su6lvAedd8ziZpYLzhL3bSDQ8DnbTPYyYp69f4/2yypDdOvnbbLPZISnTtvqCERPhS6ug0/x5XLwZ41t6O1ehCbqPauu1vUyNj1S/J322eISXmtWRhBLC4S3n/Rp3zEvMmcMCtWfvdV1yfZbWjg9NVqvbinBxXliZbP8AYOmhxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569455; c=relaxed/simple;
	bh=1rITqxdtfq8GZoHA2/P6H5GDaO7yrOL9kVv/nHPU4TU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bQhMx6pfvYHDZQ6yoq9gd82CnzisyL2e7EKTnAoKb22/2C424r2ycs1naXtnojpyJA/X/EXvLMdTFX73fUP+jeE1M6gQziZI8q1Ih6OXEXQVj3qJIdRi0Qnzzbe4ecsF11PLzr54la6S6KY4EXJpciFpRFr/Zwc1Wt9RI5O0sJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gR0RANxi; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c17098ee8eso757018b6e.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708569452; x=1709174252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rZpjfp6r1hYdsUdVVxlhsRsruPrHjAGS8OkhXDlaJo=;
        b=gR0RANxiSAMH8GhgZqjk0IPaopbH4+gE27G11B8YLIndROy2iDEOMGPevMxl0EyOGF
         rXKHmJ+4aMEQuW4OEPdv5Y/XAPhAsTYwJmdWXD0Km+kG8PH8Q965r1XdUgBxgSZBxqOg
         GU+2NUYFWN5h5V1gUzdmb6LUYgsKlYon6xohjSo27NNKeZMN3WrP71FmEIGh5pHI3Qq4
         PqTdpLG8B8m/gpiDAKlYYL6Qv0LX6zmz3MWHJyLDj+hKqsGXuivvdRa6xFpNOVXiUJ7Q
         v3XN2t0PmBT+faqvSAZ9+7P1ObTuF0WaBrV1sKw4B/d+cC56uZLVK1eAlRqEg3jRK3+d
         2/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708569452; x=1709174252;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rZpjfp6r1hYdsUdVVxlhsRsruPrHjAGS8OkhXDlaJo=;
        b=SnGWE3ajhTS/sqy5bOV8VyTJsMt/hCry3m0gXBvq15WhYNlKGXNbk4Ds3qEFivYyvm
         WuDZBsEau9k8RN7O4ZBGq0AiGQvbn3ozk3hCotIjlOBX5tgxB75CSLd1Iws1tweywgcF
         HqXJV5DH5Soeud2/So0FA42BDujffEZQoyfR1MwDl5/23TviNnpWQeeROhGU71Rat/M3
         msGd6Sx2KYogg3HuBUdbbAwZPxvGyaWKYJZzjmHE3CUdRuF04a7lzSu52lv5qkWaa6ik
         rj7Qjbzrargr9/N8gWRM0I81UN86qNq0aawTDgNvNidTh2lEWiisapAfQMMgWq36qLtN
         GF+A==
X-Forwarded-Encrypted: i=1; AJvYcCW/cTBBvNFbHf5qoHhqhavSWaxl5VE3WEHBab/eZk4oSrw3T5nb6ZY8D/T0deI1AMbRT/jFdvAMj8frjgeH/zQQBtux7TrVFn0F5w==
X-Gm-Message-State: AOJu0Yx2hE80ZC0jm3gA8xlUcvZG/leodK0wtdHY1xhbnVw4uLJcT78U
	3iY8Fn8KJIfd+c6d8R/EgxCxt45/pRJAzdC4Vyy0IhNkZ2fNuuTs3FLOXH2/76YF+/ULoB3J0Cm
	d
X-Google-Smtp-Source: AGHT+IFRIxIu+JVzwZdlJu8YZiMiwkbmpNB23grY3hNkFMpitBdh4nauHwA0Yy9NcX1k3EJVLGL8aQ==
X-Received: by 2002:a05:6808:10d2:b0:3c0:3db0:55eb with SMTP id s18-20020a05680810d200b003c03db055ebmr27441973ois.49.1708569452460;
        Wed, 21 Feb 2024 18:37:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id kt21-20020a056a004bb500b006e465e1573esm6469705pfb.74.2024.02.21.18.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:37:31 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/4] parisc: checksum: Use generic implementations and
 optimize checksum
Date: Wed, 21 Feb 2024 18:37:10 -0800
Message-Id: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFaz1mUC/x3MQQqAIBBA0avErBNUQqOrREhNUw2RhUMRRHdPW
 r7F/w8IJSaBpngg0cXCe8wwZQG49HEmxWM2WG0rba1RR59YMJxCYaaYYwy4EK5ybsoMgzZj5Vz
 tPeTDkWji+7+33ft+wYiWG20AAAA=
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708569451; l=932;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=1rITqxdtfq8GZoHA2/P6H5GDaO7yrOL9kVv/nHPU4TU=;
 b=aEhaNvt6gbnljBaOC6ltqWD1hPBSsAa/QvOdn/yDpB1sz2Jty7JlIhPvaCCIBkO15dugotule
 Ichm+/2hyPZCNICgIz+gG5AQcLDmmc9PZi9bZi5Lyl3zMy8Dd4XPpNt
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

After the parisc checksumming functions were created, generic versions
were written that are the same or better, making the architecture
specific ones redundant.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (4):
      asm-generic headers: Allow csum_partial arch override
      parisc: checksum: Use generic implementations
      parisc: checksum: Remove folding from csum_partial
      parisc: checksum: Optimize from32to16

 arch/parisc/Kconfig                |  3 +++
 arch/parisc/include/asm/checksum.h | 42 ++++++++------------------------------
 arch/parisc/lib/checksum.c         | 14 ++++---------
 include/asm-generic/checksum.h     |  2 ++
 lib/checksum.c                     |  2 ++
 5 files changed, 20 insertions(+), 43 deletions(-)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240221-parisc_use_generic_checksum-1bb01d466877
-- 
- Charlie


