Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFF4737FC
	for <lists+linux-arch@lfdr.de>; Mon, 13 Dec 2021 23:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbhLMWvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Dec 2021 17:51:06 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:41038 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbhLMWvF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Dec 2021 17:51:05 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45234)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwu9w-0081F3-BK; Mon, 13 Dec 2021 15:51:04 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:60372 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mwu9v-007pJx-7N; Mon, 13 Dec 2021 15:51:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 13 Dec 2021 16:50:56 -0600
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 08 Dec 2021 14:17:22 -0600")
Message-ID: <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mwu9v-007pJx-7N;;;mid=<87bl1kunjj.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ldPosCXFTTNb6Bl3CGqPIXoijxcUBdx4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TooManySym_01,T_TooManySym_02,
        XMNoVowels,XM_B_Phish66 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4954]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 372 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (3.4%), b_tie_ro: 11 (2.9%), parse: 1.43
        (0.4%), extract_message_metadata: 4.9 (1.3%), get_uri_detail_list:
        1.90 (0.5%), tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.89 (0.5%),
        tests_pri_-900: 1.43 (0.4%), tests_pri_-90: 98 (26.4%), check_bayes:
        96 (25.8%), b_tokenize: 9 (2.3%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 3.0 (0.8%), b_tok_touch_all: 73 (19.7%), b_finish: 1.19
        (0.3%), tests_pri_0: 219 (58.8%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 3.5 (0.9%), poll_dns_idle: 0.86 (0.2%), tests_pri_10:
        3.9 (1.1%), tests_pri_500: 11 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/8] signal: Cleanup of the signal->flags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


The special case of SIGKILL during coredumps is very fragile today and
while reading through the code I realized I have almost broken it twice.
So this simplifies that special case, removes SIGNAL_GROUP_COREDUMP
which has become unnecessary with the addition of signal->core_state,
and this removes the helper signal_group_exit which is misnamed and
is not used properly.

If you squint very hard there might be a user space visible difference
in behavior somewhere but I don't think there is one in practice.

These patches are on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git/ signal-for-v5.17

After these patches have been reviewed it is my plan to apply them to my
signal-for-v5.17 branch.

Eric W. Biederman (8):
      signal: Make SIGKILL during coredumps an explicit special case
      signal: Drop signals received after a fatal signal has been processed
      signal: Have the oom killer detect coredumps using signal->core_state
      signal: During coredumps set SIGNAL_GROUP_EXIT in zap_process
      signal: Remove SIGNAL_GROUP_COREDUMP
      coredump: Stop setting signal->group_exit_task
      signal: Rename group_exit_task group_exec_task
      signal: Remove the helper signal_group_exit

 fs/coredump.c                | 20 +++++++++-----------
 fs/exec.c                    | 10 +++++-----
 include/linux/sched/signal.h | 18 +++---------------
 kernel/exit.c                | 12 ++++++++----
 kernel/signal.c              | 24 ++++++++++++++++--------
 mm/oom_kill.c                |  2 +-
 6 files changed, 42 insertions(+), 44 deletions(-)

Eric
