Return-Path: <linux-arch+bounces-13356-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601AB40755
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D861B62F50
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541031A544;
	Tue,  2 Sep 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TrfEmPpF"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2067.outbound.protection.outlook.com [40.92.40.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B33128D7;
	Tue,  2 Sep 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824160; cv=fail; b=TtL3ihd16QEwaql1J82NjiRCpEHioj/GrP9S3mquob9B/ueZcqDa/HuEoCsgRAW1gGlfovBdyNmO5GlV5R8g8jaD2rm+7f2OurEHzSbHqxoyU9oyGfwH0KRn3lswrwP9JwDnfNrKs0VPqCrlJNbwlTcUg9SRPAUfU4x7gIWf368=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824160; c=relaxed/simple;
	bh=OOWI1wkTf7wpND0czrvD4lvgwZM7dug47LQWIo9qtHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rvigsVfYhDS9gHhxLO0zCWX5eFkDr3kDUSS07z3R9o1GJ/6nD83nlP2Z+rEHP/0H/it/qJYxfpLFx7UI7yoVWBSSmq+ZXwOMlf6mS7UOo3jZd7KNd26Jjb8Py3imIYV7wI4ZVwtZOiURgysB9RhCXea4uFnVYj/AfucuuY5tgqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TrfEmPpF; arc=fail smtp.client-ip=40.92.40.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfyoSknglFpooHcfjR/vTSUsrPcte+drgjuD8gQQaSpxnWMGz1tXBuVJ1aWYV5LXXENsDq/eXczavKTP3M+tZlFbo+/VJRimEgEnxPfzu/sq5NOK9rOIgrnw/qCFfGuQPgnnPqQFJ85f+GcsO7PCk7weEYeY+qTkJ1zRLHs/jg07xzY2UW57hLsyT+lG8HR5DQ52s9evjZVPryUsXg/4Ux2MOidXSQsGFRaQNvdp3JMZPqsOY4BOn+vQGWSvrqxZnv5of72Aprfeh/8rdLZf1EwThAaEJTspU0kswxt+/V4hQphbQHC5Ijg0W6c3igYh1zGJUGn831prB74+yP5GxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZBT8cocxBLilZXl8eMUJo55aJ7tPWysJoCfk5ZruXE=;
 b=A5JgCkcEPCLuvdikSgfNDmcAj/bHI2GlalIwgBRXedkH22wz3tQapQbW+jK79f5Iaz8RKA95s3YeZDutP8p6XQkEhYA10rXWTwrNW/8/a702R2VV9et/pKXo662szmL11DVE3fJEGxtS2Bd4vLiugT253/r24b/uy5U7+xU3sy4ewh7RPZ3GZPDphUL5p6CM45jS5VkORkTjeNxo/8q7h4LXOXEi3s60Qc+KI0E9g6IinHPfplNQTvJVY+Y4dbyYWlfmntslCqF0hK2w3a5KzSMtsL3VR0JYU8Kw9za9FW66gebMmXJl13GoVqZLLxNSSYmB5s6+UojDUZImeWRVDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZBT8cocxBLilZXl8eMUJo55aJ7tPWysJoCfk5ZruXE=;
 b=TrfEmPpF/E7Tcv7+Pk+V2bTe235kBDdboKyGyCQ+BvkR8YPMoAzwXbyaApqnvkLH+9fQ0Kace4ChEi7A7pCjQJ+FjMD3XXjOq1LSYniuh25YPTE03pxWn5+F53vuMP3c1dCr7n9klQGDN4fZeY0L0NP+nJKiHIeLNK93fumYRO2UFfjfHBmQMQ5uDnLMhWkRn+de5MfQL9GG/1HbmgJ42GtFQ9AYxBX+G5AX//OI6jsq+6uV6VFIJ9qFsn97j21IkBJtACNwI5Hj3DzfK8MuhZYry+DT6E4tm9r2v4i/t/XW3Km7WNkbQ71ICWFyU05/hfOZM+CikEQ2NgeO2YdNRQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10054.namprd02.prod.outlook.com (2603:10b6:408:19c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 14:42:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Tue, 2 Sep 2025
 14:42:31 +0000
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
Subject: RE: [PATCH V0 1/2] hyper-v: Add CONFIG_HYPERV_VMBUS option
Thread-Topic: [PATCH V0 1/2] hyper-v: Add CONFIG_HYPERV_VMBUS option
Thread-Index: AQHcF7dJQkEtmp6mJ0mMZNP9GOtcn7R7VcIQ
Date: Tue, 2 Sep 2025 14:42:31 +0000
Message-ID:
 <SN6PR02MB4157CC5B8CEB06D9E2593140D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
 <20250828005952.884343-2-mrathor@linux.microsoft.com>
