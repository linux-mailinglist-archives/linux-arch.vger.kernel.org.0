Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D384133DFBE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 22:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhCPVDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 17:03:25 -0400
Received: from casper.infradead.org ([90.155.50.34]:35976 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhCPVDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Mar 2021 17:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KHYI63/oZUglLRTw4PB2bT7DWIzsrdEaZn8S9TzaRZE=; b=D6h+y9bDeKRNcXSqcwjogsQbgS
        +w0dHuFN3mDp9X9h+UAF1zgng94INvYdrPYWUQ11iYiPN/ztFbRhC++N+Gh28jl7Fn8sZApt0XAPd
        jB8HA3dxks2gsAbVc1piFuFDZ9C4+ijk5wlhsfpk+9GJxKWl4Zfm1MvnHvLc9mh5ldkq2wfIkpYiN
        CyuQEQl2YZDC2DkrtsGvSJsrskjO0wVgLjAZkRx+cufrhA6C2xyhGY3/EevHxv3XZkBeL0bOQiRMu
        B81/Zvj8KCI/g6gvqAiWYvVBgFUZrnbUBZBGCBp8kb8tFZ7RMWK+p4GfPrk01+/sB2Y8UDpTampWW
        eerAmIFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMGp6-000cD1-UW; Tue, 16 Mar 2021 21:01:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8468A986501; Tue, 16 Mar 2021 22:01:54 +0100 (CET)
Date:   Tue, 16 Mar 2021 22:01:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
Message-ID: <20210316210154.GT4746@worktop.programming.kicks-ass.net>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
 <YFENvgrR8JSYq1ae@hirez.programming.kicks-ass.net>
 <65845773-6cf0-1bdc-1ecf-168de74cc283@intel.com>
 <YFER79kU+ukn3YZr@hirez.programming.kicks-ass.net>
 <aff84067-5b9e-1335-e540-ef90ee133ac9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aff84067-5b9e-1335-e540-ef90ee133ac9@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 01:26:52PM -0700, Yu, Yu-cheng wrote:
> Then, what about moving what I had earlier to vdso.h?
> If we don't want __i386__ either, then make it two macros.

vdso.h seems to use CONFIG_X86_{64,32} resp.

> +.macro ENDBR
> +#ifdef CONFIG_X86_CET

And shouldn't that be CONFIG_X86_IBT ?


> +#ifdef __i386__

#ifdef CONFIG_X86_32

> +	endbr32
> +#else
> +	endbr64
> +#endif
> +#endif
> +.endm

