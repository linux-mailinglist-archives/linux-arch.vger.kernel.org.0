Return-Path: <linux-arch+bounces-8351-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB7F9A6C33
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DEA2821FC
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368B81F4FB9;
	Mon, 21 Oct 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JI/rGZXm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H2zM+/4J"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EB61F9AB0;
	Mon, 21 Oct 2024 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521280; cv=fail; b=LpY3HbGr+8vsJtpSoEm0tRZb/pHlYVHmiIq++rojYqHM0uRSM15M29XN+k4/puPSFoCSVOXJTzvR7457Az8Fh59HkGABzYayNJt+9H+DEkUSnu5r6lObk2wkro82TueKt03BxqRzTHTPb5j+2mx3NoBSmUIFn44eldEzfVXyH9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521280; c=relaxed/simple;
	bh=Y5BMT/lrP50zw6gdjDD5aO4+50CTkb5vdxym9XHTTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JlpgMrc5uhrV1+Yyf5LmFL41cMqvcdHM1cZGscpis+t2/kDA+RpBt+kXdGrmL/z0tcI1ZlFr7M+yRxYjXam5lrOYNblVg5Omg53eFyPqi+JDHOfN19dQu1+Ax6udiep89NlPqBVc3fJFr9m/usqLQixVg1RPhzEJYvqSvC16FNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JI/rGZXm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H2zM+/4J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96nCG005500;
	Mon, 21 Oct 2024 14:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fN7nSnMpgfbPSWEvME
	BkV6nMuTo2GRY+Q7u9mljh6/A=; b=JI/rGZXmV+mGgEzAkd71oic/CNS1DPO6Ry
	QhOyi/yiGT7anWdSxffsW4TrJT0vyYL3xv6cGMvHjtvtbJfb+dUx6xgKmR4l0C+k
	BAvxyr6pnMtCI3zwnHRJbAshxRE1yw+XuCmr0QDTk++f+75brPwDxdrEu3zsjupD
	XdBcki0Pfa+z9B5suHYQ13VubnNB8sL4voxhU7huxd5X+BZEf5sOMAPUL7ksf+Br
	nEKwlAaXN4CRpYuDmHmvKjaoA6HVR3zE6O3pJZYLnQkpIxB39XnectMu/0A9ySoi
	iyINUhuFyaE5r7K+hq1Ah7NE+roXldD1rCkfSBd7j3x3ROHogrxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqtjgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:33:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDFa6W035262;
	Mon, 21 Oct 2024 14:33:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3775mgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 14:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/ucuvWkYK3X53rwl6ALx326bn79aeBNQdxmAIXZlLQHWTyMBraudEufVN5oDs+gflp8vh4GNJXFmUKuBD57rbny/ZnPBR/RV8eaezP0CQsYihogXSXZit/YSnAOjYI7Otgx4WQHem7QaMfOjMeDFJfR4901CcyG3uDw7Tnf9bHW7Z943aOpALJ4FKE6QXrfuc1e0kUW4YyYnoLoOxieC67n705hdhlZYQX+8qR7VSQn85LfGe97TvJEXAhqqfitgdLoF3OVUmUnZxWTzObXL3DMCX4AGcs1t/JGp3ZlQS8E6Km6EbFZAfKlSZzf/CqGBnGNFr4UxOWSZg0NvLaJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN7nSnMpgfbPSWEvMEBkV6nMuTo2GRY+Q7u9mljh6/A=;
 b=PVUb84Oq+S5U887YElvnkxWHIrVFgiwEB278YYiQ5/extkFH+Rc0WfKX+GQI/6PI9Pr1b+L8qSxrDvxgoFW4Jw0uGwrOiuBfizLbHmsSoDlDog1PKiELinCywVJYXIUpm5/TlS5r7CSc8PbXkvghFUXZnBuxJaUxmqNQAnB+ueC70FxvKRL/ReYAPwhqtTE9LcLpkC30ktKb7Nhhc+AEkVrfby3CnXKvAFHq5rVMKuH2bvxv60rf2tOcBnCQZ/Xs9i9Pkbkqrudl9WQAAeQw24umPZi0bvFOLtZchg7x439y1M4TXuQ1XXTzMjUCU/cb3ZLaKYEppp7Y4y1WD5ktqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN7nSnMpgfbPSWEvMEBkV6nMuTo2GRY+Q7u9mljh6/A=;
 b=H2zM+/4JJ8rC5IltrlmyOJAuZUWCml6yz0rKNkA4Qsd3+a3mQxo6uYxx7DquGsJinD7gen4XQZgkyd6ZsAPnc6xJ8LCqD5mzAEPhd3bGVvzCDqFRZyOLogY6Df1yMFIxpod86q4Lwu38MtQk01OLwLxLNzto/ysnhDjf36CVziw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 14:33:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 14:33:51 +0000
