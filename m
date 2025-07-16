Return-Path: <linux-arch+bounces-12815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BD9B076CE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A97D1AA1731
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472911A5BA2;
	Wed, 16 Jul 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDYmdz3x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbbGSXV0"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0135972;
	Wed, 16 Jul 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672208; cv=none; b=dHwbUqOE8QOtQS9ZalwaGL2CS/0zngp1YcjKEESZ/mBrbFclaVPJlr3EGazdrULe8DJ2bdm3MusntjiIiktOcpmICjQXNiWjAfLpo/zmtPv8d80eyqXa2MkCD8AZI8q0Vd8kYBYBOG8YnBP2wj2PJ2oZ+pWU32MWvFchbyvX47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672208; c=relaxed/simple;
	bh=agoDhpTHHL7HDDO0SSBqzE+Bq/vsN2KR3cVVfaEDCP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nARnZCh9LIVEmakgoFgG1asWkRQw9qf4ZKCuybFRbtBZxel8N/qKMrBetxH+NXsiKODyfcE8S4P5O0IrZt+Lbx4IBcFTnxAjc/IGmKaDeEr6fJpO0MM+bzdaHMExhYHPOdR3D+QC6dNN3CYKbgVp7WsqyG+3K5kJukvlto4LpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDYmdz3x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbbGSXV0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 15:23:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752672204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X1gOZP+goNDIuh3AgJjOXNlqikB6fvLUSRY30PSEnM=;
	b=uDYmdz3xJBu77jfXv2NJHZokL7soAtCFcstMwIVdJwh/xQGph1nuhSs9J1nU2fiOMN8zMf
	esXWDddlzCNlG7bkDdzVNT+IGO7xEDiQcgnwJqBIvUKr0izZslxzFhxv3Sv/JCjVLB9gG9
	vzcPEfXqWmh9Ra6fGMdAKjpxjZ6AZ1S4yeJUnAJCWGzvZu8qrHCp4CIWI+hyGHsinFmqms
	CUBFukY0V6dKPaP3oRN/G1cZDzlfJUhHw7mVkd0FWXrCKQXFHCxBcegpaCpDi67DsQdeMK
	lxq1G5AOKdpa6HUtMhdpWSxIndSLR2RGTYM2fqWRWf2y8TjPFw9yzWSzMqT0OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752672204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X1gOZP+goNDIuh3AgJjOXNlqikB6fvLUSRY30PSEnM=;
	b=JbbGSXV0n1YRvysHljC1CPzDU5AjFc60+H3pSSxq0PzWMJughRLCOcj+nWQAFJyAHP/ymb
	ByWtOGBZkMUCEMDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <20250716152041-189100b1-7f5e-4388-8ada-b79ec09d18f5@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
 <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
 <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
 <3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>

On Wed, Jul 16, 2025 at 01:50:22PM +0100, Mark Brown wrote:
> On Wed, Jul 16, 2025 at 02:34:52PM +0200, Thomas Weißschuh wrote:
> > On Wed, Jul 16, 2025 at 01:25:06PM +0100, Mark Brown wrote:
> 
> > > This issue has been present in -next for a week and is causing a bunch
> > > of disruption to tests that end up relying on the vDSO - do we have any
> > > news on getting a fix merged?  Perhaps it makes sense for Marek to just
> > > send his patch so that it's there if needed?
> 
> > That fix has been in -next since next-20250710.
> > If you still have issues, I'll take a look.
> 
> Ah, sorry - I'd not seen followup mails in the thread and was still
> seeing issues that appeared at the same time that had previously
> bisected here.  One is:
> 
> | INFO: Generating a skipfile based on /lava-4170058/1/tests/6_kselftest-dev-errlogs/automated/linux/kselftest/skipfile-lkft.yaml
> | fatal error: nanotime returning zero
> | goroutine 1 [running, locked to thread]:
> | runtime.throw(0x132d83, 0x17)
> | 	/usr/lib/golang/src/runtime/panic.go:774 +0x5c fp=0x42c7a4 sp=0x42c790 pc=0x3b740
> | runtime.main()
> | 	/usr/lib/golang/src/runtime/proc.go:152 +0x350 fp=0x42c7e4 sp=0x42c7a4 pc=0x3d308
> |A runtime.goexit()
> | 	/usr/lib/golang/src/runtime/asm_arm.s:868 +0x4 fp=0x42c7e4 sp=0x42c7e4 pc=0x645dc
> | ERROR: skipgen failed to generate a skipfile: 2
> 
> I'll just kick of a clean bisect for that and see what it comes up with.

Can you try the following?
I missed this despite the double-checking after the last reported issue.

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 97aa9059a5c9..5e0106130e07 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -365,14 +365,14 @@ __cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t clock,
                             struct old_timespec32 *res)
 {
        struct __kernel_timespec ts;
-       int ret;
+       bool ok;
 
-       ret = __cvdso_clock_gettime_common(vd, clock, &ts);
+       ok = __cvdso_clock_gettime_common(vd, clock, &ts);
 
-       if (unlikely(ret))
+       if (unlikely(!ok))
                return clock_gettime32_fallback(clock, res);
 
-       /* For ret == 0 */
+       /* For ok == true */
        res->tv_sec = ts.tv_sec;
        res->tv_nsec = ts.tv_nsec;


Sorry for all the breakage.


Thomas

