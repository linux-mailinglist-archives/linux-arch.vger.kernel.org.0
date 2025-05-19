Return-Path: <linux-arch+bounces-11999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FAABC8AD
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6A4A3622
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE68F21ABB7;
	Mon, 19 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrF03xES";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qRhzwh8y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464E21858D;
	Mon, 19 May 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688019; cv=fail; b=IfWwrJHQXJr0MmGQbbJkd9p1YRwiR+Fgbjv32r/r8hQQHPj4Mv/qTKHA8T1oOGXa8KgiaZOXu0oi4Hx3BHQGkDUb1UU31Gob+st18vLHzbYfZRJUXDzdsVCz9pIqKzMbvg4C8sfThSHMoMDosWTOxEYPpFqQZz73dOJVCiZAyBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688019; c=relaxed/simple;
	bh=0AwaNNTPSEH71EPW/eEj1nIWMBCjuH4MIwtCBzi9V7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujbLXw26hWY4HTviCTZqdRSOZnYosWLN4TPVqtsZRxE0RCgmZYglD7Ob2jsMj2nBh3b9/AZQcdachTS5bgKwyahfWj3gzmP//2dDjVuEGbbZKHLIN+Hbfj11TNwFySaWcd2N7oOQEmPLQVmhXcgVDVejnNxO0VACEXJWvLr4gwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KrF03xES; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qRhzwh8y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMppg024594;
	Mon, 19 May 2025 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NdSaB3ODZ5QBBpEMHgjMGksvaxtpvEjC09m5So8/csk=; b=
	KrF03xES4Bi4h7j8HYGqa+7Ntl8CJ99cSpH6Ejezm3oD1WCgxwW1aOSL21PT6bqM
	tW0C3kixH7f8FYmxC/I4H+dAH7vC0qE9cczfbB+qYsBv377MKokGBkFkXrEoe4E1
	uhm3XaYonFDn4mcTlydbxvoqiOo5zs2z6qceL/OJwF05ccVsDnpoSbHNeQ5aK0jN
	nREviAlw9hXGt8T1wfViP76NlivMhzxy+HlxXVho6FbtiI1xSAX4K/HxvCNU29yE
	NZInC9XpgbH9Mf4nNoIiDtIUN2cyqjqnyugrXxXG6FroVzAE0b2QRY2I1N7JfI5s
	jcXGmqj3OoSJ/C+zbEoW1A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvekybw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JItVHE017346;
	Mon, 19 May 2025 20:53:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e3p7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ploJSd+lH6E7+8NbPk7FmkWQVs52hcoVJJxQTIizZEneC5H1/lNREcv5nOLgkP4+JWCl5LWzTk0xBzPX6qim1nDdGQ5Ky1M0pFbxbvgxvwF+qjbRbyO3XnAp+le+DodJid0Y0qpVfV4qgM7ljImp7QtgXx4M4D3L4pLtQ1WP6+yEWpHUqNzKR4XAnMiFWezP7oubmff24k3udTlmgMjJTCL6kgZnJIpV7QaMCseekQwkt/bZtVnGHxPaKaxMMyT4huf4S1slK9mBpHoFdsiXlGnj10vwyoa8PLudwOQbXDvb9iRJUk7BGykdVUUkjbR4FS3pJbMUxlO1tk1aoUuVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdSaB3ODZ5QBBpEMHgjMGksvaxtpvEjC09m5So8/csk=;
 b=YKGlsWZd+ZldRH5nYI+wLZhQhSQ9e9IANPBB+/leFZA8EWA6eJUuHffOJfdY9HSLk9H9tXxKhmfwmEu/5vAgtGhLqs9JsA5SVLYtEUTOMDYj8Glaq2E6vJQI70cC09/r7193mcEwkH78sidP6bgCEzGSa57fOD+OmU8UnfqB3IYAFtRs3tD4kQ3gV3qGCFVLUciu79KXlzVf8noAJpWQP/ffQOnPZsEXEAZZzugcy93Ps9KHfpSs5aLlC9T60ifHvs3JuDCTCkokmO2azp3bZDFhCPbjDkIjuG7i7hAISqmQ1tsWU11xnKzQzWSRnq7atSBC3wuCZrw7rc6ph7srOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdSaB3ODZ5QBBpEMHgjMGksvaxtpvEjC09m5So8/csk=;
 b=qRhzwh8y9J60r2UG5lIGN3xqq1k3PCEdkPhE3gMIr4jSVcCohFRQMdsNaIdr9cKlnOL96OVT2vwgirzRQtq5r8phxVkgFFOcZTtmZTn9pDRQCQFAgUVOedJ2w7bAbNG/kP+7NqptON1S9lInwvAMZHN2hD0MeSreFnU72JpRB8Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:53:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:53:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 2/5] mm/madvise: add PMADV_SKIP_ERRORS process_madvise() flag
