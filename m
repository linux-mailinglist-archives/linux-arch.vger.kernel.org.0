Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44774259009
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIAOPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgIALt0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACD9C06125F;
        Tue,  1 Sep 2020 04:48:04 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TF5bffiWAtpwidWPHVFUAUsl9G1rNNk8HDTdIk9Zc8=;
        b=Wxn4BsDgMiaUqZXOUMySyb+eX8zXhNWuNCqked+7Arzb+1dryuQ6rYt/iBQPAWIhTTjZ+u
        udECah+aIJ/Xk4glN7HPbbDMLNbQuZhleuvrK+BdjKRyGWTOkyXANwTdnxw3NZeab5OtV2
        /0ptOyQYcf+y2Z30o+EMcFrfXFUN5p+ICBaUI6O1xVq6JeJmiixbILvE9R2Y6kzZzi6ACi
        uaC6xb3u9RGnDknTA0QCo5hdCGuk4NTFO0nQCR28ciCHzq4+/xy6XnKQ3cWPjU0Xybv3fI
        7mBySEvVwCFJb3HycoQjSZVnCE8nzffCRI8zTAvpAcpmQdTqCCxMVJTLIF1Ugw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TF5bffiWAtpwidWPHVFUAUsl9G1rNNk8HDTdIk9Zc8=;
        b=i9+Jf1zj+gmAnvKliv4krRKO8ak6SLcJj2K3O/M0lkx28IrN7uNRWiJj6GybK8uIrp4H1P
        eNtBdsww2zbHiIAQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab
 to ELF_DETAILS
Cc:     Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-6-keescook@chromium.org>
References: <20200821194310.3089815-6-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087977.20229.5184709626139315991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     a840c4de569f610bc5ee043b613c35b779d23186
Gitweb:        https://git.kernel.org/tip/a840c4de569f610bc5ee043b613c35b779d23186
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:35 +02:00

vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the ELF_DETAILS section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org
Link: https://lore.kernel.org/r/20200821194310.3089815-6-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cadcbc3..98d013d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -823,7 +823,10 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
