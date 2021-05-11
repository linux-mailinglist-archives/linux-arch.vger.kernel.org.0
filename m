Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B981D37ACB7
	for <lists+linux-arch@lfdr.de>; Tue, 11 May 2021 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhEKRKy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 May 2021 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhEKRKx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 May 2021 13:10:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521CBC061574;
        Tue, 11 May 2021 10:09:47 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ec70020ab858661d7f414.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:c700:20ab:8586:61d7:f414])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 134C61EC02E6;
        Tue, 11 May 2021 19:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620752985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oXj+aT1NLTLdq4xvPpDkmK4mlSpKcyX1kXRzqY9sy/I=;
        b=bLcn8++CHPCwI1r2+fGHgbqQmPMj0/Kw1DAyubBcNj+IKE9PD5aHN82t0EOQYgw9zkmX8U
        VMpPrqq8dwdNUvdWd3XkPDW+VrSH9QT2L5Yp2JzKL44ITn0WeVVb2mlJjcR4IxfCdcZh0e
        tVqiaLj/s+Svo/KGRT6NwRVyr9HxLRg=
Date:   Tue, 11 May 2021 19:09:41 +0200
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
Subject: Re: [PATCH v26 23/30] x86/cet/shstk: Handle thread shadow stack
Message-ID: <YJq6VZ/XMAtfkrMc@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-24-yu-cheng.yu@intel.com>
 <YJlADyc/9pn8Sjkn@zn.tnic>
 <89598d32-4bf8-b989-ee77-5b4b55a138a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89598d32-4bf8-b989-ee77-5b4b55a138a9@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 10, 2021 at 03:57:56PM -0700, Yu, Yu-cheng wrote:
> So this struct will be:
>
> struct thread_shstk {
> 	u64 shstk_base;
> 	u64 shstk_size;
> 	u64 locked:1;
> 	u64 ibt:1;
> };
> 
> Ok?

Pretty much.

You can even remove the "shstk_" from the members and when you call the
pointer "shstk", accessing the members will read

	shstk->base
	shstk->size
	...

and all is organic and readable :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
