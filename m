Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1321F60513A
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiJSUXR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJSUXO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 16:23:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FC1C7134;
        Wed, 19 Oct 2022 13:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13EE1B822EB;
        Wed, 19 Oct 2022 20:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5818C433D6;
        Wed, 19 Oct 2022 20:23:09 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqPZ2kwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666210988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6TSG2vrF4L7U0TmIuYTMcX432T1AzPyXPqLh8FCHzYM=;
        b=lqPZ2kwyeB5qBygjZyi5SR7/J0j5oEwteqw5LXX4ixsXcBUi4I/WVv6IXWL4k2UxEVHj+E
        WaXtd5/5DlP8yuvKLqjg+tQ+YWXoFMnUKOYEXPQOc+aUfnxpvhaHFxhvvANWnGMDg2lu2p
        dJauqgiam8nth1lXao18VDlv8Jkt1+k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8bccd0b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Oct 2022 20:23:08 +0000 (UTC)
Date:   Wed, 19 Oct 2022 14:23:01 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Wed, Oct 19, 2022 at 12:54:06PM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 9:27 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > So let's just eliminate this particular variety of heisensigned bugs
> > entirely. Set `-fsigned-char` globally, so that gcc makes the type
> > signed on all architectures.
> 
> Btw, I do wonder if we might actually be better off doing this - but
> doing it the other way around.

That could work. The argument here would be that most people indeed
treat char as a byte. I'll send a v2 doing this.

This will probably break some things, though, on drivers that are
already broken on e.g. ARM. For example, the wifi driver I fixed that
started this whole thing would now be broken on x86 too. But also, we're
barely past rc1, so maybe this is something to do now, and then we'll
spend the rest of the 6.1 cycle fixing issues as the pop up? Sounds fine
to me if you think that's doable.

Either way, I'll send a patch and you can do with it what you think is
best.

Jason
