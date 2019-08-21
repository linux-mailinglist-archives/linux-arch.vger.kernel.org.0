Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9A97D72
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2019 16:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfHUOpp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Aug 2019 10:45:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfHUOpp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 10:45:45 -0400
Received: from zn.tnic (p200300EC2F0A6300AD34BF75F4F01B21.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6300:ad34:bf75:f4f0:1b21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 640051EC02FE;
        Wed, 21 Aug 2019 16:45:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566398743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lTbUTRWT7/yDYikPZXnxrPfidgHBKAk129d3QMAlBN8=;
        b=UkT303Q6PQdQLRjF8bKFTVDYvf4/veO5tJOiyCziZe8EFQW68CVP7lBVMYQ6nGizmgFJKg
        FXELQvYm+ouBqgeO8bgrwK4zZB6waqhJ19Svr+ncvTHiXIWFyPkdLQkYqVzmPMYB1QhKcy
        UQ+ZL3nw4KcOvt+o5NmnqkpKAJ1PVOU=
Date:   Wed, 21 Aug 2019 16:45:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v8 03/27] x86/fpu/xstate: Change names to separate XSAVES
 system and user states
Message-ID: <20190821144537.GE6752@zn.tnic>
References: <20190813205225.12032-1-yu-cheng.yu@intel.com>
 <20190813205225.12032-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190813205225.12032-4-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 13, 2019 at 01:52:01PM -0700, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) MSR contents are XSAVES system states.
> To support CET, introduce XSAVES system states first.
> 
> XSAVES is a "supervisor" instruction and, comparing to XSAVE, saves
> additional "supervisor" states that can be modified only from CPL 0.
> However, these states are per-task and not kernel's own.  Rename
> "supervisor" states to "system" states to clearly separate them from
> "user" states.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/fpu/internal.h |  4 +-
>  arch/x86/include/asm/fpu/xstate.h   | 20 +++----
>  arch/x86/kernel/fpu/init.c          |  2 +-
>  arch/x86/kernel/fpu/signal.c        | 10 ++--
>  arch/x86/kernel/fpu/xstate.c        | 86 ++++++++++++++---------------
>  5 files changed, 60 insertions(+), 62 deletions(-)

...

> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index e5cb67d67c03..d560e8861a3c 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -54,13 +54,16 @@ static short xsave_cpuid_features[] __initdata = {
>  };
>  
>  /*
> - * Mask of xstate features supported by the CPU and the kernel:
> + * XSAVES system states can only be modified from CPL 0 and saved by
> + * XSAVES.  The rest are user states.  The following is a mask of
> + * supported user state features derived from boot_cpu_has() and

...derived from detected CPUID feature flags and
SUPPORTED_XFEATURES_MASK.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
