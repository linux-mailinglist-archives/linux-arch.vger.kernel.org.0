Return-Path: <linux-arch+bounces-8418-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DA9AA1A8
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 14:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AF1282414
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 12:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F7199252;
	Tue, 22 Oct 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TbFxwk+K";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TbFxwk+K"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC394155352
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598528; cv=fail; b=uCREsd8nw6AeCwufra7vnHd3yk1lQIztpezxeFRgJjn0ADYWSQkLgFl3ossqva082vrn8DHB1Dh4VCYgXWW05pNOZnxme6uNNwgUs3JUyjbNs1oB/keYJUF0ttwbonp9IOiYyfdJtp5H/xli9XCOs2oX6GeIkLFSLcPWyjpYsfI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598528; c=relaxed/simple;
	bh=mTS1ds6E477qKFBshkhwXfosYIpANrJKrWWXl1Th8vA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t/CcxpAzZwtYpVEIAB0hUzs36ULjM4lYotuO+Oq3avEeJIN9P4lFf0N6Rvwb4Mlyy33andosyqQibQ5emAqtMcx2d6LmTLhosdiOt4IDy7vEzOFYWSfg/2/UQGo5L+6tfVOzxC8Dbw7A1yJ1W8v6QZHyIqsMzqxRgFGBG0x2PoE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TbFxwk+K; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TbFxwk+K; arc=fail smtp.client-ip=40.107.249.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vvL0tqK3AkTvziP+gKhGn1NBaDo6qS4wgR4bnoKzhz0vApQ+Z9Yec0+OlcWQVasX5f99Jm1zk6070F8cNvIeJ8Q6A91ng/0V8w8oJPAGBs3Dlxy/uHzdOH8KAcx6sHBQWT8/t9F6MXDbBmdiET4G1RYB3xTmv5ftfHeE2N+WJC6vk4vCNtzIjTYJthaCxQOhW47ujJ3o8dMx1/GWn2F9XXPsgx0ADlCVwHGKfvGUbP7tNu4O47Vwf015xF8hJIrXSRxG9xNiAtbGrdryrxhRgo+Wkfipscjsi24ay13g1nKLelYrVbqdcEXrp4SdPAxerlqjNxEpPDxH2Yduzt1irA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb6TS7jv5tJ4sSxyzafVBNIDDzYFRWoAqgggOUKcfzY=;
 b=hnd+4gzOr4kFzEi3f9xV1xosG3cUE0gM9JS+La9y9CI+MqnFnvDZgOAr/b+Y0U33hgVWPUKdT++ymM/MAnZjTOrsAcv3n1p425WrpmKoEgju1gTO2H63+9Egu3mGRc6yqSFAsKzA7RP/nHBNg/uhNw5oHP+Zrs/RI1zKPHXHXmoYbzMRXB6KNd4K8RJbonvb2+Fh/tl22pg/bYNdM+tLPefyZuSkx2g8+CKM2g3OSs1TJS6vOyElepNrKaT5vC86FsKQpynwQVQcvNcZIZNnWeGQDNl+9HU/9wQ6bh6MjcbGoVx8YpYdH7zZrrpVA0EuO8rWJn025VNr3pe4QJ6RqA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb6TS7jv5tJ4sSxyzafVBNIDDzYFRWoAqgggOUKcfzY=;
 b=TbFxwk+KlvauKZxp+g2t9gJnWgOP7eJeGiwnV3pkA+DKeMkOC7JQVPQ0qiOHJKUrGCj8sQdzlyc2nJZS6R+FfaMKl9+ws2fDw8QKCEjflLXYL+QbED8cJqV3aaAgcvFNR6l9uNXTBe4tph1Q2dXcP+K3rPwnZgYebMrWoCKdAxk=
