Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E57C3FDD04
	for <lists+linux-arch@lfdr.de>; Wed,  1 Sep 2021 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbhIANDC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 09:03:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60240 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345667AbhIANAf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Sep 2021 09:00:35 -0400
Received: from zn.tnic (p200300ec2f0f3000a727e3aff00b12e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3000:a727:e3af:f00b:12e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1A921EC01A9;
        Wed,  1 Sep 2021 14:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630501172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rmuIuK2FpCv0DEu4TLFx/eI7rk7UX7fPyKr+Xpl6u6Y=;
        b=r6jEqxA1kBmuK19FN0TZsUfbKoQ7P8WADTQ/AuwKBFXRf0vuABalTI+NeMLZzvHfQhU0lz
        JXg1YfbZcebXpZsQS93mOTHnX6cbN/oIqd0/Trgkwk2YknnwEPwDH+M/mOd99wNtlfUDXz
        Ptadg5YGr8MMIdz7HKbk7vTpO7zRv9g=
Date:   Wed, 1 Sep 2021 15:00:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v29 23/32] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <YS95VzrNhDhFpsop@zn.tnic>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-24-yu-cheng.yu@intel.com>
 <YSfAbaMxQegvmN2p@zn.tnic>
 <fa372ba8-7019-46d6-3520-03859e44cad9@intel.com>
 <YSktDrcJIAo9mQBV@zn.tnic>
 <ab5bfeb4-af66-35b4-40da-829c7f98dcc2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab5bfeb4-af66-35b4-40da-829c7f98dcc2@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

First of all,

thanks a lot Dave for taking the time to communicate properly with me!

On Fri, Aug 27, 2021 at 01:25:29PM -0700, Dave Hansen wrote:
> I don't think this has anything to do with context-switching, really.
> 
> The code lands in shstk_setup() which wants to make sure that the new
> MSR values are set before the task goes out to userspace.  If
> TIF_NEED_FPU_LOAD was set, it could do that by going out to the XSAVE
> buffer and setting the MSR state in the buffer.  Before returning to
> userspace, it would be XRSTOR'd.  A WRMSR by itself would not be
> persistent because that XRSTOR would overwrite it.
> 
> But, if TIF_NEED_FPU_LOAD is *clear* it means the XSAVE buffer is
> out-of-date and the registers are live.  WRMSR can be used and there
> will be a XSAVE* to the task buffer during a context switch.
> 
> So, this code takes the coward's way out: it *forces* TIF_NEED_FPU_LOAD
> to be clear by making the registers live with fpregs_restore_userregs().
>  That lets it just use WRMSR instead of dealing with the XSAVE buffer
> directly.  If it didn't do this with the *WHOLE* set of user FPU state,
> we'd need more fine-granted "NEED_*_LOAD" tracking than our one FPU bit.
> 
> This is also *only* safe because the task is newly-exec()'d and the FPU
> state was just reset.  Otherwise, we might have had to worry that the
> non-PL3 SSPs have garbage or that non-SHSTK bits are set in MSR_IA32_U_CET.
> 
> That said, after staring at it, I *think* this code is functionally
> correct and OK performance-wise.

Right, except that that is being done in
setup_signal_shadow_stack()/restore_signal_shadow_stack() too, for the
restore token.

Which means, a potential XRSTOR each time just for a single MSR. That
means, twice per signal in the worst case.

Which means, shadow stack should be pretty noticeable in signal-heavy
benchmarks...

> I suspect that the (very blunt) XRSTOR inside of
> start_update_msrs()->fpregs_restore_userregs() is quite rare because
> TIF_NEED_FPU_LOAD will usually be clear due to the proximity to
> execve(). So, adding direct XSAVE buffer manipulation would probably
> only make it more error prone.

@Yu-cheng: please take Dave's explanation as is and stick it over
start_update_msrs() so that it is clear what that thing is doing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
