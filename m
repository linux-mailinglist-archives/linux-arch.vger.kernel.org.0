Return-Path: <linux-arch+bounces-10491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E155A4BE17
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154FA3B95BE
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609081F4607;
	Mon,  3 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBXAYc6x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BsJE+rCd"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38F1F1921;
	Mon,  3 Mar 2025 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000274; cv=none; b=Q7EanKjerWnAPVosR4BPgDvMkMsIWChs38yYvdacWB4Ic35WGcaACCl9zcr7i8gBFVmq36R768ivVp1DoNVZuYlRsrEvnOXJcKkqQTafkyyeuxOzPvVee1Y5jq5rpGTl7s0ZbN1HqSxuQGW1+oUog40XCToDR2eN5Ev7CKv2oyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000274; c=relaxed/simple;
	bh=VdJynf/LX8Td1aTkjDVHlJTY8Y3Zg5hFlXQpxeLfjrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp4p4Hs9mmaxTAPaEAHoea1UrH3ASxM6K7ozMPx73M/Ki342w6HFyDcRcppUR7wmvDIK70KtkTx+jQ53HCqzGppzl8vyQOADmJNCoHxyrIwUhZrH+9kEWp4LkyyUaCtIzVP7m5FQY+zDDOVnDweHvplFcs6llb6ApaZB3Q4GWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBXAYc6x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BsJE+rCd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCdwRb62VTrbR5xUivRBa4yVRFUw7ANF4zJUEJ52hKQ=;
	b=HBXAYc6xl7KXGh/flCRILcVk+FA2fkf2y+XEkkT1eiInvI/WfegoID9q/3cIc6OHUqczQF
	PQ49lZDS2Y/Fv2QRZ8112jLN7GiEnYGu/yh+XnDCfOB/9SGVDHAFD9V9jdStmPpM3ABntq
	GsLYgwzT+9+c1Lw8VU9SftKkk2q/usKIBCN+bqSgFpqjRxL0YA2gkEorjyv4YN/5R1ZEkX
	Qw6YbVEqPHHPDJGw3ayhJpxHlKzzXE1HIiT3eL9ovTtk0Jkt3bJqXZSGsFl1QBIij92k+7
	mUZHjIT4lwCNeFK+4MY1FJAUL109K4ASHusMTysKX5yNBFMDuxvnmnQUgrufPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCdwRb62VTrbR5xUivRBa4yVRFUw7ANF4zJUEJ52hKQ=;
	b=BsJE+rCdiKDKT4eQUddPU2LUS6jWIEVrQpYFv2koHUfZ/lOXdy1hh77RadF1ejnQXTtr34
	L5yNu905zFXDMuAQ==
Date: Mon, 03 Mar 2025 12:11:06 +0100
Subject: [PATCH 04/19] vdso/datapage: Define for vdso_data to make rework
 of vdso possible
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-4-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1096;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0x93loxlpgWqAeU5hAZly4hP7dcYpQTwV/L9FcTK/DQ=;
 b=kgUrJ5kC5QvnFU2yA/1gFs7qZQK2tK6WILz/EsO+Lns9Hz6h0FnvKg0dzWfpJEOg1yXiisPne
 d9rskmxoF0LDOR4RMMR3hpSsg0OkwAHBZhyMnuEvNn5qZQzT76LSfSA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

PTP clocks could also be supported by the vdso to use the advantages of
this implementation. Therefore the struct must be reworked. For a
transition to the new structure of the vdso, add a define which maps
vdso_clock to vdso_data. This will be removed when all users are updated
step by step.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/datapage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index dfd98f969f151eca3c551c3e90f69af9ee8f22bb..1df22e8bb9b31153546b72b1e8b8c8aeaed7d9e3 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -129,6 +129,8 @@ struct vdso_time_data {
 	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
 
+#define vdso_clock vdso_time_data
+
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds

-- 
2.48.1


