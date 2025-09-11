Return-Path: <linux-arch+bounces-13488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC441B52762
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABB807BC876
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D05221FC7;
	Thu, 11 Sep 2025 03:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FtSViJQq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GTnl8Wyz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409F8F49;
	Thu, 11 Sep 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562450; cv=fail; b=aJjCTZH9hFIsF3diJAq1CERZWmh5fR/guXdKbXq9JUL56M3OYwOtgpjjALlc/xEkI6ZDkKIgolcFuPeJ5IBh9POLxC79UQZgIZ8XmN2TAXZVM0PoUpmDPM+TNgETzB8/CKtFFJcfTPNjC/pXZlwIBd22U1cZNjWwZjnWdp0IKrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562450; c=relaxed/simple;
	bh=Y+dCzcigysh7ARs+lWzlHEYt5cLV94OR3CdJjPhKg7c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GxLcPrv5NCu3xM+Cu03Hcnda54W8QeaG+7X34ja+1+F7/16uVKazDUxUu/qOkTIVu61WSrvHNbdRefR+cd6yddDZ4jEdoTjxrHiyRS07+AvsqfTi8iOfRefiQOL2kbfV070qqGVEiPat8AkpuEsJDpBrjOWqh3BFIqTjwutVS/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FtSViJQq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GTnl8Wyz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALfx2I028218;
	Thu, 11 Sep 2025 03:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=cKeGWdtvOBYtlE83
	ZobGkv/VIKpMhcBos2PFis3SPjI=; b=FtSViJQqMOFQuaFkN2eRWoJwItuaOt0c
	4YMh+5fl3yPz3DceuV9zubBoocv12omZwRq3m7/cokrVbUzy6JZBM/qm0RUO2T3O
	U2z/CN5eZfIYcmld0C4/H/QxbUi151WssqYDy7Mv+fpObR0/HLjZLr2K7Qhie60s
	qFJHxZgwIsvbHZp91Dgi8wf/Din4OGVL4JTWBDLHOFJDXpcBb8Uenjk81pMCO0ws
	pVxFgTtACWIxOaYRWnL4Ht/sohYRWg2ANTy80JRgZYAhVL/xXVEPEX0oMXDsE2M2
	IygA/hc8PxjscJG5MOXEwlLAfuPNh4m2V6DZ6VhhYkRTbjKvHgG/Mg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922965f3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B3kH1U012878;
	Thu, 11 Sep 2025 03:47:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdc2cef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qiFERNB8vJjNYHdRVulI3xlTw202tNflG5T2hRPcmhYZeNc0L041gMMdcAS0dMvcvpFqkp6cMONAoK6E2xx1GJb9uouXk5niKpPt84OGFsfLuon+9eCKz2usKiaF/k6EgX4YeMGyJ8xzi8bvjZVGWXhYiz+PmSUmzA9LwO7KphTWrLfuBnq2/fM/y0TfIociPVyMQKVAihU3f5zcrFRfbyhIDzPZV/+KIHBWTvu4LKtbkeUy1TvWcBL10r8vSCB/RrnoGMEdRfjjW5vmtFo5qvcTVk0IGzKhhZMzDfpstNM/yRmH3q+2O4xv8VuzqJBsuxF+kC32reRH0pSz7njkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKeGWdtvOBYtlE83ZobGkv/VIKpMhcBos2PFis3SPjI=;
 b=kIhbwOEAyuFW/buLczbsRaMDkBX0z8LYyRz76MSB1QT+dWC4K0hPB8wjNy2IQssvbtkZHS8xHEBdHhUtiEcIsvtvcRDKPyoCxWpddFq48NR6LqjZCD8necLCaB+JfQ8cy7GsGT9EKM4eU8fqWKI0l+WmRbaiPCcVnscDK8EVOLBaO9k1BNZ+Xapy3q/hT1fl0XVpvE1wa/i1qscDhdVBDbOqpPl2b0C17iL/qMyBLqBcJSrwAouHVp2hq8p++jFbYsiChyn7phUChehW97A0LBuT5QlHrgQZpGx5UMdaaJ4If0Tnf591BMDZxRMBskQvQNZsyFdcjFZLWziv7sTX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKeGWdtvOBYtlE83ZobGkv/VIKpMhcBos2PFis3SPjI=;
 b=GTnl8WyzQokpIJK7CAENQFnXaMBRAIPs15x402titFHFViDbHrJ3zvtbELloA0hEt1nIcAExeeOmj4TxwppgQISBsqPXHRIpUGfVT7NrehqjH7tBZbSaJQ2v+b18lMe/1fBjd5Z3vex0znabclpYLT3FtTLboNofkEtDdmv2eV0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:46:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:46:56 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 0/5] barrier: Add smp_cond_load_*_timeout()
