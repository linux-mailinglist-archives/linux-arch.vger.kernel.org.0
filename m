Return-Path: <linux-arch+bounces-8305-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910039A552B
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75AA1C20E5C
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345619581F;
	Sun, 20 Oct 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ei3vQIkl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rXyj0baI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE265194C6B;
	Sun, 20 Oct 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441275; cv=fail; b=gEE+TwWpMubl4rFzkq7ac3oDHZLfpisijfeidmoN0Hp7Ooyn6z9gBoVE1VxKDcsGIAyW+rb0Dtas0k6cROYiHf2UekHNism7LktF/Y5HPJrHMme5wNqZJrFldjJnV+2qYuPYqzCS298AD/VSotYGtVh8SsNfcUxvyMfY8MN+wTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441275; c=relaxed/simple;
	bh=sjjFz9E4aTHiMF007oK+Xu+zSo4I2HHezKX/xjcZTY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CBfNTWp0s9RkKtLMOmloG6/MwacEAgqDpu1UA4xICi6+b40829i76QY5MX9AR2yxCmtHDb0Vut8sT+addtQ6d6HuBZJeeCgHz5u0VPNY7Wb1kHOu1keqjleUZkHAJx2MRn7B5RUbPy9A50z6rv6tmmGCue1FhNQ1zJUWRI6baDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ei3vQIkl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rXyj0baI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KDC9II011703;
	Sun, 20 Oct 2024 16:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fRzZp6Oobr+FLi4PT6KQdTCpdyNKg2FQUH4AiS58xHU=; b=
	Ei3vQIklDQlraNeWIn0wT+u8DW7Mo29Wom+Z15o+9x0tjTVI5gbDIBXXxayTrCiB
	3vqjqCJFTf7Xoq+sM8Ei9sxrhufiQHaQiMxDgTPWXuIotfcNrHSYGJJb/pfO0plq
	Hsgnj7HvcH4SrmCz7YFrxpwD/Tfb+SvNzVlQokZ8eS2H+/mKOUWYLtvwB8BZ/tDH
	Ff4eYiMGznVSa3wnkDXc6VNgGVnUCPF5Omq5cGa7kIbeyatXMQRuRSNOSuVC2daS
	PERMA7ENLFfYLuN9fZjVOGgXWiDSasBGeGPqZNE+s0XbIcI4DzyDkzE0mrvuvsHR
	2CiJfqdbBtXdXseavEPOFA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqs3j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KCWxoC026253;
	Sun, 20 Oct 2024 16:20:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c375g0ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TWsxDLW3BLtelurwWJk9dt0Fz++H08QHrf8ljxNPeHU+2/CsH9unm4uMkjl4EXdsEhaZxRXIUSXftz0Y50SGL9ZVPsSW4W55yPTnYjoMov640gPdRQ0dUvdSfseMfazQhIZI9z29LdKYcko8XhDjEz7RYwC7JNGyzuNwqyEpUo5vJmnILCFXyGNwCzsvO2yx/mdeqVTQFqbOt43G4LjD+1yjwBW8uY7TYwTnOOcZXcMhWsLraQ+efhBKRNU4nNl9dEw/MtyXMzm2ND7QK9ynJTo/hXrjgblJfehWPx4fLx5sQHnKhVoa2hXxT74OcTtsBoENkcOusuPeq99NhpwrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRzZp6Oobr+FLi4PT6KQdTCpdyNKg2FQUH4AiS58xHU=;
 b=JahTTvac7bdYu9NBlXxDRPTU6+vz2v1I6lr4P6iQLb85sbNnEHVkq4dSM9Vyenv180mhuab5qDBSxOJXfaRnWx5Q1TV8j44v0D/Kh9uQDVQR2nLoRTd5jap40JEy8Kh1fGTJF4cqCqa7SnIei/uPcN67EqtIVz8l9990PLuzdmtcLzkWv7mJJbjXfbLkfO/06yC18rhsE6jGWRi0kle1XmC4WrUC6b15nWD0Flg5AGKof5aD11MuS6tVxKDbrMWEwodZ2Z0IWYgUgEnk6oDPK93GARfhJsmvKioHVoM07jxoQk01I97psVO9dzpfNb4UO+VckEOdxWRM+gJSs8WOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRzZp6Oobr+FLi4PT6KQdTCpdyNKg2FQUH4AiS58xHU=;
 b=rXyj0baIInskoGJqKx+qR2EbjGNOhIFJ2P+3KbvSzuYbcZ+HAJOQe/kRqx0UG+sMVFXgUZZr0QlSlaHIfDvuEYezfAZNR3ImTcskRvm23QzZoSh0c+nAUALDqqFA0UEAmx7lDHjgps635Xu7ocOs579UsuqlRL31e6dV1lRRJe4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:26 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 4/5] tools: testing: update tools UAPI header for mman-common.h
