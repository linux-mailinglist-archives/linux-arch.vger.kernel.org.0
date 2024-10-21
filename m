Return-Path: <linux-arch+bounces-8371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 932869A7018
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1341C20EEF
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FAB1E5705;
	Mon, 21 Oct 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EvESyHcs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EV1E2May"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E801178395;
	Mon, 21 Oct 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529522; cv=fail; b=XnWXuWjzhIRQD7EEf+VLbZ2W6VtXQfHjhr/15+aKo9LvQpHTZg8AJevYNGqllfvnJIt9KUH33ZFu6sWKiUuUbPILNKN2Ks+1k+yyAMAgRJUW6lQDNg5NdsBxa3qxq7aYacjhD9C4XUdgySW+4/Lnx6oJ8dykkyNfsVzy/M9OTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529522; c=relaxed/simple;
	bh=YJusBVuhRFOV1iCmt8wcfZA1yUKrTOStomCj20/kEj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nwo0fK3sDYAXvV7KzGPXYVLvtkCiUAsPsEiOE329WzBZuOg0FD9PS3FfdxwXY2gDo7nR0dP4KMPn/JQdlUnyPRKz5GOtnU8+CJDjDsBCEEkvSTRcQQPiS/kIEiSpRBDt9pchkcGWeA5k269VLH0RLi+7A9uXJqpLigZVy/Ol3JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EvESyHcs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EV1E2May; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFteU3017300;
	Mon, 21 Oct 2024 16:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=q7U1R8bVVbgVd94/6A
	AAIei+GiyQcReNb0+odjxLTMc=; b=EvESyHcsAj57pIrVzE/y9j1L9xTfyWL7sQ
	BAO1lT/UN+8Fm9EbBHQtg9nHykNpzRozsCZU2xf+mBudoBASrUkjW8dvPWjol4mg
	IUqJKiX/JDMzjeV93JJCXiktJCSx6p26XLfTZRHF1l0IQnZY7i7QqOcP17X/NdMs
	ELnIhWIV6AMIiiZqgxYa37p5xFTeIz1kSrJTuP4puK22yMttHxsu31udufPGZc1T
	/XMUHBy9GfW7V693fkQYtKGjblvxk0LNMtCJjn5sSTZHSqe0IuyEw1Gl/l5dqJ8c
	020Kui7/6E/eSyVAlItGGo97UTVrZ9eXWkumrEhF/XB/JqpAz6KA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uumv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:51:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LGWnPB020473;
	Mon, 21 Oct 2024 16:51:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37cqsrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWESSn/jJYatLhnl/EZMNtQf9pu92I/9dnxPU2KM1fPy2gY41w5roZDzRMU0Rp3UcU9NiblCoF9uyZs/3Ot0BZoS4Dqr4zfGkVEBI4AXzp1PYdioJqv4ODXpo2+KghxBBJ/LEq8+DXnIQY98BbmYBjqAYFgGgPvt+PHC5k81WAW5pEIPnVaVvhj8d7R+kOrKwGV2LpaSuPa28/YMmFh1hV3ixusXnQQYvcqawgSb0+2hM13eEG1ERouQj0LaYSf3/Pr8lunCEWST9XtODpgqtDpQmHs/ClnXb864p1XkjIfWd9Eb8s2MA1OJaIhSNPsY2454hVy/RRVqu5cm5UMMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7U1R8bVVbgVd94/6AAAIei+GiyQcReNb0+odjxLTMc=;
 b=BIfTozrV6g8dHwpVWWTfVt5x59CxihJxmb6zUuSngUCa7mpjqFjsanlw5+UOlcoqmXBWZelHlQDX1ow2t6mJlXgwbHCLz/fElUk6j10xKHErqOT+m1ttPW1oldN7DuXTXCsf2DWDLQjkEokXCPkXAgwO5Lhr5Guca7lt2u/Hr4CgGiUp/cFh8KUrWKYcEJd0zoLrCdQqYSUaQrODukJreqcmAIsq47r5qOmNHLz2CI4Fbbg8AeU9e5+WPrTx58cI7SjVjIQkQo+Gagc0HRXLzn1mzFWpa5aOzfzXx3UpvHX6PI1XtO50B+0nTCNfp85rbbNg3q2DEb5m4Nt799v4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7U1R8bVVbgVd94/6AAAIei+GiyQcReNb0+odjxLTMc=;
 b=EV1E2MayFON1hUJBCwOiP3OxuKDl+N4tXxp79nGDCq46d7tHyJ/KNEVHDS4DuLbl4Y+tgpx4Q8IQJQCXfUAU+NfM0DaJ3thKkhAVFraw4yRz+v7kHzJNIIhCCTTJHLfFK5KBra7W8ZFFfscBt7a3XYg6TPtmC65IRjIaM2yFfgA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 16:51:09 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 16:51:09 +0000
