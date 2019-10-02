Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBBAC488C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2019 09:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfJBHbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 03:31:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39494 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJBHbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 03:31:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id n7so25116161qtb.6;
        Wed, 02 Oct 2019 00:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WGNRsjSRmemddwGXPWsCXOzzSeiEp7JkL4q/D6jMrQ=;
        b=bDRSgC/RwoK9Sx1p7XWfDK3G6BjVc3qNe0DSL4DAQzXM7dYbQ09JzvHLi2SJNYTEV9
         ahVNv7ulviEphH3Jzlj/4H9G6RQXa2lBgQkKfqU0p6tnoRgkofJ/wQn4eIIKV7p6N7pi
         HioUsZ0x2bOQl/hUGL02sO6O80IcUZBIDUEZBi8uEnzlwL7HYzZ3KvXcgn+PlAFu/l8z
         vFhERPgkljkUozlhVEdNgihC/05bEvGOsP3I8Gs6F5sLoQPbyP+jIfN4FYT32Oi208TI
         Sv0gVJlWN2QpGPAJT7o8FoX2j1RoDRM7V054Yg8eucD21zaweISZhOUZmq/Zewb0jfDD
         3TUA==
X-Gm-Message-State: APjAAAU7WTI3Pfr8xG7F1u+kLWes52QE0Q/0bcE8Tpnjlb1mo7oUkthd
        0Rc5hDd3tD7ReBSDKmzLgRlgJ+K3IW4t/ejawxg=
X-Google-Smtp-Source: APXvYqw28yN8VC30hFQhQe8SwCFurMsx1x13bc9bSbVlYqX1K++q8bKPSr+MxRV5v+POcc3GEFHfY5L5IKDEmE00RxU=
X-Received: by 2002:ac8:4a01:: with SMTP id x1mr2634596qtq.304.1570001477755;
 Wed, 02 Oct 2019 00:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <8736gcjosv.fsf@x220.int.ebiederm.org> <201910011140.EA0181F13@keescook>
 <87imp8hyc8.fsf@x220.int.ebiederm.org>
In-Reply-To: <87imp8hyc8.fsf@x220.int.ebiederm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 09:31:01 +0200
Message-ID: <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Apelete Seketeli <apelete@seketeli.net>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>, Helge Deller <deller@gmx.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Vineet Gupta <vgupta@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 2, 2019 at 12:54 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Kees Cook <keescook@chromium.org> writes:
> > On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
> >
> > I think you can actually take this further and remove (or at least
> > empty) the uapi/linux/sysctl.h file too.
>
> I copied everyone who had put this into a defconfig and I will wait a
> little more to see if anyone screams.  I think it is a safe guess that
> several of the affected configurations are dead (or at least
> unmaintained) as I received 17 bounces when copying everyone.

Looking at the arm defconfigs:

> arch/arm/configs/axm55xx_defconfig:CONFIG_SYSCTL_SYSCALL=y

No notable work on this platform since it got sold to Intel in 2014.
I think they still use it but not with mainline kernels that lack support
for most drivers and the later chips.

> arch/arm/configs/keystone_defconfig:CONFIG_SYSCTL_SYSCALL=y

Not that old either, but this hardware is mostly obsoleted by newer variants
that we support with the arm64 defconfig.

> arch/arm/configs/lpc32xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
> arch/arm/configs/moxart_defconfig:CONFIG_SYSCTL_SYSCALL=y

Ancient hardware, but still in active use. These tend to have very little
RAM, but they both enable CONFIG_PROC_FS.

> arch/arm/configs/qcom_defconfig:CONFIG_SYSCTL_SYSCALL=y
> arch/arm/configs/zx_defconfig:CONFIG_SYSCTL_SYSCALL=y

These are for older Qualcomm and LG chips that tend to be used
with Android rather than the defconfig here. Maybe double-check
if the official android-common tree enables SYSCTL_SYSCALL.

      Arnd
