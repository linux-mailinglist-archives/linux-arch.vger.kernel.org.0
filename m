Return-Path: <linux-arch+bounces-11387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB90A8519F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Apr 2025 04:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4757A935F
	for <lists+linux-arch@lfdr.de>; Fri, 11 Apr 2025 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494B20C001;
	Fri, 11 Apr 2025 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eStsDcDy"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF092AE72;
	Fri, 11 Apr 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338879; cv=none; b=uE2jKPCDrz2ochOKkFMZp527RnDKLNvkvR/EKAdWbfzd5nGbJo5Xpq3LQtlnKza2SHDKOJ5kRwzX76xfPkPaA0oVzGNr9xe6w961uidcxspJ01zkulIP3bcVgMmj/2NvjQLj2UuEaCuTa85eMFOXzAL7YWwESWVjCHMkBgomtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338879; c=relaxed/simple;
	bh=O4nLz7v5f2BsgqZL5bzUaWy0nkgqbnGDPuoPg9kIR7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UMSzLJgLhe5g9DQgpnHmsIXRmFgu3cJaad+HlwBQ74bAQUfuuKpNDDxr0V9radxoSKud5kPv/t45pyC5LMrmwb/d4CWtR2QbVuqWbkIFnifRC7IJcDgJWG9HuEf5nZuKfc1n2KMg1ZXszVtEFv4ZgWPRqihLuVFoinbDukW3FtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eStsDcDy; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744338865;
	bh=lOEueMjEzcQH+7FTLLQIxv5mkIyaFq/uP1KvEW094o8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eStsDcDyvTdvqMTBkBGbBLOYPR1QaF6vYkxvBvxQqfgG1RJD0tCuj/n6i+ZkvcPDo
	 QAquk4YA0kYS/y0VgPttR+xf9SrTbgXzrYDNaL4p5oTwZZQLhyYFfUnm91+7+LG9i+
	 HEbLrZ7Y8bBgiOyprknxbH88tjLqit98lUpNDlwE=
X-QQ-mid: bizesmtpip2t1744338855t90627c
X-QQ-Originating-IP: VREOsRjt7J4ccSVoy0EUwQUzXam43CY8I2m/vm0gMqE=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 10:34:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1101699977250414760
EX-QQ-RecipientCnt: 17
From: Liu Runrun <liurunrun@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	liurunrun@uniontech.com,
	mingo@kernel.org,
	ryan.roberts@arm.com,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	kirill.shutemov@linux.intel.com,
	arnd@arndb.de
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH] RISC-V: Fix PCI I/O port addressing for MMU-less configurations
Date: Fri, 11 Apr 2025 10:34:08 +0800
Message-Id: <20250411023408.185150-1-liurunrun@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: MHAMmLg4tmnVmAxLBtaCh5q5EWHF54LkueHHxS6SKxqLY6dwt6gpq7g/
	XUEHJ+3gwW5zWH2n9q15yuwzvOBIoMlxP423I2HPt3ijWTyp8GbNyrJ8dUOzp7Mpf556GME
	GS1ajvrd2hnWLvUJecf233QJ/AfVliWeKQLoX1UcAXJQ9JHjWK5+klUmWy/87oPJA2ZPkkT
	PUk20qh1g6AGCKniolX5e/8cF/B9HzaZzsS/hmVxOd7gn7KqWlzWKxkZTZ/Kpme0WNonyPI
	xu1EhjIXfQ7jNR5q8s4QN9YMrgKK8lfI87XvP+3zChv/TKdBBhMIXcECD5mbp22bPTy9VrM
	mUDsjzCwSr+qqgGiaT/4kXkDjrXNVg+3av3t91q2UL6KTfGGbxnhn86HPYbXJX1zxTs17La
	NtwhUlhVC2GS38GPVUcoWl6u5gYzNMAIwezUWfOsDZVDC2DHRhYSuR98llDS4NDxyfPc8b3
	WrW781Xtgq3IYqwaAcEzM5nhwqoWWypwXdzylzqMwFNRKV4Jlm19leML0KaRPav5L3h0pRY
	B5JagS7R1TUhZts01Caere1es5tuMQeh1aaVIMqL47luf5RurBTD+DiZNDtpubjFnw77kXk
	yqJBt9O7AjnbGaEpYqDM6WyuAQhTD1N9BZDOKese7x7WOYO+/kVx3fRDrNvnAbock8MECh9
	4DmQiG8/Q3FZi9ihDImN34qu4vYg8HPNjozDgHeEv3M6YK1+PNF7VjbAiZLpsG4bKqtGdJ5
	CNj0PpWIriNgIra/3TXk8OK8JtwCXEGrU3hUgjjynn7lRcLgLw7/FEqS1N3yQBg6P6j4Tlq
	Rw+syoG0QZdPUA9MGPoB1kFI9o2BH6oP+xEqhCYLQJGkBQvIIbq8xgLNRZN8EEOK8HpYaC2
	ZW9lEd5GvY5bFb3d7a8QHjxg++l4M6hyh9x+K4KfMk5ebfqupYKkhsLbASRaM+RtyW44cD3
	x6eNxVyo5zXTQtBmcNKVQwPqWXJKoUDkZTNaeC15JFd78IxA4hAWUMBmg
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