In-Reply-To: <20250828005952.884343-2-mrathor@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10054:EE_
x-ms-office365-filtering-correlation-id: 2a49f350-fb5a-41ce-9747-08ddea2ef290
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNsJbj7NxvUrpSYkT7K1zyUecqs7v9iMtaeRt6+XtxOHb1mb5btmVH0cX6JyAxqlx84PJTiAckX9CZiSLEEkXBS2eWbvH5qmgeuXJ3nTmSmZ+ZR4Qw5qJD5A0sCqW/R7pwOUnazoAowkCSfEyRpEEvaTnDBz6JmyFaQJ111K4R4DowpmW8K0fra3sEhbShungPyMy/OtYB/fd9SgtOoL+yywFE5NJlWmP2R38PGDiFSOmNEUByliaX0W+dY6sGt0jEjbiU+5xKokavY6vRKU4NtBN0UiFrJ9yFkodO46tpCmZs4m07gf4kOPut2SJFepplGodTYspiQSl25TTNK0fyHqzkmDyp8wy418oSArbwiQ6lz2GNJkLxQ+Xnt4+XDhs/h/RighQytJZkPpN1LpwBxde87rk8xw/d+Z7m9nXdiyqC0U7E8zfGmWD72V/XybvJYMtpkM3KOJQQ7fcgvnLCmMQnuKAGywBFlmx2QRC3KFf6CTzGdRYvbgswwEqG6jLumhuxCRLCsw0qkVvbjvM8evFYtK2S//GMTFutGAdriOT03214HhiNLEe1ZdRPU5DOBDh9TaneWUuXWZlTFWj6HD2sQhNO4TC9Mo0/Bbjsnc5ZPTKkSgMgVxQsEdNuQojoTN3ZHOlFEfkkWbVXFVvrf49a7PZtBYuFOP/z7WSqHsah3p2WVw4nsGBvOr7tfVW0+fkUjyagOJB4FsqbKLsWhjws+HiYasTg3V6Y80B3f1tz6n/gi4oyjGtAvFcJ0GWU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|8062599012|8060799015|19110799012|15080799012|13091999003|461199028|31061999003|440099028|40105399003|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?12jEfXASDFa+CQisIJLJ5nlxBljry/sVrT0kWt5JBP3+NsvWgWvpyTdkVkCO?=
 =?us-ascii?Q?7hNSmdF+Tc3ZZ5+/Q83HNANyF2pN7wyls1BsepAe5rPKgd12MRH3Y5lRHafY?=
 =?us-ascii?Q?oyCBgtRCwtXTn1Vtwl5PtYJRzFHaVkeYi8yZ4wwfFvNtpraJBAFw9szMd6df?=
 =?us-ascii?Q?edKTPmIzIt5C4cOoxL9YfCQS+AMpLybMr73V0lZzv5oFBEo2FgGV/WZs5loV?=
 =?us-ascii?Q?2LEoGp4ZHc1KeTzFOkNsMvBNoIyuRSY408qKLombLFOiw+0nPWew1oeDdRLy?=
 =?us-ascii?Q?Wf7KM17a+MRVyvntbNJg8L4+20NuutP93yy0AmFN3mDUiAqlArxcfnEoMBkM?=
 =?us-ascii?Q?cgNBuuaewXCSgQKpNZlnVISg+c/c0V6UVYP/2x63ZWLqRRHfILSn3OlsB4Lq?=
 =?us-ascii?Q?x0Zzf6XTro5B4Ei7/l3LipJYm6zAkCaZThUc2J4ZdDMs93YbzbNkVB7Y9r6q?=
 =?us-ascii?Q?OoTO1B/p7s66stFiSB1kuAoQm7Ov+Te4DuN/ZnvySKAF1Xwv8AS7SH2Gx6a0?=
 =?us-ascii?Q?G2d4RghoNVY2RtI96kuuIUgZG260gtrKx5L92UkVVqvyiANm0rTCTotwlM9u?=
 =?us-ascii?Q?jJNBi2aEdC0TFWzj43QXrY7KNufNWT4RRxWBTpduPQHe8JaYRK2GI/gSGMWd?=
 =?us-ascii?Q?3EHGE83oy8ggWs2SPxdxebRPvt7HWi2Y5eHmJdHuZqQlb6tulqWiQoSWwkWQ?=
 =?us-ascii?Q?9N4bul43S7QnR1iIzTi9a0tQc/NbyQtuns96b3qJ22oHWTtXqHAXdIXFZ8HY?=
 =?us-ascii?Q?IegMu7HWUUFKwiEF2elHKiwF1cYNvKKM2z9eUKCfpF87Rr93Jp+32qvwQvEu?=
 =?us-ascii?Q?1pFSmQXT8DnOtizvvRd5qEl4eUn2I2qTq+pcsOtNH93OaW1sXE/T6QfrAVhF?=
 =?us-ascii?Q?KWoWwiyOJTA8HNiEx+B2Mbw3UieGnrkcIqeMLjAQXNxQi1rPAYGbHerb/KJk?=
 =?us-ascii?Q?BIzCoR5UlvIEEnn3eyilPKSraKa43t/IXzgPV4CKqtY0ne96Ug2zcuUwDhb/?=
 =?us-ascii?Q?R0iHECH930rcjNprKp+bwxDf4qMpTppCK1jrPFX9TJQHbzdp2fSRJEGEXDhR?=
 =?us-ascii?Q?LuIQZUS52NH6LH+UzcwmU2CIvhMFHQfx2KXkq9UzNWw7ew+zmiYdTceKjODI?=
 =?us-ascii?Q?Po9UW8XnEjd2ZZz55+ecf5/Ann/xTsvF1d6zboSjPVseAoHf3AtivjsU3DDl?=
 =?us-ascii?Q?J4lPnWppT+BeIlws7fCSMOQtRhXEc8bMlMISyjpLdVnfhNQvv65tHF0JQGY?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8I9mlUoqNZcfUZ2Drpkz+4nb9hrBUCWEAX8OZ4GaNVnzwax12AFzs3hvS93m?=
 =?us-ascii?Q?EoZknUJJkzS+9EHGvReS62Z/QMr0Lb6lZASkyq0tMY7OKgnnK0eLEfQpjVfh?=
 =?us-ascii?Q?ZIioqXugkZnbes+euDI3BnwMke9C2D+9wSgKKx+HIBXSCLudUgZPW3FHOGQU?=
 =?us-ascii?Q?e+8cKMMrSCuNjVgiI6S0+zDHGqlzAt8L8BCwd5Xde6E/7QqfTTAcHcJdWT/e?=
 =?us-ascii?Q?5FyqhQfFcoOoN8YxMGEOBUsOdACsKDy95pzorIPwqmCxmBWHISKI+5aTGhnL?=
 =?us-ascii?Q?XXgMliTFM101tR6k73yNT43LA+9bMoSTG+LDe/n5GvD88Gpnp6Ojxe56HJwZ?=
 =?us-ascii?Q?cMfP2AFBFAndKY3D6icxELNvh5ADEi7ZURcgZcCSTeozzpKBLCbGZrz20RWI?=
 =?us-ascii?Q?KRN+BiObXcA1uSz3cwO5IYj/xgW4KrWPxsPJD1zqsn4I0qp/WUZKaMkQhtQF?=
 =?us-ascii?Q?UhgwR907IhD/ri7aS6/hm2Q/HkuCxniMOcDvNYpOVyR+Nk8Qk/6+nEMAptRd?=
 =?us-ascii?Q?DE0jyeCHIpU4eIdHMx4puirlogyyEQdc+MwFAymWHGG1UteNqkGFPSk9I/nh?=
 =?us-ascii?Q?biPEwqZ/9kn852UB/BSCrZ4rXWMhFf1nPvlDniJWyem/6HknXxqntqXbUVoB?=
 =?us-ascii?Q?TWw17wa4fQ+vOtbxhie+1dCXtHBxCd3Mt1hTsSPuMC8YVCvFV9ZTZ/X0EJHO?=
 =?us-ascii?Q?V7auBoxyPe5lAEca3I2aQBMPtLtj3APoBWRJos4TpIbkn+WDVA3ScBuQn6hF?=
 =?us-ascii?Q?WugdHhn7bCoI6njmYCYol1z+FwZY5sBqpAHkTk+ZfoN4Ij8zL7B9EEL3WBIN?=
 =?us-ascii?Q?e3OLXmVuUnbWHPc2A+qoTA1AhYbS4O2lWfRf4WjHhlFmlrGYEUdJfl5m/+B7?=
 =?us-ascii?Q?+pyGSAlqG9SRNLOLSgVT+PQYwrZd8O8HWB73WXsgxttWJY3P5fOjsIFWxstr?=
 =?us-ascii?Q?szKGSwJ+ITMjViy+3y9m5FUja1gsFGaYjK7FkaENtbPlsuKxcp/Z2SF09sD1?=
 =?us-ascii?Q?IO1J5JKWUk3oj8S4BzC6JsWIQaTmbJcAXN1fLr4Ug0WaDsS9kn+/imxlR2ex?=
 =?us-ascii?Q?i7d9g/8+HUclDY9S3Zygz35nnhYiz6n61d9Hl39Gn35aPG/Skiu6BlZwt7q5?=
 =?us-ascii?Q?9S1t0ZHRjzVtHZnYwvL7tykbnyqYNwjQmmER5uUEhgrD4ahFf+PVJUVd+kYC?=
 =?us-ascii?Q?b0NqzvpF92yf11x9lOvYI2LPUkoQQtxkCdkUKBE/N6+Lk77YLzrtf9yECHs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a49f350-fb5a-41ce-9747-08ddea2ef290
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 14:42:31.5382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10054

