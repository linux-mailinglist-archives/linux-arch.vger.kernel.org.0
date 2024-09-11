Return-Path: <linux-arch+bounces-7213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB3975948
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B4E28640F
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57531B29BF;
	Wed, 11 Sep 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SMjyRypJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="epJQceYI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFD1B0131;
	Wed, 11 Sep 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075536; cv=fail; b=XBHsYNkzx4Kshv5vkFcpcMcvvPV0TbX5Bl0f2l23oAHnzPPioS8y2Mf2Ql9zkSoSbP05txf4RnFlklzei4s9UtWb1eSbqA9zq0ej09sKMmV1JEahEaipP774RzLZPH+ryfW+gLRyD0cYlFw3irahPmuu/xULiW55ytbmuNCJwVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075536; c=relaxed/simple;
	bh=z8vCDiocG6gDX+N/yzxXwfd1AjtCpn2KfmYC+gjruyY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jq95vQkqExCfwYAhfR0cVKYYE9VUvWsc4VaqG1FB6v+jznjNbqdIA8ZHd+9EnhSNUGDKSygzTPmivBYx9e5+oogBWC5HEy+aL0nK2xd9g3k4KmbrXZLMhEH8t5IeYCudn0TyC3hpS52eO+fYY21gEalKeraOPHOfp0xReORRIng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SMjyRypJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=epJQceYI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCgCML030702;
	Wed, 11 Sep 2024 17:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=RmM25u6Q7kZ2ekym7ie7ANshuhtTmyVtQHNqIt+0COk=; b=
	SMjyRypJfTRm0lfFctLd7pqZcGsEbrF/ofoM1njOAKqUYzOutCO840rndsHhmDMX
	No06r4zZbycBhMu0hBSGbOIb/Snzcmhp6gSKSDIKK8rn3ViaDbp+O9VfOnb20fTR
	c230hH9Ju4s4fK22yD0Ho6oyhUSFoCFd2AFB1/OSW254dtAu1Q0U+2oIWNYLVpGn
	u69uwWH5M/sXewGNszQmxyKfjKJQp4ZPR1hMdaRCgkCMp155g70xJX71rk/xjsid
	H5ivOetTEHgBFI7i07PVTW8YGslOLJIKydFJOay9yrh+SzOOCE+nQGmN70eyuf4x
	4ouHE+s12bKfCyifeJaVwg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gevcrv7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 17:25:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48BGv2BQ006210;
	Wed, 11 Sep 2024 17:25:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9a92e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 17:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aReWC9weAld/IYA7NkOwJjfI1XlsNZSweOwCnz7ctIDgCpoeyA5BLICNuEniE/w4misOZ9luIjakRemVLzyWZFjpVLN1GOOkNTW3BpNZN45pKHk6IyzdETq6dVmzh5H/HkDOMB2kNGQNxKwqp68hc/s1JPfkHzXO1SOB3hA1itDNZv/Wm58Q45Ay/Cim4g5r75LTQD94+BANP5CI+ovH7Ot7p0rWHMH9uHVPIDAyGXb2H97otLcIZcEkjs6RLJUk2KRRRBVBn1KvDhfm0pNvURnQ0OrXcum46D1dNud+K9wYGXZT7UcgOhe6p3lvHWby8A+78CfOyrMRl+oXlHwBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmM25u6Q7kZ2ekym7ie7ANshuhtTmyVtQHNqIt+0COk=;
 b=JL5O9nI+pcPH4B3gwHyd6pj23W6AySbSkmCYZzWSC7PbhFmYWjaXYcsciREEu+uArOJwR/m0vAYiJj1IC5oIxLwW3aZswnzzAcm9jBs2NUYx6EsFtDYnkKFYcKPZNz/XD0qDpZlMhGRN3SjB2sul/cstlO455UHkjm/ZgZ1Cfi/qJD0SpsM+o3BBiaLgf8+qhpagayXp5Hw15Dsot93lFNnfOzX67iBxl8aBBWBpFwY25KRHHAKPVIc4DjA97twX78q4AEjDnnMGnKUawjgEeYz4Ax9AxIpyxbNKKd3c2W7kK4zZqqDk49rvNes/lNoMqDtgnqskZcDaky8ANSC+OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmM25u6Q7kZ2ekym7ie7ANshuhtTmyVtQHNqIt+0COk=;
 b=epJQceYIKY1dTL2XVJ6h4cLvY4a10U0QPoLPozjwRs68m4AC0PYxvXIFuwrJ81XaSIin5TswNU/QdSl/ZFnSsvxl5TZaJ6oci5aeIBnqFYmqaMrZfKRQH4nQTxoWPiSi1tfQr181x1ZRQVL2CW4pCER1zqfwyxpKEiFvZlWZA6c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB5817.namprd10.prod.outlook.com (2603:10b6:510:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Wed, 11 Sep
 2024 17:25:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 17:25:18 +0000
Message-ID: <56fbf243-8e50-4760-9ed0-8d1f0f7e5ed3@oracle.com>
Date: Wed, 11 Sep 2024 18:25:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btf: move pahole check in scripts/link-vmlinux.sh to
 lib/Kconfig.debug
To: Masahiro Yamada <masahiroy@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier
 <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
References: <20240911110401.598586-1-masahiroy@kernel.org>
 <20240911110401.598586-2-masahiroy@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240911110401.598586-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0633.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc524e-132b-4959-53fd-08dcd286b4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WThrOE0vejlkM3p0NzFSelAwdjEyMWlSUm5ZSjY0bnpiRlZ5NEVReE03cGpq?=
 =?utf-8?B?NU1XWnAwOHRBeXlUSUoyYnhsTG8yZ1JkMnkwOElSZHZRMTZPa2JrM1pkM0sx?=
 =?utf-8?B?VE5ja3hQa1NMSjZxTzhpSEVPNDRFWGNXSlRwUGpwc2o3RGNzNjFDS0lwV2lt?=
 =?utf-8?B?cFozZndERllPYlh3VlQwREx0SHduQlQ4UkJnWFhJelJVOWpscDJoRWErOGpO?=
 =?utf-8?B?YkJRRlMzRm5MRFYvZzNMakdZWFk3eTdnMHdhUVJQSzFFZmkyTXd6MzllMUJJ?=
 =?utf-8?B?Ym1NMHdSNUl6ZXlnUFcyQU5pcWUraXYySXYxMVQ5QTVRTnBKcW5walFyWHA0?=
 =?utf-8?B?VXVtMmh6a3V3UUxITkVUN2E4M2gyUmY3aDkrQjVwTzBZVE5YUmRQWlJWdUor?=
 =?utf-8?B?QmNlT3k3dUx4Ympod2xaeityOVZ6TTlYeHRFRUV5Zm05cDNnMG9jUExTYlpn?=
 =?utf-8?B?eVFkc2paVTBGNVZ0MXNOenVmdVJFNXlmNEdHRVRocG1zVk96NXpBaHJvRExz?=
 =?utf-8?B?SGFUOFIzTTFPUmtFbDNTRksvTjNRa2RCOUo5NEExWEdIMzJoOW1OTHRGRHNi?=
 =?utf-8?B?QU12YVRpSzdvRWJPZG9TYjlzMW12c3RSTm9WdEU5NUxGdFhBTTJNYmdpT2Vi?=
 =?utf-8?B?WVJMc2ltSHVkdnFaenRwTC9DN1IzSmlFTTc0TTMxRVFvSHRoYzE5QTUwRDZp?=
 =?utf-8?B?NHJVeU9Rb1MvVzlwdFVxWTRxWDFYZjlkMW4zTlJKMjNxMHJMYURGRVRXUXhH?=
 =?utf-8?B?dWdiN3BoZ1ByZjZBTGJla1k4Q2JGMGpkVzFjb0JYcW5CaSthWXQycU03MXBW?=
 =?utf-8?B?UHBsZVB1UGhLWmJPY1JHT1FDaXlISVRoeUFoZXBZT21Fc2wyNVNvWE8xNGF4?=
 =?utf-8?B?Q3pvYy85UXlKQzFMazJkUE9xaXh5SkVpaWprMTdMbml1Rm43N0piUDVONjJn?=
 =?utf-8?B?enNib2FueXdJM1A1bWQ5dVFEQXRKdXVwSm5zTTd2WldnWUlSUFZjbXlQTjRr?=
 =?utf-8?B?cG9hNVFFMU5TaDFsRTN2WlB5b2x6MUJCdnRQTWdWbXZ5a2RralRPZlhrZGR1?=
 =?utf-8?B?WGZKRWdTaHRXVGxRaktFUmpoRGZEV0s5cWh6QldHakNhOXYxQ1Q1ZWpZYm5N?=
 =?utf-8?B?Vys2cWxJamdkMG1FRnhwMDl4bHVlQS9wa2xneVdpYzltWWk2ZFFyeS9mUVZk?=
 =?utf-8?B?WFcyNjVZUHZjSnQvR29qbG43TFdqQ0FjSlp2bFZlQ1JxRHA1Wld0WmFDdTdG?=
 =?utf-8?B?MTNrcGd0WnVacVVoYmV4Q1p3bXRYVS9WTjFDQTFNejdJQXZFRkNWTm53d010?=
 =?utf-8?B?SkVkYnhGMVFmZFBlbzRRRmpXN1BTYmNzZXh2bkpGZy9RVW5zcTJOSGdaY0tk?=
 =?utf-8?B?QUhVN3NacHVkcTE4cFBuSTZGcGdnMG9CVDJqQ05ScUxPdmREY09PamM4VnFm?=
 =?utf-8?B?ZG9KRTNoN2pZTFQ1czRGNGhZRjVuaVNWL3hVaVdLZDUvbUQreW85VnlKYW81?=
 =?utf-8?B?enBzN2pKZ2xidFVwcVF6dzRtU1phNWs3Zm9HcTRwc25hTU5Pa25lTWhEVE5G?=
 =?utf-8?B?NTFjREhRKzhrV1ozVUhLUjF6REE3NFArU3AwNTFPSFFjZmdlZXpBSHk1WG1O?=
 =?utf-8?B?SE13S0crck5PV3RwRFhJMVd3VEdoa3dNWWdVNVF2SHF0Y0pXNm5mdmRabHo1?=
 =?utf-8?B?a0t0OGpFdTJFZ2QzS3BXTW9pZEp2TGhOa0EwU1FzbUhSWVBTa2gycFdsZExM?=
 =?utf-8?B?VFhEdndFb1VjYzJ1d3FXR1ZwM0N6a0NocXFHV0RUWVI1OHVVWUoxWTJLYlNI?=
 =?utf-8?Q?qcxMr5rN+D8luvxapuRIVHxe+XMXHyGvS96F4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmorS1drcE40YkFoT0NGSnFoUmozMWxKRnI4bC96bFg3OTY5ZTQ5SmgxenBn?=
 =?utf-8?B?V1JsVnAxdTFVd2hSenlHZERoL2d1ZGlhbFN5Y3FBZEloSDQyMXdqUWE5WU1L?=
 =?utf-8?B?c0NQRUpVUzloT24wSEh6VE9RWHdIV0JMUm1Va1AyMTdXQnVXdTd1b0tGNHF3?=
 =?utf-8?B?bzJkNW43SU16UEhwZUF5dnJsM0pINWdNQ2NpZFYyMVlpaXdDQ1QzMCtTUGJZ?=
 =?utf-8?B?VitTSGlvSFhhaENOdlEvblVGL2RqSWdwR1BkQk94bGl4N0U1QnFPR1dKUGI2?=
 =?utf-8?B?bGxYNStrWTU3Tzl3ejA3RmxER0gzWEh6Z3FrL24xb3lYUVdwdmlpOXFqYmhW?=
 =?utf-8?B?Y1psanYwMTlXTmdUak1wYWV0Z1hxdVB0RXZZWkltd280OTcxc29pWFdVcjJK?=
 =?utf-8?B?RWxJdEtWTStKQ0NYUS91aURHMks0UU1adGRlUitxUG55WWRvNncxYWhXNXFE?=
 =?utf-8?B?VTJROW5CU1BsLys4d3dWQW1KbkpabEdZRjZVZmVUci8vSXk4M0g0U1c2TlNJ?=
 =?utf-8?B?blBpRXZOOXpJbWNvWVNzM1pvV0g0c0VranJwRzNzZUpFVkFyQ2FkaDMzSmNy?=
 =?utf-8?B?bDJHbi9EWDFBOEdxZFh5TzcwRFB4REdWNHYxNXB3Ty9wVmYrdnZXbFFGSkRI?=
 =?utf-8?B?c2xMSVpBeWtmL1NBSGM4bmZvdEdlblgxU2hScGxBWFNUTUVKUTRFOFNxK0pu?=
 =?utf-8?B?VDR5aEJlOCtZa29QSU1KODlTYzVZVDJQRDZCOXpHNW9IWWU0anc2Z2NPZlpF?=
 =?utf-8?B?RXMxQkVFcnlKRzJ2WWN2ZTRhc3FoOXNGZ3N1ZWhva042V3JlVWwrUStrU0gx?=
 =?utf-8?B?NmpNUVpjL1QwK1RLZTVFMjlPTXpPVDNLOW9zc05wNHRWNGtHV3FTSXFua05V?=
 =?utf-8?B?OU9oeG9QQXJmaERlZnIxYnBGQlI1M0hmanZUWWFHUndBQ3VyN29lUlFyS1hn?=
 =?utf-8?B?L2xjL21JNmdrNHY4enlrc2dBendKclRiVUtQZ0x6TzZIaFhNb3RZc25NaTVV?=
 =?utf-8?B?a3VneU4xa1NoSHd2ZVRzbmNYWnVMSzl6Q1VEdEQ4UnAwWFZVR1hFTmppTVAw?=
 =?utf-8?B?eDFSbloyZzBsUmd4ZURGSWkvcmxQQ2ZiblQ4L0V0U0FNQWV0QWRhN3Z2aWl6?=
 =?utf-8?B?L1NpZ2lsVHR1RWxUek5oSi9DTnQ3YS92OTdPTU9ZT2IxSWxNWXRkNENuQit5?=
 =?utf-8?B?RiswN3pLTmJmRHYxSUZ4YW45cXFBRFRuMnp4dFJ2K252enYyd0pvODVTdFFV?=
 =?utf-8?B?Si9lR0QyV1VmcEFHaFdvaUx3WkYvVDNiWDhwSDM2ZzVmRXVRQ1QyL04wOG5l?=
 =?utf-8?B?SGJsUERiY1E2d3NkUmd0Z1NjR05OL05JcFl5TXBjaW1mYmJ5Sy9MdHJZNzlI?=
 =?utf-8?B?UWRHYXFGZ2NiaTFVZlZGbEZTakszeDM3WnpTbk4zQW9Sbzg4TlhheVJDcCsz?=
 =?utf-8?B?OUN2SXNRd3pWcHdqc2VrQjJRa0xmQnV1VTNRbzdvTTdvVHFzak5aQVhGSGhH?=
 =?utf-8?B?dUV5WXNJcmFTdVRJWDAxTDErT1o1TTl5VnpRQnp0Z1J1TURiQVJZTDdLVFd0?=
 =?utf-8?B?d2kyMGNxbWpwbmtFdkdlRnM3Y3lXd056NXYzOElyQkllOEYyZDdVTk5nbkRm?=
 =?utf-8?B?YmdmZkZzQjFDajNFVlZxVERKaFVtZmJ5THdNczJqRXAxd0ozYkVqSi9TKzUy?=
 =?utf-8?B?VjNua3cwNXd3ek0veHlYYmRpelZCbG5HVTYvaUJ3QjBhdnVsbXNLaitPZFV3?=
 =?utf-8?B?elNOUmVBR20wMjc2eGVvK0JpZTljVkw0RGI1eFQ0dWJGRjNTRDZWS1MwbzJo?=
 =?utf-8?B?amp2OEdKdktua0ZkRlExSlBVOTNsS0doSjQwTVMvTHJ6Wk5uMjMxaUpDbUFp?=
 =?utf-8?B?aXhyVmg3TXVDVVdNY2d3Q09GVDcycHBGSmEvZlB5OFNNVWRrVUZMd2NYeFUr?=
 =?utf-8?B?cjNlazY5dDhid0ZwUnNOTno3WEoyZnZXYWhrUXdlMFBxZjVTK1VhUC8zbDFu?=
 =?utf-8?B?V2Q3NmUraGV4dnE1ZVQvSEtMSjdkME53dVhraUlXSFo0dEZLbnBrOU9hRDBN?=
 =?utf-8?B?ZCtrTHNMQXdsTGlMdk95aU9CVzluQWFFeVZSck0wbFMwQjAybTZ5VDQyeWdU?=
 =?utf-8?B?VlJ0cmFOV1NkVWxqWjhxSGpDdDRvSjlPaUQ4Q243bWNNdTg2eWhZaEVZVXhV?=
 =?utf-8?Q?6sZ9A9XvnBiEU4nn3FVWyGo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XkFF7OczryYQ3VGG7yA25dJecNxsyDACxgtRSU8/9jIBvxeJpwdynpG0Ri0uUMKsSh5u9nbKTl8dV2PEF0Ex7AQUd4g4QprN6F2jDLz+lmPqTBQBD/n3/n/tBtpJ2lmWKNurNOoP1F+Fd0EQkVqmTDkEctqsnrkRQSClHO3kY/4Awn0op1W/u7reguKtozVjZzU1+i3B1Cqi9x9a5icT3dCkcoem1Cor/Q38UvHRyqLT5jK0jDQrtO+Zyh2sdBS/Usv6ejbSZqxkVWpNOLtFuf3+cCE5JnAYwtQZGnmNmKCRuwisMFmuW8O8Pcfeq7ylJ5RN/itLZi3Wgz/pk9Zf4KWT+utguxmV56yBjO9qyOJS8bQ/IfcfqZIVj8HjgEtAWu0caFZ58kH+qaXtIauRGyKbpYgfZfz/9a91AYcfurwneeaKEehocjmg0nIBscjABmBMDi6N5YkFt7Up77W1QhxrTlZN+P8BGHalTk93PhTH14LBkQ/h/8gQFGuD36kL5Ge83+iJVYPUxOsGL9AyLlOn46zmC2batSOYm6uVD1TaOOuSNs04zR8tSf3zSlLbrnbsIyT5EKxP2V/XaG/ytkvMHhKh0dTmkgK5Qn2zlV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc524e-132b-4959-53fd-08dcd286b4b5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 17:25:18.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y41BHdHvtsoLVNho9fLyDCW5A8WffXsA1AaQfBo5Y6wwrZCws5Tml0ZIt7lM+3NSUm/rtf0rp3bg78L2NXQxSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409110133
X-Proofpoint-ORIG-GUID: _skgiHfz0tTpSrY-ItUH3hz8PF6qlsOx
X-Proofpoint-GUID: _skgiHfz0tTpSrY-ItUH3hz8PF6qlsOx

On 11/09/2024 12:03, Masahiro Yamada wrote:
> When DEBUG_INFO_DWARF5 is selected, pahole 1.21+ is required to enable
> DEBUG_INFO_BTF.
> 
> When DEBUG_INFO_DWARF4 or DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is selected,
> DEBUG_INFO_BTF can be enabled without pahole installed, but a build error
> will occur in scripts/link-vmlinux.sh:
> 
>     LD      .tmp_vmlinux1
>   BTF: .tmp_vmlinux1: pahole (pahole) is not available
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
> 
> We did not guard DEBUG_INFO_BTF by PAHOLE_VERSION when previously
> discussed [1].
> 
> However, commit 613fe1692377 ("kbuild: Add CONFIG_PAHOLE_VERSION")
> added CONFIG_PAHOLE_VERSION at all. Now several CONFIG options, as
> well as the combination of DEBUG_INFO_BTF and DEBUG_INFO_DWARF5, are
> guarded by PAHOLE_VERSION.
> 
> The remaining compile-time check in scripts/link-vmlinux.sh now appears
> to be an awkward inconsistency.
> 
> This commit adopts Nathan's original work.
> 
> [1]: https://lore.kernel.org/lkml/20210111180609.713998-1-natechancellor@gmail.com/
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Nice cleanup! For the series

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

One small thing below..

> ---
> 
>  lib/Kconfig.debug       |  3 ++-
>  scripts/link-vmlinux.sh | 12 ------------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 5e2f30921cb2..eff408a88dfd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -379,12 +379,13 @@ config DEBUG_INFO_BTF
>  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>  	depends on BPF_SYSCALL
> +	depends on PAHOLE_VERSION >= 116
>  	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >= 121
>  	# pahole uses elfutils, which does not have support for Hexagon relocations
>  	depends on !HEXAGON
>  	help
>  	  Generate deduplicated BTF type information from DWARF debug info.
> -	  Turning this on expects presence of pahole tool, which will convert
> +	  Turning this on requires presence of pahole tool, which will convert
>  	  DWARF type info into equivalent deduplicated BTF type info.
>  

One thing we lose from the change below is an explicit message about the
minimal pahole version required. While it is codified in the
dependendencies, given that we used to loudly warn about this,
would it make sense to note it in the help text here; just a sentence
like "BTF generation requires pahole v1.16 or later."? Thanks!

Alan

>  config PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index cfffc41e20ed..53bd4b727e21 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -111,20 +111,8 @@ vmlinux_link()
>  # ${1} - vmlinux image
>  gen_btf()
>  {
> -	local pahole_ver
>  	local btf_data=${1}.btf.o
>  
> -	if ! [ -x "$(command -v ${PAHOLE})" ]; then
> -		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> -		return 1
> -	fi
> -
> -	pahole_ver=$(${PAHOLE} --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/')
> -	if [ "${pahole_ver}" -lt "116" ]; then
> -		echo >&2 "BTF: ${1}: pahole version $(${PAHOLE} --version) is too old, need at least v1.16"
> -		return 1
> -	fi
> -
>  	info BTF "${btf_data}"
>  	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
>  

