Return-Path: <linux-arch+bounces-12477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D0AEAE16
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617014A6C63
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428061DE4E5;
	Fri, 27 Jun 2025 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ph06clFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ViL0E+9f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836A1B4F0A;
	Fri, 27 Jun 2025 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999742; cv=fail; b=TYSY3Fxe70F29AzjK65u7RrOv5VGTQtU9bDQH/MlvvPidWQTbF5b8KA6ZfXBgEKjIh2MTE3Emr57rQfwkKwmPA+2DQPDv/kWwJu4sXembk6aeBJv+AJWRI8njRBx5krndcQNW19oy1ZnySkcdR/sPM6xb3+11b3ZoHknra6aUfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999742; c=relaxed/simple;
	bh=b0vk87qeS/NSwSlrsfu+aNEeRXFJZCS/IFc2JLCUAhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ISrc7b2WMlK9U2Mx3HWBTPe1ak3y8STYVtwZkFzYUsC+8c/U/iou6YWjQGJ6/9VSyvIrmeKJrSCQKkptK+uctQxDRY0/6wKMMwobxiWsVCVvbp6Frr/jgcBIA4k2div485ZQs/35Fc/URZK01m6aYlTzRob4gRaKgabbS09t5n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ph06clFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ViL0E+9f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R4aX3P002069;
	Fri, 27 Jun 2025 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m78ypFD2WEH+65K3u5c8P1VM/AZ98VsQWjYqCNYEJ6o=; b=
	ph06clFcRd1bA8Sgp86fi/x6WMm4ZdwbYlRsvRISCspAsPcdWkhXveRKAIHMUkQx
	vNhmI7zbc8C8zKAPoXo54jwxMsMuBAbfBnjOPcW0PkaxTXB7Zk7rdLgLdaBlnDzd
	Md0Q9Xb5K1RXDeM6DQCQst5InRHcvs1arNljD7FjHHu63piuZhYkJdRoWTQrcQKO
	/kD9DJa7qQQU6bZVvFPqcshSgLyhey5AP0wJjaijgP/AYAggzwRYbAMx9wg4hYy5
	OLMeSAhrVvsCNkawwjdSvpHYfNwcQMWKIcK/x435wj3Qif382LwabFT+277j/ZFW
	cvVjNJoUixcqMy10ygXqwA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8836v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3mtnU002627;
	Fri, 27 Jun 2025 04:48:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt59j-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPbrucBZy4Leh9xu6wHGUinOY9+oKTJc9T+GybyUWHyzRbki2/mmSTT7LzscGyLjNCVzjRG3Ji6RxYU0vnQdSkn7Po0H9OGCQFsenr2m4e62KHBl2Woe7aDoBc4ijMw8Vir3f3GoziH9PtgWgg1OXP1tlabAj0OXSedS18cyd6uWRUVG16AQY1AeYr2NdpecQYJY+PBbkiZjNw0f2nb8f4ip874xyr8jwpHuO0mB+PjSmyZdPJ0xUK/knzXJKZdAR3O30S6H+LK9v1OyGNJIuFONTQz+X3OWBiY36HyrwwDDLimMgnc2W0D+EBwGflDC3+7fnJcr/VT2hAsdPWCvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m78ypFD2WEH+65K3u5c8P1VM/AZ98VsQWjYqCNYEJ6o=;
 b=amqDffjpmYGj47Ap1YPXHRIzC7oqZrVnIWTk0rcxWKTJbgURNhZsU2ntV4WqCq5M/m9MFHSQo21/Kv1BlQJwM0IPdkmgSX5AuCx1vUlhVrzMvFL7DdHEQhbGYSarL551OqsbXv49lWmKFFLGHfrtXfv6bVN5C1nj5jg1GfiPCbu1A83qN8u+a5nC2qur9J0TJSMrnpY2lc9xHgnOxwaMQk6CaDGOkiTDJkMaeawwb9Npiuww9J5eGp2RW353hZYsy9ehKjpPUPjeWnWx5U+runyHBf9FLZM+Tv4xzrc1POeJjoHf53TbiEMqQYIa2DS8/0aDYGPB7dt5F8Hyr+spWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m78ypFD2WEH+65K3u5c8P1VM/AZ98VsQWjYqCNYEJ6o=;
 b=ViL0E+9f97d5uwc2+NzU7o5oPeDsCAQIGGixs4ibrgDiLhqXvzR4fy64GvxEAcJ+TOK8rqggaytzre9NzpPZ5yw/mW6PVT3Vtz9O/GZsziwFLhfEclBwDHBCV2x8qUMH8He0/euvrj3SbxBJtxVbU8qzyk1/zAyx1bl+29O5H9A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 5/5] arm64: barrier: Handle waiting in smp_cond_load_relaxed_timewait()
