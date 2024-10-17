Return-Path: <linux-arch+bounces-8257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5169A2EF3
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29131F24301
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC02296C5;
	Thu, 17 Oct 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AI0E0RHH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yem/bXVV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037F229112;
	Thu, 17 Oct 2024 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197813; cv=fail; b=acPq+baPX8T5QM1VZ8pp1rTcTgpqLXyUe9gZnYNebtpal/nLFot2Z1rwyoy6uY25geov2laTp5PoJjTOj54P8CvkhHvBGF+wkIrVwXJgQrAifahPwbsgNAZL02vEIy/KaDlc4UQOlDaekGqCzDFDzuQeLERv02qWstkQSdU+M3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197813; c=relaxed/simple;
	bh=Oy7/o8wglmfF+9x1fu9vxrSv41Vr5NIQB/kW7G1fAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igko6vZ2r/uf60drocZeC1MJ65c9nl65sMieChFuW2KtgxYmQtiAoMLMRWcgSj2zPBcjkoGoRbRctAOGB0bU+dyXMl08IzhD9/3ERbLauMR2TmSKOoPLCp0Jo1pCLpPd6C0PNOZYBq+ee/Opuq24E6e9eXwdAlfArYqilhOEcRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AI0E0RHH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yem/bXVV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBn6O002180;
	Thu, 17 Oct 2024 20:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aC0TTOTg08sqzeqXSpodjeivk2FlCOxNysvsPwgWW5A=; b=
	AI0E0RHHUqviPaOoe9JpGs1GtBwzSs1RpBa5Qw/EbYMR5LvctZZbUalg1E4WNNk7
	qFP7pYEak343VXgW7VT2VpdtAxdZrPnl4WBEgivxDKXgh5KVgLfHlkzVViwQEGKR
	iOSmAbl2KwIXppv0XYoJyORyXVqrHNPl0CCeucnNDS3UF2YpVP/M1tMoSmRYw3tD
	0COK9aqrTaJiWHRTyhm1zy7q6Ijvk6reD04dCgo/XmvltMLkYaBtakJzxkw5Wlik
	Wf2loMu+MSlFgIOkaCgO+htexLIA3A1SYlIDbz4tSMX5QfD/u/SqjjHqsVIjqizJ
	q1Jn86l02rel5OSH724u2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2qh6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HJD1MX013983;
	Thu, 17 Oct 2024 20:42:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjares3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hyi1Rv7n741QVgpMaZEjp0ZLq2ppQwStWINMIt6aSToQyBepKpeOfX/aGfUH3QxvleEdTxqAkoqfRiv5ygWo2mteeJMZN6Fvst6/VZd2KwcFwf7WoDZmdjuLX2CAjCIp38Q7G+4yLtxEqlUQf5n6i5l3aPk0kqG+rAtmiTLoorZ8bqg6NHCJu3p9nDWX+yOl7AQNkvObLvDdcZ+jHubXL9zK0lREye8+ASLooHWJzY5duGRq3rUl/mLPIWblss5SRVH9zOibDrvcc1SfQ4UK/0UjozhP5OmaI6cZlCbYZ35IU5VrQVJ0qSg5JPaoEGCkvBSuYOW3FQy+1Mp8BrsR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC0TTOTg08sqzeqXSpodjeivk2FlCOxNysvsPwgWW5A=;
 b=I4fDKW8X/GJsQz/qwD+VogYTjVwRHRJZOyha8PRUI8qZPK/JlOFnbsdcf0C99VeUR+CtZaxffu4QfhtKE/GAeazJZjeaMdAKbbUh+cC3k1knQwtvWMKfdSezvIjpcl7Ra/yajM353VemxBB4ZOwv0iXFKkZX3DrqecrpX3+j4eYkYEKY04ne0zywGc9RV2Oj5st0/7tnNAv2vgu39k6L2q9F5r02AlnS3TP1h0+4CZo45+P7+3+jTXAWP6jw8eB6dKUrwwKMQ4aF8mWverWc5WBbA8oOWce/GUTD4Ufa32n8hbx3iSmwZ+7rIoIegOut2UT77+5E727GgeCm+RBXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC0TTOTg08sqzeqXSpodjeivk2FlCOxNysvsPwgWW5A=;
 b=Yem/bXVVd00EPHcTQu9i8zSqRpKKZ8ROXFw1oIO2tsPgP+UhvgV/VqCpgMXVQe+OSv+ucJoNfGk3nBxgPThQbW49ebyIHLeYhl663EcovcJIAv37iTzY0OdPhbQNC5Bu6jUoiNEtnlWypeJgwLW6XrCrukk4iK4SJFD03fJ6E7U=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:42:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 20:42:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/4] mm: madvise: implement lightweight guard page mechanism
