Return-Path: <linux-arch+bounces-8652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DC9B32FA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB321C2186C
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8891DDC37;
	Mon, 28 Oct 2024 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nr1cG2fD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LN/psi/+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F91DD865;
	Mon, 28 Oct 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124875; cv=fail; b=BfYlNwC178xCcAfJ/gTYQUHgU+6x/qv2X+ox9yI30NosxX8cLUMF2SiFeOmxIU7qJD6wmafP2GKGh2YBM1M1WZG6OpYDh2WAhJ/IUhGwu686wm7DNQpi2arPPA7RFpxETd8tigmq7hjxRNzD6f1HHD96HQVTlSlBrh0dzkyzHKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124875; c=relaxed/simple;
	bh=COMxte/8THhdE6E4CFe1DCKkK2lYjQb4TIH5zNCoU6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Droil2eVhY+H85Hjf5ydWB1Z+048VsTq9LBJ/+GNobUmuiZCG7gI31UTHYR/o12t8wGxMbhqlYgfZmmw3nDuHEsQ9gsJBFpriL2XxHwMNF7OGMLqHZ3rRthnd8WOUa7Gicymu1VPgVgQ3px/XQntZz4K/5NwGK9jxEuq50wY/co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nr1cG2fD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LN/psi/+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBSjp2008698;
	Mon, 28 Oct 2024 14:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/a/g8vrRwp3Wqsx+pVfT7qcLVrpT2JgIhmq7e+m43J4=; b=
	nr1cG2fD7xsJ0AnBorwi7fbGg1pknFyT13ZrEoV+t7i7uYTAjtIf1zHwC3ifwypD
	cmCfGNnrCQe0taTs/gRd8PKxZGoyC6zBN0NanQRsKAxYE2Ibf1XHdaZO20eBUBVU
	jLMfXySd23c7LgzvkeefURplQrqPNCCaSN6DZwLACZmnKaNdTjfArcKGIc2xC7tH
	PSSFH28j/umVjgpgvW/jWiaCrXF6LTS48hBv8xVzrgLlkTVUd59UOdxAZ/KpJRTa
	RofVeF/5m5f7U8hCyg1JSZ9YPCjaW3hHwxkHVFgdsB7C0JopsW/HUIC/onwuxVm3
	F+b5mT2cQttd2nN5p8GHfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1tx2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49SCvIaE004777;
	Mon, 28 Oct 2024 14:13:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2ska3p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 14:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3YwNxeQknatxUbbi1v47HAiKrptPOZHDR1uWT07Rttp8xUvlm3nroLD2M1KUEybUwURb0zuoeyNAHEvX+U7LtLmTEEVdgDOoKm2JH1An2ffMnHMJObks8BDl8NHtrsA6OOBLa8R++UmhlE2u1BIIGUBbj/kqeuKDzbDqGVkGq+4pdav+NCWaOMtsB3HHIKb4XJ3LKzwVZk0MmZlMJ+n2dSNySCML4gXbqqFzypo3cU/iXIeazHQ0sKwFKDpLggJ99p71JjMpCQB3GPkn+6uTh2+SwmYn8/S+aEbqPEvTZPplACUQ+9j7O3YkYsd8/Bi0RU0XhzvRb/KfeO730RpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/a/g8vrRwp3Wqsx+pVfT7qcLVrpT2JgIhmq7e+m43J4=;
 b=trnfwNEB05f9J6O+E8xI5WEuFmPO8kVB5Rusm4BVq1i4K83wedYOnAAYC6ZHnC/V/DW5u9S/vnVy1MLMRwxXc+NlMXXW62h8KBOrVha80nAPMjh8Z6mODfwV2cieUzphi+VcVsc9GpEX3bjukjOiPz0DnBogoAV8vFl56sqyxH1C267L9j1PCKLQ7AMQT17vy7aZoF0sZxBdxWicJ1mXRIBx7d7QC7uVGci71OaafL8f5wzJi6oTISgCJeQrZLfJ56xn/icxNComiCkZ83l8XPf5h0HYW97Cbrfjkj2qO4dffiBKReh6R1bFDBndO1S/ZDl3h76rVxO10omuNpCF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/a/g8vrRwp3Wqsx+pVfT7qcLVrpT2JgIhmq7e+m43J4=;
 b=LN/psi/+wKx+7mUVr9T+YtVaz2KTIb0gyXUTCPqeY8Isx0vCiEzIhj3BrDU7EQaHXkjwm93sqty6Az+ASBC3JP3t0lIcZaQSoiql+zabkQnOvduOqYwP7UjvH3s5+wK20y2myJzuY7opiTX19+SfZvFfu3/0rHaobR+OXTgSefI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 14:13:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:13:46 +0000
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
Subject: [PATCH v4 3/5] mm: madvise: implement lightweight guard page mechanism
Date: Mon, 28 Oct 2024 14:13:29 +0000
Message-ID: <6aafb5821bf209f277dfae0787abb2ef87a37542.1730123433.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 29006ab5-2040-46ee-3f9c-08dcf75abc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GFKJeSLIqDJNKzNWBdwfKnsyLVYTztLce0YrUKBTRh4Jr189G0I77EriBPmB?=
 =?us-ascii?Q?j5CZGzu4yql4Bn7fNhMraVJeZnP8RimZqj+4XXhAAQb1iLMIhXyPs7sSvjyC?=
 =?us-ascii?Q?1G9dOpOY7SOjBstpMSfGMhKj6mDVlc06OBuIjJz8nXQtNZbn2dpzsdyDwvks?=
 =?us-ascii?Q?XbZzGQ648mGUWQGw/IUli2XRK5ILbXW8QZfzwBJ7coHhbkoElenCMTg+cstg?=
 =?us-ascii?Q?9mmFavMuCzEwFH+UP3AOVapYTsLimfBWNMIA2/cobJelqgBbWNKnychgj5ul?=
 =?us-ascii?Q?xzcJfMa3wRnJvahRdVjxbh4ixpW6oJVvWQ1ve6tW7BsFrKP41exB6uQGxgp6?=
 =?us-ascii?Q?9FHwEDJIBf1kxYoHtGWXkK8gpOEZ0ORnGG5qy9pUQVShXsPvz7UBOj1kvZCn?=
 =?us-ascii?Q?a5kO4FFs7Sa+gWDXXNUEWomK20egsBWUReGRS8CF/K4ZkgooXx3uekBY5rM6?=
 =?us-ascii?Q?1vukfAMO0alZVjQz9VNpBzCazcoxg+1YBo7a0x0RHd2rGo4sBshunvP1A2tG?=
 =?us-ascii?Q?fyqNJVwHRS21S9DJjB6c3+phb4d0LSR+H2MPIdhopEFQn9GEaJ/RxrkM441x?=
 =?us-ascii?Q?L/GhvNfArgt297rHuebfy48dXDdnn7dYQjrhsaYZIjjX+zrzww37eX04UdHW?=
 =?us-ascii?Q?WkNdO0gff8ZDb480ohWfZxcR9o3+4Vj//bnJ3AufzknvYq9SLed8c6Tlqrz3?=
 =?us-ascii?Q?RWJ3yrnsx0avTpaQD1VyqLUffU2RIuWXnfaZhNRGEhiRBbqwSjw2ePOqGnpx?=
 =?us-ascii?Q?xJVPN4VwtiQ+Xtg592I+qo0jAR35ynZbuGacFwgneMmQ4DLKWcNXiq952ZTb?=
 =?us-ascii?Q?geW1PGayGrGGZNEGBo1twI8BcjTS900wA40Gay0+FxcHdiuoW33bQz7HNV5l?=
 =?us-ascii?Q?R7/5DgrslCF4bC2DVvn92u0+JUM8MFWPYGuJ93hTu/sYlw7uW0PgSrfwI2qF?=
 =?us-ascii?Q?FNhc/3wgfRjO0WT6PYAOnf3OAR2eih2LdQfEr+CsqqOWCBvG/ppJjIGTBWa2?=
 =?us-ascii?Q?MXgYjdEszumLvHHjnXmiQv/jIMXsGSFUMffJifCLgvdk+MEl4OWX3XbmQFIV?=
 =?us-ascii?Q?/H4VDAS1fTpGPy3V0UVdssQFWxw/CXcTmxiUCqLiI5k5ka5zEyHPlN6qa6Bu?=
 =?us-ascii?Q?SsAAkQtSp0VOGbyXHDF5SY93D6fkfZtWGl0kDH8OD8tvvDngTZ+gpNmYpkey?=
 =?us-ascii?Q?C1lPf1z/OpWqH9Ky/+L/zagHnYg3fIwPiqD/gGw4cIl8gRCSjP5cRbbZJtdt?=
 =?us-ascii?Q?Fq1VCjacp1Uj+dDAxs3ulBPT5qv/OH+gNrSW72RZMJfdnAYb+D4h8A8pfdPK?=
 =?us-ascii?Q?rDS8IrhvN5q3r9YX1JfTVYYK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNa8m6VDmZd23EXU8IgV22W3H0aBQLENmONOdDHoNooElkMZTuZKJStBgCPJ?=
 =?us-ascii?Q?YYzlYW7ZrKmAq+j+0diNP4S4CI+r71aSEJAVqfFvaVrqRCZ//yX0zWXtnchY?=
 =?us-ascii?Q?OYzMM3WrS+p4i7TG/KDDUIemtHvyYWJsrqwJY/Pn2zvi2BCu83LEIxemVXRX?=
 =?us-ascii?Q?4YGguQDIZgpuZ3oBgFnm6MZ9bVX8iBxLUN9oHDP0AGqDcFSDcTD/WVcvqFCM?=
 =?us-ascii?Q?VIlvvyDHiNFMTwioqM/8JPiJynV8UyI/0nFgN4UrYgMoD765Evy4+go4r3Zn?=
 =?us-ascii?Q?BKJ/hR6GpAuUme9sUn2xbIQC4pzkzrjdEEgiTU2qb0V4z4rwIyKD7Nob7pty?=
 =?us-ascii?Q?Cy6xU8Fjsrxs0MyOmlQ4ezVD2xNCmE1fPTzIamcKwx06n9bLIovKCutJy32U?=
 =?us-ascii?Q?AJu/MQYGuX0/rUr5BmPyIT57p1IH5/vRfwDMMmdU1laYwCRiMslkYIFjIwvT?=
 =?us-ascii?Q?X++/0pxA/RZJeoJ8tOo6fYC1YdfbFQ2EctFZwz0tr9NkwTX8pwgF+Yrc+16G?=
 =?us-ascii?Q?/sE+zLkO1uhZhAuMcSVuiVNBJxalqyGySjbzY2vCgSKL2Qcv+gpm8run/DTh?=
 =?us-ascii?Q?1Xmiv1X0xJik9jX5yXttfPuTaOenk/dTZ33eRt6rccVy9eIJgyKLj6MgOXvS?=
 =?us-ascii?Q?eU+Jx67Ymhv1Cr1pv69gI1oyEiNBNclb0F4sJYIEkv3CyuU6NwjDx/p3nZmw?=
 =?us-ascii?Q?FO2EPi5Z8AYp5T4tLbZVeFcLQ9e0xIyRHHxa9KGeCYdese3z024ThZDbOmdE?=
 =?us-ascii?Q?0N/XYUmC+t2wD062nCtAkeZ+Xb7iq1BsQHwSbr7X4ug6KLyGs9CKLSow8pgD?=
 =?us-ascii?Q?00QVyikDrUpU7Kz4olsEePbLjVTKJRBVHSq3RJ3jqxwfsL7J7HYwswo4v1RE?=
 =?us-ascii?Q?2Ec52TMvCSPzd8FUZWGNcAe98+kurwjleIUgRNLe5552JVPpNoO+pqK3vkge?=
 =?us-ascii?Q?7BPuBE+i/mfkoUa6IzMjJ+226UmcJFGfuAwtDxfFrDLtq9YD7shbxUCzmgIB?=
 =?us-ascii?Q?LcgbZ1Bfblb847dpXb3qgpmllBYiiWgNfFJXiL6xbAGErnXQupETfG1Mihnk?=
 =?us-ascii?Q?me+gTManvBYb0bEbtUAs3VaEdCBzan+MU7fahywhI0T1U2WMsMEBBvAiIb87?=
 =?us-ascii?Q?gZ7U4Mmd4mECUwIMPV3Y+kZKkwkNvUCteXfNsC6J9+24KXpV4+ZafEl6kuPa?=
 =?us-ascii?Q?tYb4YwXTgxV2yycvPHcLiMYCTOzA0Nc3SEvSG1fE6EUFAz+yKPgEW7aKk3WK?=
 =?us-ascii?Q?1ihOvBGPUIGyx6kX8BMOCr6bSggd/L9Ow/9t8miLrKLsldQpJnuozSQ9qrdA?=
 =?us-ascii?Q?HjMW9FpRoC97UdlMG/QT3YWD/hY83jp5KHgLWoAYn22/UW1abck2U0FevMcM?=
 =?us-ascii?Q?yKErdxrwHFLmMp12+wMlcEfzwyiCTZlVnqWkHNLkcSKGYt9ctZ9+iaFW1JFq?=
 =?us-ascii?Q?HhtMx4oZdBLF19Y7a4PXtpv686NrLv4B3WOE+sfVQstJbOR6sSUQvFjyKjvN?=
 =?us-ascii?Q?8WGtyeklDLqR7Q5JKH8rc5p6ons9U3IN2Y9YECsOcF/cBv0+74IHwsr7FfOQ?=
 =?us-ascii?Q?mAB525PZYk1SHJpUUWyGIqQFZgO/L2wkDnfgptEm3s4dBLm5Y5Kh6EPmrrHY?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xDCYECgtIb0rU90X1gbtFnDd6keZ3NUJjR1R0cCO8tnQLWYW5gkjfGlkS88bHGTSlT3mGRKfr9y4eVlV/txaDOkwXHnCJy1qNhlC5BDbtzIfnU7Gj2q3C0nGVMhut8mz/Rnz+qorem81Zjv2OYMHlYJQeSRL21wk6sW3BFTtX9OrmBWMA6OZNhHSmN28EUxaqOdg420xfGuviXm24AJv8hlVDQdX0lwIQ75SDKTWI38y1nJLjTfiB0v5R/XXmsjhQw3OIFxQbaqcUDC+dBubpe5jakKgNAQNWNdnUYAhoEBFwscH8jFbslQOGZvgTjdTxvXiFioDIga4mKvZ6bv7YoB7P+hh8feF+zunPXRsWxrAPNYG+AN3pt0oHFClKXqOhidmNGS6FrXRDO2eiDE+RDGZzUQxZ70P1Rm1tSPC1JqljzuEa1rj6JMX0ZzHOAXPuNICke0ERMv2Y0vtWDPROkNyIj8HRawkiuW+xMp3kDHYM32EiKKOVTnex1KyrOKRkXNBt4VLS+s6tlPRxF6A4VRF3cW/lrFrT96UA6cA2ksi+jE64juaOdY9QnoijSoWfpSBa8AwNZwqjDl3oiBGjo055oyF6A/wUlG5NccyAiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29006ab5-2040-46ee-3f9c-08dcf75abc7b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:13:46.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBPljziL8xFIqySBWFOEmzSiK6EbBX4vygf7T5DT2BS1gf74Krxihc/i/uHfH512VD+TS+vdKGPI3BskUqgElD3kHQ/qqM+POHv9AsLX8po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-28_04,2024-10-28_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410280114