Received: from AS4P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::11)
 by AM8PR08MB6353.eurprd08.prod.outlook.com (2603:10a6:20b:361::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 12:02:00 +0000
Received: from AMS0EPF000001AD.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::68) by AS4P190CA0002.outlook.office365.com
 (2603:10a6:20b:5de::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 12:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AD.mail.protection.outlook.com (10.167.16.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Tue, 22 Oct 2024 12:01:59 +0000
Received: ("Tessian outbound 60a4253641a2:v473"); Tue, 22 Oct 2024 12:01:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b525f72f202387a
X-TessianGatewayMetadata: oYB7o3/9jRXgDp7WWN+Zfqc3lihk4hqEO77jdmNElVoHVrnIGs+a2Pvs40Mdj5q2R9p7NkK59NU+r32iDJ3XLJbFJpd2C+M2PTsKg433rUoOceoejb234fMkZMVUU4tKRMNEdaulL5GU3m0VM6MhiaYcWEF3LDyxveWVrup7k2Y=
X-CR-MTA-TID: 64aa7808
Received: from Lee9e6f087337.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2AEA317F-683B-4DF8-8046-EB90D7707D61.1;
	Tue, 22 Oct 2024 12:01:52 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Lee9e6f087337.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Oct 2024 12:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IojIY00bIzuZLcrI4ZaN4818SVycOfXlr/SamYp0h7V6JC+O6u9jVXrO+mO+BzWRLXqPVlEX7goiO0Bxab2Qa8QfXYhuzhhuqPBkFpp9bckaiwSo+y4T0TLDbSS8k0eHexV/dl8gtGRV38YI5WncLH9MgLd4ElI/V/iKBPeroxU/uGk79pJK7tBnLSPFLnPW8YXGutpglV18Hv089Wmoi6i60otxMY+V5e4Pg264JGxnyikuKAIxwIit/geKLZnhmw8jPMPblJYhDe+tVX3sFn+tfwTHO0YWI0XCka8ufiV9X5v28RfWUI5bAYKg34CjqKhnM1JIdshppbz2RfgjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb6TS7jv5tJ4sSxyzafVBNIDDzYFRWoAqgggOUKcfzY=;
 b=uiT4W4/F/ozWCFknl5C817NWRcosO5Ei85hZAwLVFQcUYMa1HmWxCvU53EHyOgXOVusD3Vw6sGyElh+6QQWhu6rO7NWDs/tncjPYjhvi+jFCVdWIiKW5psbvCBobOmXl2VWraTcgeMpwsIfzTCLjyc9LsNSnIfWNxW9kRlllKdzpXouly76VbE+j8MYgF44te2kMWZqt0geforSAfNqQGLLKSkgHhDvwc8CMV13XQjxXQN3mH2fO8c8ZssC1qescDFtZSS3Wku8XCeF5vl5iJPMmdxftmy1bVs9S155/nrt134nc2FaDaiioNYbtGW2NVWjaSh1l1tHlUwnEnwJ6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb6TS7jv5tJ4sSxyzafVBNIDDzYFRWoAqgggOUKcfzY=;
 b=TbFxwk+KlvauKZxp+g2t9gJnWgOP7eJeGiwnV3pkA+DKeMkOC7JQVPQ0qiOHJKUrGCj8sQdzlyc2nJZS6R+FfaMKl9+ws2fDw8QKCEjflLXYL+QbED8cJqV3aaAgcvFNR6l9uNXTBe4tph1Q2dXcP+K3rPwnZgYebMrWoCKdAxk=
Received: from AM0PR01CA0161.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::30) by PAXPR08MB7443.eurprd08.prod.outlook.com
 (2603:10a6:102:2b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 12:01:48 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:208:aa:cafe::75) by AM0PR01CA0161.outlook.office365.com
 (2603:10a6:208:aa::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 12:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 12:01:48 +0000
Received: from AZ-NEU-EX04.Arm.com (10.251.24.32) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 12:01:38 +0000
Received: from udebian.localdomain (10.1.28.136) by mail.arm.com
 (10.251.24.32) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 12:01:38 +0000
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: <linux-arch@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
	"Joey Gouly" <joey.gouly@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<nd@arm.com>, Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH] mm/pkey: Add PKEY_UNRESTRICTED macro
Date: Tue, 22 Oct 2024 13:01:28 +0100
Message-ID: <20241022120128.359652-1-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	AMS1EPF00000044:EE_|PAXPR08MB7443:EE_|AMS0EPF000001AD:EE_|AM8PR08MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f72fe-837b-426f-fb96-08dcf2915591
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?DGYxJOKH90h+klYQHUu1FjPw51MxaniN55qslPGSeQkOrMfwXvztxVeyx8gN?=
 =?us-ascii?Q?T5gwv05/4BIpfZ7ajAMPe8uFiBPWu29yoqsFSH258MkRBrajFO2F/+cPUHcm?=
 =?us-ascii?Q?2/AMnpZQp4aS73sEOiU0JG0CUu3f0E2XLNh2R0pK0bMOVflxLBEQ+bUVOmQ6?=
 =?us-ascii?Q?ywQ6pNrB5fhjihoahvWOb9E1CcZsl08X01GvuohupPqGH8uhnMOrjpjUBfMl?=
 =?us-ascii?Q?DhYQmbPnndrpCy0b1Kd85SxB8gQt1b3ALURPPSYgnX71FfczbToCa179pf/A?=
 =?us-ascii?Q?NVeAhg5mvDkWxTm3qoS7pwMbjyN2EKg9Yy8k1+DW7R6aEZ2GpPQVQ7QNnhA6?=
 =?us-ascii?Q?wsVExIYzr4DzEjfcxIFyxGF0iILhHYs9/Y64B0wzywr9tL2cKSQaeRyevCFw?=
 =?us-ascii?Q?6TFvnONPIHNtZ62WdBekxnj9xZ7p2VdVd5dsd4x7ZOFsZpRW7zJuMRXrGX0y?=
 =?us-ascii?Q?hXGG992pby/eldOwHnERqQbmyTG+iM8VzaPZ8X+NmggzMt4Uxfu1dpj+mLXm?=
 =?us-ascii?Q?sSIQoiSICLe5mW/QX6YfJuNGmvlDqxR4cNJILcENiRyjeXO9lE16wycNe6QP?=
 =?us-ascii?Q?uN/YFKVdzJPnbjftY2Rbeej06+XegkRC/Jsll4tq7ScB2CoGaTyzjZo4hIPB?=
 =?us-ascii?Q?+45FeiwhI0h/E5BpMSzgrefye47zcD9TYjcnSkSXggFo0FfbRgAGIQn0mjim?=
 =?us-ascii?Q?u77dlChoKvS6V/sRHPYMkAWeB2JXhsoIyzm/kZVXGvR9hC1q4WWGxP0y9wQv?=
 =?us-ascii?Q?6eIyajyQ3AZCdS+jKwoiEKQ5zx+Uf5YMQ8EHktctnO1BWdM9OaeE6HheH9Xn?=
 =?us-ascii?Q?DjYuX6o1y+uLkPuPeQmbepgIWWmoViIvenKlJUeAJQ8bg6aiXxGYx8iYKpNc?=
 =?us-ascii?Q?Tyha7p0yfv1SAhuiJr0fQai2rXhRxRMqQa93KYpPVkndYE214X+9DIm4hnU4?=
 =?us-ascii?Q?KueVAVU5Sp+1BjjDOBa1AsEH7QM9a71Q9qla70Gq+YAP4v6xApIEQcr/gvff?=
 =?us-ascii?Q?LIQn54Hc7ewrbrMpiaTkBl++X7bq7UzBgi/pgQ3t5aKKE7CpGCFDOaSOhuNb?=
 =?us-ascii?Q?im5Hwoo1JV+IUEiRpSE5A+HY5z31wmBWjrAf77moLgOTh6wU4ObQNlSQGhAg?=
 =?us-ascii?Q?amxGQirueuQL3I1S/CJm6Kw/x9+P7DLv+2bVNrrHxRjR9xpAyYa/DGiZvi4J?=
 =?us-ascii?Q?1XHirg4LJ5gJRsdq2x19aZSq0aC497JNdQx3aCD05QJcFZXC2pdaffrFe/uE?=
 =?us-ascii?Q?ESGrfEfnG2OPQSoI7snraw2oyRFaeMMiJ1+L5ZFjz1NqOAdsF7OSSFfczOlp?=
 =?us-ascii?Q?qvWOkw/K/ySjONur1GLAK6UKSXweWPzqXg8wflbbRLGzCYamOzE400YvqkiL?=
 =?us-ascii?Q?FphJoQQyACJmT5ZpwKSe56U/rrSMuApn3aHm/s9/V4jwE3cXnftzKpWXxtBG?=
 =?us-ascii?Q?o8j11dHkTjI=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7443
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:208:aa::30];domain=AM0PR01CA0161.eurprd01.prod.exchangelabs.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c2a7ae91-b055-4cb9-861b-08dcf2914e7b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|35042699022|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?foKj7nw5ksSPb1Cmy2j1BZQ1ZDFxdwZYlP4EYndY6MVow0d1OkSEGuxm38M6?=
 =?us-ascii?Q?v0u3LMmkVKJN5TYk3ySoDJxsMEeqywb8/PrzBCOOtuwXkcTFtJaX0WvAiAWu?=
 =?us-ascii?Q?UKMca9Si9d+lNqWQh0kLfIDiu7Ff24kfYGdYBkIFTjc6H2M2m4TGkqnQqGqo?=
 =?us-ascii?Q?00mxrrgf67r6zVDWtICt3CbQbDdcDl3J4wrC5g9s7LG1hLTq3bG95CMLuezA?=
 =?us-ascii?Q?1zScCkajskFTwviHTBlDqkEWhSya13Zd1uFvBiQQs4LOy2Tu7AiVel+/sWdr?=
 =?us-ascii?Q?jqRCuGgNNNWQtO7ZBWJN7CO64CPIlaEqiylsqnsdWyBrZ6bECt1top/rGS9e?=
 =?us-ascii?Q?9bywTK7wOYVJw/OHNNkisqOzwysFvUIm7KyZ5fvnX8ifTj2+riTL5lctKHHF?=
 =?us-ascii?Q?Ga2YnDUFFjV8h26yu68gk3Xa2vx9B5QHkACqXhEJeEfQlzMeLk7cf+FHpXzv?=
 =?us-ascii?Q?qSEUenZkgtAhfOrkpVlK752wYG+lGCrZL9WU/Tlbslguver14G3K4HbYTFzK?=
 =?us-ascii?Q?izEwwK23SDYTqUoNyxk1K7mm2fSnMOyfrJK/WAadH5Yk0EvwgR6Q8IbUy2ke?=
 =?us-ascii?Q?Wj26MHQ0FWzmHJ/NsN0b3VQKBKnwEidB+B7KQ3xktDeMkRf/Qsx+/CUb/FMS?=
 =?us-ascii?Q?/7rHmgzcVLT5TbpDZYtfW50YegD2rnVSkx8y3DFxuf0WKeVbblh7KbB24Omz?=
 =?us-ascii?Q?hdL1UzTauUFHCFIyR1Uwh8HEemNaKBfWzt3/MTBsu+SGFNem+26txNOfNOlv?=
 =?us-ascii?Q?YhasxwSbZA1SZ/YZeEc9Vo6pWJAIatWkxIgnp2yaQXuiEfwB4SYwAWk8DnGY?=
 =?us-ascii?Q?cP6oHKILSmjmtu9ZQ9ZmfqsZkTviMxAYnui4clDev8z1wHCTJ3hpaM5XFnt5?=
 =?us-ascii?Q?KIFQCPw68Epv7Tbo1SQqf4zuPLO9al9F8w07JXlsYJrAhMKa/uZ40GKNXcNc?=
 =?us-ascii?Q?XgKmIW7Xr5rHPgRZYOcXDTdZitQ7eS3kH9C2PD77radjXRNRTG8ji+C43EwZ?=
 =?us-ascii?Q?0mK44tdxcSK7H84Fs3s3EH7jIe9khR/nVztgx54xHUc3LQbMWmXUgyM4mRZP?=
 =?us-ascii?Q?UE4VNM0vEhHdJ3d4caN7iTDuHHq+3isiB1ENpYnmLBPl9mgeSwv9HakvtcTt?=
 =?us-ascii?Q?H0p//mgnEsCsp82syrJOALnUwIDLhTZGnUgOEVjRQf1GkQA6jntszlcwCldb?=
 =?us-ascii?Q?XIpmQKAKITwmFX5602uOptIjNAq42utfLED+HB5dbYRwQtKb6qe38E2UABXw?=
 =?us-ascii?Q?1pzIUoBCIwskk3OS0fttXrtBlMQkIJyaIhCh5VPYzVAcLXhZ2fpnPOCMpRw2?=
 =?us-ascii?Q?4T2dttebmdzaf6e/GfoGCAGPSvzv5pKQgI61TrbEzjzwa14M1nh47pwdMhZS?=
 =?us-ascii?Q?Mlx2YG1H+3yB2I6r4zPXSSj7tMpV+fCimiFmPpJXSdLMGY9ocLMCAc2wG80A?=
 =?us-ascii?Q?GVijXUgcekM=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(35042699022)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:01:59.9109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f72fe-837b-426f-fb96-08dcf2915591
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6353

