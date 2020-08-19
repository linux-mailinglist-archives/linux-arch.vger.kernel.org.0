Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2EC24A029
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgHSNgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 09:36:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58478 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgHSNgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 09:36:43 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8OGa-0050Ds-A0; Wed, 19 Aug 2020 07:36:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8OGZ-00033s-EG; Wed, 19 Aug 2020 07:36:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        peterz@infradead.org, Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
        <20200818174447.GV17456@casper.infradead.org>
        <20200819074340.GW2674@hirez.programming.kicks-ass.net>
        <20200819084556.im5zfpm2iquzvzws@wittgenstein>
        <20200819111851.GY17456@casper.infradead.org>
Date:   Wed, 19 Aug 2020 08:32:59 -0500
In-Reply-To: <20200819111851.GY17456@casper.infradead.org> (Matthew Wilcox's
        message of "Wed, 19 Aug 2020 12:18:51 +0100")
Message-ID: <87a6yq222c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8OGZ-00033s-EG;;;mid=<87a6yq222c.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/396JhySI4Q4/s/q4z9fmXeBaBg1QpuKc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3763]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 406 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (2.2%), b_tie_ro: 8 (1.9%), parse: 1.26 (0.3%),
        extract_message_metadata: 13 (3.3%), get_uri_detail_list: 2.0 (0.5%),
        tests_pri_-1000: 18 (4.4%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 74 (18.1%), check_bayes:
        72 (17.7%), b_tokenize: 12 (2.9%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 44 (10.9%), b_finish: 0.92
        (0.2%), tests_pri_0: 273 (67.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.81 (0.2%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 10 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/11] Introduce kernel_clone(), kill _do_fork()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Aug 19, 2020 at 10:45:56AM +0200, Christian Brauner wrote:
>> On Wed, Aug 19, 2020 at 09:43:40AM +0200, peterz@infradead.org wrote:
>> > On Tue, Aug 18, 2020 at 06:44:47PM +0100, Matthew Wilcox wrote:
>> > > On Tue, Aug 18, 2020 at 07:34:00PM +0200, Christian Brauner wrote:
>> > > > The only remaining function callable outside of kernel/fork.c is
>> > > > _do_fork(). It doesn't really follow the naming of kernel-internal
>> > > > syscall helpers as Christoph righly pointed out. Switch all callers and
>> > > > references to kernel_clone() and remove _do_fork() once and for all.
>> > > 
>> > > My only concern is around return type.  long, int, pid_t ... can we
>> > > choose one and stick to it?  pid_t is probably the right return type
>> > > within the kernel, despite the return type of clone3().  It'll save us
>> > > some work if we ever go through the hassle of growing pid_t beyond 31-bit.
>> > 
>> > We have at least the futex ABI restricting PID space to 30 bits.
>> 
>> Ok, looking into kernel/futex.c I see 
>> 
>> pid_t pid = uval & FUTEX_TID_MASK;
>> 
>> which is probably what this referes to and /proc/sys/kernel/threads-max
>> is restricted to FUTEX_TID_MASK.
>> 
>> Afaict, that doesn't block switching kernel_clone() to return pid_t. It
>> can't create anything > FUTEX_TID_MASK anyway without yelling EAGAIN at
>> userspace. But it means that _if_ we were to change the size of pid_t
>> we'd likely need a new futex API. 
>
> Yes, there would be a lot of work to do to increase the size of pid_t.
> I'd just like to not do anything to make that harder _now_.  Stick to
> using pid_t within the kernel.

Just so people are aware.  If you look in include/linux/threads.h you
can see that the maximum value of PID_MAX_LIMIT limits pids to 22 bits.

Further the design decisions of pids keeps us densly using pids.  So I
expect it will be a while before we even come close to using 30 bits of
pid space.

At the same time I do agree that it makes sense to use a consistent type
in the kernel to make it easier to read and update the code.

Eric
