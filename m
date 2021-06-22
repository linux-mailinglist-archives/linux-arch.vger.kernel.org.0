Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB51B3B0E81
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 22:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFVUVZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFVUVZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 16:21:25 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737DC061574;
        Tue, 22 Jun 2021 13:19:09 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvmrH-00BHkC-6N; Tue, 22 Jun 2021 20:18:55 +0000
Date:   Tue, 22 Jun 2021 20:18:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
Message-ID: <YNJFr5xUOm91Vy1r@zeniv-ca.linux.org.uk>
References: <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
 <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
 <de5f0132-eed4-f1d0-ddd2-f65a62de6b81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de5f0132-eed4-f1d0-ddd2-f65a62de6b81@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 23, 2021 at 08:04:11AM +1200, Michael Schmitz wrote:

> All syscalls that _do_ save the switch stack are currently called through
> wrappers which pull the syscall arguments out of the saved pt_regs on the
> stack (pushing the switch stack after the SAVE_ALL saved stuff buries the
> syscall arguments on the stack, see comment about m68k_clone(). We'd have to
> push the switch stack _first_ when entering system_call to leave the syscall
> arguments in place, but that will require further changes to the syscall
> exit path (currently shared with the interrupt exit path). Not to mention
> the register offset calculations in arch/m68k/kernel/ptrace.c, and perhaps a
> few other dependencies that don't come to mind immediately.
> 
> We have both pt_regs and switch_stack in uapi/asm/ptrace.h, but the ordering
> of the two is only mentioned in a comment. Can we reorder them on the stack,
> as long as we don't change the struct definitions proper?
> 
> This will take a little more time to work out and test - certainly not
> before the weekend. I'll send a corrected version of my debug patch before
> that.

This is insane, *especially* on m68k where you have the mess with different
frame layouts and associated ->stkadj crap (see mangle_kernel_stack() for
the (very) full barfbag).
