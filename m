Return-Path: <linux-arch+bounces-6266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E38954C82
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1FADB232B7
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 14:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C069B1BD4F7;
	Fri, 16 Aug 2024 14:37:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF631A7074;
	Fri, 16 Aug 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819043; cv=none; b=TbdJBHRnv6QcM8R+fLOFfucN/HMcxBaQZfMMGBOHtHxEqscpFvBBE731JBW/hAd/dXN6YMxxDHZ6qUIz+JodolpIiWvYhqMygOBYZhT3Lw2LHAUi7ngEOH0FUB8UsvmK9sFdIZQ+3pvqu8kJuylLwa8Rb+oHIKRS9NSyAi3hyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819043; c=relaxed/simple;
	bh=raZtB3D/FN8lwMI2ox/iRuvaT/4s6XJ1Ie7o2wYJiiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stm7nR0sbeCMtkptV7oPCx4zRsSD+XS4d+wqQ5Lb1uwBVOzo+0YYb4Hz41v2OMkpZnbG51NlqmkSJoBpLhZpUJGcogq0OvmabrE1t7ruIY3TWzTNYjlD4XM5rVafDUqg4+8PB/ummxaDYUKaOpSh+3Z1MCtDh49sER0bet7s6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wll1l1KyGz9sSH;
	Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D4x0hs1ixq-x; Fri, 16 Aug 2024 16:36:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wll1k4Jmfz9rvV;
	Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 802828B775;
	Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Zxbdy1l84p6x; Fri, 16 Aug 2024 16:36:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.147])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BBDF78B764;
	Fri, 16 Aug 2024 16:36:57 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 4/9] vdso: Add missing c-getrandom-y in Makefile
Date: Fri, 16 Aug 2024 16:36:51 +0200
Message-ID: <5859ac80d54c8cb7c46f81ad6f1fd253e5a5f5b1.1723817900.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1723817900.git.christophe.leroy@csgroup.eu>
References: <cover.1723817900.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723819011; l=917; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=raZtB3D/FN8lwMI2ox/iRuvaT/4s6XJ1Ie7o2wYJiiw=; b=teOiR430IbKYisIa9qeJvQUA3zExcPi5TaGUSUlPI3tZM8NfXjKiPKFM6557JJnVQNguoXKmA MqMTkii+U8yBGBW/clM//qpOMAt6i4N0tKDHC2k4jsh7jpA9/5THFVQ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Same as for gettimeofday CVDSO implementation, add c-getrandom-y
to ease the including of lib/vdso/getrandom.c in architectures
VDSO builds.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/vdso/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index 9f031eafc465..cedbf15f8087 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -4,6 +4,7 @@ GENERIC_VDSO_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
 GENERIC_VDSO_DIR := $(dir $(GENERIC_VDSO_MK_PATH))
 
 c-gettimeofday-$(CONFIG_GENERIC_GETTIMEOFDAY) := $(addprefix $(GENERIC_VDSO_DIR), gettimeofday.c)
+c-getrandom-$(CONFIG_VDSO_GETRANDOM) := $(addprefix $(GENERIC_VDSO_DIR), getrandom.c)
 
 # This cmd checks that the vdso library does not contain dynamic relocations.
 # It has to be called after the linking of the vdso library and requires it
-- 
2.44.0


