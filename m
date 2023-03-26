Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FCD6C95F8
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjCZPGZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjCZPGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 11:06:24 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0B55BB4;
        Sun, 26 Mar 2023 08:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUOL3vZjQ+e3qBvLf1AWiL1oaVMxgE34aEP0SDGOSYQ5BLenTcQ3ljIbTX8sI2wp1dkL8P1HVaS4LOlskAax2wlD5S4y5Z+ttN4eujcQ0cw82j4oNW8Sjv/cO8mw6wRtNQDbrsNAL6k8aJ/5oaOzh60aSddIN+Od/yBvHu67DCKHiap9ifccqkJzl+6XsUJEbk0TKJCGDkdezNsjpcCulq7oqd6NwBh635M1DpcXwKpz4nyS/J62jCXaHNi6BFkUIE44GCGbSs1/uAjlLHohg0F1jvgR9qFgxJq9TTTKlWWpEo63rJDj0yG9Al50CohpJ7DRL5i6RxbtrUM6nBK6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCBNaREg6P2AiCes7s+XX3UGO6khb6Riffgllh1RKQU=;
 b=mhXCK3TCn6pDPiJr/q5DlPy9QAIacJYCWuhbNrOCvFWl84ngccwzqMlQXhAd8jadT9XNiMNYDcL2+sXLPL395q+QDyDpRbrVRxszWPW1Jn5H6PbaAivPcpW04IdeadP76RdE1bnE2YB8xt9eRrGwdJfus8zr9gQ0zinoOa9iStgLoLbZlwilWabofUMtXMhdoShevFtzRO/kZ8qV1xRy78C1s35535JtIHuEWVy0tNOfmie6useQOQtj6Exq1jXQGH9mxdbHNFoDCoo+hpoTUMfg9nAFt1pvr0JCGgBSpwaFEHBbMT6Q5Lle2fA6K3d0iSUQRFksAsxgwbERDASoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCBNaREg6P2AiCes7s+XX3UGO6khb6Riffgllh1RKQU=;
 b=XNKuceeyTYvC/uwWW7yfcNcToyf4Zq5tLhReI9xlnzNsqxrrZzKRFY2qOW1bi48dospvMrLaw/dLOcSuslHjUUSom6D2aU+yfE4ieWbjZ5pYK8+eSSjc9zQjTiV7EivxYsPQ3L2YLanzENiPuYiXJncRr/HzEZjpgzix2HMc3gg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Sun, 26 Mar
 2023 15:06:15 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.014; Sun, 26 Mar 2023
 15:06:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] x86/hyperv: Make hv_get_nmi_reason public
