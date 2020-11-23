Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AC2C032F
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 11:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgKWKY4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 05:24:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33321 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKWKY4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 05:24:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id l11so23067158lfg.0;
        Mon, 23 Nov 2020 02:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJ6wjUN2TIaDvQSFiNF8yFtuiC0XjrcvQ2ERq/2mDa8=;
        b=b+XHjsjdpS7vic1f5iVO4IBL0jaCPmoqsKzQo2pB9wQVoJUfJ4fS4M34z0C9cw2681
         vlwWN0C4HqR2ik6ySCQ75lDOgyrpksgLKeThTe2HDv6feJz0RCwSSXxjowXIlHECZeFJ
         sMDI2BL35h8WiqXIz6UFEcQ+s/zn+twEbkrDF/jFVUMgK3zFSRua+f+MW0txkq5zsp5M
         x6l725bPi02d01UAmspPl/7A/DemRXnzi36Uc6Efn3nsK9u0S0i5mJQyMnCnNSRCz9ut
         RSdVwhCji3wI1u4qXYByBkz5Yw1vLCpcFi5WsiDSGIWxkLxZtqCiMpJcMgIzNaSeZNvW
         HYWA==
X-Gm-Message-State: AOAM532kWYW7L41ewPR8/YAYSGjx9cT2zWy9vIV5S7ER/nvfkV0E3RsO
        yi1IAdSImSXq/3SYrEqv39I=
X-Google-Smtp-Source: ABdhPJwlcEwlwHUKntwIlPFK3ymO9gKPmqpgJPUb1PXcjA1ZAsTHaI4/f8uE99LHcpa0nQU7xN6pDg==
X-Received: by 2002:a19:17:: with SMTP id 23mr2896593lfa.389.1606127093543;
        Mon, 23 Nov 2020 02:24:53 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id j4sm1331431lfk.275.2020.11.23.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:24:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@xi.terra>)
        id 1kh91p-00027i-AC; Mon, 23 Nov 2020 11:25:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
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
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/8] linker-section array fix and clean ups
Date:   Mon, 23 Nov 2020 11:23:11 +0100
Message-Id: <20201123102319.8090-1-johan@kernel.org>
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

Rob and Greg, can you take patches 1 and 2 through your trees,
respectively?

Jessica, you said you could take the module and params patches through
your tree?

Who picks up the init.h one? Linus?

Johan

[1] https://github.com/gcc-mirror/gcc/blob/master/gcc/varasm.c
[2] https://lore.kernel.org/lkml/20110126222622.GA10794@Krystal/
[3] https://lore.kernel.org/lkml/1297123347-2170-1-git-send-email-dtor@vmware.com/


Changes in v2
 - amend commit messages of patches 1, 2, 4, 5 and 7 slightly in order
   to make it more clear that the gcc optimisation is suppressed by
   specifying alignment when declaring variables

v1
 - https://lore.kernel.org/r/20201103175711.10731-1-johan@kernel.org


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

