Return-Path: <linux-arch+bounces-15405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA419CBC83B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72F4230094A8
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BE32145E;
	Mon, 15 Dec 2025 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S+p60a/o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jIrXASFR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904F320A10;
	Mon, 15 Dec 2025 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774504; cv=fail; b=bC+YPlymWj7dC9Zly2v15jCfgiXPQJ/kokGrqb+Khj6pv5G090m0gJQDudWSqbbmJ3GkiPyaXu+ULjxS0zkGJcdjFMofwXu7Ryyi8BjW+Mh8U5opVTltp+fos6Tl3VcUGzbF+bUwWBys4PtSFib0H8aUexuk1bCDRG/T3ZaAQ7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774504; c=relaxed/simple;
	bh=UEsVnvreByU6ZNXkqfGmwbNQIH2zkPVh2MNAmQIuMxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRVOVQcydnnauwBXbJpehjP4ovT4iTSfL7c68OuwY9zb7Yre4f0BcPt8AqmtirYJnA9KKYdgasUm0FFlO7vb+pORSCK/CoBjd5GDAjjAZ/4+TFqGAkfapW3kPqv/JGtJEykkcLVQ6ad9q6vhLn04cQvWQKSncyhCuGjFwW2V29w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S+p60a/o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jIrXASFR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BEN1iwr864057;
	Mon, 15 Dec 2025 04:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PpeHWUNiB/+F2ahCWgkB8LtWyZTkE/VibxuMHpNcQmY=; b=
	S+p60a/oIw4dInMck8oKEMAqDLE60XTD/T03pgJW1hfPi2IOozGCLsmBE2ygH1rp
	aWsKkShxOimHthY7O2XWa/H+4APTEGbBdl0vp0UHm323CPIidh33yuvAgQ+1CfWK
	H4+i62xfFRaCUlUMzKPGR+7WeyosFv0xpNH24zi3WFDGV2Vmfg4N3O9hiegjFta0
	zlO1zaMqKfJd+Q6mShj9uBv7PQba6wj1p0mFNGDnUzxlexXGtJuWXJGovd3dtWtF
	3rUZPLc19A5HHEhTx6DUzH9INL53jwrzepOHiCyxWxeC2ubZN4tr9/fLtkKpsrG5
	i1WkRgcnMF/QeaOsPn06pQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yruhaa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF4jQZk005878;
	Mon, 15 Dec 2025 04:49:30 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkbgu79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwWYqH3HHTLhjAFMM4bf3P4rwbfKkA0KjIOI3PfMAuLOfy5M6E5xfWX7p9+F4xGx94Ydk3DPio3pO5YK0WoIRj/2O+LTfdPvNaF7FT4PsHFUqngWcKdYsGEdGg3GESck8NOMoHbafKhWaQEvlsYNrON08DDQyjAjyAl3KnFTZBsBdNlNROsa+ZgviufsGD+l/4R+y9ChlTehg3z/OYrUBLkHTc872dE5jFJIAypEgd63oUJsXw9lDDF5lTg3wNIW8q9olfhfphdlUK3JHjXKqpKd0w8Gw0fPcs6LahY30SY8Eek7M+mfRnIrQCFG0HgYF9wQVWFgoJRUxRTNQHtPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpeHWUNiB/+F2ahCWgkB8LtWyZTkE/VibxuMHpNcQmY=;
 b=QAFyN4K+0vgf3u6sHy7wr/izbIZ9DEPx+wJC0xhoqUB7D8Dlnnth8iFVgf83q1abueJFRwgGgb7tjgdqBU6X1C8EjH9CZmpGJdwHugXsnxIsj6MkQqywyGoKB8pmMsMQSXORAEPQkuaAGrwCGwfaoVUzktLx8K4Qma8IFzaHEuJ4udj2wV8Sk+d6B5tgT0eGcbcLSsY3Dou5Nr7Zzny4GBxNeKigmQ0ugjvj9mBhHdg2MEEV/pYCvfaacI9XTO5E1JPsicTKev0wEN0EG9zM5UNpvFo5+EOAypTjB5hHs2Py0tnoeNTw4qatLy0G6hgMaD7KzmIrMAHURTnqidloDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpeHWUNiB/+F2ahCWgkB8LtWyZTkE/VibxuMHpNcQmY=;
 b=jIrXASFR6tOaIY6pk+kdRamTw3zD35ue1DLqfmE2p1nBFIt6n60aWDhtZXaM5j3Sfuc1baj2dtCTSjQTB4xsIaWe5bFig1QyQWmOi+rPN9p0gQiPtSlukp3haf6ekEfbKE5jco6nQD4x0WYYEfJ7uVQxi+BM+mzdAQAkGgdIi04=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:27 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:27 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Christoph Lameter <cl@linux.com>
