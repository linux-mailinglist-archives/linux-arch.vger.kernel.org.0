Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B07473F7
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGDOUF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjGDOUE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:20:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2110.outbound.protection.outlook.com [40.107.94.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DC1AD;
        Tue,  4 Jul 2023 07:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpzvGxc/jbIbFBwKLaoH0G4ry2NpMMbhMAF1DRVGirES+jft8kZUJlsJAQagHJ5cOguUhHMsJPDwTkDOxGxd27Smiy7PppS7bx7qTdz0FjbrGdlt8dgLH3Sq8EvwH5XVIs5Grymijj3kAlDaH9gKrC0wF+IARbmQfhWK5QFeddRUim9KHRs5bWVAJZn+8spTa3Jy+8gOLc++n7dGE6x6zpg3mt0yVhPvxnF7aqNXbF4EimQKGpSsoQf0w5GYQpjBQT1ibhRNHU1CAiSG5QVnVW0m7js8TI9SGGDycKC7UP/0YWWoX6kGfPjsbBe9+OJ40b7HwQS1SFPu1UOwjc/BEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzkR8Gl35G6lpx+JtDUhoocZAsdbhwO20SsGZyIgpT8=;
 b=m968o7IzbsfRZTN26OsQIFJ84Mawk8KidLxl7NG6oucIjT/BS23lm2PFHyqSlJQTsUOb4AN/SzazQI3G4ETKE3JWcHjPTGCQIf4LvBepCGLsK1tWqLkfU5Ld4Qphl+w+fOrUZTy3JLHq6RgM6Vykn0eYqZFGwpmk3wDxCLgKcGIqIrHCNTyFm9JiTuNSzXWTQGYcI40QYGjtxR/E9yVJCZvyCzWCGudS7/s809LoVolbndojmry0AHGTvjf4jsSu1qr1WKYsHkaygEhq20H6pYCcdca+GpBgS9G2yaKRNavvbXH/2A5lNrfDMu1F2c6SL6nqz7nvfZBfUjk3jUWJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzkR8Gl35G6lpx+JtDUhoocZAsdbhwO20SsGZyIgpT8=;
 b=DxFMmjlc2tvv/3s8VIipFlkK+1eib6iZ1H1pfih2UZQDB8La9ofsx/JUSU/V3RgzZG/1RlsgHTAZEUT91sFLf3xEhHF/Le9VmqFhyBLfXOsOG8F7ChXEm62VOH6TYW1Fwm1eZIHsLnrMW+vdgCBlxYOoJuVI7qsP/F9eWP57vyY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:20:00 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:19:59 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH V2 6/9] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Topic: [PATCH V2 6/9] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Index: AQHZqKaxbIc0XKeOf0CmrSq2VdhFnK+ps9bA
