Return-Path: <linux-arch+bounces-15407-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11ECBC87D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E45303EB8C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9F32142D;
	Mon, 15 Dec 2025 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rCJp6PFf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x3ZdQRxM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050921ADB7;
	Mon, 15 Dec 2025 04:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774536; cv=fail; b=k/hq+B9HTXaf3mdS1zhQIIhubc++k/YimP7ztsEf1rY7bLqYt2Ww8xR1HIoPdiEICKOpM9OyJCfxcIBpFc2LmMyI2oMVzddN7jHiy1oDnp9uMK5PDv3/0D2XE9qMgtEIUjuMjfcbX/qlZ9c6oekksKGyhV/Yt1cFEwGI+wRbyIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774536; c=relaxed/simple;
	bh=p25BgTRqqmZIgAhEdiM4weoEG+/iDOh/x9n1tqy47p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cpuef7diBX0Y/LnGFdM6qSOY2mbvT2M99FrFUWAtg7cU+M2aec3FnUuebzFz8qgo0ZDNxL4KKveoSSqc2brReR8P0tr1QvC0nI+gE2Vumczadjk3JRwu/hs2GhZ+1Xi0RAmK3RiQiboU6RCRTvfV8MrhEbMJouTbpniJpXURA7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rCJp6PFf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x3ZdQRxM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BELqWUI684400;
	Mon, 15 Dec 2025 04:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cCqAL2GyeeApNAaUVhmCQvyJ0JcaLx2c4UUacjypvIo=; b=
	rCJp6PFfuu2tLDoXmWmeFW6acLqeSVGh3nJcDkUQrVLY1Zb5K9ma+Sy3jdCMqAyh
	ZD4Tn7341ROlNU+oXdIZ6DnNGVs2fHiDXYqUtrK5OtH8DfIEhvzSjYZ9F/cHQjjM
	dFdDoPT7+GTtEd5t1HS2dFfGQP+l4Vv4Eb8/FhvDJAUPgFy8UpwlE3xy2JXbc+R9
	6hIbaIT2kW2dAQ+Gc9QnFB/7vaoUlWQsQLjd0LONCaeO8xtJ1jINu+biGsLn0EJz
	6hoBm6IVNWaEmGOQ7Y2B8fxfUA3ibDuqbQi7nfCUJ/kSkt2akdb1899VdlQouG3+
	pFJEJrRgDegqbst6Hh74VQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prhabw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF2arRv022456;
	Mon, 15 Dec 2025 04:49:53 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkhgnkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW8v0RQvlCsf7PcKXpPY5WCroIcFoPLMVeYTBq1VvGYu19YKiz1X9Z0/ddYjJmjV9ngllRFLS2Bp8H3eCkjvtoPY5P89Fn8tFdM3qijahU5tNzuzXRarl6vtpbWASB5lt22l9AF5YkqBpvfysKRHzn5V6uabqjBID9l2s+LgKvwRPWm1qjZxNqtUfP1bu7M7iRomotzyM6y+vOzm0M626ee+P9FNSXK7ddNfxXdNf0xEQFDqiTnEMEx34X1jNh3B+BdJgLH3eozD0h8taT4q+D4YDt/xv9Em3Japk+x1xfjBhRxRiVb6eOTNJYqCsjynriNlmuSsOvy/ASuq7Mes/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCqAL2GyeeApNAaUVhmCQvyJ0JcaLx2c4UUacjypvIo=;
 b=lxG1PwwehKbbSLfk+oPBpOPGwYAz+6aYgcfa9JOhJwanzcC8WoqGN8GBty/1m2VyyZAH/Pg8PNXFOj4wbwxHzuVOxdhUFyk06dGCEbEXyGxVdlfFw9wY9wNBvy4JeWmTvYOuRT6KyDLO1PEgCX05gXOCVD2KAoHE17A5Etc4zE/eRAxFboll0DGBH6rwXBhDN+0yiaSDJ7ESXt2aGJ3SUZVtmkGiCL+ZCZ7qZA+Sg1kOQIv4rkantoRKrUcweBlcrqNo2VhTLR3TvG89j57Vif7vvRJ7KA5JdTHf9tpn7dxdZMEcMwZHo3IZVQRzG3409mGpEta91OTSd9nEMTWhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCqAL2GyeeApNAaUVhmCQvyJ0JcaLx2c4UUacjypvIo=;
 b=x3ZdQRxMD1Dq3I/inpb3H6nZi2a/zgi2YNauVxq79CPwb7ExnBGx/cpkjuA6xYgWmsKvmu69JbVYx/UILbx1AZg7+s2eluU6hj1y4RB1S+DM0sIjO3BBxj/fuFOoDfNGSjF/2OC3cSQVT2pLJswljkaZ2vaOqsjl5mzL7eF9dQA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:50 +0000
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
Subject: [PATCH v8 12/12] cpuidle/poll_state: Wait for need-resched via tif_need_resched_relaxed_wait()
Date: Sun, 14 Dec 2025 20:49:19 -0800
Message-Id: <20251215044919.460086-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d26a71-2111-40c0-e73b-08de3b956141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESJdPrOqItbU1aUqqFhn0IsVngHbpG0Ca1fkfeFNHbduhZtlkFNxGTfJxcvb?=
 =?us-ascii?Q?yG25s7HrMERpG9JdrjObei9ThvPcM/N4Z6Aaylq/mEXEQEtBO1iWQ1SXwCB8?=
 =?us-ascii?Q?HcQzkuffoNkBpQedpRBGbrJ5MUW6LAu6pR5c/XpLOEAT5vK0uboYhFL+GKWu?=
 =?us-ascii?Q?L9MZMqpSQ8RhfWM0ldpQQ0vnsa/au5gnXSNyXPJ8n4jYA4frDQa0k2wQ27rA?=
 =?us-ascii?Q?zh6guwg8tMFpmzGUy9Ck+hJjfmO0/MhJZ6g0RfcBe1+/ExaXjMyvrNAVmQlv?=
 =?us-ascii?Q?jhcz2LcE/Ef2jLiZ4xLeWY9nT2Q+2nwogxqQRdjIzqi6G3zzj1Kh5brbYT1R?=
 =?us-ascii?Q?6S9qlEMopNLsXwSrachdOn+Qa5OIGcmMTcpf6MD83nN9pyH6Cva+DYUpmw8j?=
 =?us-ascii?Q?kK7K1pd43MPe3N9rv14OPCHOSnWL8Lw3HjysTbgwIHnuY2CBHgog47/SQdM+?=
 =?us-ascii?Q?L4Uk9QDo1uGdLvceGzskUmhx+ng5BtmI6/fHCYw8QiFsUA2bPasQuUrPD0SX?=
 =?us-ascii?Q?ughizanEvytymr0hdlBiQ5d7LCANg4xDO8446OdgyT0vz9yZVq+m2JwxVXT/?=
 =?us-ascii?Q?p+XmVLEb0ZE9AIR4yV7H+3d979d6s0b5C2eUwBXFa5z3B5xpsQoDGg3YQbPp?=
 =?us-ascii?Q?OK3Lac/S6qcDYnzuyMVHDY1U3eAqQUK/wJx3nHCRmWNw8wqbpWJWaW9gEkev?=
 =?us-ascii?Q?7569LVFIjMCXjM/n00+5jHHIu7CJU1K0rQzOvSUzegyzc2sCopwpbbnDmUip?=
 =?us-ascii?Q?DTlQXPS1tM+LjWGnQlu/drVDPMeBg23CqOZjId2/qSNtqeISH1q+k5wm3PzE?=
 =?us-ascii?Q?zPzK26bnHI5GxLqAcGAt6erfR/jOcCumvKQio3mINqDaoB+bL61MK4lvOaVn?=
 =?us-ascii?Q?MEZiSFRRGjXPnhZd6TI+/wF0bKu3l6FeciR/VpFBAO/GQF2M6meMT4TRCI0Y?=
 =?us-ascii?Q?4SJDdhbfETBBhmhgdLUTl/RnvVqy8qhLdbWPjzAhNvSPo6vfXFiOVB0V22AZ?=
 =?us-ascii?Q?IGi18XtFwjNEl33PfCNtaEAj3D8hNvgrB9zcF/c+5NVKzxLCwebpzD3cbF3e?=
 =?us-ascii?Q?Rf34ms8bUrbEKjAq6pcKVf/zaLSkp8fKxid/JSv5x8CcJzE6S/wQ6/BFsig2?=
 =?us-ascii?Q?VJU7X/is2qgs+pe2sO+0+3WCOPq6j3VND6ljv/2Jsf7t87HMg8fu7Iu94/2B?=
 =?us-ascii?Q?b5qqPsJtu23b14NOqW6VRYg5d9iywbsLpAvhhLJAs9N3vhDDz8tJeOrmVyTZ?=
 =?us-ascii?Q?ZYz+9luY9GRD88FNsWhDkLZVtOawP5UCPDHlqsSdtoJf1gPPy/+szkwaPY8l?=
 =?us-ascii?Q?B9pdRJcn/pwaHRuFe2gJRup6BRqnms8ZqLgUd8/D1GG9/OIpA0jecXJ5YqVE?=
 =?us-ascii?Q?Lqo5eKqSOLAoqrrzKIxUXDOtpDWlj85UHE+fLRRzvfaxz0pmsGqNvJQej55x?=
 =?us-ascii?Q?VBwPftwSYoNIaRnnLYRyvEy76QGBWYzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZ8LRLd50ysJImfQ0Qa/Ql8+QBU59AVe8EZTg0GnMVZ+wvcDGkk0I0PlXK8N?=
 =?us-ascii?Q?QyxuwOqt2q9pLGrbSExwDY05+Y5JLJJ118WNzqhSggWrvwusMe2mGwNZI7C5?=
 =?us-ascii?Q?byaI9cuKmgP1GqOULY6+nlPrCQcCYDYmMaIqZCLDXo4poKjidNyd5/cBI6Co?=
 =?us-ascii?Q?ww6ZS+Wl2CoO3PDxhmEDzamOED2HWFG7IAbLcHNePq7yayKqTwJqzH4pLdgb?=
 =?us-ascii?Q?x/Kl9xw6GKr4Tr+Tl5KxAfz5mtSOhvBF+xLZWtR/TfAAbzlvSShVfYI6BLim?=
 =?us-ascii?Q?wEdEOOBy92yAj0LHQ6beaMogFA35NCTpkTShceF7Os12l0efMnW23sxxs1Fm?=
 =?us-ascii?Q?nWbViZL+wYPxVawPqZeTxMhVKsCAQNMby4EFb8gpLj8P4sMQlcc2t4DZiX1f?=
 =?us-ascii?Q?JhRJlAK+bVGNJByYv31+f+d4V1n41rn3+112FkDUhJc8d26qz8hieo1rVJnt?=
 =?us-ascii?Q?sNlg1A/3oi8XHo1W6rsRnzksDpQG3VDkOBrAbzvOZ3IYlHjugy41sekGDwCu?=
 =?us-ascii?Q?B04K9Cu/Oz5HSrhqeLnafvB+8cvp9G2JxTtRnzTbehaf+f3CxjDSYMwNuNG3?=
 =?us-ascii?Q?J/QPITkpZMI/eMSVZlwLerMvsxrh8tvdgdgBLBVW+D7MqgRFtVD9vRZZitIP?=
 =?us-ascii?Q?507wG9ME1Es+ImekO7aqfuugFxVbQqmqx8aWjlTEzKHXZGidiWPOyEOw3YeT?=
 =?us-ascii?Q?FRj54ikjd8l3EEvvsbfm3iURLlgMmQKKzSt/pAVVvfgkIpHcnBsr8HEfUsQ1?=
 =?us-ascii?Q?vRfqOrnNv6RZZY65nXyqBt7FaBEE8XpbaY1dy5gc9hZacY//pM9QD5Dl4Gyd?=
 =?us-ascii?Q?8DkACptcnap0MbKtVqAREROqlb/Uw2BoKnqP1CeoBA4ZTW8lm+j5fYLQmk/a?=
 =?us-ascii?Q?vQ732soojQY+fG4ToCRxZjwu/O31FfV3+G4Hxv+/JumXaT/FFn3imcC1hTXp?=
 =?us-ascii?Q?ZzCBTu4EWKD5DleNd6BsF1vKMTgw6W2tzfAmQ4P+D/GTAj5BeStv/fRAd/M6?=
 =?us-ascii?Q?H95Hnu+JO/b5iAOz2UT1JyAY4y8mPtyaP7tGuMfHR6b4AKnWFvex9onKSGn1?=
 =?us-ascii?Q?xFQqbBVu16B5RxkQDEJt3ki2LbFetdiJXFUyFjYZiW33ENraiqeWimIN9Qt9?=
 =?us-ascii?Q?5BswH/1wUYnYAW+M770hzR52C1eJgHoZr8Y/zaHAdx46VOfeyGmnuOn0a04A?=
 =?us-ascii?Q?NSXGUF0suex9sLuuR/EC/Y5FW9jJB0wufNctV18HbrgeTkkwTRZdDlGO1wMH?=
 =?us-ascii?Q?clFfM040bLaNSaONZH9HY6JE890hWWoLn3l2RfNzzxWQ6GzlC8PUq1PiPZNK?=
 =?us-ascii?Q?e04jemMdtA7uYfRADhP12fa9wuwwtVfvRKX0HaPWpogmtlzAPmkb5xBPjDEI?=
 =?us-ascii?Q?rNLTiFQ9M1QRH52Fqeb8tId3epb59knqLX6p6X5DZTbnJHmx/qoBVnfl7lhC?=
 =?us-ascii?Q?tW3a5Mwkd5cY8TGTkTfuSYH4bMclLdlAZPWpQRt9rzlRXznlyhhrqNGymnrM?=
 =?us-ascii?Q?aOgIG1JcCha/wW8+y0wLgr8U2D3/0mjVaprtwKuElqo7ruFwbA2gbp1URrxT?=
 =?us-ascii?Q?SRHfSUuxkB1Dt5e/pAopFKj+tSQ4nyrKzLup8ltsYZtG24mCJw1yTKmlYxyn?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LxuoJm1RujgMxX1mEIEPiHyL16re0dwjYtBC7aS2fWz0JXP4kvLcVKir65vWkOWADcv7G/2boY6ujn/jh+acXZLdW24E0utvqhbl5DDkf2VK42LAjh3Mma89RCqa71CCP1HP+0zIH/XH5GN7GIV036VqeMNiWRPdyCl3YabVsrH9jh1buKVNfAlEpd1DVsdaHsrEVIKcP/LRqha1oZ+EPRyO+AJkxNZ/KtdUt2cpziyULPwZLGg8kjK6Il2TDeQzmI2zAmsXa0aLALiEO0GWGS92Cex0TSP7gCDXWFw2U9TvmlzZSVs/ifeEM5Oez/zbsVIw+P8+N6syWnlXyWytz8hD6F4CFubrelaRp54tnBjkBdmeZqhzpOxbD7scGVhwM8we+KcFaAZvHx9idjDvaG86BFDbEzFWqHcQIFSuqAWNCA+Qj2fNV8Q9cngkHWSnc2yGssh3ywGOAW//Z/DmGe7o5H43tCBeEzLPDP4waQjD4cb4PZbkiECKgeWyQOB6CdR/5yw46eqRjWwC9cbNAAgXpwm6IpVoaNbpPPblRLLoflMojNF6YD8e3iRYPllbfjCsV+hzJ/2Y7CBLCkl8NxHRpXrYIA5fQXTfWVff3ug=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d26a71-2111-40c0-e73b-08de3b956141
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:50.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8Sl6FLjjhAtYK/X8KpCRKFZGB8kQa5sKduuapyh7RcJWExSOfNp1K0ZNDufRxzTfDO8KfsSXLI+LJiarLl3xCLruEmlmdKPEFBl1wMOFnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfXzHEQyj35VKru
 zThUXff1Cq1DpGVU5LmUaGv/T9zTtHd+bem37X4k3MIWOGwySAlbSWqvhOdksXULWzWvHWAUk1v
 8vLtNVR6dovtZTn/4NiVTsQi/P3km8Ex0byowjpXH8U8Q+bnTeD1uX8hiEowGXjwljrjA11HnQA
 BSeL5bucRbKG/8IzdIcJfYI78zwJqA4nuLEQkoYKVbnL87SpOpdAwz1aJBQiVrc73qTuYB0eGVF
 XxEl4xAyIYlT0r5xcIYMpuSqfhCWIx++9LvJEexq4li2qSMWOyJlODH7ogCAXzVQWOCd3OFhuai
 UsNk0jswelOrtM8vG36Wr+vFRMiZqKX155JVXzzfxI/9YZRMSloWxETrz7/b90ugRavSQacm6cE
 n1cjRsQEA8J7hczMD9MBqNjnWdONPGzRAoHL6mUlMY6JSn3j8Sg=
