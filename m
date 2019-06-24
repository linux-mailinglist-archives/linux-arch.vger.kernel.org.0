Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 369F050CDE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 15:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbfFXN4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 09:56:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfFXN4a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 09:56:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6DF344;
        Mon, 24 Jun 2019 06:56:29 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58ED3F71E;
        Mon, 24 Jun 2019 06:56:26 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:56:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 01/25] kernel: Standardize vdso_datapage
Message-ID: <20190624135624.GB29120@arrakis.emea.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:28AM +0100, Vincenzo Frascino wrote:
> In an effort to unify the common code for managing the vdso library in
> between all the architectures that support it, this patch tries to
> provide a common format for the vdso datapage.
> 
> As a result of this, this patch generalized the data structures in vgtod.h
> from x86 private includes to general includes (include/vdso).
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Shijith Thotton <sthotton@marvell.com>
> Tested-by: Andre Przywara <andre.przywara@arm.com>

Minor clean-up patch (on top of the tip timers/vdso branch):

------------8<------------------------------
From 2e09fa6fca341b3ec7ecaf0b67a313a167bb4ff2 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 24 Jun 2019 12:19:23 +0100
Subject: [PATCH] vdso: Remove superfluous #ifdef __KERNEL__ in
 vdso/datapage.h

With the move to UAPI headers, such #ifdefs are no longer necessary.

Fixes: 361f8aee9b09 ("vdso: Define standardized vdso_datapage")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 include/vdso/datapage.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index e6eb36c3d54f..2e302c0f41f7 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -2,8 +2,6 @@
 #ifndef __VDSO_DATAPAGE_H
 #define __VDSO_DATAPAGE_H
 
-#ifdef __KERNEL__
-
 #ifndef __ASSEMBLY__
 
 #include <linux/bits.h>
@@ -88,6 +86,4 @@ extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")
 
 #endif /* !__ASSEMBLY__ */
 
-#endif /* __KERNEL__ */
-
 #endif /* __VDSO_DATAPAGE_H */
