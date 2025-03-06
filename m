Return-Path: <linux-arch+bounces-10555-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE04A5560C
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94703AA3C1
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC026BD82;
	Thu,  6 Mar 2025 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FDhEQ7O8"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazolkn19013011.outbound.protection.outlook.com [52.103.2.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256419D07A;
	Thu,  6 Mar 2025 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287425; cv=fail; b=KnlFcm4PEQpJCUCxdHiMxSv517hNGPlvb7/Fz6VazIFVVMgbbitjMMs0gGduX28pZnm6EsTV4ULEtO7mYXxoKKfXyLgyLAy98jHjP8EYoVPMvqdt7F2BKVlxN38BcgoT/OhT9F0lpwrUs+IEmtdkv4wxk4anQa16I0nDkA8cujk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287425; c=relaxed/simple;
	bh=nNXtK2sBbKYbHZ194IPf6yflmf6cC9uG8hU83OUpg1A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqZnG9Abj6fMqtB8cHEGitKh1nO2axC7bH6HDxGoCXmRfrNCRU+CZjAATJFYGV0TWDjRlUObtbuv4Tstt9+7kDfdR+2wqnN4nClQMew83ZpkWk4fy0ickKh4Hb3jfQv3FsWTt8JZNRTP4l3YkA7jSI6l8jHLo4Tlf0JwhALyXMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FDhEQ7O8; arc=fail smtp.client-ip=52.103.2.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMGrEy+Frv+CgXvnlwUNoBnqkLJ1Cz8+w1gaSwcw6AC/fg6Ee+83h0TBOVUhudm2iE9cFb9OOBN+UAhb2CK+mDDKxr1YLcykJqyw3R+xEaQ4j3Zji9XHLkEfN0b2ed2U0bmLeoPA62M3Cb8K/3i5+5SO4KQdtM8KImTjMJjq/XuC9WGZYaLvrRwomcDB9j+ijNjRNY9CIgAvxuXdBIf2YlIGc2cv3bmA5Ab09qarJ7U0ECXNKs/0m12Jqws4ba/6H4y4Pbd/1+zoEKWTJn45UlvIr2Wfth7QhqsopCikewQBehAKpR3+D7ktuCC2l1rLfHQjKq6rqZHdCZZOJfnUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNXtK2sBbKYbHZ194IPf6yflmf6cC9uG8hU83OUpg1A=;
 b=v8s4Po6xMOfGZiqLYXbLj96bx+skvKFylpl7XAtyYOqenG+d7x3DtJJFBg2EpqHXsjs3U2SDNhRxvLI6v4DjCD7YnPtauswAAnJ9IfoeQY+DIqbMvXN32DWEBDYAciYOJO5MqRKHwrkjIiFwH7b0sT55RUf8H43fGYv/YYnPPgYJbImF5qBp6sDqvOvyDDI3GhuC9T7mu/lvWVjiPoEmsacZKnSopfiltpBwdqCzxi4YdStCdbCobTJd542BNpX03FJfIxqOGOv5k26oHM+k0IpLdAlgUPIf5eUqnS/2ATS5U7BBe63zytw5gZsTH8olBtjYLQLbTmwU2EqA6dlyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNXtK2sBbKYbHZ194IPf6yflmf6cC9uG8hU83OUpg1A=;
 b=FDhEQ7O88mK/gL5OHIkHvqk4//tgFCcH9Nmok/JyjTtimF1CCg8aLZrvKZbjMk6fgnOBZuQdOXzkVea7oSZOhPCiVBaty33DRL94XgiW0wW+Nr3GsT9GILMyzFOdh8PnRVhhEc1/cEnURBQhC/oZK243l/U7o7ekLcpUQ1BlE/KJfepHstkVWoloDNB6qqCwUkY269R28lr/zsxYPOuMeIUqzBLGal2XL9wny7GxvzLGRYGMl4dJUs4IfrNzV4gXsjajyieIJc9O82q2THZ0Bqq9oAAbeDthsRP5TFb0gLOU3fSSSK1c38HoRLFK3gWkOhsTfnVD7fw2kHTV5dF3HQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6798.namprd02.prod.outlook.com (2603:10b6:208:1d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Thu, 6 Mar
 2025 18:57:00 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:57:00 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Topic: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Index: AQHbiKNs/uCEZOh33UCUZSZ5oZ+szbNma5PQgAAGYrCAAAs8AIAAAu5w
