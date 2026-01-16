Return-Path: <linux-arch+bounces-15824-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1149DD2D576
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82A75300792C
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2959930AD06;
	Fri, 16 Jan 2026 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeZlsSQ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Db0rjIAH"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1904288530;
	Fri, 16 Jan 2026 07:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549253; cv=none; b=ViChyQtfNzfreiEvcKUO2WTnjJE9njiGFxksxyXQZCRng3Qy02SgQFs8da+3IsQIJEMPbCBplHc4dIo+oBz1AFMag4buQMSXrbJELOAyMDzWycAVpV//WEB/ou+c43yCJlSxbTWwEtZjoDsr6l5DD4Q7YNOWor2ceXKzmKiVLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549253; c=relaxed/simple;
	bh=kt3CvuNn1vmevL7BAYsXxXqmblyxRHDlhsiDvWPlU10=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PZcEuEQEFLE9UcTwVvvwrCMQh2I+Rh2ApoNwXK5JpDh/Dg2dUowza/7RoJT2vT+XNLLNIBot9Dfdl1bzYZrbgK1c1A4kFawWY6Jiq1x7rFmqo+PNW2VnYCokto/7IumSr5rotjJRxnbZVrqNgwd6SHTiuQ6Kpzz/ggcTpI6KEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeZlsSQ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Db0rjIAH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768549249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LAw4SEgm1iYpfHS2Ouzdt/ovhQF+PmdRD53d7/vg21k=;
	b=MeZlsSQ1s2qfGUEKRXsJvSvhTKRA0FrkZRItOT7mS6hZGxOEtYuBcBnUi6zaRIpzPuCnaD
	KTceVf1Q60SlAVBmGOn+pKZsaXzYpjkidrk8iV+fXleYDz01FwihtBu/djyS9FWGWEVohD
	owrvcd6ajsQ+nGIWVSb3+5Sc1wpYaeTnZ4cypfvvZsMkQbp72JhYN4Rnk61fLhtb81vrpZ
	XnrJ8BLE2piOSOu76Iez8TfWi5T64eVXTznNGQswoXZdK7XxvIl5BSsCmiD41qVDTmsVFp
	RAmo8Fu6fPyoes+5yTwj0IqAee8Lzo/yvIgDXk/Un77+lEDZ/D7p++LGTivi7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768549249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LAw4SEgm1iYpfHS2Ouzdt/ovhQF+PmdRD53d7/vg21k=;
	b=Db0rjIAH6+WFttd10HLcSKZHKrtM5QO/QqcYiGFo2inQjubN4HfXpzJ1MugcH5WkLbh+ht
	ZNPH58ys0bSXPEDg==
Subject: [PATCH 0/4] vDSO: Use 32-bit CHECKFLAGS for compat vDSO
Date: Fri, 16 Jan 2026 08:40:23 +0100
Message-Id: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGfraWkC/x3MQQqEMAxA0atI1hOwnSmCV5FZtGnUMGpLIzIg3
 t3i8i3+P0G5CCv0zQmFD1FJW4V5NUCz3yZGidVgW+uMaTs8oiaktGa/I81Mv3Hxk6KLoXPhHT7
 BE9Q4Fx7l/4yH73Xd+cHd8GgAAAA=
X-Change-ID: 20251107-vdso-compat-checkflags-5db75b3b4bac
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>, Sun Jian <sun.jian.kdev@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768549244; l=1326;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=kt3CvuNn1vmevL7BAYsXxXqmblyxRHDlhsiDvWPlU10=;
 b=nY6udk/40JJAZYyFQWQkS3swjpPXvepYYMH/581rN/ew8hk0e07KhSWLT7UYX4CwZuKJ2IVMn
 xB0WUe1U+rqAXol8v6gAmkPyg/qW0JRyTHFnaqyEM+5+9rRecQ6WN6D
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When building the compat vDSO the CHECKFLAGS from the 64-bit kernel
are used. These are combined with the 32-bit CFLAGS. This confuses
sparse, producing false-positive warnings or potentially missing
real issues.

Manually override the CHECKFLAGS for the compat vDSO with the correct
32-bit configuration.

Not all architectures are supported, as many do not use sparse for their
(compat) vDSO. These can be enabled later.

Also add some checks to bitsperlong.h to detect such issues earlier.

Based on tip/timers/vdso.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (4):
      sparc64: vdso: Use 32-bit CHECKFLAGS for compat vDSO
      x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
      s390/vdso: Trim includes in linker script
      asm-generic/bitsperlong.h: Add sanity checks for __BITS_PER_LONG

 arch/s390/kernel/vdso/vdso.lds.S       |  3 +--
 arch/sparc/vdso/Makefile               |  3 +++
 arch/x86/entry/vdso/Makefile           |  3 +++
 include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)
---
base-commit: a37abd052c0bd9d1194710a39008801379f8ff5a
change-id: 20251107-vdso-compat-checkflags-5db75b3b4bac

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


