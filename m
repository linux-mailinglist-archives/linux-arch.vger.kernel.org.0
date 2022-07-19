Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CC57A8CB
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGSVQB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 17:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGSVQB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 17:16:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3D101E8;
        Tue, 19 Jul 2022 14:15:59 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MlwJv-1nmrE61ajr-00j5gi; Tue, 19 Jul 2022 23:15:57 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e623a4ff4so22032987b3.4;
        Tue, 19 Jul 2022 14:15:56 -0700 (PDT)
X-Gm-Message-State: AJIora+T4xG4QDLOVkgBIYkCf3+PRmhpzQhW7lJWHafMDPRnzNv4RnvO
        2rHl7gwbzFXU0Dg6z0n26s0/4e/781WjWExAUtU=
X-Google-Smtp-Source: AGRyM1vouONdtWRC6uSgwsM19DKN9yNnXedmOnx5mzXB1WkttrHPn7qGRPbPc392P2G3LxDYHDbGxroARtvQ8zSdF5U=
X-Received: by 2002:a81:6dce:0:b0:31e:5a3b:d3a2 with SMTP id
 i197-20020a816dce000000b0031e5a3bd3a2mr5966976ywc.495.1658265355982; Tue, 19
 Jul 2022 14:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
 <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com> <2656551b-2c6f-9f0d-93a6-ef6177ec265e@gmail.com>
In-Reply-To: <2656551b-2c6f-9f0d-93a6-ef6177ec265e@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 23:15:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1LnCz32DixQ2VuBh+c64+CNqNJ8v2Nk0X6P8kYA4=-gQ@mail.gmail.com>
Message-ID: <CAK8P3a1LnCz32DixQ2VuBh+c64+CNqNJ8v2Nk0X6P8kYA4=-gQ@mail.gmail.com>
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock re-definition
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QV+yaOmp53gp6OjojdvV3ieXcFDNVjTN5PqmbJEzK8BPxF31qLU
 HiGlhZgDWQRUAU3u/LpXKuwrwjSL9UuRkxZg4KRiPp64Otzcoms+Y5SmFFtcO0u2MMOkWrG
 3SZnUAwHA46H4uEDnN+W4WDYXu/9dCdBzp4N+63Ufn4ZjuIVcyUQWwibT02MOsu7KUzDxsc
 Wy6AwRqtc+ps1KWWTBKHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10cdnJmKZtQ=:/QccC7jf5ms26fI4w4DM/A
 68WwR0xMqDB74n+nd1xapXgbQmr7DX0KwTTRVyeAOzD+FUP6BWfsHxg73hnz1JUpszIWKbGua
 b4VMenmeevupq5QSX0whZEDbGkyk2fzJISCWMp8JFw3vAejk4YN55sIZVcv52TTz9BwUoOxMU
 e3Wy/UXprMZzy5GK9+3QnYv0ggJAX9IB7iKXwxFWFORjAj/sDow4a2GjI8vxZDcZPGQFm+nIu
 fIWWeIBCMntn3Uy3MDUaF6pyv3hj3KwS1D/elaTtU+iHrvWw4X8u6YRFCybYJEZyWybps8ToB
 eBXwPVH71puSETIp2QOAj/BYMLCvvI1Kx2dg3bLPmaJ50BMKUciYT08ytcF21k+A5MIWo7mgl
 /SDL91ClZg3n0YRXzKyLDJwJ3wbRGgN+aKmyNnNIBqLrX11YOQeoH056WwVii+fZ3QWMPCdsC
 hmkw6yL1ztwCxMn9VxwK7eVP6FAHJYMeBVlOwWOAVsCiJOhBSHEwc6us0IAk8ZvBVDEguPdyk
 g39MUAXELrJjGuFs52ysmBKcxpGG4SuwCfqJ4ZbxOp1w+FEGcRL3jARQFTDWzOOq4qPvFf9K7
 123EWoEkdwQMICu8ZJEiqT0XOmZzYNZJB/p13TcUVc3a3NEqcMB2+PYDxW/bOVT8l5kGTwhB1
 qLk90KUshb9V6WNoA4XbzMGJwg2loSkgxYDC/4L/FKSFVdDTm7cWH9mbIRpEZGDJktyoYAv/B
 I/tdCX9jsVQVJX40LP2R9lDYO3RFVCnCQXlBMA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 9:05 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/19/2022 12:42 AM, Arnd Bergmann wrote:

> > I applied this to the asm-generic tree, but now I'm having second thoughts, as
> > this only changes the tools/include/ version but not the version we ship to user
> > space. Normally these are meant to be kept in sync.
>
> Thanks! Just to be clear, applying just your patch is not enough as the
> original build issue is still present, so we would need my change plus
> yours, I think that is what you intended but just wanted to double
> confirm.

Yes, this was just the diff on top of your patch, I've folded it into a single
commit now.

> On a side note your tree at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/refs/heads
>
> does not appear to have it included/pushed out yet, should I be looking
> at another git tree?

Pushed it out now. There is the main asm-generic branch that is in
linux-next, and the asm-generic-fixes branch that I should send after
the build bots report success.

I've merged the fixes branch into the main branch for testing for the
moment, but will undo the merge when I forward the contents.

> > It appears that commit 306f7cc1e906 ("uapi: always define
> > F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h") already caused
> > them to diverge, presumably the uapi version here is correct and we
> > forgot to adapt the tools version at some point. There are also some
> > non-functional differences from older patches.
> >
> > I think the correct fix to address the problem in both versions and
> > get them back into sync would be something like the patch below.
> > I have done zero testing on it though.
> >
> > Christoph and Florian, any other suggestions?
>
> This works for me with my patch plus your patch in the following
> configurations:
>
> - MIPS toolchain with kernel-headers 4.1.x
> - MIPS toolchain with kernel headers using my patch plus your patch
>
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

       Arnd
