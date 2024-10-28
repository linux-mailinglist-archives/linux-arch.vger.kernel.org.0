Return-Path: <linux-arch+bounces-8656-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA019B3318
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0A1F227CC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58741DE3CB;
	Mon, 28 Oct 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FBlMSfqY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c/3KqVJf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276B1DE2DA;
	Mon, 28 Oct 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124890; cv=fail; b=V5W2WOF8LzYCX3ZM9YI9NomwvrGGUYFB7hetlWA0xGquqoHtG99WzOqtRxaSVf+xeLw25oVmEFzIEZuQf/Z+osLCGs4rcN3pN62n1QiIvmWrmqO0z/nLSdIcnL/S2/vCzpy3NuSLkMQ9Yy6fdJLd/+Amo4DxRbpqXjiHJXc4KGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124890; c=relaxed/simple;
	bh=rFzMm+wTjGC7z/6mArtj4rddXA6XhJYdnS0yA8QQ16I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVYBlHF880ab8Kjt1U/TLmbihvTK25cFux5+kL2XtAiLmD9q0BLePkihxrbADAF6vY0iq2K2aRVpIFwqjnVD5nPw6OMybQpCk2y43md59oMmaYTptjGUpWqIG757UcQla8oHE5DlK/QZynkB42N1P6VuUj99X9e/LYQXiJZQL7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FBlMSfqY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c/3KqVJf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBSf6r024165;
	Mon, 28 Oct 2024 14:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bzuMMdtjg6weBfZvea4Lfu3jFEmQm0TlQxJGaxqxxNY=; b=
	FBlMSfqY1jKVRNZIGger311woONo20fCzHRbkfVKuT+YMlbcCuov7d7KmMsMN5au
	Hu14MXkAV2F7shj86kfRsHMLmiqpywvpZsVc/YbrxMf6gMm4AGYjBehWrcMEezSs
	zEUILqcRhKOlcLLDsaGMx0GQM5GV44j0hmIaIDVJTQgqymLHDldkDVgrJ/ceq1h3
	XiYQUBNtOKvnxc2Szij2oYc4kiPAXtLsoZPwJECJx7qxm/YUpKv/oEhOLlhf4lq+
	AzPdvknTuHRLypyBFrk/cWJ4OhEGPuaXMwKhkbqY+uv4iILtbXypXndvREy9H4N5
	6B+u84fOZ9cTnTE/jbK4DQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxjymr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCvICk004790;
	Mon, 28 Oct 2024 14:13:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2sk9y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyhzLO8JLn5O8LmT98KDGOV2Q4RY78TAJuhA3YxRiPTMPK0cm5EMretHOFmVCJAb05yoonYi7QzCyB6+6R8Hx3RfbJHOEOZfRSnuZzBEcjBd28UV85K/s2qUqOCgeHsw3lRGqDXMSwLnbMUmT++OlSrkixtElQpuwnrK9YVxytR4DgPwDFnoLPr/Wrd0AI8sTmfugEfqojB8XU6fMAKhsV+dqUFptVrIbG2gViC/cDjESGngimmYOV4MDHaPymUK6suojhzKIXZlJfXftH3hBFoKZG8UFmwZVDoazmfUUTL0U88f0kKIvy1GWqjohc0HweXNmzlYp+tOyLvSTrzfiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzuMMdtjg6weBfZvea4Lfu3jFEmQm0TlQxJGaxqxxNY=;
 b=LIiqEF2Z3+GVExqZMq0HxO82EXm2NkO1chRHXTD9TCfymVoji9HRSnVEj20YRlP9HT4UMiSPJCjzpBN4XhPy5oKq0C8U11pLD/WgIHZt/0s9KU3/obaABJFR79Hxe+aAPSBsvTljrdgabny7CWBFKRr+5i11HgtdSA+jYccNtMiZoYGUkTlJrNycYb/8mWsu8AXhsxc4Oqsg6Yc1ENHecv+xrgJ+Vw+Mbg8td194Lie38tqWUXlAtlMJTgUfY7lcPOolEhKy6m7/HucXugahqsl3fITGDyACZrFRXt+WYOeZT8wpVp3ibO7FAxXgtAavuD6e9hCFZXB6QGVGCWrR0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzuMMdtjg6weBfZvea4Lfu3jFEmQm0TlQxJGaxqxxNY=;
 b=c/3KqVJfLE/INXtuYEBp9yCzJzzt1mXoMPhVP0eCWrz3cJXXo2nnOSClMguNNWfnP6eH5Po3PaZiRYG41ErKuY9woR8JWUJan/6KpoC46L1CBAKI0tjPA2SnhssH7PAt5IoB6CPn1T0JLwd0nQBEyBGNbnL9PX2gn1z7g0IUTmA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:13:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:13:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 1/5] mm: pagewalk: add the ability to install PTEs
