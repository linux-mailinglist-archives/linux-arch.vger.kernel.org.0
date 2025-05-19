Return-Path: <linux-arch+bounces-11997-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2892ABC8AB
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CB13B7560
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6472921A43C;
	Mon, 19 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cS27qQAq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S4hyEF8Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F73B280;
	Mon, 19 May 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688019; cv=fail; b=rQcSMzA53VXesr/r/it74aX34m0GsEPxAdAsS8IoKFFt4bPPQONk5pmVaBa0uFcUSSMMSTUDeg5tM2mppTGCyHdhf0ff9Iv/ZM4xfuNEf2PTbwEWI2UX0rm59gTF3eC7Ol0qwMB/wdviyUPLmSLqBtFG97XXbs823I88gPw1+V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688019; c=relaxed/simple;
	bh=OlkNKLpKgcZ+2RLxPZp+rN0B5p/Ug3wk2WM1owih5gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQSAsuHCCWz+lFvdO3fu9XEkE9itwG09/VIDSrMpgILWXIpAcjjhDk0Qp+jV2NLd7FrqTsbZhKdt8WD1UBSdiTMCRtL9orciazV4JirvhcOW9p+YL11P+yvsEtDO9ptrX6MXYG+i0xD5+pt6hLj0o3t4juMlMrafej70Nt+g894=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cS27qQAq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S4hyEF8Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMpRk024602;
	Mon, 19 May 2025 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7GdzSSDrcxh4fgUeben9xxZYo5qZtGr1+CrX2qNfjdo=; b=
	cS27qQAqSbMfytXPGlYlOvizDBGcP1KI3rn+1VkmjZq/9IA/zwx1qYsn1k8dWAoA
	1mUkXrt88do/5y2x/3ICdoy4vgdQ9drilW6f5g/kOxp0YrFLoFPFCO75Ftfgju6R
	JOe2RpVJnbuQ7ZdrKFprCf3OBkOMYqo6UawcxHapQFY4BaQaJYZyYzVfCQ2DVfC6
	8E0zrfeAn9T+t3b+cnrJlW88IZ/v6s+6IQ14/+NpuibPlW8PLOqJVLwDMv29Flzx
	eFSyhiWdVBazqTlc/dR0lbKDMLImjEO9TGRXpgQFBQOs0fGwPX0PBWiuzTPqDoOU
	afaO7pfV72L5qT1JNBZ+bg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pgvekyc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JItVHF017346;
	Mon, 19 May 2025 20:53:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e3p7-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlFeE7wShmGEADCxTfQvpidVpDERg4OkOQ+DqWyljkGCQEpIjJ6fSnyByhtVaaU0f2SAYK82c6w1Vqqy+f9h6I77sLcjfEi3Tpn6+z9X+dJrJwhfCFMU5/fdcjMFVN4g95tDovVFQt/sYlOC66iSvbya+oexkj6U11uhhliFsQrFqqo7v51clq60Yv3arPCa5in5noNPMz9Yan4OcYMaVRU55+yWKupvE71mEGwPuscNSiPh2K2sEqpVQoTF8KkqLVwTSu/RI+4N69tyeW23+gcQcZD1KW1YZbX/sv7zzUNoSyA8PfoyAQTH+PNZjC6bPa/vgFeXgbidB1DIksP10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GdzSSDrcxh4fgUeben9xxZYo5qZtGr1+CrX2qNfjdo=;
 b=dWU6vFF+OxM15/D+zNIZIEn2gPxjeoXmLVMYzX3s1pg9V5vpUY+Zl7grVaq3yjrgBsYdgGndNNUuhUKvjjd9ngefsUHssGciOhSomc4KChpDRzHhXHNqLeL0N6TDjTwEormOapCHlWA8yqTmc/7IQKT6cV9qmvnjsOzK3UbCmDAw1rs5X3NAUYOHFte+UfyuwzADI4VF83YxHyydbl/NhvFfmerd1skuqw6FL4kufoBQsQS+VuqwMbl42IzGmUk4dA9rC5kZUnRHv7O4JW1we9poyGpGogJo0UAUFa3AWqOaabsvIDezDmF4q42nM4Iwr0QML3bKc4XrA5Rl9hT1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GdzSSDrcxh4fgUeben9xxZYo5qZtGr1+CrX2qNfjdo=;
 b=S4hyEF8YXMdLpeMX1hg2WAzYKFmVpVnCuCTk9TgqjgmnLhiOx/hIHe1ZzVD5ANq2u117Cu2w739sLBzIBAvPlCKrf9so5IfcpfQvUxv8TtJJxMcQ0mz3Y5kNBpPtx2r9ugnYaKEGhde5sVVns4Y8mL3P5MJNIf+41/5eTscrPys=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:53:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:53:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 3/5] mm/madvise: add PMADV_NO_ERROR_ON_UNMAPPED process_madvise() flag
