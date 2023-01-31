Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445B6683862
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 22:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjAaVKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 16:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjAaVKu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 16:10:50 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD03C8A50;
        Tue, 31 Jan 2023 13:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ax3PgYwLD1J7idHBX3HJFIuaDhcl8qpAf80zjHGbIOE=; b=ijKot8fh7fbodyAsqMzVpj0Cd/
        VRhb3o6VGsSZwFzUgydtCMao2SRAc6OvQbKgKTgF95uP5svS4C/FxCqcqUX86wc84kQEXVbEPB7wS
        rN+Xso/B3SrMGqO5wEnGdYpYTNTo/fdm4TakUXxCmvcsIkqePXpvogyNY4WqFatodwbca/GXe/IZq
        TGTiUMc3omsIAXO69lh7VVjaJ9HjeeYC3SLP2MDqgIcLqjc0YsTzOFdqGG/tpU1bxLpogucTBRm16
        qsgaiC/gb9QmZbQNmm8axQf5ucRwx/M7yQhEY+AOFMpn3cAcoHodK3a6Dtut3nhZNK43ZjcPwYxi3
        AIsaudwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pMxtu-005JJn-1T;
        Tue, 31 Jan 2023 21:10:46 +0000
Date:   Tue, 31 Jan 2023 21:10:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9mD1qp/6zm+jOME@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 12:24:54PM -0800, Linus Torvalds wrote:

> But *if* the alpha code were to just translate it into the
> FAULT_FLAG_xyz namespace, apretty much *all* of the alpha
> do_page_fault() could have been then done by a completely generic
> "generic_page_fault()" that has all of the retry logic, all of the
> si_code logic, etc etc.

Umm...  What about the semantics of get_user() of unmapped address?
Some architectures do quiet EFAULT; some (including alpha) hit
the sucker with SIGBUS, no matter what.

Examples:
arm
        if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
		return 0;

	/*
	 * If we are in kernel mode at this point, we
	 * have no context to handle this fault with.
	 */
	if (!user_mode(regs))
		goto no_context;
	...
alpha
 do_sigbus:
        mmap_read_unlock(mm);
        /* Send a sigbus, regardless of whether we were in kernel
           or user mode.  */
        force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address);
        if (!user_mode(regs))
                goto no_context;
        return;

Are we free to modify that behaviour, or is that part of arch-specific
ABI?
