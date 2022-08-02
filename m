Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20058778A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 09:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiHBHKB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHBHKA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 03:10:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16011EC44;
        Tue,  2 Aug 2022 00:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42E0E6131A;
        Tue,  2 Aug 2022 07:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95D0C433D7;
        Tue,  2 Aug 2022 07:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659424198;
        bh=0jhHYyhCK+3Qhtr9ig01rDqez0BJmbBa8YmmaJMFHwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e9djQ/IGu8D5BlBmzQCVPktfYtADj9VUlvUc4wHOUshL2ItJTmLGk5XxGmp7LTamK
         7sQPbPmnl3hD0qR7Yejsjk4DIZCAU6TKTWpf4MKZw7WSqk3DfPQaXo+jQDohTCjNPV
         wd36oWM8YDqnp9+tgHfBSih4lpv9TKMQXnVjokkHjcLAeL5587NlqlbTwbqnfFT2T1
         OEdU+zlJejCKZI9AkOTchr4956mPzmMfaluKddsvngFBiS3sEpMtROBhXPudl9mc6V
         kRj7uZqBVHKB4clcoeybVZE7KqTzzEy7paU+lhmuGQbC08+MteqiGgDo+dKyQtwFSM
         hsYMDV0RDnyeg==
Received: by mail-ua1-f43.google.com with SMTP id f10so5468699uap.2;
        Tue, 02 Aug 2022 00:09:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo3EqEobFFoqgRYAlWySymh+XzAiagh90Px/kkia3iK1bt5ZccZ7
        AEnMoqnv2JtAYWmXGUeBnihlk+scn3gnePycmyg=
X-Google-Smtp-Source: AA6agR6grG2wQ5RJQ1Vef384HnoTVHvPAk/6u5j5UAg5aRz5bLpJE+22XfZgTZMFTDku5HsFuN1bkDeWgrYDh5cNfKk=
X-Received: by 2002:ab0:2359:0:b0:387:2dff:87d5 with SMTP id
 h25-20020ab02359000000b003872dff87d5mr7720498uao.104.1659424197668; Tue, 02
 Aug 2022 00:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802053818.18051-1-zhangqing@loongson.cn> <20220802053818.18051-4-zhangqing@loongson.cn>
 <CAAhV-H4qWTbjb45VNbA0is_2w1sgSW54kSngVhVpac5VehwoEg@mail.gmail.com> <e3df8c34-806c-e4ea-2fcb-df8efd0af610@loongson.cn>
In-Reply-To: <e3df8c34-806c-e4ea-2fcb-df8efd0af610@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 2 Aug 2022 15:09:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59tqWEFMPJ5=01qtYjd3P7xbA=Exgz2pU1nfq4ejiKGg@mail.gmail.com>
Message-ID: <CAAhV-H59tqWEFMPJ5=01qtYjd3P7xbA=Exgz2pU1nfq4ejiKGg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Add stacktrace support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jinyang He <hejinyang@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Qing,

On Tue, Aug 2, 2022 at 2:39 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
>
>
> On 2022/8/2 =E4=B8=8B=E5=8D=882:03, Huacai Chen wrote:
> > Hi, Qing,
> >
> > Though we had an offline discussion, I still think adding get_wchan()
> > support is worthy. :)
> >
> ok, I will adding get_wchan() support in v4 and modify the abbreviation
> of commit messages. :)
Maybe you can wait for some time to see if others have more comments.

Huacai
>
> Thanks,
> -Qing
> > Huacai
>
