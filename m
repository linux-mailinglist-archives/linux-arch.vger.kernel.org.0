Return-Path: <linux-arch+bounces-14455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCDC280AE
	for <lists+linux-arch@lfdr.de>; Sat, 01 Nov 2025 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606963A5645
	for <lists+linux-arch@lfdr.de>; Sat,  1 Nov 2025 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DBF1F91D6;
	Sat,  1 Nov 2025 14:20:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021096.outbound.protection.outlook.com [52.101.76.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A38B7DA66;
	Sat,  1 Nov 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006808; cv=fail; b=OejA4VRbspPUgJfPMEyIHtbCTaRuJp2/TbQoHEkAiJ7IF8p+aVn04Jnj2EC1YIYlpdUlfQQEGtUKXso2hYgH39oJ4XyhyKsHOQZ6lIMA1c3XddYv4TKQ+hCZ5qTEj3MN67i8dZ3bvx/YwGZpgh1AwWxu9KOzEPPshWZ7WribvTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006808; c=relaxed/simple;
	bh=u1HEicJ8tIEMaP7+VynVhhraWdmFtMRiZG1J0pKTxTs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoAgYsPj0mC9r97I9wor6oMIg+BrdhZf/SFJZEC3aS4+RXYMWVtfjH96O+F28IEFY3uYx1kj5AilbzvI+T1N7I3pTa98ItNUBDE8BxI++MgKVzn74uQRpRjthgTXwgHnez6b+R7qtn7YU55f5plqYwvcCmPvjgqNOHY4doN0Www=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=icemanor.se; spf=pass smtp.mailfrom=icemanor.se; arc=fail smtp.client-ip=52.101.76.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=icemanor.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icemanor.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBsX92ng0YCYxb4gEHCuuK6716VP5EuB5+2o16v2/B/+1CAN6VEPs5ZyfhawSXgvrV4tw6aXMAwTURSm4ly1fzZ854Iln95hAMxbJVSGgwmZjuGogADlOaiPAVCYBOa+3WspKs3xxX3eCSAL7ClgkdbGNoLdIc3a/PHe1IxNogT0PaFcGI/SBBEham/x0K3Vxwdu0Nu03EkA0MctObiXvi3yDuN1g9M/1uasIt1HD4mxOEWlofH0soeZ0sbWWx3PYqgVwMVSMho99BUDGa1pBxSnEias9BvCOlUgznJuDRmDd9QqWmdewzFzCAUCX50S8zj3W48UPcN2BjkvBZHOTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1HEicJ8tIEMaP7+VynVhhraWdmFtMRiZG1J0pKTxTs=;
 b=tBhJjzVb8WSm964OKyQrjoYbl0842atsrGPah3OV3AzO0KsAr2vb1dnSyNN136F+224bD0tAD4bXFJOuiw3DN49wVNbUGvngfkLyAs6F+gSr4ojBeh4lXAnbdk2uPeWqVb3/TGD4rZMR/aZ8Ft2Ds5TsFUKjmx5n8t1W/D6BvDGDFdiltbl18m5eiQ+WLqxvgpGKTrA2MLsHPkuugh/oa2if3PwSZsIIDdF2emRqqsJ8yhwVbj3hDciLpUT55zdfioAUXhcJtzt3Awh3D7l0cBenk5sNhgkapZI/N9Dftt+ZS2sDO30zNYKgpHeAkjr+VhTSjW1K0+pkwOOqmPGDVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=icemanor.se; dmarc=pass action=none header.from=icemanor.se;
 dkim=pass header.d=icemanor.se; arc=none
Received: from GVYP280MB1586.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19e::6)
 by GVZP280MB0895.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:19:59 +0000
