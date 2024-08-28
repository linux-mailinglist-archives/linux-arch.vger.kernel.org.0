Return-Path: <linux-arch+bounces-6695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B6961EB3
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D541F25015
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A99E15B0E5;
	Wed, 28 Aug 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TFXZvnQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF31509B3
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824203; cv=none; b=qR9HkbL2o4nkiUynQ7WoFcaSz4xXtcv6gSUwn6Unw3DApARMu5AQgsYkfreh2UKH2e8HiQheqWBuU8yGq+LkVoRGs2YgDx50O8QmmfzRrimZFg/CO3PDXc0qYdDi/j3XDF6E1A6hYlFdFtPOhKN/58EUIKI6p5dIRithtMiEn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824203; c=relaxed/simple;
	bh=1syBnrvTSOlOGGJG9VxttpQivuBkydj5+eNQ5N/relM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dN2n4AfYxJr7H6Wm56GiftL9oLMG67p5xFCQw3MQdzas51maYrlx9QdmJ8Hx4PrI9IU13WROpGwRGByZb35Lhv4O8T3x7G1XtIYKugwklvNYIQrQI+gTXn/ds8z2qhvj2VunPTgmDmgcNUq/EXW51A7Fr0BHD2enkXgy0CNqd4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TFXZvnQU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2020ac89cabso58352705ad.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824200; x=1725429000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfZJveM1parb4u035pYGD3zTISJbrOiZGzu54vNwlmI=;
        b=TFXZvnQUgDl02oiQ5mF7Q3S825lbsLHSgkzwcydEgSKHpLPZx3K1yWltiXMWy39O76
         c6q3t6kx5eIWJoGa6P7+LBx14cpWSecjhVesNs8hKXffMBrOigdyNJ2VOZy2Ijy5+iYX
         xano9eHts8MGnLz24dxSb7FCx/wsgkdecg/NiYfd09vNRbfSuZl0qsOgVmfEod66R8AI
         kJmbRB39eb9B6R+VoMfTSlF1RBu3i/M2odcu/i+clDQqTIKYTk2E3h7aBwkP35184Aqx
         TlwEBliP+faz0+svr747LGI2UEMOUIgazuNcxUYqiIfrwk7A2uzrcmoj6FlFOz95vGw5
         PvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824200; x=1725429000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfZJveM1parb4u035pYGD3zTISJbrOiZGzu54vNwlmI=;
        b=vvcJJOoKudKwW1wbDxeolV730QuwPC+NxiSEZK2WW0NPzKSlYdrR2F31+51At9TkbT
         00NrTBNtPGax8PE+VdOp3C7Bq9fD9iAahFmJ567wCVESBSorHXB/Lhy5T0i1/WFvgiiY
         PcsP1iM8Kbia7UvtsSJwlVwzo6r10FnEbpR5DYfrjUX6LsEegahCUfhz0zJ9oc9d0EsR
         juJ1KeVeBEIzm9dNSaOA43ZOT4LYKkzt+ZeehaPAXf54UngXM376eqG5AoHCHo2a/88j
         DuYE+GO+qGuNjsB/RV0m5g9vumYAKYybAiLdITE14VbD3cFkFKSG8qi43lLv6d58wciw
         FGOg==
X-Gm-Message-State: AOJu0YyKbamUuY5rzcV5NXHX8c+JgMfIJUDCUhfUFxGG35cNXGrr8Ho5
	KAPc+1w5log7zpogicfFDTEz/zWzwNi5GcA+Cp1BDXvYJ3pJM0srLE7OId7whwM=
X-Google-Smtp-Source: AGHT+IF596NtgPi2otbs5poJBgAoGUDj9IXzCrdKWZMEp8cIFyXQZx8MxZQO71jW2zsopg6SUNTImQ==
X-Received: by 2002:a17:903:2352:b0:201:f065:2b2c with SMTP id d9443c01a7336-2039e4fbbe2mr155506935ad.55.1724824200296;
        Tue, 27 Aug 2024 22:50:00 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:59 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:16 -0700
Subject: [PATCH 10/16] arm: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-10-46ff2eb9022d@rivosinc.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
In-Reply-To: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=1syBnrvTSOlOGGJG9VxttpQivuBkydj5+eNQ5N/relM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XfH7+5/NObdD1TC7as2nnrut80uYIpiTE6QKMsStV
 jRo9UV3lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJH3iowMbzKLnvWynRbmDQrg
 3uNwlaGFp7De9nT0tCfZV9Zxzb2swMjwZeP9u8Jhqpz79ln+TNZVkXSd3DxD3/DEm3BhhnWsrp8
 4AQ==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to addr
when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/arm/mm/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index d65d0e6ed10a..fa0c79447b78 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -71,6 +71,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
@@ -122,6 +124,12 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = FIRST_USER_ADDRESS;
 	info.high_limit = mm->mmap_base;
+	if (flags & MAP_BELOW_HINT)
+		/*
+		 * Subtract (STACK_TOP - mm->mmap_base) to get random
+		 * offset defined in mmap_base() in mm/util.c
+		 */
+		info.high_limit = MIN(info.high_limit, (addr + len) - (STACK_TOP - mm->mmap_base));
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -137,6 +145,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		info.flags = 0;
 		info.low_limit = mm->mmap_base;
 		info.high_limit = TASK_SIZE;
+		if (flags & MAP_BELOW_HINT)
+			info.high_limit = MIN(info.high_limit, addr + len);
 		addr = vm_unmapped_area(&info);
 	}
 

-- 
2.45.0


