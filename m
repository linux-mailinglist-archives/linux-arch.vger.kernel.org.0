Return-Path: <linux-arch+bounces-12061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5D3ABFC67
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 19:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F616DEFB
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB3233151;
	Wed, 21 May 2025 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtUSCHMZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y78wPVu3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68882261588;
	Wed, 21 May 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849224; cv=fail; b=r0wn5CfGLq6OZwwFyWGIaono1iwVosPmr9tDCc2eFX3nQSV5bhU0YVBcCZ+tIlVnk/6eXFzp2IlkgHW7ACyT6pxwXhSUo1NfhA5lh5Qdae2ANUmi5I7OwJgBJcyBzLLtfKzlD7lB8F29yyLgcyX17wSFceh8CSFBSEcR/lGhVnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849224; c=relaxed/simple;
	bh=eGkG2taeDZ4YzMChYbZtQuXK0e9PUPcemMOcJQ14ros=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mj5GbIGZDSVWdZwwRQj6fAuvLV8ryNbY4iZtqCcfpIhiHGK0JeluzHzgr3GpSRL9qUjKgf9BNwEacap4JP0wqOv9mJDRZXx2YOig+buAPN6FAmwg7Q6NZxxTxt1wfaAT0/+EHwaXFk90Pk+8RzwSGrX06Ug2zCj1Q2EGm1C/RjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GtUSCHMZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y78wPVu3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHMWa7009713;
	Wed, 21 May 2025 17:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eGkG2taeDZ4YzMChYb
	ZtQuXK0e9PUPcemMOcJQ14ros=; b=GtUSCHMZ+UuQpg1903zQOGym3MHtlaxxEz
	6qQq012lrbWYK2TMy+WkHMkNMAkSZo1TFuFe3c0nAxKQ3UtDhIhQbeGmOxEfS0G5
	vp0VW1UU+oUSO1foQCKKD4WnB4c5G4V5pBY0CBrKdzlCDox2toU//MlLGcQnQ/Mb
	euXRSFsJ9HGQ4orqM70VArKY2b6flEpQQgldjoQpKP+9VDGrW6VEP/tL1SOxjAu0
	nhW7chktNsySS5RScNNa/hrqSECecLbbfq/P1AIc0+/072H7bSYzG5cLQarPy6aB
	AragQBQXOQRkNXjWEQXIfalsy7yzANEnDp0tt5CSH3ddaU+vZpfA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sk5v80yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:40:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHRGmi001749;
	Wed, 21 May 2025 17:39:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwesnssr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 17:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o910h3Ls7vSWSL6sResJScH/Z6SuQK4WGkh9voe98an7jTEmS8JpMw7yaG/0/6Rs2iefs7hw3tZvjOZLinxA0K1IIsIznOdHNMc/ssvhWTzj/WgZExi6RNPoiJUZDPHtagaejFmZGMht6Nj89rD0rbzwpsoagBayzMYPp/jL7yA28FcoOIfi/g+wnVXuf0hNh8+/RfC12rHk7mMpP8w+cqTxuNS25Lsv7Z+0Y0bvJu2uBGsIMepsEmol7mBjc10/WE8sXeaxX3vECK6KV6pi3TFgINVEHMrsQwJLG8oLQi2Dn+qI141nunKp7VSfWnvJx7fHLsuV+jyHUB8VLywO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGkG2taeDZ4YzMChYbZtQuXK0e9PUPcemMOcJQ14ros=;
 b=XeLKMYPOehOEciErkpMbwHq5AK5jmIKj3ykC6Ku0iTEUbRntuxIptkgBGgR5imDwqr7ZhQzLezF/LKYiJqhdNpeybWTmUsdwBKrHjtHOW7SBbng55dRLGivwlvC/Kcw7ZJS2U0+V2kJlLSjSU0SK/sBYJqYI1CzxJVPZPhuGAtkuzKdjT3egxWw6K/PFg2LL0DQpIGJGrZGUFBwJcHsFOSCWbbdxbFM94uQrVBWjz+Ac+dSDPlEEvMZnZxF22JGjTFuutxGOaV6ldg27i/nDU+BXOgfWJCjago94ed+UiC5ECeDaGI4PQ8zUTp3NQni4cUIsxwe694dkBDn4JSsYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGkG2taeDZ4YzMChYbZtQuXK0e9PUPcemMOcJQ14ros=;
 b=y78wPVu3a/vVdhxjzPO38tQrY+RBPGm9ExCZpuCEKbFwt9osKTlda1PmARn6PfGUzGzqbl/ow34IVBdTKW2xK/fpE1n7YpxLlgA1+HL62CXyzLes8fUJNLBAz4rGVn/p0MR7MvPGjuNQSjof8CzCgjX7nNg9YKZzFMuhlF0tojY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 17:39:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 17:39:56 +0000
