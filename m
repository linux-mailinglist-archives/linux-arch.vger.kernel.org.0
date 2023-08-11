Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2306E778477
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 02:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjHKAOL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 20:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKAOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 20:14:11 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2F72D48;
        Thu, 10 Aug 2023 17:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkH8l4gd9zWgKtGMcGd3pHZpKAblVXjU2+jC6iujGMykkvYgQyfy0KZnc0iM/zJfy9l4HQItK39yvBID/r2A8B21hT/sRL3KTpzFrpfsDxfcdDgsBeopin8qUf82F3S12ZAxpG7rbh85x6s8ck4yg/8pPWPktHMP3oNSTFckJc3hAvw1ewAAdI1dYlCddZAXRcgyE4j6z3dLcy6arN3iVqkbGkoirzBcvr9nHER5PSAzvCd+JOq5psXsEPrGCwiKz8TUT37dvpijX7RnsPjDmPudHlmPtwuAmIMkr31rVMVuDky8YsMh54ptlCgsyhFQQvuA/HuO9S0fuyAVRd9Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HZmDm4C7fkR/vDuq9khBEB+z3NYwdwfIfMrgkhWMXM=;
 b=cVF2iqsctm0CmsXflWLT259eX5WyI3Ov/8E9hI2N+CY85081NMkzN3/g+1ReWXySyosFw04LPOmLeXn82Nhe7mUymCsJGK/9CwDoHIxABaOYSObmBu6yWn92xgDBDwCeZqo64wohbrIYbBNfBN5P+4zjUl1VazmLHV+p+ufqIsLbH+E2Que583n/SiiOYMZG1stC/+S+d/PzRAXdmLh7HC5K6zWbxmm79kl/DlN7h8lJDDAiIMwTOZeElaC39jl3PU7452Eaf/OEFayrgd2a5lCibK2nA3k7LByuHaLLqkjhJC/LXrGHj2fZN3nZGj7nc1MO38vy6rjGUD8UpcCOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HZmDm4C7fkR/vDuq9khBEB+z3NYwdwfIfMrgkhWMXM=;
 b=eJBL3E1VFlQC2oQ4rhVuTzkeOfjtKHSjbDvWCDY8cR24vHOg4RXk7131DK7E6ST/l8R/Q/WgkeO69fIahm0cRa2tr2w8MWjZH6S4qhnyL1e0exJfVu7i4jvKBowHMQ4kw6xJb4okGt0R8v1Xr7tK2UryIdBB7IkOeWDyQQIxZQo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SA1PR21MB4034.namprd21.prod.outlook.com (2603:10b6:806:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.6; Fri, 11 Aug
 2023 00:14:06 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Fri, 11 Aug 2023
 00:14:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: RE: [PATCH V5 6/8] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Topic: [PATCH V5 6/8] clocksource: hyper-v: Mark hyperv tsc page
 unencrypted in sev-snp enlightened guest
Thread-Index: AQHZy6Rdq+HfP2/rVUafoQyW9aFcWq/kOaJA
Date:   Fri, 11 Aug 2023 00:14:06 +0000
Message-ID: <SA1PR21MB13351211BB7EFC2AEEC33CEABF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-7-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-7-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=65231e26-6806-425d-884c-4941773281f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T00:12:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SA1PR21MB4034:EE_
x-ms-office365-filtering-correlation-id: e33e463e-ccad-41e2-da97-08db99ffe0ab
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bivb9rC0dgEk6gyS+KyxFd0LP2mh5y0ak+3SSjVLrGqP1PAvSGef4gvoyFxkRBueeffOHPp70pPYa6IhjUVdfNe5NNg5cm5nW0PM9+peNmpj+IGnMGFhy+Q0QmLTIcQRIakCQ3HwwoALO7OFZXPGREhnmPYxtxCePSMtH8yrMiJqQcYyZiUcdCwtTYPcpwITfEo/WRmPmNSai+6lqgOU2Ov7FyDuJnKNMXCCaje0eex7Ziq+6pLxwjO6dsr+kRxOT69bf+ucVgmkcwC/9o4yB0NvKd84E8hQGqCv8Q3+aUxSBmygvnDb4gKo/+CzHHi9u0oE2/XVUpDJTUV8DPBZOkVs6sPKcS4WY5khsxcA7PaITeo1RaQhWEVF4JKhZ8GZe3oBipSYprmHlHCMcmOnd22UtU3g6BHqDAVeQ/GXwLJokU+Nu9oQYroMJN9lMiW+N0zzp9J0TVmsUMIV6dasaSeu/5uE5BiA8socApJLRTGjaRIqfUHowTEXgD2nnYnDM1C4dXktK2BsxcnTdVWyP1LmSfCZV/RkrL+pGnkfVE8CEVfb2QHe6H14MtbR+7w2HOO03zhDkPeiWKcIzAv33sK9O2rLKcKj2NWEm6vn4yn5uj3/EAuEj+C5RpWg0lJGpzthp3fpY68Y6+Fl68LWzdK1qXBaUtEo1RoPPYOCLksNU22NprkyzMn7mjbcQyX9uLTZvbNGfOt/nhJBft31LA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(186006)(451199021)(1800799006)(12101799016)(6636002)(8676002)(66446008)(5660300002)(82950400001)(2906002)(64756008)(4744005)(33656002)(86362001)(8936002)(7416002)(52536014)(38070700005)(41300700001)(66476007)(38100700002)(66946007)(4326008)(316002)(82960400001)(71200400001)(6506007)(26005)(107886003)(122000001)(921005)(66556008)(9686003)(110136005)(10290500003)(55016003)(76116006)(478600001)(7696005)(8990500004)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o9LnZTXE0ADDJzh2DaSlMR1+s5pAf7COcqL3tncJzh9bimL7xywnOzvmhLU5?=
 =?us-ascii?Q?OeUM7Sunl6UyyfGeGlhhT5t2h4Du7PUs2iPKP5xJI+VFeILU7fVeIJLmNo5N?=
 =?us-ascii?Q?QYEicg66LKndqWoFM7dnpH6lWmA+Sx28mhBTThz1wrqXVwg+hJbd7wm+bzyO?=
 =?us-ascii?Q?ffkAXUagAAL025czVjvg6ibHUPg/UVpcBrfddljw5NVfIo+uMAN88DRnG9Q8?=
 =?us-ascii?Q?5b0ArSIgmmJFY4H8DFMEWYxLtka8KhVp8TXr1EdiQIAguYM1nGQaghtb5G2n?=
 =?us-ascii?Q?fI0DB5J6Uwtn5wvS6Aw4dXE48VVMOINu8fT8PmvqPZ2DgYFdxwA4IURW7AB3?=
 =?us-ascii?Q?SDzdUbwXEkEb/4XXTUB2O98/4kltyz6mYSiAkgBIbFC3dNog9mBJbvSJDl7c?=
 =?us-ascii?Q?Wj3dFnpbOf4JgCBaLr+/KIsvERHKpB4oiC6YrsPve3fDXDYVJkUVI+cSb2XM?=
 =?us-ascii?Q?tzsQlpYPao6SXkrv9tjaFwJYjwuLPj4g2PDeACcFO3e2TloSTUgJcaIJOAIC?=
 =?us-ascii?Q?Hj87yxtBGQdOtwpP96jI1dsN8lDJnbpQ4RcwGnnNynRZ+ufRVKdOat1gO2V3?=
 =?us-ascii?Q?Tnchl9B8MMBQm6InIMHtV8utow70UR4KnWowJebg0xhy4BVuHfj2gcl5lFj5?=
 =?us-ascii?Q?PzpMybnxVWiVrGX+Y/IJLbEApIRvwtQVW3G7hcsF5W7NMxraftczBHZvIayQ?=
 =?us-ascii?Q?lQj2WUBAseH79snyLFk7IkkX8XlAnKczo/y6AycsHTrayO3XZXHO49D8ge9J?=
 =?us-ascii?Q?Xl0qg1Um3jkABlJFRAIv92qw8GP6PYAPfZKAsZTG2bV/hsLB3nxWYu79h2u4?=
 =?us-ascii?Q?najWOLhBeNhiWt4BK6erryoX0j2mPogXK9XE4shqTRubKlN2dJbIOl+yKQ2B?=
 =?us-ascii?Q?cRYIbMUXDhFe2LH5TzCZ+QO3psfKsvTzyO/Dpm/Cdskd4hxSaLezd8eqlt38?=
 =?us-ascii?Q?0zzerzjxvSyClBegav0tI+NxyrpoUnqKJt2AhwrMDlF0RpICSZL3mVsq5XlS?=
 =?us-ascii?Q?9UlR3GJ/9ivFBeIbfjpz3yvOghe8ef1shE9W23SoB8p8jgGtXDuCBcoW5VvN?=
 =?us-ascii?Q?mPP8Ffx2wsa25gGF921qaAambA9Ye4xhWxMo5ax7X6RXm7DB09/vft8qnttn?=
 =?us-ascii?Q?WelWv3GCFGGY1du0YVqzj0rHyF5bYXUHB4nnMOssk04n8EG5J7XK/EWyThPr?=
 =?us-ascii?Q?5geNcmPrkJjLM8VG80Sw5OrpziOzxNYRmEqjzQCdbNLtyb+D0IXOJcLFTogZ?=
 =?us-ascii?Q?I/69Fs+DfPCkXWmg/grFq9WVEQiy0KZEgV1XOtf5g1wBDdmtmm3Bb2l7Zort?=
 =?us-ascii?Q?lQNXjR9MRxrUDzlW9oiIH6jB+uRRETV9qZu+gWGMlvGL3TGWwNpJfptV1+1x?=
 =?us-ascii?Q?YjTfJOp1coF1uZGlLyQdpxv2mfRv4ejCOjLV732SVIMVOR5opKsipJoLtkn2?=
 =?us-ascii?Q?2wAzKVsF/qMCsDWkmxCSHYM3Q/QtQHVnjHmc04JdengmpzFZBanNM4opqdFh?=
 =?us-ascii?Q?f+IK71na1KJxmLy3nJVyyiE45WCmjUi8nBTIRaGmRUDH7suR4ZbjZBZdZ3/8?=
 =?us-ascii?Q?r1vNU01CiBImT1aP+bXK7UeX2RF2IPHMNWvnKAeF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33e463e-ccad-41e2-da97-08db99ffe0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 00:14:06.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvPTVVhlYPuQNK1cvkqBm+ZIZnUJUeyUY/XSgcHUzi6ks2/WdzsYOftPodz+6ctfWiA5CISfgpKpWpfMHdug4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
> [...]
> Hyper-V tsc page is shared with hypervisor and mark the page
> unencrypted in sev-snp enlightened guest when it's used.
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>

FWIW, it looks like __bss_decrypted is ignored in the case of
TDX. I'll get it to work for TDX in future.
