Return-Path: <linux-arch+bounces-7794-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F017E993C4E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 03:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3087284EC3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 01:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94F14F98;
	Tue,  8 Oct 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kaXrZnzG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="afzjLtbp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21AB8460;
	Tue,  8 Oct 2024 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351473; cv=fail; b=LmWp/bqqrdtKmvyFZGF/H4quhkBEzindh6B3SWgv+aGCdNnJi1vfi5VxvdfEukQrWiGKBGAFrViLP9SVpAXmOR+jT2MP9XByHoUk3WIpBnxlHlCtCzQ39mo6zak9Z3D8/SLFgz6sZ3CXt4745u4UqB/0UlbPhsmwfFtkvYXSKzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351473; c=relaxed/simple;
	bh=6rT3P11RQYU48nJpSe7NJ8iWVoGaiHVDKWrIJMjEwnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rm8QLFV4P1+yG+MbObzL54ltIk5gllVboTlSHkFepdOSmB7U2A65FS34MoACExXnTmWrFAq5xjATLFwuxMesdshNigkc/4C+j0XdEiQaBfapUGGWaPmMJqxc7P3yBw2C9idDlvXnH/Gd/aZR1UCr/3/brKXtzceZC1qgKG2Hgac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kaXrZnzG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=afzjLtbp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4981NiCb026420;
	Tue, 8 Oct 2024 01:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=V+9OKG2oilZJdEEOW/PNXNvTlrK8dq98VC0RkC5+xxk=; b=
	kaXrZnzGkzu1tWdE6YRn6RI3Z6pjmy6Jbbtpe+s7NIvIzNUvoNArn/4/CbBfc/c7
	7KFYocQeMuMsGZ085+oTWzHUh8FCC4Hr7F68fKZKeH04kTA+XdqzS/oYhUScZsJu
	/SxIkEw6iXJhjShX3IVc0vOPfwP4cgyq2TVQX2kBKNL3J6Ao3VX1tXIBiO5DTxlf
	C1Z4FZK07xuhzbiKVpx8/g3bk3iSo0cI5b4i2Wl3v9aJqm0emY0HPfrjElTFX+qY
	XF5xNXM6lq9W6G/dlYn6A5vnaiFHp/QJkAImQT38qrsA1gG+n8XTWYDtzliRjGUN
	jwY8Eiac53EoP741udpdkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300dvreh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 01:37:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4981PTYB012647;
	Tue, 8 Oct 2024 01:37:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw6hqmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 01:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbVqceHXiwYCjmFLlCF1fhbhPM4B93IJ/URt1Hf17iQHX6Ai263d+CL0tmlz6WSSYmIy/ainBjn2hHjtfYz2UKXy4gB9PXxJTyE+O7001yo8YG+lfUs5YYDRtCiSG4RW+Lc7YkF1B09UGuOrouuDOBGV7Qn8DCE91rRqYVumu0/2TLJAs6mRCaUTtGtjQVFYiY8Cp7AGld7KYAddByUzVM2V1Z9rxYmy9dY+QN3ZUEmmP4xRkAmUu6/3kAGDFIrQw8IAsdQoemZSJ4053QkbFzRfIvo2MhbUUCKpXmSIbYZvSlM4z7EDhpW3lCgc5Ep+1A7oySrLM30hyesaN3z4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+9OKG2oilZJdEEOW/PNXNvTlrK8dq98VC0RkC5+xxk=;
 b=vyOesJm/0Pttzm5qtRWHsoNYIY/JZhIWqEsTDQP5NmzIz0n6RwY1r6vDeCHJXVWpHlGGBW+F3JuzELB+5ZB6ufKHq8lPGlwvxfr2AoKeCP23AK1DVbgnvg7JbM4TDkaaK/rRB5ns2jZGwIWT72ZdZKUduTBhNFEecguzIKNR6YDZpAUVZdDYuWOBTcmhinsyElBU6a7t6d7s2ROKX5vqJE2CX1/LNTomSWdVadKvDj06hDsSu5q0l9EpaSXj9DYIWgAIKGpyJ1CzC/2sXYXGqXEOcsmhSVtm3AbUxkDvgtVA/o+K1BLkk6T10/9qPEIRDHWW1P3e2mgjmt1KGWrztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+9OKG2oilZJdEEOW/PNXNvTlrK8dq98VC0RkC5+xxk=;
 b=afzjLtbp5TXrh7V6AqkTlxh6cwQiRsGFekrzB71OQhP+LYQ8+8Z66Exp9cqXRmTRbloktZIeIVzwvILGu1kQSG7iD0EmO/L9HLZl6bJaDpDB+dXeibniF9Vfv0xDsvaLnidxcoFT1lk+ffijTko4usw39jq6/SkNeH8i5mVERR8=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by MN6PR10MB7489.namprd10.prod.outlook.com (2603:10b6:208:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 01:37:15 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 01:37:14 +0000
Message-ID: <f323f1f2-46da-40eb-8632-d0bf1e60ee82@oracle.com>
Date: Mon, 7 Oct 2024 18:37:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        khalid@kernel.org, andreyknvl@gmail.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org,
        David Rientjes <rientjes@google.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
 <8c7fbaf1-61a0-4f55-8466-1ab40464d9db@redhat.com>
 <0a1678d8-0974-4783-a6f6-da85adfa1a34@intel.com>
 <7c13be04-1d18-45bd-8cfc-f5d37bd39a8e@redhat.com>
 <ZwQQOP89Dj5gvbaP@google.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <ZwQQOP89Dj5gvbaP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::8) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|MN6PR10MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ba442-7e4e-47c7-b2fa-08dce739bcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkdoalYrcll0cTRHK2ZOM3dPdUpObk8rc0lzSU13dmhoTTRLcFNFQ2doZFdP?=
 =?utf-8?B?WmF5bkJmL3pMVWdrYmxSbjJFUVlqWVVMdVV2VXFqcUVrNmdXazFrZ2V0TWdz?=
 =?utf-8?B?ZFV0RFBabVJtM3d2Tlo3blp4WFEyb3pWME5MSmVSMUpBNlk4M29iQ2VIMVA4?=
 =?utf-8?B?azlQM1BnWnNoYThjV1VtMkxyUVNjU0taWUJSWGxvRmFKcUhlbG5ZeVF2Q2Q3?=
 =?utf-8?B?V0JGOEtwSTE3WnJ5SEozVXpXVTFqd1lMVkVKWCs0UG94TDh6aUtPaXRkVElC?=
 =?utf-8?B?YXRRVDhZQ3hTWUhzQWg5Z0hhZzhXWnpsUXN1MnpKdDhpbEpXNHl4TUhRQllv?=
 =?utf-8?B?QTdIWm1rY0FlUFdiSVV6STBaNUxJN0FrMjQ4QWZNQWM5OE9ncHlJc2Z2UzNq?=
 =?utf-8?B?c1FtR3hEZEU4L1F1dTZEbzV4Z0JtNUpGMlhnTEgvWGpzVXN4VElra2hwWVRi?=
 =?utf-8?B?S2t3NkY0amNOS0l3SzZDMHVFKy80QTZoeGtieUdsM3hYZjF6SUtVVmVSazFh?=
 =?utf-8?B?VFUwWlNJTTh3NVAzOHBtVWRPZ1poeko1eXlVSlhTM0Z3Yk11U3cwSThyZGxN?=
 =?utf-8?B?TldzbGhpVWhuUUgwNy9aakloWDk2cWxoVXNaSnRKSHVwWEZDQkJyTFJUTXRz?=
 =?utf-8?B?d2pnRDllbVJUTDEyNk1DdVpnT21ERityNFJ0SUdpc2lDbFBkZ2FrNkRibzVa?=
 =?utf-8?B?c0lUVTBkajg3MTA0VVlncDlpUnd5Y3dXNkJ6Vi9nSDNPTUlBekdvQllycmVw?=
 =?utf-8?B?ZDhobmxKNml6MFNHSkVhdG9DYjdTU3NoK0UvWVlQSG9iN1FUM2ErZVRYSGsx?=
 =?utf-8?B?Rmh2RGVOL1pCdnRnQUxMbHZYSFMwaEZrbStSelA4R1JONTFtRUdFWWJrMUwr?=
 =?utf-8?B?RmJUNmE1UllKUU45UkZMRnB4UGM4andIcTNoSzl3V1o1Mk10RFg0dDZYZ2hG?=
 =?utf-8?B?NGFRQ1NrUXU0Y2VvRE1TUnB2OWhzVXUxTzI4MWJlWk9rNzc1bmlNcE83aHFP?=
 =?utf-8?B?YlE1ZFBZeHlsT0N5SXRqY0lma1d2czNpUURFdXpqU0lGK0tmcTE3US82SDRl?=
 =?utf-8?B?a1JRWklTQ2QrSjNmZkpZd0xxdEdoSER6M0k1TVd4b0kveW95M0REa1NpeFla?=
 =?utf-8?B?M3gyMEZrS3NIaU9uODNOTURmRnkyTGNqRnRzc0phbEYrSjUwUlBBYkFVL0Q5?=
 =?utf-8?B?Z1ljdVFnZ2xXajQ5T1JlWkdYZ0tocG1UMXF5eEtFMkZwcmVmWkNkNzBXM2Yx?=
 =?utf-8?B?a285d1N0eFVJNDhWcVNBYWZmbitGczVqa25wbkw0c2ttdGlUNmtOa2s2NW91?=
 =?utf-8?B?cnhLSklNQTRzYkhRb0xaU2U0TStpdVFmV0lqOUxHelRWeUhrdlhFbnBSRHdM?=
 =?utf-8?B?UEtHOTJzVExJSEtCV1VEamNTNGlhcHFYZ3hJZ2ZwUERTUEFLUFlRSXNzUGpS?=
 =?utf-8?B?QzZZRGh3TmdhdFZkVzNteFNpZGR0S2NHMFNjRkZnaVA3SUo3TXpuMDNFSUxo?=
 =?utf-8?B?UDhWbWliOFVManV6eXpuaGk0WkdKOXBxT0RTSjFaMTA5b1hnWktCa2haQ0NB?=
 =?utf-8?B?cGVQYzR0WXlnQnAzV3dMUENEZzB5Z1kxTWJIbTMrZTIxQ01haXpxdSsrQWlt?=
 =?utf-8?B?YkRLNEhWanVBTWNZUDdta1BYYTV6blI5dE9mS254YnU5OTBuOU5WWVVEL2FN?=
 =?utf-8?B?eXFJSnM4WDlJRHV2K1hjckxnMzBDZDNvekllbC92SlovbUpZMmdXNC9BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2pVWkVrSDV6eUM4QVZwY2Mzai8yN1FPSU43Ny9YdmJJT3VsS0p6RWZ5WFk0?=
 =?utf-8?B?T0tkM0l6RnBqSUYrYlM3U0I5TnFqWFpaN0lLT1ZpZ2Q3ZHFUQXVzM2l6SzJs?=
 =?utf-8?B?VXNxck44QVkyTklDS1FSYjdnZlRzcTY4NlhDQWJ5ZFRVeTdEYjZua0NrZzFn?=
 =?utf-8?B?ODA2cUlhbEdyRDRrWDdzNk1yY2Z5M0x3R0ZJQjlNODRFTWN2ZlJjWWFjdy9P?=
 =?utf-8?B?c3c5Nld2QWtGVis5R21tQnVjTUJkb3dDMWFld0s4Um9MN3dmejc2WW50VzBM?=
 =?utf-8?B?RU00YTM2Y052VW1vdnVLdzF1TVJ0TkZzcGdBMEVyTVRLSjdGcklYV0EvSGVP?=
 =?utf-8?B?Qml4TW9jWTZJQk1aM3lVRDRGczJaSE1PZDB5V0xQcms5bG1DTjVRc2paMEhE?=
 =?utf-8?B?OGE4WWxKNlZnMWVtQWhFUnVMT2hIRHpoUGtsTGdlaGJpVXBETnFmR1BidDVv?=
 =?utf-8?B?Q3NEYjRYR0NxYis5STlWaHZJZnh5S2hLaFd1OStBZy8rRzZKNHVHOGx1UFNG?=
 =?utf-8?B?WUtUOTR1bVo5cTJrcEpSa0dnSHh5eExHYTVGUVJGbkVpWGlCYkZIWndGSmZZ?=
 =?utf-8?B?b0pGRm54UDZIMDRvS0hWYnRVcWM0dlhoWW96MGZ4Y0RnV25XdG9PUE1VaTRF?=
 =?utf-8?B?ajBmQ2ROa1F5bENFdUxDSHVGdXptY1pvdTRzUU4yWW90ODZ5b1c4SVNvRWI2?=
 =?utf-8?B?TEorRlNUb2haYWE0TEZOT3dhWFk3aVdEaVJIOFdHc2c5WlM5ZE11RmpsRUE1?=
 =?utf-8?B?TUZCc0p2MDF2TTZySno1TDhrRmZBNExEalMrRXR6bHlMZHlHUThlU1hydjI5?=
 =?utf-8?B?aWlaaVVCamZYRHZuSTd4VEJlUXo5RGkyVjg3ckRFM3Rwa3dCMFN6STQrTDZX?=
 =?utf-8?B?Q2twQzYrcXE1cWN2OWNmdEc3Qmk2NDNyaUprcUxDTTkwQmtJc3ZJWXgvNUxB?=
 =?utf-8?B?U0MyOTg4cXJ2MlFkSWIxbko3TGhmVTlXR0tscUtMK3NUbGE5dUhkSlBiZW1X?=
 =?utf-8?B?S3VvKytsSHR2NnJ1aVptUmtFTlNhdzBhTEJ2dk9JWForNzVGU0ZtWEJDTm1Q?=
 =?utf-8?B?d3VVYVZvTko3TEFmTjFHQXE5KyttNGs4QVlIVkZNT1hobTdsTFp4ck5ybThu?=
 =?utf-8?B?b21rNnE4dzl0d2V0MjZmRjB5VUt4WmlKSC9EMm5EMDJ5NTU5VHFkZkhvdXVE?=
 =?utf-8?B?M1gvWmRMUjVUNThsRExkWFIxTFMyVkpzZzFIV2pPS29TRjh4ZnRGNzY0eEhn?=
 =?utf-8?B?Q1NHVHpCWDNSaHdvZE5wbEdHZHp6QytlYlRmdmxtTmdJTnd3THdrWlBZTTlu?=
 =?utf-8?B?S3NFajc4Q3RuOUtPdlhCWE44WDhNVVYwTHJtNkVic3FXejNZMFE2NVI1VXVo?=
 =?utf-8?B?RjlxYVdnczNlS2d3cm5xaTEwK205T2JBZldraThrUGx4K0I2OGNyQUk0Uk1B?=
 =?utf-8?B?RU9HK2ZseFFYZUxOSG44V3F5Q01XUXV3dTlvY3UzMjBzTjdRVXBOS1hlWXNF?=
 =?utf-8?B?eHh6bEcwSXF1dXBRVzYwM1ZVNmhtSW5YdnMrNFp3TXN5NFBHeWp1SU9rSWx4?=
 =?utf-8?B?NWVzMWYydVJpa01ZdWpFaTQ5YzFZQ3pWSTM2c2E3U21pOG85a240RGMyNlRt?=
 =?utf-8?B?eE5IZFEyNmJMeFk3d2hpUHh0ZVJxbDZKSUNVcisranBGTHQ5RzF3aW1CcVF4?=
 =?utf-8?B?a3BmZnNici9vUXpyY0RoMHI2ZEo0SktuazJNbEkrZEovb3QrZE9KeExPZmR3?=
 =?utf-8?B?ZnFIcXZIMzZ5VENGUWN5NGw4YkdmNVZUK0pmVTFxMGd3dlZjelZXRnRGdFNG?=
 =?utf-8?B?OGNYRDVCZWwrcjFjL05ybGlyeG12RG1iY1hmamRoVDIvZWFOOFkxOVNQeWZ1?=
 =?utf-8?B?UW01dHlQbWxUVlpUNG1IbjBhMllUVll6R3g5UzNDVFBGRzdRUm0yenpmbktr?=
 =?utf-8?B?SVg5VnZndEUrM1VsSUFRYkhIRkZOdDM0NzlFYm15SlZiT3N0bU51YVVzcEE0?=
 =?utf-8?B?VDN6QVkyUkQrRng2REJJdWZGaXluanIraWluaWhVUVlBeW1ONEg0M1RSNEtO?=
 =?utf-8?B?Y2JaeFJjQUJuK0RPOXNWN1dNWDN6dUwxMVk0a2J5d2NLTkxOZSswYW1NU3ZF?=
 =?utf-8?B?N1l6UjB2M09xQklCWFhRTWN0bVBlVzBBTWZOOU9DZUg1R1QyVk8xN3dkb3ZP?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5tvpR5S4iXUFb/oBJg7GDs10TYRkVxbLH/GvyegqiwaAtXfVCTzeoiN/nOaC+ylyyZ2TA2UMaB2G5jFaDuQ2Qj6VVjtI+vBdc4r0nmM74tVPiuGN647vkUyUY/dlnSsJk/YgZEQTegJMsqc+qQej+9juPiBoiFC+CshRU2sBzuk32qut+6dXykS6cPVvsgZlGJ7r3FmXY3ecbMyLiqQjwK1uSdIpFW/h5zE0hynKOs5X0lA6sf7TDktbsv+lufvykS6J9WURn94xArsSGVJc6OcwyJhRFPrL8+b+K8HxCE4jbNQXFRZCYL7FowjM4YaWeu6Pg64Mba7iO/Gy0K4sYPAyfRqa1QKnrSK1i4MFvLXjIp082rZ16pdw5wtLFHxEGYL0L0lnoCWQ4BLC5MWQbgn4A4DlJUW8HWxgRvb77oj8Z8hf/nhDdbVkmbapbofACIQhCK7uFKP7eQNhFZRY3khLB3p8r5xZPGEc7ol1W1+uzVxz1gNgMHYegxKwDplSj+d9HHhgJQ6bnNUZlAeyOuRJ/uVN6qxWMfADsizP50hwOI1qMoNNEkDOrliz317yFgTV89EuBgL5biSC0Y8hcHIzbAL69M6x+dx+S+qzK2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ba442-7e4e-47c7-b2fa-08dce739bcaf
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 01:37:14.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uk6AkJ40CkP/IcK4elR2tOmJ4m/o7jvfdmkuOJYB3v8i5gEu/7kP8NH4aNNPcJ2zkBpKJhIJiCZ8FU93ypKM3j2Wn42Zj17gmqi/ABuEGO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7489
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080008
X-Proofpoint-GUID: i-YMaJG02LHTuvbzlmWLAhE7TsELpnvN
X-Proofpoint-ORIG-GUID: i-YMaJG02LHTuvbzlmWLAhE7TsELpnvN


