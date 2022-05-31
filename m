Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182B538C87
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiEaIJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244657AbiEaIJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 04:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E184490CEC;
        Tue, 31 May 2022 01:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94C53B80F96;
        Tue, 31 May 2022 08:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DA3C385A9;
        Tue, 31 May 2022 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653984584;
        bh=RYpC6xoAQxlzwzTS1Q9qNjdKjQ7qaBCIuSSqtsnXLSA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W1ConLa0fa4CSVyJdeiG/MvfrvK8aQ6HhtVkyfspn7uvFJDxNNOIcNyqLmAfKqTcO
         EkRa2N9Ses3HUwH4CrDat1jsce69unKSvoYkDIDQwQqnYtoinOjxy+pHTc4ukWM/Gi
         GOVRlheQSO57/Tfw11+rtubK4AoEvwzXLi0INwbCbZbBw6BfB36JcBDvgoN7LldXtf
         NdYwbo7NuSILBQsj8f6cGY4crptgEmSZsDjcPGqb7FJfJ3K5fl4hjDqQpW8Tlzz6eL
         iwvdFbfphy0PmCw+MbzVQa9ctwRLaqQAQQRLZcBzWeTrH04N/d0Kq3dpFN0Xp8kZXt
         9ru/+Z/QAH3wg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3043b3f7d8fso120808117b3.8;
        Tue, 31 May 2022 01:09:44 -0700 (PDT)
X-Gm-Message-State: AOAM533M6MX1rKOBrp9iTr/VHuG+iBY99xXLp1BcRLbH8YHXV0r+MgNf
        LfoEK5cZG+amFsMYMNlcMduHoBHrzR46Vle5UtA=
X-Google-Smtp-Source: ABdhPJyhJog8azsioErC+i5PlBgcKzbEGCvn4zseszGYzoUs1FVRvYrMO45NFlB3l1wsrjJ5hIWZQ9m0KHU6vN1LfV8=
X-Received: by 2002:a81:28b:0:b0:30c:5e57:fac3 with SMTP id
 133-20020a81028b000000b0030c5e57fac3mr8140757ywc.249.1653984583406; Tue, 31
 May 2022 01:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name> <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
In-Reply-To: <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 10:09:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
Message-ID: <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     musl@lists.openwall.com, WANG Xuerui <kernel@xen0n.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 9:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, May 30, 2022 at 11:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Mon, May 30, 2022 at 5:00 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > > Now I see
> > > the loongarch-next HEAD is already rebased on top of what I believe to
> > > be the current main branch, however I vaguely remember that it's not
> > > good to base one's patches on top of "some random commit", so I wonder
> > > whether the current branch state is appropriate for a PR?
> >
> > You are correct, a pull request should always be based on an -rc, orat least
> > have the minimum set of dependencies. The branch was previously
> > based on top of the spinlock implementation, which is still the best
> > place to start here.
> I have a difficult problem to select the base. Take swiotlb_init() as
> an example: If I select 5.18-rc1, I should use swiotlb_init(1); if I
> select Linus' latest tree, I should use swiotlb_init(true,
> SWIOTLB_VERBOSE). However, if I select 5.18-rc1, linux-next will have
> a build error because the code there expect swiotlb_init(true,
> SWIOTLB_VERBOSE).

Ok, I see. This is the kind of thing we normally prevent by having everything
in linux-next for a few weeks before the merge window. How many issues
like this are you aware of? If it's just the swiotlb, you could try merging
the swiotlb branch that is in mainline now on top of the spinlock branch,
and still get a minimum set of dependencies. If there are many more,
then basing on top of the current mainline is probably less intrusive after
all.

       Arnd
