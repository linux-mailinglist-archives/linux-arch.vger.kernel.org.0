Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14267C8E0
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 11:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjAZKp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 05:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAZKpz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 05:45:55 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88751437
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 02:45:52 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:735b:e883:8069:427])
        by albert.telenet-ops.be with bizsmtp
        id DNle2900V4pY4D906NlfsF; Thu, 26 Jan 2023 11:45:50 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pKzl1-007R9r-V2;
        Thu, 26 Jan 2023 11:45:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pKzlC-003tYg-Pt;
        Thu, 26 Jan 2023 11:45:38 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] iopoll: Call cpu_relax() in busy loops
Date:   Thu, 26 Jan 2023 11:45:37 +0100
Message-Id: <8d492ee4a391bd089a01c218b0b4e05cf8ea593c.1674729407.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is considered good practice to call cpu_relax() in busy loops, see
Documentation/process/volatile-considered-harmful.rst.  This can not
only lower CPU power consumption or yield to a hyperthreaded twin
processor, but also allows an architecture to mitigate hardware issues
(e.g. ARM Erratum 754327 for Cortex-A9 prior to r2p0) in the
architecture-specific cpu_relax() implementation.

As the iopoll helpers lack calls to cpu_relax(), people are sometimes
reluctant to use them, and may fall back to open-coded polling loops
(including cpu_relax() calls) instead.

Fix this by adding calls to cpu_relax() to the iopoll helpers:
  - For the non-atomic case, it is sufficient to call cpu_relax() in
    case of a zero sleep-between-reads value, as a call to
    usleep_range() is a safe barrier otherwise.
  - For the atomic case, cpu_relax() must be called regardless of the
    sleep-between-reads value, as there is no guarantee all
    architecture-specific implementations of udelay() handle this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Resent with a larger audience due to lack of comments.

This has been discussed before, but I am not aware of any patches moving
forward:
  - "Re: [PATCH 6/7] clk: renesas: rcar-gen3: Add custom clock for PLLs"
    https://lore.kernel.org/all/CAMuHMdWUEhs=nwP+a0vO2jOzkq-7FEOqcJ+SsxAGNXX1PQ2KMA@mail.gmail.com/
  - "Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the PLL set_rate ops"
    https://lore.kernel.org/all/20200811164628.GA7958@kozik-lap
---
 include/linux/iopoll.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 2c8860e406bd8cae..73132721d1891a2e 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -53,6 +53,8 @@
 		} \
 		if (__sleep_us) \
 			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+		else \
+			cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
@@ -95,6 +97,7 @@
 		} \
 		if (__delay_us) \
 			udelay(__delay_us); \
+		cpu_relax(); \
 	} \
 	(cond) ? 0 : -ETIMEDOUT; \
 })
-- 
2.34.1

