Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624DD760E91
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jul 2023 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGYJYr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjGYJYo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 05:24:44 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5E1B3;
        Tue, 25 Jul 2023 02:24:40 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 8E019520275;
        Tue, 25 Jul 2023 11:24:38 +0200 (CEST)
Received: from lxhi-064.domain (10.72.94.5) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Tue, 25 Jul
 2023 11:24:38 +0200
Date:   Tue, 25 Jul 2023 11:24:33 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Nicolas Schier <n.schier@avm.de>,
        SzuWei Lin <szuweilin@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <Matthias.Thomae@de.bosch.com>,
        <yyankovskyi@de.adit-jv.com>, <Dirk.Behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
Message-ID: <20230725092433.GA57787@lxhi-064.domain>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-3-masahiroy@kernel.org>
 <YdwZe9DHJZUaa6aO@buildd.core.avm.de>
 <20230623144544.GA24871@lxhi-065>
 <20230719190902.GA11207@lxhi-064.domain>
 <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
X-Originating-IP: [10.72.94.5]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Yamada-san,

Appreciate your willingness to support. Some findings below.

On Sun, Jul 23, 2023 at 01:08:46AM +0900, Masahiro Yamada wrote:
> On Thu, Jul 20, 2023 at 4:09 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > On Fri, Jun 23, 2023 at 04:45:44PM +0200, Eugeniu Rosca wrote:

[..]

> > > I will continue to increase my understanding behind what's happening.
> > > In case there are already any suggestions, would appreciate those.
> >
> > JFYI, we've got confirmation from Qualcomm Customer Support interface
> > that reverting [1] heals the issue on QC end as well. However, it looks
> > like none of us has clear understanding how to properly
> > troubleshoot/trace/compare the behavior before and after the commit.
> >
> > I would happily follow any suggestions.
> >
> > > [1] https://android.googlesource.com/kernel/common/+/bc6d3d83539512
> > >     ("UPSTREAM: kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}")
> > >
> > > [2] https://lore.kernel.org/linux-kbuild/20230616194505.GA27753@lxhi-065/

[..]

> Please backport 64d8aaa4ef388b22372de4dc9ce3b9b3e5f45b6c
> and see if the problem goes away.

Unfortunately, the problem remains after backporting the above commit.

After some more bisecting and some more trial-and-error, I finally came
up with a reproduction scenario against vanilla. It also shows that
after reverting 7ce7e984ab2b21 ("kbuild: rename
cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}"), the problem goes away.

It takes <30 seconds to reproduce the issue on my machine (on 2nd run).

In order to make the test self-sufficient, it also clones the Linux
sources (only during 1st run, with --depth 1, for minimal footprint),
hence ~1.8 GB free space is required in /tmp .

The repro.sh script:
 => https://gist.github.com/erosca/1372fdc24126dc98031444613450c494

Output against vanilla on 1st run (always OK, matches real-life case):
 => https://gist.github.com/erosca/0f5b8e0a00a256d80f0c8a6364d81568

Output against vanilla on 2nd/Nth run (NOK: Argument list too long):
 => https://gist.github.com/erosca/e5c2c6479cc32244cc38d308deea4cf5

Output against vanilla + revert_of_7ce7e984ab2b2 on Nth run (always OK):
 => https://gist.github.com/erosca/57e114f92ea20132e19fc7f5a46e7c65

Would it be possible to get your thoughts on the above?

-- 
Best regards,
Eugeniu Rosca
