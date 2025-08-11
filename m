Return-Path: <linux-arch+bounces-13102-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E168B1FEA5
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 07:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666113B5C5C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9B265292;
	Mon, 11 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbwuUCq/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l36mehxI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B131DF98F;
	Mon, 11 Aug 2025 05:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890551; cv=fail; b=Yxtk1jRPd1P41w4Ljn50GUdEInYBA2GE5g4cj2mcROsY/5nZAwtpFnl5tGzVd3bsEw6JECaoUn7031w7sl5x/C5FVYPFDtEgXWT3P5Cw6QYwsg4IwUgbUTmQiK4g61Fz4CMoQjIRWS7qtPP7cicpf+2lMF/usPWyyTT66rZx+9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890551; c=relaxed/simple;
	bh=4n+GYMyELTCw3TXPBPi9cTXPkckfTPakudmw/R0cqBE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P35mDHIkbC0668ImbTNQEG9yYxhdxlcjvyYq4RhIf/xhXqThBpAbIAU0Z56/QXoIP4xcmql4jPDdNSe8txL3SyGEesmfv+cotAmr/ooRhHFFt3pEDLka83Ux9Ga3yV5wRwQYHxyy7XgwCY0/saw4+rg2T7F56xPpoJWDWIwbyPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jbwuUCq/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l36mehxI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NwxH018062;
	Mon, 11 Aug 2025 05:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=cd7d2fATAtKPVHiW
	iIGcfZERp8wP6l9dWyjkQ5McyXM=; b=jbwuUCq/POCn/FIfuPMA2yYrCH8abp+F
	MxkUHUuIcWHml9+emYA7cNWsli9vYN/lflO0quSEm9xJ23oJddO04N/gjp/g/NAK
	rI6Zg75oALRWzi0t+9YkI48BBn8NZiI82j26WicpPdjtaBDmItpUqrUrmv60mjQn
	5hxSBX27k2Gfx7tEPcfFG0rpLG/H17PNQZnT1vtTsBvcccHBT69ATdyQmUyeNnDQ
	kjmX/Nl6uAT6eZ6l/iEmO+0DaxyhWgJ9tBWvZ9zyGWCWWGOcY9L5CsYRQLTqNWSM
	LKaNK83YE3XvoB6VxddVvrsfznTPBhS5uC7//c45HDp4Z0C+aUCsOg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfssd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:34:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B45M0l017411;
	Mon, 11 Aug 2025 05:34:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs86m4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM49Z5fZLRCrPk041zRZmC5V21HvLGVrLBM53Bm0ILgoZK3vZu9VbP0nNZc7A36HWJJHmtn+LHK0/oLhfj8l/E0B5rQN0GCFMZwOnExcEYDqG/kw8TpeG16DimG9nZ3q9rIDPEHQH1n2TJ2DqQk0YRr9fxicrf7XIyZXyEdRXGnfn4YYnZv6aBwW1FL7U8HEbsCqKkNfKj3wFxCtMe32liLZ5JDYiGvkaTEZR2IHoShfeVrW2gJzoFUxDhJ9n54h/k2h4+FYbEjk9j23i4S5cgqVrmXJjmnlu56ALkrPO9Yu7ZyrEszJBresLOO9juQ3ccWvxc/aNcmDJw1hQv558Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd7d2fATAtKPVHiWiIGcfZERp8wP6l9dWyjkQ5McyXM=;
 b=eZ+I9Ht/yNOKbDrFefqNTjenRn1JspGMKAGLrRODKPviA+7pmKeh04ytlcO3wg1/7DwF+Oubnk8bhi/0UpLxe3DbFCHisUAN+9s/BenAxHRsnlryy5GF7kHtp9ibQxwKrKoWpaW+0nbX8uRLlGWURZmvq6fPzRJPxCnSHdEUYh5tzTYDagPQF4NgmOqbHZ78oI6sVHE8LQQOBQFYx7Db7NYg1WiMzQpbYN3/j/CMpWW6UgY+gTRZAvjDVPywIcuuGsmhbH+AE69adaPwGBkcAdRqoxr8XmXoorcAjQSTSnKT/2ClXEAzJPgzQOftRBKa5IUM5waUfHaCwqXe9R6+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd7d2fATAtKPVHiWiIGcfZERp8wP6l9dWyjkQ5McyXM=;
 b=l36mehxIc22HnvsEtu9PfDhL7E6VtU5DjOFJ3zguvmhXFmct8DUQxrdrT164Zw6VZYt4z/dlIzQ+TTSdz0sHC6eb24Ns9Ai/MQEQcztJzoMa4cNr5dT1VyjujdaNx5R2cJOQt6TLJZ3PWIhkXNc9Sin6riz0Xn6JeJ5vCR0Xxws=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPFA0AD88203.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:34:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:34:43 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Harry Yoo <harry.yoo@oracle.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org