X-Proofpoint-GUID: jzhR6gDz1AHsF9yJTaYGA2comuL22xF0
X-Proofpoint-ORIG-GUID: jzhR6gDz1AHsF9yJTaYGA2comuL22xF0

Implement a new lightweight guard page feature, that is regions of userland
virtual memory that, when accessed, cause a fatal signal to arise.

Currently users must establish PROT_NONE ranges to achieve this.

However this is very costly memory-wise - we need a VMA for each and every
one of these regions AND they become unmergeable with surrounding VMAs.

In addition repeated mmap() calls require repeated kernel context switches
and contention of the mmap lock to install these ranges, potentially also
having to unmap memory if installed over existing ranges.

The lightweight guard approach eliminates the VMA cost altogether - rather
than establishing a PROT_NONE VMA, it operates at the level of page table
entries - establishing PTE markers such that accesses to them cause a fault
followed by a SIGSGEV signal being raised.

This is achieved through the PTE marker mechanism, which we have already
extended to provide PTE_MARKER_GUARD, which we installed via the generic
page walking logic which we have extended for this purpose.

These guard ranges are established with MADV_GUARD_INSTALL. If the range in
which they are installed contain any existing mappings, they will be
zapped, i.e. free the range and unmap memory (thus mimicking the behaviour
of MADV_DONTNEED in this respect).

