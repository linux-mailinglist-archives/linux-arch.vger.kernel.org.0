Return-Path: <linux-arch+bounces-1237-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E8821EDB
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 16:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36332835B8
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E901429F;
	Tue,  2 Jan 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="8tM+BWNB"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B000A14F8E;
	Tue,  2 Jan 2024 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRbZAP4LvG31AyAa641Y7FySr4cBExbmDi+0xc3r8XmkHgwID5wu4Ah8u0sqTkUktFsL8vdd0w+8gEkAcZKhB63VVfuG1Kz1M96raOVUG/mP2nVV6ASMyjNXnltsQkxMk2TYJxkZbMlX3S+UwsJmeh5B2IvmLjAvvhkpY5QqvwBEOyyOZXu6UxPZjPpssBqJdYQ+0W7FMoNtnqT6laARkWsxxAEHcgA8WMu45NCRzobOCb0eToFfNDRt8UcAzGLNcuzvhlo9qcXcjbBHcvQdHypmlO3Hrfi+M0YppTVicj38C/BXs+3m9Y3KNwnCqZBncn6gx8mxygKlm4QVrUYVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTsLPkbv9z/wYa8O8XfJu9pNRv7tCoY2QfKeD8uKea8=;
 b=Gc2iJJluUV8lfrT9VqmC5W++u636srZmydvy5F11YzilU92FEIHzhD6djDZcL9V4W6C9gmpFfN7U+gkOLixkHu/nhz30zh/3oJmQgVCTZSl3SZucjEdp8KuJ36OZD1Rt5Tvto8znkOZYcAjdhJCpZxwSLxVNuKKHQUIiOUXFWvCO20itz2jWOVtiLoxmwLp1BGauDReFqS+aul8UqgMrVn/YS3x5phGiPNH7PGCLZ13uvoCp3zsR1wAhmSfDQOc/UlHn38fZZushJgTa4L8VAwffdZA0lQTzMmHrlJf77E8n9s/CRlVLb5VU96r4PeDPflr7ff3JZdsYGjYfhjOTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTsLPkbv9z/wYa8O8XfJu9pNRv7tCoY2QfKeD8uKea8=;
 b=8tM+BWNBqYgzFaETTjY7sxWNc8cGAEZ6DBei7GDP+pf4r2E+YfYjAJyvLOO8mQyANoVRG/ObCz+Fct0TEVusDD4aZMQeOIyGSaQEX+PJg7e5tCkWA7kFLZLXHmxBiC0DIYvBeIHOlZIwuj6S/n26IEOKVP7MZYEwiUIxQqD3TNA=
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com (2603:10a6:10:205::9)
 by PA4PR08MB5997.eurprd08.prod.outlook.com (2603:10a6:102:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 15:35:45 +0000
Received: from DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::1827:6361:a3a3:5831]) by DBBPR08MB6012.eurprd08.prod.outlook.com
 ([fe80::1827:6361:a3a3:5831%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 15:35:45 +0000
From: Jose Marinho <Jose.Marinho@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"acpica-devel@lists.linuxfoundation.org"
	<acpica-devel@lists.linuxfoundation.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-ia64@vger.kernel.org"
	<linux-ia64@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jianyong Wu
	<Jianyong.Wu@arm.com>, Justin He <Justin.He@arm.com>, James Morse
	<James.Morse@arm.com>, Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
	nd <nd@arm.com>, Kangkang Shen <kangkang.shen@futurewei.com>
Subject: RE: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS support
 for toggling CPU present/enabled
Thread-Topic: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS support
 for toggling CPU present/enabled
Thread-Index: AQHaL3ntNyOGqVAnrU+84Ux6biaSarDGiPtQgAA1fgCAAANiwA==
Date: Tue, 2 Jan 2024 15:35:45 +0000
Message-ID:
 <DBBPR08MB601227202A0F32F448952FDA8861A@DBBPR08MB6012.eurprd08.prod.outlook.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOhS-00Dvla-7i@rmk-PC.armlinux.org.uk>
	<20231215171227.00006550@Huawei.com>
	<DBBPR08MB60121770239F324D877847E18861A@DBBPR08MB6012.eurprd08.prod.outlook.com>
 <20240102151652.00001b3c@Huawei.com>
In-Reply-To: <20240102151652.00001b3c@Huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ts-tracking-id: F554F66CD6CA75458BFBA6F01A6446AB.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR08MB6012:EE_|PA4PR08MB5997:EE_
x-ms-office365-filtering-correlation-id: 38521add-9a58-46e0-d66e-08dc0ba87c87
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gzhl+96Gu0GOAL9TN5zr95QinwNwK47xlI06V2vy9AU1WskLJsYGvF2Px497umC1pzwqN7jkRR35S4QHN55mmrG8go3WAaWXOwNNM/W+SHeqfvp3vBunW9p7MfPDRUxcS+1vcE0WoeJlrjufUaV5IsIaLAi/inTTX+RQfIREVYVsg6HjMaMSV1EEV1ayxn2mVB4ygdfsKmrwOAttQuL4/gP34AY+IpqmOabCdFzBFGk3TAAk9WdB0MhLOmyuoj1meImsfvzWXTZG4MwMI1yYruyHlVGs+rZm5gH+M0Jx+lE1XOQrR1Xykf1FAZdG0BAoelmCmN/vy0SRB40WwEBl0M0cD2z515dGJgIlFs4+/HvG8PEvBO0ToxSKrObiXD7Hms77BBhUbQN3l8iS2V3XQMbL76sof1LnpJjBwkfkI4okBXo8682h+3Vo/vWme9gkLGjlq26P3QpQHb2C/EGgBMaZkw2ua1V4DqTpOpSc5jzQyez8K2rah5msamYjws/upc1tTye3U6Xr3VZbDWeg9t5iZN9Dw95iX2pbLva76nvVD9zbunjKUcXpnic87Ovl4FGL7sEkrpP8Pom0ycMGhb74aOYAR5Cw6lxQzJLhoahOlLn0onFilhDRRUPPe7NIxX35BrLfy6HBngX+134afQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB6012.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(33656002)(53546011)(9686003)(66556008)(66946007)(66476007)(76116006)(7696005)(64756008)(6916009)(6506007)(66446008)(38070700009)(86362001)(38100700002)(122000001)(83380400001)(26005)(7416002)(2906002)(71200400001)(4326008)(478600001)(966005)(30864003)(52536014)(41300700001)(8936002)(5660300002)(316002)(54906003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uDZb89RY1IVDQOtFI96ZyzGQbNvdo2I55Rku1+M6nxIHdAFY+EuSnDGGMfZG?=
 =?us-ascii?Q?jSV3RC322Ue99T/rFe4XjlLDxRCFFasR9NhJIzl/eJcoHcrv0bU2+oyhvEcF?=
 =?us-ascii?Q?8Jq94SZd54MowedrAMtZM+rikiKdMkav9JFch9VxDmv5grDwjqPmWpEoa4fz?=
 =?us-ascii?Q?fiNbvvfVzSGQkPkbteqfnDlNRjvVSwf6puDTNONBtp1gQrm6aqff2QTWiU0G?=
 =?us-ascii?Q?iPWEIaZHoC8F9uzMCa3BvjnhcmlQMVgJM/vcFaaAAdLJXEG1hHhkSywCfKnF?=
 =?us-ascii?Q?RahxFVh9iLKRlXNmG7789wbO3lUjiOHWqUSlv9LuiopaITewolf3quXM3xDn?=
 =?us-ascii?Q?GjIc5E+y1NbDVTVyxiT92e3pDqcyFs9zAjpmC88RsD96kg6FfoUHM+tbLt5T?=
 =?us-ascii?Q?8WHXbVFXxa8ouMWo8+vsO2etQ3ytWA9mmw2yaK50N/cb9jOW7F/TZSvt0/1a?=
 =?us-ascii?Q?7OD+QcDm9QTFht+ldf1tQ9bh0autgd4XK1XdnDtPLqmtPldKSeiAXgN02HCq?=
 =?us-ascii?Q?OJ+ka6JNQnvyuVl0Kw6SPpQ468jCxBnE3knZlZaFlJSWO/i+txO0xSu64v6j?=
 =?us-ascii?Q?uU0JprgUz6pgwyWtaj2SATsar2Zm1f7ZBzIa+AVjVbYu5FrcMyFt7n5g1zb5?=
 =?us-ascii?Q?baJuuPnlb6uDyOP06KW0MZZ/KmnE3JnWVlaeRt3ITMMAO6nHdaj+VQGi3esN?=
 =?us-ascii?Q?oKdHr2IanByl8V5tGXoT8eOQf8vA3esnwmITR35HdtUAZyiaAmAzCOz+Tfws?=
 =?us-ascii?Q?mSeQgnNdK3TVNhI2IVOa/VH5m4WlzeRgJJXThf8+z2pRdvbSAlMgxPxE3R0r?=
 =?us-ascii?Q?iADefNHwKcZO5Zyznc5/WTfZsOaUur9cJGOoCtPcFqpssW06x5EGGxzk2QIq?=
 =?us-ascii?Q?2DliaPKBKNfwmipcPcKklQGyDXkoB71GMsOx0RNdAjTkKrs8HemK9UnwNrPd?=
 =?us-ascii?Q?HnVkrYx1bVkI9OCH/pKXyJJc3brz7C3zyJ2/d+JbgwnigMv0ErUqFmkOcCQ/?=
 =?us-ascii?Q?pjT9k6Xn/9MCEkHpGchdj31M0frkLxcrBsQOCl2r6waiYr6Sn3StXfzcDo5h?=
 =?us-ascii?Q?KM2tCEL3qLYx6eZzjTkeqG+yIVg6r7azrAXvZ202/VvmgfFBpPusAoEplv68?=
 =?us-ascii?Q?L99YiJFTvdaou5fMb3ByYEJWiWO9+uEmOJLaxsozytvfz7UMCjudDK/tApXr?=
 =?us-ascii?Q?X9qTdIC1IBJcI5LmjEhjbdD3q6dnEdV5eaHSGML8dQxcwxX8WfuZ8HOR65GE?=
 =?us-ascii?Q?zZQZHB7/g38GI0z+uTfhmeEhUGQuokWp/MQ3s2Y32Wg0qXE+5/WecmLwFvZT?=
 =?us-ascii?Q?XVh52QRXkhY6MW083uWpPlKmxFG5/No9Q94jEM2KvZA3DZGMLakbc8S6nSUj?=
 =?us-ascii?Q?EJwI1NVaDDiIefsT/WeMT2RRz5hcZsD9rBTLa2uNpGFRORGejlHWrOR3+JGI?=
 =?us-ascii?Q?cx/ndP5ZLe5AzdMEY4pyw5RXIFEX/gAQF45FNDwf1Hh+dl7vlsv76d/3kK1u?=
 =?us-ascii?Q?Xl/AwERO61FXFdkbgVSB3Kg5yGC0mtxipxONV/EONU67ZS78gNk6P06lm5xq?=
 =?us-ascii?Q?mc7fda8FEcNvcaP8Wt8HcyCnicwufwpVmco9fQ4i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB6012.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38521add-9a58-46e0-d66e-08dc0ba87c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 15:35:45.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ALmLDN9AAZssFwj7K7UPnRgn9TbABqY651hC5UU7q23funi48smoq8FmjpyF1+Or1eSX5l4BT9LY9FbdWLyl0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5997



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Tuesday, January 2, 2024 3:17 PM
> To: Jose Marinho <Jose.Marinho@arm.com>
> Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>; linux-
> pm@vger.kernel.org; loongarch@lists.linux.dev; linux-acpi@vger.kernel.org=
;
> linux-arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-riscv@lists.infradead.org;
> kvmarm@lists.linux.dev; x86@kernel.org; acpica-
> devel@lists.linuxfoundation.org; linux-csky@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-ia64@vger.kernel.org; linux-parisc@vger.kernel=
.org;
> Salil Mehta <salil.mehta@huawei.com>; Jean-Philippe Brucker <jean-
> philippe@linaro.org>; Jianyong Wu <Jianyong.Wu@arm.com>; Justin He
> <Justin.He@arm.com>; James Morse <James.Morse@arm.com>; Samer El-Haj-
> Mahmoud <Samer.El-Haj-Mahmoud@arm.com>; nd <nd@arm.com>; Kangkang
> Shen <kangkang.shen@futurewei.com>
> Subject: Re: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise OS sup=
port
> for toggling CPU present/enabled
>=20
> On Tue, 2 Jan 2024 13:07:25 +0000
> Jose Marinho <Jose.Marinho@arm.com> wrote:
>=20
> > Hi Jonathan,
> >
> > > -----Original Message-----
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Friday, December 15, 2023 5:12 PM
> > > To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Cc: linux-pm@vger.kernel.org; loongarch@lists.linux.dev; linux-
> > > acpi@vger.kernel.org; linux-arch@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > > riscv@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org;
> > > acpica- devel@lists.linuxfoundation.org; linux-csky@vger.kernel.org;
> > > linux- doc@vger.kernel.org; linux-ia64@vger.kernel.org; linux-
> > > parisc@vger.kernel.org; Salil Mehta <salil.mehta@huawei.com>;
> > > Jean-Philippe Brucker <jean-philippe@linaro.org>; Jianyong Wu
> > > <Jianyong.Wu@arm.com>; Justin He <Justin.He@arm.com>; James Morse
> > > <James.Morse@arm.com>; Jose Marinho <Jose.Marinho@arm.com>; Samer
> > > El-Haj-Mahmoud <Samer.El- Haj-Mahmoud@arm.com>
> > > Subject: Re: [PATCH RFC v3 20/21] ACPI: Add _OSC bits to advertise
> > > OS support for toggling CPU present/enabled
> > >
> > > On Wed, 13 Dec 2023 12:50:54 +0000
> > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > Platform firmware can disabled a CPU, or make it not-present by
> > > > making an eject-request notification, then waiting for the os to
> > > > make it offline
> > > OS
> > >
> > > > and call _EJx. After the firmware updates _STA with the new status.
> > > >
> > > > Not all operating systems support this. For arm64 making CPUs
> > > > not-present has never been supported. For all ACPI architectures,
> > > > making CPUs disabled has recently been added. Firmware can't know
> > > > what
> > > the OS has support for.
> > > >
> > > > Add two new _OSC bits to advertise whether the OS supports the
> > > > _STA enabled or present bits being toggled for CPUs. This will be
> > > > important for arm64 if systems that support physical CPU hotplug
> > > > ever appear as
> > > > arm64 linux doesn't currently support this, so firmware shouldn't t=
ry.
> > > >
> > > > Advertising this support to firmware is useful for cloud
> > > > orchestrators to know whether they can scale a particular VM by add=
ing
> CPUs.
> > > >
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > >
> > > I'm very much in favor of this _OSC but it hasn't been accepted yet I=
 think...
> > > https://bugzilla.tianocore.org/show_bug.cgi?id=3D4481
> > >
> > > Jose? Github suggests you are the proposer on this.
> >
> > The addition of these _OSC bits was proposed by us on the forum in ques=
tion.
> > The forum opted to pause the definition until additional practical info=
rmation
> could be provided on the use-cases.
> >
> > If anyone is interested in progressing the _OSC bit definition, you are=
 invited to
> express that interest in the Bugzilla ticket.
>=20
> I've poked around a bit and can't find any reference to how to actually g=
et a
> bugzilla account bugzilla.tianocore.org. Any pointers?  I'm sure I had on=
e at one
> stage, but trying every plausible email address and the forgotten passwor=
d link
> got me nowhere.
>=20

The procedure to get a new account is described here: https://github.com/ti=
anocore/tianocore.github.io/wiki/Reporting-Issues
The immediate next steps are:
- Join https://edk2.groups.io/g/devel, and subscribe edk2 | devel group.
- Send the email with the detail reason to Bugzilla Admin (gaoliming@byosof=
t.com.cn) , this email address will be created as Bugzilla account.

> > Information that you should provide to increase the chances of the tick=
et being
> reopened:
> > - use-case for the new _OSC bits,
>=20
> Really annoying without it as a hypervisor can't query if a guest can do =
anything
> useful if the host does virtual CPU hotplug via this newly added route.
> Given this is new functionality and there is non trivial effort required =
by the host
> to instantiate such a CPU it would be nice to be able to find out if the =
feature is
> supported by the Guest OS without having to basically suck it an see with
> hypervisors having to do a trial hotplug just to see if it 'might' work.
>=20
> > - what breaks (if anything) without the proposed _OSC bits.
>=20
> Nothing breaks - you can merrily poke in hotplugged CPUs with the attenda=
nt
> creation of resources in the host and have them disappear into a black ho=
le.
> That's ugly but not broken as such. Hopefully a hypervisor will not keep =
trying
> until the first attempt either succeeds or fails.
>=20
> >
> > We did receive additional comments:
> > - the proposed _OSC bits are not generic: the bits simply convey whethe=
r the
> guest OS understands CPU hot-plug, but it says nothing about the number o=
f CPUs
> that the OS supports.
>=20
> If a guest says it supports this feature, you would hope it supports it f=
or the
> number of CPUs that have the present bit set but the enabled not.
> I'd clarify that in the text rather than provide a means of querying the =
number of
> CPUs supported.
> Number wouldn't be sufficient anyway as it wouldn't indicate 'which' CPUs=
 are
> supported.
> Nothing says they have to be contiguous or lowest IDs etc.
>=20
> > - There could be alternate schemes that do not rely on spec changes. E.=
g. there
> could be a hypervisor IMPDEF mechanism to describe if an OS image support=
s
> CPU hot-plug.
>=20
> Sigh. Yes, that could be done at the cost of every guest having to be mad=
e aware
> of every hypervisor impdef mechanism.  Trying to avoid that mess is why I=
 think
> an _OSC makes sense as then everyone can use the same control.
>=20
> No particular reason we should use ACPI at all for VMs :)
>=20
> >
> > >
> > > btw v4 looks ok but v5 in the tianocore github seems to have lost
> > > the actual OSC part.
> >
> > Agree that, if we do progress with this spec change, v4 is the correct =
formulation
> we should adopt.
> >
> Thanks for the update.
>=20
> Overall this is a question we need to resolve soon.  If this code otherwi=
se goes in
> linux without the OSC we will always need to support the 'suck it and see=
'
> approach as we'll never know if the guest fell down the hole. Thus if not=
 added
> soon we might as well not add it at all and we'll all be looking at the c=
ode and
> thinking "that's ugly and shouldn't have been necessary" for years to com=
e.
>=20
> +CC Kangkang as he might be able to help get this started again.

We're keen to support the progress of this ECR.

Regards,
Jose

>=20
> Jonathan
>=20
> > Regards,
> > Jose
> >
> > >
> > > Jonathan
> > >
> > > > ---
> > > > I'm assuming Loongarch machines do not support physical CPU hotplug=
.
> > > >
> > > > Changes since RFC v3:
> > > >  * Drop ia64 changes
> > > >  * Update James' comment below "---" to remove reference to ia64
> > > >
> > > > Outstanding comment:
> > > >  https://lore.kernel.org/r/20230914175021.000018fd@Huawei.com
> > >
> > >
> > >
> > > > ---
> > > >  arch/x86/Kconfig              |  1 +
> > > >  drivers/acpi/Kconfig          |  9 +++++++++
> > > >  drivers/acpi/acpi_processor.c | 14 +++++++++++++-
> > > >  drivers/acpi/bus.c            | 16 ++++++++++++++++
> > > >  include/linux/acpi.h          |  4 ++++
> > > >  5 files changed, 43 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > > > 64fc7c475ab0..33fc4dcd950c 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -60,6 +60,7 @@ config X86
> > > >  	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
> > > >  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> > > >  	select ACPI_HOTPLUG_PRESENT_CPU		if ACPI_PROCESSOR
> > > && HOTPLUG_CPU
> > > > +	select ACPI_HOTPLUG_IGNORE_OSC		if ACPI &&
> > > HOTPLUG_CPU
> > > >  	select ARCH_32BIT_OFF_T			if X86_32
> > > >  	select ARCH_CLOCKSOURCE_INIT
> > > >  	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig index
> > > > 9c5a43d0aff4..020e7c0ab985 100644
> > > > --- a/drivers/acpi/Kconfig
> > > > +++ b/drivers/acpi/Kconfig
> > > > @@ -311,6 +311,15 @@ config ACPI_HOTPLUG_PRESENT_CPU
> > > >  	depends on ACPI_PROCESSOR && HOTPLUG_CPU
> > > >  	select ACPI_CONTAINER
> > > >
> > > > +config ACPI_HOTPLUG_IGNORE_OSC
> > > > +	bool
> > > > +	depends on ACPI_HOTPLUG_PRESENT_CPU
> > > > +	help
> > > > +	  Ignore whether firmware acknowledged support for toggling the C=
PU
> > > > +	  present bit in _STA. Some architectures predate the _OSC bits, =
so
> > > > +	  firmware doesn't know to do this.
> > > > +
> > > > +
> > > >  config ACPI_PROCESSOR_AGGREGATOR
> > > >  	tristate "Processor Aggregator"
> > > >  	depends on ACPI_PROCESSOR
> > > > diff --git a/drivers/acpi/acpi_processor.c
> > > > b/drivers/acpi/acpi_processor.c index ea12e70dfd39..5bb207a7a1dd
> > > > 100644
> > > > --- a/drivers/acpi/acpi_processor.c
> > > > +++ b/drivers/acpi/acpi_processor.c
> > > > @@ -182,6 +182,18 @@ static void __init
> > > > acpi_pcc_cpufreq_init(void) static void __init
> > > > acpi_pcc_cpufreq_init(void) {}  #endif /*
> > > > CONFIG_X86 */
> > > >
> > > > +static bool acpi_processor_hotplug_present_supported(void)
> > > > +{
> > > > +	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> > > > +		return false;
> > > > +
> > > > +	/* x86 systems pre-date the _OSC bit */
> > > > +	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_IGNORE_OSC))
> > > > +		return true;
> > > > +
> > > > +	return osc_sb_hotplug_present_support_acked;
> > > > +}
> > > > +
> > > >  /* Initialization */
> > > >  static int acpi_processor_make_present(struct acpi_processor *pr)
> > > > { @@ -189,7 +201,7 @@ static int
> > > > acpi_processor_make_present(struct
> > > acpi_processor *pr)
> > > >  	acpi_status status;
> > > >  	int ret;
> > > >
> > > > -	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU)) {
> > > > +	if (!acpi_processor_hotplug_present_supported()) {
> > > >  		pr_err_once("Changing CPU present bit is not supported\n");
> > > >  		return -ENODEV;
> > > >  	}
> > > > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c index
> > > > 72e64c0718c9..7122450739d6 100644
> > > > --- a/drivers/acpi/bus.c
> > > > +++ b/drivers/acpi/bus.c
> > > > @@ -298,6 +298,13 @@
> > > > EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
> > > >
> > > >  bool osc_sb_cppc2_support_acked;
> > > >
> > > > +/*
> > > > + * ACPI 6.? Proposed Operating System Capabilities for modifying
> > > > +CPU
> > > > + * present/enable.
> > > > + */
> > > > +bool osc_sb_hotplug_enabled_support_acked;
> > > > +bool osc_sb_hotplug_present_support_acked;
> > > > +
> > > >  static u8 sb_uuid_str[] =3D "0811B06E-4A27-44F9-8D60-3CBBC22E7B48"=
;
> > > >  static void acpi_bus_osc_negotiate_platform_control(void)
> > > >  {
> > > > @@ -346,6 +353,11 @@ static void
> > > > acpi_bus_osc_negotiate_platform_control(void)
> > > >
> > > >  	if (!ghes_disable)
> > > >  		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_APEI_SUPPORT;
> > > > +
> > > > +	capbuf[OSC_SUPPORT_DWORD] |=3D
> > > OSC_SB_HOTPLUG_ENABLED_SUPPORT;
> > > > +	if (IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
> > > > +		capbuf[OSC_SUPPORT_DWORD] |=3D
> > > OSC_SB_HOTPLUG_PRESENT_SUPPORT;
> > > > +
> > > >  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
> > > >  		return;
> > > >
> > > > @@ -383,6 +395,10 @@ static void
> > > acpi_bus_osc_negotiate_platform_control(void)
> > > >  			capbuf_ret[OSC_SUPPORT_DWORD] &
> > > OSC_SB_NATIVE_USB4_SUPPORT;
> > > >  		osc_cpc_flexible_adr_space_confirmed =3D
> > > >  			capbuf_ret[OSC_SUPPORT_DWORD] &
> > > OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
> > > > +		osc_sb_hotplug_enabled_support_acked =3D
> > > > +			capbuf_ret[OSC_SUPPORT_DWORD] &
> > > OSC_SB_HOTPLUG_ENABLED_SUPPORT;
> > > > +		osc_sb_hotplug_present_support_acked =3D
> > > > +			capbuf_ret[OSC_SUPPORT_DWORD] &
> > > OSC_SB_HOTPLUG_PRESENT_SUPPORT;
> > > >  	}
> > > >
> > > >  	kfree(context.ret.pointer);
> > > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h index
> > > > 00be66683505..c572abac803c 100644
> > > > --- a/include/linux/acpi.h
> > > > +++ b/include/linux/acpi.h
> > > > @@ -559,12 +559,16 @@ acpi_status acpi_run_osc(acpi_handle handle,
> > > struct acpi_osc_context *context);
> > > >  #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
> > > >  #define OSC_SB_PRM_SUPPORT			0x00200000
> > > >  #define OSC_SB_FFH_OPR_SUPPORT			0x00400000
> > > > +#define OSC_SB_HOTPLUG_ENABLED_SUPPORT		0x00800000
> > > > +#define OSC_SB_HOTPLUG_PRESENT_SUPPORT		0x01000000
> > > >
> > > >  extern bool osc_sb_apei_support_acked;  extern bool
> > > > osc_pc_lpi_support_confirmed;  extern bool
> > > > osc_sb_native_usb4_support_confirmed;
> > > >  extern bool osc_sb_cppc2_support_acked;  extern bool
> > > > osc_cpc_flexible_adr_space_confirmed;
> > > > +extern bool osc_sb_hotplug_enabled_support_acked;
> > > > +extern bool osc_sb_hotplug_present_support_acked;
> > > >
> > > >  /* USB4 Capabilities */
> > > >  #define OSC_USB_USB3_TUNNELING			0x00000001
> >


