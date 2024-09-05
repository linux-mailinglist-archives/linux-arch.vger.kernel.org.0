Return-Path: <linux-arch+bounces-7088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC4A96E4C5
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 23:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8911F2464C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B381B1AE033;
	Thu,  5 Sep 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kwcr2M9f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B71A76B4
	for <linux-arch@vger.kernel.org>; Thu,  5 Sep 2024 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570978; cv=none; b=VW2xYYsF4jSERnOOTRHkzXMPHdNiKJLa7428qV7xqcCLZTIW9hVxdJuEH4hPGALeI3Qd/7gdcIWe4hZyeDtu9GE8i+EsoEB7APFXYFHw0E447QEDSSSq0QdD/jGBwpAhq8TThQQ+T/O07mmSFipm9JAnr25iDA3Sm1muIfmnsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570978; c=relaxed/simple;
	bh=B2nFsYQPUa93R6MPC6rybC4BjlmBU89eB/xyA3tmSh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niLxJq0fG9nkaAawVevCM728znt/T0EuZLswjsBGAHszpV3U/CivptNvT3GfV2DhOVwRVuuq//hE65BJMCNmZsaTibAUIA9HFTqJdgC9uQK+nfgYRGmAkZc7LwJTgKbHZWgleSfg0nQi/90ePSr84se/9J/QGbSOVFdbQdSgrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kwcr2M9f; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-70b3b62025dso961578a34.0
        for <linux-arch@vger.kernel.org>; Thu, 05 Sep 2024 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725570976; x=1726175776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6U8xmtXOad/vlvI1PiwvXKTTO0WQVhDEUoOSf42FlI=;
        b=kwcr2M9fgdzlMxXxsayGgr8FB6aw0Hi/w/Uub2U9/gvoItEWYuyY00uL0iGEYsHR8u
         GzpH2W1Y0Y2/r+kq3e9N6mPxLqJtCzVp/9rZ7rAp0ocRPdMczBj28zwKzjl2rWU4m67b
         jmZ+JQekCPFbAZ1rVbsGYXW/KjoT/cKjW4pzzx7MIIOHc/8glsj90n6oEYjU6urKpv5E
         O4naPYEPOcl/gYnCb1sgjdE8U/+p+E0zc1PyQ8jy4No90yl17lLSAEjG9wEDgS3Ep3lm
         FTwQAH/NzfHnZsddyTCCeepeaY7xQVFJEYI/bDJewzysQOQOkwxvxmz0hPncK+ZHtceZ
         ahnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725570976; x=1726175776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6U8xmtXOad/vlvI1PiwvXKTTO0WQVhDEUoOSf42FlI=;
        b=PtZLTF+SjAavvGZGbpuMhRbbsQRyjx1Fb//hvK5zx8B4l/evesiiu55PGNntOcEB+L
         Y8aZVdzNWJdKzGyTOPxc/SlmQD1WlHPVmmI7SMXmd/bB3jsM2qTekfAaHtyu6cDXUrWq
         XSZcfFCk6ft1NC/xxAkgsOzwZzmX19J3VayzeXrrCxuXoRo6u5Esh1JSuQQiCVoxJp4T
         Hcr85SH/649s/R4n8tj42osCHbSS9/KFoK+GtK9SqswuBDvSCwCK6cmlxAAc9bBGkaF4
         3L/l4gIZuUfU/w68SWrLKWNgelX+JwIn+5zCM/3ie2PDlaJ9iFJaN9IuxzMAklUaNymz
         xy9A==
X-Gm-Message-State: AOJu0YzyYHtV8VyOJLXJqlXGNVB0SiM8aygDiz1doy+kJXBT9nsAtxV5
	QpMdXs2gxV8OK+XUj4dUMLJBfahPnUC/zjdhhv9nfcRDBaQZiofM/vWlAfQ0O8w=
X-Google-Smtp-Source: AGHT+IHmMPDz3EnCCj73XeYdf9AhtZ+Ct4KejhsVi5dvIA4rh768bjpktZjdCxUayXeGPhLE3R+w8Q==
X-Received: by 2002:a05:6358:4287:b0:1b5:be34:9ad5 with SMTP id e5c5f4694b2df-1b83866e08bmr73366455d.15.1725570975653;
        Thu, 05 Sep 2024 14:16:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbda7abesm3775746a12.61.2024.09.05.14.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:16:14 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Sep 2024 14:15:51 -0700
Subject: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to 47
 bits
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
In-Reply-To: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, 
 Christoph Hellwig <hch@infradead.org>, Michal Hocko <mhocko@suse.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Chris Torek <chris.torek@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=B2nFsYQPUa93R6MPC6rybC4BjlmBU89eB/xyA3tmSh8=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9ot+em/OZQnfrnX8ed38Mt7a5qeTLghH2JpoLVOM/lWE
 E9Dee3VjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACbS9pyRoX//nRvvVlydp7Xm
 8/1ihzrxA51eb31tEvRWPpi166jgtMMM/2Pui4Sr/NDPPh503bbDcC77kZANfKUH/kz3LrfLiU2
 exg4A
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Create a personality flag ADDR_LIMIT_47BIT to support applications
that wish to transition from running in environments that support at
most 47-bit VAs to environments that support larger VAs. This
personality can be set to cause all allocations to be below the 47-bit
boundary. Using MAP_FIXED with mmap() will bypass this restriction.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/uapi/linux/personality.h | 1 +
 mm/mmap.c                        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/personality.h
index 49796b7756af..cd3b8c154d9b 100644
--- a/include/uapi/linux/personality.h
+++ b/include/uapi/linux/personality.h
@@ -22,6 +22,7 @@ enum {
 	WHOLE_SECONDS =		0x2000000,
 	STICKY_TIMEOUTS	=	0x4000000,
 	ADDR_LIMIT_3GB = 	0x8000000,
+	ADDR_LIMIT_47BIT = 	0x10000000,
 };
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..a5c7544853e5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1766,6 +1766,9 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
 	unsigned long addr;
 
+	if (current->personality & ADDR_LIMIT_47BIT)
+		info->high_limit = MIN(info->high_limit, BIT(47) - 1);
+
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
 		addr = unmapped_area_topdown(info);
 	else

-- 
2.45.0


