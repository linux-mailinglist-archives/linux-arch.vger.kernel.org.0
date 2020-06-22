Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4BE20443F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgFVXEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 19:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgFVXEx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:04:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70368C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so627123pje.4
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VqNx5+2kiVG9gpFn3910S15vAkYBqDSSedKViD8vzv4=;
        b=PhMXOA29UjdzLB+31VLcjALbAfnuSCUduSik9FZHJh5NxaVg0Ze3ovaJuHS6uF5tOP
         BraZMyN9v0GrizeBmPjb+zv8Akwh25gsoP/yBmHWTJu61OLd+BYRA6M4+11FDOfmpb8R
         1oovTnRunpqHNHYygJvCh5+K/rrVDPOIAocDGPEKTab9E8fpHhzHI4F22vH11k2kWiOs
         QYJUl/zF2QvPUc3JTuCoS4rpwMK9ClrXFVhn37aTvwU/z2mwIqEzeuYKoF/1Sud3lFtS
         lew7XOE9/h8akBhb6Ty6i9DQ8T04WtAo+VzBd+qGy91923p+SFsaHaUiwiRNYJIDBiKo
         ddOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqNx5+2kiVG9gpFn3910S15vAkYBqDSSedKViD8vzv4=;
        b=kMyGC1QZkP2kCaeqYAakl66N86QajddGg7m21hiFYByF3U5ix6hznVi9d4KUR2jj12
         tJmuAng9YZBIQ7I7TrONcm3izvWnoZJXyY+0Z2ZTZRxZbBCecuJO2dQo8uK21T5Sh2Xx
         TlfKvR5hDxwZ0Etf16D+46IWfNfQ8ApV0BW3D7dMslR8PuyityeeY01+feC4CSSetrc+
         rCkhhml5JjnEYv7LJnRlorJ3s7oN4x3fwF5cpFz7Y6cxHOfuoRMIIHvxCDaxQl1X2DJL
         zOx7Ti56iz7QBRrICXPWkluhOFOch2P11bCkMhkR1jshbnJwCVuSYrwhDIYDW6YsFOSV
         DYSA==
X-Gm-Message-State: AOAM530W3wprmtuueWiWA4CjJ4j2S34OssQgyuR1XCfKSWa+RelHWWPw
        DC858XbwHqJ3BMYo4aEsfYaxMBhI8TwXuM7V8gwE8w==
X-Google-Smtp-Source: ABdhPJyAXHvfGosb+Hbd1OCZD4musz44ks3XUKHwlc3h/XC8VXif5udxUpRvvtysGawHTGaOgDrNushmDeejEo/jrew=
X-Received: by 2002:a17:902:49:: with SMTP id 67mr21218818pla.205.1592867091804;
 Mon, 22 Jun 2020 16:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org> <20200622220043.6j3vl6v7udmk2ppp@google.com>
 <202006221524.CEB86E036B@keescook> <20200622225237.ybol4qmz4mhkmlqc@google.com>
 <202006221555.45BB6412F@keescook>
In-Reply-To: <202006221555.45BB6412F@keescook>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Mon, 22 Jun 2020 16:04:40 -0700
Message-ID: <CAFP8O3KdGc9TtziFX7UzmxA-=wfPzm5oi6NCEwRiyyrp+JD3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 3:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jun 22, 2020 at 03:52:37PM -0700, Fangrui Song wrote:
> > > And it's not in the output:
> > >
> > > $ readelf -Vs arch/x86/boot/compressed/vmlinux | grep version
> > > No version information found in this file.
> > >
> > > So... for the kernel we need to silence it right now.
> >
> > Re-link with -M (or -Map file) to check where .gnu.version{,_d,_r} input
> > sections come from?
>
> It's not reporting it correctly:
>
> .gnu.version_d  0x00000000008966b0        0x0
>  .gnu.version_d
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version    0x00000000008966b0        0x0
>  .gnu.version   0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> .gnu.version_r  0x00000000008966b0        0x0
>  .gnu.version_r
>                 0x00000000008966b0        0x0 arch/x86/boot/compressed/kernel_info.o
>
> it just reports whatever file is listed on the link command line first.
>
> > If it is a bug, we should probably figure out which version of binutils
> > has fixed the bug.
>
> I see this with binutils 2.34...
>
> --
> Kees Cook

:( It deserves a binutils bug
(https://sourceware.org/bugzilla/enter_bug.cgi?product=binutils ) and
a comment..

With the description adjusted to say that this works around a bug

Reviewed-by: Fangrui Song <maskray@google.com>
