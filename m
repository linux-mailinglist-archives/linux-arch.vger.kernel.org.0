Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102D236EE5B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhD2Qql (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 12:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2Qqk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 12:46:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB09C06138B;
        Thu, 29 Apr 2021 09:45:53 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a4f00c0c5be88e2edfd96.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4f00:c0c5:be88:e2ed:fd96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 253F71EC0266;
        Thu, 29 Apr 2021 18:45:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619714752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+ad63PVCcTY8G5quIEl9VpmY7+0tV15lo66Ty6GyFEc=;
        b=WllWCfTKHtk2grwTb0bcROdTjEBFSTbW4IXMbRR95A5UWvb7B3LcyCQW5zVPfLHYDOLscW
        jsc6FXvL4pMBHB6B4gOUdPm+a6YuR+cRRSAow3GJ7FqHIB60Joq69Zy9+HQF+gB0Efqk/F
        eXiJMErDV5h38KquyvNSKrSczvhY63o=
Date:   Thu, 29 Apr 2021 18:45:49 +0200
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
Message-ID: <YIrivcpkUwrmoO7w@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-23-yu-cheng.yu@intel.com>
 <YImg5hmBnTZTkYIp@zn.tnic>
 <3a0ed2e3-b13d-0db6-87af-fecd394ddd2e@intel.com>
 <YIp4c95E9/9DYR6z@zn.tnic>
 <bdd41e35-29f0-896a-72ec-8b1abeafda0d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdd41e35-29f0-896a-72ec-8b1abeafda0d@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 29, 2021 at 09:17:06AM -0700, Yu, Yu-cheng wrote:
> The lock applies to both shadow stack and ibt.  So maybe just "locked"?

Sure.

> vm_munmap() returns error as the following:
> 
> (1) -EINVAL: address/size/alignment is wrong.
> 	For shadow stack, the kernel keeps track of it, this cannot/should not
> happen.

You mean nothing might corrupt

        cet->shstk_base
        cet->shstk_size

?

I can't count the ways I've heard "should not happen" before and then it
happening anyway.

So probably not but we better catch stuff like that instead of leaking.

> Should it happen, it is a bug.

Ack.

> The kernel can probably do WARN().

Most definitely WARN. You need to catch funsies like that. But WARN_ONCE
should be enough for now.

> (2) -ENOMEM: when doing __split_vma()/__vma_adjust(), kmem_cache_alloc()
> fails.
> 	Not much we can do.  Perhaps WARN()?

You got it.

Bottom line is: if you can check for this and it is cheap, then
definitely. Code changes, gets rewritten, reorganized, the old
assertions change significance, and so on...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
