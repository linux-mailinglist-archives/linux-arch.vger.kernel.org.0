Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0262D93F
	for <lists+linux-arch@lfdr.de>; Thu, 17 Nov 2022 12:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbiKQLRw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Nov 2022 06:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbiKQLRw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Nov 2022 06:17:52 -0500
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 03:17:50 PST
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C858CF78;
        Thu, 17 Nov 2022 03:17:50 -0800 (PST)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-05.nifty.com with ESMTP id 2AHB9cFS027160;
        Thu, 17 Nov 2022 20:09:38 +0900
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2AHB9ICE016704;
        Thu, 17 Nov 2022 20:09:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2AHB9ICE016704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668683359;
        bh=nRWOhJaZ5KAIeF0ENljN/lYw/5/QcrKlraNrZbKSTAM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XC2ya10TgEd1/8TzhF2Gr0PhHcLAntAWAqf3VAo1zqogYwrVf1xAC3tvJnrHRXzFh
         sHjUgIADN21SHjC3AlekRf+Ox8MnfToRWl/lqFA1ACbVLm7ZJpIi6OnfrCK3pE8oU8
         5l4cqD0kU2a7/vQR/icZ605LP0KceNLoT5PP9JI4Wohs1ENeYjSE0Ujm59k966Pbrt
         ErwMQXOfdT3YtvF91V72VtQ7D/+jXPr2lO1GNZHej2Vn+9R2Y2RqDuTzOaz69kiYFl
         fnx2jMDesvKTAolXZ3+In6CEeuDnwQASAamQRtGVvps4L0W/7BOeNjfP4VB2CUIPfy
         5LMj2rvBqAqgw==
X-Nifty-SrcIP: [209.85.210.45]
Received: by mail-ot1-f45.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so812322ots.8;
        Thu, 17 Nov 2022 03:09:18 -0800 (PST)
X-Gm-Message-State: ANoB5plBe1FLaMkMcXlr2fMExyNIDzIEM56lNWUhWGi++CQp4q3l0ENz
        TZwCUrSOfNU0Z6c/IQ19FoRNZ9BWlBG1FGgAPjk=
X-Google-Smtp-Source: AA0mqf4CK4Q0N+foqWUEAX6p0/4zkzL1fEXSzY2ahsU2bwYk+QeoxrbOBFQOkegMzcI0htIHDXXHFjOXSHp5l74k9/Y=
X-Received: by 2002:a9d:282:0:b0:66c:794e:f8c6 with SMTP id
 2-20020a9d0282000000b0066c794ef8c6mr1077050otl.343.1668683357460; Thu, 17 Nov
 2022 03:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20220828024003.28873-1-masahiroy@kernel.org> <20220828024003.28873-6-masahiroy@kernel.org>
 <e98d2048-57ef-4515-8290-ddf6596856f7@nvidia.com>
In-Reply-To: <e98d2048-57ef-4515-8290-ddf6596856f7@nvidia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Nov 2022 20:08:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBBiBQw5Cx=NHy7Fs_to6JcAaRrHdbj+prYddxDgb3Kg@mail.gmail.com>
Message-ID: <CAK7LNASBBiBQw5Cx=NHy7Fs_to6JcAaRrHdbj+prYddxDgb3Kg@mail.gmail.com>
Subject: Re: [PATCH 05/15] kbuild: build init/built-in.a just once
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 17, 2022 at 7:00 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Hi Masahiro
>
> On 28/08/2022 03:39, Masahiro Yamada wrote:
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
> >      include/generated/compile.h
> >
> >      include/generated/utsversion.h is generated just before the
> >      vmlinux link. It is generated under include/generated/ because
> >      some decompressors (s390, x86) use UTS_VERSION.
> >
> > [2] Split init_uts_ns and linux_banner out to init/version-timestamp.c
> >      from init/version.c
> >
> >      init_uts_ns and linux_banner contain UTS_VERSION. During the ordinary
> >      directory descending, they are compiled with __weak and used to
> >      determine if vmlinux needs relinking. Just before the vmlinux link,
> >      they are compiled without __weak to embed the real version and
> >      timestamp.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
> Since this change I have noticed that the kernel image (at least on ARM64) now contains two version strings ...
>
> $ strings arch/arm64/boot/Image | grep "Linux version"
> Linux version 6.0.0-rc7-00011-g2df8220cc511 (jonathanh@moonraker) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) # SMP PREEMPT
> Linux version 6.0.0-rc7-00011-g2df8220cc511 (jonathanh@moonraker) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) #20 SMP PREEMPT Thu Nov 17 09:49:18 GMT 2022
>
> Is this expected?


Yes.

The first line is a weak (i.e. unused) symbol.
The second one is a real one.


2df8220cc511326508ec4da2f43ef69311bdd7b9 fixed up
arch/powerpc/boot/wrapper because it grep's vmlinux.


The weak symbols slightly increase the image size, but
I do not know how to do this better.






> Thanks!
> Jon
>
> --
> nvpublic



-- 
Best Regards
Masahiro Yamada
