Return-Path: <linux-arch+bounces-9980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F18A26610
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE6C18855B0
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FA211293;
	Mon,  3 Feb 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btrAWpOY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vzbPYNTA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735C21127D;
	Mon,  3 Feb 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619385; cv=fail; b=MCYsDLjXmjU1OURZCVv2RDj1vx7cyEn/jRBpJXw+OzTDgxGfd03IQIP8w7p04WTk7abAQRmrdfw0XnGnFNDd7HuZMcO0QMnJCDvWBf1LVWWEg/NBG9g95Gl4edQ1CrYzblmTxdWu0Oxj88d36xy3cR6XCd+RbFoN8NYFDwaN/LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619385; c=relaxed/simple;
	bh=XFxG0Wzd2uzczXApUmE4vKGd9a4qCWLNKyLy5/a5fko=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fmhwzoRhJmM2mH11GKA4TqWzqxO6I8Ov3P90AFJSy7i2awRduBIPEhHU5acefsEpbH/FhB2tNGO4VwdvhNXu/T7SkJCMdS9SU1dhk6ZolrFyvjB4pALed4nmFGO4oEljfQWG5pYDd7+aNCboWdZjFHyxTM1Vn54qP3WLLEQwQEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btrAWpOY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vzbPYNTA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMuqG004453;
	Mon, 3 Feb 2025 21:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=94m69RYLqNBNbOPt
	VbRk76UIyxyZap5Xoc4hnE8jFWU=; b=btrAWpOYSGgAxABhQUfE2kmKdxqlGh47
	b/0007ZBdlQ51JUJz03W8y6yTdkdoAOG+d3iHj0VrIc3uif+iHW4zG76Otrqh/0l
	7AjmopETTAtG3R8PDjtlV+SByxO7QEj10zM1pyJNXp/ycuF2NrAA/AJeqrupotpQ
	3IxGtTfk/rwgWhfI24IyfGyp3yXNVd+59rWbrACsOdg/t1yl+yrd1VXU4zU1J5i2
	N3GGh2ZDEOCkfd8eDJkGr4p1NV6oQWmyIkCmSPsFP0ZlnCsXQXr7Xq/sPbiGwsZu
	XPK6QB0V/f2naIcDpHVyb/KEQ7bZJ8F1oJcFgYZW+0nVMDiNlwfK3w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73khr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513LGWID029838;
	Mon, 3 Feb 2025 21:49:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p270x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc6KdlG5Xb/pYOhsF+c2YKFv8evJDbqWO3MvHLaQtaGCACdpz3qiTZX3rnO1hbWjNMVPyCRnutw2Mj+QG6zCISIgn/0vUwYX9SSYNWa3ja05TaWA+28GWHQ4mJlBFVXuO4sUhtPBt5AjQyEgCcHHhevcQRXzxhfORH+74pS38Xo5CEVVOZYzMhb1WNOs5qVf6vpUzrbmAAXkGn2iixTfnIOwQNo/rP3dobv4De/D+v1CydTqZuX6YhBw8/FiuqZBhmWSox5RI6HSusDNPCfrRXR0UmTftWEyfiAxxfVORZPO8wS6ExwKDh47bv2AlXLZiOM916kUxvzCxqmpe6XPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94m69RYLqNBNbOPtVbRk76UIyxyZap5Xoc4hnE8jFWU=;
 b=i4sK3dvBAzcI1dDTcdkfvJbBXs17GQ43U72tDx3ot4pQbEfLvx/NV0hMcnUHlRtOJODVBKidxE/RknWDzZBGPCylWZIgttt37s8f2oxwGVgGkZiQSvo40biBru1g7LmqcTRqMN83SCxvDPAqPnGGpbxyot7Xyv1PBVdu3r6FUgZbsLIlxSI4+9AQorLtugxVzNQEwoviNlumyeGJdSpZR/NAUpCrzsM4bMG7GZug+dDFl039W4MB1qP3ttfohMmWQwQY26DPsBsXjofvFn+z8bq0AM9F6cpaB7PlqPfgb+8f7e51/7Z84hpVbY9deEovDFysJnkFVbAo1CA8WQvE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94m69RYLqNBNbOPtVbRk76UIyxyZap5Xoc4hnE8jFWU=;
 b=vzbPYNTACvO1IidJ0mYjIWjBgsX5ICFoLvORbmeZ+aKS0NCvvtz1TARJthFF/yqmOx0P9mCwOcWcl6LviXhQ5Z+xUlFpw8d+OoIUa9WHKWn0AsaXgP7PW4ZovqOtvGgD8upGSJDdRZPyW3lRY0/V6IJwYLMRUUgGwhKKgxSFkwk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:49:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 21:49:13 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 0/4] barrier: Introduce smp_cond_load_*_timeout()