Date: Wed, 10 Sep 2025 20:46:50 -0700
Message-Id: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0292.namprd04.prod.outlook.com
 (2603:10b6:303:89::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c78af6a-8752-45e9-e27f-08ddf0e5dadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fMzSrMP6dNCfDYPj8cRAJ7iG5Xs67vg1FAfXFfrGEoH9brpYUOVqwDDd/7Yd?=
 =?us-ascii?Q?2VAU5PuczuyVHz2Lsd9AefJrYroCpGYektj1lkbtl0tRp+ARy4Wej/95G846?=
 =?us-ascii?Q?RN8YN/ERIHoya4s147N7xxVL3yT0e11Y8AwoCqy9JTTZ+ycSygWINlG58j7G?=
 =?us-ascii?Q?eY1YWGzhgqSRW/yuKwGRBuJDUJZS0F7hQNrXTN9y1Q+uP9dUwSdwXAWVxU4x?=
 =?us-ascii?Q?9R+9ITLvm2Q9YZBdrh3uqztg1wNDTQ8wrIl6fRIkI/7BP6tdv/GgCGGdzTrt?=
 =?us-ascii?Q?NDsNBkwyHh//K0gBopZ0VPbOQIpws7TjvGaB3LWQlw/DJ1/ELBevJx9dHHjq?=
 =?us-ascii?Q?APeE5EOalLQAjMUnIEx+/RqAqzu6Pf1FvFfxRadeA8xD5K6HX15VTkAuk5yz?=
 =?us-ascii?Q?0zZVt0qxNIDMXOw1XpPRPvzv2mGldfcdSrUtNbJv0DjOwd/IlAgDUKls40I2?=
 =?us-ascii?Q?IfoOjGdjKs57BScFe5ol4DCLLdd18zyOIj5CRWxDX9Xg00dP6H5mNY0XSC8S?=
 =?us-ascii?Q?cQ6ze1hJx6zY7qg4p3mRSaSl+aSe3lLb8niVFrcSuGAIB5xGKHz9j1QmUilU?=
 =?us-ascii?Q?ccyEgmlpOM7Vc+qP5Dw7GeTMx0+Ik00rMC/+NLSyON8W+ByfTYKMOTC9HkSI?=
 =?us-ascii?Q?V+tS/nzqGJHvAJZiBCtXXS228cSmjdzGG4eUl6SDgYjOa/7Tf/aDNOOskio0?=
 =?us-ascii?Q?6cWcvqBXH6QRBOQJQU45zAYrgz4Xw+PQmbhz3mjr/Vjz1ZDaSEX7YPmkoNZB?=
 =?us-ascii?Q?dwsxElOJsP29BcaLYOHAN0lOkfPNxFseHmNdKpXotXk0LjREnyPfT2ZJTt0X?=
 =?us-ascii?Q?xvjcpLEWyrQUqWIUR5ls9vAXyiIIYCC8MlTDI8F1njDDtMay0dpdA5qdjfXS?=
 =?us-ascii?Q?lA7zBDUTaZp9QMAoDuG3QTq7M8avtlnwv2HDulzKkVBJKKTv68siWLh6oFQZ?=
 =?us-ascii?Q?Hn6R2w63Q+Q3QDafrzuM9yoTh6wR9ALRMKcIJCI16r97LGzuA5ty9xzrIJT2?=
 =?us-ascii?Q?b7XoSGZz5hwK2m5hEOl3MVQqAL0OHkyFbRfDj9noW5Z3MwiDdRf+hA/NlYSA?=
 =?us-ascii?Q?46l4Ts/e/DGKiFobLZ8ETR8wiiS0/OinICthLoSX2PR/4U0Zb5yIl4T3APBE?=
 =?us-ascii?Q?JpqfOPvY58tUsfo4xqpGz7vei3y3wRiFvJw9UhQ102Scv+9uHliLQPpYbOkO?=
 =?us-ascii?Q?fUKD1lCrohR7LrCpg6mosTZwd98gM9Frl3mmN0zPavKbz+MGm4PEOL0PM0iu?=
 =?us-ascii?Q?GCMmHCO48Mo7W1za1iLo/BGzWKVTEjaPj1f2I6Y8W3Cwv4kcgTJpybOJKutf?=
 =?us-ascii?Q?/dJlZ6XSJkFqugViD+OO0OzIuDU5ltXMlp20K8jkdGDDDfOgFjCjIyvJ6MUo?=
 =?us-ascii?Q?QfeJ1QGOzS82LwCzm30lvY2wJ2GR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHuXTZrmoOlHHm66QhLMAQxpf29qkQ4mVm27FEafYx1p5XuAPRfs0yro7Zwu?=
 =?us-ascii?Q?SzZkHRsNWIaXprrlIJX7aZZuE4A7JHIxDgZgEIlKLSMr47Lbm8u1cMRTxvld?=
 =?us-ascii?Q?gaCQhdb45uMcFzwGsCG9m65SldMe8UBXS3Cs/uNBQpTuhKbl7dNapVPVz7xS?=
 =?us-ascii?Q?aVvCZjhTeEEU3sffsQKmaBStlBGtITRc3LImLYWl8qGD77tMiDKuwz80gOHa?=
 =?us-ascii?Q?N59qw3B9eJUU0NnJRDBP3oBWJVJEJovJCKj9cGlVswcEPbsbVv3AE2ITr6F8?=
 =?us-ascii?Q?3DBCtDT+9o+yBp7yaeggKgogQfXWEqD5ISR08ey5tlnBh5ffikTA38epocjl?=
 =?us-ascii?Q?8NNhmsDfa0ok1f6KY3n3ShFoN3EpsoFFpVJAL0PzD5KqiFXx9EgIWwCmPBQK?=
 =?us-ascii?Q?an6wjQzagP9mpjYJz2ByQfc3XtKk+sCXXWZatlJuwqemS0/gjAIcZ6gNt4qv?=
 =?us-ascii?Q?Nf68p4/Od/+cimUeLh3YnrwqCOgpJp6fyhoTH6q0oe3hIj4MqivC5qbzbmfj?=
 =?us-ascii?Q?aiIQwnjl7weJFnzJqI0VLg7ELdWHy1CqDWwA9RKzGSQ6iD4D1IzQkLLMPfo9?=
 =?us-ascii?Q?aj3+ILkh6hRIPh3y+/SGSJEo/SfKSXU2Ae1CCdQ1TNFcwHJZhgS2+o6oLzPU?=
 =?us-ascii?Q?JUundq2Lrqt8SawgdD/5/iYBpio1fCv7kiYnsQQY/juxOMvbgHwJUpLZnbVP?=
 =?us-ascii?Q?mDMtx6LGeL+N4zEIc1lP3ZhNjX7kN3iAdv0CXXAfzR2qNKPv2Nxd+eWfvUL5?=
 =?us-ascii?Q?0ZC5jFZHc02mR4Gnm/3YaI2OoFN8QwmlgkdmdxBSqZsyQzERpZnxaPebeyOo?=
 =?us-ascii?Q?ktfV0/dvkoNTLauMLtp3MbbukE0BO71/4Rot5tU0WkdeP+plV+VbGOguHxmA?=
 =?us-ascii?Q?K2dLmK/1yn2AEjZ9dus26Jef5OdwlfAgAg+XtozX8cTJQYsSg0umEgbPLAvA?=
 =?us-ascii?Q?9AQ4sbThxmZiXVy3ahyGgqE8gpS9lfqtHDXDTnEezSP5QeLChKaeUsb3IRKB?=
 =?us-ascii?Q?yNATZNZNRJBXm+rh2PRfV5qHtZqJuGNJpbOsNHA0RJp8I6YopNbnLc543ivy?=
 =?us-ascii?Q?fCfNRS74yBLCmf+9PaLu2WBX7WIy0jG0nZgOqSudS6Sax4hm8e9Yxh0UH9C4?=
 =?us-ascii?Q?8/L/bZFK/3WN6CA5lAjhy9rbz9bn3XG/2+rmU04VDTjhHw3YbHSbRNJyq6Q8?=
 =?us-ascii?Q?RMhHtekUXD8NpEc+/wC5uh+tE8740A6imMoTsydcrZXfMCyVy+PAPXH9RcmO?=
 =?us-ascii?Q?mAeJwqb9+P1vWDAS5+ent05q1SPyuMzcxBsh45OsKmP12B9EahTr8fdp9lE2?=
 =?us-ascii?Q?dIgpkjMk4yM+x/kzninjP0CE+pp/mS2aRdCpolFVdhfGUm7oF/P1tC/+hdUL?=
 =?us-ascii?Q?nSo2DR4lj22bhvq0Wl9OH9XrepoQOXi6DWfwsS+D8wiAnUbqE2es9N8BV5xX?=
 =?us-ascii?Q?+kxCPDBrsSvuvfgCWoyYkoRGRhOHcrHhjx4uJtGhBQA4QmOiIYNurgrhD2Wc?=
 =?us-ascii?Q?m+0DxFM6ryBclttclopNYmjBSf3t3fm2mISsJw6z0J+VJIMSzf/Uu2ta9CBB?=
 =?us-ascii?Q?M/VBbZA7pfhSv8ObW1Fkz9aBhpV/qCzlda4igpxwa+Vs2Zb6Url9CAOcLgMK?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bpnBLRIAUDibSnLvCCUDIQsdnvfMCYTv3PD+7ksT8Rofdc0UDvMmVVZwlqhFz7ZAlzcGSO2+LTTKeLLdbV//PzoYay2OgRJKUUCGMwnO7FhvUq0Ee9ESuAI7CMBhFRDtzqvkPDqZpnfmHVmU+JXZwGDUlXmixxyFtD88WnpXT2IouCgyAA+stWNTdfsstYw+DIe0KnoMJ+W1PM5ovISQq/Kn0Ip4N4pPkqv1mCunrwPS5veV0jqCYlwDXlTy2JLcrEwD55EF8ezSxhCQ0xECEKQYteYNkAI3xM52mhKvC/V638sdnJdpgkFXSI1AfDTofdPQZiHwtztEkPyz4ax6UuteyraobUUMyugysuCnMuon21XA1SuxaYCWuOoN/ECCRKRChH8QIRy4nImEyJyhBKrMk/rIwlA3jHwvJE5DK6VokeKwIiLApMJUh5BaU8H3rrop9OToPKq9GHW2R2elSZXBCq78XXywWDYiliq33DZNc6fWxctZ6OM+0/1AAaZwmineyIODUHZHp04/mfSZ8eRfkNA1prTqXE89Lw9eUpB5hBzfmF8g0A4zmVQe6fmh6+ys6oPpvFn2O4QHlLmn5rx1FpjV7h/la2gXRFfxnwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c78af6a-8752-45e9-e27f-08ddf0e5dadd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:46:56.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB/4S+tIlscmbJwws8UesvnedDsJji88pMyZzRa9jPbwoUdphDd9yN0HZY3y0K2K/G99Cn450FtPJCva0Kpg2OhJRitetD9eZVKAt3AD4Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110030
X-Proofpoint-GUID: K28TvO-3S6QCyQLdABq_w1PxjiDm5RKf
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c24634 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=QXDmnoQuuVSgSO7tUmQA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX4T8cDi/ueYzA
 kSn04EUOJ95NuToRHOv+c5345k7i7hsy2NimDaJsTfDJeyKt0vtqBD2svb8uSwBhVzESEI0Fo9M
 kl6GNlP3lBMTPaonhnLhzI8EBlgTTgubV8hIxw8wvfLO6PEDCgNWMDSY9FoZmojfuh+TPDuuOzO
 hsqxVdDVAw/IE43+QBuPip3NwLJDmZYWaLN4zcE0FWOPdlPLNjB970p6+HCs1jTtg6lAUzDqot7
 7nwVtNDdvXaz7N3xzWOvOfKLeJmttnczgpz0IX3T3ePfJJLfpZZrj/TeVoERUEvKd6vhBuVdBbN
 4FN+uaNOzr3u3cnZKb6NjNVu7bwigCjO97302Abmh+m8OvtrmDmR+hZBY0nE0ezeLL8yxsjErqj
 BenPpqTH
X-Proofpoint-ORIG-GUID: K28TvO-3S6QCyQLdABq_w1PxjiDm5RKf

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration. This
is easy enough to do with a loop around cpu_relax() and a periodic
timeout check (pretty much what we do in poll_idle(). However, some
architectures (ex. arm64) also allow waiting on a cacheline. So, 

  smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
  smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)

do a mixture of spin/wait with a smp_cond_load() thrown in.

The added parameter, time_check_expr, determines the bail out condition.

There are two current users for these interfaces. poll_idle() with
the change:

  poll_idle() {
      ...
      time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
      
      raw_local_irq_enable();
      if (!current_set_polling_and_test())
      	 flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
      					(VAL & _TIF_NEED_RESCHED),
      					((local_clock_noinstr() >= time_end)));
      dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
      raw_local_irq_disable();
      ...
  }

