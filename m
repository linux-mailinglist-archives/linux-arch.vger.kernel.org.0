Return-Path: <linux-arch+bounces-12293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91963AD2696
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3836B1893E95
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49821CC7D;
	Mon,  9 Jun 2025 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UuzojlsU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L7g52jlg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F5A191F89;
	Mon,  9 Jun 2025 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496586; cv=fail; b=Hu5uG6+KqD0/NeMGmOj6yemR4kgkduy0BdqClte7CARKvQhWOLde3+Vbes2+znuCt97Hx9XtUzaCCqn0fNyD/3K9H+tVzy4ktHqfRL/FgMPe3E7K+CAN+1o+bTg24uSZh0F7z1z3qZ5qIkArQjI7l/QZ8BYCwqE7bVkMOFHoV3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496586; c=relaxed/simple;
	bh=26O8rR+EPqvBomAL9VCPQuX+qL4s7OiSPY/1tNkRD8Y=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=W4UCzjAYjpRteifH4oKe1168FXY1GMONIYDcZqj1Vjz0Eg/839oEQAjD2p6Rfbu8CVhZOMmmWUkDawvVQ7X0xgz21aU8cVwCcbx47UivSc2hySt9a1Ln7Wgki6XPddZwqcoplSPsozmH4BitoB9zEGiSN1vW8nCYfii5Rz4BFdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UuzojlsU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L7g52jlg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559Fcb3I017209;
	Mon, 9 Jun 2025 19:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=j9li34Er//EiHqfhuW
	71TYAf0m6BYvNHAZLSVdQfQTE=; b=UuzojlsUAdz6VvSaYpqAHHqT+PJsNN1QiL
	NhY7On+FsQQftRyKIADwniFKBnkOrbCpjwgBOHf+LWkACdvXyhHjOw8k2bT/tQOX
	frQREIC504ZTWInPd57VVIX+cLLffr3d/ybEp8MY4w4VOtPUraJVyFWT9a/eB3Zm
	xpIGBaIr1VcMfPshC4tramuDjjRT1TVaBocbY+y2luE1PfIqCPVEu/Zdw7EX1eFx
	gJI8xsZ3Xw67KUB8XK65JsdccE1ZtEzI9tCF6jq62HCjaSBIxgodjJ3Yenj3dxWh
	dAo+zgVaxzO8P9ycGq/b1VHvpZfrPY59F9MAMAWRA+PWeew1WYQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c74tua5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 19:16:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559H9rue020989;
	Mon, 9 Jun 2025 19:16:09 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bve2dph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 19:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGhfCJ8Th0J4h9g/JQKUWPuvoomAHvc7nx/2gd9vylXLxX1cq1Cstzc+WZ1qneHXyalTNezs8UgaFCikEORPfBOvvl/Doy5wR3nxyVcnuQls5kF9zMLkd3wO40s0xtHy6JffV6S7wPV2ZfS487AXP43aoCFuicd/esLig1m16ekEZFYP9n/QKO4gvS0yUzDe0AzirpWW4XVi5hrKBkyiAEW7qm1NFPvFWX948bQb7KSH0WQ686BeEPNxjIyskRElKUkHG5ZOPcAfi/G2qLH2mMPLGPwu5X96ODCsGZt/mj6ioxmn5/0UvN3bC5QabMioog9PavVgIBe+JK+vmCyR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9li34Er//EiHqfhuW71TYAf0m6BYvNHAZLSVdQfQTE=;
 b=PqR4lTZnu7Ix0r57S9apyMf7Sc9e9zTYTczhPe88jwjwyPIMGSX+pJEn02TMLqMzhgVrnXjDAI9372+w+DZnvPetRo1lbcBpCLjbEXa2JfqxO5gsBxYyONdnkOBujrMMwhdkiotCRhf4hsOAJ9SN6/29LooBPTr3SsINTJA+ExfpO1Wdxwq4Q3OmJ5S7a0rDqdF4A2aSZaNqSwHmNMwAVv2VEWUZeiQumrUnfTd46OllEn45KvkAndACdY4jjNYn2zgMa9Yhnvloq/C542jrTXOysryHZQV/b9ytYyVP6C1XP8o8EImcImuaST9ufp8X++k8IhNVRA8yuKJye5f6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9li34Er//EiHqfhuW71TYAf0m6BYvNHAZLSVdQfQTE=;
 b=L7g52jlgnkH+ey9fkk6Wh+qRNROrF3GlQ5CTotV6ipplmy20JU7hBHFn91PkCsGcKKYVznmFxqomph7DY3Wgj7B1HzT5Ob5YNvvqQkpXNhloMnbyoJg2UVLwjy+u3ePn4zMpWJ/vT6ulhFClCf0RYhvKSBt7oHqDva83NP2qu9s=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH3PPF0A8D5CDB5.namprd10.prod.outlook.com (2603:10b6:518:1::788) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Mon, 9 Jun
 2025 19:16:06 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:16:06 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld"
 <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] lib/crc: improve how arch-optimized code is
 integrated
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org> (Eric Biggers's
	message of "Sat, 7 Jun 2025 13:04:42 -0700")