Date: Mon, 21 Oct 2024 15:33:48 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
X-ClientProxiedBy: LO6P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdac6d8-94ca-4a0a-becf-08dcf1dd6211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQDW7AbwGsiUo3YTNAs19MTSVGGK7DfJKrKXPniEsmnfHzDIuwUiBHCIlA/r?=
 =?us-ascii?Q?HI2+vbrbMrQ36lTeKcywabTNHFt4AdBxp+/A8xb23wdgzJESVnGpC6NGHJPH?=
 =?us-ascii?Q?FzDbl235otuHv/9/873XCCQ8T7HQ7DI4DHfzndIKveZjrAPqaWqOJn9WH3u7?=
 =?us-ascii?Q?5p4YKpDPPkrcQU6uSUuSnB0SlhyUsCepSdzlAJc/h/7F4FlgnEkW//3yPTGq?=
 =?us-ascii?Q?ugrYYRfqKaviKKIxzP+D0fhGO5dIGwmI9xwHcd2cFCmwU13I+acSoIQ9LnOl?=
 =?us-ascii?Q?PyyOBre43HXyfQPxkM3BLg4PgFJX8km/irWVlkZ51DkKS0bT6u/LEVptNoWi?=
 =?us-ascii?Q?+Z7mUyk0co1rHeytNMNPYVa+z7EB9Eb5QhEyhuvOqcT3MsIpTJ3ViDui9mBq?=
 =?us-ascii?Q?5+8ExNYWiwEc+ueIfaezMQP2AIputzZJlLheV/g3rHmlCXNYwg4WjeaBBORm?=
 =?us-ascii?Q?1qQS9v5xOWZieRPtj5RWx0gknNwjaKQNEUOwKiIvZ9yWCO1ksmowmFOLxUSt?=
 =?us-ascii?Q?SKxbELkjmNCWvxLYTTjmMS15vtckmGJs2q7KPcS4eJWMbe6PnSY7SqWdIemh?=
 =?us-ascii?Q?jexJWZxYYqVft8Is4DPof1bYPFhfd1k9nUUxwULFVXIUFgQt+IAy11kAm5VM?=
 =?us-ascii?Q?sHHCyoSmeUGnqnyCbAPCtoMibT0mciJCSoibjUFnHTFLuisSQ4fXowRSgDay?=
 =?us-ascii?Q?2OHx+mHyZwOL6L81OMswpdeAbrYE2RRjPmv0XOhkUxHQ3XyXcf3B7A4JiMhb?=
 =?us-ascii?Q?VkwOIoXI1plUDCKkf/lpnz58XKozGb5jWiFPCdyyAXaFCdo9KqiXorP74Lnz?=
 =?us-ascii?Q?j+KQ7k2pQh+NI4ZbB/BNeuDUwgiSCNaJ1fChR9blcb68EidFgPQszq5Qt9KR?=
 =?us-ascii?Q?Hhf9doAgncUYqGABxC0n0q1zrbNQF7bJb2cpO7mMQanWT3mb2Hjb4rL/LY/O?=
 =?us-ascii?Q?ASZjdI4M2cvR1Q30fLNfjuUIsNUyHXAJ/KDPKmaC9dGWCmxas+tUbZHuLhqt?=
 =?us-ascii?Q?ylZMc3H7tjAxEem3C+4ptAI17PhRDcT/g/GQLhxGBimB7N94GB3/xEbAEDRx?=
 =?us-ascii?Q?3Lcm0ct9IYJV/5/FzJpu8b0xZr+LetD7Cqc3Mac3V4aHbGmzCGdnXsXxi0sx?=
 =?us-ascii?Q?h/+ifLGo7BfQ1rsIgc+uZ149zEftAcQD+LkIRsRQMtMepW6HVrMk8dJgp29M?=
 =?us-ascii?Q?TYbM/mQznOupVhKbOQ8QRPt+vxLBZjzVvXFvC/LP0wi1p3vwPWaaQrwM/+/6?=
 =?us-ascii?Q?JYmZx7faASyLsjIi2IoFbcBiQAMWD83NAvU5T13FQpU1txihrtffYdBIJYgD?=
 =?us-ascii?Q?u/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v9D6Hkky0eh0MFTrT5c0DeLUzg/DMrCez2i9CCWkBAMOt/Zi9T1XTpI6cN0F?=
 =?us-ascii?Q?lQo/Z7uKfjaGmkKVrhkgHZvMn+3tip0cJUBqS9zcFOD50QNYNBsZPJi/wZa4?=
 =?us-ascii?Q?yppCtdbUck4TLrD7QeCz9jl9ouqm0uTMw/ejtngxSdntyvaCvs25hWlawjEi?=
 =?us-ascii?Q?WQDpCBPLdgyXQpK50l94g1udXSVDJ8hVgpV/lQ35uy+dnTLTpqoOUgXUOTWf?=
 =?us-ascii?Q?LD6nnebqm4+XAF5Mgn4Mj7wyDnM2WyTliwivtqhkUVqXAcXScNNGXdOC41wa?=
 =?us-ascii?Q?ioU4Dep4dxiuTalzYoDkvi0sC+N6iygKdC2vdDXKwLTdO3YDTn4Ht98XfJZc?=
 =?us-ascii?Q?71jwAsXQjKdn9Idr4jr6jMikcWkWmfN4jaWCaToH3/WGBQE99d5NJygkukyL?=
 =?us-ascii?Q?/PZBgWYQ3Qd9cdHgaQ2MPFqTxOQTkL08aFKxGa3HBi2m0+YPt97X98mtovux?=
 =?us-ascii?Q?dlzdy+gqkgEMs0h54hU1Ma9DHfDOnhRxw4D2xWztbr/0oiyTc/6zLqX7dwSh?=
 =?us-ascii?Q?X7o92ovxE3PcfvPva1B40d5+p6CZkyx4QnJPLfPuLevpYCzrDrSHYvzBlZkj?=
 =?us-ascii?Q?JULpAcqyS+qh6qoYLU1CeYdlme6TRDOcmS2WIc3kSOQrXwdFeXo7AytLR2aT?=
 =?us-ascii?Q?qz273QwbXB/xyHMGuI/yqfqq1A+VlLW9VH+ar7JKY47Z07JplQDJK1DAnlsc?=
 =?us-ascii?Q?q15SY74r9QkGkVOVQFvI9rr3lYb1IfCOc40kMZBpNldq7hpj7AoPONGHj02C?=
 =?us-ascii?Q?qJLBqAXccrYQUHk+vbEV9nX/4iX/pkpw7iFJ0S+Pa9eHoHIW/RfDJtuZQb3L?=
 =?us-ascii?Q?MmPdEq3MXDHdCDiY0H+PxRaHEgvwi5tMu9CcWkUYycB7d/sZU1z2VNW2oNhr?=
 =?us-ascii?Q?2kfRqL++///fZEdQb4pVNYXlXG8pvksiUqiq/5TLTL61xCjWkI74HhxVHmSi?=
 =?us-ascii?Q?UdW+GFNO4hvBzUM/82SZ21Ep24/+w8xEgQpzwHHt/Kb/ncfF+hQoTG9V8MB0?=
 =?us-ascii?Q?H46xJMycudnseM50s259EQN7+yvhX4Krqz5ZvOpbl8ZtFzf8CfgcKmuklYge?=
 =?us-ascii?Q?J8AByNrb2xRWgKzEqVxOU9xAYuZqLbfGiV5GN9P3MtIWgxjRi9t9xbKRrJBJ?=
 =?us-ascii?Q?FUfjZ0oU92R1CW54NbzbPMSe4X/ocK9MdekU0wuxB693biFuqYBKZVYKLf2k?=
 =?us-ascii?Q?/0FkG9Q7pKEHPFngWZTlx0Ok6VjXdFq4VQMQWMtlIbZcPUhB/RRfJii/kGPD?=
 =?us-ascii?Q?AB1rCoHY36gExwnnwsogJNs90fl4n4WSrIc1oOfafcGryHCNsJIOkE0e3hxZ?=
 =?us-ascii?Q?oA6M+I91S7cYoYHlgVU3cOqm4FM9PSq+7cBOdeIvbsAwW2G7GfA9IDmHr5xp?=
 =?us-ascii?Q?w6buFsQbZ/rP9u7XfLNmjlXlyyScM6lShsN0AUaX2SCOebdSfzlF5q7aCKBU?=
 =?us-ascii?Q?sYZXOy0J2GCJBYNqyW4dJiJ+0xS3Q7lDNb6pS6fFUqj8O+bA3/MpQ1oBYrd1?=
 =?us-ascii?Q?1paicy912QMa/Tz+/W6ePcUEK41S8Qschoby+0GMfYZOuMnp8atrjj0N7qx8?=
 =?us-ascii?Q?R0S03ONgaj9XrpVL8fBEWsnMeboIh379h3tmyAJU5oa7X+bRIoNSe7ku3X1g?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qop6Eckyl2GFs8EFdi8Ze/c4akELjE9Ttktr/dBh+v+d/NO2FCSk9JL+o0KH1nMvf34H9T1U0GDU/KOccD4/mFk3nq1sa1ODrh9pL747oN4g4wZ2X+/siJxmbxx3F8hQOzMkP2XkuAOGwjksu4T8O1vGX7jurlfK8SkKS5aficMG6qrFwB0Je5m1L/L0EhemdpLLAsxUGxU8UvnUPzPp3v87kiw2xack8G0iaQasCSpgrrijkbQT0445+l61t+/HITjCG/lBECAgiIOV/geu7mJrd0mYv7yTOT6CoYeSOq9XcLMttd8VvgLhmO3u+9/6KGdYMUBlKdr0Aohh42bGeOLYS8JkshTSZut8lavplJ3mCsxb/GytvhiAajPSGBz7SoODior7Bt+r76TIipQLxvIRhq5acELjPC+chhGzUxdu6+zVquUybrtotMud0Zp98INQVdDu5wAsgecA5CQ23jm+ASRxhAJAIdw8XDTA6ygRHdwOw3tZl284Jvb8L9YZFAqVdZraauI5I9BedT0a7pFXHf8mDJByGR5bxj66LyYIbRMB40VvIeQB2HZYX2iK3ZPiN83ODM0+qR1s0In5dslXe7DskLKN8qcRVx66l2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdac6d8-94ca-4a0a-becf-08dcf1dd6211
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 14:33:51.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI6to0JJ4e4iPFJU6jtyyCqZ5a1gVmUe9gddX6kPxycXdY3e1Fe9GKatTVmexhvty1lcHFqSK1i4yC2u3LlG0tfF/O2IQ4C6i0/PM59lr30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210103
X-Proofpoint-GUID: mmXNyfuS6wtEXB4Wd-bFUolsDtDKPSIY
X-Proofpoint-ORIG-GUID: mmXNyfuS6wtEXB4Wd-bFUolsDtDKPSIY

