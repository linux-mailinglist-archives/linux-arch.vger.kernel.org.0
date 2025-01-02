Return-Path: <linux-arch+bounces-9557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCBD9FFE90
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B41883A86
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BB1B87D5;
	Thu,  2 Jan 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="McLVyt36";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MS4luC1I"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382541B85CB;
	Thu,  2 Jan 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842885; cv=none; b=fDrm4z71+uQce1esYJzWTyTqHGOi4NnHiGkjbzCaN1cYUnwuoRv1Rf23eR4K+5rqBvLBCwqKx1zUguOuP38HH5SOv32wX8ujMUDb5CFOx895QGctETpUvAOdO+DdEEHW3fXHIShQjeg5BNrVSB8ab1pzG4KRVurBqwyFRpUovSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842885; c=relaxed/simple;
	bh=RhHYt62GnA+7j7OdQEjolUMUreWyFbTQWM9dKssd6BA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nb0b8n4kn5vWLw+s6QrMoIjAmCXOSUSqSiqTK9iHpjjlvPnE21S00GV+E2MKGdOgE/I3kIHIa1WipYAJnJouOIpRbKUHrHRK8cCnVOSf30NDVRmjkzkI5y7d8lMVxYS+cHmOI8WWra8ixQ5KSIstGFw8hBJnoNnUY3Rq3d96kXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=McLVyt36; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MS4luC1I; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 621CC1140167;
	Thu,  2 Jan 2025 13:34:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Jan 2025 13:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1735842881;
	 x=1735929281; bh=XyrFvfuZ/A/xKzvt+hiRlhoazpimLXOiH/BchC0TPMw=; b=
	McLVyt36tgj/qvD2FeD3tNste/Lwq/qb8PeAA2P/b0sPFO2vReMrOZ2Ks1DuF3Xf
	BaCj3uGFZ3qdr6RckXpDPEWpUUQmg/8OIKH6d7pHR0Yg1h5sWd2FKark0Flo9idw
	I37eFUUadBDt3ZUL9QYh1nkOywnBQrVqQkcAaEam9bA8B19cjPc45ITeuj58ahu4
	ayVR0g+MQfhXJsFnTZNvGzhQsZypfUg9kRXDf5BpobI475BzDBMhvxcUrrz6/Tcx
	l20vjI75ESOhqnYVb9YXN3IhN2Z147mBww4hiMoaJEfEDyc45GkMjSsRgV3WgaFK
	fBtuvF2FujTL5Y1XcWEp4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735842881; x=
	1735929281; bh=XyrFvfuZ/A/xKzvt+hiRlhoazpimLXOiH/BchC0TPMw=; b=M
	S4luC1IcfWAiEwSzTYIh4gFnwK+u+nxGSdlvMuWvJJP3dMAQiXilXFo4RIZR5JIC
	8oLFV0DifzynqMqZ5+Tq7ivNaMIcqrRsCP0RUq9euOXCYt3sw22HF9ADDS5Y/5M7
	PZi7SnSu3IoapMWT1rCuIaJfQau0yCa46iUE9Nn5KJUPyx7qloh2za1TZblvFkKe
	G3w5YBVe87FXPkzy/S5TbkzUzNCSnmsfhdHBW9hrPQv2M95Czz9I6Ix4FfXsEtfC
	OXUw7K27frwvZkHfeJWmClnTejUN0nJ4MYoI6qxNLioS01pJ5/lXGew+DLgNiBSY
	PiXoG5zLvR2PwlnUIjHKg==
X-ME-Sender: <xms:QNx2ZzQkuKMx4lfIvJmhlNQWN6ulzccBAJsH2coQOzo3cXlAkMZILg>
    <xme:QNx2Z0w-1OULJcvVGaIbfDTHoZEkOCNAMvGvDPXi6cQVE4XjkZXJMtRGi8dNQVGBD
    7s7IkZ5-Si-iNw0_cA>
