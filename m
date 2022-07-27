Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A39D58296E
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jul 2022 17:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiG0PR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jul 2022 11:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiG0PR7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jul 2022 11:17:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A373C17F;
        Wed, 27 Jul 2022 08:17:57 -0700 (PDT)
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MdNse-1nhf5m33VA-00ZQsC; Wed, 27 Jul 2022 17:17:54 +0200
Received: by mail-wr1-f41.google.com with SMTP id u5so24849011wrm.4;
        Wed, 27 Jul 2022 08:17:54 -0700 (PDT)
X-Gm-Message-State: AJIora/uSXDHtBTQ2nPTxn/mhclHjQWuPikEvy8U7y/Vx9C0lTjbqkZ6
        0fXW+1ePkG6rNGNmMpzO9fHpFsBkgDad7ao883c=
X-Google-Smtp-Source: AGRyM1vwxJc9gqiCvqq3uZ9PoY1AG2s6ob4gu0k2PJcRXrxC/RKPlF2mjI4dn9XBym1ZTYN/0mzbu7IFwiwjbGrFF8A=
X-Received: by 2002:a7b:c8da:0:b0:3a2:ffd2:8059 with SMTP id
 f26-20020a7bc8da000000b003a2ffd28059mr3501141wml.169.1658935074324; Wed, 27
 Jul 2022 08:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220722110711.16569-1-lukas.bulwahn@gmail.com> <Ytq50u0nhkJ1UV0U@bombadil.infradead.org>
In-Reply-To: <Ytq50u0nhkJ1UV0U@bombadil.infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Jul 2022 17:17:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a33ZApraQ5X+iK4MXtDJADF3AReBUS+GKDfmDhvZc16-w@mail.gmail.com>
Message-ID: <CAK8P3a33ZApraQ5X+iK4MXtDJADF3AReBUS+GKDfmDhvZc16-w@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: remove a broken and needless ifdef conditional
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WnOuCcD5NhXL2YQJBk7JvXauH9tZqmVJBGIulmw1T4qoBt4ZMj5
 Ze9lIdQtXXW7i2cf9pRPY3vIxR/HeMRusU/3rljJn+ak5t1nMFbRmlLk4ll2NuCyd6VtJnG
 kaMnpBPhhptQh4zV0474OLR9PVPHqn0MGD1jmNjHEed2+aL81+lZwQzLa3UitbWDIKHBUTI
 9XbghmMJK3x3gPtVoV1Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ebv59fOqQbI=:3D8TokgQRNTAYyAn+6oJVv
 l2gf+ATB4psdk/Is7A0OA4AwwSNYz/UTPkqU5vQurqrD3kUAStk20ILOo+jVDcszVso/QxGbP
 fgGdYUdO+NOoJBI49TQEWCL6rCEOR0JAu11yGBKb+ejZz7APZ+FBBaws3v2nb+5lGF2hcOksO
 nCm/WM4CCu8FTC8ShW4cxfwYqdmhR3QnBVyx4ktgOF5Dvy3cwhXplRfgQ1g9v/FfJ7d/WZevC
 ctFT2BIgF04r6d3yOWFanrXJOLqiRfEoXgb9YDngkb36zBeesRMw272jnYxp1iZ74EgATjKYf
 m5Xu/5CCWvziUB1s6BfGngfY3CLacKdIcDj72vlpNpIIfF6WeEucIGu0/6UmRV6vJY1N2HSiZ
 yVV9k6uAm86yJnUIiV8jzNywvcGApDVDBm6PkB/HWBQRLMznzSkc+cQNJNyzs8nWv3euXdJup
 Qir7Bag5tHC38Gomly8b5hVt/lHqfcajOvjhxrWwyCTrq+CnwZ/ZAody34yoYKHW+sai/m/ZD
 N/2XvvnAiWC7lsF2FrppMrlnU87xhAQIoKqBC/LAHufyQhiazYrzwaF/SrT/YKd2gjPiXvCc+
 V8LaIi2QdvhBmZ4b/vawAl2vKlF1IR3AkGNhmkKmY2xfrgjTkLHRTB6WxJ9TiVw8L06lVIL5V
 QxJqcpuBvO+kXGslc03G6daGT0oXTc66EFLyKBU9k9psUaxlMeJvtadL++2vxFUC32pGx9a4T
 8bSYGMdaRVgrnCVzd0wMHH1t7DOgI4vWFfpYoA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 22, 2022 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 01:07:11PM +0200, Lukas Bulwahn wrote:
> > Commit 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > introduces the config symbol GENERIC_LIB_DEVMEM_IS_ALLOWED, but then
> > falsely refers to CONFIG_GENERIC_DEVMEM_IS_ALLOWED (note the missing LIB
> > in the reference) in ./include/asm-generic/io.h.
> >
> > Luckily, ./scripts/checkkconfigsymbols.py warns on non-existing configs:
> >
> > GENERIC_DEVMEM_IS_ALLOWED
> > Referencing files: include/asm-generic/io.h
> >
> > The actual fix, though, is simply to not to make this function declaration
> > dependent on any kernel config. For architectures that intend to use
> > the generic version, the arch's 'select GENERIC_LIB_DEVMEM_IS_ALLOWED' will
> > lead to picking the function definition, and for other architectures, this
> > function is simply defined elsewhere.
> >
> > The wrong '#ifndef' on a non-existing config symbol also always had the
> > same effect (although more by mistake than by intent). So, there is no
> > functional change.
> >
> > Remove this broken and needless ifdef conditional.
> >
> > Fixes: 527701eda5f1 ("lib: Add a generic version of devmem_is_allowed()")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
>
> There is only one architecture which defines this as a static inline.
> Should that architecture include asm-generic/io.h, or if it already
> does, it may end up with a compilation error.
>
> So if arch/s390/include/asm/page.h can end up including asm-generic/io.h
> or if any file including for s390 can include its arch page.h and
> asm-generic/io.h then we'll still need the guard.
>
> This may compile today for s390 because s390 may not use asm-generic/io.h.
>

It looks like we never concluded this thread. I double-checked this
on s390 and confirmed that it has both the inline definition and the
extern declaration visible and this does not cause problems on any of
the compilers I tried (gcc-5 and gcc-12).

Generally speaking there is not really a need to hide extern declarations
behind an ifdef.

> So why not just keep the guard and correct this as intended?

That was what the original patch from Lukas did, but it caused regressions
because configurations actually relied on the declaration even when the
Kconfig option is disabled.

The current version of the patch was in linux-next for a while now without
causing extra issues, so I'm sending it out in my final fixes pull request
for 5.19.

      Arnd
