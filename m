Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C03F4A90A2
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 23:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355801AbiBCWYV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 17:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiBCWYV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Feb 2022 17:24:21 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728ADC061714;
        Thu,  3 Feb 2022 14:24:20 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u13so6345413oie.5;
        Thu, 03 Feb 2022 14:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlIDP1o24LdMRWZjnewjhrwwRT0kaZCiZatY+bUHhaE=;
        b=Pa/zmtlEee6Bkck7BMVEfXmMkzXP7n3Zhw3ZwUFdHgIL06epfTuIRhs4L5f2erOEv6
         /CSfNsvyXtX4OQ1s9KNuwxEBa/qJnLh1Ge66zdYYJ721V6+XtZhzbma5yb3YWhAySLpO
         H0ah0BjAz1rrJGsnye3ObO+TY6qHSGQijiMCZdIt+nZ6qRGbfB5YpP/dzN+hq+YELDyD
         N50HGOsgS8Wlm8RvKWigiNb0k4VWtS5FF8Ll9SRXU2rPD0AU4sAd63KiX5N4AlqvD5ZX
         /Ul8gq4dI1BoIhfu6q46m+cmamckrA25fKM3V1Q4jgQq17TVecEoOQT21aGzRqwxevJ2
         L7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlIDP1o24LdMRWZjnewjhrwwRT0kaZCiZatY+bUHhaE=;
        b=Zq/vNshbTfyq5r+Ys9kul9q0S1EHYA7iRnE/2eynaSBwSbMGIz35NwkIJtrfmF6G/1
         gO1N0TuxN6zBCAV8FyNqIBvXq4ls8zAkS/ykSnQJdGS+z9KDK9c09lRdJ4wF/QwW2MHq
         YeNRc42Yd7t1BV2/DF/4GWnzhfYNDYTT9xKGL7cYomDGr227QfZLnwUOfmkDvbo8IunJ
         kTzzDwih18+PSCeSA18f5tkp9MmFSPpYqMLWq5V0o6WFT/5gv0xhcFo0xyxm2cdnWOOn
         jsQNd4ScE/FjO1ZXrK/hR+38Sz0yTBMd1UEsFiHAAqxQc5saNHbxeX7IpO6XOzIBlCgb
         kLyQ==
X-Gm-Message-State: AOAM532OVbYp0Rd2loauIpXarKeJNUioVIRJt2MH9zryeq1RJzdnns8/
        Z2W7snjJ5veH38Xbn3uclH7LnFXhE1aGttKPSvI=
X-Google-Smtp-Source: ABdhPJxQMlUvdTyiQLXOpNnctVTARflweiNDaSMIW0AFhqFvwNhPdZo0t9yaOB/Az2gV2bKgrg4Dh4u4r8V8CstSTVQ=
X-Received: by 2002:a05:6808:159e:: with SMTP id t30mr27686oiw.132.1643927059755;
 Thu, 03 Feb 2022 14:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-36-rick.p.edgecombe@intel.com> <YfxQGRV6axGQ8bBC@dell9853host>
In-Reply-To: <YfxQGRV6axGQ8bBC@dell9853host>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 3 Feb 2022 14:23:43 -0800
Message-ID: <CAMe9rOqwby=p3w7L7kgDUhZPzLksYEZcyKLbWOafEYaazWgyBg@mail.gmail.com>
Subject: Re: [PATCH 35/35] x86/cpufeatures: Limit shadow stack to Intel CPUs
To:     John Allen <john.allen@amd.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, Kostya Serebryany <kcc@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 3, 2022 at 1:58 PM John Allen <john.allen@amd.com> wrote:
>
> On Sun, Jan 30, 2022 at 01:18:38PM -0800, Rick Edgecombe wrote:
> > Shadow stack is supported on newer AMD processors, but the kernel
> > implementation has not been tested on them. Prevent basic issues from
> > showing up for normal users by disabling shadow stack on all CPUs except
> > Intel until it has been tested. At which point the limitation should be
> > removed.
>
> Hi Rick,
>
> I have been testing Yu-Cheng's patchsets on AMD hardware and I am
> working on testing this version now. How are you testing this new
> series? I can partially test by calling the prctl enable for shadow
> stack directly from a program, but I'm not sure how useful that's going
> to be without the glibc support. Do you have a public repo with the
> necessary glibc changes to enable shadow stack early?
>

The glibc CET branch is at

https://gitlab.com/x86-glibc/glibc/-/commits/users/hjl/cet/master

-- 
H.J.
