Return-Path: <linux-arch+bounces-8013-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B599997D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 03:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A171F23A7E
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1718039;
	Fri, 11 Oct 2024 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bV/HRVfW"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021114.outbound.protection.outlook.com [40.93.199.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30FD53F;
	Fri, 11 Oct 2024 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610496; cv=fail; b=W5OuIPwyhq5JF5+viBj1mNIkKzv4fM8BvR7TSWpaTMORscwF7BS4YoY1HRPYbUfm58AYjzlaaaXlfuWHj5dNKIs/z+WLU3Tjcrc52AlJ+z1wvzRFHZtqK+/mC1gH3CuYluPNlzrhIm160ZDVc48vmlloUfyv0Dh6DRX2ozpoL+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610496; c=relaxed/simple;
	bh=EqPgy2eZie8Rdl2Rk9BddKlOYh+F51/EpfIKknBs574=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WndchSzgzhwWZidq3T/lHF84GWlDqM7yv0tKSZ7kpl3uBpecJtBjhroG+iv1c7RbieGng9tZGIPnBUK1SjY0E5R3JSAztCbJmW+PwByn7uE0M1iWc/+TjELTAiITBEpvhW29WPF5NrtxYk+iMT9gMlYIgmMhusDf4jIIEQlhQlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bV/HRVfW; arc=fail smtp.client-ip=40.93.199.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIwnlJSxQ8ao4ht6qijbySyVmFUF9z8RtbRLxWCWX63L/MNDztIHgYi6/8W+2qrsGmoC3fr9iGTtMs4fDYPiNZjTv3We/AednAdE7S7xExPBNNsmmt5oyvxAwAB0gv7minRRRL0u7yCCw3QRtdYZXQt7s58Ozs3fpk+zrvgeydg7HIXAhPg4Ct2PufM0SOCtWzQ6nSrjrN/0r/bK9H+Br9TG17Ocp39phWEASj9bG5EXfMix9TUHr6Z+7JLo9Z/fH+TbbDluWtrvbbc2F5RxafeeSMqXvMZ1TWPXXFOOBUokHfy+nzslrnyzNUdX3nEznn2A9aQ9+G9dDhDd+1lbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqPgy2eZie8Rdl2Rk9BddKlOYh+F51/EpfIKknBs574=;
 b=gL/50jbo9xEOPsOXh3JpMyR8aQ1GbIq1yD8a+vwzB1fZMk0CxDPVnv0TJpTqLZFU1+SQemL4yIiA61fAxOaKb2+CHyjZ0tRg4egTsePU8zIn+YTFcPxHq7Fr9q2Ii8aH62Mi3O+MCYqfX7ITkZNh9yLQ24tblolgs+ZGfuuKxV1ltB1UJ9ZTUBSW/i45g1OaWS6ft2KKhgndyf3HyuyhLFGUWFV6608s8zHKwAZsUhFWdMu24XkWA5wKLguRqnxHDVb2qdiMNtPQu70WMJ8A45FymSaqRHUSzdLvoruKpkXzZHcxEvgIlKNbsJMgP4/6njxSVENvyxTL7eLMVoBqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqPgy2eZie8Rdl2Rk9BddKlOYh+F51/EpfIKknBs574=;
 b=bV/HRVfW1JD4Lz9i2dPVE+gllRFWU1hKJ8HwTmkGruC1EXT8vzYr8L3vP9nT+yVe0eQRM3SRudYAqojv9C9eYuHKPA7mA9uTSKt2KwVUnUN5kIH9GyaG0qq1c5aQ2tk2vHa446qmH+WMHVwyis9e7/7mN8ycluurOdW3ffA0S/I=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DM4PR21MB4542.namprd21.prod.outlook.com (2603:10b6:8:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 01:34:52 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%6]) with mapi id 15.20.8069.001; Fri, 11 Oct 2024
 01:34:52 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [EXTERNAL] RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Topic: [EXTERNAL] RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Index: AQHbFc2d921TyvkcUEW4tDmfs3GIsLKAVtYAgAB5FwA=