Date: Mon, 19 May 2025 21:52:39 +0100
Message-ID: <516daa1c1ec4b22f45d266d5786375e6d59572d1.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0385.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d73a76-0a1a-4467-28bc-08dd971726e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VV4npRl2Sl4Zg2cLDTcHjIgsBD/3kuiEFJJdZRVeL/umpQBa1wONHmi2C6O?=
 =?us-ascii?Q?hiue3z65IE9mXxdF5p1EkmDVGVq3ApPCBMLNaZbq9w7WTcRvgkvcdygCm1go?=
 =?us-ascii?Q?nBgu1VnfNA+MMhBo8amyj2Pej1QikweDx6npHV6q0gfxpmi1mymjveahKyPJ?=
 =?us-ascii?Q?ln/Q+rkYYY0aIXeFgNVAUuuevJfHJWt9JZnxCPYB279WuQazUEJqzow6X2yg?=
 =?us-ascii?Q?umctuQ3MJv82ZU7864zszd1/NxpMrMKJKztqzJ/FVPoLmJfQixEuoinLBLnQ?=
 =?us-ascii?Q?kViGb9+8U6e9SNILMIb+KwcBsEoSTBzHPnyJkUNNp5AvnSzwpMHTIYcn0Bk3?=
 =?us-ascii?Q?AmdCdoWkv8Y9/1BBBcBgscStq0fVA8oe1AvQcWLWP6HVYxtx/lBzsotsG6Zk?=
 =?us-ascii?Q?eMzFI5d6U4VTFOi4xZXdpwzNDa889ytFLUzRg0ZaNZBOeUuzzb8ADVcckKe8?=
 =?us-ascii?Q?ZL3elSmRzp7ZzYJPqADeo35B+6AUSqrS1+wZ0f72jglNtsIaK/h+4BRqGhLz?=
 =?us-ascii?Q?qyh2XIXibEOuci95Bco4THswAYE4Wsnlk8O3QTA5TcTmNXty+rawA1PVb6ms?=
 =?us-ascii?Q?TuNnP6nbpNHQoEFMX9SHMvSwqJtnk6utPIY+22jTH6oB75LEsJVzS0Gg2fug?=
 =?us-ascii?Q?kSCFFoxzOgcSsocZ1bWEorlzdjVgaKywxT69UnrsWttzFH5CpL5dQ7o34pFg?=
 =?us-ascii?Q?p1GRcSqhbLOYhEEjpdN/Aqtuc7bzfDhKj7SWMzMNRLA2JC+CwlaaVb9SB3YP?=
 =?us-ascii?Q?4YPDKxKC8fjhMdUN9twpg3i6PvHAJjdbSJX6j7JV79NWBaEPTKNrZ3MQQWPa?=
 =?us-ascii?Q?1WEtrH6oSoevQZETFCxhPjF661Zw2LTS7TlBH5rbTL6cOiqTQAvCv9t6102K?=
 =?us-ascii?Q?zhK9T18/R/Q+emKDtUFSzUwGfRNHJMj7R6nXZuoCGLi45GKB55ovAMpeeJJo?=
 =?us-ascii?Q?NoA/8eEwoo0m5BFBJf0Z02pOwjyJKCjMjqho1714ju4JyQJpe5nFm2uN88ro?=
 =?us-ascii?Q?lOOYQ8KgnpJdSz8f1SOuaGs4tRX0izssQBg5QOinfjLbEInsjMTPJRB8YhPK?=
 =?us-ascii?Q?Jk7Vt5srj+inIH7WTuEgAlBARwtEX2At1hTW6rCr92RX+G/X5vVKYgJOO8Yh?=
 =?us-ascii?Q?QB0C0WZxJwShp5pSt7SQ1jXZvlSXse7gYp0L+q1NdpPsh25vuVYpGyHjzEWf?=
 =?us-ascii?Q?GWLkIDscmZs73/yBYABmUPMruSgfGuNo7M3sL/F6Zkumm7K1bKyDktmsjMzV?=
 =?us-ascii?Q?rQXY/PInsjvWgFEDozxmz2hSf9X8IsAVbDBG9pXydC9TciJ8Zvxt6ZU9r1N+?=
 =?us-ascii?Q?PmBdYPC1zhfnaYQgv0QBFtkLNel9Zisp0NlB1AX1Jy2Ej7Cb+drEFBDKjkyR?=
 =?us-ascii?Q?CecjsmcAQcTNttP4SFAb98ToytxEULZThg9brS1rheMRzbb+xFzfoAlA4gyl?=
 =?us-ascii?Q?ZnYzay9PLu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3psXyf5PgVWsEA2K7LY/dtbHg50vH2dOOnfgulNMj0GEyFiIcEAdWwEx0Zs?=
 =?us-ascii?Q?TMO610vJwoHQKCaNLGTD2v/W46E5KWBofxjC/raCM80JFSTfSO6CL4yjTVM0?=
 =?us-ascii?Q?v9jtaEm3icfjbHg1YpIbDFOT2f7b3gJJnL5JBGMo3gL7h4vLhwbuRSS4CzZN?=
 =?us-ascii?Q?Rsa/zVkB1NU0UdN9yTwWTElvtWuU4VWFbSUMvXNmy42ndnWhTG4lKNrY2maK?=
 =?us-ascii?Q?dd1osG6UyFaiF2vMMffiUQgJlCsvzZ4Z6gU7wj+c7djfcN+/R4lKSr9Qffyy?=
 =?us-ascii?Q?3szt5wiUOC2PFFdX0emkNBSWddSeZFUPm72lVyvbisocgYKAD7n2f2zX73Bu?=
 =?us-ascii?Q?bXv0Ms5Sv32P9vgiibm//n4ydnnysbe1tFd5SkVmdkL2VWzWU+4rPtltMtFU?=
 =?us-ascii?Q?HB98gLPQezzkUIs5ypN+Alb7/cIdZilwP7fsrkN53bW9aJK+HyAC95akh+h4?=
 =?us-ascii?Q?U2NtbbePrWTMhpEs0LqZ21rzS7bBGbPm/XmpZktWMEaYyFCMHTSWJV1CzmkQ?=
 =?us-ascii?Q?BLgCGXGq3mtMH4EzRkOJQi1v1hlFZ++3gIWdCsiofjF39h4kJ28DDjaEgc4J?=
 =?us-ascii?Q?i4On6gqzzeJdIBETxFQZQ9c1iJllgqCsWfnALc2GBSE88/Lub/kOcloOPpYX?=
 =?us-ascii?Q?V/CiRgivvAoQYqFgjtvFRSLPbr9Yjf4uxKwNjOeL2Bhn1XLhevJamUsaXxaQ?=
 =?us-ascii?Q?5Dm2rEjs95WPuF9TLV3rQoUCBNFzeYbmI773g9/mZe2JeG7LFACN1ah86y/y?=
 =?us-ascii?Q?2SWiER/I7IeN4rBnBpbbcbWllmDDvsoUkVNWIziGhDrtMaoCMviz/5uojY1R?=
 =?us-ascii?Q?VkaMd9xO/CfMeBXs6+XlqDMROqx7kfoUHZLzXJ3k5GeWZTN+hrCXYqlMwsJK?=
 =?us-ascii?Q?Im/jfh8nFMz/TnpC4TqeoFBbqD/QvMM8zITsJtLZXBNptJoe/yUQnjJGP/QY?=
 =?us-ascii?Q?+cIcwMQ5NUDDed8HGIpM32RpdGiFuMngeDfOI0MVTShRKGsar+lFoRcTPF3f?=
 =?us-ascii?Q?yrlwCTogLKOaKw/rWTFJa+f/zr6O3HNBSqIcxzbauFghGXkW/yfMCX3McjcF?=
 =?us-ascii?Q?dlMsIC8nsnabPSF3W/M4/kSTKhtDH34v+uLpQvDSOzJRXoPb0p28/v5mIxw9?=
 =?us-ascii?Q?fV9Q+blqAS7W6cGyWVJmI+Os3QpqHFtotIoIM6Zm8FWi1UczAkRx0gF8mcDM?=
 =?us-ascii?Q?LlFPjHZci9WYHeppreMgoYNAK/gWc/0UdAvuzk7HHyNiLBPU6LeqrvPgF8mF?=
 =?us-ascii?Q?xQuHOIcav6T2r0aPep/2J1DcmfMlqe81MBtdP07KhC3CCB+OLRhTZE592BLx?=
 =?us-ascii?Q?8LyUvettgCdFVHYDG5wj0IhjQRQ4yNRwQjFZpnnObWgPfY5kMC3Wf5l3z+GS?=
 =?us-ascii?Q?/ept2ZOWbBg1s4k5pIWsxKcwuqejLblNud56zDA7rS0/uhew4tSJ2FUOTv3f?=
 =?us-ascii?Q?1gwJofjAlao4jUlmKmiEsBJFV/J5F7f1Y6GqE0SKdFE08eqKmHYBn01taQJT?=
 =?us-ascii?Q?/4e1suaCdqo7LK+J+aJBieiT/3N1cF70fYFD58Z1iz79tH51GN90EOCQ8gHM?=
 =?us-ascii?Q?49LizG8xX7AzsS5ehzhRXCeY2y9QOCq8Ho3Tm6c9DAo//FYJ18QO0x3xfMGn?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AIWl1QUF9T9t+Ham60x4Pw3WieS/ECassehE1WcZw2RvczH9jhPW3darckADeqPQ7FPoxwIsbsO81Scvg5xKMMP0oyYteVw9TW1sHlyFR0LRWhB6dA6KpcnhBuOH+rouo54m9Fp7puCIf2fFg05PJMV+jfXedaM9MlqwToOXAqHhjO4J4r7zgpStdXcuRDgXAgRgpg34cJhM0atdWBhxsK5KgpmsZ1HuMjmyAWAiutd/lfg89xILwoC6HKCq0+HX8b1Ssx020S285ZaZQ5LFsJLFtD8pXU/LG6RWkfbl1zQpsJvgl24G3Y/ZT2TsNi/+HVdWlw4L716JojhFm6D3Jfm5rGpHFoKsTYp0CoA04Nh+r5Qzz6nd0RYQA1u+Ho9ZuMlyRGP+3biAb4i3Vzz7IIPej0hG8gCNrCGX/Bts6B+a43njL4A//6sGMRkOlGyWAvA1O9BSdEZ/+1a1SUXXEPGrkdlTxXdeC8kzGtSZp6Uai+hKbdaFxJ1N7IUZiUvsDuKZxMfz2wFqHk2aqYV8Lq0jO/3+tDY7bKMadqVkyngW99I0GbWY83kXBpxSOOZkit0DCdazlNOE6ksYR77U2sw/2uUimQFGK077g3L+fzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d73a76-0a1a-4467-28bc-08dd971726e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:53:05.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rduazF9tlW7xlcUUkfnCw3mxlIa7Ky+jRfY6eYqM40hDkHUBWfN/tHJOeSMPGj7U7lipPlusFw9YotzuC26L0IlZAZ9VSkf9dfOgPWRJvLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190194
