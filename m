Return-Path: <linux-arch+bounces-10515-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3828A4E511
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C241174A1E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Mar 2025 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF26293B76;
	Tue,  4 Mar 2025 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wFvv4Ag4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fitYPwWQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84E293B66
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103075; cv=fail; b=mO94Qvde3oGm5VL3nb6zpnHUsRtwdCS/hqmNAz3Kf1m45pFR7aP4UBLVvKH6Kgv2Xx39Cmh8x2smj2GG/nhwGlvQ51AKILPKbzC6TrHBxHq4D0ccdSdHaFRnspxKfpCb3uSrocuJ3x9EDO3YZ6e73U7cLRMLGGT73mTBF/2aKJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103075; c=relaxed/simple;
	bh=9vfPDuUWyF0UpqfujhtOOMVScvAuZP5a1Kj67thp/bM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r04Yqj390V69XiE/4HcCMM1IttRTSIiqBfwPJgEwQLyFzKPlemGyzlRVJLeMJM1WMuj/UFEtojQUeRVCEMD73WALsc4wCWg2Pn5b3/7Rzb9ikhQn5772teIizteEqX1BNCa+AcJV+u8NgKm8aF0hJWpmVXw/PlYeg2Hs1snqGdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFvv4Ag4 reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fitYPwWQ; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id B8D1F40CECA2
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 18:44:31 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g192g4kzG12T
	for <linux-arch@vger.kernel.org>; Tue,  4 Mar 2025 18:42:37 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B427D42733; Tue,  4 Mar 2025 18:42:24 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFvv4Ag4;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fitYPwWQ
X-Envelope-From: <linux-kernel+bounces-541544-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFvv4Ag4;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fitYPwWQ
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8B53542C54
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:21:03 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 23501305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:21:03 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC5C173F19
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DCF1F4CA6;
	Mon,  3 Mar 2025 11:11:29 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E171FCD11;
	Mon,  3 Mar 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000283; cv=none; b=fbwNBOekBvLosWS/mO9mTPNGSvFvbyFrRD0emdspnZKQupIQ8qBeHCkurlAWWdZ7EwhFmHqOjrkBjKOZzUTaGA3DcwYurKMMvsgqfPUHJMr65lz3de3ZgGff8R6puZGHcm+x+20slrL77F7DOHoV8Go75XFuRnCb8DXtGLY8hNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000283; c=relaxed/simple;
	bh=QFq4OIMPBYSaK2rFfwMqVmi9MSmmT1bNGmjvjGfAIis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D28M5HSnelOXdgVbohWALWdVgxEugrs7EWGH16CbRDJMCYYL4VLrqtq9/sngDpqI1UkeWghfR7VUEF9LkzIO9c2hSb9r+U1gum+kAx885vMbtRQH1Kue9KYfkrw4AazxwdO2ihtgRzv3HsfXEYub1/TW4RWbo4yaOHl7BGu1928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wFvv4Ag4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fitYPwWQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJj8fwvatyV+5ADmR5rVOToqW07azOqBXXpZjQdxBB0=;
	b=wFvv4Ag4+H8jyw8wPuoKaMJqUL/bC2HbQbI75SlyDtpJ8cEbHaPt7AviQSjahNrDWLXTGp
	OJqbX2w1RiStVP/WBwbkpcPmXBEE5okJ/zlMwfunIqR/1GmkTmwBVq9Lz6mvQtl98/Pvcn
	DBDGEuKsrJBPVPpNdkzR2QHw8cYG4/L+T3NG6Ri5ZMAN7eXcGWSXImCY/PNxnE8USkcQQv
	0JcTGJfSDvCdkflG7hLobMg3xvyQKxCBxAXWgKB99iG6DVrrTMTLEx+58wIO1pt82cf/l7
	xpfcNmL1hLNlZ88TNxaX/FhgGIQmguQryELgB48VLHxcH55Dg7OQ67Q+cdffQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJj8fwvatyV+5ADmR5rVOToqW07azOqBXXpZjQdxBB0=;
	b=fitYPwWQ3NDiAelslcwLYSlGfHXIZfz+mXUz67FA2zuzaCc86LItD4BEaB7LtUr9Dx+yGZ
	sxkDGrj23op8xdDA==
Date: Mon, 03 Mar 2025 12:11:21 +0100
Subject: [PATCH 19/19] vdso: Rework struct vdso_time_data and introduce
 struct vdso_clock
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20250303-vdso-clock-v1-19-c1b5c69a166f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=14985;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k+M8SZe+gg1+GDPDPoUJ47yntRyXRUYqj8Nnp9aAUAs=;
 b=Ou/WjNvet+M42/kAgN+xA7u1f4EvtNrhjwVie0kO8d4feK2LczpSPLRMYESUGhVByYf1uwcVW
 FEI1S/mSWtUDJ7jWnKR29BTdTHfogU9m/S1gqSq5NgEsWrAq6QnefcH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g192g4kzG12T
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707815.16715@/d5xoYOqv+SM9FIm0lo2QA
X-ITU-MailScanner-SpamCheck: not spam

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be an array of it.

