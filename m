Return-Path: <linux-arch+bounces-14370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18363C12F7C
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B8594FBA0E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85762BE059;
	Tue, 28 Oct 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6KrQR6H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvLsfb7c"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3061DDA24;
	Tue, 28 Oct 2025 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629582; cv=fail; b=cX3pvfcLOYt8oAZ+0J0yFpZ9tL3tAOGXGGMZbCZ+NJ+k7OPDhLegG23fmaLcgYDWUAd5qtR9tVog6bMcYUEKoGDP84ayOihP9QRu1Aq2BYIy13p7BLMy00/wpzCdg5BAC5V4yNGyAfKS16SnURprUTITwBXmcTc8Du71yqIAXC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629582; c=relaxed/simple;
	bh=LaycUtRIXKlqVmSGQlVcNhTyKfq+FIhGNhP1/u8IjgU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Bouqh9KjbSYN3ktkcZiw9T7z6vI8rG+ivPmw8oqlE5J7oFaHs5TUYTSeL6PG3EojLEzSx/GOpFvIHqj5ZNgD4Ldf9A9P7y1bdCP9u4zcvkkIkPm9lECujmye7gFOENB1s53mJunzaAqaLUyJzoYsaf6NwqTR+3ndhc4DdfmPA1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U6KrQR6H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvLsfb7c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NjDm010646;
	Tue, 28 Oct 2025 05:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LaycUtRIXKlqVmSGQlVcNhTyKfq+FIhGNhP1/u8IjgU=; b=
	U6KrQR6HwxLCZsoPAXPw+eH8CZAGy9o6m4ir1vhnBi5Pv4hohGPwmRSPAEFIAC6t
	vPLqniHfyP0F2IOJdi54u+IKHahZ5DKZCC0MLXGwOeO0dGrqHujeeINa5JzhLQAO
	dN5wHAQMTaOqIlYDmNdUOrYnuIwP+H+TpXWkNkz8MdKisQRtGUYpEe2sn3LsCluB
	5qiU5SdPEFvh5stutfXgqlc7ZzI1+qGvLLFTz/LN1PHe7QKDpG9dTnTMLKoySufA
	3CgZ1WQJvVuasZSkn11MM1EXqTp4KX9B9frHvf26S6GCm8em1DfRZMnBLGXfVMiJ
	lGu436LBh1qYoL+YU8i8/g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uuakeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S34HAH037529;
	Tue, 28 Oct 2025 05:32:37 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07q5ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3js+ETVEBNpG9tyTFqt4rtxITxaIhpoPxlasZEfzcsiJrLkxdceCgNWSsLYsFcDAwkMsTE2MYXO0JQUnKWrxmR2tYhaMUHJqMx3/41r0mE3TvCIDcO44EvRcLmWE1rzY0tQ9pfeczyKRwNVELhd2JBeM6l3g+kF3tkGaX2VmNPWX7WDoXmuXetTdqOdmk8F/Uq0XWPIMyui7xTKdlUuaqESRcVchNXBGUCyk2BOW3gGJSYcMO0sbacml6VKqJsFHAaZjF1+rIkTFS7865g1+lk4vKv6qNBbIKUgpOS3RyR9ATbpFwkQ76mWW8mMkaR1TNQGV+ZjeEbUY/e2jO47Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaycUtRIXKlqVmSGQlVcNhTyKfq+FIhGNhP1/u8IjgU=;
 b=MlZTObJ+ke/SYxnVC6aM9Z1t1IIUk9N6x6JjWwc6c4VFWj0L7mxHts6JaixxqDdhgZSWhAkktkXajN/IPVA834onLl5EH41dpl/oQgPLvwx2ewSRW45z4YAy5TBxhtFHg7QkK5TFsI/Y0pk6koI5hZnEncbApoDJDCYxE66POn/cKITKXQY3UtDWtMPjnXRq0PAFhSjWsGoeFz2Ttm4JGDLuNPI00VqcCl1EI4yNsQammsmw+g4nRXuQCGBBitqxTmyBOV0tg7fc3In9y7JxMuNe5CBEEOzyudwHJW3C9uH5gc7OZDK8G4arUwqHenFqH8wiP5vKruG0pEpnF+CGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaycUtRIXKlqVmSGQlVcNhTyKfq+FIhGNhP1/u8IjgU=;
 b=dvLsfb7cj4xDOPBAPWOdRywxxXnkGVAo7oP5GXfRCFz/ONEH/bU72eZ5yKn9i44QtWZSDWv69cwOFnRDtBatPm5JZ7z2JidDcqSK1lAoHqHQEZ7OmvgR3sqPnl/gqwkeJCqOyFZ0vn58xp3bvlSaPpxqMMsc+rQWMrkg9vgCOTY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:32:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:32:35 +0000
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
 <20251017061606.455701-8-ankur.a.arora@oracle.com>
 <874irkun26.fsf@oracle.com>
 <CAJZ5v0gHbOKN_3gVufY-Uv5yNuFsZ7vGdJgm8VMWJMq8EJJ5iA@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-reply-to: <CAJZ5v0gHbOKN_3gVufY-Uv5yNuFsZ7vGdJgm8VMWJMq8EJJ5iA@mail.gmail.com>
