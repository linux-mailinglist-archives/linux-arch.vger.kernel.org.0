Return-Path: <linux-arch+bounces-8158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC099DF46
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 09:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED12A1F222B6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094118BC13;
	Tue, 15 Oct 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z8Y9wuRV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qt42baIH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED369474;
	Tue, 15 Oct 2024 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728977289; cv=fail; b=BfahOI8vdMPC66bRlfPkBfnpYHftKRu/h0jXbzBA6JsCpgx/W/IOMng/joO1hjTPfIGx54katG1TgGbMqI+9wai7w4dXaE/uQH40qRLAZ8i0pAwddMqrQtHfNJ2lJf9xkor8VBEl9OnpCMf9r1ErQKRbImQJQgMygHeT5HJdEKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728977289; c=relaxed/simple;
	bh=LBQoN87juWF1AVcHTAVdlz4ei1En64gtGZvNUlMXZl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JLvHxiIqivaOaaRNZ+g6msyBFUkzkZyiEz+Repyc8xGy/E+t8jYmvWhYNR0ZCU10qPl3/2kwgn/2jMPsSeXge/U+5BdwUo0k+KaZNnbQtF9cIpWtArjNDqEDeVZBG4Zub8Q0OyVh528VCZevgT1ZwV/QFAbRLyB6lwUkzRhd7ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z8Y9wuRV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qt42baIH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6F3pa010187;
	Tue, 15 Oct 2024 07:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zzdMLcxOc2GAVZX0XT
	H3Jrv+da90jwdagjuoUP2a6Pg=; b=Z8Y9wuRV8lV2+eUBnLoTGMT0SjoMPZDH7S
	ZJtLpOZmkp/b8p8YD9TbOA/YiiZjZUDLUkAeKb4Y/xCOMcSAI+tVQdge4b+VUZaX
	wH31Bh6uJM2/6VlrfrMT8dVOkbMucXyEZmNDC5GC7tSOO7N1Q6ClR24iZwfbYeww
	/HdeXhtJTFk0Mmo/Jhu7xCfPMa1IlTS9JO95NCmZ3OdbDVK4xYkPONREyEWEYwsu
	6ccLs4KYGQmLRVMlQ+fnXjNnrYYkswbPTDBJDXvDr2izokHn5G7G8oBQqSnGvOEd
	qS/DROY0vLTa9uYWpJgYCZzYdRSWuFuNbYHRtvuyjxkwxDg35xPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqsyxvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 07:27:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49F5dFxl019963;
	Tue, 15 Oct 2024 07:27:21 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj72rm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 07:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU9BcKqiECHAuEJqiIcoA/IlZoCVNtdsoforXSkeEMsRK7EJkuRFDrmviGNQbeLNLH/MrR1EMCvg2rKR2iXzLytoxkByuYJjBxhQri9U9YM32vNjUtfxW9fUFRWsgs3RDUnVz4ykhLGjORnRI65CQgOf8sMgMrrrLjRtBw8y9uYYIlEaCgueT2QVtQfsI73aPT+qq9raq2gihRcE3VHr5NQNBfeceJEBN03VReB0ohPTgx0oKFBFL78/VjBnb5KSpCU+2PgPgURosH77B2GB0ZsPEIJ9gjKinEU+8J/+K1KZa9aP558d4Ha2zXzbQNWGPcGs5lv0y8raHg5eOTCL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzdMLcxOc2GAVZX0XTH3Jrv+da90jwdagjuoUP2a6Pg=;
 b=Vv+duTDsx8RYwhYooIc/DZac0wYDHE7GwCo6RbQnjilorQX0XF1UKIbK5O/AH4PVtOgq/hLPkRX7WpJvdIP1z8MJfZFzEB+X7fDwTQs5jEKH7Pei7ytbep0RhV04Dc+0P6ZYdjA4zPOCNNgjo6C1F+Ecu2Ez00UJXPrOQlWpMgos9JU+ra5Av7kGlyi5yoDo2yywSnLTCSo57/vTpwBa5dAMmKCW92h+aHQ5M2o8C8/q7TlZYx1Iv+09/KQPJQNzNgbebM6ayDR0RpFXq2FIc5tc4OsBJ41BfJj2g8bh6aQAOIdJrGBmsYHVIcohbgVbDZGybzlnW85SiSfHOWlr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzdMLcxOc2GAVZX0XTH3Jrv+da90jwdagjuoUP2a6Pg=;
 b=Qt42baIHCOrOIF9tbDC0iO7tFV6cjO5Veg1kJbw/A10eNQee37BBZRHVyYgfBx2RjFA9RGTn1EL5aCoCFZ+cEcJYxw6OEaZO+mHAMIE+/2UqLpEOt+6Ng+BLY4CK3h1nWQKG4f+cwIwckUxX+53HOdDUFdHoAfFrSkOG7ODZ3X0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 07:27:18 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 07:27:18 +0000
