Return-Path: <linux-arch+bounces-11781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC69DAA6D0B
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDC7D7A21BC
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C2231846;
	Fri,  2 May 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cx7Vq6oF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NE6fUzty"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D822C35C;
	Fri,  2 May 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175980; cv=fail; b=DkOOnhIwlemVUhprsPCnc5GhAC5irmovkeD11yjKcfjc1YqXVMJ/t4UH8GmB448YN5dHNIaiS1+4mMW/+/hi587auTZ3YuyaL19/H1iEJMUwtFqcj01bFWkOuBh3eNY6E8WNC92GlMG3lwW3j0F9Tvnc5IcsTVF1+xgSUoSV/OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175980; c=relaxed/simple;
	bh=N6YShK1Og2WcA3wl/GsOg4yP5QpmbnOAlNiVIL6IC9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEi381HMKrifVmTI7XL9YGfVRkISnvu+rxGHfUBdEMYghdeHxtHblbxiq1ucATkJB3e2xPrDbbolTES6KsaQEBDKSllUfit2bLEHsxAvXZbvLqFK6RPqqbIKCo5WuJ4mbyM62GekDHKTlPlp7UcwwHF2tUyNo5KAElIQkZ88zfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cx7Vq6oF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NE6fUzty; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WAG5015417;
	Fri, 2 May 2025 08:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=z9vkpqrTvVhUdBjros3lphzh/Pl8aizkj0hcMws3MaU=; b=
	Cx7Vq6oFqcwfvpz1SBrR+vqdRhdlbny0YMDtlkN+6XnWymHCiT21hmu0BlLZROOR
	CfOWgrU16BVNwLfA38qydoCPPM5efO4fN77B11pK3CQJAj6pL68KhjbTpK09aBSG
	nLLK9dGSgFfjKoGIiv9ZMN54ZAe3hyZZs/gV4BH2wUvRezilICsIAf5C2AiN+FUv
	8SPa24C7E6leJ6eWCz0eHIgrQr/VCQi3d98jhnVOSxNTrkXIb07Hj6z0HBHXOVDu
	NEolpV/AA63wdnZkecsvd6m0qDuXjmGHPa8lcaRQ5s6D6jxL0lgQm/fa8X/FG594
	D1pYnRZ4OtFH1HHQIPUK2A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukmxgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427Cp9Y013794;
	Fri, 2 May 2025 08:52:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdjncc-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMDC3qYEKy+urEz2Bg7h21Um3Gmv0cjXOR6oRoGVO/nzaYRcA1w6U9PZ5q16T0bZjkx2XNB1aACvzlaDAQTjizxZbVRLl0WMeWjm+SMGYiSmjtEtey08mizI7Cj3+/IyFNtn0HpCxgCKUWXOev43lHdWqnIBpA+/ksc7vUMejoK7rZp9a0bm0ai9TYh3kcee0j7KBEZnotAzILf+EDmdQV4iRJbFWF1zUSAOU/RZ9vRiNg0I1Y1BYH9c60Uv+i2oUg0t7USHVbcjF8DEyxfTyoxpJgsC8yqTUZE2nZbPxeFL82tGkyG4NCU2fE4Sfextpwsj5TCw/mMMLkPJm0OfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9vkpqrTvVhUdBjros3lphzh/Pl8aizkj0hcMws3MaU=;
 b=vDRy4lgniUTkgoZtfmDCQS1sao9wp0oDg4s8I3BESHQUPmL88vRA24duiQuxxVwE0R4uqlRZZ+Bw6Mu+O/WsHyr4EZ0DRebNR9uCbZy0csG4rRCQrji7my6A44zdZZKID1JkgFXpVypOShJtmi0N3UuHFZJgiJEPu9YhjTqptrQN+KbnxkT/59t3HxDYdMZohjRufw1MIUzTtgKWQO1ECRVrkCcPec1VkUbXpn/FIusfPcP5GdPxJ/S2hVkaO+aHw3t+i/m6aQdFsLCzaDEbuCu9c3D5USxJUcKq3rEDWbhEGsARfGKW7AU1IZMBmwNNh0S2K3fPZ63AD7oZ4GInTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9vkpqrTvVhUdBjros3lphzh/Pl8aizkj0hcMws3MaU=;
 b=NE6fUzty2d42H5P5caiYUwJdR9EMnMIEjNegozAqEaKhKiTAiJ6Z4kVrqyFT2VYijwj4hYaKyhqoKKiZuJGvzFm2yLL6WsHkMn9YKYgYCXmY1k0fjHhA4R9lpjY213SZ8mNQD3rM0rFmVrx+4RiSxmE6JBoZyWyI8U8dqwQ7yP0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:52:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:33 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 4/7] arm64: barrier: add coarse wait for smp_cond_load_relaxed_timewait()
