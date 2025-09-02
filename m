Return-Path: <linux-arch+bounces-13357-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCEB40761
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 16:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B231888A0E
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 14:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9168322A22;
	Tue,  2 Sep 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qV0Q6Oe0"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2061.outbound.protection.outlook.com [40.92.18.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DF3176EE;
	Tue,  2 Sep 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824172; cv=fail; b=aosVVNJPlbiYr6cgQNilBpeMfjX2+njbdiCRTBT7GRaQmEMyfT2rbb7UYYkV3LZjPAB1E1gbkPbOKR50K/15KoGpAst7Ufdfmx4867D3/PeIAr6zkn1lyzz7s7uGiZHVMa7ATuUPeeA10YU/v9BdRkTIOyF5UrnnIpv3hO+9hu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824172; c=relaxed/simple;
	bh=D6FZAVAARRR/WBnjmv552n93wtoorGbmHPkrNGRihRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qq4C50x9F4ZMTwHSUgdhy4zjoDUh0N1s9xZa1uq3g4mfOF/X43zJo01rRrRIJEWVwSDiCi5tO5ZBVVfwJ8yR4P+veHVCaTPr6UPID4rR15UKPaY7xN59NHT5665J8d/PRA+Y8XDm+iG+6EjxhG46cnt31fStGuWsrI/EakAJ3pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qV0Q6Oe0; arc=fail smtp.client-ip=40.92.18.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttIU5zedVGHgS/uutqu3HmXhvMMO9hubucRX6HZ3avjR3b1uTk4X7e7VCW+rDe/ZUo8MQjC278z3PzkPYs7TYgOjYYYfeRjDTsld/4hVCPLorHLoL+aB4d8hymLkiXfDYdc1j1ZYXKxpP7JgaiD+wbfzCJTcyN2NN2ofHl3pn8v8zZnZbnMQ3zSb6wOthUuVLMDVwszFl76zkfJKBIFB1C+yIZKNb1Tqu7T+3dD3jSxXB9D/FfmOvi5SbGGBWwa2MvfwmTGpRiCqJIdP4cP3sdQsLqCf1tZstc8TH26/tOaKMEGxDWoeRx1Y/yArvfbiXdnlUqmp+MOj5UNP51e7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQsDNJPlXThQEz26jPN0ULPX1o7Qi3jewlKvuNTDevc=;
 b=Gev7l6WMNNxbJJLfMaIx9BsTts/eTlFd9YdNUHUEigILquWKbh6U6WYhAdjaKTINOUCY4MoJGSW/aklVMQkta3d3mq8WCVf8ZrB+jfKK+sI3+ZP5rt4huHiKEYA7YFq/GGqo6UQ2We/RSyAee1yJe/8QQIfGmZ/avUQJT3F/AjJMic1VaglOqZ94JtYyH0l+y2QS2WJS2Cx96uD9Q66DKFtJ2NpqKtv4cmilcw5fsmQoP5/eCchLZb0wi5jav3IBR1h1z9cdpvTwfr03rtRNpiaqO7o2j9D+TiKCTXdw6xZKfeJCKu1D9J4nqGKmHEF2izlOWcHWnWWH9Q4tR2zRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQsDNJPlXThQEz26jPN0ULPX1o7Qi3jewlKvuNTDevc=;
 b=qV0Q6Oe0OoW7N+u9Bu2YqxqMTbp2YXCDLYXrmqinPNvh3JAzAe2aYiwZxJeMHEywQQqbW6mVxVfQp6gjKEeDFW42vR8aZRbShoNidPCiBRAtVzY/1tHyzEkG086d/dwZE8jbwgG8LmtOsm43jZcVM+LhAnEBNsxvvY0CTL6CHE+H4B4LznEkgUN5GRN5tssXzQw8WyO+hjLrz0Tx/hQxTyULkr/3uc6tWKm1vDLlgj/2Zf7xjgNiF5aqq1coMX/0HNKqEvwg5yHmgilwygbMsXdcxnHFLMpzCIrHp9fIqNwu40afFEVEne9QNnsinzconnWtam9BwNQ9ns2EizvBGQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 14:42:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 14:42:47 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh Rathor <mrathor@linux.microsoft.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "deller@gmx.de" <deller@gmx.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH V0 2/2] hyper-v: Make CONFIG_HYPERV bool
