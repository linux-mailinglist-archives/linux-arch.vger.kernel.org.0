Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6530943650A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJUPIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 11:08:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55140 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhJUPIu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 11:08:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:47110)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZeI-00HRzW-LT; Thu, 21 Oct 2021 09:06:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50622 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZeH-00CWxY-Hi; Thu, 21 Oct 2021 09:06:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-18-ebiederm@xmission.com>
        <YXERhzKOVzGJoNMN@kroah.com>
Date:   Thu, 21 Oct 2021 10:06:22 -0500
In-Reply-To: <YXERhzKOVzGJoNMN@kroah.com> (Greg KH's message of "Thu, 21 Oct
        2021 09:06:47 +0200")
Message-ID: <875ytqifip.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdZeH-00CWxY-Hi;;;mid=<875ytqifip.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/afZzUN9FSzTK9R8sFXt+HdCBvLvrywHY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Greg KH <gregkh@linuxfoundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 433 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.2%), parse: 0.82
        (0.2%), extract_message_metadata: 14 (3.3%), get_uri_detail_list: 1.28
        (0.3%), tests_pri_-1000: 23 (5.4%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 82 (18.8%), check_bayes:
        79 (18.2%), b_tokenize: 7 (1.5%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 59 (13.7%), b_finish: 0.81
        (0.2%), tests_pri_0: 287 (66.3%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 3.7 (0.8%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 18/20] exit/rtl8723bs: Replace the macro thread_exit with a simple return 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Oct 20, 2021 at 12:44:04PM -0500, Eric W. Biederman wrote:
>> Every place thread_exit is called is at the end of a function started
>> with kthread_run.  The code in kthread_run has arranged things so a
>> kernel thread can just return and do_exit will be called.
>> 
>> So just have the threads return instead of calling complete_and_exit.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  drivers/staging/rtl8723bs/core/rtw_cmd.c                | 2 +-
>>  drivers/staging/rtl8723bs/core/rtw_xmit.c               | 2 +-
>>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c          | 2 +-
>>  drivers/staging/rtl8723bs/include/osdep_service_linux.h | 2 --
>>  4 files changed, 3 insertions(+), 5 deletions(-)
>
> You "forgot" to cc: the linux-staging and the staging driver maintainer
> on these drivers/staging/ changes...

Yes I did.  Sorry about that.

> Anyway, they look fine to me, but you will get some conflicts with some
> of these changes based on cleanups already in my staging-next tree (in
> linux-next if you want to see them).  But feel free to take these all in
> your tree if that makes it easier:

I just did a test merge and there was one file that was completely
removed and one file with had changes a line or two above where my code
changed.  So nothing too difficult to result.

I don't really mind either way.  But keeping them all in one tree makes
them easier to keep track of, and allows me to do things like see if
I can remove EXPORT_SYMBOL(do_exit) as Christoph suggested.

Eric

> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
