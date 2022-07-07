Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A856A1C3
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiGGMN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 08:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiGGMN1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 08:13:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D65721A;
        Thu,  7 Jul 2022 05:13:22 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHXWL-1oMwu94Ak5-00DVYb; Thu, 07 Jul 2022 14:13:21 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-317a66d62dfso167940137b3.7;
        Thu, 07 Jul 2022 05:13:20 -0700 (PDT)
X-Gm-Message-State: AJIora8CQlfh5jzBkohQCquTnvDQtwpNZZ/PLumOtErfs0nKblNAkwTG
        h5MvPjdU8EPWAaXI3o/N4/cmr2oTfcTdtcwEfFo=
X-Google-Smtp-Source: AGRyM1tV/DrF7ycXM3ug40hQQx3lr8bWg0MpBEk4G23+AfClxifxNOoCzy63rJK/JM88aL8UcFxTAzCzt8zqWWCvBBY=
X-Received: by 2002:a81:f82:0:b0:31c:f1ae:1ed6 with SMTP id
 124-20020a810f82000000b0031cf1ae1ed6mr8719242ywp.249.1657195999598; Thu, 07
 Jul 2022 05:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop> <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
In-Reply-To: <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 14:13:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
Message-ID: <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:y52jjYOeb8evCJVCb5GPlS8PD3mNk7Rl/98+o9yukeYkRQmbpvw
 ix5q9v9/qPmrzHFoc4szA2n5Nwqrt2jtQzoFaD3RvO9nn/Jum2GdQHZFDBUohnq5JvnC9f8
 uLIlczj4Y9SsfAF+yG6m5wfDm/3fxm+SFhRx+6a5T0bWQS0J+Uf2ETppa8c0nJjQVGTaSvE
 iQrvZE1HxvxSoPXzKG88A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:izA6gWP3DDQ=:4/Ax1o5QZ1i74hAOv3jMfN
 SI2GsWbL4XI9xYsiIk4/dcHrPRdXz3F//fh7kiijBjnt5pxpoYvFeukfs574SSjkNG2TuXadf
 pvulI1yKVzFS7E8jbzmbf5/OWuoRLvewRWhTSpyFMcRtZHA217dW9/ImnA5qkN44iMGsoPcPc
 77i7n+V4di2PZ3wFP2gBADcExaAXUxRCLh+z9ix0/tpKZ/gV41Zz/gl1T6dV+0cD+Ca5zpcNr
 NfEToICEBmshRxpICf0keZaCHmhLXun5SD/7i8Nwrc53tyDdyhO5GVh2hp3gK74/g0dzqLdvC
 CLy50aYdZ194D/UAjxZE6sP3OdWWXEDqs1SxxqV8yK0XWpxuhWtgDEZp4yH57bd7y0yb+uCLL
 ZLLzEN6+nm/kA8OI3aLGPjDYoAdPsIcQfErZXZD1i2BcwMXPwaEdVYuQbpZ293WKBo2CTuG3m
 IQ+ryzTug5Moq3tDVi9M28ofqbCqWW+5ftQbtJnQOE8fdbWf6WTE451SytS5z5wgtvGwT8O0W
 7u8rfnWX8rIl9tdZS9Yo2QgzrNi74isPCpYeGp70XnCs5/IZHkzGAGO3L17RJnKlbcyn9N7Yb
 IWpnxqECb6bIicuA6ulBKmioil9zIIxZ5zejIvLxqWfU0wly2FPVgilm7d+rfsnihVHHiB8Mi
 +4BTG4Xt3EsddpgC4lQFD9xaaz4uG2fRBRsvMmPhOzsh00mgP+1ZblvY7O+27AXXpQdSuPsKn
 WuK9fVm0neJA90vx6Xr/rAUZkp+Wu0eQ7s8TgQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 7, 2022 at 1:40 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Wed, Oct 6, 2021 at 6:52 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > On Wed, 06 Oct 2021 08:17:38 PDT (-0700), Arnd Bergmann wrote:
> > > On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >>
> > >> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > >> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> > >> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> > >> in the reference) in ./include/asm-generic/io.h.
> > >>
> > >> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> > >>
> > >> GENERIC_DEVMEM_IS_ALLOWED
> > >> Referencing files: include/asm-generic/io.h
> > >>
> > >> Correct the name of the config to the intended one.
> > >>
> > >> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >
> > Thanks.  I'm going to assume this is going in through some other tree,
> > but IIUC I sent the buggy patch up so LMK if you're expecting it to go
> > through mine.
>
> Palmer, Arnd,
>
> the patch in this mail thread got lost and was not picked up yet.
>
> MAINTAINERS suggests that Arnd takes patches to include/asm-generic/,
> since commit 1527aab617af ("asm-generic: list Arnd as asm-generic
> maintainer") in 2009, but maybe the responsibility for those files has
> actually moved on to somebody (or nobody) else and we just did not
> record that yet in MAINTAINERS.
>
> Arnd, will you pick this patch and provide it further to Linus Torvalds?
>
> Otherwise, Palmer already suggested picking it up himself.
>

I've applied it to the asm-generic tree and can send it as a bugfix
pull request. I don't have any other fixer for that branch at the moment,
so if Palmer has other fixes for the riscv tree already, it would
save me making a pull request if he picks it up there.

       Arnd
