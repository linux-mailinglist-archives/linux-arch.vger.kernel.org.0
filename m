Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F535A46E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 19:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhDIROY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 13:14:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39760 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhDIROX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Apr 2021 13:14:23 -0400
Received: from zn.tnic (p200300ec2f0be10039b183a609a7c35d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:e100:39b1:83a6:9a7:c35d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7A7A1EC04DA;
        Fri,  9 Apr 2021 19:14:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617988449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9AYjgxlvYEzX7lP0NtvpK9WeNVbzcrOcj1GyMO32N+8=;
        b=BkI1zZKAIOXGXVXDZmOJ5kTvnpvdEQxEu9hHsbEfqBXbmcLX9AbdpfXRpPq2jAtv2avPna
        4L6A5qHTBqjwjIjHBREH2SQLJlAymZ23QG8Bn8+d324iG+C1FfGRkuLghB9fBaKVoM4V49
        z7Nkq6Q70HYhsY4Wx435Y8ZpYd0sTuA=
Date:   Fri, 9 Apr 2021 19:14:08 +0200
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
Message-ID: <20210409171408.GG15567@zn.tnic>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-5-yu-cheng.yu@intel.com>
 <20210409101214.GC15567@zn.tnic>
 <c7cb0ed6-2725-ba0d-093e-393eab9918b2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7cb0ed6-2725-ba0d-093e-393eab9918b2@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 09, 2021 at 08:52:52AM -0700, Yu, Yu-cheng wrote:
> Recall we had complicated code for the XSAVES features detection in
> xstate.c.  Dave Hansen proposed the solution and then the whole thing
> becomes simple.  Because of this flag, even when only the shadow stack is
> available, the code handles it nicely.

Is that what you mean?

@@ -53,6 +55,8 @@ static short xsave_cpuid_features[] __initdata = {
 	X86_FEATURE_INTEL_PT,
 	X86_FEATURE_PKU,
 	X86_FEATURE_ENQCMD,
+	X86_FEATURE_CET, /* XFEATURE_CET_USER */
+	X86_FEATURE_CET, /* XFEATURE_CET_KERNEL */

or what is the piece which becomes simpler?

> Would this equal to only CONFIG_X86_CET (one Kconfig option)?  In fact, when
> you proposed only CONFIG_X86_CET, things became much simpler.

When you use CONFIG_X86_SHADOW_STACK instead, it should remain same
simple no?

> Practically, IBT is not much in terms of code size.  Since we have already
> separated the two, why don't we leave it as-is.  When people start using it
> more, there will be more feedback, and we can decide if one Kconfig is
> better?

Because when we add stuff to the kernel, we add the simplest and
cleanest version possible and later, when we determine that additional
functionality is needed, *then* we add it. Not the other way around.

Our Kconfig symbol space is already an abomination so we can't just add
some more and decide later.

What happens in such situations usually is stuff gets added, it bitrots
and some poor soul - very likely a maintainer who has to mop up after
everybody - comes and cleans it up. I'd like to save myself that
cleaning up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