Date: Mon,  3 Feb 2025 13:49:07 -0800
Message-Id: <20250203214911.898276-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f8c2cc-f2b9-420a-d9b2-08dd449c9966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hibKEodXM2gOlTdqtqiApss2CsHZXDoPkRzjRbg4E6khfqFXXcBfqvvpPJrF?=
 =?us-ascii?Q?31KHqfiZETFSepYj/Y/Z8ZyHwIZDz8CWOCAwarkblAiCUxHPsTK0E3lnyo0c?=
 =?us-ascii?Q?gglQPRk5cWRptlWd5/pbbUyXIPiKi1nStpEg3Pn0WpdSUnd2Q8vfrfjWEr2Q?=
 =?us-ascii?Q?FwXXQgR7i3NZSxsqfusb0JBKggxka5dDoKA35XtJAPrsrIUyxp1+hk6DCj1R?=
 =?us-ascii?Q?BMBuHgRhc8fD1xSPib8C5YMe38zE8DEhvm8dYyjAKgh1tfhfhPe3B0uYUUP3?=
 =?us-ascii?Q?ECkxw3Vy15C7qmb13OL6XTe28c0/lKdVSetWqe4576ZOtuv36FArtlN31Rmk?=
 =?us-ascii?Q?50ebNMxTzlanZdRzgZfd1Mc41yjI/KUMEq3d5/EZhaTHoCPIpF6Psd6w01YF?=
 =?us-ascii?Q?C3CT7DWXbAN1JWn095nBCF6HwhM7XJ8w7y/rgsTaRn4nsZ4gaggAkLPGKZdX?=
 =?us-ascii?Q?sAhCZuttOcN7Uu1Fkh73MoZ+KheqMvGiLzacHm2lZBaLDiMD22+Bl4zVYu62?=
 =?us-ascii?Q?/cq0tkdbgz1G2YrrTxczLirdCsYopQK6GdbdrfIE/NH9366ed0dNwJ1PR6A/?=
 =?us-ascii?Q?aqquDbCYyuoUTeUsjU0+bPKIkyh0gZ79v8pPztvEN6PjvAd/Io7SfHKmvM5e?=
 =?us-ascii?Q?q7O4EF0Jpq3QD//hXFcqHjyKWrPlZg95YtgmXObaNaZXSIXtoXQOtzfNtIw9?=
 =?us-ascii?Q?mhnC0pHqww2W4Zaz+EdYp5nNt1NBmOeclmM+BWwy9ijXqrx+G12WZXJU5L1C?=
 =?us-ascii?Q?innxdQ6XC2+faxkSdasnC0rkLnXYv7GGkvu97M2tMkWk27pA5FpaGjuReJaw?=
 =?us-ascii?Q?+Y3xl/HQfAfYiYk3VLdflj1UPFH52ytdQsNaTwZg8AdsT1qWkg3Y1j3aEIPB?=
 =?us-ascii?Q?4Vdj5zHfJrvHrqmJd776d7IkHGBwAvzGzVuJLz+UDa1ts3HTKDnZFyhfQk5U?=
 =?us-ascii?Q?6SZAWYfgQSyzk1fhOLC7RGrGOQhzVkpMMAjEsxx/nJs+aIbf6qIjXZ7zUi8t?=
 =?us-ascii?Q?sMNTn11BHxu+GiKqTZ0PqI1SX8hRjIHTYfQrUGYZrhfIxvDD5+TvvMSSi3HT?=
 =?us-ascii?Q?hTcNpso+qpzevREKKpNmO+BPWiwQw5PEn3dBVRHJPzm/5zucS9I1iQZpOOPD?=
 =?us-ascii?Q?TF3yg7e4+ifMxzJF2EaX9Bz4lTLNPXJAOINKhENEoYqt4YSbnQWFq/DiLfPj?=
 =?us-ascii?Q?oTuvViTuQBQrtm2KLZ4HMsQG+wVQ3cx7SKqfPDmt8N2nek2780Xa8hk/xkYK?=
 =?us-ascii?Q?IHfu7Y1s5MYVQEuqRJ4FUo2Z0Ea1Ykb2guP9wMPiIRGtHv4+RPu3mx2ja3u9?=
 =?us-ascii?Q?FlRtqXGFnOWCqJbZg0+Ai55GBuD6SGt2ypYwPOMvLKS7bVbE7kXMpcPl5Bqf?=
 =?us-ascii?Q?8IR20/KO3rs4LTnGXiSN2fOy6kRA0RfqNJ59u/A4iPl6zO88nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Zz+2sbieKdcIkpO8K2B0SOtgftq55aqTd5zWR53a/jbUbSzlvAoZY6joiXX?=
 =?us-ascii?Q?rUBVSykPHafmzVIZgeuPfDjuHXS5KcpRPVQBDZLXD+xTVmDsN1/z0WqmfzCA?=
 =?us-ascii?Q?oczM70y1Iy9ubgu51e95wudNQHH2b5wyLoH+sZlzBds4BnAUbiHmABJQJDvH?=
 =?us-ascii?Q?zUbDY1UrIX2NOql6odfJkEYkZ7GWv6y/ND19OeNi17a5M4AuX2AfSDYV701A?=
 =?us-ascii?Q?88f4K5IoFSzvHEADAbX+JrNb9jZkM05ndnfNh2bn7v6fOCprF5WMoL+VvdEN?=
 =?us-ascii?Q?rsuWyDWDVzSxNqWEm6zdTzYavtRCo6Rq9GUq8T98pl7zwZ7R2G8y3ggbNMlO?=
 =?us-ascii?Q?CxtmFe05sY7fYwrSpodjffQ+CRuV91FFaDHlLAeuf7F1VJpBmQ87xj1U2A8r?=
 =?us-ascii?Q?PsaRIE4l6uOcwnO9U4FFrrNImbWM5UtTU+F5kdepJ4HRTDQYpv3R9Ev5H2en?=
 =?us-ascii?Q?fHMWWynqiSZ6Df8a/mciAHfqo//hcjsERJQoZ/7aYBJdoLWSBwGLs6tKZsRl?=
 =?us-ascii?Q?6hlqEaBR49TQ6WvvW49ivZC7oC5J4pnRmI8MaqMIEqGLd//WVXnzHaI39fyG?=
 =?us-ascii?Q?KEmm+Y/vdVLfZmoT6Sr0P1gr0I0khYHtseYFa13F4jxn6M62kOrqdJLGE0Sh?=
 =?us-ascii?Q?GFQxTqgT/Wlo/UbpzZ/bRPWfoqY+Tn6zcMtkmPQfOHvnyntjl8tTQcoDf6HQ?=
 =?us-ascii?Q?1+++8P+ztlgxfjnzbqKniKk4MpG4v/HVsAtMQcRn5xIrKCEvCA9WA2YVlDEd?=
 =?us-ascii?Q?Z3TdkVAgfYbuy2IC4/xd55QP9Micc7Pdvf6Fbb7vPdeEdBoPbce4/oyeDJje?=
 =?us-ascii?Q?lnNkBv4HIT3jUXDTmzRdywIa+GEpnS10KdEmGTlnkg5WmraXSpU7HR3mQH7S?=
 =?us-ascii?Q?uN2DsdgN37vtpZu0tUnoXBheRFiUxWhuwcDh40Re/4gacQge/FjlxU2ImdAG?=
 =?us-ascii?Q?0M8oOUl5swhMVNQjRip5MrYD5bdacQAE2S1rGcEBiUtZ2VpTq+eJwfEZ1PcB?=
 =?us-ascii?Q?kvBTbLZpopppw+EnTiuFY2r5LJn4LNOn46UaQoKto6kc/JcDzVcKuQbHvZO6?=
 =?us-ascii?Q?yyEUc8Hy6HhdbcOHKrpSUKYMc4Xz+EKexpgJ8klIwmECY7XrGqTBivX0msKW?=
 =?us-ascii?Q?TC/BvS4sz87/GhBxoGUH0iavs1NCQt8Z23DKMwZh9uCLu3YlWMlQ046HJ9HI?=
 =?us-ascii?Q?D2VDngdBxTiJBbXbP14FogVrGOdQmxCnx3QNl7xoo2fKa6JD/uA6DOTNNy9o?=
 =?us-ascii?Q?tad/H67gX3IODvDmnn/W4drDXF9Z7Yy3wwIpF6grdxvYPcyFGIIihPfp24Ke?=
 =?us-ascii?Q?wa66Cnbmy4ibswLNnsADAXPLBXOAoAsKjdBh0miBXYqLWboQJ+t7MbwHedjS?=
 =?us-ascii?Q?hebD9bW/gSCeNOHqRLzCOV6GVDrgWXhjzkY3Iu9WcF1iuAWViJfTRVcwkBWs?=
 =?us-ascii?Q?jDqKf3On41km8lIrGuKqe6ZF5H1+8Ry4cYuSLA9mmHwGnlOn5qPHjCqDiEWF?=
 =?us-ascii?Q?Dj+ef6wGxJQ8LMMoBB6mlWz+SVYQi953dCieSK7GlhwLbtWY+blu8aGC3n0b?=
 =?us-ascii?Q?UNZcKoCsLBD19ZHk/8nkr2V5FIcPOGbphdQScL7JgTnRnRXp8PD3oqhyjnqB?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BegUmvixl/pQjeLdj1dKI3PjQwSyOsFzC4UJo4XnE7IjXxVfkJuXkf/PQF9JSx9WJF+kIk8sqMhq0fzp/e+r2Fq8FuBAosM+gklyGKVLngcbJtafVHSLgM6XrrpTWvjjiaYmZPRN3Er8qpF1D21XLd+aAyZ78nBPNDXEM7zPL5WxHXoKQ8sXUL6QVCeySjA+7iJ879mFvkG3wUXpdXXyM/Mw1B6HXRdmvd0TiuG21b40k74nrBgTfTbBvy2CB02b3p/3xb+3KD8bJlyx4EymR/7/Z9HZHWaFWsiPbgh9IQt9TETZgt7MLI8gr9OLG+FIXqJP1gZYUntyEV5+oHHUGAh7w7bz3wBgIiqZO7dkA9NAIpXraCLvcOwDZTw5l4T0PpwEg95gdPfzcFnTa/5I6gYwNdLuunjEkENYG7BcGoynZloGWXNZMpKX1yuX+K32HTspidDnRUCYgyyIS5V/9vtWBHTki1/tXO7Zy3TqcVmypQ0EsWtoOLQZZ64yZTYS6deEMpkEJphtwyRgadbEOdmFrWK/H/yhRQoEFBz8n7cwYNhFeUnbWmOmhqN5jzf06MILn/qsqNcHVtVdv34YVCYcEM74QjVO0vuD2s0KVdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f8c2cc-f2b9-420a-d9b2-08dd449c9966
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:49:13.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujAo1VFzxSoNCCrBCVyBN7xNOuW4W3yPieevoWiN4+qGpyNkNxCIYIY+7WEQrQK7af52x03UrhbQvtDCl4oKXOfN1UnIFd6IpWJUYl14uFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=870
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030158
X-Proofpoint-ORIG-GUID: hk52INCY7sUYkjt4d2tJG5xN3rnnkpIT
X-Proofpoint-GUID: hk52INCY7sUYkjt4d2tJG5xN3rnnkpIT

