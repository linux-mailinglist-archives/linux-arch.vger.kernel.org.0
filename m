Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFFC779A87
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjHKWQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHKWQX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:16:23 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357BDCE;
        Fri, 11 Aug 2023 15:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScA8l6WewA5CNnKAaD665r2mPAVNmN746Ly6HjZK1tUhcRE2tUorjFSDvRCynVaRZXuVIcwka2PGMhG3rv+jUTbx6pWp/6DIXg3LrrxPRzz7iTxL1Ny06TAyqwb5TRJUow4y+E8fAT+1FQblntZ+iimBWuWPXQgdc/ipURvt7yLZMOHI1m84L1BLYdF0k2WHkegWZZicDpXZEVk7qML9vCrS5kZzL3QjrojXFJ1Lls+77uMmHbQgSV0PLcYYbJP8nzkjHzaKymYVP7Owra02Cl4XnSxQr9YN2yWZgI19AjN4DJ4Hvyr/5nokAo61YkdFNM5+A7vWbavyuUPaCV11aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsPw693bazfLstgLxzovzUeRw5VBcc83bC0u47pQYWo=;
 b=ZnadzohU4OCdwST9xFThRZJwUv7JIidjlQqWBszZ6QhE/IDscO+9yTdGFC2+VqBR7GyYinAtfx6r4G5AvPVvbahyyaN4Am0svQBD1QnzBNK74sHzp4vM7M39pFs+bA45Xd1ZRH1tBW/wj6qivytm9rpOXzfVEB3NknHPkPIZ+upl0p7n0mftqr26wxg0lQIcFmh/czza3NcujRCwbkBi0jpEAge4waqp3/EWMvYIZx9rr6s1NeLNCEXCJWydyvaqVE/UFGTHeQlNBYtTLiS951EKaiTA4Pm+XAuxikr5x4MrKXM6GhqoQ2kDx5pilr9y5Kc1Ja6YvI7pKUrxQ9Hovg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsPw693bazfLstgLxzovzUeRw5VBcc83bC0u47pQYWo=;
 b=WtVDE6EVsbCxAdHPIGGQ8qty51pbDR/gdD7vSNM0eGHSgX4O8rK+fIx325/QRgx2GOqKNxQQG+HAnV9qO8NXGDDBqVwOcTYohVQtcCdNTrxORsy8ybzNgfuImhFQpkVN54fl/0puJwV/6z4HmyrGICC8l2HzLww9QcJuXzQ76t4=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3699.namprd21.prod.outlook.com (2603:10b6:a03:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Fri, 11 Aug
 2023 22:16:19 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.009; Fri, 11 Aug 2023
 22:16:19 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
CC:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V5 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Topic: [PATCH V5 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init
 message
Thread-Index: AQHZy6RY7nYR/0UDx067fCeHwlC69q/kIcWggAF4xYCAAA9Y4A==
Date:   Fri, 11 Aug 2023 22:16:19 +0000
Message-ID: <SA1PR21MB13350977E381D776530C2377BF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-3-ltykernel@gmail.com>
 <SA1PR21MB1335C309189196688CDAA7CCBF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
 <ZNak31AH7u7rR9oS@liuwe-devbox-debian-v2>
In-Reply-To: <ZNak31AH7u7rR9oS@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4853f936-7dd5-4a70-81e8-65b421b44f48;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T22:10:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3699:EE_
x-ms-office365-filtering-correlation-id: 5e698408-ca22-4e41-97e9-08db9ab896d1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3L1ly1/TcHCm2EgpaPqKZibsOyiaSFNnhumGB3wDLi3eUhvhXsBcUzzGLMNstAtbGKmeQauXzxezwxiYMDJut+F6Z3ULu47Z2VCUraxF/5/bX7XzK105nFVg674NCanH8RRhosP2Bu4TOzwNCLj1QWldwrm9LLFU8w64W/d8lV4Hfy4LGi1aDfjcDVTQYNpV3tSm47MOpUAkv0TRKu0FUwZidES963booLJ2Utk8JbOHU3aeEdbJTOWaKkxK+1OwdcO1zxvqbGm11avCYfA7xddrbiFIYRwzoqu9ORNOf1U7s+WxOoaU64PvDyYNug5VhSW6A61waqFoIef81duUuV0uyGFMsW5OcnkogZhddGKS1chxUptK3pBbiGQWaK9cqSMEpKqFh+jOtT+VXKCqvCdO/BPK4h44dTXlIGXTD1CsmtaccPbTn4bMbWzFyqRkBH3wSymhZ1ZtSMhQrr9+C2E9NMAqKStpzLqYfxq8TK995A/UbVfYfdnKIaHU8vXfUcPYVyer8lndXuRJvJXeTON+s92j/AN+7BhmAzqQypViRZ6EiA0iBKYEOnD710HqJQa0oy7ZGQ83Wxh5Bgq1RDmBN+cwAJM1Xt9kkMA4nhGjxg9XlOirx+7aDAlQqJv/tT+ckoE/tpAAw2wQPQoqC4uf+CrG3mw14GzJy5rt/5JtZDqyf5dWjejZtEQicSjFV1o3Txy9gBfM7nyIreYKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(376002)(396003)(1800799006)(451199021)(186006)(6506007)(26005)(7696005)(33656002)(10290500003)(12101799016)(9686003)(53546011)(55016003)(71200400001)(82950400001)(82960400001)(122000001)(8990500004)(52536014)(7416002)(5660300002)(8936002)(41300700001)(478600001)(4744005)(8676002)(38100700002)(2906002)(66556008)(66946007)(66446008)(76116006)(66476007)(64756008)(83380400001)(38070700005)(6916009)(54906003)(4326008)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iIOzk4oNZTns1OCoI7yXo0fT/txcvrUmRJ55kdQdk5NO43iNs0uguOf3PqeF?=
 =?us-ascii?Q?3nrSd+QAN7tN4WmCgf3mdJkyzlcWJSVfBnvOtXjxhR3tZjmRmy4v1rW4Hgzy?=
 =?us-ascii?Q?RNJubPPKcLEY1j3/wgOGcrV28aRB6Kv8AW5nvJusdUXatExMIFLVAQjTfBTP?=
 =?us-ascii?Q?ocMfwTV2WjxoadHMd8Q7HDpq5ba+LdU9u3R9Km/JALSuJMLN+I38YydhY6Mr?=
 =?us-ascii?Q?v77AKLSA/IAU6R5XYX1BxmwyjOcOhnmCcR1FZppclwsxHl7Zq6NrxYsKBfTb?=
 =?us-ascii?Q?/60M56SB13wUIl9dMYQui7A/1YxN/ArVkcsyrQHnOGLgd8Dvu1TvKIRp6Coc?=
 =?us-ascii?Q?fRwgQQbUgIr3/p4+EFbU81ERRClPrWVFuZxmGLmxdQWOwsjubgNJy1gSpSt0?=
 =?us-ascii?Q?dHw1eSWkVjdcDDCGIWnCOcOR9/LOoIc4DAyaXZrkVJWcZ8YLuiI1B1MfB516?=
 =?us-ascii?Q?9/9zXmcVJCb1ghrtrzR8UsnBgrFvSe9JX9VWvWRs/gK23U2Jl9mrvSrMsJLP?=
 =?us-ascii?Q?4ujzPL0Z0rLSzHoCzKsFyjyWsHGit1ni+WPQswVPRTPjI8gPoWxILMh9Fijk?=
 =?us-ascii?Q?97w/uKIcibk2dKy+6aaOkdyp7AMg1jAmVfNkJZ/isoRp1w6MgZxomOgZKH+h?=
 =?us-ascii?Q?/x4UgPAdk4iwJXqeF2/zVfRqQEt7HfbcFGiiHrrgJohsMV0x9XvphAvFxwvw?=
 =?us-ascii?Q?6D01Nx61frw5lhsx5RAuGR5Vxuo+AJHiYGLbqlg/DQYimGc/q1x61DJKAClk?=
 =?us-ascii?Q?TcdWW/9uzmkGBd2tFbF5NHTLKi8bR1Zn2Wu+Q4cTmyQMbmHmmWVr+fwKLxgm?=
 =?us-ascii?Q?yLRXQomWIWZ5e2xQ+ZyOL5r68eicPgd3gmRL5Rnm0nJN4UDjF64ILmctXNet?=
 =?us-ascii?Q?TsVe/vv0G78QcAwTRKNoENJojEd6A9+vCY0C8Y5Ox10MU9jsTnXlLZx/owTD?=
 =?us-ascii?Q?YSnBX2HIbSy+Gz9J4PRJRV3uouwuv/Ynjgda90fej6ZSHNQSDCHOUycHzrGJ?=
 =?us-ascii?Q?dd02O0eN4Vww9w3tT0/VSBB33B9Lgh3KFxULulUmvfwKrL7mubBWuw6Tg8As?=
 =?us-ascii?Q?UMBa1UN+wIBwXmnmjq+u/jhY4N2fz2lMHotfWbkAO8+A9W6yIC7aqNY1lGef?=
 =?us-ascii?Q?XWQbwiKM63LuNnki3e43Gno9XH+ZyO31AS5JYG/TYvSOpy+XtUgEUW6xEmFj?=
 =?us-ascii?Q?YTZgyeNIKXtY1gMRmPFEFt6Q/pLxLjF7k/QD0loBxDpvTdtEH2I77y1cVXgi?=
 =?us-ascii?Q?Qs8fj6qFZ8q88iwRLuFnWYm75CEKRolFDX3d4nK9YnCsO1rs26Lvj3USKsWJ?=
 =?us-ascii?Q?tAPqtOAHotpr6IIuXCE/RPw+ApAPrwc5RSJNJaIkvpyQRGqtQDgXvICH+Mk1?=
 =?us-ascii?Q?PPlxuBncFQVhCgOn1UOThilE0SIZQDoKgsR91kI7tr5XIgoqrHYHFBd2VvHQ?=
 =?us-ascii?Q?fdMhlQfNWa8M09HLbuknLonloQv029NAL7R5dc2OM42lEAAklQXnOEl2nPmy?=
 =?us-ascii?Q?h5VZrdOmjFaozFMZHiRd1HMaN/uogp18cbLKprHGQQbPuM0iDPdDF7xsi+rU?=
 =?us-ascii?Q?IjkBBjSwITw/zPYPeAIQsdF8rsiEMfyLJPQW0QIn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e698408-ca22-4e41-97e9-08db9ab896d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 22:16:19.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/IPxv6EqOvL1iWs5PUfHAgurPrshMeLNKCONsKe/8N1OI8JhaiDbtoCnGirD975UDtc/XOROnMb5xw8zYQEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3699
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, August 11, 2023 2:15 PM
> To: Dexuan Cui <decui@microsoft.com>
> > [...]
> > > +	local_irq_save(flags);
> > > +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > +	output =3D (struct hv_get_vp_registers_output *)input;
> > > +	if (!input) {
> > > +		local_irq_restore(flags);
> > > +		goto done;
> >
> > Here the uninitialized 'ret' is returned.
> >
> > If we move the "done:" label one line earlier, we won't need the
> > the above " local_irq_restore(flags);"
> > Maybe we should add a WARN_ON_ONCE(1) before "goto done"?
>=20
> Out of interest why will input be NULL here?
>=20
> Thanks,
> Wei.

I don't think 'input' could be NULL here.
IMO we can use it without checking against NULL.
