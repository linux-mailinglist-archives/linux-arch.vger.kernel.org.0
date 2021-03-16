Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812C633DB01
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 18:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhCPRat (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 13:30:49 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33406 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233321AbhCPRab (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 13:30:31 -0400
Received: from zn.tnic (p200300ec2f0a1000f4cd07eb01fab5b0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:1000:f4cd:7eb:1fa:b5b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB1AB1EC056D;
        Tue, 16 Mar 2021 18:30:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615915829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qwNDhXsjyn7zMbvTCUkh+TXYixcjEnNSV28bE8swi88=;
        b=MkV30Y+zUzz/ZA98kKKFFbNwFgIeusWLPCM1J1vgJbX1XA4KfvzxzSNOsac++vFQoLqcsy
        owH4CMBawgA60o18K9eCIOV4032LejlLVubpAfO311bhm/ANOSi2AXvA/7BgDz0ugvzBk/
        S+aExBwBf4u3yNDxNaYa2grVYdb03sM=
Date:   Tue, 16 Mar 2021 18:30:32 +0100
From:   Borislav Petkov <bp@alien8.de>
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
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
Message-ID: <20210316173032.GE18003@zn.tnic>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
 <20210316151320.6123-7-yu-cheng.yu@intel.com>
 <f98c600a-80e4-62f0-9c97-eeed708d998d@intel.com>
 <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15966857-9be7-3029-7e93-e40596b4649a@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 10:12:39AM -0700, Yu, Yu-cheng wrote:
> Alternatively, there is another compiler-defined macro _CET_ENDBR that can
> be used.  We can put the following in calling.h:

Not calling.h - this is apparently needed in vdso code only so I guess
some header there, arch/x86/include/asm/vdso.h maybe? In the

#else /* __ASSEMBLER__ */

branch maybe...

> #ifdef __CET__
> #include <cet.h>
> #else
> #define _CET_ENDBR
> #endif
> 
> and then use _CET_ENDBR in other files.  How is that?

What does that macro do? Issue an ENDBR only?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