Date: Mon, 21 Oct 2024 17:51:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <cbf17dc3-01eb-4416-8ec5-cac05e50d663@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
 <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
 <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
X-ClientProxiedBy: LO4P123CA0443.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ad7493-5243-4381-6862-08dcf1f08fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5T/y2gm0CIAm+m0lNkODVGdzhmoSr/rvrYUv0JoyfeZJ9a7vsTG8A9kpWDT?=
 =?us-ascii?Q?Ll1BKRBRpfSaKEhOtDz7W2Y6a+3kyEZ/mXXiqwW+/Yn2+q+VEKav62SoWnau?=
 =?us-ascii?Q?ijcskuWX72jG116rCAP74/DZrBG8Rftkb6ns4T5Dz94/1n8c6+biTE9g8pkN?=
 =?us-ascii?Q?VEYJZX7V+lhReIWsCtr9Bkz1bpfeDlmOEk/adauWrfc6a5WvJtWNDkEnZhbv?=
 =?us-ascii?Q?K3KwqwexR1Cc++B9jtGYKmPwxkU9gk0ClHMVbZ6x8bd/w61++vwmqto8qSae?=
 =?us-ascii?Q?M9YdixlFXM/syLVBlBqt2ZLHdyZkdbfXOVyZQo/8kxWIzEjSexb8HEdPXsrB?=
 =?us-ascii?Q?w8CXSOeR2FJtqYczynr5p0udwXUWKnMLOuoLCR+OmWRXjsh1jfL0usUlgMWk?=
 =?us-ascii?Q?pbVOV7zLXmV0PsgeK8olp/bpfIRTvXDClS6VvA1Z0co4rH9Qt0DN3J0KZWCv?=
 =?us-ascii?Q?AYYe/MlS/zyFrFOQ1Td3YRRLeA9djj/8Q+HW+qXd95WUmUXHF23z+CVB8XOi?=
 =?us-ascii?Q?mikBj34Mm2R/q4h1t0cCRU2AYX09XCMYJIQFVY6E84vorIB1WfGmAdfIwBad?=
 =?us-ascii?Q?p8qukgz3jGafZKuoOiHoonyvrT2Xd14iKUS6UK8c1VaDm4HJhGhK7fCNyaGt?=
 =?us-ascii?Q?enuJ4yYSnEUIFMK89WV2t9ML+vGGycA5FGHaWeHHL0UH6JcPbSKYcGsUcRql?=
 =?us-ascii?Q?qJ5KtBadeM2W6UyJazPgkB3HE0gZ4ROunhG6VhU77Hu9LTkf+pIMGk7YOVc7?=
 =?us-ascii?Q?nEnC8gKP+Y0mIwmiUr9NygCBovWlOd1CXj11WyHiC0jAiNdQyV4q/06rxqEh?=
 =?us-ascii?Q?42W6FSXMjXyapMS15TQ+Xudivbjn5cqMcZTL+1pomCRipKp8tYK2n+iLglia?=
 =?us-ascii?Q?uCfdZndlxpLiF1rUjUSfd5td3wOtl9zgYOtPxjGoRa6Ox6OkIW+DTEUMqDVB?=
 =?us-ascii?Q?jHu6ELTrZSdH+I4WcFcXzAYNCIlsBXCgjKcDZViIr6z8WnHN/S8oIhkd70E8?=
 =?us-ascii?Q?vq3OmRr4yuMW91FX8KaF+yvnfs1htD2QimYk7w6f4aC3OZ96k71Qnlwrj68C?=
 =?us-ascii?Q?ae6uNXiZ1rlyJ072y35X0tteKntXhs+g0Cm8Bxf/5YwAnkusyc84Fsv+3ZtW?=
 =?us-ascii?Q?sf7wyHxeQ4d41gRi9vcK8e3UetSsUMBAUJaLNs3WkDMqMDc1qG/PxQT0H2Eb?=
 =?us-ascii?Q?QMvX+dE2/cnANpdsSFD/l78GvyQfbHmijvRwUGg+unsi1JCCnMJt7a8L5DRa?=
 =?us-ascii?Q?Hl4DkPz3tld9uCLhHB4WM+hMqpBXI7mqN4KQGPuZGvrOfy/gzXkPUDHxxWfg?=
 =?us-ascii?Q?xLH79zsCgT3weUIV1ABoaCNm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fbs9nF2LKpviYlDbQ5YDQqhUrvmsnJlpT7hvhSeixsTdma8/MrIoTiYUa/Pm?=
 =?us-ascii?Q?L/Oli2QNQ2prScLhz6JvcvGtYSePGrT9Ngx71B84lO7mGP/4043oe4mKFa65?=
 =?us-ascii?Q?nqIHI0HmfEyDe5Rr9SWuN7KuJVFRftlxdvmxRwucX7h1ngnG0vp7aL91hmF3?=
 =?us-ascii?Q?8XzWAKU+KzC7+cZU7IbqFf6GoJZXcKcXKCatJsiW1F8Fy19vZ4rEHrrY20fS?=
 =?us-ascii?Q?xZ5ov8nCqB6D8X+WynkXJeQT5jB4lcZ7lN0boIDD32Pbya16XhZU/QeNx3t0?=
 =?us-ascii?Q?9TM0qoOL3t4S8VcFVs+7UuBiFezN6mxFlBJGFVMPGkGWTXiC7w2cHt1eIlcd?=
 =?us-ascii?Q?fFcItn+wOkxa+OZJBBO2xG/883H9+24nZGPeStO76F04r4Jcy0oCGAHB0PfY?=
 =?us-ascii?Q?Vpbpt+yERaWX5a5INo9+3L538t7YqvekTURRjEQqlTeSBHNpNnAe/VOTUQ7U?=
 =?us-ascii?Q?ieYgc5kR43E3h+C5hr5so2jpYanU/SPNeST54WTkPQnG0Guae5BmpVyWTdIV?=
 =?us-ascii?Q?ft56C4nalNBDetS5feCpwT5WVlq7qosHGXxleSA1S+ysZ5iQ1u7QOAj+Dlg1?=
 =?us-ascii?Q?PXUmc/lb7Jt6HdJOEjegcmdRHIpvinsKuE16oFXYu2uC9oQW3QpiefhuVtL8?=
 =?us-ascii?Q?NQvdDWwNsJePrOfoc7YLvpbxRH7tqzyJcLMXzja4+L+C8JGG+omdHm0U7oaw?=
 =?us-ascii?Q?g/4CCEUE+32te+2uz2L7AA4crNtfTEC2Ggy7TkxZPFoYdAubscup6GZkzMve?=
 =?us-ascii?Q?nfja4JWvZitRvEXGmvhtY5JF+Tq1AWDIxDHpqsan3EE70qyuTRs39B+ryTc/?=
 =?us-ascii?Q?x4YGzqrzdI9oO/AZ5FVgjHZqPxLIHhXYSv/jdfEZ8qwZHUaiNK+igayR3h0C?=
 =?us-ascii?Q?TJ03Pl5H5d/IqKHA+uh3gExlVPVhByW/RORWyVJS3ZZoqAynqlKJlO8+SUWo?=
 =?us-ascii?Q?TVN2CO1Fcx1l8T23r+1ZJmIhA0FniW+u/91+Mu5Y/hkJ9VxyzDa2fgl+n6iQ?=
 =?us-ascii?Q?QU0QWgYRFfoZHT9TjVc5jOTR2Shjap4IVkftDTy7MRNjuHKWn8qF9pT8kKbx?=
 =?us-ascii?Q?PLwfEZR4H4Rxi//046yeygj2KBxpG49bV926pAsSy3kUf7hFED84HTc+67KI?=
 =?us-ascii?Q?Gwa5O0U2VHrGs1T7n+VP373YRxiKaIhNIVwqoeTv85Pf4wQe7MkGCcB2Oq6x?=
 =?us-ascii?Q?NuBMKakdxZ1pvHmfriijJws9S33NKu7gwupDs32h3N8xgn6eZLoBwzbSPoCh?=
 =?us-ascii?Q?+S3Mno+4QddTBjuMJdk1fdbZmFQay4ohGjDzUcMrge9Ki+cFpUABcS1gBNFf?=
 =?us-ascii?Q?KMBQlr/EPttM51/EqYGeLzeqJq1uvThQwK6qgU5BOey8XZX9Vyv7iU14nmln?=
 =?us-ascii?Q?nBhYBy5ZF1vZorpmVPgGdvJIn2Ia9QLviNgg4lxI1yjYLJQNtq52CfGMz/Yz?=
 =?us-ascii?Q?g/VSrvj/niAswcWEsWhdvnLv6j1f+c7Px2amnqSDcfovyVi2LKfjQZKMG+S4?=
 =?us-ascii?Q?DNg081b1PkZvMTrbr5KacWYLA+upoieBD7AEip2KeR1bnKz0/5sKYbYvxtse?=
 =?us-ascii?Q?nPirKr0HUVDrbrLwdEOzfWDFuAIqT3x+VJoJ1A5iwgJTK2d+3Acrrd+UKlkg?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XtDPXQCpWTRc+z9J015PYwFSsWfwUJIPlNJ6N3RDcNJlOnXcQ+avN4Ccgq6AEoSGeQ+8KU5D5le/U+nGRPizYUIfqd5zxMc9oskyo36jglWY96Bnebf8tlHC0KC3RsEXOktQD6V9uIo8zzA/+I7OFVGPS6KPc8/hdoPsKNO05kfnGcQufyr/3dxxE0jzqlJYesMRWBEKYaUV4pRpIk7p6qIf34OUBamXvUfthMyOzgvH90WHNWuA6fX+RvvyjGb5KF5MphfvMIbX+1e450oKz/1KYSX46TTyZ2V5UlEm6c8ztiFBXZI/cNMx6rNL6IvljQc6yhVvCQfDzpMHai/+j/K7R03iKHU4NMTPPAqESFn6MHIqUYvGFHpoD2rkZQoXEIhrqTQd6wFyPqzXMcQPI1dNQKL2bqltpMNVBduzlgWPSNAkDmgKrKF+iKn9WWixpXMYKowLkVzm2yYjsP6ulaph0E6fQ+UcLaWOKZ/G7nBViRf5UJxQSjqMWti6B2xD1TikaJrI/m/zrMOJZK0nbZxxFcsiEJ3ySDKrJ7SCVFb4YjaYLVW+OXN2+Lxxoe260TNDHYM8qpZ5RV3UlibPY3166dtMOixtfK4ubBo08+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ad7493-5243-4381-6862-08dcf1f08fe3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 16:51:09.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyjExegk2fvcm+vWGcz7aU5rMBnIfcEOOepED7kqxIG/ixyEAtZHc6A1DdawCL4aWKbupoQX9KCNaCAT5bY5XUSobiXkauzEicoDA+B66SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_14,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210120