From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Wednesday, August 2=
7, 2025 6:00 PM
>=20

Even though this patch touches multiple subdirectories under "drivers",
I'd suggest the patch "Subject:" prefix should be "Drivers: hv:" (not "hype=
r-v:")
to be consistent with historical usage.

> Somehow vmbus driver is hinged on CONFIG_HYPERV. It appears this is initi=
al

In text, "vmbus" should be spelled as "VMBus".  This includes patch Subject=
s,
commit messages, code comments, kernel messages, and kernel documentation.
Originally, the spelling was all over the map, but we've tried to be more c=
onsistent
lately in matching Microsoft's public documentation on Hyper-V, which uses
"VMBus". Of course, C language code variable and function names use all low=
ercase.

> code that did not get addressed when the scope of CONFIG_HYPERV went beyo=
nd
> vmbus. This commit creates a fine grained HYPERV_VMBUS option and updates
> drivers that depend on VMBUS.
>=20
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  drivers/gpu/drm/Kconfig        |  2 +-
>  drivers/hid/Kconfig            |  2 +-
>  drivers/hv/Kconfig             | 12 +++++++++---
>  drivers/hv/Makefile            |  2 +-
>  drivers/input/serio/Kconfig    |  4 ++--
>  drivers/net/hyperv/Kconfig     |  2 +-
>  drivers/pci/Kconfig            |  2 +-
>  drivers/scsi/Kconfig           |  2 +-
>  drivers/uio/Kconfig            |  2 +-
>  drivers/video/fbdev/Kconfig    |  2 +-
>  include/asm-generic/mshyperv.h |  8 +++++---
>  net/vmw_vsock/Kconfig          |  2 +-
>  12 files changed, 25 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index f7ea8e895c0c..58f34da061c6 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -398,7 +398,7 @@ source "drivers/gpu/drm/imagination/Kconfig"
>=20
>  config DRM_HYPERV
>  	tristate "DRM Support for Hyper-V synthetic video device"
> -	depends on DRM && PCI && HYPERV
> +	depends on DRM && PCI && HYPERV_VMBUS
>  	select DRM_CLIENT_SELECTION
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_SHMEM_HELPER
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a57901203aeb..fe3dc8c0db99 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1162,7 +1162,7 @@ config GREENASIA_FF
>=20
>  config HID_HYPERV_MOUSE
>  	tristate "Microsoft Hyper-V mouse driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	help
>  	Select this option to enable the Hyper-V mouse driver.
>=20
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 2e8df09db599..08c4ed005137 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -44,18 +44,24 @@ config HYPERV_TIMER
>=20
>  config HYPERV_UTILS
>  	tristate "Microsoft Hyper-V Utilities driver"
> -	depends on HYPERV && CONNECTOR && NLS
> +	depends on HYPERV_VMBUS && CONNECTOR && NLS
>  	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  Select this option to enable the Hyper-V Utilities.
>=20
>  config HYPERV_BALLOON
>  	tristate "Microsoft Hyper-V Balloon driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	select PAGE_REPORTING
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>=20
> +config HYPERV_VMBUS
> +	tristate "Microsoft Hyper-V Vmbus driver"

