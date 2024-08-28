Return-Path: <linux-arch+bounces-6700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA743961EDB
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9751F21466
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A89156C70;
	Wed, 28 Aug 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Muc3Jk/v"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535315D5C3
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824220; cv=none; b=WaNgFg80Vl/PCQUWIjJFp6isipn1Ibn6F/QXtXHLP9JmsGOhhu21h1B6miYV6LDuumZxT14qpxspPKj5aefrXY37ANtTwWjnVJ1tjtriqjb3RM0nLyDoIUMpMbRIN6oHXNj3CWaxv6DERv29NXwMcxOMlDHgLhFqaLjW4qwCCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824220; c=relaxed/simple;
	bh=wabvkTSjqwqq+1cwlxkGF9sQYYmBw7yR2/kPTnsB9SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7ssq13EUjr2dJL3rW77nznb2kK307sE2iuCTxGMxhAB64f1VLpIOnbyJaIMhjTN/+fd2c8YyYnBbsaM7CIRxnAOlbbN9ApxZ9lVSDhyd93J8qEQGuyuhZq+WhV0EwPeerlzlhuFlXzDUkAcKB5OkR6/KeHWib8RBUKwpDRYerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Muc3Jk/v; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fec34f94abso65418745ad.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824217; x=1725429017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N47VMRtMS+23qmQV6QvpGjMmEbWavAKSyy/PH2d+fuI=;
        b=Muc3Jk/vUmTkn7nTLubhYG6OEJoLJjeuKuGvizQhnNJsv8TWR0QrABV+YexkALVh7V
         7NafIHcie1AMv2c2d16rNEVQhtdJBimR5H2CQz2GemrFBqmFXkaqIMp2Ik8tn5PHlyD9
         ux0WoQTfyK0n122Z+XHeVA+QU34OIPsvJX3GYd2PmMOIPmDq4TC4EkYToS/zE7A2WjXu
         SbciLekHx5Vf7aiytKM2bqEktf/ZE0J3iekWcF7EQxW7vyZi7jC3seSlemgaibXoYEST
         V8iWI34NouelaLb4gK/fEo5r4ObaiD2PCGMrWQUsqq3Jtvw+VaHMQ5sBoaDseIJkCknQ
         D6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824217; x=1725429017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N47VMRtMS+23qmQV6QvpGjMmEbWavAKSyy/PH2d+fuI=;
        b=MEEmx2YPFxRSPlaZGBrTXf9C2ILLcMZC/x4STQ71EtCHeOcL2VGiA3sVWc1DxZ3XB6
         DS0rzBLGWFx4iCZfb6Y70aIewqKF734mt724t64hF7cxOAfB2KFxgsBbmCo7uBTeH5/W
         837jXUnHPKpwngJeU2gybN1GhaN09DSpUmvhXvQ0euO9hkoG3Kfq4GWrwl2PlDgILwJL
         hnir5upf3tmV74jVuheQhWC7XepxCyCqQDDeQtuG8SyjUBsxeYPMaz51UokWW5u7ii6z
         IiVl9g4oDkHiMn8719VT7ynaihL/aJ0fTSWj76597mGJ9VhK6E+NRriW7ICv9jwRx2Aq
         HNLg==
X-Gm-Message-State: AOJu0YxwSD5kniYdECvkEX9uEy2bPCwG4H6jt/UyX1WHUuclRglCZMqH
	Px+aQsz+m+mP2RUFlpl+uyBOGbP45mydbzVteGBGbL19G63pQY7YZlRxTvnK3Zk=
X-Google-Smtp-Source: AGHT+IE/8VPZ5WR+s//SHKXEyZvEaL/le/g9NWegqdCzDXKzmKgVVr+pZGJ3+/nFrNKyDvBxKE7OYQ==
X-Received: by 2002:a17:902:da87:b0:202:18de:b419 with SMTP id d9443c01a7336-2039e544ea3mr139583445ad.63.1724824217429;
        Tue, 27 Aug 2024 22:50:17 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:50:16 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Aug 2024 22:49:21 -0700
Subject: [PATCH 15/16] sparc: mm: Support MAP_BELOW_HINT
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-patches-below_hint_mmap-v1-15-46ff2eb9022d@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=wabvkTSjqwqq+1cwlxkGF9sQYYmBw7yR2/kPTnsB9SA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XYlrm85cSrl9L9mw2HGFibquxLlDQQX5BVPY7r2Kn
 Fj9yFu3o5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgInUNTIynHcLq9918a3O8avu
 Dw03fBV2dVbdxHna5i+P48xVwp561Qz/s5amcHn+vlr756VDtfCFS81padcPXfr2ZkdR7ZMDnv/
 PsgMA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Add support for MAP_BELOW_HINT to mmap by restricting high_limit to addr
when the flag is enabled.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/sparc/kernel/sys_sparc_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index d9c3b34ca744..b9ce9988551a 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -129,6 +129,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
 	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -137,6 +139,8 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 		VM_BUG_ON(addr != -ENOMEM);
 		info.low_limit = VA_EXCLUDE_END;
 		info.high_limit = task_size;
+		if (flags & MAP_BELOW_HINT)
+			info.high_limit = MIN(info.high_limit, addr + len);
 		addr = vm_unmapped_area(&info);
 	}
 
@@ -192,6 +196,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
+	if (flags & MAP_BELOW_HINT)
+		info.high_limit = MIN(info.high_limit, addr + len);
 	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
@@ -207,6 +213,8 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		info.flags = 0;
 		info.low_limit = TASK_UNMAPPED_BASE;
 		info.high_limit = STACK_TOP32;
+		if (flags & MAP_BELOW_HINT)
+			info.high_limit = MIN(info.high_limit, addr + len);
 		addr = vm_unmapped_area(&info);
 	}
 

-- 
2.45.0


