Return-Path: <linux-arch+bounces-15402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A1CBC81A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181B0301AE1B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A631ED69;
	Mon, 15 Dec 2025 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fDrHo+0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JrthEQh9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65D2D543E;
	Mon, 15 Dec 2025 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774303; cv=fail; b=mCum21lnHbP9eKioaLl2Fu5IDIvNk4BQeH01XHrVbS0Y4O0rhC71hkzUGWeg4+BQVvvHcP8UmwLDD96ivYwinC2QbStKR3nL7j4a/mIefqm/ocl78AWeE5p4+GQ5lZtn9PgIhoSYsoiBQAuLWecqVkQy9+lbc937RnnMS7opsfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774303; c=relaxed/simple;
	bh=TNAAObdjMCFPh6yReYoInFOlnbkX7tIE47BwA9BpOfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJwpl1CJNXNWSf+Vhvg+OsY5pbyUXpW63sq81om557sC7DpeT+ZqrJehvMEf5iOXZ8JkRUrA770aYp6gkndA5tNkzwZiPpKp8myeOqoQFgV9tLgtHpahwhBpZhsyX4qOlVzLEhBdaLIjlNdIe5tp5piSOjMYszINmEpsGjtxItA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fDrHo+0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JrthEQh9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0ETod838697;
	Mon, 15 Dec 2025 04:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=; b=
	fDrHo+0+zwUlWEMENtMJcqta2wwICzYcJdactwYVrI5WKpJr69aVX3bEjHsNdQIJ
	nRifVywuQhg6HhHLqlAVUbtkF08b7hCDkwPLvrB7aVez2sNeaN0wj9Use4i7noXj
	lg7cwzwpCLWPK8tFoJ/DaJgoeQNiD0rWd98LfdwTnlbWJ8V7sqU0VgdFRFdbPstn
	eAmvJWsUQtqUYa73NSwDM1Z5L6XBKXnRSWH0Q4352G6V7yeY5GoRXu0f6pFXO/ad
	K0qYtFklzEVWY9l85XkgrT7LX25lVipzj2nHcx2m6CdD0f8cJDZ0DzSlF7Y1TsQl
	TSO/6jfRQvXS+eX6gtbnIA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xqxsc8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF2hDbY022454;
	Mon, 15 Dec 2025 04:49:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkhgnj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvKceYflJDpg8b7gN2GBrY4ZrhcBcX62DP1KDUne9aLJ12F5/W/oZ3fwk7u2RFvton5rLvAIAGUnjKN0LNt+01OAKHpRunftz6A94xYe8eJkkAcr/x9+7U3b5M0FAdVtX4ZB+09Arnjf4u0wKYFXH4wRo3KAq1/gKdXzIZOenNzvUF4Xdtzz59rIOSc5vrXpmFaWvnA/kHy9kL9pmZI5X6bbKSJIzmaBinu2c34Iuzly+jSQwzzF4ypU+Aevp4ks8Fk35bgsXlCqI1i3ZiuPtPwxMLdyVUQTSnkNFZUo+pUAjKnG7MnhRkL90U4mM6PyHdWI5VlytYZDBk4V4p/yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=;
 b=tZQrt1PtzsGsPRuRLpFep7klpy1T/npU8hMikGLI+aTHw9MzsIhWJzt2r6ULPWHNSfp0N5cBO3IKPSocgWWCxzLURRN4MBiEo9OwLCb2R9RqdE1OjEJpjrMAwh8UtcKXCPlNZPxdOWgeK6bLCHrIiZF+mtoB100qYLU9mvxoTa+7ePMHNKThH/n0eYNcso+CBriVdrLxeAA2xwFJnSpYUM4pvMMe6rDkszsqc6lb3UdKj7Lj4WmwKdKEHvtinonuS/GiFAwsWMYm0CyijINhSR/UanZhgB81XFyiyVn7MitbmGRHYqn2iQ42wwH618VxlCP2+WdRY0c1yu3nO2+0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMjZEz5aiZfIfGl5mKdh/JccpF6VMdbqKJNqZrA6PTg=;
 b=JrthEQh9vqeBeK00Wa3A03XvsbAeScX6Z/xybI7X7k1gSqmmkKveZ6Cshtyuedto0bpUbWQVtILI536mLAutmj/bs+cuP5kTEQRkMQyTTNEcvYDNNWbRAe92mi5cB8WtkcHpwnunJHdugkw7HoWEIovBWT5//g3ye8phGJ3MZtY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:41 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 09/12] bpf/rqspinlock: switch check_timeout() to a clock interface
