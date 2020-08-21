Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF024D618
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHUNbj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 09:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgHUNbd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 09:31:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AEAC061574
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 06:31:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so1944856wrs.8
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09U6vmSaahNdcLROs1sJRQMLO2jTllhKcJ+uh2MtTKA=;
        b=FBhfxiepYWlS9uM4Bp3qtAyG46bdidayLJQHBxfbLueX+M3HuwfkeT558+nRQSbGQ4
         WIkVB7yUWXC2eCaRIJYc9a46sTBZ1NQ87YdhCK4Kk7YUvpR4FWpISpOByJZ/KcL7WD9W
         FnnokDVRdBqspIHoF/ghT0bvw9dXJK9uZLJKKLX3++cPmth+P3DTxEK7dchVqIzmC7/w
         qESqZ7Ekkci69zw1SX0P7XlEJHyLp71EYw9mf3yxrtfwZQN2AVKie5IdT9vBStgJ3ipy
         xWFmymgEZ+MbB5be3/p9NsdJln2lhDmi8cUI7UmvNIiDwlTSZprlboBjw6xYvbCGDtGk
         6u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09U6vmSaahNdcLROs1sJRQMLO2jTllhKcJ+uh2MtTKA=;
        b=qis80x/wUFN4aJI89+saFUUeCvj2WhQSb+E3DeCEfL+Rt45so8pXc8CNUjv2Wxj1/b
         ho7Owaxxb5UQaWcZpyfw2DTOpXov9nqntVXjRhjx+cTBV+GnDNgcAMhxVWwCFzieDSp5
         s15Lk+nR/HqIxr/MAEB48X8Yw/8tDbtBvtmB8x80ADWpFOGFdDUJlwuQCjmT1lb3qift
         J9IwXrHd0GiF2XVd9pDe+USP1dsysALzI0bMO8TnY6Eky9QxCihmGVNkM1jwBLz9aZxT
         awqE8IuKFUAKUWVB0zWSE5tLlw5YZM4Udk9dwCc7Y3mTCO8Kh4+u776nDyShOwOeFRhC
         y7/Q==
X-Gm-Message-State: AOAM532qHumfsxYg89b/Op261OtWO+szy98gDhPGOpyey3Rn5eD602qo
        2yUZNRG/DqkZLJazbE6YKjv42Q==
X-Google-Smtp-Source: ABdhPJxriNxDM/f9/YbCE9WsW7FeM36vohjb4MJ/IXB6Q5OW1j4S16rZa29+Vlc8vCz1eSzYWkhUIg==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr471970wrq.194.1598016687509;
        Fri, 21 Aug 2020 06:31:27 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id 15sm4796747wmo.33.2020.08.21.06.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 06:31:26 -0700 (PDT)
Date:   Fri, 21 Aug 2020 15:31:20 +0200
From:   Marco Elver <elver@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     albert.linde@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Albert van der Linde <alinde@google.com>
Subject: Re: [PATCH 1/3] lib, include/linux: add usercopy failure capability
Message-ID: <20200821133120.GA3145341@elver.google.com>
References: <20200821104926.828511-1-alinde@google.com>
 <20200821104926.828511-2-alinde@google.com>
 <CACT4Y+ZeoUX39tBZs-DLoX0q5tC+skB56Cxf_SSpKiJdv3mMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZeoUX39tBZs-DLoX0q5tC+skB56Cxf_SSpKiJdv3mMFg@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 01:51PM +0200, Dmitry Vyukov wrote:
...
> > +++ b/lib/fault-inject-usercopy.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/fault-inject.h>
> > +#include <linux/fault-inject-usercopy.h>
> > +#include <linux/random.h>
> > +
> > +static struct {
> > +       struct fault_attr attr;
> > +       u32 failsize;
> > +} fail_usercopy = {
> > +       .attr = FAULT_ATTR_INITIALIZER,
> > +       .failsize = 0,
> > +};
> > +
> > +static int __init setup_fail_usercopy(char *str)
> > +{
> > +       return setup_fault_attr(&fail_usercopy.attr, str);
> > +}
> > +__setup("fail_usercopy=", setup_fail_usercopy);
> > +
> > +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> > +
> > +static int __init fail_usercopy_debugfs(void)
> > +{
> > +       umode_t mode = S_IFREG | 0600;
> > +       struct dentry *dir;
> > +
> > +       dir = fault_create_debugfs_attr("fail_usercopy", NULL,
> > +                                       &fail_usercopy.attr);
> > +       if (IS_ERR(dir))
> > +               return PTR_ERR(dir);
> > +
> > +       debugfs_create_u32("failsize", mode, dir,
> > +                          &fail_usercopy.failsize);
> 
> Marco, what's the right way to annotate these concurrent accesses for KCSAN?

For debugfs variables that are accessed concurrently, the only
non-data-racy option (currently) is to use debugfs_create_atomic_t() and
make the variable an atomic_t.

If it's read-mostly as is the case here, and given that atomic_read() is
cheap (it maps to READ_ONCE on x86 and arm64), that'd be reasonable even
if performance is a concern.

> > +       return 0;
> > +}
> > +
> > +late_initcall(fail_usercopy_debugfs);
> > +
> > +#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
> > +
> > +/**
> > + * should_fail_usercopy() - Failure code or amount of bytes not to copy.
> > + * @n: Size of the original copy call.
> > + *
> > + * The general idea is to have a method which returns the amount of bytes not
> > + * to copy, a failure to return, or 0 if the calling function should progress
> > + * without a failure. E.g., copy_{to,from}_user should NOT copy the amount of
> > + * bytes returned by should_fail_usercopy, returning this value (in addition
> > + * to any bytes that could actually not be copied) or a failure.
> > + *
> > + * Return: one of:
> > + * negative, failure to return;
> > + * 0, progress normally;
> > + * a number in ]0, n], the number of bytes not to copy.
> > + *
> > + */
> > +long should_fail_usercopy(unsigned long n)
> > +{
> > +       if (should_fail(&fail_usercopy.attr, n)) {
> > +               if (fail_usercopy.failsize > 0)
> > +                       return fail_usercopy.failsize % (n + 1);

If you wanted to retain the u32 in debugfs, you can mark this
'data_race(fail_usercopy.failsize)' -- since what we're doing here is
probabilistic anyway, reading a garbage value won't affect things much.

Alternatively, just switch to atomic_t and it'll just be an
atomic_read().

Thanks,
-- Marco
