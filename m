Return-Path: <linux-arch+bounces-7004-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443B96BDD2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5123DB2903C
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4311DC047;
	Wed,  4 Sep 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKIctVY4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+eXvp9U"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A61DB553;
	Wed,  4 Sep 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455136; cv=none; b=TEm+0qE5ls4ZxGa4R9FUUgwxuymi0yj3USy7bXWtVNKp9eL9jBROsRLrBdaZMRf9Beam3Vg0ify9wdQQdshoTonx0WUPOxNgnZQU4LS34sNfEDqjs5Vfs08xMTYIKsbnqT9tn8XRs1HFJKNuzqrp+IsP8EXBf9Kh7KYRq4+7LCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455136; c=relaxed/simple;
	bh=i8qpq2Ga+wz0kEB5v7nBbytJkFEqZR2QrJQmK0J2+Aw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Urfj9xQWugqF5r8lsiW3GRMNVHCATvfDYBU1tBgsOxMJO/RJNo5QLtAOkB/rHnSq+lJvKy+14G9QykDcW2/xshKU+Fq27BZhiPEkw/L5zP20DQUlhXVeJpCJ/dM8BOwGQaixh7Qx7yNp07D+Uv0WzFZQntTPGiTawgr/LL9B+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKIctVY4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+eXvp9U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IcwSc34LvXMP/cT7noBpbT1jqfRVjScu2K4oFpyriwE=;
	b=pKIctVY4axfpzaDAkuW89nfEerNMQNXGr4oRrZz38wPjBOmrxBuAnOBWaEizzBAwauAjPh
	iSPCWacRZvzl6CCp1is+uBZAeRqXH7FmxMsCNUd2XW7fLBRd3R2v/gVjNOtuOAe97g20n4
	iyKyv4M3SsAHlQyN0Bb5+/WPEPJl38gvPLOQnPCVAYjWpdHo54oO5T6wTZVXJJDlbqXkkE
	3oyAKI4DEAwwq/8zn1lI0pDDGpx/h1p9ThiWQxIDIVUHt673XGvyw0iUaWqSDLv7yLyqpo
	Anfa2HXMo+/DXNdDrHE8hi9N5LqhVKzPFFuFJBaC1IHamnKd3WZ2Kp5fjH9bRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IcwSc34LvXMP/cT7noBpbT1jqfRVjScu2K4oFpyriwE=;
	b=E+eXvp9UB9r1HGGHMLtT0w+geizfWK2j8vOahsM5RXh4xyoJXjN+XNIwwk0C+aPRWMYALP
	cm7NexPhzPCUw2DQ==
Subject: [PATCH 00/15] timers: Cleanup delay/sleep related mess
Date: Wed, 04 Sep 2024 15:04:50 +0200
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJa2GYC/x3NQQqDMBBG4avIrDsQ07QkvUrpYtTfdkBTmYgUx
 Ls3uPw27+1UYIpCj2Ynw6ZFv7mivTTUfyS/wTpUk3c+uOQCD9gwseQsPIupcBd41RlWeJwKsHC
 8xltqfZfuKVLtLIZRf+fj+TqOPzF6qSBzAAAA
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
 linux-arch@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, netdev@vger.kernel.org, 
 linux-sound@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org

Hi,

a question about which sleeping function should be used in acpi_os_sleep()
started a discussion and examination about the existing documentation and
implementation of functions which insert a sleep/delay.

The result of the discussion was, that the documentation is outdated and
the implemented fsleep() reflects the outdated documentation but doesn't
help to reflect reality which in turns leads to the queue which covers the
following things:

- Minor changes (naming and typo fixes)

- Split out all timeout and sleep related functions from hrtimer.c and timer.c
  into a separate file

- Update function descriptions of sleep related functions

- Change fsleep() to reflect reality

- Rework all comments or users which obviously rely on the outdated
  documentation as they reference "Documentation/timers/timers-howto.rst"

- Last but not least (as there are no more references): Update the outdated
  documentation and move it into a file with a self explaining file name

The queue is available here and applies on top of tip/timers/core:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

Cc: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Thanks,

Anna-Maria

---
Anna-Maria Behnsen (15):
      timers: Rename next_expiry_recalc() to be unique
      cpu: Use already existing usleep_range()
      Comments: Fix wrong singular form of jiffies
      timers: Move *sleep*() and timeout functions into a separate file
      timers: Rename sleep_idle_range() to sleep_range_idle()
      timers: Update function descriptions of sleep/delay related functions
      timers: Adjust flseep() to reflect reality
      mm/damon/core: Use generic upper bound recommondation for usleep_range()
      timers: Add a warning to usleep_range_state() for wrong order of arguments
      checkpatch: Remove broken sleep/delay related checks
      regulator: core: Use fsleep() to get best sleep mechanism
      iopoll/regmap/phy/snd: Fix comment referencing outdated timer documentation
      powerpc/rtas: Use fsleep() to minimize additional sleep duration
      media: anysee: Fix link to outdated sleep function documentation
      timers/Documentation: Cleanup delay/sleep documentation

 Documentation/admin-guide/media/vivid.rst          |   2 +-
 Documentation/dev-tools/checkpatch.rst             |   6 -
 Documentation/timers/delay_sleep_functions.rst     | 122 +++++++
 Documentation/timers/index.rst                     |   2 +-
 Documentation/timers/timers-howto.rst              | 115 -------
 .../sp_SP/scheduler/sched-design-CFS.rst           |   2 +-
 MAINTAINERS                                        |   2 +
 arch/arm/mach-versatile/spc.c                      |   2 +-
 arch/m68k/q40/q40ints.c                            |   2 +-
 arch/powerpc/kernel/rtas.c                         |  21 +-
 arch/x86/kernel/cpu/mce/dev-mcelog.c               |   2 +-
 drivers/char/ipmi/ipmi_ssif.c                      |   2 +-
 drivers/dma-buf/st-dma-fence.c                     |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |   2 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |   4 +-
 drivers/gpu/drm/i915/i915_utils.c                  |   2 +-
 drivers/gpu/drm/v3d/v3d_bo.c                       |   2 +-
 drivers/isdn/mISDN/dsp_cmx.c                       |   2 +-
 drivers/media/usb/dvb-usb-v2/anysee.c              |   6 +-
 drivers/net/ethernet/marvell/mvmdio.c              |   2 +-
 drivers/regulator/core.c                           |  33 +-
 fs/xfs/xfs_buf.h                                   |   2 +-
 include/asm-generic/delay.h                        |  46 ++-
 include/linux/delay.h                              |  79 ++++-
 include/linux/iopoll.h                             |  24 +-
 include/linux/jiffies.h                            |   2 +-
 include/linux/phy.h                                |   7 +-
 include/linux/regmap.h                             |  18 +-
 include/linux/timekeeper_internal.h                |   2 +-
 kernel/cpu.c                                       |   2 +-
 kernel/time/Makefile                               |   2 +-
 kernel/time/alarmtimer.c                           |   2 +-
 kernel/time/clockevents.c                          |   2 +-
 kernel/time/hrtimer.c                              | 122 +------
 kernel/time/posix-timers.c                         |   4 +-
 kernel/time/sleep_timeout.c                        | 363 +++++++++++++++++++++
 kernel/time/timer.c                                | 210 +-----------
 lib/Kconfig.debug                                  |   2 +-
 mm/damon/core.c                                    |   5 +-
 net/batman-adv/types.h                             |   2 +-
 scripts/checkpatch.pl                              |  38 ---
 sound/soc/sof/ops.h                                |   6 +-
 42 files changed, 668 insertions(+), 607 deletions(-)


