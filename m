Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25F5395CA
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 20:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbiEaSAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbiEaSAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 14:00:47 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF38AE68;
        Tue, 31 May 2022 11:00:46 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f4so13507422pgf.4;
        Tue, 31 May 2022 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbUxo4yAz2zldbWEi0GluCNfOnin3cth9gUswEAqzU8=;
        b=hynBTbzO9rYY0qHxLkPOCSAV7PkFkMuKMQVwaYDYARYuWnM9o4kW+6rxRIYdspG+DS
         J/rTMUxu4nnsZKopHh7CclvjRd+Z/b82662SEdMCD65Cd39uYVAGCiz7JRhBmcVVzQPI
         QDeGJ+IBQiVFYn6Kzx7UMnvT4azS4kAVvyImB+arcqQ6/pihcplCHDY3QyiTllbucoFN
         s+tofLkTZcKnWf2Wl+ZXzM76fOuLvkSS7kcLWWcadnYm+2q0cNkQYAh+4VhLz/wHaBTx
         Ih6Bha6yH+VQl9q2yp7SlKX2ZvfKv5svKSOuMRR/wSv5RH2t4xvwUmZLACrz2ZwjXtqJ
         w9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbUxo4yAz2zldbWEi0GluCNfOnin3cth9gUswEAqzU8=;
        b=OxTvBpXQK2b2q4lqUFeCZ3BUEs8VOTMJm1+29sMYqcy7iZOSehVvrWfI3cdNrlkGFO
         VwW7rXoGVR7e2QvVHtTx6zPqpp4JWRPkH4XDWT1R/5+aUVaKj61oLnCV8bgz2Uyg6LYx
         s+LAlLrvU8XfxixokoxOwQHcEzFwCyxw7LmDHBRymJZ/ACm2JML6Sewd5vgIruEzsVhZ
         bwFujBGYwMZltKXhj0c38s+uy+CC4/3gHRhGijXjXVdFrSAlsIblzo+Qi7aKvxCf/zMp
         apV4kqnP+3jPxBVy7cbZCtheVfdSduTsIvl4+y2yieKW0/90QhOFYcJ3WdFiVHUmqUp3
         SlHg==
X-Gm-Message-State: AOAM5302ifVDr+/pa46HJf4xUH4JALRZsvWkn6QJ2Cxcpf1MJEA1crSk
        /XsBOdDsyeKmFXXmNfZnhLAEM9JQ2Xx+psXId8U=
X-Google-Smtp-Source: ABdhPJw72huO/7ofZw41/IrdbsJVshRqpIuB7v6o/MbZmah6cvF05hc9Bj6ASGuXAbQ+cjixMHZrrtyd3POkZdxlnbM=
X-Received: by 2002:a63:2ad6:0:b0:3f9:d9fa:2713 with SMTP id
 q205-20020a632ad6000000b003f9d9fa2713mr44235809pgq.512.1654020046159; Tue, 31
 May 2022 11:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <Yh0+9cFyAfnsXqxI@kernel.org> <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org> <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org> <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
 <YpYDKVjMEYVlV6Ya@kernel.org> <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
 <YpZEDjxSPxUfMxDZ@kernel.org> <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
In-Reply-To: <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Tue, 31 May 2022 11:00:10 -0700
Message-ID: <CAMe9rOpctH-FQZH_5e=f17Ma7Ev0u9jiXap5bgqFyhLfsx102g@mail.gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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

On Tue, May 31, 2022 at 10:34 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2022-05-31 at 19:36 +0300, Mike Rapoport wrote:
> > > WRSS is a feature where you would usually want to lock it as
> > > disabled,
> > > but WRSS cannot be enabled if shadow stack is not enabled. Locking
> > > shadow stack and WRSS off together doesn't have any security
> > > benefits
> > > in theory. so I'm thinking glibc doesn't need to do this. The
> > > kernel
> > > could even refuse to lock WRSS without shadow stack being enabled.
> > > Could we avoid the extra ptrace functionality then?
> >
> > What I see for is that a program can support shadow stack, glibc
> > enables
> > shadow stack, does not enable WRSS and than calls
> >
> >         arch_prctl(ARCH_X86_FEATURE_LOCK,
> >                    LINUX_X86_FEATURE_SHSTK | LINUX_X86_FEATURE_WRSS);
>
> I see the logic is glibc will lock SHSTK|IBT if either is enabled in
> the elf header. I guess that is why I didn't see the locking happening
> for me, because my manual enablement test doesn't have either set in
> the header.
>
> It can't see where that glibc knows about WRSS though...
>
> The glibc logic seems wrong to me also, because shadow stack or IBT
> could be force-disabled via glibc tunables. I don't see why the elf
> header bit should exclusively control the feature locking. Or why both
> should be locked if only one is in the header.

glibc locks SHSTK and IBT only if they are enabled at run-time. It doesn't
enable/disable/lock WRSS at the moment.  If WRSS can be enabled
via arch_prctl at any time, we can't lock it.  If WRSS should be locked early,
how should it be enabled in application?  Also can WRSS be enabled
from a dlopened object?

> >
> > so that WRSS cannot be re-enabled.
> >
> > For the programs that do not support shadow stack, both SHSTK and
> > WRSS are
> > disabled, but still there is the same call to
> > arch_prctl(ARCH_X86_FEATURE_LOCK, ...) and then neither shadow stack
> > nor
> > WRSS can be enabled.
> >
> > My original plan was to run CRIU with no shadow stack, enable shadow
> > stack
> > and WRSS in the restored tasks using arch_prct() and after the shadow
> > stack
> > contents is restored disable WRSS.
> >
> > Obviously, this didn't work with glibc I have :)
>
> Were you disabling shadow stack via glibc tunnable? Or was the elf
> header marked for IBT? If it was a plain old binary, the code looks to
> me like it should not lock any features.
>
> >
> > On the bright side, having a ptrace call to unlock shadow stack and
> > wrss
> > allows running CRIU itself with shadow stack.
> >
>
> Yea, having something working is really great. My only hesitancy is
> that, per a discussion on the LAM patchset, we are going to make this
> enabling API CET only (same semantics for though). I suppose the
> locking API arch_prctl() could still be support other arch features,
> but it might be a second CET only regset. It's not the end of the
> world.
>
> I guess the other consideration is tieing CRIU to glibc peculiarities.
> Like even if we fix glibc, then CRIU may not work with some other libc
> or app that force disables for some weird reason. Is it supposed to be
> libc-agnostic?
>


-- 
H.J.
