Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043C14B2EFE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353712AbiBKU6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 15:58:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353913AbiBKU6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 15:58:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97DD86;
        Fri, 11 Feb 2022 12:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F9D7CE2C05;
        Fri, 11 Feb 2022 20:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FB0C340F7;
        Fri, 11 Feb 2022 20:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644613081;
        bh=DhXPhCALScf4UQ/shTnyxSV9qJWuG4YeZkIXRRWBEVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ajgwkdmnZO9Y7MRwNsIt1ZG9/Z6LGtc+CmxUJxPxIyF8iWukb3cmoHlHk9+e7iZcY
         Gj8X8uV0uW2d4zO2mlY2nGDYRqsch9PLEDry8XYx33hz9eJ59u1V4dn9CpRYlNY24H
         YpvYHDCgR2Vb9B9VYi0pQ0HBPtioYjV/TLpoz/88Cn/XfsPeOCmkLja9io9/XV9xC/
         dGxOCeUo6tD0vH3ywGGbpEUXFYdCj8feF4MhVPoshpMFhs09YeOKHwWW2TZcitERvP
         sW/xOJ+URxZvb0WcWzPLsfzQ5CPk41AQfSZBtVmTQSbULE0s1HuIzKk0iI6wHmKHWp
         +iLESXEOHYYTw==
Received: by mail-wm1-f46.google.com with SMTP id i19so4763054wmq.5;
        Fri, 11 Feb 2022 12:58:01 -0800 (PST)
X-Gm-Message-State: AOAM531z6xupWMzYO7pLqDe9aQo5Y9Y973smxWUGlGI683SJH4SAnOCz
        f4g5Auo2qoFIRaPGlXZPpotvCGCEQNFBgrIr09k=
X-Google-Smtp-Source: ABdhPJy8dwHEN6dzGsXIEK8NoROkcl3T9UWJmDsZybG8UOP6f/JMYU9iGRPTSF1X7kLYqinjFf3/ZAsoTd9ApDP8Ffw=
X-Received: by 2002:a05:600c:1f06:: with SMTP id bd6mr1769956wmb.98.1644613079976;
 Fri, 11 Feb 2022 12:57:59 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
 <20220117132757.1881981-1-arnd@kernel.org> <CAHTX3dKyAha8_nu=7e413pKr+SAaPBLp9=FTdQ=GZNdjQHW+zA@mail.gmail.com>
 <CAK8P3a2Om2SYchx8q=ddkNeJ4o=1MVXD2MFSV2SGJ_vuTUcp0Q@mail.gmail.com>
 <126ae5ee-342c-334c-9c07-c00213dd7b7e@xilinx.com> <CAK8P3a2zZfFa55nNeMicWHhia7fkT0cJBzYvUi0O+v0B13BOMA@mail.gmail.com>
 <YgROuYDWfWYlTUKD@antec> <YgWrFnoOOn/B3X4k@antec> <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
 <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj7kOxDg+2Ym1EQsTZaZqU-p7aFHiNVOmtEhNS8jjapLQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 11 Feb 2022 21:57:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a22q+vTb3cEurhA0zXzw8-9+jKJRotC0oWMncS3sb-7zA@mail.gmail.com>
Message-ID: <CAK8P3a22q+vTb3cEurhA0zXzw8-9+jKJRotC0oWMncS3sb-7zA@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Feb 11, 2022 at 6:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Feb 11, 2022 at 9:00 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > I have now uploaded a cleanup series to
> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=set_fs
> >
> > This uses the same access_ok() function across almost all
> > architectures, with the exception of those that need something else,
> > and I then I went further and killed off set_fs for everything other
> > than ia64.
>
> Thanks, looks good to me.
>
> Can you say why you didn't convert ia64? I don't see any set_fs() use
> there, except for the unaligned handler, which looks trivial to
> remove. It looks like the only reason for it is kernel-mode unaligned
> exceptions, which we should just turn fatal, I suspect (they already
> get logged).
>
> And ia64 people could make the unaligned handling do the kernel mode
> case in emulate_load/store_int() - it doesn't look *that* painful.
>
> But maybe you noticed something else?
>
> It would be really good to just be able to say that set_fs() no longer
> exists at all.

I had previously gotten stuck at ia64, but gave it another go now
and uploaded an updated branch with ia64 taken care of and another
patch to clean up bits afterwards.

I only gave it light testing so far, mainly building the defconfig for every
architecture. I'll post the series once the build bots are happy with the
branch overall.

         Arnd