Date: Thu, 17 Oct 2024 21:42:37 +0100
Message-ID: <b7c9790037296c1a562d6686c9fbfa30d9d08241.1729196871.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 63058d18-695a-414b-4903-08dceeec44ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gkqvje2KSh2LWletVpNujG+eklovnmEYZiGu5yKlZDywNbf70+cV28kKuF5r?=
 =?us-ascii?Q?COocnYJYWZiZzSL9qS69AWOMTT4slgzKxu5HW84tBEpyvrpU4vLyC7q7SN25?=
 =?us-ascii?Q?Agb7LVyTORphcJRC8K7ti6Z6zdbTTsv1+DKLTIP2QWbfHqmBOlV/PhmKMR+W?=
 =?us-ascii?Q?KwRND9H9q5xXSSD6V/sPMyIjfIKk3C7EoUECVXhmK7NA/mLLPyw06AgydADh?=
 =?us-ascii?Q?XKrDz1KZPZPbSk4+lXqnxNouD7dR2JrhB3YomWxSohBJaWUTuCJjNiDRWRUs?=
 =?us-ascii?Q?bn9a9ZTbWDvgX9jyC/XffhNAIDN6pI/VUHKMh4G32ql/CDG4huY4KL3sL1Ds?=
 =?us-ascii?Q?El3mluIk3/csjeswQze59GMqwGpAlRWbsxPwy2YoMY507sYK6R/D+8crkAOs?=
 =?us-ascii?Q?8G3PQ9tv827Ipn+FdUQrnJDwgLGQWCaMl+0Aa8BYka7EoyHfRp7LBI5Luzwz?=
 =?us-ascii?Q?PyuNHqctZKnxGVTULpjtqWj3vHF9gstnfQpKfZTC09azM3l74EFJMfPT7OFg?=
 =?us-ascii?Q?jUE+pNCicRwq1f6YOz4kuAqedP9fbNeK4oCG1G2nJtwPv7/fFEcNONjSXB5Z?=
 =?us-ascii?Q?YvkNA0aYnfeNWPHJtNiWagTAZf4ALwYq4kvxhF7MJ5o5jKyZgAcvAKXCl7AR?=
 =?us-ascii?Q?6jyl/UEBdPtte33IYeRwBr0HLaOr+KVJEcUpS6qncmphqm5O3eoU8mAgo0/n?=
 =?us-ascii?Q?F5mGjo+MIBR1NpeOurhPeOkU1Z9YfY3v9UUl2Vn1gi2SBUNOUamFNB077idv?=
 =?us-ascii?Q?SUcZQfIPThHS0wbFAqpQUysp5rgTEKL0tWd9LSOE6Vmccd1YS6egdpOGyYyp?=
 =?us-ascii?Q?mMeEPrkOS4Uvv9mfhpcbJ/VQ5FtHnVh9AMrTkD/wylItFnQxyI2sYOIs2kfL?=
 =?us-ascii?Q?Rlcc1q3f5c8u5OKbOJ/UnJDG5rGmzskpAywvm6/zk5DW1XXG7OGxxNwYnxZS?=
 =?us-ascii?Q?DZf/TGgPov2CCN3efA1VEVgJpgY3swspWRHe0ZSrTcqohous/CsSB7NBhvJo?=
 =?us-ascii?Q?6T76kFji9KwsQGhdt5eP7K/LI/b9ii19QemIdzGTjcYq0n6sPFdXfPZt0yVg?=
 =?us-ascii?Q?H9Cu2B5IxNLZlo12675+grJTdMrH+ouyZqRtjm3ac+GAwkF8sPl4OYHuJUz6?=
 =?us-ascii?Q?dPYXAuM0JGOtHayqETdNwzxXKEWeerbLwr/boc2P7w06V/dbC0rk/emMjQNq?=
 =?us-ascii?Q?ouJNFTgdT1w1XdhO5FImZ2wy2vB7UPoeyPcgyKlBTkYNskgH4U2+wVdns91A?=
 =?us-ascii?Q?7OJbuqNXj/cq3xelQESG5DFekDfLVDHEPPnZY+KygBkGuvKcLuG0qGmYy5bE?=
 =?us-ascii?Q?A8u6qgmPra2NBFZ0nxr4QvXw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTSVOH0IuCLIutZbQqBfRrRhxxXXeyMm4Sf3uPbtfqJeNA95ZFahnp45UQ61?=
 =?us-ascii?Q?ebI7pKtfrDPse1fK9p/EIMH0SAP7reosRb1nU7Jp9d+2J71Q9VqF8xAFRbEk?=
 =?us-ascii?Q?kuYaQP1/ALaGrU7DCnvFOFSbnKsI3aLvaNIRWhhOgZNoK2vkRcdbrrCXps41?=
 =?us-ascii?Q?iihE1QVJjnCG0o27/LkikGpXODczwd7FAbhGCpC8VCQwBELhRrArcUbjOlx1?=
 =?us-ascii?Q?rEYuy4eJDGfxIUHyFebO82tlWwpkMiuRJVFHeyLiEppy+jEhdooQEJe7DpzJ?=
 =?us-ascii?Q?p2OzUwnN+3q8kKJnZ7rLxZEgZ3oGrF2K2WZn6svf5FylugHqxLPKfAZ1ToCq?=
 =?us-ascii?Q?Fi2BFRRPTY3hNgglWspoEcbUoFr7Fbi8Agf/13mbXSnLB185vuKK7MrCAjyD?=
 =?us-ascii?Q?YjuMyhyFmDVGfe+0jldnDtOB0nNzB6QLaekTKzJTTYpJlp7KLaUoODyhi7xW?=
 =?us-ascii?Q?eeYomYIdAuHr40L5er/ZfukNmSQbYH5WKxaSdMDphKU3Mq+x5IX/bpRYQHBn?=
 =?us-ascii?Q?2egGLGG2oVZnhITZsgCXfWaewPG4pToYJONhrJQT7pGnNUvPw7kcvHWXPXko?=
 =?us-ascii?Q?/gkbIvuXQHFcVZI5NMtTD1dT5ntNAjuzCXDuqJVZXjXzKkSiiPKvRizfgYZP?=
 =?us-ascii?Q?198mcIOkdKxi0bo/ODeRAjKoxDXl5IixO6Pprp/9Yd4cOb6ICInM1LXrruJ3?=
 =?us-ascii?Q?3VSaVQ7WKI63owT4cLWaMPgfE9190iuwmY2c/rWV8Cvn+YyyMa2CPz6V5pD7?=
 =?us-ascii?Q?g0PxcW51iVzXo3tKk5SofO1GHV48OKqtPLmG8EzzyeNIIuxqwXrOMNyEPPXp?=
 =?us-ascii?Q?cZfhuNSRN73ovQrmaDtvyEb6A7PBto+vUD8dcU8+uyQyOR6rNpRYuh+pvtC5?=
 =?us-ascii?Q?vfwIdNu2PbNUsQjYJeB+Vx+O9PjLWsb4tEVaAHX910GOShIkmAlx6/V3JyWC?=
 =?us-ascii?Q?e082OxjMETr9/SPUatuCNQOqQQgWpteTPJWnKcSaQVWJs4vpc1wg2DtCqX/S?=
 =?us-ascii?Q?kLDF715KRCLQ+1bBTQIDHyOmXejB6VRXpwPkd+WY3BY8LNDPsRsm79FkkKOL?=
 =?us-ascii?Q?Cwdeomyiom8jiR5v4z0zhw9N9qo62149vfYQHM2AOcT9JWOuvDdhlWhMdn2L?=
 =?us-ascii?Q?iY0YfDLSQS6XBMYMI6GvB61wSaZiu8EC27CP25jEOSUw3y7Gkk+bGxwSXKND?=
 =?us-ascii?Q?wyBQ/ObG3PnIKUBKL1LysvU55l1oCh49CMnHr79zyK2SlpMEYpo1S0LAS5Sy?=
 =?us-ascii?Q?DVoYoA0+qFZaBe8KABPx8w6l+O9QQ7662JwDmZZqlEDgF1uhqRoIygn5spAB?=
 =?us-ascii?Q?+7JPw/+X8GH0RJIqqs3sdfCX4Nggd7fRp2LQe4RF0OrcmTNiFs5c/Rlb2iWr?=
 =?us-ascii?Q?F/SWrwRTs9POArshk9q5NdgXVNwsnJ07TsuS6nRstKs0kG5zEMfoZXZzymCB?=
 =?us-ascii?Q?JXXBJ5U8qm2ADonj4P3nb9BKAofvrftj6btGmayQ4BDmNStrVt6ss8KZw1qv?=
 =?us-ascii?Q?Ynta6P7JIL2OcUwSdcm0tXzEgeTvHm3MQyHL9tdvUk9MP7Q9orUeNgAsZ+0V?=
 =?us-ascii?Q?sBtIlPQeeT1f0JMs0WQLeNk7DbuzzEp1H9uGqy4N7AcMHynppYZq7OkXDzrz?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uBpO6uM/PBH9/iEHY6tB83dbgwHV0r6+QrccPURvydGJQckWUyOe5xnHhUNqe+LO/5yEAyTiaMbXa8hwdFInOSYfq46h84fuW/ytLc9ms7LPgUlv9D73psC/3imogt0GiZ7s2PM1l9C5EOP+mxmARDuY8yEF3t5wUfxI09ci9vPGvD0oDfWW52dc2w2B4d3lRyv7p1DmPCM+YWkvWppMZblJDaQbOEAQ1L8IlH4h3H4BIDxiFi9jqMD6IHxPxlp7DMjSP4TGEmDJuPzyQSwkx9Iot0GjWO2lvKACfWhWBrz6P+uAM1ThVAoh7pqZwwPagDybEyr0FB0EGkhqozkREDoauLNmtn4scD5/S2/ztTnWVVafVGlTQhtP8Geo0WMP43bN1pqReWjA1OhPS4Lmr5WcnHp8zXcnb9uy1q4wdWCp4yRy49Lzd/z+HkSgbtnvFByoB++1Ms/CgoV2TlVBBWcLk2AP0g1DXTrHKnFyDcTC0XkRTW6o+v6Yzox6vBxOxKDMQYrryHAmpJk3UUzR4pJGiUwt7deBLpLfeHEffitMAFX3RKJA5gj0iKH8mOpRFhKZCAbUHiFoP8N24wbhYJYLhBD46jhbZnl3Nr3d5g8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63058d18-695a-414b-4903-08dceeec44ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:42:51.8594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROjkHTqRQ+o6oGFA2/TnQABLv1NEJaF6X4Sq35P61sCemeU2bmV5gsPRbIgrN26SMukoeeV+PsGgh352ZMrwFuOK19SCOWIb4znby0mmEgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=947 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170139
