Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7F59B379
	for <lists+linux-arch@lfdr.de>; Sun, 21 Aug 2022 13:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHULgW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 21 Aug 2022 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiHULgU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 21 Aug 2022 07:36:20 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC326561
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 04:36:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so4760168wrr.3
        for <linux-arch@vger.kernel.org>; Sun, 21 Aug 2022 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tBERBJeFmsU2gk0DqsvVk7OhaA+vX7d504uAWoZh04w=;
        b=IunUk0SKEn1nH9A85B2rFGOdzLzvhKfM0gFlEIcPkoAPXo4AzUcYqEXCcOxLXWrj1z
         AbEUWDg+04+jy3Fu0QvCXD1xFMIRaMvfxUVnKnfrfmoXEdYXprWWC/XNOT0FPBo1vL6D
         k/3vEXLEjiDdQGt2zOykFohvkYMDkXZWpHoMkByk2xiRiRzlTuyOA4g+ASE0gOQttgih
         o1Sl/4dF/zhAUA2z1C2A8eUPNoNGVU/0tLRmMgf56tCheoPeqQpcK3dL+sDn3uY5JQx3
         hmmiLwc2CcOeVdFoM49uCkFVV7nbhStM9cZTEJKNIzPUk1T632l/nVD040fstWJ8inVu
         e1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tBERBJeFmsU2gk0DqsvVk7OhaA+vX7d504uAWoZh04w=;
        b=1pKd2itDrTj4Cs6iMh+k/DIt4KhdfnvVEPR2h3++BepaRLaWdNuAM6Cqp/qHG1Nofd
         SS8T5zneFn6VWykS3vpdN63ZwUlCsku1DKiQf/Xdpd9z7G07nBKVgpc3j778Jg8MvPrr
         8dlc0nv30euKuQkQ/aEnq10zw8AnsIX+zvrn/b0gAJPG3D2Jk+bBX2008Z7gaTxPjw9l
         oKAUFcjVw2GYJGmDRSeVV0k3lPt8lCe1tztphvAvRIwZhE8shOPXLYaRthvMvS/hNMcs
         pYlZxkWlO2S3n1e+fLiLL5sKS5p5PZ+Ro1IgZfujj/NU6pN4ehNIsIHMuAjEf/6rR8WP
         8/ng==
X-Gm-Message-State: ACgBeo3V9L2BEQxYIHpGrq/RvMykQzkP9tvIYtYoxb+NvhOG+3u2H4Qc
        cCrSbfp4NnwWqEsOZSo5eW4PUA==
X-Google-Smtp-Source: AA6agR5cyZy9CZWot4+CBW4LaR0SdclbcYK3AcOGPU3Q+v5vUQoWQM9YfCtFYFfA5X3trYU8FH6ocQ==
X-Received: by 2002:a5d:4882:0:b0:225:3148:9f85 with SMTP id g2-20020a5d4882000000b0022531489f85mr7667679wrq.224.1661081777100;
        Sun, 21 Aug 2022 04:36:17 -0700 (PDT)
Received: from henark71.. ([51.37.149.245])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003a3442f1229sm14071361wmc.29.2022.08.21.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 04:36:16 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Michal Simek <monstr@monstr.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 0/6] Add an asm-generic cpuinfo_op declaration
Date:   Sun, 21 Aug 2022 12:35:07 +0100
Message-Id: <20220821113512.2056409-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

RISC-V is missing a prototype for cpuinfo_op. Rather than adding yet
another `extern const struct seq_operations cpuinfo_op;` to an arch
specific header file, create an asm-generic variant and migrate the
existing arch variants there too. Obv. there are other archs that use
cpuinfo_op but don't declare it and surely also have the same warning?
I went for the minimum change here, but would be perfectly happy to
extend the change to all archs if this change is worthwhile. Or just
make a header in arch/riscv, any of the three work for me!

If this isn't the approach I should've gone for, any direction would
be great :) I tried pushing this last weekend to get LKP to test it but
I got neither a build success nor a build failure email from it, so
I figured I may as well just send the patches..

I wasn't too sure if this could be a single patch, so I split it out
into a patch fixing the issue on RISC-V & copy-paste patches for each
arch that I moved.

Thanks,
Conor.

Conor Dooley (6):
  asm-generic: add a cpuinfo_ops definition in shared code
  microblaze: use the asm-generic version of cpuinfo_op
  s390: use the asm-generic version of cpuinfo_op
  sh: use the asm-generic version of cpuinfo_op
  sparc: use the asm-generic version of cpuinfo_op
  x86: use the asm-generic version of cpuinfo_op

 arch/microblaze/include/asm/processor.h | 2 +-
 arch/riscv/include/asm/processor.h      | 1 +
 arch/s390/include/asm/processor.h       | 2 +-
 arch/sh/include/asm/processor.h         | 2 +-
 arch/sparc/include/asm/cpudata.h        | 3 +--
 arch/x86/include/asm/processor.h        | 2 +-
 include/asm-generic/processor.h         | 7 +++++++
 7 files changed, 13 insertions(+), 6 deletions(-)
 create mode 100644 include/asm-generic/processor.h

-- 
2.37.1

