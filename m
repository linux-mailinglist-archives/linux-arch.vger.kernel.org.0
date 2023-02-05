Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598968B19F
	for <lists+linux-arch@lfdr.de>; Sun,  5 Feb 2023 21:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBEUjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Feb 2023 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBEUjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2023 15:39:51 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C718B02;
        Sun,  5 Feb 2023 12:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5fdXU73i1sPfwWSnl2Kp9uJVLtcRmjMeCcLubSidJE0=; b=fqMdlsGN8nHZgBmTtkX0uJosyn
        I2hmQQEMNued4xPYkfOmu6mTrqpWm5u8wUSETlQvuaE0pwJuhtMyx8lrr9dk8SSsTIGiRhLIuaT8X
        JAV2LzNUGi6risliJ6Xz3ASLXAtsDMGBIkHgbCtj3VHxswchT8DL1K5YCAGkg+pt5X56moDZSg6Sn
        jTebPrr1wvWwjngAk96JLfxOVBeOrY6e5na0+/pIlSMlYIhIRcz+Gl0wDJf4tFPbNNwOghuw/CBde
        X5YVBCZZR3+RnoAmiLu+gzrqL8S8e57gPdTh85kOi/LLec7Uu7Aksg6Z7lsrpJQ5DsYrfIS82sZwG
        Wx+K/UzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pOlnd-006PZ0-06;
        Sun, 05 Feb 2023 20:39:45 +0000
Date:   Sun, 5 Feb 2023 20:39:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
Message-ID: <Y+AUEJpWYdUzW0OD@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0aBPUEpf1bci9@ZenIV>
 <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 05, 2023 at 05:18:08PM +1100, Finn Thain wrote:

> That could be a bug I was chasing back in 2021 but never found. The mmap 
> stressors in stress-ng were triggering a crash on a Mac Quadras, though 
> only rarely. Sometimes it would run all day without a failure.
> 
> Last year when I started using GCC 12 to build the kernel, I saw the same 
> workload fail again but the failure mode had become a silent hang/livelock 
> instead of the oopses I got with GCC 6.
> 
> When I press the NMI button after the livelock I always see 
> do_page_fault() in the backtrace. So I've been testing your patch. I've 
> been running the same stress-ng reproducer for about 12 hours now with no 
> failures which looks promising.
> 
> In case that stress-ng testing is of use:
> Tested-by: Finn Thain <fthain@linux-m68k.org>
> 
> BTW, how did you identify that bug in do_page_fault()? If its the same bug 
> I was chasing, it could be an old one. The stress-ng logs I collected last 
> year include a crash from a v4.14 build.

Went to reread the current state of mm/gup.c, decided to reread handle_mm_fault()
and its callers, noticed fault_signal_pending() which hadn't been there back
when I last crawled through that area, realized what it had replaced, went
to check if everything had been converted (arch/um got missed, BTW).  Noticed
the difference between the architectures (the first hit was on alpha, without
the "sod off to no_context if it's a user fault" logics, the last - xtensa, with
it).  Checked the log for xtensa, found the commit from 2021 adding that part;
looked on arm and arm64, found commits from 2017 doing the same thing, then,
on x86, Linus' commit from 2014 adding the x86 counterpart...  Figuring out
what all of those had been for wasn't particularly hard, and it was easy
to check which architectures still needed the same thing...

BTW, since these patches would be much easier to backport than any unification
work, I think the right thing to do would be to have further unification done on
top of them.
