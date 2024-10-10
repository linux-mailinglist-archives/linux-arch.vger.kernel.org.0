Return-Path: <linux-arch+bounces-7976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E35998C16
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC331F22CB0
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A71CCB3A;
	Thu, 10 Oct 2024 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ps5/mk3m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emr3NoHm"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617A1CC886;
	Thu, 10 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575095; cv=none; b=q/xVhOsJQeE5gV+GAG1RgT8jp6X3I2dU5taE2wvtmg0hQC2yZtf3G7SJbhScDcjVQ4dY+3k7FDMbSVe4Da1CsL+eSkvVR/C/8gaTLKeGp/kdfMJKvJW2Y1XvG6Axqr7mdxCAyfdM0JSiiKuMom+VDMRobIiX5Jsv5UR/PrRX6EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575095; c=relaxed/simple;
	bh=vEHRAngD9MuOuPCRiDNA82VJK+gEUM8qSBaRt6uEvJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Aj2rCau79qIXmpf7D2jNxUbMaw4Qr34D2YLlxReY9gXc1Sxcr4m7B4wiKRi5Xm80955Xx8iyFxA6uLdF+DskGw2EW8dwe3GE+ilpxdohIRvSWT6i7uUrf3EUFV2ewvQ22i/Ks/WUhYqBbhA4gfgUSohmXkEOKxhRYsHcS3MCggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ps5/mk3m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emr3NoHm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WB2N5QQfjQyKK/IUZ575K6iS8NC3eDxd0F8948RG5sI=;
	b=ps5/mk3mLsDUcipYhz2wooMeo7xb/Bn2oBPHVLBrTQ3HFkqDcYJw7haKo5JLGLxvxpa0Ut
	iVzD3jy/0zexbSOPVOypbrhox3PKsimdvyEuOqVawg0v8ms+IgZEUUSIkzUOYLP6cWrJhV
	ogjefToGPLbVkuZ/zwTjy4REwnantdhl3WvBJbGxAbb+aWMlxri+pW5bG7xV+TgIoFlZJU
	u4Jgp0XP7/cOTC3s2qC1LSczikNFB8FXdDPVckdjW25HunnkiMwr/osgbleBYRyHT7LUND
	f89GQ/KI9KFltOPdCFC4scwzYUBNIQJopih6hTVRKhrpODcOlXJsnP8rMFX8jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WB2N5QQfjQyKK/IUZ575K6iS8NC3eDxd0F8948RG5sI=;
	b=emr3NoHm0dHHfPU9ByEiH4Mdm2TEYYw/8+O2ANg9R48cypLGQulPkR9BJ0bgx2rqUqf5G4
	7XJZRDGckZp7jGDg==
Subject: [PATCH 0/9] vdso: Remove timekeeper argument and includes
Date: Thu, 10 Oct 2024 17:44:43 +0200
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGz2B2cC/x2NwQqDMBAFf0X27EISSqv9FREJyasuSJSsDS3iv
 zf0OIeZOUmRBUrP5qSMIipbqmDbhsLi0wyWWJmccTdrrOESdeMZqWqBfQ7L9N6jPzAV/Wrw68r
 mbjv0HRz6B9XOnvGSz/8xjNf1A5OTjDxzAAAA
X-Change-ID: 20241010-vdso-generic-arch_update_vsyscall-0618e98e2e97
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-s390@vger.kernel.org, loongarch@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=2075;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vEHRAngD9MuOuPCRiDNA82VJK+gEUM8qSBaRt6uEvJ8=;
 b=szGvUeLPyxK9BXdP3C2DAht9jfEjDDdicb9QA7bfacls7AZdd5//5wdmNBRY3OWPdXAQ8Ggs1
 vq/W4RoWU/nAhk3XVNwRQTRkMgu+o4WOS9VefNnOTg/jkrdU3MIarWk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The timekeper argument __arm64_update_vsyscall() is never used and
for historical reasons many VDSO headers and implementations include
timekeeper headers.

With the move to the generic VDSO clock storage mode these are unused.
Including arbitrary headers from VDSO code can lead to build problems.

Remove all of them.

These patches are intended to be merged via the tip tree,
so following patches can be based on a unified base.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (9):
      vdso: Remove timekeeper argument of __arch_update_vsyscall()
      arm: vdso: Remove timekeeper includes
      arm64: vdso: Remove timekeeper include
      powerpc/vdso: Remove timekeeper includes
      riscv: vdso: Remove timekeeper include
      s390/vdso: Remove timekeeper includes
      x86/vdso: Remove timekeeper include
      LoongArch: vdso: Remove timekeeper includes
      MIPS: vdso: Remove timekeeper includes

 arch/arm/include/asm/vdso/vsyscall.h       | 4 ----
 arch/arm/kernel/vdso.c                     | 1 -
 arch/arm64/include/asm/vdso/vsyscall.h     | 3 +--
 arch/arm64/kernel/vdso.c                   | 1 -
 arch/loongarch/include/asm/vdso/vsyscall.h | 4 ----
 arch/loongarch/kernel/vdso.c               | 1 -
 arch/mips/include/asm/vdso/vsyscall.h      | 1 -
 arch/mips/kernel/vdso.c                    | 1 -
 arch/powerpc/include/asm/vdso/vsyscall.h   | 4 ----
 arch/powerpc/kernel/time.c                 | 1 -
 arch/riscv/include/asm/vdso/vsyscall.h     | 4 ----
 arch/s390/include/asm/vdso/vsyscall.h      | 5 -----
 arch/s390/kernel/time.c                    | 1 -
 arch/x86/include/asm/vdso/vsyscall.h       | 1 -
 include/asm-generic/vdso/vsyscall.h        | 3 +--
 kernel/time/vsyscall.c                     | 2 +-
 16 files changed, 3 insertions(+), 34 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241010-vdso-generic-arch_update_vsyscall-0618e98e2e97

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