Date: Mon, 19 May 2025 21:52:40 +0100
Message-ID: <0e7d82b8e8f4ac58d51c18fc059ea2ca235df47c.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b9f934-99b0-4cae-36d7-08dd9717285c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fppgpLYjE7njeEuyMFyMhYLbf8r6fHLoh5SLrSLmvU45qJrXtFoDoQaka4Pq?=
 =?us-ascii?Q?DMKH13nWTHvdn2snjvSnPMf/pAD+ZLPontr7DTtzaIszYwqi1y0uhMKx9nMe?=
 =?us-ascii?Q?lTyFT6zp8MkEbFqoe+eQDhmKdSWoA89JaFieSl0/n9dpIM91/yOBZSw7BjoR?=
 =?us-ascii?Q?mV7YW+o5xSQaCq2yQ5gq0Z0qJete97Ij+3PtDMSczsOoGncjNuxttfqcfcms?=
 =?us-ascii?Q?E0OH9b3xKKK+0Xde6jm7iJBu0S4Mt3txX+JPrVmkt/kSa+NPZemwnu197pDS?=
 =?us-ascii?Q?fQTMfizeRCwJVn3eQ+V21Pt6L+YIJR3QnENSMfK9xhygs89aHPKvY1YXeM5x?=
 =?us-ascii?Q?XkQQ3bkh+gsAX68K0AaH0i4j6sZ1ewYXbApdo4xsxu/g7VYDsaSlkA33YBGw?=
 =?us-ascii?Q?MMyRxHEYuXhH1eZBEpaRxRvNsbjfke7toWywz8mvXtRh86hd7uszD8cmsHKK?=
 =?us-ascii?Q?6Ag4955JEy+rMJX62XcsJYCcToBHDt1rlAZYfF469nCzDilVn5uWAz8b86Yw?=
 =?us-ascii?Q?1vxT1Zn7Acfb2Huwbw7FfjPI1jQmlhxQu9b7lOTmYtgRSKogm6EJMjd1asVc?=
 =?us-ascii?Q?Ajvrs4LKYz4+68cCJa3hSOSdv3cQEf65L224H+HGhWOcNiUFP7de/MDw05TM?=
 =?us-ascii?Q?Y9zYvmWyC/LkUcEldlT6Iwo2Pr8dFlIrCXR8csHyDO17oa18jQSOx8TdF/tB?=
 =?us-ascii?Q?VZCQtwdo+X8nQy7oLLgsG6z9iPT/u8RkukyQg/xqWfdiyk39et6sBXL9fZ1/?=
 =?us-ascii?Q?WScDkLngq3uXtK1KJ/5fqkidRXqjceLEvh/KSwQs2xUDjqWkZsUqqbwQKrpk?=
 =?us-ascii?Q?dpwAJRealf05ZUSYlOFU93c7uspbfIjH/HGMxZArYCe/qyl2i4v+e8WDWV7E?=
 =?us-ascii?Q?029owcRbjFcQ6L9q4Uni9C2gGRTR4biKTHcDY5ZWJ5oerWtaRbfJsMFw8obo?=
 =?us-ascii?Q?x8ZDA8PWLM59um8Y7DTUMLEHVila7fDnuRETIdl5PG+Tj788veMXq4b2rPbc?=
 =?us-ascii?Q?CHK5Cy31zd2XzG4oBVibG5RsDaee5T7aM9e+fssIpWKxMdBtxXNDcZIONnlx?=
 =?us-ascii?Q?vF9KUI6l7jFHaMenBaEBpvFXOFylMCU5ZSvbH4YEEcbvE8hjz4nSEhK3WvzN?=
 =?us-ascii?Q?pdwSCuhR3ec6QWKYnxKU4sOTILIQEENSnW3s4HESwNtI1gWDyjj3FEN8Yp0P?=
 =?us-ascii?Q?8zoOrcZqkoKZzj0HmsroYzWhAtIoju0VvjBeJBnko3Fzkfa61JJQQ5pFAWWB?=
 =?us-ascii?Q?o1sVDVOg7tzoIeqMdp6vRA5pYJMEFPk1OmdK/srePvPwLetyKaAk0apdhB/Z?=
 =?us-ascii?Q?Ql+WLgqnG32jXxdWVuOEFuZuz95/XbodovVwyR/5Enw1PYCUoaVCz9iY+y/P?=
 =?us-ascii?Q?OhpfZzNZspdoc6XoMt2Bei85jtrmuiOHT1NSEqmHdQzT1Yp4THoEAoL3EhAH?=
 =?us-ascii?Q?875ntPYZIok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9846rPz5WKhKKja0je7P5hJ7+lWGHxpSioUNVKbO/Gq5tEf8zsJoN2OUte/E?=
 =?us-ascii?Q?Oj5igQJS8fUTW4AxxB0VXtstS+fBWEpSFVicm7IJx/rR9lbHQb7746AWXBXV?=
 =?us-ascii?Q?kxL1SO1ivdPLnyI2hkmeQaKuHmWaK6JnLryeMC0jrzschagj9/1+I8vS7fji?=
 =?us-ascii?Q?9xCwz5jAGJ+o+sbA/I06phjJOv4xOYp2TS+Ht7QD8sHPD2CHcZt5E+Htu91A?=
 =?us-ascii?Q?grTsdp+U8zSsbXn57bGsFqAGeyfdayB4s8h/WDyAADj75Mrg0natJqwsmhwC?=
 =?us-ascii?Q?Ia11rNg+quTrsXJYCdoEF77fR7Eubj4j2AJsSBy3yZyMMwJ6MRMDbTd8O+U2?=
 =?us-ascii?Q?BIMI8KQYOzQccrU7dM3lFSq+AS/fp3mH0PzxuA1r3t1rGvSPy0Jg5PZBMh1h?=
 =?us-ascii?Q?oOHqmLSJ1tQzpdX91adX4d3XjSqfMsKMj9ACk9AV1ERul2xHfqwXRvsrsvK9?=
 =?us-ascii?Q?gVs0/rmmGYeiI52vyTKigS6Ll+vFMBB1nwvW27okZLMJZJWAsyQ0bOYhsEQw?=
 =?us-ascii?Q?l13k21Q4Hs97y54vBPV77olAsv4VgXUWp2Pjk5fmTi9q7xtL2/utrodCmiH2?=
 =?us-ascii?Q?HddmNjyLdn0ZW4KD2QvYTGtcOTDdC9SBXDJlGEM5SluChPNyxmd0b8dgslyJ?=
 =?us-ascii?Q?jYuNe7ANas+3KXER4Jn4CUKsPX7VF00dKoddk+y3UzUwpj/ABffGX+JD0VPt?=
 =?us-ascii?Q?hFnT5IF/UA0XBnYvUNp5nOQU9zSI0X6lYY559kt4SisvHa41vtFnyYGWoJUB?=
 =?us-ascii?Q?v+Rqq39LRhGFMjF9mXsieiuQGnEWRWgLkz1i/oOfR0P35uQ0P4W4JZDufrX8?=
 =?us-ascii?Q?96LRHvkEIdMraKKSGdSPY29q2zFL26UYYhygF3FhKSJZaXnjDUx1hzmhNjJC?=
 =?us-ascii?Q?howGGvH9K1iig6ySshQ22n8m5PnDW+FnVdsyws5tP3mQidRez/1PAmm9zgNb?=
 =?us-ascii?Q?LlTq8hwkLC3fdJRy7kM+JSKc93Fa+CKj8TWWjbdqyuCOHqGAa1imP4vR2kXN?=
 =?us-ascii?Q?3fXw8IZ1ShFOEmZ9tXgjobWRH7P2diMrn10MisGWx9Xy8KBMRm1rwq4Guw7w?=
 =?us-ascii?Q?1SbzKsxfqbAssvF2U/4uGXi2Q85CJ6qHBPNRhv5aRbX0Yq/IW9rHsi50p3Gm?=
 =?us-ascii?Q?AofZ6rz2vkB178hHRGDEwZUUkMAAR588mbbpYp5yRc094gHCuD3c1cxfRndz?=
 =?us-ascii?Q?Uzihgfnm6+ZoHJ4nQcVRS97RqGq+9B+8LoP+9l1eJdd4vg3kGLHYDJnV/jnF?=
 =?us-ascii?Q?jsBdHD80aCSAl64rtuLPwb2ci/bwS9RTMlrYNPLDp7zRLENcF2PrGjfJvyTu?=
 =?us-ascii?Q?WJ5Uf2xuc9+AEg38YH4txE9bT4Qdz2MunpTHOS6pxjgSLAUSz1O7UQZrTDn4?=
 =?us-ascii?Q?pnbZVMyH3Cu5pbwF4/7kURtXy53TqskjdeogxB5NqIJLGXPFXh0faA3a6vHH?=
 =?us-ascii?Q?B9PnY490YXW7XK0Y8hvEZ4Jt1ow/6B/fmMOyS2BeThI0QKEOvXQkx1tgt4mL?=
 =?us-ascii?Q?zMysP5vXtL7kU7lo5lFfZ8ELfk7Ic/x3ZSA9PiiBNNjqq/RpcOMkaEdTovbK?=
 =?us-ascii?Q?yIg21SH55cOrmszgcFw+a2+fxpR6XAJ6Q2YNWPfA/wyr7u1NxsK8lIW3nYZg?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NOSx2J1n8ncFd3+NJxur/cL1ezfvJMs7d/WyY/NmLK9akXWmToAnxxAs7JHo4LHAJYN8n1AJx0iqHs4rOqQyXvbnooMZlW45H3k/GxqavkAJmx+lal8BNAhwlEoPImKF6iKh8/6g5xGsAUS3D2Vn1W7kJbG/Sj30SLiSISEeYAoHawFvrvFs4EJtK6oS4yrZSmZ5yT8r/0bq7eP1OlUdJqUGz+hAc3PzQGVmogpjxzW3yBwkrDbmwzxBiFqyji8gUbfPLajUZOeoQWviHsGNzSx7V5e+R5h6qshj3KAGIKFtxTweCnF+YrG9PZvkx6yrVcrgqPkTpcMiy/INCQoGCx2euM2nghr1aC52g7bh2tkzx7ltD8f++UWJzj+RGCzzOCtBnEJrjVIHV0RiPU0vsTon6oPLvc39+iMY8kOTAJNSrDtUEe5+LG4Lgu926Sz4Tn54DTP+h52k/JO2SugL7YmRG7daqym+J2d39ZRK1VVDiQe7+899haXpZbRJiNJO33OeclWfbQN/J1vuQb3bqi1w6PN4r0clCf0xIRjnBn/fZ8zjqaUnBTxv/gOKrW3zu7oW2z4RwUnAyqdT/KVBgQ6Y4gQmYjJx4wJp0FnsFvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b9f934-99b0-4cae-36d7-08dd9717285c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:53:07.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1HsTYi7xuVZB3ORF/6gWWUdKZMiHoT1/hovyXLsJxYNelfH+/9qKaUhLe528F4CHEyw7zzVQ+kI7pVE0vJy9gkgHlAMr8MsO5ISjJalc5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190194