Organization: Oracle Corporation
Message-ID: <yq1zfeg7mlt.fsf@ca-mkp.ca.oracle.com>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Date: Mon, 09 Jun 2025 15:16:03 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH3PPF0A8D5CDB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eefbd7e-81c9-4356-472f-08dda78a154f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bajiKuXZjihQDyigjkjM6BaUeadtvUYJRLo9gWMGnWQEn8HN/VJ5EGhXvYiD?=
 =?us-ascii?Q?ee9q/Jnf7+kFe+vNKYE5liY5f5G04dpQVDaF7THwaADc5Ci1C2NQE/JAV5nj?=
 =?us-ascii?Q?Z59yn8BKPXeTuUvRa90SJvKuqvFjsVCeb/r9ulMfsPwEkFLTL33FwK6kBUBY?=
 =?us-ascii?Q?gs64UQ6q+AtamokU6xVMeApQqsP3McIBD0DlWte/9QqGIppBuEZPkeqSnzhh?=
 =?us-ascii?Q?82W2NlHlMb+QIhK3wbWkO5e28450Bf+Pj2T6HMyJYE3nDjjgXSCd2KYR47Ue?=
 =?us-ascii?Q?mpvAqP4OLwtjnII0YtZ30sL7I5V14eEU08KZdx8m4hP5DD+zRehRISQF1HgT?=
 =?us-ascii?Q?9FQf4bAm6J8h0B8o8yYVaou4exirJgZM2lT1h0Lg/1wTtEm7h8O7EYSZuxgl?=
 =?us-ascii?Q?6/Ji3roQg+Cli1C8qEIscrjIOVIoaY6kbdbUR0GBmgth3wVz88FT6CtPc1gj?=
 =?us-ascii?Q?o8xSEEm3j8GFEIEG3BO6YGRZmCJ/iWqGXzO39SQGaUkbUeQ5ZZqWgQvaremD?=
 =?us-ascii?Q?l6P941krX7BGqEwUG5IFhf1AK63yHz3xn/cj4pgyq/2nx2P0k/RBi1KMHifb?=
 =?us-ascii?Q?6o2WrFblflMPCyeGlWmviKkc3cKE1ZtUwWCG1EOhJQ8RXjYBQGbDpRIiBk7G?=
 =?us-ascii?Q?gSalNKaFHicj0l5n7xIMQuRzHUk7h3aR1F9ZQCwAGNM+jmhljlyF/+6OwnfK?=
 =?us-ascii?Q?PiNj10FUJCD/1ABVH0/Zu9PGlcw3+Dhuvaz0tUZjbuEm7y4LQeb57xfo0Xxs?=
 =?us-ascii?Q?wXF/oJ8d5dc24vNoVqjw4sEwY3yyeOQqYSvOjZM9vMtzki7MHZ+oiVon7Sz8?=
 =?us-ascii?Q?ZcB49U9ry0fJVGzE8Ko3hkRwab4rbOFLn0echDEltF5TQqIUNvgx6UcOsDOb?=
 =?us-ascii?Q?MnwzYp40Z4d0soIo9d8T0VLM6bobcB1Ahbz9b/sZdUgx1876nDik02BtJAXA?=
 =?us-ascii?Q?XSn7MBEwAQaTC9BSkDHbvKMv0oVwdpWl8q5aKvLG2/aSLJ7n82MBhCim9Qdj?=
 =?us-ascii?Q?WgB6nGfVOPPq5wSpmVuBq+gqX0NbdNqqXbCLmpIaTLIzYx71FN4vDjEm2BZI?=
 =?us-ascii?Q?VQokanTxdv3zqK9a9VTZPWNTxQKVerUkXThAy9K3P25ITw5ra0p72cAkCgsI?=
 =?us-ascii?Q?l/CX0Orb1F84G7Dz8MqsjftnXXIBwjFhkJcRhYJvzCMd5S+cr/dtQi6xHF8b?=
 =?us-ascii?Q?oJmhCWwFzManS9b6qugVYON/OkRkH+oNKaL9SkzNmNKS+n29aDQwc1ieL3C0?=
 =?us-ascii?Q?Yr2fLXXh5392YNowNzFBiBYJW7o0VqmsmAzhbdx0jejTLISM4mgGF2ZaGiDw?=
 =?us-ascii?Q?HHIl6WDVUbMvMM1G99eb9sQLm3KjTtniGBEmL1La++XGQhiTAkuBrtv5Uef0?=
 =?us-ascii?Q?DGTbOBGdw+vYBCsItitg7CjhLgjsBMMRd5JwHtVTm5JPniNAlkeAxXhVoYHz?=
 =?us-ascii?Q?eF00DN16zdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSBCammy4WQmUDPtRj4lHHE7kl2MkDN4dxfRMkyzl4012l1dv6FFyWS+Qb87?=
 =?us-ascii?Q?RgfK9+OdWmU1/g5zIV52oxLWqGrvm2w7pDMtvTMm2j1Uez5ZTa0RvByCoXcP?=
 =?us-ascii?Q?o0OHydL4Glequ7rG8hbJtoxSEEaNrfbHCJVLWT4LqAkenPjaeCrnommLwxZZ?=
 =?us-ascii?Q?U+O5UnM5tCHYG0eH+QvdLoAGc8/QJox6qOtJM4oLyGxmSDi5HmCSOYQi4d30?=
 =?us-ascii?Q?91RIiQSHbU633KLr4FjQ1L67sZwjqpPrYGRiZodf8WRb78jH7da9JPd63ld5?=
 =?us-ascii?Q?AsS2bFt7mqTaxg7dcumKEPt21UpXfyT0rm8USfAgxUsYZuzHknYIwvtXh9aQ?=
 =?us-ascii?Q?iBm6GGvyrl9FoiBnIJx8yHS4P+ir4w3ea8UmgjG7t9T3Xttav1oHwuvih17p?=
 =?us-ascii?Q?Le0z1L+bsdpuVbsGwk7wXu+M90gtNrZlGk1/oQmaUmB4sdejvbyI4Ofsyoqs?=
 =?us-ascii?Q?xTzdmmMl34OTCht0mrbsXp3Qk66dFFXBjx1KmNP15fyi3EjMLmO7PbT/CnIy?=
 =?us-ascii?Q?C/qfvcQJ2g4MirY3qgRtDWhfK+HsBqu1FbgykvRW3X7Yb06mFyTkCOzzVup4?=
 =?us-ascii?Q?QGUYmneemqbYUZvOY7f+rciWoQZ9nphW+je/VoR9UOny79OSmJz50Eu8KqWS?=
 =?us-ascii?Q?H/Exj+6S7sBeEDfS3f4Qw/N5LVHM+Kvo0dDM0NskVEbNiurQwOWyQcM7PvpP?=
 =?us-ascii?Q?GVHEeb3hmo459/dd/eQ7i459wctIu6z1xkrCdFS8+tHA+E5Vf1Tf+FBJwe5X?=
 =?us-ascii?Q?rF7I69JY0anS9dU6r4cDMc8Cm3CB2050UN9iC/ITm/vvlvxC/8ITI1pCXUrS?=
 =?us-ascii?Q?N5QVLmiPfNsdORR0iplOfOKKJQ5Bsr9SXz2trjrgTPbsLZEdXEm+56zoPWPW?=
 =?us-ascii?Q?e9dzowul4DAR1rFgkBdJwMFMrPLqC253vpIWKi7k2kjky3RFefdhvkzMFZ+E?=
 =?us-ascii?Q?4ZevbInT4pqMWzoV0b7bw9FJ8qQDuEPV1Dfz6PLtKTKKl+ILEs09hFKSmNcz?=
 =?us-ascii?Q?F6T320uOZJd5xyc2gWKjhfyfzeERs2ifw4d75+Q/uKwU829TQKkrXfaNNycq?=
 =?us-ascii?Q?Y2o04/IDuoyY8LCCfbJW6pJBQ8LqS4q9ZfOhhr4FFJksUhTR8A4/WJzvl9t8?=
 =?us-ascii?Q?gLui0KZSO8leV4UEP0MuyX9XajZUoKSc5s2h/q/FsMR8TGGy+y9GW0tZvk/U?=
 =?us-ascii?Q?XSbfc9C/RedeeDI1NyqICyhY0q+OLFbVXSASd1aJBFohypBjXxIwLBIFrUqh?=
 =?us-ascii?Q?/evJ/fb1nunDuOMIUIQwr+MvUUO4WKZgXdh3LgIlDygm2Eb+pYabK+RpVZ09?=
 =?us-ascii?Q?GRjZQznHuepfINO8IMkU5hBkoN1h9CEUwkDCCdGCzfGLSFC4VEkFCuGXnMK/?=
 =?us-ascii?Q?/SnLJs8kfaO8dAUppu/YPZoKuk+w5Ri9RrXT9gEobeu+Vf/DkiMO58IH5KXx?=
 =?us-ascii?Q?eNQ5JJCikoXkMCHRRP1K8NFCKe073qgMot+V9Pfx24KXiXkKOscSNNy53T/L?=
 =?us-ascii?Q?nEZ0bNljqVnZ1WLwapXVnA8X0RsbvAZD+xiIiV7IY4NrVaJjBNAn+Jo493hF?=
 =?us-ascii?Q?FsTptCk/ccEF0vTsXgv0802GopxkQ8b/srF6w7/gd+PecDmTqnXCpcAspsgx?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uRgWrm/93za3JIuIXipEd+Y0j/0HOep00ULyu7GY8pAX7Kq+fGDBbmVbQ8pz0ZowQJLjcchw5Vlx7HNfrU2xmmB/zeqm7CGV+7uruKminWDU9h8Ok81D0dzhC0IlbSUNLL1vFCnY9KnoW1dHI9Y3k2UK0KT2CSQkgezhCKmBSQdo7c8q7PObLUN4oku9s6CLysVAzX7XL4UxBg4JrTDfgGP4GOQoW/vd6pCi6J4LOzMezczeejGA1bTniAw6TRGi9Fvvmio3Bb2kZ+/CkFvS5bU9b1sCqjGkV378VuR7I1T/hXaAVi+ig+VFcbmAPUeYPE4yOH7sFdA5fC75dzCLgqpP8fo4CEWmxOI8TvsgJUG71n4SCeUpWc2bqKCNp+6tu/3zFIKfvGichECzLiyyX5zYhwjJ1HF1RV3ldOfFszb/nS2P8EQs5yZvmnjZgDxn9s/yyUL/0kfFJz9WqWnmLKiHxTCnu7Li7OYNVWTcK5ZFah2HDE0ABeCtNs/kf/nZpidkOs/f/kfgq/X9Mo0MDFgjh4sbrcDfwWzoi+wWaoKt6X8QxmhP4Ep1tW34y75LyZaLXixWmyahzKf0sWEQnA9q/LgXkSHrLjoBDBMC0FU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eefbd7e-81c9-4356-472f-08dda78a154f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 19:16:06.2830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ulv+egvMWZ/37vAZhMTqgxKDBwNHajIoihzAfBLST+vRf5+b2GYdM/bkT0AAxg62P0+wjEnNJLGNBb4F13ZKJSmBxzDjHADNvx5h/9kqIA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF0A8D5CDB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=986
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090146
X-Authority-Analysis: v=2.4 cv=LIpmQIW9 c=1 sm=1 tr=0 ts=684732f9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=NujspGZ6sVz4W0mBbdkA:9 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: 7b6DjeZj9zH3Tc4O68VYc2ztwx0k3bMI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE0NiBTYWx0ZWRfX6M5phhH13/0L M72PQsxwWsnczvU2W5LZxII8qXaiRI5NUCIKVN/81UT33ATdAY0LbUsi0b80JflOGtO8+HAy705 f6Rr4jZUf0baT8tjQsfF7n2PQd+KQPs+ImcF9XPvx+OAv8z+IATGfJ4xqQWwPKFugE9RXjKvizR
 EvbFDQGRFczItFLzW7TtZQEpXYWuzF850FxKNvjnim3RKCRvtUcnpeoSnrh0gsq2pGXjsk8H1da 2ppixqARsHca0XqCHnNMHJT2GAXzmI1CARm9fHpGKiPqltQNEO5wpUs/7H6scjsDzjgCM56WUOM AZJ1N5+aLY+/SsljCq54twoQjg+kuLgWhduLnG04vu7EioTfKuvxWciVimwiSJEv30XTq3OSC/v
 pXDcSKlyOX/QRRqFM6pqNpHEmY3i2OnQt/eaFi/Vg+iR+pca5g4jhLVMmWnkW2XeCq0n96Qf
X-Proofpoint-GUID: 7b6DjeZj9zH3Tc4O68VYc2ztwx0k3bMI


Eric,

> This series improves how lib/crc supports arch-optimized code. First,
> instead of the arch-optimized CRC code being in arch/$(SRCARCH)/lib/,
> it will now be in lib/crc/$(SRCARCH)/. Second, the API functions (e.g.
> crc32c()), arch-optimized functions (e.g. crc32c_arch()), and generic
> functions (e.g. crc32c_base()) will now be part of a single module for
> each CRC type, allowing better inlining and dead code elimination. The
> second change is made possible by the first.

Looks good to me!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

