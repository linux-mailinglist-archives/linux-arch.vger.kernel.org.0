Return-Path: <linux-arch+bounces-12528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18779AEF211
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 10:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F706171A90
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE4726AA8C;
	Tue,  1 Jul 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l7iG879W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P93PkXHf"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCA246784;
	Tue,  1 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360289; cv=none; b=iQoIzJSIoDjJickPK7KfE6B8mp9vtGb9aPjr7EOhmcrxZP2zxwLoU4odWi41yEZN3cByXgvP9NSEBz2SCwC+RIirX3iB/cxeokq0GcxKug4Mmnp2m+vRCv8fb1lsnNWZejifbjhke9I3JbaJxVkVk2hewoxeV6wiptjkDY5juKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360289; c=relaxed/simple;
	bh=xIfkmx4pDxXevXPAx1p1JGHwhxJQ6cisMgo/fbdsq6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rcr3CvxZjpe0x8M2ylz/82W8TipT26DdPTFQUv4pF/mnA+HsNIvzgRLSixz9azGgycZveKM6sj6D/fIxEaesLePNwaNs1+lWpiyeKoFbDfGvGNalt5R83eEq5HJrdCI5NCDDpXV3Lr/g0bG6J75n3/1k8y6c8w8hHb6/DMOdTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l7iG879W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P93PkXHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UWqa3o/KH1fxq5ngNTN1gEpoaEETkdHSnWpn0ajyl6w=;
	b=l7iG879WE8+uil1trLDqTYeE4L9pM5Rf+pCxkms/shlWot8WLot8/sNpSdtNPVsnwrr6Y4
	0/lkK/S1N/msIkgcDAUfBzAzjoo1QzvYBuAbM7redimuKHm4rfriBoa3eKMe6+qY6iA80i
	gEYcERB04n7G5BSAAc2WF/07/i24sw4ClAXulcHGD61dPykQnd0RP80jrD6A3IOWEhKAEN
	jigB72kmBcTvAsgSBuy9WSP8k8r4MXuazT6rS/YBgPVrN98xdXJTx5s2LV+MohLdjGHTfS
	BGptH77ybmk7gX3RAWAQGAQZ7HXdTbBcxzHQ09Topg0XuTMypXkn8xDUl0H5fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UWqa3o/KH1fxq5ngNTN1gEpoaEETkdHSnWpn0ajyl6w=;
	b=P93PkXHfKtHE62vs4BQWz1RAY3Uy++kBAAQbK9eCyc5MEUvNgJqebMmyPiuXGZtGEdYZ/x
	wE1u/oTSisTMUCBA==
Subject: [PATCH 00/14] vdso: Add support for auxiliary clocks
Date: Tue, 01 Jul 2025 10:57:54 +0200
Message-Id: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABKjY2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM2MD3bKU4nzdxNKK5Jz85GxdS/PEpJQ0i1QDE6NEJaCegqLUtMwKsHn
 RsbW1ANOskK9fAAAA
X-Change-ID: 20250630-vdso-auxclock-97abdf8e042a
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher Hall <christopher.s.hall@intel.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Werner Abt <werner.abt@meinberg-usa.com>, 
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2895;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=xIfkmx4pDxXevXPAx1p1JGHwhxJQ6cisMgo/fbdsq6s=;
 b=2ONxPG8pv+6YEU4JGQr/Cz0X4Yw33GMIFt1iZdAqeec5uo7jeOJouKKyrYKvl12fEyvfryPDt
 c2oLZ3iKm+XCT5R5Ibl/1mJbmxQgOg630sIJLuIcvqObiNdarbzu8KB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the vDSO for fast-path access to auxiliary clocks (CLOCK_AUX).
The implementation is based on the generic vDSO infrastructure and works for
all its supported architectures.
Namely x86, arm, arm64, riscv, powerpc, loongarch and s390.
No changes to userspace are necessary.

Based on timers/ptp of tip.git.

This also depends on v6.16-rc2 *exactly*.
The specific dependency is commit 11fcf368506d ("uapi: bitops: use UAPI-safe variant of BITS_PER_LONG again"),
which is available in v6.16-rc2.
Unfortunately that got broken again in v6.16-rc3 by
commit  fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources").
Another fix for this is pending [0] and should make it into v6.16.

[0] https://lore.kernel.org/lkml/20250630-uapi-genmask-v1-1-eb0ad956a83e@linutronix.de/

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (14):
      selftests/timers: Add testcase for auxiliary clocks
      vdso/vsyscall: Introduce a helper to fill clock configurations
      vdso/vsyscall: Split up __arch_update_vsyscall() into __arch_update_vdso_clock()
      vdso/helpers: Add helpers for seqlocks of single vdso_clock
      vdso/gettimeofday: Return bool from clock_getres() helpers
      vdso/gettimeofday: Return bool from clock_gettime() helpers
      vdso/gettimeofday: Introduce vdso_clockid_valid()
      vdso/gettimeofday: Introduce vdso_set_timespec()
      vdso/gettimeofday: Introduce vdso_get_timestamp()
      vdso: Introduce aux_clock_resolution_ns()
      vdso/vsyscall: Update auxiliary clock data in the datapage
      vdso/gettimeofday: Add support for auxiliary clocks
      Revert "selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers"
      selftests/timers/auxclock: Test vDSO functionality

 arch/arm64/include/asm/vdso/vsyscall.h    |   7 +-
 include/asm-generic/vdso/vsyscall.h       |   6 +-
 include/linux/timekeeper_internal.h       |  13 +
 include/vdso/auxclock.h                   |  13 +
 include/vdso/datapage.h                   |   5 +
 include/vdso/helpers.h                    |  40 ++-
 kernel/time/namespace.c                   |   5 +
 kernel/time/timekeeping.c                 |  18 +-
 kernel/time/vsyscall.c                    |  70 ++++--
 lib/vdso/gettimeofday.c                   | 212 ++++++++++------
 tools/testing/selftests/timers/.gitignore |   1 +
 tools/testing/selftests/timers/Makefile   |   2 +-
 tools/testing/selftests/timers/auxclock.c | 406 ++++++++++++++++++++++++++++++
 tools/testing/selftests/vDSO/Makefile     |   2 -
 tools/testing/selftests/vDSO/parse_vdso.c |   3 +-
 15 files changed, 683 insertions(+), 120 deletions(-)
---
base-commit: 4e83b31e48cf2e62aeaed5cd9875c851e36a90d9
change-id: 20250630-vdso-auxclock-97abdf8e042a

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