Date: Mon, 28 Oct 2024 14:13:27 +0000
Message-ID: <51b432ebef013e3fdf9f92101533435de1bffadf.1730123433.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c0a6fd-c965-4fec-d972-08dcf75ab863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZqR85DfyFEZlLGeWat2NtsKmOZUgYeU05xMSeMndl6CwY0/TeJvVQRFXdY11?=
 =?us-ascii?Q?RcXFDQsflURDYX0xRCavo5Ut/+eipho5gM8dtmeuhzzQXxqswhtOAcRt2lBq?=
 =?us-ascii?Q?Glu5mS83+66lfM+WG3mRru9ThAdDfqgcYBvNoNt/pTiE8b1dtzIRsDYI2Ebj?=
 =?us-ascii?Q?AVYYIHRUK10JjulMSI9Mv8JU4CdfZuf/4Oukz2CGpBlv7dx3qHDD+uEHP7sg?=
 =?us-ascii?Q?7eDlctR0m11pOPqFlvconSwltpUApamTpkCZjc+ZbwQPF+LFMPUAowEg9Pjb?=
 =?us-ascii?Q?KyKITH+HtXMUiocWD2/BnrjDrKs6DKZRoeLvspDpuApSdacDBS2n/FSO932C?=
 =?us-ascii?Q?Qj6R5mY264nfj/D258LgykEPmOPWrdlF8XriXcRXkT5SVRRiKFJn4J+84lmr?=
 =?us-ascii?Q?ocBDgmdkXy0kyMpHzFmCr2/BlMwBpkZT8DU/h5//ELxASVGsjuUckgtgTLRN?=
 =?us-ascii?Q?WV6AY468SR3Cn4Ewd8DWnemTOjUFJbTznQK+NGoOG2fknQmWb8p/6Z7gRtlZ?=
 =?us-ascii?Q?POa0UehBmanJd1TcQb0w6GCk2EL//53jIArbB4UckqsWXo0s5l4/hpc0s7Fc?=
 =?us-ascii?Q?wAxfyivUMsJlwDQns8ZqHLvS7Y8rBw322Ho9ximFkIQxdEuGoJD1rwDUrsYV?=
 =?us-ascii?Q?Wzu7SlOkyWwW4BaxyaUcJ01Wc8NzsHh/zLfAn3Q7np4JzJw48bwYTdyuLQRk?=
 =?us-ascii?Q?O93wRQAIIb7r/jWu1/mnqow3bGFpvEuCSPRsRwdyQtxVyZNYRJPQzTXzXm7P?=
 =?us-ascii?Q?okP6mbq8t6JTTNgGtT5MkeXiEp6PdiFRpSKQlGlEala8hwgCDd+IZQ+Dc/C3?=
 =?us-ascii?Q?FOFI4hq3rdMPou3ud1LMWA9qjjPurXQ9VhrPqjIOL+fOeKF6bbIRIN3JTJ4f?=
 =?us-ascii?Q?Gb7nIBhCdh2ngOZSNUI9wbx+mYuITRY/w7t3BzFsaAnrZDDv4w9N8DlOAnqS?=
 =?us-ascii?Q?yTLE8u28GRSuVcGUphsQ1uPe4gFMTQdt/uia7fekWXSmM1ah9yd1UF+06NVy?=
 =?us-ascii?Q?QN8jUmi7l1L8hDsZ5zuoaboC7S73DnYanoHCjgVSROFkolqq4FO0Z+gf+19d?=
 =?us-ascii?Q?pI5xr0veMQSlEBMZJQnJ2pc8aRPBY3neHjOn/QGAHe54a0uqgPPMu0WFKFNQ?=
 =?us-ascii?Q?js8RIW0Dy6XVvkM5VCaQX8vbp9sIWDMhYfhC4cilhgeJXRoYav1HoOMNVJYG?=
 =?us-ascii?Q?QMZfJuVPvctJPhyyFCUT7ROCo7W2/RL7q20mq8+Gb06N68V5mGnaKLdChYZa?=
 =?us-ascii?Q?XGSiHxoUKSoQnQeG/maZc3j5/XxVwzZi1dsR3sHD2N5CBO3CKB9FO+CRCAVv?=
 =?us-ascii?Q?El5/r34J/gEBCvzh5Zq2w3Nb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lO6pnk2WeIzb3Jb4u+5BzD0MANwfoILYQtiTGhYc2rLzu0QepdrIL92S7pFK?=
 =?us-ascii?Q?4EvrQ34tcM+i5b4JelgmzP6iiRCHUWYRtvvQP2sky370mBIh/3bPFS9ID+CQ?=
 =?us-ascii?Q?/OCs2U5tQ2wpZ5NWMNmbzvsxPgKSJfa1y5K/rHBDgmQ4P7963i10AHWTL+oD?=
 =?us-ascii?Q?gsZ0j3K0xWhvOWno1BDD1Vs/1o1WJCMBrsESor6TCN+iLIKIp/h1ZSwuI/Fl?=
 =?us-ascii?Q?CgogmQLM8j/dfvfOB5XpbqJ/uf9yHzLl2zIRQfzBug/ryYj3A+8dlnePR8IG?=
 =?us-ascii?Q?wBNbR6H6vRqzxgvs5RJsROzEgIiHYxc19rKgoVjPlXRzw311imB2Na6JMVG2?=
 =?us-ascii?Q?phcTXlzsxu+sBqCmhlV8nO79UpOPT59qFKEll4CXD+zG2vy+/NbVlSCNgvyD?=
 =?us-ascii?Q?qqucdyUSw6hXpcrpsZ2NlMMYFGJk9KR/TNie+blThGs/eCdNuUDjCmVjOR+g?=
 =?us-ascii?Q?mmsitriI6DKEjtCrwOf68veSxoFNe6eAT8GMfPc3e+1mdFD2V6iRhmGde4fp?=
 =?us-ascii?Q?O60tNNM3MCnbXngBQmJEawoW34xUVjdj5JMXZMrIRJoyvJ3ZjnmpdHpfVPDV?=
 =?us-ascii?Q?3ZpVT+L8isgXhNtW4w/0YMVUJEdb9jYQetyOuoUmtvSNYWBdDswff2RIR6Yr?=
 =?us-ascii?Q?1REL32UBNX5rh3gtOI0lqvRdrmulEBXfgZqJkCEfwzBZmvBqoWfllJ2j0PvU?=
 =?us-ascii?Q?uKCNY8F6VKQM6tYa7n6rgE1VG+CaudRPOhqNT1XZSO/otIQkxWO0TC0PVyGL?=
 =?us-ascii?Q?OyTdlzBfbvasoLfRN/MVpXXTBtWZi8bAixcwQgADP7/7I6UVAhoqA5esoK16?=
 =?us-ascii?Q?2vWQKxjEs7Fitw/9FriusELANaMEZJJ4Zht8mrx8/P95VxPdhFfMl09RGO92?=
 =?us-ascii?Q?ws/Evj6fSxerbxhzfcSTNBXOiZe+ePZA+UftEjoGtC6UMCG/1dLTQw0Hniu6?=
 =?us-ascii?Q?5ApuKDkSkHwZDiX4Pz7fu9OVIqQDfsHw4m8/s7/PyNSy8CWaBTojEEifN49k?=
 =?us-ascii?Q?To96sREBzOL6f4iEBNAT5mRnYHrZOIXwmTYFmUZzAXn7ai4Aov5Aqvsc1Osz?=
 =?us-ascii?Q?OYgtgje43NFN9nDY6NXu63PCSwNZ0JFEqaxzJ4kNb4jYWQ321WawgxGEYzY7?=
 =?us-ascii?Q?SzK9Pj9JH0aOneQRUkjIfV3P46dMswZLFQZBalskiPWT1w1DuT0o8l3IfUtH?=
 =?us-ascii?Q?OUgGlGuqys8moei2wS7d5IAyXX6jTolny3LivKSTDgSk7JOAODIBEF+egNuW?=
 =?us-ascii?Q?XNnrhcq30eNiNqjCrWRpCcv2vQdQRTc8ELKLFLv8a9380Df7GxJbLMv0os+Z?=
 =?us-ascii?Q?KVpmm4rvBKtot3Q12Jc/Ls7aMkxUaXege49MHd6Qh1j9jkhIL1ji2vRCEUwc?=
 =?us-ascii?Q?pBJuNBl960OKqkj6H8XYoO7JiTP0mTdZwDhtoCSR9oi7DG/R0owcCEjJeOlz?=
 =?us-ascii?Q?Wx8zIHq6xig7jHtZEKUv9rfeLFpJiWV2+I7akdf4Gmc/qzRQLo3SRGWZgNE7?=
 =?us-ascii?Q?w52R3+k1llSKURz6kzrV7I8KQnLRaeo5slwfg81z6Oiwq3pTyKbXAdDR8sEn?=
 =?us-ascii?Q?qr8+bqCbBnqFfGuWXQHPttPOhO6EyWxEAG9hl6U3QMgfMIXZpBPZrRWUSqhn?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CzDLAmuCVwPirMfdhBW+Pi8oJJ5lrGWy8xT1Jfbc3swQ7PmnkKw1E8fnP4FjYD27CuZxEX8Hiexjuld+LNT55XZwLWZZHg2AlhtmXJ52R1S2Xg3sMjmJL8/4nyL6cBCE8R6ynRoZb3LyFkUHs1jd5Q5RKpO24hCUI4gq1YzZUNJKMoIjf4GBFinltEhPGrhgpPa90ZO6NRuBuJ5o233E9fPs7ta72tWHxOuagGumw/B2LYKBOVzGviCPtYqMhz7a4lfU7AkqcKAu06W5A3oZ4GRtDwEZYa2Z0KklcaZa4cnRMOLmqt7OaBlX6umEK81itTM2DWiN+oNBgTGHGIpPdJoSvX66v1dVq4McvIfvv1JuzxA28zoWgqmVDwMUGlRSaV9hosv8RBgjMEY9YICDku2CSusgjKewVuQ1siE8aOhBufqOJSoNk9Q9llclOBkYocX+Tmds+DUc6Gy2W8XUWUZXcy8zjczihslrvUhcNOqLMIiaGTMoUzsQG80+lUd0A0Pm2r2qBPJ0Zo3qpJ4bnQMciK5sEV3gE4gZhoW/HyPPkWqGUZrDRo+DBcHr/NqbHs/M3jG7SkniMbydoDRTxKla7SLS2UvwT4Yq8NhSHGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c0a6fd-c965-4fec-d972-08dcf75ab863
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:13:39.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Cr2dWqt/DlqxnbMk9Df7jG9417Y5yLJBWuLwvRw6WJkPxSN3/ecY/JpfZflJT/R7lFQCbXuW/tsD67/3YMCd+QMX8O+AxmfCoGkFFjlS/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280114
X-Proofpoint-GUID: kf8nhKhPlZbW3BkhJxpt9lX7KAzxTqkO
X-Proofpoint-ORIG-GUID: kf8nhKhPlZbW3BkhJxpt9lX7KAzxTqkO