On 10/7/24 9:45 AM, Sean Christopherson wrote:
> On Mon, Oct 07, 2024, David Hildenbrand wrote:
>> On 07.10.24 17:58, Dave Hansen wrote:
>>> On 10/7/24 01:44, David Hildenbrand wrote:
>>>> On 02.10.24 19:35, Dave Hansen wrote:
>>>>> We were just chatting about this on David Rientjes's MM alignment call.
>>>> Unfortunately I was not able to attend this time, my body decided it's a
>>>> good idea to stay in bed for a couple of days.
>>>>
>>>>> I thought I'd try to give a little brain
>>>>>
>>>>> Let's start by thinking about KVM and secondary MMUs.  KVM has a primary
>>>>> mm: the QEMU (or whatever) process mm.  The virtualization (EPT/NPT)
>>>>> tables get entries that effectively mirror the primary mm page tables
>>>>> and constitute a secondary MMU.  If the primary page tables change,
>>>>> mmu_notifiers ensure that the changes get reflected into the
>>>>> virtualization tables and also that the virtualization paging structure
>>>>> caches are flushed.
>>>>>
>>>>> msharefs is doing something very similar.  But, in the msharefs case,
>>>>> the secondary MMUs are actually normal CPU MMUs.  The page tables are
>>>>> normal old page tables and the caches are the normal old TLB.  That's
>>>>> what makes it so confusing: we have lots of infrastructure for dealing
>>>>> with that "stuff" (CPU page tables and TLB), but msharefs has
>>>>> short-circuited the infrastructure and it doesn't work any more.
>>>> It's quite different IMHO, to a degree that I believe they are different
>>>> beasts:
>>>>
>>>> Secondary MMUs:
>>>> * "Belongs" to same MM context and the primary MMU (process page tables)
>>> I think you're speaking to the ratio here.  For each secondary MMU, I
>>> think you're saying that there's one and only one mm_struct.  Is that right?
>> Yes, that is my understanding (at least with KVM). It's a secondary MMU
>> derived from exactly one primary MMU (MM context -> page table hierarchy).
> I don't think the ratio is what's important.  I think the important takeaway is
> that the secondary MMU is explicitly tied to the primary MMU that it is tracking.
> This is enforced in code, as the list of mmu_notifiers is stored in mm_struct.
>
> The 1:1 ratio probably holds true today, e.g. for KVM, each VM is associated with
> exactly one mm_struct.  But fundamentally, nothing would prevent a secondary MMU
> that manages a so called software TLB from tracking multiple primary MMUs.
>
> E.g. it wouldn't be all that hard to implement in KVM (a bit crazy, but not hard),
> because KVM's memslots disallow gfn aliases, i.e. each index into KVM's secondary
> MMU would be associated with at most one VMA and thus mm_struct.
>
> Pulling Dave's earlier comment in:
>
>   : But the short of it is that the msharefs host mm represents a "secondary
>   : MMU".  I don't think it is really that special of an MMU other than the
>   : fact that it has an mm_struct.
>
> and David's (so. many. Davids):
>
>   : I better not think about the complexity of seconary MMUs + mshare (e.g.,
>   : KVM with mshare in guest memory): MMU notifiers for all MMs must be
>   : called ...
>
> mshare() is unique because it creates the possibly of chained "secondary" MMUs.
> I.e. the fact that it has an mm_struct makes it *very* special, IMO.