Any existing guard entries will be left untouched. There is therefore no
nesting of guarded pages.

Guarded ranges are NOT cleared by MADV_DONTNEED nor MADV_FREE (in both
instances the memory range may be reused at which point a user would expect
guards to still be in place), but they are cleared via MADV_GUARD_REMOVE,
process teardown or unmapping of memory ranges.

The guard property can be removed from ranges via MADV_GUARD_REMOVE. The
ranges over which this is applied, should they contain non-guard entries,
will be untouched, with only guard entries being cleared.

We permit this operation on anonymous memory only, and only VMAs which are
non-special, non-huge and not mlock()'d (if we permitted this we'd have to
drop locked pages which would be rather counterintuitive).

Racing page faults can cause repeated attempts to install guard pages that
are interrupted, result in a zap, and this process can end up being
repeated. If this happens more than would be expected in normal operation,
we rescind locks and retry the whole thing, which avoids lock contention in
this scenario.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |   3 +
 arch/mips/include/uapi/asm/mman.h      |   3 +
 arch/parisc/include/uapi/asm/mman.h    |   3 +
 arch/xtensa/include/uapi/asm/mman.h    |   3 +
 include/uapi/asm-generic/mman-common.h |   3 +
 mm/madvise.c                           | 239 +++++++++++++++++++++++++
 mm/mseal.c                             |   1 +
 7 files changed, 255 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..1e700468a685 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -78,6 +78,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..b700dae28c48 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -105,6 +105,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..b6a709506987 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -75,6 +75,9 @@
 #define MADV_HWPOISON     100		/* poison a page for testing */
 #define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..99d4ccee7f6e 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -113,6 +113,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..1ea2c4c33b86 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,9 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