X-Proofpoint-GUID: FwC5Nzfz6lUnN663VXdY7_TUmnoDe3Db
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b9a43 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=UhmxDJUD3rnAwtH-g70A:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: FwC5Nzfz6lUnN663VXdY7_TUmnoDe3Db
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5MyBTYWx0ZWRfX+tmZqkKa/rRy Y+dN+jAbVgH2xLj6B3qI9SaEIWHs5VjpfhKWLKlX/8P3W+wm3eHUlJBMChGZmtNcTXxZjScraWe L7AhSmC/TtSa31KMkW4zYQ8eYgPYorJ/5jUPzRsh8OfkQ+hSl9/tcjWw7HdmRkoIoznfvOV9IWb
 QPnxqJKW1SMt8r4li84L9++SGtCuDFL75kglwAgi6QdtQ6wO8vjHCN9shhF//p//Fk7/ysBUzXj DdLcClNSZQ9inGzaEdiUOCx/AgkfqviyFN0HqZUDl6431zsVA23Z8qhzaAOVgY4v5eRtjC8jVIN GGt/B9EMgPrv0U225jiiksbxT54rE8tqxCLDDIJZOKveX0jRCcP/eigKOOuztasnLT2L6LaShRg
 D3mnOW8ugZKwnAuYYB2KC8FyQcOUrwOLlFqhA3964smeCKVPIacAVRTUhBCIV0SwExLr9ZrZ

