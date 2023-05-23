Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5686170E552
	for <lists+linux-arch@lfdr.de>; Tue, 23 May 2023 21:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjEWTYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjEWTYU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 15:24:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2098.outbound.protection.outlook.com [40.107.93.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382E2FA;
        Tue, 23 May 2023 12:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWxBk1EkkrsV9/+x2fgsHFgXGFGXiVAM0j+2Q0ymEtaL+QQlbIkFL/83pl/znxl+qfAWgR5fJLaejyZ/x7pOtW/oPrdx1FBmjxzw55PMEjeHgjoXdApKd56NkJTqEjaPOZgQILr84Gp8lWOxX917UPO8SCf5yY3ZJIx5x5X9/p6EpOiGREIDiPubZkdUB9hL9CCAm2k8VK69z6t/VtW+Jx0jvedY25y1Xgehq2lfXmNM9n2eQv7VkMfas9E3uO3PYhKUchDcCNokEvhCvaSxgJfzUppDQ0c/N8WTLJrlVctbfJ9AbyoH+RdiJ9x6WpAV0n9kfP1H5N6mLdzc2m/rdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBmoj+Hupi3hEorEkzDmKbYEsS/SWD1FIJ2U1/3oYag=;
 b=Of4BC/3o9Vba34Z+9jR+FGclA/GovPVidmwrw2/YU4JLkqD9RwSPlmykDCwFsZxqPUXyv6hd0lsiH8PBKU0oRNUTM6YYJwsdSzBrMQrieVf+boyxoxO8Byc7ZwCC7R4H8DPXrT3TLfgAciu+lr+dlA/t9oMhFSeZj5+IFItLpoHs1GT7bANUIfwoQo0iIexS3+yWXgVS35s9Vu9qfsidJM5foULtEtIGt3oK7+dwuGZapV86th5PMRM1J+2XVzqO6rfrz0QqX77cJZrzcNT0flZHUMkCin/euhvjFyWDS+JQH6aUH4Lcv09xAbSj6KHEU3prkp3k4d346QoBVsyHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBmoj+Hupi3hEorEkzDmKbYEsS/SWD1FIJ2U1/3oYag=;
 b=U88+iI/qxy0CLFSNcJDOqwGtd5I2hvj5vtcfSKLhNXNadcwJImWSAthSAqd1Y+YAK7jGgdXg/pzZpxPxuB7vMnufQtZlS0v2Br2674jyXxuNNrZTv9o3RLFSd2k71njLFrcm59LU+tXaaulRJzh4U840PJLPCc6QAU5zzlZ9au8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MW4PR21MB1985.namprd21.prod.outlook.com (2603:10b6:303:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.7; Tue, 23 May
 2023 19:24:15 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.004; Tue, 23 May 2023
 19:24:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v6 0/6] Support TDX guests on Hyper-V
Thread-Topic: [PATCH v6 0/6] Support TDX guests on Hyper-V
Thread-Index: AQHZftts9zmkdpMLIUW3vDIrP9vrYK9oWG3Q
Date:   Tue, 23 May 2023 19:24:14 +0000
Message-ID: <SA1PR21MB133594566A3337BEF253F2F2BF40A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230504225351.10765-1-decui@microsoft.com>
In-Reply-To: <20230504225351.10765-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=39c20481-9604-44cd-8edf-696feb4a77f6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T19:16:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MW4PR21MB1985:EE_
x-ms-office365-filtering-correlation-id: 47662532-a40c-41a4-972f-08db5bc34bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAEKcaW3z7TYItDXFivCVnl0hLuOGPIApFD5ZafSWFzc6Hi91+/JzFmUIN5hVMnjGWpvpEe8Eglno5fKSNgeofx16p1VPsnysDL1tbApn3WvgRi1sjz1Ad3zXjk/kFZRebKlJLO3VywlVT6q1SIh3FU5ErLi2xSPWRmdp4gTQF2GPtMSm3DyYvy2qiTxaQHm6IXl0aScHkrJyZB6fOnBvRjK6HnefN6eUutONpB0LIDt4CYACQY7KMxK4EvqLscnvTJmATliRnIiCWvtMUe/ojbLYDjQGdEw2IgIva8SiJ59xx6AyOJzABtbrBkq+9ayt5AMbvWaIwlvqBasuGVpp4Ij2CjVcwDGcTAn9UUtypGHvRqPRHXLCOC3Cr6l9jxSjlLS8RRmPsb6B0ZVNaThNhF9mzpMNBdppNop59W5R+tkZ1JFymQ7/fvSoMiYlSKwTxzOwOPwrOSt876EWXXhsUhc/gXoPB+NIsJhnb7SD62PAHy70z83MPyPb3TA3H/+uybRudbe9MRRgowWdLtUJWioQPTcViuPloBrBJMXLJidTDgoRsLHMgkxlFv/mid83a1u0EfGJtLbMvbTEixY7Jxf8jOT0nOq9FBRhTvjNbFvP+tX468AgmYgjR8+RcRwk4M9naO8RXz0+etIMpOxs8zJ0JFc4y80+5RD3gcAhBU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(316002)(786003)(10290500003)(38100700002)(110136005)(54906003)(76116006)(66476007)(66946007)(66556008)(4326008)(66446008)(6636002)(64756008)(71200400001)(921005)(122000001)(82960400001)(82950400001)(41300700001)(478600001)(38070700005)(7696005)(86362001)(52536014)(5660300002)(8936002)(8676002)(966005)(186003)(7416002)(33656002)(107886003)(55016003)(53546011)(26005)(6506007)(9686003)(2906002)(8990500004)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?omLF4H9klvhFtdOJt3oNJvwCZhw4Sdgk2mAhWdsuD+iLF0xEY/9brl+EACXa?=
 =?us-ascii?Q?FAIRkpI7XzkrBsHFG0EqZcXH1Kaeo8ALa7RTib2aeLtjwsNyfEZ/frRMw2EN?=
 =?us-ascii?Q?iM/z8alH75Mgj9r+ESa02rHBnS4LUdkdjyRIOCm/CDNFkbYO7bYIpFVkIhpo?=
 =?us-ascii?Q?4R3lCsAR1OGUTahUW0FrSm7icoY2kACXEpPEnpd2ie48mubZJkivEPm+WPUC?=
 =?us-ascii?Q?hsoWxb9tZXBzWYsNjU/BnNaqVQpn9UwpFOztJMo1EnsjLTF0xO/b2sXoMmqb?=
 =?us-ascii?Q?88DwMp4X5pkhcnLqZRghK0Rn5wkSycd03wyaSV/r41kpJSRDhK/xpTHiff6w?=
 =?us-ascii?Q?3p6TXZmg4+KJrjcju0ey9OhtMXgch4TZI2Ff0pv16YGBO+XYEPcjf/MFI3++?=
 =?us-ascii?Q?rxcgktyzEBu7XHN5YkryUuNCu731q4Zg5ovGPW5sjWvUb6fUCHGcYrBbDglD?=
 =?us-ascii?Q?lmQ60Y10OoPt6coWlVbexx3goPGEp73PZ+49ztoUn0E4+jZjEAp/dfkawXpf?=
 =?us-ascii?Q?2EsL9rBRpmpu0tTcCLVoufNJk4kNX/6u/j8jBkj75zJN/FwFGJnceSlu2ywJ?=
 =?us-ascii?Q?Ra92v52o28G8MqSC34+oTnRleDmi1MRyU4cx6USM35whrpk+L/Gz7WcSi7j9?=
 =?us-ascii?Q?cyfjWsdSCFidcCcjtovADpaeOxUmkk0UY6TB1H67n8MCnYLJ+jV3FdPamJaQ?=
 =?us-ascii?Q?IX+LEseDjdBPmwWPgie54ThBXngsy2ffx9UvRVesnsOnfMVPmxP6QonwMDyL?=
 =?us-ascii?Q?oNh0v37jioFxrNG1rQIDrTQi+kSEFs/cONBlTxgZ0y6urkMZyJNNxfyc96on?=
 =?us-ascii?Q?hMyZFWoztpGPbr+KT9fUL1ZeHLbUgCeKuoGwba30J07CFq/M3u3DLweOt0ZW?=
 =?us-ascii?Q?+W/V650/RaCFCg7yHfgWsXHVZpQs7oRpuJMZk6sZkKvaSHC53EefcEhjLFBB?=
 =?us-ascii?Q?4R5MT7gRelHTmmB79GsmlxkW8EKbfd3SALXCMsaBpd6KRUkeAgWDQJre3iYg?=
 =?us-ascii?Q?qUxTWYH1Xd17bzFEoF3aDW8VMEpIWDyO3+ZNvyk4aye4avldJC79QCBzn2sU?=
 =?us-ascii?Q?coIB4yNFehq0knYCepDMQrPlHMXZeA6YAEdc6EG0HtoAEClOIw1fEtp2+7y/?=
 =?us-ascii?Q?rlOrP7h5V9u93VNsELL+7JvQ67fU9PZLik9TyflqNPzFsWQ26VR9jYZblNJx?=
 =?us-ascii?Q?tdEjDAqPG+5TBrZ2DFgrkBPrwoiJNrDkRsBy16w8+gmLJ8ESL7VtzYhlqOkk?=
 =?us-ascii?Q?iZvsuFtJ3B7aeJmTTR7oqdO8WwDPeG3KQ4PbHMKrJbAPBbVkfPnH9swz77lt?=
 =?us-ascii?Q?n4PlAkwOOFZjF9q/keUHnUm38cpjq8NwCkfXn0EQnoMRv0zLVETxDtn75oGo?=
 =?us-ascii?Q?qCnhg/CHPs4ceha6Q6HjUdK0WPh3PICEVbMiqtiedUARMAdilzNJLXNH5iXG?=
 =?us-ascii?Q?QRT1LbHU392XltkcNsWbLYhrU5DzXNLQUqe5I3Te/VDBxEtww/UOYlxXJIwh?=
 =?us-ascii?Q?mg75RWFZqMSvcWCq+cdvImz9n3urmuF3urbDTyE/gc1LTNCN6Ipf2E650fPL?=
 =?us-ascii?Q?HwIfFqorIEtkfNfg8ck6hltHS/cjjrW+RYOjQZis?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47662532-a40c-41a4-972f-08db5bc34bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 19:24:14.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmmCgutl3hicwUAubo0sR+l/91nV8yiXVXKE5ed8cLVp3iu6EwpA3DQZC5d64OiQWloVbCO+TgjuL8PPBqf4MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, May 4, 2023 3:54 PM
> To: ak@linux.intel.com; arnd@arndb.de; bp@alien8.de;
> brijesh.singh@amd.com; dan.j.williams@intel.com;
> dave.hansen@linux.intel.com; Haiyang Zhang <haiyangz@microsoft.com>;
> hpa@zytor.com; jane.chu@oracle.com; kirill.shutemov@linux.intel.com; KY
> Srinivasan <kys@microsoft.com>; linux-arch@vger.kernel.org;
> linux-hyperv@vger.kernel.org; luto@kernel.org; mingo@redhat.com;
> peterz@infradead.org; rostedt@goodmis.org;
> sathyanarayanan.kuppuswamy@linux.intel.com; seanjc@google.com;
> tglx@linutronix.de; tony.luck@intel.com; wei.liu@kernel.org; x86@kernel.o=
rg;
> Michael Kelley (LINUX) <mikelley@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; Tianyu Lan <Tianyu.Lan@microsoft.com>;
> Dexuan Cui <decui@microsoft.com>
> Subject: [PATCH v6 0/6] Support TDX guests on Hyper-V
>=20
> The patchset adds the Hyper-V specific code so that a TDX guest can run
> on Hyper-V. Please review.
>=20
> The v6 patchset is based on today's mainline (a1fd058b07d5).
>=20
> The v6 patchset addressed Michael's comments on patch 5:
>   Removed 2 unnecessary lines of messages from the commit log.
>   Fixed the error handling path for hv_synic_alloc()/free().
>   Printed the 'ret' in hv_synic_alloc()/free().
>=20
> @Michael Kelley: Can you please review patch 5?

Thanks Michael for your Reviewed-by on patch 5.
=20
> @x86 maintainers:
>   If the patches look good to you, can you please take patch 1 and 2
> into the tip tree?

Hi Dave and all, could you please take a look at the patchset?

The patchset can also be viewed here:
https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui%40microsoft.co=
m/

> @Wei Liu: I think patch 3, 4, 5, 6 should go through the Hyper-V tree
> since they change the Hyper-V code.
>=20
> If you want to view the patches on github, it is here:
> https://github.com/dcui/tdx/commits/decui/mainline/v6
>=20
> FYI, v1-v5 are here:
>  <snipped> on 5/23/2023
> =20
> Thanks,
> Dexuan
>=20
> Dexuan Cui (6):
>   x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
>   x86/tdx: Support vmalloc() for tdx_enc_status_changed()
>   x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
>   x86/hyperv: Support hypercalls for TDX guests
>   Drivers: hv: vmbus: Support TDX guests
>   x86/hyperv: Fix serial console interrupts for TDX guests
>=20
>  arch/x86/coco/tdx/tdx.c            | 122
> ++++++++++++++++++++++-------
>  arch/x86/hyperv/hv_apic.c          |   6 +-
>  arch/x86/hyperv/hv_init.c          |  27 ++++++-
>  arch/x86/hyperv/ivm.c              |  20 +++++
>  arch/x86/include/asm/hyperv-tlfs.h |   3 +-
>  arch/x86/include/asm/mshyperv.h    |  20 +++++
>  arch/x86/kernel/cpu/mshyperv.c     |  43 ++++++++++
>  drivers/hv/hv.c                    |  65 ++++++++++++++-
>  drivers/hv/hv_common.c             |  30 +++++++
>  include/asm-generic/mshyperv.h     |   1 +
>  10 files changed, 300 insertions(+), 37 deletions(-)

Thanks,
-- Dexuan