As described above,
s/Vmbus/VMBus/

> +	depends on HYPERV

Per my comments on the cover letter, could add
"default HYPERV" here to help ease the transition.

> +	help
> +	  Select this option to enable Hyper-V Vmbus driver.

s/Vmbus/VMBus/

> +
>  config MSHV_ROOT
>  	tristate "Microsoft Hyper-V root partition support"
>  	depends on HYPERV && (X86_64 || ARM64)
> @@ -75,7 +81,7 @@ config MSHV_ROOT
>=20
>  config MSHV_VTL
>  	tristate "Microsoft Hyper-V VTL driver"
> -	depends on X86_64 && HYPERV_VTL_MODE
> +	depends on X86_64 && HYPERV_VTL_MODE && HYPERV_VMBUS

An observation: conceptually I would not expect this driver to
depend on HYPERV_VMBUS because it is not a VMBus driver. But
looking at the code, this is a place where VMBus interrupt handling
bleeds into code that is otherwise just hypervisor functionality. So
evidently the HYPERV_VMBUS dependency is needed for now.
Getting better separation and avoiding the dependency could be
done later.

>  	# Mapping VTL0 memory to a userspace process in VTL2 is supported in Op=
enHCL.
>  	# VTL2 for OpenHCL makes use of Huge Pages to improve performance on VM=
s,
>  	# specially with large memory requirements.
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index c53a0df746b7..050517756a82 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
> +obj-$(CONFIG_HYPERV_VMBUS)	+=3D hv_vmbus.o
>  obj-$(CONFIG_HYPERV_UTILS)	+=3D hv_utils.o
>  obj-$(CONFIG_HYPERV_BALLOON)	+=3D hv_balloon.o
>  obj-$(CONFIG_MSHV_ROOT)		+=3D mshv_root.o
> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 17edc1597446..c7ef347a4dff 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -276,8 +276,8 @@ config SERIO_OLPC_APSP
>=20
>  config HYPERV_KEYBOARD
>  	tristate "Microsoft Synthetic Keyboard driver"
> -	depends on HYPERV
> -	default HYPERV
> +	depends on HYPERV_VMBUS
> +	default HYPERV_VMBUS
>  	help
>  	  Select this option to enable the Hyper-V Keyboard driver.
>=20
> diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
> index c8cbd85adcf9..982964c1a9fb 100644
> --- a/drivers/net/hyperv/Kconfig
> +++ b/drivers/net/hyperv/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config HYPERV_NET
>  	tristate "Microsoft Hyper-V virtual network driver"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	select UCS2_STRING
>  	select NLS
>  	help
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9a249c65aedc..7065a8e5f9b1 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -221,7 +221,7 @@ config PCI_LABEL
>=20
>  config PCI_HYPERV
>  	tristate "Hyper-V PCI Frontend"
> -	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI && SYSFS
> +	depends on ((X86 && X86_64) || ARM64) && HYPERV_VMBUS && PCI_MSI
> && SYSFS
>  	select PCI_HYPERV_INTERFACE
>  	select IRQ_MSI_LIB
>  	help
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 5522310bab8d..19d0884479a2 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -589,7 +589,7 @@ config XEN_SCSI_FRONTEND
>=20
>  config HYPERV_STORAGE
>  	tristate "Microsoft Hyper-V virtual storage driver"
> -	depends on SCSI && HYPERV
> +	depends on SCSI && HYPERV_VMBUS
>  	depends on m || SCSI_FC_ATTRS !=3D m
>  	default HYPERV
>  	help
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index b060dcd7c635..6f86a61231e6 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -140,7 +140,7 @@ config UIO_MF624
>=20
>  config UIO_HV_GENERIC
>  	tristate "Generic driver for Hyper-V VMBus"
> -	depends on HYPERV
> +	depends on HYPERV_VMBUS
>  	help
>  	  Generic driver that you can bind, dynamically, to any
>  	  Hyper-V VMBus device. It is useful to provide direct access
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index c21484d15f0c..72c63eaeb983 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1774,7 +1774,7 @@ config FB_BROADSHEET
>=20
>  config FB_HYPERV
>  	tristate "Microsoft Hyper-V Synthetic Video support"
> -	depends on FB && HYPERV
> +	depends on FB && HYPERV_VMBUS
>  	select DMA_CMA if HAVE_DMA_CONTIGUOUS && CMA
>  	select FB_IOMEM_HELPERS_DEFERRED
>  	help
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 1d2ad1304ad4..66c58c91b530 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -165,6 +165,7 @@ static inline u64 hv_generate_guest_id(u64 kernel_ver=
sion)
>=20
>  void __init hv_mark_resources(void);
>=20
> +#if IS_ENABLED(CONFIG_HYPERV_VMBUS)
>  /* Free the message slot and signal end-of-message if required */
>  static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_=
type)
>  {
> @@ -200,6 +201,10 @@ static inline void vmbus_signal_eom(struct hv_messag=
e *msg, u32 old_msg_type)
>  	}
>  }
>=20
> +extern int vmbus_interrupt;
> +extern int vmbus_irq;
> +#endif /* CONFIG_HYPERV_VMBUS */
> +
>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
>=20
>  void hv_setup_vmbus_handler(void (*handler)(void));
> @@ -213,9 +218,6 @@ void hv_setup_crash_handler(void (*handler)(struct pt=
_regs *regs));
>  void hv_remove_crash_handler(void);
>  void hv_setup_mshv_handler(void (*handler)(void));
>=20
> -extern int vmbus_interrupt;
> -extern int vmbus_irq;
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  /*
>   * Hypervisor's notion of virtual processor ID is different from
> diff --git a/net/vmw_vsock/Kconfig b/net/vmw_vsock/Kconfig
> index 56356d2980c8..8e803c4828c4 100644
> --- a/net/vmw_vsock/Kconfig
> +++ b/net/vmw_vsock/Kconfig
> @@ -72,7 +72,7 @@ config VIRTIO_VSOCKETS_COMMON
>=20
>  config HYPERV_VSOCKETS
>  	tristate "Hyper-V transport for Virtual Sockets"
> -	depends on VSOCKETS && HYPERV
> +	depends on VSOCKETS && HYPERV_VMBUS
>  	help
>  	  This module implements a Hyper-V transport for Virtual Sockets.
>=20
> --
> 2.36.1.vfs.0.0
>=20


