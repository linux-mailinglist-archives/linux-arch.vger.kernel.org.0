Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF4270879
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRVqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRVqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:46:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E1C0613CE;
        Fri, 18 Sep 2020 14:46:48 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s88so7771895ilb.6;
        Fri, 18 Sep 2020 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tEtbTCyG2rnV0biaFUft9F3G7S1Bq/fIXdfXEt6SoFU=;
        b=tfndcyVD0M/bXUGTAbsmnIWMQiyXNfjabqa9SSP2Hj1voEfSH6Z1MBJtiAMWa2TGv1
         6tPXBXrMNbJHxQlz5BVy8hna39lXHstRkN8uusvJjUOobFqCmqY69qlv4qoZjp4oM/Zw
         AVfbqa7IsxoEtMrYPIZIEDgWpIYIN1vuiJ96DlCPb1wYHvs9X0OsYUZH+MG+QTQiDOXi
         4pyhof/Z1GDu5FqNz9E6GBuXXHjDu3lqtyxxc0njesBymBEY79/Uak2H0YczKaky8WAh
         YvMFt+FCI98OuqvIsX5aZ9Zkv0Evmzet9eK6ZwqgjBXEXvJG5s0LEA7jBUBLuxH4fdup
         xCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tEtbTCyG2rnV0biaFUft9F3G7S1Bq/fIXdfXEt6SoFU=;
        b=XqBJkbBpDdKihL9jXeZrotCk8vzzzkgZ5zbgfmVl5KiKUvetxE1q9qZceQfGNQIf0U
         mGT8PRfW0gNaWWeCcQxvb4p0Qx7VKhBELxrxOXionnbe3hM0Gu8bu0Ef0vVjnkW46DAv
         Qey7k+6CQLm9YDUYBttcQnup2HRW2D4yCFIlmGZwGOZbxHGVLaIa2BPxK5ajfHUkvaJ0
         BkLDZLSe6XekvTrwnTYPKTTUs1rmIkqKjGS3nL62fJlS5XyHjXaMGvDtsdsJ+gq5umfX
         vSLTQtLTDwG1dXDSApztiZEo2wCDjPacw8PDHIk5p0XnM8NZkp99yXRVcZCmpw/VYmv1
         j2FQ==
X-Gm-Message-State: AOAM530yGf4QhIxmjzKyDoXV3n6UKMfK3goaNNdfoZbeRtSFIkPVnvFL
        JhnXH1BpYW9cJu1956aWhIhgxVQYy5usVaUtlTY=
X-Google-Smtp-Source: ABdhPJwqRKc2lDEZUy74lLjvsye0RI/hv+bCAqYBBOF/2360WuZAZQ/oPtM7F2ODkpRnbVa9LomvtJnyqwSVzG9Pgx8=
X-Received: by 2002:a92:c9c4:: with SMTP id k4mr8200166ilq.292.1600465608096;
 Fri, 18 Sep 2020 14:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org> <20200918205933.GB4304@duo.ucw.cz>
 <019b5e45-b116-7f3d-f1f2-3680afbd676c@intel.com> <20200918214020.GF4304@duo.ucw.cz>
In-Reply-To: <20200918214020.GF4304@duo.ucw.cz>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 18 Sep 2020 14:46:12 -0700
Message-ID: <CAMe9rOrmq-7mZkp=O+wRRX+wGa=1dopUhXRbCJBJQUdGA3N=7w@mail.gmail.com>
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 2:40 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2020-09-18 14:25:12, Yu, Yu-cheng wrote:
> > On 9/18/2020 1:59 PM, Pavel Machek wrote:
> > > On Fri 2020-09-18 13:24:13, Randy Dunlap wrote:
> > > > Hi,
> > > >
> > > > If you do another version of this:
> > > >
> > > > On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> > > > > Introduce Kconfig option X86_INTEL_BRANCH_TRACKING_USER.
> > > > >
> > > > > Indirect Branch Tracking (IBT) provides protection against CALL-/JMP-
> > > > > oriented programming attacks.  It is active when the kernel has this
> > > > > feature enabled, and the processor and the application support it.
> > > > > When this feature is enabled, legacy non-IBT applications continue to
> > > > > work, but without IBT protection.
> > > > >
> > > > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > > > > ---
> > > > > v10:
> > > > > - Change build-time CET check to config depends on.
> > > > >
> > > > >   arch/x86/Kconfig | 16 ++++++++++++++++
> > > > >   1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > index 6b6dad011763..b047e0a8d1c2 100644
> > > > > --- a/arch/x86/Kconfig
> > > > > +++ b/arch/x86/Kconfig
> > > > > @@ -1963,6 +1963,22 @@ config X86_INTEL_SHADOW_STACK_USER
> > > > >           If unsure, say y.
> > > > > +config X86_INTEL_BRANCH_TRACKING_USER
> > > > > +       prompt "Intel Indirect Branch Tracking for user-mode"
> > > > > +       def_bool n
> > > > > +       depends on CPU_SUP_INTEL && X86_64
> > > > > +       depends on $(cc-option,-fcf-protection)
> > > > > +       select X86_INTEL_CET
> > > > > +       help
> > > > > +         Indirect Branch Tracking (IBT) provides protection against
> > > > > +         CALL-/JMP-oriented programming attacks.  It is active when
> > > > > +         the kernel has this feature enabled, and the processor and
> > > > > +         the application support it.  When this feature is enabled,
> > > > > +         legacy non-IBT applications continue to work, but without
> > > > > +         IBT protection.
> > > > > +
> > > > > +         If unsure, say y
> > > >
> > > >     If unsure, say y.
> > >
> > > Actually, it would be "If unsure, say Y.", to be consistent with the
> > > rest of the Kconfig.
> > >
> > > But I wonder if Yes by default is good idea. Only very new CPUs will
> > > support this, right? Are they even available at the market? Should the
> > > help text say "if your CPU is Whatever Lake or newer, ...." :-) ?
> >
> > I will revise the wording if there is another version.  But a CET-capable
> > kernel can run on legacy systems.  We have been testing that combination.
>
> Yes, but enabling CET is unneccessary overhead on older systems. And
> Kconfig is great place to explain that.
>

I can't tell any visible CET kernel overhead on my non-CET machines.

-- 
H.J.