The existing generic pagewalk logic permits the walking of page tables,
invoking callbacks at individual page table levels via user-provided
mm_walk_ops callbacks.

This is useful for traversing existing page table entries, but precludes
the ability to establish new ones.

Existing mechanism for performing a walk which also installs page table
entries if necessary are heavily duplicated throughout the kernel, each
with semantic differences from one another and largely unavailable for use
elsewhere.

Rather than add yet another implementation, we extend the generic pagewalk
logic to enable the installation of page table entries by adding a new
install_pte() callback in mm_walk_ops. If this is specified, then upon
encountering a missing page table entry, we allocate and install a new one
and continue the traversal.

If a THP huge page is encountered at either the PMD or PUD level we split
it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
otherwise if there is only an ops->install_pte(), we avoid the unnecessary
split.

We do not support hugetlb at this stage.

If this function returns an error, or an allocation fails during the
operation, we abort the operation altogether. It is up to the caller to
deal appropriately with partially populated page table ranges.

If install_pte() is defined, the semantics of pte_entry() change - this
callback is then only invoked if the entry already exists. This is a useful
property, as it allows a caller to handle existing PTEs while installing
new ones where necessary in the specified range.

If install_pte() is not defined, then there is no functional difference to
this patch, so all existing logic will work precisely as it did before.

