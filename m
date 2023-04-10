Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D8F6DC9B1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Apr 2023 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDJRGp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Apr 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJRGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Apr 2023 13:06:44 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020026.outbound.protection.outlook.com [52.101.128.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3781FC3;
        Mon, 10 Apr 2023 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROG2W8ytKl7mvga5uezGD1vfDiS4FhdH+WDEIwmGHCV4dtvDDS5PLviLRMFzMiSplQ8NBpMKq1zSePaWEKyF2SAA3CFcKCtiJd5tDdbM62EDOYiugEd6leH3rbbvySR4Kh/qSfyIQTjpW00UBlk3IYQ45xMVfzn2q4sUW+HYLnf/+pwIxvsfxBAygyV5mZOOOHoznBDAtzoCQsPB0ETE5Js0bhejcaTEFmq8YE++TplMm/DAqo2NqGpJYLUy7RCWMjQoD/r3aURZDnF81W/Zbor8huhxjB3eIraFUnb/+/hUsADqxR34APEgChThxU9eZjMoaopm9yQLvT+qDA3odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQuD2u7kYrWvBeFYSvG9cdWJgKjqakVHzyOzUEHh9Gw=;
 b=fpZ4MtwRy1XhUOK6TjNyb/caiWYPRqkznV7LIlMkcsPDwTWFw1BCh8nxXZqNg+sHNJj9MJ1W+jdkZ103lZj/1r4EwHwFgdTkpO2yHYFj5yA00JBt+z6bk6BcoV3Rfu56AVPJVvLatpnDdgplbbvuFrKq5A4Z1KgvgXJYqiVmAUScInFxaGmZ9kj/GU9RacahY3nVy5Fyy6MoKN0T8FdLbQd+vbLgQ14cJNMh/tTi/3Pz1UFCTD02oksl+r5cqxNnn/YLaL4rwvgTkhfZBikIkn6zIv/umOA+SP3XtZGJZCuJZC5xrQt/EMZcROcNX6lVzeHXOdSen3DABfsJrwSdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQuD2u7kYrWvBeFYSvG9cdWJgKjqakVHzyOzUEHh9Gw=;
 b=KNVfG9yxFKVeZ/GvrqQcfX9Hymxsq8YrlcBvY21JO9/hZ26z5xo/XlcEo1hmvOTZr8o33XQVdP99lgTZ6dsCVLhfPzGsmVr61Wk4hjg3rAYvLctKj/G1ZAWOFuziRf8370DPPdy2vnrDs3TItmAwmui5TQ1JmbqRWiGCc5hl8m4=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 TYZP153MB0642.APCP153.PROD.OUTLOOK.COM (2603:1096:400:258::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.3; Mon, 10 Apr 2023 17:06:36 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::35b1:2595:fb9a:5149]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::35b1:2595:fb9a:5149%4]) with mapi id 15.20.6319.001; Mon, 10 Apr 2023
 17:06:36 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>
Subject: RE: [EXTERNAL] Re: [PATCH v4 2/5] x86/hyperv: Add VTL specific
 structs and hypercalls
Thread-Topic: [EXTERNAL] Re: [PATCH v4 2/5] x86/hyperv: Add VTL specific
 structs and hypercalls
Thread-Index: AQHZaXk5iHqf3Tsri0Sqpg/Edtw0pa8g0hAAgAP29lA=
Date:   Mon, 10 Apr 2023 17:06:35 +0000
Message-ID: <PUZP153MB0749649140E44F374DD89F0EBE959@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1680598864-16981-1-git-send-email-ssengar@linux.microsoft.com>
 <1680598864-16981-3-git-send-email-ssengar@linux.microsoft.com>
 <20230406135113.GB1317@skinsburskii.localdomain>
 <20230408042802.GA14345@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230408042802.GA14345@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=88eb448c-ae17-4179-aa90-7535b3a0913c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-10T17:00:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|TYZP153MB0642:EE_
