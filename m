Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395A36DAC5
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhD1PCO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbhD1PBu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Apr 2021 11:01:50 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E605C0612AD;
        Wed, 28 Apr 2021 07:57:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id d25so25800294oij.5;
        Wed, 28 Apr 2021 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xU26eKhAat6ZuGhDgaDU4lA3EkxCkgm/s81rka2sejI=;
        b=k5jI8e0y1SuWfZ34di/qkLtVolNK2FRYo26+wf8LY5DibGsrSHDxJYhS8RKM0i+O43
         0/dIqE+x2A+/sK3y3/wHosMr3rOsYPkD/ZOTo6CHe+FUahRCYdho1Yt6Jkz+s9b0Nys0
         Vv8t5Q+QJjN8/RyO+vs75phCLTS1RZ6DphJ5UUZaGOHIHfYHssGHPTu0rCZ12vnOJzkj
         VJ5Mt9IG28Bn9w5NSRdMJXXBD8um5qj+gZHPKbC10bgfUBJCvWEIxArkOiO2RDPT32k/
         rZJx18sosR84PdHF7v3OHSjmMTDb07Ud7Hjw4g3QpWhzbZRpWZQqYoXJpzQvy1AiOkJH
         9oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xU26eKhAat6ZuGhDgaDU4lA3EkxCkgm/s81rka2sejI=;
        b=tATLSXcjOfx0zWs7c92BBmT5KedZcKziKeTsYjNBk8dcXl72kFbHjzC+Iz1ax1hlji
         2+8/Qu7naBH118HJ+8LXmeE5lYBQd78xzAsAtfwmZ07idvUUTdBLM6RxUmVVSdv1gLNi
         P7IDTUkUjSV53aIJkQzzxL8l5TZZy+NvrswBb7Kn/rS03FD/KOcGsbjCDe10dSveKnFv
         lcZ/x1ciLjfLHEHY1j336MkfW/FS4iEPIOZhTtlEAmXkIukQkZ9e0OtwjIIg1Nl+Uais
         2g6cASj/ZJLbbZhVAA6wgBVLRmW28EUs8peA9HLDVveurGeyFTJKorHBcRYNwHBXIHfC
         KJ6g==
X-Gm-Message-State: AOAM5307pA7RHRTmvVoZ1ysMN93i4UvTSJP4f1FnjGj/PA7/hWD35fK+
        oaDIoP5yqRjwsFUb1YLlOn4PevocCFyaQtybAck=
X-Google-Smtp-Source: ABdhPJwBNAOYLNSRfUtYzVTxF2AYiX9nqQGGM+fJ+rtx+rAaaxqanQIebBFJnPrd9GA9ddLcf6+KFh8vSnkc+g05TdA=
X-Received: by 2002:a05:6808:2d0:: with SMTP id a16mr12208850oid.116.1619621835014;
 Wed, 28 Apr 2021 07:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204720.25007-1-yu-cheng.yu@intel.com> <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
 <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
In-Reply-To: <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 28 Apr 2021 07:56:38 -0700
Message-ID: <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch Tracking
To:     Andy Lutomirski <luto@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 28, 2021 at 7:52 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Yu-cheng Yu
> > > Sent: 27 April 2021 21:47
> > >
> > > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > > IA-32 Architectures Software Developer's Manual" [1].
> > ...
> >
> > Does this feature require that 'binary blobs' for out of tree drivers
> > be compiled by a version of gcc that adds the ENDBRA instructions?
> >
> > If enabled for userspace, what happens if an old .so is dynamically
> > loaded?

CET will be disabled by ld.so in this case.

> > Or do all userspace programs and libraries have to have been compiled
> > with the ENDBRA instructions?

Correct.  ld and ld.so check this.

> If you believe that the userspace tooling for the legacy IBT table
> actually works, then it should just work.  Yu-cheng, etc: how well
> tested is it?
>

Legacy IBT bitmap isn't unused since it doesn't cover legacy codes
generated by legacy JITs.

-- 
H.J.