X-Proofpoint-GUID: ZykuiTcn5RW2iX6RsIbwktgQtKIiNe7R
X-Proofpoint-ORIG-GUID: ZykuiTcn5RW2iX6RsIbwktgQtKIiNe7R

Implement a new lightweight guard page feature, that is regions of userland
virtual memory that, when accessed, cause a fatal signal to arise.

Currently users must establish PROT_NONE ranges to achieve this.

However this is very costly memory-wise - we need a VMA for each and every
one of these regions AND they become unmergeable with surrounding VMAs.

In addition repeated mmap() calls require repeated kernel context switches
and contention of the mmap lock to install these ranges, potentially also
having to unmap memory if installed over existing ranges.

The lightweight guard approach eliminates the VMA cost altogether - rather
than establishing a PROT_NONE VMA, it operates at the level of page table
entries - poisoning PTEs such that accesses to them cause a fault followed
by a SIGSGEV signal being raised.

This is achieved through the PTE marker mechanism, which a previous commit
in this series extended to permit this to be done, installed via the
generic page walking logic, also extended by a prior commit for this
purpose.

These poison ranges are established with MADV_GUARD_POISON, and if the
range in which they are installed contain any existing mappings, they will
be zapped, i.e. free the range and unmap memory (thus mimicking the
behaviour of MADV_DONTNEED in this respect).