X-ME-Received: <xmr:QNx2Z40mx9gWgBucFZ-bGpNaDrYK1PKpxKOaLlqr6wBYoUak_fKexV_r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleff
    keegudeghfdtuddugefhueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
    rdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehlohhonhhgrghrtghhsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohep
    khgvrhhnvghlseigvghntdhnrdhnrghmvgdprhgtphhtthhopegthhgvnhhhuhgrtggrih
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgt
    phhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QNx2ZzCETU5h4T6uQosgN0HFiamfEZHRhs0-qnoFVMH1BtmVowSZeg>
    <xmx:QNx2Z8gsSLRb9PjfA8pSVZtJ-64wL40TZ6v3mtZvTYLdMSDThXuqLg>
    <xmx:QNx2Z3pdPdTttP-W-HYfLQjx1Jsaek1ucQmWHUQEsdrWdUnOwgKDgQ>
    <xmx:QNx2Z3j6MevqU_esmUGyuSDXbwMuhtMK7QVQsfPWIkP0amoNSmcs4w>
    <xmx:Qdx2Z4jzObA-ztE0yld36aK0i1_KjvMQgZrSmXTkoL_joRXcs92CFTIq>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 13:34:39 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 02 Jan 2025 18:34:34 +0000
Subject: [PATCH 1/3] loongarch: Wire up 32 bit syscalls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-la32-uapi-v1-1-db32aa769b88@flygoat.com>
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
In-Reply-To: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
To: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=RhHYt62GnA+7j7OdQEjolUMUreWyFbTQWM9dKssd6BA=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhvSyO3YuUouVpjG+er4lYqfpzDtn1le0FRzedOs1d99nP
 enedXUzOkpZGMS4GGTFFFlCBJT6NjReXHD9QdYfmDmsTCBDGLg4BWAiSkcZ/mmK33vgO/v1ROmb
 fO1+y66sEOKYUbUq3kX3r02upMrUYDmG/8VbpjTZn1xdLemy1yKm8pzp1C02/Twuv6awhfhFreH
 4zAMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

LoongArch 32-bit UAPI will be using generic syscall table,
mostly identical with 64-bit one. It will follow the convention
set by RISC-V, being the second 32 bit architecture without
time32.

Generate unisted_32.h and syscall_table_32.h as necessary,
expose united_32.h in unisted.h UAPI, and implement mmap2
which is a part of 32 bit syscalls.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/Kbuild        |  1 +
 arch/loongarch/include/uapi/asm/Kbuild   |  1 +
 arch/loongarch/include/uapi/asm/unistd.h |  6 ++++++
 arch/loongarch/kernel/syscall.c          | 21 +++++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 80ddb5edb8455ce206fe1c67c3156c486c07b892..39c6c45e2a759cf90015619776464af0a52a5b9a 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_32.h
 syscall-y += syscall_table_64.h
 generated-y += orc_hash.h
 
diff --git a/arch/loongarch/include/uapi/asm/Kbuild b/arch/loongarch/include/uapi/asm/Kbuild
index 517761419999a898ab3d73b2568eea160795faec..89ac01faa5aef5f35837b8c4acc583082c30db53 100644
--- a/arch/loongarch/include/uapi/asm/Kbuild
+++ b/arch/loongarch/include/uapi/asm/Kbuild
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_32.h
 syscall-y += unistd_64.h
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index 1f01980f9c94826957c9729c09c550cd090e4850..38c8bce307450f37b9cc72193c6999664a34b152 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,3 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
 #include <asm/unistd_64.h>
+#else
+#include <asm/unistd_32.h>
+#endif
diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
index 168bd97540f8cfc9be26d75843c5066c6630a0d2..b267db6ed79c20199504247c181cc245ef86abfd 100644
--- a/arch/loongarch/kernel/syscall.c
+++ b/arch/loongarch/kernel/syscall.c
@@ -34,9 +34,30 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
 }
 
+#ifdef CONFIG_32BIT
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
+		prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
+{
+	/*
+	 * Note that the shift for mmap2 is constant (12),
+	 * regardless of PAGE_SIZE
+	 */
+
+	if (offset & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
+			       offset >> (PAGE_SHIFT - 12));
+}
+#endif
+
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#ifdef CONFIG_64BIT
 #include <asm/syscall_table_64.h>
+#else
+#include <asm/syscall_table_32.h>
+#endif
 };
 
 typedef long (*sys_call_fn)(unsigned long, unsigned long,

-- 
2.43.0


