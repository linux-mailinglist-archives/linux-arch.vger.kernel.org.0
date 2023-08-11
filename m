Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7222A778D99
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjHKLZk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjHKLZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 07:25:39 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DB3C3;
        Fri, 11 Aug 2023 04:25:37 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id C9870520442;
        Fri, 11 Aug 2023 13:25:35 +0200 (CEST)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Fri, 11 Aug
 2023 13:25:35 +0200
Date:   Fri, 11 Aug 2023 13:25:30 +0200
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
Message-ID: <20230811112530.GA453409@lxhi-087>
References: <20220109181529.351420-1-masahiroy@kernel.org>
 <20220109181529.351420-3-masahiroy@kernel.org>
 <YdwZe9DHJZUaa6aO@buildd.core.avm.de>
 <20230623144544.GA24871@lxhi-065>
 <20230719190902.GA11207@lxhi-064.domain>
 <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
 <20230725092433.GA57787@lxhi-064.domain>
 <CAK7LNAR4rJwrT2KLjLw-AbBvhO38xCZigC9C+DUVkn_5JM-KyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK7LNAR4rJwrT2KLjLw-AbBvhO38xCZigC9C+DUVkn_5JM-KyQ@mail.gmail.com>
X-Originating-IP: [10.72.93.211]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Yamada-san,

Appreciate your generous support, which allowed finding the root-cause.

On Wed, Aug 02, 2023 at 06:21:14PM +0900, Masahiro Yamada wrote:

[..]

> Indeed, reverting 7ce7e984ab2b218d6e92d5165629022fe2daf9ee
> makes qcom's external module build successfully
> (but rebuilding is super slow).

Same observation.

> 
> Interestingly, revert 7ce7e984ab2b218d6e92d5165629022fe2daf9ee
> then apply the attached patch, then
> 'Argument list too long' will come back.
> 
> So, this is unrelated to the actual build commands.
> 
> I suspect bare 'export', which expands all variables
> while apparently most of them are not meant exported.

Indeed, that seems to be the case and more evidence supports this:

 * Several pre-existing commits point out to the same root-cause:

    https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/audio-kernel-ar/-/commit/4025a25a2479fc34
    ("makefile: kona: remove make export <all variables> instances")

    https://github.com/sonyxperiadev/kernel-techpack-audio/commit/02f00754120df2
    ("audio-kernel: Fix build time issue")

 * The more recent GNU Make 4.4.1 (called with -ddd) reveals more
    details just before hitting 'Argument list too long':

    scripts/Makefile.lib:431: not recursively expanding size_append to export to shell function
    scripts/Makefile.lib:447: not recursively expanding cmd_file_size to export to shell function
    scripts/Makefile.lib:453: not recursively expanding cmd_bzip2_with_size to export to shell function
    scripts/Makefile.lib:462: not recursively expanding cmd_lzma_with_size to export to shell function
    scripts/Makefile.lib:468: not recursively expanding cmd_lzo_with_size to export to shell function
    scripts/Makefile.lib:474: not recursively expanding cmd_lz4_with_size to export to shell function
    scripts/Makefile.lib:520: not recursively expanding cmd_xzkern_with_size to export to shell function
    scripts/Makefile.lib:549: not recursively expanding cmd_zstd22_with_size to export to shell function

    The "not recursively expanding" messages above come from GNU
    make commit https://gnu.googlesource.com/make/+/7d484017077089a
    ("[SV 63016] Don't fail exporting to $(shell ...)"), which appears
    to be saying that our issue is caused by exporting a makefile
    variable which contains the 'shell' directive in its definition.

    I think it would be too much of a burden for Kbuild not to make use
    of any variables using the 'shell' keyword, so I tend to agree that
    defending against bare 'export' statements in Kbuild is rather not
    feasible and it should be fixed in the makefiles of out-of-tree *ko.

> Insert the following in your reproducer, then it will work.

Thanks for the demo code snippet.

-- 
Best regards,
Eugeniu Rosca
