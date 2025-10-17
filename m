Return-Path: <linux-arch+bounces-14183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61671BE6AC7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8257429EF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885E3128D0;
	Fri, 17 Oct 2025 06:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R3gCOeJk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cORKyKs4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57513112B0;
	Fri, 17 Oct 2025 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681805; cv=fail; b=NVoreZoUaj4axusbCxOnW2RAc2VB5ixKG/PtY60d1Opp6Y7DmMpMWOxgoG/mYpStRO2TNmX7mj4wXEz2LwH1HpVxuWgsZbYrLud6EUCTvKgCN/edFXxWEsDEe3H/CbsuVIbei5HaGI+C7O84bfRWLIcm2FBwcJy8Mg6k0h/hwGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681805; c=relaxed/simple;
	bh=FK52YMMCVxwCs9Y4sdCTYteB79+tTa69hZfF0rFFTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j0ATXfXe/2XjLqL1Ij/vmaAPmbXSA1BrqZwEh4zPmc4vaZbxotXTjR7BvtyQM/CrE2GmNIXmz0I0bCGP1EsMAXywYNHtoYY4uV3935FMx0RkC4FbgtuIGA+5WYjOrCUvuQzEYpdM/tOZxsVrwQqA2no9L76+zHFSrYgN0E4xgHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R3gCOeJk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cORKyKs4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLuYic023857;
	Fri, 17 Oct 2025 06:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=; b=
	R3gCOeJkP8wmhp6X5KDi/fFhEPMgVG1ZeYIbVgd45ow7K+IY3qP93JTf+liJKFfa
	k93R6lmpFlZMyz9DI5kS6j+Xadd9nCw3oD7Vdw6nXOShWjyvIXzfuRIJwWtgiucN
	ajXEpDZ14VSkBUzEDlTFtw2Xb2/FVCAgmVDMSHb/KAKMxnqfbD1Qs1aBfZ+w1uml
	DzLSmqst8wVkIx6gy2CC8L64HTzq6K6JZvKxV6+lHzM0KzH0YrKJa/bjvhB423LO
	itUU0HMbCiLk3/otDCfV3HiCt18Y+03khABMk6W7CHdtpvB6uoJYPNUbjbe9WVrv
	rhHiq/0gx1XphefXuWP4FA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59jcje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H40Voo024807;
	Fri, 17 Oct 2025 06:16:18 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcnqyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUH8lq+nQ9XTPo8gz78ocXWwDAxqapPHC7pAyBd/xTYrzCIJ0ihvdKvLd+vk8dv4FNRTC+ZlHzHxVywZozO4kDbxMhDZkbbdEoInUHQMvRUqLVYafENPfXLU6xLj2qvx1RRKrZfQ4G9d4GPqKx+Q2445tw2i4oa4NgrHuuuWuPLvSu7cK42XnRsUspFg2Uet6r8VP+Z5SYmY7Y7eXd3dnJCBgbfo8dVFeaKyVJ7yt/1dPU0SM1MgHj7U+leR5fxg/U0oM7VhcvFyja02Pj5oqOe76mzxv20M8+LYlMfh2S4L9m64/vHkWGVANGjIxZEQqWePRb9U2qnmIwVgssepnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=DU01OUPXjfTqAq965VuDXda26qersyOJV2mmeJdq2FR6B3amLlP9ZKdsoF5Wnh5+M5m5e+APG+cdfD/PLlkiT6oOkKZbRTgV6i9pWZuHM82fV6hG46ROB9O9xdfxK5kPKrEEOFP6IZPE/39t00iF3iuOsvSFLkcnXo00DUNcum37bTrvfpzmbjHWoFxq5uk7ARwlH1SI+CdLWTJzaslriZ1OjfAbDvdu7xjLZv0uYx5QGwxsPpDoPe+dg+lTKN7wA/QseSrq6/obUKyyJnvfphP2IIkpM2moHDCzJIOcuuKbw2lmtOM3rGBmCMpZxA5D5nix1s4Fognfn91rRZUKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=cORKyKs4BfiFBuMUGpc8RLIvLMCCEXZItS7FnVBwmANwoeBYEkJiLulxvVawKjTmwdZy1RT+TB7f1OHApr//zAKrCY7WQoG9w7LgYHWmVzJBYlHs77Oj/gc2JorcZobE56/Y7w/KcDQsO3Jhn78tYS96UiUgjgdaYpDW14m/J4s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 3/7] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Thu, 16 Oct 2025 23:16:02 -0700
