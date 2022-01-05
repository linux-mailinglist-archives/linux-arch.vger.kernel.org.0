Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC9485C4C
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiAEXfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 18:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245409AbiAEXfE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 18:35:04 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F54C061245;
        Wed,  5 Jan 2022 15:35:04 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5Fo3-00HaHI-UG; Wed, 05 Jan 2022 23:35:00 +0000
Date:   Wed, 5 Jan 2022 23:34:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 02/10] exit: Add and use make_task_dead.
Message-ID: <YdYrIysEd6fDVEVk@zeniv-ca.linux.org.uk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-2-ebiederm@xmission.com>
 <YdUmN7n4W5YETUhW@zeniv-ca.linux.org.uk>
 <871r1l9ai5.fsf@email.froward.int.ebiederm.org>
 <YdYTV9gQEPxssuZe@zeniv-ca.linux.org.uk>
 <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wggCHypiukgs2_tm-00r2xaAkG8MQjuZtSNoG_umg7Rrg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 02:51:05PM -0800, Linus Torvalds wrote:
> On Wed, Jan 5, 2022 at 1:53 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Jan 05, 2022 at 02:46:10PM -0600, Eric W. Biederman wrote:
> > >
> > > Being in assembly it did not have anything after the name do_exit so it
> > > hid from my regex "[^A-Za-z0-9_]do_exit[^A-Za-z0-9]".  Thank you for
> > > finding that.
> >
> > Umm...  What's wrong with '\<do_exit\>'?
> 
> Christ people, you both make it so complicated.
> 
> If you want to search for 'do_exit', just do
> 
>         git grep -w do_exit
> 
> where that '-w' does exactly that "word boundary" thing.

Sure.

> I thought everybody knew about this, because it's such a common thing
> to do - checking my shell history, more than a third of my "git grep"
> uses use '-w', exactly because it's very convenient for identifier
> lookup
> 
> But yes, in more complex cases where you have other parts to the
> pattern (ie you're not looking *just* for a single word), by all means
> use '\<' and/or '\>'.

Yep.  I wanted to make it clear that you really don't need that kind
of horrors ([^A-Za-z0-9_]); sure, on the ends of regex you just need
-w and that's it, but it's not needed in more convoluted cases either.

BTW, it doesn't have to be "have other parts of pattern" - IME the typical
case when -w is not enough is something like

git grep -n '\<wait_for_completion'
