Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FC59AFC4
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 20:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiHTSq3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 14:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbiHTSqM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 14:46:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517BE2A26E;
        Sat, 20 Aug 2022 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VVZP6ZQhgTqqYIs/Rt6urxweEdWNsRk/iiS3JVFv1uQ=; b=CKPQfWBzgswUFZR1fEIKKtGn5M
        1UUwUUvCWUFMntsLJAm6GXl1rhDDERlmboW5Gd+ewqaPmhylRM6xfMxdkmRiLoCOAa1sBbamnmQS4
        bd7gHsF3uG36ZC/6IVwr/gH6savYK1ZWF2QBc5n7Mr9IMbfZsNNkign6CrQ/6NTBy8fLN0iohja1Z
        M4PBWL19EpQL844zgyOIRhhRHq9HQisWq5hszcqtbXJOc1PzdsUAEmXQAvo/mwUcZKfZXXRwntEwK
        KsnDbBzFEuQZZK+7cXl8li3tB5TZtxqp9xDp33mJUTWxfHf04dnnXem83tgm/yrh9ziTvtaBQ53c4
        lFdqazGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPTRw-006S1Z-0k;
        Sat, 20 Aug 2022 18:44:00 +0000
Date:   Sat, 20 Aug 2022 19:43:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][PATCHES] termios.h cleanups
Message-ID: <YwErb9MnfTFCmOcA@ZenIV>
References: <YwBWJYU9BjnGBy2c@ZenIV>
 <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 20, 2022 at 11:14:19AM -0700, Linus Torvalds wrote:
> On Fri, Aug 19, 2022 at 8:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > It takes the helpers and INIT_C_CC into new header (termios-internal.h),
> > with defaults being in linux/termios-internal.h, unless an arch-specific
> > variant is provided in asm/termios-internal.h (only alpha and sparc end
> > up needing that).  Files that need that stuff (all 4 of them) include
> > linux/termios-internal.h.
> 
> I don't see anything obviously wrong here, and my main reaction is
> actually that I wish this went a bit further, and moved the whole
> kernel_termios_to_user_termios stuff into C code rather than having
> them in headers.
> 
> I don't think it's really worth inlining those things, and I wonder if
> we could just have the default "just copy directly to/from user space"
> as __weak functions, and then allow sparc and alpha to override them?

	Umm...  Might as well, I guess...  Where to put those, though?
drivers/tty/tty_ioctl.c is not an option, unfortunately - it'll pick
the local definitions, __weak or no __weak.  drivers/tty/termios.c
just for those?  Looks just as convoluted as having those as inlines...
