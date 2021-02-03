Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1749B30DEB5
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhBCPwX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhBCPwK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:52:10 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD464C061786
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 07:51:29 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id r12so36529662ejb.9
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8ZiZgrXUKTPqtav3uMw7TC7Q+Aei5KWAfNt52U+dlDQ=;
        b=rH0DqReYRnjwzpX31BARiullKEije5kg479qo/hGnERWhpgzpT4X1769vLah48SIwg
         v+RJT5IyfS6o/zlQKNZCKMovJUucHYl2vvVPHFmEM6RJtNQeyp604riUlPBTsVpDW373
         wo6gr7iWes5a1p9YYKBqNkERLiuQa+aqmylO8FIz7HD7P1E4gYQGlAco5XquUZvZim6b
         25bJTvBTgrihKk16rJPk3ZK6Q5Hpvm9ehj9Qkj2TgX7rYqHsAofeovyxj3iO85X6TK3i
         WqoqVY6lPLaJxyt3zE3Pq5HvpMDWIDK9VhhRy1IYd38sM452Mq7O4TGohXZartCXVE46
         Gf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8ZiZgrXUKTPqtav3uMw7TC7Q+Aei5KWAfNt52U+dlDQ=;
        b=gVIdUTn5vTk+884qpQ0KJe8DabSiK0UM5D5dmgL2zGyYY8qlHjnhmhcSqmYLmJTU0q
         Gq1FH7Rbu6i2sXZPVDr+buP6kNMlUPP0DmQb+vBGkWC7mmKbAqY1TuNIZ1LZ8fQQTrO8
         KosCm1FooBFFH2yDW07DnhOuG+mS3ONRyi3yNeGyV4D3FsTTG5PGNtlhUKt4kClf1ktP
         phvyPv5uZHo+70yw0VD2SrIx5tpq+lwGjg12oTYL1XoVC6jHPPM2BGA0FAdmWC4BD+NE
         hiqFIi0s9N5fyYYFNEmuAhtdceI2XxmMa0bTgMDveIrrvfXy8LQaDp1vsJFlJoTVcW1Q
         Oadw==
X-Gm-Message-State: AOAM532KWe0i3ELOOLfdtPgG5wBfhovdDPU1NxH9ws1och2NWPaijjJR
        CnXuxUlTAYbaGi2uolW61fi3tKb/vbKYsZOTj8eReA==
X-Google-Smtp-Source: ABdhPJw325Fj8DcUghMscoJ2RIXBEp961uIMC8z8Cv3Nbs+QLRe4xLzgr/K6gPQUWefmsx1FIqrtaU0BHyw9vjMq0Pc=
X-Received: by 2002:a17:906:ca0d:: with SMTP id jt13mr3721106ejb.170.1612367488351;
 Wed, 03 Feb 2021 07:51:28 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 3 Feb 2021 21:21:16 +0530
Message-ID: <CA+G9fYv-=GdpLK3-6M9P4J1N-4ypS=GO8T2N15JFWXSmsG1adQ@mail.gmail.com>
Subject: memory_model.h:64:14: error: implicit declaration of function 'page_to_section'
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linux next tag 20210203 the mips and sh builds failed due to below errors.
Following builds failed with gcc-8, gcc-9 and gcc-10,
  - mips (cavium_octeon_defconfig)
  - sh (defconfig)
  - sh (shx3_defconfig)

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=mips
CROSS_COMPILE=mips-linux-gnu- 'CC=sccache mips-linux-gnu-gcc'
'HOSTCC=sccache gcc' uImage.gz
In file included from arch/mips/include/asm/page.h:258,
                 from arch/mips/include/asm/io.h:29,
                 from include/linux/io.h:13,
                 from arch/mips/include/asm/mips-cps.h:10,
                 from arch/mips/include/asm/smp-ops.h:16,
                 from arch/mips/include/asm/smp.h:21,
                 from include/linux/smp.h:84,
                 from arch/mips/include/asm/cpu-type.h:12,
                 from arch/mips/include/asm/timex.h:19,
                 from include/linux/timex.h:65,
                 from include/linux/time32.h:13,
                 from include/linux/time.h:60,
                 from include/linux/compat.h:10,
                 from arch/mips/kernel/asm-offsets.c:12:
include/linux/mm.h: In function 'is_pinnable_page':
include/asm-generic/memory_model.h:64:14: error: implicit declaration
of function 'page_to_section'; did you mean 'present_section'?
[-Werror=implicit-function-declaration]
  int __sec = page_to_section(__pg);   \
              ^~~~~~~~~~~~~~~
include/asm-generic/memory_model.h:81:21: note: in expansion of macro
'__page_to_pfn'
 #define page_to_pfn __page_to_pfn
                     ^~~~~~~~~~~~~
include/linux/mm.h:1135:15: note: in expansion of macro 'page_to_pfn'
   is_zero_pfn(page_to_pfn(page));
               ^~~~~~~~~~~
In file included from arch/mips/kernel/asm-offsets.c:15:
include/linux/mm.h: At top level:
include/linux/mm.h:1512:29: error: conflicting types for 'page_to_section'
 static inline unsigned long page_to_section(const struct page *page)
                             ^~~~~~~~~~~~~~~
Steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.


tuxmake --runtime podman --target-arch mips --toolchain gcc-10
--kconfig cavium_octeon_defconfig


-- 
Linaro LKFT
https://lkft.linaro.org
