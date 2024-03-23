Return-Path: <linux-arch+bounces-3122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684788762F
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 01:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37456283BEF
	for <lists+linux-arch@lfdr.de>; Sat, 23 Mar 2024 00:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E43624;
	Sat, 23 Mar 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yo0uXR0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iamDQ0ls"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACFA31;
	Sat, 23 Mar 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154341; cv=none; b=Cor+EgELBLicvmugWlIgKezgpFRSh3xZJp2ul6oW+ohOEReJ24+Rb9kRaP9K8dt6fl/UyFWgXcdCZjkSwjVfKrveXaAZBc0ovl8v0NALrz26kedlcdBdo+zdDDoADwv+erm95wUAbdNrEw1wXafCGUncrZ8q5yiVncU9Io4XZDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154341; c=relaxed/simple;
	bh=HsiiukLv2OkAGJuGPGPieR0cIfyxDskRqJKokaI1nkA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=pVPdzM5MBmYGvEnw3vo9g+FferIDRo7BDMfuqTyLvrdWhaKURaBm3olgkPO9JjjPAii2xDPHFQeyya1n4taQOVF8Bkxu1nh8RQweS5MUQVce+Q0Q78VxhS/zmd0MYq2XBG94uwOgX0HN3VAAj8Ja87gzQESCho5P/Fjbvbj5r4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yo0uXR0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iamDQ0ls; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711154336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=QTNbwfGTpTBba+tM3K9/nZKlcmM6zTOdSn+n6EoRLfg=;
	b=Yo0uXR0FHsMP5dcnW15HcNd257Z0hyVeM/UUuHCzQqrd1271JHELJRo7bUdIiGGLIXXTSo
	LePbFr04lw2NucljFdk4akmgc5iedsYq6MTs0Gwu4w2zRpgb/6TytvbzoyGJ2jGxYURlzv
	4PvEi8EAoe59yzjnlPuMY8oXRPdde5WfxcJ9cRf10+E8aIPdZDJZcrxKRLCXLdbOGU7lgA
	0ORxODoBmk5SRk++jhcYYfV31QgWZtgb1kcppbwfPH+Jza8FDaGozWG8xY95zvZtA6PamB
	eEIAI3lx47ftZnOK2d4qBhfJ0nbzZz1X9vLBiJ/Iv2klTsbQ1lveeCMF2hlJRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711154336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=QTNbwfGTpTBba+tM3K9/nZKlcmM6zTOdSn+n6EoRLfg=;
	b=iamDQ0ls1b7d7WTxkvvrOgmDEr/D7rQ6kKcT5VbaH+6m4xmuG8G10qm+uxWxFN657Da6DM
	eikF6he1BEszfQBA==
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: richardcochran@gmail.com, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org,
 hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com,
 nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org,
 legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com,
 casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net,
 brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
In-Reply-To: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
Date: Sat, 23 Mar 2024 01:38:55 +0100
Message-ID: <878r29hjds.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sagi!

On Wed, Mar 20 2024 at 16:42, Sagi Maimon wrote:
> On Thu, Mar 14, 2024 at 8:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> Which is maximaly precise under the assumption that in the time between
>> the sample points a1 and a2 neither the system clock nor the PCH clocks
>> are changing their frequency significantly. That is a valid assumption
>> when you put a reasonable upper bound on d2.
>>
>
> You are right.
> In fact, we are running this calculation on a user space application.
> We use the new system call to get pairs of mono and PHC and then run
> that calculation in user space.
> That is why the system call returns pairs of clock samples and not the
> diff between them.

Please stop claiming things which are fundamentally wrong:

  The proposed system call returns the PHC sample and the midpoint of
  two CLOCK_WHATEVER samples which have been sampled before and after
  the PHC sample.

  That is fundamentally different from a pair of samples as I explained
  to you in great length more than once by now.

I understand that you can't rely on the PTP_SYS_OFFSET_PRECISE IOCTL
alone because there is not much hardware support, but what you are
proposing is way worse than the other two PTP_SYS_OFFSET variants.

PTP_SYS_OFFSET at least gives the caller a choice of analysis of the
interleaving system timestamps.

