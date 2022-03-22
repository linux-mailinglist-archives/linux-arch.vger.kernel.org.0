Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5764E43C8
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiCVQEQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiCVQEP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:04:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4585C36E;
        Tue, 22 Mar 2022 09:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F38D6126E;
        Tue, 22 Mar 2022 16:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B72C340EC;
        Tue, 22 Mar 2022 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647964966;
        bh=53qhTxwIy68V/G2LTGU3ZP7e3PIWiRm5YddHHvOGxXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYTt1n9K9NQ0sVF+i5iOM90fsEoISAnF4ekEo5NM2Q6qavYzlU8FTwRdkAFx4MH7D
         oKlB0+XXboSDJb9pHvpMLb+tymOJoyYKLhANS/IwqHsaxv9jk9P+POCejcbVc4g56I
         tgG1AHyFuMw0tqFhDQOXERtCjcMQBGewEE7HJv5aAKpN2CyuHBxECyjz62gVvzuGlm
         MqPxdmvBg8E8hP8zuGhRqXeaDz4V/rd00J18PJIteP71u7aJ9KNxrxA+2z9lYPchMp
         kDeTlOfpsijC4ucm7AQ5RyWcovn+UfaWKbkJwpixHhpetjmmkmXoYd7Jnwj8Od1nu+
         4qv0Jtg0q7FPA==
Date:   Tue, 22 Mar 2022 17:02:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
Message-ID: <20220322160234.hxyiugzm3qstyun2@wittgenstein>
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
 <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
 <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 21, 2022 at 10:47:49AM +0100, Arnd Bergmann wrote:
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

Probably, yes. I don't know of any fundamental problems there either.
