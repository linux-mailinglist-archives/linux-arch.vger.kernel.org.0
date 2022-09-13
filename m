Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD665B6C39
	for <lists+linux-arch@lfdr.de>; Tue, 13 Sep 2022 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIMLIr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Sep 2022 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMLIq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2022 07:08:46 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C371F47B80;
        Tue, 13 Sep 2022 04:08:44 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 28DB8RL8024773;
        Tue, 13 Sep 2022 20:08:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 28DB8RL8024773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663067308;
        bh=NmF06TpRZRrjmPsgtVcO+PDy/ofiYx+D2Weu+18R44M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vIysF7spA2w5d8CBkgkV3M+9rFIqgELrpKXxKIzsnxD0clk+U8OBt8XedCepweOou
         VA2dXYB6jbxsPd4yDmLtXhqNKqQxhBySlPwe3m2FJPTSeaX6FDIAH40dvjLmXNlmBG
         WdVduEW7mx7hmO5i1BJeC45xm4Ud75G2CmLX5jrHn/zbPWZWYFSyWqZlSAb20plMxG
         g7vLJUvE+/rXLybN+G6327nXb++gw9YTrZyCBCwfkFbD73C+iNd6n9AdZAqwgzV5W1
         XlV1ipPLN+RkJsV6bN04xb/15I0C4xRh1a6jVjCjW7DyUtsruBcgsfe4pZV3yvL8lX
         G0TGgAFIxDYtA==
X-Nifty-SrcIP: [209.85.160.49]
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12803ac8113so31058835fac.8;
        Tue, 13 Sep 2022 04:08:28 -0700 (PDT)
X-Gm-Message-State: ACgBeo0pyW3hnwBqZaRQ2OC5lFi1q+lSL5s09OISfzo7cGrhOBFVErkt
        qrcRD0pOX96nKq6BbZl81XtuvVkqloP16mF7Fs8=
X-Google-Smtp-Source: AA6agR4XFy75QvPDy1vSFGNTT1bYZMrWS4b62kMrENsiFC9tg/9uWUG3BVaCF881O2G8P1LVewtodSODzJ9K6ojUHnE=
X-Received: by 2002:a05:6870:f626:b0:10d:a798:f3aa with SMTP id
 ek38-20020a056870f62600b0010da798f3aamr1450642oab.194.1663067307154; Tue, 13
 Sep 2022 04:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220828024003.28873-1-masahiroy@kernel.org> <20220828024003.28873-6-masahiroy@kernel.org>
 <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X>
In-Reply-To: <YyBAFL9CBsM9gl38@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Sep 2022 20:07:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQTVZ7DNJj4tBNAgjkWAkHQaom01iOZAx3_C8+VDPVy4A@mail.gmail.com>
Message-ID: <CAK7LNAQTVZ7DNJj4tBNAgjkWAkHQaom01iOZAx3_C8+VDPVy4A@mail.gmail.com>
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 13, 2022 at 5:32 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Masahiro,
>
> On Sun, Aug 28, 2022 at 11:39:53AM +0900, Masahiro Yamada wrote:
> > Kbuild builds init/built-in.a twice; first during the ordinary
> > directory descending, second from scripts/link-vmlinux.sh.
> >
> > We do this because UTS_VERSION contains the build version and the
> > timestamp. We cannot update it during the normal directory traversal
> > since we do not yet know if we need to update vmlinux. UTS_VERSION is
> > temporarily calculated, but omitted from the update check. Otherwise,
> > vmlinux would be rebuilt every time.
> >
> > When Kbuild results in running link-vmlinux.sh, it increments the
> > version number in the .version file and takes the timestamp at that
> > time to really fix UTS_VERSION.
> >
> > However, updating the same file twice is a footgun. To avoid nasty
> > timestamp issues, all build artifacts that depend on init/built-in.a
> > must be atomically generated in link-vmlinux.sh, where some of them
> > do not need rebuilding.
> >
> > To fix this issue, this commit changes as follows:
> >
> > [1] Split UTS_VERSION out to include/generated/utsversion.h from
> >     include/generated/compile.h
> >
> >     include/generated/utsversion.h is generated just before the
> >     vmlinux link. It is generated under include/generated/ because
> >     some decompressors (s390, x86) use UTS_VERSION.
> >
> > [2] Split init_uts_ns and linux_banner out to init/version-timestamp.c
> >     from init/version.c
> >
> >     init_uts_ns and linux_banner contain UTS_VERSION. During the ordinary
> >     directory descending, they are compiled with __weak and used to
> >     determine if vmlinux needs relinking. Just before the vmlinux link,
> >     they are compiled without __weak to embed the real version and
> >     timestamp.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> <snip>
>
> > diff --git a/init/build-version b/init/build-version
> > new file mode 100755
> > index 000000000000..39225104f14d
> > --- /dev/null
> > +++ b/init/build-version
> > @@ -0,0 +1,10 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +VERSION=$(cat .version) 2>/dev/null &&
> > +VERSION=$(expr $VERSION + 1) 2>/dev/null ||
> > +VERSION=1
> > +
> > +echo ${VERSION} > .version
> > +
> > +echo ${VERSION}
>
> I am seeing
>
>   cat: .version: No such file or directory


Thanks, Nathan.



I did not notice it because /bin/sh is a symlink to dash
on my machine.
I see the warning by running it with bash.



$ rm -f .version ; dash init/build-version
1
$ rm -f .version ; bash init/build-version
cat: .version: No such file or directory
1




>
> at some point in nearly all of my builds in -next. Does the 2>/dev/null
> want to be moved into the subshell?


Agree.
I will fix it up locally.


Thanks.

>
> Cheers,
> Nathan



-- 
Best Regards
Masahiro Yamada
