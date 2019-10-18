Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86E9DCB1B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439885AbfJRQat (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:30:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439817AbfJRQas (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:48 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV9F-00033f-4e; Fri, 18 Oct 2019 18:30:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C5091C04D6;
        Fri, 18 Oct 2019 18:30:34 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:34 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/suspend: Use SYM_DATA for data
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Len Brown <len.brown@intel.com>, linux-arch@vger.kernel.org,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-3-jslaby@suse.cz>
References: <20191011115108.12392-3-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623420.29376.9224656338909570146.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     37503f734e9de314c4e9a1eba33e9e7d8ec80839
Gitweb:        https://git.kernel.org/tip/37503f734e9de314c4e9a1eba33e9e7d8ec80839
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 09:50:25 +02:00

x86/asm/suspend: Use SYM_DATA for data

Some global data in the suspend code were marked as `ENTRY'. ENTRY was
intended for functions and shall be paired with ENDPROC. ENTRY also
aligns symbols to 16 bytes which creates unnecessary holes.

Note that:

* saved_magic (long) in wakeup_32 is still prepended by section's ALIGN
* saved_magic (quad) in wakeup_64 follows a bunch of quads which are
  aligned (but need not be aligned to 16)

Since historical markings are being dropped, make proper use of newly
added SYM_DATA in this code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-3-jslaby@suse.cz
---
 arch/x86/kernel/acpi/wakeup_32.S | 2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index e95e959..4272492 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -90,7 +90,7 @@ ret_point:
 
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
+SYM_DATA(saved_magic,	.long 0)
 saved_eip:		.long 0
 
 # saved registers
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 7f9ade1..462a20f 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -136,4 +136,4 @@ saved_rbx:		.quad	0
 saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA(saved_magic,	.quad	0)
