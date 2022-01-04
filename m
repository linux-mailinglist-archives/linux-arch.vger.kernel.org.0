Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFDB484448
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 16:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiADPKJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 10:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiADPKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 10:10:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56D0C061785;
        Tue,  4 Jan 2022 07:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF0FBB8160D;
        Tue,  4 Jan 2022 15:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2ECCC36AE9;
        Tue,  4 Jan 2022 15:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641309000;
        bh=FwGNfUpg9MLkTnhbMFPLJ49cLIB2jzBLxN/4GGjWnOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcltBGCdyfRfLT+IIZTXqTS3zagADK6ZBsTMcVQyUdv4NN8kjRsGULOzE5DU/X2xy
         bZEu2Yba/l9SCF6Lo+6gv1qAIhRp0XuikLCZu9Mo1P40icdAB1XXYXFikltZapH1Gm
         l+Od1iX+Mwn8JIhqMsyLLRkWNdVVbflggg4L/CZE=
Date:   Tue, 4 Jan 2022 16:09:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] headers/uninline: Uninline single-use function:
 kobject_has_children()
Message-ID: <YdRjRWHgvnqVe8UZ@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
 <YdRRl+jeAm/xfU8D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRRl+jeAm/xfU8D@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 02:54:31PM +0100, Ingo Molnar wrote:
> 
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> > > There's one happy exception though, all the uninlining patches that 
> > > uninline a single-call function are probably fine as-is:
> > 
> > <snip>
> > 
> > >  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
> > 
> > Let me go take this right now, no need for this to wait, it should be
> > out of kobject.h as you rightfully show there is only one user.
> 
> Sure - here you go!

I just picked it out of your git tree already :)

Along those lines, any objection to me taking at least one other one?
3f8757078d27 ("headers/prep: usb: gadget: Fix namespace collision") and
6fb993fa3832 ("headers/deps: USB: Optimize <linux/usb/ch9.h>
dependencies, remove <linux/device.h>") look like I can take now into my
USB tree with no problems.

thanks,

greg k-h