On Mon, Oct 21, 2024 at 04:13:34PM +0200, Vlastimil Babka wrote:
> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > Add a new PTE marker that results in any access causing the accessing
> > process to segfault.
> >
> > This is preferable to PTE_MARKER_POISONED, which results in the same
> > handling as hardware poisoned memory, and is thus undesirable for cases
> > where we simply wish to 'soft' poison a range.
> >
> > This is in preparation for implementing the ability to specify guard pages
> > at the page table level, i.e. ranges that, when accessed, should cause
> > process termination.
> >
> > Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
> > function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
> > purpose was simply incorrect.
> >
> > We then reuse the same logic to determine whether a zap should clear a
> > guard entry - this should only be performed on teardown and never on
> > MADV_DONTNEED or the like.
>
> Since I would have personally put MADV_FREE among "or the like" here, it's
> surprising to me that it in fact it's tearing down the guard entries now. Is
> that intentional? It should be at least mentioned very explicitly. But I'd
> really argue against it, as MADV_FREE is to me a weaker form of
> MADV_DONTNEED - the existing pages are not zapped immediately but
> prioritized for reclaim. If MADV_DONTNEED leaves guard PTEs in place, why
> shouldn't MADV_FREE too?

That is not, as I understand it, what MADV_FREE is, semantically. From the
man pages:

       MADV_FREE (since Linux 4.5)

              The application no longer requires the pages in the range
              specified by addr and len.  The kernel can thus free these
              pages, but the freeing could be delayed until memory pressure
              occurs.

       MADV_DONTNEED

              Do not expect access in the near future.  (For the time
              being, the application is finished with the given range, so
              the kernel can free resources associated with it.)