Date: Wed, 21 May 2025 18:39:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <1a7be28f-c805-4092-a7dc-d71759920714@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
 <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b78e0fd8-e6b9-47c6-bec8-a44a8be242f1@gmail.com>
X-ClientProxiedBy: LO4P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 09dc9159-b394-4e86-4eef-08dd988e807d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YiKVM347tKLoU/Q8db9C05eSzgLl/8L+MLx9k3Ma6/oomXGhGotXstpXCIwu?=
 =?us-ascii?Q?ERSTJTTVX/yVeD/y4RI3k7Ve6SX0q3rQBv035GwD2nEzet/b1BNOA9XJfIiw?=
 =?us-ascii?Q?L3kZUi30v6O3CJgkhIPcUZiG3mKTqNlyWic4e/6nvE8+pv+QJPgBNV8Kr/yz?=
 =?us-ascii?Q?jPMB6hzUD0cnnejCiX3UDPwzzpQ7wzh5eSQ1dS5TfGRaNay4BHF9PBgre7xk?=
 =?us-ascii?Q?NdbMgyjJ8GqFMyknBSbmCCEjk3SgRM+RmI09iqb/M5ASnquTQ3NXZb7feroI?=
 =?us-ascii?Q?5clWF1a2Ujhbnr8yfv52RxpC4xnBKD0/TWiVayf16DEFcFPA4bGJJLm02Yb1?=
 =?us-ascii?Q?6QY3okx0p/5x2HhSAk8/kzWWxX8iwexN1ChYf+w13m+Ddikyx5pYomQRCt/a?=
 =?us-ascii?Q?G0inBYw3slzDTroYk9luXAiojq/rQMqXOyQI9dGbcXXBA1/DENQ+0Sg70uuo?=
 =?us-ascii?Q?Q5ypmpOdgNzWDXo/7iK6f4gfVqxY6VKADw3hF/Zy+TFBNvu1vjoijGRjrwXL?=
 =?us-ascii?Q?Qxlb59mcvrinMpvv1yA7eT9l/5WL2k2DE+FVYLRHP8pc3GcT9H/t7pTpgKSP?=
 =?us-ascii?Q?KlPT+Rtscdq78LdHDlGAxAInqlodPVeKDNaab5pYxtUhE3KK5klRbqYItgkp?=
 =?us-ascii?Q?ZsJQ9Xs1bvVFwy8Ul+CmGr2XvgnLsSf2J0xvj18p71yIzyHId2ruPenUE/HB?=
 =?us-ascii?Q?IGPDAf6Z5iQM7wxvdKv1YqVNk+TCEBNCI8qNfne2QzeTAIkh8LtWQ/Fr2ATA?=
 =?us-ascii?Q?kPVVF/TvJ9erYweOJ09CI7wkGhmgGub+t1eDgbM2vH5N7GgpI3W1wQUdLJRo?=
 =?us-ascii?Q?ijHvrQeexUhKlfnk0xr1hHlrbK2F1cJR+RWo6gpzpk50EY+XEeWhesDyeJLZ?=
 =?us-ascii?Q?qayQkGx5cBulijbvix5vFibX+pCMNFqcaAvdXuJlWz584qlk9MQREzbnY8L/?=
 =?us-ascii?Q?BMD5Bj+chyPlRGuq9kxQOdPLs+zjVxDvfDu+zpmmugD9oNylDoAQKtQcToS8?=
 =?us-ascii?Q?ru+9XgU9Y7Eo9gV1hZG8f/B7/XdrKJNcAzeba5X3z2VUd6aX88GSfMTTMKyB?=
 =?us-ascii?Q?GghYnhgFzxSH1dK15Rjfp8eKz0ipanOFgaoFR3KNoKVZBsk59LEzgUSMnmv5?=
 =?us-ascii?Q?9FxqVvRJWRdrI5Wsj1OktB6iZgXHSv5bPewQwfzYZ8Ruv8bnbjV/edRZ3BoF?=
 =?us-ascii?Q?cuJRiTkgGJLLndwqqS5weveB89+GkuLPemjdWVMtYj/pwm71vc7K/zN1Jx2f?=
 =?us-ascii?Q?Vd/ASfS+SN+JIryRbaXG+vXwUTS4BiX4VaPlEvM5fhW5lYznsKUe+fbB2a7Y?=
 =?us-ascii?Q?6pNsMfgNxruzeB8Cfeo64oqkHZmN/7e6eJ8Ipfus/wQ/KKYHvYb7yKND7vF4?=
 =?us-ascii?Q?2MU+iWacvg3c9vWe2yHwsd76kk+WXsTfc7RYpTNx9Cgfuk5G8tN5sP6x9Ph8?=
 =?us-ascii?Q?TpbvWX2HiF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6CpHD/jWax4/kMdmiD3RkM/yYcJRPwnzERBIGyjRqoHXi/g31dXpkXu0vyY?=
 =?us-ascii?Q?3vOcFTWbrpz6ZA1k0/1Ds6XVvE8a65m5g69ry4kEx5Og/nMca3CYCN454Wuj?=
 =?us-ascii?Q?ATad/EZD/HAyiGljYXAaFg3MPeezuFG0a+N3IzKrwSDLduvAH6BOJMa6CNFV?=
 =?us-ascii?Q?Yp7zZJHdEU+D91foSDceGAdO6iZ4C6IV7uFJAHtGTl1e/8IzlUGNNj4W6SoN?=
 =?us-ascii?Q?MXJ056YTaw2ViEbouRdGpH4FFdH4IPBIphaAJR0ea0Hr5FDVz+vPID9zFjEc?=
 =?us-ascii?Q?2csdRwUfq2ynKvIJBGIv7fjs7TZng6byiuSlC/IkD9X3PG7+ha3v9nIALi3p?=
 =?us-ascii?Q?2WdfOyEABZeS0vaMl0P6UO8IPnAjS+E71Cw+lxCRXf55e2npwcj3pvoFxY8L?=
 =?us-ascii?Q?RbF1Fu6lWUXNxSWBxrb2sFjOvHqvF35xccoqG4uzGYVkl20BYhCy0lbJTM38?=
 =?us-ascii?Q?fjn6YkTiLfWe3tPjyUUunmrAEobXJNYz6ZcVi2rdz0UCuShgr6nthxoBR2NZ?=
 =?us-ascii?Q?bvmDb580SwOAGKZrlTKqtaA5Irmn0FVEU6ut2Qw8ixXclNGQMC4+ovlSEAR2?=
 =?us-ascii?Q?FHaS2ZURk6u6tpOEZxpQjBpIZEwap4QGGbJtm6U534LX/j1VIiTUgqly0bBZ?=
 =?us-ascii?Q?6clTanHomGYXQCtEBrVgwQKMLXJhSZDieO19lzTi+PLQhW1xQbgW+aM+UOXS?=
 =?us-ascii?Q?rLScmD64X9tMtYtIRnz3o+/yG0APWNyU68/QcZCbmdSUDTJXrhBUYpqUZK7R?=
 =?us-ascii?Q?Em4tBFOr5zWlnrJdL5pn8kQ9Kn5MXF7Ir9JP1TJepXKl1svAJytZlvJ0m8Eg?=
 =?us-ascii?Q?TTo6d64O3CzCioHnCp1/MIB97VP7mBhkoO+1LdpNoEQlWW0lsNJlQQ0Q5udw?=
 =?us-ascii?Q?/8oH1wbkE1Ukl4+Qr6lskNjpdDUsyoNUfPmjwSMRVo/zLXO9oQifEvRHsUSx?=
 =?us-ascii?Q?7QuphtfTN8lhzluXsTDsyPA0rbeDMko0A41mpxkO5AOG+bs6aha9n1Jn5gK6?=
 =?us-ascii?Q?y1j85VtWbialhurnqp3mAHpgTnXD8DHCjQ+HRVeVquLDVqT+oIG2dMu8Sxtf?=
 =?us-ascii?Q?dGlAHHhJ0JNdboF7pi8na4ZOvKM9z2mEWELm5DktPdSUQHfz1YYm83hd1/Zl?=
 =?us-ascii?Q?sHxx9cdohOsbGjqGfFZEo2x+6NKiShs2R3JC0Y9k1og8EBWfDXpOOuaIwcQ9?=
 =?us-ascii?Q?Tj0NmQO/wI+kJwN4kN+E7H62LfZMasILeqmKMRqnTUSFFh8NrdoT/kLz/ZmM?=
 =?us-ascii?Q?ZjDfilVM5AflL0lYoiDS+3azqyuIaUq2DBaO3JvpDZ+zkidkpG2tlYpUo/pT?=
 =?us-ascii?Q?sH/ToIi0P3IdDgioyjEodhKsYe1kvBiWHCpwBC4Ms2JRkj9uyj4t8ZqJhw3x?=
 =?us-ascii?Q?zoQ60CXCbFH8wGFJ9+wETy4yEe+9nWNPpQ1fGXWsugJQ+0vIoUa1laYNywYs?=
 =?us-ascii?Q?HMfLz2Y0PZp6ZeJNq2yQkJ2T7LoUMGXMKWy+BzwB8udXP37oMgcgpHCjiDkF?=
 =?us-ascii?Q?+Ndrg0J6QhyYE00sFdXQYN6OK7s8XIGdxMLc/agzNwxkiTu04l2SYaZXD79i?=
 =?us-ascii?Q?g56XtrwSBypk6MJ5rnUwpCXx6O9s8qvYFtsNrei5gH6zkCf4kIrbMGwV1VC8?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O5X/er9r917VIOcMEZvcwXfyzVlezX/2OyHoQxNDvYQmISTexXxm3CUFZspgavV7agt5kIKMZ6CqJq/yhvjJe/+sEkog09ws47gV7WzPiPfQoeNUExb3TYtTDy2DE0iXmFIlKITFFxdMDAanH/6qV0nVm8CptPk1yRiPnfJIsCMxAPQBhHWSjBu470V8qhAxPwyl4cBkYBgPkOwe/Em8eVsQnRiUteNOeVkpQ5gT5bsO2Mi+A8vdonRxhuGyw4iKtI8fiXc3jisCdJLz/YDCr2ved5SnmNnHZvPcwTRSuPOBZr87N9545nMMYrg2VT5yGXXRV4K/AYUm63929pnjnvkGZ0BjqlxLaDAqk9ikxKBF1lIqKz2apz1ldtdaEWkuvkSAUF2qRZT1RY9GjXVNc06YmgvzNvbL7+0qeBu4C/CtugJlgS1ZDpKAUaMLjlom+bVHPU3EdRzR8LkUWLfh5JmQMX3t3r+hRO27doT6QNXMx4s2/BAsYxWfe8ntmGIbKLOcpaRUXMmP7mZZEan/wDhzul6LyNSTFcW6/HEmYYlww5vWBeQtnahuAAk4WyNthVntn6u+S17XL3d9jYIiaIGtqpUhKMmyyz+7HFcEzkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dc9159-b394-4e86-4eef-08dd988e807d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:39:56.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLW8Wgfg2qFeeIlxt8fEbvxzqtiOfcKtbVfGtoChj4bULPA/wpxFMztCiaGP358m3XLE4JV+RariHZvLWN5E3BT3k8EIyWr4zOGsj6bfrk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE3NCBTYWx0ZWRfX4s7Tr6JMdDy9 VO//452APWwLzRoILbnPDZUqpha2H5mqRKiFWlBNUKMK2550/eLoWVI8Fpb7pQlf7MhefU3xIek 6V/o/ufzEd6awuvrG2j5KVdAM5oY7ISZ4iuByn0/P+7JAxPnVprADm3a22KGTIcXGyWhtG8Kdcp
 DxbnQ2Wf5kkQc2iqO6mXNQ+SV6+cm2CnFKb1hIGn0Cc0sXmI1z6hWSE+KSIwsjWpfW6oUptBhag Br2qSMdaBt59IcbEyfUZiQx7oJp+Q8P6Z8NhRj7ieRyulCT1na0h/yxa+M73xWxZ0rE+/E8cPUn i6rgvMOFD6gzWfp398UZDqNTS9Ekz2S3U7ZqLa5Ry+NSTMgow4LVaczSj+vdVvQEJbVX6mBCjdF
 0HPjdArj05MmuFdzcvQgCN1l/uX5RZFUDu0HZhZ/Z28mmA0MwkPShbRMSyMNllqv/xzqTrGd