Date: Sun, 14 Dec 2025 20:49:16 -0800
Message-Id: <20251215044919.460086-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:303:16d::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4595f7-1d06-4d3a-c621-08de3b955c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KTtVsFRn7lXBlgflBEAix2OKCanA1S1tLtIDlwCNmis5y8z0dEuAsT9+sNSJ?=
 =?us-ascii?Q?MFi1GAhU2/h6H27nlO9E149dDqu8AzCfVUgIx6CIBV07zsuVHQtSyhn6s9+5?=
 =?us-ascii?Q?zKqeDl+YGJxp96r4Fc/QPilgQ9xCiwi+jZX3iApnrr8exppzOYEIWl81whLY?=
 =?us-ascii?Q?pKc4kvTq+RurZLyQRoOYpkFiIf4J2EP9Mw9YAgFknplYY8jAC54KsFfpvsL+?=
 =?us-ascii?Q?huh3ex6cQlewoqKI8Fs6VZivf3TxujNU7v3bx5+U+HP9L4SNo9mwSqf0Q7nd?=
 =?us-ascii?Q?KTvHalezgqODUxj7KeQlPiepuBVFCqk9aRlqHG5Yw2JOlnxBkE+ekrmZQU0W?=
 =?us-ascii?Q?A1X+E4koqWxw0yHBmCErHs7xMA1IEqoR2R40f5VzFRfMaBtWdD3/2jClMhjp?=
 =?us-ascii?Q?hcOUtGJ8Q9b+DTUBEEPmhgzfdFp5s6L2ODFjhEr2purN4RkZSXXO53Wd1pxl?=
 =?us-ascii?Q?c5p0rIWFen7xcUwooDdHrAQZCvLDTc7Nm3Uby9hsiPgRCYMTc5m0AanoUAPn?=
 =?us-ascii?Q?HKsqQhG5sqk4/ATE9YBP9WPz0eEB1dF9xX7qHy+1r8OGsxQX28D9y228m3gT?=
 =?us-ascii?Q?Ze3UTuRfT6bjbbdfcTEr4Q817tFf668G6O4bx3v+G5SFu8rzf0dyIGDoGjxh?=
 =?us-ascii?Q?lsDgFyIbFC053Xk1PuKOlWrE/h7aVvPDJHyGS04LVzDctlKm74T4W7+DUQoS?=
 =?us-ascii?Q?EadpH1/byQH9zZbPRU4bD5LT6AQ21CAHpYZ3ypaBuL5O879ljI6KWJTuUvbB?=
 =?us-ascii?Q?/wCrW3zbvlEwtyCQKPuv05MT+/MC0vF7zEjHYJebxFNUcqbjLn7/qUHn0fK4?=
 =?us-ascii?Q?Ha/psNjcX65YJ6EVv+vtNMMGBzwWsSn8rS2eTs6hP7R4zeDlc6muS6q2WXhn?=
 =?us-ascii?Q?pILlU4ppaT6oT5aLY8vb/QoZxLLpkLGLZ5jEB2KSMUOXEYRrqujy+H3uj7dL?=
 =?us-ascii?Q?PyGembHSaSoYgIzJZTsQP9Vu2gXDhXU6W28hALf75u9pdPi0O5a5V0bOWvU1?=
 =?us-ascii?Q?Q3OqAQboZW7sWQnlgj6FTT38uSV4196k0JqjoWln05mlQ/WLtU0UFgjVyw+Q?=
 =?us-ascii?Q?z7OEo82TLl8QWjUhx8ecRgKJJQGODAAXu//cMcbBEdY8deYDgTOXQw3cmW4q?=
 =?us-ascii?Q?tXD6X4xgj1qqwWPkJxUT/EPtEpkU29ZEToZFmTJ36r/wrLZx2fjm5yOPCojy?=
 =?us-ascii?Q?kD27YANUqLczhGgO+NYckJJf2486RRroWvYuWq1mT64n2X9v6Iz7wwZtybBX?=
 =?us-ascii?Q?M4KRB0oapAaHRp7BqOcoozN23cbomEnBZVHs971OXtgjVgeSZ7KELryre6Je?=
 =?us-ascii?Q?P4N/vL8vjv0H2cShzCUKsf5CBg45+1OfUlaFlEaZ2oboXreoFP5yR0HFQhaD?=
 =?us-ascii?Q?Pul8CqIbOj7EXDKf8O5vp1WKrbelb4o32dToyAqkI+/rjH+5G/KdFHwGuJDo?=
 =?us-ascii?Q?02EkIotDtbwoG9f8BZzw9uXyruVc6pCa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DIu74Oavn8mZyjaBwa2Vi1PfvokwqmEY8TjBwT4Z5RsFoVL/OimfOYywdkJ?=
 =?us-ascii?Q?ikrFX0b6CqvWWCwIl9Wk0emiwLR+VitG8IgxRx7qNn49mZ1/sv5Sy6E4B+ob?=
 =?us-ascii?Q?baGP/7FG8+eumNh4L7PG5vB5ypCT2ExPChEmpSXE6WHMVbELpEJqJoX+bRqq?=
 =?us-ascii?Q?akLRFVbc7LPOb4U6zxL9COfGacq3/HgrbyWIaFv8NTrGBzyscP2fFNSynrF9?=
 =?us-ascii?Q?tqbs7MskvXjetamyS3kahBzGuyf0TDS9txJhxFfIdFWU8tfFgwgX20dHaSLS?=
 =?us-ascii?Q?nURlDUY73fd5Cr1Asa7SmHEVaNME9w/MVdHf4SfKhC7whzZr8hKVBHaPfaEn?=
 =?us-ascii?Q?RVza3UV6nuAxWsmqKY+0xL2X9NVP1D1J05k40B7qEYIQNVuTCsVbtnqV9GAJ?=
 =?us-ascii?Q?z7g4ToZIIlhpRaZ5veXXLbxFr4uMdDxfjhsEmb0/6IyillODFudW02/Jh+/V?=
 =?us-ascii?Q?Xpvo8NfXDjjD3SGvnY5d4eQ74enHPOwzCXE1KSfax+4WY6gDdz869elYH98/?=
 =?us-ascii?Q?G9zeUuYLH8j6ADhdJJ32hChhbpC+yQKY4ozgSGs/7YglY2BWCi31oNuiiFws?=
 =?us-ascii?Q?PKvy5e84IXjNYD9l4ZgjXb9ysYFh/DPpjKDnvVhYOCtU4971SBfzjnCX3XqW?=
 =?us-ascii?Q?0Fmp2mY+ReyrL+wpOsF+pwl2XbxHGMzDuBYj/uxdaKvsvMuVzmGBJ4PhMQ8/?=
 =?us-ascii?Q?mHiKhN5cU4x+KnY1RvzeRBv1BSqLe3xLV7oGHQWM+1ApCY2hvP5sJtIt7be7?=
 =?us-ascii?Q?vOvsLohbROQkNaQ0IIlDDVj21lUggih0BNaYcT2B3Twk+a830mnwkI7kAmE0?=
 =?us-ascii?Q?tn02e3SEOaEcfH88PkAiBB7i0l8kUGeFBN2seWVZkxkjvwOgnZnZkRHizSt5?=
 =?us-ascii?Q?QlS5z8jVzhCQrRuHyShQNeCCP/Vy79v5X0WSFx/bMEpxrUbCdg73aKAtQMcg?=
 =?us-ascii?Q?UfmPVGZqy+Ehkq3GbybaA9GfMzKOPK4jLNZLyqWj2P2UiYG7JPHme1BJVfou?=
 =?us-ascii?Q?NLLSyaj5jCJJMLgZby38ONnNzePdjT5T7pDgZyusJave5VfJ2ZM7KwTXVrH1?=
 =?us-ascii?Q?u9mMe80gM+lZ5umMnABUNFwiNecPRF93ZIGifzSDuUNZFB7/tXQ09aVZcHHO?=
 =?us-ascii?Q?40gXPYeVLaSIZ/JogOhDfhTksdrPI+8Z3rQkP0RqVHktngnpQnrc6NI6wZfl?=
 =?us-ascii?Q?5sruX9inm4/f/bIKDrLAzUPXNOvWIa4Zd3RgIp85zKSR5KS2dmEnKTAr0GP4?=
 =?us-ascii?Q?9tp2hl5i6LMFvfzp0yPRhOf9ok1yLnaOc8EMaLAf+jIc8gUoiKI5Qg5rAlO0?=
 =?us-ascii?Q?F9xFAQel7Ctsuto2OT1kuFtw1TqNX1vvSPivkO385wQHL3yO2qRMm/DVo/mP?=
 =?us-ascii?Q?jPZSZRbzHNBP5SW2jj/TAyaWWPt1ZlwEq8Jy+Sy9QHgsQ6japb6+dgw8lWFo?=
 =?us-ascii?Q?CDeqHpzOpWS6yCYcmIiIvOV3Emeuov9bIZF8TgYk+kZO7XhtrOkCGa3ME/LK?=
 =?us-ascii?Q?HNgNyIvpyv1yjFqyvgmTj6HVgMdbcdJMzIa2Y/aUD+GNtZKY3LlALFwD/8mJ?=
 =?us-ascii?Q?lyDmRZB78VEvkMAvA6AYQIqNg4nOPAikP4E1mFNGbSN/mOLc0oYIgAMMTSv6?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kNcvAEFnTYa+mYqAZyJYEjC7Adp7b5fYUK1ScIYgLXf4zxYO68QZiXNYZnM2ivaEvO6f8ivn3EoNqqOnW6R6tSxFCFsyESDdz2FlcqQkJSsqlnejzDTPUzeyPL56wIPsMKvffp4rqUVzCIDFWDiKrcwv0uW+lh2J44QFkHIFXOghbsMB3DFo9qWb1xSYM0KDfA+tVVnSb5/OqAPhCUT08ZwYIDAgoUbsDPl7scRUSkBH6BEYDpvwbGUsMtYbLDzrhidsKgaOySeyl6+GHCJB/0RDZs3LIe0k5fRje1KR6TUtUVKbmit3O/YAM2RqrvAslq47zZF+Gc45pp8S2NACsrsknorbxSYimzWU62k4c2wPKazPSLaLXh8F8zmGh1+fe4eySknfm9MQ9ZihzIsbh6cSv+8rF6JWJcEpBqcaOsLskOZvnKNC6j/IUI+YPuXSgfospVTCGPS3hgZ5gq/e0nPMEYXAdiS1mS3x3YQm6prL8Z5PGZm0O9gRB8iISr1BNe+3djcrcmZ3dWoVC5FgcI8mOcj2pCqpOdZE729o5ZloiWG+vo8H47CvlcA2l0BtVqIRPJOFl9wMNhhxy3pAyAzzmsjIO2DxKlAEs0IhC9Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4595f7-1d06-4d3a-c621-08de3b955c31
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:41.7355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EI1fpaRRjkhBNQY0s+U7L2kEVrAWI63+I5UFe4N/3pw+QReHICZDOzody9U0jWcVAw73sgdoovwOLw86nX/zjtV/PhiFgqnKlQaywsJe3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX3EbIhEOJBCyn
 j9AwoTX21qsu9550VBI6xggh7TnM6bHaRaK/sKSH5jdah43yt6k35sj94wFptPk+lMC0RdqxMqW
 ILCPV0giOCy1KByLeZePzVjMdec2tiyw86gGYjar2vs8oMgzsyIoVNsn+E1pFmM3fJIAj8C9ppK
 OU17sPtG1O9CMh1G/I2Vm5RdQa7Dj/GQb4JQhXERpv+DPj2+n7KpFKnlVhbDRdSRyz0elZgdQ6x
 Uv2O7EF/sKD+WUciSV4f37lka0kP0y5aF0DsRxqAtcu0VTOZXxJ8h1tqeU7alMu4/TfBbR6geks
 t7+LAe4m6+O/+2XeGiwJ4gx9d5yzOaVz1oy1JNu6XrGGG1Dh52/AI55CjZ1Q8VRkL3Xf13PEQLB
 UcZyRKQ97Ktp8kY/wL/ogDddCh0aexfXJMK0kHix+YmpvKdSNlo=
