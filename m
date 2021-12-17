Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD3A478DD7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhLQOdU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 09:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLQOdU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 09:33:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AF2C061574;
        Fri, 17 Dec 2021 06:33:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0F82B82893;
        Fri, 17 Dec 2021 14:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECFC36AE7;
        Fri, 17 Dec 2021 14:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639751597;
        bh=bnAhBVD0SeMRbYtZrAjVEVEtg4NHq1FwGil2ThDv/l0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2rbAZnjNtdWvXxo81ZuosYLz5Wm5EJXjwMiqO+AU9UeuNcO26zHzd0ogaLq0HZWR
         I4q0TLTXfMQLwmOjLcodnDXPfy1DqbCgWNY8a8HJtpXd6mYIiMN2u0VlIG+CbUDK9/
         ITuQ+vFBtVlpcqAS6JmLK1mwOsMFx3TRZf/zvAQk2t5QWCAx4XxvtrPTgVNUysKK1f
         aL/0cR8eCtN7OUTRERm2SaQDQY7f73i3XlzZbbeSv/vbPkaDp/QLBH7z3To8IGH0bh
         D/jFkKtQd08mT8gVRa6pxkV06jYXLLAuvofKhABlwaPR2KgwQM0BwvPaF8zfG35NG9
         iKI/sOGGf44FQ==
Received: by mail-wm1-f45.google.com with SMTP id b73so1770202wmd.0;
        Fri, 17 Dec 2021 06:33:17 -0800 (PST)
X-Gm-Message-State: AOAM5301q2nE9xf4CiCCtkQF2Nq7M0x/jfF0MWYnG17doMjkJTCqDi6m
        eW86e3pbcbbyZ4meCMpA0pyt1EIUmh8xggFxTLc=
X-Google-Smtp-Source: ABdhPJx53DkYg3g0Yv27ba6xATpcP3yBj2mTzfkeh0ojRN8SusGdabP6+EfLvIO/BieFICuhr/+AxJLjLvmWEuRB1LM=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr2992275wmn.98.1639751596012;
 Fri, 17 Dec 2021 06:33:16 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com> <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com> <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
 <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com> <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
In-Reply-To: <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 17 Dec 2021 15:32:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
Message-ID: <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     John Garry <john.garry@huawei.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 3:27 PM John Garry <john.garry@huawei.com> wrote:
> On 17/12/2021 13:52, Niklas Schnelle wrote:
> >>> I have tested this on s390 with HAS_IOPORT=3Dn and allyesconfig as we=
ll
> >>> as running it with defconfig. I've also been using it on my Ryzen 399=
0X
> >>> workstation with LEGACY_PCI=3Dn for a few days. I do get about 60 MiB
> >>> fewer modules compared with a similar config of v5.15.8. Hard to say
> >>> which other systems might miss things of course.
> >>>
> >>> I have not yet worked on the discussed IOPORT_NATIVE flag. Mostly I'm
> >>> wondering two things. For one it feels like that could be a separate
> >>> change on top since HAS_IOPORT + LEGACY_PCI is already quite big.
> >>> Secondly I'm wondering about good ways of identifying such drivers an=
d
> >>> how much this overlaps with the ISA config flag.
>
> I was interesting in the IOPORT_NATIVE flag (or whatever we call it) as
> it solves the problem of drivers which "unconditionally do inb()/outb()
> without checking the validity of the address using firmware or other
> methods first" being built for (and loaded on and crashing) unsuitable
> systems. Such a problem is in [0]
>
> So if we want to support that later, then it seems that someone would
> need to go back and re-edit many same driver Kconfigs =E2=80=93 like hwon=
, for
> example. I think it's better to avoid that and do it now.
>
> Arnd, any opinion on that?
>
> I'm happy to help with that effort.

I looked at the options the other day and couldn't really find any that
fell into this category, so I suggested that Niklas would skip that for the
moment. If you have a better way of finding the affected drivers,
that would be great.

       Arnd