Date: Sun, 20 Oct 2024 17:20:04 +0100
Message-ID: <6899594f48ef250d6984bbcb90877f92a0cb1753.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0052.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 61df5ebd-887b-4ac0-42ab-08dcf1231b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jz/5RKdm1Zoxkhkjuwukuygpqea+CGFh2gjbCRV0dt7xQredpzXz1uSBx+9a?=
 =?us-ascii?Q?gh1yKKhnUNUZq+BdDaE60/9mph+gAQhkjxvZp3Q965W9JOUvi8dOCC6a0Elu?=
 =?us-ascii?Q?adHkgBtfNbpUSwwd6QMnDIXcMTcU3alo9bwpYtSq66OcDz9mMXH8WUGM2+/c?=
 =?us-ascii?Q?SG2OWTkCHo/ZNjJ/LDyYfgo3GbJtYMmv2oB0wa8HIL4BS8pWK2v3VTyfzfIz?=
 =?us-ascii?Q?n/m69Dea1ycENumFLuZrLGXFMnv7lDDaPrNSV+Z2DEpRvEcQYRmY4/MNxusi?=
 =?us-ascii?Q?+S8oqEUWzvIWLQreJVZPNSYYalGYWwsurBuWDVq0rFSSL5NIFk5DhteYIWR7?=
 =?us-ascii?Q?mPVKeP4ACxQ+NiW4H3wJS/Jg9aeu0/4Wgo+bN1XObL3bf4UWCGSX5IiCsRoZ?=
 =?us-ascii?Q?ccdc/MA4zlyEPlZ2B8D9+ZypWkkPMxVHN0YiUi2lMPxgaEIfOLrbJ2uNTv+7?=
 =?us-ascii?Q?FVzTPPszsgDzryIfzjnzC0OMQuCkNDp0/Ez16ShZ2kEy7+POPPoYdodhZnW3?=
 =?us-ascii?Q?tppFbw+RKkCIAO3rntJMlwK8QhXEkXG97Wyob8b1GWkgLH0YAiurbc+YYaam?=
 =?us-ascii?Q?qjqWguF3DBPdbWr+IzNqjioIAJr7LQmOzMGE7FzqwCN/zYijmVxP0iCSCDBN?=
 =?us-ascii?Q?93zfD7MovqvfxWYTpeG48ZFvJUnENQVMBWMAhnBr2yrPBt7D4n3MQnz1xkNW?=
 =?us-ascii?Q?7H52V5aN4tnaIiOhDcizcqeN9ykj870Fx17GKMKP5wkt8imknDqyTSyOBOS6?=
 =?us-ascii?Q?MqVRysSi2Eb0VdPu+O5kVgauSQqtMxDApa5X6q0FT5gq6sW2X3s3jL8+7d0x?=
 =?us-ascii?Q?pGuQmcvdXQQ3/QIz5TuDm4jECnEcGC7Ma/IlEW6DlRxG7pRkaDN8yHiEyQVp?=
 =?us-ascii?Q?0R7nBMUnPHp3Xg3i9A3smTF/SrvkwC3RVQjax2uss9eSSsJM1UqyWwWD7+sK?=
 =?us-ascii?Q?2IBgBGIACb4WLlWf8773wqR3eMAFKwTruPEW3fvOh6ZIviAkEsb6dL19x8LJ?=
 =?us-ascii?Q?BGDuA8iLZlfWDlkQxRctR62HUgIdCoRzJkh9t5CFoE20tZ4PSceu0RAQrLfR?=
 =?us-ascii?Q?CeJfMt2r5Ch6L5vusZvgtevp+/0sTFJ1ScZ82csdeFV1KMXDO+JyoQBDfYkk?=
 =?us-ascii?Q?SUe5v34UP2ig9ZmMlgFwzUmwIoWVz9pZVLuynQN9OQrauWkvfaw80Gbb9Wfy?=
 =?us-ascii?Q?rqQIQubNqT0ZSs6ah/LZ2JCjkh6IEsEGheG88QFqE9uiG+4xqG5Sa2zgPLYB?=
 =?us-ascii?Q?E0Lf9DC4TlBSh6vWwvKIYpnPLsMYCNxeNr1L9siPKTyebo4kvB+/ivOeqwKo?=
 =?us-ascii?Q?nC3QUrmbhV6zeeuzi/ey5RWf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTf/BVYKYS9hXW3uVyli90jhKRuoEFbAK0R87gW8sMkJL1aYA9X3QxMj4Otj?=
 =?us-ascii?Q?6Rkye3znBsRIo8FawCSCKybBJNE+5OSTY/hes//4SF68kyuRF/zCPNwI7dRn?=
 =?us-ascii?Q?ssTLG+68nomSVVma1JxDwJcbB/uaQVzhY2FHi5eUgSFDN4jkxVzdkR3zb2uS?=
 =?us-ascii?Q?TTMp1wyBxZzovkVkjBOQuY8RdRWTrhMbWVyhJLaFwI1dVPw8r1W7VEcXE1dO?=
 =?us-ascii?Q?+Mp02HjWHaU0ja/rO62hJ6mGJZeExKB1wqt6X3ea/YDxaI8/T/2UCjV3DImg?=
 =?us-ascii?Q?35OOJTPufNc9c9USEGQCUzZOCp79mvU7wtrP/uTuQg7gezzN0AbjoRB+ab35?=
 =?us-ascii?Q?n/DL+iicSEwoFdlppCVuDIRusnXBxoaaECZxPlcfLbjl3zlban+PcHbUMJwi?=
 =?us-ascii?Q?H2Gtsa3gaBHnDZuyB7+NeDnS8dNHbfBrJV/ILUztAU/A1TQVH/PQHlNHg0/a?=
 =?us-ascii?Q?HDPqMf6rogC/Y2+tCCW2QVv3C/zXGAKsyimHxqjbBMVO+C0MH5AM2Uvt4eAT?=
 =?us-ascii?Q?iJ0l2COxckVZPJOCkdlvUqwXZbOyAURLqOhiCur2R3tOQCMrWiMcuy5AMWG7?=
 =?us-ascii?Q?ULsDiSx0ZWJBai7+4fAtnzxHB4TGa4I0uyewdrUgQ2auQMNXV6bSgMWw3N/u?=
 =?us-ascii?Q?0NM+J6FxQ+fWo/oF6HUH0X17UHSSr1NnlvRzhF9dfHql5RrzHNURtgRM/X79?=
 =?us-ascii?Q?AtljBY4+64FJrPqFPSOV8+lKe7zV9vNtLzBEuyclPWSGe6oaLMnnL6PdnpzB?=
 =?us-ascii?Q?XW3O2kJ+B1XgSVtIvEjLLtTV7Hvlnh6ba0QIU8xY3hO1fDwSnWcpHFnq4UC8?=
 =?us-ascii?Q?tNRAOdxOTs/9dH+rKgfpHLObZC6+UEJP985Wk3Pf0AvcBo52ZOQ/QAOIAXx7?=
 =?us-ascii?Q?6dSXzCJQlV58Bjpa40DVstWvWM8MpmwC8exc9hgcZKRxYhcTSPWuZQ8b6+r+?=
 =?us-ascii?Q?l1zRyxp726y5c8Z095U+qgKuUcq8ZYVHJ+Cs4pPqx3FR5ayu6t/QN21o4nvh?=
 =?us-ascii?Q?2J/vIqBB5Ik5QDsTXyF93mk+YMpsGD5zBw/02tM5gZnKd/1AWuDtkWo8D+yI?=
 =?us-ascii?Q?LnBJHwuUJgvrE0+lv4chLVVCKvxkzYTawsDDzC+jKvDtzVsflOpnhWHUWP9U?=
 =?us-ascii?Q?AcEyvDooI/EVkUKDrQhTuH8Q8RaB6JIxeIDo0AAe2mfqwreGOunVUk/dx+HY?=
 =?us-ascii?Q?q4f2dwIecJcEmW4NC3dVMWJqEArVPPq53nTzabhfriQe6QV13XgNNYCuvfGU?=
 =?us-ascii?Q?4gnYKtXXj5YSRL9/YYHOY4G1I+NwGdRCwnAwmcelInoYkkVw/ajK1VOWc3kk?=
 =?us-ascii?Q?qdlZtw5fjzgyllm6UfLm3sDsnje3wM9LpTbN0Ukg2s93y97yOCF5owm0nnVr?=
 =?us-ascii?Q?8iJ7UhjVJuIi+4Jr2PSOYgTZMi+6s//JTPRM2bzbrqVuNaY3rL3TYllrMWJF?=
 =?us-ascii?Q?6v5+zAD5oscXzYKTPz4tng2cdnPg3RA9iSJf5iSfzT/D5YAx43AL/0dPJD5u?=
 =?us-ascii?Q?v8TsQHHBjIlZh3Ad90LoAgBT6kpqMxqmGpNxlnBWb/Yk7xjQJXzLxC0k2BFM?=
 =?us-ascii?Q?14CDrjRY9oinnrc9K2tGEXRA0U1s0bK5DBGJKFCv0kWew9iP9QgRr1sBXk8J?=
 =?us-ascii?Q?k7NYTMfv4BE3Em7vH0pFjoyyPxyjcA4nlUfODX8rlZ9iPmCZT/YMd5pDz+iX?=
 =?us-ascii?Q?NZBwdw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8ns2FhFIZwsi3VdwSsX1B4NC70PuAjg1jGLAV/8Nkg0/ojnhgIuFAhw2YzSff0N8xK+zO91wlT/Ljz8Riqnfk7pzwBqy/hmwxxFVzqsyD9mYYGMPsn52hOvdonyUXkCy9ARBmiRnaYH1O60LV5PFqWMOl0GXIlyX74yJZig2/IlCZ4RBDxL6PGJdwyiKuT2tqWSv5mPrdBMEPtDfvb6+OESvn84t78AUbiw598c/Din67Qw5CbuRehL6jdgbAIONH1NPpjXNVMELeJ+sUAPEqJCuj3axU63U4dRqvS06u+qqDKrXKg3t8LFtr8ZxlFxp0KpPfSqWKyVRfILWifATeKkZ70zRkX3GeQhEg7adY3L8V5IBzLDJ1lftxfZtD2r2GS2vdmd5KW8BxkmjrwQGd/Ul4WXThEKObQp5Uxdho4MQqdLr4TVqxnRUjP+Df+rDq87lIAr2b9i+UXbP6OiQzclyMM36bjy29SlI91MDdsOJ0WDPd56dy5zM9p+uglZRjrDvXM/5RNYmfEA5lf+QeuWik+rThLkHFeu+964vhX9ZpRV0uaayLSk0Uwq6FRgbmFmEEc1TnbnG8x8XeptCJyOnKHw1gScvGAh5rqVaRGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61df5ebd-887b-4ac0-42ab-08dcf1231b1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:26.1597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SouEhZFQnOdkyhDFT18NhWKoSaSk98Qyq9MF3u55glsExKLaQo5hQyO0UuD74GWq4/4NdmseIeqbFtFA39sdjkM1hXu4LK7dO6NUtrD78g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=878 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200114
X-Proofpoint-GUID: XYGwlR16DP78uKCZU_OWKIvAVbitExy7
X-Proofpoint-ORIG-GUID: XYGwlR16DP78uKCZU_OWKIvAVbitExy7

Import the new MADV_GUARD_POISON/UNPOISON madvise flags.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/uapi/asm-generic/mman-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..5dfd3d442de4 100644
--- a/tools/include/uapi/asm-generic/mman-common.h
+++ b/tools/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
+#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
-- 
2.47.0


