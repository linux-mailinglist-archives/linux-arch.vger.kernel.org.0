Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66D2538F87
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiEaLPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 07:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiEaLPW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 07:15:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E2994F3;
        Tue, 31 May 2022 04:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02846B80FBD;
        Tue, 31 May 2022 11:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2E3C385A9;
        Tue, 31 May 2022 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653995718;
        bh=spm2UFjiS6fo8kk8UmCdleJqxwofF/24678eBahMomc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DUTZyAV6vmjsTeXar9jAU8J1pcHQfkQuE5QyO53BZ8O6qshPBXt3F4Ue1GJ6SXGNe
         xVzcOgcyEA1gJWG0/rXEsHtnu61j9OOX7kyU2z/Kf1WnM+x8t+sjTKN+EDVFCALLgW
         5qT/LD2vYLqTTcqYS1OMH7FWK5Fb7cQW4GySvfQ9U3XQrBX31zCpcycj4Wm/VcwOyG
         ZeE32bTP6rkd8lLPtfmxzOKN26hh89r5lqmKQWvjpFK2WwJ58Xm6aPAbm6I4903902
         a7bQyNNXEa7OO2CR+CtY64+u4tLz5scXH0MOz7YYGCuroKyDWOKPggtvcBkYeXhyPW
         SbXuo8v6tpjgw==
Received: by mail-yb1-f178.google.com with SMTP id a64so13036382ybg.11;
        Tue, 31 May 2022 04:15:18 -0700 (PDT)
X-Gm-Message-State: AOAM530+/jaMtKsb0p5mtCp0ybK2KSaJW+kGw0xRzeJ+z/E4wOn/pwHu
        UeU3EqzESrIfWqfCrEfBt0oeISiUJNJedP3u25E=
X-Google-Smtp-Source: ABdhPJzib5WuqtNhjnhge2BPfWDo2FJWgi1Qcys5IM2Iv/hVgNJtSBxsL/pGrhAkQ4whDydRW9RKvkK9GP/C8I9PNXo=
X-Received: by 2002:a25:4f0a:0:b0:64f:6a76:3d8f with SMTP id
 d10-20020a254f0a000000b0064f6a763d8fmr47846196ybb.134.1653995717866; Tue, 31
 May 2022 04:15:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name> <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com> <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 31 May 2022 13:15:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
Message-ID: <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
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

On Tue, May 31, 2022 at 10:17 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Tue, May 31, 2022 at 4:09 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, May 31, 2022 at 9:50 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > On Mon, May 30, 2022 at 11:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > On Mon, May 30, 2022 at 5:00 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > > > > Now I see
> > > > > the loongarch-next HEAD is already rebased on top of what I believe to
> > > > > be the current main branch, however I vaguely remember that it's not
> > > > > good to base one's patches on top of "some random commit", so I wonder
> > > > > whether the current branch state is appropriate for a PR?
> > > >
> > > > You are correct, a pull request should always be based on an -rc, orat least
> > > > have the minimum set of dependencies. The branch was previously
> > > > based on top of the spinlock implementation, which is still the best
> > > > place to start here.
> > > I have a difficult problem to select the base. Take swiotlb_init() as
> > > an example: If I select 5.18-rc1, I should use swiotlb_init(1); if I
> > > select Linus' latest tree, I should use swiotlb_init(true,
> > > SWIOTLB_VERBOSE). However, if I select 5.18-rc1, linux-next will have
> > > a build error because the code there expect swiotlb_init(true,
> > > SWIOTLB_VERBOSE).
> >
> > Ok, I see. This is the kind of thing we normally prevent by having everything
> > in linux-next for a few weeks before the merge window. How many issues
> > like this are you aware of? If it's just the swiotlb, you could try merging
> > the swiotlb branch that is in mainline now on top of the spinlock branch,
> > and still get a minimum set of dependencies. If there are many more,
> > then basing on top of the current mainline is probably less intrusive after
> > all.
> I have 3 issues:
> 1, swiotlb_init(1) --> swiotlb_init(true, SWIOTLB_VERBOSE);
> 2, the prototype of handle_kernel_image() should be changed from 5
> parameters to 6 parameters;
> 3, the return value type of huge_ptep_get_and_clear() should be
> changed from void to pte_t (and the function implementation should be
> also changed).

Ok, I see. Let's stay with the base on top of a mainline snapshot then.

       Arnd