Date: Thu, 26 Jun 2025 21:48:05 -0700
Message-Id: <20250627044805.945491-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627044805.945491-1-ankur.a.arora@oracle.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 74059172-cb48-4526-bb4b-08ddb535d564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?63PfzKZMwc1QpveMPwrH0CB0w492OlxV2DsPVQXvB0OCS2SYhd8Hye6nHtgC?=
 =?us-ascii?Q?xHlteYFuYedw7mVGKTLYvPMK5G9SyeTktXouPVdQq3vJIcXyJAnt9VxQxqK1?=
 =?us-ascii?Q?D3G3Ve449dRc8ypiSsVQAb3qKac4R01BCYYcIe7eH6Zsm45+N/qx3jSsQ0eG?=
 =?us-ascii?Q?fYOwVtAJyP3hUH249/gJcu8k12go9X6FCoz7jPcREyjKNGabYysyDzVS3u7g?=
 =?us-ascii?Q?an/fgk5r1jLXwBCvmzc5wDvOkIUatmEnRwnUS8DWBzzjHLXnatiIEMMNqQID?=
 =?us-ascii?Q?TaphIKEw2/FJ24sjDxuwcv0Y5hGVwWAPYnaX7CDpIaRndHzP4FFUjy/VM4nU?=
 =?us-ascii?Q?VRRKxA5MREpnzvy1/XNyjCkMUvt+GhJrqDfPXFJBzWGHQE4gYJfdL3O+1Znk?=
 =?us-ascii?Q?9yPrqvHNdBfpSWfHGiQAIQcaI6+Q976OEo8nD0fLT2SgxKFZYgV1DvvC43Py?=
 =?us-ascii?Q?PkBY6W16nzwJEpVkEQ1JHFERJlegzv9SHYYGkgrKnLKN2NBLuNl3I12aRZb/?=
 =?us-ascii?Q?7OYQHf/AY3nvnG9ZArJbP7d8uondQW76UAvGg47Gnym9iY2LJFoEvOXcuCxf?=
 =?us-ascii?Q?Hl8En5b+TFJLe6gJB/EADurENZLkjAl0ZZkWtMFrZE/XILRSP0uZYEYoBxSR?=
 =?us-ascii?Q?4Fcf0oSt+NyDU504zlclno37hiIYriOU3GBwH+/S3sBrdvqjujNfdShM4f5G?=
 =?us-ascii?Q?68FiCGsSE/9EGKHXjHXmYU1O7H/6IzSCBuWy23bqRl9A1jSDgWVc3ewqwXvb?=
 =?us-ascii?Q?JJdyjd+BZrLrssDWxH0otN3OsimpBhu+Um3xz8wyBZt7s6XHFO0phdwZu/N2?=
 =?us-ascii?Q?RtL3mmMo3OgrFnyGamT3MJAgjiBzXAmBObftQpCKBAACg96yzyyDBFXSQAjV?=
 =?us-ascii?Q?JDmezVVG4DQX1VXNbfg2ZoMNvPVJxKnWQw/E8rxLIiGgR0Wcgv6/bVmsuUVI?=
 =?us-ascii?Q?DT7o57smtxFHtI+JoL93ejtMB3xrvtyIxYWBBxyPV5CMc+Pn0Bx+Cr+2zUsD?=
 =?us-ascii?Q?0lgB35eT+0rH9yy+QIwioOeKvyu+wM7CL42MYpr618ZJgti9CnjyH01Gm7w1?=
 =?us-ascii?Q?dX8PgObuA5BBq7yQElxlhP2PmwvNqHHfq10MW9QKrZoNdokh6W6p+F+X2Q4G?=
 =?us-ascii?Q?4/2cHq22qcQ2nxtAm65lww2UObLWv5fMFcmNhjiIQv9GKtcdmQe+9nKYMm10?=
 =?us-ascii?Q?/0A6UJA0DQlD2Na4pIser0lEKeX8mxC2cxzDbWjnJrePQhXzxpOmhzRW3hsN?=
 =?us-ascii?Q?XWfMqOK6bSt7Y7f6CN1YJBg4nYpj+WrWyeD3ASI8AvWTErYoX+OYwesSLuR9?=
 =?us-ascii?Q?O2fwbbc2WxuOobFDzjsrEs05PpjSicDtLh7PdnZXA+ifT/Pa/HaR+gcbUErr?=
 =?us-ascii?Q?NkCjRTZL7f6NKwzo4hL9DhtCM8TxVEYnDrO8/MlLVU9ljU/u7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74wWF/YmVGeiArKcNfGmX2H2hhIMtzjcyIxV/nIocYWwqjgd1XC92XPqfJhh?=
 =?us-ascii?Q?ViOVl8yVXR9v4bl8CyJ2+Q1z8GDdmSU76r/7E6LNXkQAyV8cG8fweU/Aya0b?=
 =?us-ascii?Q?Y7nF26hgWItSo6H66s+mvzoIELS/S/UcxebXGiCOHLsNl60HFdm5/BHLUw3u?=
 =?us-ascii?Q?CJCvFJ5KhuFc0yCp3rlA+97ksE4V/NSj/Y93XkGOxHT8xZVj3ywVI7Pr4Ck5?=
 =?us-ascii?Q?M5E2/iXbbyCDZRcEIfl40YrXmkCSnpmw9L/STuCrpnW/7iU92lmjF2Cbdc9T?=
 =?us-ascii?Q?6oojbGd709TcIff50aoBWCXGwqY6aW0hydR/JefP09Nn6b3EUMhPqgbfnA9z?=
 =?us-ascii?Q?RpjgkZy70llZGiV/CyyisPIB26+RNdTZPpdFLOZsLpwu786Ugy1b5rwBhBs6?=
 =?us-ascii?Q?2jVEOteuuaym/41gBMnPRa+luye8Nb/X8RZgVGnSraL4PDsn8fXV5Gqbe7cT?=
 =?us-ascii?Q?dUL3X7PiLzq4C6dQTtZe6H3a2nb5hF4jnQVCduQ1otHaoO63sA+44ytbjNF5?=
 =?us-ascii?Q?skpnYiZJW78NXltvrIYfp7MRAOVxX+xr+cMcym7NR1q0bZdGKPMbm8k4Gc5x?=
 =?us-ascii?Q?6BHVeN8WYa+K8sREodzx7yZe+yMMT8kK7FeK8Qy5GR3eaJHkR6JnW4rV6SCi?=
 =?us-ascii?Q?9+KvaWFWKWqza1fJ922lOJp9gJ5Ah5NcbpxQTMz3rN7T/6Ee2gEBkBn4zkCs?=
 =?us-ascii?Q?Xj0hHwpRepW8PqjnyMR4wz/b9Sotru6H3ExCZ2Zfy0PaBJk7g7iS3x4b1XHj?=
 =?us-ascii?Q?yLYRpXcPM2PhlXbNw7TDyoc5L75YrVO6oSFlLTnmT3qcp3hyWyYP3gFjoMgZ?=
 =?us-ascii?Q?cxEaLj0LukHBgSo5MffhH+HYIZrm2qRJvGC7pFdF5kpmIzwv8mC2nJUM7PWh?=
 =?us-ascii?Q?2l0qrnfnrQB0MVlOq36QYI3MaedHS6GbTQi2tiUzwe0j+BRbRVX47+zEvZkU?=
 =?us-ascii?Q?VEZG/SyKB813EXiP1XyZ9uBuaRjyV9HPHxLVPiMCZyA0/WgWIHaQDjOG3Wgr?=
 =?us-ascii?Q?k/tfSdk6iIR5twhQQ3NulsH3FtomCVvD3hdECoCNiU898mevsgHR5Z0xg9PF?=
 =?us-ascii?Q?uNLHZZvc2cg9mByv1wLgErYWEVpqdPEujSPPtixZzDLe7Fd79XMxRf4sO24D?=
 =?us-ascii?Q?Go6A4iBTCJiHMniu3CVZphvFFzkZ1tktCx8ALQeHZbTn/+yTShGkTAubd5gR?=
 =?us-ascii?Q?ELRfE8FdkOODAsy9B4Uw19UAQfnGElZnes4xg4cOP22pgSgRZNdwJTUzXTZl?=
 =?us-ascii?Q?3XgU3I9JRmR3xoGkbLulzkqjMCQPofjNphQ7U0h1jJT+yFrvf/O8wZ4p5Vta?=
 =?us-ascii?Q?Mhom74SVAqJhwYSOp5lwrqUVAs1NHHXx2evZ8WzTEaNzZ5oNBWZnpQ5exiQH?=
 =?us-ascii?Q?pKNxXBcH9fLjSqNI2wf4dNhc+pLBmbDXurunA9z+tWdYrGk3YjCnm3XpSmyQ?=
 =?us-ascii?Q?gkYH5+vzFZhY5nKRg4/Cp8i4wNtrsY+ugMJuLQbUclg4abyqqMkEBJ9gXbcv?=
 =?us-ascii?Q?NgZi5jPTDHmIXxKqaizojx7Mciy0zukmbickUIW3KDvSqh8zIY+9r4yvBD+C?=
 =?us-ascii?Q?or0Z9EYmRa8fdWzIEqMz1I0iBKh5kfOPvgUj1+JAsxcX8+3jB8baeIbtUtuR?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	izD3IfAOsPbOC8GjrOMgrkiqGQ/pC801Vkp7FX3zUcwsDuOHuYGJ8PfL9xBTZhB2XRTaMzl695RQGvo98OihudrBYnYru/bbDnb/8KJmyV0NuYl7R+OrkV0nUjiq9dCi/8lNdMgfDdO8mdx1gLMhysmI6F6SEIZBeZMe66Lg/uOvQCtCwfvJ+ZD5pcGDEV62/JkPAXQMY5KxBOLcrjXoxgwg78d4s6SLMXBsRX1SuSC5/zVtwgI2+l3FDo0AMZx37hpRdf+8FzM/VU6I5YO+B+trk/8L0msoxtwMBupRkPBQTRh+urEWTUNF7VrsBq6FhPMuXBcvJzLh86qFccPVXcG1uIN4XZzwWkOgUlwH/nET8syHFbZuYItbj4jNCidowSZ641j0cajNSklXna7cWDnbCjcgvZOpqIEXshoCk7Uu496QbFd6joIJkdvINckhlBdEUFmb0if8yVebn3XuoEGzeOlky1aky489S30BGjIvnFk4Rp8t7ZpV21fl+zNpUxL7Rtua1UuyIDg9AOcPmK1bvm4LHop1us9vTNifhckGhn4hYMq6up+ZpZ27JA0PMep9dEqLTSIgxOWiptY6zB6BDzicEzgd9X3zxnNvnHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74059172-cb48-4526-bb4b-08ddb535d564
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:17.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+gMmiRRhb/Y/NcAOCFWtv/NcPApXIqV15+cHvtysNGTJrkKtU/RVeLjT3qfIGxL90rMEQuja38jOYdbJj+Vc1vT/qrDIXnfw9MyaarPUwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685e2298 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=ZZK_dPAAUNCPne2FAV8A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfXy+Z8OGeP2z94 uYaavYoKw63kStIVmWRy3HiDfQFrHWSeD1yHOro4DFUYFjbL963eR6oiDWEgENvUP9aJaBg/YQe aZ/X30+vrD1OKgehtUwXmuiyNl83shINnOGISP90SCgNlPz+EF55GD4R8sdEYdaKLO1mCETp/+/
 vBN6HP7/AacB/r87grLvqg/EiSAMh/ee8H5K8ET3O6za1KmaHexnITVP/0PH755MtCQwjmPuF4/ /czSqbO21gm9tOpedccbN+bkQSANS60XU4wEfqoSuTC6sr3t0yagZHiTqVS+ikokfk1fVVcvpYG fc7AWVEfuzpnirDbiwMZJaIzMlPwcgHXfwUbcVJLx2EyX1H42jmL1e8XfMX1TMNLZsfaha2GrUR
 5SHK+xFUPuqPLQJ5dJd/LlRcf/DuMqJzzTv1kC1QqdftOmsi+DCES49NJN3KQqhhEMhzyH/4
