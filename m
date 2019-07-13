Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0A67BDC
	for <lists+linux-arch@lfdr.de>; Sat, 13 Jul 2019 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfGMTsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Jul 2019 15:48:06 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39039 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfGMTsG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Jul 2019 15:48:06 -0400
Received: by mail-wr1-f47.google.com with SMTP id x4so13123468wrt.6
        for <linux-arch@vger.kernel.org>; Sat, 13 Jul 2019 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hAuDOxKAGGgLxklzMBgcenn1SxEzL/PAgC7c5quSXLk=;
        b=K7S4uwIwg/yndUVpzFlmZciuIRefWBEoXT5gcbDl3NpuJZ6Igvva5+HkGlnU3ClEQU
         IcbyGG05wI9FiwrAlS+3FskLVPPOW6fABvxKIxoODjT6kdfBzNSTjNrdNHLzzo7Di1aJ
         rnk6R7W1AfhAtbmCYTWKe/D86nYAHn3ZQ7ONGDR7Kw2e3M7TWRz5kjRr/D61xMSNX1em
         o8ryX3KfAxxP9MVZ5v6rbWbFDB+QZD02Nil5aSG9Dkc50DA32km7QX39IPvq5g3898Ek
         QY+MZ0qTEpjP9p3MKMMY7VSaPgBfEqoVhwqC9c8MhAIHbwrtuy+MYbxxFj3O/E2neHSt
         FyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hAuDOxKAGGgLxklzMBgcenn1SxEzL/PAgC7c5quSXLk=;
        b=B2JgfF0z+uXkNeGeo+sDAGDf2bTDyi92XBF3EwYlYQK+zgW73y6rPYPZdXmgYwJDr1
         S+tgvSwQisGZJ8kNWrDdiVa3JZcegYt1s7+xOKi8MpphRx7amACL7byfB+96pWVKv+dX
         kxzjLmb1c/vD++RnZx7j6kfVMtmT3G+hqdGvlOER+SZaJ7AKiivlhDCp7QGL+a4h6Z7q
         1K8ZpkwNZKjSCkE6+xwwHDtXMHrcrTDzkro8Zo8YldTcUyH5kPGxlQPFZJpypPCkvibh
         sPXxJNBVFpTx/6SXmybJtrlOW0OB5D3iff4ugqM0hP6iM/o/OiFFGbcPgG5qQPleCAG3
         NprQ==
X-Gm-Message-State: APjAAAW15+svqC7CxsQ+TvoO+56e7nE1DWJPN6EwKTmnOl4R5tBvnFH9
        Edn7YItf+j1U+FyHxKn4PlQJvEI=
X-Google-Smtp-Source: APXvYqxGe49AUzwuiamJCLBeLR0N+7859bAmxG48cXUV5rpEgarYOl6kGr1qT/RdXoysz1Y3lYr6RQ==
X-Received: by 2002:adf:8028:: with SMTP id 37mr18570746wrk.106.1563047283049;
        Sat, 13 Jul 2019 12:48:03 -0700 (PDT)
Received: from avx2 ([46.53.251.122])
        by smtp.gmail.com with ESMTPSA id o4sm10092761wmh.35.2019.07.13.12.48.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 12:48:02 -0700 (PDT)
Date:   Sat, 13 Jul 2019 22:48:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-arch@vger.kernel.org
Subject: FYI __ASSEMBLER__ typo
Message-ID: <20190713194800.GA15790@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

