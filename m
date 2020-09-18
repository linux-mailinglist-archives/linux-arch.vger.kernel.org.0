Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAAE270868
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRVgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRVgs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:36:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7170EC0613CE;
        Fri, 18 Sep 2020 14:36:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m17so8624759ioo.1;
        Fri, 18 Sep 2020 14:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYAfKOEgqTvyvH0yDy3llMH0PY9ahaiDfu83a2kBOFs=;
        b=KL1m+3ilCVTJWW4GEz6PYiYht8QSLyBWsxXqbceneOydilxk6IrertQdBtA2CBI86L
         WSMD/cf/ZhKtIvBJpcrokAe/Xt0vEpWOO3fm1z8KNdFEXXrIVcYVnnaD2ln73UBCeWOl
         yu3pZDws9ashJZGh/QIj4vuWx2TBWwtFoU6FvoT+c++UO2XHEoINN9rEME+AnVxslmtF
         VzoxMB+Hufev73B1IRmeKm+JCi9JBWLSaYKxnZS607wEaGrkHD/t3oSh1keAEK7ViOQr
         EvFRyZb45rQHwrjluEGg9JANUw6IVf1geB1isIB8hEYC1doRYCexQtAm4WS6/WB3w4Hj
         Purg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYAfKOEgqTvyvH0yDy3llMH0PY9ahaiDfu83a2kBOFs=;
        b=t1gMahsQwaCk6uEUfYPCMmP3svitewbWJghpHSh8Ck/cTox71y6PvQfzltPCCyiSga
         zpq9cMvndPf4FezOR/3uSBtO/p9py3nIFQl2dYnd4cPXVWoXcLaIDvAQB3D5pjm4vRnf
         58Aspj15iATUNn0KW625Py1tykN6ZQRAtHS+O/EFagHeVxceI7jbO1WN/tYlkhCZsCQX
         N5/h9ge0Mz5XGvEGibpuXaFR7AcVW+C7exXNstVvjWMR4WtSlcR0BVmLL/pjKFmEKNHx
         778YXzDr8YnjRbaDfO41QeI5zpUOAlHO6yzpnPigcEjf95e+QrOHncriDYBrczBcRa0Y
         Tl5w==
X-Gm-Message-State: AOAM530YCEWXgXJWCEip0xJ4v0lotw180DiMNPxs8gQ9jkCljs4u7ugW
        dcEBWcgjbfHa4psXqzP2fKa1IUod8Hr1VEV6dIg=
X-Google-Smtp-Source: ABdhPJxcSizO6W8h2GV+qS06uMaeznfZ+zoijcOqzbPihxuHG8PsGc9HW19RbwJQQTgjZshpByRKce18anYGPKoMnRQ=
X-Received: by 2002:a05:6602:6c9:: with SMTP id n9mr28333723iox.91.1600465007846;
 Fri, 18 Sep 2020 14:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-2-yu-cheng.yu@intel.com>
 <ce2524cc-081b-aec9-177a-11c7431cb20d@infradead.org> <20200918205933.GB4304@duo.ucw.cz>
 <CAMe9rOo0+SBPtN7yb8_-h0dRAoOXkad8wi9d-EiWAfgFSedXjQ@mail.gmail.com> <20200918212403.GE4304@duo.ucw.cz>
In-Reply-To: <20200918212403.GE4304@duo.ucw.cz>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 18 Sep 2020 14:36:11 -0700
Message-ID: <CAMe9rOrO_Yat4VbeqDvs8UsjOhEtCiDW0pLY-kQkK8yND_iO_A@mail.gmail.com>
Subject: Re: [PATCH v12 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
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

On Fri, Sep 18, 2020 at 2:24 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > > +   help
> > > > > +     Indirect Branch Tracking (IBT) provides protection against
> > > > > +     CALL-/JMP-oriented programming attacks.  It is active when
> > > > > +     the kernel has this feature enabled, and the processor and
> > > > > +     the application support it.  When this feature is enabled,
> > > > > +     legacy non-IBT applications continue to work, but without
> > > > > +     IBT protection.
> > > > > +
> > > > > +     If unsure, say y
> > > >
> > > >         If unsure, say y.
> > >
> > > Actually, it would be "If unsure, say Y.", to be consistent with the
> > > rest of the Kconfig.
> > >
> > > But I wonder if Yes by default is good idea. Only very new CPUs will
> > > support this, right? Are they even available at the market? Should the
> > > help text say "if your CPU is Whatever Lake or newer, ...." :-) ?
> > >
> >
> > CET enabled kernel runs on all x86-64 processors.  All my machines
> > are running the same CET enabled kernel binary.
>
> I believe that.
>
> But enabling CET in kernel is useless on Core 2 Duo machine, right?
>

This is very important for CET kernel to run on Core 2 Duo machine.
Otherwise, a distro needs to provide 2 kernel binaries, one for CET
CPU and one for non-CET CPU.


-- 
H.J.