Subject: [PATCH v8 03/12] arm64/delay: move some constants out to a separate header
Date: Sun, 14 Dec 2025 20:49:10 -0800
Message-Id: <20251215044919.460086-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 0400ed9b-6bd2-4b0c-78e0-08de3b9553cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mrlqkrQp0Y5m8EdW+Exyd43gfmvuP1WovlbLzMPIML5McHuRgin1+QI4sJ5J?=
 =?us-ascii?Q?i0kLD79cd+MEwM/mLAyxupSdq/gLrD7BBKqXFl7Y44ioNoPl0mWK5TATp1u2?=
 =?us-ascii?Q?zE6Wb1eyh3EIpne6is+MrVtMWNypx17dgHHHVgc+CJLYDYsCfNaYQfdR3h2T?=
 =?us-ascii?Q?8zUjgKORZ2Hk0jY4wEgHmKc1ujb/dNaNuXz3LYl4fwJSC5+xel//Km5NwJQI?=
 =?us-ascii?Q?D9Tg1Ega1VyoBrIAn/FW+KKQsI+9exeehiOyKPla4F6yAv3dgVMEn8e3KHA3?=
 =?us-ascii?Q?L92Ftm8PpZOb+j/vikKryPHF9ihd4sUBVRTqzQFS13I8BaKwP3j7KAZDLOao?=
 =?us-ascii?Q?QqPRhOpze2z9tokzQqHTJw7hwQQ+SzttR/2JVXKZFZAXKTWPbbdWrTsln2vw?=
 =?us-ascii?Q?J0vBIO5ydcrFgo1CJaeoQJTzOPRmi6ni8WEBaJ72LVm9Leh0lNSywTl5endx?=
 =?us-ascii?Q?spW+HrnL1NwEuDGfvZrRz19MUNxexX40RusYff/ZNwkwH1w8x3DpVmM8eyEi?=
 =?us-ascii?Q?tQsf3DgXaygoLZHqax3nrA8b6whPsCg41N1cmD+DnnRBZVi6zvDtqP2Smo0l?=
 =?us-ascii?Q?xFWV0F1M6VQ3iH/DaFA7XQfuvDjP+ksBUlCrzkgpdNhu0gh9MsYX74NYb3Bj?=
 =?us-ascii?Q?Brqlh0SqW174WyZu2cSKer05v5ZEK5bWuIqooX+cAcLAqIoUzeqp3MTTFyHb?=
 =?us-ascii?Q?8/fc0gIuY3SsDQx0dh0mhoCYSRB3A67lHTwMCFk0IQFfq1Bv4EQy+iksthi0?=
 =?us-ascii?Q?IbFZ0hMc6Puls766WwAR/qRcALgjiHugkp8AxMsN16Jdj6JliQ3CUkP+oObX?=
 =?us-ascii?Q?LSaW4yXXfsZpxuRgkBJjcanqMcllvEelKPg9OSRWI5+EOR7EnlG3yKKiG86G?=
 =?us-ascii?Q?bcSxyCLxDWH1aROjqDqH6ydhWX+sbLHi+K5F22Ln7esMGE9nUgPHANAICXBb?=
 =?us-ascii?Q?l9A4RGvFJ1nWvrSsDpCDJY5w305alxVairB+Mwss4092DY2aFYmq9bA/Pf6m?=
 =?us-ascii?Q?yo5nrAxco5Rbj/z9PqEsUdemRlsHPs1cHes8JyUayKa8qG4uD/pIS/oyjIK9?=
 =?us-ascii?Q?biJ3w8jakEbHVx4toKIa3+Pxd2yFmlRqpjWk40NZx657FTQE+RdppdnVuyiZ?=
 =?us-ascii?Q?e910BDs9EtFmh4sbxhscurqLMJpKe/I1O1BLDG9WuBhzMbus6wvRBvWVvSt5?=
 =?us-ascii?Q?C9fJ2jW7d3dPmNLkasYoEhyaa1BW+QHeOZ8OhQSICCejR9Sp0LAD6yfaw1D9?=
 =?us-ascii?Q?fdgUsMznR1g+9nMHpVlRZt8JgeLiCNi8H+jyu+1OKhxJg0TVuu2/HfObOf3U?=
 =?us-ascii?Q?BMAsjkmc16fx26AdL+50x5Za4/VJ8UCIp0jke+MFSdiaGxbNzs0QmT0fOGIy?=
 =?us-ascii?Q?7R/ykhqbpWHCeFK2fz3tbAqWxY3fIgCqFWWmC4/QFNFS0KUs0Zj8GD9/7idr?=
 =?us-ascii?Q?HjT07kbPHFcB9iMaA5iRsskWKAWHIIqI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlUo1Fs06lgQ8iTNiW19dm26AwMU1HzduHdStTYQmh+XxrdAZbxqsN9iQ1pV?=
 =?us-ascii?Q?qRRF4j5RiTBPFbn+Sgmi6mbsa92mXpyCWjyAhmjfZJVVFwNOIyVxz4iJdCDa?=
 =?us-ascii?Q?PhPiWQoFDEcFiPTBpVvD8NqJeAFGyiB6Kz/3ZAtxLkT6M9r+Yg58y7j76Fjx?=
 =?us-ascii?Q?c1m+rZ78RT5PtPOWIvouUj0FDUU9uT24qD3xUHvrmWMBfGa2h31EXRK5Lv7Y?=
 =?us-ascii?Q?Z5By5vm+CaEp+zTuhXUwF7/Kh6S88RyfyYEFqXR5KZXtO1vCnaxj578DMo7C?=
 =?us-ascii?Q?/OOPMScXZUh+E/PgRT0PIyGsNecu8XBWVNPAirHfwxTGNMl/0PlcZ0bxvCXQ?=
 =?us-ascii?Q?1NHouoI9vl/EvDhlLiQx5kSZltNww40KNEaUCDnVZxd4rQiIh3b5O+f6jMCb?=
 =?us-ascii?Q?0P2Ndlq32lrCgJqLuyS4kY0oUryv69n7E8Nido33FajU1aY4k4pW++BmR5qo?=
 =?us-ascii?Q?Zyp3Gqzl2jcLWvc3lkoG6WHDqAGDBWAu4QS2lSwZxTtp8+vuySNYC8axZq7Y?=
 =?us-ascii?Q?NLiPH3ilVHg3SYqzNYCB527rmbxBNg6a15AixE7mGg8dWUQNl/vmy4fiwNGR?=
 =?us-ascii?Q?HJ6y8LBfQeWGdUZdzSbC03wspCNpsc0osXyir2A4t8ZloRLR4JqI3zajowd1?=
 =?us-ascii?Q?Vl8AaSbopAG75gYQhEVZ24+lM7sTebgsQAaG92wWyokm24cKMG7e9lYPi6um?=
 =?us-ascii?Q?xFsAVCQx6aYaqjk33VlNQs9qVFE+O+tn+51Vb2exfDCytg5sC5TMKPASIMgw?=
 =?us-ascii?Q?Gm9y3l2S3EyFWExm9HC1apoflZkkR+1TCGlJhqgUowztMuSC1ZYRvFecvlwO?=
 =?us-ascii?Q?ALCEtQNYXKT/ah4o9kVf8LqLEZJmqvtYt4HVLSXQGH59rs/vNI10uV2lmCYj?=
 =?us-ascii?Q?QNADpbNhXXplGYvM6bsIG1AjwIe6WA5OePMAlNqZlKuuYFfjd9CZHf+ZFvUA?=
 =?us-ascii?Q?x6BgbcMOfnICR/BtbGC3jrW1144YLXqFoMWWsXFS63Z3T9oiTW41doiXGmCq?=
 =?us-ascii?Q?eqtsUziK2bQz6rP9vx33hyuRBvkT9jVTHNtJ0kffniJPJ9/I0o29H69pvnPU?=
 =?us-ascii?Q?L3K4vcCykskcUJrZ3vwynJkD22Ovo+f1NkA6KrZY0ItxQJS6Ue7U0Hs9QpG3?=
 =?us-ascii?Q?a+UYObtAswxaN4sL5pxgJ2QsSuQd18QLSWsrBAvVXitruezfDRwf0Rns13B1?=
 =?us-ascii?Q?KWJqpWMxynVdDXDQJkTnxNNReO+mk0eMfi52PBmtCs+rBL07PmHd8MPM8Jhj?=
 =?us-ascii?Q?3oD5VyIfly4gCKL2oxn1Wx+oeBv5qSgC/JnUZIj24Ad6JSqO4y9MpXRViB15?=
 =?us-ascii?Q?E+PpFuF3+C/roKo68XJF8zMn42vYVDakEKIqQzFU5FBtWRnKXa1WiWmF0pFm?=
 =?us-ascii?Q?Xznrb6QlknbpoZUXRzoXAC4CrKwFkyf2J416HX0tu1stIcqNwtupbxLDDrtF?=
 =?us-ascii?Q?pHpXka7MzxQi0l7wGxOW7Ptfx/PJHIaE2y4mjzjQ4mpu9eQDAr5p7n9Rgc5J?=
 =?us-ascii?Q?M/3HFma6o9ggvAepYAd99O3ryMSggJMmsd7jdt02fTw7pbYf+hJL08c5hp7q?=
 =?us-ascii?Q?R4cxeDdrYa+3fRPHAekTh7hpEIyUUGDUugNSbVS7kt0WjZTjoCVsAvWqAyQC?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xVuOfJ98WuTW1fyy3tRaEMtOZLcLybbOhuv2xk3T2o3KuOrZvz1++KW/Zftfn8k1elllR+mBahE1f9jhya7piAblSl7hYqCEld2+UYTiGjjEMcfPd+cE+xWiyLstY/pC6RhoJOKPNG/q/voLIVu6iAxfVvEuxP8a5mWSGZS8ZHSpKFOqUsYxVP6IxwxG+jB+jOYMqcKPR2Aq11oozLjC0Ehbjo43mTSj8iQEvD7Zrf4AW/M/mqBDt9SIYNjFaAFki1uea/PwiA6L9S6G65IEj1hKSU6YDblkMdpDQ7JmlwJeyjPfjm1/R7q2OIXTsRdygZE8TEcF0oSv0e4Ge/6Lr74LURAejyS9PGPszXj9guqh5YwJdovw4rGF6+GlnHXI3r5iscFB6wOLTCQO9cR5naU4TJl+U6kNXXL4ZYNKpR5vV/b64KiZ8EpL05ya3ufD+08GAKukFdx695UemzfcIvl95sDIvronnZH8XNxm/tS8izGwPWzX6OWO5dwjOEudjCWx2rfyMtjHDZvzcp2Omtp9sxpBqzSh65hNgQlGEVMl/HWd80v3nd3JXXMxr9L5mW46QkGJycH5xHvZNqtRpDDyI9L6JRD3pQKc6ZwlOyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0400ed9b-6bd2-4b0c-78e0-08de3b9553cc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:27.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDCEw7pjKG0scdDil5T5LJl9g9Njbi2Gvd45OP/VYY7tYIz1iCAgQ1hgAL5bf7dPACtYmvTZS3YFKnuMacD5vS2jjOlxLuFMwxFtAvXaseY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX46Bi0DYRjdbK
 F/qvx9Ni1ZW4ZmprlFbYE3uykIEIRJoyPHa7Ckq48qjQsWrLTyhNX8xhTL1JC9/beMG0ffuLJhi
 2ayrVuIXTaOjyk8tZS8Rx+MWOoSReLGZXsUyoqnSQomESJnvT/eFePnA9zfmco0UxMY3pypivbD
 tatNnsBF6bP04yuBhPUjIuy2+FSO0WYPYv1Ag5un6tp7Yo2Eb/HDRope+u2E0+q4dIX/fz6lX3Y
 rwRYuy31+zSGMaXCAMhtBoYQDAIMNTcSUeo7tTUBCL9dCZIjR5C4zRDeCBLD/+TemSxIVGDh81Q
 a98poxLdAf/JkOVf9hZSINpefG1G6KSbuv67g+JWiYM5FI3AJx3n0tCTMUUwzDfeDKa46cf59ef
 ftWNkn0igMGFP9oX01wCAvpvq3SYehK41gs9PuTqU8YPHLxcLzE=
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=693f935b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=NufY4J3AAAAA:8 a=d4sVeSq9ft_tFhUswqUA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=TPcZfFuj8SYsoCJAFAiX:22
 cc=ntf awl=host:12109