where smp_cond_load_relaxed_timeout() replaces the inner loop in
poll_idle() (on x86 the generated code for both is similar):

  poll_idle() {
      ...
      raw_local_irq_enable();
      if (!current_set_polling_and_test()) {
      	unsigned int loop_count = 0;
      	u64 limit;
      
      	limit = cpuidle_poll_time(drv, dev);
      
      	while (!need_resched()) {
      		cpu_relax();
      		if (loop_count++ < POLL_IDLE_RELAX_COUNT)
      			continue;
      
      		loop_count = 0;
      		if (local_clock_noinstr() - time_start > limit) {
      			dev->poll_time_limit = true;
      			break;
      		}
      	}
      }
      raw_local_irq_disable();
      ...
  }

And resilient queued spinlocks:

  resilient_queued_spin_lock_slowpath() {
      ...
      if (val & _Q_LOCKED_MASK) {
      	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
      	smp_cond_load_acquire_timeout(&lock->locked, !VAL,
      				      (ret = check_timeout(lock, _Q_LOCKED_MASK, &ts)));
      }
      ...
  }

Changelog:
  v4 [1]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [2]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [3]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in
      hindsight unnecessary constants.

  v1 [4]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [5]

Any comments appreciated!

Thanks
Ankur

 [1] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [2] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [3] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 
 Cc: Arnd Bergmann <arnd@arndb.de>
 Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (5):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  rqspinlock: use smp_cond_load_acquire_timeout()

 arch/arm64/include/asm/barrier.h    | 23 ++++++++
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 include/asm-generic/barrier.h       | 57 +++++++++++++++++++
 kernel/bpf/rqspinlock.c             | 23 +++-----
 4 files changed, 87 insertions(+), 101 deletions(-)

-- 
2.43.5


