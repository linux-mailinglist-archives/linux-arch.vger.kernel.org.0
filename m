Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E034C112CEE
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfLDNwD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 08:52:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40695 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbfLDNwD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 08:52:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so3416643pgt.7;
        Wed, 04 Dec 2019 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TbJ9lT2HAjMyDE1SH6CunT8N4kMbxtVJWep3/Ofx1Bc=;
        b=iQxO6lcpt1bJ5gN8Y4kXPU0dr1c6ATyxgAG3EI+vfRJjoJwHwrwXLUiEJaKIQTeWiJ
         F3UYh0AiufKF1rKIvNQHINl9+iu83Ghb6/HciDylFzE+lqA/Y05uht95p5Ml9dMsmiBW
         LmVhvC1WqxEHyDikQtRY5aa/DLzmEzUGP3WajcYRhfSuSWiCmhqQJofWgjUUxhimvZSn
         izg4tZ21p1IIh8YQpHrKl/rgkij20CilbOG/R4QdRrqb9CPVgj9rh5hJ4dp5NTjNgINr
         9RXoUsxYqHRo0g6+BYKJsFgzQZChPUtfJBJ/0BM1AuCvPjydaTIWFhouEQ4evipa6UdD
         kFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TbJ9lT2HAjMyDE1SH6CunT8N4kMbxtVJWep3/Ofx1Bc=;
        b=r7oMuwDiRF9yLKrjGYMVAtufKB9fGrXyRdy3j0pNtD8W4lo6KjIgTucYuxMsvOFike
         4gc6Y+FoNEYGWt+tZR8VtHPD/J6yRY4T+AmLwph9XhPCvNoyiWrcPnNHSjZBFZ8BRPbC
         GYnQeVTqIkZdis7RCbb0fkHorqwcabyKe43aG/pQs5C2oPokkudnidh+DqNsap115iTo
         Gz8GZ14MqdHlt38tV9qFlQE89CCrK67qWkeyfv9oi6Atuhk/AEZ/maT8SVvrswmStpAC
         FsMlF3y/rzdgDvEZGbhLdFht7lCZTJTjEjWpkfJViJU2ijROFXaOBF5pRv9P11uzLUGh
         OVNg==
X-Gm-Message-State: APjAAAWvTA6murU0RSYSEoe0RCkAwwbU6pxqKmc0K1q3wxlKEnZgy0n5
        A1DsmCF5yZJl0F7rKfXxoRI=
X-Google-Smtp-Source: APXvYqyoPrSep/q/DUOv+zINoePEiuZB7UyBS8bmOBLu+0j65jHVO2r6iBhfr9RUckMGjFizXhOFLg==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr3327547pgc.401.1575467521937;
        Wed, 04 Dec 2019 05:52:01 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id in19sm6642985pjb.11.2019.12.04.05.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 05:52:01 -0800 (PST)
Date:   Wed, 4 Dec 2019 05:51:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
Message-ID: <20191204135159.GA7210@roeck-us.net>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-17-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
> The arm vDSO library requires some adaptations to use to take advantage
> of the newly introduced generic vDSO library.
> 
> Introduce the following changes:
>  - Modification vdso.c to be compliant with the common vdso datapage
>  - Use of lib/vdso for gettimeofday
>  - Implementation of elf note
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This patch causes a crash with qemu's mcimx6ul-evk emulation while running
imx_v6_v7_defconfig.

[   19.976852] Run /sbin/init as init process
[   20.044931] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

There is nothing else useful in the log, unfortunately.

Reverting the following three patches fixes the problem.

74d06efb9c2f ARM: 8932/1: Add clock_gettime64 entry point
052e76a31b4a ARM: 8931/1: Add clock_getres entry point
20e2fc42312f ARM: 8930/1: Add support for generic vDSO

Guenter
