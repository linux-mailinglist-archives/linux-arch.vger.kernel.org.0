Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E162A1F4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 20:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiKOTeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 14:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKOTeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 14:34:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE7A189;
        Tue, 15 Nov 2022 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQGbwJBFPdywGVEY1nsUqo2w6Ph8/bC9PDVo83SGkBE=; b=R+jp8claD3kKSP26LER/jd1Ub6
        HsbUQoiGXISXe/c+55v0VWTJ7MnwOd1HJ//X2FPUubx7XQHvOUC5E7OMqWpyL+eIOxwMvnFtP5ghV
        jNiCS1exb5MvPmxmmwN+6KZ/cRdFwQhFqqul6jk/djVlHvafCMK7qaNh60B9AHTOnvvKx0P3hD4F1
        V+mRLnIPWrspe+2jaznHOVlEQNkYki1Dq9DjWnoHW0+jhXtvqtLai3X2uKrnsI0LT/Cc49yIp+moF
        Mo7iBZfk1TzIoJ9xeGU6nJv+5tACw6fSSFnoQiiy/ZuHvkt+lmGEkUE2sGAkrDpX9WyHW38x9CJVQ
        bd38ONNw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1gd-00GXs5-9I; Tue, 15 Nov 2022 19:33:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71321302D84;
        Tue, 15 Nov 2022 15:47:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 590C820C99E5C; Tue, 15 Nov 2022 15:47:05 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:47:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 36/37] x86/cet/shstk: Add ARCH_CET_UNLOCK
Message-ID: <Y3OmaSjhCtjht1nS@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-37-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-37-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:36:03PM -0700, Rick Edgecombe wrote:

> diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
> index 71620b77a654..bed7032d35f2 100644
> --- a/arch/x86/kernel/shstk.c
> +++ b/arch/x86/kernel/shstk.c
> @@ -450,9 +450,14 @@ long cet_prctl(struct task_struct *task, int option, unsigned long features)
>  		return 0;
>  	}
>  
> -	/* Don't allow via ptrace */
> -	if (task != current)
> +	/* Only allow via ptrace */

Both the old and new comment are equally useless for they tell us
nothing the code doesn't already.

Why isn't ptrace allowed to call these, and doesn't that rather leave
CRIU in a bind, it can unlock but not re-lock the features, leaving
restored processes more vulnerable than they were.

> +	if (task != current) {
> +		if (option == ARCH_CET_UNLOCK && IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)) {

Why make this conditional on CRIU at all?

> +			task->thread.features_locked &= ~features;
> +			return 0;
> +		}
>  		return -EINVAL;
> +	}
>  
>  	/* Do not allow to change locked features */
>  	if (features & task->thread.features_locked)
> -- 
> 2.17.1
> 
