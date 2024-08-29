Return-Path: <linux-arch+bounces-6792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E77963C7A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 09:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6947D283F58
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 07:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00717CA0B;
	Thu, 29 Aug 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="YjY6csQA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C816D4CA
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915780; cv=none; b=Izdbkve/0Knk2UU5oyodiNuXu8oZPYAL8dZvcq0wjzmMzASWgvS2oizH750RCGiyXcHuJqZXshhvITCvFIiUZRnlOoIFUq7c7gMynKBi+HOVlcnOZLj6FJopGyNkEZddTh9CbRDOiBpAvEPAXGZoVW3ICqkeXHi6vFLxJBrbHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915780; c=relaxed/simple;
	bh=BFQJVSzGcUiBI/yFP8LdbUQD3Uj+U8GuBEaXAXz6ZKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r+Bf9mB+GGDnO9IbhRXoHhjTI6pJ7VZCeAytCgbfY+I/eRaw5BQoVQLBytJ95KKbRcsARr8b7oOQD7YIfm+hczxQj4MrSwy6yxrSb1m/+lFKJJNapgIZ9OEasvyjgOTGWjtJImktshwqx3WVhi+lTNyDYTbHf8yuZ02vyx1EKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=YjY6csQA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-714302e7285so280126b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724915777; x=1725520577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+PlWd5TxPsjPig/hDVlAKKLZn98jtqGVu2vnt7YwwU=;
        b=YjY6csQATMCrOEwZLU/O2bTnabxTFqK1/W1pNXL5jgIn6/xLfdWyP86ZMK1QAay/b+
         0y+W4/EE6gITb+hmOeGm3Lw4FBGSpJQf72LhwQLQZheMIZH2pyPefkLYoY3a+sySNbqU
         1+SSBdSmhxyOvuG7jEpW5Fa3WYX/meFuWYrBVRliPcy2/6XweLzu3v1zdZpjIrCpv2xD
         KnWfkVkeBP7JcSOpHfJXRhqswJHBQVDDi7ON0E9ef5KdCaaVB3jSiabL5uhsIDZBOIOu
         FsgAq1/wy2Iu+Por9Dzz0sPtdJiQCJ1yuyh6bSHlVYTl/J+yrHflA/v+CdVijrcW45XX
         sZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915777; x=1725520577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+PlWd5TxPsjPig/hDVlAKKLZn98jtqGVu2vnt7YwwU=;
        b=IHwObhvs3sqn6GhAdvMjn7jA0wm/ddazoLxcTPfH18SvBOqvFobEE+jk0T+fWesLzv
         lC0rezvHerPoF6lnejgI4z3V2nVohv4OuKVCuP86J1MOlGkKRL1B7R8av8rm38esee5Q
         hheahN+Oj8t/wS+vTbcVDRXd8sMuzY/3AzlwY/0J53OiVjnAziFqkxT6UQBsZw9mhroS
         6B70hmR1lLYAo2a2ypiSLwq0S7GpwYtYcivtXiVQUkipsXrt6b5ORRJeBAHN130SmWQr
         AKr/B9RkI9+C+KJ6RbKuYYohBERaHYcBQd6GYAHwevRGPMjpK9UfHmXtjQeNCs71z4hQ
         8emA==
X-Gm-Message-State: AOJu0YzV7vjoDTm+wsvqXiIPg0rOYgY1dGdgH9pJB1z2vIx8620KkxxC
	t8OHg2h8FTReul4cfoxzxSFueNfCDlf6YHzXmXWEtdIlAklZO96RLSbMiEp80K8=
X-Google-Smtp-Source: AGHT+IFLTY1yKSBMzZ5xgis43aJyn47zOLzwLd2defzztxCwj/TAmDuOoW0Odpywez2pOZ4X8GI8+g==
X-Received: by 2002:a05:6a21:164e:b0:1c3:b16d:9ebf with SMTP id adf61e73a8af0-1cce10103d0mr1908062637.15.1724915776548;
        Thu, 29 Aug 2024 00:16:16 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bef08sm581976a12.58.2024.08.29.00.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:16:15 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 29 Aug 2024 00:15:58 -0700
Subject: [PATCH RFC v2 1/4] mm: Add MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-patches-below_hint_mmap-v2-1-638a28d9eae0@rivosinc.com>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
In-Reply-To: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
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
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=BFQJVSzGcUiBI/yFP8LdbUQD3Uj+U8GuBEaXAXz6ZKc=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9oFBYuLDvF9d6RNyqKnPc++ZptxLkm788kE4fk8m6PdD
 Gf/eyDdUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwEQUHjP8FT4q7/qhylvttk3+
 XKO3ddmdn3jey344uGPfdmlzxi+3HBkZXsjbfilaf335tejK27Ovnk67EVP0NumF3oyGea6eXuV
 VHAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Some applications rely on placing data in free bits addresses allocated
by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
address returned by mmap to be less than the 48-bit address space,
unless the hint address uses more than 47 bits (the 48th bit is reserved
for the kernel address space).

To make this behavior explicit and more versatile across all
architectures, define a mmap flag that allows users to define an
arbitrary upper limit on addresses returned by mmap.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 include/uapi/asm-generic/mman-common.h       | 1 +
 tools/include/uapi/asm-generic/mman-common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..03ac13d9aa37 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -32,6 +32,7 @@
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_BELOW_HINT	  0x8000000	/* give out address that is below (inclusive) hint address */
 
 /*
  * Flags for mlock
diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..03ac13d9aa37 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -32,6 +32,7 @@
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
+#define MAP_BELOW_HINT	  0x8000000	/* give out address that is below (inclusive) hint address */
 
 /*
  * Flags for mlock

-- 
2.45.0