Received: from GVYP280MB1586.SWEP280.PROD.OUTLOOK.COM
 ([fe80::af0:e631:7d37:d0d0]) by GVYP280MB1586.SWEP280.PROD.OUTLOOK.COM
 ([fe80::af0:e631:7d37:d0d0%7]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:19:59 +0000
From: Joel Severin <joel.severin@icemanor.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Port of Linux to WebAssembly
Thread-Topic: Port of Linux to WebAssembly
Thread-Index: AQHcSzkr7lV+FMm7/kSfIOHGCoI3srTd3sQA
Date: Sat, 1 Nov 2025 14:19:59 +0000
Message-ID: <618f3602-03aa-46a8-b2d4-3c9798c4cd2b@icemanor.se>
References: <f9b5a1db-681a-4ac2-888a-2b8228976e53@icemanor.se>
In-Reply-To: <f9b5a1db-681a-4ac2-888a-2b8228976e53@icemanor.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=icemanor.se;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVYP280MB1586:EE_|GVZP280MB0895:EE_
x-ms-office365-filtering-correlation-id: cd0525a8-e731-4f6f-7339-08de1951bd5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Syt0T2JFb0xWVGRRS0FtNUs1NnYyVlA1QlJXU201UWtnYTVKcUlhN1JPN3R4?=
 =?utf-8?B?V29NVXJTYnJ2UGROLzRrQ2ZuUmtqR0ZMdlYvTVcyU2lBSFVIeG1PWXF2bTMr?=
 =?utf-8?B?TTNHVk1Ka0xFRDNGQ3g5Qm5sKytaa0lveko3cFQyYUVLTkhkcDBvTGVvWWxh?=
 =?utf-8?B?ZVdkYVdVOWMxZ1lYYWo5UW1XaW5lV29JaC9qQXdPMFMrc3F1d0s3dmRkc01a?=
 =?utf-8?B?ZWpIMzV2NEIzQ0tLTXkvVW5OVlh5Q2lHQmlNcGhVWUxHZzlCWXNRdDNxSkR5?=
 =?utf-8?B?SXhYM3M0VjM2cHg1emI1bUZBaFZnVmIwaTYzbDlnbFByTHZYMG1Fc3FPSW1X?=
 =?utf-8?B?L2szcWVRdXBPZVJKeFgyTmNpTUtRSEM0SkVPTW5Sb2szRWlxNG40bnZsWUtC?=
 =?utf-8?B?aUVLV1VOdURpblB3eDVrL1BzK2NxWFpiWUwyVVg0K0JFc0RxOUx3NEdWNjJL?=
 =?utf-8?B?SFRSVW9NUmVySnZWNXRJdFg0WVY2cDU1ZWlBem5rN01LZzRWblJzZGZxUDMr?=
 =?utf-8?B?S3U5WXY2Y1grWG4yTlZKV1g3dmxiRVV3OEpsS3dnZCs1VHdXb1djbGFQRDM5?=
 =?utf-8?B?ekIwNVFZeUVRVWlKODRDaEk2Y0lkeUhsYW1YeEEwUUFkNWljRVpXeFZKaVJ6?=
 =?utf-8?B?M2E4T3p6blZrOGtkUGw3RVhjbWxVcEkzWUthWXhmeDlUaStMem01MkRYOWly?=
 =?utf-8?B?MHZHeVhOcDYwenV2V1M2bzhPRERuK3k4OHMvT0duUG1wRFZPYnlGcnpIRUxt?=
 =?utf-8?B?eXhaQ1V4cWh4cFpOSE42aG5DZ1hBR2FCSUVWTGExVnVjM1V6dkNydDZXV01m?=
 =?utf-8?B?MysvWS83b2pLczhROXRmY0xkMGg4SFRrK0pneWo5L1lpK1QxRWVZMlk5OXJa?=
 =?utf-8?B?UGw0d1I2TVQxaUxkZUVFcnU2YlNWMVpqUThna1lSYWEvSkkrb1ZRYVMvNlc0?=
 =?utf-8?B?cUduTWh2cjJjUmFPemRBRjhpbzB3NklHQzI3cjN4d2hqRHViQjdpbDBGUGNZ?=
 =?utf-8?B?eFQzQnZXMmw1NVVSVFJXWE8raUhQb0p6d3B6QnRkbHNTVDE5VXhQMlN5S0ph?=
 =?utf-8?B?TVBrdFF4bUk1V1plVXNuaG9ZajJEQlVzVlA4N2hldEZDcTFQWC9xSlpkU3JC?=
 =?utf-8?B?TmhxUFYxZFl3cTI5Umk2eWR4N2lTejdHa3ZnQ1lidGpKdGt4YW14S2dMdkJh?=
 =?utf-8?B?b2VXMUxCUmhIVmhiQVhjdTgyV2xCRVFWbVBZS295cWw2K200UXQxSXlpeVds?=
 =?utf-8?B?K0RsaTNhNFFPODFRK1BkZmF1M1B0c2FUVHNjYjlBVTZjU1A3SkNIUXlFOHdW?=
 =?utf-8?B?TDZCRGEvZEZrd1VMOW44Nm05b0xETDVFRnpHbW03bjlUWkptbXhkcjBMajYz?=
 =?utf-8?B?TVVxNmp4clhSVHhoL1hZQUpvR0grd1RaUTJmS2JvNVgwdUNDcUhiSWZoYWxk?=
 =?utf-8?B?LzFBY1h5cUU4QlBLVUhFdFo3d2RQQjMyZTBhd09GOTVRTUJrZUhCWDN3dld6?=
 =?utf-8?B?VWZ5RmZ2ckhRdW5LODRxRkJ2S1MxTit2Z2c0eHlGc3M0ZlpTTEw3ZHVIazF0?=
 =?utf-8?B?OTBNNGtjOVNOSmJQU01qSy92cW9KRGdSVkdlOWIwU3o1NmpxV3AxNU5lL0s1?=
 =?utf-8?B?SC9adlE1cTMrQ09nb3RPU3pEUCtTVDNsMkFhaXczVmVGb1dzdzJRcXNndzBr?=
 =?utf-8?B?aXFJYWxucHZuNStZcERlYlFPZU9wUTUvWDREU0FQMXpsSlRTS1F2Wi82L1c2?=
 =?utf-8?B?WHRjNGZFZG11dkhIYlV0QTYvbEc4V0VtUmtKUTl1WFFBMnRrUmxXR1crODBL?=
 =?utf-8?B?emJaNERLeGJTZmhvNnM0N29xb3NtcVpFVnBnaHloWWVnaERDNE01ZHlyQ29O?=
 =?utf-8?B?cFJ0bitvcldveDVWL05vbUNvdjBWY0FBS3A0bE52WkN3eXJKeGJSNVhhZjVX?=
 =?utf-8?Q?rC6QoC1BY6ndjxwu2wkzx/njEK3ull0D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1586.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUQ5NFpZR0N2NXRETDFqcERDWGZNdUk3WnpYM3FhdkN2b2tqZHF3SFNYUDBX?=
 =?utf-8?B?d2I2bVRuT0IrOWROWlo1bm1PTXYzM1ZheHBSSnR5WUplSFFURGYvUWhXY0JS?=
 =?utf-8?B?d0o3RDdsWnlualFsdFJZRERiMjVBc0tkTWlHWkNCbkg2aElaSVAwbklldFRL?=
 =?utf-8?B?OVRYdVVhelRjTm5BSFp2NjhQN2ZlUVhEclNTQ2Nla0lMbEswTllFQzFIeDQ4?=
 =?utf-8?B?YkJpWEN2cjZDUjJnOGdkVWRPR3NJU2F6UlAwY1dMYWZzT0JXMnh3V256a3N4?=
 =?utf-8?B?ajJWcG0wWXNyOGlaL3JCTnJjVEFVbmtmcFk5bTJ6NktjcXJGRVlTTHdjNHRv?=
 =?utf-8?B?aXh2TWNrbXdHaFQ1c1lsM2RaZFJqNFpBcnFjWUc1UGR0RmFxUklFSW5wN2tC?=
 =?utf-8?B?SENEa1FKdnhJOW9BM1JHdXV3bHdKS21GUnEyQ21BcDRkWlI4VnBGWXBoRDJh?=
 =?utf-8?B?QkVHdHFDSFpxbWYyakljVlVyYlBBcWU3VG0xc2tBamlZMFp1SGFzeXNjZStU?=
 =?utf-8?B?cGVmMmtTSEZLelVvR3BJNllob2RrSmJReVZMSzBzNkFqQkg1NGVkYVZmS3lQ?=
 =?utf-8?B?N2Y0OUVXYWI4UkVjZEVpRjQ1T3ZhV3A5Yi9WUHhNRDNxYWVrVWFsaXU3ajJE?=
 =?utf-8?B?Nlh2L3pOT2tUY3kwYlg4NGZ6WGhlR3BTY0k3b1ZSSTJnY0E1UVNlSHY5TGpi?=
 =?utf-8?B?Qk9VRzAyQlNzeU11ZVd4RW0xR3h3ZWEveU9NY09MK21mRkR2eWJ6OXhQN3Rx?=
 =?utf-8?B?YXlhK1FCdm43VWEwQTk1UldTVDdYeE9Lc3VXR2pWVG9NOXRud3JobGcyZTdk?=
 =?utf-8?B?U2lSdlNSeXBOZVZ1UnJUdEVkb1dpVUxjZkV6d1JvYjZ0d1o2b01GVVNUbHJo?=
 =?utf-8?B?ZmljQm1zUmpDeW5qVUZUQWJIS1NPczdxcG5GZjdvQlppYUxmYkFTN2Q3bURI?=
 =?utf-8?B?QnNqemJtRWgxTVBTRlFwREE4UCtQOWJlU21ib2ZmM2pzcUtQbk0rZjRNcXZX?=
 =?utf-8?B?SG9XN1h5ZHBHK3gwa2NJRlQrUnNjOFFhZFpKU3p5THlDb2ZhNEJ6eDVlRHc2?=
 =?utf-8?B?MjVpREZrUU5tblY5S09nWktmZnpZbnNnNnpiRE9zMU9MLzNlYjNWUlRIaW1v?=
 =?utf-8?B?WnhrdWxhYnNkQ3RhYzRjM0xSWGdZc1gvNXdLYXl4SmhSTzNwWVIxTzFxUldY?=
 =?utf-8?B?aC9Qb1VYWUU1eE1MOEoyMUxtdDkrWGlUY3pLek1NdkpFbFVSblRWdWpWSmdy?=
 =?utf-8?B?RThEWVZwcEVuS2s5ZG42QkZTWnh3eG83ZG5RaXNoaDJZdTVqcDNacTk4c28w?=
 =?utf-8?B?Z3plSzl4N1hQenNmTnZkazBkTVB6TXd6aW1aeGlUTmJyRE1ZMWNEQTVqUnhO?=
 =?utf-8?B?M2llSzZNUzZtckJnMmJEeHNNMkpFTThFNElTNHExWTBIT3pOSkNCTStrcG8y?=
 =?utf-8?B?K2NvcjYzNENSNXRTcHUxc01TcGlxNWExMEI0WWdnQW9nOTN5MGtySVI1N3p3?=
 =?utf-8?B?Z05Hdk02bk9MQWU1ZTBlTXNxdTF3WGgxQTJjQm5taHFkZEgrbWcydVk4Qlh1?=
 =?utf-8?B?ckNFRU1PN3ZTQTEzZkFZY014RmkzeG15RDBNOTFvbjd0Rk5HT3Z6TVZTMXpl?=
 =?utf-8?B?alRkR3BIU1hKNFJBZWs3TUZHbmRKZW1ZUklPK3dvbnVXalNtTk5ReGJiL2J0?=
 =?utf-8?B?M2Ztb0gzQUtPMmUxWHBSV0h5cnNFMXhYQnZtaUJ6U1hjNk1TL1YySFpmLzBC?=
 =?utf-8?B?dDBjeFVBOURSNmZXTERuOURKNU9UN2R2YmIwejZtN0FxQ3Q5emM2aDhxL09V?=
 =?utf-8?B?MkU4dHR2S0h1UnkxK1RnL3UzbVNqN3E3YmtrRy9ZZ3Q2WnRhdWI3VjNkMTRI?=
 =?utf-8?B?ODFMYjF0QUhJR3drYVNrMzcwUEw5bDNMUmdBK3FacG4xOGxyMWpiaWJUSmJC?=
 =?utf-8?B?cCtORnBPODh3Q1gwRWkrd0toZ2ViODZ5dDRic0w5bmFxeXBOYnpiTkRJQzFT?=
 =?utf-8?B?NXBFSC9KdGxCZk1tSEJ6akE1ZDZYMzdiM21JN0FCbW9uRHI2Q21lMENBT2tU?=
 =?utf-8?B?UVZJS1FXUVFTNWR5VVRqanhlQXhqN0FLS05VTzh3T2IyeFpyMFpIOFhncGtF?=
 =?utf-8?B?dWFjQzNTczRpZE9vdXNqRHlLSSs0ejJCdzlJNWxwSERZOStIM1dpNEF5VlJx?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C78EDFC230A4047A2509CAFB877F25C@SWEP280.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: icemanor.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1586.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0525a8-e731-4f6f-7339-08de1951bd5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2025 14:19:59.2863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ef88825-5567-41d9-8ee7-650e451148f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PWtkb1BY5FH+WsxlMUErvVRHFzTHpWklf+tR5Ez8Btzk5N+9fYSvnu1YXzuc8O2bJYZ9PzTSPl0cEXZQJ4HNzLoe4zyeVseATYBG5tEQDeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0895

DQpIaSwNCg0KRHVyaW5nIHRoZSBwYXN0IHR3byB5ZWFycyBvciBzbyBJIGhhdmUgYmVlbiBzbG93
LXJvbGxpbmcgYW4gZWZmb3J0IHRvIA0KcG9ydCB0aGUgTGludXgga2VybmVsIHRvIFdlYkFzc2Vt
Ymx5IChXYXNtKS4gSSdtIG5vdyBhdCB0aGUgcG9pbnQgd2hlcmUgDQp0aGUga2VybmVsIGJvb3Rz
IGFuZCBJIGNhbiBydW4gYmFzaWMgcHJvZ3JhbXMgZnJvbSBhIHNoZWxsLiBBcyB5b3Ugd2lsbCAN
CnNlZSBpZiB5b3UgcGxheSBhcm91bmQgd2l0aCBpdCBmb3IgYSBiaXQsIGl0J3Mgbm90IHZlcnkg
c3RhYmxlIGFuZCB3aWxsIA0KY3Jhc2ggc29vbmVyIG9yIGxhdGVyLCBidXQgSSB0aGluayB0aGlz
IGlzIGEgZ29vZCBmaXJzdCBzdGVwLg0KDQpXYXNtIGlzIG5vdCBuZWNlc3NhcmlseSBvbmx5IHRh
cmdldGluZyB0aGUgd2ViLCBidXQgdGhhdCdzIGhvdyBJIGhhdmUgDQpiZWVuIGRldmVsb3Bpbmcg
dGhpcyBwcm9qZWN0LiBTaW5jZSB0aGUgY3VycmVudCBzdGF0ZSBpcyBhIHdlYiBiYXNlZCANCmRl
bW8sIEknbGwgZHJvcCBhIGxpbmsgYmVsb3cuIFRoaXMgaXMgTGludXgsIGJvb3RpbmcgaW4geW91
ciBicm93c2VyIA0KdGFiLCBhY2NlbGVyYXRlZCBieSBXYXNtLiBPbiBhIGRlY2VudCBjb21wdXRl
ciBpdCBzaG91bGQgYm9vdCBpbiA8MXMuDQpodHRwczovL2pvZWxzZXZlcmluLmdpdGh1Yi5pby9s
aW51eC13YXNtLw0KDQpVbmZvcnR1bmF0ZWx5LCBteSAiaG9zdGluZyBwcm92aWRlciIgKEdpdEh1
YiBQYWdlcykgZG9lcyBub3QgcHJvdmlkZSB0aGUgDQpyaWdodCBDT09QL0NPRVAgSFRUUCBoZWFk
ZXJzIGZvciB0aGlzIHRvIHdvcmsgKHNwZWN0cmUgbWl0aWdhdGlvbiksIEkgDQpndWVzcyBJIGdv
dCB3aGF0IEkgKGRpZG4ndCkgcGF5IGZvci4gSSBmb3VuZCBhIHdvcmthcm91bmQgdGhhdCBvZnRl
biANCndvcmtzLCBidXQgdGhlIHBhZ2UgdGFrZXMgbG9uZ2VyIHRvIGxvYWQgYW5kIHNvbWV0aW1l
cyBicmVha3MsIA0KZXNwZWNpYWxseSBvbiBzb21lIG1vYmlsZSBkZXZpY2VzLiBSZWxvYWRpbmcg
dGhlIHBhZ2UgbWF5IGhlbHAuDQoNCk5vdywgdGhpcyBpcyBhIHRlY2hub2xvZ3kgZGVtbywgaXQn
cyB0byBzaG93IHdoYXQncyBwb3NzaWJsZS4gVGhlcmUgYXJlIA0Kc29tZSB0aGluZ3Mgd2hlcmUg
d2hhdCB3ZSBoYXZlIHRvZGF5IG1ha2VzIHRoaXMgbW9yZSBwYWluZnVsIHRoYW4gaXQgaGFzIA0K
dG8gYmUuIFRoZSBnb29kIG5ld3MgaXMgdGhhdCBpZiB0aGVyZSBpcyBhIHdpbGwgdG8gZ28gZm9y
d2FyZCB3aXRoIExpbnV4IA0KYW5kIFdhc20sIGF0IGxlYXN0IEkgZG9uJ3Qgc2VlIHdoeSB0aGUg
Y3VycmVudCByZXN0cmljdGlvbnMgY2Fubm90IGJlIA0KbGlmdGVkLiBCdXQsIHRoZXJlIHdvdWxk
IG5lZWQgdG8gYmUgYSBjb21taXRtZW50IGZyb20gTGludXggYW5kIFdhc20gDQpwZW9wbGUsIG5v
dCB0byBtZW50aW9uIHRoZSB3aG9sZSBlY29zeXN0ZW0gYXJvdW5kIGl0LCB0byBhY3R1YWxseSAN
CmltcGxlbWVudCB0aG9zZSBjaGFuZ2VzLiBTb21lIGZ1bmRhbWVudGFscyBvZiBlYWNoIHBsYXRm
b3JtIHdvdWxkIG5lZWQgDQp0byBjaGFuZ2UgZm9yIGEgc21vb3RoIGV4cGVyaWVuY2UsIGVzcGVj
aWFsbHkgc28gb24gdGhlIFdhc20gc2lkZS4NCg0KSWYgeW91IGZpbmQgdGhpcyBpbnRlcmVzdGlu
ZyBhbmQgeW91IHdvdWxkIGxpa2UgdG8gam9pbiBpbiBvbiANCmRldmVsb3BtZW50LCBwbGVhc2Ug
bGV0IG1lIGtub3cuIEknbSBlc3BlY2lhbGx5IGxvb2tpbmcgZm9yIGNvbXBldGVudCANCnBlb3Bs
ZSB3aG8gY2FuIGhlbHAgbWUgd2l0aCBhdG9taWNzIGFuZCBsb2NraW5nIGluIHRoZSBrZXJuZWws
IGJ1dCBhbHNvIA0Kc2NoZWR1bGluZy4gT3IganVzdCBnZW5lcmFsIGRldmVsb3BtZW50IGluIHRo
ZSBrZXJuZWwgYW5kL29yIHRoZSANCmVjb3N5c3RlbSBhcm91bmQgaXQsIHN1Y2ggYXMgY29tcGls
ZXIgb3IgdXNlcmxhbmQgaW5mcmFzdHJ1Y3R1cmUuDQoNClE6IFdoeSBhcmUgeW91IG9uIGtlcm5l
bCB2ZXJzaW9uIDQuNiwgTExWTSAxNy4wLCAuLi4/DQpBOiBUaGlzIGhhcyBiZWVuIGEgc2lkZSBw
cm9qZWN0IG9mIG1pbmUgYW5kIEkgaGF2ZSBiZWVuIHdvcmtpbmcgb24gaXQgb24gDQphbmQgb2Zm
IHdoZW4gSSBoYWQgdGltZS4gSSBkaWRuJ3Qgd2FudCB0byBoYXZlIG15IGtlcm5lbCBjcmFzaCBi
b3RoIA0KYmVjYXVzZSBJIGRpZCBzb21ldGhpbmcgd3JvbmcgQU5EIHRoZSBydWcgYmVpbmcgcHVs
bGVkIHVuZGVyIG15IGZlZXQgDQpiZWNhdXNlIG9mIG5ldyBjb2RlIGNvbWluZyBpbi4gTm93IHRo
YXQgdGhpbmdzIGJvb3QsIG9uZSBvZiB0aGUgdG9wIA0KcHJpb3JpdGllcyBpcyB0byByZWJhc2Ug
bXkgYnJhbmNoZXMgdG8gdGhlIGxhdGVzdCBzdHVmZiBvdXQgdGhlcmUuDQoNClE6IFdoYXQgaXMg
aXQgZ29vZCBmb3I/DQpBOiBDb21wYXRpYmlsaXR5IHdpdGggcHJvZ3JhbXMgdGhhdCB3YW50IHRv
IHJ1biBhcyB3ZWIgYXBwcy4gQmVpbmcgYWJsZSANCnRvIGxpbmsgYSBrZXJuZWwgYnVnIG9yIG5l
dyBmZWF0dXJlIGZvciBhbnlvbmUgdG8gdGVzdCBvdXQuIFNhbmRib3hpbmcuDQoNClE6IEJ1dCBp
c24ndCBpdCB0b28gc2xvdyB0byBib290Pw0KQTogQnV0IHRoZW4gZG9uJ3QgYm9vdCBpdCBvbiBl
dmVyeSBwYWdlIGxvYWQuIFByZS1ib290IG9uY2UgYW5kIGxvYWQgYSANCmhpYmVybmF0ZWQgaW1h
Z2UgYWZ0ZXIgdGhhdC4gSnVzdCBsaWtlIGFueSBvdGhlciBhc3NldCBvbiB0aGUgd2ViLCB0aGUg
DQppbWFnZSBjYW4gYmUgY29tcHJlc3NlZCBhbmQgY2FjaGVkIGJ5IHN0YW5kYXJkIGJyb3dzZXIg
ZnVuY3Rpb25hbGl0eS4NCg0KQlIsDQpKb2VsDQo=

