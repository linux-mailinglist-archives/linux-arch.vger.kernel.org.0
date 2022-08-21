Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607A59B10F
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 02:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiHUAbA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 20:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUAa6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 20:30:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756EA26AC0;
        Sat, 20 Aug 2022 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=41Yr0JmCMU+AK4AyIf/PPqS/cRIRXD6tybm1KRxE/EI=; b=GRiBmHwCi4NasUevEVTsHsS9ct
        0xNYTPWvCC42cRyYFfw5b0pwo/CfjD+GYDJlQrUq52qt8l5aPf+wukjOTqNWzvRMkFFndkq4Rn6cZ
        i0MDpGCKQ5l2UQdRBRbUy8UGiCksyaMixSkpyI3Ere7DYIkSTtuoI8loW/FzBsHRfvn3GX4sS/SFB
        oLbkvB0qDBKo4G7KY3obpf2dzPonTeKdQuInm3uM05j+16VXrft4a2kuEnxLjD4iCPJ2tqkoXCE/K
        mzsurd8viZ7HfjZ4bIU3mgxM80UNer40uXnpD5PNyEB4KQwiH7Pz6FTKZI76vCFuSYgPwHQEy08Tu
        48YB4leQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPYre-006Vs4-D9;
        Sun, 21 Aug 2022 00:30:54 +0000
Date:   Sun, 21 Aug 2022 01:30:54 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC][PATCHES] termios.h cleanups
Message-ID: <YwF8vibZ2/Xz7a/g@ZenIV>
References: <YwBWJYU9BjnGBy2c@ZenIV>
 <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
 <YwErb9MnfTFCmOcA@ZenIV>
 <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh91JqnMU+aN9NEy4vB9hePFEYLtiAVtS+U6VE-17pDBg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 20, 2022 at 02:44:09PM -0700, Linus Torvalds wrote:
> On Sat, Aug 20, 2022 at 11:44 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         Umm...  Might as well, I guess...  Where to put those, though?
> > drivers/tty/tty_ioctl.c is not an option, unfortunately - it'll pick
> > the local definitions, __weak or no __weak.
> 
> IThat bug is ancient history, and tty_ioctl.c is just fine.
> 
> Yes, we used to have the "you can't have __weak function definitions
> in the same file that uses them" rule.
> 
> But it was due to a bug in gcc-4.1, which would inline weak functions.
> 
> But we long since gave up on gcc-4.1, and we have __weak functions
> declarations in the same file as the use in multiple places. See for
> example arch_release_task_struct() in kernel/fork.c.

OK, that allows to reorder the whole thing better...  See #work.termios2
(very lightly tested)
