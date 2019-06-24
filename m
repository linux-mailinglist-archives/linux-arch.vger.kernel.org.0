Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5550B1E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 14:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFXMvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 08:51:02 -0400
Received: from foss.arm.com ([217.140.110.172]:49274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfFXMvC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 08:51:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20E7344;
        Mon, 24 Jun 2019 05:51:00 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EDFB3F718;
        Mon, 24 Jun 2019 05:50:58 -0700 (PDT)
Date:   Mon, 24 Jun 2019 13:50:55 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
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
        Shijith Thotton <sthotton@marvell.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Message-ID: <20190624135055.7020fc2a@donnerap.cambridge.arm.com>
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 Jun 2019 10:52:27 +0100
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

Hi,

> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
[ ... ]

Some numbers for the ARM(32) part:

I booted my trusted old Calxeda Midway server (Cortex A-15 cores) and ran
the vdsotest benchmark on it. The results are:
(vdso: times, in nsec/call; n/t: "not tested" (=not implemented))
call				5.2-rc3	5.2-rc3-vdso
clock-gettime-monotonic:        147     142
clock-getres-monotonic:         n/t     34
clock-gettime-monotonic-coarse: 90      96
clock-getres-monotonic-coarse:  n/t     36
clock-gettime-monotonic-raw:    431     142
clock-getres-monotonic-raw:     n/t     35
clock-gettime-tai:              598     150
clock-getres-tai:               n/t     34
clock-gettime-boottime:         592     142
clock-getres-boottime:          n/t     34
clock-gettime-realtime:         149     142
clock-getres-realtime:          n/t     34
clock-gettime-realtime-coarse:  86      96
clock-getres-realtime-coarse:   n/t     36
getcpu:                         n/t     n/t
gettimeofday:                   133     110

So there are some minor improvements, two minor regressions, some
significant improvements (factor 3-4), and some dramatic improvements
(where we actually gained VDSO support).
Overall a pretty impressive outcome for an "Odd fixes" architecture,
especially as it should reduce the future maintenance burden.

Cheers,
Andre.
