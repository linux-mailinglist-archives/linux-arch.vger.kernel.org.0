Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DF649CD4D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242560AbiAZPG1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 10:06:27 -0500
Received: from cloud48395.mywhc.ca ([173.209.37.211]:60350 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPG1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jan 2022 10:06:27 -0500
Received: from [45.44.224.220] (port=43668 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1nCjsO-0004Xu-Ld; Wed, 26 Jan 2022 10:06:24 -0500
Message-ID: <719907481ee811fb7556deec1469a20edf0b5cdd.camel@trillion01.com>
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
From:   Olivier Langlois <olivier@trillion01.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Wed, 26 Jan 2022 10:06:23 -0500
In-Reply-To: <87ee56e43r.fsf@email.froward.int.ebiederm.org>
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
         <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
         <87ee56e43r.fsf@email.froward.int.ebiederm.org>
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

On Mon, 2022-01-17 at 10:09 -0600, Eric W. Biederman wrote:
> Olivier Langlois <olivier@trillion01.com> writes:
> From my perspective I am not at all convinced that io_uring is the
> only
> culprit.
> 
> Beyond that the purpose of a coredump is to snapshot the process as
> it
> is, before anything is shutdown so that someone can examine the
> coredump
> and figure out what failed.  Running around changing the state of the
> process has a very real chance of hiding what is going wrong.
> 
> Further your change requires that there be a place for io_uring to
> clean
> things up.  Given that fundamentally that seems like the wrong thing
> to
> me I am not interested in making it easy to what looks like the wrong
> thing.
> 
> All of this may be perfection being the enemy of the good (especially
> as
> your io_uring magic happens as a special case in do_coredump).  My
> work
> in this area is to remove hacks so I can be convinced the code works
> 100% of the time so unfortunately I am not interested in pick up a
> change that is only good enough.  Someone else like Andrew Morton
> might
> be.
> 
> 
Fair enough.

You do bring good points but I am not so sure about the second one
considering that the coredump is meant to be a snapshot and if io_uring
still runs, the state may change as the dump is generated anyway.

I'll follow with interest what you finally come up with but my mindset
when I wrote the patch was that there does not seem to be any benefit
keeping io_uring active while coredumping and it has the potential to
create nasty issues.

I did stumble into core file truncation problem.

Pavel got that when modifying io_uring code:
https://lore.kernel.org/all/1b519092-2ebf-3800-306d-c354c24a9ad1@gmail.com/

and I find very likely that keeping io_uring active while coredumping
might create new nasty but subtle issues down the road...

Greetings,
Olivier

