Return-Path: <linux-arch+bounces-7764-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7805992F9D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4110A1F226A2
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707841D26F5;
	Mon,  7 Oct 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KOKMMaDf"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816FB18BB90;
	Mon,  7 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312054; cv=fail; b=oATaE8lM+TIDCbA2hyB9uNwptmwqDhIcEoIaY4u/gZ+0cBHDemDJwhW7L88SzIHLTpEXG5ZraKuWR2WVD/LvEDHS3xw3sZC3pZcGzXECLsb5l93jJ6wAcqwaJlBv3B/24xrCS8SKsINh+DszypDJIy62ndYeaLQGozh/jZbn71s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312054; c=relaxed/simple;
	bh=77RYC4EUfIsuQusuQzcMMlj68JnbiKlI5WjA2pZDbwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sMfwriJWRSL6mwaHSk4Q9NbILGkvbTwM+Hh3l57F5+BEesZ8RVwoQZnFqaqom/X+lrQLTUTobIoWbU+PKI6XXPefRrU93X1mVDr7K+1y7RCxrIPxN120udy6MkQRvnBHU6dBMRxg0cDJqW/uVSaezblqC/7rni8rob4td/d4Afw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KOKMMaDf; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mswoE8cMVZwI/R86xFwB0vs4Ll/rrseu3oW2usF8k5hGO070zjbLu0TMobuXpLaYxLnlL7Mp3JJJuEtZREuQ32/5cTpSvUj4Xp6GyoY/Cm8nwBttBa/8Kma8r3PyWeSX5EJsrUDLar47w2Cmfk732My/LDqkxltlMYPQvhOHbK8WfIBCfkN6VxDfq/hzGKtniIeJHnzw+UwYq7FYOb+6l9PDB5G0z3ZnFhS/Trx+uAiCb5yK/0hdlbgS3GHTVqffnJ1n8EuPXjGI9DVfylb6xe65hWrXZKXFEDIzAsIZJibEflr+7RXpYlfKhRRpYEqCH+jvQ/6hM5DhUGM+4dwu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77RYC4EUfIsuQusuQzcMMlj68JnbiKlI5WjA2pZDbwQ=;
 b=c8cYfwH55pF/7ueLg23EFtEKf0BuxLSLRJxYaxZTYebgsK68s39aFu9A2raI8WnTKMnLlcQIiHTw3htuXpwlniDcOu87CIs4nbAJef3Uo4PcKixPPEokSIJOX1lyctAs4scM4Gckrhe/KZm7cHXSt4A2pUxFDOdza7aZBcpnMzEKGMTJY5n/n0bBLsqK2IlR/TVerAVOA1qRp4+2yIfmof69kdG55U4B5fknQ+Zqe5zvcX2sDnHegPkxJg5BUAH9ISAhSJmxvIDXLfEgvCoYB3Y+MXC8OSDQHM0PbP6juvidMFQm1a5w7m23Mal1yH2wBgDpuXvRnG6kGhfe1QnBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77RYC4EUfIsuQusuQzcMMlj68JnbiKlI5WjA2pZDbwQ=;
 b=KOKMMaDf218u/iUy7JihTVOE8HCJbx5wAkhYC0Nj9daUUi37RBQAcYVqf1h1IHmzilJms+GRtTgbKrjh/ZUcL9llA3AUiBugov/2L/G79M0uAf/GazSICIgsnoixKqq1geTHDvWCg5X/b5McP9iSZviE6jyV20LTzDoZ3F5roN4nop9uQZp7+sLTQS4gYLB8SJBF4A62EV3njQ8OFWi5h26PNKyvR9R4Qz9c2p67prnEYFxiCW6oRcc8XZjsUjLpVhE9z29HrBv3wuNNgiLFuUskVcs2tT447ZwS4YORZb77VXMc2XwgtzFG6PzSMfYh+yqmAp+Y7cpNqCyy0tjqZQ==
