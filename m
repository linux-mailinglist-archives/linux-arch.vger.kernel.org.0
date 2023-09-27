Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE30E7B0AE1
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjI0RM2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 13:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0RM1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 13:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98738E5
        for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2023 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695834707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26ZECuIzAzrHSPBpB0H3QfUZnnLT0zZT0ILMAOLj/qo=;
        b=Iu0FckIuHOPj6bFgDRKYn5CjZgBO7esWc0XNMxt9kr5rIPsz00b5EeXWSJKkeVyr7bT/eO
        bS4cPYdlLeA3VMkj3mO/fJn0stTU4Juwq80IWKgq4LemY4BW5uExVb4abnKcrgZdSLGG4h
        R6GlqDsD1PFUapyhvq3Z5PLvyPXx3fs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-FdKk6S_4M7alcxc91Iu2gQ-1; Wed, 27 Sep 2023 13:11:46 -0400
X-MC-Unique: FdKk6S_4M7alcxc91Iu2gQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5043307ec0bso16317042e87.2
        for <linux-arch@vger.kernel.org>; Wed, 27 Sep 2023 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834704; x=1696439504;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26ZECuIzAzrHSPBpB0H3QfUZnnLT0zZT0ILMAOLj/qo=;
        b=cevN+Z8bTG7KlQGCJDyNE/GQqzALSubBLnD+5knh8lxFbFyK2sR7VuDbBnIcf8oD6V
         cwXAWnxjAIkKgZlKoSEZrLr6LmWesw2yUfwT18cDbndEgVtqlxI1t0Tm8t8G2EZ/Ft97
         HilbDXk+RfXDTuE2mbXKuG5+VBcpmI2jChQTOZKvhQQSIqQbjc7+EE/TBsX5yw8bmWHE
         8oV8aFrTXOBE0jO2kn0cAfGvJTAE6owVK+EuAUPY0ryVO3ob6M6TE4GtSRFniQ9sI6sT
         2QIKBlgcRqlwSDBXKIPO/FIQbP8bZqT2QWH1VkOh8tAMJS8rMkAvYszEQRKrmOcoFmws
         kGAA==
X-Gm-Message-State: AOJu0Ywtr5IeWgiLw0ASHdGFiyLOHtfk+g8uNyEmbCZ82wNMhvInsX9d
        g293gz17Ax0WIX9GbYchJ9hXV1aIFT9HuOJHD3JUCeaFzT3U91fbOxbJmTu0TW+ikFk1oemSqyG
        8pHG7/TBq0BjWF57KNZO7tMgXZNd+5Q==
X-Received: by 2002:a05:6512:2350:b0:502:fe11:a694 with SMTP id p16-20020a056512235000b00502fe11a694mr2554997lfu.45.1695834704176;
        Wed, 27 Sep 2023 10:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLwBPlXrmnb4AHD26hUp4ZPo2eKW8J8eyw+zBWId4dlPqrr3HlDYhpvIRYNLY7H1Jl/xXg5g==
X-Received: by 2002:a05:6512:2350:b0:502:fe11:a694 with SMTP id p16-20020a056512235000b00502fe11a694mr2554982lfu.45.1695834703656;
        Wed, 27 Sep 2023 10:11:43 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id ck15-20020a0564021c0f00b005342fa19070sm3665635edb.89.2023.09.27.10.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 10:11:42 -0700 (PDT)
Message-ID: <3c25ec6f-cd33-9445-a76f-6ec2c30755f5@redhat.com>
Date:   Wed, 27 Sep 2023 19:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/10] Fix confusion around MAX_ORDER
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, quic_jhugo@quicinc.com,
        snitzer@kernel.org, dm <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 12:31, Kirill A. Shutemov wrote:
> MAX_ORDER currently defined as number of orders page allocator supports:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> 
> This definition is counter-intuitive and lead to number of bugs all over
> the kernel.
> 
> Fix the bugs and then change the definition of MAX_ORDER to be
> inclusive: the range of orders user can ask from buddy allocator is
> 0..MAX_ORDER now.

Looks like this crossed with three changes that introduced new
uses of MAX_ORDER:

drivers/accel/qaic/qaic_data.c:         max_order = min(MAX_ORDER - 1, get_order(size));
drivers/md/dm-crypt.c:  unsigned int order = MAX_ORDER - 1;
drivers/md/dm-flakey.c: order = MAX_ORDER - 1;

The bugs are all benign, MAX_ORDER - 1 can simply be changed
to MAX_ORDER to be consistent with the new world order.

CCing relevant maintainers...

Paolo

