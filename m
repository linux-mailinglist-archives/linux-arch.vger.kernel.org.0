Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D095227081B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRVXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVXN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:23:13 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28CFC0613CE;
        Fri, 18 Sep 2020 14:23:13 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z25so8521176iol.10;
        Fri, 18 Sep 2020 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+R9udthszirp5ph1euFI7j8KgMqFMsoIf5y9goKTHNM=;
        b=F0fy8kNFKDpSAjjecuElAAjRNGjsnJXsuUSBhwtwBcrnGPYOSx3DRKvz5px9kBon/l
         SnWgPm3dtc0WY2+RMVwZawrEl2itpja3mltAQhJ8qX9jKuqWlgIqhs4cu0V9yV9pL72z
         1nFanYT/DkvzHVwfKVKZ6Km1ReA2VrGtKKr+gd1hhMnqRA0yuv6Sd4ik3xWUz373B0CN
         R3JbqhuMKKi6y+3d2WJVFtYbZF+tONL+sXC3Csy6y9Ie5dXheOGx9TNypG3MhvSqqb6U
         Ve2ENc40ifV7SVjIk1qKnxGJygQE6Az8FTr9vne2CfaH5qJVbpbht0jhpXGIDc0VYs+u
         DgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+R9udthszirp5ph1euFI7j8KgMqFMsoIf5y9goKTHNM=;
        b=BKN9q4u+bcWAaqRtd0A9lLjee1F163lVue6v+mADdxXmF6B+vfnJBkUxaWjkv8ku7Z
         C/75MuRpG4+p4d6oXQZbncFMbyCqAB5asE+6g2Q6zFRN3MWEP31vXN+dCbjRExom/pOd
         mOGdQpgKgqNcdQVoI7AOMmUwnGjOI2j1Hi/Qum+z7UiZ6i0x+RSX3J+pSp4AXvu70lIk
         wvhxcPw9qlcC6w1LjBHKTM6kjnlNpKw99GaR6c47g3ebOyye7YmN4wvVzwQEZw3GQjI2
         G9KvM1cTisU7qrpsrDtks6hIJbEFJlDwhpRSmGDEoE947uQlR3lsI/rZB1Pl1yJQ/G7Z
         +6OQ==
X-Gm-Message-State: AOAM533O/KaPt+1Xg6sfC5lmFhYGOM8zFm5oYlM4ivUafpMlHaCPCTz0
        Rl757LiaiMgaZMMpzu/8F2gTw/wRB/lXIYPrkZg=
X-Google-Smtp-Source: ABdhPJxy1JeWoxWEO8/PRD1NozAezh60pVqQZrrCJ4a+ovrb+USFp35rUx2X1gOeuMWymf7scw0+anyVqWmN0JoPF6w=
X-Received: by 2002:a5e:881a:: with SMTP id l26mr28068321ioj.51.1600464193161;
 Fri, 18 Sep 2020 14:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <f02b511d-1d48-6dea-d2e6-84d58e21e6cd@intel.com> <20200918210026.GC4304@duo.ucw.cz>
 <CAMe9rOrHCE51dKSz3fPXG-ORNim_Ok7rtwQxnudH9et4ecHBRA@mail.gmail.com> <4f93b106-53fc-40df-4c9b-c26490be24c8@intel.com>
In-Reply-To: <4f93b106-53fc-40df-4c9b-c26490be24c8@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 18 Sep 2020 14:22:37 -0700
Message-ID: <CAMe9rOqAmbRgGzUaA5ChGzeSqFVW524CJQ7Npe99BQtx-L_YBA@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 2:17 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 9/18/20 2:06 PM, H.J. Lu wrote:
> > On Fri, Sep 18, 2020 at 2:00 PM Pavel Machek <pavel@ucw.cz> wrote:
> >> On Fri 2020-09-18 12:32:57, Dave Hansen wrote:
> >>> On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> >>>> Emulation of the legacy vsyscall page is required by some programs
> >>>> built before 2013.  Newer programs after 2013 don't use it.
> >>>> Disable vsyscall emulation when Control-flow Enforcement (CET) is
> >>>> enabled to enhance security.
> >>> How does this "enhance security"?
> >>>
> >>> What is the connection between vsyscall emulation and CET?
> >> Boom.
> >>
> >> We don't break compatibility by default, and you should not tell
> >> people to enable CET by default if you plan to do this.
> >>
> > Nothing will be broken.   CET enabled applications don't use/need
> > vsyscall emulation.
>
> Hi H.J.,
>
> Could you explain your logic a bit more thoroughly, please?

Here is my CET slides for LPC 2020:

https://gitlab.com/cet-software/cet-smoke-test/-/wikis/uploads/09431a51248858e6f716a59065d732e2/CET-LPC-2020.pdf

which may have answers for most questions.

> I also suspect that Pavel was confused by your changelog where you said
> that you do this when "CET is enabled".  Does enabled in this context mean:
> 1. Just CET support compiled in, or
> 2. Compiled in and on CET hardware, or
> 3. Compiled in to the kernel enabled in the app and running on CET
>    hardware?

CET is enabled only in a process if

1. All components are CET enabled, and
2. CPU supports CET, and
3. Kernel supports CET.

-- 
H.J.
