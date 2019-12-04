Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF6112FCA
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 17:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfLDQQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 11:16:46 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38647 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfLDQQq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 11:16:46 -0500
Received: by mail-pj1-f68.google.com with SMTP id l4so20659pjt.5;
        Wed, 04 Dec 2019 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqU4igCndeG4UoCDSucNu4GwL3x2y+vfWi/Ebs1wzZc=;
        b=J6wW9rQZNctPpcpaRobDFMExB93/ZEkzhTam2T23ewBpNq8vpq3su7cM3xksiLZRNj
         VWPwta8xYcL1/FVMAdHrrQqm0c6LIyIsxgxue6Nal0v0DU7ls9RPDkIGRGiUemkCZKbz
         42pJxBUytOxLa7bu52MpYJG4PcBntgRTHizCN1Yh/q1pnqXc3Uqc2I+E/MoFiC7fxL5k
         wFc3uc1nXh85UFVB2mLGjIjtD49oKFf/fDu/OREA03+FCqWDtXvfnkLlcT93j4BX7+rC
         hAV9eg9itNtdgLH1AOehHAfFNPjXTPeR9v8kLgmX3SQ0aTeAkM/nMKIeKGQ8GydaR7cm
         lu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqU4igCndeG4UoCDSucNu4GwL3x2y+vfWi/Ebs1wzZc=;
        b=Q+QHix0XoJSnVn8FahV+Jq82pMk0i1pRPv8+0rHqG6Ow5vCqFlCEBzUvx+oeAMyoef
         bUa+cvPxga0d04543WrXXh5HAZM9IcuocNIANKooxc/hpIQPnr1xIHfL1cDWTY+l5I5o
         hWlE0heWCUYoLMTO5L1ZJeqxqeen4feoARcx1gTEAC+1BQbmkF3DQTY6cLF0Pap3SOOT
         bhzcCrGiUAhzU0VG7d+k8mhtCjwaA8z4BzPphC9uKJpWKX/FAWA7/TDSW4nY+w2/jNp+
         Da3hB6e9XvlQZf6HuieZiWTwQ/ItnO0idb0yhY4WIK9NVG3A7dgWuar6ztODG0dpxyXe
         Yq2Q==
X-Gm-Message-State: APjAAAVMa6toSII94401IJUWWcoQBub29ptCtHGElbGrUc+w7h9s3Pzq
        kojSSVuizCpR9s/y+DKAbVRsgnjx
X-Google-Smtp-Source: APXvYqwdytT3wxqOWmWAUSezJYS9o3F9w3oCV/vG1Nqu53f+3nOnX41jUHMdU6TBi2uG6y1+LpWSnw==
X-Received: by 2002:a17:90b:3011:: with SMTP id hg17mr4116854pjb.90.1575476205426;
        Wed, 04 Dec 2019 08:16:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x186sm8346024pfx.105.2019.12.04.08.16.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 08:16:43 -0800 (PST)
Date:   Wed, 4 Dec 2019 08:16:41 -0800
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
Message-ID: <20191204161641.GA28130@roeck-us.net>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
 <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 04, 2019 at 01:58:25PM +0000, Vincenzo Frascino wrote:
> Hi Guenter,
> 
> On 12/4/19 1:51 PM, Guenter Roeck wrote:
> > On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
> >> The arm vDSO library requires some adaptations to use to take advantage
> >> of the newly introduced generic vDSO library.
> >>
> >> Introduce the following changes:
> >>  - Modification vdso.c to be compliant with the common vdso datapage
> >>  - Use of lib/vdso for gettimeofday
> >>  - Implementation of elf note
> >>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > 
> > This patch causes a crash with qemu's mcimx6ul-evk emulation while running
> > imx_v6_v7_defconfig.
> > 
> 
> Thank you for reporting this. Could you please provide some details on how I can
> reproduce the scenario you are describing?
> 
- Build imx_v6_v7_defconfig
- Get root file system or initrd, for example from
  https://github.com/groeck/linux-build-test/tree/master/rootfs/arm
- Run image. Example, with initrd:
	qemu-system-arm -M mcimx6ul-evk -kernel arch/arm/boot/zImage \
		-no-reboot -initrd rootfs-armv7a.cpio \
		-m 256 -display none -serial null \
		--append 'rdinit=/sbin/init earlycon=ec_imx6q,mmio,0x21e8000,115200n8 console=ttymxc1,115200'
		-dtb arch/arm/boot/dts/imx6ul-14x14-evk.dtb \
		-nographic -monitor null -serial stdio

qemu has to be v3.1 or later to support the machine.

Hope this helps,
Guenter