This patch addresses the PCI I/O port address handling in RISC-V's
port-mapped I/O emulation routines when the MMU is not enabled.
The changes ensure that:
1. For non-MMU systems, the PCI I/O port addresses are properly
   calculated in marcos inX and outX when PCI_IOBASE is not
   defined, this avoids the null pointer calculating warning
   from the compiler.
2. In asm-generic/io.h, function ioport_map(), casting PCI_IOPORT
   to type "long" firstly makes it could compute with variable addr
   directly, which avoids the null pointer calculating warning when
   PCI_IOPORT is a null pointer in some case.

The original implementation used `PCI_IOBASE + (addr)` for MMU-enabled
systems, but failed to handle non-MMU cases correctly. This change adds
conditional compilation guards (#ifdef CONFIG_MMU) to differentiate
between MMU and non-MMU environments, providing consistent behavior
for both scenarios.

Fixes: 9cc205e3c17d ("RISC-V: Make port I/O string accessors actually work")
Reported-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Liu Runrun <liurunrun@uniontech.com>
---
 arch/riscv/include/asm/io.h | 22 +++++++++++++++++++++-
 include/asm-generic/io.h    |  3 ++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index a0e51840b9db..d5181bb02c98 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -101,9 +101,15 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar(addr))
 __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
+#ifdef CONFIG_MMU
 #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
 #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
 #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
+#else
+#define insb(addr, buffer, count) __insb((void __iomem *)(long)addr, buffer, count)
+#define insw(addr, buffer, count) __insw((void __iomem *)(long)addr, buffer, count)
+#define insl(addr, buffer, count) __insl((void __iomem *)(long)addr, buffer, count)
+#endif /* CONFIG_MMU */
 
 __io_writes_outs(writes,  u8, b, __io_bw(), __io_aw())
 __io_writes_outs(writes, u16, w, __io_bw(), __io_aw())
@@ -115,23 +121,37 @@ __io_writes_outs(writes, u32, l, __io_bw(), __io_aw())
 __io_writes_outs(outs,  u8, b, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u16, w, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u32, l, __io_pbw(), __io_paw())
+#ifdef CONFIG_MMU
 #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
 #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
 #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
+#else
+#define outsb(addr, buffer, count) __outsb((void __iomem *)(long)addr, buffer, count)
+#define outsw(addr, buffer, count) __outsw((void __iomem *)(long)addr, buffer, count)
+#define outsl(addr, buffer, count) __outsl((void __iomem *)(long)addr, buffer, count)
+#endif /* CONFIG_MMU */
 
 #ifdef CONFIG_64BIT
 __io_reads_ins(reads, u64, q, __io_br(), __io_ar(addr))
 #define readsq(addr, buffer, count) __readsq(addr, buffer, count)
 
 __io_reads_ins(ins, u64, q, __io_pbr(), __io_par(addr))
+#ifdef CONFIG_MMU
 #define insq(addr, buffer, count) __insq(PCI_IOBASE + (addr), buffer, count)
+#else
+#define insq(addr, buffer, count) __insq((void __iomem *)(long)addr, buffer, count)
+#endif /* CONFIG_MMU */
 
 __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
 #define writesq(addr, buffer, count) __writesq(addr, buffer, count)
 
 __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
+#ifdef CONFIG_MMU
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
-#endif
+#else
+#define outsq(addr, buffer, count) __outsq((void __iomem *)(long)addr, buffer, count)
+#endif /* CONFIG_MMU */
+#endif /* CONFIG_64BIT */
 
 #include <asm-generic/io.h>
 
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 11abad6c87e1..c0409188bb5e 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1172,7 +1172,8 @@ static inline void __iomem *ioremap_np(phys_addr_t offset, size_t size)
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
 	port &= IO_SPACE_LIMIT;
-	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
+	return (port > MMIO_UPPER_LIMIT) ?
+				NULL : (void __iomem *)((unsigned long)PCI_IOBASE + port);
 }
 #define ARCH_HAS_GENERIC_IOPORT_MAP
 #endif
-- 
2.49.0