x-ms-office365-filtering-correlation-id: 12e1b150-2c8c-4360-f282-08db39e5f10b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBUywT05I5cQqfrPz7K2X4RO2v7uTGZ7vu5C0GYf/aPeOzuhWzyXnsFeByc3fR84g4n4lababCBHUS32ctU2cJrTtJvhn0JVVNEbfzjzu3q4W0nBaC4AP1RD26CtCipAr/9z0aa/cHqgUX2jbf4ZdA9BSST/fT4fDMOrD86go9iW66AfhPmxy0DwcYXLguAVfHioLJ+M3aUOgAK/0wwfsuIV+SqvI7YIHURFrMB5ZtWrfET2I88mN/AXymWsPZ+XG4Ik6VZKR148QVpySMLaU5qqVaAGEvJVV7Z9utoOcWrfdWqSdtwwcNFnghY2g3+I0yPlYMbWkLiATxhDoyC/yGSmXgtQwqguV0lRwyUtHW30z/LZnc+kk+p3WQP5sGPuzg/oLwrrRhwlxXq/LoDdUwIaf2Cm1bMPv1rWim3HNLNN8VNk8CVCrXgTHSdsSvPHfieT/BwdZr5plvQOqKFLrtaZUkNRM77H1bWSp+4ZK+kG2bh7C/fNj1hK2qzdu0So/+ZGNj3slObl3DrOQS/fjIZfyGwiLcbrfNUyenFSRLdSgM4Kb/YSPjRvcdR5mDl3HZQZMl26UyAzF4oCdRrKTJalHJQxT2sBR+x84i6Q5q0hLtmzAxpO+A9U3JA+xvVjqF41pll+I2MVAMaonHARGmLv7ONrZjXdVbD4GZ/nwP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(66446008)(4326008)(8676002)(76116006)(64756008)(66476007)(66556008)(66946007)(8936002)(2906002)(7416002)(5660300002)(8990500004)(41300700001)(66899021)(52536014)(54906003)(110136005)(786003)(316002)(83380400001)(478600001)(10290500003)(71200400001)(7696005)(55016003)(6506007)(9686003)(53546011)(186003)(33656002)(82950400001)(82960400001)(122000001)(38100700002)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NlOu+kKX32u0Ald6O67Sg3BtFrbgYzdAFb3O2flNU+vcJZy5tr8s0ksPKbRw?=
 =?us-ascii?Q?aUpfghLcXhtW2LeWYdoK1x2P7fcOeDC52I/lny6GU09ZsIZ+rIxhBm8Q2QAh?=
 =?us-ascii?Q?PdKTtow7FZEHEm66u4dQKk1ZNvoTt++n11TNCjNIzBdZSOJiW9CyaWfSq2fk?=
 =?us-ascii?Q?Yq9kxr8go+oRG4GHYerS93/ybIflloFzIBRRAY4HZZtR9VK6Dv8NsT+OTpZP?=
 =?us-ascii?Q?QGhEYOdG5mGmm4myhPdts0gI3EIzZtHsRqY1rfBz1WVmEuXd3kd8ZyZbykDM?=
 =?us-ascii?Q?IlEXqjxdQYTy73+MKOMS4CwPiqyRVq585dTWMAYvWlvmfOpyKmZv31Yi1dDs?=
 =?us-ascii?Q?D5xV6nx+ZW0pAh7n/jYiQgh5GaZBsnVC9Go6E86IXBx7NOpy1pdUz4S0naC/?=
 =?us-ascii?Q?+EcSpTBzC0OxiR2hgtEVLvbKbKpX9O5auBlEt3sec7w3/VZ15u5YY2mABbNH?=
 =?us-ascii?Q?9KYC/nDjSZqh4IH8jW+W4fsnGD4VK9I/8/hAYvrhj6C0AUyNKPYaQ/Ku2IMJ?=
 =?us-ascii?Q?GxryyVn+TOiYwc6EREZtdT39HM5seb+9i4HaAKgx497cJeqy7IwJtXV9lRdp?=
 =?us-ascii?Q?TwQXu179DQddyLOn0QxzlDq3Lm54QRexx9sPpeo6zIkg1tpsA0IL5R+UOp9U?=
 =?us-ascii?Q?ICzot9z9Z4PXThGiiHh/na4EHa9UnPdfU212zMAgTMp1OgbtNXW33fi2XyaD?=
 =?us-ascii?Q?VD4krf+GTJcsLnGPRFghzaET8A7PW8KXA/cWD1qHawhzDyG/vaOCa4dgi+Rw?=
 =?us-ascii?Q?VgafW/64ssK5bXvbvceIxDfqKo5jVC1NwpKTbXTiW86uOJcagIEAnS1tUQ1T?=
 =?us-ascii?Q?Uw12PqbgQB8vCHbcH7H7WnHagZ3YpAHOm0/TjcBHM1MH0/E+8lA6DF/LmGpI?=
 =?us-ascii?Q?EsR/kyIBsBepMfzHQ3L6HuxX2Hw9nM7/mMNqb70tfEmW3af5OcQNsQOqzMDk?=
 =?us-ascii?Q?/FMkNJ06mwc+gDpPJcNrfEN3F4KqnAypo1HegV/2oVEHjHUOYFfrwoXfpbVH?=
 =?us-ascii?Q?igxWlV6VzMHjmBbe+ajTMEAlIu8bcj33498jDrhodfAVw+mDVPVjF7tGoDvI?=
 =?us-ascii?Q?cQbKt/Riw9L352VZ31YgUa8JbBZY5jyut2Im3OoKu4Kflge1ac3faaLiNlK2?=
 =?us-ascii?Q?IP4BZwaCW8P+0QVncl9ToYuTiseC+UFr8Wf80RYsCs3QHhfXSxVvugDG8l3X?=
 =?us-ascii?Q?Vc5V1QwZ+8orFCe/LgXrX7wyt9FzW8LOUy8H8STlqdOxckOnvElT2/A0/ibw?=
 =?us-ascii?Q?lu1ioix2fQPxbfPz4aGt3VOkBjPQPamax1hIaz0b//HHNK4nV5SnodqjpGaV?=
 =?us-ascii?Q?sYa691f9Mm0ovdDZFxDvqVUGqIF7CNK6vrATOqarO9+IT0xW+4XhQYgyLo8V?=
 =?us-ascii?Q?dEHPtkDIgaSzT3TgRoM3K9iPHU+WAeyfxZwWidbSrt8lpQAnf5xDQYfFXPYr?=
 =?us-ascii?Q?8qkTif6sRQVFbBzwwaNJmlvuj/KEM62azx5kxa8MK6O7w4SAFMTwX3s0gid0?=
 =?us-ascii?Q?zKqjSXwBtke3vm+9jZuzwAT+tfSuIBJIGGGqSOxQhDx0UrqWQCfqUGFVtDcM?=
 =?us-ascii?Q?Moi0aCWyS+nQnpcxaqA0gMAu/9KxJSD4+6SATjbd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e1b150-2c8c-4360-f282-08db39e5f10b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 17:06:35.7152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VH5V6afEv+UxRs0FQpUn0CFH7y+eacNZQlELqbghHA61glEC3dvUGCvSK/GAYuNSvqgxEH/AVxsTWenWkc0eRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0642
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> Sent: Saturday, April 8, 2023 9:58 AM
> To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Cc: tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; KY
> Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; arnd@arndb.de; Tianyu Lan
> <Tianyu.Lan@microsoft.com>; Michael Kelley (LINUX)
> <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; linux-arch@vger.kernel.org; jgross@suse.com;
> mat.jonczyk@o2.pl
> Subject: [EXTERNAL] Re: [PATCH v4 2/5] x86/hyperv: Add VTL specific struc=
ts
> and hypercalls
>=20
> On Thu, Apr 06, 2023 at 06:51:13AM -0700, Stanislav Kinsburskii wrote:
> > On Tue, Apr 04, 2023 at 02:01:01AM -0700, Saurabh Sengar wrote:
> > > Add structs and hypercalls required to enable VTL support on x86.
> > >
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >  arch/x86/include/asm/hyperv-tlfs.h | 75
> > > ++++++++++++++++++++++++++++++  include/asm-generic/hyperv-tlfs.h  |
> > > 4 ++
> > >  2 files changed, 79 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> > > b/arch/x86/include/asm/hyperv-tlfs.h
> > > index 0b73a809e9e1..0b0b4e9a4318 100644
> > > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > > @@ -713,6 +713,81 @@ union hv_msi_entry {
> > >  	} __packed;
> > >  };
> > >
> > > +struct hv_x64_segment_register {
> > > +	__u64 base;
> >
> > Ideally they arch-size types naming should be consistent: either with
> > underscores or without.
> > The majority of cases in this file are without underscores.
>=20
> Although I am fine either way, I think in a non-uapi file "without unders=
core"
> is prefered.
> I can change this in next version.

After reconsidering, I believe it would be wise to consult the "x86 maintai=
ners" regarding this matter.
Hence, I intend to send the next version without this change.

- Saurabh

>=20
> Regards,
> Saurabh
>=20
>=20
> >
> > Reviewed-by: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
> >
> > > +	__u32 limit;
> > > +	__u16 selector;
> > > +	union {
> > > +		struct {
> > > +			__u16 segment_type : 4;
> > > +			__u16 non_system_segment : 1;
> > > +			__u16 descriptor_privilege_level : 2;
> > > +			__u16 present : 1;
> > > +			__u16 reserved : 4;
> > > +			__u16 available : 1;
> > > +			__u16 _long : 1;
> > > +			__u16 _default : 1;
> > > +			__u16 granularity : 1;
> > > +		} __packed;
> > > +		__u16 attributes;
> > > +	};
> > > +} __packed;
> > > +
> > > +struct hv_x64_table_register {
> > > +	__u16 pad[3];
> > > +	__u16 limit;
> > > +	__u64 base;
> > > +} __packed;
> > > +
> > > +struct hv_init_vp_context {
> > > +	u64 rip;
> > > +	u64 rsp;
> > > +	u64 rflags;
> > > +
> > > +	struct hv_x64_segment_register cs;
> > > +	struct hv_x64_segment_register ds;
> > > +	struct hv_x64_segment_register es;
> > > +	struct hv_x64_segment_register fs;
> > > +	struct hv_x64_segment_register gs;
> > > +	struct hv_x64_segment_register ss;
> > > +	struct hv_x64_segment_register tr;
> > > +	struct hv_x64_segment_register ldtr;
> > > +
> > > +	struct hv_x64_table_register idtr;
> > > +	struct hv_x64_table_register gdtr;
> > > +
> > > +	u64 efer;
> > > +	u64 cr0;
> > > +	u64 cr3;
> > > +	u64 cr4;
> > > +	u64 msr_cr_pat;
> > > +} __packed;
> > > +
> > > +union hv_input_vtl {
> > > +	u8 as_uint8;
> > > +	struct {
> > > +		u8 target_vtl: 4;
> > > +		u8 use_target_vtl: 1;
> > > +		u8 reserved_z: 3;
> > > +	};
> > > +} __packed;
> > > +
> > > +struct hv_enable_vp_vtl {
> > > +	u64				partition_id;
> > > +	u32				vp_index;
> > > +	union hv_input_vtl		target_vtl;
> > > +	u8				mbz0;
> > > +	u16				mbz1;
> > > +	struct hv_init_vp_context	vp_context;
> > > +} __packed;
> > > +
> > > +struct hv_get_vp_from_apic_id_in {
> > > +	u64 partition_id;
> > > +	union hv_input_vtl target_vtl;
> > > +	u8 res[7];
> > > +	u32 apic_ids[];
> > > +} __packed;
> > > +
> > >  #include <asm-generic/hyperv-tlfs.h>
> > >
> > >  #endif
> > > diff --git a/include/asm-generic/hyperv-tlfs.h
> > > b/include/asm-generic/hyperv-tlfs.h
> > > index b870983596b9..87258341fd7c 100644
> > > --- a/include/asm-generic/hyperv-tlfs.h
> > > +++ b/include/asm-generic/hyperv-tlfs.h
> > > @@ -146,6 +146,7 @@ union hv_reference_tsc_msr {
> > >  /* Declare the various hypercall operations. */
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> > > +#define HVCALL_ENABLE_VP_VTL			0x000f
> > >  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
> > >  #define HVCALL_SEND_IPI				0x000b
> > >  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
> > > @@ -165,6 +166,8 @@ union hv_reference_tsc_msr {
> > >  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
> > >  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
> > >  #define HVCALL_RETARGET_INTERRUPT		0x007e
> > > +#define HVCALL_START_VP				0x0099
> > > +#define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
> > >  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
> #define
> > > HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0  #define
> > > HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db @@ -
> 218,6
> > > +221,7 @@ enum HV_GENERIC_SET_FORMAT {
> > >  #define HV_STATUS_INVALID_PORT_ID		17
> > >  #define HV_STATUS_INVALID_CONNECTION_ID		18
> > >  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> > > +#define HV_STATUS_VTL_ALREADY_ENABLED		134
> > >
> > >  /*
> > >   * The Hyper-V TimeRefCount register and the TSC
> > > --
> > > 2.34.1
