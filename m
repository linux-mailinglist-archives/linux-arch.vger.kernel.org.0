Return-Path: <linux-arch+bounces-7979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB3E998CEC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C4A9B32A99
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725C1CDFBF;
	Thu, 10 Oct 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJo35Z9S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8B7wL2Et"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DED1CC89F;
	Thu, 10 Oct 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575097; cv=none; b=SLVBaHpGr7gUvDwA0BCB74B9BsGlkGIpCZrq0149lvadcpnrJVt1YbsfclKnlkPxYMiiuFbNHSJPsE/DtOGLUiuXdWlvDlsSBHqU36O6GsOMLJS4zQcY2GB64hbFNYMVvrkWwExfqPb1laYviKavFDdCTo14/8s4/RTtihC5jVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575097; c=relaxed/simple;
	bh=P9OFc8LoZinuHPdD6G8mUCCAPZekDQoc9eNGYe6RM5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sqa+CIP+YGEmLg/m1WOxfNM52HY6vkPzGcm25Fz8RFrXmKT0wKPgkKiJev9mPmEx6PsccIWYbo7I1HUKFrYGDJLqVm+hW2Rvfz6IhLq8jXNbFPUpsObTwuQZ/UdE74nLalLm7SdUsUUsIz3LX7TxU+X4CSbzmR2uSzoWZc/pVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJo35Z9S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8B7wL2Et; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728575093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbw860Y8cRi5xxA/qi1H6FVRcI5Ca4sRKMG/9Wo+Ih8=;
	b=UJo35Z9SJbVvJPEtwXQTx640hZGNYd0yx369ZyIlfIt49f3c0x/SjL/N6mlKrtSjlg4mKm
	j/sqpAyhDBuAugTWJ8KWafd7X3EtfHEGBGQ6ptpv3Ls8pkj/g8+l9PlsANmS6SvFRkN97D
	Kon3OvbvB8U59sEuUrx8hhkTfCDfXvtQ5EixPaFMir23HXlcss3yflyAqw1HsFZ/Uwn4zB
	MT2EsHiPspQHHSAmEwOCTRHoE3fDziowLWBbuGwQT0zkhNYyBUe4V0FVlPnMXwtRrADaLX
	Mq6zst83FF1WS0p0ObFMXC0E+hEqbmyU/BYYxdVPrnBo+DSn/+03qzP+zKeZZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728575093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbw860Y8cRi5xxA/qi1H6FVRcI5Ca4sRKMG/9Wo+Ih8=;
	b=8B7wL2EthakSTpTkhWHWWbhqFPddFlgbdTyAxK8V1/rzHtm4Gdl+zZqr3iY43yE3KnKYV6
	XvBPZpKZ/PJfdTAw==
Date: Thu, 10 Oct 2024 17:44:44 +0200
Subject: [PATCH 1/9] vdso: Remove timekeeper argument of
 __arch_update_vsyscall()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-arch_update_vsyscall-v1-1-7fe5a3ea4382@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728575090; l=2431;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=P9OFc8LoZinuHPdD6G8mUCCAPZekDQoc9eNGYe6RM5M=;
 b=rRX2lt1HBT3/u9x9JvlnflNmRDWsy5jscJ4NTC/lrOHnd2lofDJUSy4Brb/2qyoNuIuirmMpQ
 EQ5r/daGrFlB91mXesIGTiy54olcuu6phkOtEZCAbUlBJIlrxz2PwJG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

No implementation of this hook uses the passed in timekeeper anymore.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/vsyscall.h | 3 +--
 include/asm-generic/vdso/vsyscall.h    | 3 +--
 kernel/time/vsyscall.c                 | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index 5b6d0dd3cef5483ab8166a24ab3c7ca956927350..eea51946d45a2f8c7eebfff971d74878be53a798 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -6,7 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 
 enum vvar_pages {
@@ -37,7 +36,7 @@ struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
 #define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
 
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
+void __arm64_update_vsyscall(struct vdso_data *vdata)
 {
 	vdata[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
 	vdata[CS_RAW].mask		= VDSO_PRECISION_MASK;
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index c835607f78ae990e7479878767b05cccd3a99837..01dafd604188fb0512d21c4ce4b027f7da54f5a0 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,8 +12,7 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 #endif /* __arch_get_k_vdso_data */
 
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
-						   struct timekeeper *tk)
+static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
 {
 }
 #endif /* __arch_update_vsyscall */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d6133e5d688342be8485b9a0efb7af9ee148..28706a13c222df29635fd22d23f21eacb068855c 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -119,7 +119,7 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode != VDSO_CLOCKMODE_NONE)
 		update_vdso_data(vdata, tk);
 
-	__arch_update_vsyscall(vdata, tk);
+	__arch_update_vsyscall(vdata);
 
 	vdso_write_end(vdata);
 

-- 
2.47.0


