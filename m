Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090C06836FF
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 21:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjAaUC7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaUC6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 15:02:58 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3035587;
        Tue, 31 Jan 2023 12:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wcBJkRF793IhrFvqwpLU4zntoDbJkzMhR1UFYyzCsfo=; b=BFTP6VpnlE8pQa3pDsKLm3Q10X
        Q9Gcdp7Xqeex1PKhqtcPoNe9nPTNJTF0ILbjS7R3tAUBiQe3I8I6NveA94gSYpNFCTShE7F9Mw32X
        sMkSPoX4uQPAO127UmaQN8vg8AelHaryoauasOWusihSupTGmNrqDUfP8WshD8Nu0JamWbe6yjYbE
        +a+/Pupnf8T8mInAf+wq1pKyMzaHiIb837m8C/KGKn5O0TNPKh9nWjv4opaH4Rc6k015fbTgdzd1E
        daMXAIGzgablb7n/2W6yDtHHgnj6NKhMzKfaP8ZV5EJgJf7xa2vYL3l0Z8UsaJzcyzgtcFZwutRlq
        a35LbcuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMwqB-005Il7-1l;
        Tue, 31 Jan 2023 20:02:51 +0000
Date:   Tue, 31 Jan 2023 20:02:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9lz6yk113LmC9SI@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Page fault handlers generally react to VM_FAULT_RETRY from
handle_mm_fault() by repeating the whole thing (starting with locking
mmap) with FAULT_FLAG_TRIED added to flags.

	However, there are two cases when that's not the right thing
to do:

1) fault has happened in userland and we have a pending signal.  In that
case we'd better return from fault handler immediately.

2) fault has happened in kernel (e.g. in something like copy_from_user())
and we have a pending *fatal* signal.  Solution is to handle that as if
handle_mm_fault() had failed; we have come from kernel mode, so we'd
better have an exception table entry for the fauling insn.  Find it
and deal with it; from the copy_from_user() (or whatever it was that
triggered our fault) caller's POV it's indistinguishable from running
into an unmapped area, so it will fail.  The process is not going to
survive anyway.

Quietly returning from #PF handler in the second case is asking for
livelock - one common case when handle_mm_fault() returns VM_FAULT_RETRY
is when it needs to wait for page lock and gets hit by a fatal signal.
Running into that in any uaccess primitive will end up repeating the
faulting insn again and again, as long as we hit that case in
handle_mm_fault().  Eventually it might get out (e.g. trylock
manages to get page lock without hitting the "wait for it" codepath),
but it's obviously not a good situation.

On x86 it had been noticed and fixed back in 2014, in 26178ec11ef3 "x86:
mm: consolidate VM_FAULT_RETRY handling".  Some of the other architectures
had it dealt with later - e.g. arm in 2017, the fix is 746a272e44141
"ARM: 8692/1: mm: abort uaccess retries upon fatal signal"; xtensa -
in 2021, the fix is 7b9acbb6aad4f "xtensa: fix uaccess-related livelock
in do_page_fault", etc.

However, it never had been done on a bunch of architectures - the
current mainline still has that bug on alpha, hexagon, itanic, m68k,
microblaze, nios2, openrisc, parisc, riscv and sparc (both sparc32 and
sparc64).  Fixes are trivial, but I've no way to test them for most
of those architectures.