Date: Tue, 15 Oct 2024 08:27:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: Re: [RFC PATCH 1/4] mm: pagewalk: add the ability to install PTEs
Message-ID: <09af9d3f-2165-4580-8cf3-9278ccd349d1@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <59e218670565accf978aeb8cf4745de4c0738773.1727440966.git.lorenzo.stoakes@oracle.com>
 <Zw4QHoPArxEQan0G@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4QHoPArxEQan0G@infradead.org>
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 836ff358-790e-4b59-07ed-08dceceacceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b3jMLWbgvsZphwv/mRIH2l+dS+VKo53GnU9KXHW6EiEDKk/HAkSsDCZP9fNE?=
 =?us-ascii?Q?JLbe4P1bHdY+7lpewrl6GMmVwIzBLEySwbG3dgNU0iXi3jLU+vF7FDtuNbhS?=
 =?us-ascii?Q?VfQmouwTUQL9s08y0Gt9XDwyWJtOkBxxSRaYCYJszjQ34H+YZQ6sLXO5Wf4e?=
 =?us-ascii?Q?ILqS/VSiqkQ/2wx9zVXA+1APp7mrofu1K9TZYo8MRqZ1vw9NN39XvzBR6Kzu?=
 =?us-ascii?Q?tjXKn/2ajgK0qnMOp6t/EeVNO6uihmsLBNZqdxxLusCfZIYB55aiIB98ZMQJ?=
 =?us-ascii?Q?iFMe5mM/MTe3qvL+hplNawO3ABUg4XeahSWf3KCED0jBXBHsP+VWfms9F83n?=
 =?us-ascii?Q?WtTGVIs6ne5fBm8cdxCQoCtYj34rG0W1KZ36Cz6OKgY56C64DfvVyYUOcQS3?=
 =?us-ascii?Q?JNO+LFYZyKCYqzh3wwbgOwAi9W2+C43SGHhKimzWiUkuKN3JSM8LPvT+edDQ?=
 =?us-ascii?Q?f1GvPu+geutmUF9r05dQvdPNWm59af1amkgIlnL+BDIy40vF5EsclRz0s5i0?=
 =?us-ascii?Q?Tjz6BmtXqx20tHZROUTQCRrMqW4TqGzk5R0Z1YeivgTHDF2SHKPhCqtzDea9?=
 =?us-ascii?Q?sWIQUZ70VYLZl+ev3DkQqjS4RbpjwIVWV/qI4oXnQY5By6KAYrL/loxOOUAr?=
 =?us-ascii?Q?ul+idk0+aWkuAwSx6m09JOTSn9dLum3qCRMPQYMk6b/wXuBCY3RsZbfXna7t?=
 =?us-ascii?Q?NemHxGvP8T/HWZd/O9VWNPutlHsuvyzAM7cJq/O4y27z2kUO5bnaWOvadp2U?=
 =?us-ascii?Q?F/fvTOYOE8cWkwqeP8co59gD/+SQhZKsQUOgN9DPnujl0znb7NyFFUpB329D?=
 =?us-ascii?Q?TCTLeg4vUlObTo2uZwLx3u0peP8qkefMZn4FRosWPKm2nYEfSDEO2L2xlYZe?=
 =?us-ascii?Q?gEsYlO4CUSR3XZTYjZLfWukOsZTQ93A6jEGB25peXdIpmr19Zll/k9Yt1xeh?=
 =?us-ascii?Q?F5nxwcCG5V52GfDFUczWg1xrk7ex5eeZGJIMatqXkrgbM0Pw1Jw5GmmF4IYD?=
 =?us-ascii?Q?qN6CDD08dDWasrwmsB7DMSRWSLh0o65N+rAraBZCWGqYNfsW2Ra28LU2utcH?=
 =?us-ascii?Q?tt1rQAgG2e6q6zaPo+JZ7burOQ0+QF0Y7BLKBYXsIDBEAFi9+cMslCN8wSSs?=
 =?us-ascii?Q?HZ/f1GaY36XKfBRoLNGe2GKKelvwECwPQldKX8lAEIeN3uKZ1D1acnIZCFTu?=
 =?us-ascii?Q?FXe8rtbP4Qch3dW+NtWwPSPSkWPfR4oeFnqoeDKI72F4Nl5zxjiydVWQVfTK?=
 =?us-ascii?Q?ul6z9uwXFPORG3u1PE9w7fqrYImyfmv02WSy3jHAPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fW65D5cDOF2oE9ZPFCXPobcDD5GAHUu5HePiK7R0zr+kslZ4jFaKoV4EL8BX?=
 =?us-ascii?Q?rqaDkBa6yS3DBzeSMNl+VVCZqEqF6tAFRO7PYQM1kBmIXimlEFK+lopsX9Li?=
 =?us-ascii?Q?bpSwi5ow+TP2S2O/QXcEAEc2oqa+hdm2/pDG52FFgRV6XSbOw90ay2ocXSEJ?=
 =?us-ascii?Q?Q1tTZHBbyIf5+q/Aod2vXgovWyAw0uVmMZbewtsqZrrY1AliA/wmFcsdCoE9?=
 =?us-ascii?Q?r5TgYpysYkFGMRSqph17DPRVFKqwF+dLbLiPwI7I+GuYqogqPv468X9FuLAo?=
 =?us-ascii?Q?XueXH7gc8VSPZvjILnu33FqbGaDyZRNt9cisRt/6KfyQLF0QWCB5fmNrweMf?=
 =?us-ascii?Q?oqV07yOVI5DS5jkPIeqHgtJLiLhicp28hXvtJNSKF5SqRh/TglojG9GgrswZ?=
 =?us-ascii?Q?CB51h6UoM804xaqX5jdgkcGtDA2u/O7PzYmNW5HlPjCfZyyzG+p5w1LZCrVe?=
 =?us-ascii?Q?ijxV3lzxF0D8IvG9LK5k2nupCP15mQdvOKUJsFCCno8oyT1cNDWDtZq7FmAX?=
 =?us-ascii?Q?Kn/IzyNJutTwc3Nu6+aQWev9KJmZyPDB5OdvmUMR0rUzdrHEUag/Ufsb4Dsk?=
 =?us-ascii?Q?OTIdjqhrNgP3r2pvLjHbTLgcyV6qf7LT3y+F+JXtl2uZRxKlDOCUhAi7TEQ1?=
 =?us-ascii?Q?9uMcmjFEZ9gZ4X+U012wTGD45Hp7J8FOFCnAmIDTYsn6057LGyhEYx2Ixl/I?=
 =?us-ascii?Q?oR9mpCTPRiV3ijXKekrEbUIDNmbTkEu3LeP5C2E03JQIafZA9USICnp+NdF7?=
 =?us-ascii?Q?2h1vktOE2cG2lj+ng3gjLBACzcGh26QIeoFUg+HLO9Hx+qU/A8xhbUEYAXLD?=
 =?us-ascii?Q?BcZXg+WT7k8C1hsRLdmhf/pp/84qQdCrrelTlO8E3djqvMy0CtdHlD/M/FvH?=
 =?us-ascii?Q?vycw2ieLnfHR0PM7/z1Ccm21YGT0C9j9Ltp24P2d7AHjj55yq/wOgbimN8Fx?=
 =?us-ascii?Q?8oj7dCj5FVcWuGr9J0VN7zdBL9ytEv7nuJvgEkFhpqXCPUx5rlZHcq9w3/J/?=
 =?us-ascii?Q?RpQyzPFEoS2Ds8apbBKIEzQp2C8kD02YJQ24J/3KSgqWW+clFt04EjUi7jCv?=
 =?us-ascii?Q?3jULM3++JpiHpTxvxwJNOqcZuKocDLoubEp8e2PtKpOTAhyVGHpzPV2YfRTV?=
 =?us-ascii?Q?C/LN2TjKiTYZZIUKZ3xwcj90RcEv+TK+eewhw4wDt96SSiXH++Em7ERG4UoM?=
 =?us-ascii?Q?1jeZ3WwCk3nuYcjxPTu5iXtQP6H2o7em/sLVR0HG/luJIuegwcmRyJkKHuEB?=
 =?us-ascii?Q?DUzRNx5sQ5Nm8ByDTCwoTTmtMVpZTcpnbNU631w3j9k91JM6SzECGn2WEa//?=
 =?us-ascii?Q?sAh9FqSd8BG6gmcuGMWyHRzkFoR/jojW3WdqU1nTTBEG+fMCrOR2FJyh+izK?=
 =?us-ascii?Q?vIUAri9hYqamFl/MezZfGTYrrDcbtFS3fzXoBnrR52F95e9spG+OYj05M7Rp?=
 =?us-ascii?Q?wcy8hhQO9h8yKwDmiNAhjrAe76dcJ1ofFI9MHB3SBqNAjvtjizFVFDhdr3rz?=
 =?us-ascii?Q?/OreZnbSp8BY+Z6znK/To27See/iZPhq09Nml6hVtmuwgoTQR2ggPlOwti0S?=
 =?us-ascii?Q?oCGcZKnVKPluTWMGeuGtAAHrxltNLL2QVuGSsQT1f2gOSEv+LYTbSugHQ4pW?=
 =?us-ascii?Q?6s6eAIKTsg3zmhyPH01KS2lXIHa2yMA3XCDharjlfnYnvQX2y1A0ME2oMCz6?=
 =?us-ascii?Q?HlbPlg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wKHH2057gcqYce2KBCMGFJ4AZzoyFgDNR1/+AenwVQ0qR7WBgGiZ+RG7n6+YUPDs99yPKKDfDlacE2QPDu50oxL9iO06Lizq+33vdZqGx/ltPwOwx2FROmjve834f/OOnBQ6kldJGIvfZ91ukPGDwi58b+5Qwx18oXdrdCrXrQ9SanFU2ocNg5UaAuqEpIyyS6YVzYzMiNeY956QMFnd2jJEoG2llvCz0azsy8l+rDwLYeitCI+gKTID3iu2yjO4PDP75aJGEab4ycmm4N86kLnLo2POEdr4dN+tLM8VgLO8L5eFWEat1KoSLN1H+eaNHSu79bRTjkYlHniFdrjIrBBVOXYP2GqMwxbUBE9PlbOTKSrf6QGpvOdU26v7u3js0qrvnUe3ajksXZyvkcp7PzaAHSnnymMbt0RtufvIfAwexB62eBJAMaNAjgHI6MwYS4L7gz1Tc+Qs/NIUPtVr1GCjz11Fiw6VvSu8GCoe/t3z7Nujmf6bL+OYdf/jXEo8mmXQ+XBozTe8PV9ggDIt1YTtNr93fmuWqnwUCbOI75Hf42Hr7c+uHDJlbGFHG6PG8a7JO8g1B+kodQyiN+9sSUitZc/G+qQwYqoIdccv95g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836ff358-790e-4b59-07ed-08dceceacceb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:27:18.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPieH1gKq20wJY6clPspYKkH4yPII0YxoRkCi5eTYaXwRPo10JI1a+dMYysEm82FsFLbOgcKJo86U0ZcBHnf8+ysYUtsm4PanQC2vsv8YAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_03,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=913 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150049
