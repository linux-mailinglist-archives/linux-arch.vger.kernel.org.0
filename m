Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6091436808
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhJUQjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:39:52 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42986 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbhJUQjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:39:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41788)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb4N-001Jtm-KY; Thu, 21 Oct 2021 10:37:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55830 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdb4M-00CmEw-Gn; Thu, 21 Oct 2021 10:37:31 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-14-ebiederm@xmission.com>
        <202110210925.9DEAF27CA@keescook>
Date:   Thu, 21 Oct 2021 11:37:23 -0500
In-Reply-To: <202110210925.9DEAF27CA@keescook> (Kees Cook's message of "Thu,
        21 Oct 2021 09:25:36 -0700")
Message-ID: <878rymbags.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdb4M-00CmEw-Gn;;;mid=<878rymbags.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5uF2JtmE/Kc+XrBqzEk3qfCQQ0B1hi+U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 330 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 11 (3.4%), b_tie_ro: 9 (2.9%), parse: 1.46 (0.4%),
         extract_message_metadata: 17 (5.1%), get_uri_detail_list: 1.12 (0.3%),
         tests_pri_-1000: 28 (8.4%), tests_pri_-950: 3.3 (1.0%),
        tests_pri_-900: 1.54 (0.5%), tests_pri_-90: 54 (16.3%), check_bayes:
        51 (15.5%), b_tokenize: 9 (2.7%), b_tok_get_all: 7 (2.2%),
        b_comp_prob: 2.8 (0.8%), b_tok_touch_all: 28 (8.4%), b_finish: 1.40
        (0.4%), tests_pri_0: 195 (59.0%), check_dkim_signature: 0.96 (0.3%),
        check_dkim_adsp: 4.5 (1.4%), poll_dns_idle: 0.95 (0.3%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 13 (3.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals on failure
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Oct 20, 2021 at 12:44:00PM -0500, Eric W. Biederman wrote:
>> Use force_fatal_sig instead of calling do_exit directly.  This ensures
>> the ordinary signal handling path gets invoked, core dumps as
>> appropriate get created, and for multi-threaded processes all of the
>> threads are terminated not just a single thread.
>
> Yeah, looks good. Should be no visible behavior change.

It is observable in that an entire multi-threaded process gets
terminated instead of a single thread.  But since these events should
be handling of extra-ordinary events I don't expect there is anyone
who wants to have a thread of their process survive.

Eric