Date: Mon, 27 Oct 2025 22:32:31 -0700
Message-ID: <87frb3twuo.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c45b511-c1ab-4263-b29e-08de15e364d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjlYclU2dVB4WFNJd3J1WmU1UndKR3VPNGRPYS9qbi9COUIxaGQ4a0RmNklz?=
 =?utf-8?B?UHo2MVZuakxaMzJIdWRZOGxIVW1OK1J6NnY1dEFRcGZaQnBacTlWOTZYWXFR?=
 =?utf-8?B?RTJKdHpVa0JFQ3hLcGJVYlhER2dKb2dCV2xrK0ZKTVk2VUlHcERlcHZtSlRI?=
 =?utf-8?B?VmpsRkNoNDNlT3BZdk1UVm1hVllsNEIxS01acGZlRWk5WmNoN25XQlJEZFoy?=
 =?utf-8?B?NXh3WmYyVFZQSVBoTkZrVGRzWjJ4N3VmUWlFMHRnR2kwWkY4VGh3VnREWEk0?=
 =?utf-8?B?TGZFN0NKMEF5R3JBYjdYMFg5OTlodVcvQm5vaWt2TUFBaFV5SGNMekVXbW8v?=
 =?utf-8?B?VmMzbnI0eWtFTzNKdDFOQUpQa0Jsa2h1eG1SNkZ5anBCcUtyMnZCaUgxWkhi?=
 =?utf-8?B?RjZVSlpmSEU0TER3bnlOYVpqS0hMWXBKdXZnS1pNSHFHanRUYzJsVlRkOXRa?=
 =?utf-8?B?QkFxNnB1QnN1cGpwSHllN1FxdGdIMEd4R2dSdDk4dFFuMzVuOEtrTEdVcXF2?=
 =?utf-8?B?R3RnQmg2SVdsTmVLQ3lEZ2c0SjRxeCs3cmMra1IzZDF0dXBwWUxFYnM3TCt4?=
 =?utf-8?B?ZjNGaXUwSXZsNEZNTWJtUVQwNXQ5eWxmcC9qamFJVkN3K0M1eU80VXlYejN1?=
 =?utf-8?B?cHZCTGNYdzkvZ1hONEpBZStkOGIrcXNMMm42N083OStPcXd1REpKVSswTmxM?=
 =?utf-8?B?TVphZ0hoaWtvcytUcFdjUnNSY2VFMk85TWNRMVpqa1ppU1VhR0R1MEFsMm1s?=
 =?utf-8?B?dDlQbWM5djhuR2RxbHZnWGp3TjlxanBrYjl0TzZpUXRKWW41Mnl3T1lZYXdn?=
 =?utf-8?B?MjByeE8rdHBFcFVtK2RFcFpPYllIdjcvcDEvNkFKTGpZK1RYVCtuTTdqZ3Ar?=
 =?utf-8?B?UFRhZTNkWmVxa0svWkRXV3YzRmdlU2lNTzhCekdoanNDYStIREhhMm52NERJ?=
 =?utf-8?B?cGFFbzk2RnpoekU1UkswK0NVcit1aEpOOVI5R0VVZTZlVWw4MWNNejRJblRl?=
 =?utf-8?B?a3k3Y25PbWdkSWJRMHhxeVBSNXo4Vko3TU51bk5ta1MvUjBFUFFWKzdvNmtL?=
 =?utf-8?B?TmVKanJiYnROTmtxY09lUTFrYVRQUDhKSkpKeE5NM3VyZnREZG1SU3p3MTJO?=
 =?utf-8?B?eTRoSlB1ekNIQXRtVWsyV1NKVE1zSG0xNGE4U1Z6K3hTYVNHbUZJekdXdmlD?=
 =?utf-8?B?ckF6eVgrcGJnQ09NVDhQSHdhTENINW9QSURiRjJGdTduV2xEd1U0dDNSWGpu?=
 =?utf-8?B?Q05NODVUOFNDbUJ4RU9CYzJEdUVkenhoV3drMER0VDhsVk1zRk5NZEViSnk2?=
 =?utf-8?B?alJ1Vzk2b1I2amdyanJsU09paXpLeWUydHRSVkdTT3RpRXI2ZlZJbFlnRlpX?=
 =?utf-8?B?ejQxNzJzU1oxSmlVeVFPVTJUN1UzZVY0SDFHR1ZadHpBR2x1SkdiMk9BbzBK?=
 =?utf-8?B?U3h6RWtXOXNEeVM2amFHRythcnp0UGR1cXpTRnBON21FOVpkazl3Z1I3dG1H?=
 =?utf-8?B?aUF4V1daakxoaExoNGFVQWY2SDA1eWhuUWJ1eXJYQ0lNelhDNnpxK1d1dE5j?=
 =?utf-8?B?Y0IwYklWTGlzbjBpQWpzYjdaRVQrZmFVK1lmeGpoQUM0dnV4MU9JSCs5Vklp?=
 =?utf-8?B?NVIrZDYvbnkvNXF4QU5IdEFsa0pYdk1rNDNBR3ptOS9HSCt1dTBRVG9hOXRi?=
 =?utf-8?B?UU5nL3B1djZKZ3pjL3JteVdCcTFBTURjK3ltK05ZdzBvZUt1dVJQa0lRbmtP?=
 =?utf-8?B?bGplWVZJcGlJZkgxM3B4MVhWMjBGY0M3ZVZYejN4NTk2ZmJvTWdud2ZIdW50?=
 =?utf-8?B?ak5WZEFYTWk0bXpweXo0UENGQkJUV0NQY0R0N0xXV0R0TE1XSjkrRnNnenk0?=
 =?utf-8?B?cmdEcXlLWFFsL2dDdklkOVMvWTk0U1cxVnBJdm5ubmNSNlJpTEdSZis2cElO?=
 =?utf-8?Q?c+sXPtgWEaS0z17hljeL6WyB53UVt2DI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWVUTjZFS1BtMjJtTWtDYldJQ2t4QTByYUwxdDVzZmVMMkUyNTU0UUlXb2dR?=
 =?utf-8?B?MzFIdlFiYmlUVVFrS090Ky80bWdpR1pGOUY3cGNkY2puVHhDM2c1TE9PbVNX?=
 =?utf-8?B?T0FCZXJ4b3NidmVYUjNmbTNpNVhHa2VRZ1ZReFoyc0JacUxpb1o0dm82YU9Y?=
 =?utf-8?B?czNaU1dzWnFPbnQ5NUxYMUJ4TlNwM0lSUHFwY0RVSFdEc2VqaTRTZU16c2xT?=
 =?utf-8?B?YTNZeXpvNlF5N003SXJCeVN4ZGdWeCtiZ0FzUlpVM01vY21CRTdMVHBJeHhi?=
 =?utf-8?B?c3hlaUJ6bnBoR3pQMkFCZVcxTHNEbFE5aDQyOWhRUXIvUDg0RjRtYzZRcGFa?=
 =?utf-8?B?VXFRbXJZdjNydVRZdnU4bGIrcEZNdHNZWllISUV0MFVQL21QSVloNnVBVTNl?=
 =?utf-8?B?ODY1aHo2aDNJSk9oR0Q3NDhnZkhka1A2Z2lrM2lKajJwZ3RySDZtTTNmOVg2?=
 =?utf-8?B?ZlVmY3QrWk5CRlFjdG5EaXZkZS9uQVZPNndFcW9sK3BWNEN6WncrejdadFlM?=
 =?utf-8?B?aWR1RXJaWXZnRi9rOUVydW5kWTY1dmZYVWhyK1JlMTNLKzR6YmsyYU9JQ3Z3?=
 =?utf-8?B?akxsdDZoRGpUUHlDeEhRWVIyOTlUZ3h3bG9qeWprV1R2cmloeVB6bld2bkN3?=
 =?utf-8?B?dmdSR2lsdG1tVVdKT2FoM2R3Y3BNeFYxOUZHQ3c2cEV0SDhjV3hyTlpNUnBo?=
 =?utf-8?B?SGVwL3RtOFRoU3N1WXRZd29Wb2JtOWxIRDd5d3Z0WWFmOW5HcURjd0VLMFYz?=
 =?utf-8?B?NnRVMUhyTnJMaDFCc3FSaVhBd3poeFJxTFNrK25oUThnREpPV3ZSZ1ZWeUxI?=
 =?utf-8?B?ZCtsZEN5OGd2TDZsZy81NGppenA4ZXY1amZjeVlwd29aeUtURDVnR05BWmc5?=
 =?utf-8?B?SnpyNktPQ2NlKzVtTmpXN01LKzVqQzlHQ1Y1SStkYXVSMDgvbEl4QVpYZjY2?=
 =?utf-8?B?K1R2VnVqZVZqQ0piQjBkQVJ2M2I2VkdDaXl6NUhidS95N0FtanZGV3B0WDBH?=
 =?utf-8?B?QlM4TnFVMi9ZU0JWQmNPckRvcDk3eWtjcUl3MWdOdEIvRWJIVzJxOVliZjRz?=
 =?utf-8?B?QzZEVERJbGEvR1dybWx1Ty9oOHZUemZZOWQxMWs0ejUvZG1QVkdYTW1Ocnl6?=
 =?utf-8?B?a0VLTnBHMnRFTzZOTXIxVDcxcGJ2RzJHU3hNTERnY0pPRWltUk8xZFlaVFN2?=
 =?utf-8?B?ajhpNHVGMVZXUnlwREFYYlA1NjVkM1l1N1pJUXhiNmx5YlNHdHJ6LzVubEs0?=
 =?utf-8?B?QWNtMEsxYmMwYmRpUXM3dFpLRmJpL2M4MUcxZnNHYzJVSlhheUk2UFNOYzl6?=
 =?utf-8?B?MFZ4U0FxaDhpWVdHUGNUM3RocDN4enBsdmhzRDk3b08vNldnRFNvRXZjbUk2?=
 =?utf-8?B?WFBma1pGV0tYNzl2Wmg1ZmRnNWd3MHljTGJJVEdzaFZXOTl5UDZnK1VjdXQ5?=
 =?utf-8?B?Ym8vdm5KTW1qK3UrRWpibW5zenlaRldiYTlIaTZXQTBkNGEwVlliWXl2ZDNV?=
 =?utf-8?B?WkhvTm1aTC9YaGpEbWZaS0xHbmRWVWtQY1l3VXh3NlZ0d1hhcWdpQ05lajFK?=
 =?utf-8?B?VkFBb1dhMVZpU1ZRdENNQUxCLzNxcjB6RWFhV05jdW5iUHBQcTlxS0M0LzMz?=
 =?utf-8?B?bk1ueTRpbStyUHBXNlNDdzB4aDAxdHZUdm5CMC8rT3JMWGJFN0I3T1VjOVJv?=
 =?utf-8?B?OGgzc3dzOFJRSmdNWjdXY2cyL0c5RmwvTkZwd2tOb1ppaFNUdm1nMGV3YzdH?=
 =?utf-8?B?dzJ3NlFTTGkzaTZDRmFBam5IbU5EanVpaVVYUDd1cGRaZFhucFNWditUTUIw?=
 =?utf-8?B?N1pBZzR1c0lGQzBoQk9tR2NNMjQxcTJFV3ljV24rTllpN3o1cVY3b1lTWXpY?=
 =?utf-8?B?VEdoNVFFbm9mTDFWVWs3emdXU1ltM1U5V0YrM1dKRi9kMEVqeWFDT2lDWXNI?=
 =?utf-8?B?eitJUHdGMDV1NW9OWHhuWXBieFgyclFuN3ZwemJsa3lzcUlMdnhFQ0FjdDlZ?=
 =?utf-8?B?UnpPazl4K0V1YzVuNk1hNlRqY2tkd2NuKzhIZndmWGthanlxbGRBaFkwRXdK?=
 =?utf-8?B?U2ZxTkVKS2NtVFFwQVhZbCszanQ0U1FiYWpqemZoVHc0MjllaW1jRUpvUVdE?=
 =?utf-8?B?TzFRUHJnUFU5Um9LcFl5bSs5d242dklZQlF1aUxGZDV5Z1BXU3p3VndxYmZz?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aH0UCk6x835Au0sGigvjndvu9muLZe/MPG5tTUkOai+LTnYIM6oy4c6619bvEiaCdLDuyLPVKGjektEIPJR+JFFUaVJEu4wdleG1BE3zgEFRlL6ViLKXsq4VNdcTpSGBAAmI5uuJzAnH7oTkmUPSeSWTDRbYdtq4/MmloMJMc2VDIgTk98joDa0IuVIJaAJEdQI6EuIkX/PTp2pNf2+1wLtSt1UK/QUsmafk4dNyzq42dFUSoOo9AQ9e6uTB/0tJX4ChPyu19Ofo6pgeeOeDpQnbzoaBmnOKZnpoeDIiy1jO9Oqw3DutVlOc63MOgz2gZT4mzGbpd1SXE+1gvcjtbnE0HN/40RFFrUnlgFfk9Lhn3/SiuxK8+VGG02bm84cFNL/ZlcPLI5+L+DhKUT3Zh+2Fx+sSXxGDYKfB1+zm0FKYvp/ylDQzTGAQICOHd+pVak8jAn8n9ptyR2EVuzIMgQrIWy6zQT0etOgnXuEtVA9LgVpHOJUTZwyy4GqtYBkjUYG7x8CdPKx5LF3IvOXXHcfAf8/QiUs3mcYdmYlU3xzOc/wNL9P3xNtQMcWkGGewIKUJta0Y+j/AAOZj/VIDPyGM5A6nA3Ov1GxcmlAkqyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c45b511-c1ab-4263-b29e-08de15e364d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:32:34.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qm+8DgMrNNd22vhmZOPXS9sO/tIuXGZG7fffFfeUq0sCz7KZBjid9VVD0tCNW0n0rJyIwDKQLinpyAriqYHXg3CWJBgeYHqZg6l5r8c2eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-GUID: sJnw1XCTLdxRvjZBBScM_lP__XC_Y4zr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfXwvVMP72XfH+4
 eMVe72a0MVANtCCgXPRh4SFx/ePvGj9S+Cc0HNksdj9j+3AspQTruEZb/rXswDuvqrXIq27+vUy
 bLaOglsVTYxe5y8CCOdBI9yqKYjsQdTO3ILSAkiP5D6Xu9S3WYjvjJuJxokYqyNorGY8DX4pO7b
 gVeslsRjpqAYCOfjV1f9HC9LW3bpYchsWGWDlijSf0mY/81ROQ6bNv6s8dippdevzRiLjZHSQfR
 5/8IyWK+DgcEyb6GZXFaZoyBbXoibyoz8ABUwzsSkg7lQSjbWIBsNFCT3jE64gpYTPouNydSZAc
 rfNG85qHLz0CHKT583mldd564ri0d51Hr8/AFjcIX8drpmywV9GWI+5ovULaCAkpoPOogUa66hj
 weAMhnK+ZCcm50RzuZGz58VqlejuGg==
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=69005576 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=sPa-dtvYyaRsMRBzNkgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: sJnw1XCTLdxRvjZBBScM_lP__XC_Y4zr


Rafael J. Wysocki <rafael@kernel.org> writes:

> On Mon, Oct 27, 2025 at 9:07=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle=
.com> wrote:
>>
>>
>> Hi Rafael, Daniel,
>>
>> Could you take a look at the proposed smp_cond_load_relaxed_timeout()
>> interface and how it's used here and see if that looks fine to you?
>
> Well, can you please resend this with a CC to linux-pm?

Done.

Thanks
--
ankur

