Return-Path: <linux-arch+bounces-8922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6919C1753
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C841C2163E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A389A1D12F1;
	Fri,  8 Nov 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LU0Yqbx+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6f9SDq4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693D1CF7CE;
	Fri,  8 Nov 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731052469; cv=fail; b=OPMU5qW7aQqIuROjE1SaqFA7zQb7q6RtzaVmHiMlbNhK2LkisBomHOcQrVl0A3ZJjpn/ulQ2QE+K1mNjRz1DwlGMmaGRL2w/MsQMixBskl4Tui2nn9GSHh9xbOdmLgkTuaX+QtAscT+sLYVc19dZHDO0H0CpZ4mt6z6YKWHvCGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731052469; c=relaxed/simple;
	bh=VlJ8erEj7DTvxAJEGC9SfWxCD0DDh9g+pcSxnvZ+RbM=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=rpm2At8DGwhyqaYII1H0mhuqCGsDFD/Uc3gAYZNNKr+gN3tbYWfGh9UMuDXSHM49wbE4n4JMiPSG6XHzOFrFkqBlemwBOjgNZ+F9WB/JNyBElK9kpxGnclHfFs+kCAdl5hnn+zvD94pfclG3kk8snOp3w2ldS/tkpARQnh8YSNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LU0Yqbx+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6f9SDq4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87pKgx025373;
	Fri, 8 Nov 2024 07:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=MGHDOL6VT5hQ0NlZaL
	WKTl0Iy2QTFArhJOZ1uOMaT3o=; b=LU0Yqbx+OIOYKF2kgXHvfMomhXa/PQXbU+
	yPq1GtYQHc7VtjIhDcN8IIKpMgtjnrPaco5nLPqCoRVOdSL57F36dmMmnY7Fh/+0
	6Jeo5GzMPPdGJ+lljc19aPJ7SpEH98y8TxYaow6CbeS/kGfGDVkHO9OuFErJJur8
	VpKJ2EvdU+0S2zWajHnnAJrIKRDTm0H+y0pL4MFp1ExrXPcPFSSmXD8bjLEVD/X8
	JxwdQdyJgQDQzgnGOSiHXK3U8eAAdWp8KCfA4a43/jHOYJKLjOolnvOHReJj95jy
	Pqc9O6T9kuT9EU9X/Qh0w3QRbTLsiXVAdfn92c0VMfEvaDqN58Kw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gj0npe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 07:53:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87jLoB036880;
	Fri, 8 Nov 2024 07:53:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahba5c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 07:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLTYsipwQumg5HJitxDPHtHmH0H6btIa4unayS8l1tvstzqbABaKYzQVZXk1EaSJI6p0kGVW+xWJLdlrwt3IDrgLEt3ZCF2xzAXtBoGG9A68ZerxODJFPMlR8Ci55wGNNmcmf0qr2oAl54zAWQNX1BG2SQgWS9ZCATzTCtzbZOLE1xaPucbpjW0/ejLNLuCj3wA1SelTNrXEWDn8D8+zXBBymYaEvCaTFcU2hUrmZ8PF8AdceLt8N9JQzYbX7Zzi3ZbuuffOHOVmzmtToGU4M1ej8zV/KBjB2NYK4IG8yN8ONSobUNWmangO/s3G5ml8LgTd4smUUKU7Qf4/pEbGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGHDOL6VT5hQ0NlZaLWKTl0Iy2QTFArhJOZ1uOMaT3o=;
 b=QkGPyMA9M4ZRpTm39lIHpbZ+hMef8onyqD/9IKkG+ZO//ybn0Yn0zLlR1llhT2Mrrl2Z6DuV8DAetNbuFscfNqutHVY49EtEtWkd9U54GURlUhQP1SiwfSdN4I2APRxuX9zZDKA6Rzo3Yn+NVy87UMhmFf/zL3opppI0EoTz6axYsqpnHTMK5Cp53nYRBc4vLPpWwJFCwiVRD2jxG0G4sIZUQN8HGy/YSexpzMccmKEU2HWG1nTbmz8BpAHTqvCpLC8gzS2RCPbAEUH2IbQp2c2IHBxE9dMbu/SDKFbElPeQ9FbolOlundr3SCkzr+xL9ZQEIRSQ583A3ckZGtVoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGHDOL6VT5hQ0NlZaLWKTl0Iy2QTFArhJOZ1uOMaT3o=;
 b=Y6f9SDq4TXhqodGigReU/bRIYjwqh4rN2PibKJBmjOcQVvXgnQ9fb7JWKtpZP1eGK2fJK1vhB9s6MbKvd+V2rE0TivyMZ2vN07qpgqfg3qWdWoQzqXGPTdGjahJBFgyDWTnGUky03JVRPxN7H1ipGj0g8VhPg8zNLlo64XSvEuE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 07:53:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 07:53:38 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
 <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, maz@kernel.org, misono.tomohiro@fujitsu.com,
        maobibo@loongson.cn, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-reply-to: <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
