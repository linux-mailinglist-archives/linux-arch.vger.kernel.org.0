Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C3136E7AD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhD2JNF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 05:13:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232775AbhD2JNE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Apr 2021 05:13:04 -0400
Received: from zn.tnic (p200300ec2f0a4f00fa8ecda271c3a3d7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4f00:fa8e:cda2:71c3:a3d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DC2B1EC0288;
        Thu, 29 Apr 2021 11:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619687536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7zGmhNtr9fSMXiAv9CTHWxetCafBFfr5+g4Pp2O1zPA=;
        b=VJ8KU5gDLEDcc86e/EfzBa0Fu1gTt/agw1fFBUNcKkgElWJVHz5ezJ1+abvUNWA/+YPW+c
        hhXKF5mKvOhNpbhEILpk4RsYp4zZM9GJdcTDDXSIzZSnW5O74QppV0bnYsVdEpAKdndzIb
        /RedeShYZzUdYUN0WSeW2H8EvvtriFM=
Date:   Thu, 29 Apr 2021 11:12:19 +0200
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
Subject: Re: [PATCH v26 22/30] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <YIp4c95E9/9DYR6z@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-23-yu-cheng.yu@intel.com>
 <YImg5hmBnTZTkYIp@zn.tnic>
 <3a0ed2e3-b13d-0db6-87af-fecd394ddd2e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a0ed2e3-b13d-0db6-87af-fecd394ddd2e@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 11:39:00AM -0700, Yu, Yu-cheng wrote:
> Sorry about that.  After that email thread, we went ahead to separate shadow
> stack and ibt into different files.  I thought about the struct, the file
> names cet.h, etc.  The struct still needs to include ibt status, and if it
> is shstk_desc, the name is not entirely true.  One possible approach is, we
> don't make it a struct here, and put every item directly in thread_struct.
> However, the benefit of putting all in a struct is understandable (you might
> argue the opposite :-)).  Please make the call, and I will do the change.

/me looks forward into the patchset...

So this looks like the final version of it:

@@ -15,6 +15,7 @@ struct cet_status {
 	unsigned long	shstk_base;
 	unsigned long	shstk_size;
 	unsigned int	locked:1;
+	unsigned int	ibt_enabled:1;
 };

If so, that thing should be simply:

	struct cet {
		unsigned long shstk_base;
		unsigned long shstk_size;
		unsigned int shstk_lock : 1,
			     ibt	: 1;
	}

Is that ibt flag per thread or why is it here? I guess I'll find out.

/me greps...

ah yes, it is.

> Yes, the comments are in patch #23: Handle thread shadow stack.  I wanted to
> add that in the patch that takes the path.

That comes next, I'll look there.

> > vm_munmap() can return other negative error values, where are you
> > handling those?
> > 
> 
> For other error values, the loop stops.

And then what happens?

> > > +	cet->shstk_base = 0;
> > > +	cet->shstk_size = 0;

You clear those here without even checking whether unmap failed somehow.
And then stuff leaks but we don't care, right?

Someone else's problem, I'm sure.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
