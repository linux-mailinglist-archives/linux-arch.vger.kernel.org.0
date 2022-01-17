Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C4490C1E
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiAQQJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 17 Jan 2022 11:09:56 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:58430 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240818AbiAQQJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 11:09:40 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38868)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9UZe-00HJYy-1g; Mon, 17 Jan 2022 09:09:38 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:44298 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9UZc-00FVMc-Oj; Mon, 17 Jan 2022 09:09:37 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Olivier Langlois <olivier@trillion01.com>
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
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211213225350.27481-1-ebiederm@xmission.com>
        <CAHk-=wiS2P+p9VJXV_fWd5ntashbA0QVzJx15rTnWOCAAVJU_Q@mail.gmail.com>
        <87sfu3b7wm.fsf@email.froward.int.ebiederm.org>
        <YdniQob7w5hTwB1v@osiris>
        <87ilurwjju.fsf@email.froward.int.ebiederm.org>
        <87o84juwhg.fsf@email.froward.int.ebiederm.org>
        <57dfc87c7dd5a2f9f9841bba1185336016595ef7.camel@trillion01.com>
        <87lezmrxlq.fsf@email.froward.int.ebiederm.org>
        <87mtk2qf5s.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wjZ=aFzFb0BkxVEbN3o6a53R8Gq4hHnEZVCmpDKs3_FCw@mail.gmail.com>
        <87h7a5kgan.fsf@email.froward.int.ebiederm.org>
        <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
Date:   Mon, 17 Jan 2022 10:09:28 -0600
In-Reply-To: <991211d94c6dc0ad3501cd9f830cdee916b982b3.camel@trillion01.com>
        (Olivier Langlois's message of "Sat, 15 Jan 2022 14:23:34 -0500")
Message-ID: <87ee56e43r.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n9UZc-00FVMc-Oj;;;mid=<87ee56e43r.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RCqiXptE75sBjTr0WM3bA53Ca83Pe8DA=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong,XM_B_Phish66,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Olivier Langlois <olivier@trillion01.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 676 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.73
        (0.3%), extract_message_metadata: 23 (3.4%), get_uri_detail_list: 3.5
        (0.5%), tests_pri_-1000: 30 (4.4%), tests_pri_-950: 1.44 (0.2%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 105 (15.6%), check_bayes:
        95 (14.0%), b_tokenize: 11 (1.7%), b_tok_get_all: 12 (1.8%),
        b_comp_prob: 4.4 (0.7%), b_tok_touch_all: 63 (9.3%), b_finish: 1.33
        (0.2%), tests_pri_0: 480 (71.0%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 3.2 (0.5%), poll_dns_idle: 0.87 (0.1%), tests_pri_10:
        3.1 (0.5%), tests_pri_500: 14 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] signal: Make SIGKILL during coredumps an explicit
 special case
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Olivier Langlois <olivier@trillion01.com> writes:

> On Fri, 2022-01-14 at 18:12 -0600, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > On Tue, Jan 11, 2022 at 10:51 AM Eric W. Biederman
>> > <ebiederm@xmission.com> wrote:
>> > > 
>> > > +       while ((n == -ERESTARTSYS) &&
>> > > test_thread_flag(TIF_NOTIFY_SIGNAL)) {
>> > > +               tracehook_notify_signal();
>> > > +               n = __kernel_write(file, addr, nr, &pos);
>> > > +       }
>> > 
>> > This reads horribly wrongly to me.
>> > 
>> > That "tracehook_notify_signal()" thing *has* to be renamed before
>> > we
>> > have anything like this that otherwise looks like "this will just
>> > loop
>> > forever".
>> > 
>> > I'm pretty sure we've discussed that "tracehook" thing before - the
>> > whole header file is misnamed, and most of the functions in theer
>> > are
>> > too.
>> > 
>> > As an ugly alternative, open-code it, so that it's clear that "yup,
>> > that clears the TIF_NOTIFY_SIGNAL flag".
>> 
>> A cleaner alternative looks like to modify the pipe code to use
>> wake_up_XXX instead of wake_up_interruptible_XXX and then have code
>> that does pipe_write_killable instead of pipe_write_interruptible.
>
> Do not forget that the problem might not be limited to the pipe FS as
> Oleg Nesterov pointed out here:
>
> https://lore.kernel.org/io-uring/20210614141032.GA13677@redhat.com/
>
> This is why I did like your patch fixing __dump_emit. If the only
> problem is the tracehook_notify_signal() function unclear name, that
> should be addressed instead of trying to fix the problem in a different
> way.

It might be that the fix is to run a portion of the exit_to_userspace
loop that does:

	if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
		handle_signal_work(regs, ti_work);

I am deep in brainstorm mode trying to find something that comes out
clean.

Oleg is right that while to be POSIX compliant and otherwise compatible
with traditional unix behavior sleeps in filesystems need to be
uninterruptible.  NFS has not always provided that compatibility.


>> There is also a question of how all of this should interact with the
>> freezer, as I think changing from interruptible to killable means
>> that
>> the coredumps became unfreezable.
>> 
>> I am busily simmering this on my back burner and I hope I can come up
>> with something sensible.
>
> IMHO, fixing the problem on the emit function side has the merit of
> being future proof if something else than io_uring in the future would
> raise the TIF_NOTIFY_SIGNAL flag
>
> but I am wondering why no one commented anything about my proposal of
> cancelling io_uring before generating the core dump therefore stopping
> it to flip TIF_NOTIFY_SIGNAL while the core dump is generated.
>
> Is there something wrong with my proposed approach?
> https://lore.kernel.org/lkml/cover.1629655338.git.olivier@trillion01.com/
>
> It did flawlessly created many dozens of io_uring app core dumps in the
> last months for me...

From my perspective I am not at all convinced that io_uring is the only
culprit.

Beyond that the purpose of a coredump is to snapshot the process as it
is, before anything is shutdown so that someone can examine the coredump
and figure out what failed.  Running around changing the state of the
process has a very real chance of hiding what is going wrong.

Further your change requires that there be a place for io_uring to clean
things up.  Given that fundamentally that seems like the wrong thing to
me I am not interested in making it easy to what looks like the wrong
thing.

All of this may be perfection being the enemy of the good (especially as
your io_uring magic happens as a special case in do_coredump).  My work
in this area is to remove hacks so I can be convinced the code works
100% of the time so unfortunately I am not interested in pick up a
change that is only good enough.  Someone else like Andrew Morton might
be.


None of that changes the fact that tracehook_notify_signal needs to be
renamed.  That effects your approach and my proof of concept approach.
So renaming tracehook_notify_signal just needs to be done.

Eric
