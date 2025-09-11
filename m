Return-Path: <linux-arch+bounces-13510-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C6B53E4C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 23:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC1B1B2927D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 21:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C152E2F03;
	Thu, 11 Sep 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBezDeZM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MSQYIemE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F82E5B19;
	Thu, 11 Sep 2025 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627942; cv=fail; b=pDZzTEh/MvRaibIzm8sPNQKranPmTsBuflS0VMeB3ScInfGEe1zSZ/Er1hon0u4MSWIb0rq4tpTtqq1VeKZnkWAWnjhxlUe/+i9LiM6fWnVlSxp1BCVf/tfsd9UhRtIK0wigNmddSKLzIh5QFckL49oXq7FJMv/kie87BaaeQXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627942; c=relaxed/simple;
	bh=to0L0WyMMZjIIkD7wbhz6BXsIr3FlytfEaJZ7Qt7HrQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=J9T6DylkfskHPnap8etTWoJF+zZpcDGC5apSpit1k5n5lY5lNlF3Ab0hMXoOsKF6amghb5H2Ql9tSgltXc5AxWOJLcBkjUdoGehj2w5BskSH736vUClwpsoNhODFByhceKovKWrK76l4LlFhQh9CnAosrJ+w5TdC0vdR+7Wi3f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MBezDeZM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MSQYIemE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BLDgh4013410;
	Thu, 11 Sep 2025 21:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=to0L0WyMMZjIIkD7wb
	hz6BXsIr3FlytfEaJZ7Qt7HrQ=; b=MBezDeZM//iuuvolLPydwcfgHBfwZ2akK1
	cud0zobneLEDeMyU9rvBZpxZhJW7/HkcTebue9CHV0oIiByi6HFXS6WgK3FWRojD
	B7Wdc+ujtc7VDiWrzTUEgVLGkiNgMhylfRIwNsb55e5tnonoODVS4ehZlyD3S1ee
	YT45lCI/y1N6qtuFAgnLflDoGVPVM7iRhdx3ixQArxRAGbiwSrwt1xSu/5IVR98h
	mwmEHH5KO7ROXXowA3rsYJrWimd26HQn8y4oegQtPs+Cv6ykl+FwPOjH194V8Oce
	02Dl4IoQ6ufA2BT/5A+iDXP05K+sPuVHLEF4ndWp9IKzOggOxl4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shy3em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BLbWjN038737;
	Thu, 11 Sep 2025 21:58:33 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdd2c4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzpD/Lpf12/ofqFVUcg6PXp6/l8sY2AL2kwX8M2CgVjXYqSYUerIY2d33WJXJ7LHrsQFuTwjCdVTcrq09TLR+K5ft4ZRvh6Fvv8zPs29DQuvZAnC6FF5qkxOshs2DqKuILvqO5p/qDIBwegXXROmaVeQY2nm8fw05/dlPPMdCONov2w2L3VdGJHdm1/1HAxMWTBBCe2mmM5kcaM+AF7tLNPL8sb9rfEl1s4jYZ+/ZOs1O/0NbzfrDH1eZ/aIzHdsj8ZJVsRKw6GM4at+cd1yB/RmH3dGZQVISj7MBuL01jITSDvfnRWyD0wAzbhs3wxh+LIMB8yFt9xohwRCt2mu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to0L0WyMMZjIIkD7wbhz6BXsIr3FlytfEaJZ7Qt7HrQ=;
 b=d9HcUhLcObRUOzq/iZ1PPYJo++eD55I38WNtxwIH7xJo8SkbxH0HsZzFEdPyQuwmwP6i6e+nyFOd9ONqlzTxJqavg/UcriMD664mfm7u3qLQhhGiLdI1crJ3+63unrt1C471UIclGkGCa1nqKNAlFxfHkY9iQ6BJBl0odmccrSsbFEv5ffG2B3egGjFw6KVttq2d+HXZN+xPxTGuBo7HQqwsH6yixx75arsrozlYX5h85nSEqLoj3f4xJUldkzC0CFv6nAQSt5k+p7H6dbp+CE6UHVvoh35+OPk54HF8mWrrSlijqIJc1/bQnAEF0pQcZLd0rlHbs4dU8gM9F+pI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to0L0WyMMZjIIkD7wbhz6BXsIr3FlytfEaJZ7Qt7HrQ=;
 b=MSQYIemE26Q1LA1tEasb8GsYJsGGUrCx7y8o/KhLV/SwJ+1bkBcyqG+ZVatOURx2EDH8UdJb7yns/Jtd0FH+Id3JXCxrb6FBahkyMM1JN5JvQ3Qu89hdpp+pZL8Rs9hX2D6PR0vR0097dNivUYwxwuqEU+eQrlNGCTeSpFg7icI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8176.namprd10.prod.outlook.com (2603:10b6:8:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:58:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 21:58:23 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com>
 <aMLdZyjYqFY1xxFD@arm.com>
 <CAP01T74XjRJGzT7BV3PYQOQOwZVud3nL7HfcW3kzU_fPFekNHg@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
In-reply-to: <CAP01T74XjRJGzT7BV3PYQOQOwZVud3nL7HfcW3kzU_fPFekNHg@mail.gmail.com>
Message-ID: <87o6rgk5xd.fsf@oracle.com>
Date: Thu, 11 Sep 2025 14:58:22 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a3c473-fb70-4877-7300-08ddf17e5421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGukaVNgNkUSigsuqIBgAHzHB6kx6K5rdu83g1bxOsxPniV/IbgnhHpWXyO6?=
 =?us-ascii?Q?M4iP+0QW2h6PwMtX+2HowttkovV9qxByfam3vwdPbPgM1m7TCZRjWQyTGo6w?=
 =?us-ascii?Q?OKtqEJ4KINbO+UXYFDi8oLI8CjjeMgUSB/AgpxuYR3yCocaffPqNuF3JoClt?=
 =?us-ascii?Q?R3N28b3mj3KfzgTKRBlL5mvgIyTl83kptJxECzB64pJfx8F9eUpt+lPgwBU/?=
 =?us-ascii?Q?ygKCYbtGH0HUEuCdBHIqjKkfXUgQJ9J+WgzqscmNuL+sUdyoG8F5R65YRn8j?=
 =?us-ascii?Q?kIQwpxjvsMmlLoEzZjTqcMUeniXWcaSujG3ucxDUP5HpzYsMrXLhNsgGArR/?=
 =?us-ascii?Q?uFjVzbnuScxenpEZL6XWYhOuBQbj+RwtN2+nYrG/kJTzRv2c+gwVoyvqziAz?=
 =?us-ascii?Q?lRCay8Lr87YjzxinjO/Alq40E5LoByB05i3Jdhna11kz3EtlF5flQL37vnkF?=
 =?us-ascii?Q?ufQAet9Q2a01eYVQ1PqHyi8sQFRMzBmdCa7lHDqqEngnYSvVQRRo5bWtGGC/?=
 =?us-ascii?Q?QmHjltHHaJKUd88MCWq0sJNEHbe+kyh0lC7Qj+dUSfP+UVjhAfjPNH9bsPox?=
 =?us-ascii?Q?vr/7F5utbXbEYaeRP3UmDgYrBxx2DfhE9GLhvlENJWJVHdOqoF6RdoK2Agwl?=
 =?us-ascii?Q?MZVpIswkdXbZFP2l/yj7musJGgtbnM0Anldo1yBIWuwCAyT7iVJuB9emawr7?=
 =?us-ascii?Q?qc89JwHYIkj0z+Sag4PinFRyVHueU0dHpC83nVNctBYZ4FCnuj74NCpVjjp6?=
 =?us-ascii?Q?qXpS7AbVHzfv+djJDKCEE0Oy5UAwRiTCYOMbxKTQmb0rJ6MI8Y9pxnEc1r9G?=
 =?us-ascii?Q?MUQ1sEW5M5TJK1dqUurCXEw5eFYyOlylxPY/HklEt+Hc6vaC7GfrqxQKfIUK?=
 =?us-ascii?Q?haXJGlQoaCO4OBnLTvGgjk9zOgQtYaI8sgj/3uGfjl3uPl4RIONSFlekRcoQ?=
 =?us-ascii?Q?abfv/2hZpccPhFsHDK6KEPB5STes/35nuh1FKQQkhbjw3cduZ63I1rTOFWKd?=
 =?us-ascii?Q?l06qbt9UuBaAy3WuyxAmWAO/+4yQhFYFESTta+NCanO+jDP42XIzpiSvsRfS?=
 =?us-ascii?Q?IEa0hQmxfRYkIp+shsDlhZy/5vOr0pfGOYCvKnfXDUYI0r1OvK7A443k0WVc?=
 =?us-ascii?Q?SMqCbgPqOgLZd4AyAMEG5sRxTEzVwjvL+WvoAZpvRls84ZWimEz7I4i/pupY?=
 =?us-ascii?Q?8jYoYrgOcS/rC6VWa+wxkvOzdyPyMI/8BxrCoCxIOQuLXXTFypzrVLFBdbJc?=
 =?us-ascii?Q?7tgtTy6OWC/skCyZdkg12/SnrD3px0rEeo5q+XmK6nLsH9KX4cG4HffX20mA?=
 =?us-ascii?Q?wN+7W/RFtmtbh4azR0Iwk1mwDLTMJRJ3z8sW0FL+NxrHPJ/lMSESMxwAiWYT?=
 =?us-ascii?Q?ipF8tK1Bm2mD5EXnNmgkg+TwpZXYGoYcOEFHIuBwHEjuhoL5nI4t5RmcvF4h?=
 =?us-ascii?Q?rXP/oQ/KwAc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hADpYgZfs5IxWuiT+B/i2BWhYeFh/n2wjdi0pYYd1BqraUiYF13tr8KLo75o?=
 =?us-ascii?Q?giqnbGPALcqmjZ+a64mxROy77xghV+cE+pxb4enTVTo7DLEE6xyHFnwRM/hb?=
 =?us-ascii?Q?WdRWCDkwK7oe/XEmA9Pikg85bbldaecoAtjIAYUTksQvWM10HjzDdJnabiPw?=
 =?us-ascii?Q?RZm1YQ5SmbvhPHdzUoL2w4zX7KdZu9OkmN1momEuXrI817piSIGz7p94FMNW?=
 =?us-ascii?Q?36g/1xhsKurPyKNLzqLEslM+yWvwv4gKeGonIhF5457Dd7PGrBHgGcCSwOe0?=
 =?us-ascii?Q?Rha1BiujkNQRDfIPpHota6rUZPzttp4H08K58j3jkPX2w+nF3Wk+fN/5VDJr?=
 =?us-ascii?Q?2u28waBoaTVF2Qwvcd2XZgmAaLtItQgTLVgzVijSItUcffgIcBgh2/wNZApx?=
 =?us-ascii?Q?/IHu6jZ1u8sswj6PudlEb/0gC9f9J57XcNp75tE5bfIpVOG9YAIBGFzwE1AX?=
 =?us-ascii?Q?HXKtONvQ/P/9l0f8nOfvEu4k4q52XUJ0p0NASTfnIV2nTyUyjMb8Vhn2nIwH?=
 =?us-ascii?Q?e/LUMPVHIVJNoY3+WO0LNsrYm1dCQU6nV06gulu5e/gFJ4kDwwbZQsoZYecS?=
 =?us-ascii?Q?o/szpkzmBtvdD3xF/mfTtClDLeor7UjM623eoZ3AU5Aa7I3LKX2hiJ8IIMwC?=
 =?us-ascii?Q?mspavoCfD1yGrByDJRoLYl3FnaClWMisqQQBGCkJ9fAks4c5Kbklv2LBHilI?=
 =?us-ascii?Q?Eu53yin5k8f/wtcjc6BLwzH2zQf04Me1cpkX/mOCgK617E5esp5iWSWTAfJ4?=
 =?us-ascii?Q?6UmLVRrf6B0PP7eTx70OE0HvypoW8N4fHG0n8qKsw7MKFqhtKr2drA5ZbbK8?=
 =?us-ascii?Q?+/wBuJ6+Qe08uk7cetZHOMfAS5uVk+p2delj+GG0QZjTZmMLtyNWAwkkzq00?=
 =?us-ascii?Q?ABdNkZSDgMdcxCzrB6SKr1yZJLDM4GZhY5F9NFKcTLUh6w2n2s39Q/fgJwtb?=
 =?us-ascii?Q?SihLsB4tLjE0JdXHD5br8wTF3DNMp0SUn78QC6IkQpyFoHLcR3ZnUPPLRF1k?=
 =?us-ascii?Q?ZOBrE+4rLfrKs2iXHhcimYEROiOtXe5lOFE4/6paB19X0Uv1/Mj7MYOK3mpP?=
 =?us-ascii?Q?xSpKBTnyoiq/XfAWayFeRBiueeyMGb4n1wWXz+axzyLkZCxW0EGUiczdcIRa?=
 =?us-ascii?Q?1y7pq1Yc9nRhk+Gq+djXVZRf35kYexou3hLno+fJJ6lAh2IKGMT0F+2U6GCA?=
 =?us-ascii?Q?F5iybVj3JCSWRuPghI3CsLnEWqYKsFiwi3WXmB+s1koq2wNPQhXarFp7SJVa?=
 =?us-ascii?Q?Q3ZpURv7MvqIry4V8d/jqdaF5Y5P+QfS/b9on1XPyEoqcy3BeXGAnw8RFCbk?=
 =?us-ascii?Q?ytoO/2UPnMyzEcGAEYtNA7C7QXWlwIxaIuOoUkmw+j0+rP7HpFE7DfDOyk2E?=
 =?us-ascii?Q?Vw4YJWhD/Bd0X//eq10nsml+6yK6k4f9CkbpPaNCCb5Vjim53+t1T8sfnUgj?=
 =?us-ascii?Q?YY9diUusIIp7atNLD4KZGxnLR89ASIKpdMI5sQAXhYahK9Cu286P8868AQuP?=
 =?us-ascii?Q?xcgqA01kXBTdjQ4DK7WsBeLJlaZ8k5Pecm8T8ZGKGBzVILy/rDO7hY9Qfmlj?=
 =?us-ascii?Q?eMhFsdEYQrLfykezdFvwr9j71RA3ufoskYQMrcjCtF6JE+cJOsJtyF1ffRfc?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e6pQoNgU7gR9wXZ3/Wq9K0B4PNnrvhUnCQ7sQla3QqA+6MhfEksLBq7+HtzAgoqKsy+ZT7bEclMLXYySjl9u6xW2jqrA4Q8RAr4+/tEC7vppAkp3Nqz8WHxeUVkOCIQl+uAOkx2WMEsnMxJufqAD2pYXPkaZY7+xbCPxYyaHBlq85Y46LbLkzZqvyrAECZZUY19R4FJT6OdH56sBprHo3J9nh67KJqU8YWCB5nFkeeczHAdA4imbcBEumCTT+0n7TUp0WY2CtqXNJbKeT2XpSVopl73GtCzYm5L6v9vlWlaCN8b96KKusYtp4Z0dGYgZpW9buyjde+LQnxjcudnv1NOAqcCtghlDUAJKVN+oBMmrPazH16j0tgGteJ30eaLVdEjHYiKRJz9WAoAyW8iHVv+7svJbiGDAsatS3jbZtg/4pNBv87JvlZh4zLXEA9oQZn2ZQ8i+FpWryYnnNkfOHF2y6orXo6KlDCMO2SEgzvjf5wUmDpv37McqAz9NywcTlhD5r5nzyS4UdujkUtvCa8/fqEtMrFULUQU0WuH+D4nrSJJxU0QdUHFvZUFpGic1RorQsvipF49dXGqfgt7YEZ9nqEsxv0F/U/qeLNPSIxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a3c473-fb70-4877-7300-08ddf17e5421
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:58:23.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kBTrsumB8pE2PGMZjvQbkh9vDT4eWrzUsW8wv9ecYhZafcrLwhhAgOS+G6eWJKaJXCNRpLaBmoIE9QCMucDoAC0tWEUaCj7dCcHu03O/5NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110197
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c34609 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=mzZxRmUfWSig62SmEuQA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfXyGBZr90obn+j
 Mlp/sqz9GcQNDFgRX/Nt0JtmEsyWXU4hyhZWQEc4Y+qtrisanyEG83wBjbYSKvcg5N8Rc5zMd0F
 xclZ0zm9FMLTAy/gjjT7mV5pYOr1mOQlynshP5GeC0yDOOVWlfRmyC/4Ogul1/aSjOqY8hPY/8u
 nf4rnBWUXAarCTyeBj5hmSkZ2iYN4xYwNT5kEyMwruHDk9s7Cy02egXFkUjVk1pUgI7WZZZSanL
 IncfgXAp2+TFDlklerEQzD1n65y8ZvFEOWxGwoqQSeD+gppvAYiuse3R8o/70SHGfr2ACpg+j93
 sl841eIDwgW6GeY9ucOWOqjHUdvqfjfbCegKjJ/DtoffWrm424Ii4ie9qZwOet++c63eoLnYXJI
 aiqBt22tB00r1swKO6lweqMWLBN4oQ==
X-Proofpoint-GUID: Lh0NusTMpgasmOzw_Jg8HeIHO5iwI1sh
X-Proofpoint-ORIG-GUID: Lh0NusTMpgasmOzw_Jg8HeIHO5iwI1sh


Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
>> > Switch out the conditional load inerfaces used by rqspinlock
>> > to smp_cond_read_acquire_timeout().
>> > This interface handles the timeout check explicitly and does any
>> > necessary amortization, so use check_timeout() directly.
>>
>> It's worth mentioning that the default smp_cond_load_acquire_timeout()
>> implementation (without hardware support) only spins 200 times instead
>> of 16K times in the rqspinlock code. That's probably fine but it would
>> be good to have confirmation from Kumar or Alexei.
>>
>
> This looks good, but I would still redefine the spin count from 200 to
> 16k for rqspinlock.c, especially because we need to keep
> RES_CHECK_TIMEOUT around which still uses 16k spins to amortize
> check_timeout.

By my count that amounts to ~100us per check_timeout() on x86
systems I've tested with cpu_relax(). Which seems quite reasonable.

16k also seems safer on CPUs where cpu_relax() is basically a NOP.

--
ankur