Thread-Topic: [PATCH v3 3/5] x86/hyperv: Make hv_get_nmi_reason public
Thread-Index: AQHZWxND4dSjEgaIXkungXho9wotBK8NMqwA
Date:   Sun, 26 Mar 2023 15:06:15 +0000
Message-ID: <BYAPR21MB168865FF573B593C18E669B5D78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-4-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679306618-31484-4-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9e1c3a2b-71d8-48d5-825b-31be5543e574;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-26T15:05:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1908:EE_
x-ms-office365-filtering-correlation-id: 09814f73-3829-468c-47a5-08db2e0ba52c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qajr3ksEnbk0LHePZtwrHMpcZAjHewva68Jf56D2tDs82ueRxPNVWkzNtiK8zxk16fqhyZL69JAaf3Q3QB0GMu7yvJQCCFEb9pxBYmEWyGfWoF+im4chT108MhoTPlKdt1cq8wBGagh2WSXyDvseIKAQyc29mylgSmpycxRiSpWi/FG1Y0HIXxLwx5UTQv8QbDyObhMiEVfkOWoSILiQIpgrDgHj7dS2DdiI/3v+ciw28ZjcQAZCgyGW54qyMgCmNB3VWioAjrd+zxmxeFgOtDIoFlqU6wP614irVBq0JndW9MKkJnIO1cCQIgempc2h6Fjpt+CmsMJ/v5wxrvOt0bRVZxn98pOa7eM/Bcqrk11G4c5xjMSpLXNvfGqzCcN1ASz0XWuVWg3gY8nn9C9tg0X0dSHOCM7+lkbp8BlwhjmG3EE/yML5DqXSpy4LFtiwEpuK2bowPNn83z6DYnlT8gGT2t3R+q/IM00P/2CZfq9/tPqcKhtdli8txna6meHXztw8Gx6M786zULc7CjdwBjriwdc4bGTkMJ5DSf4oQ9UUovacIc/lsxiqxw5HXGdhb2SKRveaInv8e+U1WAqeeRW4VujnDim3s4POg6aQzah1YhnDyfpFRfnV8EOBbsrf00ng24ggKeuFJ4Y7tPZce1c62qGgVpJqWetPQCxV0jQ+eSBKZieoofUwWz2z6nDo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(122000001)(38100700002)(82950400001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(921005)(2906002)(10290500003)(186003)(26005)(478600001)(6506007)(9686003)(5660300002)(7416002)(8936002)(71200400001)(7696005)(52536014)(41300700001)(110136005)(316002)(66556008)(64756008)(66446008)(66476007)(66946007)(8990500004)(8676002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P6n/dpyo0rIe188JS85MWNGsT/R38hlIOcNjUyXRh3r6r5HkVeQstMtZYieM?=
 =?us-ascii?Q?/v+/DSKOJ6sSiHkGS4Z+7rI8880zdcyvxeS4yOWc/oudLQ+iQ0aqWM6MsV6X?=
 =?us-ascii?Q?M4Kp79kJ2Ssj+kjCxlQDzwFbE8eU3CnLFwpwHPOKgnvSihjuQOw9LBnrqlMg?=
 =?us-ascii?Q?lrJ64RSRJac0UmOIXs/C3b+pRPLiWuMhni0njbJrEuQ5FhybxRkQn99qObuP?=
 =?us-ascii?Q?Xp5kw6/lYyhmJfuU+v3v3I0uFQdzIA8b2M8lEIBr7KBbSAEVzNVCyQsEqY3F?=
 =?us-ascii?Q?gnDTkruf3rRLM9GXgL620JQK/tMtWHeJHpWAgvx+Id8TN5JPp00DhaSWlWIG?=
 =?us-ascii?Q?jLtQP1UzIjxqyzbMlLMYkSArtQI/Y+XRC7Qg/O5GrMtFOA2AHx0DXudATTGI?=
 =?us-ascii?Q?H5ivdFID3P7KMHSfJwdnYNG+AVzagoDvexysC5frVkbznXukjRbzwbnPjsvy?=
 =?us-ascii?Q?sYroT4S0nqCKZXV5SqEnbkmwwQwoeyj69yakp56swlEyrsZ+mp7gnDb+Th6A?=
 =?us-ascii?Q?DtMap35rnaLtH+kzBq4LE9ljG2/SXw0boyGe8QLhkk1WI3GzHIpucKuBiAN2?=
 =?us-ascii?Q?6kKyX82EUK5+EDtvxZH3ITjBhe8x+ZhNBzAL1C+26mEj/VBCgV8inVc5vPEx?=
 =?us-ascii?Q?TFkhGuWS9wL3qI0DeOlccCspONdXE9/mNmS9MToFs1ettLOqLcgaGV1/ikjH?=
 =?us-ascii?Q?Z40P4nbTOdjxBcYWP77G4Y/1VM/IH/jgPf4NSEinaGBrROSssEzWmxjIO4Lg?=
 =?us-ascii?Q?ADoLMPOctRqFpUDXxyYqC+JHFs3hloLFgGARc0smmDTp/7EavRIxyyVhurCZ?=
 =?us-ascii?Q?J8XtPERPSXIHn/gb1sE8/6j9MpjDf6Vp0HLtbz5lva+1oQ01B4sBKlzfYvnM?=
 =?us-ascii?Q?gHxBMuSZPcSpTHAM0AnP9VQkiSfDs30GGjQKrYk7Qfafw8dYjMXgv/5gr3dT?=
 =?us-ascii?Q?b9TJEYlT6tmn2OipHWsYBB/pVX50IUA5j4c2hPrQpLENPh8Hh+1ken+4Tw/l?=
 =?us-ascii?Q?S7cSzLXMMgL6tAjODrQotzaQW7mIFKJV0TRqkExRDbIgvwk3qTYrmakzr0kI?=
 =?us-ascii?Q?0/FPpHVlcI5+3LGeAv1G+pLxGGHpatEDY7UxdxnyorbzMp6GHDegfjnNPk96?=
 =?us-ascii?Q?OL8QQ2N+0nL++XQ2788XyqC163SJ3Fs2Qr8vOP0REtDKnk6gOqj8hnTMsJrV?=
 =?us-ascii?Q?kHnnDSOmr8DiROlewA0HieSBkF8zFPzipZiqtt+o0xAQr8ARa+Iy3cAQJnJw?=
 =?us-ascii?Q?H5yAo5BqbhGdNjnvYfiicn3yHHxc7mroSxSC6EOwyFcvo4VTX1saofSY5e/Q?=
 =?us-ascii?Q?e71PLovs0DwZIy9RVWAlfcbVO9BJNaGpquqBvSDQ4HPeXcp+JkceGM3rpSwO?=
 =?us-ascii?Q?xIZo8PVj3nAyX4hIwTI1trJvEr4kQ57Dhz3CgJKjhzQ8kGK8zVyNwnwUlxTA?=
 =?us-ascii?Q?m7VoEwdoTs/YgYdQo+u4YRYTzObFjnxIl6B94Q/ctZKHt5xOkhNtpu2HlSVw?=
 =?us-ascii?Q?Uq5SAaqkuFTj4/tXxTphwIKPtFwTeVfosPVs5rzLTdNOu7b5Eg5zN34Zajh3?=
 =?us-ascii?Q?m9/JJjhWliBRXNCC9ejnVCcLptkMidY33zpVpwrvzxVkEPgjUQlc9j8b+yQR?=
 =?us-ascii?Q?lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09814f73-3829-468c-47a5-08db2e0ba52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 15:06:15.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sijbFtvMb0AI/0S9zSXupnOT1UTLbb8NwJ45Qrp8FWsOYaNbcixtF+fKrjVF7XeZsmXnMjdaITWDZdVx6nnWS55LWAG6RClRz2y8BHxdE+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1908
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> Move hv_get_nmi_reason to .h file so it can be used in other
> modules as well.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 5 +++++
>  arch/x86/kernel/cpu/mshyperv.c  | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4c4c0ec3b62e..35b16b177035 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -181,6 +181,11 @@ static inline struct hv_vp_assist_page
> *hv_get_vp_assist_page(unsigned int cpu)
>  	return hv_vp_assist_page[cpu];
>  }
>=20
> +static inline unsigned char hv_get_nmi_reason(void)
> +{
> +	return 0;
> +}
> +
>  void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
>  void set_hv_tscchange_cb(void (*cb)(void));
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f1197366a97d..61363ce0b335 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -250,11 +250,6 @@ static uint32_t  __init ms_hyperv_platform(void)
>  	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>  }
>=20
> -static unsigned char hv_get_nmi_reason(void)
> -{
> -	return 0;
> -}
> -
>  #ifdef CONFIG_X86_LOCAL_APIC
>  /*
>   * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

