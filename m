Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55CF4C2AE2
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 12:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiBXL0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 06:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiBXL0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 06:26:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590129A56B;
        Thu, 24 Feb 2022 03:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0509461806;
        Thu, 24 Feb 2022 11:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE968C340E9;
        Thu, 24 Feb 2022 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645701967;
        bh=c9g/jUJtCUw9sivZ3lkoycxnPjQ1WqrUDK+4vvMZAhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNfUenic21FUYcVgChtpf/OKbUtHvXzNJTMffYLsbZRJ+ydTkUPhK6jQSqZUCUXrF
         lSR0NyoGcrNUJ3fH7EkgdKI5ChXw1/kKiLnKHsK0afT7hfZSkKr7cD6CvQBmPxmukA
         PETIYkqoOWChOY1svgopA/zWJ+2V6cLgS5I/ZyjA=
Date:   Thu, 24 Feb 2022 12:26:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristiano Giuffrida <c.giuffrida@vu.nl>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Message-ID: <YhdrTHeMzSqozGDY@kroah.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
 <86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com>
 <6d191223d93249a98511177d4af08420@pexch012b.vu.local>
 <CANWxqZmDjfhw78ZmbS6H8Y+qurRC7jirm_rgb5WUYJYw7GrEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWxqZmDjfhw78ZmbS6H8Y+qurRC7jirm_rgb5WUYJYw7GrEmg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 11:46:40AM +0100, Cristiano Giuffrida wrote:
> I think the "problem" with this solution is that it doesn't prevent
> `tmp` from being used outside the loop still (and people getting it
> wrong again)? It would be good to have 'struct gr_request *tmp;' being
> visible only inside the loop (i.e., declared in the macro).

That is a larger change, one that we can hopefully make when changing to
introduce the temp variable in the loop_for_each() macro as Linus
described elsewhere in the thread.

But for now, it should be pretty obvious to not touch tmp again after
the loop is done.  That should make it easier to check for stuff like
this as well in an automated fashion (i.e. the loop variable is only
touched inside the loop.)

thanks,

greg k-h
