Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132563B4858
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFYRr4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 13:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhFYRr4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jun 2021 13:47:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77816C061766
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 10:45:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d13so13516413ljg.12
        for <linux-arch@vger.kernel.org>; Fri, 25 Jun 2021 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNeEazWas8i0I5pBcB4dOYRPkmz0cs96RkB+Oe7gaq0=;
        b=Ac52bmzzRQZNPpekUSeIo1vprJWyBsB2D6XCnvGCluM4dZ6WZ50+TRJJJ4HfCWDmc9
         lumagY+Ziz6bqZpSUwMJMGnnb3wFVrYOKlk2H4g2BdjjEegYbXywOPrugRhUyFZ8EZcd
         H/RX38fv0SCz4uA5bAdae+IsRb5zWoJuz2/b+jR4taXazXvI2I/Qo8XMgVUwoJdXTNgk
         JBhubaIYShCYoBwjrNkfKm2CRjLyaDCmVg6xqtCTcecTIVFdgae/qsV+tUcwFAsyHMc/
         DYA8muvxRDkFZ1xbrxJFyLIlv+03s+rWFjvYrYMOuqd/uzLpDZ/4OvUVH96/F4maQFAb
         NXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNeEazWas8i0I5pBcB4dOYRPkmz0cs96RkB+Oe7gaq0=;
        b=JTg792v54rAakkDbVpSkTozQSFmtR5fe7Eybm6XcGuWZFN3k9AQl+6EElocj0bc+ln
         8WodK3zM8S01hyITg3KdL3GU4XfcA/EqARnd7C1a0XQ2iRSfT+ZOnwzGi5XjFTCz6G4G
         ACA3COlwhU6Q074jOvkwWSvZgXNDR/Yg+8duQI7cif4fdU/EC6qX1mBSIgtFQI9L84bl
         Y+vMp342PsFxOd2TUYlXwO1AHBOw+9RQev0lBpIl9YBOXFP9mUnYokoagWc0LxU3qrSx
         /7hxQ3rIwHKTInYFDZh8lGFLqZFJEftwxX9CPXYbmb10Y9aopWWnXcb4BMg6M1odnD25
         NCVw==
X-Gm-Message-State: AOAM5326mMAa9l6PO1AjaS8QHnaewKQJdM9tIQtTfdGPivzxD2ZXiGb8
        m6tz1v4m9xJ21ouAS57PHvNJe68xyTg+Koxs2JpPZg==
X-Google-Smtp-Source: ABdhPJyKg9KDZxebXTZT/Q8tKpmXlmmJWeK8MlwoundUry0HUACHyeyHhEnBID/ZTAlR9vDWotblOTcc2rQdjLigUpk=
X-Received: by 2002:a2e:a492:: with SMTP id h18mr9229016lji.495.1624643133384;
 Fri, 25 Jun 2021 10:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210625010200.362755-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210625010200.362755-1-mcroce@linux.microsoft.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Jun 2021 10:45:21 -0700
Message-ID: <CAKwvOd=rzoCFtUPrB+Hh8ZneGJwKc_2jW=QN6apb4T033r+kYg@mail.gmail.com>
Subject: Re: [PATCH 0/3] lib/string: optimized mem* functions
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 24, 2021 at 6:02 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Rewrite the generic mem{cpy,move,set} so that memory is accessed with
> the widest size possible, but without doing unaligned accesses.
>
> This was originally posted as C string functions for RISC-V[1], but as
> there was no specific RISC-V code, it was proposed for the generic
> lib/string.c implementation.
>
> Tested on RISC-V and on x86_64 by undefining __HAVE_ARCH_MEM{CPY,SET,MOVE}
> and HAVE_EFFICIENT_UNALIGNED_ACCESS.
>
> Further testing on big endian machines will be appreciated, as I don't
> have such hardware at the moment.

Hi Matteo,
Neat patches.  Do you have you any benchmark data showing the claimed
improvements? Is it worthwhile to define these only when
CC_OPTIMIZE_FOR_PERFORMANCE/CC_OPTIMIZE_FOR_PERFORMANCE_O3 are
defined, not CC_OPTIMIZE_FOR_SIZE? I'd be curious to know the delta in
ST_SIZE of these functions otherwise.

For big endian, you ought to be able to boot test in QEMU.  I think
you'd find out pretty quickly if any of the above had issues.
(Enabling KASAN is probably also a good idea for a test, too). Check
out
https://github.com/ClangBuiltLinux/boot-utils
for ready made images and scripts for launching various architectures
and endiannesses.

>
> [1] https://lore.kernel.org/linux-riscv/20210617152754.17960-1-mcroce@linux.microsoft.com/
>
> Matteo Croce (3):
>   lib/string: optimized memcpy
>   lib/string: optimized memmove
>   lib/string: optimized memset
>
>  lib/string.c | 129 ++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 112 insertions(+), 17 deletions(-)
>
> --
> 2.31.1
>


--
Thanks,
~Nick Desaulniers