X-Proofpoint-GUID: mLls0DN2dXGDEtnVqEX3a21iKO2yWhdI
X-Proofpoint-ORIG-GUID: mLls0DN2dXGDEtnVqEX3a21iKO2yWhdI
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=693f9372 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=OvgspRp6jwyVCtadSW8A:9 a=cvBusfyB2V15izCimMoJ:22 cc=ntf
 awl=host:13654

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is rate-limited. In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

Switch over to tif_need_resched_relaxed_wait() instead, since that
provides exactly that.

However, given that when running in idle we want to minimize our power
consumption, continue to depend on CONFIG_ARCH_HAS_CPU_RELAX as that
serves as an indicator that the platform supports an optimized version
of tif_need_resched_relaxed_wait() (via
smp_cond_load_acquire_timeout()).

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:
  - use tif_need_resched_relaxed_wait() instead of
    smp_cond_load_relaxed_timeout()

 drivers/cpuidle/poll_state.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index c7524e4c522a..20136b3a08c2 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -6,41 +6,24 @@
 #include <linux/cpuidle.h>
 #include <linux/export.h>
 #include <linux/irqflags.h>
-#include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 #include <linux/sprintf.h>
 #include <linux/types.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
-
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
+		s64 limit;
+		bool nr_set;
 
-		limit = cpuidle_poll_time(drv, dev);
+		limit = (s64)cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		nr_set = tif_need_resched_relaxed_wait(limit);
+		dev->poll_time_limit = !nr_set;
 	}
 	raw_local_irq_disable();
 
-- 
2.31.1


