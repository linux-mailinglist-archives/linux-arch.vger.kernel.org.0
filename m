Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CF061750F
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 04:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKCDbm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 23:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiKCDbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 23:31:05 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020016.outbound.protection.outlook.com [52.101.51.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138D91580B;
        Wed,  2 Nov 2022 20:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxtBt7kpDNnGIGZZQeYtowhUP6kU3CD0buCVD0kHd1jNJ125gdPsP1b6BmcFeH+AYNkt3QvBD48AO3tzrE+E1GY7kvBgSuPvQGezjOAOXm5kettt+sSaLUcv3SBhtvkApPcSDbIU2EqK2getfIVgnbUoiHA+o7EL9SAFeLvYs3yFxIk4SSHsEZw6ahf/oP8LV9vl8oRRFtoJYZGpXZy7yprKymyeZFJVPnzCy1ZUiORJqyHKNLMzL68LmgOnf2/AzlCaJ24TJo7/Iq9pb42xXGy8fGRj432er8wUrb5jRGTX5inTAeBOiyvfQs7EBmaGgTIi+nN3mXIkM+9K+MERWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX7iBxIgKmr+jhHnln2MXhvLFGRBdgpBO9mm/Z2YR1E=;
 b=CCV2qsJ2SuRTyyLl2z8FGYc/Kl2SlnZP5aYMcc3QY1Yfj5Rs3wUyRRAknlEQ5EJdGak99PjCfNhjfGAe/WOOlYEvjCbrh+jU+kUjI4IL8ijmYw00yO8+Sl7h/WVx69HVBL6HiXEJ/mSRie/r+E3PR3rMKfFYlidAdtHOC4jh1hxR1RrA0gqK0yC/In9Omceb2Zp+fa07Il/kE4C+k8CS3fbNT38DAhSMFDGZxYi9JZG7dyptVJzl3aI9pg4OD8UZmpdgdoSwPE+zYBbMKDjMuAgSr+4bTPCmaGnQOZjDa3iQJyCaH4i0nEnDI5BYFofP7fk/U01npzI4wWXAr1EwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX7iBxIgKmr+jhHnln2MXhvLFGRBdgpBO9mm/Z2YR1E=;
 b=cshIfA3WHFbg7mGzeS5WUlLMJqog4atu6KPPNgWCB+/Mh9vK/MgWKd63R+QJlpfMAm/lrnLAL37C/UCiS2c+QIjgf3OSnJz1bWab619wKGBJWBge+w9iRz16RHhUx3ISP/jgB393CFBPJW5bdWDeDXzxQmmHmyvxgGYLHlRRkE0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Thu, 3 Nov
 2022 03:30:35 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Thu, 3 Nov 2022
 03:30:35 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] hv: Enable vmbus driver for nested root partition
