Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3162E48F90B
	for <lists+linux-arch@lfdr.de>; Sat, 15 Jan 2022 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiAOTXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 Jan 2022 14:23:43 -0500
Received: from cloud48395.mywhc.ca ([173.209.37.211]:48568 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiAOTXn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jan 2022 14:23:43 -0500
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:43386 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1n8oeG-0005wd-FD; Sat, 15 Jan 2022 14:23:36 -0500
Message-ID: <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
From:   Olivier Langlois <olivier@trillion01.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Sat, 15 Jan 2022 14:23:34 -0500
In-Reply-To: <87h7a5kgan.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
         <20211213225350.27481-1-ebiederm@xmission.com>
         <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
         <87sfu3b7wm.fsf@email.froward.int.ebiederm.org> <YdniQob7w5hTwB1v@osiris>
         <87ilurwjju.fsf@email.froward.int.ebiederm.org>
         <87o84juwhg.fsf@email.froward.int.ebiederm.org>
         <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
         <87lezmrxlq.fsf@email.froward.int.ebiederm.org>
         <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
         <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
         <87h7a5kgan.fsf@email.froward.int.ebiederm.org>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2022-01-14 at 18:12 -0600, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Tue, Jan 11, 2022 at 10:51 AM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
> > > 
> > > +       while ((n == -ERESTARTSYS) &&
> > > test_thread_flag(TIF_NOTIFY_SIGNAL)) {
> > > +               tracehook_notify_signal();
> > > +               n = __kernel_write(file, addr, nr, &pos);
> > > +       }
> > 
> > This reads horribly wrongly to me.
> > 
> > That "tracehook_notify_signal()" thing *has* to be renamed before
> > we
> > have anything like this that otherwise looks like "this will just
> > loop
> > forever".
> > 
> > I'm pretty sure we've discussed that "tracehook" thing before - the
> > whole header file is misnamed, and most of the functions in theer
> > are
> > too.
> > 
> > As an ugly alternative, open-code it, so that it's clear that "yup,
> > that clears the TIF_NOTIFY_SIGNAL flag".
> 
> A cleaner alternative looks like to modify the pipe code to use
> wake_up_XXX instead of wake_up_interruptible_XXX and then have code
> that does pipe_write_killable instead of pipe_write_interruptible.

Do not forget that the problem might not be limited to the pipe FS as
Oleg Nesterov pointed out here:

https://lore.kernel.org/io-uring/20210614141032.GA13677@redhat.com/

This is why I did like your patch fixing __dump_emit. If the only
problem is the tracehook_notify_signal() function unclear name, that
should be addressed instead of trying to fix the problem in a different
way.
> 
> There is also a question of how all of this should interact with the
> freezer, as I think changing from interruptible to killable means
> that
> the coredumps became unfreezable.
> 
> I am busily simmering this on my back burner and I hope I can come up
> with something sensible.

IMHO, fixing the problem on the emit function side has the merit of
being future proof if something else than io_uring in the future would
raise the TIF_NOTIFY_SIGNAL flag

but I am wondering why no one commented anything about my proposal of
cancelling io_uring before generating the core dump therefore stopping
it to flip TIF_NOTIFY_SIGNAL while the core dump is generated.

Is there something wrong with my proposed approach?
https://lore.kernel.org/lkml/cover.1629655338.git.olivier@trillion01.com/

It did flawlessly created many dozens of io_uring app core dumps in the
last months for me...

Olivier


