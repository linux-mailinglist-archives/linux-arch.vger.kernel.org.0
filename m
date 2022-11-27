Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BE639CC1
	for <lists+linux-arch@lfdr.de>; Sun, 27 Nov 2022 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK0U1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 15:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0U1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 15:27:53 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020024.outbound.protection.outlook.com [52.101.46.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599F6418;
        Sun, 27 Nov 2022 12:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndHWIen9/vNmeYLdyAHrtd1NE1d+kAFnnafpz9F3vMxAqV6uRO8u9r+chvt2mZQkeRAahS1tdyNLpGLCqr90MEO76uYgWcKqYVL1IHhzFCC62A5mOsd1+cOQ9Y2amDqV5/QxNQugWA5QLctf+yE4sSVOdYpAJVqS5Dp0oNNiwn4caegooNM6J2ghdzrhJBA0anAWk7IYm/q2dYjMbDRxVsg8g8ge8VZ4XmhceECsQ8DczZUK3/dBZ7kj/sDz8mSeNdZxFRzlgSvitJCPoqpy3R48vdXlUNaIuFnj0sXXM9HCIZ1L/8SCVbcTH83da/X6Wd44PEXRyAdXmse9yVq92w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMckL/gpO7SQonfXwhXtY/zcJsZ9n4TTk5hnFtNx+ww=;
 b=kVYlk0g4hdXITyAtBr1iOsryywfPHxvrCQW8enrbO2AYjNCy7XimjGABQztbg+ii2eB0nzkcoP1Fm9L32Kb3qY4K4ZbH5jJQELfh3YbQOM4dT+IquItKCtb+P3LSTS4NvcZN7jYv+IIX/RyxMM0jGkD6GLdkvZ4P/G9hq/VD7+Ttmi8tSAd08rZvVuB4cGWaXHZrE6tbIIrGiZL5VWmNWFqtOgISKccBfbGPfY8rw8ayWcCUHZgV6nxrN/TjLELGmAAuGQyhIV1mDgYfJ+ncch7kVmqWx/bQtsNybrM4iSqWrengzPgVg37qPJBMTz7Wks/NH6kBM0SzsiW+8oBKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMckL/gpO7SQonfXwhXtY/zcJsZ9n4TTk5hnFtNx+ww=;
 b=DwVdUFGT7dqstMcmLGZL7QBUUiSb6M0SrDg5qxwZ2rXTiX0VlK8htO9DLpdT+ZTTdGbuShKiZnqw+/w6ZCo7IimFUd/ifBsEaSRwQlzhmmLLU+wHpUNk9I5mV8CXiU+2Q3L8fSdEt+a01YuKsogq37/eYqkEtUJxqAdox6fKxkE=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CH2PR21MB1413.namprd21.prod.outlook.com (2603:10b6:610:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sun, 27 Nov
 2022 20:27:49 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Sun, 27 Nov 2022
 20:27:49 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH 3/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHY/5Z0Z424jDhUsEe8P9jmzKLFI65Ns+2AgAV8WbA=
Date:   Sun, 27 Nov 2022 20:27:48 +0000
Message-ID: <SA1PR21MB1335A5E7E0B7592FA96814DEBF109@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-4-decui@microsoft.com>
 <20221122002421.qg4h47cjoc2birvb@box.shutemov.name>
 <SA1PR21MB133536EA0C26DFE0168E2F98BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221124075125.56cpbkmjyr26dzsn@box.shutemov.name>
In-Reply-To: <20221124075125.56cpbkmjyr26dzsn@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=89e565df-ecbd-49e0-8cd7-eac7f94dc372;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-27T19:37:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CH2PR21MB1413:EE_
x-ms-office365-filtering-correlation-id: 2bd26e36-c756-48ce-769d-08dad0b5d9a3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EG9pSh445o4vyjCWI1dw9S/VODPpDOI1L6h0/g7LHSSfP2vXuYxlSVNTNMKHFbIJXmVq5oKH8BvQWu3xv9wnJi+RxlkVd2rkt4o57dG5SAtGvq5lbNn8XacRyb4Kovxn3R1jZWV0s52T6jNSw41F0k7DFlqxfEv0FaLh9rxR4hhJ+G7TzpULXWzYlYFngcarayxaLSHFvg9BFp6+eyV90AVDZ5+3Z0Fzrwajzz4i44aDONy4yYH5RJXkUMtNIuQ/dPachY2eid54RXY/KIunuiTyoJfiPCkCzUTdIxqXnPDrI5j19I45vjriIzpXguDXesthBsm3x/2O9ahne1UqW51rqC4tqZAYWlxoqJGCwZTfyzm72DQ6QP9D5hrhVHHaqWc7Hr4KUTFUE49Qa+sSchgLQEoL43NYXFruu4aOxUhyxK+W0cW2pKQWfGsQbmtB92F9ED9Fh7wkz70rnYn3vqGe/+hX0JCUnjQDrC3gcNp4gZabtHu8Z4yMtn5DkHloJna0kUJkq5jF5U3mAHviHz87biqD57zqUpUTAYwuxEgH9XzMZ3v7z7ZbW+yS2VrRWPTl06wJaNrNtx7L3q70MWDo2dh25tiPbm1yQdeui9ryIIqtFxh3kFQH4isU+lMigHzmNF5D82cEeTYFPV9gL4NN3HmkV8OMzHrfH/rfeFxt6G6af9VvkIBwZHMpSRHaiFCIYYbT/aOcP3/xIUPLmzmyEDqv40lDK5ANdAQo63kM9khqTnZeIzrzG5k7rgy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199015)(316002)(478600001)(76116006)(66946007)(2906002)(33656002)(54906003)(6916009)(71200400001)(8990500004)(10290500003)(83380400001)(122000001)(82950400001)(82960400001)(107886003)(38100700002)(55016003)(26005)(7696005)(6506007)(86362001)(9686003)(186003)(38070700005)(5660300002)(7416002)(52536014)(8936002)(41300700001)(8676002)(66446008)(66556008)(66476007)(64756008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cHn1/maFVHGDDz/tjekHjBGUJkgAJMjDg/u2rw65SM7AimmmtJjkzdXxQGsO?=
 =?us-ascii?Q?NlQdRDFVVZNdJNJcq32ueFESVNCBCkyArs4yjI3InV5yvDdbWMBPBoYNk0R6?=
 =?us-ascii?Q?wfrZ67hwif+n6xWIMnxn2rzwGnD0ECoBoWECh0OueO4rr9iSoOaW81AatPhE?=
 =?us-ascii?Q?IeNoHhYMGWEnDg08QBqglD8AbVvWBfCHICNl14a4JZZRhRPTYIeGiYnxZ1pU?=
 =?us-ascii?Q?rRHln8X7rOb9ZpDOptqOYNJFegdHavZEAdkYhPpWnVbhPsc8GNWWGEiJQ8y4?=
 =?us-ascii?Q?cujrNJW2ufEHp+pTkMtYL9rgTsJEtgTLZPjUnzwH2cjtKHA3udicP62NMtGW?=
 =?us-ascii?Q?4x4TmQX8Pp+3AENFYfPUzZjvV26oPso4U+dtS00vtY2bm8KI+5WIJpcbd1w6?=
 =?us-ascii?Q?NVjOEHvsWrsJU1oWxUkwh9Xm4SY39G34NGHI5z2+hN+0g6XyTLzWg/XV0sfk?=
 =?us-ascii?Q?7PeeNBK0INx383a3GyvyBo9/AKah1vJoUw8d0pzQnsbzOp1lIvYr7fhff5Rp?=
 =?us-ascii?Q?hm1kiKi6um5FkzZEV2uw2oKs5B4KeH/krF4niBh0kfMFLdsQ7VSw4N0dDSIq?=
 =?us-ascii?Q?YpwH02AJimmt07GNVlIUGcLNqRdKW4MVI17ZEfx5pvIORw62YYWmr9Plput6?=
 =?us-ascii?Q?Og4XSb9ydFPklyStYo2sxM2f46MbYesOSVglpZxXgdJiS+LDXNYfbe1gFLII?=
 =?us-ascii?Q?IjsMAYTRCGoUGzRC2/X8DlOIGYjUo1o0v7PgO6qtF2g5Eotkto79KdeJTiQ9?=
 =?us-ascii?Q?Kk8uN3yDw5lsQztuer7OjCI0/eR2bWi9s3LWXhBzS/XvcbEIIX2RVPk+jIKj?=
 =?us-ascii?Q?qOzlFdSNihOYeNmVHI+E2wfztjcLfSIMX/bRJwbJdSSSJEGWw7g34judw2+5?=
 =?us-ascii?Q?Ry9QWCzXDSeA2ppOIDg2WNLx7n5SHR4ywav8aCZnLNQ/RBeIyH6kl6TPgt/3?=
 =?us-ascii?Q?qtnH+4h0Hax8ConC2ezjk1OHDy3o8ze47MvVxVHNqIhodzpaxYntl+IuJmuc?=
 =?us-ascii?Q?NvyWoim0UoAYh8MRT8nyUypH42fc5ii3/UFKZ/MJ6j+Wdan6nxKJN6W87AbQ?=
 =?us-ascii?Q?P5xOI6JQx8KBiDHFPKDLcFlG2rYs2wIAP56blhoeIrecnEgPsFDHKNZYQWzJ?=
 =?us-ascii?Q?OTfYD7DDdgfmbdylUFFJR+3fmRgZEoWS32IeqZH7S0g/NFv+ME7IMUNFKnL2?=
 =?us-ascii?Q?RZNubuGeGDgYrMNZVwZoiWkeC27QrWxngHvhHntgFkj9SkbYrGNgnCPHi/jh?=
 =?us-ascii?Q?i43bGQ/hAn7m/uFpfLyGP7NxyhAywdFrCr9NEZjrm4aYi5V65/Pvv3rDJORi?=
 =?us-ascii?Q?aXkBdVHJ0g/lxDu5zTOI/ROip+w8iYHlZZ6GGSQLHCxepFKDz1n00zPXbbpE?=
 =?us-ascii?Q?/VWKHfngNfy3tD4y/xhcCnE3HIBvGQs9wIebHPrQLVmCXHJarzR72HlbCdXh?=
 =?us-ascii?Q?P7FC/0En9KRy1IbpkI+j7bFn+o6NdPi/85v/A0wNVxbkkvW1LwB/xPrbxK9v?=
 =?us-ascii?Q?4M9TyJUDz50tyIpCv9RHxHopNZ3Ww+sRoQEu9ykG7bBqC14MuUhejwlULZqC?=
 =?us-ascii?Q?vKtWrCKFG8qzVosf2q0VNXSNFNV7bAuk+SDgbVh1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd26e36-c756-48ce-769d-08dad0b5d9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2022 20:27:48.4844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqCA8Iw8MqSkzhAE49v/+Txwz9wdl6tX3bw6MmGKmScfL/Y8TZ7o27K8BfQTTR1O9ktbAOmqqCm6bSSqS2NAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1413
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Wednesday, November 23, 2022 11:51 PM
> > [...]
> > > Will you also adjust direct mapping to have shared bit set?
> > >
> > > If not, we will have problems with load_unaligned_zeropad() when it w=
ill
> > > access shared pages via non-shared mapping.

It looks like this is also an issue to AMD SNP?

> > > If direct mapping is adjusted, we will get direct mapping fragmentati=
on.
> > [...]
>=20
> __get_free_pages() and kmalloc() returns pointer to the page in the direc=
t
> mapping. set_memory_decrypted() adjust direct mapping to have the shared
> bit set. Everything is fine.

You're correct. Now I understand the issue.
=20
> > BTW, I'll drop tdx_enc_status_changed_for_vmalloc() and try to enhance =
the
> > existing tdx_enc_status() to support both direct mapping and vmalloc().

Looks like I should not drop tdx_enc_status_changed_for_vmalloc() and have =
to
detect if the addr is a vmalloc address, and if yes we'll have to adjust th=
e direct
mapping?

> > > Maybe tap into swiotlb buffer using DMA API?
> >
> > I doubt the Hyper-V vNIC driver here can call dma_alloc_coherent() to
> > get a 16MB buffer from swiotlb buffers. I'm looking at dma_alloc_cohere=
nt()
> ->
> > dma_alloc_attrs() -> dma_direct_alloc(), which typically calls
> > __dma_direct_alloc_pages() to allocate congituous memory pages (which
> > can't exceed the 4MB limit. Note there is no virtual IOMMU in a guest o=
n
> Hyper-V).
> >
> > It looks like we can't force dma_direct_alloc() to call
> dma_direct_alloc_no_mapping(),
> > because even if we set the DMA_ATTR_NO_KERNEL_MAPPING flag,
> > force_dma_unencrypted() is still always true for a TDX guest.
>=20
> The point is not in reaching dma_direct_alloc_no_mapping(). The idea is
> allocate from existing swiotlb that already has shared bit set in direct
> mapping.
>=20
> vmap area that maps pages allocated from swiotlb also should work fine.

My understanding is that swiotlb is mainly for buffer bouncing, and the
only non-static function in kernel/dma/swiotlb.c for allocating memory=20
is swiotlb_alloc(), which is defined only if CONFIG_DMA_RESTRICTED_POOL=3Dy=
,
which is =3Dn on x86-64 due to CONFIG_OF=3Dn.

If we don't adjust the direct mapping, IMO we'll have to do:
1) force the kernel to not use load_unaligned_zeropad() for a coco VM?
Or
2) make swiotlb_alloc()/free() available to x86-64 and export them for driv=
ers?
Or
3) implement and use a custom memory pool that's pre-allocated using
__get_free_pages() and set_memory_decrypted(), and use the pool in drivers?=
??

BTW, ideas 1) and 3) are from Michael Kelley who discussed the issue with m=
e.
Michael can share more details and thoughts.

I'm inclined to detect a vmalloc address and adjust the direct mapping:

1) Typically IMO drivers don't use a lot of shared buffers from vmalloc(), =
so
direct mapping fragmentation is not a severe issue.

2) When a driver does use shared buffers from vmalloc(), typically it only
allocates the buffers once, when the device is being initialized. For a Lin=
ux
coco VM on Hyper-V, only the hv_netvsc driver uses shared buffers from
vmalloc(). While we do need to support vNIC hot add/remove, in practice
AFAIK vNIC hot add/remove happens very infrequently.

Thoughts?
