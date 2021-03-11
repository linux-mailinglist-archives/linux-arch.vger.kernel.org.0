Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA1336ACA
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCKDgj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 22:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhCKDgb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 22:36:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D85C64E22;
        Thu, 11 Mar 2021 03:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615433791;
        bh=VU36+Oy9eNMQX1av5VV5rT/wzZmLW57dBFB+sUkXF4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7M11Ykz/wwfbgjKNn5uhle8DDoJiLEl5wtNAzrhBK5zeTMiiIe70zX3rO1f+tMpn
         EV8wPp3kqY/+Epphh1oW1a5Wg8muWy6V92Lc0VJ47G57DvHYoMIwrbmJC82GJh7K2K
         xT3sFovM1zbQxp17qxWMUtcMUruA7l6KLd9nF5BCTc7IfAN0XDhrteiGRvWvEOECEo
         GdnDEiGZfSEgrEWvKdvoj8OFJFrrbOLoTkSFI+bRru2BEB5IIeLYrjnJ4n4t0YTywG
         EbYs1bSm7vsUntt8XSuaTBZJnaAe/AIFepL4WoJO8P7vVTqj3xFoBZZpl7lAUf19fm
         z301GU9DwHQVw==
Date:   Thu, 11 Mar 2021 05:36:06 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
Message-ID: <YEmQJjwjs8UCEO2F@kernel.org>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
 <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 02:55:55PM -0800, Yu, Yu-cheng wrote:
> On 3/10/2021 2:39 PM, Jarkko Sakkinen wrote:
> > On Wed, Mar 10, 2021 at 02:05:19PM -0800, Yu-cheng Yu wrote:
> > > When CET is enabled, __vdso_sgx_enter_enclave() needs an endbr64
> > > in the beginning of the function.
> > 
> > OK.
> > 
> > What you should do is to explain what it does and why it's needed.
> > 
> 
> The endbr marks a branch target.  Without the "no-track" prefix, if an
> indirect call/jmp reaches a non-endbr opcode, a control-protection fault is
> raised.  Usually endbr's are inserted by the compiler.  For assembly, these
> have to be put in manually.  I will add this in the commit log if there is
> another revision.  Thanks!

Thanks for the explanation. There is another revision, because this is
lacking from the commit message.

Does it do any harm to put it there unconditionally?

> 
> --
> Yu-cheng
> 
> > > 
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >   arch/x86/entry/vdso/vsgx.S | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> > > index 86a0e94f68df..a70d4d09f713 100644
> > > --- a/arch/x86/entry/vdso/vsgx.S
> > > +++ b/arch/x86/entry/vdso/vsgx.S
> > > @@ -27,6 +27,9 @@
> > >   SYM_FUNC_START(__vdso_sgx_enter_enclave)
> > >   	/* Prolog */
> > >   	.cfi_startproc
> > > +#ifdef CONFIG_X86_CET
> > > +	endbr64
> > > +#endif
> > >   	push	%rbp
> > >   	.cfi_adjust_cfa_offset	8
> > >   	.cfi_rel_offset		%rbp, 0
> > > -- 
> > > 2.21.0
> > > 
> > > 
> > 
> > /Jarkko
> > 
> 
> 

/Jarkko
