Return-Path: <linux-arch+bounces-14556-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F6C3CD80
	for <lists+linux-arch@lfdr.de>; Thu, 06 Nov 2025 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A288018815B6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Nov 2025 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BFA2E11D7;
	Thu,  6 Nov 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dACsgeS+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vtwMOLBv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B226FA6E;
	Thu,  6 Nov 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450176; cv=fail; b=YZts3am+yFCeC8NDVM4mVYWlF9HLUFjlQaEEP2W+mf0nXiUFfLLSoygjBPUHSde1+wHygcpRUgM6/UVEu2xqZQymfr08yeZ+nsXsr30Xds7JnVdv8+qhdp7IPoFqgk0YtNHAddgS4UazYBjtU/7B70hqxBUC0fBY25CggfF+JU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450176; c=relaxed/simple;
	bh=WvAuTrp7lP9fYwvwdPGkteJsuE/lmteVGqrH6ukPCA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqs8wP7xovdX9ZVltouyR6pZnmGJLA2LXhciJBuWY1xFxWuDY6/8V7b9rgoq/Y47BS53dFey9/nXVUslDxqbY/Pl8RoA9UF1ATVH8ALVgpDK8TQa0vHIPYucW1NRy//j/scG5RlQ5p/6z+igSQfJSuM8e8RegI+Sjp+ODsrRBpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dACsgeS+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vtwMOLBv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6HETDV021463;
	Thu, 6 Nov 2025 17:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WvAuTrp7lP9fYwvwdPGkteJsuE/lmteVGqrH6ukPCA8=; b=
	dACsgeS+kbCheL28Owhsac7Af0DmAsRF2gT3C0Wq3P7pTvk8lmBFsUdJPpCHAg7k
	+GuJ/F8rakj2akPJpB56c6SJGpK6LGelKI5CGZy9MXsUubeBFne5whUwqW8Vx2yH
	5XqxQxTds5KIUJv0XTKHYOJcr3NMFaI/G8VJf8WCgKXQVTtiXdZuAJNfuW9LlzNi
	ZPKHCRYzkMCs3ILpe383WJYEEiU+/SYrzCEipnr4DpciQYAu9ev+IU03Kwb7R2un
	OaclkBFresKvz/noEYtEsFlUpqeUODeuimvDQtcANjCIya/glL+7q1AXEZnKtW6K
	4NNHRHwDKvT5rzrUEBFx7w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yw9r1dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:29:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6G7FAC010939;
	Thu, 6 Nov 2025 17:28:56 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncq72t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHKNB5QMUm26udgQisdmZKbJ9eOYJxd5/vRQjIBUeNJ8K1nzzNykMJa9njLBNXgCpTaSmSpWV0mCJbeZaqtWGuslICQjj+nTgHTLkZF9Tivy6MhenVSshfoEqR8BtWO865vO3rrt4G5YYFRRipqbyAYFEgF1x+5FoGHQ9HoOa3og2H0j3W9QCS08i33AK2t9zhF4jw1GaMZWGAFxm45S22SZTvW3/36fTGwxBl4TNegeXmzaVI35eUxGiMpYEtJEscidTtBUbGzUvKaAR/tqt7hqgi3CeJXokXxSXkJW2yB6AwUu5/WtNDwS15ESR0xDBRdfdFTd07q7ZGMgtv3Uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvAuTrp7lP9fYwvwdPGkteJsuE/lmteVGqrH6ukPCA8=;
 b=RgyB1a8jXH8+9mba8Bf15wLyoDSQzW9ghQXwNgbg8PdUEeT1LtpqMAr1qxPHW7vPHGIptkZUk2OGD1tvGgVFNKbaWxKOJx65FgrUMpVnAXO2gjDkTdx4YY5mBKO6qGlOCacU3Q9hGPaqV0dN29Usswz2Bn/jLllJ4eBOju0CTD2tV70ikeJ8aMyQc8SU8f5ZvwQSlUvfl/PFwpElyYZdXEjKlo9qvLOvFV/RCZBoXvq4LwlFltLfxvGRW3zcsp4t7gVApZ4j0Hl/1gnifsSaqK1qdB1Gdc1aWblLclUGSxjdMDcesQLh0zyjaNNYXpuNR71uZ7yX7b0p0porHLh1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvAuTrp7lP9fYwvwdPGkteJsuE/lmteVGqrH6ukPCA8=;
 b=vtwMOLBvOt8DPhOCBzqiNhDExi5cyBPWwjZ5IifJWHm+QxTUM2U0DeJhuBWJKav3eNqEejw1UnvWnBuBxy3yeBs6Vp5fdfD2FqvwE71wdPdim/TgfEpRS5bqXtjzwdyKbIYQm1z4Us3QJrWCyYmNcXjiecP+46Q9tyNed1sNf34=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:28:53 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:28:52 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Index: AQHcSNcOglHsgNF4y0S/q4HcTckeK7Tl8+kA
