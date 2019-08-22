Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB898BDA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Aug 2019 08:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbfHVG6I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Aug 2019 02:58:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39366 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbfHVG6H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Aug 2019 02:58:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id i63so4558217wmg.4;
        Wed, 21 Aug 2019 23:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=UJ4ndSsA+KlZA68sHmztUkQhSgbwuP+daP+r2iy3R+s=;
        b=pByGk2q+MG5FW6nVQKR+qe001OsoEpiE8351tEsN5n5vhzG87uX2naEiS724FQsYOz
         iFL0qPyNEqFmWLzVAgajKk5nDtdFngTAmw6N8fCCzJjyyObJgf/pgG5i2bkm6srgV+XE
         peddH9hmaBB/1inqGbNZjYtKPdfEjx8D/I0nuB7mCbOtuilQenWeu/KeL/rKUFZAqeax
         DCFeD2GjUrHbQDKM6Wkz5/N3/JdfLG6G5BaEYCJlCbH/eELiUhUNE3hUiyDHgHALuShP
         TSBL97HD87Te8LoI2/A30FVdK1m5y/TEOKVBBRjjHb4DI/a2dKkne9kCuxjk86w+v6GO
         D8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=UJ4ndSsA+KlZA68sHmztUkQhSgbwuP+daP+r2iy3R+s=;
        b=GJ/mdLa7sHXcq2bxN9WoyuFv9ORAKSLXb0Ggwbhu0oVcYvIxp28r3mJ6y2m+k06T5p
         eUUioVWuKF1U+X1LI4s1psRG1ls2B12F9kd2LNHHzN4caGhJ5wkHB+KvMtRsLVXLllpp
         EgKzfS/TdOTXirPaBOdRKjZfoS0zpq9AD1QS3sgSiVjs0Tw8x9UV6G8k+uA/n+O+Icux
         mtdu4z93trbfVkB03gNVZq906Zly9ziCrdHy4Jx0H1t1SeR2IzSsAhzlIYFH178r+xVK
         +usTJnOjx/EWXFlQTgVr2joQ4heTRPKKuw2gaWHm7oe2H3zAqYMT1C/2PAX3ge0VbMnv
         8hrQ==
X-Gm-Message-State: APjAAAWkf0Njl6OlDYPljL6IvUlmeJO6TEa+2cihwMuSQKnalAMJvXXY
        kS8muCGpPyYPGmHbmPfFSMw=
X-Google-Smtp-Source: APXvYqzupd9YcGew+aYy624JEYO24Qz27ePGljeVffqKjx18vl4v7RPF48u41M7JoXWxNvfSmBdrHw==
X-Received: by 2002:a1c:c5c2:: with SMTP id v185mr4553483wmf.161.1566457083649;
        Wed, 21 Aug 2019 23:58:03 -0700 (PDT)
Received: from [192.168.1.20] (host109-153-59-46.range109-153.btcentralplus.com. [109.153.59.46])
        by smtp.googlemail.com with ESMTPSA id j20sm56299931wre.65.2019.08.21.23.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 23:58:02 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     vincenzo.frascino@arm.com, tglx@linutronix.de,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, salyzyn@android.com, pcc@google.com,
        shuah@kernel.org, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk,
        huw@codeweavers.com, sthotton@marvell.com, andre.przywara@arm.com
From:   Chris Clayton <chris2553@googlemail.com>
Subject: Regression in 5.3-rc1 and later
Message-ID: <faaa3843-09a6-1a21-3448-072eeed1ea00@googlemail.com>
Date:   Thu, 22 Aug 2019 07:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi everyone,

Firstly, apologies to anyone on the long cc list that turns out not to be particularly interested in the following, but
you were all marked as cc'd in the commit message below.

I've found a problem that isn't present in 5.2 series or 4.19 series kernels, and seems to have arrived in 5.3-rc1. The
problem is that if I suspend (to ram) my laptop, on resume 14 minutes or more after suspending, I have no networking
functionality. If I resume the laptop after 13 minutes or less, networking works fine. I haven't tried to get finer
grained timings between 13 and 14 minutes, but can do if it would help.