X-Proofpoint-GUID: pBj46_rACR0qyCfJZK0lnQTAMourP_p6
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=682b9a43 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PLySa3yzCaLjkI0FfEAA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: pBj46_rACR0qyCfJZK0lnQTAMourP_p6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5MyBTYWx0ZWRfX9wJJX7epEkY+ amNnVbF0WkKd4bSgZdPUyOrb80A/wAnf4Y/xr/RWicXuJH1JNFcVBIVgAcCFHuHm9lRp6DjHhRP 55+GQq9fH+NXjR7C/txZQq2qNOH82VGkql57M5aG9YRd6aITQ+wOdSDnp8Zh4OP3UNBubFpN41D
 x3KAFRdFDX/377+vyfylksB1ME5Dk1rPRdCmSFqwBJe/Q3LgPU9yaQ3cHWOFBknZSR6l7ClrxFk lgPFoS6ManoL4dAcWqSeoJrmx23RqLb+T1WHFkC0zOQMxthgu0oZqcyoTbr2jlQclZ/ockpWX83 iGoaRD++hPL4N/dweDinRHHSePDChLJ4yavpuX5nZOMdBcRP3XLjY/YC/q/dvXyOWOUN3ucOFEC
 AD6WLJTGkb6irTzGzMejTH70mIlQmjbP4QRa9FU5sZFXp5/G2vq/fUg1dGo35Yx1wiV+20Y9

