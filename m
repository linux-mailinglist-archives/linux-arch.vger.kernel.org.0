Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EAB48445F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiADPOu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 10:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiADPOu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 10:14:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA76C061761;
        Tue,  4 Jan 2022 07:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D56E612ED;
        Tue,  4 Jan 2022 15:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528D9C36AE9;
        Tue,  4 Jan 2022 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641309288;
        bh=+PeJuC7ZBT0eKpoIvV1CdYSaxikW5lqK8tc2FJJfgT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcROUIoPJwcNDNbHa3QP242nsYdl0k6Y5JF15NuIWaJhj5oM2DiAtaPckH/Zb6u9Z
         TxiD7L/Oj0v3AAMycX9TZ7YXbp4VBor2hyFkBVHq24J53rR4nySJsgzk2LIUZdNUHF
         rBu5X3VQyAuh264VkEHrumYrMQJfMxhryivrU9qk=
Date:   Tue, 4 Jan 2022 16:14:46 +0100
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
Message-ID: <YdRkZqGuKCZcRbov@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
 <YdRM7I9E2WGU4GRg@kroah.com>
 <YdRRl+jeAm/xfU8D@gmail.com>
 <YdRjRWHgvnqVe8UZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRjRWHgvnqVe8UZ@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 04:09:57PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 04, 2022 at 02:54:31PM +0100, Ingo Molnar wrote:
> > 
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> > > > There's one happy exception though, all the uninlining patches that 
> > > > uninline a single-call function are probably fine as-is:
> > > 
> > > <snip>
> > > 
> > > >  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
> > > 
> > > Let me go take this right now, no need for this to wait, it should be
> > > out of kobject.h as you rightfully show there is only one user.
> > 
> > Sure - here you go!
> 
> I just picked it out of your git tree already :)
> 
> Along those lines, any objection to me taking at least one other one?
> 3f8757078d27 ("headers/prep: usb: gadget: Fix namespace collision") and
> 6fb993fa3832 ("headers/deps: USB: Optimize <linux/usb/ch9.h>
> dependencies, remove <linux/device.h>") look like I can take now into my
> USB tree with no problems.

Also these look good to go now:
	bae9ddd98195 ("headers/prep: Fix non-standard header section: drivers/usb/cdns3/core.h")
	c027175b37e5 ("headers/prep: Fix non-standard header section: drivers/usb/host/ohci-tmio.c")


thanks,

greg k-h
