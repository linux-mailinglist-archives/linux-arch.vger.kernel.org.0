Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE02487CB3
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiAGTBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 14:01:41 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:40118 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiAGTBk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 14:01:40 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:58856)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uUc-00HEXO-Sv; Fri, 07 Jan 2022 12:01:38 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:48588 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n5uUb-002BFF-JJ; Fri, 07 Jan 2022 12:01:38 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Wed, 5 Jan 2022 05:48:08 +0000")
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <20211208202532.16409-3-ebiederm@xmission.com>
        <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 07 Jan 2022 12:59:33 -0600
Message-ID: <87tuefwewa.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n5uUb-002BFF-JJ;;;mid=<87tuefwewa.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ylOQ812OzYa8pP/ypTCEqNmeufvP4Onc=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 560 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 0.87 (0.2%),
         extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.47 (0.3%),
         tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.58 (0.3%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 94 (16.9%), check_bayes:
        91 (16.3%), b_tokenize: 14 (2.5%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 4.8 (0.9%), b_tok_touch_all: 58 (10.4%), b_finish: 1.04
        (0.2%), tests_pri_0: 414 (73.9%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 1.21 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Wed, Dec 08, 2021 at 02:25:25PM -0600, Eric W. Biederman wrote:
>> -	/*
>> -	 * If do_exit is called because this processes oopsed, it's possible
>> -	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
>> -	 * continuing. Amongst other possible reasons, this is to prevent
>> -	 * mm_release()->clear_child_tid() from writing to a user-controlled
>> -	 * kernel address.
>> -	 */
>> -	force_uaccess_begin();
>
> Are you sure about that one?  It shouldn't matter, but... it's a potential
> change for do_exit() from a kernel thread.  As it is, we have that
> force_uaccess_begin() for exiting threads and for kernel ones it's not
> a no-op.  I'm not concerned about attempted userland access after that
> point for those, obviously, but I'm not sure you won't step into something
> subtle here.
>
> I would prefer to split that particular change off into a separate commit...

Thank you for catching that.  I was leaning too much on the description
in the comment of why force_uaccess_begin is there.

Catching up on the state of set_fs/get_fs removal it appears like a lot
of progress has been made and on a lot of architectures set_fs/get_fs is
just gone, and force_uaccess_begin is a noop.

On architectures that still have set_fs/get_fs it appears all of the old
warts are present and kernel threads still run with set_fs(KERNEL_DS).

Assuming it won't be too much longer before the rest of the arches have
set_fs/get_fs removed it looks like it makes sense to leave the
force_uaccess_begin where it is, and just let force_uaccess_begin be
removed when set_fs/get_fs are removed from the tree.

Christoph does it look like the set_fs/get_fs removal work is going
to stall indefinitely on some architectures?  If so I think we want to
find a way to get kernel threads to run with set_fs(USER_DS) on the
stalled architectures.  Otherwise I think we have a real hazard of
introducing bugs that will only show up on the stalled architectures.

I finally understand now why when I updated set_child_tid in the kthread
code early in fork why x86 was fine another architecture was not.

Eric