Date: Fri,  2 May 2025 01:52:20 -0700
Message-Id: <20250502085223.1316925-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:303:8e::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de0ec27-4e58-4d50-5105-08dd8956ad4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fiFPKgncQ/7ZDVFdwHp43RJubiCOVJrEnEvk2aNAVrfYPGzlUm5JptA3UChk?=
 =?us-ascii?Q?27EPvzoDAE+Vkol0kYg/UJL1veL7zK2EBSmoNl+TuLD110f3OL3DwHywoNsq?=
 =?us-ascii?Q?/0uU4Z+9RzOKtfGGapZeIYJH/CrqVZQ7V+4/1G/DNp6mzJrsFHokhFNmu0xl?=
 =?us-ascii?Q?5vxqE3kfZSfudSEQoRzStWP7atVlpDBSE/35bsRqkxfWgyDPsJXiqKG0/p7g?=
 =?us-ascii?Q?ESd6s1BCpUTrqLF1LxhSz0k5cAdlXlTywTRiqUa5El8NEvVDR5aDmeYMhMFD?=
 =?us-ascii?Q?Tr+5ypHPYMWH837BifuG3fFWxg4NZ69kK1JAwqNG4xsMSKA+ffLsXmcjpx+F?=
 =?us-ascii?Q?eHQRJ9grIV5v3QQCEyASxw9nATi3ld146Vaw4tf0NwL+EdZHnbzwBfClrse5?=
 =?us-ascii?Q?HE7AB8jeohIDxwURMmEqP2Gxovy0YosLZR44G9/KdqWceHHZt6VVBgWvf+wQ?=
 =?us-ascii?Q?+NameZ+rQOfXj1GL1tzADbxsWM+Tfnd+1P+WAmoll6AsiXVMOzcv/aUFWQ3D?=
 =?us-ascii?Q?LT85lTxK1MYGA2OG1G+D4hor+2yaonx4Xvkh1fEnL/OAMMm78tTQBpY19IMk?=
 =?us-ascii?Q?IZh5mz3BZKjnJriQ4zXzQH1lcpPAA8YRMCk9qya229zWuecvHvcACy21Z64/?=
 =?us-ascii?Q?3h7CZer3dHyPRcAdq+LQ23FvTBbE4BPz5/B/NUTeipPyRXm4TdVAeUVJ0jMF?=
 =?us-ascii?Q?5xuXkIbOMkAKyIe4MYlVKXsn0N2vPEO2h5KpaB4Nh3Ep0RiLn0Clh8CSkCzW?=
 =?us-ascii?Q?pKB3zFpfRNZOk/MBquDRFa84MXyD3GRcrsdUMzrv5+wpRfOakmGW5uro1gTn?=
 =?us-ascii?Q?1kcc3pAZNnBdCN2s7WDwvmsVDRjCbPBQOHOAmH+HhcXgJ361QHCwxYiT20jf?=
 =?us-ascii?Q?EifQKpLbQsK3EXAtuVku9hUSWWewb4QeQMdYZi8DoVqybDWO1Wq+GyhycStX?=
 =?us-ascii?Q?9z5dUxpDOaaDKczAoPt3sttsmMqR7Etl10qigBm2s5P4dmMDJWLHWkGyF/SR?=
 =?us-ascii?Q?8ec/TG6/groFkkzMAs5/OTsgsNs2VW/9k4veOL92DtO6DuhdjmvoBUuqQXh/?=
 =?us-ascii?Q?Bjl2nKdJGKdcFog/ftXLUbcY4SMvgmo4WWVFNum20vUb8K8JwWdr0aJSa6M5?=
 =?us-ascii?Q?gOpOoDxBTHxR94YI/O88fDkw+fyO3eiRP+SWyVAowISCydU4OEEIBUwxdSAW?=
 =?us-ascii?Q?mtgd8gkMYZxCW4EEGqltUkngu4S1J/gb3bRMUAJkQsQGrAwv45NUREx/woPh?=
 =?us-ascii?Q?Ty3nhFdzcb15+A8TOaaKuMLaPVMhZtMfuzPuglEhAULsNqpKDlZpi70iZ4Ql?=
 =?us-ascii?Q?qWN0g56cq/a/nttRhY9vdzZzDsXZdYizsOg3H3ZZP+2FEh16gIrrfyzUF1BB?=
 =?us-ascii?Q?LiGgUlSKyPSCwKDIGOTE6vJgag0gvvjMY0F8kzP5V4mMslE+5UqT/mdwHlNK?=
 =?us-ascii?Q?IIWDvErOY0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8U5jSeIC130o7pVjP5a5NjsCeFocq6wXZyXew7SbhvngmoRhosJ8b9YLvnvt?=
 =?us-ascii?Q?w/6aAV6dA7e/aNC9Mg+p9PnGY4OLpY/8N0mJA9770Mrg1bW0AaT0/d0ks25u?=
 =?us-ascii?Q?elZRFF3b2Vk/RphZyXUCwWwWV+rv13V/fQsjygHkVg7jhQZM5It38nFG7w6+?=
 =?us-ascii?Q?gkojdiGexL+U0huxLTGyCuplOScGnQE7wRUGhPQJKitMgILN5auR7BCDMWcn?=
 =?us-ascii?Q?tFgpjBonX2/YsTyzmO/Gp3+wzf8PdqgbdIKRIheqfwG07o9lCqOB8yzFME1T?=
 =?us-ascii?Q?XUUDTXNu/UVywazJ8r90RpX4fqjwz9LF+HiAe7TpcRRU1w9NZx8PaAoc4OtI?=
 =?us-ascii?Q?reM6ZKWCDDjczu5d3FLbDbHK2n3aEQBfnCBzQvgZY7g85Apxy0KGcH3p3bNn?=
 =?us-ascii?Q?x4j7wAhD0G+l2V2g02iDNZ8mKV+qQBq+wD7QjZXEkIJ+3WD1CY2i8qIIDZvK?=
 =?us-ascii?Q?rc/AywdvroPK10s79gVgm+7BPm8MZWWwjQgd13sqXLaYoMFjgukyIzEb1Dbd?=
 =?us-ascii?Q?/bYqWqMjRzwt++pPTufiTvWT6GKOow6JfUocAhsU4fTciXyAsua+z3NDLrcR?=
 =?us-ascii?Q?Y58IUdPdTAluh2QqPnbYj/o4/0muFIGWmdTI7bO2xaoi9wp2giWAOAr55toZ?=
 =?us-ascii?Q?079lgdUeqM6zo0iUiZsCmzamWtHvUOqpx70+rWQZqHJCU73LZQUfanydEf6h?=
 =?us-ascii?Q?11eawA+EMALmyV28pEIFUMQavXCRuokx5WW0GchcI6koexN+r4MmtYwg3AKf?=
 =?us-ascii?Q?YSdtUaTvmQAsww+NjdddMu4yoBJBKlh69ZIdIQrgXiOecLdJMY7rqoiiSbv9?=
 =?us-ascii?Q?soscP3TYgioY+WtVxhDqEUsiuh4dlKubc06NgCuoDlOdt4ukWJa8fgGgUzlq?=
 =?us-ascii?Q?qcTlRGz0t+/SWMv5iYlu5/DLWXOkJue4BUxpxKMFGezrJ7tEdK5DucB2p59Z?=
 =?us-ascii?Q?cqYetnl48VitChyNqqKJTuu7AzNV/TKh6rKEOcDDgTRzBh3RUzK/C2eROJJZ?=
 =?us-ascii?Q?dC3lLq7p8svJJZRS+MoaQ1bAvaYuF+LIR62QpPpkQhbYE8yP8AJzw/OSycs/?=
 =?us-ascii?Q?WaisWsQkCjj+bDqkvn8isFjj8c3qD5LCrJp70f2IY3yf1TNtZGFzJuRd6QL7?=
 =?us-ascii?Q?QvFwnD4ZU+jHTfLtF+E1W0QiPMtGPuqF+Gw+VitPQdTVUYOkziX00haQ7hFu?=
 =?us-ascii?Q?+OT8ZIQqp5/RyT8L/v36opB/n/l5RlwWa/AhVfh5Fhgg2Gjm6HDbozQfG0A3?=
 =?us-ascii?Q?4N9s4FkW7+0JkLNz/0PXlz9V+8WWZSTu3uGkR5ssC+W3KkKRXozIQhpVqZfB?=
 =?us-ascii?Q?nNcSdyVZj8Q5KyesrupzOG9IDG4mMTBbLWCl6C55nBU4nQ0HAHSmdM+fQAP6?=
 =?us-ascii?Q?5VCanYcvhaf1AHrGtqtvRQOnKwPGlH9k3DeYDVXAHH5OjJyEc9hBzqyhzKXG?=
 =?us-ascii?Q?iNQkd4FXMGLo4ao8ssc+sf471dEUgbOhZP1SDi/pDVbli8aCwqZ+JQuOH+cS?=
 =?us-ascii?Q?Dqpl0yx34YDXj0TD/mAtIwWrTS9/+UoIBo7jzZ9XMiLFQBfCR6E5/dpOzk/D?=
 =?us-ascii?Q?+k18HXt1vRYLgu8hns26GVRG/9P3Thss4EYyR6Hn/XBp9SV3MMamXbOQdKbY?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dDZlNXyOs3kFgCZ962tTyCSgWBfdZcIsf+QFUGTsIjLmWF2C2gibPmiLJX1HXiEQxalGVdoJ29MdFV/LTGxDzDwrVCm1yZgvBqOrNTtvs1zZSDIpYHqfPrPlDdlr75mkxIm0qPtPFNaSOb5Oq/aE9bdN6ZEsFE08cu30stMybt8HP0C/IqQbamNP99rZmJyF9VlrvEtIBy9LtujkkFdrZ0jQXaErTgJC1VAkZFWXTeB9tLqVi/RMYxS8qyUMQhoFL9Qoc6CkG1EgriqWnMRVd2aEvUZK57LxDhuYefTikdICzWALVa1b/WnGUq2ndleGd62uABhQowT9s5zlSDekbdECSBPGeZzPOFYC53VIkHKD/RLAMB4Ih0D7vv0kHymhmmDaSFYHXiM3t/65nVVTii1lWuDoDLEAmcu15ErXRgNKfSxDA0PPrKB5o/BXSfQzStm3PtvL1LOGufl1Yi/rStIyki8sbrs31OQ6mw64gsr++UccSXhuEFwbCs8JweUJXeDlIyyh5ISN3HPWwoqAZICFHDOztaJp0FxM2m+TkrHlR20Itj/HDoktTBcjikUdJkeqOr9LWC7U8e6fBuZu8fUgoV0E6hhzZFVnCzOB6x0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de0ec27-4e58-4d50-5105-08dd8956ad4d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:33.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEUUuXF4SeI7xPBqSiCP4dAcHBxHKogjbCzCkKDlWaXM6DK07YD4N84/w9Dp75pxpLOSs4oYtaxO5yN6M7f6l6hudN+L9kzOYaoghq4baY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505020068
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=681487d4 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=-n7TEV3Rdn1l6z5psJwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: p7GWg20cI4PhcWyxQkVC2r-exxPl_ba4
X-Proofpoint-ORIG-GUID: p7GWg20cI4PhcWyxQkVC2r-exxPl_ba4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfXwdkKxiCMF8+1 gi1SQ4JQmzJW2fRAeUdhRRAEXfcmtk7XJlANI9SLxN9GieZtpwvmMONwf/r/G3DaOkY6SI3lMDP yz+tq7XZYLE5og9L183MvJhFb5vE9dPQ+GnsCOZfchk0zvyMqDV1/flUdnzhWVEcJQNuaWJnFW9
 A/i+P07dspgfNXA1Qz7Lvhv2XEf4PJDOiTsMzvfKDDmNyNpnuFI9k85B0Qihoib37qMWg3D0yrc KP3SAklKoIHY1X0I3Azw1cLBtDuJTjtqkJqUQXVg2OP5NnZfefeac+4a7SDII0aJuWa3sJw06sz o1CoN8HULNeelTwW5/YnphyGxrzY68XkurI1eSr8RSvYr9FA0P1EOdcjm6Na074TfX5//ALYFNP
 I78n5UwyADpm2uZzNhCny+bm9unST/0J12nxqQBBENN/e/a7/MmuQPxw5Rq3X6P2H3LOfXsi