PTP_SYS_OFFSET_EXTENDED moves the outer sample points as close as
possible to the actual PCH read and provides both outer samples to user
space for analysis. It was introduced for a reason, no?

Your proposed system call is just declaring arbitrarily that the
CLOCK_WHATEVER sample is exactly the midpoint of the two outer samples
and is therefore superior and correct.

It is neither superior nor correct because the midpoint is an
ill-defined assumption as I explained to you multiple times now.

Aside of that the approach loses the extended information of
PTP_SYS_OFFSET and PTP_SYS_OFFSET_EXTENDED including the more precise
sampling behaviour of the latter. IOW, it is ignoring and throwing away
the effort of people who cared about making the best out of the
limitations of hardware including the already existing algorithms to
make sense out of it.

The P at the beginning of PTP does not mean 'Potentially precise' and
the lack of C in PTP does not mean that Correctness is overrated.

The problem is that these non hardware assisted IOCTL variants sample
only CLOCK_REALTIME and not CLOCK_MONOTONIC_RAW, which is all you need
to solve your problem at hand, no?

That's absolutely not rocket science to solve. The below sketch does
exactly that without creating an ill-defined syscall monstrosity, at the
same time it is fully preserving the benefits of the existing IOCTL
variants and therefore allows to apply already existing algorithms to
analyse that data. That's too simple and too obviously correct, right?

The thing is a sketch and it's neither compiled nor tested. It's just
for illustration and you can keep all bugs you might find in it.

On top this needs an analyis whether any of the gettimex64()
implementations does something special instead of invoking the
ptp_read_system_prets() and ptp_read_system_postts() helpers as close as
possible to the PCH readout, but that's not rocket science either. It's
just 21 callbacks to look at.

It might also require a new set of variant '3' IOTCLS to make that flag
field work, but that's not going to make the change more complex and
it's an exercise left to the experts of that IOCTL interface.

Thanks,

        tglx
---
 drivers/ptp/ptp_chardev.c        |   36 ++++++++++++++++++++++------------=
