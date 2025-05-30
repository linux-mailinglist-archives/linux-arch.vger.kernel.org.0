Return-Path: <linux-arch+bounces-12158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800FAC9399
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA5A4E81FA
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E73222E3F7;
	Fri, 30 May 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HBAHajtY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rwMP5oy3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730701D5CF2;
	Fri, 30 May 2025 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622637; cv=fail; b=SaqvnmJPcCxtPVSKRXvfCicLte3WIDQoIfqhMPDunZKEADvsh898qmNqCob0NQLidPRCdgG3oE71hmNeBCF2nwB9MmiNm1hQ/TyloIzgk+s0iZr5zLG/iqi6T6cNI/UKg0hI/wCrCrx9J+Sbg78jmPROit1PqIzQBW8SX3QzqaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622637; c=relaxed/simple;
	bh=UpJYQp2CxqdKcr8BAp1M5VkF7SN+YZkANZc13Fr3GOw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCe+X9W84HBzcSmmdcb5Dnzw36IRq3BU0mQ6bJsyq3GW56k05zsoEbLw/WWJV3kBY8v47qtmIauwZt3+wKbmRZQoq8YIwBneyzjhsiqThnmrPF1zeTnCXLRXSoEe8GdOxnzOt9o8ADjSrdfyGplIXvKXJfEJlCz6+W3dx1pT0qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HBAHajtY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rwMP5oy3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UGN9Hl013819;
	Fri, 30 May 2025 16:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3kQMRRYNu508FjE3n9bwEFQd9Y+f74RpRED7eJ4gzcc=; b=
	HBAHajtYDvRIX7ETqf6GSMy/iwo6noJwsgiqxvqgBrGvxDT3s1pm9p5zwPmWkxBE
	+vtZFirOn97MTDq6j/R716C2aAZY5YNrylwl5g3lquOAk2pUAO0/NoC/6AnhTQ7a
	K8rci6ciTiiYwemYZQ1wWgvIpAYCDkdC/DAzNQPDJm568jObCivpNtdvlsoadaBX
	SAygg2uqdWacmMrDK+GrnRTGNbZOpEzSyauAP384GvFcGTG7TJyskE+TWypSLi+J
	4i1RyDG7M8GhvCKYoXaceXkgKz3WwY1FR5A5fi5R9HD0R5Ql0eA+FltTuHmjPqwn
	eMngpOr58WCCeB03gz0VKA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2jprc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 16:30:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UEoqT3026679;
	Fri, 30 May 2025 16:30:01 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jdfm6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 16:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvQIxwm46ylnQVH0NXah/L/b+IxpT+Jul9wUcSJpmYy2lRThWPy6IlRNzdZDlpZ/V9zyHw6J2Dw0l9fQJe5lXnHJwp4SjE1smRfERdWjsmiL7aXORUhwf71vDZqHVwwKhmajbRljTE5NLdpbp/1ecxUT9C197E4M+x9T651cK/DQQ7EVuT15PZjw0D4BkIhx6NNcWX4SeauRZOy3DMxqMyqOKiL5nFpu+/L7aI+lFcVZMhK3VGxvb9uIqM+ZhK9c8US8LAO3iRVvbH+AWQhlFpjYy03BevejGLsM6KERY1NWmlNiWdOaMbgYwKzX375BwND3f1/lmcVJnmVzTpYS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kQMRRYNu508FjE3n9bwEFQd9Y+f74RpRED7eJ4gzcc=;
 b=bpiZP/CqkHMfofW1InkYnfWik/2inv8xrpLHlpShTdhznT8ZdDCMuNewuYe7xqg1nFRKWsl2QK7HuKhaqInXoKZL55TCBnnC4Y6AT0wrMjDGW9hTAFfjrP/JfoBjL38Hmzq2bcqhQVlHUVXNSjOyvhDOaCLyRtlh0elmXEYuStTMhJCoQ5Sq4OF37qvmy+8BEda1TYZG6m9iG1RJrwEXulxUitNK7c2HXoy6p1uTFuccYikfsFsoT6w4+AZLNsNAl/ClZTeyBkqej53yYEXaOPcaUFf0Q5Rkp24V6kLGo820yHQhBKlSq8VFCY08byyQ5uZUVN4cOkjShtp4aFT+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kQMRRYNu508FjE3n9bwEFQd9Y+f74RpRED7eJ4gzcc=;
 b=rwMP5oy3yakVevzF4b3a+TLWcOS3vcjk9zV5pEz1bU/r8zNg41K4tGFPM7tI92D1AnEf9MreWpAR6Zetkd4guUHBxNS+I+zmfix+k5U5ICb964LD0FfRDPqYf2pf/AlBMiZjigSG8+Zk6e+Rg1HKaUwXjKsUgu8fUY/WhqvR8rA=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by IA4PR10MB8471.namprd10.prod.outlook.com (2603:10b6:208:55e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Fri, 30 May
 2025 16:29:58 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 16:29:58 +0000
Message-ID: <bd7d2ebe-f9be-437f-8cd8-683c809326f1@oracle.com>
Date: Fri, 30 May 2025 09:29:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] mm/mshare: flush all TLBs when updating PTEs in
 an mshare range
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20250404021902.48863-1-anthony.yznaga@oracle.com>
 <20250404021902.48863-9-anthony.yznaga@oracle.com>
 <CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CAG48ez3cUZf+xOtP6UkkS2-CmOeo+3K5pvny0AFL_XBkHh5q_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::31) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|IA4PR10MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b1b980-de46-44d4-bc4d-08dd9f9737e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVRJTEpDUjVIcnF5S0tyc0k2dTJhUXRjTGV2TXhkVi9BMXN4WE5DTU4xMXZT?=
 =?utf-8?B?VnFNL0hOcWk0a2luS0h4Z0hDMmxzS1ZwVEorMXY1d2UxUmxwL1YvSVIwajZt?=
 =?utf-8?B?aWpVbm9SVDJBSml2VjIxWDhNd1Z3TkJaNThRMmprdERhR3JVaC9haEJwZFVz?=
 =?utf-8?B?UDNnNEFucGZGeWRhOHlWK00rNHJGWUNHL0UrRmVCYTJnSUxpWmFIOHVUd1R2?=
 =?utf-8?B?VkNqWGZLemtvOVN3ejU3SmhiQnl1b0w2WmpWNlVEV0UyejNNeHBYYUwwcUdT?=
 =?utf-8?B?NkU2THBpRnBGK096QWF5bXpMZzN0TURzbEVRU1Z5ai9JMDRCWitMUGxWdTVP?=
 =?utf-8?B?UzM5UUVYY3hpMkJiMis3b3NueE82ODhNN3FpUitranZkVGFQSjdoT3d3OVhq?=
 =?utf-8?B?R1lzcExuWEMycEhYUlk0K2V0L3UvQVVCSHNtQmpnbkRNaFBGK1pOd3RHV3hR?=
 =?utf-8?B?Y2pQbUV2MUg1TlA3U0s2TC9uVk43ZnM1M2xoa280d2NSblNPYmlHWWNUVUNo?=
 =?utf-8?B?VXJMZ3VkdmJmQ2VaZjJMMHZaY3I5dVcwOGJlUm96S2tBUVJsanFHQ3g5VXk0?=
 =?utf-8?B?M0QrQnh4bmZUZjJqeXVNNU1OYmhqWm1zRlE1U2lleXJMQ1NidXpkcnpTWmpS?=
 =?utf-8?B?TDBNUjBJc2tlMTNndzhFYUp3SWpKOEpWODVLZkhueUhtSUM2Tk9VM3ZRWW9T?=
 =?utf-8?B?NEswNEFDc3Q2a3VFUGFNNkcvd2pVWlVMdzVua0M0d2V6d0FEYnAwM1hBaXls?=
 =?utf-8?B?WUNzeG1mcWtKdzl1VlJlRjFGQmJCVDhSTTJPQ1pVNmdrYk5PWmJkQkg3VSt2?=
 =?utf-8?B?d3c1MW5GdXhnUVkrd09BZ0t4Z24rVy9KRjFQTmkxek0vVjd1RERwT3VSOUta?=
 =?utf-8?B?bDVnUDNGU1l2V01KbFB0K3plZ0FlbVFLaDhaOERPaG5saVdiRWkwdDh1a3Y0?=
 =?utf-8?B?RHFBVXFMMWMvSHd3TnhMYjRVQUlwQURyMzc2WkpnVUJEcGlrb0xsWEFTdGNV?=
 =?utf-8?B?R0M1Y0E2RzBVQW1EUE9WM3R4QWR0S1E5SWF1R3cvWEJqWUNYNmI1TmlnT3B5?=
 =?utf-8?B?UC9wWUFCU2xlN2h4cWh0SjBGd0NVME90MlRwZllOL0g3MzlVY0NHTE9UcEtq?=
 =?utf-8?B?TjZNa3R0TFZlTUZHVjd6djN4OWdpTmJvNzRQT1VEem5QaFo4QXBQNlJYZEdI?=
 =?utf-8?B?V0hPOVB0U25mdmhIWWxsbXpjMXZQRHJKdGljUVd2TGREK3pnbXZDZ3dxUytv?=
 =?utf-8?B?ejZKK2F2T2RoYXhaUDZuNUt2UXJSSFNJNzA0STh3U2VNSkErWHBxNTFyTE5j?=
 =?utf-8?B?WU5Qc29kVFJjaHI2a0FmN1JKMUxFMFVZUnlyUGlkWDh5RDJnY1lmTzIvNjRy?=
 =?utf-8?B?Z2V3YXEzZ2RPRnFzai85SXhqV042NFU5VDQwTzdiSE50d1cyMzltcVFFMUx5?=
 =?utf-8?B?RUZyWnkrSHUyUmh2ZWdrVDV3R09oZ3lmL1UvTjVucnBwcytDT0dQWnZTQktx?=
 =?utf-8?B?NHcyU29NUEFwVFNZeDFyL0d5TUVLZDB5Wjg4K3RERTE1VmJwTlk2REZ0TzlB?=
 =?utf-8?B?RWloR1J6UHAxMmU3QkZYNjFOUzVIY1l0NnAvY2kyQ2ZYTTZxZUpzRkg4SDFF?=
 =?utf-8?B?dVB4Y05QWUxwRGYyVnBnSlN3L2h2dDNrKzhLWnA1OERreHBLYmVWM29lYlAw?=
 =?utf-8?B?Q1dDRzdyNk0ybnp6b2JXZjNhdWJtTzVzN1lTTEYvbWJTYmZiSXpZczh3KzB2?=
 =?utf-8?B?MHFpR1EyUGNNNjQyRUg0OU5idG5pdCt4TFhwMkJ1ZmVBREpQeGJwdWdSQlRR?=
 =?utf-8?B?RkwzdTNXMkNjVVhrcU5uNEZyUXpkakNRaVZNbnVmV0pLTjIrZEtvVThIaTVu?=
 =?utf-8?B?S29NVkFDeXhjeUgvSUY1Y3BLOUpYclFFYmt6TTJxcFQyblNPV0tncDJmdTBI?=
 =?utf-8?Q?NhkAbCOpXUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjh4MExLSW5QTGFVK3M5VzhhMXFGcjF6dUhobDVXNDZqb2xEMHEzck5oVHBV?=
 =?utf-8?B?NVpScUZ1RTNpT0Z5ZHROZ2R0bXUxY0JldktEbjd6TEYxdWNPSGlEUS9XNFpB?=
 =?utf-8?B?L2d3QUdHNlJEaFZhblhXNllyd0N6RHNDNU1meVRYY1g1VkFyUFAwaE5BVUFi?=
 =?utf-8?B?ck9pL0V2cENCRmFJdXBmTGlEb2h1NzZiZldYb0JZYk51SnZjMmlrTUZsN1c3?=
 =?utf-8?B?aEQ2d05KOGdjZ3RqaWI2UGV5ODBTNVIwUkVFRFozYjZsakY3MGZNcmZTTWQ1?=
 =?utf-8?B?R1BpYVExTXVFenlhd1N4RWxHS2R0a1VWT2hqeGFrY2F4bm1yMHd1Q1RiRGhL?=
 =?utf-8?B?elpBYW1DU0pjOENtRG9zY0Z1NU1VcnVOd0poYzhQdjZYVE9NcjlYRWVkVGNN?=
 =?utf-8?B?c3lUaVJZbm9SSkFjaVg5dWg3UkxvNXJHaEtGbDVFU3drc1IydzNqamwwbjll?=
 =?utf-8?B?NWJ3UFVIZHJQQ0NETkdHKzlCb291T2U4REcyNUltV1VFVmZqNEJaR3VyYUJw?=
 =?utf-8?B?NmZvdG1BVWlOaHRKMFlCOFRUVFM2OENuYkFrYTlpVXUrNnJvdVhLNldhOHRC?=
 =?utf-8?B?dDVZaE8rNkVicUV2MDJyckZvSVRmYWtWTElLVEpRNUN1NTZzcXh2WnhGL1VI?=
 =?utf-8?B?WkdaNnI5YUpIaDQyK3MrMnFKNEdTVnVrOHV4WGdFdEdhU0QrNlZGM2xpNnJL?=
 =?utf-8?B?UUJQTVlDZ3h2Z3dkN28xTlZBd3ZVRHBlLzlhalJ2MWpLdnlKcEhzY0p2OEFz?=
 =?utf-8?B?VjRnMGdMcFJ1WXJLVEg1VllIV25FeWdIWlJOZ3ZDVkl6T1hzQ3MyL0haME9X?=
 =?utf-8?B?cG56WnJCY2Vidlk3VzB5cUpMQ3ZZdXdCZHVPeVQ3cmhrWnp5RXFZS1F4UzF2?=
 =?utf-8?B?Z3B1RTdQN0hUTnVTaGwzUWJsVXpGMHJUUXc1dWo1UmtEWG8xRjFKaURBemZr?=
 =?utf-8?B?eVRCRjVyQ25rM29LT2pBU25BQXpVQTZsN3FuZnZMM2hJSVhvdmluYjlTRFdm?=
 =?utf-8?B?b1cxb3dYVnloMjR0Q2tyQnd1U3BoOFB6bmM1US9IY3ZTV0tzNGNUWGczMFZG?=
 =?utf-8?B?U0pvUlNIZVkyTTYwcjJqOGNiRHVEdUh5eGczamlrZk1HeFJHKzhnWkQ2aVhD?=
 =?utf-8?B?UUhERlQ3bzVPbDZZYVM2MnB6QUlwMjJ0b01jcnlxQ1ZLeCs0eTU2RlhSQ1hn?=
 =?utf-8?B?aWZnV3h2dmdadnRPMk5vZXJwYkFkTUtsdmdUTFc0R2RFNDdRMnZtYlNFY3NE?=
 =?utf-8?B?blhEanhQMWxMWXFoY1Ryc285elpLcXdHWGJGaFloWGNJQ3ozbjZnRENOTkJo?=
 =?utf-8?B?d1ZMdkpQNDVMWmRUaGpNb092eTdjS09IVnJNeTJQanV1b1pZWkpWNHdHbitx?=
 =?utf-8?B?Z2VOQXNmTGc3TWdzUFBWcFFYUlhQU292THhQaDc1a3ZDQXdHUmIwVTd1L2pH?=
 =?utf-8?B?R3JpTm0xeHNhaEpPS1JPVjZkcWdQNXQ1QUhvWFJJTmo1WXR4Y0VCWS9RWjR4?=
 =?utf-8?B?SGcyQUluc1hBRTRtMGlKL3pQMGIzbEdkOVFndS9IeUlubVRKMEd1OGQ4OGpy?=
 =?utf-8?B?L0Y1VnBNTXR4aHlhRTlqUnhZZG9rMDFFTHBMY0tyRW95YXQzb3Q4S1g5WVph?=
 =?utf-8?B?RHNYYjJUdmM4UHBuR3pEbDdHNDhETlVzZkRGWk9zQmZidkNsWnBETGplYnBG?=
 =?utf-8?B?eGl0eTRHcm91eFpOQUY3akl6TDFGOTBCcisxaGh3S2xBOHhwekdVRUZEeHpw?=
 =?utf-8?B?ZHFpKzlLSXdTZG5IQ2VPdFF3VTlPTTNEMWFjdEg0U1VrS0xJdUh5MEJBUlN0?=
 =?utf-8?B?WW5NdXdEYWNlUVI5b0c4NDlBTlVYcHlnRmxVQTdjY2Y3UVlvbGZ0K3JQSE40?=
 =?utf-8?B?YlpGMk5vMkE2NU1Mc0xZVUFrTGZoY1pIaGorRFNWanBXb0MxWHc1d2l3RzNF?=
 =?utf-8?B?ZGU3a0tzQ1d6WFR2dlBsdTdzaWlWVUZ2Z09uSnVlVEJ5aVdzWCtMWUxOYWxW?=
 =?utf-8?B?T0pjQXk1cFBJRWttVTl4M0tBL1VZSXM3Mmt4ZUR5TlpSUkpYQUlaMTNLQ0Fp?=
 =?utf-8?B?ZlNFRktRbmtoaUpHYlp6RFg5aVhXOTFrTWVkbThoakIrOG1adytQMTkwd0E5?=
 =?utf-8?B?UGxBclZMRy9KcCtXbE1rdkxpV2o5M2xMZmE0c2JrUjZrMDNTaGIySElyQ0dK?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IXZoNUfhUGgH3lwJUcoAdVxX3veIVSFEiMQ27x+CgWay8mCSp8YaMjxahYH1TfvwPP11rTKcnNQ/s1EWxlVWPYlyAp+AknIKPR0oyWN08C/WYovsmSlm6Jxqo+gF5adInIcdScWRAY5/SKeGC1wIqv2+z8gykIaWyDTCaUWTJHNAonj1DiZpoplvuwokahgPH04dolW/+VivDAbQ/0DVmnUTzCQFlWxxDWcMxjYPCE9my5OsoYX71H+M+Cq1HQn4AbRWROzGr/HWeZw3T/AXg+CEtAEbFFde0nsg+M/GBv6lrIxhBFtYH9S8IdGGZPYDWMFMCWLK65fa/HW9mHK1yKRhyLnbCHjhF+xq9FSKVupNMhYNsCf2IU6IxlpEcbIAp4TgAEGiREbEIM57NWXj5q20zT3b0VyFzJeO7iCeGdLeNkE/hN7MKFsicHP4cJkzYesrkxq28F7/+xCI77QWpbaOU8Tx76wlZOjbhwyfSYtv1qrP54HXf7AqvSwPxMCiNjQwH0hQsKzDR66UmJLeHxF+J16WCx3nKxC2C4/aQqhoZ9Kj1nPi8mL+JYMGRb2Q7I3o1c/IYXoKJLxYI+Ydqo73yJ4VwjcXDDa/GZC05Ng=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b1b980-de46-44d4-bc4d-08dd9f9737e8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 16:29:58.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Db/1lFTq0ztDIHrqBQuagGcjggcI0BwpJ7B8eqcotJIvmvutoRVNf5uZh1Vzg0U8Qtmgcg0O8jz0a7pb/8flC36IyWjYB2PFiQsKLu/gD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_07,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE0NiBTYWx0ZWRfX63XHTzQJcYG3 i+wd61t6bWJQtYKqZ+08jckyLIkoPjeU2vLpxlPFkO7WcXkOPcTKz1qoX5oAz+rB/8FHPUIAycD wSkha9jkjZOQQ90aWyIn6UPgr3aS6eIwlyjdoWa5E5MhYA+1gp+liGmK+Gd6Y17GRPnrYUNvUsT
 fdjP1bzfnWe7J36PTw6/SDNEAN3MRrhvNfeEwBHKrcLOttJNnEGr1XlNu+VVmMs0rMLJjBylP2i rtHBpQqrLL7vWzir+IGck1mLDLmIZt2pZnWwgvHsQVS92cgpHazSJAcbwyItlBvffMEqV1bguRL cssJCO/ynAjqWU24uCmpHMp08Pb0YEGOUGZl0HOIoDgz5A2GfYfhAC4CFxK7McNpVF3Pk4juBUF
 SBDrxIXWIfVpGLZctZ21WPiC08ngnxY02oW++tJGMSoxfCHa1rKhuc+H4fRzvBznxjIPPrRE
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=6839dd0a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=P15QGO--FDVWL9koMvsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ikdMBI4P8s1njLAyGPtcf5QU4nom6V-c
X-Proofpoint-GUID: ikdMBI4P8s1njLAyGPtcf5QU4nom6V-c



