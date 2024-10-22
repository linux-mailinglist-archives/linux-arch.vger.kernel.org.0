Return-Path: <linux-arch+bounces-8428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015AD9AB6A1
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 21:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB26B21E1B
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20C1C9DD8;
	Tue, 22 Oct 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LNrRsvjY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820B41BDA8D;
	Tue, 22 Oct 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624763; cv=fail; b=E3JOZdSG8O4ranVoP+GGwmP9q4gYviYqLvD6PqL46OtSyNwxnt1F6gxOBi4mkdIsfxv3A6efeFW9syd+nquzlXobsQlA8uzojyEPa+jhlxT3tl9+ZZDFcQgZYopt7R+OLzROSkCpyEVAVZ7ma7ibQFsDKNcBaIUcWv/3uYpHbP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624763; c=relaxed/simple;
	bh=/gAdXmTWA4ncOhutcl/73y5+svQZQGHdpfy5m1GJ2c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iST4lUxmd63qjF6VJ83GlXxkv5LJ06FTtZTl+KvZnV1CAyU7PhTMV/MezWnENxmaDuMm/AukZSG7Zl3iWBQHQzkAwZ7H1vYAICq+TTjN5DJSkle9/+Q7qjZPPO1aKu5nZ3x+YooX2Bcqz3PxqIr2eBZn1DXh9G1YmO4WbBcHEVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LNrRsvjY; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MFXW3c014424;
	Tue, 22 Oct 2024 19:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/gAdXmTWA4ncOhutcl/73y5+svQZQGHdpfy5m1GJ2c0=; b=LNrRsvjYL5Lfw35C
	BaMWVUIqRS/igrlKDEJj6yy2KRwftWZg67HcYh8rWG++JT8INcGySlpCU6CBEyuN
	3HKsGHlcG7LUa+PfY1G8MqeZ+W+m3Xh0e3FZILKsdjxJ8Na6WmRjmcJlpQRern/J
	S0UvtAwtGIoYqFEt8D5hhZTsRwgDwOCTwKNKNo6dQN/HlzjTBU+lFEGxFyYfXcCP
	vA60iCf6hx3ITSGxYHMIJT8PRNoDlO1Jvm7Iqyn2yrCl39N45tsYBtVBfPl5leKl
	PJ6ux7Opty/4dA4IO/ravGz+lwm9Z46MGmTCRzJbB3uAeyzg0dm/7tfexBYNdA65
	4PSQPQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dkhd5n7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:19:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmpGTlpL7Fc5d3xS1xgkeGMQwJS1fDjEvRNqEBzSaZ4lRuff68xMH9S5jW01xfHdOcc04VsNs8TMQVoSYyso7U+D7xHBt6RbWtAT1y/oN2LZhGn1WuialLJZYvJYCcal0JrVBXtF81d3GxMoeWy1nKvxLcyXzkgsGBhBGPJYyW8SmNfjNnKfURYuOGzvpDsQ/6vdy5ORyhiC7aZ485jPLv8kri39aCKnMaB8GYmCWS4k6FeZtBho219e0BrlEWhjYnW3VyqSb79yEYIJ9l7c6OsxbDNxXB111CpC4spp2L44PmhbDwMchkYEoQONbEhio/xo5wAcXwGloYg4HOyGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gAdXmTWA4ncOhutcl/73y5+svQZQGHdpfy5m1GJ2c0=;
 b=i8MEq4wWSaAD+gSm6HlUcjAUZMgm2DRBg+9wsw4oXbtPfDv7I/YCGcvHwe4dAnhbYFNvC0yKoZLJmS9DxmajGJJzaJ+avAIZJ2V6/STaXEeXjbAG0lEKzYRXWBMlDJxctLwRyEJYE2yr/n3il2zygg0yqKaSF62TWuwx8NprToBax3CRl0n2QudSdszup2DzquihpWWFXGisDP1n7pQjyZWBVatcQwv6IqAIDRRuyBJcGHK+hJZC8CeCgVo6S6Vb7lTcxvVzO9tH/vUj0BttVDFYw5kq7ZdFKTIU0C+a/WIY+oeP5Q0V+Eb6/LYKVGwTJD0k7hD3oWwgLEOMC4Dung==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB10250.namprd02.prod.outlook.com (2603:10b6:8:192::5)
 by PH0PR02MB7125.namprd02.prod.outlook.com (2603:10b6:510:15::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:19:10 +0000
Received: from DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea]) by DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 19:19:10 +0000
From: Brian Cain <bcain@quicinc.com>
To: Thomas Huth <thuth@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd
 Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>
