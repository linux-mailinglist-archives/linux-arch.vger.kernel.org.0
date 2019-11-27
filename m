Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2862210B3F1
	for <lists+linux-arch@lfdr.de>; Wed, 27 Nov 2019 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK0Q4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Nov 2019 11:56:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50890 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0Q4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Nov 2019 11:56:30 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1ia0c9-0007Qs-8Q; Wed, 27 Nov 2019 09:56:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1ia0c8-0000wP-EY; Wed, 27 Nov 2019 09:56:29 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>
Date:   Wed, 27 Nov 2019 10:55:52 -0600
Message-ID: <87r21tuulj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ia0c8-0000wP-EY;;;mid=<87r21tuulj.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18CMr/x/AMiUx+XsHUs26QfjdcxgfVX5yk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMSexyCombo_01,XMSubMetaSxObfu_03,XMSubMetaSx_00,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4799]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  1.0 XMSexyCombo_01 Sexy words in both body/subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 402 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.6 (0.9%), b_tie_ro: 2.4 (0.6%), parse: 1.38
        (0.3%), extract_message_metadata: 7 (1.8%), get_uri_detail_list: 4.1
        (1.0%), tests_pri_-1000: 5 (1.4%), tests_pri_-950: 2.0 (0.5%),
        tests_pri_-900: 1.61 (0.4%), tests_pri_-90: 29 (7.3%), check_bayes: 27
        (6.7%), b_tokenize: 11 (2.8%), b_tok_get_all: 7 (1.8%), b_comp_prob:
        3.1 (0.8%), b_tok_touch_all: 3.0 (0.7%), b_finish: 0.76 (0.2%),
        tests_pri_0: 324 (80.7%), check_dkim_signature: 0.70 (0.2%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        3.3 (0.8%), tests_pri_500: 11 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] sysctl: Remove the sysctl system call
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: 61a47c1ad3a4dc6882f01ebdc88138ac62d0df03 sysctl: Remove the sysctl system call

As far as I can tell we have reached the point where no one enables the
sysctl system call anymore.  It still is enabled in a few defconfigs
but they are mostly the rarely used one and in asking people about
that it was more cut & paste enabled than anything else.

This is single commit that just deletes code.  Leaving just enough code
so that the deprecated sysctl warning continues to be printed.  If my
analysis turns out to be wrong and someone actually cares it will be
easy to revert this commit and have the system call again.

There was one new xtensa defconfig in linux-next that enabled the system
call this cycle and when asked about it the maintainer of the code
replied that it was not enabled on purpose.  As of today's linux-next
tree that defconfig no longer enables the system call.

I have recently amended the commit to include the review status.

Some of the mailing list choked on my patch posting, I don't know why
but here is a link to part of the review that made it to linux-kernel.
https://lore.kernel.org/lkml/201910011140.EA0181F13@keescook/

What we saw in the review discussion was that if we go a step farther
than my patch and mess with uapi headers there are pieces of code that
won't compile, but nothing minds the system call actually disappearing
from the kernel.

Eric W. Biederman (1):
      sysctl: Remove the sysctl system call

 arch/arc/configs/nps_defconfig              |    1 -
 arch/arc/configs/tb10x_defconfig            |    1 -
 arch/arm/configs/axm55xx_defconfig          |    1 -
 arch/arm/configs/keystone_defconfig         |    1 -
 arch/arm/configs/lpc32xx_defconfig          |    1 -
 arch/arm/configs/moxart_defconfig           |    1 -
 arch/arm/configs/qcom_defconfig             |    1 -
 arch/arm/configs/zx_defconfig               |    1 -
 arch/m68k/configs/m5475evb_defconfig        |    1 -
 arch/mips/configs/ci20_defconfig            |    1 -
 arch/mips/configs/loongson3_defconfig       |    1 -
 arch/mips/configs/malta_qemu_32r6_defconfig |    1 -
 arch/mips/configs/maltaaprp_defconfig       |    1 -
 arch/mips/configs/maltasmvp_defconfig       |    1 -
 arch/mips/configs/maltasmvp_eva_defconfig   |    1 -
 arch/mips/configs/maltaup_defconfig         |    1 -
 arch/mips/configs/omega2p_defconfig         |    1 -
 arch/mips/configs/qi_lb60_defconfig         |    1 -
 arch/mips/configs/vocore2_defconfig         |    1 -
 arch/nios2/configs/10m50_defconfig          |    1 -
 arch/nios2/configs/3c120_defconfig          |    1 -
 arch/parisc/configs/c8000_defconfig         |    1 -
 arch/parisc/configs/generic-32bit_defconfig |    1 -
 arch/powerpc/configs/40x/klondike_defconfig |    1 -
 arch/sh/configs/rsk7264_defconfig           |    1 -
 arch/xtensa/configs/audio_kc705_defconfig   |    1 -
 arch/xtensa/configs/cadence_csp_defconfig   |    1 -
 arch/xtensa/configs/generic_kc705_defconfig |    1 -
 arch/xtensa/configs/iss_defconfig           |    1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |    1 -
 arch/xtensa/configs/smp_lx200_defconfig     |    1 -
 arch/xtensa/configs/virt_defconfig          |    1 -
 init/Kconfig                                |   17 -
 kernel/sysctl_binary.c                      | 1305 ---------------------------
 34 files changed, 1354 deletions(-)
