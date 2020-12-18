Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4A2DE4F9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 15:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgLROfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 09:35:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLROfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 09:35:09 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2wCi-1kmxPC1v92-003Pjz; Fri, 18 Dec 2020 15:31:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, msalter@redhat.com, jacquiot.aurelien@gmail.com,
        gerg@linux-m68k.org, geert@linux-m68k.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        maz@kernel.org, tony@atomide.com, arnd@arndb.de,
        linux-alpha@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: cleanup handling of bad IRQs
Date:   Fri, 18 Dec 2020 15:30:59 +0100
Message-Id: <20201218143122.19459-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:GCc9gbsI9eyOCfdNmRX4o9bXX1pOCTy0AyznDchDYs0oM1Puh0V
 HaUshqI/aGp8nZ32pIa3W6umlwkDU/2qcylknjRG07xPj3Phd4Hi7sPh0w6jCYT7br8wP9r
 fsQ6guhbrEZJsPZNI8LuMeU1nvpg4pLhQC4hxQMx4DspP5teK6wAXTnJgWzY/Mk0t7irqLX
 kur37BKvbPWU7xvonpMrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/sbNIRVafqs=:7E0S8ysTyADzbE8lkSM6eP
 3TWEq16dIlocEj3ixPEv4zX+3uTZPLFNfZxuuLVDe5vQethUoPCGbLrF+TJzqQS6i9ZiPDOWV
 +MEyUwQsMabb9a7q9A0f4yZPbmnRvOUDPtXYvFQYiaQf8++meO3+CL9+AQCaHZpZU5Lu4zk3h
 DHvOcIL0N3IkgsS8EOQdWctpP0notp1p3/QtKqWrA0uwnQO8udkYh4oSleqescXu70z7m0miq
 aQx+1M87gYUAFYOUnCysSU1ZhyZRm3NivHaA+X1Bi0lbdEx0v1kCrv+PamjVlz+r4tOy1m2VO
 7GBJGicMrEiBxqRit0qr0sJg1PjhIfT/u0Up/KxPuvMs/TGlnv05ySaqY98K0u1+80NKHB60f
 iftFYU5etid5UzRqKbNb+YFzN9b3C5t5lHQzh4h/GALhKjmHZEoAm9bm1bb//
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello friends,


here's a patch queue for cleaning up the IRQ handling. Inspired by a
discussion we had on a previous patch of mine:

    "arch: fix 'unexpected IRQ trap at vector' warnings"
    https://www.spinics.net/lists/kernel/msg3763137.html

Turned out that the whole message, as it is right now, doesn't make much
sense at at all - not just incorrect wording, but also not quite useful
information. And the whole ack_bad_irq() thing deserves a cleanup anyways.

So, I've had a closer look and came to these conclusions:

1. The warning message doesn't need to be duplicated in the per architecture
   ack_bad_irq() functions. All, but one callers already do their own warning.
   Thus just adding a pr_warn() call there, printing out more useful data
   like the hardware IRQ number, and dropping all warnings from all the
   ack_bad_irq() functions.

2. Many of the ack_bad_irq()'s count up the spurious interrupts - lots of
   duplications over the various archs. Some of them using atomic_t, some
   just plain ints. Consolidating this by introducing a global counter
   with inline'd accessors and doing the upcounting in the (currently 3)
   call sites of ack_bad_irq(). After that, step by step changing all
   archs to use the new counter.

3. For all but one arch (x86), ack_bad_irq() became a no-op.

   On x86, it's just a call to ack_APIC_irq(), in order to prevent lockups
   when IRQs missed to be ack'ed on the APIC. Could we perhaps do this in
   some better place ? In that case, ack_bad_irq() could easily be removed
   entirely.

have fun,

--mtx