MADV_FREE is 'we are completely done with this range'. MADV_DONTNEED is 'we
don't expect to use it in the near future'.

>
> Seems to me rather currently an artifact of MADV_FREE implementation - if it
> encounters hwpoison entries it will tear them down because why not, we have
> detected a hw memory error and are lucky the program wants to discard the
> pages and not access them, so best use the opportunity and get rid of the
> PTE entries immediately (if MADV_DONTNEED doesn't do that too, it certainly
> could).

Right, but we explicitly do not tear them down in the case of MADV_DONTNEED
which matches the description in the manpages that the user _might_ come
back to the range, whereas MADV_FREE means they are truly done but just
don't want the overhead of actually unmapping at this point.

Seems to be this is moreso that MADV_FREE is a not-really-as-efficient
version of what Rik wants to do with his MADV_LAZYFREE thing.

>
> But to extend this to guard PTEs which are result of an explicit userspace
> action feels wrong, unless the semantics is the same for MADV_DONTEED. The
> semantics chosen for MADV_DONTNEED makes sense, so MADV_FREE should behave
> the same?

My understanding from the above is that MADV_FREE is a softer version of
munmap(), i.e. 'totally done with this range', whereas MADV_DONTNEED is a
'revert state to when I first mapped this stuff because I'm done with it
for now but might use it later'.

