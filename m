Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F466D3F02
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfJKLvP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727226AbfJKLvP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B108B43E;
        Fri, 11 Oct 2019 11:51:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v9 02/28] x86/asm/suspend: Use SYM_DATA for data
Date:   Fri, 11 Oct 2019 13:50:42 +0200
Message-Id: <20191011115108.12392-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some global data in the suspend code were marked as `ENTRY'. ENTRY was
intended for functions and shall be paired with ENDPROC. ENTRY also
aligns symbols to 16 bytes which creates unnecessary holes here between
data. Note that:
* saved_magic (long) in wakeup_32 is still prepended by section's ALIGN
* saved_magic (quad) in wakeup_64 follows a bunch of quads which are
  aligned (but need not be aligned to 16)

Since historical markings are being dropped, make proper use of newly
added SYM_DATA in this code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S | 2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index e95e95960156..427249292aef 100644
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
index 7f9ade13bbcf..462a20f386e0 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -136,4 +136,4 @@ saved_rbx:		.quad	0
 saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA(saved_magic,	.quad	0)
-- 
2.23.0

