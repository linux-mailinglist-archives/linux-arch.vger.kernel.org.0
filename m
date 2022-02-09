Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C934AF442
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 15:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiBIOkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 09:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiBIOku (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 09:40:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA0C06157B;
        Wed,  9 Feb 2022 06:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C1C0B821EA;
        Wed,  9 Feb 2022 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EEFC340E7;
        Wed,  9 Feb 2022 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644417650;
        bh=EKM+E1m9ba2sJX02hB2POGkw8eHy06YZEclCbdBgMzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gd4eBN2kJN6Cej7pTFXXBVlm2f29VYufJ5BWji3yIEJbwSkZPY/2a6eHURR3B7MlR
         2ku0uAblBicVjlEVqoThuWXqsMlMgp/evMhAsowoO4YvoYm3BeMC4Lfb+IrsAgv8Wc
         07agruI8F+H45+mNuvfqK8dsbcmaRE2UmlrZaUCs1dSGQZIpnNaixVWpT0vaklpE3y
         bR2B8P7SQsB/feEhKcN2RhJxXkeA1DXk84N5BEg0sWK+EwapF9Go6iv0c0yai0aEGk
         uRN5gNFvLQAGyR/gPY8DN+iRi5bBt02shiA/KFhiFbH/nzqCmOMFyGWS7adpnNmye3
         cSqOSKOtZ79dg==
Received: by mail-wr1-f43.google.com with SMTP id i14so4390024wrc.10;
        Wed, 09 Feb 2022 06:40:49 -0800 (PST)
X-Gm-Message-State: AOAM532Rn8KLCWXrJlgU7I9T4yH9ClkHWlbnQic7FLd20JQEaf24ww7d
        JRyMr7oaRghF1Yla+0Iv5GRzV95nTmTXY4g7Y2U=
X-Google-Smtp-Source: ABdhPJwU5/brQVWCcjSn+cr+1zP4jzaM99RD1wh7T2UGLi8lltk3Oe1QBv6DoDXF8nW5icqRGfyX9dTStexpEUxWut8=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr2350249wrt.219.1644417648257;
 Wed, 09 Feb 2022 06:40:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org> <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
In-Reply-To: <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 9 Feb 2022 15:40:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
Message-ID: <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Michal Simek <monstr@monstr.eu>
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

On Wed, Feb 9, 2022 at 2:50 PM Michal Simek <monstr@monstr.eu> wrote:
>
> Hi Arnd,
>
> po 17. 1. 2022 v 14:28 odes=C3=ADlatel Arnd Bergmann <arnd@kernel.org> na=
psal:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I picked microblaze as one of the architectures that still
> > use set_fs() and converted it not to.
>
> Can you please update the commit message because what is above is not
> the right one?

Ah, sorry about that. I think you can copy from the openrisc patch,
see https://lore.kernel.org/lkml/20220208064905.199632-1-shorne@gmail.com/

         Arnd