Hi,

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().

There are two known users for these interfaces:

 - poll_idle() [1]
 - resilient queued spinlocks [2]

For both of these cases we want to wait on a condition but also want
to terminate the wait at some point.

Now, in theory, that can be worked around by making the time check a
part of the conditional expression provided to smp_cond_load_*():

   smp_cond_load_relaxed(&cvar, !VAL || time_check());

That approach, however, runs into two problems:
 
  - smp_cond_load_*() only allow waiting on a condition: this might
    be okay when we are synchronously spin-waiting on the condition,
    but not on architectures where are actually waiting for a store
    to a cacheline.

  - this semantic problem becomes a real problem on arm64 if the
    event-stream is disabled. That means that there will be no
    asynchronous event (the event-stream) that periodically wakes
    the waiter, which might lead to an interminable wait if VAL is
    never written to.

This series extends the smp_cond_load_*() interfaces by adding two
arguments: a time-check expression and its associated time limit.
This is sufficient to allow for both a synchronously waited
implementation (like the generic cpu_relax() based loop), or one
where the CPU waits for a store to a cacheline with an out-of-band
timer.

Any comments appreciated!


Ankur

[1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
[2] https://lore.kernel.org/lkml/20250107140004.2732830-9-memxor@gmail.com/

--
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-arch@vger.kernel.org

Ankur Arora (4):
  asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timewait()
  arm64: barrier: Add smp_cond_load_relaxed_timewait()
  arm64: barrier: Add smp_cond_load_acquire_timewait()

 arch/arm64/include/asm/barrier.h | 74 ++++++++++++++++++++++++++++++++
 include/asm-generic/barrier.h    | 71 ++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

-- 
2.43.5


