Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F22324298
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhBXQy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 11:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbhBXQyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Feb 2021 11:54:20 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEDFC061786;
        Wed, 24 Feb 2021 08:53:36 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d1800cad8e5da06da911c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:cad8:e5da:6da:911c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82A2A1EC0531;
        Wed, 24 Feb 2021 17:53:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614185614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zOeBFbmurGj2suyzyPT2GMRd0IroJnET77mPeR4/Ncg=;
        b=R/2WRrCIWmVthrB+I78FYN+IY8shvdqh1yeCIanSd6GjieZDGa7W8lvI+ympdG3Ja0UF2A
        xPsNbQBqjQFjga7jTK0n6EaKzu3m1PlQVEhaRIy1HPClbAW0ezM8ccMdS/PQO4sYnz2KUH
        cWr4wWCrMTA+2xkZOOsF3BO7bGmbS9M=
Date:   Wed, 24 Feb 2021 17:53:32 +0100
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
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
Message-ID: <20210224165332.GF20344@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic>
 <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 08:44:45AM -0800, Yu, Yu-cheng wrote:
> > > +	force_sig_fault(SIGSEGV, SEGV_CPERR,
> > > +			(void __user *)uprobe_get_trap_addr(regs));
> > 
> > Why is this calling an uprobes function?
> > 
> 
> I will change it to error_get_trap_addr().

"/*
  * Posix requires to provide the address of the faulting instruction for
  * SIGILL (#UD) and SIGFPE (#DE) in the si_addr member of siginfo_t.
  ..."

Is yours SIGILL or SIGFPE?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
