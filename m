Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012EA56A5B3
	for <lists+linux-arch@lfdr.de>; Thu,  7 Jul 2022 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiGGOlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Jul 2022 10:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiGGOla (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2022 10:41:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696773190D;
        Thu,  7 Jul 2022 07:41:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31bf3656517so171608217b3.12;
        Thu, 07 Jul 2022 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5bjrIIk4MXIN8C31qiFXOS3/fG2/z8CmTSANmVxdy8=;
        b=kmWYMaUMp2mRClBKlIj7qLT5zJaCjwENeyNTjiQSNrIIRkJfTvFvh2WWMa6PAyijFV
         aU0AIDpaSpv3DPCNoEKYmqOMND86p2POEJX2rqKTOeJRPeB9X8I0f74xiRgljzu7tapS
         uIcVwArIYwk25FopRMaItDjuT0uN5EaAZQ/xJ2SCvSg12v3i/5n8a5mqTOOyQxOEo6jW
         ZQvmi7WnA/CsW6y2pziC9JVgpBdvfR1oUGlWX4S7DsvrIpUM9dPt7dWw/h86fH2LUsCI
         UPOBoZOQRx+ZLscbfduFYEZ4vqN3MmBkIFVtryHPHgANKOGb2IdC8YpppE1Ybnsopu63
         oH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5bjrIIk4MXIN8C31qiFXOS3/fG2/z8CmTSANmVxdy8=;
        b=n9gEx5MO2niFaoGo0t90jdWMPDc/lgcQ57sG6qouranT4BFcUk9SjH4COW9+OIX+a8
         nPBQYE3zhDWZNb+lHq7kWtNBik5EHzV8Z9/wdsPykJpyTm9SbYubOWbUGO9ZdAJwEIFV
         rJqS1O8/gNqa6tpwR++2BzkCajgJ7lPv5sy2W2aUmXechflGSDDsMXoAPwFWxs1PaWiP
         Ei4Hy+sPyIOQig/w3BE2ICNvcO3cOnNZMFdpc0GhGhwuJqaG9wa0P8FYdFM0u+7IdavB
         1RCAOvVajgxIG/2XS29pE+3yJXv6F/YzYXYalXjPZWRzkrHKyfd3kDaaKxFZzX/stM0x
         UBGA==
X-Gm-Message-State: AJIora84ac/4x2euN5wsA91/LddqPqRQzlN980Wj5Mf5/qOUzOSMqh0g
        5sIK8oQS8ZtsS8vhZBrgSBSfunaYmMVpMvUYaSQ=
X-Google-Smtp-Source: AGRyM1uJk4/jKvboenu61bK22XlgMlaJz0THOLxslPfUwFNnE4t0l44/11LtiP6JadK+sxElCUXALnelrhc0K8+Ii7Y=
X-Received: by 2002:a81:cf02:0:b0:2d0:b68c:cf30 with SMTP id
 u2-20020a81cf02000000b002d0b68ccf30mr52305330ywi.510.1657204888328; Thu, 07
 Jul 2022 07:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a12-atmqjtjqi-RhFXH2Kwa-hxYcxy3Ftz2YjY5yyPHqg@mail.gmail.com>
 <mhng-f5938c9b-7fc1-4b0c-9449-7dd1431f5446@palmerdabbelt-glaptop>
 <CAKXUXMzpWsdKYbcu5MxvrAEMLHv4_2OGv2bRYEsQaze5trUSiQ@mail.gmail.com>
 <CAK8P3a32m42gT9qz+Ldvr8okYGOc=kKeoJTGNWyYT71N8tJfEA@mail.gmail.com>
 <4ff47e50-8702-1177-612b-73d9700e47c5@microchip.com> <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
In-Reply-To: <CAK8P3a01x_ETchX2Vwm9oNaFJDhVZEu+G-2vRwegqKkMe54m6g@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 7 Jul 2022 16:41:17 +0200
Message-ID: <CAKXUXMxOUs31SkGb0JD=nmHxgFy4tQ5vn6yD6ivgRpbSAxm7mA@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: correct reference to GENERIC_LIB_DEVMEM_IS_ALLOWED
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jul 7, 2022 at 3:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 7, 2022 at 2:20 PM <Conor.Dooley@microchip.com> wrote:
> > On 07/07/2022 13:13, Arnd Bergmann wrote:
> > > On Thu, Jul 7, 2022 at 1:40 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >>
> > >> On Wed, Oct 6, 2021 at 6:52 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> > >>>
> > >>> On Wed, 06 Oct 2021 08:17:38 PDT (-0700), Arnd Bergmann wrote:
> > >>>> On Wed, Oct 6, 2021 at 5:00 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >>>>>
> > >>>>> Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > >>>>> introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> > >>>>> falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> > >>>>> in the reference) in ./include/asm-generic/io.h.
> > >>>>>
> > >>>>> Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> > >>>>>
> > >>>>> GENERIC_DEVMEM_IS_ALLOWED
> > >>>>> Referencing files: include/asm-generic/io.h
> > >>>>>
> > >>>>> Correct the name of the config to the intended one.
> > >>>>>
> > >>>>> Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > >>>>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >>>>
> > >>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >>>
> > >>> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > >>> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > >>>
> > >>> Thanks.  I'm going to assume this is going in through some other tree,
> > >>> but IIUC I sent the buggy patch up so LMK if you're expecting it to go
> > >>> through mine.
> > >>
> > >> Palmer, Arnd,
> > >>
> > >> the patch in this mail thread got lost and was not picked up yet.
> > >>
> > >> MAINTAINERS suggests that Arnd takes patches to include/asm-generic/,
> > >> since commit 1527aab617af ("asm-generic: list Arnd as asm-generic
> > >> maintainer") in 2009, but maybe the responsibility for those files has
> > >> actually moved on to somebody (or nobody) else and we just did not
> > >> record that yet in MAINTAINERS.
> > >>
> > >> Arnd, will you pick this patch and provide it further to Linus Torvalds?
> > >>
> > >> Otherwise, Palmer already suggested picking it up himself.
> > >>
> > >
> > > I've applied it to the asm-generic tree and can send it as a bugfix
> > > pull request. I don't have any other fixer for that branch at the moment,
> > > so if Palmer has other fixes for the riscv tree already, it would
> > > save me making a pull request if he picks it up there.
>
> lkft just found a build failure:
>
> https://gitlab.com/Linaro/lkft/users/arnd.bergmann/asm-generic/-/jobs/2691154818
>
> I have not investigated what went wrong, but it does look like an actual
> regression, so I'll wait for Lukas to follow up with a new version of the patch.

Thanks for your testing. I will look into it. Probably it is due to
some more rigor during builds (-Werror and new warning types in the
default build) since I proposed the patch in October 2021. That should
be easy to fix, but let us see. I will send a PATCH v2 soon.

Lukas