As we only permit the installation of PTEs where a mapping does not already
exist there is no need for TLB management, however we do invoke
update_mmu_cache() for architectures which require manual maintenance of
mappings for other CPUs.

We explicitly do not allow the existing page walk API to expose this
feature as it is dangerous and intended for internal mm use only. Therefore
we provide a new walk_page_range_mm() function exposed only to
mm/internal.h.

We take the opportunity to additionally clean up the page walker logic to
be a little easier to follow.{

Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

{#	modified:   mm/pagewalk.c
---
 include/linux/pagewalk.h |  18 ++-
 mm/internal.h            |   6 +
 mm/pagewalk.c            | 246 ++++++++++++++++++++++++++++-----------
 3 files changed, 201 insertions(+), 69 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f5eb5a32aeed..9700a29f8afb 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -25,12 +25,15 @@ enum page_walk_lock {
  *			this handler is required to be able to handle
  *			pmd_trans_huge() pmds.  They may simply choose to
  *			split_huge_page() instead of handling it explicitly.
- * @pte_entry:		if set, called for each PTE (lowest-level) entry,
- *			including empty ones
+ * @pte_entry:		if set, called for each PTE (lowest-level) entry
+ *			including empty ones, except if @install_pte is set.
+ *			If @install_pte is set, @pte_entry is called only for
+ *			existing PTEs.
  * @pte_hole:		if set, called for each hole at all levels,
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
- *			are skipped.
+ *			are skipped. If @install_pte is specified, this will
+ *			not trigger for any populated ranges.
  * @hugetlb_entry:	if set, called for each hugetlb entry. This hook
  *			function is called with the vma lock held, in order to
  *			protect against a concurrent freeing of the pte_t* or
@@ -51,6 +54,13 @@ enum page_walk_lock {
  * @pre_vma:            if set, called before starting walk on a non-null vma.
  * @post_vma:           if set, called after a walk on a non-null vma, provided
  *                      that @pre_vma and the vma walk succeeded.
+ * @install_pte:        if set, missing page table entries are installed and
+ *                      thus all levels are always walked in the specified
+ *                      range. This callback is then invoked at the PTE level
+ *                      (having split any THP pages prior), providing the PTE to
+ *                      install. If allocations fail, the walk is aborted. This
+ *                      operation is only available for userland memory. Not
+ *                      usable for hugetlb ranges.
  *
  * p?d_entry callbacks are called even if those levels are folded on a
  * particular architecture/configuration.
@@ -76,6 +86,8 @@ struct mm_walk_ops {
 	int (*pre_vma)(unsigned long start, unsigned long end,
 		       struct mm_walk *walk);
 	void (*post_vma)(struct mm_walk *walk);
+	int (*install_pte)(unsigned long addr, unsigned long next,
+			   pte_t *ptep, struct mm_walk *walk);
 	enum page_walk_lock walk_lock;
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index c4c884d61024..41b60204b059 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
 #include <linux/pagemap.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -1502,4 +1503,9 @@ static inline void accept_page(struct page *page)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+/* pagewalk.c */
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5f9f01532e67..e478777c86e1 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -3,9 +3,14 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_context.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include <asm/tlbflush.h>
+
+#include "internal.h"
+
 /*
  * We want to know the real level where a entry is located ignoring any
  * folding of levels which may be happening. For example if p4d is folded then
@@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 	int err = 0;
 
 	for (;;) {
-		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
-		if (err)
-		       break;
+		if (ops->install_pte && pte_none(ptep_get(pte))) {
+			pte_t new_pte;
+
+			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
+					       walk);
+			if (err)
+				break;
+
+			set_pte_at(walk->mm, addr, pte, new_pte);
+			/* Non-present before, so for arches that need it. */
+			if (!WARN_ON_ONCE(walk->no_vma))
+				update_mmu_cache(walk->vma, addr, pte);
+		} else {
+			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
+			if (err)
+				break;
+		}
 		if (addr >= end - PAGE_SIZE)
 			break;
 		addr += PAGE_SIZE;
@@ -81,6 +100,8 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd_t *pmd;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool has_handler = ops->pte_entry;
+	bool has_install = ops->install_pte;
 	int err = 0;
 	int depth = real_depth(3);
 
@@ -89,11 +110,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 again:
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
-			if (ops->pte_hole)
+			if (has_install)
+				err = __pte_alloc(walk->mm, pmd);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!has_install)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -109,18 +133,25 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
-
-		/*
-		 * Check this here so we only break down trans_huge
-		 * pages when we _need_ to
-		 */
-		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
-		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pte_entry))
+		if (walk->action == ACTION_CONTINUE)
 			continue;
 
+		if (!has_handler) { /* No handlers for lower page tables. */
+			if (!has_install)
+				continue; /* Nothing to do. */
+			/*
+			 * We are ONLY installing, so avoid unnecessarily
+			 * splitting a present huge page.
+			 */
+			if (pmd_present(*pmd) &&
+			    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
+				continue;
+		}
+
 		if (walk->vma)
 			split_huge_pmd(walk->vma, pmd, addr);
+		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
+			continue; /* Nothing to do. */
 
 		err = walk_pte_range(pmd, addr, next, walk);
 		if (err)
@@ -140,6 +171,8 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud_t *pud;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool has_handler = ops->pmd_entry || ops->pte_entry;
+	bool has_install = ops->install_pte;
 	int err = 0;
 	int depth = real_depth(2);
 
@@ -148,11 +181,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
  again:
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
-			if (ops->pte_hole)
+			if (has_install)
+				err = __pmd_alloc(walk->mm, pud, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!has_install)
+				continue;
 		}
 
 		walk->action = ACTION_SUBTREE;
@@ -164,14 +200,26 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 
 		if (walk->action == ACTION_AGAIN)
 			goto again;
-
-		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
-		    walk->action == ACTION_CONTINUE ||
-		    !(ops->pmd_entry || ops->pte_entry))
+		if (walk->action == ACTION_CONTINUE)
 			continue;
 
