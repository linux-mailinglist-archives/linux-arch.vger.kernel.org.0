Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19440436551
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhJUPOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 11:14:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56470 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhJUPOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 11:14:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:49138)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZjW-00HSiJ-PB; Thu, 21 Oct 2021 09:11:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51076 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdZjV-00CXjS-FN; Thu, 21 Oct 2021 09:11:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
References: <87y26nmwkb.fsf@disp2133>
        <20211020174406.17889-12-ebiederm@xmission.com>
        <YXFLFUjGsvdK13Sa@infradead.org>
Date:   Thu, 21 Oct 2021 10:11:46 -0500
In-Reply-To: <YXFLFUjGsvdK13Sa@infradead.org> (Christoph Hellwig's message of
        "Thu, 21 Oct 2021 04:12:21 -0700")
Message-ID: <87wnm6h0p9.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mdZjV-00CXjS-FN;;;mid=<87wnm6h0p9.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19u0wOTfTJ+w+da1gXdYf5UxQQOSI4+4bY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSlimDrugH,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 483 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (1.9%), b_tie_ro: 8 (1.6%), parse: 0.92 (0.2%),
        extract_message_metadata: 14 (2.9%), get_uri_detail_list: 0.88 (0.2%),
        tests_pri_-1000: 20 (4.0%), tests_pri_-950: 2.6 (0.5%),
        tests_pri_-900: 1.87 (0.4%), tests_pri_-90: 242 (50.1%), check_bayes:
        239 (49.4%), b_tokenize: 7 (1.5%), b_tok_get_all: 5 (1.1%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 220 (45.6%), b_finish: 0.96
        (0.2%), tests_pri_0: 180 (37.3%), check_dkim_signature: 1.02 (0.2%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 12/20] exit/kthread: Have kernel threads return instead of calling do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Oct 20, 2021 at 12:43:58PM -0500, Eric W. Biederman wrote:
>> In 2009 Oleg reworked[1] the kernel threads so that it is not
>> necessary to call do_exit if you are not using kthread_stop().  Remove
>> the explicit calls of do_exit and complete_and_exit (with a NULL
>> completion) that were previously necessary.
>
> With this we should also be able to drop the export for do_exit.

Good point.

After this set of changes I don't see any calls of do_exit in drivers
or other awkward places so that would make a good addition.

Eric

