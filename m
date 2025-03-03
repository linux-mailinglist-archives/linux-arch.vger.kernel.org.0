Return-Path: <linux-arch+bounces-10500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F6FA4BDD7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9414B7A6C73
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C31FC7CA;
	Mon,  3 Mar 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LmV6BZNb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cidttnyv"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29271F890D;
	Mon,  3 Mar 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000279; cv=none; b=EvLRm9TXspxvpbf0HImN/ARnjj12VBE9Z2NWIh/An2r4nUfR41PublhZAhINNn6fLktc27gcTYyt/cT2g+s7OVc9OY4xjm2L+NkVarWxUsGsZnHMwWENk97FoB2HYg5sXUMVBL8JivUv5ubE0ezorDT0twYgsmKGRZRX1cqCxU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000279; c=relaxed/simple;
	bh=iLtBxq9WJD86hsFQmJqw4knCT6b82vWHXs3qixc55Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMBpq5OKJjlqYFQ0oNGEhiAq1xAlKIQR99mrYjWEYEX+1hiZa1hJA46Lp25GYhbZSM/4mz9Pg9G9g0S/tElVQj92WFstHqTleirA0jw48zV/eaiTQgDms/keCd77BUkJkpFSVQsS9d/IuTpu4KJDV8GsDin8h1/l6v8ZOvAfbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LmV6BZNb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cidttnyv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XReqk4Aen4MK7eX+VauyjHHk/TSJRy2pW2Es7/MoImA=;
	b=LmV6BZNbIbXd82Wfm/N0Wga1F48N9yW7wFH/MNP3apM4AwlfaJ7UUHoH2G4jLcqgfirUrZ
	bMP3czVab7xcpYSGXAX1FZ4kPenS3TNCt1QPC1+/65AjmrupUTH2OkrYPIkTvMJ4RM2SSB
	aG0aNqkFKEeAthWGMNFfp6c7yY+Rc5JhcNDkJHE/eZ4CbsNp5XLEkoTvG7IdD8+h+VJDbc
	BQEJ6RY3Sgdsk8Tl1u242U/4fhoyOVyyrQu0swEnzDkSNQ6xj9/6AYQdkbStOA9gup6WlA
	PVQh/RK/KrAdDcgCtKpxNlo2yFx2L7e37BmhphP0xIh5qB8jobwZWf/dOkGROQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XReqk4Aen4MK7eX+VauyjHHk/TSJRy2pW2Es7/MoImA=;
	b=cidttnyvEBhkcKoxcdejbdB8UW6sNnz6bQlRh0g3VIer+5ywzsJPGAUmJBCSkVPa5eIktN
	EbTm/ptslRomsQAQ==
Date: Mon, 03 Mar 2025 12:11:16 +0100
Subject: [PATCH 14/19] time/namespace: Prepare introduction of struct
 vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-14-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=3143;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rvrB9ifBvRXgxwLjfAy8fiQwFAt4ofAQmLlLCatQ/ko=;
 b=00VGODDgq5LMqN9LKjPqKVX6bcYBv+gb9Z2V8XxONuiiNC44yja15un2b1lmnwgWBadX1tPE6
 zsfhL+2AmkJCVPhjZEGt7SQCB6rqlcljig5snI8lxOHkljl8bO6qj8y
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/namespace.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index f02430a73be8f081618792c8968bf0c112c54505..09bc4fb39f24ccdaa1e6e7f7238660a4f2a63b54 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -165,26 +165,26 @@ static struct timens_offset offset_from_ts(struct timespec64 off)
  *     HVCLOCK
  *     VVAR
  *
- * The check for vdso_time_data->clock_mode is in the unlikely path of
+ * The check for vdso_clock->clock_mode is in the unlikely path of
  * the seq begin magic. So for the non-timens case most of the time
  * 'seq' is even, so the branch is not taken.
  *
  * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
- * for vdso_time_data->clock_mode is a non-issue. The task is spin waiting for the
+ * for vdso_clock->clock_mode is a non-issue. The task is spin waiting for the
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
+ * Timens page has vdso_clock->clock_mode set to VDSO_CLOCKMODE_TIMENS which
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_clock_data(struct vdso_time_data *vdata,
+static void timens_setup_vdso_clock_data(struct vdso_clock *vc,
 					 struct time_namespace *ns)
 {
-	struct timens_offset *offset = vdata->offset;
+	struct timens_offset *offset = vc->offset;
 	struct timens_offset monotonic = offset_from_ts(ns->offsets.monotonic);
 	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
 
-	vdata->seq			= 1;
-	vdata->clock_mode		= VDSO_CLOCKMODE_TIMENS;
+	vc->seq				= 1;
+	vc->clock_mode			= VDSO_CLOCKMODE_TIMENS;
 	offset[CLOCK_MONOTONIC]		= monotonic;
 	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
 	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
@@ -220,6 +220,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 				struct time_namespace *ns)
 {
 	struct vdso_time_data *vdata;
+	struct vdso_clock *vc;
 	unsigned int i;
 
 	if (ns == &init_time_ns)
@@ -236,9 +237,10 @@ static void timens_set_vvar_page(struct task_struct *task,
 
 	ns->frozen_offsets = true;
 	vdata = page_address(ns->vvar_page);
+	vc = vdata;
 
 	for (i = 0; i < CS_BASES; i++)
-		timens_setup_vdso_clock_data(&vdata[i], ns);
+		timens_setup_vdso_clock_data(&vc[i], ns);
 
 out:
 	mutex_unlock(&offset_lock);

-- 
2.48.1


