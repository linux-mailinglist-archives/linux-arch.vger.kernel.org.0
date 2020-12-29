Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D432E70A8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 13:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgL2MmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 07:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgL2MmE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Dec 2020 07:42:04 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B5C0613D6;
        Tue, 29 Dec 2020 04:41:24 -0800 (PST)
Received: from zn.tnic (p2e584e83.dip0.t-ipconnect.de [46.88.78.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F8A61EC04EC;
        Tue, 29 Dec 2020 13:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609245682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OOvXZBMQoIK+UvAUZYe+0qhjBjyUbhc4PxiosDWY7K8=;
        b=kSuZWitBGMRGQgaVggsdrAEL0Efy6toGfl5eErUFhou97tpqX+9b/p9nk/yCryuEtYGxJJ
        nLtpzpe73aNhdSirVgFlhBSWelCg12bdGxtFgP7bfWtiRHIVkis2gYEbs9o8jv2mspotTD
        n+cLy+uJbPZtThZnmxp/C/nzgtm7zFc=
Date:   Tue, 29 Dec 2020 13:39:10 +0100
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
Subject: Re: [PATCH v16 02/26] x86/cet/shstk: Add Kconfig option for
 user-mode control-flow protection
Message-ID: <20201229123910.GB29947@zn.tnic>
References: <20201209222320.1724-1-yu-cheng.yu@intel.com>
 <20201209222320.1724-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209222320.1724-3-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 09, 2020 at 02:22:56PM -0800, Yu-cheng Yu wrote:
> Shadow Stack provides protection against function return address
> corruption.  It is active when the processor supports it, the kernel has
> CONFIG_X86_CET_USER, and the application is built for the feature.
		     ^
		   enabled.

> This is only implemented for the 64-bit kernel.  When it is enabled, legacy
> non-Shadow Stack applications continue to work, but without protection.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig           | 22 ++++++++++++++++++++++
>  arch/x86/Kconfig.assembler |  5 +++++
>  2 files changed, 27 insertions(+)

Rest looks good, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