X-Proofpoint-GUID: Q-OKsRZAdbWZozWyMqeSV04LRPcVgHbZ
X-Proofpoint-ORIG-GUID: Q-OKsRZAdbWZozWyMqeSV04LRPcVgHbZ

On Mon, Oct 14, 2024 at 11:47:58PM -0700, Christoph Hellwig wrote:
> Hi Lorenzo,
>
> sorry for only replying to this so late.

No worries, and thanks for taking a look! :)

>
> On Fri, Sep 27, 2024 at 01:51:11PM +0100, Lorenzo Stoakes wrote:
> > The existing generic pagewalk logic permits the walking of page tables,
> > invoking callbacks at individual page table levels via user-provided
> > mm_walk_ops callbacks.
> >
> > This is useful for traversing existing page table entries, but precludes
> > the ability to establish new ones.
> >
> > Existing mechanism for performing a walk which also installs page table
> > entries if necessary are heavily duplicated throughout the kernel, each
> > with semantic differences from one another and largely unavailable for use
> > elsewhere.
>
> I do like the idea of having common code for installing page tables!
>

Awesome.

> Minor nits below:
>
> > +int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
> >  		unsigned long end, const struct mm_walk_ops *ops,
> >  		void *private)
>
> It would be good to have a minimum level of documentation for this
> function, including how it differs from walk_page_range and why
> it should remain internal.

Will add on respin!

>
> > +	/* For internal use only. */
> > +	if (ops->install_pte)
> > +		return -EINVAL;
>
> And this should probably be expanded a bit, including that no exported
> symbol should allow inserting arbitrary PTEs.  Maybe best done with
> a helper to share that comment with the other places that have this
> check.
>

Yeah a helper makes sense actually, a more general 'are these ops valid?'
thing. Will update on next respin with some explanation.

The next iteration I plan to un-RFC as seems generally the concept is
unopposed for this series, will make these changes then.

Thanks!