Now all preparation is in place: Split the clock related struct members
into a separate struct vdso_clock. Make sure all users are aware, that
vdso_time_data is no longer initialized as an array and vdso_clock is now
the array inside vdso_data. Remove also the define of vdso_clock which ma=
de
preparation possible in smaller steps.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  2 +-
 arch/arm64/include/asm/vdso/vsyscall.h            |  4 +-
 arch/s390/kernel/time.c                           | 11 ++----
 include/asm-generic/vdso/vsyscall.h               |  2 +-
 include/vdso/datapage.h                           | 47 ++++++++++++++---=
------
 include/vdso/helpers.h                            |  4 +-
 kernel/time/namespace.c                           |  2 +-
 kernel/time/vsyscall.c                            | 11 +++---
 lib/vdso/datastore.c                              |  4 +-
 lib/vdso/gettimeofday.c                           | 16 ++++----
 10 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm=
64/include/asm/vdso/compat_gettimeofday.h
index 2c6b90d26bc8fd6d4be87bf6a4178472581f56d3..d60ea7a72a9cb3457c412d0ec=
e21ed76ae77782d 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -149,7 +149,7 @@ static __always_inline const struct vdso_time_data *_=
_arch_get_vdso_u_time_data(
 	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
 	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(vdso_u_time_data));
+	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(&vdso_u_time_data));
=20
 	return ret;
 }
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/=
asm/vdso/vsyscall.h
index 3f65cbd00635aab50a4e0c6058d38b39fd6d43a9..de58951b8df6a4bb9afd41187=
8793c79c30adbf2 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -15,8 +15,8 @@
 static __always_inline
 void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
-	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
 }
 #define __arch_update_vsyscall __arm64_update_vsyscall
=20
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 41ca3586b19f6cac3753b52f0b99be62a33e1cb1..699a18f1c54eb7ec09f7f1cce=
ecd1118aed37ab2 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -79,12 +79,10 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
-	int cs;
=20
 	/* Initialize TOD steering parameters */
 	tod_steering_end =3D tod_clock_base.tod;
-	for (cs =3D 0; cs < CS_BASES; cs++)
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
=20
 	if (!test_facility(28))
 		return;
@@ -373,7 +371,6 @@ static void clock_sync_global(long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
-	int cs;
=20
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod +=3D delta;
@@ -389,10 +386,8 @@ static void clock_sync_global(long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end =3D now + (abs(tod_steering_delta) << 15);
-	for (cs =3D 0; cs < CS_BASES; cs++) {
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
-		vdso_k_time_data[cs].arch_data.tod_steering_delta =3D tod_steering_del=
ta;
-	}
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_delta =3D tod_steering_delta;
=20
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) =3D=3D 0)
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vd=
so/vsyscall.h
index 1fb3000f50364feeaaa9348d438b3ab8091bb265..b550afa15ecd101d821f51ce9=
105903978dced40 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -9,7 +9,7 @@
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_ti=
me_data(void)
 {
-	return vdso_u_time_data;
+	return &vdso_u_time_data;
 }
 #endif
=20
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index bcd19c223783be7c22f90120330e7dddd0496f1a..9e419394b32443c9e6af67afd=
9d97ef2b316d8be 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -69,9 +69,7 @@ struct vdso_timestamp {
 };
=20
 /**
- * struct vdso_time_data - vdso datapage representation
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
+ * struct vdso_clock - vdso per clocksource datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -81,17 +79,9 @@ struct vdso_timestamp {
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
  * @offset[clock_id]:	time namespace offset per clock_id
- * @tz_minuteswest:	minutes west of Greenwich
- * @tz_dsttime:		type of DST correction
- * @hrtimer_res:	hrtimer resolution
- * @__unused:		unused
- *
- * vdso_time_data will be accessed by 64 bit and compat code at the same=
 time
- * so we should be careful before modifying this structure.
  *
- * The ordering of the struct members is optimized to have fast access t=
o the
- * often required struct members which are related to CLOCK_REALTIME and
- * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ * See also struct vdso_time_data for basic access and ordering informat=
ion as
+ * struct vdso_clock is used there.
  *
  * @basetime is used to store the base time for the system wide time get=
ter
  * VVAR page.
@@ -104,9 +94,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_time_data {
-	struct arch_vdso_time_data arch_data;
-
+struct vdso_clock {
 	u32			seq;
=20
 	s32			clock_mode;
@@ -122,6 +110,29 @@ struct vdso_time_data {
 		struct vdso_timestamp	basetime[VDSO_BASES];
 		struct timens_offset	offset[VDSO_BASES];
 	};
+};
+
+/**
+ * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
+ * @clock_data:		clocksource related data (array)
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_time_data will be accessed by 64 bit and compat code at the same=
 time
+ * so we should be careful before modifying this structure.
+ *
+ * The ordering of the struct members is optimized to have fast acces to=
 the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ */
+struct vdso_time_data {
+	struct arch_vdso_time_data arch_data;
+
+	struct vdso_clock	clock_data[CS_BASES];
=20
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
@@ -129,8 +140,6 @@ struct vdso_time_data {
 	u32			__unused;
 } ____cacheline_aligned;
=20
-#define vdso_clock vdso_time_data
-
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -151,7 +160,7 @@ struct vdso_rng_data {
  * relocation, and this is what we need.
  */
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((v=
isibility("hidden")));
+extern struct vdso_time_data vdso_u_time_data __attribute__((visibility(=
"hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("h=
idden")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility(=
"hidden")));
=20
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 28f0707a46c62187ad7500543e169f5b99deee70..0a98fed550ba66a84a620fbbd=
6aee3e3029b4772 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -30,7 +30,7 @@ static __always_inline u32 vdso_read_retry(const struct=
 vdso_clock *vc,
=20
 static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
@@ -44,7 +44,7 @@ static __always_inline void vdso_write_begin(struct vds=
o_time_data *vd)
=20
 static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	smp_wmb();
 	/*
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 09bc4fb39f24ccdaa1e6e7f7238660a4f2a63b54..e3642278df433c41654ffb6a8=
043c3fcecc2994a 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -237,7 +237,7 @@ static void timens_set_vvar_page(struct task_struct *=
task,
=20
 	ns->frozen_offsets =3D true;
 	vdata =3D page_address(ns->vvar_page);
-	vc =3D vdata;
+	vc =3D vdata->clock_data;
=20
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_clock_data(&vc[i], ns);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index dd85b41a70bee7decbd943c35197c091916ee4c7..01c2ab1e897193e12be9b9817=
90147ad018e19f3 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -17,8 +17,8 @@
=20
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, s=
truct timekeeper *tk)
 {
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	u64 nsec, sec;
=20
 	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
@@ -78,8 +78,8 @@ static inline void update_vdso_time_data(struct vdso_ti=
me_data *vdata, struct ti
 void update_vsyscall(struct timekeeper *tk)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	s32 clock_mode;
 	u64 nsec;
=20
@@ -109,9 +109,8 @@ void update_vsyscall(struct timekeeper *tk)
=20
 	/*
 	 * Read without the seqlock held by clock_getres().
-	 * Note: No need to have a second copy.
 	 */
-	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+	WRITE_ONCE(vdata->hrtimer_res, hrtimer_resolution);
=20
 	/*
 	 * If the current clocksource is not VDSO capable, then spare the
@@ -131,8 +130,8 @@ void update_vsyscall_tz(void)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
-	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
-	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
+	vdata->tz_minuteswest =3D sys_tz.tz_minuteswest;
+	vdata->tz_dsttime =3D sys_tz.tz_dsttime;
=20
 	__arch_sync_vdso_time_data(vdata);
 }
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 4e350f56ace335b7ebca8af7663b5731fae27334..c715e217ec6576c34795ad767=
30faddf6b4c9f8b 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -13,10 +13,10 @@
  */
 #ifdef CONFIG_HAVE_GENERIC_VDSO
 static union {
-	struct vdso_time_data	data[CS_BASES];
+	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
-struct vdso_time_data *vdso_k_time_data =3D vdso_time_data_store.data;
+struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
=20
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c6ff6934558658f9e280d5b84cfb034f4828893d..93ef801a97ef25f66195490d1=
4e41bebcd41982b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,8 +87,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *v
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns)=
;
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
@@ -199,8 +199,8 @@ int do_coarse_timens(const struct vdso_time_data *vdn=
s, const struct vdso_clock
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns)=
;
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
@@ -265,7 +265,7 @@ static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t =
clock,
 			     struct __kernel_timespec *ts)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
 	/* Check for negative values or invalid clocks */
@@ -337,7 +337,7 @@ static __maybe_unused int
 __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
=20
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
@@ -371,13 +371,13 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *t=
v, struct timezone *tz)
 static __maybe_unused __kernel_old_time_t
 __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *=
time)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS) {
 		vd =3D __arch_get_vdso_u_timens_data(vd);
-		vc =3D vd;
+		vc =3D vd->clock_data;
 	}
=20
 	t =3D READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
@@ -399,7 +399,7 @@ static __maybe_unused
 int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid=
_t clock,
 				struct __kernel_timespec *res)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
 	u64 ns;
=20
@@ -420,7 +420,7 @@ int __cvdso_clock_getres_common(const struct vdso_tim=
e_data *vd, clockid_t clock
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
-		ns =3D READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+		ns =3D READ_ONCE(vd->hrtimer_res);
 	} else if (msk & VDSO_COARSE) {
 		/*
 		 * Preserves the behaviour of posix_get_coarse_res().

--=20
2.48.1