Date: Thu, 07 Nov 2024 23:53:37 -0800
Message-ID: <87v7wy2mbi.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 579ffa1a-e5ae-4fcb-91e3-08dcffca7467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66o/5N/IGsVp+n+aom8eJGWyWArMdvDEAJvoPmdzOOI9+actoepX6o2fQhaC?=
 =?us-ascii?Q?uQdVhDfnukGzxcDMMf+RFAPMNKw5Gvp+yKbsqlmznrEYL+wJ5uW8RqMp/r4P?=
 =?us-ascii?Q?ATuTaDq/n1C0UoIWvRdB1KaQ0RAGwEfuKsHHdDyFU83ur3VwpjpPwmqbc17i?=
 =?us-ascii?Q?eaReR+j/e9xrgI9zglIJ8A/N9WcY5eUp/8UDW27s3w8X/ieUXRXjqZC1KsI4?=
 =?us-ascii?Q?uGnGKS+J8kTpF++Lxy8cs3+bWn1syEdaNdQZYMikmnKhge9K/KVwsPtD8iKx?=
 =?us-ascii?Q?LZgOKYxFOzUtelAASevSZpN5X/sb8wyNR3CtD49fzgAIlOIU91UKjNCQu3SA?=
 =?us-ascii?Q?Wqyg71rDPAu7RrR+CXsDi1fPH++gZB4qQNgw+DBKHOwM4qDiyqZa6pSru9QH?=
 =?us-ascii?Q?TJNAInzqRahFin6spoTfdTiy8cJ7B+wr9xZw0xk1XCPlg/hPhPZ5Do19SNxm?=
 =?us-ascii?Q?OTL5bErCeFtTZkLhRy3afBT3gmy9627YuQEp8SFzFFj2PSU2pq84DjL5MrOZ?=
 =?us-ascii?Q?01himp+zVQHBHykm22PmqJz+Vi73j1jY6/QrMrh0QJ9iecCemHnKEVmo97Sc?=
 =?us-ascii?Q?2rfp3mewxyu2VCKkS2pV3+xFibC4HwSeogNBzL2mfI2TVTaowbMkGqECRlhF?=
 =?us-ascii?Q?/DadttGPiLVfooMZshp/bY66qjG9QRov4Y7a6mag+KrTZjy9jqZxQIUO9ih8?=
 =?us-ascii?Q?aTuC3K5JXLc5FJtmutfXGRc+dbzqNqo2jsXYajuWgs/+LGpuuEwSdCgmZuLR?=
 =?us-ascii?Q?YtQb14jM8M6LQpehvOYW0fgNBHaTUR0FEbb6xTmpdavkp/JzGb876S3t7CAi?=
 =?us-ascii?Q?+7DzpyQnG1OP3BFlyR8YE4IKDsosTgvhWKaZUOemptWKfJFrJdQVBqoT+aBK?=
 =?us-ascii?Q?rih458NldzkTutI+YoRxVN5hqmTF8Hm3fLmNICFMMSZFQNSPCtP6sM5ndltf?=
 =?us-ascii?Q?lQsQ/EC4l/6OHniU7xt4jvc2EkVyezSHBbv0NnyKzIeWKjK5WTd2MtIrUzGl?=
 =?us-ascii?Q?uwU1Y54sCPmedPePaTxBuaZgCC9istu3fbtpkHPQ5AxmiHmGYRFr43oVnbkE?=
 =?us-ascii?Q?z1N6ec+Kgbmpi6OkgX5rI+qxpMmkSThf2VqjeCYxzcB9zNnMkWi74QLBz9Ka?=
 =?us-ascii?Q?KBkRB6rvQpaiMa++OOXNoANnEZscc/zrlyKWUN0NxEMG9vsVBNkQF/JIp0zh?=
 =?us-ascii?Q?n5STaNwng98IFu2832jIo0SUadYFiqdyKMLQmGyyy+WdyWaPQwgU1eY6cQfb?=
 =?us-ascii?Q?oXjNVhUnjzc4UP0cbe3xXn7JsCoc/ZIC/wxqCddyTp9I2M15UsjH9pA7X0V8?=
 =?us-ascii?Q?vI2/b0FvifIZFzn2vnn9wZwQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtbXF3y5kCDmTBZQ67YrZhtFL0dq38Omnd5EZXYoR9YphUusKtPQpDYQPvuW?=
 =?us-ascii?Q?iGtZQyGb5aHlyXUnCaqSnX5wXGDWEcZ9stgjEcGkQxii9ZkLRqQ78UewJ5ki?=
 =?us-ascii?Q?AVQMRigOd82UXd+YkgussbUeBAxKFaHVDMMB+QeebGoPVSVZv9H9kFtU2wbq?=
 =?us-ascii?Q?8VbuVoF8+3rk8OfjqdIMww8fNFKHmP4DW44N8RbDDGO1LXejo88DSE+AKcuK?=
 =?us-ascii?Q?jQP614Oy9Sc8gsrrb92uULT86BsozhQBwI1h01inFOeispvOJWFzcW0OMHuL?=
 =?us-ascii?Q?zpp2FfIFOg11i46Ju9PbDWC3sq3UW3fI2fKuD7ajh6ETH9S+Gb0Xq/1aCDDY?=
 =?us-ascii?Q?4rRf1Dh5DAGoNf0ujOysZvkkYGibPrVRZ7/7VwTm3AHmv10xI6l7R+VMXFkd?=
 =?us-ascii?Q?H2/fjGGf7L1toJBpVwOdQOEjV96Kvxd9hqNP39nYdXgIwxQC8l9BmdDGIkO/?=
 =?us-ascii?Q?xCmbC/zgWMTGPellne++QRChXKHVEWqxWfhV3nopbvbOQm/gKni9HGn47ePc?=
 =?us-ascii?Q?iBGh6eY1qgeCCGk/amks95YKW376D8AKNnY1JL9SAYBIOn/FKBkySI12f6hc?=
 =?us-ascii?Q?BIOTK7BOS9iz2cSTCHqsRIpBpy73WFF8NK0SA1CMSiDP4H2wmTVCMee/aV+s?=
 =?us-ascii?Q?c/13Q04PRaKctEopCEGwL0LrZZzSyEaFVqPF73JNoI4QhXJiDIJyx5nLyOcR?=
 =?us-ascii?Q?cQn/umpVX3RVPwEupO2MDrRYblOcW5VECv67AqOg2h54kJMbHq9h11zFWf5K?=
 =?us-ascii?Q?zhMjm+M1tICRskud1Y+0+psgwStoK8YQDTTIeYX6nJT5skDDtx7A4jjH3Ld0?=
 =?us-ascii?Q?KZbaEDl1bVlMcWg7GqLuYQF5W6KqGCXwnwljxLH9+YQP/zrBYgvxB4rztpYv?=
 =?us-ascii?Q?idXAMw/xeJyGu7emDbL3MIBaZQGFHH+2z6Dn7F+su71aG3vCbBkJMErYLTHi?=
 =?us-ascii?Q?zuIFtiSlsUyvhTrhKdSw6lyW3/ju8sz3nNJbvQfnfXk5l2bKTjuL6UYrmm6Y?=
 =?us-ascii?Q?pS0MzgctPwEDLZYn1anxtiOXaOjb5DLxfIYbNK+Cwuqm2ExbuI0O5Ua6lnjp?=
 =?us-ascii?Q?wl/bPORuaLKtd5sbGtJg5gmIj6FJJSeYQ3Y43VeTOfP9C5PBLblTTp/b6ZbH?=
 =?us-ascii?Q?Iej4qfch8Hf1t3Uzq9CcfcObmD6s73gAlinr6rhgshopED+4l2UqBuZ0rZ/L?=
 =?us-ascii?Q?1uDap4suj5sOWPt8banzTbbQZ/OOIxAJE8UuTjnJFSMKRRZEgpLAl8gkhYLt?=
 =?us-ascii?Q?K8iIUKn+UfLqTfCLUZ0YlVdWvLS6RsYbX7dgCwL1JZyvWe/xtDZ8QUKtFVKg?=
 =?us-ascii?Q?vIX6yDVzE3axVZRk5WN6ImJxlwKEjkQoP89Xj3ki58S4HrLxezCnAvIN0mKH?=
 =?us-ascii?Q?MeU5nkJO5lTQU0ZrNaYQ+JveRNVzFOR8B5PLIbaLhrrM/Q3vBUzg6W3JWyUM?=
 =?us-ascii?Q?UGy1IoceQQI9vpC1YeIDhUfKv1K6jAR+P/U/h8LsMcqWHIeGNVBTqVXI6Dfi?=
 =?us-ascii?Q?oacZT2Nn5bRkR8+dDWFwq3MbvKg7AjbltoDisFs60Qdd4CmY+z4XdVzDhRPj?=
 =?us-ascii?Q?fFU2aSyw24glPt4Tg0lmLee/fmLqoBodBgRS5LdH7DJrtLp1GerJsmE/1z+D?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kPMM9x8T046Tlv3naYiBN82TtEABJwB2SmsrDdh0zhYEoranQp/7sDvZeRSNJvzKNAbDfE3v4OmmTpmqMgAG7mThf002L4EuYHu9YYkUAM2oUGXw2br15+7VrXvqk2wdbyxdh8klXrPZ5CuLCoKtpjLKyUWWzxnUqrPt7XepT5CyZj9x3Gt4TzkiokwhY9Lbq+UDNeG6/rAX75JFA8aBllt6z2pnZ0Q2m5/MdUv5hIsVfnV52FJ8MGhH8q9XdqUZonDif+XOg2CJKdvZWiRDcfw3BT5W0BuGE39JC47yifHPUoDe3IZ+qDyc50iMiSupTsmj8F37Md3/VSQHhAohGWWcPE5eYByQ0hkVUpza0sxpGVD0plFsO9eDdcYcAd8+6QZjyaztER1mq5V5I2hX/1kf6mKEXfGSL/jWP3TSh7ewG1iKDo/vYtZ6KUCcGQMA6X9ZKIob8dc6Hljxa23UvlCghUIhlfv1HaQVT4riRMXszZd9yFBsPn6WKCfxE12fwCcFjP4ekFziYYf61fmdGbsW+5pYsKdDyw8OeOp/Mmc5w9HBKRunGrStaRdhI81bF4/PsSSgGK2355mtWmb6qXbrvdTHlsC2kXxFIqJzBa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579ffa1a-e5ae-4fcb-91e3-08dcffca7467
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 07:53:38.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhC9ICcmmd9Z6OlHpVBe2nAFcsc64b7logd0f8VQWXVgKe4k+zsVZAhmWXrqUGxqXEOdw/033uBdOHfV2o//E4uv8I2BkIsWCws8wK7ae0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_06,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=886
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080065
X-Proofpoint-GUID: We2rN2w0yH1qRS3Sp-lghXSBo-62poDz
X-Proofpoint-ORIG-GUID: We2rN2w0yH1qRS3Sp-lghXSBo-62poDz


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Thu, 7 Nov 2024, Ankur Arora wrote:
>
>> +#ifndef smp_cond_time_check_count
>> +/*
>> + * Limit how often smp_cond_load_relaxed_timeout() evaluates time_expr_ns.
>> + * This helps reduce the number of instructions executed while spin-waiting.
>> + */
>> +#define smp_cond_time_check_count	200
>> +#endif
>
> I dont like these loops that execute differently depending on the
> hardware. Can we use cycles and ns instead to have defined periods of
> time? Later patches establish the infrastructure to convert cycles to
> nanoseconds and microseconds. Use that?
>
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr_ns,	\
>> +				      time_limit_ns) ({			\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	unsigned int __count = 0;					\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (__count++ < smp_cond_time_check_count)		\
>> +			continue;					\
>> +		if ((time_expr_ns) >= time_limit_ns)			\
>> +			break;						\
>
> Calling the clock retrieval function repeatedly should be fine and is
> typically done in user space as well as in kernel space for functions that
> need to wait short time periods.

The problem is that you might have multiple CPUs polling in idle
for prolonged periods of time. And, so you want to minimize
your power/thermal envelope.

For instance see commit 4dc2375c1a4e "cpuidle: poll_state: Avoid
invoking local_clock() too often" which originally added a similar
rate limit to poll_idle() where they saw exactly that issue.

--
ankur

