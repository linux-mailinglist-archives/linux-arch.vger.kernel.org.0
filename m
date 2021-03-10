Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9604334C57
	for <lists+linux-arch@lfdr.de>; Thu, 11 Mar 2021 00:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhCJXSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 18:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbhCJXRj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Mar 2021 18:17:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982C9C061574;
        Wed, 10 Mar 2021 15:17:39 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a9900a924d5d6558379cc.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9900:a924:d5d6:5583:79cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 189CE1EC0324;
        Thu, 11 Mar 2021 00:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615418258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vdW4jHtU0yP5nIiN9iN5QIKuVvJT42tBZF1aEM+pmEU=;
        b=OIreb/Q1GnNA6DuKQAQYJMdcbxOaH0NUHkN7M6Kf7IKhYmFJauv7y+XrlTqSsWEr8X4gRT
        tGYSQZjwQOLCA3nRyXqewrox7hN5tB5czxuo3XLI+/sA+g7CQ21vsIeygf++0qYcRxtQY3
        jrI28tGi2TEAPSYH5No08OdnBG/xI+8=
Date:   Thu, 11 Mar 2021 00:17:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
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
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v22 8/8] x86/vdso: Add ENDBR64 to __vdso_sgx_enter_enclave
Message-ID: <20210310231731.GK23521@zn.tnic>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
 <20210310220519.16811-9-yu-cheng.yu@intel.com>
 <YElKjT2v628tidE/@kernel.org>
 <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b8efe44-b79f-ce29-ee28-066f88c93840@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 02:55:55PM -0800, Yu, Yu-cheng wrote:
> > > @@ -27,6 +27,9 @@
> > >   SYM_FUNC_START(__vdso_sgx_enter_enclave)
> > >   	/* Prolog */
> > >   	.cfi_startproc
> > > +#ifdef CONFIG_X86_CET
> > > +	endbr64
> > > +#endif

You can hide this ifdeffery in a macro and have

	ENDBR64

at the callsite and define

.macro ENDBR64
#ifdef CONFIG_X86_CET
	endbr64
#endif
.endm

or so, perhaps. Ditto for endbr32.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
