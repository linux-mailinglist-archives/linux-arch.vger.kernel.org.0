Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC1E52A704
	for <lists+linux-arch@lfdr.de>; Tue, 17 May 2022 17:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbiEQPiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 May 2022 11:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbiEQPiA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 May 2022 11:38:00 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06955047D;
        Tue, 17 May 2022 08:37:04 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55038)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqzFo-00HUt8-UL; Tue, 17 May 2022 09:36:56 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38510 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nqzFn-00CCn9-VR; Tue, 17 May 2022 09:36:56 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "<linux-arch@vger.kernel.org>" <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
        <20220514080402.2650181-15-chenhuacai@loongson.cn>
        <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
        <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
        <b30e5b28-2a3a-f3a6-1bb1-592323f6eadd@xen0n.name>
        <87bkvxd12b.fsf@email.froward.int.ebiederm.org>
        <CAAhV-H7R4hioE-dHVxAnPmeJJ-eqiWkdmZWxNDfLesuvURCLcw@mail.gmail.com>
Date:   Tue, 17 May 2022 10:36:48 -0500
In-Reply-To: <CAAhV-H7R4hioE-dHVxAnPmeJJ-eqiWkdmZWxNDfLesuvURCLcw@mail.gmail.com>
        (Huacai Chen's message of "Tue, 17 May 2022 10:08:18 +0800")
Message-ID: <87v8u49nn3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nqzFn-00CCn9-VR;;;mid=<87v8u49nn3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/z8zdXGiWLxn4UIls5cu+131SNiPOvwrA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Huacai Chen <chenhuacai@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 363 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (1.3%), b_tie_ro: 3.2 (0.9%), parse: 1.15
        (0.3%), extract_message_metadata: 11 (2.9%), get_uri_detail_list: 1.35
        (0.4%), tests_pri_-1000: 12 (3.2%), tests_pri_-950: 1.06 (0.3%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 79 (21.8%), check_bayes:
        78 (21.4%), b_tokenize: 6 (1.6%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 1.58 (0.4%), b_tok_touch_all: 60 (16.6%), b_finish: 0.73
        (0.2%), tests_pri_0: 242 (66.6%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 1.88 (0.5%), poll_dns_idle: 0.50 (0.1%),
        tests_pri_10: 2.4 (0.7%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH V10 14/22] LoongArch: Add signal handling support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Huacai Chen <chenhuacai@gmail.com> writes:

> Hi, Eric,
>
> On Mon, May 16, 2022 at 10:07 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I can understand exporting these values but the names aren't very
>> well namespaced at all.  Which means they could accidentially
>> conflict with things.
>>
>> It would probably be better to do:
>> SC_USED_FP
>> SC_ADDRERR_RD
>> SC_ADDRERR_WR
> SC_ prefix is good, but ADRERR_RD/ADRERR_WR is used together with
> SIGSEGV/SIGBUS, so I want to keep the same as BUS_ADRERR (a single D)
> if possible.

Fair enough about the single D.  Please add the prefix in the next
version. Especially for kabi symbols in a namespace is a very good idea.


>> Given that neither lsx_context nor lasx_context are used in the kernel
>> code yet I would very much prefer that their inclusion wait until there
>> is actual code that needs them.
>>
>> If nothing else that will put the definitions in context so people can
>> more easily see the big picture and understand how the pieces fit.
> OK, I will remove lsx_context/lasx_context in the next version.

Thanks,
Eric
