Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA80F65F537
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jan 2023 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAEU3m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Jan 2023 15:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjAEU3j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jan 2023 15:29:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2105.outbound.protection.outlook.com [40.107.94.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684B763F57;
        Thu,  5 Jan 2023 12:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I418xVgW9Ts0/uWNrdC2Pts+waJnwEC3g0iqbpWgFQu0zxiHKX4UabooRKIfrqaAyAw6qdbNZc5lehrEbjyPWx9PGO6pCPqsMNTBS4BIc4CRo5z5FbgBfjtZDyDiC9ohDOU0CU3T7DfWRCICJ1cA8Jucr6yU9GFHJ8HumhJDCtx159R8ZGUqmytXD2mHDMb3Yxizc3amdZ8b5V7sbLBzNt33kTsOUjvPP0Aze+dxYDKzS3xBHCPGOzDJa/EyD7KyStQ3rDcDl9mRrcT0/NfgCA61cyFMA4oBJ4zElmRDLHnA4uP/YMSUyr+ZdcrNSEdXf7R/MY/ztORKeQw1xPLDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3ja1Or1b9Hb2M0hBV1D0PlVnfRbSdz/T/1fIqkgS84=;
 b=D02TJ/5rCraIJ6/Qq66hgUhGERjHP1z80srOPWA904cDabi599u5CLTr5O3/6vpKlnQ6nLzmZc4gT8rT9wlGhmPKuPn49zFfB0DI6Fqr0P9F8jDL1yif47VrsxvTruC0LPr0W4k8tRRFKWOk0SwAWjT2ESjaSUzFbVh4WXFFOpnz67R5oWIk/jHtysrcb0aDyt/yISdeQnmqqvc0GTPTpxEb5moZZX/zmHAvGJMc8fSowGe97IrJZxMVPb2+1ZnuXp9f0uLpu/OBMkX55XFU4vil0YgoAPSnMIlefliwU99JChB20zlBk8SmCuLBAs1EKF7a2q18tRpvwWRxafYpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ja1Or1b9Hb2M0hBV1D0PlVnfRbSdz/T/1fIqkgS84=;
 b=c9pRF1IKfRZIAkzHharssDePrkIJNP4PDyxEh10wh8rPHleABmwplrO1xvjawDajsTStmhPWxwaBWighYmBqa8RaKcvXGra9NywaU7iBHOuTgSa1LNYwmLlC96XOkJ1BrxeBQYFcHlcg88ystrbvL0+e0PAprtWN0BQBFH6EuH4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1439.namprd21.prod.outlook.com (2603:10b6:208:20a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.5; Thu, 5 Jan
 2023 20:29:25 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::9244:f714:3c6d:ba37%5]) with mapi id 15.20.6002.004; Thu, 5 Jan 2023
 20:29:25 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Zhi Wang <zhi.wang.linux@gmail.com>
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
        "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>
Subject: RE: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v2 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZIOpXAghmsq3xdEqAL1zty4oDaa6QFLQAgAALbQCAACLkQA==
Date:   Thu, 5 Jan 2023 20:29:25 +0000
Message-ID: <SA1PR21MB133576523E55BBC7300DE2B1BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
        <20221207003325.21503-3-decui@microsoft.com>
        <20230105114435.000078e4@gmail.com>
        <SA1PR21MB133560538DDD7006CCB36E30BFFA9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20230105201024.00001ea0@gmail.com>
