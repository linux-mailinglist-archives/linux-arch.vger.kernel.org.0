Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832E5ACBAE
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 09:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiIEHEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 03:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiIEHEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 03:04:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3EF1D0C5;
        Mon,  5 Sep 2022 00:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6E87B80EA6;
        Mon,  5 Sep 2022 07:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A178C4347C;
        Mon,  5 Sep 2022 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662361483;
        bh=gABsR+C8s1QYA2kJuQbKyt5Do4plDC0D2eCx6RfARLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MzycPAexg5XdWGeU4fi08dtp7cGApj/o0eq9owOGhMOpvI62AapOnSKjpezLtg2Dl
         gI0Dp3XClL9p7Vsl9RlrwuWUWkXbJBugctHn70cSCdjTDEtt7+dApTcp30SjVXqxvZ
         bliZ0X+EcWyu0VzziBe0Y4UqRZRhu2yNf2t+xJh50cL6+ScSdZ2T6xPtA2eEbg0BG9
         e1OS/tqFyzVfkaHKFdL5jTUOGiib16nYMPQvgUINsRoFyeVefKC8V2H1RZHmksa5T+
         O438BBZW6nCe+xiqVBvZnP6ANizU6SGUWEGdsOBXLXokUc6jDXmSqscp3xBDgQCxIM
         yewJbrUU5jLcQ==
Received: by mail-lf1-f53.google.com with SMTP id p7so11829519lfu.3;
        Mon, 05 Sep 2022 00:04:43 -0700 (PDT)
X-Gm-Message-State: ACgBeo2E/UdnjosYzqZHZsMtFqa65bh/Rylfn0xoMQuVSf+ZFnCFZL4V
        PwhNOYh89qGSfhZUA+JYUUJP4MNnuHsF60g47gE=
X-Google-Smtp-Source: AA6agR5beeTW6f/IM3Hyd4GU9/H9AoDWKkjjc75oL9DUZe8qduXi1GWu10PbgZ8g5dtSppNKZvYN2MvsDb5xt0foixA=
X-Received: by 2002:a05:6512:150e:b0:492:d9fd:9bdf with SMTP id
 bq14-20020a056512150e00b00492d9fd9bdfmr15272229lfb.583.1662361481624; Mon, 05
 Sep 2022 00:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819102037.2697798-1-chenhuacai@loongson.cn>
 <9b6f0aeaebbd36882b5b40d655f9ccd20c7be496.camel@xry111.site>
 <CAMj1kXFOd+gMHbi6MH0KHWkBEKN9V0LeZbyGRw8h630OxtMrdA@mail.gmail.com>
 <CAAhV-H6MR=rWhecY_uuiXAysED-BBJhKhGHj2cCkefJiPOo-ZQ@mail.gmail.com>
 <CAAhV-H4KXVUBgNoQxOFiEj2AH-ojhnrEJ8QLvNrALY69MhXF3w@mail.gmail.com>
 <CAMj1kXHJv_6mLhMikg+ic7=EUABLdrX3f__eBbHntrpGHjRfXg@mail.gmail.com>
 <CAAhV-H4WTCRU9qShDp57AZ2DG1uz+=GTz14zyAUaqVDjXrNABA@mail.gmail.com>
 <8319b9d4-960c-e706-468a-cb58bef6df8c@loongson.cn> <2772310e-a537-a733-c7c1-be3ff243d2fe@loongson.cn>
In-Reply-To: <2772310e-a537-a733-c7c1-be3ff243d2fe@loongson.cn>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 5 Sep 2022 09:04:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEj_4amyccrHu40i6XTrSX9bxZdXL=8aY=AD9QT-2JmDw@mail.gmail.com>
Message-ID: <CAMj1kXEj_4amyccrHu40i6XTrSX9bxZdXL=8aY=AD9QT-2JmDw@mail.gmail.com>
Subject: Re: [PATCH V3] LoongArch: Add efistub booting support
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, 5 Sept 2022 at 08:29, Youling Tang <tangyouling@loongson.cn> wrote:
>
> Hi, Ard & Huacai
>
> While applying this patch [1] we need to add vmlinuz* (vmlinuz and
> vmlinuz.efi) to arch/loongarch/boot/.gitignore to ignore the generated
> binary (also required for arm64 and riscv).
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?h=efi-decompressor-v4&id=efcc03a013f2ddbed0ee782e5049b39432dc9db2
>

Good point. I'll add that.
