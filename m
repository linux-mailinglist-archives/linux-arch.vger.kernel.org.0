Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4FD7392D7
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFUXGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 19:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUXGA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 19:06:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E865D1988;
        Wed, 21 Jun 2023 16:05:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-763d86856fdso88822885a.3;
        Wed, 21 Jun 2023 16:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687388758; x=1689980758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XDtB2HXrkctzeKU+qZH+wPpskqfD4hoPJ8GizdXePk=;
        b=hN+GOsPk2ssjB6RukkBFAN0V6IKJuYAybWWSoSooirwqwFIszSIi1jqg22yAlKuhOh
         mGCy043EKVyyJzo8Jn+sFY6EXX0yu59Qouh2gm5aJDSexy026ZZ9oZGuOVtPvB3Yx4gq
         zVpWfXUNQrEotUyZZILRQg18m7NYz6/Rie2NVO24Rss1uoxlnI+H9XtkbdQGd5F7t9Im
         Prm1POz9pLrSIDpkvwN1Ce3yM77W57zbLhwaV/AO4xP7U73vIhZzWkANihfQwtAopnSD
         2tZHGp7KCuLdkXzPiVAtJtMK7p1NJ82CCzaCKP7TxaHG8yWro2rWBvd9MYXbIYD506Nh
         5/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687388758; x=1689980758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XDtB2HXrkctzeKU+qZH+wPpskqfD4hoPJ8GizdXePk=;
        b=aEQVqbDoZZwAj/pgju74eh93W/dwDeuqTG+KOfVRadmQuaeinJzDVEDi0ltR6Qs/Zl
         Eq0KvY0J+rPxdPM9wRMrTu4ljc/Ea7rp3c6oYiwbySdC3ManAMmTplvTLAzofzW9q0AW
         MIVEVLq2MvxM5qsVzcWF1H5qBzunZnEky4Jtw2JXCoKJSNZdo5q5Rv2fKREzxKnbWoAL
         keTrsv8PUVdkmuqPFI3ngOzPPTmxx319SiTheoY7HfZ3ztp1RsZsgRn7EulDLvLZNc6M
         OeG42lhdiO2TNc1EQPDgfcSFaEverY949JrC5aZHjqCIOrMpH3k5YoT9lAPdYl2KAhZd
         s0sA==
X-Gm-Message-State: AC+VfDxpBRSNHI/A2iTHaiaskb0JSv6XIpCwGglFbfb00pP01yvgZMPy
        Pu/LTHxMVs1FhbhWMqohEcn2NruXKDXZHpgNECQ=
X-Google-Smtp-Source: ACHHUZ7+oPBsMTAc1Mveb3HrLuKQFV/T8rnORwkd6Of9g9+2i1UOTkMotCPCG0ehoHm9I8Ey+qdZfziEeCO3aB20Y/U=
X-Received: by 2002:a05:620a:3f49:b0:763:9560:c830 with SMTP id
 ty9-20020a05620a3f4900b007639560c830mr9544641qkn.11.1687388757753; Wed, 21
 Jun 2023 16:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <1f04fa59-6ca9-4f18-b138-6c33e164b6c2@sirena.org.uk>
 <49eabafa97032dec8ace7361bccae72c6ecf3860.camel@intel.com>
 <fc2ebfcf-8d91-4f07-a119-2aaec3aa099f@sirena.org.uk> <a0f1da840ad21fae99479288f5d74c7ab9095bb6.camel@intel.com>
 <ZImZ6eUxf5DdLYpe@arm.com> <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com> <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com> <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com> <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
In-Reply-To: <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 21 Jun 2023 16:05:21 -0700
Message-ID: <CAMe9rOpZYwD=v0vcseBrjNvMy4J3Kgy2i8hCcBsU+1gNUcR9qA@mail.gmail.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack description
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
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

On Wed, Jun 21, 2023 at 3:23=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Wed, 2023-06-21 at 11:54 -0700, Rick Edgecombe wrote:
> > > > > > > > there is no magic, longjmp should be implemented as:
> > > > > > > >
> > > > > > > >         target_ssp =3D read from jmpbuf;
> > > > > > > >         current_ssp =3D read ssp;
> > > > > > > >         for (p =3D target_ssp; p !=3D current_ssp; p--) {
> > > > > > > >                 if (*p =3D=3D restore-token) {
> > > > > > > >                         // target_ssp is on a different
> > > > > > > > shstk.
> > > > > > > >                         switch_shstk_to(p);
> > > > > > > >                         break;
> > > > > > > >                 }
> > > > > > > >         }
> > > > > > > >         for (; p !=3D target_ssp; p++)
> > > > > > > >                 // ssp is now on the same shstk as
> > > > > > > > target.
> > > > > > > >                 inc_ssp();
> > > > > > > >
> > > > > > > > this is what setcontext is doing and longjmp can do the
> > > > > > > > same:
> > > > > > > > for programs that always longjmp within the same shstk
> > > > > > > > the
> > > > > > > > first
> > > > > > > > loop is just p =3D current_ssp, but it also works when
> > > > > > > > longjmp
> > > > > > > > target is on a different shstk assuming nothing is
> > > > > > > > running
> > > > > > > > on
> > > > > > > > that shstk, which is only possible if there is a restore
> > > > > > > > token
> > > > > > > > on top.
> > > > > > > >
> > > > > > > > this implies if the kernel switches shstk on signal entry
> > > > > > > > it has
> > > > > > > > to add a restore-token on the switched away shstk.
>
> Wait a second, the claim is that the kernel should add a restore token
> on the current shadow stack before handling a signal, to allow to
> unwind from an alt shadow stack, right? But in this series there is not
> an alt shadow stack, so signal will be handled on the current shadow
> stack. If the user stays on the current shadow stack, the existing
> simple INCSSP based solution will work.
>
> If the user swapcontext()'s away while handling a signal (which *is*
> currently supported) they will leave their own restore token on the old
> stack. Hypothetically glibc could unwind back through a series of
> ucontext stacks by pivoting, if it kept some metadata somewhere about
> where to restore to. So there are actually already enough tokens to
> make it back in this case, glibc just doesn't do this.
>
> But how does the proposed token placed by the kernel on the original
> stack help this problem? The longjmp() would have to be able to find
> the location of the restore tokens somehow, which would not necessarily
> be near the setjmp() point. The signal token could even be on a
> different shadow stack.
>
> So I think the above is short of a design for a universally compatible
> longjmp().
>
> Which makes me think if we did want to make a more compatible longjmp()
> a better the way to do it might be an arch_prctl that emits a token at
> the current SSP. This would be loosening up the security somewhat (have
> to be an opt-in), but less so then enabling WRSS. But it would also be
> way simpler, work for all cases (I think), and be faster (maybe?) than
> INCSSPing through a bunch of stacks.

Since longjmp isn't required to be called after setjmp, leaving a restore
token doesn't work when longjmp isn't called.

> I'm also not sure leaving a token on signal doesn't weaken the security
> it it's own way as well. Any thread could then swap to that token.
> Where as the shadow stack signal frame ssp pointer can only be used
> from the shadow stack the signal was handled on.
>
> So I think, in addition to blocking the shadow stack overflow use case
> in the future, leaving a token behind on signal will not really help
> longjmp(). (or at least I'm not following)
>


--=20
H.J.
