Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99E1384B9
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2019 09:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFGHHz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jun 2019 03:07:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFGHHz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3xG2gB2u3ltC4ECXHzkfqk/Rf8Lzs9XYnPxSdw9Djq4=; b=gBrTD1ywQqnghTyPb+u8oUuO1
        n92Hi8a/rdgmVIhQ/moKpSzpN7IRYERjWycGLMqob6ui4vuJ0Lrag517vzAbE44qxJdkCSgxPKLT1
        TPDM9DMcOeTrROrwysz2WUqaSu0h22M6pU9hi1I9cmfvloI+w1dJxzU3J6rnF+OWy4rCb0aDGY2of
        b8kFhR/J3YJz62PeRqL2pk7arp5DAGDnFJX9NMH/Cj3Y2VoHWyDyUjEx/zl3iOjcEreXchO/Uxps0
        vF2ga+x78jDgquKaiphXwBrUEmKnjdaG5QpFvxY68BuCmEZlEwI1DNDpMN8q58R1DKQ6b2F5Av84v
        oC93ptfaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ8yG-00069g-2e; Fri, 07 Jun 2019 07:07:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C8E4202CD6B2; Fri,  7 Jun 2019 09:07:25 +0200 (CEST)
Date:   Fri, 7 Jun 2019 09:07:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 05/27] x86/fpu/xstate: Add XSAVES system states for
 shadow stack
Message-ID: <20190607070725.GN3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-6-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 06, 2019 at 01:06:24PM -0700, Yu-cheng Yu wrote:
> Intel Control-flow Enforcement Technology (CET) introduces the
> following MSRs.
> 
>     MSR_IA32_U_CET (user-mode CET settings),
>     MSR_IA32_PL3_SSP (user-mode shadow stack),
>     MSR_IA32_PL0_SSP (kernel-mode shadow stack),
>     MSR_IA32_PL1_SSP (Privilege Level 1 shadow stack),
>     MSR_IA32_PL2_SSP (Privilege Level 2 shadow stack).
> 
> Introduce them into XSAVES system states.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/types.h            | 22 +++++++++++++++++++++
>  arch/x86/include/asm/fpu/xstate.h           |  4 +++-
>  arch/x86/include/uapi/asm/processor-flags.h |  2 ++
>  arch/x86/kernel/fpu/xstate.c                | 10 ++++++++++
>  4 files changed, 37 insertions(+), 1 deletion(-)

And yet, no changes to msr-index.h !?
