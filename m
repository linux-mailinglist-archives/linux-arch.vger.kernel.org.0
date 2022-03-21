Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91F4E237A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 10:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345888AbiCUJmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 05:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiCUJms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 05:42:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C45B3FC;
        Mon, 21 Mar 2022 02:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6DA9B8117E;
        Mon, 21 Mar 2022 09:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6FCC36AE2;
        Mon, 21 Mar 2022 09:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647855680;
        bh=PA5/9WnwkF/956PEUqe0HUC0jBHuB/WEpZFZAjgcOPo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ig0yIp6nnvDCXMfOIfWkuqoa298Gqho8BLob4gl9UraOtx/IOf6QLLql5Fa2rPT7P
         rexB5w4Dm+yYA/YmqTLEVsK9Ik+VPEB6KOL5Y7dv7Zady4hgf83Crfc2sW6WpHWcwL
         n6sqTIauXgZSHNXybUCgM9WZn8kR8a9Nf6wNaaRyZu4nEYj/Cs+Tm+Irz/ObnzcPd+
         NAqqUNouzsJ8R58YHwpr+XkU25t8RFmjZVdFAL5TEg1PkasnmX9t53XhfMnhhsuFSQ
         7DAQcyoHIid5E+j93KzTuJHWyVZH1KSHticgdTZXtuvNf46KeUXti1P6XHpc1brATX
         RPBaJTsvyPWYA==
Received: by mail-ua1-f45.google.com with SMTP id 34so5535051uao.13;
        Mon, 21 Mar 2022 02:41:20 -0700 (PDT)
X-Gm-Message-State: AOAM531VSa1HlXnBgf5pSacTFSrtnv8NKyxS63PlKETJYBzY9XqrJhpE
        JN8RWZKKRY9S1Fu/wcxQK6ynDjG41DFwkcvTJZg=
X-Google-Smtp-Source: ABdhPJz2Dhu98c64JwlgRM4uWbyOOQxZ9DSBqgniZPOgIEr9/bx2eRULm+DkFPicObxWP4o8HfxCwc5WYhqfrMcLIGY=
X-Received: by 2002:ab0:30b8:0:b0:356:c867:9283 with SMTP id
 b24-20020ab030b8000000b00356c8679283mr2197618uam.118.1647855679197; Mon, 21
 Mar 2022 02:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
In-Reply-To: <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 21 Mar 2022 17:41:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
Message-ID: <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
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
        Huacai Chen <chenhuacai@loongson.cn>
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

On Mon, Mar 21, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > This patch adds system call support and related uaccess.h for LoongArch.
> >
> > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> >    bit platforms still use newstat now.
> >
> > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > A: The latest glibc release (2.34) has some basic support for clone3 but
> >    it isn't complete. E.g., pthread_create() and spawni() have converted
> >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> >    related applications can still not work perfectly with clone3.
>
> Please leave those out of the mainline kernel support though: Any users
> of existing glibc binaries can keep using patched kernels for the moment,
> and then later drop those pages when the proper glibc support gets
> merged.
The glibc commit d8ea0d0168b190bdf138a20358293c939509367f ("Add an
internal wrapper for clone, clone2 and clone3") modified nearly
everything in order to move to clone3(), except arch_fork() which used
by fork(). And I cannot find any submitted patches to solve it. So I
don't think this is just a forget, maybe there are other fundamental
problems?

>
> > +#define __ua_size(size)                                                        \
> > +       ((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
> > +
> > +/*
> > + * access_ok: - Checks if a user space pointer is valid
> > + * @addr: User space pointer to start of block to check
> > + * @size: Size of block to check
> > + *
> > + * Context: User context only. This function may sleep if pagefaults are
> > + *          enabled.
> > + *
> > + * Checks if a pointer to a block of memory in user space is valid.
> > + *
> > + * Returns true (nonzero) if the memory block may be valid, false (zero)
> > + * if it is definitely invalid.
> > + *
> > + * Note that, depending on architecture, this function probably just
> > + * checks that the pointer is in the user space range - after calling
> > + * this function, memory access functions may still return -EFAULT.
> > + */
> > +static inline int __access_ok(const void __user *p, unsigned long size)
> > +{
> > +       unsigned long addr = (unsigned long)p;
> > +       unsigned long end = addr + size - !!size;
> > +
> > +       return (__UA_LIMIT & (addr | end | __ua_size(size))) == 0;
> > +}
> > +
> > +#define access_ok(addr, size)                                  \
> > +       likely(__access_ok((addr), (size)))
>
> I rewrote this bit a series that is currently queued for 5.18, so you
> will have to adapt it to the new version, by just removing your
> custom definitions.
OK, this will be updated.

>
> > +#define __get_user(x, ptr) \
> > +({                                                                     \
> > +       int __gu_err = 0;                                               \
> > +                                                                       \
> > +       __chk_user_ptr(ptr);                                            \
> > +       __get_user_common((x), sizeof(*(ptr)), ptr);                    \
> > +       __gu_err;                                                       \
> > +})
>
> It would be good to also provide a
> __kernel_kernel_nofault()/__put_kernel_nofault()
> implementation, as the default based on __get_user()/__put_user is not
> ideal.
They are provided in this file below.

Huacai
>
>         Arnd
