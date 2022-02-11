Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A884B2B24
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbiBKRAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 12:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbiBKRAG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 12:00:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE521A1;
        Fri, 11 Feb 2022 09:00:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FDE4B82AF0;
        Fri, 11 Feb 2022 17:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6E1C340ED;
        Fri, 11 Feb 2022 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598802;
        bh=PH5ZGu/nOfR4rtVzTmQgDEFh7VhP/oNa2KDW9GMa1ZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fDR5hskTdsFn2goxIW3SnqXMDJUTstEauOnVedYwYL+XdFOFSHGfIgJrnY1Do2R8N
         37IypVbzdLQMo9gTNGJOZxd9CN61Nxd8CbmllN1KZ2+yWhNA0qbQRk2cfYbsnzqsbx
         G2O7cX+ZN3yTppVLTwlKrzGktrikR/FfaZdyOd9gqtPYf89BEnwTzLiO5F8xDCKZDX
         3tHPe4bsLRdLrAjIJjIIi5/zPlM2J+Gclzfv2o9QyUjzbySF8KgdRfRb50meHSM2AJ
         Xb8Ypw7UJFC3NgUqNbUYPk6sUwhx8o2EOpslc9lrxce98b9lZPGGrOY7HmS+DzTd27
         fOg09vYrZy+QA==
Received: by mail-wr1-f41.google.com with SMTP id j26so5445113wrb.7;
        Fri, 11 Feb 2022 09:00:01 -0800 (PST)
X-Gm-Message-State: AOAM532WJU/DdZn6n2Q/kz0fbhCGYhb7aF9KsyrvlZ8/EvSoA4iIznj0
        XJzVPHXG5DOI/33/KisCfIAc/rJROlJnAjV1wnQ=
X-Google-Smtp-Source: ABdhPJyZrCmZYigf4Rh9e1qgq8RLZArNfwWs0Rpzq/GiZC1ZS9VB/SuZTQjReWPc6n7DjyvtWR37FmtoLLDdUKHxd/U=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr2018413wrn.317.1644598800242;
 Fri, 11 Feb 2022 09:00:00 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org> <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com> <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec> <YgWrFnoOOn/B3X4k@antec>
In-Reply-To: <YgWrFnoOOn/B3X4k@antec>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 11 Feb 2022 17:59:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
Message-ID: <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Stafford Horne <shorne@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 On Fri, Feb 11, 2022 at 1:17 AM Stafford Horne <shorne@gmail.com> wrote:
> On Thu, Feb 10, 2022 at 08:31:05AM +0900, Stafford Horne wrote:

> > > Looking at it again, I wonder if it would help to use the __get_kernel_nofault()
> > > and __get_kernel_nofault() helpers as the default in
> > > include/asm-generic/uaccess.h.
> >
> > That would make sense.  Perhaps also the __range_ok() function from OpenRISC
> > could move there as I think other architectures would also want to use that.

I have now uploaded a cleanup series to
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs

This uses the same access_ok() function across almost all
architectures, with the
exception of those that need something else, and I then I went further
and killed
off set_fs for everything other than ia64.

> > > I see it's identical to the openrisc version and would probably be the same
> > > for some of the other architectures that have no other use for
> > > set_fs(). That may
> > > help to do a bulk remove of set_fs for alpha, arc, csky, h8300, hexagon, nds32,
> > > nios2, um and extensa, leaving only ia64, sparc and sh.
> >
> > If you could add it into include/asm-generic/uaccess.h I can test changing my
> > patch to use it.
>
> Note, I would be happy to do the work to move these into include/asm-generic/uaccess.h.
> But as I see it the existing include/asm-generic/uaccess.h is for NOMMU.  How
> should we go about having an MMU and NOMMU version?  Should we move uaccess.h to
> uaccess-nommu.h?  Or add more ifdefs to uaccess.h?

There are two parts of asm-generic/uaccess.h:

- the CONFIG_UACCESS_MEMCPYsection is fundamentally limited to nommu
  targets and cannot be shared. Similarly, targets with an MMU must use a custom
  implementation to get the correct fixups.

- the put_user/get_user implementation is fairly dumb, you can use these to
  avoid having your own ones, but you still need copy_{to,from}_user, and
  a custom implementation tends to produce better code.

So chances are that you won't want to use either one. In my new branch,
I added the common helpers to linux/uaccess.h and asm-generic/access-ok.h,
respectively, both of which are used everywhere now.

        Arnd
