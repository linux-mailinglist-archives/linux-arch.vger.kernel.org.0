Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5314210C7D2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2019 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfK1LRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Nov 2019 06:17:30 -0500
Received: from foss.arm.com ([217.140.110.172]:34082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfK1LRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Nov 2019 06:17:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC34E1FB;
        Thu, 28 Nov 2019 03:17:29 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBCE73F6C4;
        Thu, 28 Nov 2019 03:17:28 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     tglx@linutronix.de, luto@kernel.org, marc.w.gonzalez@free.fr
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH] lib: vdso: Fix sparse warning
Date:   Thu, 28 Nov 2019 11:17:19 +0000
Message-Id: <20191128111719.8282-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix the following sparse warning in the generic vDSO library:

linux/lib/vdso/gettimeofday.c:224:5: warning: symbol
'__cvdso_clock_getres' was
not declared. Should it be static?

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lutomirski <luto@kernel.org>
Reported-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Link: https://www.spinics.net/lists/arm-kernel/msg770849.html
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 45f57fd2db64..1d47b34a8ad9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -221,6 +221,7 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
 	int ret = __cvdso_clock_getres_common(clock, res);
-- 
2.24.0