Subject: [PATCH V4 mm-hotfixes 0/3] mm, x86: fix crash due to missing page table sync and make it harder to miss
Date: Mon, 11 Aug 2025 14:34:17 +0900
Message-ID: <20250811053420.10721-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::27) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPFA0AD88203:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e53a85-a91d-4581-a498-08ddd898c5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?POoDF+Sy3NnAX3rSAwrzJuHIstOXFb5Y+VPQSf//FFqxqy7eKoatrDYBx78y?=
 =?us-ascii?Q?PKDd7hgaBs942VFMCVFS86vLR3EnJYjMFuzTYtJr6Yq0Dda9UTPjc37eHVcl?=
 =?us-ascii?Q?MQ0xGLMzU8VnPDddp3HUybNCK7lSuVsy1j36adLR3qPHeK/kcxRw2XXEyhnO?=
 =?us-ascii?Q?y+Ciueo0thQNN8uG+63VH5hiMVatQv8lQj8fzUqkJvETrDpr3WVauRvu7xjC?=
 =?us-ascii?Q?pwQzsfa2rs3s+mLH7UsXsRd2tCh6l7wNqU0yjsH8pMzZRu25Vw5TOG5so/Rd?=
 =?us-ascii?Q?iIcxPVFGVvB0BVj2boSrmFfbf6hQwVOTTI9v/o5OUDPABVB6sy7t3tC3KLpU?=
 =?us-ascii?Q?af5PnkF1dEBfw7/nK+ywI/Xz9jW8Ja5RshWLQ+FueCu/ZTzS7i4/1s2UZn18?=
 =?us-ascii?Q?NGSO0L+PrbcC0TRL/eI6AM/sPxIzlYTVpT9q7X9hRFst06zzqtSZOJ3R2y7N?=
 =?us-ascii?Q?6kQip50sZWKAa4PJevJQogNJTyl/GxY8SICuAL7vQXj5vjmXS+nvL11Je78E?=
 =?us-ascii?Q?KNCYUoi+ABH5uYbokblnkvlZVYLnbAi0WiZI90b1UsRdahP37/ADSZyIw1wl?=
 =?us-ascii?Q?HeR9DyF47f+DP3Te7nXq5ZbQN8cq6LiZH0cKWQ/72QWFBDzlIIyQXtzuBHff?=
 =?us-ascii?Q?qotiL5VJ5gY9naFx+SZCw4JldJ/BnNp/sG9BtFq5e2w74jxIT9al2fcsSYZ/?=
 =?us-ascii?Q?8bRMAwV6CVp9+/RcTn2v3rR5QKWqqBID9s+g3GWwZad+LErq/bXdB+pKsykK?=
 =?us-ascii?Q?5ThfexC+Pvu9o3+s6J2xC9zOg8i3cGVfFXfDtL+inEnELyTKaRUXk7Ulq67H?=
 =?us-ascii?Q?Ly/0NFTeh+h+b32ZRVTfEdLmLI43aNBrk0C3dmB4sY8EGNDVrwxt+CshUhqo?=
 =?us-ascii?Q?iFvDj0xVmy/i3C0XYgPW24Al69LaAdVBOZu7Bi5/BhofRhFCETXt6NvJHM1f?=
 =?us-ascii?Q?t5ABAMAywFqE8lYLOQvCWqbtJpI0PdXhrxT0iTvfEpq/Zz7NsALjTMNK85+R?=
 =?us-ascii?Q?jQWv9tUG263MPwCDA2m0nrsqvG/ddVZ+vgiobGfqx8hcMv1Fjm2AMaUQC0kk?=
 =?us-ascii?Q?XoZI7m9vbKhjUafbVpI8SfgY4toafUeKQUBTczTWlrJz48vrc6TKTdAovkam?=
 =?us-ascii?Q?PE/HMnHdkrgrHKRkCtN4HFDfJ3i4ZQlTn4AARa6CLWHQEOKRKvCgj3AynT/P?=
 =?us-ascii?Q?hveOL9J4v9yHnRkE50AhBfvDqH0MT8zj/WsUeiddR13OStrFC61UQB+VXzjT?=
 =?us-ascii?Q?HOsZRaSoChr1gTPnZO/oZ9+Zgr72uIK8bl2KpZbtOFrPBBODc5Y+wpW0trY5?=
 =?us-ascii?Q?CS6TZgqxpmOfmCRP3LaL8eDjhSXW9L33mpQbLvHbJl5BPIZ1zVMtR2nF2htI?=
 =?us-ascii?Q?VKCQwhEEXSG8e/vTGdTMCYKcvhFwXIRy+dxjrNJ6igBsY23hhmt2hTN+7f8+?=
 =?us-ascii?Q?5tbLfeFQSYYD5vbzcpYdXEjL904zcisXN6AvMuYpezDDAD+areneHTNYHzhM?=
 =?us-ascii?Q?pHm4nf2i7eRZ+Vw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kdi3KFYQ344H5NKVvKaiMYmEbs9ZyW+AK3HZSrnCJmpMinbx4xEK0EFaXlEI?=
 =?us-ascii?Q?irlPX5m0J5POdFu1Mz17/VsWEm1zSb1g2GOkqcfYODzHgExI4svgMxMWGNzz?=
 =?us-ascii?Q?x0nNW1Gi2VoP9fpBQrBKeWar5atdEgvuPuhg8k0mzGxg+l64zGOXRo8LMi82?=
 =?us-ascii?Q?XHtqBEpev1uPUCbY636rGB/Q26xzkvk0Pck15zyGrCQu8iJsOu553NnwYYjO?=
 =?us-ascii?Q?Afaw/68j+mTff1Jsma8mZ8l4y6eMKrfEw3dgyg8fxR6Cy2yM3+2FsMMIxjBl?=
 =?us-ascii?Q?m1vrDzDBqnvMO7mqqpUZvaq+ypm8chybaxS00v+iozfGWyJ+i8Ztf6KfoboG?=
 =?us-ascii?Q?vAlKaculU7KmM+cBSHpV9C7jkyDGe46TGvIVzRORykTptv7f2ejP8UPqEFxx?=
 =?us-ascii?Q?pxx0+aZ26LiddJwxbDABXePvhy5+fQIAM51kjXfeamXVTEV+JFGr1qs988UV?=
 =?us-ascii?Q?VLPLSCSUdtPPPLcEBE9M3QQg1+u2Hi0IZLKaLJ5iQV6FoBgUoxfuGLY0MRk+?=
 =?us-ascii?Q?6efPO+Mdlei3fjn53WDNkTVX31QUWOrN9qpeZHnt+ilVAydcLKzVKXgmjuP0?=
 =?us-ascii?Q?E8t+M9QVIuiVdq9PVR+38Ukdoe4r5v/luA6vpyG0gH/QkvFjhOxLlDJrSIz1?=
 =?us-ascii?Q?Ea6pennLOiRBc7XzP0p5XpK9Wp1RpYiOsg/MQrvb6tBi7TgbClHPAG1jqpim?=
 =?us-ascii?Q?ixRsxaKI5SISd1AXttTNtDF569cupB4jYzn8HT35t2dmnEw2qdvLxnHbJnla?=
 =?us-ascii?Q?i4oHmMkFyoPWr6OR+lsGNwILu9WTJH+IaH22wwsRNjcAO08OOWgXwtGWa+pL?=
 =?us-ascii?Q?UuWA/elfTcwtvIaWje/2JSUpR1oEI8d9KTL15srIqPg4Q6leF7JG2gB6Y73j?=
 =?us-ascii?Q?67kQgrs/hCGe1xJaQuGwp6qqOldqWnNDjYWQ6ehcMleioZgOUadoXR2C2yuQ?=
 =?us-ascii?Q?Z43HKAei/dAUs1Zwd4G6CKJfvw6/sQ2ru5MaA6KFja2FCgTAgPnvAjbOTFlA?=
 =?us-ascii?Q?OqDjvywZfPGEczl9R/zs5j7v1VVnvZEybGLHxbcVTOkzBzt9jsaPXNxV7vvg?=
 =?us-ascii?Q?mJJEo4rbv7+Q0phWLVS7aDO4vB6dPzw+MkNwXQmPLmjCy3yC2/sKu7zX/8A2?=
 =?us-ascii?Q?6Qq1PxJ+7PdaP+UOk9qxVT7mxAifS06DeElaVMAEGBwQzxKy17SD3Mw7B59h?=
 =?us-ascii?Q?ENA71LIhT2WooRFhxqDOq+f6leKAiufghda1cfpwNIhlDTI7PIbCkBR7ubR9?=
 =?us-ascii?Q?pWoUeswn+PF+rqaYXtGr3WQhaIDLUB+/aJ7V57QaY7+AgpABwsrxQ6L6qqcr?=
 =?us-ascii?Q?pKkwzD78aRpSI6AoZ6NqVdLiS+XBmtMJWdVYeRvLo8AY/4UVy9HneEUf1J6U?=
 =?us-ascii?Q?I4sOKXif/+4t2ZPubBNvHaWvWD4CXJAL3kSzaiy+09dnNBIvbwdPRZjE+7dd?=
 =?us-ascii?Q?JBvtax13Aw0KHA9hh1N710UmM5pD2nuNI1YUnqYUOAswnN+ANKtsDD+Dyai8?=
 =?us-ascii?Q?WtNzbPbvqhRe55qzj0Jk5Is2vkZs1q6AezDimunZjtb8qqCdnmUwTYONsiVv?=
 =?us-ascii?Q?dVGYBgmvkAqel2dmwH2E5KLDGlBQPMRzq0fY2aHI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QqaUSScuFefG2SvRQvrO9tHFU3nGQNuov1SV6OSLmoTiDU1RWzScEgQllK5kdVx9GvTFxA1nrxUk0ymPAHfKJODzq3xjG6TkuezAleCWFy6pEICGnYkI/1/yUOP6OFAx60bDNt0zXeYCQP8R52n6dmnCcMfarhjpamqnuchC5VzWTzhl+AXgxbF6f+A5ea3X31H+g4yW1xS/Eh5dRIoLVboj+CU8htSytE/N0f3E5zBJYmyS5VmK+iuzezIuAY/MyYSe+HdzsNDGD+PSv/us/0KA1kbyqijVJ+jhNe7r8Uux9brTsPH0r6EfpMERmiLLyK1ZzQFiED0SqFK08cTWn0O0vBCOcWB3DNzDUKu8IzII8NM2439UoQDXKrjn4cwvFzesMcUbWASPI9MmTfMMYN3tD6ntOMnoyBGwOxmb/THIjU3BVJQ+Cb4rU8PCAdGNU3Ahd/R848uvyo5Xr58LrNS5YENioiDN/qY6BvUOwpOiWKvJQu5MQ8POedh/YEhQW2fUoApswzXLbw8k+5N7I7NsxAR2bHASePcJpQx3OWszCSEdbvcMx+OpT4/eIWfuOaym8p18QqcVvOQF8NJTOHcQ06OuobODkjho+xe889I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e53a85-a91d-4581-a498-08ddd898c5d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:34:43.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEq/Sb2g/Z0honzw8crwWl8k2hrMkt7qtnfgAkUdICOSWNPPg4CIVUhdQwVJTMAAmrav6Wh3Yn9Rctgz9OeSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA0AD88203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110035
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689980f8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Ut5Sv_cQT0ioXsQQ:21 a=xqWC_Br6kY4A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=OjyniKcQLBVGvT9PaUkA:9
X-Proofpoint-ORIG-GUID: -VVhk1-f8Wl6mVR_V8LBsVe8txOCGoq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzNSBTYWx0ZWRfX8ygFcBYwB5Sq
 Xlmnln/+WVlo4mHCv/mlcAQMptN3RaS2V5C7R+laIN7NLKPPBpN2wWkbE7XuwzZFsbbLE+Arss8
 /XTdZFrcRUncrAbWBrsvoq/3WHPOqh4Q0YUKYkC5+HDqEzUCstyvuJbW1JuDADju+pY6iXhKxps
 RcwVrocEyyqhxhwVZg2K136WgV0Q+pIKZJsPgtiQeLHOq/D32A4nzfWl3kRfmVjysPqXZ6T8zhS
 BNS6OYPsJ8y2G0EPsZXcl7ASGeqZldRfPwmvLW4//kBiQxYP+eC6yiU6M0xYCbjiVQ0aQ1thFgf
 N6Wroe0dj4K+L4UbalMEXRwHuzXOjr1OW6g97Mw2CvU5f+DzW2Hnp0yEMuPmXOUZWubGDo1kubF
 pGZmi0k0J+wJ0gCKGAWg20/uuCbyUBa3hcWoROCIjQQse9Fz3U2N8IamnrAQ645duxWncYio