ifconfig shows that wlan0 is still up and still has its assigned ip address but, for instance, a ping of any other
device on my network, fails as does pinging, say, kernel.org. I've tried "downing" the network with (/sbin/ifdown) and
unloading the iwlmvm module and then reloading the module and "upping" (/sbin/ifup) the network, but my network is still
unusable. I should add that the problem also manifests if I hibernate the laptop, although my testing of this has been
minimal. I can do more if required.

As I say, the problem first appears in 5.3-rc1, so I've bisected between 5.2.0 and 5.3-rc1 and that concluded with:

[chris:~/kernel/linux]$ git bisect good
7ac8707479886c75f353bfb6a8273f423cfccb23 is the first bad commit
commit 7ac8707479886c75f353bfb6a8273f423cfccb23
Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date:   Fri Jun 21 10:52:49 2019 +0100

    x86/vdso: Switch to generic vDSO implementation

    The x86 vDSO library requires some adaptations to take advantage of the
    newly introduced generic vDSO library.

    Introduce the following changes:
     - Modification of vdso.c to be compliant with the common vdso datapage
     - Use of lib/vdso for gettimeofday

    [ tglx: Massaged changelog and cleaned up the function signature formatting ]

    Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-arch@vger.kernel.org
    Cc: linux-arm-kernel@lists.infradead.org
    Cc: linux-mips@vger.kernel.org
    Cc: linux-kselftest@vger.kernel.org
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Russell King <linux@armlinux.org.uk>
    Cc: Ralf Baechle <ralf@linux-mips.org>
    Cc: Paul Burton <paul.burton@mips.com>
    Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
    Cc: Mark Salyzyn <salyzyn@android.com>
    Cc: Peter Collingbourne <pcc@google.com>
    Cc: Shuah Khan <shuah@kernel.org>
    Cc: Dmitry Safonov <0x7f454c46@gmail.com>
    Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
    Cc: Huw Davies <huw@codeweavers.com>
    Cc: Shijith Thotton <sthotton@marvell.com>
    Cc: Andre Przywara <andre.przywara@arm.com>
    Link: https://lkml.kernel.org/r/20190621095252.32307-23-vincenzo.frascino@arm.com

 arch/x86/Kconfig                         |   3 +
 arch/x86/entry/vdso/Makefile             |   9 ++
 arch/x86/entry/vdso/vclock_gettime.c     | 245 ++++---------------------------
 arch/x86/entry/vdso/vdsox32.lds.S        |   1 +
 arch/x86/entry/vsyscall/Makefile         |   2 -
 arch/x86/entry/vsyscall/vsyscall_gtod.c  |  83 -----------
 arch/x86/include/asm/pvclock.h           |   2 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 191 ++++++++++++++++++++++++
 arch/x86/include/asm/vdso/vsyscall.h     |  44 ++++++
 arch/x86/include/asm/vgtod.h             |  75 +---------
 arch/x86/include/asm/vvar.h              |   7 +-
 arch/x86/kernel/pvclock.c                |   1 +
 12 files changed, 284 insertions(+), 379 deletions(-)
 delete mode 100644 arch/x86/entry/vsyscall/vsyscall_gtod.c
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/x86/include/asm/vdso/vsyscall.h

To confirm my bisection was correct, I did a git checkout of 7ac8707479886c75f353bfb6a8273f423cfccb2. As expected, the
kernel exhibited the problem I've described. However, a kernel built at the immediately preceding (parent?) commit
(bfe801ebe84f42b4666d3f0adde90f504d56e35b) has a working network after a (>= 14minute) suspend/resume cycle.

As the module name implies, I'm using wireless networking. The hardware is detected as "Intel(R) Wireless-AC 9260
160MHz, REV=0x324" by iwlwifi.

I'm more than happy to provide additional diagnostics (but may need a little hand-holding) and to apply diagnostic or
fix patches, but please cc me on any reply as I'm not subscribed to any of the kernel-related mailing lists.

Chris
