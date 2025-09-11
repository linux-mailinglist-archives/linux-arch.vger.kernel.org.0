Return-Path: <linux-arch+bounces-13487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A2BB52761
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23B407B11E6
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2C1A9F97;
	Thu, 11 Sep 2025 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DkzVzUGH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K7kydrJV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8C329F20;
	Thu, 11 Sep 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562449; cv=fail; b=paytSW15Jx92AKhfsO5dZHtYzCcREGaclSu1FDkrkBk4x4jjRLxoIPYOQ0PO+6vOedC5WdCeigaNn9BVA+u+LnSPEphL72r9QFdOoAuSawWZLeM4asT0/004WVRhx8yGCOnCGenHp6Zlt3MwrKnlFVMf0Yyp4W9nukNsvyNzzsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562449; c=relaxed/simple;
	bh=E5zYSEeJd3dzM3Cp82XkX4iTREG0FFgoPigcMM1CAwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2o1M4026DhGf8uHWw6SCBK+nVjVxlibJEzbygnXvtDwaFjaiptm6FZoF7TydDKUHqwccf8xdXWEPgP5ChB1b3YcBUenli1IGery9rpQwVtaQnk3sQI4k7JWa+5uwilqGmAuVb8CPoFZERbO4vGOybxN1W9GsJugKcezKq/Hhm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DkzVzUGH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K7kydrJV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALfn7f006484;
	Thu, 11 Sep 2025 03:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z9EkjF6dh1R5TgDaTtuQSp6vxyltMn5FhlpIebRumMA=; b=
	DkzVzUGHFenaSLim64KRhYiQwScAzVuiQ5t7UjYNGmxEWRgp65cKtZPubir331y2
	ez5BloZpT6bSHOCxilse/Jc6ovIkV80R/fREhkkunYWOyyz91sIOh7hQDlTnHGfv
	Dn3OynJ8nR5h1cwUeGS1Fhihqd1Q6snX5Xqs1ASEi+PnC1T8tTXSnBb4QokVFW0G
	lVODKV8kaeNsDhwSegugYKbO5S5F5dk7rNC2w1BuXUDUVhkt+0uUz7K2k0sv9ab1
	3wYNUCeYIXfj6xavuza8KXoCnrH6ltApVT47JVqsnJm6GsKwD80PM/cyr7NPCUup
	vOuafbxab67Cf4q6q34A/Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1njj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B3VGoT032834;
	Thu, 11 Sep 2025 03:47:02 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcudu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uonwRm+EpvIk4Cv1oRFc89mpcbFQOLRptX1UlYEtx8ShQToJmzNx3c4KExhcWI4kOkdKqw6rn8+TtJLyMtb7Ptn8x9xe0hjFOi1Bwhk63BczlZy6PMtdiKH3qjh/j29NRISMhNBKv4u7UX1xyHRmSTWOnrFQH7N3/e9ukhIIHkCTNKF+PJUKjFmVEd98ricKQJK04PMISAhFMPLqzDKRWYQB2UFkZFcrZwnzyb7fjGjO8zhOR8evVpaDWrd4dSuoOObiBIVxwT+m3vdtQgSN5k7vSTV14O227FeZiICvwvjGvz+Tn4Dwv6mNnwYhhbiEFNZ7mEK/m55JLQxJ9dK9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9EkjF6dh1R5TgDaTtuQSp6vxyltMn5FhlpIebRumMA=;
 b=BawstDHzgksiO3Y8Z4gHZbvklRmUJm2IM5fE6jL8GzRcslhH4qEkU7usR+I6CL91R1jo4ifvq4ZyXJacfkLfinGw3vaGCXyU575LLm7oZsA1dVdETzqOeIkNGEbxgOzi4lT9VrcHjip+ReYbj3po8FEs+w+C9qpFaQqCMzFa1PfOAtulOyYyVRvk+F4pgjjF2Tc00z7/kk9u82a1mTA3F9TwL4ki/8GIu4A4FCoAAakGvjW2qYIzi9qO+2KU0nr88ZbUR/60OnlpRIMfJkeUvgu7FzZW5+wVbrzFZuFBxQcv3AIuqyIslKd3ohdhvVMdsdPdh7AQxDVimagCTslvfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9EkjF6dh1R5TgDaTtuQSp6vxyltMn5FhlpIebRumMA=;
 b=K7kydrJVxhfwn/PVsUnCLWdAWZz7V3XHwvuuOKR7wJH5LD6dRiJCJMSqxbO/LjzoysBJ3+ZH0tFkdL1rzjgKGu63t02ARC4a49cD7jEKhbWlPSMPnCP8WuricgDvx/fcSdn6JBBRKpcxai0HaauROc845nQWbTop6LNZgab+bUQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:47:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:46:59 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 2/5] arm64: barrier: Add smp_cond_load_relaxed_timeout()
