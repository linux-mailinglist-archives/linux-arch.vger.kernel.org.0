Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3764C30F9
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiBXQIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 11:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiBXQId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 11:08:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6E17EDA1;
        Thu, 24 Feb 2022 08:07:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329D76179C;
        Thu, 24 Feb 2022 16:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D2AC340EC;
        Thu, 24 Feb 2022 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645718654;
        bh=jWymqgAfcR3qfS82nYoUUc+s4THWcAw77Lv/fLqZeHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VabpdoNHIcm5/kDkYE0JsGzkAuL1Vu3lh9leQX9oYtKdf1JOHFzhmjAHgUrLuH+pa
         pE8tAwzkQ3Mfe/q0S1NpFUDifbW3oA9eosOKPtqHxhm2VxX4MA79dbR4JGTzG+Kmqa
         56eTw1xPUqlWsvKSMgpE9LMQ7kKsYS3gBpaJ2CRAgNnQFz6tIAwBenWIdSPGHbv0em
         rc+plY3fkKWk/6EcaT9eOxEgzSimHWjGKgGIfRjoBJ5fpLJ1KsJJHjOTQvQSB8V9cs
         LDulc5OVBeKGu+zXjQw75iauwMAwvQUEy/E/94fNp8HvQCYgbQW/io6nXvDGtR+sJa
         dOA6jaultOxgg==
Date:   Thu, 24 Feb 2022 09:04:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, llvm@lists.linux.dev
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
Message-ID: <YheseEX+xD5q1aAd@dev-arch.archlinux-ax161>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com>
 <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com>
 <CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com>
 <CAHk-=wgLe-OSLTEHm=V7eRG6Fcr0dpAM1ZRV1a=R_g6pBOr8Bg@mail.gmail.com>
 <CAK8P3a0DOC3s7x380XR_kN8UYQvkRqvE5LkHQfK2-KzwhcYqQQ@mail.gmail.com>
 <CAHk-=wicJ0VxEmnpb8=TJfkSDytFuf+dvQJj8kFWj0OF2FBZ9w@mail.gmail.com>
 <CAK8P3a2b_RtXkhQ2pwqbZ1zz6QtjaWwD4em_MCF_wGXRwZirKA@mail.gmail.com>
 <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh97QY9fEQUK6zMVQwaQ_JWDvR=R+TxQ_0OYrMHQ+egvQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 01:53:39PM -0800, Linus Torvalds wrote:
> On Wed, Feb 23, 2022 at 1:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > > Ok, so we should be able to basically convert '--std=gnu89' into
> > > '--std=gnu11 -Wno-shift-negative-value' with no expected change of
> > > behavior.
> >
> > Yes, I think that is correct.
> 
> Ok, somebody please remind me, and let's just try this early in the
> 5.18 merge window.
> 
> Because at least for me, doing
> 
> -                  -std=gnu89
> +                  -std=gnu11 -Wno-shift-negative-value
> 
> for KBUILD_CFLAGS works fine both in my gcc and clang builds. But
> that's obviously just one version of each.

I ran that diff through my set of clang builds on
v5.17-rc5-21-g23d04328444a and only found one issue:

https://github.com/ClangBuiltLinux/linux/issues/1603

I think that should be fixed on the clang side. Once it is, I think we
could just disable that warning in those translation units for older
versions of clang to keep the status quo.

Cheers,
Nathan
