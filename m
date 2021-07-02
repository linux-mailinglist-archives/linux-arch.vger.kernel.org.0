Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD2E3BA066
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jul 2021 14:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhGBMee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Jul 2021 08:34:34 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:37536 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhGBMee (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 08:34:34 -0400
Received: by mail-ej1-f50.google.com with SMTP id i20so15538120ejw.4;
        Fri, 02 Jul 2021 05:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kxCwLjDiZox2uq7lbOwELumWKVYmpQy6VlL3NaLiI8=;
        b=es4A7xBblfIDQVXpsPqMEIC2hgvglZoRFx5M4+ILyFEPA5FxXQ3nZDplXTlWla75sc
         3QfMRSZYQ8PMl7/ArNqBk9KLp6HL7nRrJHPxJvO1sAlfpkg0JwyLPvkdz8Iua5xSnXB1
         3jd21scg+Gxi2dgP0s/7I3dytW8SpJRnZ3jaSt07tPc8L/ZUSzKAKq1eb4A88L90jtQI
         UaCRCyhFBiadYATAvAt9vv89xjTin7XUWMzOdFf89f4zoa5zuFYTh6gzaYZ65E6PJlKw
         SWxTeqF1nFpOyKMBcxOG9LKALOqaCUUOCj5GOD1ONWr9qQ+UpwcsPuuJ43Ypr0Px3rAW
         B4TQ==
X-Gm-Message-State: AOAM532helMhXGopduS0s23os28N5OHxu+j5FowZPieq9oiMP7lapCC9
        qJar/YQfPsy7uWB7YBqkLiUrD9AR2qj0Ug==
X-Google-Smtp-Source: ABdhPJwp+TxUnuAhBmoh5g26KXPKy156z5RfynaIIigiBUmM5ov3S56JthwVXNRlRsSXFm3cdpoXUg==
X-Received: by 2002:a17:907:2cc7:: with SMTP id hg7mr4735818ejc.360.1625229120306;
        Fri, 02 Jul 2021 05:32:00 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-182-89-242.retail.telecomitalia.it. [80.182.89.242])
        by smtp.gmail.com with ESMTPSA id c3sm1290189edy.0.2021.07.02.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:31:59 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] lib/string: optimized mem* functions
Date:   Fri,  2 Jul 2021 14:31:50 +0200
Message-Id: <20210702123153.14093-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Rewrite the generic mem{cpy,move,set} so that memory is accessed with
the widest size possible, but without doing unaligned accesses.

This was originally posted as C string functions for RISC-V[1], but as
there was no specific RISC-V code, it was proposed for the generic
lib/string.c implementation.

Tested on RISC-V and on x86_64 by undefining __HAVE_ARCH_MEM{CPY,SET,MOVE}
and HAVE_EFFICIENT_UNALIGNED_ACCESS.

These are the performances of memcpy() and memset() of a RISC-V machine
on a 32 mbyte buffer:

memcpy:
original aligned:	 75 Mb/s
original unaligned:	 75 Mb/s
new aligned:		114 Mb/s
new unaligned:		107 Mb/s

memset:
original aligned:	140 Mb/s
original unaligned:	140 Mb/s
new aligned:		241 Mb/s
new unaligned:		241 Mb/s

The size increase is negligible:

$ scripts/bloat-o-meter vmlinux.orig vmlinux
add/remove: 0/0 grow/shrink: 4/1 up/down: 427/-6 (421)
Function                                     old     new   delta
memcpy                                        29     351    +322
memset                                        29     117     +88
strlcat                                       68      78     +10
strlcpy                                       50      57      +7
memmove                                       56      50      -6
Total: Before=8556964, After=8557385, chg +0.00%

These functions will be used for RISC-V initially.

[1] https://lore.kernel.org/linux-riscv/20210617152754.17960-1-mcroce@linux.microsoft.com/

Matteo Croce (3):
  lib/string: optimized memcpy
  lib/string: optimized memmove
  lib/string: optimized memset

 lib/string.c | 130 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 113 insertions(+), 17 deletions(-)

-- 
2.31.1