Date: Thu, 6 Nov 2025 17:28:52 +0000
Message-ID: <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
References: <20251029125514.496134233@linutronix.de>
In-Reply-To: <20251029125514.496134233@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|CO1PR10MB4786:EE_
x-ms-office365-filtering-correlation-id: 4b7b8f3d-13d3-4046-8aee-08de1d59f4b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEpVRjNpWS9lR0UrYmpxZkR6Y05mS2ZMSkVXYStsaWZpcEQvL2Z3OFlWenBC?=
 =?utf-8?B?TVVpSDlxOWNsRFRlNHdLc2g2Z09pL1dEREhDQVM3WU11QmNWYktqZUwrOEdj?=
 =?utf-8?B?S3hJY0xWUlFPMkNBWG0zSlJja0FXSmh4SG4zSnpOTW5SYktQT3pWUDFDUXIz?=
 =?utf-8?B?MkxXcEE1ZW1xMGhyaWRNVzZqV3lGdmtOSndlRWQ2V2ZMenNyQ1hiaWQ0LzYr?=
 =?utf-8?B?cU5EYlNSM2pNeFZKWnJsdEhDU2hPMDA1czAyblpuSCtkMU02cGZVZnBmZ09M?=
 =?utf-8?B?Q2FzSm9PQ1kzMktQQlBaUWNqT1BZR3kvb3d2YkZwL3B1S0hjdXF3a1ZjMjR1?=
 =?utf-8?B?c3BsTUxoK21zQ2xDaFBUWHhQdDhtSGxQbWRpRENUdlAzQnhUU3ZrR1pLT3ZO?=
 =?utf-8?B?MEFkQksxOXRycjYrWVhOcXN5cTVBbWNSWnNWUHQ5ZEpQem1wdnBEY3pRMk9u?=
 =?utf-8?B?eDBGOVhySnlYNlNsUGhMTlkySTNucmJiWFVLdytjenhEZjFQUUU4dHNJN3dw?=
 =?utf-8?B?Zno4aWNiT096a1hEMHNDQVVUM1dMOEVUd2w4cmdGbGNWVHIvUk9USFRqcnBV?=
 =?utf-8?B?QjFKaWVWeUZ1MnpiYjE3Ly9mWGVxQktmcXYxZzg3WDg5UDFGbGowWGI2T2Vh?=
 =?utf-8?B?dzNIZWx2ZzhNRFdMNStVVHNqSVhXS01lR2xzOG5IUEtpd0lyL21sYTFMbzA1?=
 =?utf-8?B?bkgwdFd3cVhYcVRpUkVFelRsSjRkOXFiWCtXRWlKaHlnUGtpcWxscmdLZjR4?=
 =?utf-8?B?Uyt6V3p2OUdUYkJxaEtMT1lDVkErcEpucXlFTmxTck9YRFc3dzFSVENEUCtT?=
 =?utf-8?B?TTF3b0xjU3A5U1lTalJYdW5sY2JJS2x2UDNNQXMwU2dvZS9KbHc4UmZ5cXIx?=
 =?utf-8?B?bXJ4aENCRmtvWnBzRUdxZXhnUDB5b1gwZG5aYnQ1RWl3STdWT28xczdjTEF3?=
 =?utf-8?B?dVRhYjQrQjNjN3U2eWJzWEJTc2JPZUxvUTRpOEs2cUV6UXEvUk5ZT3VqSVY5?=
 =?utf-8?B?ZFl5MzhBaEMxYXdsUDc1UXdweUxJZkVsMStJbVVpR1hWaEU3b3hnZ2tlTjdU?=
 =?utf-8?B?c0IyRGVOUTB6WDJBQU5qdm9NT0tBUkhmMGFYUG9CR3ZoaHhMSFlCTjB4TUs3?=
 =?utf-8?B?Y2h6RG1kcCtJNXRkelFDais3NTZSM1Jndkc2NXkyd1ZabGordFZKMzFMUkY1?=
 =?utf-8?B?SVNmcldydGZpU3RrVnM1TmRQUGtwSGM0clFOVVF3cXcvRncyYStUWmYrV2Y1?=
 =?utf-8?B?SUprdHROZUlDdk5jMmhqalVIRTVHMXlIS3ZiSm90ckxwUnBacHlIcjZkT20x?=
 =?utf-8?B?dGFMNnJOcklHWXl2cGxLQUM3R1cxT3dqOWZkTjhpUDc1UFVkVFUwd2Y3RGFl?=
 =?utf-8?B?ald4WVdIVEpZRWxXVU16L2t1VmZMRFZBcXNQSlNBZGRKc2NYN2h5ZEFWajds?=
 =?utf-8?B?NWxBNG9maHl1Q2RhMVh1OHpsZUtSclVZaVlQQlUyRjJiKzl1bzQvMytldjFG?=
 =?utf-8?B?Z2M3VzVzUlBkaDAyNXJuc3F6OWxGVVNodVB2NWU1bjJiM01ZY0tLSlIyWm51?=
 =?utf-8?B?WlZpWnFLckVLb1NJVE1ZOUt3aTBodVI3QndIVFhPVmQzWlE5WmZCSjRndEJz?=
 =?utf-8?B?THhnUDh5d3hxekE2dFRPVnowVlpkQzc2RHRiMHhISkYvTVplWXZwWVhRMXVP?=
 =?utf-8?B?M0pQYzQ1RVFSOFVLbXdYOXdjMVYzVzY4eVFwMDFNald4NzNySFZlcDVSVGZO?=
 =?utf-8?B?cHV0Z0pFR0dFWExqMzFCcEhON1RBK0J6NWZsNmZEVWJDaTEyQXhKVk5IRUQv?=
 =?utf-8?B?Q2Yvc01PQ0lHRnVjZ0x2NGhEM2lMWVNWMkc0aWxQVzZoMXFKSC9YTCtWdCt6?=
 =?utf-8?B?Yy81cDZVOWJGejZ3bGZabWQ3Njdma0pZamQyZnRMSHJxZUprNVByZStmWlFx?=
 =?utf-8?B?aml6UFlXd1k2b2NDNWo2Z2lGSlloeFNjU3U3MWo2dWRTckVTd1N4OEd2c256?=
 =?utf-8?B?TVZMU3dzd3IrOWtzZTdUT0xxcUpUOUdpV2h5NGlyTHhQMFhHOFUvbjc4Vkx1?=
 =?utf-8?B?ak4vZFNJbFZWZjAwN3lxY0ZQd3hXUElsUnZQdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFFBNFI2WTY2RmxkYzR5dUt4aTM3WHZybGJrZFR0T2QyM2ozcjEzZGh4Ri9u?=
 =?utf-8?B?NnRESS9GUE54bGVVMmZuUkdhOEVvTVY1eUx4Q1FjaU5BT3ZEOGNKbm1UdGlK?=
 =?utf-8?B?dmZKTVppejR5Vy9QUFBBYVA4YnEwRTRrQXpqZ3RDcjJsTzIxUm5LUTE4dUNk?=
 =?utf-8?B?OS9QbXNlbVBYaDFvZDM2bk04MStYTmFIVWFsTndZemlPam1UMUJWL0FjQnNP?=
 =?utf-8?B?OFpFTzA0WkkyWlBqdjNPWFFZWGFGNzN3M2x2L3BkMGQ1eTR6OWRmZVNpa2lI?=
 =?utf-8?B?Sm5HYjlvRnhBTEJFeXRlZDVETUcxTkVwZERyK1JHK1Vya2g0dDF2blBmRzZZ?=
 =?utf-8?B?cmUzQkFTUitSbDlxdzEvamRlMXh3VzAyWGt2NWh4ZG5INDgwWjhKaXpTWG1l?=
 =?utf-8?B?WWZKYjc4RXdXdGpvRVVoeHlrVyszUjk1U2c2TWF6QTBLYmxEaUxOWngxNmwv?=
 =?utf-8?B?NTJVOHdLbnhSSjhDdlBEYnF2V0VXU2EyTzQxenZFa2xzTGp1NENvd05wNGZI?=
 =?utf-8?B?Y1h6WUJYbW5wZHJzbW1uR0RobXh5Wm53ajJKeVQrcm9wSkJscUlyeEo2cjdC?=
 =?utf-8?B?U3ExNkFWekR4UXVWTzQ1ZTZNUTAzREtPY0ZQVHphZzJ3WElNVS9kYXR3Q1Yz?=
 =?utf-8?B?dlMxWkdPYWdPd3E2T1QvVjQ1M3dmRTdHeURObHFQWkhWSEJycy9UaFFNdHVz?=
 =?utf-8?B?bmNPdlFENmRsNThqMERqcjJEU1FDdWpaWEw5T1R3MXRkaEpKL2Y5a3c4M2Vh?=
 =?utf-8?B?L1VTc0ZzU2FCYjNoeWRrZGVDOUpqL015dnhERW5lT0lDVHBoc3N1WWVkcG9k?=
 =?utf-8?B?OGlSVHdCMWo0Zlh5RG5YSDE1bjhudEV2VTlna2NrS3F4QkVEaU1NYWUyRDFl?=
 =?utf-8?B?V0lMZGtKK1FyVXRkYnpCc255bzBCbTJtTWFwUDcyTGk4Z3R5ZU5DQmk2aXVz?=
 =?utf-8?B?c0RqK2Eyd2hCMXR1OGxzUGpNOE15NG1RSVRKb1I2anhxSm5yVEx2dnZLTHo4?=
 =?utf-8?B?QzdHNUJoUWdPZjJWZGNob1ZtNGxWeXJlUkF2d2l4NEFSZ3lJd3JBNDhaVUZJ?=
 =?utf-8?B?c0FENFhqVVpJSGdVUjk4cEljZWRTRklORld4eUxrUVV2aFBDL2NjTlJYSVBt?=
 =?utf-8?B?b2N4aDdFbGF4R2tKZHcwekNRTWl4V2xySEo1VlhtZHVHdjc0Q2d6T0hFblpL?=
 =?utf-8?B?Uk5tcG8vQ1VFMmdCZ3pwcU40aWl4YTFkRE0ySEVXS1ZXaFRmZjJHeGVxbnho?=
 =?utf-8?B?OXdNeXVQK3NNYkM0cklCaVdoTUNxaEk3eXFCQWlXRkRTbmxCUEF2R1NCVEFk?=
 =?utf-8?B?MHhjSmd6NEswWjB3UStlY3JBeDZuUVJybWNDTHNDcG1pWUJ4QlFsODYyOU9N?=
 =?utf-8?B?eGhkbUNRV0Zrd2ZXUmQ2bXpVa3FsUWM1Sy9leDlvUHpsUktaLythVHVYbFc0?=
 =?utf-8?B?bWZTYVJqOWIrUUNaZk5XeDdtUVhnQWw1Smc1WXppWGc5bFE2ejh4YUNkTS85?=
 =?utf-8?B?N1ZJSGlSOWljeENKUlBSYXJzczk4UlhDKy90QndUSEhOK2xZQlIrNjM2aHZv?=
 =?utf-8?B?aGJ2SUI2VWdBVzR4YVppdnhzSS94UExaa3FVSURxemxHaUdGemdwYk4xZElY?=
 =?utf-8?B?cmN2Vnh6UnNWUUVzbm1CcDl3K0RackNLRU5obzF1V1UyZkhlYVNubE44VXhv?=
 =?utf-8?B?K2F1SnUxSnp1UWJyRDVoUzBlcHY4L1BGSWxPOVFndHFaT0ltRUVKekEvNldK?=
 =?utf-8?B?aitGSmUycDVlNDNOQ09UbTRra1lNUU5paUVTQ1NyL1NYUFhqSWZIeXRMQ2hz?=
 =?utf-8?B?akJWTURDMkpwdi9GZEl1UnpMdDBvcFpIV2I2WlVFWS92NUFzNlJtUmd0NHBN?=
 =?utf-8?B?aTRNMS94emdzVDVBSmo2dkMxY3hBMUJRRDVWL29rWWZySjc2bUk1aEZwTTZ3?=
 =?utf-8?B?elJnZ3F2U3Z6UWlGb3h0RlRRZDE4d1Vsd0VkQ0dpZVhzSGtCMmg4ckJhM2gy?=
 =?utf-8?B?TDBTOEZURWNSRTNvL0xDbHBhS0ZST0JhUjF3ZE9ZZlE1aUZDSEw3QUV2UGow?=
 =?utf-8?B?SG5meGN3YmZISXBhZnl1M2haMUpFb1RPUldMTGxza1pJSjBxNjQvUlF6NFA0?=
 =?utf-8?B?YWhTMW51MG5NMGY4K3NCNzFwdUJoRm04QzRCNUFOc1pGVlA5N3QzY3R1YitC?=
 =?utf-8?Q?BrkfW/HMlqvucnOsZ0BG8CA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA42F8BEAECFDD4DADDF266ECF060C04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uca3QBWb1KPSoQuKFUZL17Xdjl1ukHwl5xYwKvYytVO0EXbhCCHD6TWmP0Zfi60u6jU5Q9oUEnCJn3s9vGO4fJiJWZni11muSHh/2Y9FkQUTsqZMn7kTefiqtyu3nfE6ZGSMWS0M5qhKxKXFRP2Q7E0u0oEu88mGJ6aKKSBQX2+xEvDe6rgzmd1IVKadJRIs1Qd+16a+7LPFmpy0GnDwf2FZhMtVCRamkOVu72XRVWa7StSQf7r8IVxH44Y/eOZ1v8TgN7Og/GzBM582zFK6UB3Vq/LB1g+HhcBFzVE/Mkm20SpUAS2xd5c+ZrIX2tyfKREHZ+83au7zmmNuvqqlBUpq7I/OsLYnX3WjKt9tBpfOvAertpg2dL+0/e0xJkz2Bse4YXGajjuYbpVYTQFSSsoPmwLMFnPATItL0wz085xbuDVbfyGUoVqGqiyp4PA+fBZr9V2nILDRjq4nT18Ne9uPLwjJTH6IKrp5pf5hG5wet1kVvrSE7aifjBUSZvuVZklkXuGFQ/71ygotX4mdpE0nEjnmfUFPl+rKsqFWMWZN8RY2JyNt5GDtV/3IU7dqeQFV7gu/TG+05dk8Ma99UB4IcU0b9KjdlEdViOj8fMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7b8f3d-13d3-4046-8aee-08de1d59f4b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 17:28:52.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yV50UDsIQPUhvJxO1Rt2DJ7DWOo3RZzVMk/vx8BuPfJxdWJT2Pmk1mPb5SF39cczfEFXDSFoUBZAQrX4G7j33raq3XTUHpQ3XZaxWUmifwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060140
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=690cdadd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dtKohUXvfrrtQea3qcgA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX3PMaUQNJel1x
 iHZC4vV7+FE3K6CXLAGxnosBHX4ASaxEf5HokO7k7OdaIpfxAouKlsTPkx1yUDYn5pOfr3WnyYE
 3L7rmyaCmr8QsHxW5LQCgzgz+MIiVUY49FrttPwOHmkySt9NUouksL+oQzfx6vKK+Set2TuRBl0
 ufnaRh58E4VLhHe06gs9JnqC88BaLdCcX39Vqo9AD0y7VFqPEF+XvXUEEOuqPlkEEba4LLlN0oJ
 VEQSpGFtZ3B38UKN8FktXKzfV4Ft6wMtdSRxYZuc9MSu5rNh+OQwFsmfpO9AkbFuQVwXOBafCKT
 uN/tUqCoqCkjr0FlqFhYGMI46czNL0ETKxvgu1t3HeHf9k5QmhWbohjnbB7gGtJldkY/nhsA+sO
 sKWfMwkiPEFVjxre0Bw6v26cTZZMRw==
