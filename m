Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294068372E
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjAaUGI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaUGH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 15:06:07 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7308577EF;
        Tue, 31 Jan 2023 12:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VASyJZSBEquFV0KDKoogdy4OX3OzJhAh5o0jO+QEP/8=; b=HB3AztPi+msrmE3oE5yxiRYHVr
        ykikKMa5v2Yo/giiWWzK4KJyD5/Ga89pUwCA5QwIcEFZBjT6oE1RFuEVpeMiy76e/ZXx+0nL5crYs
        8IK4nTQuAawNWyAZkdVLhCPSzC1A/uzuiGDGdxxpBOFsX7lUljEbBv6ahdNY643XjTRayt1YFEoJx
        2sQZ3b5XcI1+dhT9RX453RW2gqZWp14s31ix2dzgEhP3KVyyOxoPEN9O1p0Xp124Si6XBthNYbFUh
        lczTWd+6ntJSifvArW39txP0ZNkdkGGYFRV1xXxHbQIvUoxSo7pon5BnAUMC8WjMHKxggfzsDaq8a
        E+6hb8kg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMwtJ-005Inr-0r;
        Tue, 31 Jan 2023 20:06:05 +0000
Date:   Tue, 31 Jan 2023 20:06:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 07/10] openrisc: fix livelock in uaccess
Message-ID: <Y9l0rfNESGOhIf9E@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9lz6yk113LmC9SI@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

openrisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/openrisc/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index b4762d66e9ef..6734fee3134f 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -162,8 +162,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 
 	fault = handle_mm_fault(vma, address, flags, regs);
 
-	if (fault_signal_pending(fault, regs))
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
 		return;
+	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-- 
2.30.2

