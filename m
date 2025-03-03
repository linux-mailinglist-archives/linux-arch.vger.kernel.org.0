Return-Path: <linux-arch+bounces-10501-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA68A4BE3A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685B83BF01C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846621FCCED;
	Mon,  3 Mar 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rsLn/M4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+G7CPOXa"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DB1F8731;
	Mon,  3 Mar 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000280; cv=none; b=QxsxybRJok3YT9AF6VtrJNfCw5zOxXp7bXFOdXoHwkaa7snvKzEMl/Y+F2tKDctfVGPLqE3ifomBBrexc+RJoPrfeSX+ta2t/UP1ut++h2m1UnBOchREN8FP6uKETfEWOnNGqae7Wlc4tRmWvp57lVV8NR+9A7HNpazypLBJaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000280; c=relaxed/simple;
	bh=ieC8TpGukcgCKuzoAP3LV+lI6B2aMnM2hsyCYN2YmSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlNt9BYSpwcNpuKxl0U9qXMnS1Qo4ogNa9aER6f0mf0d2TYz+5v9okymGVvDKEkN7mFkOQ9PrmxO8SJip122ts0FxQ8W902tgvC6INQFgtgLGVDNP2fTbqS73GkTB5y1qEGEvHAilLOYGdYzFsF0Y0CCWJnorDpMhGi6EwK7fBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rsLn/M4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+G7CPOXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfUaF9ZM/sDC2742hKCsP1ynzqPjDFo3SoemEN7MXiw=;
	b=rsLn/M4m3C8C47//EcdlpS0gXuo2S8wQBjDlujUkeS/RnT2e7kEu1ZpPQLBhJPnl5F5Dmx
	Bnz9W6RvqO+XSj3gXinEcZXHTpjXZbuevhvVGl0N2jdGn/+Tig4flR6nR/JGTxB9/cyvYn
	eP2uKi7alGTLQIjYf+iG6izSyMtWFfHgpfTidXcTJL+QBX26d7SIb2ZkMVVy9cVLS/75qJ
	SSHpkxYM79/XNYhRRZbdx8weq1qxLRdEz+P/dzOcM918QM7Xn6IxyB1uOJQv4tBq0chmKS
	Z4cp3An4kPROpJxzqRvLsLIFdgmSIZomtmy7D4kFiX784zgsUt/5hgwfGEmaqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfUaF9ZM/sDC2742hKCsP1ynzqPjDFo3SoemEN7MXiw=;
	b=+G7CPOXa/ZWNxu6fthMtPvHWjD/eNSSKNL+q0WW80iJGWJhuVfvM0Ibxa4KTEM0uLK5NDu
	Ntj+12tjKCTbUGCQ==
Date: Mon, 03 Mar 2025 12:11:15 +0100
Subject: [PATCH 13/19] vdso/namespace: Rename timens_setup_vdso_data() to
 reflect new vdso_clock struct
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-13-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=2585;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=deY68vPxYVkoFnSlPdJ3pbtph7Y53gSWK99Jd8i7ioE=;
 b=qUFMIhhMLCqTE6c0fsVZpLM2srZkxcqqjDXZ3u3EzqbyA9lpIiErtiIS89RMGeKHwKrCWS4y9
 zvNwoxlkRFFDJzuFefrTwdqSIzx82VtsLrum1h7uvLyVZbiQfvPmRLS
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it.

For time namespace, vdso_time_data needs to be set up. But this is only the
clock related part of the vdso_data thats requires this setup. To reflect
the future struct vdso_clock, rename timens_setup_vdso_data() to
timns_setup_vdso_clock_data().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/namespace.c | 6 +++---
 lib/vdso/datastore.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 12f55aa539adbc11cce4055f519dbeca8a73320c..f02430a73be8f081618792c8968bf0c112c54505 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -176,8 +176,8 @@ static struct timens_offset offset_from_ts(struct timespec64 off)
  * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_data(struct vdso_time_data *vdata,
-				   struct time_namespace *ns)
+static void timens_setup_vdso_clock_data(struct vdso_time_data *vdata,
+					 struct time_namespace *ns)
 {
 	struct timens_offset *offset = vdata->offset;
 	struct timens_offset monotonic = offset_from_ts(ns->offsets.monotonic);
@@ -238,7 +238,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 	vdata = page_address(ns->vvar_page);
 
 	for (i = 0; i < CS_BASES; i++)
-		timens_setup_vdso_data(&vdata[i], ns);
+		timens_setup_vdso_clock_data(&vdata[i], ns);
 
 out:
 	mutex_unlock(&offset_lock);
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index e227fbbcb79694f9a40606ac864f52cf1fdbfcf4..4e350f56ace335b7ebca8af7663b5731fae27334 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -109,7 +109,7 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
  * page tables are cleared and then they will be re-faulted with a
  * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
+ * See also the comment near timens_setup_vdso_clock_data() for details.
  */
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {

-- 
2.48.1


