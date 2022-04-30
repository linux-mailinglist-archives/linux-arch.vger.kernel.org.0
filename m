Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACC2515C66
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiD3LNz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiD3LNy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 07:13:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CF5FF6;
        Sat, 30 Apr 2022 04:10:29 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ma1HG-1nNjqD27l6-00W23Y; Sat, 30 Apr 2022 13:05:09 +0200
Received: by mail-yb1-f175.google.com with SMTP id w187so18600390ybe.2;
        Sat, 30 Apr 2022 04:05:09 -0700 (PDT)
X-Gm-Message-State: AOAM531o/3BAN8nqceJV/xsr+E4yVz2GNdptZvfqIMN9bInkV6Fq3mxS
        XF/+7H5zHjU7aXJJnZT4XERP7tJBoQdkJtbSIAs=
X-Google-Smtp-Source: ABdhPJwibsCnhqRh57jVjG10phM0BrUgvfZ/Cu+XnlvIN8vHkz0VXxSV0emX0Uq3MS9OyJQ4u/HSolRYBlWtD82GrJc=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr3093454ybf.480.1651314908194; Sat, 30
 Apr 2022 03:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn> <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
In-Reply-To: <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 12:34:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
Message-ID: <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christian Brauner <brauner@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5Q9ONKpvezK/gY6sK2MPxh0TEU0BEAAMPsvROxQ36cnlmFEuzsX
 HJsG/sjFOKpipVSpnXpq9/Ku4sBDl72eHjTZI/jSDmrqMQ8IIFStXLMVQjFdfwzt3St4jP7
 E07FbeDW1UzkQp6jGVh7QHV6fYvi4I2RH664Dtr/txCTm7/GLBVUuHn6rRjXvAUTb4m+3ZQ
 bP4jZMRxNSRZ3WHWQ1MAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oWsy5LbyTq4=:s7CgRuTp2XESwdp66ENlDB
 +NkgFe9kdfEFuy214EXWqK1AHaJR4oXifE5/H5Kur1cVn7QArR7Txb627fNLJl8mEoCWvWCyf
 G4SXEAH0q5qjr9RvMNvZhnKhHyvdMjP6oYE678pwKSqoDdXn6QJG4kWv68n+ME8rHBp5832DT
 MQPlpKZqUn/lJMFIX/Jj0nd+0M30HUNVP80dbr+5bWkXSvJSmms8MZQWtFX9Xrtyl21sCHJlY
 X34QYEFwUHNcJoFziIPhbVuPMM0otbQcRgjZkR8I3vTrR4LpX4SeyLNvs70vdFQWILlh7nIwc
 /+sfcxsbcFu4lD4hE5x/p2ZPGgChsCwmjEgWIl7KGDcEewGXNM31KEUo5bb8PGXnDuzIrvLcO
 GsMWKhPkxG6Cx6zyD3DotsOdt5XT66aLYlTfeCje8GoAbV7CJpgXK6IT7OH4ywqpIF/y88CQd
 wUBn4BLGGENZ9mv3UeJuAx+hLfAdb5Cjxif+bG5nUeaOnQ769/37AoJhDLCK/XUwyRmtFN/Z5
 97FSHXEQf23DdpAA13mLkGHkGoBOVuQpmnBy5ySCGj21CleDHrt7byJDB0n4GS8lrNM2mCWkv
 hy6OykB1ixIlssTi1skcFPeTYdk7NKLz3SZaq014lznWmdXYR7aYf//tUAUZNDbGbjJDxq52P
 YsG7j/xU8PO4c+TvzTEnZEjujWIIowaOMbh/A6MkrEDV/17xKWtFLUtpLaEOF7NG/I/HGhctw
 /V/Stumjei+zsmOAeY2oJl2x84P9h8O/NEm79U5ggsdJqGPwz0JrJcgeVQx/NVHSeMYrGaeRO
 YVshJNh2V4ryguQjzMPbdPBwXEBIB+MicnBZEOcPNVKahVmyRA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 12:05 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Sat, Apr 30, 2022 at 5:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > This patch adds system call support and related uaccess.h for LoongArch.
> > >
> > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > >    bit platforms still use newstat now.
> > >
> > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > >    related applications can still not work perfectly with clone3. E.g.,
> > >    Chromium sandbox cannot work at all and there is no solution for it,
> > >    which is more terrible than the fork() story [1].
> > >
> > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2936184
> >
> > I still think these have to be removed. There is no mainline glibc or musl
> > port yet, and neither of them should actually be required. Please remove
> > them here, and modify your libc patches accordingly when you send those
> > upstream.
>
> If this is just a problem that can be resolved by upgrading
> glibc/musl, I will remove them. But the Chromium problem (or sandbox
> problem in general) seems to have no solution now.

I added Christian Brauner to Cc now, maybe he has come across the
sandbox problem before and has an idea for a solution.

        Arnd
