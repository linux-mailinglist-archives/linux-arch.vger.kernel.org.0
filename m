Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D04E36FE
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiCVC6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 22:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiCVC6S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 22:58:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3143FFD74;
        Mon, 21 Mar 2022 19:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A02D6113C;
        Tue, 22 Mar 2022 02:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE42EC340F3;
        Tue, 22 Mar 2022 02:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647917801;
        bh=YEpuCp2P6kjoBndK4Ea4E+BlNtN1oBALS8HZJrXyV2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mDfQjkS2M5e69HcKlS1E5oQpk1kuGQsmejHzx93zyfw1Nm2XFLSavr5tZhJTifykA
         Z+AlC41AgnKpW0TH0GbCklwrbKffWX3EQCZ8nzGyZcuSdrE/q1OWFMUWhBJw1G4CC5
         4cjYXe3h2/hPuKrQSa1KIk87zKVXlJ54sn1suUhzCPmOhKka1YsvAD0ZZyIfoZEolJ
         /i4TJ+Ch3OJlH3Nk2D6J+jB/TQqwOVFoeAL2fEF/NW8zF4hBgGbe8YJX0Bmph7cOsV
         EzT8JqdZW+2CpsOEvvwqI1nYy7DGcYyy/BTYimGfMetUsIpVpFpnabZz6/a4nljUdH
         J+Gd+ALJnv+zQ==
Received: by mail-ua1-f52.google.com with SMTP id o26so6508913uap.4;
        Mon, 21 Mar 2022 19:56:41 -0700 (PDT)
X-Gm-Message-State: AOAM531v/UWOfMXo++ObBRYR4ZkHF7alpPGmN9B7MvGssh0Z6UuU2/RG
        NQjbRw7lcGqK+zZSADF7TzfwymquS5ZtcBnWpkA=
X-Google-Smtp-Source: ABdhPJyU1p4psTJi1hIstGjzXfKNega2swCJ9tyW4pUhSWqG4ugHLcm62ysTivsRm40bGreCnbkX6d5oIyShkJ+Hsuk=
X-Received: by 2002:ab0:30b8:0:b0:356:c867:9283 with SMTP id
 b24-20020ab030b8000000b00356c8679283mr3724666uam.118.1647917800908; Mon, 21
 Mar 2022 19:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
 <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com> <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
In-Reply-To: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 22 Mar 2022 10:56:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H67o+6zkw4pvDb46c=b4UNtKesog08yGf_hhhXAbLoZGA@mail.gmail.com>
Message-ID: <CAAhV-H67o+6zkw4pvDb46c=b4UNtKesog08yGf_hhhXAbLoZGA@mail.gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Mon, Mar 21, 2022 at 5:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 21, 2022 at 10:41 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > On Mon, Mar 21, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > >
> > > > This patch adds system call support and related uaccess.h for LoongArch.
> > > >
> > > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > > >    bit platforms still use newstat now.
> > > >
> > > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > > >    related applications can still not work perfectly with clone3.
> > >
> > > Please leave those out of the mainline kernel support though: Any users
> > > of existing glibc binaries can keep using patched kernels for the moment,
> > > and then later drop those pages when the proper glibc support gets
> > > merged.
> > The glibc commit d8ea0d0168b190bdf138a20358293c939509367f ("Add an
> > internal wrapper for clone, clone2 and clone3") modified nearly
> > everything in order to move to clone3(), except arch_fork() which used
> > by fork(). And I cannot find any submitted patches to solve it. So I
> > don't think this is just a forget, maybe there are other fundamental
> > problems?
>
> I don't think there are fundamental issues, they probably did not consider
> it necessary because so far all architectures supported clone().
>
> Adding Christian Brauner and H.J. Lu for clarificatoin.
OK, wait a response, if arch_fork() will be moved to clone3(), then I
will remove __ARCH_WANT_SYS_CLONE.

Huacai
>
> > > > +#define __get_user(x, ptr) \
> > > > +({                                                                     \
> > > > +       int __gu_err = 0;                                               \
> > > > +                                                                       \
> > > > +       __chk_user_ptr(ptr);                                            \
> > > > +       __get_user_common((x), sizeof(*(ptr)), ptr);                    \
> > > > +       __gu_err;                                                       \
> > > > +})
> > >
> > > It would be good to also provide a
> > > __kernel_kernel_nofault()/__put_kernel_nofault()
> > > implementation, as the default based on __get_user()/__put_user is not
> > > ideal.
> > They are provided in this file below.
>
> Ok, I see them now, not sure what I did wrong when I looked earlier.
>
>         Arnd