This is definitely a gap with the current mshare implementation. Mapping 
memory

that relies on an mmu notifier in an mshare region will result in the 
notifier callbacks

never being called. On the surface it seems like the mshare mm needs 
notifiers that

go through every mm that has mapped the mshare region and calls its 
notifiers.


>
>>>> * Maintains separate tables/PTEs, in completely separate page table
>>>>     hierarchy
>>> This is the case for KVM and the VMX/SVM MMUs, but it's not generally
>>> true about hardware.  IOMMUs can walk x86 page tables and populate the
>>> IOTLB from the _same_ page table hierarchy as the CPU.
>> Yes, of course.
> Yeah, the recent rework of invalidate_range() => arch_invalidate_secondary_tlbs()
> sums things up nicely:
>
> commit 1af5a8109904b7f00828e7f9f63f5695b42f8215
> Author:     Alistair Popple <apopple@nvidia.com>
> AuthorDate: Tue Jul 25 23:42:07 2023 +1000
> Commit:     Andrew Morton <akpm@linux-foundation.org>
> CommitDate: Fri Aug 18 10:12:41 2023 -0700
>
>      mmu_notifiers: rename invalidate_range notifier
>      
>      There are two main use cases for mmu notifiers.  One is by KVM which uses
>      mmu_notifier_invalidate_range_start()/end() to manage a software TLB.
>      
>      The other is to manage hardware TLBs which need to use the
>      invalidate_range() callback because HW can establish new TLB entries at
>      any time.  Hence using start/end() can lead to memory corruption as these
>      callbacks happen too soon/late during page unmap.
>      
>      mmu notifier users should therefore either use the start()/end() callbacks
>      or the invalidate_range() callbacks.  To make this usage clearer rename
>      the invalidate_range() callback to arch_invalidate_secondary_tlbs() and
>      update documention.

I believe if I implemented an arch_invalidate_secondary_tlbs notifier 
that flushed all

TLBs, that would solve the problem of ensuring TLBs are flushed before 
pages being

unmapped from an mshare region are freed. However, it seems like there 
would be

potentially be a lot more collateral damage from flushing everything 
since the flushes

would happen more often.


