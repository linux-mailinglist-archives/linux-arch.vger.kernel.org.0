Return-Path: <linux-arch+bounces-13494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68475B52A31
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E8C7A55D8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE22271451;
	Thu, 11 Sep 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fm09gguE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1e5v+Ve"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A431494CC;
	Thu, 11 Sep 2025 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576225; cv=fail; b=SX6QKNIQaHtl6bUpbH146ERoHonjkA94jVJr4QCn1GqoPYd3plQXsRoObeSpGABbliCjy9Ldi2EM8/IzJaWblaIxbW4ZrcGOcPFSCaTYfzU/SlP7is9WFjCDBZf7J1RmtxIs3lgxk08jujKg8vi2fblgA/H6/EYPSWW8Y05VmYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576225; c=relaxed/simple;
	bh=EYUbWyQ8Odmw5Db8mWO8SjFOzXvme1RaoJUjsFoWnXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gQ2hWBymL9BuWXE5pKFt70ciMEq1MmkTw5orP8H6RJ1++/sDaqffCl6kEnNiiyTJxy+8zHNqYBimLeGMZfMvS3u+o8LvNh1/4ZWOLunOhPCRPYNSmesNvOZAofcQR5O39fOh5FLyqxdf8Moq4poJg2u5S9eBfuyVHO9yiPRogTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fm09gguE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1e5v+Ve; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALgH4x018469;
	Thu, 11 Sep 2025 07:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IWSuEJUNSj7YDiCcDxOJveSW4acja0UNBrKEuJH2C1o=; b=
	fm09gguEg+UprL0BvvFWoXpyjCgWTYZAk+o9tZUgBl7HeOJN2kZs6onbmOz8WMMf
	krFEDCq4b+m7sKG03nlf3nXpRiWQPxlCaYvh2oMPhDbQ/BOUvoOndew2mVr5BmE+
	dSqKMwYGojlU9Hj7rilJ/96BoyzDqbZIYKwIGxs3LpslPpJARrkkDBi1DShw4pac
	Zkcrkz+zXZ9wj25bnJY5fnJcxCJlwNSNXnnbbBiwFcK8Bj6acmzTCqVUPt1JuE3p
	O+K/dUWll0XYy7zL/6PtuUGr0fthLLnRBr4QyLl9Wg2cqrkH+FjFIxhOfkCa8qmR
	Cz+IExr9DRpOT0maV1limg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgwpxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:36:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B6ZTTG013730;
	Thu, 11 Sep 2025 07:36:30 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdc9r9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9nYyah625mZXcuU/zfvIe+CbQ8kXcaEzpkIf6UbAReIrv5s7FPHw3FGfCeLg4Kbx8QhY4stVL+K7qfcTmPntblsAIEHmzz4UGYmbKb4vNApaPDVb2Nx5uaz3yTLAi5vKl/GDaome88C4fxH2yTTmG2NVKrkVqT3INIJAu4d4GdiZj6qzvi/pjNTWTHHEk8IE1ljwkrrbG/EjeB3K3/NdyLxslozF868wfwojGeN/AQBXxhTJiVbTe3ac733ld9JtpKXAaAaU78553KRuwr0ZtqBQ6nd1MeMJtBgMOUSNqmGMojuBtIqWd3lh3e7BvKvUsCIfb5njZfd92/PbNWGMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWSuEJUNSj7YDiCcDxOJveSW4acja0UNBrKEuJH2C1o=;
 b=i8I7u6R1bCtgWTRuV6uNh4efOKRN6G1QiitwG2GrIMW8ITPiVB8xQrxt3FKTGsisEgZvS8mT2/VIwR1hI7rLzr65MzoKiHPtreKREFEiGhlUxK+K5DM7NZIevBno7CtCdZXZ4Y5d2MAAODQOI/DxJF22XH9XZq47lCGCI95PnYjjo19hxZkKcgJ0M2M/v2Emegz7usM22a//aDSH5wBAbv7Gm2ib5loTIqQukD/zY4qImDsxUKG7YKwDFRl3jWw4fLJSRyw9b5U6HevpEmR1WZfg69QKuUulAp2jt7T4gll8rdCar7QvjdnWm/Dg3R/AYExgugg1TvVyAg0aJX1ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWSuEJUNSj7YDiCcDxOJveSW4acja0UNBrKEuJH2C1o=;
 b=J1e5v+VeDAo68Qd4VH6GsY18nRoXgZ5Us4w/TvZuFK4AS91/GtrNpgbMsiVmeKMiqfCniOZ2KhQ6q2H8PUgNMzfR0t59qOoC3CnnnB8zIE6gfLTgC5ShB3CtHs5oY+Nc/mY8dxGynV/18cKiC5LW10bYde+z248yqMtr3nV98cI=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by DS0PR10MB6246.namprd10.prod.outlook.com (2603:10b6:8:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:36:27 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 07:36:27 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi
 Vineeth Reddy <vineethr@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Index: AQHcIRRQ6F4MTToGYU+vkRiA2yaxVbSMSdcAgAA4lwCAAMzDgIAATDUA
Date: Thu, 11 Sep 2025 07:36:26 +0000
Message-ID: <10A3A1C0-C20F-4A00-B450-E19868B6B720@oracle.com>
References: <20250908225709.144709889@linutronix.de>
 <e2b2d2dc-adfd-46db-85ec-a09590fcb399@amd.com> <87ecsetl87.ffs@tglx>
 <fb66953f-8d03-4026-a33b-f414db776f37@amd.com>
In-Reply-To: <fb66953f-8d03-4026-a33b-f414db776f37@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|DS0PR10MB6246:EE_
x-ms-office365-filtering-correlation-id: d3573175-7663-4ed7-f161-08ddf105ea9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fN9ID5K0sFpm4/m0VNehdpq/tINzPqqPyLTCtc5AEGmhJjmLHa4ItMziJwMA?=
 =?us-ascii?Q?5uAUsXr3EKpBoSuvHkLhqkb9W3mTKGtc3r0tcoiAoBu+IarXjyJczfXrLj2f?=
 =?us-ascii?Q?79GIVbL4B0BExDqoUdB/eYMxdBzrhC5dKCYjHwXls4UebxP1L8Ej25uzlcEw?=
 =?us-ascii?Q?EuVQPerCK8L5lmVZXd6Ccs+qKYS9bEWOaxqTeivlRRvnrlwAcN16nYZHehlD?=
 =?us-ascii?Q?UcLY/RqpPRWV6o6/t80PC73OCq5Jn2/cHIyWrdxVhUcPK5JWnvxWnsxcZHWd?=
 =?us-ascii?Q?pEc/CftL6phT+nsMOmHNWzSTSJmIsKeu9GmVFwPDcSHP41uJsmBjl08BQz/D?=
 =?us-ascii?Q?SMKo9Hr+QEjxMZ1JenYngwciltq8DuIpvbBzrf7MqfsCZPnfKtTV5q2c0IQA?=
 =?us-ascii?Q?bVDwXZV3A+Wk9EotpJDGXEWALnGCCstsyFVQyqrlrWuQ7HBPOQQ16hLcZ6iQ?=
 =?us-ascii?Q?fz967MR+mqN8+xtBkFAOTP+Zsa4JD6fP5q4iYNwgVjx4rnaMz6AmhPNtrCxS?=
 =?us-ascii?Q?Mmh5h/8GgMQPNja2AgwpdnOUsy/vNgEq51UHmwQ3V/bNJ4UJ/I6F3dmNApHm?=
 =?us-ascii?Q?Bi/cKJ0WdiH8nVl3SXbUr/cNDDsD9hErWWkXxzBmM3f1bH33raPB2jxwEZxH?=
 =?us-ascii?Q?9r2FqewRUksWknwSb8UH/NGolx4Q0liCL3zHjs8wAcDGHTxnhkOkcL9bR05K?=
 =?us-ascii?Q?ygeSRX7ZLegLubKRdDjEau6vKgqHVC1rU9NyRSY8Is1nbaG3ZbKdlQqAzex4?=
 =?us-ascii?Q?/PYjlcgDcdPjJZu2ns1tN83YZUUA3xgurlhcHuFewjIgFA33rr7rN/wNg8mA?=
 =?us-ascii?Q?vM2DY9xhM6Qy5QPnA2q8gDWLGssAdyUXEsLlQVZRbHtHFd3PFwGZGZPFV6y+?=
 =?us-ascii?Q?wf+Yz+Lljq1MhSHAMz70v9+UaMoY3ottL5TehdWVDNekysZb6EZekm3w231m?=
 =?us-ascii?Q?vqYsW1pEQ8i8QGXcpnPN8vknV4VPMKYMw5OJaRl/MGTo+JMQEFyGXOLBxAr9?=
 =?us-ascii?Q?izvLHLDlZpLeXZmvlmYyFHniBCLxhrC+JhGFlcwrRaSQaw3ooq1bO+J+zCUP?=
 =?us-ascii?Q?Jz9tfu82F9fvhVqxJJxWkBpUy4/HISt6aK+23bnvVDMGHy/Ko2Hg7w1jaBss?=
 =?us-ascii?Q?b4Dhx+NufjzDpP3oipgT/n/ivmvktyJ3z7m+wZtoHBRGl4ISCs7LIijJCcGM?=
 =?us-ascii?Q?Bg9FddZw+39MHzkNaOyz7dBWdsw6iZvEsQ5TJ2wpdKNvqlwmRMozEGxfW+7u?=
 =?us-ascii?Q?BYSd0tnyzK5Efii85A9I6bcRRzP9dqZhvXmB3pb0YkbjrQluufZuq8jQ9Q8w?=
 =?us-ascii?Q?cLfuHgrIhfdH3ke6y794xbpVxdOykX6d2yafUFHV5u9PC24y3cWNLFb3trU2?=
 =?us-ascii?Q?9vf3/T32G8e1cGoabQIWuqovydmpzESeqEBvMmKpi5ZELLdMAhnbg+SjCHFo?=
 =?us-ascii?Q?Ww+57RHbM0gADjozKqkivxBNyxi9BTQpQ/sG0axkn0itY2pU5ZgDltobfy3l?=
 =?us-ascii?Q?ekbTzwtNI3frRSM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+mm5oJD3U4Ary9DwGjXLs4QQ8XNaipshMfa6oT+yLiqmscpsSpK2GGcT5dEn?=
 =?us-ascii?Q?Gf+sJrHERR8MNUjCIKLX/+cenH26lEQNG5jq4ksQksN3QYBjD+IRwKIiN5Qb?=
 =?us-ascii?Q?bZWmu9cQrq9QZJ1SxIFJ8EjP0LP2vfon67/jHfjA/FPD364jigu+TK0yPNr6?=
 =?us-ascii?Q?/Mn17UgLoAEktHbZuPf41hPWbjhZsx9pTnFTL5/k1HTcvO5ng8B40RKSTYjl?=
 =?us-ascii?Q?4ZH2+4y52uRjHkfAVyyMBJnCzSMTpIALVHwRmzaj9Tp2eUcUv5KQzMSFiGrW?=
 =?us-ascii?Q?Ir/eKoQRXdAK2okag6A0fdEm+k5bV0KBkaq5qNA5q3H3z4t0kpl2WslJ2OH0?=
 =?us-ascii?Q?1++NL133ElqmKuwy2Y73Wk9WnXFX7ZEi2e4mxCr2dqZYZp0CuPT6+MUJI2sD?=
 =?us-ascii?Q?0dRJSwDCtaf13k0khY+ei5MGRtQ98BfCiWGHPA4wQt43U/wMXqiMuja46VoY?=
 =?us-ascii?Q?3UYRB1yMRz8J40RqvYMrSmr+yBKg2AQZhBx64cRchjkHsy8OnrCqCpaGCgXQ?=
 =?us-ascii?Q?1j8DevyGDBqIqVFshqibigzvhfsvyyq0DvKOxIFfCMmfZUjBkFneb52NuXNw?=
 =?us-ascii?Q?vOXqee4abh7E8/VdT8za9TAE0ovx2Z2Srrv990D/0RFF5BCici8NbafRHu09?=
 =?us-ascii?Q?MNXJWMczK1CxwQTmwxb9ByPOaRmUdanruVM+ZesUzJsZ1YsUMmDCGAaUK4Pg?=
 =?us-ascii?Q?08FG3o7uGlQGCv9aDuZ22AYcDOE6dC3J2KQ2fJKv4pDsRgA9RSkvpUhxXZvI?=
 =?us-ascii?Q?rVhNUkbWAfoFifP7fMHMAETKPX/EQA7CoQ9Uu34MnRMic09FpACmT9uMqFLN?=
 =?us-ascii?Q?PE48jTcmETmnkcX4AaSkybh29CDOfgmSAuxwdHiT0LkW2bQi7vrIxCUIDTz3?=
 =?us-ascii?Q?u06BTjPQu7ow+5vUHin2Nln4B2m1Mv1rgFqEgx7qwTjUqLtn/oBbO5xz/tRB?=
 =?us-ascii?Q?Oow63S1NdVOxpxylLrhjbFcraUa4VT/DnYFwaPTxe+V+NVhk4jKuZJB1oPT1?=
 =?us-ascii?Q?Q3UBgOeSiq32Xr+MVwP7CpAgETx0nTbwQ78NXjzNEc9jWHhS2R0Kqq0USF0x?=
 =?us-ascii?Q?UnlJ9EcVO8SIJpMOwFO6Jj0SS4wz6WxbyJHZUkDo4qgsct4KdcqX2z1/ZBli?=
 =?us-ascii?Q?IwGqZ1se4kBlcFzp57x3f/sYRMXVpI1ptIEM+mEInClEGIttURipnHxumQ2G?=
 =?us-ascii?Q?52RMjOsBItPGRWH1gS7SulMZCofEKnMikcmpClRY+c4yYptbV7Uw+MRbS00j?=
 =?us-ascii?Q?G3AHxjfk6FGfJ87DESsRH2CpNy58dRXpr+3vd8nMTs/X5RK9Yb1DVnvN/OvU?=
 =?us-ascii?Q?2bMLzS/s9wqMGXjKsAs3otM/sTn/1/EPssVpJTUENtODUI1XUic5GnosKurA?=
 =?us-ascii?Q?Tjjjc5Cd2faGurCQrSlt3BCjm3aC8g0oYHGpxF7ks79G2RvfaEOSfi+9Avet?=
 =?us-ascii?Q?gacq9xwGh8Ct8zp9s5oJL3Rj+Gfgv3VU64uErxdi9XW5CeZXQoFiQ5w2lhEW?=
 =?us-ascii?Q?Cgj0Jr6PEliCleNI9/74l1BzAezXr+pm06GS591XJ14X2pGgS9Ah/3jdMzun?=
 =?us-ascii?Q?3zZOshkHqyqrvJ6hvTu3uhiA3niwxkTdw7Qz0ktn5gwbh8+K91qL8WoWjd53?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1239978DAED89C4D87E1967629EFEB73@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IURpOBGAOz0OQ5Lw8TFRxD19J0RnQe+pvNxg2zn+T2TvhvIb6ogB1F2yy0cYIttxm57h6Blh039qeOS4NEP2/Q+yVaXebKlEOxEKKeDQJC6EyDGZ3G07b8MU7XEd4ZgtyfNQ81M0AOns1r82Qy8O16Awj3QbMYLdkK/b78yaYVyq0itogrpr+zbqnQGZP/01MhS6kxEhnjsoJMMppbQMWMjMgNe5LkRJ/EyDuuGo4GRxPiUi72rqiNkVZrdy48Z4zTryhXLJ8ulbpr026oNjCTwNcxOvBrWipY/kw6fRv8wNyayIjls3YBMAn3QFXDd+Z47sHYPMo3aPqkL2OosuixzdWtAHbmp9A5G2W2w8j5c+XM5HnhmMt/mH2zwHDckbSUa8ubbAjFZJQyx0eNvHVNOoiXV4KTryKImppOEB2ZbZFyDqTuok7WBm1csKq3b71LRc9p2rhWudmdMpcNRGKVy9ne4YINltpgosfi9x9iZuTQ+u8097HX6VQCIa7vZiTTXEotbaEsiMntzKrxRFp2ZhAZbO9i5H7/tsOuUekVnv7gEeSHmFKa8XuBGwq5RKWqEYHjb01+hl3cPmPMgmYnrO5Vv12ZqgRZWVojmkGLA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3573175-7663-4ed7-f161-08ddf105ea9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 07:36:26.9462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aoGe4d7n43VFRNI0MNO6+KbudNd5ABuEYt2Ydqf8UEnFfwmYbH7Pv3OcXh/aOyrgvdYCBavi13VYOC6Bjvb0FiZr4X/eNGsb1JLYe63heIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=993 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110066
X-Proofpoint-ORIG-GUID: XvF_FV5-2WOii7X5zsAPSkRcDzoN2Etu
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c27bff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=EURWjSBQO3p4tmFh9HUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: XvF_FV5-2WOii7X5zsAPSkRcDzoN2Etu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX+RO8oL7icBD4
 pnORLdKEIwigE9eA+d28slT6K+LmHxBwQP+DWBy/OhUa90mjZlNams0bUC+p+25dVxuaiYoeaau
 5mRDGcWHYZAngvGOoDuTN6kLK9HHCCzkQWcodALbiXQ02iq0M1bjlIkrrUwkMKlJWonD4OPdR2u
 ltfCcONtKSpgGPZ+DVmJ7+sH014WquJxRq63IKsia/uJa4dwnBSpFaVx4E8T8Ng8Vu78Xr5gqoM
 fTNSDS/cbSyp5dyYUvxVsqZW1TwRw4EfhqtFpxIzyC8qgxSw+JtN+iBjUmB5zPoZVckGnEk+KoK
 gCxRX8kkJtgZmYvdylDeCMoIThv6YIbFbaxS6F3Tz2ctoHsFNc5TeOv8u9ZBENohuLuU9UKDLYS
 VdGRZxvZ



> On Sep 11, 2025, at 5:03 AM, K Prateek Nayak <kprateek.nayak@amd.com> wro=
te:
>=20
> Hello Thomas,
>=20
> On 9/10/2025 8:20 PM, Thomas Gleixner wrote:
>> On Wed, Sep 10 2025 at 16:58, K. Prateek Nayak wrote:
>>> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>>>> For your convenience all of it is also available as a conglomerate fro=
m
>>>> git:
>>>>=20
>>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/s=
lice
>>>=20
>>> Apart from a couple of nit picks, I couldn't spot anything out of place
>>> and the overall approach looks solid. Please feel free to include:
>>>=20
>>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>=20
>> Thanks a lot for going through it and testing.
>>=20
>> Do you have a real workload or a mockup at hand, which benefits
>> from that slice extension functionality?
>=20
> Not at the moment but we did have some interest for this feature
> internally. Give me a week and I'll let you know if they had found a
> use-case / have a prototype to test this.
>=20
> In the meantime, Prakash should have a test bench that he used to
> test his early RFC
> https://lore.kernel.org/lkml/20241113000126.967713-1-prakash.sangappa@ora=
cle.com/
>=20

(Have been AFK, and will be for few more days)

The above was with a database workload. Will coordinate with our database t=
eam to get it tested=20
with the updated API from this patch series.

Thanks,
-Prakash

> --=20
> Thanks and Regards,
> Prateek
>=20


