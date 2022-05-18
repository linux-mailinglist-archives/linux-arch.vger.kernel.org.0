Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E152C03F
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiERQkO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 12:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbiERQkK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 12:40:10 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2B51FB574;
        Wed, 18 May 2022 09:40:03 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40784)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrMiN-000aXg-N2; Wed, 18 May 2022 10:39:59 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38670 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrMiM-000int-IO; Wed, 18 May 2022 10:39:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
        <20220518092619.1269111-15-chenhuacai@loongson.cn>
Date:   Wed, 18 May 2022 11:39:51 -0500
In-Reply-To: <20220518092619.1269111-15-chenhuacai@loongson.cn> (Huacai Chen's
        message of "Wed, 18 May 2022 17:26:11 +0800")
Message-ID: <87ilq294mg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrMiM-000int-IO;;;mid=<87ilq294mg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/loKgiIQkjiUDPfvi+iuLWDLAFJas94Fw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Huacai Chen <chenhuacai@loongson.cn>
X-Spam-Relay-Country: 
X-Spam-Timing: total 445 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 10 (2.3%), parse: 1.14
        (0.3%), extract_message_metadata: 20 (4.5%), get_uri_detail_list: 1.84
        (0.4%), tests_pri_-1000: 40 (9.0%), tests_pri_-950: 1.70 (0.4%),
        tests_pri_-900: 1.40 (0.3%), tests_pri_-90: 60 (13.4%), check_bayes:
        58 (13.0%), b_tokenize: 10 (2.2%), b_tok_get_all: 9 (2.1%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 33 (7.3%), b_finish: 0.80
        (0.2%), tests_pri_0: 296 (66.4%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.90 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH V11 14/22] LoongArch: Add signal handling support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Huacai Chen <chenhuacai@loongson.cn> writes:

> Add ucontext/sigcontext definition and signal handling support for
> LoongArch.
>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/uapi/asm/sigcontext.h |  44 ++
>  arch/loongarch/include/uapi/asm/signal.h     |  13 +
>  arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
>  arch/loongarch/kernel/signal.c               | 566 +++++++++++++++++++
>  4 files changed, 658 insertions(+)
>  create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
>  create mode 100644 arch/loongarch/include/uapi/asm/signal.h
>  create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
>  create mode 100644 arch/loongarch/kernel/signal.c
>
> diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> new file mode 100644
> index 000000000000..be3d3c6ac83e
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _UAPI_ASM_SIGCONTEXT_H
> +#define _UAPI_ASM_SIGCONTEXT_H
> +
> +#include <linux/types.h>
> +#include <linux/posix_types.h>
> +
> +/* FP context was used */
> +#define SC_USED_FP		(1 << 0)
> +/* Address error was due to memory load */
> +#define SC_ADDRERR_RD		(1 << 30)
> +/* Address error was due to memory store */
> +#define SC_ADDRERR_WR		(1 << 31)
> +
> +struct sigcontext {
> +	__u64	sc_pc;
> +	__u64	sc_regs[32];
> +	__u32	sc_flags;
> +	__u64	sc_extcontext[0] __attribute__((__aligned__(16)));
> +};
> +
> +#define CONTEXT_INFO_ALIGN	16
> +struct _ctxinfo {
> +	__u32	magic;
> +	__u32	size;
> +	__u64	padding;	/* padding to 16 bytes */
> +};

This is probably something I a missing but what is struct _ctxinfo and
why is it in a uapi header?

I don't see anything else in the uapi implementation using it.

Symbols that start with an underscore "_" are reserved and should not
be used in general, and especially not in uapi header files.

Eric
