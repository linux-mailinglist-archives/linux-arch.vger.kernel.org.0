Return-Path: <linux-arch+bounces-7201-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAE974983
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 07:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE7B1C2528B
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 05:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8B6F2FD;
	Wed, 11 Sep 2024 05:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcjOUdE5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gknwvNYQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4F43144;
	Wed, 11 Sep 2024 05:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726031634; cv=none; b=REn/oMViuq3vKuIHwHpVbvSo+q/XR7W3RhfzrPmIver4dkOJF2pdUc+9h5LQuuAFnsKElreNOQDMJf0XCWcUjMVUpevSWQBoqRCZTSn1YFExT0N+EK3OgQCZEfX4mfA0igHfmUsw2KWs12S1NS0wzhVWp/CcnveAIXZ6nmhl8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726031634; c=relaxed/simple;
	bh=q0HRr62z9v6B+nh5b/c1um4MZq70nhNyB/Vrb0dK0og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfjkmckKGV4CQ18281bw7GstGEfYaam0wlAfKaB+6mY4lGDkzi6wt2R4GXg/kg5rPKrgvHSaVyGXrdX/YJ77vPMmzlrkwzj8F2yT1E35R0ohKR8oHxIVQqYDpJPOAo0wCy4Qp5xOQE2QHWhu9K1G0qc9S5/dWxh4wx5VKMpWeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcjOUdE5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gknwvNYQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726031630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+M63sb+alCucSQJ7tlC6FTNMfLDiWgRAcRl5msr836k=;
	b=zcjOUdE5uYOzG3zMWEysbHES79qDB4JSVXHCvX7jvX038hWJ6E1a9zmS+8gu8PUIVCCpAB
	MFWXJ7p6LXXj4ROo0dAOnsRZIxnowxknJJEhm4BWG0Oo+2egK0RgI2vlxZMdxkEWOAx7i1
	d2brlK5z8VGIsQ1JjenUCJxy45eLQdU0pqQ8FCEgHTyk615kiOsGJtMGW8lZ6bPKCRxcPo
	uFDQn+ByIPqS23hKA0bubN5nF5pDTo6IRnyxDc/mXB4TF8q39GIubPyo2pmQ4LXywN2So1
	g6YS43ZHIDqqJIWssbA6Ql0ocvqSfcNJxMiLCpxJ7Mksmpr5QBVYTaU10mmzmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726031630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+M63sb+alCucSQJ7tlC6FTNMfLDiWgRAcRl5msr836k=;
	b=gknwvNYQnzUM0poa0HzYHQbR2GF9YzVdCcLwSMZwtPEgGL8vK1OkJldGBzIqqkkvp4MOMX
	P63ejNE/kCRZ18DA==
Subject: [PATCH v2 00/15] timers: Cleanup delay/sleep related mess
Date: Wed, 11 Sep 2024 07:13:26 +0200
Message-Id: <20240911-devel-anna-maria-b4-timers-flseep-v2-0-b0d3f33ccfe0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYm4WYC/5WNSw6CMBQAr0Le2mdK+bWuvIdhUeQhL4GWtNhgC
 He3cgOXM4uZHQJ5pgC3bAdPkQM7m0BeMniOxr4IuU8MUshSaFFiT5EmNNYanI1ng12JK8/kAw5
 TIFpQFarSuex0rRWkzuJp4O18PNrEI4fV+c+5jPnP/lOPOQokrZpayKouGnGf2L5X7yxv156gP
 Y7jC2ndop/WAAAA
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, SeongJae Park <sj@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
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

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
Changes in v2:
- change udelay() and ndelay() as suggested by Thomas
- Update some formatting in the new sleep_timeout.c file
- minor typo changes and other small review remarks

Thanks,

        Anna-Maria

---
Anna-Maria Behnsen (15):
      MAINTAINERS: Add missing file include/linux/delay.h
      timers: Move *sleep*() and timeout functions into a separate file
      timers: Update schedule_[hr]timeout*() related function descriptions
      timers: Rename usleep_idle_range() to usleep_range_idle()
      timers: Update function descriptions of sleep/delay related functions
      delay: Rework udelay and ndelay
      timers: Adjust flseep() to reflect reality
      mm/damon/core: Use generic upper bound recommondation for usleep_range()
      timers: Add a warning to usleep_range_state() for wrong order of arguments
      checkpatch: Remove broken sleep/delay related checks
      regulator: core: Use fsleep() to get best sleep mechanism
      iopoll/regmap/phy/snd: Fix comment referencing outdated timer documentation
      powerpc/rtas: Use fsleep() to minimize additional sleep duration
      media: anysee: Fix link to outdated sleep function documentation
      timers/Documentation: Cleanup delay/sleep documentation

 Documentation/dev-tools/checkpatch.rst         |   6 -
 Documentation/timers/delay_sleep_functions.rst | 122 ++++++++
 Documentation/timers/index.rst                 |   2 +-
 Documentation/timers/timers-howto.rst          | 115 --------
 MAINTAINERS                                    |   2 +
 arch/powerpc/kernel/rtas.c                     |  21 +-
 drivers/media/usb/dvb-usb-v2/anysee.c          |   6 +-
 drivers/regulator/core.c                       |  47 +---
 include/asm-generic/delay.h                    |  95 +++++--
 include/linux/delay.h                          |  79 ++++--
 include/linux/iopoll.h                         |  52 ++--
 include/linux/phy.h                            |   9 +-
 include/linux/regmap.h                         |  38 +--
 kernel/time/Makefile                           |   2 +-
 kernel/time/hrtimer.c                          | 120 --------
 kernel/time/sleep_timeout.c                    | 376 +++++++++++++++++++++++++
 kernel/time/timer.c                            | 192 -------------
 mm/damon/core.c                                |   5 +-
 scripts/checkpatch.pl                          |  38 ---
 sound/soc/sof/ops.h                            |   8 +-
 20 files changed, 701 insertions(+), 634 deletions(-)