Thread-Topic: [PATCH V0 2/2] hyper-v: Make CONFIG_HYPERV bool
Thread-Index: AQHcF7dMSD3n9gCD/UmZR8RHFTAe5LR7WjWQ
Date: Tue, 2 Sep 2025 14:42:47 +0000
Message-ID:
 <SN6PR02MB4157381DA21132544B3A41B7D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
 <20250828005952.884343-3-mrathor@linux.microsoft.com>
In-Reply-To: <20250828005952.884343-3-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10054:EE_
x-ms-office365-filtering-correlation-id: 8e4dccd8-fe9f-408e-d454-08ddea2efbff
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNsJbj7NxvUrpSYkT7K1zyUQnJlg6q1yvcbChD15tsTbyDrPS6VOsBqO1CmsdcERwTEzRc6CPoyVlt8x55KKzqSHPQe4XhFVaiYhKL634D0IFHI6Ax9bVYmUPvNgSb2cbTMEdgwPO1Q3oiYiKZhUC/KSo+g+UShRq+FR9U3MeZ+shPVgeL/M0JqiW5CLtjy3ejkrd1fN7loxt+34/vPQsl/OO5KsEoKVgA+5pXnvPYRWBn4l/B81k4WlqXMNqdcq3bfZeX86otyW8OAUPWWxMstg9erOCvcTTuWbpiinK8USAE/xfGGubkVp8yG8NiVT+2m+GY3kRDuqgIubtZqpjZ3yH5ykKFVj0yhYvKOkmAwWCYq9NsykWJdhzG8EKQBE6X1B8t1dNn/bnl9gAKnwh6KN6r0ct+IzuiOCpdRho3Scg6fbuahF1nkACOBvT55wUAohY9je+xgHzN4GR7ZFqxgfpPLdJMf6W5b+svX30jyE1VGxNIaUQ+Yh5+YYKPHMZ8pbB1C+r1Dw9e9H5DgI+qTJh/1YiZCnOBuWFbqCsczrsn7DbgGFdw+ODB0bXSQUxLfLz7I8U7C2DNyWHtPzOJNDScp8EI3YY0pMMhZtl7EFQ/rJYXBXhGsI5YvysdbTstwqs5WXODOG+XrcPeA2hBOifG467SEtXWlodaR2q9d3YrBsKmBsIBDuM0atjmVGAZC8E+dwuEx90M3O02fcAe6Lz30lO4htYAIB7Do2ekEbJ1d3Ug71ba29u5FGgOspAc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|19110799012|15080799012|13091999003|461199028|31061999003|440099028|40105399003|3412199025|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QqDq+5QWys6v77z5xt9gcxqiYzqnORJsGL3v5WWufcxN5mqk5lpwB+/UNXiD?=
 =?us-ascii?Q?CGqptBzqPR/j8rSbdsOdNUJ6g3yjiI7Qc19Jx9ESAclUgCZ5YeBjxJzN1tbZ?=
 =?us-ascii?Q?unaQMfWagbL49VlKyzAl+EQ3Ng95qyEHCWOgWNQ18mSCXOADmb+EPMdw+e2U?=
 =?us-ascii?Q?yuePmTqKhVMmSWgBz5mUz8XGkvEPvx51mfgd6qVXGL7nQtXgcbAiWH7NXWO6?=
 =?us-ascii?Q?wnNtwC1cJHRBfNV/YLPPiw8qhriaX9XuP5+PmsOxc4ub6fvtK+lg8SF8dUUs?=
 =?us-ascii?Q?aZp/vL8kMTew8t5lsQn7EoIjOBcBR1lLz6KeKIQEEfP4aC+CjHnJDmrIR53E?=
 =?us-ascii?Q?fV8M+tDI0elNdjR0Z5YETXocoXI8JLGuAuB3PXhf8M41cQxVK0dMNWMKpT5Z?=
 =?us-ascii?Q?SSp4X8r6iizp2fe1VMWaoin5DTPX3NjnfS/rO6MXrDwBSoVKzwKT/GupW8XV?=
 =?us-ascii?Q?MVKADsAXDGpT86CneadvK/tdC5+IjY1N6UipAilvIvWBhsY4yYldrjtgNm2X?=
 =?us-ascii?Q?epDBDrO2wx1aARvgqYPOCYM3Udx8+cS/LOi75uewTRuzlmruZgkcltyXpbzj?=
 =?us-ascii?Q?pKWa/Cl0s13ytiriA9Y3aB8vwBJRL5VIdMgNrsjwAeBfhKFJ/pPP/BrDjGgU?=
 =?us-ascii?Q?G4uYzlkcp2Wvf/M36sHzGgyFdotWdQAjiO1DKU7N700mZAuwGCYRGQ2VqD/9?=
 =?us-ascii?Q?z2VoBI/OeTAXAuVsTMQj4plzThAK8Vi6+XdlyoOxJDh9SDhS3i135N+Dh3Ec?=
 =?us-ascii?Q?DDTUxJylhAvfqkJyAVIs0KNJ155xaNtyQsWlK2mdQTDdc9ta0hRn2jfqvFtP?=
 =?us-ascii?Q?MbYxuJZEMmeKe5SvAzFwWQZxlGy4KoA9H4dJ7++3stYJXDzgI481goMGoR8L?=
 =?us-ascii?Q?2H2yxodPXDFAaU5ti0z0uctYrLgHVrvXXByHQrr8Ajfwtp1/DJwqAgoy7/Wv?=
 =?us-ascii?Q?Qz1+T+0izNqgckDYnuZqYq7yN/zuKBtfAZ9UbwF5aTH9RArrtk04s4X6wKpO?=
 =?us-ascii?Q?mpvZP30sANWIgUQZf5MD8wEb3PqO3iRzxvvNIvw/SNOBJN+v+PpGAyekPTqT?=
 =?us-ascii?Q?E+cbWjYtC9uqgKE+nNDRgzz11CkQdhaxjVWuS6glSJbXPGqcGlz65+HUklyu?=
 =?us-ascii?Q?9+H1XlwewwoIAkhRslC8atw+1v0Cl6/QTWPHSrHVNFo369qGnaCD3euwHHDq?=
 =?us-ascii?Q?B/1UkflBNgc9Wx8XBdtxOAqmJuhjRy/dCEdeAQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S0ZCeqyBDyViJxRMGW2XfbKiNni+bUmGiz9ADcAkR1g5MwuqVMp7BgF3StLp?=
 =?us-ascii?Q?sJw+XV12shSWCFHYUN4d9kLemq0588Moh5wqK5jR0//84Uvp4QQRw7Tca2NQ?=
 =?us-ascii?Q?JwqnRqIlDNRB13vIfFdvdZTaAFbjSC33BbqJn+VHM3dCoGPMYagcZL2ZuFlR?=
 =?us-ascii?Q?+oV0vinbuvYDx0DXUdzjMJIq65+quq+kijMXQ/KGdH4U09q1zo4d8K64wheC?=
 =?us-ascii?Q?o0c15SGG6u24FiodwcG5sThg02eKTMIckXAAg8n53JlivTbAYKscp/kSaE/R?=
 =?us-ascii?Q?MBpefXa4Ce1a36O5tcvHiqokM58rU3yUYkDtnpcF0jKtzJf5wdqHlOHKarFR?=
 =?us-ascii?Q?r+vaEL5dzS68Xp2ggMTwURl/t7LrEZ5Q0pKwNiHBKQwVSqpNQET69gULZVh+?=
 =?us-ascii?Q?bp57cCfQ1V2LMIF2++/mVMmUZte6GUQZclgsDuCEfOWThh3pj1JImmUSHY1v?=
 =?us-ascii?Q?YdWv9TXpSr+s6vMXisrdlwTX9PpJGXKhS4Ybt+qkNu4G0ZSBHPygSc5JIyPB?=
 =?us-ascii?Q?tBsVrkpN9jNWXQ69nl6hCf6SjxnENZ+sKjn2yFhC9BXAOqRE1Vkg5zBgcXgD?=
 =?us-ascii?Q?0BRaQCg0hRKbdLtdh7tM4k+ks1cvBG/PP1/mnCYE8Ey7VglekhQIjEbIwNGc?=
 =?us-ascii?Q?ZIpYUuC9b8DBrLTT8TJjSc2+1zmCf3cR9j2XiJ00NVZAQjaxXh2NRlpUKoeP?=
 =?us-ascii?Q?AXySzo0OTabNZsly7I383u9+oQLWdxMcCPIvVuA9XfjNS06z23cBjo+NvEwm?=
 =?us-ascii?Q?WDVF8ac7CrHePse5q02T9AefUHUb3wbOZ7HULWiP0RYU3PwLiFZxeJ85Ui+s?=
 =?us-ascii?Q?iyy7OCwnPrDOIcOSEBBYjMdMuCAITEy0Eg3HZibL1P0Iy5rsWEjsYwUQUhnv?=
 =?us-ascii?Q?wxSAt2WneNMkayDlnVAbvh63WTHgbev79iFA5dLAqxiPmnPUi/lA2YEr8ql/?=
 =?us-ascii?Q?OI4RuHgtUx36Au72ZGiZUgOx07gkI4SozyJHYV84xPDZ3jypap2AfN6TpjVH?=
 =?us-ascii?Q?/Mc/jtC67x+woauIV8PjjbDP1RXSlTFOBYZT9+5MjKWdh1Tpcwa0gQcZ7TQ8?=
 =?us-ascii?Q?lDQlUScgaac+YDq/7Zt95U1NyMNVV4sumFpQzk8cAdvw3Eroe6bfQNze6Qnd?=
 =?us-ascii?Q?DcIMbz91ihB0aQqwxGIjAo+6esVrPtn5jWLXmsvJlq7kYfZN92nd5gulusXu?=
 =?us-ascii?Q?dSFGf6neOb7X2EQNbJodc5Z+0G1wNqewoS1v99o7ztTz4wJgOMcpgtAkoYg?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4dccd8-fe9f-408e-d454-08ddea2efbff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 14:42:47.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Wednesday, August 2=