arch/arm64/include/asm/irq.h:16:#endif /* !__ASSEMBLER__ */
arch/arm64/include/asm/irq.h:5:#ifndef __ASSEMBLER__
arch/arm64/include/asm/lse.h:13:#ifdef __ASSEMBLER__
arch/arm64/include/asm/lse.h:21:#else	/* __ASSEMBLER__ */
arch/arm64/include/asm/lse.h:38:#endif	/* __ASSEMBLER__ */
arch/arm64/include/asm/lse.h:41:#ifdef __ASSEMBLER__
arch/arm64/include/asm/lse.h:47:#else	/* __ASSEMBLER__ */
arch/arm64/include/asm/lse.h:55:#endif	/* __ASSEMBLER__ */
arch/arm/include/asm/glue-cache.h:129:#ifndef __ASSEMBLER__
arch/arm/include/asm/smp_scu.h:9:#ifndef __ASSEMBLER__
arch/arm/mach-iop13xx/include/mach/irqs.h:5:#ifndef __ASSEMBLER__
arch/arm/mach-ixp4xx/include/mach/hardware.h:25:#ifndef __ASSEMBLER__
arch/arm/mach-keystone/keystone.h:13:#ifndef __ASSEMBLER__
arch/arm/mach-keystone/keystone.h:20:#endif /* __ASSEMBLER__ */
arch/arm/mach-omap1/ams-delta-fiq.h:35:#ifndef __ASSEMBLER__
arch/arm/mach-omap1/include/mach/hardware.h:40:#ifndef __ASSEMBLER__
arch/arm/mach-omap1/include/mach/hardware.h:73:#endif	/* ifndef __ASSEMBLER__ */
arch/arm/mach-omap1/include/mach/memory.h:20:#if defined(CONFIG_ARCH_OMAP15XX) && !defined(__ASSEMBLER__)
arch/arm/mach-omap1/include/mach/serial.h:44:#ifndef __ASSEMBLER__
arch/arm/mach-omap1/include/mach/tc.h:62:#ifndef	__ASSEMBLER__
arch/arm/mach-omap1/include/mach/tc.h:74:#endif	/* __ASSEMBLER__ */
arch/arm/mach-omap1/pm.h:114:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm2xxx_3xxx.h:46:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm2xxx.h:44:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm33xx.h:377:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm3xxx.h:66:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm.h:22:# ifndef __ASSEMBLER__
arch/arm/mach-omap2/cm.h:43:# ifndef __ASSEMBLER__
arch/arm/mach-omap2/common.h:27:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/common.h:364:#endif /* __ASSEMBLER__ */
arch/arm/mach-omap2/include/mach/serial.h:57:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/omap-secure.h:59:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/omap-secure.h:83:#endif /* __ASSEMBLER__ */
arch/arm/mach-omap2/prcm-common.h:432:# ifndef __ASSEMBLER__
arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h:22:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm2xxx_3xxx.h:47:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm2xxx.h:119:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm33xx.h:118:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm3xxx.h:130:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm44xx_54xx.h:25:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm.h:110:#ifndef __ASSEMBLER__
arch/arm/mach-omap2/prm.h:15:# ifndef __ASSEMBLER__
arch/arm/mach-omap2/sdrc.h:112:#endif	/* __ASSEMBLER__ */
arch/arm/mach-omap2/sdrc.h:17:#ifndef __ASSEMBLER__
arch/c6x/include/asm/clock.h:17:#ifndef __ASSEMBLER__
arch/c6x/include/asm/linkage.h:5:#ifdef __ASSEMBLER__
arch/csky/abiv2/sysdep.h:7:#ifdef __ASSEMBLER__
arch/m68k/include/asm/m525xsim.h:220:#ifdef __ASSEMBLER__
arch/m68k/include/asm/m525xsim.h:307:#endif /* __ASSEMBLER__ */
arch/m68k/include/asm/m53xxsim.h:159:#ifdef __ASSEMBLER__
arch/m68k/include/asm/m53xxsim.h:174:#endif /* __ASSEMBLER__ */
arch/m68k/include/asm/mcfintc.h:70:#ifndef __ASSEMBLER__
arch/mips/include/asm/mach-pmcs-msp71xx/msp_regs.h:146:#ifdef __ASSEMBLER__
arch/mips/include/asm/sibyte/sb1250_scd.h:140:#ifdef __ASSEMBLER__
arch/sparc/net/bpf_jit_32.h:18:#ifndef __ASSEMBLER__
arch/sparc/net/bpf_jit_64.h:5:#ifndef __ASSEMBLER__
drivers/net/wan/wanxl.h:126:#ifndef __ASSEMBLER__
drivers/net/wan/wanxl.h:149:#endif /* __ASSEMBLER__ */
drivers/net/wan/wanxl.h:76:#ifndef __ASSEMBLER__
drivers/net/wan/wanxl.h:95:#ifdef __ASSEMBLER__
include/linux/build-salt.h:8:#ifdef __ASSEMBLER__
include/linux/elfnote.h:31:#ifdef __ASSEMBLER__
include/linux/elfnote.h:61:#else	/* !__ASSEMBLER__ */
include/linux/elfnote.h:97:#endif	/* __ASSEMBLER__ */
include/linux/platform_data/gpio-omap.h:13:#ifndef __ASSEMBLER__
include/linux/platform_data/gpio-omap.h:148:#ifndef __ASSEMBLER__
include/linux/platform_data/gpio-omap.h:195:#endif /* __ASSEMBLER__ */
include/linux/platform_data/pm33xx.h:38:#ifndef __ASSEMBLER__
include/linux/platform_data/pm33xx.h:73:#endif /* __ASSEMBLER__ */
tools/testing/selftests/powerpc/include/reg.h:150:#ifndef __ASSEMBLER__
tools/testing/selftests/powerpc/include/reg.h:155:#endif /* end of __ASSEMBLER__ */
