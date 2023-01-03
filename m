Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB63565C706
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjACTMT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbjACTMN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:12:13 -0500
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11022023.outbound.protection.outlook.com [52.101.48.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208112AC0;
        Tue,  3 Jan 2023 11:12:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXP/VE5CeVfrKZGs2CTn9m2/6ECpJ2seVhAQm+sWE79BEJfTQobunAyKkNBfpaaIcPv0I5aDllvIknxLSXCXYKW+k5vQNv18q3rpP4ofBIETD63tHuQy5nOewmMSgL9sAeXAUO7JA/kSqkRp79EJYAI+97JiDYodoKE0yvBKGyss+NeqkFfn0yWdnOlXKNOLEwiaGrdSsU4+a1vKbmg5OJuVOA5VH4MNzx66H54WV3Pb1H9k5HQFvUZ15ExGqhDk1oJeKQ+jU6JCtBmzcU8YT5cdBQ2+xIgB3303PSRfbST3fkTr3EDBD7ySD2W1JrcEwohnJJ/nH/5mUEemV+nY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ik56466ObFsmMppkQh7j8E6bk7aa8DGlqLOkneGvR0=;
 b=IS+5cyiydqyyPpkDdQ/xcpX2US7U5UUVkxWNBXaRqhBr1mu5icbh6SUgaKstMbDoMVDpYJvulq7DO1vu0myXNTQKBAXy2pDKBhJ/BJbAuhvir4cUc1EvFpYCv93s5hl6kjTVKp9IFuTMXn0BfW3B8R4rtRN9Bq+fWqG0wjmOV9xV1mmh8xnxg51uTzS/pcBWdEHwdAqnT9AEZ1TjIeYwoeiRoYeRBMCy1KEwaaPYYHW7tD5KBfgIgxVmWSIwPijd5Dhp8gCrrPONIo9QX2b40k6IBEm3fe+BlKaM6dgfjEOd+wjBu8ELFzXdmJliVQDsmjZ0oiK89vr8+sJ1RFZ+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ik56466ObFsmMppkQh7j8E6bk7aa8DGlqLOkneGvR0=;
 b=GSrHMzUfg1rR/MZwWJOhpRX2TaVReiPvH49nphMvYvjj0kL2Zo+SaUR9QhYn31TMja5PZHXUOkLfUs7vyzeNWWL5AcwmFfRR2kxIgIWDVauA3iJipeVdeyR4iIu5vxYTGaSBgRrY4OlIADfQLHQ0Btlg2AFpUYJaLMfaUF/blmk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3749.namprd21.prod.outlook.com (2603:10b6:208:3d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.1; Tue, 3 Jan
 2023 19:12:08 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Tue, 3 Jan 2023
 19:12:07 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v10 3/5] x86/hyperv: Add an interface to do nested
 hypercalls
Thread-Topic: [PATCH v10 3/5] x86/hyperv: Add an interface to do nested
 hypercalls
Thread-Index: AQHZHnmpvVLD+m3uzEu9T0k4Q2fsXa6Ktk+AgAJbIQA=
Date:   Tue, 3 Jan 2023 19:12:07 +0000
Message-ID: <BYAPR21MB168879D1525FFE17DB2B23BBD7F49@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <24f9d46d5259a688113e6e5e69e21002647f4949.1672639707.git.jinankjain@linux.microsoft.com>
In-Reply-To: <24f9d46d5259a688113e6e5e69e21002647f4949.1672639707.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4351397d-de5b-4099-9de0-a75fe10f1885;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-03T19:11:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3749:EE_
x-ms-office365-filtering-correlation-id: bd39b065-6087-4496-8ca6-08daedbe687a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVDr5r+3nLOjODr/ZVe2teL6/fvknc52nk670Q1dyb9yzL/zIpI7Em26Zo73zPjTzV6fnY8gzm1cMbvNfVY1HIeFc+gvcHZfcb7F1hc6NzTllbHwSDkdHoqPukGgVq0+F7KXKha6bqu91zgHtHdrm9p11fQ4X/YkO7lPlY/zNHgJlHgfeyLofT7t8eHdI4LmW++g6cpvqBse4CdHrfNDIUq8ycbbc1ppsC9ZqxdqfqBm8nMhV9EnqSTyw0je1fg/C+yQ8Ljp4joBKxijDQpP2kj9yDAk1l1t4m/EzVYvg1lmxaDjPF2huN9q1kCtYy1h7EsPUkD3rf9OnBXg+zY4dHDdG8LAFXfxym2kP1XoGoUQj7zW97HdUT9WO1/cUwXD6ZEZqEVDo3DlOXB5XesYRc+TPfjbiX76VYWHMfDIwxUQTr0zsokUPyqrpLAqbSWC03xZ0cN5bQMARr6qNr44ui87A0yzvd1/vWgaTdZuUR+UwxiwJ+Ja4FOWwePpQ/Zbs6Ti+slEHH2McG2xx/JY0MhB5WKHGrsf7IHxq9Lz20y1jpL0/tqES3LLGr+EsnHm54CzyM0NmZKSOU57AwUW/7LsoIVn5cyBdWPm3eEMUrw7MrIHhtReEGaU1pHZFPuOMxW6j5F+RjFenZ+HXJRSKRsErn/qCsCmf5IdaDUekb62Gchs5LB05JcZ1Xbz6wzR/2PuMdq/gVkAA5DNLN/srubJDsKIfSuKMGmbVCYLGmIeWpNbRlHTezuWkkYcC+9QcNtSintp6FxkrU4dH1jZXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(7416002)(52536014)(8676002)(66476007)(4326008)(66446008)(76116006)(66556008)(64756008)(5660300002)(41300700001)(2906002)(6636002)(54906003)(316002)(10290500003)(71200400001)(110136005)(478600001)(8990500004)(6506007)(107886003)(186003)(33656002)(26005)(9686003)(7696005)(66946007)(83380400001)(82960400001)(82950400001)(55016003)(86362001)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u4Wxc7V/bIi4G0SbPC6hmJ39z4Nk0gpoLaPbdGazJVcCZJOKrVAvgnigXNOj?=
 =?us-ascii?Q?7MTZrbh38m/zdeuX6T49/k7PhRuooBFKNPhwjS3GJ8GQx5jOTKA/Cf9xMH5A?=
 =?us-ascii?Q?n06g1sl4KXMd3ly2TViqTemuKKWDwOuK/vQtyeMzO2Rjy+OySivzqvrurj/E?=
 =?us-ascii?Q?Y3eEPQCiaphaL/2BLam9UUwfRjvUwZhOVnlDedmdcIeA+GMFPd23D5H3/5p2?=
 =?us-ascii?Q?xcidLpKuaTlgVStzC58zP8a+XyokO6q+jKOO4JExCT2vh/DJsvhXjBw//GGd?=
 =?us-ascii?Q?o/gv73RjwWyq87Criuf3ij7zag6LqvIGkdzXl5WR+cqfjjVCMj9tSqZ2rjSh?=
 =?us-ascii?Q?iaA5XGNL5PG9yadhX+lUaAw94MB/MeDSKqn9vi/6/4sMGR5UUYURg7hCLGxR?=
 =?us-ascii?Q?FNizbHmkuChs6J2ZtIfIcOy6zy5LPIkIfL1vXBIC4we2jivZNBtF1IVvE9oX?=
 =?us-ascii?Q?XYl4Civ649ns3J4FDSSZDLxDs5rGFj0QgoiAt1tIRPoliU8QK+F+cG87DLZA?=
 =?us-ascii?Q?fLkQvy6bsgc+bpWiW5Rcc4WVzH9Xyuz+XqhOIfLIDVmN1JWY57U3bjCurXEd?=
 =?us-ascii?Q?DQ5DAHjgksabQvYh+KVSQd3PKClBYo2eS6ErdT0YeZSPWT5Ws0M2pnVqjLH6?=
 =?us-ascii?Q?l9p+AtuvIwzjDWoVSPWoJrQfNXvZv62f/mUG9Ipt5+Iz6rJEdLDHEAoIIFad?=
 =?us-ascii?Q?Rn/PjvgohKVLBsACh8K1kYmEOJmAwhDroo9jrPXtpnD3sic0QzCnQfrWPThM?=
 =?us-ascii?Q?oOmxUAOJzwVYi3EyMkhk9eDSLAKMXfGdyX5rbh1GggNjs8/DKr3CrpyUbM8G?=
 =?us-ascii?Q?CwN4eYF5plLFuU4kXhI86jIuaNUlqzCFkejv67PQfSNb4fp2CANGifHJhhDj?=
 =?us-ascii?Q?IrowMKfwQ5pET4wkI7ZMFofKGE2n0Wx6arYEsKdzWn7syo52cY9XN0yQn4LR?=
 =?us-ascii?Q?j+cuRirNm3oyRDKOLedmpRZTPwDYKNuQ/I+yrQUKm21SNrmfNRYSjcGyCed+?=
 =?us-ascii?Q?dHdc/VrOB9XYzMeAgNQfzoZP4+RHl89Enazmjvd0dMOuYdSZSt5GUeciDRIR?=
 =?us-ascii?Q?GLpouZj5ZBYytSdZY/lFWJzBjkVlIeVz/rXzfdDiAmJUr0rnM5zqMbPCIoLc?=
 =?us-ascii?Q?h2Bl8sEns+rtna7ZNTtNkVr3GMgLajrsp7UZuASiRvQmkvwjwVMiv4lF1bFz?=
 =?us-ascii?Q?Cvz4DhGOsRsDLZU+ph/ST1G5E/+JvZfVoU5VuMYaQpe0aDjaVDjBzPV3+7fi?=
 =?us-ascii?Q?UTA2r3o/hpSuKOZeXaeEOA+4cYfeaizLX5R0K0GslRIBNsCXexWAIL2MQTpx?=
 =?us-ascii?Q?HHRT4Qg6E2elzEO8g2sgmobCEitUmZTpHtiioJsfzLqqA9QOiwaEGIM943Dg?=
 =?us-ascii?Q?IaVtZoMZFTQPv4MFVrbZVtGUHPZSOOMjm1e9WgJF3noKtI1EmlPDnZN4ZeHB?=
 =?us-ascii?Q?543ryitFS9JXZJPt/+eQ3SCVmFlO1uQen+8me3aYqrvJ5dz+Ty6FbKxr4uyE?=
 =?us-ascii?Q?eD7J9HOZZzM47VHJn6zgLkYQTpClEYAnmpu+25h9wEQhl3H/+ijsXtw1NUuv?=
 =?us-ascii?Q?gXUd3DJJBztgnBaO1ySJD39ocynGW/FRk3T16jdz0elhFiEzoao+HmsqLiU7?=
 =?us-ascii?Q?hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd39b065-6087-4496-8ca6-08daedbe687a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:12:07.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjOXwGxG2GtUxI3ZKAuPjl009eUGNU+VzGQ3gq/S4KMgKfsFagnMb+B6y9/F0O/L4zemVoEbkGAFMUqEAhkdxjq9hFFncaMUJ0S3o2gMTSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Sunday, January 1,=
 2023 11:13 PM
>=20
> According to TLFS, in order to communicate to L0 hypervisor there needs
> to be an additional bit set in the control register. This communication
> is required to perform privileged instructions which can only be
> performed by L0 hypervisor. An example of that could be setting up the
> VMBus infrastructure.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
>  arch/x86/include/asm/mshyperv.h    | 42 +++++++++++++++++++++++++++---
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  3 files changed, 41 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index b5019becb618..7758c495541d 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -380,7 +380,8 @@ struct hv_nested_enlightenments_control {
>  		__u32 reserved:31;
>  	} features;
>  	struct {
> -		__u32 reserved;
> +		__u32 inter_partition_comm:1;
> +		__u32 reserved:31;
>  	} hypercallControls;
>  } __packed;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index c38e4c66a3ac..9e5535044ed0 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -74,10 +74,16 @@ static inline u64 hv_do_hypercall(u64 control, void *=
input, void
> *output)
>  	return hv_status;
>  }
>=20
> +/* Hypercall to the L0 hypervisor */
> +static inline u64 hv_do_nested_hypercall(u64 control, void *input, void =
*output)
> +{
> +	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
> +}
> +
>  /* Fast hypercall with 8 bytes of input and no output */
> -static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -105,10 +111,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u=
64
> input1)
>  		return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall8(control, input1);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> +
> +	return _hv_do_fast_hypercall8(control, input1);
> +}
> +
>  /* Fast hypercall with 16 bytes of input */
> -static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 i=
nput2)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -139,6 +159,20 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64
> input1, u64 input2)
>  	return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall16(control, input1, input2);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u6=
4 input2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> +
> +	return _hv_do_fast_hypercall16(control, input1, input2);
> +}
> +
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index b17c6eeb9afa..e61ee461c4fc 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -194,6 +194,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_VARHEAD_OFFSET	17
>  #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
>  #define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
> +#define HV_HYPERCALL_NESTED		BIT_ULL(31)
>  #define HV_HYPERCALL_REP_COMP_OFFSET	32
>  #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
>  #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

