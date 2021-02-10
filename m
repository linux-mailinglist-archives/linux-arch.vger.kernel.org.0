Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621943168DD
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 15:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhBJOOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 09:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhBJONU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 09:13:20 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E19C061794
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 06:11:46 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id TSBi2400s4C55Sk01SBiBq; Wed, 10 Feb 2021 15:11:45 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDW-005Hss-76; Wed, 10 Feb 2021 15:11:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l9qDV-006JqZ-Oe; Wed, 10 Feb 2021 15:11:41 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] Remove checks for gcc < 4
Date:   Wed, 10 Feb 2021 15:11:36 +0100
Message-Id: <20210210141140.1506212-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Hi all,

This patch removes the few remaining checks for gcc < 4, which is no
longer supported for building the kernel.

All four patches can be applied independently.

Thanks!

Geert Uytterhoeven (4):
  ARM: div64: Remove always-true __div64_const32_is_OK() duplicate
  ARM: unified: Remove check for gcc < 4
  asm-generic: div64: Remove always-true __div64_const32_is_OK()
  microblaze: Remove support for gcc < 4

 arch/arm/include/asm/div64.h    | 11 -----------
 arch/arm/include/asm/unified.h  |  4 ----
 arch/microblaze/kernel/module.c | 26 --------------------------
 include/asm-generic/div64.h     | 14 ++++----------
 4 files changed, 4 insertions(+), 51 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