X-Proofpoint-GUID: ZF9uy2NbcQX-Pt8qEimPERr6NXW79R2y
X-Proofpoint-ORIG-GUID: ZF9uy2NbcQX-Pt8qEimPERr6NXW79R2y

smp_cond_load_{relaxed,acquire}_timewait() wait on a condition variable
until a timeout expires. This waiting is some mix of spinning while
dereferencing an address, and waiting in a WFE for a store event or
periodic events from the event-stream.

Handle the waiting part of the policy in ___smp_cond_timewait() while
offloading the spinning to the generic ___smp_cond_spinwait().

To minimize time spent spinning when the user can tolerate a large
overshoot, choose SMP_TIMEWAIT_DEFAULT_US to be the event-stream
period.

This would result in a worst case delay of ARCH_TIMER_EVT_STREAM_PERIOD_US.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 48 ++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 7c56e2621c7d..a1367f2901f0 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/kasan-checks.h>
+#include <linux/minmax.h>
 
 #include <asm/alternative-macros.h>
 
@@ -222,6 +223,53 @@ do {									\
 #define __smp_timewait_store(ptr, val)					\
 		__cmpwait_relaxed(ptr, val)
 
+/*
+ * Redefine ARCH_TIMER_EVT_STREAM_PERIOD_US locally to avoid include hell.
+ */
+#define __ARCH_TIMER_EVT_STREAM_PERIOD_US 100UL
+extern bool arch_timer_evtstrm_available(void);
+
+static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
+				       u32 *spin, bool *wait, u64 slack);
+/*
+ * To minimize time spent spinning, we want to allow a large overshoot.
+ * So, choose a default slack value of the event-stream period.
+ */
+#define SMP_TIMEWAIT_DEFAULT_US __ARCH_TIMER_EVT_STREAM_PERIOD_US
+
+static inline u64 ___smp_cond_timewait(u64 now, u64 prev, u64 end,
+				       u32 *spin, bool *wait, u64 slack)
+{
+	bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);
+	bool wfe, ev = arch_timer_evtstrm_available();
+	u64 evt_period = __ARCH_TIMER_EVT_STREAM_PERIOD_US;
+	u64 remaining = end - now;
+
+	if (now >= end)
+		return 0;
+	/*
+	 * Use WFE if there's enough slack to get an event-stream wakeup even
+	 * if we don't come out of the WFE due to natural causes.
+	 */
+	wfe = ev && ((remaining + slack) > evt_period);
+
+	if (wfe || wfet) {
+		*wait = true;
+		*spin = 0;
+		return now;
+	}
+
+	/*
+	 * The time remaining is shorter than our wait granularity. Let
+	 * the generic spinwait policy determine how to spin.
+	 */
+	return ___smp_cond_spinwait(now, prev, end, spin, wait, slack);
+}
+
+#ifndef __smp_cond_policy
+#define __smp_cond_policy ___smp_cond_timewait
+#endif
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