X-Proofpoint-GUID: sAgKRayedR2bDtFLjSGNxEhRR-aD7Nlp
X-Proofpoint-ORIG-GUID: sAgKRayedR2bDtFLjSGNxEhRR-aD7Nlp

Moves some constants and functions related to xloops, cycles computation
out to a new header.

No functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
---
 arch/arm64/include/asm/delay-const.h | 25 +++++++++++++++++++++++++
 arch/arm64/lib/delay.c               | 13 +++----------
 drivers/soc/qcom/rpmh-rsc.c          |  9 +--------
 3 files changed, 29 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/include/asm/delay-const.h

diff --git a/arch/arm64/include/asm/delay-const.h b/arch/arm64/include/asm/delay-const.h
new file mode 100644
index 000000000000..63fb5fc24a90
--- /dev/null
+++ b/arch/arm64/include/asm/delay-const.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_DELAY_CONST_H
+#define _ASM_DELAY_CONST_H
+
+#include <asm/param.h>	/* For HZ */
+
+/* 2**32 / 1000000 (rounded up) */
+#define __usecs_to_xloops_mult	0x10C7UL
+
+/* 2**32 / 1000000000 (rounded up) */
+#define __nsecs_to_xloops_mult	0x5UL
+
+extern unsigned long loops_per_jiffy;
+static inline unsigned long xloops_to_cycles(unsigned long xloops)
+{
+	return (xloops * loops_per_jiffy * HZ) >> 32;
+}
+
+#define USECS_TO_CYCLES(time_usecs) \
+	xloops_to_cycles((time_usecs) * __usecs_to_xloops_mult)
+
+#define NSECS_TO_CYCLES(time_nsecs) \
+	xloops_to_cycles((time_nsecs) * __nsecs_to_xloops_mult)
+
+#endif	/* _ASM_DELAY_CONST_H */
diff --git a/arch/arm64/lib/delay.c b/arch/arm64/lib/delay.c
index cb2062e7e234..511b5597e2a5 100644
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -12,17 +12,10 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/timex.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(unsigned long xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 void __delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();
@@ -58,12 +51,12 @@ EXPORT_SYMBOL(__const_udelay);
 
 void __udelay(unsigned long usecs)
 {
-	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+	__const_udelay(usecs * __usecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__udelay);
 
 void __ndelay(unsigned long nsecs)
 {
-	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+	__const_udelay(nsecs * __nsecs_to_xloops_mult);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index c6f7d5c9c493..95962fc37295 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <asm/delay-const.h>
 
 #include <clocksource/arm_arch_timer.h>
 #include <soc/qcom/cmd-db.h>
@@ -146,14 +147,6 @@ enum {
  *  +---------------------------------------------------+
  */
 
-#define USECS_TO_CYCLES(time_usecs)			\
-	xloops_to_cycles((time_usecs) * 0x10C7UL)
-
-static inline unsigned long xloops_to_cycles(u64 xloops)
-{
-	return (xloops * loops_per_jiffy * HZ) >> 32;
-}
-
 static u32 rpmh_rsc_reg_offset_ver_2_7[] = {
 	[RSC_DRV_TCS_OFFSET]		= 672,
 	[RSC_DRV_CMD_OFFSET]		= 20,
-- 
2.31.1


