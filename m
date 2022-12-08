Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344326476D5
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 20:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLHTyb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 14:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHTya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 14:54:30 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11022016.outbound.protection.outlook.com [40.93.200.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F3E56552;
        Thu,  8 Dec 2022 11:54:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNamr4kaTxahc19D3g0neDSasRjRzY3Dy7JruoMWBHxBttUXT/TqlhjX59Hpdx08QGLPB5XJyp8liz6k9aipQIX5kwcWALYOxnLQf4QDzjxGWDnENeLd+3QTn8q7BFnJDqrtDsO/KRQOHy12PU7FVsXgD3BkNMesFZm6it+7Q9H7RWnmAqz6l32b4Mk52ZWcvrhyYgEG7xrAInat9Pwuzf1uiJ4coGRQEcwQw+efsuc/dvMTmiYtqcHb3qlBBya7UNPNEBJAYmFcU5KmFqYcDW9YsfrLS9oxr2XU1ABF6Hf0O5/g37N11ztQOCR9KmTBla4oNibzWIPu20xq4GV2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3meGI4TFq0LsQlhwFa6SfURhtLSthRXyXc1tIP7z5w=;
 b=ODExIxHiGaUGBFIeNzj3rLeVhDPZNVTZAdC/k4KvPE0WNNOFQac2SsC6DV+GT+CUXqmxWg0vBbkNyD1v207yE8TLIDKdSjn0pgQ6RyUpJwtm4u3FdyMjFK68vmq4xE4yU9TP9JTCQupFx3jZ2nKD3ZYhhB6OPp2BYs5Y3DAHazpdks+pNOeINgR+ubxqyQ5ta57XLB75yOoIxuZMBv7ZOWhkFvhJR4UuPKGI01ea0N0dCt7QWRqPnhU+6/Y8sf2rBYwyTT/h/hlfq1N3e7DYNXUehTKZs52hKYdRCHy0XQTRbQDEkdoNmJjB9ktGUQ2aWP8aTqQTzh2AX/c+dsooEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3meGI4TFq0LsQlhwFa6SfURhtLSthRXyXc1tIP7z5w=;
 b=BIdxMTec3Ab56fdVdE5RiKnjIwt9iNFFjgQ7B+aZpC109Ti5a5o28Ej8rFj1HfDaTDR/pXMDV0AgKBovWDxSpJWISgcElNADKHMkbhxc5WWbvAa6DetpbW0URZF9tOTFvaTlenuWQgd/eifr9eEQrj0aC1TiA796BwmeKxVHwac=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Thu, 8 Dec
 2022 19:54:23 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%4]) with mapi id 15.20.5924.004; Thu, 8 Dec 2022
 19:54:23 +0000
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v2 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZCz4AOyDNAgTkI0C32ZM+R3hqDK5kZlNA
Date:   Thu, 8 Dec 2022 19:54:22 +0000
Message-ID: <SA1PR21MB133556956745BA16EC2841C9BF1D9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-2-decui@microsoft.com>
 <20221208194800.n27ak4xj6pmyny46@box.shutemov.name>
