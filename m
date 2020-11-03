Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BED2A4DF2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 19:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgKCSMD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 13:12:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43091 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgKCSMD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 13:12:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id d24so20042075ljg.10;
        Tue, 03 Nov 2020 10:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSiaQEI9iuJw/ssLHdIHxMndxMzRbBZZ0KM7RNAHM3c=;
        b=FFpg8mWkGUnK/90t52YnhCnTMqW/WYUiQag/ZogS7jI/8BlCEVVJFvDDiOnYR6EzYn
         HTDb8YN/RsQPZ+nx4OSyQxNhnciYa1M0RtbD8ZmvvWOkWb04FShDwgoC5+4wNpHnBSoE
         tOa7W5bN44itPl0q0ZkbY+Hy4gy3rpl5w5LCw1mHFtOIFSbAq6mg9nRe0J4pJ8F3oPtx
         z4tMygMciwr5G+uoin/ys1e4xNovWxLxEhNN8jv8QREByntuIuZmNC1iSbeuNfJrMUt4
         hC0zf/jUZZopUkgcy+mbZn0ntVvYyBXoEisHcDoe9snAItIblD3pk7qhDBTZNTKyrARz
         NDAA==
X-Gm-Message-State: AOAM532IgSGPsZLkHfCpVpBsfeViuvRXgzlneIFRe5l5vu/BAUb8vs9i
        iSUHyJo60LHbO1yZBCHApVUovmSctA56wQ==
X-Google-Smtp-Source: ABdhPJw5lAvIVcM9GD7by5r20/82PI4VcL2xyGYr4rIWJlRWES8SN1jHlox+kEdXE4w8ELMP3o/vuw==
X-Received: by 2002:a05:651c:105b:: with SMTP id x27mr9266604ljm.302.1604427120315;
        Tue, 03 Nov 2020 10:12:00 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t10sm4092988lfc.258.2020.11.03.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:11:59 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1ka0mm-0002rM-Pj; Tue, 03 Nov 2020 19:12:01 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/8] linker-section array fix and clean ups
Date:   Tue,  3 Nov 2020 18:57:03 +0100
Message-Id: <20201103175711.10731-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We rely on the linker to create arrays for a number of things including
kernel parameters and device-tree-match entries.

The stride of these linker-section arrays obviously needs to match the
expectations of the code accessing them or bad things will happen.

One thing to watch out for is that gcc is known to increase the
alignment of larger objects with static extent as an optimisation (on
x86), but this can be suppressed by using the aligned attribute when
declaring entries.

We've been relying on this behaviour for 16 years for kernel parameters
(and other structures) and it indeed hasn't changed since the
introduction of the aligned attribute in gcc 3.1 (see align_variable()
in [1]).

Occasionally this gcc optimisation do cause problems which have instead
been worked around in various creative ways including using indirection
through an array of pointers. This was originally done for tracepoints
[2] after a number of failed attempts to create properly aligned arrays,
and the approach was later reused for module-version attributes [3] and
earlycon entries.

This series reverts the latter two workarounds in favour of the one-line
fix of aligning the entries according to the requirement of the type.

In principle, there shouldn't be anything preventing us from doing the
same for tracepoints.

The key observation here is that the arrays should be constructed using
the alignment of the type in question (as given by __alignof__()) rather
than some specific alignment such as sizeof(void *). This allows the
structures to be stored efficiently, but more importantly prevents
breakage on architectures like m68k where pointers are 2-byte aligned
should the size or alignment of the type change (e.g. so that the size
is no longer divisible by four).

As a preventive measure in case the kernel-parameter structures are ever
amended (or the code pattern is reused elsewhere), the final patches
switches the parameter declarations to also use type alignment.

The series has been tested using gcc 4.9 and 9.3 on x86_32 and
x86_64 and using gcc 7.2 on arm; and has been compile-tested and
verified using gcc 4.9 and 10.1 on aarch64, sparc and m68k.

Note that the patches are mostly independent and can be merged through
different subsystem trees. I decided to post them as a series to provide
a common background and have a single thread for any general discussion.

Johan

[1] https://github.com/gcc-mirror/gcc/blob/master/gcc/varasm.c
[2] https://lore.kernel.org/lkml/20110126222622.GA10794@Krystal/ 
[3] https://lore.kernel.org/lkml/1297123347-2170-1-git-send-email-dtor@vmware.com/


Johan Hovold (8):
  of: fix linker-section match-table corruption
  earlycon: simplify earlycon-table implementation
  module: drop version-attribute alignment
  module: simplify version-attribute handling
  init: use type alignment for kernel parameters
  params: drop redundant "unused" attributes
  params: use type alignment for kernel parameters
  params: clean up module-param macros

 drivers/of/fdt.c              |  7 ++-----
 drivers/tty/serial/earlycon.c |  6 ++----
 include/linux/init.h          |  2 +-
 include/linux/module.h        | 28 ++++++++++++++--------------
 include/linux/moduleparam.h   | 12 ++++++------
 include/linux/of.h            |  1 +
 include/linux/serial_core.h   | 20 +++++++-------------
 kernel/params.c               | 10 ++++------
 8 files changed, 37 insertions(+), 49 deletions(-)

-- 
2.26.2