Memory protection keys (pkeys) uapi previously used two macros:

 - PKEY_DISABLE_ACCESS 0x1
 - PKEY_DISABLE_WRITE  0x2

with implicit literal value of 0x0 that means "unrestricted". Code that
works with pkeys has to use this literal value when implying that a pkey
imposes no restrictions. This may reduce readability because 0 can be
written in various ways (e.g. 0x0 or 0) and also because 0 in the context
of pkeys can be mistaken for "no permissions" (akin PROT_NONE) while it
actually means "no restrictions". This is important because pkeys are
oftentimes used near mprotect() that uses PROT_ macros.

This patch adds PKEY_UNRESTRICTED macro defined as 0x0.

---
Applies to 42f7652d3eb5 (tag: v6.12-rc4).

For context, this change will also allow for more consistent update of the
Glibc manual [1] which in turn will help with introducing memory protection
keys on AArch64 targets [2].

[1] https://inbox.sourceware.org/libc-alpha/20241022073837.151355-1-yury.khrustalev@arm.com/
[2] https://inbox.sourceware.org/libc-alpha/20241011153614.3189334-1-yury.khrustalev@arm.com/

Is this patch OK?

Kind regards,
Yury

---
 include/uapi/asm-generic/mman-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..ea40e27e6dea 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -82,6 +82,7 @@
 /* compatibility flags */
 #define MAP_FILE	0
 
+#define PKEY_UNRESTRICTED	0x0
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-- 
2.39.5


