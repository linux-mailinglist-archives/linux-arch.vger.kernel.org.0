Return-Path: <linux-arch+bounces-8067-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8345F99C2FC
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42DF1C2267C
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB041547F3;
	Mon, 14 Oct 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFExR3Z0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="slvvGPaA"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6509212C54B;
	Mon, 14 Oct 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894167; cv=none; b=fWWxn82eszQFuckO1FwMP4L8UdehI/8dH5QW5Hej5H+VL3CGCNVHXRYds8L71MdFNg7KU1UVZAe76vt+qzpOJECPvHpySpFs+nXycYTdYqGwO6lVrQ3qMJ+9SO3wzatoV1trt17je6+ArcdskJVl77kiwVH/z3+UdIxSPO1a1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894167; c=relaxed/simple;
	bh=dGqCqRwAyi62E3GAk8CVKrqzGtDT7u4rKx7rTPZQFko=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ihe/xUc3owLcuGkDQgS88GmHQl3AsxGgLkEtpE7GNVTWVspRymU/OEoWRxL19XM3Y4oqmez0cr/mZsfuzJV66n1spafByBWMOfAz/cemPmOEV+KyFInH8mU+KGnNA+VDQVdL2WZCcHw69ug2iGuD+OCgAqc/3qUxHI4g5xJdoYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFExR3Z0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=slvvGPaA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728894163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6HOwNsVm5tP1AF7YCvIKWbMDqeHpS3lPwmHnkUywq/Y=;
	b=KFExR3Z0ch2CGjb8uZF385NycoNtXWJ52MR/i19uWkoHR73ejXuX4GOFPDZJchSNKxN0YH
	9H09dQgIFLN0XYA0sRa7f+Jg744VoU+FWRipA2zenwRVFWf0noRuToPCIoq/ePHjxWarJ9
	SqjMIQ2OJJIQc/JlGoQcr7qn+Ztcb5Wog63TpXuR+uMIcDwA7z6B2gog9Q3SVmAY2bikFt
	mRj2dJa9yDAlHsRKp62fLCoRoJ4uho0BgHGrPNhLu+s/+D79MQkDsckRZ1I3/nd5V/0BHs
	FuKX3H4yatjIlK09dEr8+nGf1DKjJ0qQxyhRK9NozUQLqHSQ76Lx7voiR0M2tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728894163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6HOwNsVm5tP1AF7YCvIKWbMDqeHpS3lPwmHnkUywq/Y=;
	b=slvvGPaAqPFHoRdnXnb5CSGotI1RmGRgBCGz97ighCehiyEF+E9aEDo3bB0d+pbkk/R91i
	aaXfQVNhvqPTH6BA==
Subject: [PATCH v3 00/16] timers: Cleanup delay/sleep related mess
Date: Mon, 14 Oct 2024 10:22:17 +0200
Message-Id: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnUDGcC/5XNSw6CMBSF4a2Qjr2mD1515D6MgwIXuQkU0mKDI
 ezdwsjEiQ7/M/jOyjw6Qs8uycocBvI02hjqlLC6M/aBQE1sJrlMueYpNBiwB2OtgcE4MlClMNO
 AzkPbe8QJSlVmWshK57pk0ZkctrQcH7d77I78PLrXcRnEvv6jBwEcUJdFzmWWq4Jfe7LP2Y2Wl
 nODbH8I8kMV4hdVRrXijWqVqusWv9Rt295y1hsLLAEAAA==
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 damon@lists.linux.dev, linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 netdev@vger.kernel.org, linux-sound@vger.kernel.org, 
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 linux-media@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi,

a question about which sleeping function should be used in acpi_os_sleep()
started a discussion and examination about the existing documentation and
implementation of functions which insert a sleep/delay.

The result of the discussion was, that the documentation is outdated and
the implemented fsleep() reflects the outdated documentation but doesn't
help to reflect reality which in turns leads to the queue which covers the
following things:

- Split out all timeout and sleep related functions from hrtimer.c and timer.c
  into a separate file

- Update function descriptions of sleep related functions

- Change fsleep() to reflect reality

- Rework all comments or users which obviously rely on the outdated
  documentation as they reference "Documentation/timers/timers-howto.rst"

- Update the outdated documentation and move it into a file with a self
  explaining file name (as there are no more references)

- Remove checkpatch checks which also rely on the outdated documentation

The queue is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
Changes in v3:
- Add review remarks
- Split checkpatch patch: 1. Remove links to outdated documentation,
  2. Remove checks in checkpatch which rely on outdated documentation
- Link to v2: https://lore.kernel.org/r/20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de

Changes in v2:
- change udelay() and ndelay() as suggested by Thomas
- Update some formatting in the new sleep_timeout.c file
- minor typo changes and other small review remarks

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (16):
      MAINTAINERS: Add missing file include/linux/delay.h
      timers: Move *sleep*() and timeout functions into a separate file
      timers: Update schedule_[hr]timeout*() related function descriptions
      timers: Rename usleep_idle_range() to usleep_range_idle()
      timers: Update function descriptions of sleep/delay related functions
      delay: Rework udelay and ndelay
      timers: Adjust flseep() to reflect reality
      mm/damon/core: Use generic upper bound recommondation for usleep_range()
      timers: Add a warning to usleep_range_state() for wrong order of arguments
      checkpatch: Remove links to outdated documentation
      regulator: core: Use fsleep() to get best sleep mechanism
      iopoll/regmap/phy/snd: Fix comment referencing outdated timer documentation
      powerpc/rtas: Use fsleep() to minimize additional sleep duration
      media: anysee: Fix and remove outdated comment
      timers/Documentation: Cleanup delay/sleep documentation
      checkpatch: Remove broken sleep/delay related checks

 Documentation/dev-tools/checkpatch.rst         |   6 -
 Documentation/timers/delay_sleep_functions.rst | 121 ++++++++
 Documentation/timers/index.rst                 |   2 +-
 Documentation/timers/timers-howto.rst          | 115 --------
 MAINTAINERS                                    |   2 +
 arch/powerpc/kernel/rtas.c                     |  21 +-
 drivers/media/usb/dvb-usb-v2/anysee.c          |  17 +-
 drivers/regulator/core.c                       |  47 +--
 include/asm-generic/delay.h                    |  96 +++++--
 include/linux/delay.h                          |  79 ++++--
 include/linux/iopoll.h                         |  52 ++--
 include/linux/phy.h                            |   9 +-
 include/linux/regmap.h                         |  38 +--
 kernel/time/Makefile                           |   2 +-
 kernel/time/hrtimer.c                          | 120 --------
 kernel/time/sleep_timeout.c                    | 377 +++++++++++++++++++++++++
 kernel/time/timer.c                            | 192 -------------
 mm/damon/core.c                                |   5 +-
 scripts/checkpatch.pl                          |  38 ---
 sound/soc/sof/ops.h                            |   8 +-
 20 files changed, 704 insertions(+), 643 deletions(-)


