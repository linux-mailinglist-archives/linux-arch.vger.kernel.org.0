Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8926BD6BC
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 18:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPRJo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPRJn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 13:09:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A968F528;
        Thu, 16 Mar 2023 10:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PusxSQb4ds65XY37H8tZG8zn7sbEvYsgS+aBkbr6A7cGDMHOpumj4uWKc/5Of1XSCvBsvxkfeFyZLd9EQhchHzgZoToecsuaecdJs58IF4Ri9iyjy/SIIxL41Y5mFiGK1QfefEygzrECEohZ3bpJPV7kOHlFAIGRLgbBcuqH1dTSnd7qKl0Uc7Lhkfctal92W6mVYWxv/AC7Q9AdQKuyLQZZUyQ3yggGqA7UdsziH9uTq2mI0oLWCbxHgtr3VTb+hfSyl1DCltxZ8acI/h/X0pB2hCSGU81wQyoeYekoPxrmfKijtDNNYvVP9BrC8E/vbIJyU6AjeaBgZX0YBbrQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImOKlPWaLMBn6dLLVebBWs9HN7SR1NjV8B6m3Fcpqfc=;
 b=A1NMpBwTOYp+RQVvh1Kj+vTVNKSAMPyeye7uS0HyS4+iZK2QUck6o0b8g4PRMFFb9JGqKZawofecw/I6m5stdygzlQTRl07kNRjD6PhV7FMbkOvs6OUFqjPZ9TkBAZ/GrLx4FXUGDLErzRFWRHzOB+4vG1OLlKl74burX5USdpTF6mZnxvNyPglEX5gOK5zhSDPR1/inO8VGQy1ieneRTiS2u7eHI98G65s2CfvCDFEWBMgKBM3paddQ8GJYUy+AAvu//5l5tdwV0fvVKm+pk6QWj5zQs54/epQU58LkRg19/BSaWlx/NP/ebxg9gJfwInPZyDe8gZeezP2F41OQ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImOKlPWaLMBn6dLLVebBWs9HN7SR1NjV8B6m3Fcpqfc=;
 b=PaLMaz0Ooh+4o6FiYMySxVrW88v0Cf5Ptt+4lX1yC0h5LksQyBmWV4w8kyhM2g72E0u/l+994nYurOeptxkruPIelu2J2YhI1Twtj83JtXFtwvEycrYnQ4BL6gtqqSBNjh+VNeYA00UIL8puZ7t8zurO01kdaIIaZMuYW+Ng98uMzSVdNpSuK9/Ax1bQAe5qSbL0Qowz7GrKBfTTimskNeWi/CLQxb0fXPQqd3BHeRclntUn5bzAJAudMqnO8cgyUwkldRk7+cOGF1pc7r4Z87aZDnPKMOPxp8DnShcKEtW2eVN5tveagNaXJb1yH5aH9Oyr0GFkFAHVq6dIS5vq3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 17:09:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 17:09:33 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Date:   Thu, 16 Mar 2023 13:09:30 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <06785A33-BDBD-4EEC-B063-19E1002F87D9@nvidia.com>
