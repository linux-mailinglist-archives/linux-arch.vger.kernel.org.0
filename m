Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4241674182A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjF1Spf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jun 2023 14:45:35 -0400
Received: from mail-dm6nam10on2127.outbound.protection.outlook.com ([40.107.93.127]:39265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230504AbjF1Spe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2023 14:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0rYPPPsOKfFhQv+2F4pCi1FDEvDQXmsbgTB3+aYdWVOWiXAp3tpbjr4WIk+Y52PIMyNAZb/j4bA6cXZ3+UI8+5M73k99m15w3Mi9358qHfXBI7M1f6Bb+QZh6T1QxLIVuvhQ44hkk6TbkjvSWaxrIlo6sROCbCHpfn+Dja2d0IDnz0HVarh4z+dFcuQPz1Kj0f4pCZs7pxqfnDLoTOLyYVcdcs0ct69OwP386q347ISgsPgk1rO/Ytjp1BZ3Lzu3nCzwF7tHF2fFfDK1m1q0p9I6vbhmT8xlvBnRQOOsm7GOt9qi4ZZWcf79Oxa5XZfz1JD0VKf4AGztK7SUkS3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtlBoZ8N1GHGsOlZ73GasS4YMxoJx1jtrUlJuWDH2Os=;
 b=DaDn7la3YVSzYQDlE8nbhYa/glo6FDfA/cJ6SrMIcjSdjgtA0Djj3aqh1uDOuENzwheHX1bhQmucuPRJhYpPKGKi02on3V1xTsD9/3XTarmaMQkwTIJ650wKfob4s9Xf5Py8Ljv2beDj/Gj/R6dAzWP8P5JNC3Z2RfbRV66Z5aLWRpCalzaVU/Jv76BzzKStSZqS/r47G24w0K12SkVs360VNx318Wan0ZEGpZfEgrIB8eSr8zBOczuUSGcGt1aedync30R68sOYzIAR73ufrWWRHSeGgC1x5QYdRjWNU2/M2XCgFnfuUqkNl7MlAAQcYoGgdFFjIAtotutto1ECng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtlBoZ8N1GHGsOlZ73GasS4YMxoJx1jtrUlJuWDH2Os=;
 b=OaBr7ZXn+miZIJLs5nI9uc19gy8V8F/NYQZu8pM8FAaHrQ2QBA2frSGAwjuxDA9h3yD86y4/k5haCXSiBLHDHgcfNsFigwwBapRb0evOJ+SkrVBfkEcAszJVQ9LIkMnbH/S7d2UezGD8aYRpmNdk0AP2/OGekpRa/C3YJDCpp6w=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BYAPR21MB1317.namprd21.prod.outlook.com (2603:10b6:a03:115::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.3; Wed, 28 Jun
 2023 18:45:29 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::718a:bd58:c08f:f54d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::718a:bd58:c08f:f54d%3]) with mapi id 15.20.6565.003; Wed, 28 Jun 2023
 18:45:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Topic: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx part)
Thread-Index: AQHZqesomMpIPtubN0K/S6c9+nGnj6+gi4Rw
Date:   Wed, 28 Jun 2023 18:45:28 +0000
Message-ID: <SA1PR21MB133517262C2D1DFB881BE8B2BF24A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230621191317.4129-1-decui@microsoft.com>
 <ZJx2cm1HaMEcNIYy@liuwe-devbox-debian-v2>
