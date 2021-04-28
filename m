Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB5236DB6C
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 17:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbhD1PPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 11:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239783AbhD1PPf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 11:15:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BB1261443
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619622890;
        bh=4Ws0+en3jeqx+lcLETHxSaMmCbFj64akFU1VEPRBU+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScedMa4pTRrbMQMckrxWa/W5fytapGxMaxWDH0qlymRF2Y9VLNEfZ52a8gzMHsd52
         2ryrys+CYOK1xWIKrSs7xIDsGaZo0qKjaTOAxk8nNreE5vd1fGw4viUeltjoLfBNIP
         HW8ySxMLlVoJNC29I9nCwWa1D76Zyk8vD5A/UPgMvlRmNd7LsqZzo/XF4JdhrvD4EU
         HJ/OMpNw5to/qNYpA2J3gev0yOy5iopChmSc0MSy+m0m0zctmONRp8W0ey7BsyBMYF
         UWXAHkifj/C3aJ1/51ufonU1ECY9WqyF1vtGSrN67dWbBEI3Wcrkh86DyUZgtvil1i
         Id7nJ/+1aZj1Q==
Received: by mail-ed1-f46.google.com with SMTP id j28so10673833edy.9
        for <linux-arch@vger.kernel.org>; Wed, 28 Apr 2021 08:14:50 -0700 (PDT)
X-Gm-Message-State: AOAM532RNrLMdV26myg/9bf/MX5cPj6XcDr/+mkp6ZTAunNMufpN9zPt
        EYRkVBbsjEOodh8zddwnZYAi3Kqvh3l2TthX/LxsGg==
X-Google-Smtp-Source: ABdhPJxwJpY1QIeAU6fDkKWgHdGb8D1MMF6TX8d4Wams5Yc1cZADwoIMzfDbopKAgEhXVvM9guavhPLCPGkwr5btYfc=
X-Received: by 2002:a50:fc91:: with SMTP id f17mr11825671edq.23.1619622888769;
 Wed, 28 Apr 2021 08:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210427204720.25007-1-yu-cheng.yu@intel.com> <0e03c50ea05440209d620971b9db4f29@AcuMS.aculab.com>
 <CALCETrUpZfznXzN3Ld33DMvQcHD2ACnhYf9KdP+5-xXuX_pVpA@mail.gmail.com> <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
In-Reply-To: <CAMe9rOp7FauoqQ0vx+ZVPGOE9+ABspheuGLc++Chj_goE5HvWA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 28 Apr 2021 08:14:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
Message-ID: <CALCETrVHUP9=2kX3aJJugcagsf26W0sLEPsDvVCZNnBmbWrOLQ@mail.gmail.com>
Subject: Re: [PATCH v26 0/9] Control-flow Enforcement: Indirect Branch Tracking
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
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

On Wed, Apr 28, 2021 at 7:57 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 7:52 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Apr 28, 2021 at 7:48 AM David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Yu-cheng Yu
> > > > Sent: 27 April 2021 21:47
> > > >
> > > > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > > > return/jump-oriented programming attacks.  Details are in "Intel 64 and
> > > > IA-32 Architectures Software Developer's Manual" [1].
> > > ...
> > >
> > > Does this feature require that 'binary blobs' for out of tree drivers
> > > be compiled by a version of gcc that adds the ENDBRA instructions?
> > >
> > > If enabled for userspace, what happens if an old .so is dynamically
> > > loaded?
>
> CET will be disabled by ld.so in this case.

What if a program starts a thread and then dlopens a legacy .so?

>
> > > Or do all userspace programs and libraries have to have been compiled
> > > with the ENDBRA instructions?
>
> Correct.  ld and ld.so check this.
>
> > If you believe that the userspace tooling for the legacy IBT table
> > actually works, then it should just work.  Yu-cheng, etc: how well
> > tested is it?
> >
>
> Legacy IBT bitmap isn't unused since it doesn't cover legacy codes
> generated by legacy JITs.
>

How does ld.so decide whether a legacy JIT is in use?
