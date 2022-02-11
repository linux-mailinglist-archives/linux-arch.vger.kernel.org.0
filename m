Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18254B301D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiBKWJd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 17:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiBKWJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 17:09:33 -0500
X-Greylist: delayed 3550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 14:09:31 PST
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A104CD0
        for <linux-arch@vger.kernel.org>; Fri, 11 Feb 2022 14:09:31 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:37100)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIdBK-00E2Bx-SL; Fri, 11 Feb 2022 14:10:18 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53086 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nIdBI-001IMe-Qe; Fri, 11 Feb 2022 14:10:18 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <CAK8P3a22q+vTb3cEurhA0zXzw8-9+jKJRotC0oWMncS3sb-7zA@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 11 Feb 2022 21:57:43 +0100")
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
        <20220117132757.1881981-1-arnd@kernel.org>
        <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
        <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
        <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
        <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
        <YgROuYDWfWYlTUKD@antec> <YgWrFnoOOn/B3X4k@antec>
        <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
        <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
        <CAK8P3a22q+vTb3cEurhA0zXzw8-9+jKJRotC0oWMncS3sb-7zA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 11 Feb 2022 15:10:10 -0600
Message-ID: <87a6exxg7h.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nIdBI-001IMe-Qe;;;mid=<87a6exxg7h.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UdMlaxxlAx0910DUy08LRd/8gtAunb88=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Arnd Bergmann <arnd@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1339 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (0.2%), b_tie_ro: 2.3 (0.2%), parse: 0.68
        (0.1%), extract_message_metadata: 8 (0.6%), get_uri_detail_list: 1.15
        (0.1%), tests_pri_-1000: 11 (0.8%), tests_pri_-950: 1.06 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 68 (5.1%), check_bayes: 67
        (5.0%), b_tokenize: 6 (0.4%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.74 (0.1%), b_tok_touch_all: 51 (3.8%), b_finish: 0.68 (0.1%),
        tests_pri_0: 1233 (92.1%), check_dkim_signature: 0.45 (0.0%),
        check_dkim_adsp: 1.80 (0.1%), poll_dns_idle: 0.35 (0.0%),
        tests_pri_10: 2.7 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> On Fri, Feb 11, 2022 at 6:46 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Fri, Feb 11, 2022 at 9:00 AM Arnd Bergmann <arnd@kernel.org> wrote:
>> >
>> > I have now uploaded a cleanup series to
>> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs
>> >
>> > This uses the same access_ok() function across almost all
>> > architectures, with the exception of those that need something else,
>> > and I then I went further and killed off set_fs for everything other
>> > than ia64.
>>
>> Thanks, looks good to me.
>>
>> Can you say why you didn't convert ia64? I don't see any set_fs() use
>> there, except for the unaligned handler, which looks trivial to
>> remove. It looks like the only reason for it is kernel-mode unaligned
>> exceptions, which we should just turn fatal, I suspect (they already
>> get logged).
>>
>> And ia64 people could make the unaligned handling do the kernel mode
>> case in emulate_load/store_int() - it doesn't look *that* painful.
>>
>> But maybe you noticed something else?
>>
>> It would be really good to just be able to say that set_fs() no longer
>> exists at all.
>
> I had previously gotten stuck at ia64, but gave it another go now
> and uploaded an updated branch with ia64 taken care of and another
> patch to clean up bits afterwards.
>
> I only gave it light testing so far, mainly building the defconfig for every
> architecture. I'll post the series once the build bots are happy with the
> branch overall.
>

Thank you so much for doing this work.

Eric
