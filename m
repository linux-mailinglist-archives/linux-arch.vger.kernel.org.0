Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3154E53AD7B
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 21:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiFATan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 15:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFATal (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 15:30:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347017C6AF;
        Wed,  1 Jun 2022 12:28:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b5so2646622plx.10;
        Wed, 01 Jun 2022 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwFYe8vG1hgF//coAlXZoNBBVbmnrkPi8xOD0rdFVts=;
        b=KF2QzfcpN134OIsXyk3kBy72OtuSNqbJHaRvlqkAGA0kbj0Phrwf5K3xBxwidYkUPG
         bJLJl3OjKYDIu8We1CSIRj89bkJWaPAS4LgNgc+eFD3nd7lncagoR28dNSEZsF2gr+qV
         QtTWORwt+ry+x+RIOznMukILrX1XWqyCPsIdq+3O1AVHRR9hoIAoqHnWn19+CqUU3b6e
         ht1Yty84Qu0f1N8QPJmld5ipZgWipzdIBsyTXZe8GDxgAEzY1Ic9Sv+lJL6inUqWJ1b4
         /IMuJbDxT8M1ogwnWI0/Uw5PL76LSXDEJF/2DnKE2lsiLYAFqovXPYhDRYUR3zXGfr6p
         FS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwFYe8vG1hgF//coAlXZoNBBVbmnrkPi8xOD0rdFVts=;
        b=zPueRMssRFimdoyRa0L1gvyouQmKC8WeoOEGwjcPQepp4A1fTEDFgieIrCttG6xAMc
         q18gGVbvORL6Sx6q9tJeqm7XT8NC+Ejfsuw52GeHDZr2dlGKZCcEBA9p3P15fwsR2zpF
         GOoHUT5ywRRSU80xyti2Dh+ealU2UAFEXFRqxdvj29hw/xhBXyzR4/A0J/LiDYGpEHpH
         LZQz865gplPXSNVwPyk0xJxpXqAwIqCwC9yWNEmEhiwZCXTHrMHkpf6jlT5RO4jPwKVG
         UDcxTCir8pywenKcEw+7TY0t2qMrfO6HeSNay+PHAJnueyWARjsuu6esFJpEJ9tV+vnV
         TAyw==
X-Gm-Message-State: AOAM531HhaUzHsZS1otP9QbrVWPzA+dWV+kDLyZeIxZJNuS9qqCOWsFR
        H9FMzAOdEdGa2me7i1aNYdZGKYiyPrcJif+D1oE=
X-Google-Smtp-Source: ABdhPJyDA6C5DQXioXg31Wj9TMeGFjgKh185K1zYFg2Gp28lZkR0rLJ5Az2Ahuku4Ke5Wjt3PdFq+l9pcuaeBfBBob8=
X-Received: by 2002:a17:90b:23d8:b0:1e2:e3cb:ac08 with SMTP id
 md24-20020a17090b23d800b001e2e3cbac08mr967331pjb.35.1654111697802; Wed, 01
 Jun 2022 12:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <Yh0+9cFyAfnsXqxI@kernel.org> <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org> <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org> <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
 <YpYDKVjMEYVlV6Ya@kernel.org> <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
 <YpZEDjxSPxUfMxDZ@kernel.org> <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
 <CAMe9rOpctH-FQZH_5e=f17Ma7Ev0u9jiXap5bgqFyhLfsx102g@mail.gmail.com> <172310e1b8fcc78fca786f9ea7966f58dd93ff93.camel@intel.com>
In-Reply-To: <172310e1b8fcc78fca786f9ea7966f58dd93ff93.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 1 Jun 2022 12:27:41 -0700
Message-ID: <CAMe9rOqwueSXjhkyPfv4+UDbBwf5jtsVjKqm_aD-htkh8k99Rg@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 1, 2022 at 10:27 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2022-05-31 at 11:00 -0700, H.J. Lu wrote:
> > > The glibc logic seems wrong to me also, because shadow stack or IBT
> > > could be force-disabled via glibc tunables. I don't see why the elf
> > > header bit should exclusively control the feature locking. Or why
> > > both
> > > should be locked if only one is in the header.
> >
> > glibc locks SHSTK and IBT only if they are enabled at run-time.
>
> It's not what I saw in the code. Somehow Mike saw something different
> as well.

The current glibc cet branch:

https://gitlab.com/x86-glibc/glibc/-/commits/users/hjl/cet/master

locks only available CET features.  Since only SHSTK is available, I
saw

arch_prctl(0x3003 /* ARCH_??? */, 0x2)  = 0

CET features are always enabled early in ld.so to allow function
calls in the CET enabled ld.so.   ld.so always locks CET features
even if they are disabled when the program or a dependency
library isn't CET enabled.

> >  It doesn't
> > enable/disable/lock WRSS at the moment.  If WRSS can be enabled
> > via arch_prctl at any time, we can't lock it.  If WRSS should be
> > locked early,
> > how should it be enabled in application?  Also can WRSS be enabled
> > from a dlopened object?
>
> I think in the past we discussed having another elf header bit that
> behaved differently (OR vs AND).

We should have a complete list of use cases and design a way to
support them.

-- 
H.J.