Subject: RE: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h
 header
Thread-Topic: [PATCH] hexagon: Move kernel prototypes out of uapi/asm/setup.h
 header
Thread-Index: AQHanLeL8Kd+mUgFkkyfrWbUyrW5bLKUKy4AgAAJ2BA=
Date: Tue, 22 Oct 2024 19:19:10 +0000
Message-ID:
 <DS0PR02MB10250CAA28A6119B7C9F0767BB84C2@DS0PR02MB10250.namprd02.prod.outlook.com>
References: <20240502173818.58152-1-thuth@redhat.com>
 <3e80f240-e95c-47ed-80a5-18a722dbb2c6@redhat.com>
In-Reply-To: <3e80f240-e95c-47ed-80a5-18a722dbb2c6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10250:EE_|PH0PR02MB7125:EE_
x-ms-office365-filtering-correlation-id: d7673209-4259-4b1c-c90d-08dcf2ce67fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c1hwVkpPcWFTbnduS0NNdGl4dno1QUFZMnZDWlF3MzRsOFVDKzRrR1pOTW1T?=
 =?utf-8?B?ell1Snd1NXRQWmY4a3dRME1BTlQyRWFFKzRRK2M3RVhFSU4rckdpNTRMZzBp?=
 =?utf-8?B?RmdVdHhQckJUVzRGUUxMSW1PNmRQQStoYmJEZjVkb0NmTUMzaTUvRTdxRXNr?=
 =?utf-8?B?cld4QTJtOGdvTGxmWGJibjlFQmwraVhIMjdjOVoxNnRFdTFDSzFaTXJhTFBa?=
 =?utf-8?B?SjNIMC8vYWMyYm9BZ1h1eFhET3NVOFZEVCs5NGZ1clVURHRqV0dxL09Oamo1?=
 =?utf-8?B?ZGdaTUtKMUFXNUhKM1RMSXdCZGVqODlObTJscHJoNEM2eWJ0cEk1SXVSMUhR?=
 =?utf-8?B?UUJtOENERi8zaDUrYlZ0ZVh5cUlmRXQ3d3U1UnV2MWYrazRaM2pPMnBkVHZY?=
 =?utf-8?B?VEsyRk9zVGNKTFVITTR5eHlhYi9BM1FVZ3RTZzBPdXZKOHh1dlZKNXRiU0FP?=
 =?utf-8?B?cmdKWXQwUmJTMXpKcEVoSmZLd0M5NHk1MTJXWXcxMmsyajU2c1FrVWlrSXFD?=
 =?utf-8?B?amhBdnJpVlJPMElnaVN3aHcxamo4VjZSYTBMWTZUVlAvVlNsSndBSHp6RHZi?=
 =?utf-8?B?SXQ2VmgySXY3cWp5cmtFOGJSWXdYQVZQVWNad0F5ZVovWFloSURGVXRENXBk?=
 =?utf-8?B?bkJvUCsxMHFudFoyQThJcTk2NXkreTVBYkkvaEt3Z2x3UjByQW5ycytmd0dj?=
 =?utf-8?B?SXFpUktjRUkrVTY2WFJUMkFtZlhvVDZWVGNaSUgzR0NZQUFNelhsMnVEZTFn?=
 =?utf-8?B?aUl6OFZ4bFIzVUdodTY2YW1BZjRHRUM2amRzRjlRblFBY1gvUTIrb0hiOHV1?=
 =?utf-8?B?WWQ2eWsreHVFNm9jWWs0SDhMMWJjdXlMakxOdUxIa094bkRjWVVnMGZzS1lG?=
 =?utf-8?B?OW54UExDV1hhalZhWUJxYnNaREJmYzFsNWF6c1F2UE9jelVYM1VBd29oalFv?=
 =?utf-8?B?TWtMcEp3L3o1MkxyRHJTNFB4d1JicXBUc1dUZ0QzUVV2Y2pSSGo3U09rQTll?=
 =?utf-8?B?QmM4SnJoNW8zVE1HcDBXOEJrU3NidmRXTkRQY2NCNWJrcnUvWU8zRytxcjR2?=
 =?utf-8?B?K3pwWElDekd2b1ZtZ3p4N09lOG9pK1BTWlNTU3pzWWZ5WTl3dGswMkFBY2RD?=
 =?utf-8?B?WWlGcTFpNUh0MHVGbkloM1J0aFJxMCtDT2J0bC9aby95cHdTNCtLdThqUWJO?=
 =?utf-8?B?YnBrTnNseWQ2V2d4ZmdNeXJwMytoMnZLTnlkSUdIVUtTYk1IMVY0REtrQUFK?=
 =?utf-8?B?SDdqUDJBWXBURmY5MUgxL3piV0xESU4vMTFhSUEySmIyS1B2RGFoVXBiSGJQ?=
 =?utf-8?B?RGg1T0w1OVdRUXRpQnFDckZSaGk5TTUzQTh6ZHVVL3JuRk9hdFRnOUFTMTFy?=
 =?utf-8?B?bjhYUVZTTDV2dDAycWo0bEdRd01iQ3I5MVNjUmZhMGJjRFpEemZvdVJlNnRE?=
 =?utf-8?B?OCszdXllL1Y0bXNuMkhqbm9ZR0JnSlJPTW9XTUozV2prYjNTWXhtWU5Makhp?=
 =?utf-8?B?RXZjVzZOYXNpUWNLK3JWdnptT3VxcGl6NWcvRTFrWHl6eDlTOGVUNVJELzQy?=
 =?utf-8?B?a0VpdjQyQlc1dWdDVTUySzEwYkdyQmZQTXp1NUxIOWdaaTdDY0p2Wm1QTENV?=
 =?utf-8?B?TjduMnYydjZZV2NKQTBDdWo3UXZHSHZTWnhBODdHbHorQXpzUDZOa1VNNlkv?=
 =?utf-8?B?UEplRU1LTUlWK3RDK0hOdk5mUFBYWDc0VW1FdWJRckNSanRSKzE2WlBuSkF1?=
 =?utf-8?B?VnVxNUYwQWlXdXpUTkVKZmtmdGdkL3VFSW1aaG02T0lXME03MndUdkdUZ1pU?=
 =?utf-8?Q?HegcSln3jwTmlzSRiHhgJk/UpdD7caQtgsgRo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB10250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1ZBS2g0OFNpWWtyVWtIbktoZXV4NjBsMFk1aDUzbGpuSDhvSTd4VUxxTlNp?=
 =?utf-8?B?RVdRWWNmb3pIQnNQN0FQSTdWdHI4RTIwOHQyeFBCT0tkdzBNS2ZkcndDZFlJ?=
 =?utf-8?B?NXZPeU56dnQwcW9uek8yR3FkSHNWNENRVlZOM1hLVFNnc2wybkZ1ZmRIWWE3?=
 =?utf-8?B?eVc0TVlTS1BKWWJHdm5UUXpmWWZ4Sk9xaG5Fb1VDcnYwQXVXd0F5QnNROFNz?=
 =?utf-8?B?LzJ2Mis0R2J3N216d2JRUDhJRjJFQk8vd3dhNUpGT2lBS205U0xxazFqY3Np?=
 =?utf-8?B?aDl4ZTUxcStxVlQ0QzVHRGh4Lyt4TVZLdlJpbnoyZE5oU003YU5XenRUVG1W?=
 =?utf-8?B?bHNzQ3Z5YWt1cGxJdVp1K25SME94V3VUVksrdnl1dGtwazJLZnR3QTRZajhI?=
 =?utf-8?B?TU9OM0RHYVlnVkdhekcydzNpVlN3OGFtRjFmMFBadVc5UlhVZ3pseTI0UStW?=
 =?utf-8?B?QU9WUUVzSGRZdXlHdWhrVktVazVvWnlGZStzemlVM0dBakYrbVhNWm5uT0gz?=
 =?utf-8?B?b1hwTFN6UzAzb3A5aVMxYlRSY1M3dzI2Q1Y4akFvRjYrdmZBZjlnanBSOE10?=
 =?utf-8?B?Zmk1dTYwZlZiaVNZT2JMd1Zmdk1BMW02VU55czVrbEVBSmkxNCt6Q2JPMEdN?=
 =?utf-8?B?T0xBeGFmMm1sRm5qbmlJcWVNYjVOWmJWa2EyaXhyczZ0QUdVMmdTRmhxaGZ3?=
 =?utf-8?B?bWR3b3Y0b01PN3BFMUpXVTl2eWt4eVBvNmFkNnQrRUpIeE0vODBlUU1mT2Er?=
 =?utf-8?B?dzRRZW16U2hja1BwaU5wRWNxdExTN1NhQmJWM2NmS0NJbGJjUlNqUVU2bXp2?=
 =?utf-8?B?K2Z3V2RpaEx2QUZGZHZZeDk4NHYrY2U1VGs1Q3NFdVFnZ3NKV2EraFZReERL?=
 =?utf-8?B?THZraVFURTVQTTZWbjVMVDBnREF4RnVrZlMza0F5Vlcxcy8wZ0V4NlRueDFG?=
 =?utf-8?B?eVpyRzN4Ty9YZVZ6T01Ebm1xNmEwekNjZGVFSFA2WGJGMUk3VGdwZVAxeXY1?=
 =?utf-8?B?bC9WYWlndVIxQ2ZWK0ViNXVOUHdVd0JoWUgxVDlsdHQ5VmtjNTVVWWdhbkxD?=
 =?utf-8?B?bkllRnQ0bUpkRXh6MWFOc0tMZHN3ZEM1Q3hjMEZ2WXE0bjlvakNXdkJLN3Nu?=
 =?utf-8?B?aFRuSmJjU20vTUx4L2dWTTY1NmQwN0JWWXBXS05kRVlVamhUM1VYNnZCUEg4?=
 =?utf-8?B?NjR5SzM1NmFNN1lEaytZaUVzdlB4UGQ3M2ZLcDEvUGYzL1dDNVAwdUxpZHE0?=
 =?utf-8?B?ZkdNN0ZaUityOTQwdHFoQzQ1dExRR0hkb095TFJNdnBwOHlkUDhJT1JZbEtl?=
 =?utf-8?B?d2t6RjM0bm03UVV5d241R0YwK0JxMHhCbXJWOERvM0JtcHdXVnd2eVIvYU1K?=
 =?utf-8?B?dDNuQm4xaS9QdTQwd2Q3T2o0VXA0LyttenlPWHA2T01PNForL016L0RaZ04y?=
 =?utf-8?B?Q0ZuWTQvUHlpYUo4WG9GTEx3aXN0a0tudVdIZmVhRnZ2K0k2c1BGaWF1R0dq?=
 =?utf-8?B?Vkl0Q29HQjBnUTNFcHdUanlBYkFnMzNiTkhmeklTejBHSTFBWUZzTnFvWVRF?=
 =?utf-8?B?MG5rWFNYcVlSeS9jWWMrbDlTaG5mSUFRM1owYUhhUGpwaXZRWGQ3a0Q2UUFa?=
 =?utf-8?B?UytSdkhmb2RkWWY5VGZsd1ZYTE1vUE8zaVl3MU5HelRoempmQWRoOE94YnI5?=
 =?utf-8?B?SVdzZ0FLckgrQUJWQ0JsdGdwTGxndmRsVXVuNGlwWmJ4dnVDS0ticWkyczJC?=
 =?utf-8?B?bDZPV3crQVppb3VJTHBPOVZxY2N2a1FpZXkwcmd1NVAwcUtQR1piM09pSlVD?=
 =?utf-8?B?WFQ1WE9zb0VyblhTbWd1aWFocVBsSEg0WVJMbVlTVDBSUGNudUhZRWl0R0g0?=
 =?utf-8?B?MXF5d3FpbWRYeVZ4RkVId2JKVldLTitIV0NOcXdJOTZ4OE5VcTUyOHkrK3Nn?=
 =?utf-8?B?TnkvQm1mdzV4bUlqRStjd24yZFBGSzI3ZE9LQVlacnp4a2QwU2F3ekFLVWp6?=
 =?utf-8?B?dXl5WEpUVWhURFZtZ2VTWkM2QThGckZqOUM0VHVMdXhUZWpUaUM1NzJpdEsv?=
 =?utf-8?B?VzkvWUtoTmh4SVp6OUlCTjhRSnowdGw1eEpIMWNYYnNrSHZubzFGN0pDMS9P?=
 =?utf-8?Q?uJ4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mDTMVE6I6jKmy9WJVJNQGE8LKkVGPt5RJ5yIbpAwjhPCVyurXqn698SvtIug5VVZ3D00FZnuQDuB+xz8xqS9zxFXsc52tg0/9QuAvxRnc8qfhieh15YTILNRV7lobpqdde8q4ZP/1GhKh+JWQNpWu00uj/T0uquNbBHG1i89DkEYZxNBF7oO6ft+vLAZak39ImNQ60G84sICzhS443bZ9HAfJWm3+ivI07RQjtbi4vacY7KIgF1L/YauFDyEvD8kfZ4WkRLMpAdIpNTKlWhLWoSbhwbBENpK73SgEikjbSIoKhI4gJ2fGJ8++f56U0OUsQmeiIFv8mP20B0R38kGYwEvrFC3ewG5gCexjvyqFYWFFSRXSRItwR0WxOyvB5S7fqAov7Oj7XwzmtrLJt/ctB3NWBPhHzB1Z1NTGcks8LK+Vk8OqxsalMViJzKoekpa7wkytGKFpLpZsMq5hSjE9mR03T4ky68zP26ielBdA4ufa5vKRmD7sJf70EI+0Ppq3s9sjXnnx0Hzt3u+HcG368NkUKczfBWZD+s7tkCDFl1v/KOyVLGK8YREJGDTgqEVyTxSkz3evNv7w9uByj+rI5ahLApR76BJgE0tzplRNGfg213pQVe91EwVnlPEQQS1
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7673209-4259-4b1c-c90d-08dcf2ce67fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 19:19:10.1288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: noDylCkvYQ8PgW+E+Tg6DEjuYx8I/Y0h7gpnNfG2a2ib9ssoARn9jag7Ope/xnk9q+ww5IEyHG2wVP8i5X3WHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7125
X-Proofpoint-ORIG-GUID: oANFnm6ZLQMsZwYcS_zNl0kj3XpBsNtC
X-Proofpoint-GUID: oANFnm6ZLQMsZwYcS_zNl0kj3XpBsNtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=925
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410220124

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEh1dGggPHRo
dXRoQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjIsIDIwMjQgMTo0NCBQ
TQ0KPiBUbzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgbGludXgt
DQo+IGFyY2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC1oZXhhZ29uQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBoZXhhZ29uOiBNb3ZlIGtlcm5lbCBwcm90b3R5cGVzIG91
dCBvZg0KPiB1YXBpL2FzbS9zZXR1cC5oIGhlYWRlcg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFp
bCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YN
Cj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+
IA0KPiBPbiAwMi8wNS8yMDI0IDE5LjM4LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gPiBUaGUga2Vy
bmVsIGZ1bmN0aW9uIHByb3RvdHlwZXMgYXJlIG9mIG5vIHVzZSBmb3IgdXNlcnNwYWNlIGFuZA0K
PiA+IHNob3VsZG4ndCBnZXQgZXhwb3NlZCBpbiBhbiB1YXBpIGhlYWRlciwgc28gbGV0J3MgbW92
ZSB0aGVtIGludG8NCj4gPiBhbiBpbnRlcm5hbCBoZWFkZXIgaW5zdGVhZC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiA+IC0tLQ0KDQpS
ZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQoNCj4gPiAgIGFyY2gv
aGV4YWdvbi9pbmNsdWRlL2FzbS9zZXR1cC5oICAgICAgfCAyMCArKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgYXJjaC9oZXhhZ29uL2luY2x1ZGUvdWFwaS9hc20vc2V0dXAuaCB8IDE0ICsrLS0t
LS0tLS0tLS0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvaGV4YWdvbi9pbmNsdWRl
L2FzbS9zZXR1cC5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUv
YXNtL3NldHVwLmgNCj4gYi9hcmNoL2hleGFnb24vaW5jbHVkZS9hc20vc2V0dXAuaA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi45ZjI3NDljZDQwNTIN
Cj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL3Nl
dHVwLmgNCj4gPiBAQCAtMCwwICsxLDIwIEBADQo+ID4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChjKSAyMDEw
LTIwMTEsIFRoZSBMaW51eCBGb3VuZGF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiA+ICsg
Kg0KPiA+ICsgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KPiA+ICsgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhbmQNCj4gPiArICogb25seSB2
ZXJzaW9uIDIgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uDQo+
ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBfQVNNX0hFWEFHT05fU0VUVVBfSA0KPiA+ICsj
ZGVmaW5lIF9BU01fSEVYQUdPTl9TRVRVUF9IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8bGludXgv
aW5pdC5oPg0KPiA+ICsjaW5jbHVkZSA8dWFwaS9hc20vc2V0dXAuaD4NCj4gPiArDQo+ID4gK2V4
dGVybiBjaGFyIGV4dGVybmFsX2NtZGxpbmVfYnVmZmVyOw0KPiA+ICsNCj4gPiArdm9pZCBfX2lu
aXQgc2V0dXBfYXJjaF9tZW1vcnkodm9pZCk7DQo+ID4gKw0KPiA+ICsjZW5kaWYNCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUvdWFwaS9hc20vc2V0dXAuaA0KPiBiL2FyY2gv
aGV4YWdvbi9pbmNsdWRlL3VhcGkvYXNtL3NldHVwLmgNCj4gPiBpbmRleCA4Y2U5NDI4YjE1ODMu
LjU5OGY3NGY2NzFmNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2hleGFnb24vaW5jbHVkZS91YXBp
L2FzbS9zZXR1cC5oDQo+ID4gKysrIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvdWFwaS9hc20vc2V0
dXAuaA0KPiA+IEBAIC0xNywxOSArMTcsOSBAQA0KPiA+ICAgICogMDIxMTAtMTMwMSwgVVNBLg0K
PiA+ICAgICovDQo+ID4NCj4gPiAtI2lmbmRlZiBfQVNNX1NFVFVQX0gNCj4gPiAtI2RlZmluZSBf
QVNNX1NFVFVQX0gNCj4gPiAtDQo+ID4gLSNpZmRlZiBfX0tFUk5FTF9fDQo+ID4gLSNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+DQo+ID4gLSNlbHNlDQo+ID4gLSNkZWZpbmUgX19pbml0DQo+ID4gLSNl
bmRpZg0KPiA+ICsjaWZuZGVmIF9VQVBJX0FTTV9IRVhBR09OX1NFVFVQX0gNCj4gPiArI2RlZmlu
ZSBfVUFQSV9BU01fSEVYQUdPTl9TRVRVUF9IDQo+ID4NCj4gPiAgICNpbmNsdWRlIDxhc20tZ2Vu
ZXJpYy9zZXR1cC5oPg0KPiA+DQo+ID4gLWV4dGVybiBjaGFyIGV4dGVybmFsX2NtZGxpbmVfYnVm
ZmVyOw0KPiA+IC0NCj4gPiAtdm9pZCBfX2luaXQgc2V0dXBfYXJjaF9tZW1vcnkodm9pZCk7DQo+
ID4gLQ0KPiA+ICAgI2VuZGlmDQo+IA0KPiBQaW5nPw0KPiANCj4gICBUaG9tYXMNCg0K