7, 2025 6:00 PM

Same comment about patch "Subject:" prefix.

> CONFIG_HYPERV is an umbrella config option involved in enabling hyperv

s/hyperv/Hyper-V/

> support and build of modules like hyperv-balloon, hyperv-vmbus, etc..

With CONFIG_HYPERV and CONFIG_HYPERV_VMBUS separated, I think
of CONFIG_HYPERV as the core Hyper-V hypervisor support, such as
hypercalls, clocks/timers, Confidential Computing setup, etc. that
doesn't involve VMBus or VMBus devices.

> As such it should be bool and the hack in Makefile be removed.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/Makefile    | 2 +-
>  drivers/hv/Kconfig  | 2 +-
>  drivers/hv/Makefile | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b5749cf67044..7ad5744db0b6 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -161,7 +161,7 @@ obj-$(CONFIG_SOUNDWIRE)		+=3D soundwire/
>=20
>  # Virtualization drivers
>  obj-$(CONFIG_VIRT_DRIVERS)	+=3D virt/
> -obj-$(subst m,y,$(CONFIG_HYPERV))	+=3D hv/
> +obj-$(CONFIG_HYPERV)		+=3D hv/
>=20
>  obj-$(CONFIG_PM_DEVFREQ)	+=3D devfreq/
>  obj-$(CONFIG_EXTCON)		+=3D extcon/
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 08c4ed005137..b860bc1026b7 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -3,7 +3,7 @@
>  menu "Microsoft Hyper-V guest support"
>=20
>  config HYPERV
> -	tristate "Microsoft Hyper-V client drivers"
> +	bool "Microsoft Hyper-V client drivers"

I would want to change the prompt here to be more specific, such as:

	bool "Microsoft Hyper-V core hypervisor support"

As noted in my comments on the cover letter, this change causes
.config file compatibility problems. I can't immediately think of
a way to deal with the compatibility problem and still change this
from tristate to bool.

>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
>  		|| (ARM64 && !CPU_BIG_ENDIAN)
>  	select PARAVIRT
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 050517756a82..8b04a33e4dd8 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -18,7 +18,7 @@ mshv_root-y :=3D mshv_root_main.o mshv_synic.o
> mshv_eventfd.o mshv_irq.o \
>  mshv_vtl-y :=3D mshv_vtl_main.o
>=20
>  # Code that must be built-in
> -obj-$(subst m,y,$(CONFIG_HYPERV)) +=3D hv_common.o
> +obj-$(CONFIG_HYPERV) +=3D hv_common.o
>  obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) +=3D hv_proc.o
>  ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
>      obj-y +=3D mshv_common.o
> --
> 2.36.1.vfs.0.0
>=20


