Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2F56A328
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiGGNHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbiGGNHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 09:07:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93230551;
        Thu,  7 Jul 2022 06:07:29 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MbRXd-1ncZNe3bGj-00btSj; Thu, 07 Jul 2022 15:07:28 +0200
Received: by mail-yb1-f180.google.com with SMTP id h132so1680379ybb.4;
        Thu, 07 Jul 2022 06:07:27 -0700 (PDT)
X-Gm-Message-State: AJIora8R72R7HjT8KgED1EU4OYMq+pMxMHwG3MAOICMue5e0cgr9CtrO
        LwwQLbPVd0lSlKQkJI0Z+VxPFJwLbLH4sZwEsS4=
X-Google-Smtp-Source: AGRyM1tDLI1o8/Y0A+kLC4sBFmobSnsX0dpLPEdqGjJbIqO9YhhuY84UIc4kb1l5oqjp2OMrL8CPptOCmOlr92ZWup4=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr49857681ybq.472.1657199246218; Thu, 07
 Jul 2022 06:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com> <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com>
In-Reply-To: <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Jul 2022 15:07:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
Message-ID: <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6GE+clHrGvNzl04i8kcAIR3zFF2F8809ljPATS5+RhKOVPkVLep
 +QzEVU5Mh5xDAhGn+iYd+H8N2mpvqIVBdia+eufN/Dqcv3K3vy5/hLx/zaKOCacBTLo3dcc
 Ab6xrjYkLJ9O8ort+l6IUOhqDY2nqU30EZAk3uuCC8wZGBtfLDsrPFucP/dKyZUq68PscmE
 nif3CpFju8svLvnQTXbCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tvthlhlazMY=:a4X17KeL0MVHY10lRgV0a0
 P9mhqRXkxUFHYWkfFZ77jE6Hubx81lJmwxH80sD+vCS1p1x2mfUSJWyo7zYTtSRlh3XjO/njw
 kCQFGHtDenBcIYnn6fGGfO4BNaJo26qfVlf4d+fnR7TVKodStOmgx/4+Xtmy0KQobI9Vvr2qM
 FgawDfIeDwSBDIQ8ySECbVZJNVv1kUcXKjTzGTffBLpxNMRx4j7PeFm9/1/qyAmSDoFuCACy3
 yfxkLedP5s/fZ+SogUP5hlHiimPb/sGK3PJfht4woFg8ivNSDjzCiSbRFqamVtNXeybs6+LlU
 PTyqOUMLY79DQlP4tDrkf6Tj+t5Z2aTmsiVFn9OfWzSDydgIK1U55j/g0zGGgvNMVar0g7zfV
 VmxRRXfVotZt1y9do7zfiIu+15GfsuULoQ8ype9/oPIGaFTAFxMesBNp0Zk7rLSUc7+xoF8rx
 hFW8TZooYyM2//WhQPLRZ2Mix1dt6BIfknThrE/HHrLNYm5loazJv5MaILuN4cDEox+2f1241
 ffcImF5D4QjH9sYxHbeiTbn+Arxaupeyt7kGYY6CL+JY9shg8hkHXYl8jlX4smDeXlPC6YgYs
 XZZzfCflXmmTvdpJZ077YufF92q+KfJP8/U3UPsTa+y68PoxbvhRxP1pkCzDeKSsjjBwHtANr
 uncfNmiKEcvmrpjGlDOD3ZtlvpOoKk3/TQD/t/psUKA5hnhsiSpSHgN6i3megBuZa76CNTsQf
 aoKy7dvIfAWSODVWLyu+Yy+MKlrGzwlm+04vWu+w0iT+gyJcTcla0Dw/4jWWmFKVPFltIFhqB
 dwu2n/jmgPhF3gv3B/U6N+JbRatTiHX6LE1ukBvf+5rYuAjT0W9qRVQeKwYUfj0m+hJO+YmuN
 gvrofGegVTbGILZjbE3nCjmxVB/mqq1SCC4e12F74=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 7, 2022 at 2:20 PM <Conor.Dooley@microchip.com> wrote:
> On 07/07/2022 13:13, Arnd Bergmann wrote:
> > On Thu, Jul 7, 2022 at 1:40 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >>
> >> On Wed, Oct 6, 2021 at 6:52 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >>>
> >>> On Wed, 06 Oct 2021 08:17:38 PDT (-0700), Arnd Bergmann wrote:
> >>>> On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >>>>>
> >>>>> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> >>>>> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> >>>>> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> >>>>> in the reference) in ./include/asm-generic/io.h.
> >>>>>
> >>>>> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> >>>>>
> >>>>> GENERIC_DEVMEM_IS_ALLOWED
> >>>>> Referencing files: include/asm-generic/io.h
> >>>>>
> >>>>> Correct the name of the config to the intended one.
> >>>>>
> >>>>> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> >>>>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >>>>
> >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> >>>
> >>> Thanks.  I'm going to assume this is going in through some other tree,
> >>> but IIUC I sent the buggy patch up so LMK if you're expecting it to go
> >>> through mine.
> >>
> >> Palmer, Arnd,
> >>
> >> the patch in this mail thread got lost and was not picked up yet.
> >>
> >> MAINTAINERS suggests that Arnd takes patches to include/asm-generic/,
> >> since commit 1527aab617af ("asm-generic: list Arnd as asm-generic
> >> maintainer") in 2009, but maybe the responsibility for those files has
> >> actually moved on to somebody (or nobody) else and we just did not
> >> record that yet in MAINTAINERS.
> >>
> >> Arnd, will you pick this patch and provide it further to Linus Torvalds?
> >>
> >> Otherwise, Palmer already suggested picking it up himself.
> >>
> >
> > I've applied it to the asm-generic tree and can send it as a bugfix
> > pull request. I don't have any other fixer for that branch at the moment,
> > so if Palmer has other fixes for the riscv tree already, it would
> > save me making a pull request if he picks it up there.

lkft just found a build failure:

https://gitlab.com/Linaro/lkft/users/arnd.bergmann/asm-generic/-/jobs/2691154818

I have not investigated what went wrong, but it does look like an actual
regression, so I'll wait for Lukas to follow up with a new version of the patch.

       Arnd
