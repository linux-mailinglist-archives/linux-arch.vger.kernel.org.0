Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111CB61750C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKCDbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 23:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiKCDbC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 23:31:02 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020024.outbound.protection.outlook.com [52.101.51.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18770167F6;
        Wed,  2 Nov 2022 20:30:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egSoA9Mx2H+FiBAbNN8BTtyxZ5lpSBVKN1e3+6Y3kKE9tgM0N7PONpJ6Kse5iNC6MLNTABDCo8giw211wr1Q5dVau8JemkcpgpfPDGVjKeiF9Fb2TOvVdpim+vhWs1re/QsOWTyvHeEUmfRMGPi8q+Yvyfipti9wSWnrUczId/OYNGxCNhk0Mh+2eOIaxwkvI2yPxDkHHze5jCaARVXT3Gmb0yAdYcHgdd3tHjyTwBJnvwzaUwOUkRzixAV4ykkQ6xTTsH39998Za9FfVdXlygNVWRHtpz2jckLO9yPTMTmDqHSS2tzOi8ciDRC/KzeyuSePLraavURX1wttp0RFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj7yv2yQjkg2ehG3W651PcjzM8NXwHNH0Psr2zDq6Rg=;
 b=QwaFboKSqScWwOlpOC/GKUykFZSlZwImF3HCdWiEJCSDd9dydTS1LkcexrGW+XWtrwn9SfBEnyr+nsY4ym6AfVDp8tfigiUt24punWvUKgv+pzSLvHjElljAi7SjFEG6O1bl+DR5P9atAka4EhGiUsxWxxWOGL9nbJJBW03klHrrc1uQPfBt8hCPiyvRiJw5i6o9UI2g1U+sE3eksNwvVgkoODXzjuct4cNoWBxAjMzpnimg0wAyAsuKfNw+BIEtt+ekcrh/x0Kf3/daM20++tP5l3dVz8E6K1tZVMpvcFprbBHgvWbT4ZA281lUJWGtk5SBy/vBiTqgNCOB1alg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj7yv2yQjkg2ehG3W651PcjzM8NXwHNH0Psr2zDq6Rg=;
 b=Ru1NMxk9O5/aEo+ZzFJbaiIbVfakYgUVTGB9QW/nr7yvAbgYuqXQ2UvLn4RCBuHrFQvTfu55y1mSdkHaaNXtEwb/+BUOdWx8ty6twWq+tPO8MMGmZf+Z1YJCZJODC7MVz2Q5FOXB6pi35AtBGWtg0QiLJLkopeALSDmdFDAIUt8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Thu, 3 Nov
 2022 03:30:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Thu, 3 Nov 2022
 03:30:13 +0000
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
Subject: RE: [PATCH v2 3/5] hv: Add an interface to do nested hypercalls
Thread-Topic: [PATCH v2 3/5] hv: Add an interface to do nested hypercalls
Thread-Index: AQHY7toFMRGwfG8Yo0mw2/kFpX79Wq4sg8fQ
Date:   Thu, 3 Nov 2022 03:30:12 +0000
Message-ID: <BYAPR21MB1688400B8CA7F1AAA4575E5DD7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <0a960bee61e46c4e368f351d3cf40d60ff28ca8b.1667406350.git.jinankjain@linux.microsoft.com>
In-Reply-To: <0a960bee61e46c4e368f351d3cf40d60ff28ca8b.1667406350.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a6e2cf2c-671d-4cac-bdf7-47f2f7c88bbc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T03:02:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3660:EE_
x-ms-office365-filtering-correlation-id: 5fa92167-efc7-4a35-bbfd-08dabd4bb7c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H7FrdnCHTDnSVcKae6LlQMCiznw4c7QZ93AY4FeAm2xa29LqKBPJREnvWpXeUL929ryXZ+iAfjay4UFfeiauYknsvbZsZexMWGuiauqkj27LDBQx656+7ZIFwySLBw8z7QkEpY7aa/zcCsP5eXljDrltVflfKfkcslxEmimYNUAXfNYj0bPS8ONTHSR4M5TewvXQxH9mwIVZDd+f4xJIn8kQeVHFDWsA3Zrqe9X4yb+rTkn7zsBAM20rZCmMAgxcaZlOTKcvJrnPMB06k28F7+fAH69Cc2tqGr3+hWboLb1g8MKzclzVq8vI7X3GU6TEQVDqX/yVrqc/kXt+tSWU12soDaKXfhxWF5xu8XGxFUsVpgLZ7emD0eqSzkyrBTFtlpjajtgd5IQsPcQp9oEiJfyrjYv2ySCn3KhH1yhGmXrK7Tic2MSD0dPfKRUv4bD2vNGoCHuiW7zH3eTTTutkteIXJ8KmnJnaGCjWm1eMi7oAd635efw+EmXlap5FFlbLvkDaaJu2NO8IUX/k5NrBairxBu42sN+zPgJ5qFEGWR6oFzIstig41Bi1186ZrVNPekZj20jZ0Raj3EJsG4/cjkuTpbIYeoEqLjpKiu3+p+3jpJkgfW2ZRj9hNpC0BsASQrk1oKxNcbTpi9D+wGtNj56PPYkJGosaeXKnY44ZpXRKB+vCKxDHCmV8C7is/DBi6nP02paW9635QjlkxELeuUPUKOj2cHQcUXBEKttPonlq5Vte7gO6E2TN01hd1U+i2nf+kmUf84sOs4eqkFiTgRotjCqgzR33XzI4oD3rXm/Ol6+CCzAWPXoz0Y2w3G5t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(8936002)(52536014)(41300700001)(54906003)(110136005)(66556008)(66446008)(6636002)(64756008)(316002)(66476007)(5660300002)(76116006)(66946007)(4326008)(7416002)(10290500003)(8676002)(2906002)(38070700005)(8990500004)(478600001)(71200400001)(6506007)(122000001)(9686003)(7696005)(26005)(38100700002)(83380400001)(82960400001)(33656002)(86362001)(82950400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZPjWBXse5q52dIGkw0/fKSGrNYcF8YFTDmFtNguXiQJ2FLcUtWJL5CsFAed?=
 =?us-ascii?Q?UAM/Ye1AC0ms4SdC6OoPQf4fOemEmeQPlsYP1lYPg/d3JlNudjW/zDDgXRTn?=
 =?us-ascii?Q?KpGQ0j9gJbOgHVR+8wtrzs5KqiOOqS0Nz0+FTm/WS470/RSIGIHqYFxRItYJ?=
 =?us-ascii?Q?gnOk4327lXEPzoVl+AFY9IpoQRLmY8Qsdq2obYXPKEdjEHNRD7v2xWHCIs+I?=
 =?us-ascii?Q?7FfuLvfhLcdXvZR6c6UHWmvoqP2YXHblpWDQVwUshFW3NUZpLQ6qOugy7NlS?=
 =?us-ascii?Q?taXZOn9llR5E+7w/21JOVD1vFWVnHaomqR9OIgJj+jT5w42UkkVS8H8P7PqI?=
 =?us-ascii?Q?P1RlWerk/xk4Va3cHTZzWodAW1hgNFanQDFWe/P1TfuBAtsUIpglmbaIAX8d?=
 =?us-ascii?Q?dd1HiNMVyEewVPJXEiSDI9F4eIoD/MjgaB8TRoxyCP61xrvuZTIy7a9dH5rN?=
 =?us-ascii?Q?3L3AChUmIMPwTvaGYD0U7c8m1RTpHrlKccg76TdTdd+ZYuhDV8GNJrssy1tg?=
 =?us-ascii?Q?BQ8HlzfxkOkBvjPL8g3efWzLnciHN3iucUvnKtvP6RYRSuFyFN6KtNj+D4Ox?=
 =?us-ascii?Q?ATwJCWLnW+j0u7TMd9s8g8epjX7CiJe8Upg7XFl7ezqW2Q3OjIBfjGN+OY70?=
 =?us-ascii?Q?Izwb9NztZ2awo+n/VCyx4jcJV5LaJXOBUqFjG8Bw2ruwD062sG6U8ua22PuG?=
 =?us-ascii?Q?JP4N1EGBVCLv8AcpWBdAOBwrSd/k8gifduYpKrklDtzoxGQU6e7db7DCB6DA?=
 =?us-ascii?Q?P+ldob8pygi7cfspamBWirGx+jryA5Faab0czQy1nQchQRfnAEKYfHIVwBuc?=
 =?us-ascii?Q?1S228vsJ5uRBSUu9WMq+h2ngzXCbcG4T5EiLbYaAbfKdcwTMbISpeZKWW3/c?=
 =?us-ascii?Q?cT3mw9wOviS/E6ZKw9t7i6WdxG1fIFkYdIIzY3OtntnS0/3ax9N3bTR+Q9lo?=
 =?us-ascii?Q?vCmxKTN3pWou7rXaJPLGdEZ5VoD+3sF06Wl4VZxYsn3Rp6DwJmhh+Yavdh5F?=
 =?us-ascii?Q?mXt7/kYI1jXiflzj63Js9F0pVRL0ZLZaUpi3VhuiJj0m+kMYYMlbPoU02X1w?=
 =?us-ascii?Q?z9Vcs/BZnzKoXlCeij0CXiydIw02HJHmVpUDmG6WTk+tmalGjUz0Lpa0gOwx?=
 =?us-ascii?Q?qGAFQrKC//HP/SBOQyC88LBd3045+NF5gMkSrO5QU+5kq6Ykq22gBATJoCOE?=
 =?us-ascii?Q?+1QThNGN9/ANHdAnU3jAKlyiIOplf0WUnLzK+5Zwc1v/Eti9xRCspm2jwcsl?=
 =?us-ascii?Q?y75pMgsO8yq9aiZZmk2Y0ayaFSNv32XJXAocn8m4zBDbPYsvIPJYLIlTKQ1/?=
 =?us-ascii?Q?tazc+NxtutJPgonhBmywfMlQRV1QeEGYS9+5/S8/oXdP5HINK8ZLUawXX4dj?=
 =?us-ascii?Q?U3inhtGVYiJOtIi0zRRLNBrA1quhNwfqATVLZv21ikhXcLDAu0uPd4uY1bpG?=
 =?us-ascii?Q?l5WrqWZfVTNWg5nZYBcB1Hy1hkw7v67ypre27f9x7Uk82A6b6SaE0OXM0oZ0?=
 =?us-ascii?Q?3j5p+xR+1VjjcIVZz4V6Vi8lultza9WRFCgOjp94A0gCvLU/NOW6qSNO7qhB?=
 =?us-ascii?Q?yXNmrZob8cw9aLnGFgL3uYCd6zqLbWhnaOAXYxPRJ3GG6YvzSv8FM88vEwAR?=
 =?us-ascii?Q?Kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa92167-efc7-4a35-bbfd-08dabd4bb7c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 03:30:12.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QVNDsfNN5nY00uYghXsxGAJ1l1azEyTZyzWJsBnzBl+blAtYRB6mDfceeOE4Lh8+Ks9XFapEbaVUmNWd+s872gB8yeV72RbRvXBGtu59Ss=
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
> According to TLFS, in order to communicate to L0 hypervisor there needs
> to be an additional bit set in the control register. This communication
> is required to perform priviledged instructions which can only be
> performed by L0 hypervisor. An example of that could be setting up the
> VMBus infrastructure.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
>  arch/x86/include/asm/mshyperv.h    | 42 +++++++++++++++++++++++++++---
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  include/asm-generic/mshyperv.h     |  1 +
>  4 files changed, 42 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 0319091e2019..fd066226f12b 100644
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
> index 415289757428..451d8c3ab63b 100644
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
> +static inline u64 _hv_do_fast_hypercall8(u64 control, u16 code, u64 inpu=
t1)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -105,10 +111,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u=
64 input1)
>  		return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
>  /* Fast hypercall with 16 bytes of input */
> -static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +static inline u64 _hv_do_fast_hypercall16(u64 control, u16 code, u64 inp=
ut1, u64 input2)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -139,6 +159,20 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1, u64 input2)
>  	return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u6=
4 input2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED=
;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}
> +
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index fdce7a4cfc6f..c67836dd8468 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -185,6 +185,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_VARHEAD_OFFSET	17
>  #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
>  #define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
> +#define HV_HYPERCALL_NESTED		BIT(31)

Since it is used with a bunch of other u64 values, the above should
probably be BIT_ULL(31).

>  #define HV_HYPERCALL_REP_COMP_OFFSET	32
>  #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
>  #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bfb9eb9d7215..a2524d96ce2d 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -53,6 +53,7 @@ extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
>=20
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputadd=
r);
> +extern u64 hv_do_nested_hypercall(u64 control, void *inputaddr, void *ou=
tputaddr);

Is this needed?  hv_do_nested_hypercall() is implemented as a static inline
function in the x86-specific version of mshyperv.h, so this seems duplicati=
ve.
But maybe I'm missing something ....

>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
>  extern bool hv_isolation_type_snp(void);
>=20
> --
> 2.25.1

