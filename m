Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D42202F3
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 05:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGODgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 23:36:01 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42686 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGODgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 23:36:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvYD7-000181-1R; Tue, 14 Jul 2020 21:35:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvYD5-0005mz-Hq; Tue, 14 Jul 2020 21:35:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200714105505.935079-1-hch@lst.de>
        <20200714105505.935079-7-hch@lst.de>
Date:   Tue, 14 Jul 2020 22:33:05 -0500
In-Reply-To: <20200714105505.935079-7-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Jul 2020 12:55:05 +0200")
Message-ID: <87v9ip4fm6.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvYD5-0005mz-Hq;;;mid=<87v9ip4fm6.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jRvo1LY05IcyELAS/Dyw89Gb+7bU2HOk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4841]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1061 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.2%), b_tie_ro: 11 (1.0%), parse: 1.41
        (0.1%), extract_message_metadata: 20 (1.9%), get_uri_detail_list: 2.2
        (0.2%), tests_pri_-1000: 15 (1.4%), tests_pri_-950: 1.37 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 122 (11.5%), check_bayes:
        117 (11.0%), b_tokenize: 14 (1.4%), b_tok_get_all: 9 (0.9%),
        b_comp_prob: 4.2 (0.4%), b_tok_touch_all: 84 (7.9%), b_finish: 2.5
        (0.2%), tests_pri_0: 256 (24.1%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 609 (57.4%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 625 (59.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Both exec and exit want to ensure that the uaccess routines actually do
> access user pointers.  Use the newly added force_uaccess_begin helper
> instead of an open coded set_fs for that to prepare for kernel builds
> where set_fs() does not exist.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Have you played with a tree with all of your patches
and placing force_uaccess_begin in init/main.c:start_kernel?

Somewhere deep in the arch code we seem to have it all backwards
and kernel threads are all set_fs(KERNEL_DS).  So just putting
a force_uaccess_begin somewhere very early should be enough
to switch things around.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exec.c     | 7 ++++++-
>  kernel/exit.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a7032784..769af470b69124 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1380,7 +1380,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out_unlock;
>  
> -	set_fs(USER_DS);
> +	/*
> +	 * Ensure that the uaccess routines can actually operate on userspace
> +	 * pointers:
> +	 */
> +	force_uaccess_begin();
> +
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
>  					PF_NOFREEZE | PF_NO_SETAFFINITY);
>  	flush_thread();
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f2810338..17d486a20f0dc6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -731,7 +731,7 @@ void __noreturn do_exit(long code)
>  	 * mm_release()->clear_child_tid() from writing to a user-controlled
>  	 * kernel address.
>  	 */
> -	set_fs(USER_DS);
> +	force_uaccess_begin();
>  
>  	if (unlikely(in_atomic())) {
>  		pr_info("note: %s[%d] exited with preempt_count %d\n",
