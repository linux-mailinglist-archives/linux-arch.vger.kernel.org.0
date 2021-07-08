Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3403C144D
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGHNeJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 09:34:09 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhGHNeJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 09:34:09 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1rGy-1m3fyo2UVU-002JVg for <linux-arch@vger.kernel.org>; Thu, 08 Jul 2021
 15:31:26 +0200
Received: by mail-wm1-f53.google.com with SMTP id k32so894527wms.4
        for <linux-arch@vger.kernel.org>; Thu, 08 Jul 2021 06:31:26 -0700 (PDT)
X-Gm-Message-State: AOAM5327MeZFZ1oX4Sst84ecRJM7WgSvyaqlqtR0RfKX5xCBMe0zzzMd
        WKvkjqmAOy9bhDDrq0btW0duP8wsGkrxUGvy+DA=
X-Google-Smtp-Source: ABdhPJz92en+W1+M0bwaJyjLUElowbsWjUxd3dSWWu7j5BVGBjFyoQXk1nS3+FJZtHE6LKlvIm6UsiTr1073KNigPSg=
X-Received: by 2002:a05:600c:3205:: with SMTP id r5mr5181215wmp.75.1625750655305;
 Thu, 08 Jul 2021 06:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
 <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
In-Reply-To: <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Jul 2021 15:23:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
Message-ID: <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:POxGMf9wvf4BsezPYnLR4XdCsbUKnBCgRgkAt2q+o+Mqjs/Gu8w
 F35WYY+Yru+BEFfwffRtui2XvietRSvOkcDWa99HEwUdLddtNuYKcwajuVrFoGK+JulDXF8
 GUQQNhiTG5R8pVAe7EtVKdFp9Xkz0MZudkIxtcuiYwx4iJBIPjhKKdOmOZ1s25vfcxbosrM
 q8WjbENDhqkCms42H9ytw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:J8+lx8eDylA=:H4iWHDSWhFp0Xo3ub7mLpl
 UkQWTRt2Kne0nuM8E7T0fD9rbeG8xDbBJXyv+aK4v+3ahLk5HpP+qYGWEWUeydSNU6DxW/4Rf
 oNkAiHCXsz8bRj1iS37KKfBd1e+7VIcOdMoyUaHbtOXL1kXl0Kpew4zWVNQ49AhlJsFSLVeCE
 VyNoAeH3lN+ASdnKWfWs+pjgBOp8JvcLdsugsnXa5UD4qjxx5jzWEhDxNb64ZGCKBykx8AB4/
 vUZleUYi52bBZcnRb3jD59RAhsIvL498/BK7MnOFh8JCt/n3WUcM69K5b5faBvLAJ9fYFYrO5
 QMqRv9S1AW1vUUfdMGLI+VE6m0W1m54VEdN4yzKB1yA0Xgg9tT+TmDzSdz+MaXNPPkMi87IHo
 f8EG0j2UFpQmeszesP44Co3OQR3PIgGfV+DNLMXWxKXkJSFycNQ8Z0+eAWrNFBqwddt1uldJb
 2bDaXdIyf/rYbVxaRSJkz7ZYzzb1R55ql8JA+xtDOcw8No/2lCK9TMOK9K7tV9aC8mHuNxb0O
 BrVGsq3M3KV9rABa0AzIkUIOSr7LXlr5IoUT4TAJKS674uy6DMtoed2OlToCYuK/3sm41ARrX
 iDJ9A9el6cSLYqeAm526tlyKHSW0rb7D9B8gHFhtEutdWZih/1RpWe//F5B3S1qZXAMYhxWGM
 e08xyskbYd37znAVELTkEaLBEzyh72QOjteghMmdV5H/wI/u0bJyd7TbeiHjqNpFuGX9KFGav
 UCeNSThRjRYFy+PIHruXfcm04beIb9C/U5sZouJ6Q4dW7F77pwB5T9MhRdtM2tP94uWP++6Io
 I24rIcoP8AZzJzQbYnl95jdK9K1Pxym7FPu6sCO5jvEp+t2NfoT/eDVupa8/1MGfcENutn8No
 GslopM8argY9SBGJrXtlWJcnCPWqWPKZliQSnUXn4EC3MZfPSPhyiV1IzuTjWX8yMh4s6ZWOr
 0d9/tl0r7dY+WGhJz6yGLe3TXbj95cieLrmQEIlQppJpP4lqDihYF
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 8, 2021 at 3:04 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > +
> > > +#ifndef _NSIG
> > > +#define _NSIG          128
> > > +#endif
> >
> > Everything else uses 64 here, except for MIPS.
>
> Once before we also wanted to use 64, but we also want to use LBT to
> execute X86/MIPS/ARM binaries, so we chose the largest value (128).
> Some applications, such as sighold02 in LTP, will fail if _NSIG is not
> big enough.

Have you tried separating the in-kernel _NSIG from the number used
in the loongarch ABI? This may require a few changes to architecture
independent signal handling code, but I think it would be a cleaner
solution, and make it easier to port existing software without having
to special-case loongarch along with mips.

      Arnd
