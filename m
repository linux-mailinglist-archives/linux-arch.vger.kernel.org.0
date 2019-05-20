Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDE229B5
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 03:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfETB31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 May 2019 21:29:27 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:22374 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbfETB31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 May 2019 21:29:27 -0400
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 May 2019 21:29:26 EDT
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id x4K1GmAg045473;
        Mon, 20 May 2019 09:16:48 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x4K1GZ9r045438;
        Mon, 20 May 2019 09:16:35 +0800 (GMT-8)
        (envelope-from vincentc@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 20 May 2019
 09:21:18 +0800
From:   Vincent Chen <vincentc@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <linux-arch@vger.kernel.org>, <greentime@andestech.com>,
        <green.hu@gmail.com>, <deanbo422@gmail.com>
CC:     <vincentc@andestech.com>
Subject: [PATCH 0/2] nds32: Prevent FPU emulator from incorrectly modifying IEX status
Date:   Mon, 20 May 2019 09:21:11 +0800
Message-ID: <1558315273-2795-1-git-send-email-vincentc@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x4K1GZ9r045438
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

  In order for kernel to capture each denormalized output, the UDF
trapping enable bit is always raised in $fpcsr. Because underflow case will
issue not an underflow exception but also an inexact exception, it causes
that the IEX, IEX cumulative exception, flag in $fpcsr to be raised in each
denormalized output handling. To make the emulation transparent to the
user, the emulator needs to clear the IEX flag in $fpcsr if the result is a
denormalized number. However, if the IEX flag has been raised before this
floating point emulation, this cleanup may be incorrect. To avoid the IEX
flags in $fpcsr be raised in each denormalized output handling, the 1st
patch always enable IEX trap to fix this issue.

    The existing floating point emulations is only available for floating
instruction that possibly issue denormalized input and underflow
exceptions. These existing FPU emulations are not sufficient when IEx
Trap is enabled because some floating point instructions only issue inexact
exception. The 2nd patch adds the emulations of such floating point
instructions.

Vincent Chen (2):
  nds32: enable IEX trap too when kernel supports denormalized output
  nds32: add new emulations for floating point instruction

 arch/nds32/include/asm/bitfield.h            |    2 +-
 arch/nds32/include/asm/fpu.h                 |    2 +-
 arch/nds32/include/asm/fpuemu.h              |   12 +++++
 arch/nds32/include/asm/syscalls.h            |    2 +-
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h |   16 +++++++
 arch/nds32/include/uapi/asm/sigcontext.h     |   24 ++++++++---
 arch/nds32/include/uapi/asm/udftrap.h        |   13 ------
 arch/nds32/include/uapi/asm/unistd.h         |    4 +-
 arch/nds32/kernel/fpu.c                      |   15 +++----
 arch/nds32/kernel/sys_nds32.c                |   26 ++++++-----
 arch/nds32/math-emu/Makefile                 |    5 ++-
 arch/nds32/math-emu/fd2si.c                  |   30 +++++++++++++
 arch/nds32/math-emu/fd2siz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fd2ui.c                  |   30 +++++++++++++
 arch/nds32/math-emu/fd2uiz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fpuemu.c                 |   57 ++++++++++++++++++++++++--
 arch/nds32/math-emu/fs2si.c                  |   29 +++++++++++++
 arch/nds32/math-emu/fs2siz.c                 |   29 +++++++++++++
 arch/nds32/math-emu/fs2ui.c                  |   29 +++++++++++++
 arch/nds32/math-emu/fs2uiz.c                 |   30 +++++++++++++
 arch/nds32/math-emu/fsi2d.c                  |   22 ++++++++++
 arch/nds32/math-emu/fsi2s.c                  |   22 ++++++++++
 arch/nds32/math-emu/fui2d.c                  |   22 ++++++++++
 arch/nds32/math-emu/fui2s.c                  |   22 ++++++++++
 24 files changed, 452 insertions(+), 51 deletions(-)
 create mode 100644 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
 delete mode 100644 arch/nds32/include/uapi/asm/udftrap.h
 create mode 100644 arch/nds32/math-emu/fd2si.c
 create mode 100644 arch/nds32/math-emu/fd2siz.c
 create mode 100644 arch/nds32/math-emu/fd2ui.c
 create mode 100644 arch/nds32/math-emu/fd2uiz.c
 create mode 100644 arch/nds32/math-emu/fs2si.c
 create mode 100644 arch/nds32/math-emu/fs2siz.c
 create mode 100644 arch/nds32/math-emu/fs2ui.c
 create mode 100644 arch/nds32/math-emu/fs2uiz.c
 create mode 100644 arch/nds32/math-emu/fsi2d.c
 create mode 100644 arch/nds32/math-emu/fsi2s.c
 create mode 100644 arch/nds32/math-emu/fui2d.c
 create mode 100644 arch/nds32/math-emu/fui2s.c