X-Proofpoint-ORIG-GUID: UZHRsQt5uCbx3KYEfewYea4hlHz9GO2F
X-Authority-Analysis: v=2.4 cv=LLNmQIW9 c=1 sm=1 tr=0 ts=682e0ff0 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=XRvxzOlpUreydqbFFmkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UZHRsQt5uCbx3KYEfewYea4hlHz9GO2F

On Wed, May 21, 2025 at 05:57:48PM +0100, Usama Arif wrote:
>
>
> On 21/05/2025 17:28, Shakeel Butt wrote:
> > On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> >> On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:
> >>
> > [...]
> >>
> >> So, something Liam mentioned off-list was the beautifully named
> >> 'mmadvise()'. Idea being that we have a system call _explicitly for_
> >> mm-wide modifications.
> >>
> >> With Barry's series doing a prctl() for something similar, and a whole host
> >> of mm->flags existing for modifying behaviour, it would seem a natural fit.
> >>
> >> I could do a respin that does something like this instead.
> >>
> >
> > Please let's first get consensus on this before starting the work.
> >
> > Usama, David, Johannes and others, WDYT?
> >
>
> I would like that. Introducing another method might make the conversation a
> lot more complex than it already is?

The argument is about prctl() vs. another method.

Another method was proposed, arguments were made that it didn't seem
suitable, so an alternative was proposed.

