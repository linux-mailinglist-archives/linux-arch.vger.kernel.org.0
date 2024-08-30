Return-Path: <linux-arch+bounces-6856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9AE966533
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18CE284642
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63351B3B37;
	Fri, 30 Aug 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kZxXuQwK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNzsdEb4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF718E047;
	Fri, 30 Aug 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031248; cv=fail; b=V4blRcQFVUUBpnxD7aQqNFXlluyoZX4P0qfOJZOxe5M9KJoexpTQOcCnpKj/l4oO61QoB9QrN1yPjuOPA546EIVd5deabRfHLUR1fvgd+RMyEkd8fsgcz0UaO5J+oe5n5rcObuTfg4/nQYJIQXrUYa7ZlKWaP0habr9DkDOu09w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031248; c=relaxed/simple;
	bh=nTGpeu2uKxw3B4a9HVXG/Q2aGe+TUPa6J0T2Ku/87TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SpRRdVlDH6d6lBBfPTLLCTy6u7xpFWG/8ferb7MPfFmik5qTZP7/b+EBzS6GFhUnt0FAO+sJF9Jf5+lOPEVMdYw4POeYEe81cojFbJ94WfBmMEwXtK/In6CfWRQI03PE/mA8xoz08+k0f0pLbf0gSxmFrXyES2Zl7rMb3AdyJGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kZxXuQwK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNzsdEb4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE8bSn015073;
	Fri, 30 Aug 2024 15:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=2oYsqApN6OojPmQD4SjrDRuFvV8n9GjNmjhrBHMk21M=; b=
	kZxXuQwKjG9E5Udqp2KJqQBtCEOR0RE/O0mnIp+8DU58qK7HY82sB0EIIW74UBKD
	fI8hSA+XQzKUQZZQEdhKHMjf24pcJYY7/MH+8DyWXSN+YsNY+R6C3cZJyOl991Hv
	kL7q+vJ0/gv08Q9YB8cZZVvNi3RVeipV0J/6j+b5BlbMV9UqLSRmm0VThHKv547f
	+XWkLVtIUc+c9VoRHMGO6hWP7g6/eDeUpNIUNU+/LwDOAMpT7C+6rgxhErIxeZqA
	ALVqTbMFXi7dVMvFzimttA29hIE/+U4vZZkJrTapSbqZjH6sKE+hsUNs+E3dTiD4
	NiYDYHNZC47p6DErtQjKTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfjvg5ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:18:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UFHrZK034931;
	Fri, 30 Aug 2024 15:18:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxhcuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 15:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4grz8AY/pJguCCkSnD66Fjq7YGpHYeOKkMAJXziAwZVKnk3aKDZJS8s4p9iiqZRL+qlZb6o8TH2+QHlriHgML53e/EYUC6YNX8MnMnVpljK72nCqMcQ9UWgDRDEOgiW7PmWvcQ2MKcGwdkuxtAre+qAnMuFLfgkMSR9Sj5Sno6WrS2eJKBQQ4sWCc9Qeh3GO4UkDbRTFjrkNKdKzTB3AooK+7NzAI3k3NteCB2N4R6tVLu8T7RccxUfZLsgvODk6CSkTvF7wFK/MCtrcIW+OzEyx65nWjgKEq7+p8A+V7+Mms2w7w5Y2Xe2jzYr+7ketM9FfBXV41BbMz/dFLSX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oYsqApN6OojPmQD4SjrDRuFvV8n9GjNmjhrBHMk21M=;
 b=RE1oFO/dOVreLYwqQQQmjlo9v07Dq0c0Mleh692L3IZ2cjtDn4+vAJSab6M4tUchfFC7xNMDl88YHOPgFaQ1Sbiu0ZX8wcY8sRCX33KpjBHCaI9pzrsd8XSIK55D4OmAqF/bwiO64dAInafB+T7Vg+KvLWHyq5VlzwXYazOKOfggg2F2fpm8U2TeFMqrlpVO8keqJk/w9fMbrpDAzSOon+8p79RRlcDJ9FydwhET41NUm5wXB4wK9Mav8tsQm6sHThkGnT6gbX2ITN4sQEryaAn39OfrhmwmKvObJNQIXFRJeFbOoDbt7jEFjJHbZXijmjtyG/SLz5q4l4lXWB2+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oYsqApN6OojPmQD4SjrDRuFvV8n9GjNmjhrBHMk21M=;
 b=tNzsdEb45zdVIg4aBPaB+Fk6LqJwZGo6er0Dg16uIL1IAmhgDR33tsS4Ri6hZVN91HWbt0U72tNU569vad5GMS84YM7veATOSgwdndKIlihd+gdj67FKimqd5XPmd6/C9LlIJKPm7J2SHz2pquku0jENDkw4zGFChc4Ui+QT9d4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7702.namprd10.prod.outlook.com (2603:10b6:610:1a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 15:18:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 15:18:42 +0000
Date: Fri, 30 Aug 2024 16:18:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Message-ID: <e48d41f5-646c-413e-99e5-c935b5235576@lucifer.local>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <ab90ff3b-67dc-4195-89a7-54e394da1aa0@lucifer.local>
 <a922737b-be1a-4ae9-b2d8-fefc44bb6419@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a922737b-be1a-4ae9-b2d8-fefc44bb6419@intel.com>
X-ClientProxiedBy: LO4P123CA0561.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: aea331e8-b64b-4068-4f00-08dcc907089a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2Y0Q0N5U0x5d25jeWcvTGoyWHpETHA4Tk9HdWovbVE5bjZmVzhkSHdscEhO?=
 =?utf-8?B?Zis1cDI1OWpHWXhpTytZZk53bkNzOFhDU1dtUUs4R3ZBcEk5YnMvbXZzWDlT?=
 =?utf-8?B?bHBLcmYwVGUyL3JrTW4yaWI3WjVDSWFEOU14eFR2NERndjNKQUhVVE9KUkl5?=
 =?utf-8?B?c2xZOGJtNHlBWGRTZEZNdytQU0VFNmdKdTlqVDdRbEY4ZVcxSERxVlR0bDJw?=
 =?utf-8?B?Mk5sWS9VRXE0a2JNWExkNXdmV2NMUnFMb3ExZWVCdDYyeUowczdpZ3dWYjlU?=
 =?utf-8?B?VnJKaUZzd3RZNHdNR1EwclhhTjE3K3pwOENnR0Eybms4WkFWWVd2YjcyL2cx?=
 =?utf-8?B?OTBpQTNwdmJZbVVVNGVraU9vdGp4T2FTRDQ3VHhDUjJaYUswQ29iM0x3U2ww?=
 =?utf-8?B?N2w4QTJhV1QxR0F3NGNLSWJDY3dIdnNXTm5SKzlnQ1lhRWF4RDQyZWJ2Mlkw?=
 =?utf-8?B?TW91SEJCWlRHanM2RUZSZGJPbFd6Z1BReTdxcG9YcGJmMUtDTko5ZklUSGFr?=
 =?utf-8?B?dkh3U2p6a3lBd2I3bkhyc0ZvQ1E2SVUvNzZNMG9Ld0UycmozeUkrN1czM09z?=
 =?utf-8?B?R3ltNGE0Yi92NDcwcWZnOTZYR1BvMGpVOUZlOHRUVGk5L1Z5bGVmSjdIMytF?=
 =?utf-8?B?ajJBenVFaVhidTVPVEgvNVhwdkZGZHNRVTNNZW12ZWxFWW8zTlRZWEVvUXFG?=
 =?utf-8?B?bSt0SFUyVjVqZGJLZkVmK01iWHhNRnhrQ0lranNmY0NYMDR4MEI3VnZ2RStx?=
 =?utf-8?B?VDFWbGhoTmtmM21IVHJicjVnM1JyN3RnSk9YMjg5dFVnNUQ5NWxpRzE5Z28v?=
 =?utf-8?B?RUN1V2pLSnJEbHJTU0VUSCtKMFlqWFNmOHg4Q0NTdUtyTVBLSll2NlVVVDFm?=
 =?utf-8?B?RkVTWVFjMVB6UjR2Y2Z0YU5qUnlmYjV2bk40Z1FqZFhUQ1pNZ01LZHVjTld3?=
 =?utf-8?B?VU9sZnBxdVpzWUdEeFJqaThHaUhVK1BlSU1kVlJVL1pmeUJyTm5xUnRxUFkv?=
 =?utf-8?B?ZUg4bjJXV2xTTUEzc3I4RWlDWTZnNmJFVVVPeXpQTzVxcTM5RGVVcnlZSzEw?=
 =?utf-8?B?R1JNV29qQSt0eGtPTU4xdC9ZaE5xRGxKTUpHL096ejNGV2R4RG90TFJ4cVRk?=
 =?utf-8?B?OEwzUEg3cTd1aTlXNVJsNzRQWFUrdXhIVjhueFFEVXFLNWdQdG11MEVtNE1H?=
 =?utf-8?B?ZHVGZEoxQUdiZHZZK0Q1cXYweDNtcDlaTXdyUGJnQ1BzUi9HSWFIdWhacU9m?=
 =?utf-8?B?c2FGd2Y0bXowWURHZkhOaWprRXc4K0ppQ2xNSXFSWGFadEM4dVFpZS9ocXBl?=
 =?utf-8?B?MGtyUmlhNDNCUFlCM25zNXJRZ1hCV0ZoSG5GRXZIUzN4VytDL290RnNhZ2tB?=
 =?utf-8?B?UHIrV3RCT3lCTXQrRTdjSXdFNmcrK09NMjVYMzcvVnZKaGNuKzh5dkpYdmZM?=
 =?utf-8?B?MVlhYjJybU1FZjZlVmY3UGVjaEVYdGdFUUFpR2NLeXMzSkxidTR5dnFKamFB?=
 =?utf-8?B?TUlPUnN5cElab2l0dWFPQmVvVFVZbmViOTQyVDgxNkxQNjZnYTEvejlSNlVs?=
 =?utf-8?B?VVpmOG5zK0hjSGxBNmhhbUxyb0JMem91dC9hTHhBUloxOXNIUHZMQWRxQlFw?=
 =?utf-8?B?SEtDanVHend2UVk0YW9sVk9Kd0dzRkI3WmdmZmlieDZxVFQ3eEpkTFBmTkNV?=
 =?utf-8?B?bWpQYmdWSDBCKzJZNHhvQUJDd1hYcjQxT1RjY1ZCczdOSHQ2NUZoemNrd0hv?=
 =?utf-8?B?amUwdmV1Q2E5QWN0NXlScm1ObHFDckU2OFZnR2d0TXFJM2Fod0E2RVZPbmpt?=
 =?utf-8?B?MEs4c2tLUG1UcmVxaStjQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dyt0aWp3bU5JTTl0dEowb1F6STlhaHhXeEUzckhqblFROEJ5cXk4aU53RmtC?=
 =?utf-8?B?anAzcFpxaDVqMFdQSjIySG5rREZyZlU0S3FGOGVDYkl5L1ZCKzZyaDlZenBj?=
 =?utf-8?B?R1FNQVBTQ216TytwVCtsb3ZrWVY4ZllsQ1M4N1RoejBWcDk1eTZqNDhuTEN4?=
 =?utf-8?B?VWlaVFJSSmd5K25DRC9oY2dBK0Y2akVQTFJKdUtaeHgrd2U0OWM1MkxDN1VC?=
 =?utf-8?B?eXk3b2dxcUg3d1pTSjU4bktUZUN1THhMc2ZYVmx0ZXVBeU91TFdNbjg3ZEp6?=
 =?utf-8?B?emhZeTlyZWg4UXRobGs5ZXZqUUlzQ2tOR3dFYWY4Z2VVWjNMVHFpck9uS0dG?=
 =?utf-8?B?ZWxxTUcvNmZJTldNaS9sZE5SSzdxL2ZHZDNYelFydTZtK3FqRG92MTZsNG1T?=
 =?utf-8?B?RXZDUzhxWUdvL0ZiZ1V6ejJmeGpueWpxQnF0b1lHM3oxYnVqT3BWY3JLWHJM?=
 =?utf-8?B?RFBUcEVZVXYxYVFkb0h2ZndyeCtZWllDTmxUdGF1N2NVSkk1SGp0UkNkam11?=
 =?utf-8?B?ZVNxejFoVWliM1RCVEg4NkZLVzEyWmtSRjd5aW1KcE9wREFqUi9NNTlHSSsr?=
 =?utf-8?B?eXUwcnhBS1ZCaU1KMGRucjdOUExPb3Q5UnYxZHJScVFTRlhxK2NkWTluT0sr?=
 =?utf-8?B?VXdTci9Bb3FzMHlZQlBVREZuSDlVVDJUTXpYUWtoQ2FMV1NDZFd2ekxOYWxy?=
 =?utf-8?B?bi85OElVemRLSExhZ1BjSnQ4RG80aG9ra3pHRnV3elZuNWJDYXVBQ05wWkpT?=
 =?utf-8?B?VkNhSFVUa0gwaHpyZlo1UjdRWHdRN1ZKSzZ0c3pmelNCWlgvVFlQZ3Z5THUr?=
 =?utf-8?B?TzFHdm1aYkpuZFBhQXh4L0tUdWJxZ1RmRFQzSWhSSk1SaHJ1aVdtRkFMM1k2?=
 =?utf-8?B?alBXLytCUWJSN0hpZWJTdURoNVZtS052Q3VJUTY3bUJrbG9EY1VXRmIvK1NT?=
 =?utf-8?B?eVRSbDIyWWQrZlF2cmRDTWpUZGRUZWRYWjdtR1BMTFR1MlEzZTl0Ry9WRUdl?=
 =?utf-8?B?R1l3aWR0a0dUU3hwOGg1bHVwOFM1c3RHdnpVWWJOQmw0Y3g4KzVwek44bUMy?=
 =?utf-8?B?WGd0ZVdsQWtPQjlZZHhMVW9ja1hMNWFSSkhiZTg2T2FxQ0F6RkxpYWh6Nk9J?=
 =?utf-8?B?OEs4UW1lUXJSTlFDUHhwSHJ3TjFoUCtZWXZXOW9BZlF1VUphMmxNUzN6Lzhk?=
 =?utf-8?B?Y0xGRmFjdFpYc0k2SU5KTGVCcUREZDZxMnNZSjYva0xNbmprT1M5dW5LZHY0?=
 =?utf-8?B?QmFQMkdETS9tYTVJaVBWaEttOUROZml0RS9xaUd0MnJzVTc3Sm1ld2x0b2lS?=
 =?utf-8?B?dnFhYXk5UHZSeXRsTFZDRy9xKzNEbHlybDdQRm1ubG15aVdXS0szQkh5UlRP?=
 =?utf-8?B?TW9VWno4eVd0Y2k5YzBPamJWNWlhYmQwQm8wcS8vdnRPL29BdjVBYk5Wbzhs?=
 =?utf-8?B?QUtaaldPMm91L0N6TDdDM2tlM2wzdTN2Y3RQUGd2cGdmQktqSTdWN0oyS0ZG?=
 =?utf-8?B?bG5XcFVxa0doU2FQelFmQnZ4QUdZN0tVSS9KVXpQeHl2S3IraE5LdU5NaEVD?=
 =?utf-8?B?RWpiSDg4T29tUk1HcUVNT0J1WHBmVFNUWk1TVG91L050OHJuY0h1K3hwOUp5?=
 =?utf-8?B?amVieDJmbGpCQnlkcndNQVBsSFkxZHNYRlFIM0U5L05GakVaMjBtMmYyaGZh?=
 =?utf-8?B?eTR4U2NXeU5QNVc5NXFIZzh1eitSRHdGK05qQjZ1clNIeExvTlZ0UEl3OEJv?=
 =?utf-8?B?U2pwMEpjSVU0d0t4RlVESGk3NEJhc0hWdzJZSGZxY1l1V0xyOU9YWkliN3pv?=
 =?utf-8?B?RzRkU0VhZDlzQThFM2NXVGVxSEhnNFZuSHdzWGRnUEhvQ2lLaXZ5Q3JRUW45?=
 =?utf-8?B?emQzeXhkaTRtYzFoZUZDdmp3bGZ6eGRseXVCTTlpeVFzQzk5VzQ5Ymt6Y3hs?=
 =?utf-8?B?cEFjVWM0dzB3V1FPNklZazZlZndrRU5zdytZWjNsb3VKbVFnNnFtd3ZVQW5L?=
 =?utf-8?B?cXgvRzB5SWYwMHMrOU43UjNTL3psenArbE1sL1REZUtPYTU0c1o4K0Rpc2hJ?=
 =?utf-8?B?bkZiN1BaaElRZTVETTBEaC9ZZDlsZWFZMlMxVzNCRFBlSTRORllob2NteUJO?=
 =?utf-8?B?THI5NGtyTXJFYlVJWW1MRTVGTFhDS2YyOWt1N0kvcVk4SkNSaDB4d3E3UUJO?=
 =?utf-8?B?Nm9nblUvOXprdGZVWXo4YUZjaGkrTE00SEZKWHdwMERmeUprQ3VqRUNiVFpw?=
 =?utf-8?B?NytJaHg1NDQrSDBudFExUVJkRVpnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y6WQbYACCiNhBv6nP9iFFZeL0s+pvuC9UFcuGMyu8Jze6GGA3ZR0JybiRF3zJNvueSNH5XXcbK/ZeBD/O/k6YHnf7S1VTkc8wXrtMeiQ+horM3yDQ5LdcPB/FHiUPo/+I//Lz9yn2xklb7KmVekoEPTUbiN8SLiMWLbMZ3S+iC88PfLJWJunWRMatD/Z/VOIDNOVBXMtcjd2AFTPm3La5s7Ct8ohpftqdQKXOTb94lPKUmlJpFN2O/eWznmfI8B9tzrhrnqkzhb5cAVR8pFkt54xuDnpqhn+zOW6SrRr/kt1GUOdHhQAi2adRj9f78PGns/96qEfMRpkUWlntN1zgDJU1iBdbQD3hGcsdxIKur2si0RJVGW4C58jeUiFDgMXwncrZfxW2LDMECqze9ZqZvVXHK/62n1QZFBn7IAgWixvIp5Zb0oGGKsIN2qmJVOy524tSFIXQIKQhxE4X5a/cgm9T5w1E+okgywZDlY8jQiR8U08L0QEhLnDbPB/N8iwYDi6KIAmGmzGhs0hSiiqbYSKGl7l4ZTix7L5ZTRbjdMDQg/016vbfWfGndo2SvDXfD4YUZ10OOOpPcVmBZ6dPWOPAF/EXP3ITFyJDsQF7QI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea331e8-b64b-4068-4f00-08dcc907089a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:18:42.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTnP3dj5SXyHLmRJvTmatvsLx7ugROyc7HPw+OaX27QQGzvGIZINpIbC5sCah5EDH7e5BLcoJg3wciKbMkhJgMCnsPto9f/qi8HMC75ytI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=493 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300117
X-Proofpoint-GUID: M1zGCvooakmHy6p0DKqZFQurvvMvxXW0
X-Proofpoint-ORIG-GUID: M1zGCvooakmHy6p0DKqZFQurvvMvxXW0

On Fri, Aug 30, 2024 at 08:03:25AM GMT, Dave Hansen wrote:
> On 8/29/24 01:42, Lorenzo Stoakes wrote:
> >> These applications work on x86 because x86 does an implicit 47-bit
> >> restriction of mmap() address that contain a hint address that is less
> >> than 48 bits.
> > You mean x86 _has_ to limit to physically available bits in a canonical
> > format 🙂 this will not be the case for 5-page table levels though...
>
> By "physically available bits" are you referring to the bits that can be
> used as a part of the virtual address?  "Physically" may not have been
> the best choice of words. ;)
>
> There's a canonical hole in 4-level paging and 5-level paging on x86.
> The 5-level canonical hole is just smaller.

Yeah sorry this is what I meant!

>
> Also, I should probably say that the >47-bit mmap() access hint was more
> of a crutch than something that we wanted to make ABI forever.  We knew
> that high addresses might break some apps and we hoped that the list of
> things it would break would go down over time so that we could
> eventually just let mmap() access the whole address space by default.
>
> That optimism may have been misplaced.

Interesting, thanks. This speaks again I think to it being unwise to rely
on these things.

I do think the only workable form of this series is a fixed
personality-based mapping limit.

