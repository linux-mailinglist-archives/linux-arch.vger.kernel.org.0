Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1D42A9AF3
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgKFReZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 12:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgKFReZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 12:34:25 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F23AC0613CF;
        Fri,  6 Nov 2020 09:34:25 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1f00ad832f6a7d59b60b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1f00:ad83:2f6a:7d59:b60b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B492A1EC0472;
        Fri,  6 Nov 2020 18:34:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604684062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sZ9sdfZO0dp3q+XlR5ns+dfmE83j+UNdPPPEebExe5c=;
        b=d26LGmNknsIHWGQjHbilUlMAKQzgZcL4TLfb795hEAJ3dnrB5du0h8A9kwucaFuvlgIk+m
        HNk4fbqCpqh+DE3pPXsUHFd+k8vVaOhgRZbcQH0+hVGjl6ntbafz75XBW73Omxfw9585ag
        WtfzHj5fRCcHMYKBeTGhjrNwJs80T9M=
Date:   Fri, 6 Nov 2020 18:34:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v14 01/26] Documentation/x86: Add CET description
Message-ID: <20201106173410.GG14914@zn.tnic>
References: <20201012153850.26996-1-yu-cheng.yu@intel.com>
 <20201012153850.26996-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012153850.26996-2-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 12, 2020 at 08:38:25AM -0700, Yu-cheng Yu wrote:
> +[1] Overview
> +============
> +
> +Control-flow Enforcement Technology (CET) is an Intel processor feature
> +that provides protection against return/jump-oriented programming (ROP)
> +attacks.  It can be set up to protect both applications and the kernel.
> +Only user-mode protection is implemented in the 64-bit kernel, including
> +support for running legacy 32-bit applications.
> +
> +CET introduces Shadow Stack and Indirect Branch Tracking.  Shadow stack is
> +a secondary stack allocated from memory and cannot be directly modified by
> +applications.  When executing a CALL, the processor pushes the return
				       ^
				    . .. instruction ...


> +address to both the normal stack and the shadow stack.  Upon function
> +return, the processor pops the shadow stack copy and compares it to the
> +normal stack copy.  If the two differ, the processor raises a control-
> +protection fault.  Indirect branch tracking verifies indirect CALL/JMP
> +targets are intended as marked by the compiler with 'ENDBR' opcodes.
> +
> +There are two kernel configuration options:
> +
> +    X86_SHADOW_STACK_USER, and
> +    X86_BRANCH_TRACKING_USER.
> +
> +These need to be enabled to build a CET-enabled kernel, and Binutils v2.31
> +and GCC v8.1 or later are required to build a CET kernel.  To build a CET-
> +enabled application, GLIBC v2.28 or later is also required.
> +
> +There are two command-line options for disabling CET features::
> +
> +    no_user_shstk - disables user shadow stack, and
> +    no_user_ibt   - disables user indirect branch tracking.
> +
> +At run time, /proc/cpuinfo shows CET features if the processor supports
> +CET.
> +
> +[2] Application Enabling
> +========================
> +
> +An application's CET capability is marked in its ELF header and can be
> +verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
> +field:
> +
> +    readelf -n <application>

Can be verified how? What does it say for a CET-enabled executable? Put
it here in the doc pls.

> +
> +If an application supports CET and is statically linked, it will run with
> +CET protection.  If the application needs any shared libraries, the loader
> +checks all dependencies and enables CET when all requirements are met.
> +
> +[3] Backward Compatibility
> +==========================
> +
> +GLIBC provides a few tunables for backward compatibility.
> +
> +GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
> +    Turn off SHSTK/IBT for the current shell.

For the current shell? How?

You mean, you execute the kernel shell with that variable set? So you
set this variable in any executable's env which links with glibc in
order to disable CET?

In any case, this needs clarification.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
