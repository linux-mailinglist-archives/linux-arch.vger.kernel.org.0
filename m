Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148B37395CD
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 05:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjFVDY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVDYY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 23:24:24 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59861A4;
        Wed, 21 Jun 2023 20:24:23 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57015b368c3so59245677b3.3;
        Wed, 21 Jun 2023 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687404263; x=1689996263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4O28N8FGaP9hA4+6ahHxAcfwQx7IU5FkHKln14GG3Y=;
        b=NNzIU7JYQjWLGByJ0BDfsfQXPqUrK8MTUXGyV2D7lW4Bm2q/Ik9xu4/R9FF6nlsBJ3
         TIHN8+qx+P5YQSu3BRXBrADFh6Rqc82tvQV2NucSTLEHqjw2x5J/wx8T/UxoG6g+6W41
         BXCJp8iHfs3Q5LrKoKhMijiFDtHv6grmRkjMveBM6SShEnRHOCRtOEygGCX27SS1yLxo
         yCwfd8Z1Em0R8BJNkMXT+T61pRnBAPPWzTnB/pCpF+guhA/9FHrDf0XOl3iXXx8dLsJY
         J/mabNfXG0tb1BXV8NzPSOyBFOSkyMDAhwf7P9X4WVIF7ZbCsrUu+YD4LVDl+9W/VRku
         WJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687404263; x=1689996263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4O28N8FGaP9hA4+6ahHxAcfwQx7IU5FkHKln14GG3Y=;
        b=PNQ70k29dV02skC3Ig6Pc8rkGyuMquNPl2fr4QreWhDpeyKP3BdNJfOuztKvq+4KUl
         Yv97u465xqbqQMWh22IG7LfPkTqwbpbKKD/AkgunaDLYJrGh3qyppsX5zlBPbfD+Di1T
         9Lta8aT584VUBaEOrakIn4nst6AI/Qe8XcPo0GEgt/xNMxnc/15eFeifeqObViMxeX1m
         j5PpPfhilkDZlP8xxyYrIhOpMRbtsBhujKI9NZ5ncYxHs+jZ5awYYcl+UZXnC/tQUJgt
         yz2PIbvnlAsjq7iJ+Ex+baIHLHSXp9VNWKasfRCMYDZRnDLWkpN9GnjIueobbU4fvkz5
         Ed9g==
X-Gm-Message-State: AC+VfDwcwA/4jT5WGocW+TJ+X3jdlalCNtTlOY4ZUSdunqIXWXdkanjz
        4VfypchKJ10iT+egE4LPVqmdcYGCNz8y2nCz7eE=
X-Google-Smtp-Source: ACHHUZ59kfPGrSfKxuh324V37hD7nPSrroGRA6spekBztu808vKYMl2ssvTY0BHJNvqM8Z1gQTVEnHiRioEMUW3M1y4=
X-Received: by 2002:a81:48d0:0:b0:56d:1521:4f6c with SMTP id
 v199-20020a8148d0000000b0056d15214f6cmr16992828ywa.16.1687404263010; Wed, 21
 Jun 2023 20:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk> <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com> <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com> <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com> <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com> <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
 <CAMe9rOpZYwD=v0vcseBrjNvMy4J3Kgy2i8hCcBsU+1gNUcR9qA@mail.gmail.com>
 <c7df57a7489ff555fc531d19a5a4a689f6f99a7c.camel@intel.com> <66042cf07ed596d33f714ef152153361c77567d7.camel@intel.com>
In-Reply-To: <66042cf07ed596d33f714ef152153361c77567d7.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 21 Jun 2023 20:23:46 -0700
Message-ID: <CAMe9rOohfEbCEiaP=DO2StzkwTncdudwZ9DOC87Vz+Q03rQ9Qw@mail.gmail.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "david@redhat.com" <david@redhat.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 6:07=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2023-06-21 at 16:15 -0700, Rick Edgecombe wrote:
> > On Wed, 2023-06-21 at 16:05 -0700, H.J. Lu wrote:
> > > > Which makes me think if we did want to make a more compatible
> > > > longjmp()
> > > > a better the way to do it might be an arch_prctl that emits a
> > > > token
> > > > at
> > > > the current SSP. This would be loosening up the security somewhat
> > > > (have
> > > > to be an opt-in), but less so then enabling WRSS. But it would
> > > > also
> > > > be
> > > > way simpler, work for all cases (I think), and be faster (maybe?)
> > > > than
> > > > INCSSPing through a bunch of stacks.
> > >
> > > Since longjmp isn't required to be called after setjmp, leaving a
> > > restore
> > > token doesn't work when longjmp isn't called.
> >
> > Oh good point. Hmm.
>
> Just had a quick chat with HJ on this. It seems like it *might* be able
> to made to work. How it would go is setjmp() could act as a wrapper by
> calling it's own return address (the function that called setjmp()).
> This would mean in the case of longjmp() not being called, control flow
> would return through setjmp() before returning from the calling method.

It may not work since we can't tell if RAX (return value) is set by longjmp
or function return.

> This would allow libc to do a RSTORSSP when returning though setjmp()
> in the non-shadow stack case, and essentially skip over the kernel
> placed restore token, and then return from setjmp() like normal. In the
> case of longjmp() being called, it could RSTORSSP directly to the
> token, and then return from setjmp().
>
> Another option could be getting the compilers help to do the RSTORSSP
> in the case of longjmp() not being called. Apparently compilers are
> aware of setjmp() and already do special things around it (makes sense
> I guess, but news to me).
>
> And also, this all would actually work with IBT, because the compiler
> knows already to add an endbr at that point right after setjmp().
>
> I think neither of us were ready to bet on it, but thought maybe it
> could work. And even if it works it's much more complicated than I
> first thought, so I don't like it as much. It's also unclear what a
> change like that would mean for security.
>
> As for unwinding through the existing swapcontext() placed restore
> tokens, the problem was as assumed - that it's difficult to find them.
> Even considering brute force options like doing manual searches for a
> nearby token to use turned up edge cases pretty quick. So I think that
> kind of leaves us where we were originally, with no known solutions
> that would require breaking kernel ABI changes.
>
>
> Are you interested in helping get longjmp() from a ucontext stack
> working for shadow stack? One other thing that came up in the
> conversation was that while it is known that some apps are doing this,
> there are no tests for mixing longjmp and ucontext in glibc. So we may
> not know which combinations of mixing them together even work in the
> non-shadow stack case.
>
> It could be useful to add some tests for this to glibc and we could get
> some clarity on what behaviors shadow stack would actually need to
> support.



--=20
H.J.