X-Proofpoint-GUID: 1EAhxfwwfhZiVI6AssHnENFBlWc6DC7T
X-Proofpoint-ORIG-GUID: 1EAhxfwwfhZiVI6AssHnENFBlWc6DC7T

On Mon, Oct 21, 2024 at 06:44:04PM +0200, David Hildenbrand wrote:
> On 21.10.24 18:23, Lorenzo Stoakes wrote:
> > On Mon, Oct 21, 2024 at 06:00:20PM +0200, David Hildenbrand wrote:
> > [snip]
> > > >
> > > > To summarise for on-list:
> > > >
> > > > * MADV_FREE, while ostensibly being a 'lazy free' mechanism, has the
> > > >     ability to be 'cancelled' if you write to the memory. Also, after the
> > > >     freeing is complete, you can write to the memory to reuse it, the mapping
> > > >     is still there.
> > > >
> > > > * For hardware poison markers it makes sense to drop them as you're
> > > >     effectively saying 'I am done with this range that is now unbacked and
> > > >     expect to get an empty page should I use it now'. UFFD WP I am not sure
> > > >     about but presumably also fine.
> > > >
> > > > * However, guard pages are different - if you 'cancel' and you are left
> > > >     with a block of memory allocated to you by a pthread or userland
> > > >     allocator implementation, you don't want to then no longer be protected
> > > >     from overrunning into other thread memory.
> > >
> > > Agreed. What happens on MADV_DONTNEED/MADV_FREE on guard pages? Ignored or
> > > error? It sounds like a usage "error" to me (in contrast to munmap()).
> >
> > It's ignored, no errror. On MADV_DONTNEED we already left the guard pages in
> > place, from v3 we will do the same for MADV_FREE.
> >
> > I'm not sure I'd say it's an error per se, as somebody might have a use case
> > where they want to zap over a range but keep guard pages, perhaps an allocator
> > or something?
>
> Hm, not sure I see use for that.
>
> Staring at madvise_walk_vmas(), we return ENOMEM on VMA holes, but would
> process PROT_NONE. So current behavior is at least consistent with PROT_NONE
> handling (where something could be mapped, though).

