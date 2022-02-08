Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B44AD394
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350047AbiBHIiZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 03:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiBHIiY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 03:38:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D4C0401F6;
        Tue,  8 Feb 2022 00:38:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644309498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=JrCAs9kbBprIEgALNJFOh0qnOZQk7Hfl/hnbgt4vAfw=;
        b=jgxsPPPyIazEOwCTiVmZmbsyjKpMw+Qqmq76g2m8P5z4KnJB/NVGlME1Q+2eZflalqwZFH
        E/m/U2zbLt1GwL9KEqZmiobS2BBK23V+XghXRCubY5wuXeV1KbFiJRBTeYmMAply1C50R9
        +sNMq/aHaZagKUHTYWDrA13pLBPtQAyBbBCHTvj92jdAAUq6sPyE8RyiuMfZi1uBIAPEBm
        6uSW/3NymO7qkF6O+/D723OXmoVd7sn+cTShk2Vm4yS16oqZstiFKTzxKWo+FZE9JIu+yL
        0kjNAqcrWrVlrlKB379S+RsBjnplFAVlyX8lT8BgczxWmm2BuaifKQfgpmqAEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644309498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=JrCAs9kbBprIEgALNJFOh0qnOZQk7Hfl/hnbgt4vAfw=;
        b=HnFz7J1nLMVF9/u/sEsoyb+TMdbcI8/bkZD8tJIpPry3H0lJR1ZVjQty8Zn0aB1yRgp0sM
        2Eh+c9laMdsrdGDg==
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 26/35] x86/process: Change copy_thread() argument 'arg'
 to 'stack_size'
In-Reply-To: <20220130211838.8382-27-rick.p.edgecombe@intel.com>
Date:   Tue, 08 Feb 2022 09:38:18 +0100
Message-ID: <87y22lvjlx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 30 2022 at 13:18, Rick Edgecombe wrote:
> -int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
> -		struct task_struct *p, unsigned long tls)
> +int copy_thread(unsigned long clone_flags, unsigned long sp,
> +		unsigned long stack_size, struct task_struct *p,
> +		unsigned long tls)
>  {
>  	struct inactive_task_frame *frame;
>  	struct fork_frame *fork_frame;
> @@ -175,7 +176,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  	if (unlikely(p->flags & PF_KTHREAD)) {
>  		p->thread.pkru = pkru_get_init_value();
>  		memset(childregs, 0, sizeof(struct pt_regs));
> -		kthread_frame_init(frame, sp, arg);
> +		kthread_frame_init(frame, sp, stack_size);
>  		return 0;
>  	}
>  
> @@ -208,7 +209,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
>  		 */
>  		childregs->sp = 0;
>  		childregs->ip = 0;
> -		kthread_frame_init(frame, sp, arg);
> +		kthread_frame_init(frame, sp, stack_size);
>  		return 0;
>  	}

Can you please change the prototypes too for completeness sake?

Thanks,

        tglx