> Kirill A. Shutemov (10):
>    sparc/mm: Fix MAX_ORDER usage in tsb_grow()
>    um: Fix MAX_ORDER usage in linux_main()
>    floppy: Fix MAX_ORDER usage
>    drm/i915: Fix MAX_ORDER usage in i915_gem_object_get_pages_internal()
>    genwqe: Fix MAX_ORDER usage
>    perf/core: Fix MAX_ORDER usage in rb_alloc_aux_page()
>    mm/page_reporting: Fix MAX_ORDER usage in page_reporting_register()
>    mm/slub: Fix MAX_ORDER usage in calculate_order()
>    iommu: Fix MAX_ORDER usage in __iommu_dma_alloc_pages()
>    mm, treewide: Redefine MAX_ORDER sanely
> 
>   .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
>   .../admin-guide/kernel-parameters.txt         |  2 +-
>   arch/arc/Kconfig                              |  4 +-
>   arch/arm/Kconfig                              |  9 ++---
>   arch/arm/configs/imx_v6_v7_defconfig          |  2 +-
>   arch/arm/configs/milbeaut_m10v_defconfig      |  2 +-
>   arch/arm/configs/oxnas_v6_defconfig           |  2 +-
>   arch/arm/configs/pxa_defconfig                |  2 +-
>   arch/arm/configs/sama7_defconfig              |  2 +-
>   arch/arm/configs/sp7021_defconfig             |  2 +-
>   arch/arm64/Kconfig                            | 27 ++++++-------
>   arch/arm64/include/asm/sparsemem.h            |  2 +-
>   arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
>   arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 10 ++---
>   arch/csky/Kconfig                             |  2 +-
>   arch/ia64/Kconfig                             |  8 ++--
>   arch/ia64/include/asm/sparsemem.h             |  4 +-
>   arch/ia64/mm/hugetlbpage.c                    |  2 +-
>   arch/loongarch/Kconfig                        | 15 +++-----
>   arch/m68k/Kconfig.cpu                         |  5 +--
>   arch/mips/Kconfig                             | 19 ++++------
>   arch/nios2/Kconfig                            |  7 +---
>   arch/powerpc/Kconfig                          | 27 ++++++-------
>   arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 +-
>   arch/powerpc/configs/fsl-emb-nonhw.config     |  2 +-
>   arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
>   arch/powerpc/mm/hugetlbpage.c                 |  2 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
>   arch/sh/configs/ecovec24_defconfig            |  2 +-
>   arch/sh/mm/Kconfig                            | 17 ++++-----
>   arch/sparc/Kconfig                            |  5 +--
>   arch/sparc/kernel/pci_sun4v.c                 |  2 +-
>   arch/sparc/kernel/traps_64.c                  |  2 +-
>   arch/sparc/mm/tsb.c                           |  4 +-
>   arch/xtensa/Kconfig                           |  5 +--
>   drivers/base/regmap/regmap-debugfs.c          |  8 ++--
>   drivers/block/floppy.c                        |  2 +-
>   drivers/crypto/ccp/sev-dev.c                  |  2 +-
>   drivers/crypto/hisilicon/sgl.c                |  6 +--
>   .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
>   drivers/gpu/drm/ttm/ttm_pool.c                | 22 +++++------
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>   drivers/iommu/dma-iommu.c                     |  4 +-
>   drivers/irqchip/irq-gic-v3-its.c              |  4 +-
>   drivers/md/dm-bufio.c                         |  2 +-
>   drivers/misc/genwqe/card_utils.c              |  2 +-
>   .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
>   drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
>   drivers/video/fbdev/hyperv_fb.c               |  4 +-
>   drivers/video/fbdev/vermilion/vermilion.c     |  2 +-
>   drivers/virtio/virtio_balloon.c               |  2 +-
>   drivers/virtio/virtio_mem.c                   | 12 +++---
>   fs/ramfs/file-nommu.c                         |  2 +-
>   include/drm/ttm/ttm_pool.h                    |  2 +-
>   include/linux/hugetlb.h                       |  2 +-
>   include/linux/mmzone.h                        | 10 ++---
>   include/linux/pageblock-flags.h               |  4 +-
>   include/linux/slab.h                          |  6 +--
>   kernel/crash_core.c                           |  2 +-
>   kernel/dma/pool.c                             |  6 +--
>   mm/Kconfig                                    |  6 +--
>   mm/compaction.c                               |  8 ++--
>   mm/debug_vm_pgtable.c                         |  4 +-
>   mm/huge_memory.c                              |  2 +-
>   mm/hugetlb.c                                  |  4 +-
>   mm/kmsan/init.c                               |  6 +--
>   mm/memblock.c                                 |  2 +-
>   mm/memory_hotplug.c                           |  4 +-
>   mm/page_alloc.c                               | 38 +++++++++----------
>   mm/page_isolation.c                           | 12 +++---
>   mm/page_owner.c                               |  6 +--
>   mm/page_reporting.c                           |  4 +-
>   mm/shuffle.h                                  |  2 +-
>   mm/slab.c                                     |  2 +-
>   mm/slub.c                                     |  4 +-
>   mm/vmscan.c                                   |  2 +-
>   mm/vmstat.c                                   | 14 +++----
>   net/smc/smc_ib.c                              |  2 +-
>   security/integrity/ima/ima_crypto.c           |  2 +-
>   tools/testing/memblock/linux/mmzone.h         |  6 +--
>   80 files changed, 210 insertions(+), 240 deletions(-)
> 