Date:   Tue, 4 Jul 2023 14:19:59 +0000
Message-ID: <BYAPR21MB16885F935CCFAA000BE04992D72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-7-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=682f3c6d-d5e5-4123-8033-9bbf7633b204;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:19:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 40fcb735-04b1-4da8-e803-08db7c99c02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUY9ZBycRwjepXqoyxuMPwnYHkTVR+1CIPWIRNrvTRzcd5pR/118TD1P7R6oQ8uytX96hJy0DOFMEd8S4LEZCiZ0NH9/fbZ+Q36cPV2bxUrkl70qWi79KxTJmL5ATbfsYekFlmT0ytRl/4Rqc6CjP7MpZizB1CfhmYrReTiCOmz0bXlH+EniGrQ+NhzktAixIk8n0qp6izb9j6PFJcSG4VVu8sQbUUGXAzR3O/C43LvFIQHK3srU2aBqm3l8F9XKjW6EmQ49zYk03/XqON7pyXMwcfXTTip4qrow3CfNOywQ1prxru/QzGkpFGqyfnSD40JsBxEv5pGN/Y7S/sqrQC2qKoY0hGRP0acvpItMgJMfL533htYrMBt99tujMBYJ2+l5gzETUUDx6ghSX98v0BhdGSxUB3/ynAPBd0UEPn3A3AfhaBxVIiSD7ssVCUJb+Nj9a1i7LhVIVa0tiFnwY/8glYc10IqvE/1T8oh2N6Xh6MRYpkHAbydO32NzqzdHIBRTvCTCYANIT2jAC2L0AkaO85EEwOZkPpWgkYek6lwqZz3M0UUq87/8jk2sTbosdI+CEZl9FaTbTYAJn0Eb7MT9QawMlVwTX2CAlKkikqphIkuvcheg0gPQJjY1KEjxsUjBgJghccrJHEuVRKiGiJeb9qWvE/D+tpj337UOW+PDZ+d5cuM1DtepMJYS2x+p
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(4744005)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HjmsNIJwh6i5tAPpq3AgmiiPeSCg/HRXJNguIebeMpW3u79UpzpkRHYHfAEO?=
 =?us-ascii?Q?y3ckIML1QRvzkqUvv8L6P/EyZo3bGjeQfslYbwNnH90tf/ZVzt/a07CEdwzU?=
 =?us-ascii?Q?SQoDs0Gwz89xFEftzYl5vzlvgQJsF3Z9Yh/tf75S708h9fuj94hbOG1JN/Pn?=
 =?us-ascii?Q?K09jhmUypV/YvGzgU+48TKFBpq6A071xJQ6loNgJYMQDs6lailMjl5Ci4btj?=
 =?us-ascii?Q?ycyspfYpncbL77tqx4BQwyx7nyF2mU/B0Zem47vawI2NHFNHVqFSbyBFHQrI?=
 =?us-ascii?Q?7mEzxkCcPhnMruC+N2h5W93+qlZUuAVovs5dFZg92SfIko0Pbzp7hPmvS+Ux?=
 =?us-ascii?Q?zH+J/NGueD+dz0myN4C6myHTSyxgIbNpQDIkLd1GxPdH88by1JS4OUnJC0YA?=
 =?us-ascii?Q?aA5xQNxJey0EB0W2fd4hfTDb2qO7IeuN8tkh+1eeAHaVYgLNDdMtDAMIxzLJ?=
 =?us-ascii?Q?JLOJ1kVF4EgLgipZ2T8XYH2nvv9kBixcxCft0eqbOmJrafpOR7i7GfvEYDwB?=
 =?us-ascii?Q?SzXvLAx2g06CukRImCArtfgzq28aBtN6UDLQLO14u/YFsp7/29hYanK/9B2C?=
 =?us-ascii?Q?uGjRFC07eL16JDZ/OKcbt7amZVUtVClPCHCkASkCXWXjyB8GqOMDZ6Q0itqF?=
 =?us-ascii?Q?DS9sDZIctjlFbx/6fyv5gZbfh3OuEFQvIvs31+UhKrUoxKXhDWdzFa/w/c3b?=
 =?us-ascii?Q?aY/mFRwMkrgGGH1frTi/htc6+t4l2MXrsQsh/vWi9E2Mx+BaRC+yNmqqE5wK?=
 =?us-ascii?Q?xy3zcQh42LCvxSoiO4vpFAPbpQjApLDBAXhwHxY0FUvh7G8NqDK+tSCWLKTr?=
 =?us-ascii?Q?GH4uCgwcWrhF/4ZiQoM/4we5rLm8fizOyKENHoLlj43IGXQMGD0TcZTuzNC1?=
 =?us-ascii?Q?SpmEzaP5tNAfg0jiU08knrkTr8HA7tPoWZzxHuxSPcCBYARZ1bZarB1vXX8D?=
 =?us-ascii?Q?uLb0c5IOnWFrXFX68HBpKW/mtnQrZyls0wngiDw3FkMtY+36i0ECqnIfRxI/?=
 =?us-ascii?Q?W/+JovyNnIxydbzGb1K+mDNgsR1oYGff0WYcLvf0DCQt6PW1JNtXFPFNoXh6?=
 =?us-ascii?Q?g164VsKedWVUH0Ky7L5gzVy/upGSSHIj5Bzw43MoAXl7WOK5oEpdSWulgZe+?=
 =?us-ascii?Q?4ksbgXb3lh+c5x0kZGQIss1Fq8VtBKjteGV++lpgficmf/hjjSjdMmtqD0lm?=
 =?us-ascii?Q?yswFwPOwsyIzxePVdnw0tutJfunu3Ll6NFX2yVuTD95mDxyGWoSZFWIffZgP?=
 =?us-ascii?Q?IVs2RJqr1aoriE6AseojP2FLdcb3xE5868C+fvPx4zRe6QUgFXpLRevfZjX2?=
 =?us-ascii?Q?2NaccZlmlojs0+JdHiTpBJs09fGyreYHje4emqSC5CN7f2TosON3pUapkVob?=
 =?us-ascii?Q?jKZ5xppYjjud7PCiHTyLhyLIQdJm0rQq6VK1lsr9Xh9sXfe+a5tKqGXK9keq?=
 =?us-ascii?Q?Ua+KuX1qeQxlAX2xvl3pWsvTs+qD8M0OpzMbLhs7s1nXf4agi4kD7tLw9PUR?=
 =?us-ascii?Q?Qjdo+VS7sMO2ucw2Fw95cQvpT0LJmCeYVe5P+tAZU1q/+grdg1aMAnq7SmHE?=
 =?us-ascii?Q?EWiBdF4CTgkJS+NabUATYKSBNLLgmZCg7TPKyTonmG5bi3nX4854/RjFqiNn?=
 =?us-ascii?Q?Pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fcb735-04b1-4da8-e803-08db7c99c02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:19:59.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0B2yzwrfW7uJkQOgVWTGKidUW0CFkxstlWhhkXYtl9FxqSuQ77+7PnVpwy75+whv1hFP5wXqOmfwA6VOaSCO+XXW94I6mMw3HpEakafyLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> Hyper-V tsc page is shared with hypervisor and mark the page
> unencrypted in sev-snp enlightened guest when it's used.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/clocksource/hyperv_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index bcd9042a0c9f..66e29a19770b 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
>  static union {
>  	struct ms_hyperv_tsc_page page;
>  	u8 reserved[PAGE_SIZE];
> -} tsc_pg __aligned(PAGE_SIZE);
> +} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
>=20
>  static struct ms_hyperv_tsc_page *tsc_page =3D &tsc_pg.page;
>  static unsigned long tsc_pfn;
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

