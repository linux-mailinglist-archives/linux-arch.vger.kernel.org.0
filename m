Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18B21A4B41
	for <lists+linux-arch@lfdr.de>; Fri, 10 Apr 2020 22:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJUj1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Apr 2020 16:39:27 -0400
Received: from mail-bn8nam11on2116.outbound.protection.outlook.com ([40.107.236.116]:42950
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgDJUj0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Apr 2020 16:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaSjwy52vvLHIdWZtF+hFsylnh+qxrspqh0IwLAIitq9VP+NGfoOrhn1ar5VK8S1smSEyW565ysFwNIt5jwmFL6hzpRLe4nIchjiVAbpf4nVdkaVKYY+eRfyOPi5HHeR20iQayViVbEcU8sf6DOdZDg0Yn7vh1fWoPqE2vialpisrKAoMAcdi3NUSoO/0CUvjz6RG4gdBkhBESJH3g3UevXBytf4+2OYxWskSYDMx0C52TIQ/UQ5IKw4d0ygOACIoKu6z5OrOAt1N7umkuMVhMJnq5C783W5JWYLEIo7wdmgYYzAEH0lFFA4MniyeSqnLz8A6pLcRSnwRy6vHY/qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoToauhBYeB3BuJLG+DYNXlchkH32OndZ8w44wnlo3k=;
 b=ALXXbU1PrXLLn0AlTjp+RyQBOeDbH29ZkkLS9SOP35StSLMC2Uev3P9pPriLU3lgSdujmaFl60sAlNr5xezzKzDD/Kbd3Gldu8KWimxNEeQ+oXvTjMuLh+zBN7HZgxpu4VB7SsWypTcYpGE4gRZK/QvfkrIjYMLrlf+jL4wi/B2SiJVXNyOyIMvY/WEiCuLdddZ6XTUeKdicEJT+BOEA9umJmyn+1Y7XZU14s3JToRm0auRp3lvLHlDwEX5emFdOqz4UmPDI/YPMtM7nkqv6yTph3cVJWiwn/3wqRBruRxfvhEo+hUlShjuKLQ00y/kGY3zVPdMXNABN25hU7yHPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoToauhBYeB3BuJLG+DYNXlchkH32OndZ8w44wnlo3k=;
 b=HIwwiQfCsMTuKpMCttUu9DBlkiPnoaXTWYPJ0UqwemwR+8BZYXh7AqXqMmPrm+iPpoTC9H9PPaj90l1fh3r9yaSdRi/05cWWj7Ac4f/qG7UWDGiQLAZcCA/Bwrsd4El68Pw2Vx6sTlSHr4KuZmi01uc5DBmyiqGNpzF8PTJL3TY=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB1110.namprd21.prod.outlook.com (2603:10b6:4:a5::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.3; Fri, 10 Apr
 2020 20:39:23 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 20:39:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 20/28] mm: remove the pgprot argument to __vmalloc
Thread-Topic: [PATCH 20/28] mm: remove the pgprot argument to __vmalloc
Thread-Index: AQHWDZ16T10FJHa5qkmQBiTBI7lC0ahy1JXA
Date:   Fri, 10 Apr 2020 20:39:22 +0000
Message-ID: <DM5PR2101MB10472EA3373D4D1A73AC0F7ED7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-21-hch@lst.de>
In-Reply-To: <20200408115926.1467567-21-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T20:39:20.2356348Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4bc76ec5-07a6-47b3-a0ad-cdf0dc769870;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8eebaa48-c873-4038-513f-08d7dd8f40ce
x-ms-traffictypediagnostic: DM5PR2101MB1110:|DM5PR2101MB1110:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR2101MB1110D9F93961892981A81C5DD7DE0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:49;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(8676002)(86362001)(8936002)(66476007)(8990500004)(7696005)(66946007)(71200400001)(81156014)(66446008)(54906003)(66556008)(64756008)(10290500003)(478600001)(7416002)(110136005)(316002)(76116006)(6506007)(33656002)(4326008)(82950400001)(55016002)(52536014)(186003)(2906002)(82960400001)(26005)(9686003)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qrCPnCPp+Ms5eFpNc+uE3nriH+Pey6ezal8zhmYSgPIUJQ3etmXUWaLwfwplCD+Ux/za0JBzwO098D2FgfKB7OpojK71QED/2EYd/2QY08KeyW//+zmo2A6ZW9EV+Qq3KewIMzdu+PRiGb2fZoCjq+CW/K/yvDS3VU3bOYfwNJet0mBCwR+ECLPq9FNgCL1ybGOQHScrvY6Ep8ARIdFbZasDCgcVF2gAnUV3MJHCCYoXO9s0rDjI2NwMOJXyG1DFhm6bDrxTDzZvvHJLhXhCAS4MZN4QtTVk6mD3/hATg6fIXaecU4z5+FFOGbxcZmM0qiy278572y1fShhglMgCim9ycKMfYRgC64e3LHeD7LYxph0S9BfhRoG+zJSstSOLRo15Ngk6K18XqfHHI83Nnr1nCnkwlKdy3K5mLiliuyiCaaAQ+XAnJGzNTteVh7sM3BGZJ9L9k6EuAD2hkOzfZtSDvOJKy3HdjG3bAbk9+do9LdtDlzVTQkWchiaDd6vS
x-ms-exchange-antispam-messagedata: 2zSQnUGFQyGSIZyjV8zmFy4O0+N9T8YeqzYzFx5WSukNTCQkoNBdAVfLX6BSX+ChCAvD4gGVSkvg6HGIrg+8M3Y/WQ0AVssORU89AKIUaSSrWJbhBv0/2Yh6a0UKriNrywdokZvMloASZYaVIcrTSQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eebaa48-c873-4038-513f-08d7dd8f40ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 20:39:22.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j0ryeNHVOwrByWoWAqYAZVYhAQZ8fx3teihoxzqpnRd3QTOGMyhID9lRwDcFDF8ZYmG1gLPBZUUxrUv7DYY8mpAbqaqvz8dUSTLPn3WUfNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christoph Hellwig <hch@lst.de> Sent: Wednesday, April 8, 2020 4:59 AM
>=20
> The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
> it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/hyperv/hv_init.c              |  3 +--
>  arch/x86/include/asm/kvm_host.h        |  3 +--
>  arch/x86/kvm/svm.c                     |  3 +--
>  drivers/block/drbd/drbd_bitmap.c       |  4 +---
>  drivers/gpu/drm/etnaviv/etnaviv_dump.c |  4 ++--
>  drivers/lightnvm/pblk-init.c           |  5 ++---
>  drivers/md/dm-bufio.c                  |  4 ++--
>  drivers/mtd/ubi/io.c                   |  4 ++--
>  drivers/scsi/sd_zbc.c                  |  3 +--
>  fs/gfs2/dir.c                          |  9 ++++-----
>  fs/gfs2/quota.c                        |  2 +-
>  fs/nfs/blocklayout/extent_tree.c       |  2 +-
>  fs/ntfs/malloc.h                       |  2 +-
>  fs/ubifs/debug.c                       |  2 +-
>  fs/ubifs/lprops.c                      |  2 +-
>  fs/ubifs/lpt_commit.c                  |  4 ++--
>  fs/ubifs/orphan.c                      |  2 +-
>  fs/xfs/kmem.c                          |  2 +-
>  include/linux/vmalloc.h                |  2 +-
>  kernel/bpf/core.c                      |  6 +++---
>  kernel/groups.c                        |  2 +-
>  kernel/module.c                        |  3 +--
>  mm/nommu.c                             | 15 +++++++--------
>  mm/page_alloc.c                        |  2 +-
>  mm/percpu.c                            |  2 +-
>  mm/vmalloc.c                           |  4 ++--
>  net/bridge/netfilter/ebtables.c        |  6 ++----
>  sound/core/memalloc.c                  |  2 +-
>  sound/core/pcm_memory.c                |  2 +-
>  29 files changed, 47 insertions(+), 59 deletions(-)
>=20

For Hyper-V changes,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
