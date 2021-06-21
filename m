Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BFE3AF93A
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 01:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhFUXZg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 19:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhFUXZg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 19:25:36 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F5C061574;
        Mon, 21 Jun 2021 16:23:21 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvTG3-00Azc5-0G; Mon, 21 Jun 2021 23:23:11 +0000
Date:   Mon, 21 Jun 2021 23:23:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
Message-ID: <YNEfXhi80e/VXgc9@zeniv-ca.linux.org.uk>
References: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <YNDsYk6kbisbNy3I@zeniv-ca.linux.org.uk>
 <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh82uJ5Poqby3brn-D7xWbCMnGv-JnwfO0tuRfCvsVgXA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 04:14:36PM -0700, Linus Torvalds wrote:
> On Mon, Jun 21, 2021 at 12:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Looks like sys_exit() and do_group_exit() would be the two places to
> > > do it (do_group_exit() would handle the signal case and
> > > sys_group_exit()).
> >
> > Maybe...  I'm digging through that pile right now, will follow up when
> > I get a reasonably complete picture
> 
> We might have another possible way to solve this:
> 
>  (a) make it the rule that everybody always saves the full (integer)
> register set in pt_regs
> 
>  (b) make m68k just always create that switch-stack for all system
> calls (it's really not that big, I think it's like six words or
> something)
> 
>  (c) admit that alpha is broken, but nobody really cares

	How would it help e.g. oopsen on the way out of timer interrupts?
IMO we simply shouldn't allow ptrace access if the tracee is in that kind
of state, on any architecture...
