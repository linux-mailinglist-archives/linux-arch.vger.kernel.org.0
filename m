Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B2259154
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIAOtp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:49:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgIALs1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:48:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I57UAO7P51ZgEM8V4T+HRPcJdptqpQjfQLS6YRa1cI4=;
        b=VlVvTAPLi7Nw0Yu4X9ZXsuM4K+FFQiNyLuczRHjtBSXnrkYbcRswTaNooiiZaisX8wUvlU
        fEuvuhOVzGIts7P9jRDIO6NiRcF/tIgwsaWOyGejdAYqDWoiQ9fZI9aMr+E8ckDY/MIX3G
        VENVsJw7NBD+f8P+BJDDA9ch50uDzA+Aj9WjpzIiyERMG3l9ZpFZMQPHlAzbI2I6s9tX8Y
        sAGs864SiP2we2KCaSIDmNKEXMDHpuBGWJoWhxeXS7PMC8OV+clVB7pJQ7UbrajOkGIZJP
        nRQqIhYpyE5Zxnnsoq+hTFcg0kbsn8T2H7NHKSA+JhjP1lBe91W4v6SqVGWyAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I57UAO7P51ZgEM8V4T+HRPcJdptqpQjfQLS6YRa1cI4=;
        b=u/qewu0bFU1EFGP/qYZhZlt5wkAOHemY4DIxlSXTZvEHEoGpyRX/xW04S+jsa3MMiIqIJ9
        WqMV5PlwCQgCu1Cw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Fangrui Song <maskray@google.com>, linux-arch@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-3-keescook@chromium.org>
References: <20200821194310.3089815-3-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896088111.20229.8673241506137481803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     dfbe69689b4dee19021d8c315a5137b4790b5634
Gitweb:        https://git.kernel.org/tip/dfbe69689b4dee19021d8c315a5137b4790b5634
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:43 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:35 +02:00

vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS

For vmlinux linking, no architecture uses the .gnu.version* sections,
so remove it via the COMMON_DISCARDS macro in preparation for adding
--orphan-handling=warn more widely. This is a work-around for what
appears to be a bug[1] in ld.bfd which warns for this synthetic section
even when none is found in input objects, and even when no section is
emitted for an output object[2].

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=26153
[2] https://lore.kernel.org/lkml/202006221524.CEB86E036B@keescook/

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Cc: linux-arch@vger.kernel.org
Link: https://lore.kernel.org/r/20200821194310.3089815-3-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 184b23d..f1f02a2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -957,7 +957,9 @@
 #define COMMON_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
-	*(.modinfo)
+	*(.modinfo)							\
+	/* ld.bfd warns about .gnu.version* even when not emitted */	\
+	*(.gnu.version*)						\
 
 #define DISCARDS							\
 	/DISCARD/ : {							\
