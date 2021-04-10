Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CCE35AC76
	for <lists+linux-arch@lfdr.de>; Sat, 10 Apr 2021 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhDJJaI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Apr 2021 05:30:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhDJJaH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 10 Apr 2021 05:30:07 -0400
Received: from zn.tnic (p200300ec2f1aea004ff424aef8172112.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:ea00:4ff4:24ae:f817:2112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 243AB1EC0409;
        Sat, 10 Apr 2021 11:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618046992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U4fOVgCu+Cc3JD0fk9iTK0StzoBFsYk6BLIrkX0M9Mk=;
        b=DRP6H5Ya6IuI83rk+l8ifJgdtETmDKwOsMtW/uVOTSKMmoq2JlNAflXx9ngr3q1hYBwnKo
        Otg746xtSkovC47rbD3PERQsxbGqzbsmyQ/zEdn+F8RrBZtspuxrsUYofvIb8SM6xRVtGJ
        GvB0pOIrbUR/pw+mHGHW1CoVzKbqFO0=
Date:   Sat, 10 Apr 2021 11:29:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v24 04/30] x86/cpufeatures: Introduce X86_FEATURE_CET and
 setup functions
Message-ID: <20210410092951.GA21691@zn.tnic>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-5-yu-cheng.yu@intel.com>
 <20210409101214.GC15567@zn.tnic>
 <c7cb0ed6-2725-ba0d-093e-393eab9918b2@intel.com>
 <20210409171408.GG15567@zn.tnic>
 <f7a1299a-916f-70fe-6881-0951fe4fe38a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7a1299a-916f-70fe-6881-0951fe4fe38a@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 09, 2021 at 04:14:09PM -0700, Yu, Yu-cheng wrote:
> > @@ -53,6 +55,8 @@ static short xsave_cpuid_features[] __initdata = {
> >   	X86_FEATURE_INTEL_PT,
> >   	X86_FEATURE_PKU,
> >   	X86_FEATURE_ENQCMD,
> > +	X86_FEATURE_CET, /* XFEATURE_CET_USER */
> > +	X86_FEATURE_CET, /* XFEATURE_CET_KERNEL */
> > 
> > or what is the piece which becomes simpler?
> 
> Yes, this is it.

Those should be X86_FEATURE_SHSTK no?

> Signals, arch_prctl, and ELF header are three places that need to depend on
> either shadow stack or IBT is configured.  To remain simple, we can make all
> three depend on CONFIG_X86_SHADOW_STACK, and in Kconfig, make CONFIG_X86_IBT
> depend on CONFIG_X86_SHADOW_STACK.  Without shadow stack, IBT itself is not
> as useful anyway.

Makes sense to me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