Date: Fri, 11 Oct 2024 01:34:52 +0000
Message-ID: <d70bbad7-bcad-2031-a4e1-755b502422a4@microsoft.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DM4PR21MB4542:EE_
x-ms-office365-filtering-correlation-id: 0e951dbf-d416-4fb7-2290-08dce994e76b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0IwbC9zMWNqb1FrTVNtZmdRRkl5Qk1pWVhPMXlxekFGMXNyWmhFeXA0NXR1?=
 =?utf-8?B?L2ZTSjdqenZCWlFaOXl3NTRzQ1drUE8wd0FMVlBwV0NPSDlZcEhXRUNGN2xx?=
 =?utf-8?B?VU9Wb2dLYi9mdHZxdGNyTmt5cEJwdW5Mc05kNkVBQzNVOWY4V2hQZVFmdUNN?=
 =?utf-8?B?NG16VXg4TlgyRHRpMmEyMmlwdFB2RVRMc2FvUnZaM1lYV1ZLcjNjMGZ5UEdG?=
 =?utf-8?B?cGpzWURVZXRoalNyM1ZhWjhQcXB4QWlKaTl4RFlsMGR0RmFJa2ZsbnlvMHpj?=
 =?utf-8?B?cVpXblVUODlQbFFFVEN2aXEwVytjeUVzUWNhLzBoSTgxbWNUNXpLYTJpVnZX?=
 =?utf-8?B?bVpLU05lbDA0N0Urd3hEMGlYRnZqeUM1VXF6YzBUMFpVelZ3ODIyR0d3REor?=
 =?utf-8?B?MkQ3aWxlYUd4Tm5UZTMyTDc0S0FBZnlneTEwV09vL1cwSUFtTDlSWk53UkpW?=
 =?utf-8?B?aVJra0krWlUvUU1mV01zU0lIbnVpWkZKV0hERDVuR1FCMlh0ZWthNCtGdGl1?=
 =?utf-8?B?UExXaTBzSEJncGx6RUk3OUNLTDFyZjdqRUorK0dxV25OZlJzdm5qeU1SK2Va?=
 =?utf-8?B?ZEZCOVJ6S3JIcWt5K0tnSUszdVNFQno3ZTk2K2c0ak40dmViam5yRXN0ZjJJ?=
 =?utf-8?B?dVdTSGJJbWs3VjNoQmpRaWVKaWVyRHZqcHY1UyszK0dMa1RRa2xHYlJ2TDcy?=
 =?utf-8?B?ZnBteEQ0VVV0b1lnNzVQVEtwMjNHSUlDSTdHM0c4RVlvQmxCY0U5enhSSnVQ?=
 =?utf-8?B?VlkvN3FnUHFxZUNtaElFOHFMbFVEa25BakpnaWFCMjFPSVltUlc2Zk80VVB2?=
 =?utf-8?B?VWlHWFpkUWVhOFhNTGRFQlAwWk44NWxTdm15c3VjRmpzYVJVcWNMNWZRWVM2?=
 =?utf-8?B?STc0UnpRZm1QbDZpeVAxR3BTZXNaTlBTOVJ6ajB5ZDN1U0ZYOUVqTUt2K0l4?=
 =?utf-8?B?WHJ5a2ZTTzdCVU0ydzVHSUFndDhueHlKMnd1dDV6VFRGOU5hUTlUQkNObjZp?=
 =?utf-8?B?Y2ttVzExOXQrTDE1TWhEazR6Vjc4VHBoL0ZIbVdXdUhoOUx0ZVN2OHpkR0VK?=
 =?utf-8?B?VWcyQ29XV29DVmtBcHRKalR6VEllcFZvaVNCOGpXZFd4b3R2ZEZXSFpqRUda?=
 =?utf-8?B?M01VejJFWEtVNDRyTjNBelh6OSthRlFKR2pTWlRDTERDUmoreDl1MnlrY01U?=
 =?utf-8?B?Q2dqOTVVcTJ2VjhQeUJmQUNOZEJWYTZHYm5XZUdKenJidUovRlVjeDNtTmQr?=
 =?utf-8?B?QTZKcERKN1pjOHEwZVI3ZHlqaGpiSTAzdHZRUzlDQWp2NThYSTBqUjM3NUZj?=
 =?utf-8?B?dEE0NytLSVM5bS9DaU96NVdVQXpncUt6cW1aaWt0SDhTVGVEb1VmZVhiWm9L?=
 =?utf-8?B?cU8zS0czaWJDVGFyZGxSY2lDYk1mSjhCSWdlZ2JQZDNaS2E0MlFUcmlHUE1U?=
 =?utf-8?B?ZFFZcWxVZVZRYi82UFRjQUNMUXo0cFZ6ZDJZWFB4THJjdk1wcVViNHBOd1Y5?=
 =?utf-8?B?QkRIMjJtSjJtQmJQeXB0anFaMGZ5Y2d6bXNOejJOYVNtY0hmK0h0REN4bWdY?=
 =?utf-8?B?OUxoTEVMV0pvLy8yV0pOS3VXZGRxMU1NcWozUXNid09OUW4zdjJsaHhLMEUv?=
 =?utf-8?B?NENSWEJmQ1JwVXpDd240MTY0d3ZmQ1Y4d0FEcTIyUWVYSVdoNTN2N0t3Rkx3?=
 =?utf-8?B?NHM3SkpjOXhHMGN3eHNEQWUvK0Voa1dBVjgyZlBFaHhiVjM4QkQ0S1kwWFVC?=
 =?utf-8?B?WGhSV2FabWkzQnJ4aDB2Zlk0TFg1WUZFTTF2a2JHaGgyaklkY2FqTDFuTkRW?=
 =?utf-8?Q?Ds38rXHLIyPQYn77OSpIC6E93OeptRu4pnU3E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkVsMXBjRkNyeXdzSVBFWXg1RHpLYTBEOGVFbDhNSzFDT0hCQU1WQTVXaGVS?=
 =?utf-8?B?Uk8rUDFYQTVXLzAwendyekhBRjQ1Y1pOSHlmeEp4aEFCQ3VmdFZBdGNDa2pO?=
 =?utf-8?B?Q2dqanJ6cUlaNndmRDVTSmozL1ZEUXpTT3MyelN6dS9lQkNLeDRMbDB6VkhV?=
 =?utf-8?B?TG5YQ0s1V2xZMDFBdkwvZkpTVUpUYUUrVEtOaTlNbnBlbllyRjlnN1EyNm9k?=
 =?utf-8?B?UmJ6R3pjUGF1ZjE1K0RxWjJvSVFId1J2MVlVYkFzLzA5bVdHdjhTaGozc0do?=
 =?utf-8?B?MGNLZU8vazZYeHJGaWNkM25YVU9OdGV1bGNJTXV0bm5GSnlISmZaYng3N2pY?=
 =?utf-8?B?ZzhwUmR3QjVxVEZUVkdmcHpFYjBLN3BHYm9lSFBHaXhyelpmaDArT3Ewd1Ev?=
 =?utf-8?B?TUVDTE5PbklpYkYybDEzcXFCUXU0ZlMvUXI5YVZKV01EdUNOM3I2T1FiYkJi?=
 =?utf-8?B?ZlkyS0syd2pKYTdwaUxsRjlaYWNpNmlHWXdyOXpGVDFCdXZkMDNMSEgxWmNW?=
 =?utf-8?B?YS9yMGZTd3BxUTlvUnBiS2JCYlAvQlpKRzdjU1QrR1JSNVNpdEhhaHFiTTFs?=
 =?utf-8?B?VHRUa2RtTVdnUG5yN3RiV2VRc0FwWEgwaDVVYmJSUnFGdmRIcFZHV2NFL1Fj?=
 =?utf-8?B?b1dsd3dKS2pkREJPRCtzRUlGZGNkLzNuZlBwaWdYMWx1dHZkUDlMeEFxWkVE?=
 =?utf-8?B?ZXZ5a2VYbjZYdHZ2UGVkMTQxWmNxTnFmeTAvWHVoQjhZNEx1RHFLR09aaXgr?=
 =?utf-8?B?MjFEc3phMFJPRzdnR1hwREpvMi8vbkltRGcyK0s4dHlFZTFtcFZDcnQ3cnl5?=
 =?utf-8?B?SFJxa3dXWmI4alBhblYyZkUzZUdzejFSTlNCV0xJNjFaS1BnR1lmTnYxYzhX?=
 =?utf-8?B?QThUc3pBeGZ5TllQY1FRVENMYnpLYU5IbjlEQ21IMDhpb3pqSVMyMVhwZm93?=
 =?utf-8?B?ZU1Fc0paZEV5TlhMYy9DMmoxNkFNSVBHbUY0bzZUU0J0Um9tK1dleVlzaWZ5?=
 =?utf-8?B?Vm9tM28wTVVQb2IzTi95QmJDbWh4K2xrTTEzc3pVVVV1RUVWd01qTFRYQXBZ?=
 =?utf-8?B?RnVXM21VVWpRMjRsSDlrN2M3NTlJY3Mrei9QTjhxRWk5aWticzY2Z05xN2ZJ?=
 =?utf-8?B?YkxQaVZrSWJtMmIrdWdGUU9BNnBFYnZISEFNTUg5TUJPY25IT3d5T2NxODNn?=
 =?utf-8?B?cTdtaytYSHI3M0p0MUxGRWtFTnNHVWZCZjN3RXNmSjUwWnk3SjBubGZITWJK?=
 =?utf-8?B?eGdHSkFDWVNsUjdDZi9zb09lOG9vcnNuaHZXUWNmbGtPZCtVd3FmNjJtcUZZ?=
 =?utf-8?B?b0VaT1R6eG5kUEt3a3htNEN2M3gzUkw1N2EwdTVQcVNYVEVoRlFPQzB4VGNq?=
 =?utf-8?B?L09FRHQwRHFObXp3V3pGUXExKzQvdjdlUXBwOG1QYXREYU1LeHcxWTRlYzRo?=
 =?utf-8?B?SkNYK3VCeHJRUjZZQUszdmVWWEE3YXh6Z2hBYmZ3QXF3bk85TDAzOVd2eFND?=
 =?utf-8?B?OFVjOG0rekcvZDZPTmhTeTJHQ1NERktZY25iaVVrYzJiK2pNeVJiQkVQN3U1?=
 =?utf-8?B?ZFN6dlByV0JtaUUrdWJTUEJyTStmcEtpTHhONDNVQjBNMXc2M0pBVDIyazQr?=
 =?utf-8?B?Nkd6WFdSbnJKdEpNbUFnOEZaM2ZOVEhSN2U2WHFuYnh6UW1xbkF6VUxqWVcw?=
 =?utf-8?B?anpMeWZtQXNFcXRPNHZ2Q3UvRE5saTROV1EwTGN2REJrQ2I5OTYvQUVJRjh3?=
 =?utf-8?B?eTNxYVdDRXFKUnJJQlhmK2pjUGVrNHlJS3Z1U0NqT21VUFkzTmEreUE2NkJF?=
 =?utf-8?B?d09va1hnTnUwdDNZMmcwQnRMMldKcnVVZW5sTGwzLzhpSWlxUWQrUFBWTWdE?=
 =?utf-8?B?dnR0SHJyQUdDTkxWZ2dWSlhLMlJCMEUrOURqbFdod2s4N2xibXBVNVdoMXhK?=
 =?utf-8?B?VTJ3KzZpTUs2ZTRPRVhsUVZQT3M2a1RGdGtnUU9RWWhKSysyZmhIajVxNXRM?=
 =?utf-8?B?Q2theGFLbXZTSkFreHBqbVd0TFljNW5JelBTZ3RRVEF1VTltY3dqU3JQVk4y?=
 =?utf-8?Q?wO0S+7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <496E8473D040044697E092A53624EA36@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1434.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e951dbf-d416-4fb7-2290-08dce994e76b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 01:34:52.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYif6wrlzdAFlT7e7WJy1WAi9WINgFOEh4rBCXMFdsLbx1yql2DkA/7foQdVgv2aPDltCktZCAXr4hxVk8P2F8bE2DvA5PUl3TuFSyJdDro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB4542