Obviously happy to be corrected if my understanding of this is off-the-mark
but this is what motivated me to do it this way!

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/mm_inline.h |  2 +-
> >  include/linux/swapops.h   | 26 ++++++++++++++++++++++++--
> >  mm/hugetlb.c              |  3 +++
> >  mm/memory.c               | 18 +++++++++++++++---
> >  4 files changed, 43 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 355cf46a01a6..1b6a917fffa4 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
> >  {
> >  	pte_marker srcm = pte_marker_get(entry);
> >  	/* Always copy error entries. */
> > -	pte_marker dstm = srcm & PTE_MARKER_POISONED;
> > +	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
> >
> >  	/* Only copy PTE markers if UFFD register matches. */
> >  	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index cb468e418ea1..4d0606df0791 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -426,9 +426,15 @@ typedef unsigned long pte_marker;
> >   * "Poisoned" here is meant in the very general sense of "future accesses are
> >   * invalid", instead of referring very specifically to hardware memory errors.
> >   * This marker is meant to represent any of various different causes of this.
> > + *
> > + * Note that, when encountered by the faulting logic, PTEs with this marker will
> > + * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
> > + * logic.
> >   */
> >  #define  PTE_MARKER_POISONED			BIT(1)
> > -#define  PTE_MARKER_MASK			(BIT(2) - 1)
> > +/* Indicates that, on fault, this PTE will case a SIGSEGV signal to be sent. */
> > +#define  PTE_MARKER_GUARD			BIT(2)
> > +#define  PTE_MARKER_MASK			(BIT(3) - 1)
> >
> >  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> >  {
> > @@ -461,9 +467,25 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
> >  }
> >
> >  static inline int is_poisoned_swp_entry(swp_entry_t entry)
> > +{
> > +	/*
> > +	 * We treat guard pages as poisoned too as these have the same semantics
> > +	 * as poisoned ranges, only with different fault handling.
> > +	 */
> > +	return is_pte_marker_entry(entry) &&
> > +		(pte_marker_get(entry) &
> > +		 (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
> > +}
> > +
> > +static inline swp_entry_t make_guard_swp_entry(void)
> > +{
> > +	return make_pte_marker_entry(PTE_MARKER_GUARD);
> > +}
> > +
> > +static inline int is_guard_swp_entry(swp_entry_t entry)
> >  {
> >  	return is_pte_marker_entry(entry) &&
> > -	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
> > +		(pte_marker_get(entry) & PTE_MARKER_GUARD);
> >  }
> >
> >  /*
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 906294ac85dc..50e3f6ed73ac 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  				ret = VM_FAULT_HWPOISON_LARGE |
> >  				      VM_FAULT_SET_HINDEX(hstate_index(h));
> >  				goto out_mutex;
> > +			} else if (marker & PTE_MARKER_GUARD) {
> > +				ret = VM_FAULT_SIGSEGV;
> > +				goto out_mutex;
> >  			}
> >  		}
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0f614523b9f4..551455cd453f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
> >  	return !folio_test_anon(folio);
> >  }
> >
> > -static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
> > +static inline bool zap_drop_markers(struct zap_details *details)
> >  {
> >  	if (!details)
> >  		return false;
> > @@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> >  	if (vma_is_anonymous(vma))
> >  		return;
> >
> > -	if (zap_drop_file_uffd_wp(details))
> > +	if (zap_drop_markers(details))
> >  		return;
> >
> >  	for (;;) {
> > @@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			 * drop the marker if explicitly requested.
> >  			 */
> >  			if (!vma_is_anonymous(vma) &&
> > -			    !zap_drop_file_uffd_wp(details))
> > +			    !zap_drop_markers(details))
> > +				continue;
> > +		} else if (is_guard_swp_entry(entry)) {
> > +			/*
> > +			 * Ordinary zapping should not remove guard PTE
> > +			 * markers. Only do so if we should remove PTE markers
> > +			 * in general.
> > +			 */
> > +			if (!zap_drop_markers(details))
> >  				continue;
> >  		} else if (is_hwpoison_entry(entry) ||
> >  			   is_poisoned_swp_entry(entry)) {
> > @@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> >  	if (marker & PTE_MARKER_POISONED)
> >  		return VM_FAULT_HWPOISON;
> >
> > +	/* Hitting a guard page is always a fatal condition. */
> > +	if (marker & PTE_MARKER_GUARD)
> > +		return VM_FAULT_SIGSEGV;
> > +
> >  	if (pte_marker_entry_uffd_wp(entry))
> >  		return pte_marker_handle_uffd_wp(vmf);
> >
>

