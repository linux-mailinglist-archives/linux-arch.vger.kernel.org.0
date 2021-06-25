Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C123B3A4B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 03:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhFYBE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 21:04:26 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:33398 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYBE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 21:04:26 -0400
Received: by mail-ej1-f54.google.com with SMTP id bu12so12510708ejb.0;
        Thu, 24 Jun 2021 18:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdYef+EeqjZUHJEkYZovIoYwvlil/tVir3JF22p9drE=;
        b=Y5QbUsB56OQQ+bRYlPkB4j8M0IudXmDgYWb7o1IAYt3TruvQFP//C9vaMSne1KoI9n
         8/R1Jofp6xiFHbXZ9VI1mIVJsloC9MJUiHwo8raNjddIShyzcMUQsbIcjIy7o43VLpdo
         7soPqS8Siefpblsp7SNmDZS9jFNdEw1CZcCovJxpzCoHMvSwJ5Ruq9+jsG52bSOcgg0N
         AMIFOHPFu/L9E3en8RVZzEgmiVNzGrr4W+p2FSLNbPq9AxLS5nt84gfsETEw7BiUOCw5
         4zZ1ryYxKjQYkzVuSMarccKuZ5VjFCYMXj6oFCd2UscJwhvrPWxp2Mb/dWMNnAM+NzBJ
         ZODg==
X-Gm-Message-State: AOAM530l5eK4ySP9k9utCVedPfCd2cteAqrIBWaKtE5vFoFIULb+oWkq
        PtBwCGq9hYz7nOw28AI0hkbpeja5FDt+lw==
X-Google-Smtp-Source: ABdhPJwXo0l8Ri22N8iM69Xf6x6QIaI5Eo8yFPOt6JHftyHB+BG7uO7b06nNrMu9DnEZSSyVa0ApeA==
X-Received: by 2002:a17:906:590a:: with SMTP id h10mr7904079ejq.346.1624582924279;
        Thu, 24 Jun 2021 18:02:04 -0700 (PDT)
Received: from msft-t490s.home (host-95-251-17-240.retail.telecomitalia.it. [95.251.17.240])
        by smtp.gmail.com with ESMTPSA id yc29sm1921909ejb.106.2021.06.24.18.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 18:02:03 -0700 (PDT)
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
Subject: [PATCH 0/3] lib/string: optimized mem* functions
Date:   Fri, 25 Jun 2021 03:01:57 +0200
Message-Id: <20210625010200.362755-1-mcroce@linux.microsoft.com>
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

Further testing on big endian machines will be appreciated, as I don't
have such hardware at the moment.

[1] https://lore.kernel.org/linux-riscv/20210617152754.17960-1-mcroce@linux.microsoft.com/

Matteo Croce (3):
  lib/string: optimized memcpy
  lib/string: optimized memmove
  lib/string: optimized memset

 lib/string.c | 129 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 17 deletions(-)

-- 
2.31.1