Received: from SN6PR11MB3167.namprd11.prod.outlook.com (2603:10b6:805:c6::10)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 14:40:49 +0000
Received: from SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf]) by SN6PR11MB3167.namprd11.prod.outlook.com
 ([fe80::4863:3d2c:e708:fccf%3]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 14:40:49 +0000
From: <Marius.Cristea@microchip.com>
To: <David.Laight@ACULAB.COM>, <arnd@arndb.de>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Topic: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Index: AQHbELhIoRgtG0Q7D0uFOhXRGdeyrrJvSFqAgAwkAQA=
Date: Mon, 7 Oct 2024 14:40:49 +0000
Message-ID: <04222aeb7a9c35ec080222168bace72a3788c90a.camel@microchip.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
	 <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
In-Reply-To: <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB3167:EE_|SA1PR11MB6565:EE_
x-ms-office365-filtering-correlation-id: 1357076e-d50b-425b-3c49-08dce6de0948
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RFpwUE9sSjVSb1BTVXZuYWg2eGJCQmVQVExocXJYVXo0cm9IN0duWk1ndG5E?=
 =?utf-8?B?dUk3dDR3TVNwQ0pTTUF0VnljdytFMEFrTUZSTllMaFByMmtMOTJPR0pwOEZZ?=
 =?utf-8?B?M3AraEsyMmVpZ1ZIYWRvMm1vOC9LQzZ5bnBuN3FWYSt2eE9JTWlNNWxxdFF1?=
 =?utf-8?B?Y05vTkJkU1ZnbUEwcUE5RGYzRW45ZHBEeVl1b0RIbTZEbkZpenVFZ0hZdUdQ?=
 =?utf-8?B?S3pyVGdSdFRTekp1bnJKbXVVU2JvVlp1eS81Ry95ZjdOWlo0eWVPNmdZK2tY?=
 =?utf-8?B?VGVHK0p0blU1Q1pINFduR1lYOTJQTmJzbnR2b3IvcG84QkNYR1gyWlk1dndY?=
 =?utf-8?B?eFNadTZjdmZ1bFI4UXZ6Z3lXNFIrQ3Y1TUFoVFAzcFQxMUJFbGQ5dkM5QnZC?=
 =?utf-8?B?RG9TU0w1ZWFwck83dUJpcmlIQmNTUWZOMk5od2hpb2xoMnFWRFNJaHZoUFpM?=
 =?utf-8?B?TTNLYlJTclhja2tOT29tbFlDMjNxVnQ2SUcrdi9OakRuQ1JoMGhuRHMrYkE4?=
 =?utf-8?B?RG40UGhDdVowYWQ5NEo2VnhFVUcwazVJU09Fc2ZNTDREVHJSdWZzVFpnd3J0?=
 =?utf-8?B?QU1VUlJ5RHRiV01iL3JtTHF1eXltNjdsOW02QVFXTGt2VDNVeTFSelh3MFVU?=
 =?utf-8?B?WGMvRVgxNGRhR1FFMHVGSHNTRkxYSFZVcFdEZ0V3VHpvUzVrdzRtQ3Zta2dX?=
 =?utf-8?B?eVliMHpDdE9ITkhEaHNzTThwVXo1ZS9JWkt2c3lwNGxqSjdXb2dNTUI3Vnhp?=
 =?utf-8?B?MmhueUlKRUtSS2ZkcFVTeXZjV2VPTWs4c29vZUF3cVp2blczR2loa3pQZFpm?=
 =?utf-8?B?RysvckRQcGpET2ZobzNtelRiR1Q2MkQ1a1pnd3ZrRzBUbmpnNVhuNVBwczVG?=
 =?utf-8?B?Wi9BdUtTYTZ4aHhXVE9YdHRteUhzS1gzMy8yTHJlTkIwYXVOeGFrd3kwNXpK?=
 =?utf-8?B?aDBCZk5ycDV5b0ZadFYvY3VmdWpCSFd4NHVLa3dDRkxpRVpRdEoxUGZoUkMv?=
 =?utf-8?B?UlVKaC9mQlVscmdiekhLZ1NLdkRwbUVPWVRhSXB2dGlOUVE4QXd0cmlSOEFC?=
 =?utf-8?B?aXhCUWwrQXZQRGdLOVlNeU1RdVd3OFVadko0V2orNCtQWTBmVVpiUmlBL3c5?=
 =?utf-8?B?ZDJsMlU5ZmZTUkxHVkQrekF2T1Q4MTI2czNEV3EvUlA0RDdHaXVsWGxKRWVx?=
 =?utf-8?B?dEhsNDNMa0NwZUNhTUhjL1JreEVPZG1LTngweWd6bjVVVDJoblZBUUo2UWpZ?=
 =?utf-8?B?NDZ1UCtHQVgrdkJHb3gwWnM5aElmcnE3LzM1azVKbkU0L3FqaEI2NzI3SnV5?=
 =?utf-8?B?SDJ1WnBqclFFUnlrcXl1em5HMnpIMFFjcUx0MmUyZk9NUDhLbWlCUFBuWjdl?=
 =?utf-8?B?eUxYQXAraXA3ZHNidW5ydmpUemNGOEZlaU93MlAyaDRlS0UwMGJSQ3BObWFV?=
 =?utf-8?B?WGFZOXpGSmd2NXZxaUpkM0VpakQwMUlNdlR5anRMeGViT2pPQVRSdURzeWx3?=
 =?utf-8?B?TUZFRk82dkdUU0lmMzNwbG0zeTI2MnZRM3NqM2NXRjMzK2l2a2VNZ3lLYTRl?=
 =?utf-8?B?RXBRcVRZR2E0SFJGbTVjaElFS3VaZ3c2SGtYcmw0Q3RkWjVEcGVXbG5xMXRZ?=
 =?utf-8?B?eVhiK0VKc2JwVElJZnpFRGMvVHYxMDJabTZpaWc2V09uZHRKYzZVZDFUZmg2?=
 =?utf-8?B?U1hLeTAyL0d1S1ZsK3BGOVhOVU5sK1ZQK2RLbjVlMnlaUThXUWtzbXo4RUUy?=
 =?utf-8?B?elZJYXRwTGhTTkFGZFVsclFxaUQ0enJCR0I5eHd4WHNnekw4VWRBRFRFbDJQ?=
 =?utf-8?B?OEVyUW9vaW55VGJ5RU9WQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?czY5bXBESUwrY3Zvck5YMjRLUXdZY2IvVlBPK3B1cklxMUNwd3dLbVpBWGdm?=
 =?utf-8?B?ejBpa0Z4Y0JsWGdteWREcHg4TlZscUZuTnJHTmVMN1ZTem45R1RXZ1I4bnd6?=
 =?utf-8?B?LzFQdDZwNUYzOTRzZUMzVVdOd2dLejVtb3hNZmlzVHlQMlkrWXMzNjJnZ2JQ?=
 =?utf-8?B?RjFyV01iaVhzRHFGV0Yxd3ZyUGRzbjhBM05aSEhpd3pweHJMcTNSNllQSktN?=
 =?utf-8?B?b1BxQStRZUNsSnJxdERpNUxMaFJxQVhKSUFMS2xqN3Z3WmFza1Q5WkFjQ2Nt?=
 =?utf-8?B?blpScGNSZjdXdXVsV2NVOFRreFk3T3U4T3lSQ0s2cHg1dDNYK3UrLzJNWjBs?=
 =?utf-8?B?UlAzL0UyY2x4UGlWVWhRUS8yTVdiaHExdWFKSDF6Z0wvRDhkVVlvZUYvalhQ?=
 =?utf-8?B?SGE0NVJwY1poaENoajVNQ21zNXFiWkIxNVhPZkxPRDJSUmNCQjYzVi8wY2FJ?=
 =?utf-8?B?eXlzS2pTSXc2R0F3a2xVYlpTRE5WNXRWRVNkNEs1enAzZFRPM0IycC9qZ2ox?=
 =?utf-8?B?ZmhsWmpRZkU5UDZmSVVVYkNJQW5ERVZDa0NKWE9FMVQyMlZobHJ5M0FwMlFX?=
 =?utf-8?B?ZVUzbVYrbExHRGRlaFRqY2Y1bENpenBhT3Zjd0JWNVRRNHJvMlFWdFV0R1Q4?=
 =?utf-8?B?Q25pSTFkYXdMV21BY3MyVTlpSDRQa3J0UU4xbVlsaVdaOElCVUIya0Izc3VB?=
 =?utf-8?B?WE5mY0tDSzF1aURGL3pPQzUzSDVLZHoweWdhTEpNWDE4MmM3ek9uRm5PV3RB?=
 =?utf-8?B?M3JLVTRpcjlESUZmMnNIb2Y4ZzNDZUR3eGZNMmJkZkFnU1UxeHRoWjhzdDAv?=
 =?utf-8?B?VUtKRndYd21RRE1xZVJqNGpxNjE0eUMwUHllN1ZSTStJWDlxcTlKVmFPblFu?=
 =?utf-8?B?WlFoc1JJQm9Ib0c2TzRyUndjMUpkSUExWDBxMlBINUR3TVNrRVRRNVRYUUpG?=
 =?utf-8?B?aHFrRWRhenhFSHFKUFpkZmo5Sjh5K2x4ckxNTXlFNGdNTlFJdlBGaUR1TmFp?=
 =?utf-8?B?d3BQTDVsNTlOTGxMeE1hOCsrR0ZJejdwcmhhVktHdGY2cnJxMnFkNGljNVBJ?=
 =?utf-8?B?cmhlNTJabVNiaHIzRmdTRkpnUmhHeG1yNFp0ZjYxWHJIUFMwVGlaYlhNSG53?=
 =?utf-8?B?K1JiUWVvaFFjczZ3YzVNWFhzcldVeUU5dGp2V3ppd0Q5NXpJY1hITjNpNU5p?=
 =?utf-8?B?ZXcrMVo3NFN0QkExQ0U5WlYrOFI1U2ZWdTNYWnk2RmNJUytMMXJ4WjdJMFZD?=
 =?utf-8?B?VzR3Z2lUMEIyUWJvMHlDU0dYNjg3cXljODVEVVErK2V1dlNqVjF5c2s2Y3pU?=
 =?utf-8?B?VGVjL3hXZGFFaGgwWGpMc1lqNW9UR2c4VlVuQXpFUHYrWXowT0FoWFJrWndi?=
 =?utf-8?B?MHFRVjdqTElHbXBDaHk3MlRRMEd6NkZCcFMxRWZObjRNa3NZWUNrTkxlZ0R6?=
 =?utf-8?B?OWN6TmI1WkU2S1hEK2FIZHk1UEljSW1xb0t2bkZKeG5Bbk1mcmlvNWhIR2xp?=
 =?utf-8?B?YndZVGRJMnVScTg2ZXBtaWtRTzRjaTNUR3lYd3Zrd1BwQzlHWkUxVG85dWxv?=
 =?utf-8?B?NURUK0Z5SVhRWkZ6VVNKMUY4ODFUL0FMVEVCUVFzbmt1RTJtT1RJWTZRL1lm?=
 =?utf-8?B?N2ZtZVJvb1A3cUVwNEZzS3FBemxKN2M0cmU1RmYycjJuOUkrTlNyc2hCS3ND?=
 =?utf-8?B?VFZTb0MyZUw5UkYyYUZrOEsrR3ExSFZVL3ZSc2EvNHpTaWEydThsRENHQlEw?=
 =?utf-8?B?SWJ4eFdhbFE3d0NRc2tOaVlEYkpQNUFZZW5NSHpTSXVRRnVNeGdLOXhpZnZL?=
 =?utf-8?B?Zm9EWDdMa3VSbTBPTmI0V1ZmdmY4TGZiZ2VROUpNM0xIYXNPeEtMeVVtWXZ0?=
 =?utf-8?B?ZG5TdzlQd0dlalkxajhkQTRZREwyOWYydHZXRXhxK3dNcGVsU0hJVmI5NGNY?=
 =?utf-8?B?VjhUTWFScVRNblQvbDZaV1lFc1BHYWlxYm5KaHdkVGtMWkkram5vM2xabXdJ?=
 =?utf-8?B?Yk1vZXJ0RDl5YUhIcm1rbGl6SEZMaGpBekRKMWFqQVZ2T3VUY0RvY3FnTno5?=
 =?utf-8?B?VHgxQ3JrUGJrWTBTNVU4RjVFUHg4Vk11Wnp1Vlc1MWJtUmJhUUUyY0VFM2Qr?=
 =?utf-8?B?NktjdVhyMXNJcmlmOGYwb2pMZndLV28yZUNuR095emFrdFNneS9lL2RjRmZl?=
 =?utf-8?Q?t4AcP4ppdNJVBlUBPuGKMTI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F08EB486F533DD4BB177934E6149CFC4@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1357076e-d50b-425b-3c49-08dce6de0948
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 14:40:49.2136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohfnAriN855D4emLiNUqAasYlos8qmQVfQFC+U7zzKL7p0wseQL9459HN9jUd30Eq0g1tQwGq9kcKaVNAlVw2KN52kHeRTAf99deMLTJ3+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565

SGkgRGF2aWQsDQoNCiAgVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGhlIGZlZWRiYWNrLg0KDQpP
biBTdW4sIDIwMjQtMDktMjkgYXQgMjE6MTYgKzAwMDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4g
W1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkYXZpZC5sYWlnaHRAYWN1bGFiLmNvbS4g
TGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBtYXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tDQo+
ID4gU2VudDogMjcgU2VwdGVtYmVyIDIwMjQgMDk6MzYNCj4gPiANCj4gPiBUaGUgUEFDMTk0WCwg
SUlPIGRyaXZlciwgaXMgdXNpbmcgc29tZSB1bmFsaWduZWQgNTYgYml0IHJlZ2lzdGVycy4NCj4g
PiBQcm92aWRlIHNvbWUgaGVscGVyIGFjY2Vzc29ycyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIG5l
dyBkcml2ZXIuDQo+IA0KPiBTb21lb25lIHBsZWFzZSBzaG9vdCB0aGUgaGFyZHdhcmUgZW5naW5l
ZXIgOy0pDQo+IA0KPiBEbyBzZXBhcmF0ZSB1bmFsaWduZWQgYWNjZXNzIG9mIHRoZSBmaXJzdCA0
IGJ5dGVzIGFuZCBsYXN0IGZvdXINCj4gYnl0ZXMuDQo+IEl0IGNhbid0IG1hdHRlciBpZiB0aGUg
bWlkZGxlIGJ5dGUgaXMgYWNjZXNzZWQgdHdpY2UuDQo+IA0KPiBPciwgZm9yIHJlYWRzIHJlYWQg
OCBieXRlcyBmcm9tICdwICYgfjF1bCcgYW5kIHRoZW4gZml4dXANCj4gdGhlIHZhbHVlLg0KPiAN
Cg0KRG8geW91IHJlY29tbWVuZCBtZSB0byBkcm9wIHRoaXMgcGF0Y2g/DQoNCkkga25vdyB0aGF0
IHRoZXJlIGFyZSBzb21lICJ3b3JrYXJvdW5kcyIsIGJ1dCB0aG9zZSBkaWRuJ3QgImxvb2tzIg0K
bmljZS4gSSB3YXMgdXNpbmcgdGhhdCBmdW5jdGlvbiBsb2NhbGx5IGFuZCBJIGdvdCBhIHN1Z2dl
c3Rpb24gZnJvbSB0aGUNCklJTyBzdWJzeXN0ZW0gbWFpbnRhaW5lciB0byBtb3ZlIGl0IGludG8g
dGhlIGtlcm5lbCBpbiBvcmRlciBmb3Igb3RoZXJzDQp0byB1c2VkIGl0Lg0KDQoNClRoYW5rcywN
Ck1hcml1cw0KDQoNCg0KPiDCoMKgwqDCoMKgwqDCoCBEYXZpZA0KPiANCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJpdXMgQ3Jpc3RlYSA8bWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbT4N
Cj4gPiAtLS0NCj4gPiDCoGluY2x1ZGUvYXNtLWdlbmVyaWMvdW5hbGlnbmVkLmggfCAyNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdW5hbGln
bmVkLmggYi9pbmNsdWRlL2FzbS0NCj4gPiBnZW5lcmljL3VuYWxpZ25lZC5oDQo+ID4gaW5kZXgg
YTg0YzY0ZTVmMTFlLi5kMTcxYTlmMjM3N2EgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9hc20t
Z2VuZXJpYy91bmFsaWduZWQuaA0KPiA+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvdW5hbGln
bmVkLmgNCj4gPiBAQCAtMTUyLDQgKzE1MiwzMSBAQCBzdGF0aWMgaW5saW5lIHU2NCBnZXRfdW5h
bGlnbmVkX2JlNDgoY29uc3QNCj4gPiB2b2lkICpwKQ0KPiA+IMKgwqDCoMKgwqAgcmV0dXJuIF9f
Z2V0X3VuYWxpZ25lZF9iZTQ4KHApOw0KPiA+IMKgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgaW5saW5l
IHZvaWQgX19wdXRfdW5hbGlnbmVkX2JlNTYoY29uc3QgdTY0IHZhbCwgdTggKnApDQo+ID4gK3sN
Cj4gPiArwqDCoMKgwqAgKnArKyA9ICh2YWwgPj4gNDgpICYgMHhmZjsNCj4gPiArwqDCoMKgwqAg
KnArKyA9ICh2YWwgPj4gNDApICYgMHhmZjsNCj4gPiArwqDCoMKgwqAgKnArKyA9ICh2YWwgPj4g
MzIpICYgMHhmZjsNCj4gPiArwqDCoMKgwqAgKnArKyA9ICh2YWwgPj4gMjQpICYgMHhmZjsNCj4g
PiArwqDCoMKgwqAgKnArKyA9ICh2YWwgPj4gMTYpICYgMHhmZjsNCj4gPiArwqDCoMKgwqAgKnAr
KyA9ICh2YWwgPj4gOCkgJiAweGZmOw0KPiA+ICvCoMKgwqDCoCAqcCsrID0gdmFsICYgMHhmZjsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSB2b2lkIHB1dF91bmFsaWduZWRfYmU1
Nihjb25zdCB1NjQgdmFsLCB2b2lkICpwKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgIF9fcHV0X3Vu
YWxpZ25lZF9iZTU2KHZhbCwgcCk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUg
dTY0IF9fZ2V0X3VuYWxpZ25lZF9iZTU2KGNvbnN0IHU4ICpwKQ0KPiA+ICt7DQo+ID4gK8KgwqDC
oMKgIHJldHVybiAodTY0KXBbMF0gPDwgNDggfCAodTY0KXBbMV0gPDwgNDAgfCAodTY0KXBbMl0g
PDwgMzIgfA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHU2NClwWzNdIDw8IDI0IHwg
cFs0XSA8PCAxNiB8IHBbNV0gPDwgOCB8IHBbNl07DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBpbmxpbmUgdTY0IGdldF91bmFsaWduZWRfYmU1Nihjb25zdCB2b2lkICpwKQ0KPiA+ICt7DQo+
ID4gK8KgwqDCoMKgIHJldHVybiBfX2dldF91bmFsaWduZWRfYmU1NihwKTsNCj4gPiArfQ0KPiA+
ICsNCj4gPiDCoCNlbmRpZiAvKiBfX0FTTV9HRU5FUklDX1VOQUxJR05FRF9IICovDQo+ID4gDQo+
ID4gYmFzZS1jb21taXQ6IGI4MmMxZDIzNWEzMDYyMjE3N2NlMTBkY2I5NGRmZDY5MWE0OTkyMmYN
Cj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+IA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywNCj4gTUsx
IDFQVCwgVUsNCj4gUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCj4gDQoNCg==

