Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FA731A86
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jun 2023 15:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbjFONyh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jun 2023 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjFONyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jun 2023 09:54:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DDD193
        for <linux-arch@vger.kernel.org>; Thu, 15 Jun 2023 06:54:35 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso5864217a34.0
        for <linux-arch@vger.kernel.org>; Thu, 15 Jun 2023 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1686837274; x=1689429274;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aL6s+S70COXWhSW1xa78Cs58KFjDmq4WzqQOCdiOiQ=;
        b=gO90/AdNIolSs15osNgKPkFkIycjW7AtQYUlLN1kYKDXG53CQt5/HpTfPL0SNKfV+q
         SBWNbTDKbv/9XgznIq3QER7UkD+YWke3zclHBDwZ2nHPc4ylAj5ge1f1IcR3+d2kahjh
         FjwxFrj3VTydDLQ8yv1GwQc4oPAYYSqq6rAimwqpm4MWQF1ys3owYsjib5W9t3oPlflv
         CDxfBNyUSej0G/0GHx04kNAQv57eAAF0dPazGO3Io2PRLrW6FNWGhJg1fsAUgp5GjzPp
         UgoQUCxffIfRWnbiqH/Yl9jZh0limMMAjS//SbPA5K1ihbmZnzRuFEVkb1B+JtDuEwVQ
         cs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837274; x=1689429274;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aL6s+S70COXWhSW1xa78Cs58KFjDmq4WzqQOCdiOiQ=;
        b=J2vrBiH0l9mr0e+v+A4Y6305TkzGgV6BsVk7v3vL57ARkw7cYNMOj/IiFNzUmW1i87
         DgZ1yESUxIqvsIY83SVjHnkEUfK5cCHqWqSudwgKcMvFRDDXEGJdLlbcazgvZSPxgkbD
         SQ7L+1986KXRl8G2Q4J8Q/pezv1TD8WORS1+xcTIqBGGfzFLPVeWjuQ92c4y32NpcExB
         CykOEYoBMdm2Db6h3bUpVRjI8kRTBpbZIoBdm7WnEA0j6eR2rEvEkkzNPJUih4j29eAY
         5vJ+adgLZnxcb7zZSCQaI5p7BmRRcUqfAxbJHAZskGSXZ6Dx9Fbiag1P+RKHyw/D63wX
         Inlw==
X-Gm-Message-State: AC+VfDwh3LBq5iHjuFq4ASle5jSYJBz9aUf92k+opsvSA0f3HIWhRRzd
        ZJbzrJSa/vFBy09JC5x9uFiGDw==
X-Google-Smtp-Source: ACHHUZ5I63uqJ8FKjWG+8uwoFHcGcg1JHnF32YJoVu3zwVNY0nDaVNwrqRY/Q7wnBZo524tHS2PlDw==
X-Received: by 2002:a05:6358:cb2f:b0:129:c6d6:ce40 with SMTP id gr47-20020a056358cb2f00b00129c6d6ce40mr12848161rwb.15.1686837274461;
        Thu, 15 Jun 2023 06:54:34 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id g25-20020a633759000000b0051afa49e07asm12980492pgn.50.2023.06.15.06.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 06:54:33 -0700 (PDT)
Date:   Thu, 15 Jun 2023 06:54:33 -0700 (PDT)
X-Google-Original-Date: Wed, 14 Jun 2023 09:58:00 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <ZInqDdXh6wNK3NHq@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-41a06775-95dc-4747-aaab-2c5c83fd6422@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
>
> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
>> > When trying to run linux with various opensource riscv core on
>> > resource limited FPGA platforms, for example, those FPGAs with less
>> > than 16MB SDRAM, I want to save mem as much as possible. One of the
>> > major technologies is kernel size optimizations, I found that riscv
>> > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, which
>> > passes -fdata-sections, -ffunction-sections to CFLAGS and passes the
>> > --gc-sections flag to the linker.
>> >
>> > This not only benefits my case on FPGA but also benefits defconfigs.
>> > Here are some notable improvements from enabling this with defconfigs:
>> >
>> > nommu_k210_defconfig:
>> >    text    data     bss     dec     hex
>> > 1112009  410288   59837 1582134  182436     before
>> >  962838  376656   51285 1390779  1538bb     after
>> >
>> > rv32_defconfig:
>> >    text    data     bss     dec     hex
>> > 8804455 2816544  290577 11911576 b5c198     before
>> > 8692295 2779872  288977 11761144 b375f8     after
>> >
>> > defconfig:
>> >    text    data     bss     dec     hex
>> > 9438267 3391332  485333 13314932 cb2b74     before
>> > 9285914 3350052  483349 13119315 c82f53     after
>> >
>> > patch1 and patch2 are clean ups.
>> > patch3 fixes a typo.
>> > patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.
>> >
>> > NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
>> > elimination for riscv several months ago, I didn't notice it until
>> > yesterday. Although it missed some preparations and some sections's
>> > keeping, he is the first person to enable this feature for riscv. To
>> > ease merging, this series take his patch into my entire series and
>> > makes patch4 authored by him after getting his ack to reflect
>> > the above fact.
>> >
>> > Since v1:
>> >   - collect Reviewed-by, Tested-by tag
>> >   - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag
>> >
>> > Jisheng Zhang (3):
>> >   riscv: move options to keep entries sorted
>> >   riscv: vmlinux-xip.lds.S: remove .alternative section
>> >   vmlinux.lds.h: use correct .init.data.* section name
>> >
>> > Zhangjin Wu (1):
>> >   riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>> >
>> >  arch/riscv/Kconfig                  |  13 +-
>> >  arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
>> >  arch/riscv/kernel/vmlinux.lds.S     |   6 +-
>> >  include/asm-generic/vmlinux.lds.h   |   2 +-
>> >  4 files changed, 11 insertions(+), 16 deletions(-)
>>
>> Do you have a base commit for this?  It's not applying to 6.4-rc1 and the
>> patchwork bot couldn't find one either.
>
> Hi Palmer,
>
> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
> series is based on 6.4-rc2.

Thanks.

>
> Thanks
