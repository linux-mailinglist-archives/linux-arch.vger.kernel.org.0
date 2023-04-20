Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E36E8CEC
	for <lists+linux-arch@lfdr.de>; Thu, 20 Apr 2023 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjDTIgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 04:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 04:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596413C31;
        Thu, 20 Apr 2023 01:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7AB66460B;
        Thu, 20 Apr 2023 08:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F9C4339E;
        Thu, 20 Apr 2023 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681979792;
        bh=sEawzxBfsQuwG5y+dWimYLd+jqvDGsYfpjI5vDaYBwo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rhD901AskVduoiR8jcYbsoilkHhIk1c4/jP/wFnbyvv36qvRwDGSi7OUpBwRC7h6/
         +AZG6cFijgToJPW3eE8jqG8GPzpxIhXpQjDDECrHmPHNnQzOIC1kvdM4lkzj5cMnWT
         7MfLN9ICknt0WntJGXs0p6NYJ9oQJGsks0RhPluRmkH937JwBYsPu23MuwfJIB7YpE
         KlsOTAgnTSnEFlKBxgTV9Z5+3NC9Nw//9GIysdvgVlajJwYiCweruqVMa40U6AZBVf
         uI/m15v5uIl78su39Mzt/pyHa72rBIh8zSsFIFqRTDZNouBa7iZekaKyMdqVwDtQ7C
         MNiwMW8KI7j0Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso617610a12.1;
        Thu, 20 Apr 2023 01:36:32 -0700 (PDT)
X-Gm-Message-State: AAQBX9eNjhCN5iqSuSHlFmF7MV+HkNsDh+qfGTWxMLaVgQGRaegcDM4u
        7Kvge0mrWyUtGtBdb5Y+2rZZKO/5MRpV2FSHdws=
X-Google-Smtp-Source: AKy350bxtCS4gctVzwoYAwn8RttxXNaUcCxyBObX+0qpOY69mFfp6vG7+mFFoejUTKHevs8vn5LskFXb0d6Zi1C+KGY=
X-Received: by 2002:a05:6402:7c2:b0:508:4954:e30c with SMTP id
 u2-20020a05640207c200b005084954e30cmr1096793edy.11.1681979790467; Thu, 20 Apr
 2023 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230416173326.3995295-1-kernel@xen0n.name> <e593541e7995cc46359da3dd4eb3a69094e969e2.camel@xry111.site>
 <6ca642a9-62a6-00e5-39ac-f14ef36f6bdb@xen0n.name> <f54abfae989023fcfdabb4e9800a66847c357b85.camel@xry111.site>
In-Reply-To: <f54abfae989023fcfdabb4e9800a66847c357b85.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 20 Apr 2023 16:36:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7zTjSsz=e+0r-9Z0KOF-Gxr-chXnVgWo+4eNA1ptWw1g@mail.gmail.com>
Message-ID: <CAAhV-H7zTjSsz=e+0r-9Z0KOF-Gxr-chXnVgWo+4eNA1ptWw1g@mail.gmail.com>
Subject: Re: [PATCH 0/2] LoongArch: Make bounds-checking instructions useful
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        WANG Xuerui <git@xen0n.name>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

I hope V2 can be applied cleanly without the patch series "LoongArch:
Better backtraces", thanks.

Huacai

On Mon, Apr 17, 2023 at 5:50=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Mon, 2023-04-17 at 15:54 +0800, WANG Xuerui wrote:
> > On 2023/4/17 14:47, Xi Ruoyao wrote:
> > > On Mon, 2023-04-17 at 01:33 +0800, WANG Xuerui wrote:
> > > > From: WANG Xuerui <git@xen0n.name>
> > > >
> > > > Hi,
> > > >
> > > > The LoongArch-64 base architecture is capable of performing
> > > > bounds-checking either before memory accesses or alone, with specia=
lized
> > > > instructions generating BCEs (bounds-checking error) in case of fai=
led
> > > > assertions (ISA manual Volume 1, Sections 2.2.6.1 [1] and 2.2.10.3 =
[2]).
> > > > This could be useful for managed runtimes, but the exception is not
> > > > being handled so far, resulting in SIGSYSes in these cases, which i=
s
> > > > incorrect and warrants a fix in itself.
> > > >
> > > > During experimentation, it was discovered that there is already UAP=
I for
> > > > expressing such semantics: SIGSEGV with si_code=3DSEGV_BNDERR. This=
 was
> > > > originally added for Intel MPX, and there is currently no user (!) =
after
> > > > the removal of MPX support a few years ago. Although the semantics =
is
> > > > not a 1:1 match to that of LoongArch, still it is better than
> > > > alternatives such as SIGTRAP or SIGBUS of BUS_OBJERR kind, due to b=
eing
> > > > able to convey both the value that failed assertion and the bound v=
alue.
> > > >
> > > > This patch series implements just this approach: translating BCEs i=
nto
> > > > SIGSEGVs with si_code=3DSEGV_BNDERR, si_value set to the offending =
value,
> > > > and si_lower and si_upper set to resemble a range with both lower a=
nd
> > > > upper bound while in fact there is only one.
> > > >
> > > > The instructions are not currently used anywhere yet in the fledgli=
ng
> > > > LoongArch ecosystem, so it's not very urgent and we could take the =
time
> > > > to figure out the best way forward (should SEGV_BNDERR turn out not
> > > > suitable).
> > >
> > > I don't think these instructions can be used in any systematic way
> > > within a Linux userspace in 2023.  IMO they should not exist in
> > > LoongArch at all because they have all the same disadvantages of Inte=
l
> > > MPX; MPX has been removed by Intel in 2019, and LoongArch is designed
> > > after 2019.
> >
> > Well, the difference is IMO significant enough to make LoongArch
> > bounds-checking more useful, at least for certain use cases. For
> > example, the bounds were a separate register bank in Intel MPX, but in
> > LoongArch they are just values in GPRs. This fits naturally into
> > JIT-ting or other managed runtimes (e.g. Go) whose slice indexing ops
> > already bounds-check with a temporary register per bound anyway, so it'=
s
> > just a matter of this snippet (or something like it)
> >
> > - calculate element address
> > - if address < base: goto fail
> > - load/calculate upper bound
> > - if address >=3D upper bound: goto fail
> > - access memory
> >
> > becoming
> >
> > - calculate element address
> > - asrtgt address, base - 1
> > - load/calculate upper bound
> > - {ld,st}le address, upper bound
> >
> > then in SIGSEGV handler, check PC to associate the signal back with the
> > exact access op;
>
> I remember using the signal handler for "usual" error handling can be a
> very bad idea but I can't remember where I've read about it.  Is there
> any managed environments doing so in practice?
>
> If we redefine new_ldle/new_stle as "if [[likely]] the address is in-
> bound, do the load/store and skip the next instruction; otherwise do
> nothing", we can say:
>
> blt        address, base, 1f
> new_ldle.d rd, address, upperbound
> 1:b        panic_oob_access
> xor        rd, rd, 42 // use rd to do something
>
> This is more versatile, and useful for building a loop as well:
>
> or            a0, r0, r0
> 0:new_ldle.d  t1, t0, t2
> b             1f
> add.d         a0, t1, a0
> add.d         t0, t0, 8
> b             0b
> 1:bl          do_something_with_the_sum
>
> Yes it's "non-RISC", but at least more RISC than the current ldle: if
> you want a trap anyway you can say
>
> blt        address, base, 1f
> new_ldle.d rd, address, upperbound
> 1:break    {a code defined for OOB}
> xor        rd, rd, 42 // use rd
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