In-Reply-To: <20230105201024.00001ea0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b5ba56a2-4979-462a-b4da-a1f2a8c75097;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-05T20:15:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1439:EE_
x-ms-office365-filtering-correlation-id: 0501313b-cdde-4e11-b7db-08daef5b894b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xPP5QSLTzzKF+qQfVf5wPGWJWbRBJ2NZDAgcz93g4K2dw3UOftFPLneYIAtwRseQnGm2yjMo5oq5VgfaunjSa6LRN5v/kgSOx2HwRilx62ZKzqqEYlr8uR8djCY2QGmdtHg+zba5A5Y3a23EyMeN/AIwYhZyubob1+bqmDjDnk2aChsfVNFmOyPmtUbjPTtg19+vvAirXvP2hvShvxM8SGwIENcS/B/lXgsK6vtf2SWESqqiR+MrgKeQRmlcTojf2gjJ/LkzPtose0n+ncW9mPrwLjzd3aJV1oL4PjlGP+JuaQ3+BohkvIHqrxcEOnIFbYo5WuYGD0z/VFPN9tT1ci+UcVdkuiiKJBa5J+Pl9ikR8vJJCoRpPW29gcw/+GrEnye9bjZdy3ag4BPRH7tDr2MrjXhm2YLRFSiWu5a1+pR+s4S/j/oPtK7nLAhHE01z5WZ3d4NFVuzAAxsoe40ybzpLrOqXgW7jg1iL+0+Pn7cxTLH6nRfgWbRwxz7ArJHQwxhu/O2gnMmI3YgNvhLoTlJXkPI+t5eB/uwq87nC9znl2AN+beknt+VccbEs10DGk6bN12zV3wjRi+tyYYV93/d35lSH6JhYSNmf94oqm2BZfT6rx32WBax+QMy2e1gktE2gbxWvAkzuPmwgFDgozTQPJbKwWESs1/EpH2nUPkVCe0aKSM7m1VyzdyZE+X4jQZctz3e0E6dVaRrOpo9M0MZAZ/pyOS1Adl0qW5AJT3Vbn7ukI19/ua0xiSanL7/M6ozkejDbC72B3ko74JqquWqB7bqZbBNrOcShlY3B8CJgt+m83mOsSSdPkAcUH8Jr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(55016003)(38070700005)(6916009)(86362001)(33656002)(316002)(10290500003)(478600001)(54906003)(7696005)(7416002)(966005)(66946007)(2906002)(5660300002)(52536014)(76116006)(66476007)(66556008)(8676002)(8936002)(66446008)(41300700001)(64756008)(4326008)(82960400001)(38100700002)(122000001)(71200400001)(26005)(82950400001)(9686003)(8990500004)(186003)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?36Jkr7Sc3EgQfmRRzc3tQI0PiyYihc6nBBUurAlzZ+HBZK+VhbtZNmvIS90m?=
 =?us-ascii?Q?olmbptTj99RweMnozl5/peC25cy7NntJ3fNMF4QzSi6zlx6K/2LaEMFchaXZ?=
 =?us-ascii?Q?gOYBZRWYuK0jm7MNUvOOV5Ai6UX55wPyQ3txih1RWTTK1+MckQQ8ADHJXNIw?=
 =?us-ascii?Q?I0ZVhEscH5zMnYghVhvODq9WmqZuP1jtSw8t/n2eMpp6m68kMNdlu1SdKqW/?=
 =?us-ascii?Q?q/993ajDgzDhiuHSbMaeXKUvJzJIKn0PGFRZ7LdRXSb//rXt3Z8UdHBg7Wh+?=
 =?us-ascii?Q?aXUwQk418AiemBSqMAX4lmSf9nUtX9sa1haQF6g2lMQrYVpd0Sp5+ZahLWCx?=
 =?us-ascii?Q?CSpWqh0Xyv4wNXZnZyuU0NS6SDQ7hShzC5YnI3QuuYvCDeUfmIXheuXifo5E?=
 =?us-ascii?Q?9ZRzfSNoEwHoNsMEdJvtxe4JBtjDsPXxckcYJ9sbDW5xrAssccBIp18NnSRw?=
 =?us-ascii?Q?an0LQ4vyCaIuiXnM4xV8ii+DYerNLfgpIedXA143BmNuYKMLFXl+ZRykzITb?=
 =?us-ascii?Q?LZP4SWbsle88J6KCAGUN8bGldh/P+DTbo+3uoer8ajQac5IQPz5+6VdcDEXv?=
 =?us-ascii?Q?D7AWLjkXf8gfm90Ey1F1ZNIcGzoYXKcsbPGOHBXVEZLsS8LthhBZgSe81XF6?=
 =?us-ascii?Q?owIW29MzrNH2IV6WltEEn3FvdUtELYh5RSRS8ySzEPErKNHHx/3nL8imMw/s?=
 =?us-ascii?Q?OfajSVFe/W6Ox+2JtC4K1idPEarU/EfEU8+T/EeEv6EuWHmcqnsPrF7xUETN?=
 =?us-ascii?Q?EjbEUFBfnTRChcNFajJB1BHFVtETI55NuXZdF6YNHrHRn6KVyHsIZ7I3bg29?=
 =?us-ascii?Q?dAuDY6EdlCNIbRLjbDKi8AeeWlLwS8U7LeZpWJLghd43rJMUP2CP38dayzs+?=
 =?us-ascii?Q?fHDdTy91dOZHeKlcpuqrWMVmsD8vAe6Uj4294hnXHl7X4qP3btH/6owimXM1?=
 =?us-ascii?Q?CK5FnKk4ALMlhkxY2YtRYBXAbsG38IvwzQah4dccq8JaUTaGrruu/l9WzoKZ?=
 =?us-ascii?Q?J5D4MeWaIe4TeapLkZ8dfmsiRAF7x4NwESSAH3AeV7WKLyH0sxJCz8FaPY/Z?=
 =?us-ascii?Q?KHBtOpirQKDXY9rjQaVcWpSUVcKNr+rJdn+XYWll31cFlxwW3ENG6JvRKntf?=
 =?us-ascii?Q?UJilE8AkexTVNL7hq2rodH5/5bDel+FT3C9Q/CUf6fVDGja6rTgXqFdyIFtS?=
 =?us-ascii?Q?gfAl5hIGSMDe0es49KtHlG6a6lfxIxrbd+SRmUNut2W0k0Gp0C27ZWF9K9LJ?=
 =?us-ascii?Q?vKem4JkFK+rjBE3+HD4cXI6oyx1vryNXMI5Vfqs8pRAqM/J/hguIyrDeLsvt?=
 =?us-ascii?Q?MtQbUJDH8fOtU08OYhSzOvVMCRwsLbMtJnCCQNKfMYEisoF5c4Jqj9qkSAEz?=
 =?us-ascii?Q?zagXbu7uzSsQ6RiXYL+v0edevu/Go8JKG6wtgh2T1Wy0ZnxkL9X5Y15aYQg5?=
 =?us-ascii?Q?4f+IFkQZmfyOzebgqo0ahCGkGjWnPdIc15jL/jOz/4wj96CTJ5GA1VzDoUFE?=
 =?us-ascii?Q?5BwKiN7L2HzRVgkv0vaD4IypcGuGCXvouSkc2nFuNx826PfDe81SMMNRjyaW?=
 =?us-ascii?Q?NgKm/YVY4ZHFohgTPWYkfk4KOJVk7OzLA5HsZP9O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0501313b-cdde-4e11-b7db-08daef5b894b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 20:29:25.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXN0ZMT/nEPr46A2+QthBE0k6zTvvTAK7T8AawmTKH2/0HJvuNsD5kPK9MWKDhSdgRCE0nbTRUl+WaXnQmOzjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Zhi Wang <zhi.wang.linux@gmail.com>