Thread-Topic: [PATCH v2 4/5] hv: Enable vmbus driver for nested root partition
Thread-Index: AQHY7toZyRPGEYHjsUqg5KNp5QZ2IK4shkZA
Date:   Thu, 3 Nov 2022 03:30:35 +0000
Message-ID: <BYAPR21MB16880A610264D54C141B7D79D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
In-Reply-To: <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a85e80db-183a-42a8-97f6-22196f0e2f66;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T03:11:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3660:EE_
x-ms-office365-filtering-correlation-id: 28d29b06-a7c3-4b31-76f9-08dabd4bc55e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m39u6z72G5BIIR1wum/GdnAtLWmk8NAH0k1tj/V7thUAELBfEyaEPE7xExfwRSySj+2+D2zi4t9y5+whI0yJiXgGV7TS0dhadQ2+CwnFK0oT5cC0Qde2DV9rN4Uqsv3zG/NfMmRT8jSHij63KmFFER60iuT9KeytmqCRihcYtVzvqaNScxTauRHS/MEhVlJ7v80I/qVg0mWlzdAh3jAs+lkQmP73htLCY3Jog0fkkTpVWnPgBGX95EL1NwrTqv4Ro10NCf/upq2xY4rGLlePXlC3ibuogZu9b8/awi+xzo+D/GbuqB0hw4hY/y0bV+n7xd/yAvA3IBk2KFlIc4E5x2x4Puntq121fMzLDOinSq2rz80d/54+QOTrrRMlQ9ELZiYZ5wyXJpRPFn1+BaH5BsedYWSj2dJgbfcgoScEK/ytEay/H9MJ0rzV//ZwHskHztLpfoTcoXOUyXNjmfWxV457YOpxAukdTpMr041S2DX8JGJxBuPkN4u3tlbpp6Ue76mUzp37Hsb8EUFWSSmg3zKfbGuvHL69HJJkQvu7bUwnYJBonycpRUzqWqhDepYwI6gbLGWbhPOc/RjAUG86pMlvoAILyy9xANGp9pV84IypMVBgyXSuX9UccIPuLU+56DSyUzL5p6vTOurTm1ji9rTqFNVJJ3Au7zmakBt3ZFnwlQR6vTQ9Jx0ADtal3RfYf7KXEKCr71lTnN7lhWEK7ae32n8SpW5FzaHFCD8BQqM0WJc0ddcqtiD3l0+AgIbT4L0QGxb/D9iHmTGye5RREIC9gWh/biNmggbgZZaRlG3hDB1ZTITFEvtWJdnAHEPf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(8936002)(52536014)(41300700001)(54906003)(110136005)(66556008)(66446008)(6636002)(64756008)(316002)(66476007)(5660300002)(76116006)(66946007)(4326008)(7416002)(10290500003)(8676002)(2906002)(38070700005)(8990500004)(478600001)(71200400001)(6506007)(122000001)(9686003)(7696005)(26005)(38100700002)(83380400001)(82960400001)(33656002)(86362001)(82950400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v/tABjkdxqnSMgcwOZSeSYCoLewJ8OpLXItnn01lgpNlNCjx2N4YRPwi8H+a?=
 =?us-ascii?Q?rGXHlFntVzgoiiaET/gbtKL2OMzjRgJEAiC3208FkRRwTy4BJFKXKnmSbZAz?=
 =?us-ascii?Q?/3N+3u421RtCZWwFo5zg9fBmGdvZUQ9OTqa4sv0Wm4y+TOlFNAqxMEc3X+W+?=
 =?us-ascii?Q?LJceBNHGVSIWow42fjs1am5BhoDX2LCCiOwQxdwWY9cT/UKEvvDK0r8iTEyk?=
 =?us-ascii?Q?HNYuXPJlUwkbRtoT3zcY2Z6uBFwlwZBcpKnyIGqUGG3J4u1ijJ90FTB0qf3U?=
 =?us-ascii?Q?vTiHgEE2CJagA6cPlVkca61UJCX+fwrLtOYz7wcDFytBYVHgJ/H3aWBZET2n?=
 =?us-ascii?Q?7i7utv17ApsnboiPVlD2gN9TIPsiCgQnyEjrlSJdKptbqNOT1jUZcUO5EAvA?=
 =?us-ascii?Q?ZJ0hB6Si/PEjlKUzrQ0gGvpEACW4KrHEZXxnR7Gqt5jF8UHsb1ep5BbwDQ4I?=
 =?us-ascii?Q?j8XTL5hi6eoEYADvZilG5dhnw7DWQTIGrjQXboiWNhUViumTpmKMhbhmQSni?=
 =?us-ascii?Q?nQGqvS7nbFngx3KHglVbUYn0NZdpICVyitEYENxe8N15EUuhEYGpld/UYrn4?=
 =?us-ascii?Q?PGlzeNTNs+T+sCCOSKsfzNTEFxLqL7ShHE8o2IlYlc9/q1dYL4U2AXQSZur4?=
 =?us-ascii?Q?BCaZX9M3MG5v4GmZBRM8UdWvtuK5q1CxKYtpowuIlh6BdX2v8w7J9GHTIRc2?=
 =?us-ascii?Q?gM1YhKWUUSkHEVk0/8JLI+5NixMpU0fivJTFGPhK9i31z5W0DsjUHHKls/Gz?=
 =?us-ascii?Q?lWFy2p5WLbzxoggkOdkxws6VZq4v+yL+Z/+J4vjNNUNvoIerGMqhCnSUpfbX?=
 =?us-ascii?Q?7p2ZZMUzkupdVYNQHUCi9ii1+pT5jqVws6+DDS92kVBTARGc8sUItKB49/SK?=
 =?us-ascii?Q?XVl/AGpIOQU6RFrd5o49MXPI50XTzQLyuKzlwT470jRqPHQxb+yJZrFzNGkm?=
 =?us-ascii?Q?RqWNk07M2Z8+JqlkFAm47NyaZZiswJX/qmEfe7ZN2zedWNwGJFR0Qs8xLUpV?=
 =?us-ascii?Q?Kp5hDuJ3QVvRa8n0ueR4nbjWUhxn97t1/Cw0FkpmdFmOZo+1OCQhZDU8WFIF?=
 =?us-ascii?Q?nezlsSDcjM4YCuwCcVpE29sLC2Wzjhig8/6KZUSadivT2iyECPjBMNo91W56?=
 =?us-ascii?Q?ibnGGhYucuGQGoiYCS54daWGhWLw3dcEguiyV6FAh8KuDG2lvKuywHTP+aIO?=
 =?us-ascii?Q?nWm0Q+lzMZeIFdEqXoIAqpKiBadPN6w3T40cebY6hFOFXZgXTH05ybmqEMke?=
 =?us-ascii?Q?JmPOZViYMwO+XvNzlz9v8xWcyI79p0WbLz3fzyQvDiGp9kohB7bBxwlTqjkp?=
 =?us-ascii?Q?2B5qQEkZj06BBE7Pr48nTNl6QlBOgBU1+FYTSENr0qfj3+a1jfJL8IWcitt5?=
 =?us-ascii?Q?EZsYGsI4xoiZbD3cTg4B518rGd4Wl6QDKl0QEuvMi7+0wr6LivOspUda+wY7?=
 =?us-ascii?Q?jGWNW7CduHgZjqAXQGK6wj+DXWBCDy9+6+4X03QXs3X2uvW/IlJKka+jwTow?=
 =?us-ascii?Q?S+3T//U2td/dc06UgpC5TnKTVjrxoyjstwMc7jNbl45RQrZ7ewnmFMuUFwrp?=
 =?us-ascii?Q?Lkjki9AInmiuaT285nVnRKJvDf0imS/cIsrGB8lPArQvwsq/qRyG9nwdzGFv?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d29b06-a7c3-4b31-76f9-08dabd4bc55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 03:30:35.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MbJkZ1eZZA3dj+vfXAQWhuwMgTUSHTU0ZwwPPF/0sdxzGb2rncEjEMiXKq2JwmEUoNwJjulULg0rqRO0pSNwTzFTM8c8rai/ZTXMZa2QTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 2, 2022 9:36 AM
>=20
> Currently VMBus driver is not initialized for root partition but we need
> to enable the VMBus driver for nested root partition. This is required
> to expose VMBus devices to the L2 guest in the nested setup.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8b2e413bf19c..2f0cf75e811b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2723,7 +2723,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>=20
> -	if (hv_root_partition)
> +	if (hv_root_partition && !hv_nested)

Note that this code must compile and run when Linux is built
to run as a guest on Hyper-V for ARM64.  There's currently
no definition for hv_nested on the ARM64 side, so the compile
will fail.  But per my comments in Patch 1 in this series, using the
same technique as for hv_root_partition in hv_common.c should
solve the ARM64 problem as well.

>  		return 0;
>=20
>  	/*
> --
> 2.25.1

