Return-Path: <linux-arch+bounces-7767-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCE3993036
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD304B25558
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B901D2B35;
	Mon,  7 Oct 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bv0OBZhN"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6F1D79AF;
	Mon,  7 Oct 2024 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313050; cv=fail; b=r5/PhFZMZRnDaJtClH54TaqY7xHVk0ASM5fmp8gtaCAbx+14HDdXV0+lHo8paflAxxlPqDZssLmFUukXGG3NsoDlo6YmIQwqDm87HgnTfGbNXb48WAbeBnF8GdNV53gB5TZM9Rjl1GO5AUr9+PYlzBYoGY3dfGosULGnmzBWtGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313050; c=relaxed/simple;
	bh=I1JIFuH2rjSjDguIy7CQdK8paAmhMyTU79H91qU+LO0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ezx6weILiJrFkmScGP1ieELR6wINstHsksv7itCJxcbC+XuJlzMkBre5/s4e67OXJ7AwgrqJ1aoVIzOOz8gdJg69Pv8tO1nfZO0nETplZ01uB4hF00BXZt6cvOOfH1BO0onG+LWP2QaNhlG9ChBPxcUYoFpLW0G4sFY223vpZHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bv0OBZhN; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NycTIc5ytfv6/O1mJI35XlvjeFd/YeyzWP4j//sdLyBZIBhkpGn4SYDxxe2twZuSEKuaKItuHBC43ztWC0oFQGrmLe7semw/TwaqVuDtGRPII1w4qBHkeZF+oZvJNAB0RtpPARnjwijBfW/6sX21X8dRaL4PTWAfnvgZi1eZQyX5KzncAINHiVi4sHXbjeD8OtFoqPtm+F9xRkRxr8x3PvU5hl7we09Bh9mdSP2BazQFmPZ3OsryU8uFv59pLhWgDd3LLHpZmh46qTRYsosZmtapJ9jm7UjEu4I45Oezf5TqD71TVNbb6sTNhygXGgOVFfIA1PrbQEfk9GfWlyHYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1JIFuH2rjSjDguIy7CQdK8paAmhMyTU79H91qU+LO0=;
 b=Yq1oxB8YuvxCnNOva7eTXu0XEblZfC651iKqVv6gyc8tnzfVIAqPEOlpJQByK2ZA6qlKxqI0u2GaowmCaCZy2h33Eo11r6qvs6M4q65e0enu0gz143Ibu+lYjNBQOnYxhfiIzO3HbqKM9JX6E3GRlb/Sr2MKyE0TBAKnrbq1TiyiwFIu6s1F51RMsjwGqzrm3hsSRUQ/DvI7mc3Q72XchejqdczBNtIPo8cvquhKMTbX62Mr948+P05Rj9h+LpbAPDbmrI+p8hop0jxx/YsxAxRftMl6VFs5Ci6TWyEcPo4/MfIiH30FsjJhEZHgLgP01mRqgMhAaPcPm9vraM3J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1JIFuH2rjSjDguIy7CQdK8paAmhMyTU79H91qU+LO0=;
 b=bv0OBZhN9/+x6z9X10u/Pafc/E2wFcgztuUss+xqzr1MbExCAjTepVaTjv6/Ud2l77wpF3yNCbcN0RiRgchHn+TzdGNZb4OmlZ9xmYJvOnYUyUTP8JmkXDaKjD4/mYKPxUt2NgCyVgkbgiBB8Y6IydUHcNg3Ivg68wT97HrYG106RLWRlRVW1ccLlJpQAxzM3bw35I9cMpypEeDP2NnHHOOfgL2FTzD8W4xVA4Ueo3ctrR2GxDR00qHT/f/7EBRfbSkXrypToazZV7oIKuMJzFDgPmtcGddwaWk2Lh+YlnS1L1x5+a9A6ojuBbhLZ12M8+/F56g2SNgTUWbUIToiaA==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by SJ1PR11MB6298.namprd11.prod.outlook.com (2603:10b6:a03:457::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 14:57:23 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%3]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 14:57:23 +0000
