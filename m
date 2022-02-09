Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097404AF481
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 15:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiBIOzM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 09:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBIOzM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 09:55:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB46C061355;
        Wed,  9 Feb 2022 06:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1797B821FA;
        Wed,  9 Feb 2022 14:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EC4C340E7;
        Wed,  9 Feb 2022 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644418512;
        bh=ULKfYtK5+8ILP+G8NhZQoQ7aqzNgMQ+Hnh15IDDeAqM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q8o00BHmJKljdOO7la/ECM/4SoJtkoFxu91EerYHgxRRfOZXVvWb8mARn1o4UJ5Y4
         uzB6EmW5eog7zQh1EAd6gOuTHOOUsbgMm/TLN7Npz/WH7YOc4lQhrtQ0BQTUi7gTGv
         JKUp9g6DgkF4InoI84IMEeNdY/d0lCiUkgJdMp8qIOVquOfLAdaouvutUzjWGyWLhS
         3WE/FalbPx1glK5Bli1KwQhcJH+ApuihVAgmroSyYT7jSCBWNFZG3Q2Q/OXyTeexeK
         0hrWuQ2/Ygjk1YvscXjt+vSldB6alo4+9/56qEUbhvIoScxa0qCBM0Z2fx1XnRQR5C
         F90i3eSN4udfw==
Received: by mail-wr1-f45.google.com with SMTP id e3so4612925wra.0;
        Wed, 09 Feb 2022 06:55:12 -0800 (PST)
X-Gm-Message-State: AOAM533HiPUI63kgO0HTj6l+W2UvdqGLn9sJLZJrJ+ugLrqPYS23IbYw
        WrQCK4YTjt+fh+CRu8TQIibZBOSXVdsABPPg6qs=
X-Google-Smtp-Source: ABdhPJwc+zhs0FbKKcw5e7bDZTPTPrG08eT2BuaJ/va4xLPEftXqghgspw3sTvIDovunNZz6u/mp3Rt9gCWp3N6Kb/4=
X-Received: by 2002:a05:6000:178d:: with SMTP id e13mr2343920wrg.317.1644418510880;
 Wed, 09 Feb 2022 06:55:10 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org> <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com> <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
In-Reply-To: <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Feb 2022 15:54:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
Message-ID: <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
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

On Wed, Feb 9, 2022 at 3:44 PM Michal Simek <michal.simek@xilinx.com> wrote=
:
> On 2/9/22 15:40, Arnd Bergmann wrote:
> > On Wed, Feb 9, 2022 at 2:50 PM Michal Simek <monstr@monstr.eu> wrote:
> >>
> >> Hi Arnd,
> >>
> >> po 17. 1. 2022 v 14:28 odes=C3=ADlatel Arnd Bergmann <arnd@kernel.org>=
 napsal:
> >>>
> >>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> I picked microblaze as one of the architectures that still
> >>> use set_fs() and converted it not to.
> >>
> >> Can you please update the commit message because what is above is not
> >> the right one?
> >
> > Ah, sorry about that. I think you can copy from the openrisc patch,
> > see https://lore.kernel.org/lkml/20220208064905.199632-1-shorne@gmail.c=
om/
>
> Please do it. You are the author of this patch and we should follow the p=
rocess.

Done.

Looking at it again, I wonder if it would help to use the __get_kernel_nofa=
ult()
and __get_kernel_nofault() helpers as the default in
include/asm-generic/uaccess.h.

I see it's identical to the openrisc version and would probably be the same
for some of the other architectures that have no other use for
set_fs(). That may
help to do a bulk remove of set_fs for alpha, arc, csky, h8300, hexagon, nd=
s32,
nios2, um and extensa, leaving only ia64, sparc and sh.

        Arnd
