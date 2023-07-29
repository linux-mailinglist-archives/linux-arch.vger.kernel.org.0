Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A82B767997
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 02:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjG2Ad1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Jul 2023 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2Ad0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jul 2023 20:33:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B82135
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 17:33:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bbc64f9a91so21630125ad.0
        for <linux-arch@vger.kernel.org>; Fri, 28 Jul 2023 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690590804; x=1691195604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahyJuXZ5mL1EHkAmnBhtpjxq5pGjH0m9c44cFqu9RR8=;
        b=xpUdgokS5I3D2dS83HRiHhZiG56m5FAIJgE/jlbqlE+gYcIRkpxvSi/pZSlUi7sy2z
         bnqqAIfSeRVJ95s1lcZAuogwJigMtlZdlSs+YHeoYBnYTHfZR6Zk4ahWvPG1AaLULQhY
         gO+eJNi8wd3w5WbQ9DO9D/sOeD3bA9T5kHZwOM7wmJcQvePox0iYtRM8wYAC7n/dDaqK
         X7P0sDk/dcUAgQAqq7D+U55LcixXdO1mjn96aqshgDPBbaKb46v56++fUbVWhXcdTM5a
         esvqsFXNPN843wzsRhz3BzbNQN9oUX4Gbmjl8FepRs+P4u+4Q+dnrBblDHu1hpf9MbwM
         y3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590804; x=1691195604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahyJuXZ5mL1EHkAmnBhtpjxq5pGjH0m9c44cFqu9RR8=;
        b=SlRZVkzpwWTnGsyzvSqanZo8wnT25QPdwtagnhvQZx9bmvzLPMSUkMaOBpoEYmV5ZV
         MgPjYMbCs8KL9UgtqqKohk/axXl7KTO5MCReRNcWDVuJhwKHbi4bHUNae8FQhJijbZps
         SK+qDaG1xP1FLwUqDNxLU57jYlG4Pdpa7/eZP1TReSgvKm2032juA4p375/zfv4M2iLf
         Ajb2g+yRf2e7v+WG+xxSNJhIlmaeH+z7Dvs9bkcNCLrzOImM/V/Ylg+suQ4g2odJ7g7V
         O+00lYlPOwMg8O0kZlzl/FnBt5/L1PmTBBWdCW6kNTI8JdwnIajCryto0c6EEzIrdM4j
         2tUQ==
X-Gm-Message-State: ABy/qLZ1LKwO29h8aRu8W7mIziZwSQ54R7eeC25K1fqwp2771avrj5QQ
        FES3FTZ5Jcp748cVfPawAuHTbA==
X-Google-Smtp-Source: APBJJlFS9zLP1c6phrba+UHvupDG9E3d4F06JGpS2iM7oXYYOuggQ3ope9iTdf44U6BdBCqfanr6PA==
X-Received: by 2002:a17:902:9a06:b0:1bb:edd5:4644 with SMTP id v6-20020a1709029a0600b001bbedd54644mr2869632plp.68.1690590804391;
        Fri, 28 Jul 2023 17:33:24 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:ab2e:71c2:3a28:319c])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b001b9be3b94e5sm4140174plg.303.2023.07.28.17.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:33:24 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:33:22 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 0/2] riscv: stack: Fixup independent softirq/irq stack
 for CONFIG_FRAME_POINTER=n
Message-ID: <ZMReUsAVmwcDwEhe@x1>
References: <20230716001506.3506041-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716001506.3506041-1-guoren@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 15, 2023 at 08:15:04PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The independent softirq/irq stack uses s0 to save & restore sp, but s0
> would be corrupted when CONFIG_FRAME_POINTER=n. So add s0 in the clobber
> list to fix the problem.
> 
> <+0>:     addi    sp,sp,-32
> <+2>:     sd      s0,16(sp)
> <+4>:     sd      s1,8(sp)
> <+6>:     sd      ra,24(sp)
> <+8>:     sd      s2,0(sp)
> <+10>:    mv      s0,a0		--> compiler allocate s0 for a0 when CONFIG_FRAME_POINTER=n
> <+12>:    jal     ra,0xffffffff800bc0ce <irqentry_enter>
> <+16>:    ld      a5,56(tp) # 0x38
> <+20>:    lui     a4,0x4
> <+22>:    mv      s1,a0
> <+24>:    xor     a5,a5,sp
> <+28>:    bgeu    a5,a4,0xffffffff800bc092 <do_irq+88>
> <+32>:    auipc   s2,0x5d
> <+36>:    ld      s2,1118(s2) # 0xffffffff801194b8 <irq_stack_ptr>
> <+40>:    add     s2,s2,a4
> <+42>:    addi    sp,sp,-8
> <+44>:    sd      ra,0(sp)
> <+46>:    addi    sp,sp,-8
> <+48>:    sd      s0,0(sp)
> <+50>:    addi    s0,sp,16	--> our code clobber the s0
> <+52>:    mv      sp,s2
> <+54>:    mv      a0,s0		--> a0 got wrong value for handle_riscv_irq 
> <+56>:    jal     ra,0xffffffff800bbb3a <handle_riscv_irq>
> 
> Changelog:
> V2
>  - Fixup compile error with CONFIG_FRAME_POINTER=y
>  - FIxup stable@vger.kernel.org tag
> 
> Guo Ren (2):
>   riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=n
>   riscv: stack: Fixup independent softirq stack for
>     CONFIG_FRAME_POINTER=n
> 
>  arch/riscv/kernel/irq.c   | 3 +++
>  arch/riscv/kernel/traps.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Tested-by: Drew Fustini <dfustini@baylibre.com>

Xi Ruoyao noticed that the mainline kernel crashed when using a kernel
config with CONFIG_FRAME_POINTER=n. I was able to reproduce this [1].
Emil suggested I trying this patche series. I can confirm that this
resolves the kernel crash on the Sipeed Lichee Pi4a [2].

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/ZMNojqwLxcG8FcHN@x1/
[2] https://lore.kernel.org/linux-riscv/ZMQAqUfb0y%2FigQs2@x1/