Currently process_madvise() has an unused flags field. Make use of it to
modify madvise behaviour, starting with a flag to enable the ignoring of
errors in the process of applying advice across ranges.

Currently, should an error occur in a VMA (keeping in mind each individual
range specified to process_madvise() may span multiple VMAs), we abort the
operation.

In the case of madvise() we report the error should one occur, or -ENOMEM
should no error occur but a gap (unmapped memory) is contained in the
specified range.

In the case of process_madvise() we only report an error if absolutely none
of the specified ranges succeeded.

This patch introduces a new process_madvise() flag - PMADV_SKIP_ERRORS -
which changes this behaviour - if an operation fails, whether part of an
individual range or one of the ranges specified in the input vector, we
simply carry on and do a 'best effort' pass over the input VMAs.

Since process_madvise() cannot report errors should any operation succeed,
we cannot sensibly return an error code in this case without it being
unclear as to whether the whole operation failed, or if an individual one
failed (or perhaps an individual VMA within the range).

To provide sensible feedback, we instead report the number of iovec entries
specified by the user which had no skipping occur whether internally (at
least one VMA specified in the individual range) or as a while.

We also intentionally do not consider the (rather odd) case of an error
arising should a specified range contain unmapped memory - any unmapped
regions encountered will not change the reported number of ranges
successfully advised.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  3 +
 mm/madvise.c                           | 92 +++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 16 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef1c27fa3c57..a5e4e2f3e82d 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -91,4 +91,7 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+/* process_madvise() flags */