X-Proofpoint-ORIG-GUID: zxiBK3qqWOp8i4FGeQ6AFuLsDCz2YJ58
X-Proofpoint-GUID: zxiBK3qqWOp8i4FGeQ6AFuLsDCz2YJ58

DQoNCj4gT24gT2N0IDI5LCAyMDI1LCBhdCA2OjIy4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IFRoaXMgaXMgYSBmb2xsb3cgdXAgb24gdGhl
IFYyIHZlcnNpb246DQo+IA0KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvMjAyNTEwMjIx
MTA2NDYuODM5ODcwMTU2QGxpbnV0cm9uaXguZGUNCj4gDQo+IFYxIGNvbnRhaW5zIGEgZGV0YWls
ZWQgZXhwbGFuYXRpb246DQo+IA0KPiAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvMjAyNTA5
MDgyMjU3MDkuMTQ0NzA5ODg5QGxpbnV0cm9uaXguZGUNCj4gDQo+IFRMRFI6IFRpbWUgc2xpY2Ug
ZXh0ZW5zaW9ucyBhcmUgYW4gYXR0ZW1wdCB0byBwcm92aWRlIG9wcG9ydHVuaXN0aWMNCj4gcHJp
b3JpdHkgY2VpbGluZyB3aXRob3V0IHRoZSBvdmVyaGVhZCBvZiBhbiBhY3R1YWwgcHJpb3JpdHkg
Y2VpbGluZw0KPiBwcm90b2NvbCwgYnV0IGFsc28gd2l0aG91dCB0aGUgZ3VhcmFudGVlcyBzdWNo
IGEgcHJvdG9jb2wgcHJvdmlkZXMuDQoNClvigKZdDQo+IA0KPiANCj4gVGhlIHVhY2Nlc3MgYW5k
IFJTRVEgbW9kaWZpY2F0aW9ucyBvbiB3aGljaCB0aGlzIHNlcmllcyBpcyBiYXNlZCBjYW4gYmUN
Cj4gZm91bmQgaGVyZToNCj4gDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnLzIwMjUxMDI5
MTIzNzE3Ljg4NjYxOTE0MkBsaW51dHJvbml4LmRlDQo+IA0KPiBhbmQgaW4gZ2l0Og0KPiANCj4g
ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2
ZWwuZ2l0IHJzZXEvY2lkDQo+IA0KPiBGb3IgeW91ciBjb252ZW5pZW5jZSBhbGwgb2YgaXQgaXMg
YWxzbyBhdmFpbGFibGUgYXMgYSBjb25nbG9tZXJhdGUgZnJvbQ0KPiBnaXQ6DQo+IA0KPiAgICBn
aXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5n
aXQgcnNlcS9zbGljZQ0KPiANCg0KSGl0IHRoaXMgd2F0Y2hkb2cgcGFuaWMuDQoNClVzaW5nIGZv
bGxvd2luZyB0cmVlLiBBc3N1bWUgdGhpcyBJcyB0aGUgbGF0ZXN0Lg0KaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQvIHJzZXEvc2xp
Y2UNCg0KQXBwZWFycyB0byBiZSBzcGlubmluZyBpbiBtbV9nZXRfY2lkKCkuIE11c3QgYmUgdGhl
IG1tIGNpZCBjaGFuZ2VzLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMDI5MTIz
NzE3Ljg4NjYxOTE0MkBsaW51dHJvbml4LmRlLw0KDQotUHJha2FzaA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0Kd2F0Y2hkb2c6IENQVTE1
MjogV2F0Y2hkb2cgZGV0ZWN0ZWQgaGFyZCBMT0NLVVAgb24gY3B1IDE1Mg0KLi4gIA0KDQo5My4w
OTM4NThdIFJJUDogMDAxMDptbV9nZXRfY2lkKzB4N2UvMHhkMA0KWyAgIDkzLjA5Mzg2Nl0gQ29k
ZTogNGMgZWIgNjMgZjMgOTAgOGIgMDUgZjEgNmEgNjYgMDIgOGIgMzUgZDcgYmMgOGUgMDEgODMg
YzAgM2YgNDggODkgZjUgYzEgZTggMDMgMjUgZjggZmYgZmYgMWYgNDggOGQgM2MgNDMgZTggMjQg
Y2UgNjIgMDAgODkgYzEgPDM5PiBlOCA3MyBkNSA4YiAzNSBjOCA2YSA2NiAwMiA4OSBjMCA4ZCA1
NiAzZiBjMSBlYSAwMyA4MSBlMiBmOCBmZg0KWyAgIDkzLjA5Mzg2N10gUlNQOiAwMDE4OmZmNzM0
YzQ1OTFjNmJjMzggRUZMQUdTOiAwMDAwMDA0Ng0KWyAgIDkzLjA5Mzg2OV0gUkFYOiAwMDAwMDAw
MDAwMDAwMTgwIFJCWDogZmYzYzQyY2VhMTVlYzJjMCBSQ1g6IDAwMDAwMDAwMDAwMDAxODANClsg
ICA5My4wOTM4NzFdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAg
UkRJOiAwMDAwMDAwMDAwMDAwMDAwDQpbICAgOTMuMDkzODcyXSBSQlA6IDAwMDAwMDAwMDAwMDAx
ODAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDkzLjA5
Mzg3M10gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDBmZmZmZmZmNCBSMTI6IGZm
M2M0MmNlYTE1ZWJkMzANClsgICA5My4wOTM4NzRdIFIxMzogZmZhNTRjNDUzYmE0MTY0MCBSMTQ6
IGZmM2M0MmNlYTE1ZWJkMjggUjE1OiBmZjNjNDJjZWExNWViZDI3DQpbICAgOTMuMDkzODc1XSBG
UzogIDAwMDA3ZjkyYjE0ODI3NDAoMDAwMCkgR1M6ZmYzYzQzZThkNTVlZjAwMCgwMDAwKSBrbmxH
UzowMDAwMDAwMDAwMDAwMDAwDQpbICAgOTMuMDkzODc2XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpbICAgOTMuMDkzODc3XSBDUjI6IDAwMDA3Zjhl
YmU3ZmJmYjggQ1IzOiAwMDAwMDEyNmM5ZjYxMDA0IENSNDogMDAwMDAwMDAwMGY3MWVmMA0KWyAg
IDkzLjA5Mzg3OF0gUEtSVTogNTU1NTU1NTQNClsgICA5My4wOTM4NzldIENhbGwgVHJhY2U6DQpb
ICAgOTMuMDkzODgyXSAgPFRBU0s+DQpbICAgOTMuMDkzODg3XSAgc2NoZWRfbW1fY2lkX2Zvcmsr
MHgyMmQvMHgzMDANClsgICA5My4wOTM4OTVdICBjb3B5X3Byb2Nlc3MrMHg5MmEvMHgxNjcwDQpb
ICAgOTMuMDkzOTAyXSAga2VybmVsX2Nsb25lKzB4YmMvMHg0OTANClsgICA5My4wOTM5MDNdICA/
IHNyc29fYWxpYXNfcmV0dXJuX3RodW5rKzB4NS8weGZiZWY1DQpbICAgOTMuMDkzOTA3XSAgPyBf
X2xydXZlY19zdGF0X21vZF9mb2xpbysweDgzLzB4ZDANClsgICA5My4wOTM5MTFdICBfX2RvX3N5
c19jbG9uZSsweDY1LzB4YTANClsgICA5My4wOTM5MTZdICBkb19zeXNjYWxsXzY0KzB4N2YvMHg4
YTANCg0KPiBUaGFua3MsDQo+IA0KPiB0Z2x4DQo+IA0KDQo=