Err, the handling of holes is terrible, yes we return ENOMEM, but we _carry out
the whole procedure_ then return an error, an error _indistinguishable from an
error arising from any of the individual parts_.

Which is just, awful.

>
> No strong opinion.

Well you used up your strong opinion on the naming ;)

>
> >
> > Also the existing logic is that existing markers (HW poison, uffd-simulated HW
> > poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
> > no error on MADV_FREE either, so it'd be consistent with existing behaviour.
>
>
> HW poison / uffd-simulated HW poison are expected to be zapped: it's just
> like a mapped page with HWPOISON. So that is correct.

Well, poison is _not_ zapped on MADV_DONTNEED but _is_ on MADV_FREE :) anyway, I
mean the MADV flags are a confusing mess generally, as per Vlasta's comments
which to begin with I strongly disagreed with then, discussing further, realsed
that no this is just a bit insane and had driven _me_ insane.

>
> UFFD-WP behavior is ... weird. Would not expect MADV_DONTNEED to zap uffd-wp
> entries.
>
> >
> > Also semantically you are achieving what the calls expect you are freeing the
> > ranges since the guard page regions are unbacked so are already freed... so yeah
> > I don't think an error really makes sense here.
>
> I you compare it to a VMA hole, it make sense to fail. If we treat it like
> PROT_NONE, it make sense to skip them.
>
> >
> > We might also be limiting use cases by assuming they might _only_ be used for
> > allocators and such.
>
> I don't buy that as an argument, sorry :)
>
> "Let's map the kernel writable into all user space because otherwise we
> might be limiting use cases"

That's a great idea! Patch series incoming, 1st April 2025... :>)
>
>
> :P
>
> --
> Cheers,
>
> David / dhildenb
>

Overall I think just always leaving in place except on remedy err sorry sorry
unpoison and munmap and not returning an error if encountered elsewhere (other
than, of course, GUP) is the right way forward and most in line with user
expectation and practical usage.