On 5/30/25 7:41 AM, Jann Horn wrote:
> On Fri, Apr 4, 2025 at 4:18 AM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> Unlike the mm of a task, an mshare host mm is not updated on context
>> switch. In particular this means that mm_cpumask is never updated
>> which results in TLB flushes for updates to mshare PTEs only being
>> done on the local CPU. To ensure entries are flushed for non-local
>> TLBs, set up an mmu notifier on the mshare mm and use the
>> .arch_invalidate_secondary_tlbs callback to flush all TLBs.
>> arch_invalidate_secondary_tlbs guarantees that TLB entries will be
>> flushed before pages are freed when unmapping pages in an mshare region.
> 
> Thanks for working on this, I think this is a really nice feature.
> 
> An issue that I think this series doesn't address is:
> There could be mmu_notifiers (for things like KVM or SVA IOMMU) that
> want to be notified on changes to an mshare VMA; if those are not
> invoked, we could get UAF of page contents. So either we propagate MMU
> notifier invocations in the host mm into the mshare regions that use
> it, or we'd have to somehow prevent a process from using MMU notifiers
> and mshare at the same time.

Thanks, Jann. I've noted this as an issue. Ultimately I think the 
notifiers calls will need to be propagated. It's going to be tricky, but 
I have some ideas.