+#define MADV_GUARD_REMOVE 103		/* unguard range */
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e871a72a6c32..0ceae57da7da 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -37,6 +37,12 @@
 #include "internal.h"
 #include "swap.h"
 
+/*
+ * Maximum number of attempts we make to install guard pages before we give up
+ * and return -ERESTARTNOINTR to have userspace try again.
+ */
+#define MAX_MADVISE_GUARD_RETRIES 3
+
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
 	bool pageout;
@@ -60,6 +66,8 @@ static int madvise_need_mmap_write(int behavior)
 	case MADV_POPULATE_READ:
 	case MADV_POPULATE_WRITE:
 	case MADV_COLLAPSE:
+	case MADV_GUARD_INSTALL:
+	case MADV_GUARD_REMOVE:
 		return 0;
 	default:
 		/* be safe, default to 1. list exceptions explicitly */
@@ -1017,6 +1025,214 @@ static long madvise_remove(struct vm_area_struct *vma,
 	return error;
 }
 
+static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
+{
+	vm_flags_t disallowed = VM_SPECIAL | VM_HUGETLB;
+
+	/*
+	 * A user could lock after setting a guard range but that's fine, as
+	 * they'd not be able to fault in. The issue arises when we try to zap
+	 * existing locked VMAs. We don't want to do that.
+	 */
+	if (!allow_locked)
+		disallowed |= VM_LOCKED;
+
+	if (!vma_is_anonymous(vma))
+		return false;
+
+	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
+		return false;
+
+	return true;
+}
+
+static bool is_guard_pte_marker(pte_t ptent)
+{
+	return is_pte_marker(ptent) &&
+		is_guard_swp_entry(pte_to_swp_entry(ptent));
+}
+
+static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* If huge return >0 so we abort the operation + zap. */
+	return pud_trans_huge(pudval) || pud_devmap(pudval);
+}
+
+static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* If huge return >0 so we abort the operation + zap. */
+	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
+}
+
+static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
+				   unsigned long next, struct mm_walk *walk)
+{
+	pte_t pteval = ptep_get(pte);
+	unsigned long *nr_pages = (unsigned long *)walk->private;
+
+	/* If there is already a guard page marker, we have nothing to do. */
+	if (is_guard_pte_marker(pteval)) {
+		(*nr_pages)++;
+
+		return 0;
+	}
+
+	/* If populated return >0 so we abort the operation + zap. */
+	return 1;
+}
+
+static int guard_install_set_pte(unsigned long addr, unsigned long next,
+				 pte_t *ptep, struct mm_walk *walk)
+{
+	unsigned long *nr_pages = (unsigned long *)walk->private;
+
+	/* Simply install a PTE marker, this causes segfault on access. */
+	*ptep = make_pte_marker(PTE_MARKER_GUARD);
+	(*nr_pages)++;
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_install_walk_ops = {
+	.pud_entry		= guard_install_pud_entry,
+	.pmd_entry		= guard_install_pmd_entry,
+	.pte_entry		= guard_install_pte_entry,
+	.install_pte		= guard_install_set_pte,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_install(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	long err;
+	int i;
+
+	*prev = vma;
+	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
+		return -EINVAL;
+
+	/*
+	 * If we install guard markers, then the range is no longer
+	 * empty from a page table perspective and therefore it's
+	 * appropriate to have an anon_vma.
+	 *
+	 * This ensures that on fork, we copy page tables correctly.
+	 */
+	err = anon_vma_prepare(vma);
+	if (err)
+		return err;
+
+	/*
+	 * Optimistically try to install the guard marker pages first. If any
+	 * non-guard pages are encountered, give up and zap the range before
+	 * trying again.
+	 *
+	 * We try a few times before giving up and releasing back to userland to
+	 * loop around, releasing locks in the process to avoid contention. This
+	 * would only happen if there was a great many racing page faults.
+	 *
+	 * In most cases we should simply install the guard markers immediately
+	 * with no zap or looping.
+	 */
+	for (i = 0; i < MAX_MADVISE_GUARD_RETRIES; i++) {
+		unsigned long nr_pages = 0;
+
+		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
+		err = walk_page_range_mm(vma->vm_mm, start, end,
+					 &guard_install_walk_ops, &nr_pages);
+		if (err < 0)
+			return err;
+
+		if (err == 0) {
+			unsigned long nr_expected_pages = PHYS_PFN(end - start);
+
+			VM_WARN_ON(nr_pages != nr_expected_pages);
+			return 0;
+		}
+
+		/*
+		 * OK some of the range have non-guard pages mapped, zap
+		 * them. This leaves existing guard pages in place.
+		 */
+		zap_page_range_single(vma, start, end - start, NULL);
+	}
+
+	/*
+	 * We were unable to install the guard pages due to being raced by page
+	 * faults. This should not happen ordinarily. We return to userspace and
+	 * immediately retry, relieving lock contention.
+	 */
+	return restart_syscall();
+}
+
+static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pud_t pudval = pudp_get(pud);
+
+	/* If huge, cannot have guard pages present, so no-op - skip. */
+	if (pud_trans_huge(pudval) || pud_devmap(pudval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmdval = pmdp_get(pmd);
+
+	/* If huge, cannot have guard pages present, so no-op - skip. */
+	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
+		walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
+				  unsigned long next, struct mm_walk *walk)
+{
+	pte_t ptent = ptep_get(pte);
+
+	if (is_guard_pte_marker(ptent)) {
+		/* Simply clear the PTE marker. */
+		pte_clear_not_present_full(walk->mm, addr, pte, false);
+		update_mmu_cache(walk->vma, addr, pte);
+	}
+
+	return 0;
+}
+
+static const struct mm_walk_ops guard_remove_walk_ops = {
+	.pud_entry		= guard_remove_pud_entry,
+	.pmd_entry		= guard_remove_pmd_entry,
+	.pte_entry		= guard_remove_pte_entry,
+	.walk_lock		= PGWALK_RDLOCK,
+};
+
+static long madvise_guard_remove(struct vm_area_struct *vma,
+				 struct vm_area_struct **prev,
+				 unsigned long start, unsigned long end)
+{
+	*prev = vma;
+	/*
+	 * We're ok with removing guards in mlock()'d ranges, as this is a
+	 * non-destructive action.
+	 */
+	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
+		return -EINVAL;
+
+	return walk_page_range(vma->vm_mm, start, end,
+			       &guard_remove_walk_ops, NULL);
+}
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1098,6 +1314,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	case MADV_COLLAPSE:
 		return madvise_collapse(vma, prev, start, end);
+	case MADV_GUARD_INSTALL:
+		return madvise_guard_install(vma, prev, start, end);
+	case MADV_GUARD_REMOVE:
+		return madvise_guard_remove(vma, prev, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1197,6 +1417,8 @@ madvise_behavior_valid(int behavior)
 	case MADV_DODUMP:
 	case MADV_WIPEONFORK:
 	case MADV_KEEPONFORK:
+	case MADV_GUARD_INSTALL:
+	case MADV_GUARD_REMOVE:
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
@@ -1490,6 +1712,23 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
 	while (iov_iter_count(iter)) {
 		ret = do_madvise(mm, (unsigned long)iter_iov_addr(iter),
 				 iter_iov_len(iter), behavior);
+		/*
+		 * An madvise operation is attempting to restart the syscall,
+		 * but we cannot proceed as it would not be correct to repeat
+		 * the operation in aggregate, and would be surprising to the
+		 * user.
+		 *
+		 * As we have already dropped locks, it is safe to just loop and
+		 * try again. We check for fatal signals in case we need exit
+		 * early anyway.
+		 */
+		if (ret == -ERESTARTNOINTR) {
+			if (fatal_signal_pending(current)) {
+				ret = -EINTR;
+				break;
+			}
+			continue;
+		}
 		if (ret < 0)
 			break;
 		iov_iter_advance(iter, iter_iov_len(iter));
diff --git a/mm/mseal.c b/mm/mseal.c
index ece977bd21e1..81d6e980e8a9 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
 	case MADV_REMOVE:
 	case MADV_DONTFORK:
 	case MADV_WIPEONFORK:
+	case MADV_GUARD_INSTALL:
 		return true;
 	}
 
-- 
2.47.0