Any existing poison entries will be left untouched. There is no nesting of
poisoned pages.

Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
unexpected behaviour, but are cleared on process teardown or unmapping of
memory ranges.

Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
'remedying' the poisoning. The ranges over which this is applied, should
they contain non-poison entries, will be untouched, only poison entries
will be cleared.

We permit this operation on anonymous memory only, and only VMAs which are
non-special, non-huge and not mlock()'d (if we permitted this we'd have to
drop locked pages which would be rather counterintuitive).

Suggested-by: Vlastimil Babka <vbabka@suze.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |   3 +
 arch/mips/include/uapi/asm/mman.h      |   3 +
 arch/parisc/include/uapi/asm/mman.h    |   3 +
 arch/xtensa/include/uapi/asm/mman.h    |   3 +
 include/uapi/asm-generic/mman-common.h |   3 +
 mm/madvise.c                           | 168 +++++++++++++++++++++++++
 mm/mprotect.c                          |   3 +-
 mm/mseal.c                             |   1 +
 8 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..71e13f27742d 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..1a2222322f77 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..380905522397 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,9 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..e8d5affceb28 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..5dfd3d442de4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c32..7b9a357b84d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -60,6 +60,8 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_GUARD_POISON:
+	case MADV_GUARD_UNPOISON:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1017,6 +1019,166 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+{
+	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
+
+	/*
+	 * A user could lock after poisoning but that's fine, as they'd not be
+	 * able to fault in. The issue arises when we try to zap existing locked
+	 * VMAs. We don't want to do that.
+	 */
+	if (!allow_locked)
+		disallowed |= VM_LOCKED;
+
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
+		return false;
+
+	return true;
+}
+
+static bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_pte_marker(ptent) &&
+		is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
+static int guard_poison_pud_entry(pud_t *pud, unsigned long addr, unsigned long next,
+				  struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* Do not split a huge pud - we do nothing with these so just ignore. */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_poison_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
+				  struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* Do not split a huge pmd - we do nothing with these so just ignore. */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pte_t pteval = ptep_get(pte);
+
+	/*
+	 * If not a guard marker, simply abort the operation. We return a value
+	 * > 0 indicating a non-error abort.
+	 */
+	return !is_guard_pte_marker(pteval);
+}
+
+static int guard_poison_install_pte(unsigned long addr, unsigned long next,
+				    pte_t *ptep, struct mm_walk *walk)
+{
+	/* Simply install a PTE marker, this causes segfault on access. */
+	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_poison_walk_ops = {
+	.pud_entry		= guard_poison_pud_entry,
+	.pmd_entry		= guard_poison_pmd_entry,
+	.pte_entry		= guard_poison_pte_entry,
+	.install_pte		= guard_poison_install_pte,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_poison(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	long err;
+
+	*prev = vma;
+	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+		return -EINVAL;
+
+	/*
+	 * If we install poison markers, then the range is no longer
+	 * empty from a page table perspective and therefore it's
+	 * appropriate to have an anon_vma.
+	 *
+	 * This ensures that on fork, we copy page tables correctly.
+	 */
+	err = anon_vma_prepare(vma);
+	if (err)
+		return err;
+
+	/*
+	 * Optimistically try to install the guard poison pages first. If any
+	 * non-guard pages are encountered, give up and zap the range before
+	 * trying again.
+	 */
+	while (true) {
+		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
+		err = walk_page_range_mm(vma->vm_mm, start, end,
+					 &guard_poison_walk_ops, NULL);
+		if (err <= 0)
+			return err;
+
+		/*
+		 * OK some of the range have non-guard pages mapped, zap
+		 * them. This leaves existing guard pages in place.
+		 */
+		zap_page_range_single(vma, start, end - start, NULL);
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		cond_resched();
+	}
+}
+
+static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
+				    unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (is_guard_pte_marker(ptent)) {
+		/* Simply clear the PTE marker. */
+		pte_clear_not_present_full(walk->mm, addr, pte, false);
+		update_mmu_cache(walk->vma, addr, pte);
+	}
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_unpoison_walk_ops = {
+	.pte_entry		= guard_unpoison_pte_entry,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_unpoison(struct vm_area_struct *vma,
+				   struct vm_area_struct **prev,
+				   unsigned long start, unsigned long end)
+{
+	*prev = vma;
+	/*
+	 * We're ok with unpoisoning mlock()'d ranges, as this is a
+	 * non-destructive action.
+	 */
+	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
+		return -EINVAL;
+
+	return walk_page_range(vma->vm_mm, start, end,
+			       &guard_unpoison_walk_ops, NULL);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1098,6 +1260,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_GUARD_POISON:
+		return madvise_guard_poison(vma, prev, start, end);
+	case MADV_GUARD_UNPOISON:
+		return madvise_guard_unpoison(vma, prev, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1197,6 +1363,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_GUARD_POISON:
+	case MADV_GUARD_UNPOISON:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..d0e3ebfadef8 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			} else if (is_pte_marker_entry(entry)) {
 				/*
 				 * Ignore error swap entries unconditionally,
-				 * because any access should sigbus anyway.
+				 * because any access should sigbus/sigsegv
+				 * anyway.
 				 */
 				if (is_poisoned_swp_entry(entry))
 					continue;
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..21bf5534bcf5 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
 	case MADV_REMOVE:
 	case MADV_DONTFORK:
 	case MADV_WIPEONFORK:
+	case MADV_GUARD_POISON:
 		return true;
 	}
 
-- 
2.46.2