--
 include/linux/ptp_clock_kernel.h |   28 +++++++++++++++++++---------
 include/uapi/linux/ptp_clock.h   |   10 ++++++++--
 3 files changed, 49 insertions(+), 25 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -164,9 +164,9 @@ long ptp_ioctl(struct posix_clock_contex
 	struct ptp_sys_offset_precise precise_offset;
 	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops =3D ptp->info;
+	struct ptp_system_timestamp sts =3D { };
 	struct ptp_sys_offset *sysoff =3D NULL;
 	struct timestamp_event_queue *tsevq;
-	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
 	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
@@ -358,11 +358,13 @@ long ptp_ioctl(struct posix_clock_contex
 			extoff =3D NULL;
 			break;
 		}
-		if (extoff->n_samples > PTP_MAX_SAMPLES
-		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
+		if (!extoff->n_samples || extoff->n_samples > PTP_MAX_SAMPLES ||
+		    (extoff->flags & ~PTP_SYS_OFFSET_VALID_FLAGS) ||
+		    extoff->rsv[0] || extoff->rsv[1]) {
 			err =3D -EINVAL;
 			break;
 		}
+		sts.flags =3D extoff->flags;
 		for (i =3D 0; i < extoff->n_samples; i++) {
 			err =3D ptp->info->gettimex64(ptp->info, &ts, &sts);
 			if (err)
@@ -386,29 +388,35 @@ long ptp_ioctl(struct posix_clock_contex
 			sysoff =3D NULL;
 			break;
 		}
-		if (sysoff->n_samples > PTP_MAX_SAMPLES) {
+		if (!sysoff->n_samples || sysoff->n_samples > PTP_MAX_SAMPLES ||
+		    (sysoff->flags & ~PTP_SYS_OFFSET_VALID_FLAGS) ||
+		    sysoff->rsv[0] || sysoff->rsv[1]) {
 			err =3D -EINVAL;
 			break;
 		}
+		sts.flags =3D sysoff->flags;
 		pct =3D &sysoff->ts[0];
 		for (i =3D 0; i < sysoff->n_samples; i++) {
-			ktime_get_real_ts64(&ts);
-			pct->sec =3D ts.tv_sec;
-			pct->nsec =3D ts.tv_nsec;
-			pct++;
-			if (ops->gettimex64)
-				err =3D ops->gettimex64(ops, &ts, NULL);
-			else
+			if (ops->gettimex64) {
+				err =3D ops->gettimex64(ops, &ts, &sts);
+			} else {
+				ptp_read_system_prets(&sts);
 				err =3D ops->gettime64(ops, &ts);
+			}
 			if (err)
 				goto out;
+
+			pct->sec =3D sts.pre_ts.tv_sec;
+			pct->nsec =3D sts.pre_ts.tv_nsec;
+			pct++;
 			pct->sec =3D ts.tv_sec;
 			pct->nsec =3D ts.tv_nsec;
 			pct++;
 		}
-		ktime_get_real_ts64(&ts);
-		pct->sec =3D ts.tv_sec;
-		pct->nsec =3D ts.tv_nsec;
+		if (!ops->gettimex64)
+			ptp_read_system_postts(&sts);
+		pct->sec =3D sts.post_ts.tv_sec;
+		pct->nsec =3D sts.post_ts.tv_nsec;
 		if (copy_to_user((void __user *)arg, sysoff, sizeof(*sysoff)))
 			err =3D -EFAULT;
 		break;
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -44,13 +44,15 @@ struct ptp_clock_request {
 struct system_device_crosststamp;
=20
 /**
- * struct ptp_system_timestamp - system time corresponding to a PHC timest=
amp
- * @pre_ts: system timestamp before capturing PHC
- * @post_ts: system timestamp after capturing PHC
+ * struct ptp_system_timestamp - System time corresponding to a PHC timest=
amp
+ * @flags:	Flags to select the system clock to sample
+ * @pre_ts:	System timestamp before capturing PHC
+ * @post_ts:	System timestamp after capturing PHC
  */
 struct ptp_system_timestamp {
-	struct timespec64 pre_ts;
-	struct timespec64 post_ts;
+	unsigned int		flags;
+	struct timespec64	pre_ts;
+	struct timespec64	post_ts;
 };
=20
 /**
@@ -457,14 +459,22 @@ static inline ktime_t ptp_convert_timest
=20
 static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->pre_ts);
+	if (sts) {
+		if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
+			ktime_get_raw_ts64(&sts->pre_ts);
+		else
+			ktime_get_real_ts64(&sts->pre_ts);
+	}
 }
=20
 static inline void ptp_read_system_postts(struct ptp_system_timestamp *sts)
 {
-	if (sts)
-		ktime_get_real_ts64(&sts->post_ts);
+	if (sts) {
+		if (sts->flags & PTP_SYS_OFFSET_MONO_RAW)
+			ktime_get_raw_ts64(&sts->post_ts);
+		else
+			ktime_get_real_ts64(&sts->post_ts);
+	}
 }
=20
 #endif
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -76,6 +76,10 @@
  */
 #define PTP_PEROUT_V1_VALID_FLAGS	(0)
=20
+/* Bits for PTP_SYS_OFFSET and PTP_SYS_OFFSET_EXTENDED */
+#define PTP_SYS_OFFSET_MONO_RAW		(1U << 0)
+#define PTP_SYS_OFFSET_VALID_FLAGS	(PTP_SYS_OFFSET_MONO_RAW)
+
 /*
  * struct ptp_clock_time - represents a time value
  *
@@ -146,7 +150,8 @@ struct ptp_perout_request {
=20
 struct ptp_sys_offset {
 	unsigned int n_samples; /* Desired number of measurements. */
-	unsigned int rsv[3];    /* Reserved for future use. */
+	unsigned int flags;
+	unsigned int rsv[2];    /* Reserved for future use. */
 	/*
 	 * Array of interleaved system/phc time stamps. The kernel
 	 * will provide 2*n_samples + 1 time stamps, with the last
@@ -157,7 +162,8 @@ struct ptp_sys_offset {
=20
 struct ptp_sys_offset_extended {
 	unsigned int n_samples; /* Desired number of measurements. */
-	unsigned int rsv[3];    /* Reserved for future use. */
+	unsigned int flags;
+	unsigned int rsv[2];    /* Reserved for future use. */
 	/*
 	 * Array of [system, phc, system] time stamps. The kernel will provide
 	 * 3*n_samples time stamps.

