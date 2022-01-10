Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA87848A1AE
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 22:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbiAJVSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 16:18:30 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:57638 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbiAJVS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 16:18:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50624)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n723e-004JIM-N4; Mon, 10 Jan 2022 14:18:26 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:55924 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n723d-006ley-N9; Mon, 10 Jan 2022 14:18:26 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <20220103213312.9144-8-ebiederm@xmission.com>
        <CAMuHMdWsNBjOJh0QEx9sppA9x3WoL8H2icqukNqECFhOPremjw@mail.gmail.com>
        <YdxcszwEslyQJSuF@zeniv-ca.linux.org.uk>
        <CAMuHMdX9nhUQe_jeQCUtXeQgcQ5MBiHpPiRexh86EssoHNtJ3Q@mail.gmail.com>
        <YdyZEAWKVTVnq2ef@zeniv-ca.linux.org.uk>
Date:   Mon, 10 Jan 2022 15:18:18 -0600
In-Reply-To: <YdyZEAWKVTVnq2ef@zeniv-ca.linux.org.uk> (Al Viro's message of
        "Mon, 10 Jan 2022 20:37:36 +0000")
Message-ID: <87zgo3thlx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n723d-006ley-N9;;;mid=<87zgo3thlx.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185tqCdbMXD+YaCSV+3dCINElFLxfX3dJs=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4947]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 412 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (2.2%), b_tie_ro: 8 (1.8%), parse: 1.03 (0.2%),
        extract_message_metadata: 13 (3.1%), get_uri_detail_list: 1.34 (0.3%),
        tests_pri_-1000: 11 (2.6%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.10 (0.3%), tests_pri_-90: 145 (35.3%), check_bayes:
        143 (34.7%), b_tokenize: 7 (1.7%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 123 (29.8%), b_finish: 0.97
        (0.2%), tests_pri_0: 214 (52.0%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 11 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 10, 2022 at 06:54:57PM +0100, Geert Uytterhoeven wrote:
>
>> In fact Michael did so in "[PATCH v7 1/2] m68k/kernel - wire up
>> syscall_trace_enter/leave for m68k"[1], but that's still stuck...
>> 
>> [1] https://lore.kernel.org/r/1624924520-17567-2-git-send-email-schmitzmic@gmail.com/
>
> Looks sane, but I'd split it in two - switch to calling syscall_trace_{enter,leave}
> and then handling the return values...
>
> The former would keep the current behaviour (modulo reporting enter vs. leave
> via PTRACE_GETEVENTMSG), the latter would allow syscall number change by tracer
> and/or handling of seccomp/audit/whatnot.
>
> For exit+signal work the former would suffice, and IMO it would be a good idea
> to put that one into a shared branch to be pulled both by seccomp and by signal
> series.  Would reduce the conflicts...
>
> Objections?

I have the version that Geert ack'ed queued up for v5.17 in my
signal-for-v5.17 branch, along with a couple others prior fixes in this
series of changes where it was clear they were just obviously correct
bug fixes.  No need to delay the removal of profiling bits for example.

I would love to see the m68k perform syscall_trace_{enter,leave} but
just getting as far as ptrace_report_syscall will be enough to avoid any
dependencies on my side.

Eric
