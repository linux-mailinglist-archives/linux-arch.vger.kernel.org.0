Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8DC6A9194
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjCCHQv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 02:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCHQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 02:16:50 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870684740C;
        Thu,  2 Mar 2023 23:16:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZBXuZCEiDsOW7H0GsSR20HJSjHCjCuyomiRZXM/F+fizwhSmEv6+qV1Cnaq0Uukf+Qs+5JgqQ/CghtN054qmSTncggpPUHJub2tZpxCQ5TgLAW/b32jrCkXiVqPkgZL7OPXXhO/TxzyPiXxxShttfqfOiD+ps2n55q9rC8KNP7rJdKGEdzZB4NCqVM3Ftt/QDmRpHiHB20jNJlG6C6NI3P4sMnM/YVeofizJ9lIXGWzzkDOoHuHMcY3fROMPnFpItm/Qp2VnGpouzf0/5bvbGcbzpGWX4kcRVLWtT2wIE15AO0sasP/vGg4k5FdHNAF2nI/6mrzBxR9Pi6TuqEgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM03yG5qg4ecvF/oqlV2nU5hUbnUTuyvnT6pRagshuo=;
 b=EngRx8qFgOa6GvNa/Z8Ra+zRznh8Oe3bfZnNGyKa9zCx8Xn7tzNJz0CNScFdxpWCb8+1QpfdQniAQATc/mkjDFFgiDRWrr8Me3lrLP5Y9nodSG+6jUlx71vWgc0nyXb79dNGWp7g9m8+Yx41n5U5wLdivuTsZ8s3kpmn1wCmQj+Wm5uxpz22G2tg6pIr+HmbEIkyg6yMwsZ1p3fbOPc2JSWJbJEVonBSb7g5XTXgPR1kJpyHmr8pU7FFKI0UPrxpmrlRhg+JoeA0lkIYktX75DALlfmSCArdUTNZhgU9HjukRzhX3FZ3MFmVpqrQo6eYtIGCTAtYGANLiaFh75/u3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM03yG5qg4ecvF/oqlV2nU5hUbnUTuyvnT6pRagshuo=;
 b=BloJZDg1//Ph6qAh+OherBngezCyAVffmrb4kM9uHRp5wdlEOoMnpkKiUEY61ii/RDGY3utLxn5LwGKmV7e/2i8auGgb69Ixe0X8ky6NU4dw6dprSIL4yvr1zEuDdlYwSBBM7SIZ30TWKSOzSNQ7f/wCHIHCID6mqgjFf5a2CsI=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3648.namprd21.prod.outlook.com (2603:10b6:a03:454::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.4; Fri, 3 Mar
 2023 07:16:42 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2%6]) with mapi id 15.20.6178.010; Fri, 3 Mar 2023
 07:16:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v3 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v3 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZQtKKlvsyoVW3g0qP8C+HsO3CIq7ouMzg
Date:   Fri, 3 Mar 2023 07:16:41 +0000
Message-ID: <SA1PR21MB1335549C889EE8309AF97C1BBFB39@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230206192419.24525-1-decui@microsoft.com>
 <20230206192419.24525-3-decui@microsoft.com>
 <20230217131949.oj4jz4dbvhyen5rl@box.shutemov.name>
