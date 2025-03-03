Return-Path: <linux-arch+bounces-10504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0777EA4BE00
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547B6188CFD7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52C1FDA90;
	Mon,  3 Mar 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5uWwxgC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txGhQuO8"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEE1FC7E6;
	Mon,  3 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000282; cv=none; b=Zi+D3d0iZttAkMhQst4RROjAuRLie0ZnOXgv5EVRQROUOjJo0IWNvnkFEsWJHMsWXxH289nd5Qv7Cgljb4Yiz3I2lBKo8vdDZHJhasR++kgqJBn7ifLcxAKppUag9EChKNQzaUpLP472hbGoYYD0KPUR18xO25w8qHUYnKhOIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000282; c=relaxed/simple;
	bh=4W0/ux5EhNgOnsFPnNp1J2/rUjYoy2NJ0USEfInHEWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLwr27VZxeI46HcHHaMXNTFZ3bL4cQKaqZ6ZfZbENKXOSBtNFoCHOBHe0+V9baptg7VU59yRnpfxXKilx/4ZReYXfa/g81MEWbezAWyXGan2Uz2PNHUhunOIlaCm9DYBrLFfmVfjNHjFEB/L5biCvAEVx8LHgix2MPPChmAgSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y5uWwxgC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txGhQuO8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUFxaeOa8MxkhoOaa265B/ccj1bobA8YN971cVAYoCE=;
	b=Y5uWwxgCwKEcrzJAENfdOv9giYLmvYx0m8BkwnRw3rjkGWNDqwO1mi2jZBcU076us9cfpe
	NlIJ+nVEMz8yi0rHBd2d+N1S4xFgN9job+iswQJ+t+uhFMk8qoKYgI0iSixGv80eQRpXZJ
	T36BOlunSnevhikVuciu604kS6m0N/R5WbRALLYbB5QZOKmvkFiWAkJh7ziL6RjXpn1LI0
	NPQ9hz2VV6MqBqjoTxM8BFjYhcUmtPMQBsqvXjWlP8lFjQvInRUewL3iTuYV8Nn0z8aVSp
	FH8tcof86vHWIUGIYK9ADtOe7Q/94P1alvifw6OqsiOaWgUFrp7XuzLhxC0M7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUFxaeOa8MxkhoOaa265B/ccj1bobA8YN971cVAYoCE=;
	b=txGhQuO8g6BysurNHcVyDXbTp4j02hmRD4DuL7Zh74mFtq1/JxyrjKsLn/OMUI10Pa7IKC
	QoVL79GgITZAauCg==
Date: Mon, 03 Mar 2025 12:11:18 +0100
Subject: [PATCH 16/19] arm64/vdso: Prepare introduction of struct
 vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-16-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=1512;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=L7kK/MCZMD7r1X/TTNdxBJdzqOQW5bJywl2DJquziWk=;
 b=fJgzjZCc5WkxvrFlLjxD+BfXszci8Y3cDqbkKCkbvF2kHXyYJjhzAfWZAte2yMP84uv4/uX+e
 gS1QU3HJXulDpcBrLb18rkXvBchGsQOAZLb+5338gjRvJQush6GNM2G
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Nam Cao <namcao@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 957ee12fcc54bd7f978fbcd8945bce62327b037a..2c6b90d26bc8fd6d4be87bf6a4178472581f56d3 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -155,9 +155,9 @@ static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(
 }
 #define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
 
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
+	return vc->clock_mode == VDSO_CLOCKMODE_ARCHTIMER;
 }
 #define vdso_clocksource_ok	vdso_clocksource_ok
 

-- 
2.48.1