> Sent: Thursday, January 5, 2023 10:10 AM
> [...]
> I see. Then do we still need the hv_map_memory()in the following
> code piece in netvsc.c after {set_memoery_encrypted, decrypted}()
> supporting memory from vmalloc()?

For SNP, set_memory_decrypted() is already able to support memory
from vmalloc().

For TDX, currently set_memory_decrypted()() is unable to support
memory from vmalloc().

>         /* set_memory_decrypted() is called here. */
>         ret =3D vmbus_establish_gpadl(device->channel,
> net_device->recv_buf, buf_size,=20
> &net_device->recv_buf_gpadl_handle);
>         if (ret !=3D 0) {
>                 netdev_err(ndev,
>                         "unable to establish receive buffer's gpadl\n");
>                 goto cleanup;
>         }
>=20
>         /* Should we remove this? */

The below block of code is for SNP rather than TDX, so it has nothing to do
with the patch here. BTW, the code is ineeded removed in Michael's patchset=
,
which is for device assignment support for SNP guests on Hyper-V:
https://lwn.net/ml/linux-kernel/1669951831-4180-11-git-send-email-mikelley@=
microsoft.com/
and I'm happy with the removal of the code.

>         if (hv_isolation_type_snp()) {
>                 vaddr =3D hv_map_memory(net_device->recv_buf, buf_size);
>                 if (!vaddr) {
>                         ret =3D -ENOMEM;
>                         goto cleanup;
>                 }
>=20
>                 net_device->recv_original_buf =3D net_device->recv_buf;
>                 net_device->recv_buf =3D vaddr;
>         }
>=20
> I assume that we need an VA mapped to a shared GPA here.

Yes.

> The VA(net_device->recv_buf) has been associated with a shared GPA in
> set_memory_decrypted() by adjusting the kernel page table.

For a SNP guest with pavavisor on Hyper-V, this is not true in the current
mainline kernel: see set_memory_decrypted() -> __set_memory_enc_dec():

static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
{
		//Dexuan: For a SNP guest with paravisor on Hyper-V, currently we
        // only call hv_set_mem_host_visibility(), i.e. the page tabe is no=
t
        // updated. This is being changed by Michael's patchset, e.g.,
https://lwn.net/ml/linux-kernel/1669951831-4180-7-git-send-email-mikelley@m=
icrosoft.com/
       =20
        if (hv_is_isolation_supported())
                return hv_set_mem_host_visibility(addr, numpages, !enc);

        if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
                return __set_memory_enc_pgtable(addr, numpages, enc);

        return 0;
}

> hv_map_memory()
> is with similar purpose but just a different way:
>=20
> void *hv_map_memory(void *addr, unsigned long size)
> {
>         unsigned long *pfns =3D kcalloc(size / PAGE_SIZE,
>                                       sizeof(unsigned long),
> GFP_KERNEL);
>         void *vaddr;
>         int i;
>=20
>         if (!pfns)
>                 return NULL;
>=20
>         for (i =3D 0; i < size / PAGE_SIZE; i++)
>                 pfns[i] =3D vmalloc_to_pfn(addr + i * PAGE_SIZE) +
>                         (ms_hyperv.shared_gpa_boundary >>
> PAGE_SHIFT);
>=20
>         vaddr =3D vmap_pfn(pfns, size / PAGE_SIZE, PAGE_KERNEL_IO);
>         kfree(pfns);
>=20
>         return vaddr;
> }
