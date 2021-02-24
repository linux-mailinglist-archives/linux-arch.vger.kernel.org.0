Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61433244A3
	for <lists+linux-arch@lfdr.de>; Wed, 24 Feb 2021 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhBXTba (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Feb 2021 14:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233019AbhBXTb2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Feb 2021 14:31:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D55364F0C
        for <linux-arch@vger.kernel.org>; Wed, 24 Feb 2021 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614195047;
        bh=Lq1pRLzytneqVg5GzjUOBxr7UErPTTg7R99LXTu4jks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bktVaOf6y4/5bWKQQSPfMtneTY1Tf+MYRVmtWsHhJUEljQh7DAFxS/43+Udvclz/P
         4uwhgkr39vhLwUdkWL3u/xWOMxywvm21AkhIHJOJG35ouSjUs1+cRi74oDketdnCbn
         UKefUkals+rUocpkVbnWY0GtkV9vSTnJRGPXczv8jYiQ70jAq2tzvmzM19W6d7qZti
         Kz1/3QOhiAii/afgTNwkzN1PC6UIEW5tmnIUEpmJ3R+ZioNfqokC2yqqwHIWtz5VJ5
         1cCYanTplUlIoOQHMo+S4ThKZ1Pf/5uiIIhPmqID00nin9wfsBSrcG4p+qE0JaGu6y
         XfRmlWDIyjn5Q==
Received: by mail-ed1-f46.google.com with SMTP id j9so4035593edp.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Feb 2021 11:30:46 -0800 (PST)
X-Gm-Message-State: AOAM532VWO4pLx0aNUhRALmXMii0G47/B9d6hyMFZtn4p1ST/8HLmpi3
        2ypKd9J9mz0NTOyzZE2V78yGO+cWfSRRqejDIiaT5g==
X-Google-Smtp-Source: ABdhPJzlogxTsjCGzU5seCvYinL8R6SWLGS7Jdf1y0Dy2HvnH6emgV3LCiR+4/d92EKLQEe1rozYaNkkaap0cgFu/2I=
X-Received: by 2002:a05:6402:377:: with SMTP id s23mr21425103edw.172.1614195045281;
 Wed, 24 Feb 2021 11:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20210217222730.15819-1-yu-cheng.yu@intel.com> <20210217222730.15819-7-yu-cheng.yu@intel.com>
 <20210224161343.GE20344@zn.tnic> <32ac05ef-b50b-c947-095d-bc31a42947a3@intel.com>
 <20210224165332.GF20344@zn.tnic> <db493c76-2a67-5f53-29a0-8333facac0f5@intel.com>
 <20210224192044.GH20344@zn.tnic>
In-Reply-To: <20210224192044.GH20344@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Feb 2021 11:30:34 -0800
X-Gmail-Original-Message-ID: <CALCETrXKteS9K=OOgsCvBU4in_3zcYccqF9hh2=OdCJPknvB8Q@mail.gmail.com>
Message-ID: <CALCETrXKteS9K=OOgsCvBU4in_3zcYccqF9hh2=OdCJPknvB8Q@mail.gmail.com>
Subject: Re: [PATCH v21 06/26] x86/cet: Add control-protection fault handler
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, X86 ML <x86@kernel.org>,
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
        Haitao Huang <haitao.huang@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 24, 2021 at 11:20 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Feb 24, 2021 at 09:56:13AM -0800, Yu, Yu-cheng wrote:
> > No.  Maybe I am doing too much.  The GP fault sets si_addr to zero, for
> > example.  So maybe do the same here?
>
> No, you're looking at this from the wrong angle. This is going to be
> user-visible and the moment it gets upstream, it is cast in stone.
>
> So the whole use case of what luserspace needs to do or is going to do
> or wants to do on a SEGV_CPERR, needs to be described, agreed upon by
> people etc before it goes out. And thus clarified whether the address
> gets copied out or not.

I vote 0.  The address is in ucontext->gregs[REG_RIP] [0] regardless.
Why do we need to stick a copy somewhere else?

[0] or however it's spelled.  i can never remember.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