+		if (!has_handler) { /* No handlers for lower page tables. */
+			if (!has_install)
+				continue; /* Nothing to do. */
+			/*
+			 * We are ONLY installing, so avoid unnecessarily
+			 * splitting a present huge page.
+			 */
+			if (pud_present(*pud) &&
+			    (pud_trans_huge(*pud) || pud_devmap(*pud)))
+				continue;
+		}
+
 		if (walk->vma)
 			split_huge_pud(walk->vma, pud, addr);
+		else if (pud_leaf(*pud) || !pud_present(*pud))
+			continue; /* Nothing to do. */
+
 		if (pud_none(*pud))
 			goto again;
 
@@ -189,6 +237,8 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	p4d_t *p4d;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool has_handler = ops->pud_entry || ops->pmd_entry || ops->pte_entry;
+	bool has_install = ops->install_pte;
 	int err = 0;
 	int depth = real_depth(1);
 
@@ -196,18 +246,21 @@ static int walk_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	do {
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d)) {
-			if (ops->pte_hole)
+			if (has_install)
+				err = __pud_alloc(walk->mm, p4d, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, depth, walk);
 			if (err)
 				break;
-			continue;
+			if (!has_install)
+				continue;
 		}
 		if (ops->p4d_entry) {
 			err = ops->p4d_entry(p4d, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (has_handler || has_install)
 			err = walk_pud_range(p4d, addr, next, walk);
 		if (err)
 			break;
@@ -222,6 +275,9 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	pgd_t *pgd;
 	unsigned long next;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool has_handler = ops->p4d_entry || ops->pud_entry || ops->pmd_entry ||
+		ops->pte_entry;
+	bool has_install = ops->install_pte;
 	int err = 0;
 
 	if (walk->pgd)
@@ -231,18 +287,21 @@ static int walk_pgd_range(unsigned long addr, unsigned long end,
 	do {
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd)) {
-			if (ops->pte_hole)
+			if (has_install)
+				err = __p4d_alloc(walk->mm, pgd, addr);
+			else if (ops->pte_hole)
 				err = ops->pte_hole(addr, next, 0, walk);
 			if (err)
 				break;
-			continue;
+			if (!has_install)
+				continue;
 		}
 		if (ops->pgd_entry) {
 			err = ops->pgd_entry(pgd, addr, next, walk);
 			if (err)
 				break;
 		}
-		if (ops->p4d_entry || ops->pud_entry || ops->pmd_entry || ops->pte_entry)
+		if (has_handler || has_install)
 			err = walk_p4d_range(pgd, addr, next, walk);
 		if (err)
 			break;
@@ -334,6 +393,11 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 	int err = 0;
 	struct vm_area_struct *vma = walk->vma;
 	const struct mm_walk_ops *ops = walk->ops;
+	bool is_hugetlb = is_vm_hugetlb_page(vma);
+
+	/* We do not support hugetlb PTE installation. */
+	if (ops->install_pte && is_hugetlb)
+		return -EINVAL;
 
 	if (ops->pre_vma) {
 		err = ops->pre_vma(start, end, walk);
@@ -341,7 +405,7 @@ static int __walk_page_range(unsigned long start, unsigned long end,
 			return err;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_hugetlb) {
 		if (ops->hugetlb_entry)
 			err = walk_hugetlb_range(start, end, walk);
 	} else
@@ -380,47 +444,14 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
 #endif
 }
 
-/**
- * walk_page_range - walk page table with caller specific callbacks
- * @mm:		mm_struct representing the target process of page table walk
- * @start:	start address of the virtual address range
- * @end:	end address of the virtual address range
- * @ops:	operation to call during the walk
- * @private:	private data for callbacks' usage
- *
- * Recursively walk the page table tree of the process represented by @mm
- * within the virtual address range [@start, @end). During walking, we can do
- * some caller-specific works for each entry, by setting up pmd_entry(),
- * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
- * callbacks, the associated entries/pages are just ignored.
- * The return values of these callbacks are commonly defined like below:
- *
- *  - 0  : succeeded to handle the current entry, and if you don't reach the
- *         end address yet, continue to walk.
- *  - >0 : succeeded to handle the current entry, and return to the caller
- *         with caller specific value.
- *  - <0 : failed to handle the current entry, and return to the caller
- *         with error code.
- *
- * Before starting to walk page table, some callers want to check whether
- * they really want to walk over the current vma, typically by checking
- * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
- * purpose.
- *
- * If operations need to be staged before and committed after a vma is walked,
- * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
- * since it is intended to handle commit-type operations, can't return any
- * errors.
- *
- * struct mm_walk keeps current values of some common data like vma and pmd,
- * which are useful for the access from callbacks. If you want to pass some
- * caller-specific data to callbacks, @private should be helpful.
+/*
+ * See the comment for walk_page_range(), this performs the heavy lifting of the
+ * operation, only sets no restrictions on how the walk proceeds.
  *
- * Locking:
- *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
- *   because these function traverse vma list and/or access to vma's data.
+ * We usually restrict the ability to install PTEs, but this functionality is
+ * available to internal memory management code and provided in mm/internal.h.
  */
-int walk_page_range(struct mm_struct *mm, unsigned long start,
+int walk_page_range_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private)
 {
@@ -479,6 +510,80 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	return err;
 }
 
+/*
+ * Determine if the walk operations specified are permitted to be used for a
+ * page table walk.
+ *
+ * This check is performed on all functions which are parameterised by walk
+ * operations and exposed in include/linux/pagewalk.h.
+ *
+ * Internal memory management code can use the walk_page_range_mm() function to
+ * be able to use all page walking operations.
+ */
+static bool check_ops_valid(const struct mm_walk_ops *ops)
+{
+	/*
+	 * The installation of PTEs is solely under the control of memory
+	 * management logic and subject to many subtle locking, security and
+	 * cache considerations so we cannot permit other users to do so, and
+	 * certainly not for exported symbols.
+	 */
+	if (ops->install_pte)
+		return false;
+
+	return true;
+}
+
+/**
+ * walk_page_range - walk page table with caller specific callbacks
+ * @mm:		mm_struct representing the target process of page table walk
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * Recursively walk the page table tree of the process represented by @mm
+ * within the virtual address range [@start, @end). During walking, we can do
+ * some caller-specific works for each entry, by setting up pmd_entry(),
+ * pte_entry(), and/or hugetlb_entry(). If you don't set up for some of these
+ * callbacks, the associated entries/pages are just ignored.
+ * The return values of these callbacks are commonly defined like below:
+ *
+ *  - 0  : succeeded to handle the current entry, and if you don't reach the
+ *         end address yet, continue to walk.
+ *  - >0 : succeeded to handle the current entry, and return to the caller
+ *         with caller specific value.
+ *  - <0 : failed to handle the current entry, and return to the caller
+ *         with error code.
+ *
+ * Before starting to walk page table, some callers want to check whether
+ * they really want to walk over the current vma, typically by checking
+ * its vm_flags. walk_page_test() and @ops->test_walk() are used for this
+ * purpose.
+ *
+ * If operations need to be staged before and committed after a vma is walked,
+ * there are two callbacks, pre_vma() and post_vma(). Note that post_vma(),
+ * since it is intended to handle commit-type operations, can't return any
+ * errors.
+ *
+ * struct mm_walk keeps current values of some common data like vma and pmd,
+ * which are useful for the access from callbacks. If you want to pass some
+ * caller-specific data to callbacks, @private should be helpful.
+ *
+ * Locking:
+ *   Callers of walk_page_range() and walk_page_vma() should hold @mm->mmap_lock,
+ *   because these function traverse vma list and/or access to vma's data.
+ */
+int walk_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		void *private)
+{
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
+	return walk_page_range_mm(mm, start, end, ops, private);
+}
+
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
  * @mm:		mm_struct representing the target process of page table walk
@@ -494,7 +599,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
  * walking the kernel pages tables or page tables for firmware.
  *
  * Note: Be careful to walk the kernel pages tables, the caller may be need to
- * take other effective approache (mmap lock may be insufficient) to prevent
+ * take other effective approaches (mmap lock may be insufficient) to prevent
  * the intermediate kernel page tables belonging to the specified address range
  * from being freed (e.g. memory hot-remove).
  */
@@ -513,6 +618,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 
 	if (start >= end || !walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	/*
 	 * 1) For walking the user virtual address space:
@@ -556,6 +663,8 @@ int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 		return -EINVAL;
 	if (start < vma->vm_start || end > vma->vm_end)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -574,6 +683,8 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 
 	if (!walk.mm)
 		return -EINVAL;
+	if (!check_ops_valid(ops))
+		return -EINVAL;
 
 	process_mm_walk_lock(walk.mm, ops->walk_lock);
 	process_vma_walk_lock(vma, ops->walk_lock);
@@ -623,6 +734,9 @@ int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
 	unsigned long start_addr, end_addr;
 	int err = 0;
 
+	if (!check_ops_valid(ops))
+		return -EINVAL;
+
 	lockdep_assert_held(&mapping->i_mmap_rwsem);
 	vma_interval_tree_foreach(vma, &mapping->i_mmap, first_index,
 				  first_index + nr - 1) {
-- 
2.47.0