I'm really not sure what complexity this adds?

And what better means of comparing approaches than actual code? Isn't an
entirely theoretical discussion less helpful?

This feels a little like dismissing my input (and I note, Liam's points
remain unanswered), and I have to admit, that is a little upsetting.

But I suppose one has to have a thick skin in the kernel.

>
> I have addressed the feedback from Lorenzo for the prctl series, but am
> holding back sending it as RFC v4.
> The v3 has a NACK on it so I would imagine it would discourage people
> from reviewing it. If we are still progressing with sending patches, would it
> make sense for me to wait a couple of days to see if there are any more comments
> on it and send the RFC v4?

I've no problem with you respinning RFC"s, as I've said more than once. The
NACK has been explained to you, it's regrettable, but necessary I feel when
explicit agreed-upon review has not been actioned (obviously I realise it
was a mistake - but this doesn't make it less important to be clear like
this).

As to stopping and having a conversation about which way forward makes most
sense - I feel like that's what I've been trying to do the whole time? I
would like to think my input is of value, it is a pity that it seems that
it apparently is not.

I am obviously happy to hear other people's input. This is what I've been
working very hard to try to establish, partly by providing _actual code_ so
we can see how things compare.

It seems generally people don't have much of a strong opinion about the
interface, other than Liam (forgive me if I am misinterpreting you Liam and
please correct if so) and myself very strongly disliking prctl() for
numerous aforementioned reasons.

I would suggest that in that case, and since we maintain madvise()
interfaces, it would make sense for us therefore to pursue an alternative
approach.

But for the absolute best means of determining a way forward I'd suggest an
RFC is best.

Thanks.

