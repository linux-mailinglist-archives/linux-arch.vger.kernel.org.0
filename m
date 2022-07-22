Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42957DB95
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiGVHxy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiGVHxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 03:53:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCF09B195;
        Fri, 22 Jul 2022 00:53:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a18-20020a05600c349200b003a30de68697so4683791wmq.0;
        Fri, 22 Jul 2022 00:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g3X0thJEsCWIOzOzMBtExWar34oEgPFC4eBjEJc+Q/M=;
        b=jhwjXe5+00591ui1+4eJAgxNtWH0CPVmyKMMOtn6qMMVFAlZqF8nu7MYeJT29Iv93R
         iEImoFe5h6Uy4uX6muYoTtfmyiRrd7PHFIX5Tq5ltHpPYTf9EYj0vlgpi7wrLXJQYMc5
         8sUCrLoTyKecPeiGiA6QSQlQXf0F4Lug47HniAIBQFkaLfW5WcUeHcLYrhVDlMVhL8Jh
         D1UQHwJQMqcnXMmuEDMI3FzNR1has4UKW9jivIDbH4DqZo0dKen3/ANQWuV4JOIbs2AE
         185DXt46s6G8/l2ehuXNaGTD0n59QIu42I3EioBdRXqezhowUR4ZHZMu+Q0R9Zn+pS9O
         r3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g3X0thJEsCWIOzOzMBtExWar34oEgPFC4eBjEJc+Q/M=;
        b=dQs5sPj5tim7wnIl2Y1BasyKHEx7Cm5oTvTyfFvDpwmFhlgwjrXSEj+0d2IzLVStsJ
         1cmAx7RYS4njQRifual5+4e4Y3rRZy5OVo9NlnH6fyTEBi4t7vcN/XQCU+mVpdgq/7S6
         gbGITKaKBZUAnUKeZZbMvFgDOrmzeeaPsUEu5a+bWYd7iYB9izeo1eUfmk2LPh+CKsF4
         otsY06rTf04QxJdBztgCh+W+fuLz6FEtvO1M7oWiVneAcmLq6SHyw5orO7zjrhsYnALq
         Ll1797Y+1+mfukjVp3qFTJ/OF1TIfs+Ti/L79IlcU8wqEQHafAEPsFRHDyFV3peHf3ty
         BU3g==
X-Gm-Message-State: AJIora/gsApN8VzRFpHTamORa4BGQhP8PSoAQti7A90b2AKNhZPvGwhw
        O3OtsfNqdA0uOdjXagb1XxA=
X-Google-Smtp-Source: AGRyM1uZmThHHo3HU8Kz8irV9I9+G0HiM7LJisLBSmpY1M8Jn6/n8BJ73QG0fMX20r9rjuFCp9Iknw==
X-Received: by 2002:a05:600c:3b1d:b0:3a3:1fda:efcf with SMTP id m29-20020a05600c3b1d00b003a31fdaefcfmr11100899wms.49.1658476425341;
        Fri, 22 Jul 2022 00:53:45 -0700 (PDT)
Received: from debian (host-78-150-47-22.as13285.net. [78.150.47.22])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b003a2cf1535aasm4094868wme.17.2022.07.22.00.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 00:53:44 -0700 (PDT)
Date:   Fri, 22 Jul 2022 08:53:43 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: mainline build failure due to b67fbebd4cf9 ("mmu_gather: Force
 tlb-flush VM_PFNMAP vmas")
Message-ID: <YtpXh0QHWwaEWVAY@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for alpha allmodconfig
with the error:

In file included from ./arch/alpha/include/asm/tlb.h:5,
                 from mm/oom_kill.c:48:
./include/asm-generic/tlb.h:401:1: error: redefinition of 'tlb_update_vma_flags'
  401 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
      | ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/tlb.h:372:1: note: previous definition of 'tlb_update_vma_flags' with type 'void(struct mmu_gather *, struct vm_area_struct *)'
  372 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
      | ^~~~~~~~~~~~~~~~~~~~
In file included from ./arch/alpha/include/asm/tlb.h:5,
                 from arch/alpha/mm/init.c:32:
./include/asm-generic/tlb.h:401:1: error: redefinition of 'tlb_update_vma_flags'
  401 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
      | ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/tlb.h:372:1: note: previous definition of 'tlb_update_vma_flags' with type 'void(struct mmu_gather *, struct vm_area_struct *)'
  372 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
      | ^~~~~~~~~~~~~~~~~~~~
In file included from ./arch/alpha/include/asm/tlb.h:5,
                 from kernel/sched/core.c:77:
./include/asm-generic/tlb.h:401:1: error: redefinition of 'tlb_update_vma_flags'
  401 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
      | ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/tlb.h:372:1: note: previous definition of 'tlb_update_vma_flags' with type 'void(struct mmu_gather *, struct vm_area_struct *)'
  372 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
      | ^~~~~~~~~~~~~~~~~~~~
In file included from ./arch/alpha/include/asm/tlb.h:5,
                 from fs/proc/task_mmu.c:25:
./include/asm-generic/tlb.h:401:1: error: redefinition of 'tlb_update_vma_flags'
  401 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
      | ^~~~~~~~~~~~~~~~~~~~
./include/asm-generic/tlb.h:372:1: note: previous definition of 'tlb_update_vma_flags' with type 'void(struct mmu_gather *, struct vm_area_struct *)'
  372 | tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma) { }
      | ^~~~~~~~~~~~~~~~~~~~

git bisect pointed to b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas").
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

--
Regards
Sudip