smp_cond_load_relaxed_timewait() waits on a conditional variable
until a timeout expires. This waiting is via some mix of looping
around, dereferencing an address, or waiting in a WFE until the CPU
gets an event due to a store to the address, or because of periodic
events from the event-stream.

Define __smp_cond_timewait_coarse() for usecases where the caller can
tolerate a relatively large overshoot. This allows us to minimize the
time spent spinning at the cost of spending extra time in the WFE
state.

This would result in a worst case delay of ARCH_TIMER_EVT_STREAM_PERIOD_US
and a spin period of no more than SMP_TIMEWAIT_CHECK_US.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index eaeb78dd48c0..f4a184a96933 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/kasan-checks.h>
+#include <linux/minmax.h>
 
 #include <asm/alternative-macros.h>
 
@@ -219,6 +220,71 @@ do {									\
 #define __smp_timewait_store(ptr, val)		\
 		__cmpwait_relaxed(ptr, val)
 
+/*
+ * Redefine ARCH_TIMER_EVT_STREAM_PERIOD_US locally to avoid include hell.
+ */
+#define __ARCH_TIMER_EVT_STREAM_PERIOD_US 100UL
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * For coarse grained waits, allow overshoot by the event-stream period.
+ * Defined without reference to ARCH_TIMER_EVT_STREAM_PERIOD_US to avoid
+ * include hell.
+ */
+#define	SMP_TIMEWAIT_SLACK_COARSE_US	__ARCH_TIMER_EVT_STREAM_PERIOD_US
+
+#define SMP_TIMEWAIT_SPIN_BASE		16
+#define SMP_TIMEWAIT_CHECK_US		2UL
+
+static inline u64 ___cond_timewait(u64 now, u64 prev, u64 end,
+				      u32 *spin, bool *wait, u64 slack)
+{
+	bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);
+	bool wfe, ev = arch_timer_evtstrm_available();
+	u64 evt_period = __ARCH_TIMER_EVT_STREAM_PERIOD_US;
+	u64 remaining = end - now;
+
+	if (now >= end)
+		return 0;
+
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
+	 * Our wait period is shorter than our best granularity. Spin.
+	 *
+	 * A time-check is expensive but not too expensive. Scale the
+	 * spin-count so we stay close to the fine-grained slack period.
+	 */
+	*wait = false;
+	if ((now - prev) < SMP_TIMEWAIT_CHECK_US)
+		*spin <<= 1;
+	else
+		*spin = max((*spin >> 1) + (*spin >> 2), SMP_TIMEWAIT_SPIN_BASE);
+	return now;
+}
+
+/*
+ * Coarse wait_policy: minimizes the duration spent spinning at the cost of
+ * potentially spending the available slack in a WFE wait state.
+ *
+ * The resultant worst case timeout delay is SMP_TIMEWAIT_SLACK_COARSE_US
+ * (same as ARCH_TIMER_EVT_STREAM_PERIOD_US) and a spin period of no more
+ * than SMP_TIMEWAIT_CHECK_US.
+ */
+#define __smp_cond_timewait_coarse(now, prev, end, spin, wait)		\
+	___cond_timewait(now, prev, end, spin, wait,			\
+			    SMP_TIMEWAIT_SLACK_COARSE_US)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