X-Proofpoint-GUID: Wbl0mYGKtbPOPT5w_vj98Fuu7aWDbql6
X-Proofpoint-ORIG-GUID: Wbl0mYGKtbPOPT5w_vj98Fuu7aWDbql6
X-Authority-Analysis: v=2.4 cv=BYDVE7t2 c=1 sm=1 tr=0 ts=693f936a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=mCH88hr4Ii9tCPgkyJUA:9 cc=ntf awl=host:13654

check_timeout() gets the current time value and depending on how
much time has passed, checks for deadlock or times out, returning 0
or -errno on deadlock or timeout.

Switch this out to a clock style interface, where it functions as a
clock in the "lock-domain", returning the current time until a
deadlock or timeout occurs. Once a deadlock or timeout has occurred,
it stops functioning as a clock and returns error.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index f7d0c8d4644e..ac9b3572e42f 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -196,8 +196,12 @@ static noinline int check_deadlock_ABBA(rqspinlock_t *lock, u32 mask)
 	return 0;
 }
 
-static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
-				  struct rqspinlock_timeout *ts)
+/*
+ * Returns current monotonic time in ns on success or, negative errno
+ * value on failure due to timeout expiration or detection of deadlock.
+ */
+static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
+				   struct rqspinlock_timeout *ts)
 {
 	u64 prev = ts->cur;
 	u64 time;
@@ -207,7 +211,7 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 			return -EDEADLK;
 		ts->cur = ktime_get_mono_fast_ns();
 		ts->timeout_end = ts->cur + ts->duration;
-		return 0;
+		return (s64)ts->cur;
 	}
 
 	time = ktime_get_mono_fast_ns();
