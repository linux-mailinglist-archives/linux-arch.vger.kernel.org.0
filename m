Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B20410480
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 08:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhIRG4i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhIRG4i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 02:56:38 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E584C061574;
        Fri, 17 Sep 2021 23:55:15 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id l19so10115166vst.7;
        Fri, 17 Sep 2021 23:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BURkVCRjjFHUHfhVT++eM+u/rf30SF7uc8tSLt0X+Oc=;
        b=GgvhCGrSxZJXPqSYDZUc8JUXWKFzU7zZyiS5sYWBzx+VrbPJZlTx9QyWtObCAF1Nih
         3TNw/8O+uXJERZBBoYcDMA5FsQwc5eFzl8ItbWqrPBTZf+6ogqxanup601TX5xC9Svui
         X1ODd6JW9Xix72sBhN2hcxXjeTeYUbAcBordW6WGY4yyt7nN/sPty3ci6t+Cfw3IP4U6
         Jmk+fWlv04O7Zn1Ry4THweYaTHyIsUnuo5dBdoEgxsfqhppXLtAZCTMww/Y/UDZDOP0Q
         I4cUVm6tiNrHdEifxXaX1DACev5clHbF3TqUVg+88B53MrVVg2fgDRi4rWwyafx1leZk
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BURkVCRjjFHUHfhVT++eM+u/rf30SF7uc8tSLt0X+Oc=;
        b=pGpbijfVUVs+wibdUHYqgFM3T8v/bRoSjkkUI5gjFrn45Gp/HkEumrG6CGVw0Sdgvt
         H9A69+rYFKHtAOxHxXZG8kImmdSsKCF0jlC6laPIn8clSO3SKCX8odL3QZgAxolWqQSL
         V2lH+cXx/DMODVLLTtNdgDyUQo7Hpy7GTIeWZEBVpH+bWnC8mFxYaoNrZxYZdqRa8IIf
         jp0DHzpcgChoLnzewpshr2digzlkP9qMvGFEALjschjOAcF5fBb7n4vogw5Lw15fgNOf
         Q2hi58oc9kyjGjhxehwh7xQUZgL3RFEoh5iC4L0v4z662/cSFb5xP3wzzwtdzXWOK8cd
         1Saw==
X-Gm-Message-State: AOAM530ZDDi0KHp6nMT9vhGqxe4+rkmOrmmPCOhu99bRm6zPPeuZbBQ0
        bjqQ3c4LljIMPbhbKK5yRvZvclITGm3FF4rEy6E=
X-Google-Smtp-Source: ABdhPJwhewBoUf59yhdkVWNG6VkBCWxshGpVvcIRTN362KNqhdzbDhfUlukK2rZ/IbClJiKc3d1Zejzxe6gNiB8lo4k=
X-Received: by 2002:a67:441:: with SMTP id 62mr11548405vse.54.1631948114246;
 Fri, 17 Sep 2021 23:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-14-chenhuacai@loongson.cn> <CAK8P3a3Ce0bsyrhEK1SZHtUPEnX-rvQcKLT-TPRGptNdmiJaqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3Ce0bsyrhEK1SZHtUPEnX-rvQcKLT-TPRGptNdmiJaqQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 14:55:02 +0800
Message-ID: <CAAhV-H7kaYAGz85pNFo0tSObS7A36vetBWUM9oEGCPH_b1AN-w@mail.gmail.com>
Subject: Re: [PATCH V3 13/22] LoongArch: Add system call support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Fri, Sep 17, 2021 at 4:24 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > +#define NR_syscalls (__NR_syscalls)
> > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > new file mode 100644
> > index 000000000000..b344b1f91715
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > @@ -0,0 +1,6 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#define __ARCH_WANT_NEW_STAT
> > +#define __ARCH_WANT_SYS_CLONE
> > +#define __ARCH_WANT_SYS_CLONE3
>
> I still think you need to remove __ARCH_WANT_NEW_STAT and
> __ARCH_WANT_SYS_CLONE here.
>
> I understand that those are needed for the transitional period when you
> still need to support your existing glibc library files, but you likely still
> have other kernel patches that are not part of this series, so I suggest
> you add those two lines as a custom patch there until you are ready to
> drop support for old libc.
The clone story:
When I sent V1 of this series, the upstream glibc (2.33) hadn't merge
the clone3 support. Now glibc 2.34 has merged clone3, so
__ARCH_WANT_SYS_CLONE seems can be removed. But I think there is
someone just download this series and suppose it can work with current
userspace. So I want to keep it for a while, until this series can be
merged.

The statx story:
The latest upstream glibc (2.34) is still like this
(sysdeps/unix/sysv/linux/fstatat64.c):
#if (__WORDSIZE == 32 \
     && (!defined __SYSCALL_WORDSIZE || __SYSCALL_WORDSIZE == 32)) \
     || defined STAT_HAS_TIME32
# define FSTATAT_USE_STATX 1
#else
# define FSTATAT_USE_STATX 0
#endif

This means statx is supposed to use in 32bit systems, or 64bit systems
with 32bit timestamp (e.g. MIPS64). So I think __ARCH_WANT_NEW_STAT is
still needed.


>
> > +
> > +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
> > +       unsigned long, prot, unsigned long, flags, unsigned long,
> > +       fd, off_t, offset)
> > +{
> > +       if (offset & ~PAGE_MASK)
> > +               return -EINVAL;
> > +       return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> > +                              offset >> PAGE_SHIFT);
> > +}
> > +
> > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> > +       unsigned long, prot, unsigned long, flags, unsigned long, fd,
> > +       unsigned long, pgoff)
> > +{
> > +       if (pgoff & (~PAGE_MASK >> 12))
> > +               return -EINVAL;
> > +
> > +       return ksys_mmap_pgoff(addr, len, prot, flags, fd,
> > +                              pgoff >> (PAGE_SHIFT - 12));
> > +}
>
> sys_mmap2() is only used on 32-bit architectures, you only need
> sys_mmap() here.
>
> Ideally we'd just move those two definitions you have here into
> mm/mmap.c and remove all the duplicate definitions. Maybe
> you can come up with a patch to do this?
>
> Note that some architectures use either nonstandard names,
> or shift value other than 12, so those need to keep their own
> versions.
OK, sys_mmap2() will be removed. But can "move sys_mmap() to
mm/mmap.c" be done by others? (I think my credit is not enough to do
this, at least now).

Huacai
>
>       Arnd