In-Reply-To: <ZJx2cm1HaMEcNIYy@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b79af80-4a3e-40cf-8e4e-0deac849eee3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-28T18:38:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BYAPR21MB1317:EE_
x-ms-office365-filtering-correlation-id: 35e6be17-ef21-47b9-eed8-08db7807d7fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 44uLu1h4xIHdJuuRvv81+Npxd999+s3HZwYzIzz36B04rDTHKDmx2HERaK80Ydqvp0K78gYlFcscdZ7VkauSE066h5rOH+Ql8SNG3fpgIIMOoARoxdBTYLfS3PSh+F4GXk2h/3cEHz/rs6NhN/r/ON2X34LbDHFtDc7cDLoHjFcxh3TjPq7USWL0ljgJ0JoIyLLTX+Pk1NcrcYrG65F/+lL/9JjuE7rk8vRUBSSID9LZf385mKYepV28fRe4woDnw6YXw/nlGQ2ZzknCj/xH7FHBxVztvxFHmh8T653ayIKrhPQ9UqDaq/VhEMssDMSJBomom9l/1XgCcvHKeYsxj5l+Hv9rzSg973Rgo2nrYEGU1RWp9IH2PGjDTA84up2+xbIBjBNpQbhVNvB6Gz+bPZ4pnsvZIW3HBPlS7919EcZW4qtHQdqAEM9ReryCyIFCG2+EI+IVg1VoYH85XVsNhN+oZIJVqPCLrxbSWZVzNPk+iqnBDR5lyYdnO8zP51LFdAyBwLqqhEKygHvUhj9xvDoPqcIMEICgPMfl8zgn7s6DqgeHZq6ZFyr4ur8RIOrMRhsB1ErNhBKPS8CHhzm2LFLO9KrA0xb5Jm0IgwyhflkqDaZ+aJpoqulsPgSC10PxdqLzNBGxTTXfMC7HkeQt4Tgkf5f1fEvjwBIMopVNdV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(4326008)(33656002)(82950400001)(82960400001)(38100700002)(122000001)(38070700005)(86362001)(55016003)(52536014)(41300700001)(8676002)(26005)(53546011)(478600001)(9686003)(7416002)(5660300002)(8936002)(6506007)(10290500003)(186003)(2906002)(8990500004)(83380400001)(71200400001)(76116006)(66946007)(54906003)(66476007)(66556008)(64756008)(66446008)(316002)(7696005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jI2ikdQa3ZzWGZKFLXFUEB9GI/0LOL00bTkUgb1oy53rdPUXgajuVTv70n06?=
 =?us-ascii?Q?HJ5SWv19bE6LHbY1DfUtumRCZRuKbsi34xPDiZbcNn2QvbY6au8LRyDuPhKE?=
 =?us-ascii?Q?XXpD3etkwlBrsv9ws7QwW3AFqqxDHYiD6HRRc5QhUkYkzKcUblnofuwrVyg0?=
 =?us-ascii?Q?pDTzDNEzUMo8yw2Tbbmi6RF53/DC912dSZOB+xsESYr5PR4lFWigJYcwCv6A?=
 =?us-ascii?Q?ndZUrKoMXXvc/CZMe8I+jsF1z/CiaELS0bsnIwVm2qEbGq+YLvriiypICxSr?=
 =?us-ascii?Q?87wsk5q5hbsbHeEI6iW0bKct+tUKO/epCPQQrneaLMhKuAZYSqU27veM0iQk?=
 =?us-ascii?Q?3r/JKxydVS8bnUB8+Qhs7RBP36jpJMHmrIrcS4847bkV1X4waGRa7GJZahQr?=
 =?us-ascii?Q?uv96jrKWtr0dlZTdpS9VBWBcqUqX2tMBslzubomh/mPO9eKZLIPI2sRLEFL5?=
 =?us-ascii?Q?qLy6gI7+6YKHf6CJLo3JLhbI4qlc5dwkvSi20/81Lw2JrbCtEWrLRlhC9Y75?=
 =?us-ascii?Q?LcQc+/R/J8Ma1XKw19O04dwndNcF87sKIBEOvRNr1c1/h4kIEO3+Y6eXkRF4?=
 =?us-ascii?Q?cjag425gP3iuDxMmF46iVFr0YDG6zB+7BykaNdjaADjbNjwnOu7qRd4OB9WJ?=
 =?us-ascii?Q?A+GLyBHwGFnG6okt0izqHdgTvXvYaUtdsOcPkFjV3lOEBlXC5Fv4pIu29Cq2?=
 =?us-ascii?Q?obHlQnpPCU03VRTkBbJ6rZtFFlZtxbOikn7mYhZp+VS5sA8Jo0Y93Nf41Tne?=
 =?us-ascii?Q?qjqgbTZYDV+9D11doebb7/Sfnv6R0e1EzpwDqy6rWVdi04fKb+oa7+l8Yb57?=
 =?us-ascii?Q?PBK1Yi5nZdbrd6fzymMfwTSixpVoWFPMn8atT6T172+2u9qVAWD7H801JOHP?=
 =?us-ascii?Q?LzwaneihDOpXBkngWI9EQf9PvUJuzlP1sIR6na6x7qDwE032CA2BAd5aEBkg?=
 =?us-ascii?Q?VG3ELohQmTkwEcABVx/QlGPlDPCXNHg64rmHj1l2f5GAjyS6N22+fgQBaW5r?=
 =?us-ascii?Q?5L77anlVWbuYA6gbxIwTy/mEt2iZPNlBRkkhJzFRoLhNi9BGX1A511ckx6zy?=
 =?us-ascii?Q?r+/S+DbkjT58Wj+qpdSuHviBvPBPKjNEfdqXCC0Weth12ofLu9h3bfBPAsyu?=
 =?us-ascii?Q?9v+CMR/eLtw2B9rZ2xsvGWJg0mF/EyNlvT3b0x+5eACPfoDBEP4yDUcoj7q6?=
 =?us-ascii?Q?yDo3kpfqUOjgbns7/M1DBXy7+wc54E3jcgV73n9j5a6EUwesj4jBLLnIsBJ8?=
 =?us-ascii?Q?MnrQZQi1mzllq8PfblxncNBWKwZIco/yXXSrTHGYpSZ87Swk3ZMBei7OY3iH?=
 =?us-ascii?Q?aFOUQdAG4txnTPx7cohamUtTTEkGzhOE0SM99315bRHVOpno5UjfFFqcR9pP?=
 =?us-ascii?Q?4EfM7Ul0I5zJpgKao8Hjj1QtGq9D0261xQusWAc1EO92JABKaqyRf7TcSNVE?=
 =?us-ascii?Q?xM7NIm/6WT49j0D3uWh3hRZ+g/J4zLYBDi1uO+DoTnZMyKTeThAdyIBrLGeV?=
 =?us-ascii?Q?ufJWYeJz5I0DNlyp1vO+/fk/MXDhFORfPlkZgozIuDvgx6FIPRxsU33aIorM?=
 =?us-ascii?Q?iTiHeDtpezm99K/qT8oL8KTVePbYbYJJCOgBSXTJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e6be17-ef21-47b9-eed8-08db7807d7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 18:45:28.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8riAZIKUdrRdtAxKwqLkce3bJ5H4dP1o/LlpLP32gBM0+wFB7n0WgSNsTqeOad6/WPvCwXfy5MD4GpVYFB9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1317
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, June 28, 2023 11:06 AM
> To: Dexuan Cui <decui@microsoft.com>
> Subject: Re: [PATCH v9 0/2] Support TDX guests on Hyper-V (the x86/tdx
> part)
>=20
> On Wed, Jun 21, 2023 at 12:13:15PM -0700, Dexuan Cui wrote:
> > The two patches are based on today's tip.git's master branch.
> >
> > Note: the two patches don't apply to the current x86/tdx branch, which
> > doesn't have commit 75d090fd167a ("x86/tdx: Add unaccepted memory
> support").
> >
> > As Dave suggested, I moved some local variables of tdx_map_gpa() to
> > inside the loop. I added Sathyanarayanan's Reviewed-by.
> >
> > Please review.
> > ...
> > Dexuan Cui (2):
> >   x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
> >   x86/tdx: Support vmalloc() for tdx_enc_status_changed()
> >
> >  arch/x86/coco/tdx/tdx.c           | 87
> ++++++++++++++++++++++++++-----
> >  arch/x86/include/asm/shared/tdx.h |  2 +
> >  2 files changed, 77 insertions(+), 12 deletions(-)
>=20
> Dexuan, do you expect these to go through the Hyper-V tree?
>=20
> Thanks,
> Wei.

I suppose Dave and/or other x86 folks would like the 2 patches to go
through the tip tree if the patches look good.=20

Hi Dave, any comments on the patches?

Thanks,
Dexuan


