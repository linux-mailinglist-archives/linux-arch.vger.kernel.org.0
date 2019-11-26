Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3710A464
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2019 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZTQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Nov 2019 14:16:00 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:48796 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZTQA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 14:16:00 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iZgJa-000117-Nc; Tue, 26 Nov 2019 12:15:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iZgJa-0006KJ-3e; Tue, 26 Nov 2019 12:15:58 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     <linux-arch@vger.kernel.org>, linux-xtensa@linux-xtensa.org
Date:   Tue, 26 Nov 2019 13:15:23 -0600
Message-ID: <8736eaxxdg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iZgJa-0006KJ-3e;;;mid=<8736eaxxdg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1904z59hT8Q3i1/bR/fklsg7zwbNYPmKxY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=8.0 tests=ALL_TRUSTED,BAYES_00,
        DCC_CHECK_NEGATIVE autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -3.0 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 249 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5 (2.1%), b_tie_ro: 3.7 (1.5%), parse: 0.63
        (0.3%), extract_message_metadata: 2.4 (1.0%), get_uri_detail_list:
        0.55 (0.2%), tests_pri_-1000: 4.2 (1.7%), tests_pri_-950: 1.78 (0.7%),
        tests_pri_-900: 1.23 (0.5%), tests_pri_-90: 17 (6.7%), check_bayes: 15
        (6.0%), b_tokenize: 3.1 (1.2%), b_tok_get_all: 4.2 (1.7%),
        b_comp_prob: 1.53 (0.6%), b_tok_touch_all: 2.9 (1.2%), b_finish: 0.95
        (0.4%), tests_pri_0: 198 (79.5%), check_dkim_signature: 0.53 (0.2%),
        check_dkim_adsp: 3.0 (1.2%), poll_dns_idle: 1.03 (0.4%), tests_pri_10:
        2.6 (1.0%), tests_pri_500: 8 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: new uses of SYSCTL_SYSCALL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Doing a test merge against linux-next I see that in the
tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
a new defconfig is added:

arch/xtensa/configs/xip_kc705_defconfig

That defconfig adds CONFIG_SYSCTL_SYSCALL.

Is xtensa actually using this system call?  So far I have not seen any
other users and I am serously proposing to remove it. 

Eric