DQoNCk9uIDEwLzEwLzI0IDExOjIxLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCiA+IEZyb206IE51
bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogDQpU
aHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDEyOjUxIFBNDQogPj4NCiA+PiBUbyBzdXBwb3J0IEh5
cGVyLVYgRG9tMCAoYWthIExpbnV4IGFzIHJvb3QgcGFydGl0aW9uKSwgbWFueSBuZXcNCiA+PiBk
ZWZpbml0aW9ucyBhcmUgcmVxdWlyZWQuDQogPj4NCiA+PiBUaGUgcGxhbiBnb2luZyBmb3J3YXJk
IGlzIHRvIGRpcmVjdGx5IGltcG9ydCBoZWFkZXJzIGZyb20NCiA+PiBIeXBlci1WLiBUaGlzIGlz
IGEgbW9yZSBtYWludGFpbmFibGUgd2F5IHRvIGltcG9ydCBkZWZpbml0aW9ucw0KID4+IHJhdGhl
ciB0aGFuIHZpYSB0aGUgVExGUyBkb2MuIFRoaXMgcGF0Y2ggc2VyaWVzIGludHJvZHVjZXMNCiA+
PiBuZXcgaGVhZGVycyAoaHZoZGsuaCwgaHZnZGsuaCwgZXRjLCBzZWUgcGF0Y2ggIzMpIGRpcmVj
dGx5DQogPj4gZGVyaXZlZCBmcm9tIEh5cGVyLVYgY29kZS4NCiA+Pg0KID4+IFRoaXMgcGF0Y2gg
c2VyaWVzIHJlcGxhY2VzIGh5cGVydi10bGZzLmggd2l0aCBodmhkay5oLCBidXQgb25seQ0KID4+
IGluIE1pY3Jvc29mdC1tYWludGFpbmVkIEh5cGVyLVYgY29kZSB3aGVyZSB0aGV5IGFyZSBuZWVk
ZWQuIFRoaXMNCiA+PiBsZWF2ZXMgdGhlIGV4aXN0aW5nIGh5cGVydi10bGZzLmggaW4gdXNlIGVs
c2V3aGVyZSAtIG5vdGFibHkgZm9yDQogPj4gSHlwZXItViBlbmxpZ2h0ZW5tZW50cyBvbiBLVk0g
Z3Vlc3RzLg0KID4NCiA+IENvdWxkIHlvdSBlbGFib3JhdGUgb24gd2h5IHRoZSBiaWZ1cmNhdGlv
biBpcyBuZWNlc3Nhcnk/IElzIGl0IGFuDQogPiBpbnRlcmltIHN0ZXAgdW50aWwgdGhlIEtWTSBj
b2RlIGNhbiB1c2UgdGhlIG5ldyBzY2hlbWUgYXMgd2VsbD8NCiA+IEFsc28sIGRvZXMgIkh5cGVy
LVYgZW5saWdodGVubWVudHMgb24gS1ZNIGd1ZXN0cyIgcmVmZXIgdG8NCiA+IG5lc3RlZCBLVk0g
cnVubmluZyBhdCBMMSBvbiBhbiBMMCBIeXBlci1WLCBhbmQgc3VwcG9ydGluZyBMMiBndWVzdHM/
DQogPiBPciBpcyBpdCB0aGUgbW9yZSBnZW5lcmFsIEtWTSBzdXBwb3J0IGZvciBtaW1pY2tpbmcg
SHlwZXItViBmb3INCiA+IHRoZSBwdXJwb3NlcyBvZiBydW5uaW5nIFdpbmRvd3MgZ3Vlc3RzPyBG
cm9tIHRoZXNlIHBhdGNoZXMsIGl0DQogPiBsb29rcyBsaWtlIHlvdXIgaW50ZW50aW9uIGlzIGZv
ciBhbGwgS1ZNIHN1cHBvcnQgZm9yIEh5cGVyLVYNCiA+IGZ1bmN0aW9uYWxpdHkgdG8gY29udGlu
dWUgdG8gdXNlIHRoZSBleGlzdGluZyBoeXBlcnYtdGxmcy5oIGZpbGUuDQoNCkxpa2UgaXQgc2F5
cyBhYm92ZSwgd2UgYXJlIGNyZWF0aW5nIG5ldyBkb20wIChyb290L2hvc3QpIHN1cHBvcnQNCnRo
YXQgcmVxdWlyZXMgbWFueSBuZXcgZGVmcyBvbmx5IGF2YWlsYWJsZSB0byBkb20wIGFuZCBub3Qg
YW55DQpndWVzdC4gSHlwZXJ2aXNvciBtYWtlcyB0aGVtIHB1YmxpY2x5IGF2YWlsYWJsZSB2aWEg
aHYqZGsgZmlsZXMuDQoNCklkZWFsbHksIHNvbWVkYXkgZXZlcnlib2R5IHdpbGwgdXNlIHRob3Nl
LCBJIGhvcGUgd2UgY2FuIG1vdmUgaW4NCnRoYXQgZGlyZWN0aW9uLCBidXQgSSBndWVzcyBvbmUg
c3RlcCBhdCBhIHRpbWUuIEZvciBub3csIEtWTSBjYW4NCmNvbnRpbnVlIHRvIHVzZSB0aGUgdGxm
cyBmaWxlLCBhbmQgaWYgdGhlcmUgaXMgbm8gcmVzaXN0YW5jZSwgd2UNCmNhbiBtb3ZlIHRoZW0g
dG8gaHYqZGsgZmlsZXMgYWxzbyBhcyBuZXh0IHN0ZXAgYW5kIG9ic29sZXRlIHRoZQ0Kc2luZ2xl
IHRsZnMgZmlsZS4NCg0KU2luY2UgaGVhZGVycyBhcmUgdGhlIHVsdGltYXRlIHNvdXJjZSBvZiB0
cnV0aCwgdGhpcyB3aWxsIGFsbG93DQpiZXR0ZXIgbWFpbnRlbmFuY2UsIGJldHRlciBkZWJ1Zy9z
dXBwb3J0IGV4cGVyaWVuY2UsIGFuZCBhIG1vcmUNCnN0YWJsZSBzdGFjay4gSXQgYWxzbyBlbmZv
cmNlcyBub24tbGVha2luZyBvZiBkYXRhIHN0cnVjdHMgZnJvbQ0KcHJpdmF0ZSBoZWFkZXIgZmls
ZXMgKHVuZm9ydHVuYXRlbHkgaGFzIGhhcHBlbmVkKS4NCg0KVGhhbmtzDQotTXVrZXNoDQoNCg==

