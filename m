Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610872DE60B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Dec 2020 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLRPBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Dec 2020 10:01:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLRPBP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Dec 2020 10:01:15 -0500
Received: from orion.localdomain ([95.115.54.243]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5FtF-1k7Hmp0Rxl-0118Hm; Fri, 18 Dec 2020 15:58:02 +0100
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
Subject: (repost) cleaning up handling of bad IRQs
Date:   Fri, 18 Dec 2020 15:57:23 +0100
Message-Id: <20201218145746.24205-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:kDy23KicY6yANCRUU/uS27W+PiA6W2GQEJc1w+ZgwWxEjEL6wp+
 O8q9sjFQjB+V0eXbRSVHReMrDSfLKWhKYaglZe/mGoKnGo+tKe78BIINCtGjVGRkQlVCPRT
 E0zs050IDCFNASTif7ntcdtcNCuqqIz4boa/lWXOWWv6+2VsptoinSFPTn2gbyoldCF3WLk
 LPxaYtQibJh05k9ukhkIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqNj1TBcidE=:gp0GmOgW/MpqQGs+zxKh6i
 I0088aGoSzOIfC95i/SEDZNYBUDmgwLa8n4SXmJkOmu/GGWNmsBGg/Xf8yNQt9k/hZG1GWXPN
 xEBtNhEWsGOydmRhKc+SGqkOJt1MGEphhCucm67oCLQxZfaAVCyV1LE8fm4EHrJROazGyYjEq
 lH16F/3XvcljV+pCYiqIoRjM6+oypx0etdtwnLgAZmNyA9S6WTF37Yqa3INS1S7FwBDy3Kbkw
 IcBnm6E0VHQ4OPHXxABvAk2oIndJOeCt+tf9gc9//r1GcOSb4BYRCbTjQKkvol7Zx++hrz8D9
 ayJibSTe5nhuLcL+SN4HlKtWfuz6RmVjv6c/fDlR3j/qL/eB03XvQh9FCZg3jiwKfX5w6bpnL
 fTy0MG7FyqXlq0+laGULoIs9JiSUAXz4NDEYbZiUPQeKZN9i2edp69JRiVoBK
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello friends,

 << reposting, since first queue didn't go through completely, due to mailer problem >>

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



