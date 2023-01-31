Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204A683734
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 21:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjAaUGa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 15:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaUG3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 15:06:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9945867A;
        Tue, 31 Jan 2023 12:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Va46d86eM1Bc2zftK4w6YVIH/9TSKHJFKV1SMXapYTA=; b=wP1rmspskn7rYIm3LIubWz3zZY
        CX7Pm1fllvuDHdAV0IOAnSDgrsaowkvoRmi/XUYRBrjGq3ixNXrTgSKteSegRq92d4ZSuD2x4KFqN
        n64Lx21+SSTyHwh9ZQTkuJ5tSwYqU543ckEgA0Afvo3XT8tp2WFfrZADEX/iSevSCRtO4lo4UZKUd
        uMAnRpLwr7SxtDn29dSzBAsDhDi1jL2v7u6WaHriQRKtfQTLK52Pew4tfOJqXzALx0qtScNMOJCrQ
        VIm60E7FRBQGzyrh8RI0tkmGD+i2Z8lIe1R/29aG3eeR/81AwwdA+P75WnbVplBNdABD9j2/J2gJM
        7+tiSftg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMwtf-005Io6-0L;
        Tue, 31 Jan 2023 20:06:27 +0000
Date:   Tue, 31 Jan 2023 20:06:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <Y9l0w4M91DwYLO3N@ZenIV>
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

parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
to page tables.  In such case we must *not* return to the faulting insn -
that would repeat the entire thing without making any progress; what we need
instead is to treat that as failed (user) memory access.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 869204e97ec9..bb30ff6a3e19 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
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

