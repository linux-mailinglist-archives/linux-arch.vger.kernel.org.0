Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68930EE3F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 09:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhBDIWP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhBDIWO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 03:22:14 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2144C061573;
        Thu,  4 Feb 2021 00:21:34 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so1556480pgk.13;
        Thu, 04 Feb 2021 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XXkvcBKboNN7LGIeynhgZT6EpSB86akvi9IwRytyAz8=;
        b=LxvPH9bB5kAaZOYcJLU2iOG2OormPkekcFLSUlN6cpK/oqo551ZRevlJQSdTj9CxB1
         rCfZlOPlLe/FAdkjd2tYzWS9LBxKvSFzufueWwEGAGkcWFAqv25IWvqpQyhSiMt4SAVS
         IpwD9JkOriCnJ+Q2+N5mwql7JWGZEvEdu+lsUSo2ZjViWm0HoCSwf31f0+Si9XG/N8Y+
         ctZRHcpTf6yjXhE1LnhjgMfKCvchelCV6B1Rd/DFlkGhGVypKY6ORTk+GdVvtVOW0AFN
         N/inRTqZVWOdJbPmt5xeAky+ZVODprxaeWovrbG6up5GSTM5MOdsUH7PHg5NhFEcKaQX
         F6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XXkvcBKboNN7LGIeynhgZT6EpSB86akvi9IwRytyAz8=;
        b=YGTTU6HYnz2yu73rec0y5sfqV1WTNeXuuKuiMY0wcU0NeE0DDDxgL1y1EnjXqmm9Er
         V1X2Nw1WZ4HyoGZMHz95lMxO80vmnnMHzwX22Hz3Sh1L2e7dNzPwkUIfr3c27Ri50D9J
         +8y3NF3BUw0c2IweHzWkB7zt898nOC1Dgp8RW5FUrAOt80u64aleHC3hhkeocVmLPh7y
         jJeLiwxtD+lOw4zsIfEJkJ9MMS99Ve7fkmmDayZbDhH6TQx73h2yyyG1rRt7BP3nwIaO
         9gvvpF/YEcd2AAMbFAzGhzcG1ACKHEzKvKjdmTmlHLM/Q3iPFsb6ZLwR7cBlJwonTMhY
         KExg==
X-Gm-Message-State: AOAM532gxUK/Cl2krbmK80dmOc4PNHFmEWAcA1awszicN3YUvxgnTk9H
        wATdcMAj87B+RqNaZ8Hke9BVLP8cHdo=
X-Google-Smtp-Source: ABdhPJyFh2UIalFWfH9S0Gigao8PrBaKb3QduCZYTwG0z0xvXFRe3aj70yzjXDYS3R0QrYEyG2SNLA==
X-Received: by 2002:a63:1c13:: with SMTP id c19mr7570212pgc.359.1612426893809;
        Thu, 04 Feb 2021 00:21:33 -0800 (PST)
Received: from localhost ([1.132.253.145])
        by smtp.gmail.com with ESMTPSA id 72sm4819621pfw.170.2021.02.04.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 00:21:33 -0800 (PST)
Date:   Thu, 04 Feb 2021 18:21:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/5] shoot lazy tlbs
To:     linux-kernel@vger.kernel.org
Cc:     Anton Blanchard <anton@ozlabs.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andy Lutomirski <luto@kernel.org>
References: <20201214065312.270062-1-npiggin@gmail.com>
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1612426668.622xblt2lx.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I'll ask Andrew to put this in -mm if no objections.

The series now doesn't touch other archs in non-trivial ways, and core code
is functionally not changed much / at all if the option is not selected so
it's actually pretty simple aside from the powerpc change.

Thanks,
Nick

Excerpts from Nicholas Piggin's message of December 14, 2020 4:53 pm:
> This is another rebase, on top of mainline now (don't need the
> asm-generic tree), and without any x86 or membarrier changes.
> This makes the series far smaller and more manageable and
> without the controversial bits.
>=20
> Thanks,
> Nick
>=20
> Nicholas Piggin (5):
>   lazy tlb: introduce lazy mm refcount helper functions
>   lazy tlb: allow lazy tlb mm switching to be configurable
>   lazy tlb: shoot lazies, a non-refcounting lazy tlb option
>   powerpc: use lazy mm refcount helper functions
>   powerpc/64s: enable MMU_LAZY_TLB_SHOOTDOWN
>=20
>  arch/Kconfig                         | 30 ++++++++++
>  arch/arm/mach-rpc/ecard.c            |  2 +-
>  arch/powerpc/Kconfig                 |  1 +
>  arch/powerpc/kernel/smp.c            |  2 +-
>  arch/powerpc/mm/book3s64/radix_tlb.c |  4 +-
>  fs/exec.c                            |  4 +-
>  include/linux/sched/mm.h             | 20 +++++++
>  kernel/cpu.c                         |  2 +-
>  kernel/exit.c                        |  2 +-
>  kernel/fork.c                        | 52 ++++++++++++++++
>  kernel/kthread.c                     | 11 ++--
>  kernel/sched/core.c                  | 88 ++++++++++++++++++++--------
>  kernel/sched/sched.h                 |  4 +-
>  13 files changed, 184 insertions(+), 38 deletions(-)
>=20
> --=20
> 2.23.0
>=20
>=20