Message-Id: <20251017061606.455701-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: b994756a-d2fc-4222-85d9-08de0d44ad5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpOygwpN4M3SdRhg2JYBDC2CJRT8MpUWL02IKNvTNECSs1nAuF3inkBHgNWR?=
 =?us-ascii?Q?O4H/mDKzTPfTzQELZ3M9DIvOY6m19bJPgOCMuD3Mr60DgHy9IZ3z+zsJw+C4?=
 =?us-ascii?Q?+fOh1/puUb4XfSHMcrVwV9bJT/o+vWj6LYo9zhpqO/1MlOUas9JJPrQYTE2v?=
 =?us-ascii?Q?oOqPLhrhVZkrKWUZb10Bpt5LGkBAktwp/aPPHT62kLxpdCJpYB6B2ig/HkW9?=
 =?us-ascii?Q?+s9x38ACuriGr0dqsaxIQkX25Nn05FlRfcwuSvEEExGSW2WZKv7Tm70u5V1L?=
 =?us-ascii?Q?D9Fv58qAGSkbsg3J1HUwNiOWOeetdef5FZfLJtRto1jP7NactGnh/p57Tspz?=
 =?us-ascii?Q?MOjyp8ChcNIiho8iu9oUJcEPCaXHlcmI9aAwdG1TlMaw277NcgyIcGEZVf2W?=
 =?us-ascii?Q?BA60ZoWTQJpVIXMCFrIAnTIuEb+WoHSkv4FljsGbx1bAdJXZ+oeWqXhVTIG6?=
 =?us-ascii?Q?bgInxOXZ/XrXXXviUvRSHID8k3eLYznySklR0qnm9QEEfkHJ90osr7U8syZs?=
 =?us-ascii?Q?7y+KoX7cOKETmVzSsU7VZ+tbzd6VcPejTOHSFvRqFKFiHbf5vFNm/bXefqCF?=
 =?us-ascii?Q?g630l0AcT54R58ZT/a8rL1cur6LEsp07yOPOSfuKO+zq9Z7PkRZBkJf/EZFT?=
 =?us-ascii?Q?7zS2AkyN3ru9qrtOpkv76885tyH7g5RY7txVQjcDFtWBX2mXZ18lew35Xs28?=
 =?us-ascii?Q?m+zPwaen/IxaBARaW+PNa5BP8/VajjG9eLuTydicm/PJHxAOAFB5wk/nOWKv?=
 =?us-ascii?Q?Gg4fin0+8zJbZRj7Xng7G3gvQy4RpzuLUObMmU5Lw8ttGq0yaTRA4xICYM0J?=
 =?us-ascii?Q?Hr/kd5sycdws5nHgpxI9itvElzjfExHfqwhFOREFMzUWlBfMLOoL0GmXOWyy?=
 =?us-ascii?Q?HN4+Olz0auxW2cQIdPkX50snAsiQuqyJXRH6XRpn9Rkk53BjtOc6zuD4MlVO?=
 =?us-ascii?Q?rXdilcJUj0mZfnQpB8AOWI+JPep5fdX/6PKYRbA1KTmLcOqn7VKgyZtcMnUY?=
 =?us-ascii?Q?q8QR7giw43Sto5cGTUG408qIu/uWo3iCcMoHaDmLhRAJdx8BkWs96Sw+Kajw?=
 =?us-ascii?Q?ihMbn4Hz+jncvi1yoaQyiulfCX+5xZ3swhTwjMGf3p+Fcz5MrV5ErzIHG4Sv?=
 =?us-ascii?Q?Hf/jx1yhcBQbzcumc42N7nYKAiL06iddkv4QiJq7Ayb4yfzWxfJOTyMYLiNT?=
 =?us-ascii?Q?93Yh2iLuIAaAqSsLWmwHkmVPzphlLc2dAwmPyT9cwkBhL88TeLz9FwGJHi5A?=
 =?us-ascii?Q?MefdRi7I33xbpb3DtpZeLg0F8VqOlNXCVBaYyNY6FA/uONfmDEzq/zza5KDE?=
 =?us-ascii?Q?W/MnwhoI+ItEoywkZeJ74DsjiSmo5tkjUL8yuBNSh4sHJLp+RrB95x2SzKXH?=
 =?us-ascii?Q?yxSNFSpIBlC5iwDOhF1OIJe6N3VyqzFzLI4juJ8XVTW1N4ycfr0njqU3VrEw?=
 =?us-ascii?Q?ZSzVtxi8A5hdT40jraVpK3Isatm321h0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kz9IvIRqoj43pSMxjLtPU9S4BcfiZ/k3kh3j5jzSsqmOnNKWpzarrms1k0fC?=
 =?us-ascii?Q?H7AKJfeTHpVEhVIYbwNr2kdRFzOmvgq1/FG8dNxJcaIkFY9qF6u3R+CDMTfV?=
 =?us-ascii?Q?Bfd0Fc06jRGVYerL89m6EGnoQfE5tgh+2Q8vhQrFY2abosc8GB7efbdisqg+?=
 =?us-ascii?Q?8tUN3U9nuT3HQ3+O0OTCMWNi4yIGcolbbFd6Aa/3LhU0R3wAavcj3leOkz7r?=
 =?us-ascii?Q?f5+piYjPGpcdGVs5J6b03ylf3Cp26JvdVPgX1hFXg3/Ckr2dxervPVoAVUvZ?=
 =?us-ascii?Q?ia3NAXtESSR/8DDQ5ZP931Jl55zbSUdER15BWhgV5anDz1H1Pyy2mNt1B38E?=
 =?us-ascii?Q?1Zej2FgNupFtXmqpydR7mJQ1154i0mZQavkpElvfhjymoxhDVpmUu5LwKupd?=
 =?us-ascii?Q?RWV9adiLMmh4UX3YzU8hwc5ZvrxWxZnLCYJzoYJCAm2vL/Pu5r80jLTzo7PG?=
 =?us-ascii?Q?MYIfsL4H4txVMEoUO76Ca+xguFCn7Zzl3aUeRALq7C2zyAqmTg3kaIgOC7zn?=
 =?us-ascii?Q?Y4r8KMoNmlsjUdF4G/lvzWeVZLXjGa2ALTAnM+yFVQdCHxa7oVrtY14wLcry?=
 =?us-ascii?Q?+rsage95J5+K+nDl0H/PcIdgOXmUya2QItm2Cb3quoFbVeSUTR9XFqisD9wD?=
 =?us-ascii?Q?3AQT5Fnf1GdstI/NXCMloMqpoEq6X2ck42Z1RpN7jWDhjAzP1bVwyDV4GBpO?=
 =?us-ascii?Q?9PD1XdGo3EQJCTiLOMl3Hy/ORYt8+EccdEE1oJcBO5XNJQ4KQTfM2bAmWACM?=
 =?us-ascii?Q?Lb9ldsIi22CS+j8+P3ss3oF9moU8gKtwjSjlocM5jjhCigTlnoHC6wln0lml?=
 =?us-ascii?Q?SdkgbrfoCcfkXbIM6bLi0E4YNEg7PMc/oXagQYSojI1/nc51M7tqQ8ftHLNK?=
 =?us-ascii?Q?YLO2mFk8K6YSTBDdE5qbKkTMFcLUCJKCA9fvwKt44UoWtzQFylWVICBUX7FV?=
 =?us-ascii?Q?4uTXLoRTPVWHjqyqwcC4T3rSNQ02EI7HdJsSTWzqBbbiTJboF8efUAOfssvK?=
 =?us-ascii?Q?yxC0a25zJcMNqYgevncL/TkscSlWLqeWzrRxaD+Jl6uNMKc8v2othn6y9BIL?=
 =?us-ascii?Q?FLbbaoayg4zKD57txrn9sNcrlygCDg+8Jn+lVZcd9Ti38Gfx4XhxNJO3JHwo?=
 =?us-ascii?Q?CCi0w6aAuBdpXHC82fSVTUhb8oQAyisjGxzB1O6oTD0B1ySRcysJIq4T36h7?=
 =?us-ascii?Q?twmgVZsgE8o2ujGaP8ocbzkoYwInrhHOijE5VJy2YVYTyrm6szKxD58xNsMu?=
 =?us-ascii?Q?Hv06jr8wq2mSG3QN5Rx5yJ4LB0JYjLT8MuQYWI80CWuuGIayo6ryBIWVud/P?=
 =?us-ascii?Q?/oV1hW6OLXtyy+k7g7W+0G4Se1V7q2FhECkqlCGDZGnRG8P/hkeegrL4xOBT?=
 =?us-ascii?Q?CRfKg9AOL3tFK3t7ord9atrElRUHwJ6OkjWUvjFeAASM6gw+sYigzOdt0w2C?=
 =?us-ascii?Q?lZONG+7ebwEdybGXiWqXfAAsk0wlH/RG4OTZjVscr7uyZeWmhYhGHqA8BRev?=
 =?us-ascii?Q?TbU1rsUtyeUp0VRsNtVOKBCLgBiADh+FmWUNbMp9iUrA1B66a1TNj2go/F+Q?=
 =?us-ascii?Q?wYYIUxvSwIxWRyVq1w4WaY1dsExlEz80vwBvKolfcYFqNZ2eKtydwQo4TVZT?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9y2vCfHLNywu5b2wC99n5OSWHZshFhAvuFHDLHbIZOYASAMQ/0GC9dEmee7iyZlZgK1NvxVYRMUT/TLdlkeXqEnprJX9xMv22i6yvXE2FSQHsac2+AQYljlw+x+C3a06okNIwP9ewesXao5ipTuUp8ztcppjId2eshODD70CPaIEBshzpvwoKeaDxZl1MPYdje2DeKLub18UhDC881GOdMwdF3pYd6R05GBBin5EsXoGHdCQW7s161X+gKq73xnwF7nxe7VJIeY46U6JYyA4ajK7XQwoZ6fbdFfLmaLzqNTAyoWn41fGmDTO4v++yISj/um4MOpJJbZ0cvHkG9B2VqvvWG8w1t3vv/dj+Zv/4E4taZDBUrm8M1AzAs4KSOauTG0AMQ6L3zjN6Vx9WL8j2YgxzwH9yXneieysAaW9jRaBycu7c9fA43w1sdTyulaRJMonk/FV71Yzd6slZE37rE4i4f2a02+d+lgKT0aqkM+vLgN7g78lchotxQPkQIkR3eOFxCEaCvdET42uvK2dIQkhC2VsRrBl5NlYHJUHWK3ziAYYg2ATr7c5atzQsbPFz8MoPAwCqOC9DZxGj67M09FzYl72ZKw6raeKCKvkRFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b994756a-d2fc-4222-85d9-08de0d44ad5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:15.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjaceiaig+9r0sE/objVriy59eTsWzaOUB4PRYRBKCvr7g6h9TGHJqiRSc1gtrcg66Zixmxp7bkpDD5Aev0VuWSbLnB3WNVOaXmyfgKdy0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX/ax0AgZoN5Q1
 fMAwRcmJbCbWQAE5IFdVfHxmdq1dKFRU6+ExFo1tejxwdqyDu0Sg21oT8RyONwTW70ReplfEiW6
 2mkZuAf89H0c+DB3G0O5Zaa61KFIVRloOZyLa2Rwdl5/zg/F6ubFHjt/oH2wCHd7sPEgDVIm/rD
 skRM/kzTZvKD5IYmBvZTOHgFE0PKeGJUMN72FE44UqSYWcrShcMMUxfriGgVMWk64rbgZzOX4FA
 f2yh4APolh2Iu8bT0d/4ZNV+KohY/hSvw4jRKWArzlS53IswJ0rOxRxk5yWMIxexGp/BcBtDo2q
 xi9eZPcc91cWBFsGZMYJu3ts2DzzlLHhjdlKedk/gP+pZg8/gjGK7E1UwslTfwoRWt13ts5MhDv
 sMYS6jZWwyXWgUy1MYy9s1uuBnQLAw==
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f1df33 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 5CopTsZQZUZoYtpEao42f3H6REVTqkA8
X-Proofpoint-GUID: 5CopTsZQZUZoYtpEao42f3H6REVTqkA8

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.43.5


