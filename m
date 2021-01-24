Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DF2301A82
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbhAXIXk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbhAXIXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:23:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBAC061573;
        Sun, 24 Jan 2021 00:22:54 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g3so5757452plp.2;
        Sun, 24 Jan 2021 00:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxwgyuW5XH28Q8/mj8v779VyclgJcF5KFu/DzCcjZnI=;
        b=Fs0JCb3pwKQ3Qw2tgKBDrI0dac88HUkrErNJBG0hmRLf5MyNBR21T+TPQXWbZhzXWR
         5CKgAqureRQX5U3msaUj+PUlSx+eroPq001obnVV7TfXWOm2oSyNkyE7wZM7J9Pv8Mta
         xDge4jkywbVh2WRt+ij2Wvj7yIwZDjn6BDaEtOt4/C2gHaR7aiHu96kIa1ZiMKOG6JX1
         Vdh6g9cgk2rsp+rAgX7ps8P3fUZTlODulpbF24noaVvODB7zOCWZr/S0xRJRBhHCPNRm
         j4Jo4Rxa5z8wzdHpC1OgyDz4e7JPp8DkXwn0yn6X7IPbVkLVco3Zbc8HUofZ34N5kcGN
         zLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxwgyuW5XH28Q8/mj8v779VyclgJcF5KFu/DzCcjZnI=;
        b=Uv58EzZmSjxxVSApv/3VudNwyQOsV8ow+7KDZf9GMdM7dWYzmDZ6lkooCLX7uMarRr
         BJsCIrY0kEC3JWO5xG3SZhbjQ58FgQsQRJVxRr8ziH959YDk5XzNQVW0k8UWszsPhdM1
         1cGIk8pIVOVg2mki9u69/jhadXOkUrSSLUAWbEYAGY2dmw3DD+sfKENm7WxVy3YoGuLu
         E6TAEQKBRCb1j6275oX/sk3h1CYWRpVgWyzor2ghgjypYclW+zgenT/hyUDsUYqhbsIn
         HqY0fHOG6X50EpkK2EKEuQwo13XIT2MjN74U9vbkytKykI3ZwzFYotZKBk2Dvh0owEQs
         lpfw==
X-Gm-Message-State: AOAM5304G3jJRaEboHGFCOtwnIg/J7cFrHSk7YInbpzwrV0GqqlMsX7J
        2VKXK0sgiPvKTItfHUqh5Ew=
X-Google-Smtp-Source: ABdhPJwork++HKOseNPRq3Vls6uVbkN5KsPiEY5ah8ze3Qk+PSvpG3taYXPMNJK4g7gAUsggjvJOSg==
X-Received: by 2002:a17:90b:b0b:: with SMTP id bf11mr10064810pjb.122.1611476573791;
        Sun, 24 Jan 2021 00:22:53 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:22:53 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v10 00/12] huge vmalloc mappings
Date:   Sun, 24 Jan 2021 18:22:18 +1000
Message-Id: <20210124082230.2118861-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fixed a couple of bugs that Ding noticed in review and testing.

Thanks,
Nick

Since v9:
- Fixed intermediate build breakage on x86-32 !PAE [thanks Ding]
- Fixed small page fallback case vm_struct double-free [thanks Ding]

Since v8:
- Fixed nommu compile.
- Added Kconfig option help text
- Added VM_NOHUGE which should help archs implement it [suggested by Rick]

Since v7:
- Rebase, added some acks, compile fix
- Removed "order=" from vmallocinfo, it's a bit confusing (nr_pages
  is in small page size for compatibility).
- Added arch_vmap_pmd_supported() test before starting to allocate
  the large page, rather than only testing it when doing the map, to
  avoid unsupported configs trying to allocate huge pages for no
  reason.

Since v6:
- Fixed a false positive warning introduced in patch 2, found by
  kbuild test robot.

Since v5:
- Split arch changes out better and make the constant folding work
- Avoid most of the 80 column wrap, fix a reference to lib/ioremap.c
- Fix compile error on some archs

Since v4:
- Fixed an off-by-page-order bug in v4
- Several minor cleanups.
- Added page order to /proc/vmallocinfo
- Added hugepage to alloc_large_system_hage output.
- Made an architecture config option, powerpc only for now.

Since v3:
- Fixed an off-by-one bug in a loop
- Fix !CONFIG_HAVE_ARCH_HUGE_VMAP build fail

*** BLURB HERE ***

Nicholas Piggin (12):
  mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
  mm: apply_to_pte_range warn and fail if a large pte is encountered
  mm/vmalloc: rename vmap_*_range vmap_pages_*_range
  mm/ioremap: rename ioremap_*_range to vmap_*_range
  mm: HUGE_VMAP arch support cleanup
  powerpc: inline huge vmap supported functions
  arm64: inline huge vmap supported functions
  x86: inline huge vmap supported functions
  mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c
  mm/vmalloc: add vmap_range_noflush variant
  mm/vmalloc: Hugepage vmalloc mappings
  powerpc/64s/radix: Enable huge vmalloc mappings

 .../admin-guide/kernel-parameters.txt         |   2 +
 arch/Kconfig                                  |  10 +
 arch/arm64/include/asm/vmalloc.h              |  25 +
 arch/arm64/mm/mmu.c                           |  26 -
 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/vmalloc.h            |  21 +
 arch/powerpc/kernel/module.c                  |  13 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  21 -
 arch/x86/include/asm/vmalloc.h                |  23 +
 arch/x86/mm/ioremap.c                         |  19 -
 arch/x86/mm/pgtable.c                         |  13 -
 include/linux/io.h                            |   9 -
 include/linux/vmalloc.h                       |  27 ++
 init/main.c                                   |   1 -
 mm/ioremap.c                                  | 225 +--------
 mm/memory.c                                   |  66 ++-
 mm/page_alloc.c                               |   5 +-
 mm/vmalloc.c                                  | 455 +++++++++++++++---
 18 files changed, 563 insertions(+), 399 deletions(-)

-- 
2.23.0

