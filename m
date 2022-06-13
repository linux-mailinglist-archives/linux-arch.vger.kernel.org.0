Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1D547D3C
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 03:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiFMBQF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jun 2022 21:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiFMBQD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jun 2022 21:16:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED783252A4;
        Sun, 12 Jun 2022 18:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE9F4B80CFB;
        Mon, 13 Jun 2022 01:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A678C341C4;
        Mon, 13 Jun 2022 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655082960;
        bh=T/oPYXJvfTUUTAn3CsqoozPh9/pXSGnZmlhYNE8gbWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PxWK/9l6TdsQa77yV2AJPnGPvbYWhjRLP+wFfrNAXLjgtstoiHZXCMoo8B2IqcL7y
         rJYzFIT+mHg3ZKrHvaheUxROxBUNvqFs2qlykv4MpcQSZOCcE5InVYzVY9gAedqrzl
         FnuwwSzIfvkZHuyrFJ7SxGf5qezL+KsNEXhVx5VKfPjeumd7apyl49oYKlxtRU1zpg
         GDBh5Hgh8YUFAxR7RJZPuea54fZ5P93OWebgMT4J8xA0g1zF/FoCx8KzlVZ5id19aY
         dSaS71/WhW/0o+WHBrRP1zFeukLpZRbthXoRShYwKaOPOzZU843Ve5m0UWJoV8qtRs
         VsQDIkfPoli1Q==
Received: by mail-ua1-f48.google.com with SMTP id 63so1644079uaw.10;
        Sun, 12 Jun 2022 18:16:00 -0700 (PDT)
X-Gm-Message-State: AOAM532X/HcAEa2YaFJjCvzIZNL9PJ69x/UlVxmrZ9PxP1xJd59Lnaez
        pTd191Ygtk+bldpMc6ZaUQWfW507LiPajqQWev8=
X-Google-Smtp-Source: ABdhPJy022BVkvpX4bwvrgAxTSG7Jz6gfQIdan6W4shKCc4lN35Y4ktHFEjUhhT0WI19MsTm4e13W+ximSNeINXMAlQ=
X-Received: by 2002:ab0:3459:0:b0:378:ec81:4a8b with SMTP id
 a25-20020ab03459000000b00378ec814a8bmr14374212uaq.83.1655082959409; Sun, 12
 Jun 2022 18:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220405071314.3225832-1-guoren@kernel.org> <20220405071314.3225832-3-guoren@kernel.org>
 <20220608094108.GA18122@asgard.redhat.com>
In-Reply-To: <20220608094108.GA18122@asgard.redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 13 Jun 2022 09:15:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQhFbN3mK0jco=NAKZr4qCgvX4zkw3h6jdffr66Rz7REQ@mail.gmail.com>
Message-ID: <CAJF2gTQhFbN3mK0jco=NAKZr4qCgvX4zkw3h6jdffr66Rz7REQ@mail.gmail.com>
Subject: Re: [PATCH V12 02/20] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64
 in fcntl.h
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, ldv@strace.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 8, 2022 at 5:41 PM Eugene Syromiatnikov <esyr@redhat.com> wrote=
:
>
> On Tue, Apr 05, 2022 at 03:12:56PM +0800, guoren@kernel.org wrote:
> > From: Christoph Hellwig <hch@lst.de>
> >
> > Note that before this change they were never visible to userspace due
> > to the fact that CONFIG_64BIT is only set for kernel builds.
>
> > -#ifndef CONFIG_64BIT
> > +#if __BITS_PER_LONG =3D=3D 32 || defined(__KERNEL__)
>
> Actually, it's quite the opposite: "ifndef" usage made it vailable at all=
 times
> to the userspace, and this change has actually broken building strace
> with the latest kernel headers[1][2].  There could be some debate
> whether having these F_*64 definitions exposed to the user space 64-bit
> applications, but it seems that were no harm (as they were exposed alread=
y
> for quite some time), and they are useful at least for strace for compat
> application tracing purposes.
>
> [1] https://github.com/strace/strace/runs/6779763146?check_suite_focus=3D=
true#step:4:3222
> [2] https://pipelines.actions.githubusercontent.com/serviceHosts/e5309ebd=
-8a2f-43f4-a212-b52080275b5d/_apis/pipelines/1/runs/1473/signedlogcontent/1=
2?urlExpires=3D2022-06-08T09%3A37%3A13.9248496Z&urlSigningMethod=3DHMACV1&u=
rlSignature=3DfIT7vd0O4NNRwzwKWLXY4UVZBIIF3XiVI9skAsGvV0I%3D
>
Yes, there is no CONFIG_64BIT in userspace, we shouldn't limit it with
(__BITS_PER_LONG =3D=3D 32 || defined(__KERNEL__)) to break the
compatibility. Just export F_*64 definitions permanently.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
