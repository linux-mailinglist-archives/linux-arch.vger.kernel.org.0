Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3D636E95
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKWXvS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 18:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKWXvQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 18:51:16 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11021019.outbound.protection.outlook.com [52.101.47.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86AC6316B;
        Wed, 23 Nov 2022 15:51:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guIiAQ4AAp6ZzcTlJq5un0xZ2rRHAmCK1v84u6gspQw5UUjuDPuHxBkHsX47hB1CgseqZDm6/XhCTKe37pxDAhGG0O+Js/KrSsOU5DJJftnbQ+I3Tjd4zUzNZvYwEyZShytUIsk8nVROAuq/LTrQSaFUJJz6T4UE0OXdb6zWguawlNM0V5Sksz0mVVC/WOqf7+Rht58AxIgPS0EnWOwjNACphBNF1vOOOHkqKJT2eA+R8e3yIZxSLca5TQi6RrJOJpnP5NwApQe66tcLICbFYkbqdE8M22ImJoMYQxe/FiTwirDhWrw3VRS0m9hu77S0RypSWU0nLJOL1/rDm8JRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8R5rndoout8A9h9Z3t70YJezVTzp4VbK23UuzulTx0=;
 b=YhC1zmp8VgZlwaUdS2U6Hd1LEvP83qBr6ygtA8S15YsL/bALCk2WRTGLazOm7d2+mvmaHmvozb2sgWzvW6CzeYkhcnwR6K/QVbilC4yg2QAbCFvFZ1Zp42Tcrg0S14evLqYI5GVkD54vVynWjjnw7h6dWhUJM0P/G6Byd+jOVFOfmH5vZ6bPp+N/mAi/ChRtVEBO4E5jIzLMs79frlqpxxjfvplaThzSeCOu5T5GeaALqkSewDQ9O6CATR1H8gJ28i3osED1k6m51GFZgLVJ8gLDCXf/ZnLuDlyMqo2ob0bAf5w2Rv7Zy/3cZkRzUi7u1XwFUoVMHpIDBYZua+8O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8R5rndoout8A9h9Z3t70YJezVTzp4VbK23UuzulTx0=;
 b=XD6duKFB/jyJCe/bwnOJn35F7SnIqaCvyBF0Dya7qMyYkJldHyo1LNYnTSlFQpqkfgtkPlKxvyYW4X/U8WTOVXDFeNWxc/aA5DdvEureuzTSgFbQBRPzHXHf5c2ck9ZznauNAslxld98rBBAE2N9rpwM/Qdhzg4x1w5TclF2+x8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3298.namprd21.prod.outlook.com (2603:10b6:8:6a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.5; Wed, 23 Nov
 2022 23:51:11 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 23:51:11 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHY/5Z0Z424jDhUsEe8P9jmzKLFIw==
Date:   Wed, 23 Nov 2022 23:51:11 +0000
Message-ID: <SA1PR21MB133536EA0C26DFE0168E2F98BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
 <20221122002421.qg4h47cjoc2birvb@box.shutemov.name>
In-Reply-To: <20221122002421.qg4h47cjoc2birvb@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfd26d64-1f1d-4d05-9de0-ee0d8d425bfb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T19:15:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3298:EE_
x-ms-office365-filtering-correlation-id: 0d0e8a96-b8ab-45b9-50dc-08dacdad996d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j95OKNBc8XrtT3AI+k36gDErxdBlvh5CVlhUmlO+8X0MTRBpYtYWOMN2UgDNA7UlFJ6sMIZhLwAtzMZWH1lwvSv9E95pVumctFkH2086ZYeiHnmfawDil2AX/pmzdveIl68BLuD3ROzaocsMmSCt9TvRBIR7rZj3eeF6IX1XENxZjDx4F/z2r8z1KwHLXLSU1j3eDBvx4d/6dVjlGZBQU3cQk9KnR6L4rk2ZK4z18x8ilbX523s52sS1/b4/iHmUjiAX+Eeak/ffnJb7S/FXjZx/78upSrQmUJyRcZ1QCKEyz5Y/rr2AxEkGUbUb+rYvuV4nj4/9SM5d9gUMTmXRSS+WNDb1roFMhOwFX2IuOaubMwAS5LxGiNnnr11MlVVGwy6msFnhmFC/wrc2540hBIOOoVxlMcpJZ+ZNyA4yGC6YCAUEtRRfydqFFgwo6M8wJnIXpxREq2V3PXmeYpbqj/CJgjVvMRROS7xWz42YQlnswxrlsqcaOxoiYjzWE5Rvi7PCDiEJCfGNn7X5saJoBVxbEQtRW5xOd42PVuaSB4uVOuPpq8Xp9uAkRHOJWH6Enq8TQAfC9HUHk8nAyDj0ZV3VnByxoKuEB9EK78+YDbFChZoY5gOiTPwEBDQU5tdFScFIA+XRMUM2GbtYwEISPdK5oLX0aCEX0lDKbvjmbWUe5CjUeK2XBTmxCvEdMU1LwMTXcU2fHlHetPlFU6LkgFbLjHnm7qAUFJv0hEmNx6wiHzQ/lLTDDg+qJEuZuu91Wu+3/VjqzkbdxnWxdWtJpz/QmKAfuhu6E/4nDQk2q/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(52536014)(8936002)(41300700001)(55016003)(5660300002)(4326008)(8676002)(66556008)(66476007)(76116006)(2906002)(64756008)(66946007)(66446008)(26005)(478600001)(83380400001)(316002)(38070700005)(966005)(10290500003)(8990500004)(54906003)(6916009)(71200400001)(9686003)(7416002)(82960400001)(82950400001)(38100700002)(186003)(122000001)(33656002)(86362001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DhkkWVCSrt/hO4F6tIHREqjo6N7wxUQhzB2BFazUMlMFhjO99uCC92HPt4zv?=
 =?us-ascii?Q?WqtCFA3BT8iyLY0RXDB+VrGjkwIU7TEpZZYNUvlKHZQLhTDD06x201RnKaOG?=
 =?us-ascii?Q?HStBqWVfpNSIZk5q6tWxlAV7LvSFsn4ZI1TOVod0GW3hkZdHJiIOItvgrzLN?=
 =?us-ascii?Q?ZKUQCv7pa4EVZbX6dh4qCUe3pRx8pyEK0GJBazF6AJAxJTIHkBNjiE5l69yw?=
 =?us-ascii?Q?1iTBwv4YQVciixcc9X15vpQzQBfy3G6V/ta7FD0QlHjz8962MkwRH+QcqAd0?=
 =?us-ascii?Q?CaFDKMPbkfCzFbBk3YBC/05Vd1P/iszLjSpazWnxhSNVfeyKke4P4+MxBCqi?=
 =?us-ascii?Q?vE/GFN3CBJ+Ph0eHxAKDGVedD/Wtc1LxxOeh6bGDX2VmsIwEJmDHWi6+20T2?=
 =?us-ascii?Q?x5P79mCSIpkq4ct3SNVEblodhW0dqxqHDZ+3BZREmfyoUrbyzzKHfxkLO+gy?=
 =?us-ascii?Q?fMdfq6N21P+Rmne0Kp1OrwL12P5x7yzFiQhwCQKLkf4VucpYsFDCLxkN3O7j?=
 =?us-ascii?Q?qmKQdn/jS+Glq7OchVgC3Upl3VXrWbTupAzrbyw85ptr+jD5cqlI74w2kSrB?=
 =?us-ascii?Q?WmxrgLqHDUdlfpBRev1Q1AxGGzNYVUKmfIA1jjSkzfg0YyDzB7EM1BaNfRsP?=
 =?us-ascii?Q?QOWh+giy+wlukIuIW6OLeDaZ3arEuL+ISLk4ecAmzmuQ9zd7DyxxBI3ac2mb?=
 =?us-ascii?Q?igc2yQlkbewueyduWYGCavf85zpBiEXrfL4PXA53ZO3pcG7pynfITsh7XfFi?=
 =?us-ascii?Q?Xmd3PW98aRCzrvS53zqYbUEUeFkf7zEZwxCichvSK6vey9pVc3aN3GWBfQpX?=
 =?us-ascii?Q?++nJL7bS4db3CCI2rtvnw8jfI9jU1tBe9+v6h+AdjVu+k0z5jC+RESWtNtlx?=
 =?us-ascii?Q?5cLrH0+9SWx/CoRbbZeR11Eh7P2qAXeKssLBdXuhs7G9y9edOLJLHtB+1BzH?=
 =?us-ascii?Q?4X+UqFNg+bj0oWhz3ZCsTnlmoEXHQJvMpDj+mZymmHGsnLZc4SP3NdsjkIf2?=
 =?us-ascii?Q?GyjgjcTydAsloBNfBf6VyCylCDgnHmDSomIJVMiZtvBLpZTCXvqiJxKoQKgM?=
 =?us-ascii?Q?9Lhcrq4HrtXwGcd9zcuaJiq5TM7aScXRSMSCAhOxaaPluMbSqkohcdHYFGsC?=
 =?us-ascii?Q?SNKUOGhMxY6Bh+aurndq8uuS3Pt7gClZqMeQA4Lqpa8E9r7siKLdHPXXsUAy?=
 =?us-ascii?Q?enX5AmlV3si+mdmimZVvEJamAUjijQFUSO8SNQEymv/NDcQQQAaOZLp4DP//?=
 =?us-ascii?Q?TsqEKz0VLS498KSH5yEApSyX2V4YdTsiG6hRQzdt5F129hzq4kVoAHs3mkN7?=
 =?us-ascii?Q?Rgk4ghQZ33i9wQYVF7BbSIlcmmSnRMvsOTCwvBnxtY3i+lTZjpxUVhPcRlEv?=
 =?us-ascii?Q?ObXR32LPd/x/MMv19D7Mzr6EdhU3Lat45p5s+645wz4GYazgjeTb2QqcMWUV?=
 =?us-ascii?Q?cnp6LYSZerhUkSJk7/9ryaHn9rIjPc/8Gj2/aIi3ThNM6bxbNRN51NbrCqKr?=
 =?us-ascii?Q?9uwSB/W05A10YAFtaXbCLdIbp3Cv99jay0S4r738Y9OTl9Jio9b7B5Ok81hk?=
 =?us-ascii?Q?avLgPiBzlzcZPnYgujMB6a1NTyY43SYm5brfyg6D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0e8a96-b8ab-45b9-50dc-08dacdad996d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 23:51:11.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4w0gbjLlel+643HKG/RL63qFB1WTM3sCSSRJYX0cuCLiztPqsMNdd7airUY6FJo9EzyP/rlp9qxzWWfWwIGvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Monday, November 21, 2022 4:24 PM
>=20
> On Mon, Nov 21, 2022 at 11:51:48AM -0800, Dexuan Cui wrote:
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_bu=
f()
> > allocates buffers using vzalloc(), and needs to share the buffers with =
the
> > host OS by calling set_memory_decrypted(), which is not working for
> > vmalloc() yet. Add the support by handling the pages one by one.
>=20
> Why do you use vmalloc here in the first place?

We changed to vmalloc() long ago, mainly for 2 reasons:

1) __alloc_pages() only allows us to allocate up to 4MB of contiguous pages=
, but
we need a 16MB buffer in the Hyper-V vNIC driver for better performance.

2) Due to memory fragmentation, we have seen that the page allocator can fa=
il
to allocate 2 contigous pages, though the system has a lot of free memory. =
We
need to support Hyper-V vNIC hot addition, so we changed to vmalloc. See

b679ef73edc2 ("hyperv: Add support for physically discontinuous receive buf=
fer")
06b47aac4924 ("Drivers: net-next: hyperv: Increase the size of the sendbuf =
region")

> Will you also adjust direct mapping to have shared bit set?
>=20
> If not, we will have problems with load_unaligned_zeropad() when it will
> access shared pages via non-shared mapping.
>=20
> If direct mapping is adjusted, we will get direct mapping fragmentation.

load_unaligned_zeropad() was added 10 years ago by Linus in
e419b4cc5856 ("vfs: make word-at-a-time accesses handle a non-existing page=
")=20
so this seemingly-strange usage is legitimate.

Sorry I don't know how to adjust direct mapping. Do you mean I should do
something like the below in tdx_enc_status_changed_for_vmalloc() for
every 'start_va':
  pa =3D slow_virt_to_phys(start_va);
  set_memory_decrypted(phys_to_virt(pa), 1);
?

But IIRC this issue is not specific to vmalloc()? e.g. we get 1 page by
__get_free_pages(GFP_KERNEL, 0) or kmalloc(PAGE_SIZE, GFP_KERNEL)
and we call set_memory_decrypted() for the page. How can we make
sure the callers of load_unaligned_zeropad() can't access the page
via non-shared mapping?

It looks like you have a patchset to address the issue (it looks like it
hasn't been merged into the mainline?) ?
https://lwn.net/ml/linux-kernel/20220614120231.48165-11-kirill.shutemov@lin=
ux.intel.com/

BTW, I'll drop tdx_enc_status_changed_for_vmalloc() and try to enhance the
existing tdx_enc_status() to support both direct mapping and vmalloc().

> Maybe tap into swiotlb buffer using DMA API?

I doubt the Hyper-V vNIC driver here can call dma_alloc_coherent() to
get a 16MB buffer from swiotlb buffers. I'm looking at dma_alloc_coherent()=
 ->
dma_alloc_attrs() -> dma_direct_alloc(), which typically calls=20
__dma_direct_alloc_pages() to allocate congituous memory pages (which
can't exceed the 4MB limit. Note there is no virtual IOMMU in a guest on Hy=
per-V).

It looks like we can't force dma_direct_alloc() to call dma_direct_alloc_no=
_mapping(),
because even if we set the DMA_ATTR_NO_KERNEL_MAPPING flag,
force_dma_unencrypted() is still always true for a TDX guest.