Date: Wed, 10 Sep 2025 20:46:52 -0700
Message-Id: <20250911034655.3916002-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0294.namprd04.prod.outlook.com
 (2603:10b6:303:89::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e9794c-66f4-43b2-7f72-08ddf0e5dca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fZ/ZIjjaAao0G1Itv5ptU5HH9Rh5zgVuOL6gLiVAYBTtlCAwwWI1HDmSrFnb?=
 =?us-ascii?Q?cCwwV1RsvVNaxs3AIA3bSVPzceA22+APm/M0aPY9Yz+5f6JOt1N7DQTk5m9P?=
 =?us-ascii?Q?s90w/efoq3gxXCGup2Ab/OTRk36JE51ZkUJVRcjhDH3sEwq2UVL8eT/y6Z+M?=
 =?us-ascii?Q?YWD4JC+ZJil1YuFxOjV3lBcSz/zOUEKOW50S7+lOekTh2/dfNYegYz1PuExs?=
 =?us-ascii?Q?8NkMHbvU8NDSgFiika/s8lwH9Zl/50vRYxfzlCipl23M8E0aXzhOW9kJgLNv?=
 =?us-ascii?Q?JaIjVrOJkzqOY6vt5PohLDTLMoifqP/rvrnLDIAWrGk7lXtikd5UxurIA+pI?=
 =?us-ascii?Q?JSVPW9eu5hyo9mBPulUtgFVWf+Jl09W5mS3CsFxSDfxjsDJrgo9nbQovTBD+?=
 =?us-ascii?Q?Q8HBWz8QhZ/WCwaz2jrVRfPPNi+QEnZk27l6yrQFdOjE9lgfqBuRU3IxGuWX?=
 =?us-ascii?Q?EfSHDh3jPg+v6oP1+yzjs12OxqaX6WQsmValsbUbQM+D+14mRN12G8UDqTko?=
 =?us-ascii?Q?Siz/8uM0kG0qDOLTC3GNtcv/xGvElHhD/qAQ0Z2u28dF4l0LzEq8EdQT9NSW?=
 =?us-ascii?Q?OfVKl771yH2pjpyPFHOPhFxB2BcMK7SYWRxbg6eSdenBlYTwG5Q31+UdOEsa?=
 =?us-ascii?Q?7KMb53xbbb/9Z63k7ysuuARiyzK20dXGS5GBjeWqNYQY3o4DeZyEKo4y9GPD?=
 =?us-ascii?Q?mtz36P4iUcgg0x+vlyzxNdmHD9+vPHF5BsXZsGjYNFM48FkEjE8W+ziDshW9?=
 =?us-ascii?Q?RbxCDSk7xMO6ziV0wnjhHy3Ctt7dKTNwsZiDAQeLw96chde0Ju3mUvukceq4?=
 =?us-ascii?Q?o0QcCd7c9VskRWOTb6hCEAL6YAD/d310V8S6+Ww2CLd8lx8u5EHM8dYiMIJt?=
 =?us-ascii?Q?B0vGUr+1pD6B6itg11u3I9pzbdv5egr9E9xL89GHihz1AxqnV0OqWfANZX0E?=
 =?us-ascii?Q?saF90sXtKC9DM+O2psS0IqlS3aVynU+6H4x8WUanB741p71N6uAtFMhN7+xU?=
 =?us-ascii?Q?op4ae+iXXspXQ6xRYhP6kjvkzx4TuwLE3KtfLIOeXOC60Oo/eJ4FmbnjBv62?=
 =?us-ascii?Q?0G66ULyLheOXa+McUXa+AE97yO9ZGM45NCu1BZy9jVOFYYfPPRliMujKJfYD?=
 =?us-ascii?Q?0eY5U1xEM+cyJhLFvM9VvRemG8hKZOxjIQ7q4MAOnk4iXhgaUvbIzWdlTGZA?=
 =?us-ascii?Q?X80MIkklzIhbfcjdTfDNhwzyZGanh01IPsivyBk1TRPug/8j6Fdt0Y/IAxE/?=
 =?us-ascii?Q?VmNmhfMPeSfcs9NpOshUBTQ+XCzu04ORhJgsFMtG3swvM3yv6Iyz4hzZWTrk?=
 =?us-ascii?Q?xQawDtw0E+pr6Iy5bM9RdzZmyU5T+HmBR0JaMQZK/NCV7pxMwjMKhS3csJhb?=
 =?us-ascii?Q?Y2bx69mlONhGG3sxLcfp5WSLMHWVpuVIeRZUQPU9+kUD+DOZ45yEZm9/mXV5?=
 =?us-ascii?Q?BWreweiEqHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qr+lMWj4hco0Pxieaj4xOoo7NSq4tFRQPoIM2AAOXYMLexJmRNiyWW1CpyhI?=
 =?us-ascii?Q?9a/Qzn3xqm+iAHY3MW0LlAvjL98JAqHQEtCOHgLadVaiSNKvlqoAetk/lSPi?=
 =?us-ascii?Q?VmF0iakpQT9WF+9kuk+kEaXr69vO9xfBtrzgCYGHkwH7RRcoplhMZ275h0KF?=
 =?us-ascii?Q?SaUjLudkqpyUZW6SpFtCafx6j7f89Uxb1TCPHq/xo0QtAT2srClr+WBAJgWX?=
 =?us-ascii?Q?OGu4Bw5hlT3MzO7sMgF8B7/wJfk49sGbpjC2qYTOCueljY/j2WphpsfAMvX3?=
 =?us-ascii?Q?5IJ+j8QJkGPWUDQMjhMlAXRIgPuSfeV2JxedZxedeAyyLbYuLldAdUOhyex3?=
 =?us-ascii?Q?48JG7mVTPG9+pffzEtgWvvKoWYZYVhs4lud0jUnq1vuUtV+zi734CKC9JXjk?=
 =?us-ascii?Q?b0QUiQO9Ui/t24hXgwM43nSakT9voirZRA1wXEz9Bs7ebq2wNJFM5th9edPi?=
 =?us-ascii?Q?q/TNddQI91x5M8W+LHThdONBNHPRuO87vcGJg4kbATC2IB5j51rOd4qt1wLY?=
 =?us-ascii?Q?dj4IUlGpHYaUol3e+D2+nbQyA3mzY1elBOG4p5S7WYEohr3dHAaOIrvu3aw7?=
 =?us-ascii?Q?08FrsSI9kiOt93zIVUam1mq3MxHBVDrMsAtPlG56ymmh/XO9J79kC2Xv5ruU?=
 =?us-ascii?Q?j1bJq5qhrapWNgX4mpfNY1AtFPoa6NJSOP1NSNVyAI2nmLFFarSOHvdLlgzr?=
 =?us-ascii?Q?Mps4bcfEH2z7c8g9/2lY03xUyFptfMYcPbqSpXIj26rFYUj6x5OftgLacsI7?=
 =?us-ascii?Q?4jPPlyZ3DVRF7zjg2xJy9u3ENbsIpkbuAev5RKI5mIAQ4YLZVP3ezLJQxYIH?=
 =?us-ascii?Q?+bXKjuM18MB/ZN7V8od2rIOJkDjzquFWzz/aVrxRigHIX0PhZNNB3mOnMvJ/?=
 =?us-ascii?Q?/HWjcl8cEhM7PAzsBH6Nqpw0EzYngO1txQhkcV6daPm/NQxV4nNE0ANq1A/I?=
 =?us-ascii?Q?csIW54iu37HtSuxQw9tK6dxY67pEHonE28lAnLazBVzbw3EAnDcb4ouDv6OY?=
 =?us-ascii?Q?/4q+ja0kBtUxbQYpq8H4EnyATPwpKnZ4qEkvijWLdLRfGr75Zhgu7J++T+4M?=
 =?us-ascii?Q?n41B/aBk/1osLS4sbOYHEBF2oo9G8hEiApwf/J7IDuNEoa+sUOUJosDPzJyW?=
 =?us-ascii?Q?0JBzBRA9nM3qDB6wOoKNDiRP5tHHWM9KRWY2KSt03bam39H/mb9aedMUdqBW?=
 =?us-ascii?Q?Uz+wDS+WenR56hvTZSoLkDFK9/MKCMAd4Ftas0W8tQimjHvzprO18zIJxAJg?=
 =?us-ascii?Q?vR5TLPWauUMB43/4CYF+SsIsTxhTzC68VPvVvrmgYmJ5ZsgEaiqKAKFXCH/4?=
 =?us-ascii?Q?RpwbiU95f2Hh8sykqkGlbbUlYnVcxO9bBF4sYncJ9Y/K3S7YX+Zqyjhj1hV+?=
 =?us-ascii?Q?P30eOUZIcUVmeqtYHJHaaeCf0avUDq2K9/ds3Fnso0mT54ZE16JxIOf7fixc?=
 =?us-ascii?Q?PfrppWZbH9Hd2NkD36c//XUH/XnToZWMnT3qlmSt1m0OegH675HJFWgSlO9h?=
 =?us-ascii?Q?cvel1xVh93B1sJ/wYZGw0rn96e3nlVVT88Cz1g059Dj99IeJz1V8jNuBFmPV?=
 =?us-ascii?Q?ImX8ArIVOp1fAaeT8MQQALNSsBzMMebeccLHM5mB44VdQVnCq2Z2T8KgpJra?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ex4+C+nhKHw9+7rqRwS6hNDyUpBbu+GV3aFK7P2P4y/gdEQjlu6ylJw18WvTQZOsGTEkjErcDw54jWVdcN6geeo2S2haKQy/bOcynGgRX4bg3f9cO/o4fDmxe1Cgs+3LwSizSb21J0MyebSoyieJ+jy1g/1sEpsiM3jWpP9EqItwWIWoUU+6OOAeWMwlcOHzasq6GPtSeL+IItkipFVRl6Ii/zW9t7N6I0pzhtvAoLuem6U16MsXg0JURuk7Db5jPsxP4oSkI6vmykQ//+4/DCDOeYVcwZ/ZzO/wRBID9PgVTiL3wM4exZuzRCS7duC9xHB2h+Bev6vdI0YZjrEoMWvFmRg86aMDU4rDPRJxuVXqjg+uTD7iKElYBChlas2E8SzaxqlsM6J0XU4K0enHvUghlkOYlPtcBNSdW9G+XtJ3Pf05fCKNPXqGHA5QZjc+ajkbGj2TtGde0nSfnkd9aurToY4x4avey9Vbhbpy5GzW/wvkM7sIpr9kgl1Xa2Lvbk8Xkb8OukYt5wMwiXD2RpEfHPYc+viQ5LhOyq+8wHoTlRP8NixXb9ww8rFO2gj1NQ42cbpep2whaR0HpBkaANwylrTYvSB02Kr8OaPOHvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e9794c-66f4-43b2-7f72-08ddf0e5dca7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:46:59.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmTBeH5Ju9LF3vQU/N5bZLulJNO9m/Ew38A5BwEc5Kf3ggnrD70wAP2G+J+a5WmLIaFSW7aCYCZxU3TSGC7w2XD8KpAPHAQtKRigrJHzhV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110030
X-Proofpoint-ORIG-GUID: TT4xfRyQUHENT1UUNxB6RZk8GXWpgp3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX5Ft6u5NPpjhN
 wsdXMhmCZ1lbXIW4xEWqvMKwRAMkO0HbM2DU9vj6AoLr9Wa+OWp7o4xzlKg1rdFmxrWSrOnL/Kp
 4COFjyp4b+FXLEfSnDyMkAh+Gn4D+Ju1pZ6NJXkPW+dn6slfiEHm/PWkeGrE8do4KTJhoHgwolK
 7OahSzHrse/HJjgenoMjjLXq3hIy3mhU80U00z6w9A9WD6KY4yFUE5M7EFboWRh4GPh2DW1QDzT
 BhcDxxSR+DMetUhpRxcqVOqDysT0igxN66EY2CexP/IgJuPQiMYhHQzWiDKRmG/v/F6xgbL1sDM
 VPkrQLVn9owgteR7+xMsCZq1Y5puo0uHPAE3RHDFWo0BshnzREY9hmPbI04Z7IpUCWH6Z9MMP99
 Rc83UeHT
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c24637 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=Z1HUBbmx4UX_vy3hcwUA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: TT4xfRyQUHENT1UUNxB6RZk8GXWpgp3H

Add smp_cond_load_relaxed_timeout(), a timed variant of
smp_cond_load_relaxed().

This uses __cmpwait_relaxed() to do the actual waiting, with the
event-stream guaranteeing that we wake up from WFE periodically
and not block forever in case there are no stores to the cacheline.

For cases when the event-stream is unavailable, fallback to
spin-waiting.

Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f5801b0ba9e9..4f0d9ed7a072 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -219,6 +219,29 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	bool __wfe = arch_timer_evtstrm_available();			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		if (time_check_expr)					\
+			break;						\
+		if (likely(__wfe))					\
+			__cmpwait_relaxed(__PTR, VAL);			\
+		else							\
+			cpu_relax();					\
+	}								\
+	(typeof(*ptr)) VAL;						\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