Date: Thu, 6 Mar 2025 18:57:00 +0000
Message-ID:
 <SN6PR02MB4157C148444E429FB6376C6ED4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41577560030C55503D1BAFDCD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157629A6197A8A6C992BB75D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <9123b404-f6f8-464b-bad8-b793ea6fb21e@linux.microsoft.com>
In-Reply-To: <9123b404-f6f8-464b-bad8-b793ea6fb21e@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6798:EE_
x-ms-office365-filtering-correlation-id: 217a1c96-cf31-4010-e502-08dd5ce0ad20
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|15080799006|8062599003|8060799006|12121999004|440099028|41001999003|3412199025|13041999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?anVPTTJKblVaeGQ4RXpKb1Y1azdkRDRsVVlvSnFXUmRmWmUxRzNiMXZqYmdS?=
 =?utf-8?B?MVBEMkQ0RDhacnBSRjg3eWQ1ZVVjcVdZRGNCdTFhb3FuZ2hsVzVreFdtdElI?=
 =?utf-8?B?bEFuMHBUYXd4VlkwTlduanZha0Fpci9sZUsrWnMwVlhLSElWZ1NJY2s2b1p4?=
 =?utf-8?B?MzdQcVIvRjdTZktSUnJGSm5uZEM1TXE0UFFwMXdMT2Y0N1FjVk5KVjhwMW9H?=
 =?utf-8?B?a0VDb1B2aEpaNVJ5ZkxMdktocFJTdG9qMjJLM1owK1lpQjVhMFJsOUhOV0p0?=
 =?utf-8?B?b2dsZnhhRmwrTWpHNmdpSnAyQmlTcGhJUytlcGh1TWJiZzBLRGpqN2lQM1Bj?=
 =?utf-8?B?b2lYdnRuWWYxZkxWVlFHZGRlZXBQdnhQSkZ4YnVPY08xb0FzMll1dG9TZUxN?=
 =?utf-8?B?bzhHck1lYk9ycEZrdFlCeDZPdXY1VUNieUExUWsyelRzWWZkQW5qTnl0N3NN?=
 =?utf-8?B?ekFabVI4RVhCbGlkM0tTZ2tHcjdadEErbG9HeFRwSTVvYlZHNUIwTFRNeXF4?=
 =?utf-8?B?dldwY1hxaHp0OVA1TGo3KzhlMzQreVdSUGZ3OEZMVUJjS2pIZnRYc0EzVzJt?=
 =?utf-8?B?UGJFcFRrL2hLSWhSV083MFFlT0Zha3VDdktzV2dVaW1DenJVY3RURjZrcmRj?=
 =?utf-8?B?K3lmSWMxclZmbTJxN3ZQd0psZlNxdVlpbEZGRE1rcnkzZEp5czNBNEpUV2x2?=
 =?utf-8?B?K3UzZ1kvNWRDb01zb2g5ZkVwRHhTakF4UnE3d3BpamNZZDl1YlJuV2ptRitz?=
 =?utf-8?B?Wmx0SlhkQTRWV3o3U3BvOEthQk5LSU9ML0hzbGZyNTdTMzNrMDhGRTZzeXlv?=
 =?utf-8?B?YXZlZWNKWW9zVExlQVpVU3ZTMUdSdjUvUFVKY3dQSmZpQS9Ub2dVdWpNQnZl?=
 =?utf-8?B?UGNPQ3lKNkQyZDlTY0ZxbTRDck83bW9YNXljZUdvS0g1anZwcWFHcmtWcC9i?=
 =?utf-8?B?QklEUjlOSXR2ZFdZekY2VEZQRzl2VnZaZWE4Uy9vTlFNdE5tL2hDS21vQU9L?=
 =?utf-8?B?UkszamlaYjVKU2xZdytWNE1oYStSZUpVN3BQV3liV2p6ejNKS1J3R1RnUmFW?=
 =?utf-8?B?QzJ0MElmOWVwek82NnZ2bjE4Z0ZsUkl3R0d6TmZLRnkveDZFSjdlc1VQK3FO?=
 =?utf-8?B?aEoyM1RrOUc0NHo2bnhoK0FldzdWUEJHczdjREN5RExaaVJDYlNZdGZxbG9U?=
 =?utf-8?B?TkZvL2thaWdpanVhL0kzeDNaODFKS0NUTmI5YjBtbnhjOUY4N0dyRVR3a0Rk?=
 =?utf-8?B?Z3VHMWVFZHF6c25BVWFNc0NxaVFSZU96NFFBRzN5ampHRTBjMU4xQk52Tk8r?=
 =?utf-8?B?bDVoQTJvNHV3NkpQanRlamNpUWhkZG1FSWdOeFJZbnl0WFpaczBZdVBvMjhl?=
 =?utf-8?B?VVl4QkpLRzc3aEdGVElHakU5NndoMzlXZDR1SHBKVmwrMzU0ZDBTczdoY2RN?=
 =?utf-8?B?NXFibnAydWxsVVNRMngzSmFGMlhPbVhDTkt0QWtPVXd3LzZXYzFNdmllRi8v?=
 =?utf-8?B?WWZPRlhMREpjdE1lOTlTOUkzNnNJK0w5Y294RnNIeFNyblZvMFdkdDYxMmlM?=
 =?utf-8?B?TzNWdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGV4NllLRVM1NzNTRUI1L3lxc09aRGVQeW1BR1FuVDZJdkJOOUdsY1R4ZkhV?=
 =?utf-8?B?WFl4MnpWNFU0bEcyTlJNUS9jY1lMQ0FtZi9mOHZEL2w1TVBBeHI4bHdNWXM2?=
 =?utf-8?B?eG5CUWV5Y3d3VnZkS0p5RGxIZEFlYTZvb2pKb0VyZTcrd21TRmNzVHA3ZjFx?=
 =?utf-8?B?YmpiVVlUN1E4ZnQzRTRaVUNrMVIvWHA0djA4SWk1LzA4Ti9JUDkrY05xY0lp?=
 =?utf-8?B?NEduWU1HYng2MGxpREV5SnNtNHVDM3J1azFQUHU2TnhGZ2hoaVIxeEM4QU1U?=
 =?utf-8?B?WVcxMVk4aWtDZUFpU1h2UFdJMVlqVTlLcGxBb0x4VGtidHFVc2syOHZ6WWN0?=
 =?utf-8?B?U3JLYm1yNnVKY2dCQnZZYW4wRFlCMnBaZHJPbThuUGhzY2ZyK01QSmdPTkN1?=
 =?utf-8?B?TTA2bVdqMlhPRWNSdzk3dWRMYVFBdlVRZzhJdkxlOE9Rb1RBenYwaGlpRERF?=
 =?utf-8?B?VjdYekUzZCsyd3J0eDBmTVMzTW1HaGdVYnZqOFRoTE1FcXY5Z2lYWWpIYW50?=
 =?utf-8?B?OExWa25iRmlId1Z6SUxTUFNyMGp0WUMwQVVVN1R1ZUN1N0crVkJHR0xadlRU?=
 =?utf-8?B?dDVtaTJzYnowaDU3OWlPQituTlRQR2JQOHpzVEYwVzVMZzdNU3FMeHp3emFW?=
 =?utf-8?B?MFlyTHZqZ0F3KzF6NXlKVVllMklCd2JuZ255endOeE1LMzdlTGlZZTNGbms5?=
 =?utf-8?B?bXdKSk5YL2ptZktqVFZtQVg3NkxvOXZrMDQwSzEvQWI1SHNpUEpSNlVEOW0x?=
 =?utf-8?B?VlVndk0wcTZUYmd5SmZrMEp6elBwa2ozU0ZrVmRobnpLRmRVUnJqK0VkU0Q0?=
 =?utf-8?B?Nk0zbXIxL1VqT0g0YitOQnZPb0s4NEFJZFVZd1M2VVNwdk9ySFRKWUZndDZY?=
 =?utf-8?B?amxCbzI2bUdyT0cyWmg4b2xadmpCNnRmaXFCRENaQnpSOHl5NW5ENk5zc2J4?=
 =?utf-8?B?bTBRWUJQS1QrR3Z6bVdJWkFHT0M4bTdCMEtIblI3aHBvbTRJMDAraU0wL2l3?=
 =?utf-8?B?ZW9ONXVUUGhHR2NEQUViRjYzYndLNUY5V0Y5TnZFanpFOFp6cmE4b3U1QnBD?=
 =?utf-8?B?YlVlRjR3WXZkeWRWM0hQaGFYVStQdmhVVjBvRVhMeU94R2dSdlBrV2tXV051?=
 =?utf-8?B?WTdIVEVRZDF4eWxHTnc5Tk1rWDJINXQzNnYrR2hTeUxtRS9kYVZvamJsOXJp?=
 =?utf-8?B?MEQ4THRIYVoreFZlUC84ZEgyT240Yk1JcTF4THcrRHBaZmxPWmRMbk5yeElW?=
 =?utf-8?B?bXFVSFZXM3dITHJhME1XbGZjTkFKeURwOG9jaERMVW5zK0crNGpMN1JPNm5Z?=
 =?utf-8?B?ZGJpYjl4OUlZRm92ZTJtS3ZxcVFWZTdJeWdkTVpGM3BFSnB1WVJIWEllQm1i?=
 =?utf-8?B?dzFpS0dmbjIrM2JvdjQ4dDN5SWtCNTRBSmJUYjJYM0Z5OFRPbGNMSE9ycjZj?=
 =?utf-8?B?bkEvRGNKL3JrT1ZnZXBiY2V0dDE2em9DdmRJWGQwWVdIazNZdnBhazJOOU1I?=
 =?utf-8?B?YUtKTzIyWVNZZVo4QzRFWEcrbzJzL21OTUxDYjJDb0VLSmE2a01PM1Z2dXk2?=
 =?utf-8?B?WkMzRFloaUJRZFBneEJKMWEvYkhBckplazNmUGp3eWREQmZuRGoyMzB5cjYx?=
 =?utf-8?Q?Q3UlaKd/MyXkHdv1OgcDCq1ChRn1a2UEwPnLPqmvOKjs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 217a1c96-cf31-4010-e502-08dd5ce0ad20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 18:57:00.2919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6798

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUaHVyc2RheSwgTWFyY2ggNiwgMjAyNSAxMDo0MSBBTQ0KPiANCj4gT24gMy82LzIwMjUg
MTA6MDkgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE1pY2hhZWwgS2VsbGV5
IDxtaGtsaW51eEBvdXRsb29rLmNvbT4gU2VudDogVGh1cnNkYXksIE1hcmNoIDYsIDIwMjUgOTo1
OCBBTQ0KPiA+DQoNCltzbmlwXQ0KDQo+ID4+IEkndmUgcmVhZCB0aHJvdWdoIHRoZSBvdGhlciBj
b21tZW50cyBvbiB0aGlzIHBhdGNoLiBJIGRlZmluaXRlbHkgdm90ZQ0KPiA+PiBmb3Igb3V0cHV0
dGluZyBib3RoIHRoZSBoZXggY29kZSBhbG9uZyB3aXRoIGEgc3RyaW5nIHRyYW5zbGF0aW9uLCB3
aGljaA0KPiA+PiBjb3VsZCBiZSBlbXB0eSBpZiB0aGUgaGV4IGNvZGUgaXMgdW5yZWNvZ25pemVk
IGJ5IHRoZSB0cmFuc2xhdGlvbiBjb2RlLg0KPiA+Pg0KPiA+PiBJIGNhbiBzZWUgcHJvdmlkaW5n
IHNvbWV0aGluZyBsaWtlIGh2X2h2Y2FsbF9lcnIoKSBhcyBOdW5vIHByb3Bvc2VkLCBzaW5jZQ0K
PiA+PiB0aGF0IHN0YW5kYXJkaXplcyB0aGUgdGV4dCBvdXRwdXQuIEJ1dCBJIHdvbmRlciBpZiBp
dCB3b3VsZCBiZSB0b28gbGltaXRpbmcuDQo+ID4+IEZvciBleGFtcGxlLCBpbiB0aGUgY2hhbmdl
cyBhYm92ZSwgYm90aCBodl9jYWxsX2FkZF9sb2dpY2FsX3Byb2MoKSBhbmQNCj4gPj4gaHZfY2Fs
bF9jcmVhdGVfdnAoKSBvdXRwdXQgYWRkaXRpb25hbCBkZWJ1Z2dpbmcgdmFsdWVzLCB3aGljaCB3
ZSBwcm9iYWJseQ0KPiA+PiBkb24ndCB3YW50IHRvIGdpdmUgdXAuDQo+ID4+DQo+ID4+IExhc3Rs
eSwgZnJvbSBhbiBpbXBsZW1lbnRhdGlvbiBzdGFuZHBvaW50LCByYXRoZXIgdGhhbiB1c2luZyBh
IGJpZw0KPiA+PiBzd2l0Y2ggc3RhdGVtZW50LCBidWlsZCBhIHN0YXRpYyBhcnJheSBvZiBlbnRy
aWVzIHRoYXQgZWFjaCBoYXZlIHRoZQ0KPiA+PiBoZXggY29kZSBhbmQgc3RyaW5nIGVxdWl2YWxl
bnQuIFRoZW4gaHZfcmVzdWx0X3RvX3N0cmluZygpIGxvb3BzIHRocm91Z2gNCj4gPj4gdGhlIGFy
cmF5IGxvb2tpbmcgZm9yIGEgbWF0Y2guIFRoaXMgd29uJ3QgYmUgYW55IHNsb3dlciB0aGFuIHRo
ZSBiaWcgc3dpdGNoDQo+ID4+IHN0YXRlbWVudC4gSSd2ZSBzZWVuIG90aGVyIHBsYWNlcyBpbiB0
aGUga2VybmVsIHdoZXJlIHN0cmluZyBuYW1lcyBhcmUNCj4gPj4gb3V0cHV0LCBhbmQgbG9va2lu
ZyB1cCB0aGUgc3RyaW5ncyBpbiBhIHN0YXRpYyBhcnJheSBpcyB0aGUgdHlwaWNhbCBhcHByb2Fj
aC4NCj4gPj4gWW91J2xsIGhhdmUgdG8gd29yayB0aHJvdWdoIHRoZSBkZXRhaWxzIGFuZCBzZWUg
aWYgYXZvaWRzIGJlaW5nIHRvbyBjbHVtc3ksDQo+ID4+IGJ1dCBJIHRoaW5rIGl0IHdpbGwgYmUg
T0suDQo+ID4+DQo+ID4NCj4gPiBCZXR0ZXIgeWV0LCBhbHNvIGluY2x1ZGUgdGhlIHRyYW5zbGF0
ZWQgZXJybm8gaW4gZWFjaCBzdGF0aWMgYXJyYXkgZW50cnkuDQo+ID4gVGhlbiBodl9yZXN1bHRf
dG9fZXJybm8oKSBjYW4gZG8gdGhlIHNhbWUga2luZCBvZiBsb29rdXAgaW5zdGVhZCBvZg0KPiA+
IGhhdmluZyBpdHMgb3duIHN3aXRjaCBzdGF0ZW1lbnQuIEkgZGlkIGEgcXVpY2sgbG9vayB0byBz
ZWUgaWYgdGhlIHR3bw0KPiA+IGZ1bmN0aW9ucyBtaWdodCBiZSBjb21iaW5lZCB0byBkbyBvbmx5
IGEgc2luZ2xlIGxvb2t1cCwgYnV0IHRoYXQgbG9va3MNCj4gPiBzb21ld2hhdCBjbHVtc3kgdW5s
ZXNzIHNvbWVvbmUgZWxzZSBzcG90cyBhIGJldHRlciB3YXkgdG8gaGFuZGxlIGl0Lg0KPiA+IFRo
ZSBjb3N0IG9mIGRvaW5nIHR3byBsb29rdXBzIGRvZXNuJ3QgcmVhbGx5IG1hdHRlciBpbiBhbiBl
cnJvciBjYXNlLg0KPiA+DQo+ID4gRldJVywgaHZfcmVzdWx0X3RvX2Vycm5vKCkgYW5kIHRoZSBu
ZXcgaHZfcmVzdWx0X3RvX3N0cmluZygpIGFyZSBib3RoDQo+ID4gc2xpZ2h0bHkgbWlzbmFtZWQu
IFRoZSBpbnB1dCBhcmd1bWVudCBpcyBhIGZ1bGwgNjQtYml0IGh2X3N0YXR1cywgbm90IHRoZQ0K
PiA+IHNtYWxsZXIgMTYtYml0IHJlc3VsdCBmaWVsZC4gaHZfc3RhdHVzX3RvX2Vycm5vKCkgYW5k
IGh2X3N0YXR1c190b19zdHJpbmcoKQ0KPiA+IHdvdWxkIGJlIG1vcmUgcHJlY2lzZS4NCj4gPg0K
PiBIbW0sIHdlbGwgSSdsbCBhZG1pdCBJIHdhcyBhbmQgc3RpbGwgYW0gcmF0aGVyIGNvbmZ1c2Vk
IG9uIHRoaXMgcG9pbnQuDQo+IA0KPiBJbiB0aGUgVExGUyAoc2VjdGlvbiAzLjgpIHRoZSBlbnRp
cmUgNjQtYml0IHJldHVybiB2YWx1ZSBpcyBjYWxsZWQgdGhlICAiaHlwZXJjYWxsIHJlc3VsdCB2
YWx1ZSIuDQo+IFRoZSAxNi1iaXQgSFZfU1RBVFVTIHBhcnQgaXMgKmFsc28qIGNhbGxlZCB0aGUg
InJlc3VsdCIgaW4gdGhpcyBzZWN0aW9uLg0KPiBMYXRlciwgaW4gc2VjdGlvbiAzLjEyLCB0aGUg
MTYtYml0IGZpZWxkIGlzIHJlZmVycmVkIHRvIGFzIGEgInN0YXR1cyB2YWx1ZSBmaWVsZCIuDQo+
IEZ1cnRoZXJtb3JlLCB0aGUgbmFtZSBvZiB0aGUgMTYtYml0IHZhbHVlLCBpdHNlbGYsIGlzIEhW
X1NUQVRVUy4NCj4gDQo+IERlc3BpdGUgdGhlIGluY29uc2lzdGVuY3ksIGluIG15IG1pbmQgaXQg
bWFrZXMgdGhlIG1vc3Qgc2Vuc2UgdGhhdCB0aGUNCj4gMTYtYml0IEhWX1NUQVRVUyBwYXJ0IHRo
ZSAic3RhdHVzIiBhbmQgdGhlIGVudGlyZSA2NC1iaXQgcmV0dXJuIHZhbHVlIHRoZQ0KPiAicmVz
dWx0Ii4gSSBhbSBhd2FyZSB0aGF0IGVsc2V3aGVyZSAoYW5kIGluIHRoZSBkcml2ZXIgcGF0Y2hl
cyBpbiB0aGlzDQo+IHNlcmllcyksIHRoZSBuYW1lICJzdGF0dXMiIGlzIHVzZWQgdG8gcmVmZXIg
dG8gdGhlIGVudGlyZSA2NC1iaXQgcmV0dXJuDQo+IHZhbHVlLg0KPiANCj4gVGhlc2UgZnVuY3Rp
b25zIHdlcmUgYWN0dWFsbHkgY2FsbGVkIGh2X3N0YXR1c190b19lcnJubygpIGFuZCBodl9zdGF0
dXNfdG9fc3RyaW5nKCkNCj4gaW4gdGhlIHBhc3QsIGJ1dCBJIGNoYW5nZWQgdGhlbSB0byB1c2Ug
InJlc3VsdCIgYnkgZm9sbG93aW5nIG15IG93biBsb2dpYywgYW5kIEkNCj4gdGhvdWdodCB0aGlz
IGFsc28gbWF0Y2hlZCB0aGUgbmFtaW5nIG9mIGh2X3Jlc3VsdCgpIGFuZCBodl9yZXN1bHRfc3Vj
Y2VzcygpLg0KPiBIb3dldmVyIEkgbm93IHJlYWxpemUgdGhhdCB0aGUgInJlc3VsdCIgaW4gdGhl
c2UgbmFtZXMgcmVmZXJzIHRvIHRoZSAqb3V0cHV0KiBvZg0KPiB0aGVzZSBmdW5jdGlvbnMuLi4g
dGhleSB0YWtlIGEgdTY0IHN0YXR1cyBhcyBhIHBhcmFtZXRlciBhZnRlciBhbGwuLg0KPiANCj4g
U28gaW4gdGhlIGVuZCBJJ20gcmF0aGVyIGJvdGhlcmVkIGJ5IHRoaXMgd2hvbGUgc2l0dWF0aW9u
LiBJIGNhbiBjaGFuZ2UgdGhlc2UNCj4gbmFtZXMgYmFjayB0byAic3RhdHVzIiAoYWx0aG91Z2gg
aHZfcmVzdWx0X3RvX2Vycm5vKCkgaXMgYWxyZWFkeSBtZXJnZWQsIEkNCj4gY291bGQgc2VuZCBh
IGZpeHVwKSwgb3IgSSBjb3VsZCBrZWVwICJyZXN1bHQiLCB3aGljaCBJIHRoaW5rIGlzIGEgbW9y
ZQ0KPiBsb2dpY2FsIG5hbWUgZm9yIHRoZSA2NC1iaXQgdmFsdWUsIGV2ZW4gdGhvdWdoIGl0IHNv
bWV3aGF0IGNvbnRyYWRpY3RzIGhvdw0KPiB0aGUgdGVybSBpcyBhbHJlYWR5IHVzZWQgaW4gdGhl
IGtlcm5lbC4NCj4gDQo+IEdpdmVuIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSB3ZWxsLWRlZmluZWQg
aW4gdGhlIGZpcnN0IHBsYWNlLCBJJ20gbm90IHJlYWxseQ0KPiBzdXJlIHRoZSBiZXN0IHJvdXRl
Lg0KPiANCg0KSG1tbS4gWW91IGFyZSByaWdodC4gSSBoYWQgaW4gbXkgbWluZCB0aGF0ICJzdGF0
dXMiIGlzIHRoZSBmdWxsIDY0LWJpdA0KdmFsdWUsIGFuZCAicmVzdWx0IiBpcyB0aGUgMTYtYml0
IGVycm9yIGNvZGUuIEJ1dCB0aGF0J3MgY2VydGFpbmx5IG5vdA0KYWx3YXlzIHRoZSBjYXNlLiBB
bmQgYXMgeW91IHBvaW50IG91dCwgaXQgZG9lc24ndCBjb21wb3J0IHdpdGggdGhlIFRMRlMsDQph
bmQgdGhlIFRMRlMgaXRzZWxmIGlzIG5vdCBjb25zaXN0ZW50IGluIHRoZSB0ZXJtaW5vbG9neS4N
Cg0KSWdub3JlIG15IGNvbW1lbnQuIFRoZSBkaWZmZXJlbmNlIGRvZXNuJ3QgaGF2ZSBhbnkgcmVh
bCBpbXBhY3QuIExlYXZlDQp0aGUgc29ydGluZyBvdXQgZm9yIHNvbWUgb3RoZXIgdGltZS4gOi0p
DQoNCk1pY2hhZWwNCg==