X-Proofpoint-GUID: -VVhk1-f8Wl6mVR_V8LBsVe8txOCGoq5

v3: https://lore.kernel.org/linux-mm/aIQnvFTkQGieHfEh@hyeyoo/

To x86 folks:
It's not clear whether this should go through the MM tree or the x86
tree as it changes both. We could send it to the MM tree with Acks
from the x86 folks, or we could send it through the x86 tree instead.
What do you think?

To MM maintainers:
I'll add include/linux/pgalloc.h to "MEMORY MANAGEMENT - CORE"
in the follow-up series, if there's no objection.

v3 -> v4:
- Updated the subject line to emphasize that this is a bug fix rather
  than just an improvement. (was: a more robust approach to sync
  top level kernel page tables)
- Added include/linux/pgalloc.h and moved p*d_populate_kernel()
  to the file (fixed sparc64 build error).
- Added Fixes: tags to patch 1 and 2 to clarify which -stable versions
  they should be backported to (Andrew).
- Dropped patch 4 and 5 because they don't fix bugs but are
  improvements. They are planned as follow-ups (Andrew).
- Rebased onto the latest mm-hotfixes-unstable (f1f0068165a4), but also
  applies to the latest mm-unstable (c2144e09b922)

This patch series includes only minimal changes necessary for
backporting the fix to -stable. Planned follow-up patches:
- treewide: include linux/pgalloc.h instead of asm/pgalloc.h
  in common code
