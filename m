Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1468A74C
	for <lists+linux-arch@lfdr.de>; Sat,  4 Feb 2023 01:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjBDAsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 19:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjBDAsG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 19:48:06 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50659E7
        for <linux-arch@vger.kernel.org>; Fri,  3 Feb 2023 16:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JmVQD8jromSnDUBUYgPiaayJmQ/MzQF4zRX6jlvWPUg=; b=eOybbCNSuQ/HA42sISi4q2xx/q
        fnlGBUUEin5jHcuHAUe9MBk0rRBjVeKlVXteLhKOu62OmSos0oKjwmGXOgZqnqlIsq/OAgqnbH2D2
        jJ8TaTcAnvQ/fQS8fq3rTYELw2ehz8AMMwIT6mRKIvmsSRDF3rYqQFQcjD0VMhzuGKdPNR76OVgSV
        6lrlwYCa6KOlava394+pHhl+Q3eb796m5a28hKQYCWPZcX3DYyFzDl6wtAO8JadAm/+l7OvNU0DJa
        ZenD97acn+FF9sRqCb3DGONEDhJHoyVOQaavDXm1okMQaQdsQ7C/hSJcEmkmJpy8bBiJBHdVv8Tst
        uiwfWcIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pO6ij-0064SA-09;
        Sat, 04 Feb 2023 00:47:57 +0000
Date:   Sat, 4 Feb 2023 00:47:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [loongarch oddities] Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y92rPZRqdxPb/dlu@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9mM5wiEhepjJcN0@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9mM5wiEhepjJcN0@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Speaking of really weird stuff, on loongarch we have
this:
        /*
         * We fault-in kernel-space virtual memory on-demand. The  
         * 'reference' page table is init_mm.pgd.
         *
         * NOTE! We MUST NOT take any locks for this case. We may
         * be in an interrupt or a critical region, and should
         * only copy the information from the master page table,
         * nothing more.
         */
        if (address & __UA_LIMIT) {
                if (!user_mode(regs))
                        no_context(regs, address);
                else   
                        do_sigsegv(regs, write, address, si_code);
                return;
        }

That looks as if it had started off as usual vmalloc page tables
propagation in #PF, but... it obviously does nothing of that sort.
What's going on there and why do we even bother?  After all,
we'd better have no vma above that address, so the normal logics
would seem to be fine with that case...

Another really weird part there is
        /*
         * If we're in an interrupt or have no user
         * context, we must not take the fault..
         */
        if (faulthandler_disabled() || !mm) {
                do_sigsegv(regs, write, address, si_code);
                return;
        }
There should be no way to have this condition for userland
page fault and do_sigsegv() is starting with
        /* Kernel mode? Handle exceptions or die */
        if (!user_mode(regs)) {
                no_context(regs, address);  
                return;
        }
	<force SIGSEGV>
What's wrong with just
        if (faulthandler_disabled() || !mm) {
		no_context(regs, address);
		return;
	}
Am I missing something subtle here?