From: <Marius.Cristea@microchip.com>
To: <arnd@arndb.de>, <David.Laight@aculab.com>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Topic: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Index: AQHbELhIoRgtG0Q7D0uFOhXRGdeyrrJvSFqAgAwkAQCAAAERgIAAA5AA
Date: Mon, 7 Oct 2024 14:57:23 +0000
Message-ID: <2f53046dd5b791845c2ffa783d7637ca94ca330c.camel@microchip.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
	 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
	 <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
	 <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
In-Reply-To: <758e1d68-3a27-4d64-8c45-da829ed5904a@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|SJ1PR11MB6298:EE_
x-ms-office365-filtering-correlation-id: a6d312f4-91d9-4c37-eea4-08dce6e059de
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFFzTW9xdVBYaUxWSC9paGZ0R3I3b3dsQjFnd3NDMGhyNk95am5sZzVVUVR3?=
 =?utf-8?B?Zk9oNEhKM2E1RlVyR2xNMy9BVVhjYW5UeXVRSjVOclF6Rmdwa00vdllUTVRh?=
 =?utf-8?B?eE5ndEZ1Zk5ka0JLZW1Vb2FyQ2krbi9xNm4ralRDT3VzdW9LbVZlM0xtOGoz?=
 =?utf-8?B?b3liMlc2T1lDQTVuY0pyV0NOdDV1cE1OMkNTOHE5S3FzcmRlQXZwNGNHWVBT?=
 =?utf-8?B?WHdDbWtRdXVYNWFJYkpJd1Nsb0xyMFpwekFhcDNuNmM2S01tSlIrZFJUU1Fz?=
 =?utf-8?B?emVOZnM2UE04N24zalZ1R1plUjlEVmlEejh1S3pNL3N4Q2NGdVFMS1ZiRlBx?=
 =?utf-8?B?VVMyUGlpWmk5VncrT1RHWnh4Z2FPTFl0MDNyWEpDVTNGaVVodys2OEFYYW82?=
 =?utf-8?B?Z2ZLdmVpTURzZEtkdzRQdmJDM01hcUUzV05xazFRaFJzRWkzNDhhbU1FSFJJ?=
 =?utf-8?B?dlZWdmlNYXNFS2x5TFlxdUdiaTI3MGdYQTdiTVV2SkNvdnhNOGMzMlV2eEhV?=
 =?utf-8?B?cS9UdmduY3I0OTB5cGlRTHpBRjlNdXZXaTBFSzRpbWJoN2dNVG1rb2dPWnVv?=
 =?utf-8?B?MGU1enRxNTk1QTl1aFJGMzVtczV2R293WXFFdTE0bHhILzAzc0xjQmcvdWYz?=
 =?utf-8?B?Snk3TkdiY3BNWWxrNVhTRHFmOG9xUjI0ek01SEhvMktFbWgxa0JjR2ZsYVhK?=
 =?utf-8?B?NjhkaytkMnB2MGcwOEF4a3Z0SmQrQWFaaHJ2OWtrNkx2SzkrY2tFcUtsRWFF?=
 =?utf-8?B?dG5sRVpYOGoyMDVlcFg3TlhHc2JDcXdXaXNnSWRmbW9QaDFQVUp2U3NUOWkz?=
 =?utf-8?B?Zm9KbHhITWJIQlNua2hUUlpHeGxGMnNseGUxNjFtNkVQNk9nSjdJUkVJQzJ0?=
 =?utf-8?B?RW5CdWovbmJPd2FuOWpocXFtSXVPcWszMm4veVpLNWs0TDNIWnFiSUZPQ1dU?=
 =?utf-8?B?T2UyR2h1YnFvb2xZWDZHSmZNRXlDUVhRRG56dEdjM0Y0OUlqejUxOG5jbTBj?=
 =?utf-8?B?LzlYQjg2UjBGUlZXUmNRenhsb1FubVdwcHc3d0srSGRtdDNBQjFRcEFCNnBV?=
 =?utf-8?B?Q2h0MlMxN1h5Wk83Z3pDempvZzQ2ZXZHVFVMUXZUU1k3Q1U3L2g5TjJ1OVhC?=
 =?utf-8?B?Mjh4a0l2TElTWGJPeC9oR1grTENsRHdVSWpFOE5SM1pRRUVIQTZRRVAyS0pS?=
 =?utf-8?B?WTNULzR3YWhEa2JNVXpxbC94cmljb1gwSG43SlRnMTY2bWxKeW9xS0lPOWtB?=
 =?utf-8?B?VnBKVy9yM2tmeTlPYjJTeFI0bTR1aDRaMlJ4RklsOVhzMVBGajlDM1ZaZmM4?=
 =?utf-8?B?SGlBa1Flb3VMVU9hOHN0SDZ6OVFUdVV4TGhTQUZSNU02N3lORG9GcUZyWGVU?=
 =?utf-8?B?S0dyVjhoRUJ6dWdwcDlOYXFrTXlDWDNERkRLV2hMdDlVcmJZY2Y3clE3S25L?=
 =?utf-8?B?dUJ3aGlBdVp6VHVXWStuc09nRVh2aUdURW56eHVGdWtIZnNqbjZrYWJONko2?=
 =?utf-8?B?NkpxbnFhb3A5MHM1eXZnU1NTSjZRYXpBMm10bDdFYTlYZTZhUHVBN09OdklY?=
 =?utf-8?B?T0U5VG9Ud0FSSytNMkl2QjhEU0tzbjdjT2J2R1hSYVpoVlZtSXIwcUJSZFhZ?=
 =?utf-8?B?aTd5R3l3dHBpbGl0dzNFbVFCeFRNcjJIZWg2TW1VaTJnQXBQK2U0WHdSVXUy?=
 =?utf-8?B?VThLZmNMalY1TDVvK0VZekJhcmVqZ01sVTFYLzdVYjlQRktZc05ZSG5KK0ZR?=
 =?utf-8?B?Z0tld21xK1E1YWZUUDc4dXBmMVpNeU83WFJRYWVWZzlIUmtHVlpzNVZQQW1R?=
 =?utf-8?B?KytsZjRyeGN3UmhkV1RHZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEU1UzVqSi94Vnk2YnE2TFV0VE81OUNseGlncm51SXhkd2UzYmFuZzcybFRa?=
 =?utf-8?B?aXNiakdwVmVaMFVTblNyVm9lSnc5NXJYT0FvK1QzZWcwM0R2NGMzL3VaZDN1?=
 =?utf-8?B?WWVLbjZYakEzWjUyV21JQVQzN1ZNOGlXeHFQSVlKdHlyNEVOTTdvemJjM25B?=
 =?utf-8?B?Q2NaYi9aNWIxcWpaclljNnB6d1c2NUxBblkxNytiblNJMWlnUkJzNnBGU010?=
 =?utf-8?B?NlczbXArVVJLOTc3MXg1bWowN04yZkF3U3k0UTJadlFwT1JpMDlwS1dCcHhk?=
 =?utf-8?B?QWdrQmJiUHkyc1REQzRtWXJ2eVRhUERBL3BNOEVnamZZZHJMVXhxU1AyeWlO?=
 =?utf-8?B?dS8rRWpSYW4vTWFuODRMbGxCVG1HRk5nY2dPam1Md1VRRWxSaVVyZXJnN1Bj?=
 =?utf-8?B?RlNXYmxtN05Kc0dzUHdwOFlBQWNTUm82eHpaL09mMVJudHc4dElPR1JCaHdF?=
 =?utf-8?B?VzBHc0lGY3djMHJKem5ORFBkNDJEQUVSVTV3SE5TenNWN3YvZ3Ntb1MrQlVr?=
 =?utf-8?B?TXYyZXlONDNNYUxjMGV1dGRJbU05OGluL2VjVGNsS0RkRUtJcG13S0RKanVO?=
 =?utf-8?B?MzdPVmttdCtTZGxGV1g0NkNPUGh6a0Q4ZEM1M0xXZmtmUU5EU2hla3M5N0VW?=
 =?utf-8?B?VUdkRWdDOXJLNS9YRFRQVGxFL3lnN0RyTDRUUUpkUm9ZWHE0VFNHR04yRjNl?=
 =?utf-8?B?aGttcEtaNUdXcDJjeitOcndGYVN5cDhRRGJvNW5YcnZqZ0MreC9heVdveFYz?=
 =?utf-8?B?VVlWeFFia1YxenpNVmNHRWs4SHZNZGZKaTJrem9Vcmo4ajEzeXpXQU5IemYv?=
 =?utf-8?B?R2J0UnNVb05oMGplUXVPWmx6WkJ6UU81N0lTREpXK1F3NkVUSVVTVnJnMmJ5?=
 =?utf-8?B?RkdCMVcvTkw1VE1hZ1ZEU053djZwcUl3a2ZJRTA2U29lNmNPTXl2RzRTdGFP?=
 =?utf-8?B?TC9UR1dIRnRXR09yZXdnM2FHRXA3cGdjOUdNMS9kVThzOUJicmZ2ZGlYV3FG?=
 =?utf-8?B?MDBVWFNaTm1waER0aWV6R3JYbjBrQU1ZRjBmY2htRmtDVGlIc0VPMi9QbkZJ?=
 =?utf-8?B?VDlPM0FhVTFBREJHZldFM3ZTZitaVzVCSEtsQ200QjBFNGRyL1RlKzRuZi9C?=
 =?utf-8?B?WDZPb3hLcWRYMEZsaUttV3hJbjJOUmpweG16NG5weXpFb1dhVVREWGVhKzVP?=
 =?utf-8?B?bGJ3S2ZLbGFiTER3Qzd5VnpqdjV3SDJFdXZrSkxQZmdyTlNleFJ5V3hhNVlP?=
 =?utf-8?B?Q0hJeFc3SE0xVllHMlhuK283cFN0TFNHUGRiWXBENEE5MGRwSDdnZkJaN2FJ?=
 =?utf-8?B?NU1mM1N0LzM4RmhRVm8wRUI3YXdzL055L0s5SEFMUWtUTzMzaDUzWHk0QUx3?=
 =?utf-8?B?SHJOWk5BQVBtVmhWZ2E0WGdQZFhCS2NPS2ZWVnNjN0c1ZHZpSXlPUlYzS3FF?=
 =?utf-8?B?d0k1VUp3UHJJK1FxWVhVREZ2bTQ2c3pUY01kNEh0U3VNeXBTVEJZd2w3ay9m?=
 =?utf-8?B?UGNmbVZiZzRpdjRXbEJkK0ZhbVorbHlWSGprS3ZidGh0cGoxTjFpblBRRUxP?=
 =?utf-8?B?U0JMQ3R3U1RuRlF5dmQ4cURwbWVIajhpUTJvR1VYNmNOTkV0bUNNL2xEL1pG?=
 =?utf-8?B?RnVpNGFJUy9uUENYOVIzRExXMFI0WG0wSkZJdHNZcjhNUU5wNWdZd3BqUjE0?=
 =?utf-8?B?NUlxOW5PTWVNbG4yYWphamNNbHJWbHhyVm9md2pqdTEyTU5hOXlKdURsZUFu?=
 =?utf-8?B?ZUJRTGVBZkVmSUZnRFhEV1VNajliNWJjbk9zbkxaeDkzVWJPcUdyYmhOM0Qx?=
 =?utf-8?B?VzNQVG1OWUZ5T0dxL0djV2N3SXB0Z1VkNFg2UkR0c0ZoYjRsTC9sTCtVamV1?=
 =?utf-8?B?SU1xVmNTNzRJa21MdXlLNCtLRGdvY3RYcEZ1b3pXWmJQTkR0Y3JrQWsxRUxR?=
 =?utf-8?B?SjZhUzFsN28yZ0tDb3R1TEZncGR5YUE2Ym5JaS82VXV6YWw3S3lTbU1wcVNZ?=
 =?utf-8?B?M01vYms4MmlQYk81ek5MU01HenpLS2xuZFNiQ01TYkhxNkFKbEt4YkIxYnJw?=
 =?utf-8?B?UVcycExmTUcwNlFmYjl3azJ3ZGxiR1kwL2Q1ZXR5YmpQQWFQdFFlaGZCWlF4?=
 =?utf-8?B?a1B1ZU9lTDdrOEg4WTFYN1kwK01DYWxxdXBRQjFiRU5ienRhallpcVB0TUZJ?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDFCD3F94AE7C948A007D8192CFE92ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d312f4-91d9-4c37-eea4-08dce6e059de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 14:57:23.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvWbOT/frYNTKdYmY74/bti+qV6hvf/CQS6RZKWeqz2VwwBzPwoZO5NqHldoDsgR9CsTEoJTszZnTyxNy+RDgULvjJMGn7uj58WURVA97fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6298