+#define PMADV_SKIP_ERRORS (1U << 0) /* Skip VMAs on errors, but carry on. */
+
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 63cc69daa4c7..37ef1d6f4190 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -51,6 +51,8 @@ struct madvise_walk_private {
 struct madvise_behavior {
 	int behavior;
 	struct mmu_gather *tlb;
+	int flags;
+	bool saw_error;
 };
 
 /*
@@ -961,8 +963,10 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 }
 
 static long madvise_populate(struct mm_struct *mm, unsigned long start,
-		unsigned long end, int behavior)
+		unsigned long end, struct madvise_behavior *madv_behavior)
 {
+	int behavior = madv_behavior->behavior;
+	bool can_skip = madv_behavior->flags & PMADV_SKIP_ERRORS;
 	const bool write = behavior == MADV_POPULATE_WRITE;
 	int locked = 1;
 	long pages;
@@ -978,6 +982,13 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
 		if (pages >= 0)
 			continue;
 
+		if (can_skip) {
+			/* Simply try the next page. */
+			pages = 1;
+			madv_behavior->saw_error = true;
+			continue;
+		}
+
 		switch (pages) {
 		case -EINTR:
 			return -EINTR;
@@ -1254,12 +1265,11 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
  * will handle splitting a vm area into separate areas, each area with its own
  * behavior.
  */
-static int madvise_vma_behavior(struct vm_area_struct *vma,
+static int __madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				void *behavior_arg)
+				struct madvise_behavior *arg)
 {
-	struct madvise_behavior *arg = behavior_arg;
 	int behavior = arg->behavior;
 	int error;
 	struct anon_vma_name *anon_name;
@@ -1354,19 +1364,38 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	return error;
 }
 
