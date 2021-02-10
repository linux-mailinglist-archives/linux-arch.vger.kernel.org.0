Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B85317082
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 20:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhBJToi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhBJTod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Feb 2021 14:44:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0E8C061788
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:43:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so1785096plr.9
        for <linux-arch@vger.kernel.org>; Wed, 10 Feb 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGHT8XOGSqwJihWSbK4ZCApnRLwGxJl/53HxYyWXezs=;
        b=if4tN2WNJyzWPTaspQ776mp/XyIjptrjUE6vyDEJQHwBwjbBKoCDQLne6RBOay/Gya
         ETjxZrzFV35RGRbhe869RCQ/5E/RIbbwgzIoniAUCJ5k201x5mkuiLZOhL0VYdQ4jsAv
         RyPDmVPC5itgGoWraSB8PUeUtLim9zZMSuPrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGHT8XOGSqwJihWSbK4ZCApnRLwGxJl/53HxYyWXezs=;
        b=TvhNbWgcSBpovYPGB4kZ6Ln0hJ2J9k2keYtCMZPeY8DulighIacSEWxIJMfXYRXGQT
         p8oon7Klt85IGZP2x95dMhRlibVIJVvaWE5NqJKpveBIY8yVzDRb6UnjKjOiEXlT4/6T
         ROhAXrqRTo8YqlgplJ6mk4r8zo1SclOAPIuEF6eIvD/ojdFyrKeGiC1X8SexWB3hS9x8
         TYet/doClEgK9Qgp10/5VRDiRtoYaqmK9Ma47AN0h9KJbM/Jar3nzATVvd0oDcLFO96X
         G7TrTVhN8a3kPL63jzrvQ06RM5DAarT9s/74W3YRMeK26EhH574aiGZKEiI9SfaauZUj
         rUHQ==
X-Gm-Message-State: AOAM530RgTpm8Y8Q1y9pEohtYB5RRMpamMRhHLaXUslJcyeFuvZ5yQM4
        kSG0FkdcBP2sYquO6oz5VoXIng==
X-Google-Smtp-Source: ABdhPJzEeGazBGDtvRNKKcgM+jRUEzPCcD05XU2/gT44RhHj/XxWHNUDZXuhwPlL1NIDCRlRSpYvHQ==
X-Received: by 2002:a17:90a:ab17:: with SMTP id m23mr511137pjq.0.1612986227233;
        Wed, 10 Feb 2021 11:43:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm2853653pjq.38.2021.02.10.11.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:43:46 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:43:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com
Subject: Re: [PATCH v20 11/25] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <202102101143.6585C93D43@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-12-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-12-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:49AM -0800, Yu-cheng Yu wrote:
> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].
> 
> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE.  However, this will not occur on processors supporting
> Shadow Stack, and a TLB flush is not necessary.
> 
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
