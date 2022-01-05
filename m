Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F174855C4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiAEPXM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 10:23:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55974 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbiAEPXM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 10:23:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7F8617C9;
        Wed,  5 Jan 2022 15:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31A7C36AE0;
        Wed,  5 Jan 2022 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641396191;
        bh=ee5Owo3zU5vxkUxfJCeUQuvv8yMKNI4iRfO6jmetJQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m579DXS9iq/ymOI4ZYUnx7B941if1nNEh9yl45zNk3rugpq+87IPVeo2rjyAAov87
         EC8zXM51rU4ItLwIGU+yIgBgEJnPsWmWTAlaOT5aLj9O0zt8mF/U7DSr2UClcL9Jzd
         MpvNjt9QyFcTtQH1nnFyr2juOBZjQMWd82WYYsmw=
Date:   Wed, 5 Jan 2022 16:23:08 +0100
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
Message-ID: <YdW33ITu4Hz3+kid@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
 <YdRRl+jeAm/xfU8D@gmail.com>
 <YdRjRWHgvnqVe8UZ@kroah.com>
 <YdRkZqGuKCZcRbov@kroah.com>
 <YdTiF5dVeizYtIDS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTiF5dVeizYtIDS@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 01:11:03AM +0100, Ingo Molnar wrote:
> 
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Jan 04, 2022 at 04:09:57PM +0100, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 04, 2022 at 02:54:31PM +0100, Ingo Molnar wrote:
> > > > 
> > > > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > > On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> > > > > > There's one happy exception though, all the uninlining patches that 
> > > > > > uninline a single-call function are probably fine as-is:
> > > > > 
> > > > > <snip>
> > > > > 
> > > > > >  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
> > > > > 
> > > > > Let me go take this right now, no need for this to wait, it should be
> > > > > out of kobject.h as you rightfully show there is only one user.
> > > > 
> > > > Sure - here you go!
> > > 
> > > I just picked it out of your git tree already :)
> > > 
> > > Along those lines, any objection to me taking at least one other one?
> > > 3f8757078d27 ("headers/prep: usb: gadget: Fix namespace collision") and
> 
> Ack.
> 
> > > 6fb993fa3832 ("headers/deps: USB: Optimize <linux/usb/ch9.h>
> 
> Ack.

This one required me to fix up a usb core file that was only including
this .h file and not kernel.h which it also needed.  Now resolved in my
tree.

> > > dependencies, remove <linux/device.h>") look like I can take now into my
> > > USB tree with no problems.
> > 
> > Also these look good to go now:
> > 	bae9ddd98195 ("headers/prep: Fix non-standard header section: drivers/usb/cdns3/core.h")
> 
> Ack.
> 
> > 	c027175b37e5 ("headers/prep: Fix non-standard header section: drivers/usb/host/ohci-tmio.c")
> 
> Ack.
> 
> Note that these latter two patches just simplified the task of my 
> (simplistic) tooling, which is basically a shell script that inserts
> header dependencies to the head of .c and .h files, right in front of
> the first #include line it encounters.
> 
> These two patches do have some marginal clean-up value too, so I'm not 
> opposed to merging them - just wanted to declare their true role. :-)

They all are sane cleanups, so I've taken them in my tree now.  Make
your patchset a bit smaller against 5.17-rc1 when that comes around :)

thanks,

greg k-h