- MAINTAINERS: add include/linux/pgalloc.h to MM CORE
- x86/mm/64: convert p*d_populate{,_init} to _kernel variants
- x86/mm/64: drop unnecessary calls to sync_global_pgds() and
  fold it into its sole user

# The problem: It is easy to miss/overlook page table synchronization

Hi all,

During our internal testing, we started observing intermittent boot
failures when the machine uses 4-level paging and has a large amount
of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0 
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It turns out that the kernel panics while initializing vmemmap
(struct page array) when the vmemmap region spans two PGD entries,
because the new PGD entry is only installed in init_mm.pgd,
but not in the page tables of other tasks.

And looking at __populate_section_memmap():
  if (vmemmap_can_optimize(altmap, pgmap))                                
          // does not sync top level page tables
          r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
  else                                                                    
          // sync top level page tables in x86
          r = vmemmap_populate(start, end, nid, altmap);

In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
synchronizes the top level page table (See commit 9b861528a801
("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
changes")) so that all tasks in the system can see the new vmemmap area.

However, when vmemmap_can_optimize() returns true, the optimized path
skips synchronization of top-level page tables. This is because
vmemmap_populate_compound_pages() is implemented in core MM code, which
does not handle synchronization of the top-level page tables. Instead,
the core MM has historically relied on each architecture to perform this
synchronization manually.

We're not the first party to encounter a crash caused by not-sync'd
top level page tables: earlier this year, Gwan-gyeong Mun attempted to
address the issue [1] [2] after hitting a kernel panic when x86 code
accessed the vmemmap area before the corresponding top-level entries
were synced. At that time, the issue was believed to be triggered
only when struct page was enlarged for debugging purposes, and the patch
did not get further updates.

It turns out that current approach of relying on each arch to handle
the page table sync manually is fragile because 1) it's easy to forget
to sync the top level page table, and 2) it's also easy to overlook that
the kernel should not access the vmemmap and direct mapping areas before
the sync.

