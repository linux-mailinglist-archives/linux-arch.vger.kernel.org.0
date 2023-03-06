Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5606AB46C
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 02:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFBzn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 20:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCFBzn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 20:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFFEEB6A;
        Sun,  5 Mar 2023 17:55:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0D13B80159;
        Mon,  6 Mar 2023 01:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778DEC433D2;
        Mon,  6 Mar 2023 01:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678067739;
        bh=LFOlhZwjqco3To24PwT/bnjj85QY4nt/PP/0xwPn7vk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jmjgia47Nm0V2fMUC+HcgRaq5jaoDN1qK8kVi9874X3ogjTjxrzkxsqc+h4D3rArt
         eigsRC6bbzSQLeoWETlqr735jtOdMW8DQAwymL/dEsP9IRPn45wYvy7K5MkykDk+Cn
         9vH5fgnDsZIWyxDd+ptU0fxqBFMWgQLRVvkhur3eVMAxjLQd0Xu8B/E3EvVXJHa3vB
         Yxqw61NI9Ac72tsDlFAIpRmsoHvrDeYMr1FMtzmRFHXMna6kEeuWyRQBdTkdz9+ZhZ
         seYzvxO+jNDl6DZCtW6FfJeRGtHdA/+iMDGuEIuoBAz6hXftxoTvLcUM5SoPQcZrxy
         oFQ9gtjSLNBEQ==
Received: by mail-ed1-f42.google.com with SMTP id da10so32578057edb.3;
        Sun, 05 Mar 2023 17:55:39 -0800 (PST)
X-Gm-Message-State: AO0yUKUQm5gdd3NHEzFgTvML7a7sYPif15Vre7EbYxBqnl0j00dEycIG
        1K7JHDIxrMQnrUAOnDsHG/M/WZ+Qy3YsoMWVGzM=
X-Google-Smtp-Source: AK7set/D4BiQAR9m/qKto9etEw32s+atfviVn8FEBBDjd8K4N5zPu71rK44UGSm5NsriVjlfyEepBpjGXTI+b+9MgxU=
X-Received: by 2002:a17:906:274f:b0:877:7480:c561 with SMTP id
 a15-20020a170906274f00b008777480c561mr4377647ejd.1.1678067737750; Sun, 05 Mar
 2023 17:55:37 -0800 (PST)
MIME-Version: 1.0
References: <20230305052818.4030447-1-chenhuacai@loongson.cn>
 <48f508aa-ab40-7032-a68d-90d8986afb2f@xen0n.name> <CAAhV-H55QUrkYYR1Lbj=zbquiz3frX2dNAH23fAuN6eCOUddNA@mail.gmail.com>
 <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
In-Reply-To: <58cc7e6d19628757d6d8dc192d07876288f6077e.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 6 Mar 2023 09:55:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
Message-ID: <CAAhV-H7vv+AE-7kDf7YpU6_f_dTNxKKoRSHC6vA4aBHOVyMRAQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Provide kernel fpu functions
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 5, 2023 at 9:28=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Sun, 2023-03-05 at 20:18 +0800, Huacai Chen wrote:
> > > Might be good to provide some explanation in the commit message as to
> > > why the pair of helpers should be GPL-only. Do they touch state burie=
d
> > > deep enough to make any downstream user a "derivative work"? Or are t=
he
> > > annotation inspired by arch/x86?
> > Yes, just inspired by arch/x86, and I don't think these symbols should
> > be used by non-GPL modules.
>
> Hmm, what if one of your partners wish to provide a proprietary GPU
> driver using the FPU like this way?  As a FLOSS developer I'd say "don't
> do that, make your driver GPL".  But for Loongson there may be a
> commercial issue.
So use EXPORT_SYMBOL can make life easier?

Huacai
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