madvise() has the peculiar behaviour of, should unmapped memory be
encountered in a specified range, carrying on regardless, but returning an
-ENOMEM error at the end of the operation.

This is problematic as one cannot tell if this error arose from there being
unmapped memory or some other cause. It's also rather odd behaviour.

However, we must maintain madvise() behaviour as-is for uAPI reasons.

When it comes to process_madvise(), things are a little different (and a
little more strange). Should ANY entry in the supplied iovec encounter no
errors whatsoever, then all errors encountered are swallowed and we instead
report the number of iovec ranges which succeeded.

However, if no entries succeeded, we simply report the error.

This is problematic in the case of gaps - as the -ENOMEM return value is
treated like an error and causes the entire operation to halt.

A user may very well not desire this behaviour, so we provide the
PMADV_NO_ERROR_ON_UNMAPPED option to cause this to not be treated as an
error at all.

Note that due to the way it is implemented, PMADV_SKIP_ERRORS implies
PMADV_NO_ERROR_ON_UNMAPPED.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/uapi/asm-generic/mman-common.h |  3 ++-
 mm/madvise.c                           | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index a5e4e2f3e82d..58c8a3fadf99 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -92,6 +92,7 @@
 				 PKEY_DISABLE_WRITE)
 
 /* process_madvise() flags */