# The solution: Make page table sync more code robust and harder to miss

To address this, Dave Hansen suggested [3] [4] introducing
{pgd,p4d}_populate_kernel() for updating kernel portion
of the page tables and allow each architecture to explicitly perform
synchronization when installing top-level entries. With this approach,
we no longer need to worry about missing the sync step, reducing the risk
of future regressions.

The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
vmalloc and ioremap to synchronize page tables.

pgd_populate_kernel() looks like this:
static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
                                       p4d_t *p4d)
{
        pgd_populate(&init_mm, pgd, p4d);
        if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
                arch_sync_kernel_mappings(addr, addr);
}

It is worth noting that vmalloc() and apply_to_range() carefully
synchronizes page tables by calling p*d_alloc_track() and
arch_sync_kernel_mappings(), and thus they are not affected by
this patch series.

This patch series was hugely inspired by Dave Hansen's suggestion and
hence added Suggested-by: Dave Hansen.

Cc stable because lack of this series opens the door to intermittent
boot failures.

[1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
[2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
[3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
[4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 

Harry Yoo (3):
  mm: move page table sync declarations to linux/pgtable.h
  mm: introduce and use {pgd,p4d}_populate_kernel()
  x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and
    arch_sync_kernel_mappings()

 arch/x86/include/asm/pgtable_64_types.h |  3 +++
 arch/x86/mm/init_64.c                   |  5 +++++
 include/linux/pgalloc.h                 | 24 ++++++++++++++++++++++++
 include/linux/pgtable.h                 | 16 ++++++++++++++++
 include/linux/vmalloc.h                 | 16 ----------------
 mm/kasan/init.c                         | 12 ++++++------
 mm/percpu.c                             |  6 +++---
 mm/sparse-vmemmap.c                     |  6 +++---
 8 files changed, 60 insertions(+), 28 deletions(-)
 create mode 100644 include/linux/pgalloc.h

-- 
2.43.0