In-Reply-To: <20230217131949.oj4jz4dbvhyen5rl@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d93d53a-67e5-4177-881e-8dd26458c16b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-03T07:10:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3648:EE_
x-ms-office365-filtering-correlation-id: bebb0aea-9252-4c51-5a2a-08db1bb73ca4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4CPC1/c5It9HeyJmJMG4+EekQXF1bwAV/3KWCSbeCqPix8DckzrzGvyJzL0DNlxgTCzmEmAP9Rwpa3BtdyZ5iop4x5Qqvm2kIHyw6UGB9xu4zsSUk95FxvQlqlomTjw+4ikT/SfkFiWjl6x9Xj+Mn3pOBTQ2t/7Um0TsOzrq7YKVz3VzYFBJ+CRXEMr2w5VLl/iXa4WzhXta+QfZ9ahfEmQo1jbXu4i2wXmdwIvP26bBUiJNCMBDkP514ddYcqW9Hg91JWMuqIfE4lLZZfJsjWrd3TRqXY4S/5KUjeba/4HZWXA9VVHO5O5WLts6IKniUK8BmXtODeioIOTl4t2U8k/WsqPZayWCjWjMkw0qXzw8u/7zhE7G527lhzhKoPh6VYOkKPfQRVDa3sVhDVB6Vr61+oY1ZNw1twxOzVcQjeavFfWYbwIxqwWbB8R7l5iy/zb6LO1CSxGE65U4jWCl778MxRI948rLBbNM3ens3n59KJ9EBDmsZ3sxx2kiw+dxY5oYJm468HA5IoXAxyBQos3/4UeqmcCXwX6Tj3/Fr4e0z+YvjcCEPiXyBcZ/0aHjpljej8X0of5KLmJq7VWv4KROhiO22tp4L9/9Muuz8IOXWdoFa/+MtjtJPCLZKBg8RdQuQKg9u+aSdaIvmOr9XzYKX7EmrMou5VTukWrWVHkOHJBk7CvBRvPzM7K9G8bLUvJRUqHoJSpwKEAcjCk30osUUJAS/KcDV6B8lLXNXSsy1P3QVuDsR4yNEZGWMWEj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199018)(5660300002)(4326008)(64756008)(66446008)(8676002)(41300700001)(478600001)(66476007)(10290500003)(86362001)(33656002)(107886003)(8990500004)(83380400001)(2906002)(76116006)(26005)(316002)(6506007)(82950400001)(53546011)(66556008)(52536014)(71200400001)(6916009)(55016003)(9686003)(54906003)(66946007)(7696005)(186003)(82960400001)(8936002)(7416002)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sCpBsKbcZfCzJG72daWA8kMLesvz+QCJMyHNOs/wvXC/jkUU2tc0VNCEfRwh?=
 =?us-ascii?Q?EcZ9bEArGfxsGi0LMa26bBhkNwfODQMc3BQt08Qfblz1V+JP34/aliaUuTsU?=
 =?us-ascii?Q?U32/AwzSSDdYJnWwTOoTZZwbzLGee1WCJoY97/zVz8FRloAiMAnOuvSTiX8P?=
 =?us-ascii?Q?IyiasyWf0Ff8WpdafdGoxJyHlaaEaUcXUuHZQxJHAYkAuBTfbMdu7J72mfsu?=
 =?us-ascii?Q?pEbZI+8I4xyH6abiDcrsXoJA7fzV1e9Fbin064vutlJaMhFqtTrq1Z++1p8w?=
 =?us-ascii?Q?cCsZeVE/QIhfOiNC7Ro4wWdac5YTa8MALAQ1qXO1BE+fJaGL9WftnkqHhDQZ?=
 =?us-ascii?Q?fC7C+xNp9NAX4z8aKQt8DiV25DXlnM1A9N2M53JJwTGH3qWl5+h639dxNCBa?=
 =?us-ascii?Q?upjvOtD/aUNcu3u4o5y5/4XX0HA3qhnkQcKREUk81nrP1bqIzqvr6lfbuiNV?=
 =?us-ascii?Q?CmQvacvjJgp5HElMKZemjuXtDMKHOUthBrAMvO9Wu4UvyE9wNEpVWspjiWx6?=
 =?us-ascii?Q?I/GXgdRwxGe3DvBQwlHJMZkJ20sKk70yDko6fxCiF4iYcMkU8za4V67g3cJf?=
 =?us-ascii?Q?CFpaEGJM1BDxbqp4TnDox+tfal7Nb+HVCRNuxcg4k7FXH5vowsRVxWb1bNP8?=
 =?us-ascii?Q?A3Uxh3/tV9csK9X+1O+CXfAa6SYXxVoz7NJPJm6W9zxtUpDE8B6eE2rhfyyS?=
 =?us-ascii?Q?6U3gO3kyeBOEguPm5LrRak3znjmCEYDPXBCiFfzCh0X+PrEq8N+gM5/b/sfm?=
 =?us-ascii?Q?7hJH+nx7lvXMItcEUNcoH7rvXeX+CKAV7iIq3v8XhuhRlOElI3qf1FX878D1?=
 =?us-ascii?Q?O8SBi+eyidq1B7JB48DDkvMJsKYU4HaA05Hb41DYszmLNy14pYK90Vb2pwkw?=
 =?us-ascii?Q?9rL60tzdu++P1aJDBxINOFyAByohLiH/In4HdOUUx6jXlc5mE3i09Lq88Ffc?=
 =?us-ascii?Q?WmQJCXEMc3zoiai3OBCedev1yBkn1s143rNu+hlbOWl5lgUQRvHDLki0pgt/?=
 =?us-ascii?Q?xCxYOLDsykSSUCKz2N51IDOiUdMkuTT2hLsjyPxy6h2RAzQ81v+z7qbhGkhL?=
 =?us-ascii?Q?HEK29SoHQ3n5ZzfyBj66OHCl9mCvh9Xn9ruLycxIG9WwlfMDyiz1G8M5hZf1?=
 =?us-ascii?Q?JYcuq3YwDJEy/GBbKgYlqGmBkiFpnNVNQaibgxNdFYMb1AlUzk7xKZ2Ndb+s?=
 =?us-ascii?Q?FYjm1qmdpBoT3DrWBo8YMHDZr9u3U7TOtgCUf6h3tCjJZkbl4WdqVqdCuCh+?=
 =?us-ascii?Q?sUaq4vElo9PjgRaDJCJKc5LX6jq+9yfkMD6Y26hFUPrVuqGNoOSLRNExzBvf?=
 =?us-ascii?Q?rr9K6u+pBrRBQWqrL+XOEUqOUeY0aUo1szwb8MLrofJWPDS08qvMle994BlW?=
 =?us-ascii?Q?i77y9YtDKO+euJFrYkc9vbKnGrQDf/hbvafFcoF8nkWPrNHDT5FX70CvFthh?=
 =?us-ascii?Q?Dgnw3jJTQZyKzyv0YXVcuZ51UzOBuZoZCnjyLzRFOVA90CP/SvC6PX2fZg6Y?=
 =?us-ascii?Q?O6aXtG/jZO3x8KilpQ8QaFJZwyscl9Kp/x3mMlaeF46CtgkDbj/5JjMoykJy?=
 =?us-ascii?Q?rroOEMQofX/7Mifl3QT+lnZXCjQsnvyLBS51P4qJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebb0aea-9252-4c51-5a2a-08db1bb73ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2023 07:16:41.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEu4ZbWaT8TBu0ZtMJxUG2tT62rh5zmAgmlDXUdrw08OAWzpJJ3qChPEeCfZpm4JIJAEjKXPQXsUllIHhnkPHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3648
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Kirill A. Shutemov <kirill@shutemov.name>
> Sent: Friday, February 17, 2023 5:20 AM
> To: Dexuan Cui <decui@microsoft.com>
> > ...
Hi Krill, sorry for my late reply!

> > Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
> > how to get the underlying huge page info (if huge page is in use) and
> > try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
> > is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
> > underlying page allocation info is internal to the mm code, and there
> > is no mm API to for me get the info in tdx_enc_status_changed().
>=20
> I also don't obvious way to retrieve this info after vmalloc() is
> complete. split_page() makes all pages independent.
>=20
> I think you can try to do this manually: allocate a vmalloc region,
> allocate pages manually, and put into the region. This way you always kno=
w
> page sizes and can optimize conversion to shared memory.
>=20
> But it is tedious and I'm not sure if it worth the gain.
Thanks, I'll do some research on this idea.

> > Hi, Kirill, the load_unaligned_zeropad() issue is not addressed in
> > this patch. The issue looks like a generic issue that also happens to
> > AMD SNP vTOM mode and C-bit mode. Will need to figure out how to
> > address the issue. If we decide to adjust direct mapping to have the
> > shared bit set, it lools like we need to do the below for each
> > 'start_va' vmalloc page:
> >   pa =3D slow_virt_to_phys(start_va);
> >   set_memory_decrypted(phys_to_virt(pa), 1); -- this line calls
> > tdx_enc_status_changed() the second time for the same age, which is not
> > great. It looks like we need to find a way to reuse the cpa_flush()
> > related code in __set_memory_enc_pgtable() and make sure we call
> > tdx_enc_status_changed() only once for the same page from vmalloc()?
>=20
> Actually, current code will change direct mapping for you. I just
> double-checked: the alias processing in __change_page_attr_set_clr() will
> change direct mapping if you call it on vmalloc()ed memory.
>=20
> Splitting direct mapping is still unfortunate, but well.
>=20
> >
> > Changes in v3:
> >   No change since v2.
> >
> >  arch/x86/coco/tdx/tdx.c | 69 ++++++++++++++++++++++++++---------------
> >  1 file changed, 44 insertions(+), 25 deletions(-)
>=20
> I don't hate what you did here. But I think the code below is a bit
> cleaner.
>=20
> Any opinions?
Thanks! Your version looks much better. I'll use it in in v4.