+static int madvise_vma_behavior(struct vm_area_struct *vma,
+				struct vm_area_struct **prev,
+				unsigned long start, unsigned long end,
+				void *behavior_arg)
+{
+	struct madvise_behavior *madv_behavior = behavior_arg;
+	int ret = __madvise_vma_behavior(vma, prev, start, end, madv_behavior);
+	bool can_skip = madv_behavior->flags & PMADV_SKIP_ERRORS;
+
+	/* We must propagate the restart no matter what. */
+	if (can_skip && ret && ret != -ERESTARTNOINTR) {
+		madv_behavior->saw_error = true;
+		return 0;
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_MEMORY_FAILURE
 /*
  * Error injection support for memory error handling.
  */
-static int madvise_inject_error(int behavior,
+static int madvise_inject_error(struct madvise_behavior *madv_behavior,
 		unsigned long start, unsigned long end)
 {
+	int behavior = madv_behavior->behavior;
+	bool can_skip = madv_behavior->flags & PMADV_SKIP_ERRORS;
 	unsigned long size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-
 	for (; start < end; start += size) {
 		unsigned long pfn;
 		struct page *page;
@@ -1396,8 +1425,12 @@ static int madvise_inject_error(int behavior,
 				ret = 0;
 		}
 
-		if (ret)
-			return ret;
+		if (ret) {
+			if (can_skip)
+				madv_behavior->saw_error = true;
+			else
+				return ret;
+		}
 	}
 
 	return 0;
@@ -1416,7 +1449,7 @@ static bool is_memory_failure(int behavior)
 
 #else
 
-static int madvise_inject_error(int behavior,
+static int madvise_inject_error(struct madvise_behavior *madv_behavior,
 		unsigned long start, unsigned long end)
 {
 	return 0;
@@ -1721,13 +1754,14 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	int error;
 
 	if (is_memory_failure(behavior))
-		return madvise_inject_error(behavior, start, start + len_in);
+		return madvise_inject_error(madv_behavior, start,
+					    start + len_in);
 	start = untagged_addr_remote(mm, start);
 	end = start + PAGE_ALIGN(len_in);
 
 	blk_start_plug(&plug);
 	if (is_madvise_populate(behavior))
-		error = madvise_populate(mm, start, end, behavior);
+		error = madvise_populate(mm, start, end, madv_behavior);
 	else
 		error = madvise_walk_vmas(mm, start, end, madv_behavior,
 					  madvise_vma_behavior);
@@ -1836,7 +1870,7 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 
 /* Perform an madvise operation over a vector of addresses and lengths. */
 static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
-			      int behavior)
+			      int behavior, int flags)
 {
 	ssize_t ret = 0;
 	size_t total_len;
@@ -1844,7 +1878,10 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	struct madvise_behavior madv_behavior = {
 		.behavior = behavior,
 		.tlb = &tlb,
+		.flags = flags,
 	};
+	bool can_skip = flags & PMADV_SKIP_ERRORS;
+	size_t skipped = 0;
 
 	total_len = iov_iter_count(iter);
 
@@ -1886,18 +1923,41 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 			madvise_init_tlb(&madv_behavior, mm);
 			continue;
 		}
-		if (ret < 0)
+		if (ret < 0 && !can_skip)
 			break;
+
+		/* All skip cases will return 0. */
+		if (can_skip && madv_behavior.saw_error) {
+			skipped++;
+			madv_behavior.saw_error = false;
+		}
+
 		iov_iter_advance(iter, iter_iov_len(iter));
 	}
 	madvise_finish_tlb(&madv_behavior);
 	madvise_unlock(mm, behavior);
 
-	ret = (total_len - iov_iter_count(iter)) ? : ret;
+	/*
+	 * Since we ignore errors in this case, simply report the number of
+	 * entries in the iovec which were totally successful.
+	 */
+	if (can_skip)
+		return total_len - skipped;
 
+	ret = (total_len - iov_iter_count(iter)) ? : ret;
 	return ret;
 }
 
+static bool check_process_madvise_flags(unsigned int flags)
+{
+	unsigned int mask = PMADV_SKIP_ERRORS;
+
+	if (flags & ~mask)
+		return false;
+
+	return true;
+}
+
 SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
@@ -1909,7 +1969,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct mm_struct *mm;
 	unsigned int f_flags;
 
-	if (flags != 0) {
+	if (!check_process_madvise_flags(flags)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1950,7 +2010,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_mm;
 	}
 
-	ret = vector_madvise(mm, &iter, behavior);
+	ret = vector_madvise(mm, &iter, behavior, flags);
 
 release_mm:
 	mmput(mm);
-- 
2.49.0