T24gTW9uLCAyMDI0LTEwLTA3IGF0IDE0OjQ0ICswMDAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgT2N0
IDcsIDIwMjQsIGF0IDE0OjQwLCBNYXJpdXMuQ3Jpc3RlYUBtaWNyb2NoaXAuY29twqB3cm90ZToN
Cj4gPiBPbiBTdW4sIDIwMjQtMDktMjkgYXQgMjE6MTYgKzAwMDAsIERhdmlkIExhaWdodCB3cm90
ZToNCj4gPiA+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gZGF2aWQubGFpZ2h0QGFj
dWxhYi5jb20uIExlYXJuDQo+ID4gPiB3aHkNCj4gPiA+IHRoaXMgaXMgaW1wb3J0YW50IGF0DQo+
ID4gPiBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4g
PiA+IA0KPiA+ID4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+
ID4gDQo+ID4gPiBGcm9tOiBtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tDQo+ID4gPiA+IFNl
bnQ6IDI3IFNlcHRlbWJlciAyMDI0IDA5OjM2DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgUEFDMTk0
WCwgSUlPIGRyaXZlciwgaXMgdXNpbmcgc29tZSB1bmFsaWduZWQgNTYgYml0DQo+ID4gPiA+IHJl
Z2lzdGVycy4NCj4gPiA+ID4gUHJvdmlkZSBzb21lIGhlbHBlciBhY2Nlc3NvcnMgaW4gcHJlcGFy
YXRpb24gZm9yIHRoZSBuZXcNCj4gPiA+ID4gZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBTb21lb25l
IHBsZWFzZSBzaG9vdCB0aGUgaGFyZHdhcmUgZW5naW5lZXIgOy0pDQo+ID4gPiANCj4gPiA+IERv
IHNlcGFyYXRlIHVuYWxpZ25lZCBhY2Nlc3Mgb2YgdGhlIGZpcnN0IDQgYnl0ZXMgYW5kIGxhc3Qg
Zm91cg0KPiA+ID4gYnl0ZXMuDQo+ID4gPiBJdCBjYW4ndCBtYXR0ZXIgaWYgdGhlIG1pZGRsZSBi
eXRlIGlzIGFjY2Vzc2VkIHR3aWNlLg0KPiA+ID4gDQo+ID4gPiBPciwgZm9yIHJlYWRzIHJlYWQg
OCBieXRlcyBmcm9tICdwICYgfjF1bCcgYW5kIHRoZW4gZml4dXANCj4gPiA+IHRoZSB2YWx1ZS4N
Cj4gPiA+IA0KPiA+IA0KPiA+IERvIHlvdSByZWNvbW1lbmQgbWUgdG8gZHJvcCB0aGlzIHBhdGNo
Pw0KPiA+IA0KPiA+IEkga25vdyB0aGF0IHRoZXJlIGFyZSBzb21lICJ3b3JrYXJvdW5kcyIsIGJ1
dCB0aG9zZSBkaWRuJ3QgImxvb2tzIg0KPiA+IG5pY2UuIEkgd2FzIHVzaW5nIHRoYXQgZnVuY3Rp
b24gbG9jYWxseSBhbmQgSSBnb3QgYSBzdWdnZXN0aW9uIGZyb20NCj4gPiB0aGUNCj4gPiBJSU8g
c3Vic3lzdGVtIG1haW50YWluZXIgdG8gbW92ZSBpdCBpbnRvIHRoZSBrZXJuZWwgaW4gb3JkZXIg
Zm9yDQo+ID4gb3RoZXJzDQo+ID4gdG8gdXNlZCBpdC4NCj4gDQo+IE15IGZlZWxpbmcgaXMgdGhh
dCB0aGlzIGlzIHRvbyBzcGVjaWZpYyB0byBvbmUgZHJpdmVyLCBJIGRvbid0DQo+IGV4cGVjdCBp
dCB0byBiZSBzaGFyZWQgbXVjaC4gSSBhbHNvIHN1c3BlY3QgdGhhdCBtb3N0IDU2LWJpdA0KPiBp
bnRlZ2VycyBpbiBkYXRhIHN0cnVjdHVyZXMgYXJlIGFjdHVhbGx5IGFsd2F5cyBwYXJ0IG9mIGEg
bmF0dXJhbGx5DQo+IGFsaWduZWQgNjQtYml0IHdvcmQuIElmIHRoYXQgaXMgdGhlIGNhc2UgaGVy
ZSwgdGhlIGRyaXZlciBjYW4NCj4gcHJvYmFibHkgYmV0dGVyIGFjY2VzcyBpdCBhcyBhIG5vcm1h
bCA2NC1iaXQgbnVtYmVyIGFuZCBtYXNrDQo+IG91dCB0aGUgdXBwZXIgNTYgYml0cyB1c2luZyB0
aGUgaW5jbHVkZS9saW51eC9iaXRmaWVsZC5oIGhlbHBlcnMuDQo+IA0KPiDCoMKgwqDCoMKgwqDC
oCBBcm5kDQoNCk1vc3QgcHJvYmFibHkgdGhpcyByZXF1ZXN0IGlzIHF1aXRlIHNwZWNpZmljIHRv
IG15IGRyaXZlciBhbmQgSSdtIG5vdA0Kc3VyZSBob3cgb2Z0ZW4gaXQgd2lsbCBiZSB1c2VkIGJ5
IHNvbWVib2R5IGVsc2UuDQoNCkknbSB1c2luZyBibG9jayByZWFkIGluIG9yZGVyIHRvIGdldCBt
dWx0aXBsZSByZWdpc3RlcnMgYXQgYSB0aW1lDQooYXJvdW5kIDc2IGJ5dGVzKSBhbmQgdG8gaW5j
cmVhc2UgdGhlIGVmZmljaWVuY3kgb2YgdGhlIHRyYW5zZmVyIG92ZXINCkkyQy4gQmVpbmcgYSBi
bG9jayByZWFkIHRoZXJlIGFyZSBkaWZmZXJlbnQgcmVnaXN0ZXJzIGxlbmd0aCBpbnZvbHZlZA0K
ZnJvbSAxNiB1cCB0byA1NiBiaXRzIGxvbmcgYW5kIEkgbmVlZCB0byB1bnBhY2suDQoNCi8vTWFy
aXVzDQoNCg==

