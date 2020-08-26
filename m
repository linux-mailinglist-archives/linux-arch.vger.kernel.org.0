Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D33F2535B0
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHZRFJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 13:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHZRFH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Aug 2020 13:05:07 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4355C22CA0
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598461506;
        bh=Fp4rNpiuId6Zd1SRZaw++Fjp3anMdRDaszmTeS7uFZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IXsZbehfS9rUMHIUdoa09eOQCVQ3Gh0ntq3FHoKtDEBmxNo4m64QNUZgFCYV/FBvm
         pA0iOF4Eb1d4wGL5f7juoUUApYPt8PaUV0XRtuZ1fvkTFHbKiaCRhCTKGYqTqFGDje
         m7p05GH9gD2W5ZWdl9vtHaNQM1v4gDB8YxzDl5VE=
Received: by mail-wr1-f48.google.com with SMTP id c15so2543954wrs.11
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 10:05:06 -0700 (PDT)
X-Gm-Message-State: AOAM53144j71HPLuo7Gemv4xWvrx3nPNYzueJGF+EWXVyQf2FCP8T2sv
        xdJU+sCyELxDtO0NKGXTUwdAktbA2IbOMfzX8i18IA==
X-Google-Smtp-Source: ABdhPJxT1whGlvFPDBPqTZxg6JBM1ZNVE0c8Sb8po9BtCcEYhiPPubL7pcyJ9YiMCYEcuPYkefPEyiGW6FbklL+xVTI=
X-Received: by 2002:a5d:570e:: with SMTP id a14mr1919991wrv.70.1598461504645;
 Wed, 26 Aug 2020 10:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002540.3351-1-yu-cheng.yu@intel.com> <20200825002540.3351-26-yu-cheng.yu@intel.com>
 <CALCETrVpLnZGfWWLpJO+aZ9aBbx5KGaCskejXiCXF1GtsFFoPg@mail.gmail.com>
 <2d253891-9393-44d0-35e0-4b9a2da23cec@intel.com> <086c73d8-9b06-f074-e315-9964eb666db9@intel.com>
 <73c2211f-8811-2d9f-1930-1c5035e6129c@intel.com> <af258a0e-56e9-3747-f765-dfe45ce76bba@intel.com>
 <ef7f9e24-f952-d78c-373e-85435f742688@intel.com> <20200826164604.GW6642@arm.com>
 <87ft892vvf.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87ft892vvf.fsf@oldenburg2.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Aug 2020 10:04:53 -0700
X-Gmail-Original-Message-ID: <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
Message-ID: <CALCETrVeNA0Kt2rW0CRCVo1JE0CKaBxu9KrJiyqUA8LPraY=7g@mail.gmail.com>
Subject: Re: [PATCH v11 25/25] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 26, 2020 at 9:52 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Dave Martin:
>
> > On Tue, Aug 25, 2020 at 04:34:27PM -0700, Yu, Yu-cheng wrote:
> >> On 8/25/2020 4:20 PM, Dave Hansen wrote:
> >> >On 8/25/20 2:04 PM, Yu, Yu-cheng wrote:
> >> >>>>I think this is more arch-specific.  Even if it becomes a new syscall,
> >> >>>>we still need to pass the same parameters.
> >> >>>
> >> >>>Right, but without the copying in and out of memory.
> >> >>>
> >> >>Linux-api is already on the Cc list.  Do we need to add more people to
> >> >>get some agreements for the syscall?
> >> >What kind of agreement are you looking for?  I'd suggest just coding it
> >> >up and posting the patches.  Adding syscalls really is really pretty
> >> >straightforward and isn't much code at all.
> >> >
> >>
> >> Sure, I will do that.
> >
> > Alternatively, would a regular prctl() work here?
>
> Is this something appliation code has to call, or just the dynamic
> loader?
>
> prctl in glibc is a variadic function, so if there's a mismatch between
> the kernel/userspace syscall convention and the userspace calling
> convention (for variadic functions) for specific types, it can't be made
> to work in a generic way.
>
> The loader can use inline assembly for system calls and does not have
> this issue, but applications would be implcated by it.
>

I would expect things like Go and various JITs to call it directly.

If we wanted to be fancy and add a potentially more widely useful
syscall, how about:

mmap_special(void *addr, size_t length, int prot, int flags, int type);

Where type is something like MMAP_SPECIAL_X86_SHSTK.  Fundamentally,
this is really just mmap() except that we want to map something a bit
magical, and we don't want to require opening a device node to do it.

--Andy
