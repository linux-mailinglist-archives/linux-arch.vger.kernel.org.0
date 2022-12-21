Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8C65338F
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 16:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLUPj7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 10:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLUPj6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 10:39:58 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D57B9;
        Wed, 21 Dec 2022 07:39:57 -0800 (PST)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2BLFdavX012529;
        Thu, 22 Dec 2022 00:39:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2BLFdavX012529
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671637177;
        bh=e5zLKGROubDNVvYxZKupYtEZfQJgPSYQABMW+J+3mDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xNtSKmCWEoxmpMGBvN9ieu4widdAifgZmD1YWGYQ8KRJs/UXoP2AYWa+854iilMPn
         QYu/Px2/7KUS9YVG+3xRwH+D4vmYgnJjkj97LDPn2YF3K6OIMFjvPveM4SLnsnGayy
         R44AClZ653RPjMLj7tfa7zHNgM2vOcZyoiOq9+uIwo2/cpkNr+sK1YvzgoifdsUFVO
         vxG47DR6bDvj4ijZUuySzjmkash/lfjZc7US6fYP6tRakh3+IZ7uCk7ToIg+e7PEPZ
         IkEOo/slEWPDzUeDIHpufADvgnjOitJY4xwgU2fdVi36/alpA+kveK54t0AXWb7+NZ
         IHEij96gekoQA==
X-Nifty-SrcIP: [209.85.160.54]
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-144bd860fdbso19641297fac.0;
        Wed, 21 Dec 2022 07:39:37 -0800 (PST)
X-Gm-Message-State: AFqh2kpzyqoiEeemT07PFtTB6W0XhfFdq+HlUUtgTJSFH5MohRzcWn8r
        3V4THN6jqRUuXbXv/79kTI0NAo2gjotyRysY8Ho=
X-Google-Smtp-Source: AMrXdXu5wBUNkd6f+ZHBJHJAfJjzw4vVTST+099spBVLipN+anBHxC5siTmFSLQ2Jxj/8kubYP90fcs7i0BaTV1TKzk=
X-Received: by 2002:a05:6870:4c0e:b0:144:a2de:1075 with SMTP id
 pk14-20020a0568704c0e00b00144a2de1075mr113181oab.194.1671637176438; Wed, 21
 Dec 2022 07:39:36 -0800 (PST)
MIME-Version: 1.0
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info>
In-Reply-To: <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 22 Dec 2022 00:39:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
Message-ID: <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
Subject: Re: BUG: arm64: missing build-id from vmlinux
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> Hi, this is your Linux kernel regression tracker. CCing the regression
> mailing list, as it should be in the loop for all regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html
>
> On 18.12.22 21:51, Dennis Gilmore wrote:
> > The changes in https://lore.kernel.org/linux-arm-kernel/166783716442.32724.935158280857906499.b4-ty@kernel.org/T/
> > result in vmlinux no longer having a build-id.
>
> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for the link
> order of head.o") from Masahiro merged through Will this cycle.
>
> > At the least, this
> > causes rpm builds to fail. Reverting the patch does bring back a
> > build-id, but there may be a different way to fix the regression
>
> Makes me wonder if other distros or CIs relying on the build-id are
> broken, too.
>
> Anyway, the holiday season is upon us, hence I also wonder if it would
> be best to revert above change quickly and leave further debugging for 2023.
>
> Masahiro, Will, what's your option on this?


I do not understand why you rush into the revert so quickly.
We are before -rc1.
We have 7 weeks before the 6.2 release
(assuming we will have up to -rc7).

If we get -rc6 or -rc7 and we still do not
solve the issue, we should consider reverting it.



The problem is that the .notes section was
turned into PROGBITS.



$ aarch64-linux-gnu-readelf -S  vmlinux.good

   [ snip ]

  [ 7] .notes            NOTE             ffffffc0082c53a0  002d53a0
       0000000000000054  0000000000000000   A       0     0     4



$ aarch64-linux-gnu-readelf -S  vmlinux.bad

  [ snip ]

  [ 7] .notes            PROGBITS         ffffffc0082c5380  002d5380
       0000000000000054  0000000000000000   A       0     0     4




I just want to figure out why the linker transforms it this way.







>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>
> #regzbot ^introduced 994b7ac1697b
> #regzbot title arm64: missing build-id in vmlinux breaks at leas
> Fedora's kernel packaging
> #regzbot ignore-activity



-- 
Best Regards
Masahiro Yamada
