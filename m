Return-Path: <linux-arch+bounces-7978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B215998D55
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 18:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB736B36509
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2DA1CDFB4;
	Thu, 10 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpPnWgCG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yPC6uHm4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F31CCB3B;
	Thu, 10 Oct 2024 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575097; cv=none; b=Gt6cJAktbF1SoRwONLfOiX0OKaZK1MVn52j2B/s3zTgpNlIPhReEcL+QlP8h24waLBgsgHE5lTnwHrVXTlpd9x+Y2A23WQ7cx187CACNL/DRmLkjRmB2ip7sUfKt51PVuMvKRt6vHcd4RV42UyYYhSai3lX3sAXemAttU3E0sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575097; c=relaxed/simple;
	bh=bvh1jJWpx42LXX2Lx1XPkC92g2mUzF72aNPhVvbLrZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1dDHO4QloS/0KN+UUpuibNIwuTf0xzvZDl/NhPifwH65QCGYnC7axj+n285nIbeylJQ9VSgX0gwYdMcbojDUKZKttUnXFWgz5jNBe6VrS+/RprbLWxR6KFqgQQaY6nrw7PU8yOBsSPsA7CMHR14F9Ew8Sa3BVRGOoc2iJdxRYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpPnWgCG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yPC6uHm4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/XG6DQ3PsHd/P8r1A05s25oqNbuRg7CSOZvJqQ2RQY=;
	b=dpPnWgCGSIyojR8YOPIODHalfROtG8LEH56sRq5mxfbjyLOjCbAUcmwaMEXu2cZKvV/k45
	TqCsVhu9RjkkmSOOJHJuqXZYoGPFsnkOmbDlhYNvgEwJazOCAwr7sFuf/q/XCr4AxLc7LI
	dGsxxC8lKbH5MGgIEHmr9FLo/VCp+48X0ADki3jRqZ/GrQ8GTJ5MvsMbi/3zfKTl9GhNeF
	/N7gQZM/KxB9RCxX8j9UYsUadv+fsFOCt06p+0Ld11JPrc7spDgGOZClIoMnEmkNtFpvTn
	qiejVdTPUtzvFiteYKw1WjMoVONiwOUIOPbvghvXF0iSUCKHrMeOEpRwaBMY/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/XG6DQ3PsHd/P8r1A05s25oqNbuRg7CSOZvJqQ2RQY=;
	b=yPC6uHm4/dZnVaE4EHlAEdw716wEYkItVZ5dtEr3RPr0fP8aCnTfCm4qYZzbKZLqlRrUy4
	YQ6+oBRsFvnQKADA==
Date: Thu, 10 Oct 2024 17:44:46 +0200
Subject: [PATCH 3/9] arm64: vdso: Remove timekeeper include
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-3-7fe5a3ea4382@linutronix.de>
References: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
In-Reply-To: <20241010-vdso-generic-arch_update_vsyscall-v1-0-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=720;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bvh1jJWpx42LXX2Lx1XPkC92g2mUzF72aNPhVvbLrZk=;
 b=YGgVa8cvZKIl5iidwiNogphb+kk0LhZ+d6YHOWerWO8c9r/x3PAzZfBvmQFoMG57QQRIjERP8
 AcrvpsLRlIwDMa7tDFUUIPvzlus1/YLClhqc8iu++BgbyiMoYVBpqbz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 706c9c3a7a50a4574e77da296e9c83e1e2a9f5ab..8ef20c16bc482e92de8098d55000c9999b89830e 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -19,7 +19,6 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/time_namespace.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>

-- 
2.47.0