@@ -219,11 +223,15 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 	 * checks.
 	 */
 	if (prev + NSEC_PER_MSEC < time) {
+		int ret;
 		ts->cur = time;
-		return check_deadlock_ABBA(lock, mask);
+		ret = check_deadlock_ABBA(lock, mask);
+		if (ret)
+			return ret;
+
 	}
 
-	return 0;
+	return (s64)time;
 }
 
 /*
@@ -234,12 +242,12 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
-			(ret) = check_timeout((lock), (mask), &(ts)); \
+			(ret) = clock_deadlock((lock), (mask), &(ts));\
 		(ret);                                                \
 	})
 #else
 #define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
+	({ (ret) = clock_deadlock((lock), (mask), &(ts)); })
 #endif
 
 /*
@@ -261,7 +269,8 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 {
 	struct rqspinlock_timeout ts;
-	int val, ret = 0;
+	s64 ret = 0;
+	int val;
 
 	RES_INIT_TIMEOUT(ts);
 	/*
@@ -280,7 +289,7 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_t *lock)
 	val = atomic_read(&lock->val);
 
 	if (val || !atomic_try_cmpxchg(&lock->val, &val, 1)) {
-		if (RES_CHECK_TIMEOUT(ts, ret, ~0u))
+		if (RES_CHECK_TIMEOUT(ts, ret, ~0u) < 0)
 			goto out;
 		cpu_relax();
 		goto retry;
@@ -339,6 +348,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	struct rqspinlock_timeout ts;
+	s64 timeout_err = 0;
 	int idx, ret = 0;
 	u32 old, tail;
 
@@ -405,10 +415,10 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
 	}
 
-	if (ret) {
+	if (timeout_err < 0) {
 		/*
 		 * We waited for the locked bit to go back to 0, as the pending
 		 * waiter, but timed out. We need to clear the pending bit since
@@ -420,6 +430,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 		 */
 		clear_pending(lock);
 		lockevent_inc(rqspinlock_lock_timeout);
+		ret = timeout_err;
 		goto err_release_entry;
 	}
 
@@ -567,18 +578,19 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
 	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
+					   RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_PENDING_MASK) < 0);
 
 	/* Disable queue destruction when we detect deadlocks. */
-	if (ret == -EDEADLK) {
+	if (timeout_err == -EDEADLK) {
 		if (!next)
 			next = smp_cond_load_relaxed(&node->next, (VAL));
 		arch_mcs_spin_unlock_contended(&next->locked);
+		ret = timeout_err;
 		goto err_release_node;
 	}
 
 waitq_timeout:
-	if (ret) {
+	if (timeout_err < 0) {
 		/*
 		 * If the tail is still pointing to us, then we are the final waiter,
 		 * and are responsible for resetting the tail back to 0. Otherwise, if
@@ -608,6 +620,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 			WRITE_ONCE(next->locked, RES_TIMEOUT_VAL);
 		}
 		lockevent_inc(rqspinlock_lock_timeout);
+		ret = timeout_err;
 		goto err_release_node;
 	}
 
-- 
2.31.1