-#define PMADV_SKIP_ERRORS (1U << 0) /* Skip VMAs on errors, but carry on. */
+#define PMADV_SKIP_ERRORS (1U << 0) /* Skip VMAs on errors, but carry on. Implies no error on unmapped. */
+#define PMADV_NO_ERROR_ON_UNMAPPED (1U << 1) /* Never report an error on unmapped ranges. */
 
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index 37ef1d6f4190..fd94ef27f909 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1530,7 +1530,7 @@ static bool process_madvise_remote_valid(int behavior)
  */
 static
 int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
-		      unsigned long end, void *arg,
+		      unsigned long end, bool err_on_unmapped, void *arg,
 		      int (*visit)(struct vm_area_struct *vma,
 				   struct vm_area_struct **prev, unsigned long start,
 				   unsigned long end, void *arg))
@@ -1584,7 +1584,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned long start,
 			vma = find_vma(mm, start);
 	}
 
-	return unmapped_error;
+	return err_on_unmapped ? unmapped_error : 0;
 }
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -1632,8 +1632,8 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 	if (end == start)
 		return 0;
 
-	return madvise_walk_vmas(mm, start, end, anon_name,
-				 madvise_vma_anon_name);
+	return madvise_walk_vmas(mm, start, end, /* err_on_unmapped= */true,
+				 anon_name, madvise_vma_anon_name);
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
@@ -1752,6 +1752,7 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	struct blk_plug plug;
 	unsigned long end;
 	int error;
+	bool err_on_unmapped = !(madv_behavior->flags & PMADV_NO_ERROR_ON_UNMAPPED);
 
 	if (is_memory_failure(behavior))
 		return madvise_inject_error(madv_behavior, start,
@@ -1763,8 +1764,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_madvise_populate(behavior))
 		error = madvise_populate(mm, start, end, madv_behavior);
 	else
-		error = madvise_walk_vmas(mm, start, end, madv_behavior,
-					  madvise_vma_behavior);
+		error = madvise_walk_vmas(mm, start, end, err_on_unmapped,
+					  madv_behavior, madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	return error;
 }
@@ -1950,7 +1951,7 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 
 static bool check_process_madvise_flags(unsigned int flags)
 {
-	unsigned int mask = PMADV_SKIP_ERRORS;
+	unsigned int mask = PMADV_SKIP_ERRORS | PMADV_NO_ERROR_ON_UNMAPPED;
 
 	if (flags & ~mask)
 		return false;
-- 
2.49.0