In-Reply-To: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1250BC76-DBD8-4544-AB2A-CA9FC07CB1BE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:208:23b::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: feac1208-e0fc-431b-c31f-08db26413631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H+v32V8mOmAFiDfZOzqpVh0idvN5soXOB1bRBpci2BEfOQAFZUhFGvuXWIrcFbpMW3bV6wIemaRqI3VoQwopBIPCbGGzqlIcOZvw6g1FbpmdWc7Ub2dGfTEy/7JtlGYO2T34u65xJPcx6O3qfxx6E94tQTKpwKAQsBXt2GrnIpbWusm6CslJuVgHgrkUvwRSbSUquLx9PP0UPXCDT7ux2bU6xSY+c9o0439KqZxFBzkD5cLYCSi7q03XBdeogaHsf74c25urbmjcz5F4a307UQILm2nPCI5CUsB7Jnmv+vvH6o64l8I5G5SCUI/UQmCC/eCYB1EfE+GHlBaR2HYZ7w/j7TmF6+3QO4isY3X1YeV0qBtK3rOpGOcITqbEJII+PPL+zX0Z8XJsvC13mnrCCEqeFBmH7xClt6runflC93P80qwoOxwU4pcX+EJw57NgW76h2ZbJt6nPHn5O40SMbkqbA5HLFuhhW3uO0VQHgugLYmZ8e4Du+Bh5QauVPXvlbDRmyDY2SG1sX9SA2JTw1/R0UgJcOhIQAwrJVJkeYQzlMb4dxXYxnfKremm0a1cYSsvVSVVMQeAOrZ9ywgKNqQAkvvhjS3rlCZTR1y3UGbsa0CMVlYK8qFJvAK9bfA6MmC3y1RXXt/FJtEzgr0bISH/PyskThD01ll4HxHBBcG4/zOCBOuRH1mWZORflnG91rR8bmpN15BPRntEavmnxq0QJfElDzLBt/dK97PqnhH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(86362001)(36756003)(6506007)(26005)(6486002)(6512007)(38100700002)(66946007)(66476007)(54906003)(478600001)(4326008)(316002)(186003)(53546011)(235185007)(2616005)(8676002)(30864003)(5660300002)(41300700001)(33656002)(8936002)(66556008)(6916009)(83380400001)(2906002)(72826004)(45980500001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIoQVfLlI1HwaI6WeXkrj17TTXozJZja5pJtSJdNvpbUw8Q8L1G3nXf1ZOnq?=
 =?us-ascii?Q?pHBcewgJYdMiGDgFps9z/Dj07kSbpBAmP4/5n9bWGOqmqEinAv5jKaLTcl2o?=
 =?us-ascii?Q?1j0ykAm4Vp3NB4wX3JJYkJd9tss96/f1SM24+du3hIqAvOVus1iP35O27zeI?=
 =?us-ascii?Q?2TgPTx0f6GxM0/XEfrPLsBgbTki6HHM26yo7GDYZeYpg01IzvTRCsHErDPcW?=
 =?us-ascii?Q?sSM7gnBXDPaGZ3s+dC1vh4mrfiCK9rEhOYPwByhQniS2vdjvFgD25RnQAx44?=
 =?us-ascii?Q?UaXJg5ykEMJS2JQ/6+PXK2f1yexX+Nt84ukLrwoeyKwMz1obeaRVCJ83+Qun?=
 =?us-ascii?Q?R297aTy+cXCRPj8dihoUp3GLhKXbh6Pg6Xl5GnBJ5Qt0BAXMpPEe0R/ZfrMR?=
 =?us-ascii?Q?Zdm0BfZRFWaC3juPvksANsVEorrDFKm//lYDiKT76eK58b4zFfWHGjJ6OorM?=
 =?us-ascii?Q?BcKRi8PdpIHhzQ6ffB88nLD50HVi+OlCgjeReROrwYYuCmcEj9YRjx1uPbZX?=
 =?us-ascii?Q?DB0EnA1oKy8xyFEIE3+2IxmF+yzIcRLoGORPWs1eiyLFvN2Aa5sMe6v2Qq9b?=
 =?us-ascii?Q?iIZyCdBCtfnGbmk+PjD1RzvUUOy3Iq1XoaVjsrTsFmFWq0gwj1iGyKydDBpE?=
 =?us-ascii?Q?YFXESvQG7hkuzti1pz9muEe1PHk1Nu3+OG40ecLxrmPaGzuKEHFX6RIfFODr?=
 =?us-ascii?Q?jKhzDc6Ix76yHUqHDTgAwMGZrwAOYDnhcDMvHvGb/EzecSfS2ZsFNzFBmd/2?=
 =?us-ascii?Q?q1HSF2MluHWBxnruzHvcmE7zHPf7B8en7neG9pqfBuaoscD+ep8lgmVIS+Ge?=
 =?us-ascii?Q?y/8lq69w8h0bOPJ8bN6r2Ax2rFWVcON2wTA7yUa29oGYqOG5ZPBBYKeTpTBf?=
 =?us-ascii?Q?yvMg/0GsfpMAsp/lVZ+hqUPdE2NoI7FJFV/o8SQJzNbTYA+FE8f0/dgJyZDx?=
 =?us-ascii?Q?7SpOQpzgnfnLjk+vJPFkgTE9T9EhIds56FK4N1jbgiBcGTUcKfUJhExfhc05?=
 =?us-ascii?Q?ANTEcnHuUyV8CaRIh5mtn415a0cE7s91JWLXoOwouaCWY4MY4aR/LChUaNRX?=
 =?us-ascii?Q?nLFA178zMPFTuUVI8Rn8Tcg5aPEM7VNKYYyUs/6TnOUgmfXZFrYNbalmYLyl?=
 =?us-ascii?Q?QJPFCtsDIayM+R5us0SdTFRrbBklD2Yc4fM7mPSnb+CCKAleXqYk9Zusahrd?=
 =?us-ascii?Q?CeNrKsmH14ej3rzfMdnbep3riDljuyboUwdLGtp+lV7Aml39vyZ6apI5rx5/?=
 =?us-ascii?Q?nw8HZbVmiPSowJWwD/4QnIpJrBPfEFU8BFRxGbQDJ3QBrMFVYCGBepYwVm0p?=
 =?us-ascii?Q?Ok0Xy2BxPWfe2VQYKfJuPL5miafFw1J/Kyv6IzGb7FlLFHpBTZeqn4xabpxL?=
 =?us-ascii?Q?BMFVloIr2zkjc5YfE90hAANzA32k7mA63dq7oEmr6VUbVQXmf0KSZnnPbgzE?=
 =?us-ascii?Q?evW85h9vwN0OhsUcEybMxGRk6VoWhfn/FF0gtKQlr0VKmNaiducS1fR2v77G?=
 =?us-ascii?Q?im/0F1srXrCed84+AnTRzGtiT9Yn6RyzpntaODEhWCDfAvtAjqtZ8FYA2tfA?=
 =?us-ascii?Q?LmPZJfokYrPaphMsomIEjwX1bgrmEMpaLUG2vUff?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feac1208-e0fc-431b-c31f-08db26413631
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 17:09:32.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Hoe0VWVkZZivGf1iCxu3BSsVTdKUhNV/ZAaTYk0ku4rwOMAi6Lw6rvn4XYbWXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=_MailMate_1250BC76-DBD8-4544-AB2A-CA9FC07CB1BE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Mar 2023, at 7:31, Kirill A. Shutemov wrote:

> MAX_ORDER currently defined as number of orders page allocator supports=
:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
>
> This definition is counter-intuitive and lead to number of bugs all ove=
r
> the kernel.
>
> Change the definition of MAX_ORDER to be inclusive: the range of orders=

> user can ask from buddy allocator is 0..MAX_ORDER now.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  .../admin-guide/kdump/vmcoreinfo.rst          |  2 +-
>  .../admin-guide/kernel-parameters.txt         |  2 +-
>  arch/arc/Kconfig                              |  4 +-
>  arch/arm/Kconfig                              |  9 ++---
>  arch/arm/configs/imx_v6_v7_defconfig          |  2 +-
>  arch/arm/configs/milbeaut_m10v_defconfig      |  2 +-
>  arch/arm/configs/oxnas_v6_defconfig           |  2 +-
>  arch/arm/configs/pxa_defconfig                |  2 +-
>  arch/arm/configs/sama7_defconfig              |  2 +-
>  arch/arm/configs/sp7021_defconfig             |  2 +-
>  arch/arm64/Kconfig                            | 27 ++++++-------
>  arch/arm64/include/asm/sparsemem.h            |  2 +-
>  arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  2 +-
>  arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 10 ++---
>  arch/csky/Kconfig                             |  2 +-
>  arch/ia64/Kconfig                             |  8 ++--
>  arch/ia64/include/asm/sparsemem.h             |  4 +-
>  arch/ia64/mm/hugetlbpage.c                    |  2 +-
>  arch/loongarch/Kconfig                        | 15 +++-----
>  arch/m68k/Kconfig.cpu                         |  5 +--
>  arch/mips/Kconfig                             | 19 ++++------
>  arch/nios2/Kconfig                            |  7 +---
>  arch/powerpc/Kconfig                          | 27 ++++++-------
>  arch/powerpc/configs/85xx/ge_imp3a_defconfig  |  2 +-
>  arch/powerpc/configs/fsl-emb-nonhw.config     |  2 +-
>  arch/powerpc/mm/book3s64/iommu_api.c          |  2 +-
>  arch/powerpc/mm/hugetlbpage.c                 |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c     |  2 +-
>  arch/sh/configs/ecovec24_defconfig            |  2 +-
>  arch/sh/mm/Kconfig                            | 17 ++++-----
>  arch/sparc/Kconfig                            |  5 +--
>  arch/sparc/kernel/pci_sun4v.c                 |  2 +-
>  arch/sparc/kernel/traps_64.c                  |  2 +-
>  arch/sparc/mm/tsb.c                           |  4 +-
>  arch/um/kernel/um_arch.c                      |  4 +-
>  arch/xtensa/Kconfig                           |  5 +--
>  drivers/base/regmap/regmap-debugfs.c          |  8 ++--
>  drivers/block/floppy.c                        |  2 +-
>  drivers/crypto/ccp/sev-dev.c                  |  2 +-
>  drivers/crypto/hisilicon/sgl.c                |  6 +--
>  drivers/gpu/drm/i915/gem/i915_gem_internal.c  |  2 +-
>  .../gpu/drm/i915/gem/selftests/huge_pages.c   |  2 +-
>  drivers/gpu/drm/ttm/ttm_pool.c                | 22 +++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
>  drivers/iommu/dma-iommu.c                     |  2 +-
>  drivers/irqchip/irq-gic-v3-its.c              |  4 +-
>  drivers/md/dm-bufio.c                         |  2 +-
>  drivers/misc/genwqe/card_dev.c                |  2 +-
>  drivers/misc/genwqe/card_utils.c              |  4 +-
>  .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  2 +-
>  drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
>  drivers/video/fbdev/hyperv_fb.c               |  4 +-
>  drivers/video/fbdev/vermilion/vermilion.c     |  2 +-
>  drivers/virtio/virtio_balloon.c               |  2 +-
>  drivers/virtio/virtio_mem.c                   | 12 +++---
>  fs/ramfs/file-nommu.c                         |  2 +-
>  include/drm/ttm/ttm_pool.h                    |  2 +-
>  include/linux/hugetlb.h                       |  2 +-
>  include/linux/mmzone.h                        | 10 ++---
>  include/linux/pageblock-flags.h               |  4 +-
>  include/linux/slab.h                          |  6 +--
>  kernel/crash_core.c                           |  2 +-
>  kernel/dma/pool.c                             |  6 +--
>  kernel/events/ring_buffer.c                   |  4 +-
>  mm/Kconfig                                    |  6 +--
>  mm/compaction.c                               |  8 ++--
>  mm/debug_vm_pgtable.c                         |  4 +-
>  mm/huge_memory.c                              |  2 +-
>  mm/hugetlb.c                                  |  4 +-
>  mm/kmsan/init.c                               |  6 +--
>  mm/memblock.c                                 |  2 +-
>  mm/memory_hotplug.c                           |  4 +-
>  mm/page_alloc.c                               | 38 +++++++++----------=

>  mm/page_isolation.c                           | 12 +++---
>  mm/page_owner.c                               |  6 +--
>  mm/page_reporting.c                           |  6 +--
>  mm/shuffle.h                                  |  2 +-
>  mm/slab.c                                     |  2 +-
>  mm/slub.c                                     |  6 +--
>  mm/vmscan.c                                   |  2 +-
>  mm/vmstat.c                                   | 14 +++----
>  net/smc/smc_ib.c                              |  2 +-
>  security/integrity/ima/ima_crypto.c           |  2 +-
>  tools/testing/memblock/linux/mmzone.h         |  6 +--
>  84 files changed, 218 insertions(+), 248 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documenta=
tion/admin-guide/kdump/vmcoreinfo.rst
> index 86fd88492870..c267b8c61e97 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -172,7 +172,7 @@ variables.
>  Offset of the free_list's member. This value is used to compute the nu=
mber
>  of free pages.
>
> -Each zone has a free_area structure array called free_area[MAX_ORDER].=

> +Each zone has a free_area structure array called free_area[MAX_ORDER +=
 1].
>  The free_list represents a linked list of free page blocks.
>
>  (list_head, next|prev)

In vmcoreinfo.rst, line 192:

- (zone.free_area, MAX_ORDER)
+ (zone.free_area, MAX_ORDER + 1)



> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> index 6221a1d057dd..50da4f26fad5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3969,7 +3969,7 @@
>  			[KNL] Minimal page reporting order
>  			Format: <integer>
>  			Adjust the minimal page reporting order. The page
> -			reporting is disabled when it exceeds (MAX_ORDER-1).
> +			reporting is disabled when it exceeds MAX_ORDER.
>
>  	panic=3D		[KNL] Kernel behaviour on panic: delay <timeout>
>  			timeout > 0: seconds before rebooting

line 942:
-		    possible value is MAX_ORDER/2.  Setting this parameter
+			possible value is (MAX_ORDER + 1)/2.  Setting this parameter

> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index d9a13ccf89a3..ab6d701365bb 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "12" if ARC_HUGEPAGE_16M
> -	default "11"
> +	default "11" if ARC_HUGEPAGE_16M
> +	default "10"
>
>  source "kernel/power/Kconfig"
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e24a9820e12f..929e646e84b9 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1355,9 +1355,9 @@ config ARM_MODULE_PLTS
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "12" if SOC_AM33XX
> -	default "9" if SA1111
> -	default "11"
> +	default "11" if SOC_AM33XX
> +	default "8" if SA1111
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -1366,9 +1366,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  config ALIGNMENT_TRAP
>  	def_bool CPU_CP15_MMU
>  	select HAVE_PROC_CPU if PROC_FS
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/im=
x_v6_v7_defconfig
> index 6dc6fed12af8..345a67e67dbd 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -31,7 +31,7 @@ CONFIG_SOC_VF610=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_ARM_PSCI=3Dy
>  CONFIG_HIGHMEM=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D14
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D13
>  CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
>  CONFIG_KEXEC=3Dy
>  CONFIG_CPU_FREQ=3Dy
> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/config=
s/milbeaut_m10v_defconfig
> index bd29e5012cb0..385ad0f391a8 100644
> --- a/arch/arm/configs/milbeaut_m10v_defconfig
> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> @@ -26,7 +26,7 @@ CONFIG_THUMB2_KERNEL=3Dy
>  # CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11 is not set
>  # CONFIG_ARM_PATCH_IDIV is not set
>  CONFIG_HIGHMEM=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D12
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D11
>  CONFIG_SECCOMP=3Dy
>  CONFIG_KEXEC=3Dy
>  CONFIG_EFI=3Dy
> diff --git a/arch/arm/configs/oxnas_v6_defconfig b/arch/arm/configs/oxn=
as_v6_defconfig
> index 70a67b3fc91b..90779812c6dd 100644
> --- a/arch/arm/configs/oxnas_v6_defconfig
> +++ b/arch/arm/configs/oxnas_v6_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ARCH_OXNAS=3Dy
>  CONFIG_MACH_OX820=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D16
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D12
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D11
>  CONFIG_SECCOMP=3Dy
>  CONFIG_ARM_APPENDED_DTB=3Dy
>  CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defc=
onfig
> index e656d3af2266..b46e39369dbb 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -20,7 +20,7 @@ CONFIG_PXA_SHARPSL=3Dy
>  CONFIG_MACH_AKITA=3Dy
>  CONFIG_MACH_BORZOI=3Dy
>  CONFIG_AEABI=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D9
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D8
>  CONFIG_CMDLINE=3D"root=3D/dev/ram0 ro"
>  CONFIG_KEXEC=3Dy
>  CONFIG_CPU_FREQ=3Dy
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_=
defconfig
> index 0d964c613d71..954112041403 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -19,7 +19,7 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=3Dy
>  # CONFIG_CACHE_L2X0 is not set
>  # CONFIG_ARM_PATCH_IDIV is not set
>  # CONFIG_CPU_SW_DOMAIN_PAN is not set
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D15
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D14
>  CONFIG_UACCESS_WITH_MEMCPY=3Dy
>  # CONFIG_ATAGS is not set
>  CONFIG_CMDLINE=3D"console=3DttyS0,115200 earlyprintk ignore_loglevel"
> diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp702=
1_defconfig
> index 5bca2eb59b86..c6448ac860b6 100644
> --- a/arch/arm/configs/sp7021_defconfig
> +++ b/arch/arm/configs/sp7021_defconfig
> @@ -17,7 +17,7 @@ CONFIG_ARCH_SUNPLUS=3Dy
>  # CONFIG_VDSO is not set
>  CONFIG_SMP=3Dy
>  CONFIG_THUMB2_KERNEL=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D12
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D11
>  CONFIG_VFP=3Dy
>  CONFIG_NEON=3Dy
>  CONFIG_MODULES=3Dy
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1023e896d46b..cb5c6aa3254e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1476,22 +1476,22 @@ config XEN
>
>  # include/linux/mmzone.h requires the following to be true:
>  #
> -#   MAX_ORDER - 1 + PAGE_SHIFT <=3D SECTION_SIZE_BITS
> +#   MAX_ORDER + PAGE_SHIFT <=3D SECTION_SIZE_BITS
>  #
> -# so the maximum value of MAX_ORDER is SECTION_SIZE_BITS + 1 - PAGE_SH=
IFT:
> +# so the maximum value of MAX_ORDER is SECTION_SIZE_BITS - PAGE_SHIFT:=

>  #
>  #     | SECTION_SIZE_BITS |  PAGE_SHIFT  |  max MAX_ORDER  |  default =
MAX_ORDER |
>  # ----+-------------------+--------------+-----------------+----------=
----------+
> -# 4K  |       27          |      12      |       16        |         1=
1         |
> -# 16K |       27          |      14      |       14        |         1=
2         |
> -# 64K |       29          |      16      |       14        |         1=
4         |
> +# 4K  |       27          |      12      |       15        |         1=
0         |
> +# 16K |       27          |      14      |       13        |         1=
1         |
> +# 64K |       29          |      16      |       13        |         1=
3         |
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
> -	default "14" if ARM64_64K_PAGES
> -	range 12 14 if ARM64_16K_PAGES
> -	default "12" if ARM64_16K_PAGES
> -	range 11 16 if ARM64_4K_PAGES
> -	default "11"
> +	default "13" if ARM64_64K_PAGES
> +	range 11 13 if ARM64_16K_PAGES
> +	default "11" if ARM64_16K_PAGES
> +	range 10 15 if ARM64_4K_PAGES
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -1500,14 +1500,11 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  	  We make sure that we can allocate up to a HugePage size for each co=
nfiguration.
>  	  Hence we have :
> -		MAX_ORDER =3D (PMD_SHIFT - PAGE_SHIFT) + 1 =3D> PAGE_SHIFT - 2
> +		MAX_ORDER =3D PMD_SHIFT - PAGE_SHIFT  =3D> PAGE_SHIFT - 3
>
> -	  However for 4K, we choose a higher default value, 11 as opposed to =
10, giving us
> +	  However for 4K, we choose a higher default value, 10 as opposed to =
9, giving us
>  	  4M allocations matching the default size used by generic code.
>
>  config UNMAP_KERNEL_AT_EL0
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/as=
m/sparsemem.h
> index 4b73463423c3..5f5437621029 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -10,7 +10,7 @@
>  /*
>   * Section size must be at least 512MB for 64K base
>   * page size config. Otherwise it will be less than
> - * (MAX_ORDER - 1) and the build process will fail.
> + * MAX_ORDER and the build process will fail.
>   */
>  #ifdef CONFIG_ARM64_64K_PAGES
>  #define SECTION_SIZE_BITS 29
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp=
/include/nvhe/gfp.h
> index 0a048dc06a7d..fe5472a184a3 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
> @@ -16,7 +16,7 @@ struct hyp_pool {
>  	 * API at EL2.
>  	 */
>  	hyp_spinlock_t lock;
> -	struct list_head free_area[MAX_ORDER];
> +	struct list_head free_area[MAX_ORDER + 1];
>  	phys_addr_t range_start;
>  	phys_addr_t range_end;
>  	unsigned short max_order;
> diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/=
nvhe/page_alloc.c
> index 803ba3222e75..b1e392186a0f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> +++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
> @@ -110,7 +110,7 @@ static void __hyp_attach_page(struct hyp_pool *pool=
,
>  	 * after coalescing, so make sure to mark it HYP_NO_ORDER proactively=
=2E
>  	 */
>  	p->order =3D HYP_NO_ORDER;
> -	for (; (order + 1) < pool->max_order; order++) {
> +	for (; (order + 1) <=3D pool->max_order; order++) {
>  		buddy =3D __find_buddy_avail(pool, p, order);
>  		if (!buddy)
>  			break;
> @@ -203,9 +203,9 @@ void *hyp_alloc_pages(struct hyp_pool *pool, unsign=
ed short order)
>  	hyp_spin_lock(&pool->lock);
>
>  	/* Look for a high-enough-order page */
> -	while (i < pool->max_order && list_empty(&pool->free_area[i]))
> +	while (i <=3D pool->max_order && list_empty(&pool->free_area[i]))
>  		i++;
> -	if (i >=3D pool->max_order) {
> +	if (i > pool->max_order) {
>  		hyp_spin_unlock(&pool->lock);
>  		return NULL;
>  	}
> @@ -228,8 +228,8 @@ int hyp_pool_init(struct hyp_pool *pool, u64 pfn, u=
nsigned int nr_pages,
>  	int i;
>
>  	hyp_spin_lock_init(&pool->lock);
> -	pool->max_order =3D min(MAX_ORDER, get_order((nr_pages + 1) << PAGE_S=
HIFT));
> -	for (i =3D 0; i < pool->max_order; i++)
> +	pool->max_order =3D min(MAX_ORDER, get_order(nr_pages << PAGE_SHIFT))=
;
> +	for (i =3D 0; i <=3D pool->max_order; i++)
>  		INIT_LIST_HEAD(&pool->free_area[i]);
>  	pool->range_start =3D phys;
>  	pool->range_end =3D phys + (nr_pages << PAGE_SHIFT);
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index dba02da6fa34..c694fac43bed 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -334,7 +334,7 @@ config HIGHMEM
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "11"
> +	default "10"
>
>  config DRAM_BASE
>  	hex "DRAM start addr (the same with memory-section in dts)"
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index d7e4a24e8644..0d2f41fa56ee 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -202,10 +202,10 @@ config IA64_CYCLONE
>  	  If you're unsure, answer N.
>
>  config ARCH_FORCE_MAX_ORDER
> -	int "MAX_ORDER (11 - 17)"  if !HUGETLB_PAGE
> -	range 11 17  if !HUGETLB_PAGE
> -	default "17" if HUGETLB_PAGE
> -	default "11"
> +	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
> +	range 10 16  if !HUGETLB_PAGE
> +	default "16" if HUGETLB_PAGE
> +	default "10"
>
>  config SMP
>  	bool "Symmetric multi-processing support"
> diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/=
sparsemem.h
> index 84e8ce387b69..a58f8b466d96 100644
> --- a/arch/ia64/include/asm/sparsemem.h
> +++ b/arch/ia64/include/asm/sparsemem.h
> @@ -12,9 +12,9 @@
>  #define SECTION_SIZE_BITS	(30)
>  #define MAX_PHYSMEM_BITS	(50)
>  #ifdef CONFIG_ARCH_FORCE_MAX_ORDER
> -#if ((CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BIT=
S)
> +#if (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT > SECTION_SIZE_BITS)
>  #undef SECTION_SIZE_BITS
> -#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER - 1 + PAGE_SHIF=
T)
> +#define SECTION_SIZE_BITS (CONFIG_ARCH_FORCE_MAX_ORDER + PAGE_SHIFT)
>  #endif
>  #endif
>
> diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
> index 380d2f3966c9..e8dd4323fb86 100644
> --- a/arch/ia64/mm/hugetlbpage.c
> +++ b/arch/ia64/mm/hugetlbpage.c
> @@ -170,7 +170,7 @@ static int __init hugetlb_setup_sz(char *str)
>  	size =3D memparse(str, &str);
>  	if (*str || !is_power_of_2(size) || !(tr_pages & size) ||
>  		size <=3D PAGE_SIZE ||
> -		size >=3D (1UL << PAGE_SHIFT << MAX_ORDER)) {
> +		size > (1UL << PAGE_SHIFT << MAX_ORDER)) {
>  		printk(KERN_WARNING "Invalid huge page size specified\n");
>  		return 1;
>  	}
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 7fd51257e0ed..272a3a12c98d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -420,12 +420,12 @@ config NODES_SHIFT
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 14 64 if PAGE_SIZE_64KB
> -	default "14" if PAGE_SIZE_64KB
> -	range 12 64 if PAGE_SIZE_16KB
> -	default "12" if PAGE_SIZE_16KB
> -	range 11 64
> -	default "11"
> +	range 13 63 if PAGE_SIZE_64KB
> +	default "13" if PAGE_SIZE_64KB
> +	range 11 63 if PAGE_SIZE_16KB
> +	default "11" if PAGE_SIZE_16KB
> +	range 10 63
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -434,9 +434,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  	  The page size is not necessarily 4KB.  Keep this in mind
>  	  when choosing a value for this option.
>
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 9380f6e3bb66..c9df6572133f 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -400,7 +400,7 @@ config SINGLE_MEMORY_CHUNK
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order" if ADVANCED
>  	depends on !SINGLE_MEMORY_CHUNK
> -	default "11"
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -413,9 +413,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  value also defines the minimal size of the hole that allows
>  	  freeing unused memory map.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  config 060_WRITETHROUGH
>  	bool "Use write-through caching for 68060 supervisor accesses"
>  	depends on ADVANCED && M68060
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index e2f3ca73f40d..3e8b765b8c7b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2137,14 +2137,14 @@ endchoice
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 14 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> -	default "14" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> -	range 13 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> -	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> -	range 12 64 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> -	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> -	range 0 64
> -	default "11"
> +	range 13 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> +	default "13" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_64KB
> +	range 12 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> +	default "12" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_32KB
> +	range 11 63 if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> +	default "11" if MIPS_HUGE_TLB_SUPPORT && PAGE_SIZE_16KB
> +	range 0 63
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -2153,9 +2153,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  	  The page size is not necessarily 4KB.  Keep this in mind
>  	  when choosing a value for this option.
>
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index a582f72104f3..89708b95978c 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -46,8 +46,8 @@ source "kernel/Kconfig.hz"
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 9 20
> -	default "11"
> +	range 8 19
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -56,9 +56,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  endmenu
>
>  source "arch/nios2/platform/Kconfig.platform"
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a6c4407d3ec8..90bc0c7f2728 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -896,18 +896,18 @@ config DATA_SHIFT
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 8 9 if PPC64 && PPC_64K_PAGES
> -	default "9" if PPC64 && PPC_64K_PAGES
> -	range 13 13 if PPC64 && !PPC_64K_PAGES
> -	default "13" if PPC64 && !PPC_64K_PAGES
> -	range 9 64 if PPC32 && PPC_16K_PAGES
> -	default "9" if PPC32 && PPC_16K_PAGES
> -	range 7 64 if PPC32 && PPC_64K_PAGES
> -	default "7" if PPC32 && PPC_64K_PAGES
> -	range 5 64 if PPC32 && PPC_256K_PAGES
> -	default "5" if PPC32 && PPC_256K_PAGES
> -	range 11 64
> -	default "11"
> +	range 7 8 if PPC64 && PPC_64K_PAGES
> +	default "8" if PPC64 && PPC_64K_PAGES
> +	range 12 12 if PPC64 && !PPC_64K_PAGES
> +	default "12" if PPC64 && !PPC_64K_PAGES
> +	range 8 63 if PPC32 && PPC_16K_PAGES
> +	default "8" if PPC32 && PPC_16K_PAGES
> +	range 6 63 if PPC32 && PPC_64K_PAGES
> +	default "6" if PPC32 && PPC_64K_PAGES
> +	range 4 63 if PPC32 && PPC_256K_PAGES
> +	default "4" if PPC32 && PPC_256K_PAGES
> +	range 10 63
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -916,9 +916,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  	  The page size is not necessarily 4KB.  For example, on 64-bit
>  	  systems, 64KB pages can be enabled via CONFIG_PPC_64K_PAGES.  Keep
>  	  this in mind when choosing a value for this option.
> diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerp=
c/configs/85xx/ge_imp3a_defconfig
> index ea719898b581..6cb7e90d52c1 100644
> --- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
> +++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
> @@ -30,7 +30,7 @@ CONFIG_PREEMPT=3Dy
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_BINFMT_MISC=3Dm
>  CONFIG_MATH_EMULATION=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D17
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D16
>  CONFIG_PCI=3Dy
>  CONFIG_PCIEPORTBUS=3Dy
>  CONFIG_PCI_MSI=3Dy
> diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/c=
onfigs/fsl-emb-nonhw.config
> index ab8a8c4530d9..3009b0efaf34 100644
> --- a/arch/powerpc/configs/fsl-emb-nonhw.config
> +++ b/arch/powerpc/configs/fsl-emb-nonhw.config
> @@ -41,7 +41,7 @@ CONFIG_FIXED_PHY=3Dy
>  CONFIG_FONT_8x16=3Dy
>  CONFIG_FONT_8x8=3Dy
>  CONFIG_FONTS=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D13
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D12
>  CONFIG_FRAMEBUFFER_CONSOLE=3Dy
>  CONFIG_FRAME_WARN=3D1024
>  CONFIG_FTL=3Dy
> diff --git a/arch/powerpc/mm/book3s64/iommu_api.c b/arch/powerpc/mm/boo=
k3s64/iommu_api.c
> index 7fcfba162e0d..81d7185e2ae8 100644
> --- a/arch/powerpc/mm/book3s64/iommu_api.c
> +++ b/arch/powerpc/mm/book3s64/iommu_api.c
> @@ -97,7 +97,7 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, u=
nsigned long ua,
>  	}
>
>  	mmap_read_lock(mm);
> -	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER - 1)) /
> +	chunk =3D (1UL << (PAGE_SHIFT + MAX_ORDER)) /
>  			sizeof(struct vm_area_struct *);
>  	chunk =3D min(chunk, entries);
>  	for (entry =3D 0; entry < entries; entry +=3D chunk) {
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpag=
e.c
> index f1ba8d1e8c1a..b900933507da 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -615,7 +615,7 @@ void __init gigantic_hugetlb_cma_reserve(void)
>  		order =3D mmu_psize_to_shift(MMU_PAGE_16G) - PAGE_SHIFT;
>
>  	if (order) {
> -		VM_WARN_ON(order < MAX_ORDER);
> +		VM_WARN_ON(order <=3D MAX_ORDER);
>  		hugetlb_cma_reserve(order);
>  	}
>  }
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/p=
latforms/powernv/pci-ioda.c
> index 4f6e20a35aa1..5a81f106068e 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1740,7 +1740,7 @@ static long pnv_pci_ioda2_setup_default_config(st=
ruct pnv_ioda_pe *pe)
>  	 * DMA window can be larger than available memory, which will
>  	 * cause errors later.
>  	 */
> -	const u64 maxblock =3D 1UL << (PAGE_SHIFT + MAX_ORDER - 1);
> +	const u64 maxblock =3D 1UL << (PAGE_SHIFT + MAX_ORDER);
>
>  	/*
>  	 * We create the default window as big as we can. The constraint is
> diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecove=
c24_defconfig
> index b52e14ccb450..4d655e8d4d74 100644
> --- a/arch/sh/configs/ecovec24_defconfig
> +++ b/arch/sh/configs/ecovec24_defconfig
> @@ -8,7 +8,7 @@ CONFIG_MODULES=3Dy
>  CONFIG_MODULE_UNLOAD=3Dy
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_CPU_SUBTYPE_SH7724=3Dy
> -CONFIG_ARCH_FORCE_MAX_ORDER=3D12
> +CONFIG_ARCH_FORCE_MAX_ORDER=3D11
>  CONFIG_MEMORY_SIZE=3D0x10000000
>  CONFIG_FLATMEM_MANUAL=3Dy
>  CONFIG_SH_ECOVEC=3Dy
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index 411fdc0901f7..40271090bd7d 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -20,13 +20,13 @@ config PAGE_OFFSET
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	range 9 64 if PAGE_SIZE_16KB
> -	default "9" if PAGE_SIZE_16KB
> -	range 7 64 if PAGE_SIZE_64KB
> -	default "7" if PAGE_SIZE_64KB
> -	range 11 64
> -	default "14" if !MMU
> -	default "11"
> +	range 8 63 if PAGE_SIZE_16KB
> +	default "8" if PAGE_SIZE_16KB
> +	range 6 63 if PAGE_SIZE_64KB
> +	default "6" if PAGE_SIZE_64KB
> +	range 10 63
> +	default "13" if !MMU
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -35,9 +35,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  	  The page size is not necessarily 4KB. Keep this in mind when
>  	  choosing a value for this option.
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 84437a4c6545..e3242bf5a8df 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -271,7 +271,7 @@ config ARCH_SPARSEMEM_DEFAULT
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "13"
> +	default "12"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -280,9 +280,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 13 means that the largest free memory block is 2^12 page=
s.
> -
>  if SPARC64 || COMPILE_TEST
>  source "kernel/power/Kconfig"
>  endif
> diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4=
v.c
> index 384480971805..7d91ca6aa675 100644
> --- a/arch/sparc/kernel/pci_sun4v.c
> +++ b/arch/sparc/kernel/pci_sun4v.c
> @@ -193,7 +193,7 @@ static void *dma_4v_alloc_coherent(struct device *d=
ev, size_t size,
>
>  	size =3D IO_PAGE_ALIGN(size);
>  	order =3D get_order(size);
> -	if (unlikely(order >=3D MAX_ORDER))
> +	if (unlikely(order > MAX_ORDER))
>  		return NULL;
>
>  	npages =3D size >> IO_PAGE_SHIFT;
> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.=
c
> index 5b4de4a89dec..08ffd17d5ec3 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> @@ -897,7 +897,7 @@ void __init cheetah_ecache_flush_init(void)
>
>  	/* Now allocate error trap reporting scoreboard. */
>  	sz =3D NR_CPUS * (2 * sizeof(struct cheetah_err_info));
> -	for (order =3D 0; order < MAX_ORDER; order++) {
> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  		if ((PAGE_SIZE << order) >=3D sz)
>  			break;
>  	}
> diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
> index dba8dffe2113..5e2931a18409 100644
> --- a/arch/sparc/mm/tsb.c
> +++ b/arch/sparc/mm/tsb.c
> @@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long t=
sb_index, unsigned long rss)
>  	unsigned long new_rss_limit;
>  	gfp_t gfp_flags;
>
> -	if (max_tsb_size > (PAGE_SIZE << (MAX_ORDER - 1)))
> -		max_tsb_size =3D (PAGE_SIZE << (MAX_ORDER - 1));
> +	if (max_tsb_size > PAGE_SIZE << MAX_ORDER)
> +		max_tsb_size =3D PAGE_SIZE << MAX_ORDER;
>
>  	new_cache_index =3D 0;
>  	for (new_size =3D 8192; new_size < max_tsb_size; new_size <<=3D 1UL) =
{
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 5e5a9c8e0e5d..8dcda617b8bf 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -368,10 +368,10 @@ int __init linux_main(int argc, char **argv)
>  	max_physmem =3D TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
>
>  	/*
> -	 * Zones have to begin on a 1 << MAX_ORDER-1 page boundary,
> +	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
>  	 * so this makes sure that's true for highmem
>  	 */
> -	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_ORDER - 1)) - 1);
> +	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
>  	if (physmem_size + iomem_size > max_physmem) {
>  		highmem =3D physmem_size + iomem_size - max_physmem;
>  		physmem_size -=3D highmem;
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index bcb0c5d2abc2..3eee334ba873 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -773,7 +773,7 @@ config HIGHMEM
>
>  config ARCH_FORCE_MAX_ORDER
>  	int "Maximum zone order"
> -	default "11"
> +	default "10"
>  	help
>  	  The kernel memory allocator divides physically contiguous memory
>  	  blocks into "zones", where each zone is a power of two number of
> @@ -782,9 +782,6 @@ config ARCH_FORCE_MAX_ORDER
>  	  blocks of physically contiguous memory, then you may need to
>  	  increase this value.
>
> -	  This config option is actually maximum order plus one. For example,=

> -	  a value of 11 means that the largest free memory block is 2^10 page=
s.
> -
>  endmenu
>
>  menu "Power management options"
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap=
/regmap-debugfs.c
> index 817eda2075aa..c491fabe3617 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -226,8 +226,8 @@ static ssize_t regmap_read_debugfs(struct regmap *m=
ap, unsigned int from,
>  	if (*ppos < 0 || !count)
>  		return -EINVAL;
>
> -	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> -		count =3D PAGE_SIZE << (MAX_ORDER - 1);
> +	if (count > (PAGE_SIZE << MAX_ORDER))
> +		count =3D PAGE_SIZE << MAX_ORDER;
>
>  	buf =3D kmalloc(count, GFP_KERNEL);
>  	if (!buf)
> @@ -373,8 +373,8 @@ static ssize_t regmap_reg_ranges_read_file(struct f=
ile *file,
>  	if (*ppos < 0 || !count)
>  		return -EINVAL;
>
> -	if (count > (PAGE_SIZE << (MAX_ORDER - 1)))
> -		count =3D PAGE_SIZE << (MAX_ORDER - 1);
> +	if (count > (PAGE_SIZE << MAX_ORDER))
> +		count =3D PAGE_SIZE << MAX_ORDER;
>
>  	buf =3D kmalloc(count, GFP_KERNEL);
>  	if (!buf)
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 90d2dfb6448e..cec2c20f5e59 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -3079,7 +3079,7 @@ static void raw_cmd_free(struct floppy_raw_cmd **=
ptr)
>  	}
>  }
>
> -#define MAX_LEN (1UL << (MAX_ORDER - 1) << PAGE_SHIFT)
> +#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
>
>  static int raw_cmd_copyin(int cmd, void __user *param,
>  				 struct floppy_raw_cmd **rcmd)
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.=
c
> index e2f25926eb51..bf095baca244 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -886,7 +886,7 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cm=
d *argp)
>  		/*
>  		 * The length of the ID shouldn't be assumed by software since
>  		 * it may change in the future.  The allocation size is limited
> -		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
> +		 * to 1 << (PAGE_SHIFT + MAX_ORDER) by the page allocator.
>  		 * If the allocation fails, simply return ENOMEM rather than
>  		 * warning in the kernel log.
>  		 */
> diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/=
sgl.c
> index 09586a837b1e..3df7a256e919 100644
> --- a/drivers/crypto/hisilicon/sgl.c
> +++ b/drivers/crypto/hisilicon/sgl.c
> @@ -70,11 +70,11 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(=
struct device *dev,
>  			 HISI_ACC_SGL_ALIGN_SIZE);
>
>  	/*
> -	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^(MAX=
_ORDER - 1),
> +	 * the pool may allocate a block of memory of size PAGE_SIZE * 2^MAX_=
ORDER,
>  	 * block size may exceed 2^31 on ia64, so the max of block size is 2^=
31
>  	 */
> -	block_size =3D 1 << (PAGE_SHIFT + MAX_ORDER <=3D 32 ?
> -			   PAGE_SHIFT + MAX_ORDER - 1 : 31);
> +	block_size =3D 1 << (PAGE_SHIFT + MAX_ORDER < 32 ?
> +			   PAGE_SHIFT + MAX_ORDER : 31);
>  	sgl_num_per_block =3D block_size / sgl_size;
>  	block_num =3D count / sgl_num_per_block;
>  	remain_sgl =3D count % sgl_num_per_block;
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu=
/drm/i915/gem/i915_gem_internal.c
> index eae9e9f6d3bf..6bc26b4b06b8 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> @@ -36,7 +36,7 @@ static int i915_gem_object_get_pages_internal(struct =
drm_i915_gem_object *obj)
>  	struct sg_table *st;
>  	struct scatterlist *sg;
>  	unsigned int npages; /* restricted by sg_alloc_table */
> -	int max_order =3D MAX_ORDER - 1;
> +	int max_order =3D MAX_ORDER;
>  	unsigned int max_segment;
>  	gfp_t gfp;
>
> diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/=
gpu/drm/i915/gem/selftests/huge_pages.c
> index defece0bcb81..99f39a5feca1 100644
> --- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
> @@ -115,7 +115,7 @@ static int get_huge_pages(struct drm_i915_gem_objec=
t *obj)
>  		do {
>  			struct page *page;
>
> -			GEM_BUG_ON(order >=3D MAX_ORDER);
> +			GEM_BUG_ON(order > MAX_ORDER);
>  			page =3D alloc_pages(GFP | __GFP_ZERO, order);
>  			if (!page)
>  				goto err;
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_p=
ool.c
> index aa116a7bbae3..6c8585abe08d 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -65,11 +65,11 @@ module_param(page_pool_size, ulong, 0644);
>
>  static atomic_long_t allocated_pages;
>
> -static struct ttm_pool_type global_write_combined[MAX_ORDER];
> -static struct ttm_pool_type global_uncached[MAX_ORDER];
> +static struct ttm_pool_type global_write_combined[MAX_ORDER + 1];
> +static struct ttm_pool_type global_uncached[MAX_ORDER + 1];
>
> -static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER];
> -static struct ttm_pool_type global_dma32_uncached[MAX_ORDER];
> +static struct ttm_pool_type global_dma32_write_combined[MAX_ORDER + 1]=
;
> +static struct ttm_pool_type global_dma32_uncached[MAX_ORDER + 1];
>
>  static spinlock_t shrinker_lock;
>  static struct list_head shrinker_list;
> @@ -405,7 +405,7 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct tt=
m_tt *tt,
>  	else
>  		gfp_flags |=3D GFP_HIGHUSER;
>
> -	for (order =3D min_t(unsigned int, MAX_ORDER - 1, __fls(num_pages));
> +	for (order =3D min_t(unsigned int, MAX_ORDER, __fls(num_pages));
>  	     num_pages;
>  	     order =3D min_t(unsigned int, order, __fls(num_pages))) {
>  		struct ttm_pool_type *pt;
> @@ -542,7 +542,7 @@ void ttm_pool_init(struct ttm_pool *pool, struct de=
vice *dev,
>
>  	if (use_dma_alloc) {
>  		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
> -			for (j =3D 0; j < MAX_ORDER; ++j)
> +			for (j =3D 0; j <=3D MAX_ORDER; ++j)
>  				ttm_pool_type_init(&pool->caching[i].orders[j],
>  						   pool, i, j);
>  	}
> @@ -562,7 +562,7 @@ void ttm_pool_fini(struct ttm_pool *pool)
>
>  	if (pool->use_dma_alloc) {
>  		for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i)
> -			for (j =3D 0; j < MAX_ORDER; ++j)
> +			for (j =3D 0; j <=3D MAX_ORDER; ++j)
>  				ttm_pool_type_fini(&pool->caching[i].orders[j]);
>  	}
>
> @@ -616,7 +616,7 @@ static void ttm_pool_debugfs_header(struct seq_file=
 *m)
>  	unsigned int i;
>
>  	seq_puts(m, "\t ");
> -	for (i =3D 0; i < MAX_ORDER; ++i)
> +	for (i =3D 0; i <=3D MAX_ORDER; ++i)
>  		seq_printf(m, " ---%2u---", i);
>  	seq_puts(m, "\n");
>  }
> @@ -627,7 +627,7 @@ static void ttm_pool_debugfs_orders(struct ttm_pool=
_type *pt,
>  {
>  	unsigned int i;
>
> -	for (i =3D 0; i < MAX_ORDER; ++i)
> +	for (i =3D 0; i <=3D MAX_ORDER; ++i)
>  		seq_printf(m, " %8u", ttm_pool_type_count(&pt[i]));
>  	seq_puts(m, "\n");
>  }
> @@ -736,7 +736,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  	spin_lock_init(&shrinker_lock);
>  	INIT_LIST_HEAD(&shrinker_list);
>
> -	for (i =3D 0; i < MAX_ORDER; ++i) {
> +	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
>  		ttm_pool_type_init(&global_write_combined[i], NULL,
>  				   ttm_write_combined, i);
>  		ttm_pool_type_init(&global_uncached[i], NULL, ttm_uncached, i);
> @@ -769,7 +769,7 @@ void ttm_pool_mgr_fini(void)
>  {
>  	unsigned int i;
>
> -	for (i =3D 0; i < MAX_ORDER; ++i) {
> +	for (i =3D 0; i <=3D MAX_ORDER; ++i) {
>  		ttm_pool_type_fini(&global_write_combined[i]);
>  		ttm_pool_type_fini(&global_uncached[i]);
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iomm=
u/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8d772ea8a583..b574c58a3487 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -182,7 +182,7 @@
>  #ifdef CONFIG_CMA_ALIGNMENT
>  #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + CONFIG_CMA_ALIGNMENT)
>  #else
> -#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER - 1)
> +#define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_ORDER)
>  #endif
>
>  /*
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ac996fd6bd9c..7a9f0b0bddbd 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -736,7 +736,7 @@ static struct page **__iommu_dma_alloc_pages(struct=
 device *dev,
>  	struct page **pages;
>  	unsigned int i =3D 0, nid =3D dev_to_node(dev);
>
> -	order_mask &=3D GENMASK(MAX_ORDER - 1, 0);
> +	order_mask &=3D GENMASK(MAX_ORDER, 0);
>  	if (!order_mask)
>  		return NULL;
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic=
-v3-its.c
> index 586271b8aa39..85790b870877 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2440,8 +2440,8 @@ static bool its_parse_indirect_baser(struct its_n=
ode *its,
>  	 * feature is not supported by hardware.
>  	 */
>  	new_order =3D max_t(u32, get_order(esz << ids), new_order);
> -	if (new_order >=3D MAX_ORDER) {
> -		new_order =3D MAX_ORDER - 1;
> +	if (new_order > MAX_ORDER) {
> +		new_order =3D MAX_ORDER;
>  		ids =3D ilog2(PAGE_ORDER_TO_SIZE(new_order) / (int)esz);
>  		pr_warn("ITS@%pa: %s Table too large, reduce ids %llu->%u\n",
>  			&its->phys_base, its_base_type_string[type],
> diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> index cf077f9b30c3..733053c2eaa0 100644
> --- a/drivers/md/dm-bufio.c
> +++ b/drivers/md/dm-bufio.c
> @@ -408,7 +408,7 @@ static void __cache_size_refresh(void)
>   * If the allocation may fail we use __get_free_pages. Memory fragment=
ation
>   * won't have a fatal effect here, but it just causes flushes of some =
other
>   * buffers and more I/O will be performed. Don't use __get_free_pages =
if it
> - * always fails (i.e. order >=3D MAX_ORDER).
> + * always fails (i.e. order > MAX_ORDER).
>   *
>   * If the allocation shouldn't fail we use __vmalloc. This is only for=
 the
>   * initial reserve allocation, so there's no risk of wasting all vmall=
oc
> diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_=
dev.c
> index d0e27438a73c..55fc5b80e649 100644
> --- a/drivers/misc/genwqe/card_dev.c
> +++ b/drivers/misc/genwqe/card_dev.c
> @@ -443,7 +443,7 @@ static int genwqe_mmap(struct file *filp, struct vm=
_area_struct *vma)
>  	if (vsize =3D=3D 0)
>  		return -EINVAL;
>
> -	if (get_order(vsize) >=3D MAX_ORDER)
> +	if (get_order(vsize) > MAX_ORDER)
>  		return -ENOMEM;
>
>  	dma_map =3D kzalloc(sizeof(struct dma_mapping), GFP_KERNEL);
> diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/car=
d_utils.c
> index ac29698d085a..1c798d6b2dfb 100644
> --- a/drivers/misc/genwqe/card_utils.c
> +++ b/drivers/misc/genwqe/card_utils.c
> @@ -210,7 +210,7 @@ u32 genwqe_crc32(u8 *buff, size_t len, u32 init)
>  void *__genwqe_alloc_consistent(struct genwqe_dev *cd, size_t size,
>  			       dma_addr_t *dma_handle)
>  {
> -	if (get_order(size) >=3D MAX_ORDER)
> +	if (get_order(size) > MAX_ORDER)
>  		return NULL;
>
>  	return dma_alloc_coherent(&cd->pci_dev->dev, size, dma_handle,
> @@ -308,7 +308,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, st=
ruct genwqe_sgl *sgl,
>  	sgl->write =3D write;
>  	sgl->sgl_size =3D genwqe_sgl_size(sgl->nr_pages);
>
> -	if (get_order(sgl->sgl_size) >=3D MAX_ORDER) {
> +	if (get_order(sgl->sgl_size) > MAX_ORDER) {
>  		dev_err(&pci_dev->dev,
>  			"[%s] err: too much memory requested!\n", __func__);
>  		return ret;
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/=
net/ethernet/hisilicon/hns3/hns3_enet.c
> index 25be7f8ac7cd..3973ca6adf4c 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -1041,7 +1041,7 @@ static void hns3_init_tx_spare_buffer(struct hns3=
_enet_ring *ring)
>  		return;
>
>  	order =3D get_order(alloc_size);
> -	if (order >=3D MAX_ORDER) {
> +	if (order > MAX_ORDER) {
>  		if (net_ratelimit())
>  			dev_warn(ring_to_dev(ring), "failed to allocate tx spare buffer, ex=
ceed to max order\n");
>  		return;
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/=
ibm/ibmvnic.h
> index b35c9b6f913b..4e18b4cefa97 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.h
> +++ b/drivers/net/ethernet/ibm/ibmvnic.h
> @@ -75,7 +75,7 @@
>   * pool for the 4MB. Thus the 16 Rx and Tx queues require 32 * 5 =3D 1=
60
>   * plus 16 for the TSO pools for a total of 176 LTB mappings per VNIC.=

>   */
> -#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << (MAX_ORDER - 1)) * PAGE_SIZE)=
)
> +#define IBMVNIC_ONE_LTB_MAX	((u32)((1 << MAX_ORDER) * PAGE_SIZE))
>  #define IBMVNIC_ONE_LTB_SIZE	min((u32)(8 << 20), IBMVNIC_ONE_LTB_MAX)
>  #define IBMVNIC_LTB_SET_SIZE	(38 << 20)
>
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hype=
rv_fb.c
> index ec3f6cf05f8c..34781dec3856 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -946,7 +946,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device=
 *hdev,
>  	if (request_size =3D=3D 0)
>  		return -1;
>
> -	if (order < MAX_ORDER) {
> +	if (order <=3D MAX_ORDER) {
>  		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
>  		page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
>  		if (!page)
> @@ -977,7 +977,7 @@ static void hvfb_release_phymem(struct hv_device *h=
dev,
>  {
>  	unsigned int order =3D get_order(size);
>
> -	if (order < MAX_ORDER)
> +	if (order <=3D MAX_ORDER)
>  		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
>  	else
>  		dma_free_coherent(&hdev->device,
> diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/=
fbdev/vermilion/vermilion.c
> index 0374ee6b6d03..32e74e02a02f 100644
> --- a/drivers/video/fbdev/vermilion/vermilion.c
> +++ b/drivers/video/fbdev/vermilion/vermilion.c
> @@ -197,7 +197,7 @@ static int vmlfb_alloc_vram(struct vml_info *vinfo,=

>  		va =3D &vinfo->vram[i];
>  		order =3D 0;
>
> -		while (requested > (PAGE_SIZE << order) && order < MAX_ORDER)
> +		while (requested > (PAGE_SIZE << order) && order <=3D MAX_ORDER)
>  			order++;
>
>  		err =3D vmlfb_alloc_vram_area(va, order, 0);
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 3f78a3a1eb75..5b15936a5214 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -33,7 +33,7 @@
>  #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOW=
ARN | \
>  					     __GFP_NOMEMALLOC)
>  /* The order of free page blocks to report to host */
> -#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
> +#define VIRTIO_BALLOON_HINT_BLOCK_ORDER MAX_ORDER
>  /* The size of a free page block in bytes */
>  #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
>  	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 0c2892ec6817..835f6cc2fb66 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1120,13 +1120,13 @@ static void virtio_mem_clear_fake_offline(unsig=
ned long pfn,
>   */
>  static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr=
_pages)
>  {
> -	unsigned long order =3D MAX_ORDER - 1;
> +	unsigned long order =3D MAX_ORDER;
>  	unsigned long i;
>
>  	/*
>  	 * We might get called for ranges that don't cover properly aligned
> -	 * MAX_ORDER - 1 pages; however, we can only online properly aligned
> -	 * pages with an order of MAX_ORDER - 1 at maximum.
> +	 * MAX_ORDER pages; however, we can only online properly aligned
> +	 * pages with an order of MAX_ORDER at maximum.
>  	 */
>  	while (!IS_ALIGNED(pfn | nr_pages, 1 << order))
>  		order--;
> @@ -1237,9 +1237,9 @@ static void virtio_mem_online_page(struct virtio_=
mem *vm,
>  	bool do_online;
>
>  	/*
> -	 * We can get called with any order up to MAX_ORDER - 1. If our
> -	 * subblock size is smaller than that and we have a mixture of plugge=
d
> -	 * and unplugged subblocks within such a page, we have to process in
> +	 * We can get called with any order up to MAX_ORDER. If our subblock
> +	 * size is smaller than that and we have a mixture of plugged and
> +	 * unplugged subblocks within such a page, we have to process in
>  	 * smaller granularity. In that case we'll adjust the order exactly o=
nce
>  	 * within the loop.
>  	 */
> diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
> index 2f67516bb9bf..9fbb9b5256f7 100644
> --- a/fs/ramfs/file-nommu.c
> +++ b/fs/ramfs/file-nommu.c
> @@ -70,7 +70,7 @@ int ramfs_nommu_expand_for_mapping(struct inode *inod=
e, size_t newsize)
>
>  	/* make various checks */
>  	order =3D get_order(newsize);
> -	if (unlikely(order >=3D MAX_ORDER))
> +	if (unlikely(order > MAX_ORDER))
>  		return -EFBIG;
>
>  	ret =3D inode_newsize_ok(inode, newsize);
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index ef09b23d29e3..8ce14f9d202a 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -72,7 +72,7 @@ struct ttm_pool {
>  	bool use_dma32;
>
>  	struct {
> -		struct ttm_pool_type orders[MAX_ORDER];
> +		struct ttm_pool_type orders[MAX_ORDER + 1];
>  	} caching[TTM_NUM_CACHING_TYPES];
>  };
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 7c977d234aba..8fb7d91cd0b1 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -818,7 +818,7 @@ static inline unsigned huge_page_shift(struct hstat=
e *h)
>
>  static inline bool hstate_is_gigantic(struct hstate *h)
>  {
> -	return huge_page_order(h) >=3D MAX_ORDER;
> +	return huge_page_order(h) > MAX_ORDER;
>  }
>
>  static inline unsigned int pages_per_huge_page(const struct hstate *h)=

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 9fb1b03b83b2..54a07b8862b9 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -26,11 +26,11 @@
>
>  /* Free memory management - zoned buddy allocator.  */
>  #ifndef CONFIG_ARCH_FORCE_MAX_ORDER
> -#define MAX_ORDER 11
> +#define MAX_ORDER 10
>  #else
>  #define MAX_ORDER CONFIG_ARCH_FORCE_MAX_ORDER
>  #endif
> -#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
> +#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
>
>  /*
>   * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deeme=
d
> @@ -93,7 +93,7 @@ static inline bool migratetype_is_mergeable(int mt)
>  }
>
>  #define for_each_migratetype_order(order, type) \
> -	for (order =3D 0; order < MAX_ORDER; order++) \
> +	for (order =3D 0; order <=3D MAX_ORDER; order++) \
>  		for (type =3D 0; type < MIGRATE_TYPES; type++)
>
>  extern int page_group_by_mobility_disabled;
> @@ -922,7 +922,7 @@ struct zone {
>  	CACHELINE_PADDING(_pad1_);
>
>  	/* free areas of different sizes */
> -	struct free_area	free_area[MAX_ORDER];
> +	struct free_area	free_area[MAX_ORDER + 1];
>
>  	/* zone flags, see below */
>  	unsigned long		flags;
> @@ -1745,7 +1745,7 @@ static inline bool movable_only_nodes(nodemask_t =
*nodes)
>  #define SECTION_BLOCKFLAGS_BITS \
>  	((1UL << (PFN_SECTION_SHIFT - pageblock_order)) * NR_PAGEBLOCK_BITS)
>
> -#if (MAX_ORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS
> +#if (MAX_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
>  #error Allocator MAX_ORDER exceeds SECTION_SIZE
>  #endif
>
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-=
flags.h
> index 5f1ae07d724b..e83c4c095041 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -41,14 +41,14 @@ extern unsigned int pageblock_order;
>   * Huge pages are a constant size, but don't exceed the maximum alloca=
tion
>   * granularity.
>   */
> -#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_O=
RDER - 1)
> +#define pageblock_order		min_t(unsigned int, HUGETLB_PAGE_ORDER, MAX_O=
RDER)
>
>  #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
>
>  #else /* CONFIG_HUGETLB_PAGE */
>
>  /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
> -#define pageblock_order		(MAX_ORDER-1)
> +#define pageblock_order		MAX_ORDER
>
>  #endif /* CONFIG_HUGETLB_PAGE */
>
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45af70315a94..aa4575ef2965 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -284,7 +284,7 @@ static inline unsigned int arch_slab_minalign(void)=

>   * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
>   */
>  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	5
>  #endif
> @@ -292,7 +292,7 @@ static inline unsigned int arch_slab_minalign(void)=

>
>  #ifdef CONFIG_SLUB
>  #define KMALLOC_SHIFT_HIGH	(PAGE_SHIFT + 1)
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	3
>  #endif
> @@ -305,7 +305,7 @@ static inline unsigned int arch_slab_minalign(void)=

>   * be allocated from the same page.
>   */
>  #define KMALLOC_SHIFT_HIGH	PAGE_SHIFT
> -#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT - 1)
> +#define KMALLOC_SHIFT_MAX	(MAX_ORDER + PAGE_SHIFT)
>  #ifndef KMALLOC_SHIFT_LOW
>  #define KMALLOC_SHIFT_LOW	3
>  #endif
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 755f5f08ab38..90ce1dfd591c 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -474,7 +474,7 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_OFFSET(list_head, prev);
>  	VMCOREINFO_OFFSET(vmap_area, va_start);
>  	VMCOREINFO_OFFSET(vmap_area, list);
> -	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER);
> +	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
>  	log_buf_vmcoreinfo_setup();
>  	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
>  	VMCOREINFO_NUMBER(NR_FREE_PAGES);
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 4d40dcce7604..1acec2e22827 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -84,8 +84,8 @@ static int atomic_pool_expand(struct gen_pool *pool, =
size_t pool_size,
>  	void *addr;
>  	int ret =3D -ENOMEM;
>
> -	/* Cannot allocate larger than MAX_ORDER-1 */
> -	order =3D min(get_order(pool_size), MAX_ORDER-1);
> +	/* Cannot allocate larger than MAX_ORDER */
> +	order =3D min(get_order(pool_size), MAX_ORDER);
>
>  	do {
>  		pool_size =3D 1 << (PAGE_SHIFT + order);
> @@ -190,7 +190,7 @@ static int __init dma_atomic_pool_init(void)
>
>  	/*
>  	 * If coherent_pool was not used on the command line, default the poo=
l
> -	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
> +	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER.
>  	 */
>  	if (!atomic_pool_size) {
>  		unsigned long pages =3D totalram_pages() / (SZ_1G / SZ_128K);
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index d6bbdb7830b2..273a0fe7910a 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, int=
 order)
>  {
>  	struct page *page;
>
> -	if (order >=3D MAX_ORDER)
> -		order =3D MAX_ORDER - 1;
> +	if (order > MAX_ORDER)
> +		order =3D MAX_ORDER;
>
>  	do {
>  		page =3D alloc_pages_node(node, PERF_AUX_GFP, order);

line 817:

-	if (order_base_2(size) >=3D PAGE_SHIFT+MAX_ORDER)
+	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)

> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4751031f3f05..fc059969d7ba 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -346,9 +346,9 @@ config SHUFFLE_PAGE_ALLOCATOR
>  	  the presence of a memory-side-cache. There are also incidental
>  	  security benefits as it reduces the predictability of page
>  	  allocations to compliment SLAB_FREELIST_RANDOM, but the
> -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
> -	  10th order of pages is selected based on cache utilization
> -	  benefits on x86.
> +	  default granularity of shuffling on the MAX_ORDER i.e, 10th
> +	  order of pages is selected based on cache utilization benefits
> +	  on x86.
>
>  	  While the randomization improves cache utilization it may
>  	  negatively impact workloads on platforms without a cache. For

line 669:

-	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will be=

-	  clamped down to MAX_ORDER - 1.
+	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
+	  clamped down to MAX_ORDER.




> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..709136556b9e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -583,7 +583,7 @@ static unsigned long isolate_freepages_block(struct=
 compact_control *cc,
>  		if (PageCompound(page)) {
>  			const unsigned int order =3D compound_order(page);
>
> -			if (likely(order < MAX_ORDER)) {
> +			if (likely(order <=3D MAX_ORDER)) {
>  				blockpfn +=3D (1UL << order) - 1;
>  				cursor +=3D (1UL << order) - 1;
>  			}
> @@ -938,7 +938,7 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
>  			 * a valid page order. Consider only values in the
>  			 * valid order range to prevent low_pfn overflow.
>  			 */
> -			if (freepage_order > 0 && freepage_order < MAX_ORDER)
> +			if (freepage_order > 0 && freepage_order <=3D MAX_ORDER)
>  				low_pfn +=3D (1UL << freepage_order) - 1;
>  			continue;
>  		}
> @@ -954,7 +954,7 @@ isolate_migratepages_block(struct compact_control *=
cc, unsigned long low_pfn,
>  		if (PageCompound(page) && !cc->alloc_contig) {
>  			const unsigned int order =3D compound_order(page);
>
> -			if (likely(order < MAX_ORDER))
> +			if (likely(order <=3D MAX_ORDER))
>  				low_pfn +=3D (1UL << order) - 1;
>  			goto isolate_fail;
>  		}
> @@ -2124,7 +2124,7 @@ static enum compact_result __compact_finished(str=
uct compact_control *cc)
>
>  	/* Direct compactor: Is a suitable page free? */
>  	ret =3D COMPACT_NO_SUITABLE_PAGE;
> -	for (order =3D cc->order; order < MAX_ORDER; order++) {
> +	for (order =3D cc->order; order <=3D MAX_ORDER; order++) {
>  		struct free_area *area =3D &cc->zone->free_area[order];
>  		bool can_steal;
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index af59cc7bd307..c9eb007fedcc 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -1086,7 +1086,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_d=
ebug_args *args, int order)
>  	struct page *page =3D NULL;
>
>  #ifdef CONFIG_CONTIG_ALLOC
> -	if (order >=3D MAX_ORDER) {
> +	if (order > MAX_ORDER) {
>  		page =3D alloc_contig_pages((1 << order), GFP_KERNEL,
>  					  first_online_node, NULL);
>  		if (page) {
> @@ -1096,7 +1096,7 @@ debug_vm_pgtable_alloc_huge_page(struct pgtable_d=
ebug_args *args, int order)
>  	}
>  #endif
>
> -	if (order < MAX_ORDER)
> +	if (order <=3D MAX_ORDER)
>  		page =3D alloc_pages(GFP_KERNEL, order);
>
>  	return page;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4fc43859e59a..1c03cab29d22 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -471,7 +471,7 @@ static int __init hugepage_init(void)
>  	/*
>  	 * hugepages can't be allocated by the buddy allocator
>  	 */
> -	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER >=3D MAX_ORDER);
> +	MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER > MAX_ORDER);
>  	/*
>  	 * we use page->mapping and page->index in second tail page
>  	 * as list_head: assuming THP order >=3D 2
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 07abcb6eb203..9525bced1e82 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2090,7 +2090,7 @@ pgoff_t hugetlb_basepage_index(struct page *page)=

>  	pgoff_t index =3D page_index(page_head);
>  	unsigned long compound_idx;
>
> -	if (compound_order(page_head) >=3D MAX_ORDER)
> +	if (compound_order(page_head) > MAX_ORDER)
>  		compound_idx =3D page_to_pfn(page) - page_to_pfn(page_head);
>  	else
>  		compound_idx =3D page - page_head;
> @@ -4497,7 +4497,7 @@ static int __init default_hugepagesz_setup(char *=
s)
>  	 * The number of default huge pages (for this size) could have been
>  	 * specified as the first hugetlb parameter: hugepages=3DX.  If so,
>  	 * then default_hstate_max_huge_pages is set.  If the default huge
> -	 * page size is gigantic (>=3D MAX_ORDER), then the pages must be
> +	 * page size is gigantic (> MAX_ORDER), then the pages must be
>  	 * allocated here from bootmem allocator.
>  	 */
>  	if (default_hstate_max_huge_pages) {
> diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
> index 7fb794242fad..ffedf4dbc49d 100644
> --- a/mm/kmsan/init.c
> +++ b/mm/kmsan/init.c
> @@ -96,7 +96,7 @@ void __init kmsan_init_shadow(void)
>  struct metadata_page_pair {
>  	struct page *shadow, *origin;
>  };
> -static struct metadata_page_pair held_back[MAX_ORDER] __initdata;
> +static struct metadata_page_pair held_back[MAX_ORDER + 1] __initdata;
>
>  /*
>   * Eager metadata allocation. When the memblock allocator is freeing p=
ages to

line 144: this one I am not sure if the original code is wrong or not.

-	.order =3D MAX_ORDER,
+	.order =3D MAX_ORDER + 1,


> @@ -211,8 +211,8 @@ static void kmsan_memblock_discard(void)
>  	 *    order=3DN-1,
>  	 *  - repeat.
>  	 */
> -	collect.order =3D MAX_ORDER - 1;
> -	for (int i =3D MAX_ORDER - 1; i >=3D 0; i--) {
> +	collect.order =3D MAX_ORDER;
> +	for (int i =3D MAX_ORDER; i >=3D 0; i--) {
>  		if (held_back[i].shadow)
>  			smallstack_push(&collect, held_back[i].shadow);
>  		if (held_back[i].origin)
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 25fd0626a9e7..338b8cb0793e 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2043,7 +2043,7 @@ static void __init __free_pages_memory(unsigned l=
ong start, unsigned long end)
>  	int order;
>
>  	while (start < end) {
> -		order =3D min(MAX_ORDER - 1UL, __ffs(start));
> +		order =3D min(MAX_ORDER, __ffs(start));

while you are here, maybe using min_t is better.

order =3D min_t(unsigned long, MAX_ORDER, __ffs(start));

>
>  		while (start + (1UL << order) > end)
>  			order--;
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index db3b270254f1..86291c79a764 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -596,7 +596,7 @@ static void online_pages_range(unsigned long start_=
pfn, unsigned long nr_pages)
>  	unsigned long pfn;
>
>  	/*
> -	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback mig=
ht
> +	 * Online the pages in MAX_ORDER aligned chunks. The callback might
>  	 * decide to not expose all pages to the buddy (e.g., expose them
>  	 * later). We account all pages as being online and belonging to this=

>  	 * zone ("present").
> @@ -605,7 +605,7 @@ static void online_pages_range(unsigned long start_=
pfn, unsigned long nr_pages)
>  	 * this and the first chunk to online will be pageblock_nr_pages.
>  	 */
>  	for (pfn =3D start_pfn; pfn < end_pfn;) {
> -		int order =3D min(MAX_ORDER - 1UL, __ffs(pfn));
> +		int order =3D min(MAX_ORDER, __ffs(pfn));

ditto

int order =3D min_t(unsigned long, MAX_ORDER, __ffs(pfn));

>
>  		(*online_page_callback)(pfn_to_page(pfn), order);
>  		pfn +=3D (1UL << order);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ac1fc986af44..66700f27b4c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

line 842: it might make a difference when MAX_ORDER is odd.

-	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
+	if (kstrtoul(buf, 10, &res) < 0 ||  res > (MAX_ORDER + 1) / 2) {

> @@ -1059,7 +1059,7 @@ buddy_merge_likely(unsigned long pfn, unsigned lo=
ng buddy_pfn,
>  	unsigned long higher_page_pfn;
>  	struct page *higher_page;
>
> -	if (order >=3D MAX_ORDER - 2)
> +	if (order >=3D MAX_ORDER - 1)
>  		return false;
>
>  	higher_page_pfn =3D buddy_pfn & pfn;
> @@ -1114,7 +1114,7 @@ static inline void __free_one_page(struct page *p=
age,
>  	VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>
> -	while (order < MAX_ORDER - 1) {
> +	while (order < MAX_ORDER) {
>  		if (compaction_capture(capc, page, order, migratetype)) {
>  			__mod_zone_freepage_state(zone, -(1 << order),
>  								migratetype);
> @@ -2579,7 +2579,7 @@ struct page *__rmqueue_smallest(struct zone *zone=
, unsigned int order,
>  	struct page *page;
>
>  	/* Find a page of the appropriate size in the preferred list */
> -	for (current_order =3D order; current_order < MAX_ORDER; ++current_or=
der) {
> +	for (current_order =3D order; current_order <=3D MAX_ORDER; ++current=
_order) {
>  		area =3D &(zone->free_area[current_order]);
>  		page =3D get_page_from_free_area(area, migratetype);
>  		if (!page)
> @@ -2951,7 +2951,7 @@ static bool unreserve_highatomic_pageblock(const =
struct alloc_context *ac,
>  			continue;
>
>  		spin_lock_irqsave(&zone->lock, flags);
> -		for (order =3D 0; order < MAX_ORDER; order++) {
> +		for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  			struct free_area *area =3D &(zone->free_area[order]);
>
>  			page =3D get_page_from_free_area(area, MIGRATE_HIGHATOMIC);
> @@ -3035,7 +3035,7 @@ __rmqueue_fallback(struct zone *zone, int order, =
int start_migratetype,
>  	 * approximates finding the pageblock with the most free pages, which=

>  	 * would be too costly to do exactly.
>  	 */
> -	for (current_order =3D MAX_ORDER - 1; current_order >=3D min_order;
> +	for (current_order =3D MAX_ORDER; current_order >=3D min_order;
>  				--current_order) {
>  		area =3D &(zone->free_area[current_order]);
>  		fallback_mt =3D find_suitable_fallback(area, current_order,
> @@ -3061,7 +3061,7 @@ __rmqueue_fallback(struct zone *zone, int order, =
int start_migratetype,
>  	return false;
>
>  find_smallest:
> -	for (current_order =3D order; current_order < MAX_ORDER;
> +	for (current_order =3D order; current_order <=3D MAX_ORDER;
>  							current_order++) {
>  		area =3D &(zone->free_area[current_order]);
>  		fallback_mt =3D find_suitable_fallback(area, current_order,
> @@ -3074,7 +3074,7 @@ __rmqueue_fallback(struct zone *zone, int order, =
int start_migratetype,
>  	 * This should not happen - we already found a suitable fallback
>  	 * when looking for the largest page.
>  	 */
> -	VM_BUG_ON(current_order =3D=3D MAX_ORDER);
> +	VM_BUG_ON(current_order > MAX_ORDER);
>
>  do_steal:
>  	page =3D get_page_from_free_area(area, fallback_mt);
> @@ -4044,7 +4044,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned=
 int order, unsigned long mark,
>  		return true;
>
>  	/* For a high-order request, check at least one suitable page is free=
 */
> -	for (o =3D order; o < MAX_ORDER; o++) {
> +	for (o =3D order; o <=3D MAX_ORDER; o++) {
>  		struct free_area *area =3D &z->free_area[o];
>  		int mt;
>
> @@ -5564,7 +5564,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned in=
t order, int preferred_nid,
>  	 * There are several places where we assume that the order value is s=
ane
>  	 * so bail out early if the request is out of bound.
>  	 */
> -	if (WARN_ON_ONCE_GFP(order >=3D MAX_ORDER, gfp))
> +	if (WARN_ON_ONCE_GFP(order > MAX_ORDER, gfp))
>  		return NULL;
>
>  	gfp &=3D gfp_allowed_mask;
> @@ -6294,8 +6294,8 @@ void __show_free_areas(unsigned int filter, nodem=
ask_t *nodemask, int max_zone_i
>
>  	for_each_populated_zone(zone) {
>  		unsigned int order;
> -		unsigned long nr[MAX_ORDER], flags, total =3D 0;
> -		unsigned char types[MAX_ORDER];
> +		unsigned long nr[MAX_ORDER + 1], flags, total =3D 0;
> +		unsigned char types[MAX_ORDER + 1];
>
>  		if (zone_idx(zone) > max_zone_idx)
>  			continue;
> @@ -6305,7 +6305,7 @@ void __show_free_areas(unsigned int filter, nodem=
ask_t *nodemask, int max_zone_i
>  		printk(KERN_CONT "%s: ", zone->name);
>
>  		spin_lock_irqsave(&zone->lock, flags);
> -		for (order =3D 0; order < MAX_ORDER; order++) {
> +		for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  			struct free_area *area =3D &zone->free_area[order];
>  			int type;
>
> @@ -6319,7 +6319,7 @@ void __show_free_areas(unsigned int filter, nodem=
ask_t *nodemask, int max_zone_i
>  			}
>  		}
>  		spin_unlock_irqrestore(&zone->lock, flags);
> -		for (order =3D 0; order < MAX_ORDER; order++) {
> +		for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  			printk(KERN_CONT "%lu*%lukB ",
>  			       nr[order], K(1UL) << order);
>  			if (nr[order])
> @@ -7670,7 +7670,7 @@ static inline void setup_usemap(struct zone *zone=
) {}
>  /* Initialise the number of pages represented by NR_PAGEBLOCK_BITS */
>  void __init set_pageblock_order(void)
>  {
> -	unsigned int order =3D MAX_ORDER - 1;
> +	unsigned int order =3D MAX_ORDER;
>
>  	/* Check that pageblock_nr_pages has not already been setup */
>  	if (pageblock_order)
> @@ -9165,7 +9165,7 @@ void *__init alloc_large_system_hash(const char *=
tablename,
>  			else
>  				table =3D memblock_alloc_raw(size,
>  							   SMP_CACHE_BYTES);
> -		} else if (get_order(size) >=3D MAX_ORDER || hashdist) {
> +		} else if (get_order(size) > MAX_ORDER || hashdist) {
>  			table =3D vmalloc_huge(size, gfp_flags);
>  			virt =3D true;
>  			if (table)
> @@ -9379,7 +9379,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  	order =3D 0;
>  	outer_start =3D start;
>  	while (!PageBuddy(pfn_to_page(outer_start))) {
> -		if (++order >=3D MAX_ORDER) {
> +		if (++order > MAX_ORDER) {
>  			outer_start =3D start;
>  			break;
>  		}
> @@ -9629,7 +9629,7 @@ bool is_free_buddy_page(struct page *page)
>  	unsigned long pfn =3D page_to_pfn(page);
>  	unsigned int order;
>
> -	for (order =3D 0; order < MAX_ORDER; order++) {
> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
>
>  		if (PageBuddy(page_head) &&
> @@ -9637,7 +9637,7 @@ bool is_free_buddy_page(struct page *page)
>  			break;
>  	}
>
> -	return order < MAX_ORDER;
> +	return order <=3D MAX_ORDER;
>  }
>  EXPORT_SYMBOL(is_free_buddy_page);
>
> @@ -9688,7 +9688,7 @@ bool take_page_off_buddy(struct page *page)
>  	bool ret =3D false;
>
>  	spin_lock_irqsave(&zone->lock, flags);
> -	for (order =3D 0; order < MAX_ORDER; order++) {
> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  		struct page *page_head =3D page - (pfn & ((1 << order) - 1));
>  		int page_order =3D buddy_order(page_head);
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 47fbc1696466..c6f3605e37ab 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -226,7 +226,7 @@ static void unset_migratetype_isolate(struct page *=
page, int migratetype)
>  	 */
>  	if (PageBuddy(page)) {
>  		order =3D buddy_order(page);
> -		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
> +		if (order >=3D pageblock_order && order < MAX_ORDER) {
>  			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
>  						    order, NULL);
>  			if (buddy && !is_migrate_isolate_page(buddy)) {
> @@ -290,11 +290,11 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>   *			isolate_single_pageblock()
>   * @migratetype:	migrate type to set in error recovery.
>   *
> - * Free and in-use pages can be as big as MAX_ORDER-1 and contain more=
 than one
> + * Free and in-use pages can be as big as MAX_ORDER and contain more t=
han one
>   * pageblock. When not all pageblocks within a page are isolated at th=
e same
>   * time, free page accounting can go wrong. For example, in the case o=
f
> - * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two pag=
elbocks.
> - * [         MAX_ORDER-1         ]
> + * MAX_ORDER =3D pageblock_order + 1, a MAX_ORDER page has two pagelbo=
cks.
> + * [         MAX_ORDER           ]
>   * [  pageblock0  |  pageblock1  ]
>   * When either pageblock is isolated, if it is a free page, the page i=
s not
>   * split into separate migratetype lists, which is supposed to; if it =
is an
> @@ -451,7 +451,7 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
>  				 * the free page to the right migratetype list.
>  				 *
>  				 * head_pfn is not used here as a hugetlb page order
> -				 * can be bigger than MAX_ORDER-1, but after it is
> +				 * can be bigger than MAX_ORDER, but after it is
>  				 * freed, the free page order is not. Use pfn within
>  				 * the range to find the head of the free page.
>  				 */
> @@ -459,7 +459,7 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
>  				outer_pfn =3D pfn;
>  				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>  					/* stop if we cannot find the free page */
> -					if (++order >=3D MAX_ORDER)
> +					if (++order > MAX_ORDER)
>  						goto failed;
>  					outer_pfn &=3D ~0UL << order;
>  				}
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 220cdeddc295..31169b3e7f06 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -315,7 +315,7 @@ void pagetypeinfo_showmixedcount_print(struct seq_f=
ile *m,
>  				unsigned long freepage_order;
>
>  				freepage_order =3D buddy_order_unsafe(page);
> -				if (freepage_order < MAX_ORDER)
> +				if (freepage_order <=3D MAX_ORDER)
>  					pfn +=3D (1UL << freepage_order) - 1;
>  				continue;
>  			}
> @@ -549,7 +549,7 @@ read_page_owner(struct file *file, char __user *buf=
, size_t count, loff_t *ppos)
>  		if (PageBuddy(page)) {
>  			unsigned long freepage_order =3D buddy_order_unsafe(page);
>
> -			if (freepage_order < MAX_ORDER)
> +			if (freepage_order <=3D MAX_ORDER)
>  				pfn +=3D (1UL << freepage_order) - 1;
>  			continue;
>  		}
> @@ -657,7 +657,7 @@ static void init_pages_in_zone(pg_data_t *pgdat, st=
ruct zone *zone)
>  			if (PageBuddy(page)) {
>  				unsigned long order =3D buddy_order_unsafe(page);
>
> -				if (order > 0 && order < MAX_ORDER)
> +				if (order > 0 && order <=3D MAX_ORDER)
>  					pfn +=3D (1UL << order) - 1;
>  				continue;
>  			}
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 275b466de37b..b021f482a4cb 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -20,7 +20,7 @@ static int page_order_update_notify(const char *val, =
const struct kernel_param *
>  	 * If param is set beyond this limit, order is set to default
>  	 * pageblock_order value
>  	 */
> -	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER-1);
> +	return  param_set_uint_minmax(val, kp, 0, MAX_ORDER);
>  }
>
>  static const struct kernel_param_ops page_reporting_param_ops =3D {
> @@ -276,7 +276,7 @@ page_reporting_process_zone(struct page_reporting_d=
ev_info *prdev,
>  		return err;
>
>  	/* Process each free list starting from lowest order/mt */
> -	for (order =3D page_reporting_order; order < MAX_ORDER; order++) {
> +	for (order =3D page_reporting_order; order <=3D MAX_ORDER; order++) {=

>  		for (mt =3D 0; mt < MIGRATE_TYPES; mt++) {
>  			/* We do not pull pages from the isolate free list */
>  			if (is_migrate_isolate(mt))
> @@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_d=
ev_info *prdev)
>  	 */
>
>  	if (page_reporting_order =3D=3D -1) {
> -		if (prdev->order > 0 && prdev->order < MAX_ORDER)
> +		if (prdev->order > 0 && prdev->order <=3D MAX_ORDER)
>  			page_reporting_order =3D prdev->order;
>  		else
>  			page_reporting_order =3D pageblock_order;
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index cec62984f7d3..a6bdf54f96f1 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -4,7 +4,7 @@
>  #define _MM_SHUFFLE_H
>  #include <linux/jump_label.h>
>
> -#define SHUFFLE_ORDER (MAX_ORDER-1)
> +#define SHUFFLE_ORDER MAX_ORDER
>
>  #ifdef CONFIG_SHUFFLE_PAGE_ALLOCATOR
>  DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> diff --git a/mm/slab.c b/mm/slab.c
> index dabc2a671fc6..dea1d580a053 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -465,7 +465,7 @@ static int __init slab_max_order_setup(char *str)
>  {
>  	get_option(&str, &slab_max_order);
>  	slab_max_order =3D slab_max_order < 0 ? 0 :
> -				min(slab_max_order, MAX_ORDER - 1);
> +				min(slab_max_order, MAX_ORDER);
>  	slab_max_order_set =3D true;
>
>  	return 1;
> diff --git a/mm/slub.c b/mm/slub.c
> index 32eb6b50fe18..0e19c0d647e6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4171,8 +4171,8 @@ static inline int calculate_order(unsigned int si=
ze)
>  	/*
>  	 * Doh this slab cannot be placed using slub_max_order.
>  	 */
> -	order =3D calc_slab_order(size, 1, MAX_ORDER - 1, 1);
> -	if (order < MAX_ORDER)
> +	order =3D calc_slab_order(size, 1, MAX_ORDER, 1);
> +	if (order <=3D MAX_ORDER)
>  		return order;
>  	return -ENOSYS;
>  }
> @@ -4697,7 +4697,7 @@ __setup("slub_min_order=3D", setup_slub_min_order=
);
>  static int __init setup_slub_max_order(char *str)
>  {
>  	get_option(&str, (int *)&slub_max_order);
> -	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER - 1);
> +	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER);

maybe min_t is better?

slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);

>
>  	return 1;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..0b611d4c16f1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6990,7 +6990,7 @@ unsigned long try_to_free_pages(struct zonelist *=
zonelist, int order,
>  	 * scan_control uses s8 fields for order, priority, and reclaim_idx.
>  	 * Confirm they are large enough for max values.
>  	 */
> -	BUILD_BUG_ON(MAX_ORDER > S8_MAX);
> +	BUILD_BUG_ON(MAX_ORDER >=3D S8_MAX);
>  	BUILD_BUG_ON(DEF_PRIORITY > S8_MAX);
>  	BUILD_BUG_ON(MAX_NR_ZONES > S8_MAX);
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 1ea6a5ce1c41..b7307627772d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1055,7 +1055,7 @@ static void fill_contig_page_info(struct zone *zo=
ne,
>  	info->free_blocks_total =3D 0;
>  	info->free_blocks_suitable =3D 0;
>
> -	for (order =3D 0; order < MAX_ORDER; order++) {
> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>  		unsigned long blocks;
>
>  		/*
> @@ -1088,7 +1088,7 @@ static int __fragmentation_index(unsigned int ord=
er, struct contig_page_info *in
>  {
>  	unsigned long requested =3D 1UL << order;
>
> -	if (WARN_ON_ONCE(order >=3D MAX_ORDER))
> +	if (WARN_ON_ONCE(order > MAX_ORDER))
>  		return 0;
>
>  	if (!info->free_blocks_total)
> @@ -1462,7 +1462,7 @@ static void frag_show_print(struct seq_file *m, p=
g_data_t *pgdat,
>  	int order;
>
>  	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
> -	for (order =3D 0; order < MAX_ORDER; ++order)
> +	for (order =3D 0; order <=3D MAX_ORDER; ++order)
>  		/*
>  		 * Access to nr_free is lockless as nr_free is used only for
>  		 * printing purposes. Use data_race to avoid KCSAN warning.
> @@ -1491,7 +1491,7 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>  					pgdat->node_id,
>  					zone->name,
>  					migratetype_names[mtype]);
> -		for (order =3D 0; order < MAX_ORDER; ++order) {
> +		for (order =3D 0; order <=3D MAX_ORDER; ++order) {
>  			unsigned long freecount =3D 0;
>  			struct free_area *area;
>  			struct list_head *curr;
> @@ -1531,7 +1531,7 @@ static void pagetypeinfo_showfree(struct seq_file=
 *m, void *arg)
>
>  	/* Print header */
>  	seq_printf(m, "%-43s ", "Free pages count per migrate type at order")=
;
> -	for (order =3D 0; order < MAX_ORDER; ++order)
> +	for (order =3D 0; order <=3D MAX_ORDER; ++order)
>  		seq_printf(m, "%6d ", order);
>  	seq_putc(m, '\n');
>
> @@ -2153,7 +2153,7 @@ static void unusable_show_print(struct seq_file *=
m,
>  	seq_printf(m, "Node %d, zone %8s ",
>  				pgdat->node_id,
>  				zone->name);
> -	for (order =3D 0; order < MAX_ORDER; ++order) {
> +	for (order =3D 0; order <=3D MAX_ORDER; ++order) {
>  		fill_contig_page_info(zone, order, &info);
>  		index =3D unusable_free_index(order, &info);
>  		seq_printf(m, "%d.%03d ", index / 1000, index % 1000);
> @@ -2205,7 +2205,7 @@ static void extfrag_show_print(struct seq_file *m=
,
>  	seq_printf(m, "Node %d, zone %8s ",
>  				pgdat->node_id,
>  				zone->name);
> -	for (order =3D 0; order < MAX_ORDER; ++order) {
> +	for (order =3D 0; order <=3D MAX_ORDER; ++order) {
>  		fill_contig_page_info(zone, order, &info);
>  		index =3D __fragmentation_index(order, &info);
>  		seq_printf(m, "%2d.%03d ", index / 1000, index % 1000);
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 854772dd52fd..9b66d6aeeb1a 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -843,7 +843,7 @@ long smc_ib_setup_per_ibdev(struct smc_ib_device *s=
mcibdev)
>  		goto out;
>  	/* the calculated number of cq entries fits to mlx5 cq allocation */
>  	cqe_size_order =3D cache_line_size() =3D=3D 128 ? 7 : 6;
> -	smc_order =3D MAX_ORDER - cqe_size_order - 1;
> +	smc_order =3D MAX_ORDER - cqe_size_order;
>  	if (SMC_MAX_CQE + 2 > (0x00000001 << smc_order) * PAGE_SIZE)
>  		cqattr.cqe =3D (0x00000001 << smc_order) * PAGE_SIZE - 2;
>  	smcibdev->roce_cq_send =3D ib_create_cq(smcibdev->ibdev,
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/i=
ma/ima_crypto.c
> index 64499056648a..51ad29940f05 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -38,7 +38,7 @@ static int param_set_bufsize(const char *val, const s=
truct kernel_param *kp)
>
>  	size =3D memparse(val, NULL);
>  	order =3D get_order(size);
> -	if (order >=3D MAX_ORDER)
> +	if (order > MAX_ORDER)
>  		return -EINVAL;
>  	ima_maxorder =3D order;
>  	ima_bufsize =3D PAGE_SIZE << order;
> diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memb=
lock/linux/mmzone.h
> index e65f89b12f1c..134f8eab0768 100644
> --- a/tools/testing/memblock/linux/mmzone.h
> +++ b/tools/testing/memblock/linux/mmzone.h
> @@ -17,10 +17,10 @@ enum zone_type {
>  };
>
>  #define MAX_NR_ZONES __MAX_NR_ZONES
> -#define MAX_ORDER 11
> -#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
> +#define MAX_ORDER 10
> +#define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
>
> -#define pageblock_order		(MAX_ORDER - 1)
> +#define pageblock_order		MAX_ORDER
>  #define pageblock_nr_pages	BIT(pageblock_order)
>  #define pageblock_align(pfn)	ALIGN((pfn), pageblock_nr_pages)
>  #define pageblock_start_pfn(pfn)	ALIGN_DOWN((pfn), pageblock_nr_pages)=

> -- =

> 2.39.2

The changes look good to me. I added some missing changes inline, althoug=
h the line
number might not be exact. Feel free to add Reviewed-by: Zi Yan <ziy@nvid=
ia.com>.

Do you think it is worth adding a MAX_ORDER check in checkpatch.pl to war=
n people
the meaning of MAX_ORDER has changed? Something like:

# check for MAX_ORDER uses as its semantics has changed.
# MAX_ORDER now really means the max order of a page that can come out of=

# kernel buddy allocator
        if ($line =3D~ /MAX_ORDER/) {
            WARN("MAX_ORDER",
                 "MAX_ORDER has changed its semantics. The max order of a=
 page that can be allocated from buddy allocator is MAX_ORDER instead of =
MAX_ORDER - 1.")
        }

Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_1250BC76-DBD8-4544-AB2A-CA9FC07CB1BE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQTTUoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUCd0P/j9EWNMwzZ1NX6zyj5RRHWf/hADc30MisL56
QLjz4nvI/gHej2aKR8Vfi7hBsN4rHf8qm7OKVfLE3gvCleI0I95bZVHfXHXpppNN
1wtP+kDhbZMD958zKFAR/hiAqP54A85wxwAiLdWO3+nIUc29Ki9zK2cU2KNcBgKi
WXOGX7xQL+qIvVWPcivqrgwAVZ+zutzTsiAC4e/86Z/eutZEN/XLKwMwBXtERgtb
+ao2YzcvSAiqL92oO0N7PVa3VtWeQRFcD1+gc8JM8E+VRasEuOk0C2SR0qSQhrQv
wbgCeqxXx83goKK5YgWIpEpTDWTrvAkBqLDgQlOYw5wLEhHfKjV0zxEDfhu8TcoO
oGEf2X1dnO1/p90BJvlLt55MTpHqbBSMjIWOHEt/58azSNDQ1qrc2GcUkPDkpSen
6dcmyXY1melcaAutoE3G5/wbSTu6e5lm8W7cZHL/WQpEYGJYbGC77p25g+2nzf3L
9zWqwOGe6RmQRXQAyOjwgVxo318Ctd5gxGL94n4l6waDGQxalnpm638atp8UqbsG
mKth1cJ+Ker84WxLLJIzoYomJ2Xzsah1PsX3DajN2fKiXrhWs9yvdrJ2g4jJycQz
fJk6g/kH4r5LeKck+Yf7VxCYpgQhobAwcf+AgXfjWA09jhCXHGDsTuMEBt5+FUL8
iEE+kjnW
=o+cH
-----END PGP SIGNATURE-----

--=_MailMate_1250BC76-DBD8-4544-AB2A-CA9FC07CB1BE_=--