In-Reply-To: <20221208194800.n27ak4xj6pmyny46@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ae777a79-23e1-4591-9d3b-a941af323d76;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-12-08T19:51:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3457:EE_
x-ms-office365-filtering-correlation-id: 40e6eb23-9bff-4b12-5ae6-08dad95600d3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDtNzKU0p3uNOt1JkeCawyW5XUGUdD38TQIBMdhKsP3+IWBCiS4tc3WNQClaEq5EjVu0DBHlceHn15Tyfb0jc2paLgDqp1krKn97Ry3uIo9iO9P4ePvXNWEk0V33fPrFAoPufTOieJTiHdLKwK1KOrG7fOoILQq8cOL1/Uyk+qSWSPp7Un0g4qulBOhSRvJiJXwbepyZ67INt/TxzcgM040cDBiPSKbJROPWWQAgXbtmruHEd56Mcx3Exj0udMbt4rm09IgJrOqHhNacM0Kf/Jw4nyVOT+uKRYr2oZnBYiwlz7VZU4BbT+WwftJvTFOD0CEmSN6Xsucq1O31YQjXRr/NJndrRrUj7fjZ+ehvj8jJTuDjKHi11iIAiQYrGT3FQ6GCKSrMxNDVQFaCKAvARjYFFvSXQHZxWRih4T3BQovlbEtAtVBva42oLY2h8TLq16NQpnihxQ6hZldIBvqJnf1wsR32xUQ1xsMYbe8sqR2fjfxBHXmuQIJDhIa6HSO4FbpS1HQ6YThpkkIbZyFh2XMQdNJ9L2sVCp1xYRrjmvu7llWOmB9/lNlE8KZq8fL2KNDWKOEIIL2B4pzVoVsDmqB7O47GXDb5QG+FzjcUMQH6hkTtm1Rn3XEBM7u/DC0pNzhdhAbUVIbL4XXkSBSn9cn8HnG4bvumi1YE/wvMgnyYBPpabqUqnck2G4OOeyAPHdDuJpW0kNO7EFoyg3YWTArgLdyu6Av+WQKCK+JK4UVXJyXP0vAMdcZawi3TYccz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(82950400001)(71200400001)(86362001)(10290500003)(478600001)(53546011)(33656002)(7696005)(8990500004)(6506007)(38070700005)(55016003)(38100700002)(82960400001)(122000001)(186003)(7416002)(76116006)(8936002)(2906002)(4326008)(26005)(52536014)(66556008)(316002)(41300700001)(5660300002)(54906003)(66476007)(9686003)(8676002)(66446008)(64756008)(6916009)(4744005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sVwE3R+//jq8mjpMrIxkJ/W6tzoGWb2xBZoCODE6ZfTGF03vKcrAn062/dO0?=
 =?us-ascii?Q?OCUdRjDckO87fBnDTXwyLYtZlCEWcsabs0tKET1I++931NxTe2/srWJyl3t7?=
 =?us-ascii?Q?80PU2ebRmC5yfHZoWrsDhSjFDDCWSW/kwzsClI6tCFrpsgpL2oXhZYi/j5oj?=
 =?us-ascii?Q?yHbXDkBPItrYZrbuhRtQealcTTZVHGb0b6IWtBWY5bH0/ksmapW0F5r2Ok1v?=
 =?us-ascii?Q?ltUyq1HPXxroupjVXKvQ9bb6uIiweUyqhXIcyYdgQHtci9Ekhph1+CVoxkw8?=
 =?us-ascii?Q?M8nw7XIhpsgbtcQVhvvLxAb0bVUylUnpZXFQd7MRSjPafcQ0DsJenYGy/PhL?=
 =?us-ascii?Q?xzQRb74kYkkQr1M+HcvVm3LjsiUxjmOFw2Pi9chO6GPAR6j3Pxl9JCwqobLC?=
 =?us-ascii?Q?8vOs30ov/saz1gCQsbwhbxWxOCtb74sMOUZlWO9ZhHl+ZVw1LJY+6JzDkpMK?=
 =?us-ascii?Q?IF3WHJfimx+LtcOAKJ3ctJBOcR/ywmAQC38haDJ1PRQscN5gxOPYPWBI9gzM?=
 =?us-ascii?Q?OjPjUGrWU2DX8ZISECnf7+XiPhNXWUTvFm2LnQxvSNU5Amjt/5ZI2k/MjO7i?=
 =?us-ascii?Q?hlB74i+s5alaHxjm6mnNRYeLiyP/1Fl5Hpbfcj+NwnuCeXqNr0x5jn0F8MdZ?=
 =?us-ascii?Q?Mlbv3Dq4nlpQ8HOyEQLffOM7OJAyGtCRNweTH3B63d6V3gAcWQoP9m5pix3T?=
 =?us-ascii?Q?HjSoVZUmfZrqzMPX1r4CG8rjqiq+5crWRgTnuyia8tVf+Ojjj5XD9UBOEHmd?=
 =?us-ascii?Q?BoGMwBGuQa6xVFJzWbZsUHmpg3phIYN/iQNgfhLJDGQAG0PEryB0kIvd/DHB?=
 =?us-ascii?Q?vyqpb877u2mI6SMziw2zGC4dY2bZYTZeLiNnv8IydtCYGJuqOjCsK6D6B6MH?=
 =?us-ascii?Q?9zdRDVhLeYIxMRSOu2SqxMZ6WhEYKFOO1/xVKr+WJOj/DarCaLtNaiTD38hP?=
 =?us-ascii?Q?1DypUKt+iP8tJwmGWDlPDhHLhq6oUGQe24IMBke2Ml2AY4QKu4GUyBLzduVV?=
 =?us-ascii?Q?bqXN2g9y5R1CLEfdX/0w9d9oN7aFHmH5Fs5/FMQIzqxk83lqZyeKjozm75RP?=
 =?us-ascii?Q?c7J4vVrCiciHISWpFW7oMzP3vPX7a80j2MiaqlCWMFL6P+1IsxZQDPZQgBwm?=
 =?us-ascii?Q?KEuY0Me4bH86/oDTWOSBZ3gl/Zu5Jp+NMJKUJ9/OkDbcJkbccfoKJXeyoezz?=
 =?us-ascii?Q?HOdjtDAwioAvh2lh6u1g/sWD/BXYxlrOptZtdUOJINRxKUGLK1b5DLWTNcHV?=
 =?us-ascii?Q?GQkjebCWUV22m2xFs6KJ25cRMQ/BSkHM1TUShEltrKPcEDL0qAOVOK4yxiiY?=
 =?us-ascii?Q?VHZn8b0BKpKGKNonRbK7bAsnRmn2kefdhmYcyrdyAKGHdLOqsAJCP6zN5ePy?=
 =?us-ascii?Q?Zg8+pQK+SXODNkfs4prfE7zKlaK3Ko99Au9QZsvAlqf7HF0soywro+dd7Uzl?=
 =?us-ascii?Q?30YUZsQO7drDbg++6qma6qAlFvbv+GXAO1nek4mT1vqkpKTuo+/wR7azXMru?=
 =?us-ascii?Q?JUPWkrO8+USJynZnfdLWgCy8BCfjMckl4bmp6n5wRDtM5A385hmdzAUimSW2?=
 =?us-ascii?Q?97Ot+500WxxL+iqMWe+YviPOhVz3wyuCJcXfUwbk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e6eb23-9bff-4b12-5ae6-08dad95600d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 19:54:22.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Txygt9exsO9Mo6OfiJAaQ56CvGWpLmLc+oxWd2wbItMwOozELM9DnL7AV7FiA71wD8eR/sZST3ocW3RjsBP6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3457
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
> Sent: Thursday, December 8, 2022 11:48 AM
> To: Dexuan Cui <decui@microsoft.com>
> > [...]
> > +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
> >  {
> > -	phys_addr_t start =3D __pa(vaddr);
> > -	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> > +	int max_retry_cnt =3D 1000, retry_cnt =3D 0;
>=20
> Hm. max_retry_cnt looks too high to me. I expected to see 3 or something.
>=20
> Any justification for it to be *that* high?

No. I just used an enough big number :-)
I'll change it to 3 in the next version.
