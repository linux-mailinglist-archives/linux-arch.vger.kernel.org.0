Return-Path: <linux-arch+bounces-12834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96008B08C61
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 14:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B4BF7BACAD
	for <lists+linux-arch@lfdr.de>; Thu, 17 Jul 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95929B78D;
	Thu, 17 Jul 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZN5SwdeA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yw+AGhKq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC3429ACC6;
	Thu, 17 Jul 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753518; cv=fail; b=bTJyt83ulIGg5xWfZIKpIA519Lku/BxdXOPVd6OY9Sv3xTs1NmxC8m+sXlHAmzN7MFuWu1QfyrbYN01kxTTsp2l1eQlp96IRBhTJXP+N/Z7SFB4DHgtn3gEdQoewCVKzOxQdyRlwJhOQ2mBk7kSUvfxuh/o1l6k75cTe6Tt+xWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753518; c=relaxed/simple;
	bh=hp42/cb3saGe9NK6yEsjPfz9iUsbHvNA3DbIcxJ2RSw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+w2oSpq+gMbSg6WXrbstoDMvADwk8IGfC5ZLGtig/SPO4FUWCTs5szVCTUE6ydRrT4QY1aUWCwiTcPZ5Sf8gynLABjADvyLGs8oO1yPZyWdh7gxdGv4rqWMqiKfahhXFJAkNl8CgVGXpLbMwEhwO2IFQYXwn5n4LjEP7w3un0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZN5SwdeA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yw+AGhKq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7foh5020685;
	Thu, 17 Jul 2025 11:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vmQOOEhhX0CZTxF0UNHGxAGau++cq8nmFx33lAP+lUc=; b=
	ZN5SwdeA/MXllF4ioGJjcOcEEM/u827v3lAvjN6u9MtbTrHNNvS+KxIiJd14877y
	8fntl6ePVsN72lBUSFqBX5Qc8AaOGgJBaQXUmX+NBDMeiFJ12yYRtAfnA6Su4Zmd
	PlVYDbUzme+nsDycxZrdErH38Gw+aPFWonn4F7yKYI7C3+cTPW/1LJgeXVGq2jvN
	hUKchvXDAsVKmxyR6PgnIDjcQuT3Njdxi0vHpWcRDoWRmGUeJqiwL4bKYd+XBJyh
	mSBhg3tXjlo4Mgxr37fnzh6w3HFVzylBq8sV2d1+07OaMb72Qrke8jPKtLE/t/tk
	uRifQs8yCeU9u8MZH2ZJ6g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujy4tsw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:56:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HA0DeZ013762;
	Thu, 17 Jul 2025 11:56:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5c4be1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 11:56:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghpG27WR+9iZbzUErFfTdV6DS1HpFc7DsnpEPnozeRlsDZq9BKlqTgnOstEeZ07++Ds0PT0Q+pMbSGk4cetnnx44BtXH8AdeGX/RRDPCPeY7WflM8seNGKD4WAmwUEAyJq0WVa/LoRfjvLZJoHN0zKedoa1FEaYOLPYjpXRpvdEiH6WGJtZVCwz44qdz4RlJy2/TDWtActsIvtKQB16e0jiiz7Eydx1ej+OgepLjdrtZ6q+JYvzF/I/RwSx4ToXcZLPrAIQQZDqUT4I/8LRIt6+SuJo69EyRrP3wJKPd8gCx6ziuIMiroAVvV20koeKaqDQ5T107DT22onnX4Azr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmQOOEhhX0CZTxF0UNHGxAGau++cq8nmFx33lAP+lUc=;
 b=eumvEb3uEtU6Kc8bde/blPdyAtmQS89neCZznncfAj30VzpirADwFS6CiNuUc67BTvmt+SDQQJ5g4R0zJSappr+LUy3l9j9BzNnfytlkrt2v+voqsBvL38u0jJWMtqKM8ltvq8BGm9Q8MbRs6r04Zl2pfUH0Gqwfg4g7nglzlimoM4l0URtVL0ZgK5nYNpptK4ScAji+9kT+8HBlNytMt40XE0reQej6reAK2ZEqb0JtR+J2cgK8mEIedoAo5hdmZWDI6i0KpRI0ocgQEKES7Fl/6bRc9+7Ga7XXUN0UDyT2RDEOg2VwcIichXrIqbm9dPVX4USWuBMGDWPjMNTnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmQOOEhhX0CZTxF0UNHGxAGau++cq8nmFx33lAP+lUc=;
 b=yw+AGhKqs+JVMXcyn9phbujhSiF1Thmk+4+fvnjy1m5wOiZdW0/JN471snE7c1tUyMBFSdRJD5DUlFKxx4ZE/frHYBpD7xMa1pIvOdiOgqiynyD6hQnCY92faU7UV5s8guvRRJ+l5tNn6+xOyoFbFJzuEFtuxrGH5OeRN422rwY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DM4PR10MB6720.namprd10.prod.outlook.com (2603:10b6:8:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 11:56:28 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 11:56:27 +0000
Message-ID: <65735554-0420-4af7-881d-5243b83a3eb6@oracle.com>
Date: Thu, 17 Jul 2025 13:56:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Convert atomic_*.txt and memory-barriers.txt to reST
To: Bagas Sanjaya <bagasdotme@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux RCU <rcu@vger.kernel.org>,
        Linux CPU Architectures Development <linux-arch@vger.kernel.org>,
        Linux LKMM <lkmm@lists.linux.dev>, Linux KVM <kvm@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Josh Triplett
 <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        Changyuan Lyu <changyuanl@google.com>,
        Dan Williams <dan.j.williams@intel.com>, Xavier <xavier_qy@163.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Maarten Lankhorst <dev@lankhorst.se>,
        Christian Brauner <brauner@kernel.org>
References: <20250717080617.35577-1-bagasdotme@gmail.com>
 <20250717105554.GA1479557@noisy.programming.kicks-ass.net>
 <aHjd-oisajaKW_Z5@archie.me>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <aHjd-oisajaKW_Z5@archie.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0411.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39b::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DM4PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: d4abb43f-abdd-4966-c7e1-08ddc528f639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1gzWHgrMGdXNWgrckF6U2JyWmhTWFRUK1BEeG5zVjZCWkF6SXh5Ymlnb0hr?=
 =?utf-8?B?M0NjVzA1N2Q2Tk44OUs1MFlBL2hqOExEOEVjRXpIcVlPZHVwWkJ4cmlxeis4?=
 =?utf-8?B?OU04NkVIR2YyZTlCK1g5eGZHalh6b2lOOVZHZUhUQzh2WHRPZEZNWVB2US9M?=
 =?utf-8?B?cXFJWmZ4QTY4OWgvTVhUNk82TXBvbTExc3ZQaEF6eXBzWWZBUElZWk1NSkpZ?=
 =?utf-8?B?QmNJOXFpb1psV09xZUtFZTQ1Y1pZSXZWYTFGOCtySVRXK1JXaW9lSWhNQnpI?=
 =?utf-8?B?QnpzQndGaTJ1T2k1N1FpNDRiNHNFZnMrUUdWODk1UTI1M1JRMW1Wb0dOZHVY?=
 =?utf-8?B?bFJJdDdHZEg4dlY4a1hVTlB2RWdvOU4wVW44MHF5S29NU2tUckw2WndSaDBy?=
 =?utf-8?B?TFU5K0UrNDBIZFpBR1ZsZHZVTDFTSys2dFF5VXpRK2h2L0NQZHhRQTYvNkpF?=
 =?utf-8?B?MVR2a0tBcEtZaUF3QjZXOVpVYUNDZ3RwNnFDSk5tbUx2M09wTzQ4aTVJK0hC?=
 =?utf-8?B?WGhtNFRzQjhoSGtnZTlRejR5Mis4T0J4VkFUb3ZmV1VtSUprT3EwempmcWZT?=
 =?utf-8?B?d1gwNkJkc05QVmtTZ1JaRTBsS0NnNGxCRFhoRUNTQjMyb0VzRFZ1Sk1zd3RU?=
 =?utf-8?B?c0pXZ3JiQTNwS1NUVDU4T1E4NTd3SVNKUXgrQTBpWUJHak9LYW0wWENIanNS?=
 =?utf-8?B?VzRKSzlJalljNSt2SDYyei96Tmw0NG5UOFFmM1BKQnkrZUplVG5hWEpkcHFy?=
 =?utf-8?B?eGJkR0NBNmRMMGR6MFFxblpPTzgwWmRkRnl4SUVzQkZiNllDZDRwcHVBcytW?=
 =?utf-8?B?UDBiVlNJeGEyRVZmbzVTSEhxaTNvNnIrSTNuMWlteVhSelMxenJzKzRCU2tl?=
 =?utf-8?B?bVdoQ3p6cDRlQVloK2NvdjRCK0JpMWdLMmFJTW5XMlh4Zk1aVUs4V3J2MXN3?=
 =?utf-8?B?M0xGR3hZMzJDSGN1U0MyaFgzWHhueitpY2dVVWk3R0svTXdDWGt0SkpmRjkz?=
 =?utf-8?B?WlFwaEYza3kvTXVibVEyWlI4RnJEaHNnNEt6NW9hY0NxVzhZaHRVcXE0UzhO?=
 =?utf-8?B?MFRUVnR1eXB0MnVHVFNSUmdLRDduQXkwdzNUY0xaRnZEa21sc0lLUHRodVFq?=
 =?utf-8?B?bDdweWdHNmpOMjA1eisrc1FPb2VPVDd1V1ZiNHNQaU0zN2RGSDRpTjFuSFhu?=
 =?utf-8?B?MW93YUg1Ris0eDlRUGFLZlZZd1JwUnlJU3hSeXlyRkR3TGl0OUphLzF6VTd1?=
 =?utf-8?B?VUVYY0NjcUxXWHJzazBrL3J2WHZQdjlwS2hjdkFMMkpkQS8zc290azEvMnRw?=
 =?utf-8?B?MmdNMTlqTmtVQ3ZkWHRxYjhVOUFvMUtKTmRYVWhodmw0TzBnLzNNN0ZMU2p4?=
 =?utf-8?B?dmNxWUhBNzRMeXZiY2JtRm15OW93Q2I4eDVUTm5yblF5Z2ZRbmp3bGdVbm9G?=
 =?utf-8?B?NFB0cmpmaEloclZ4aWFMdVlmaU9rbEZicEt4UXJ5Vk5XbjFwRjloelNzZUpS?=
 =?utf-8?B?N3IrUzdlWFRMNmVtSG1tMENMS2RmbUEwRG9wTVZrWXBkeWllVys2RUczNU9s?=
 =?utf-8?B?cEtoRVRtYWxqbXZHT1loZi9LVko5bWVnaE9sczNwMDhIcmFkQW4rc1lsTjd6?=
 =?utf-8?B?TzBvNEtwR1ppRWFmbFQvcEtCckVCWnpyYXlvVjhJMDFPN1hxbTk3dW5BMkV2?=
 =?utf-8?B?T0ZyM0hkSDJHUDc4R2s3TnlVOWJJNm9QSEVXcHNCTXZkME5QVGh0bGpJQm5P?=
 =?utf-8?B?M3ZqamFWcjdndVcvYTVoRHBCRWRhODJhSm85bXhISUJQWWp1VWR4M1J2ek9S?=
 =?utf-8?B?RWhuUS9nb1ltRlVRQTY3WFVBUDkwZ3RZS3VTZ1ZZQ2pxdGg1UC92K25TL1RL?=
 =?utf-8?B?Y1YzZmJpK3psbTgxK1hkUVFpdWgwZEU4VndIcEc5U2FGak9uRWRKZHFhQU43?=
 =?utf-8?Q?lkizwFlc0hM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEM2QTNhalEzaTRXRjBLaXJMbjE4TWNiZUlheWRmeXlzTmtHZCsyZjdJRS9w?=
 =?utf-8?B?TjJSVEc5UUk1LzVzbERUdnFnMnN6YmZzTHV6S0dBZmR6Q3Y5bjlXQnpIK0J3?=
 =?utf-8?B?dDRhMWZ1SVpLamdPcE01eHBlSW0raVhoQzlNeW1FMjMwYW9xK252WmRXNFVC?=
 =?utf-8?B?bWpwc05qMlBtRkRybTRiMTRkTE1CeVNtMmdrOXhJMTBsTnQwR2RnQUhjWHRH?=
 =?utf-8?B?NjFkWENiTy92WHF2RUkzYTIzNEVYeC9oNFhkSld4bVBwSy8wQm04NXAwNGZK?=
 =?utf-8?B?RlJFQzR2SXN2RmxvajI2cWFkSk5SL1JtcmhkRTN0N0wvQnBYSlBnM2Y4YTg2?=
 =?utf-8?B?T0NhdFNBeFRtWTN3TmZ1ZEIrUE1oTkl4WGZVbDBXRUpqZDZTaWtKa2c1VC9Z?=
 =?utf-8?B?RnJuTW93U0xsbnZvN29sT0pNSjRMSEk2eWxlRG1NMDJpbjBhZU5weDc0UzlK?=
 =?utf-8?B?V1BoN0g4NXdQZVBzVGdRY3MzaTVRZGUvYldCeE5janNub3htbG5PdWxPQjVa?=
 =?utf-8?B?TE5VdjJjWkFOQ2ZQUTl3ZVl4L243WjQ3aXF6KzVNUHE5QVlKa0xCc0pBcmxr?=
 =?utf-8?B?MG1uV1FERzNrbmtOSndkRWhlYXBQVm5SWkpoait1c29FSHRmV21LMU9xSTgw?=
 =?utf-8?B?TFVheENTUFFhTStiODJicEkrUTFjLzJBWlhxSXhaTktSY3RJZU16L2hYQTZu?=
 =?utf-8?B?bXFtVkRPNlQyVkFQczhqQTh4bW42TG9nT3VGbkpWeWwyR05NY2RBRVJVVTZ6?=
 =?utf-8?B?b2lzZjgwajVSRFR4aG42ZEJybTVsWFB5WHpZWVZiYmUvcWdKSHlNZlNRSGsz?=
 =?utf-8?B?SzJhOEpmc3NIbTlraDdzZWIrRHhQOGRWVDVMdTRYWjVsbmZ3c1dsMW5pQS8y?=
 =?utf-8?B?SXV1WUpScUFtYkh4WXI5YzNTaVdoall6Rk02a3dFeC9VbG94cGlZK0xyOGVT?=
 =?utf-8?B?YUdaM1dlM0VPRVBjOUg1UldVUG9wRFZ5ZWFOK3NkcWdja2E3TTh6UG1sRHNQ?=
 =?utf-8?B?N1F4V3pjSHVsODRldE9aWUx4cFkxVGx3OWsvYitEejF4Z01kK1Rab3NZYnFJ?=
 =?utf-8?B?OXVoUm12MG9uQXVmekd6U0hOUXpTSmVicFVVQWtPWW1ZR09CTVBTS0FuZTR2?=
 =?utf-8?B?SXY4YjFZN01YK1N1eS9OaGVtekh3ZDVRZVV6RC9CZEMwTHJaV0tQTTIwaUdo?=
 =?utf-8?B?cjU2eGFXL1NobFV4aUI2bjZEc2FRb0dOMGVsT3EvVzJZdUpsdElXMEsxZDlF?=
 =?utf-8?B?L2MrVmdFRDgwTGxEZ0YrTjI1K0lLMjU2NEZYMThSU2JRNkxGbzhRMU1zenRi?=
 =?utf-8?B?SHBHaTFlaDdYc3pERlphWndCdDRhQVZWS3BSZ1c4eUUxMjdjSklwQS80WndC?=
 =?utf-8?B?bkt2QVQzS1daUWUzYzhBUDYyLzNyRU5WOURlYWV4UUlRUCtiN2x5Wjhpcm1x?=
 =?utf-8?B?Z3VoUi9vYmlWMUs3bG5mWHA5TitFNlZFNGtrK0dBZ2k3dnZlTG95OFRyK25P?=
 =?utf-8?B?RE1xVFpFeGpoaCt6TzYzUEVLOWpHSEtEbVFjVzdBUGYxSldISU9HUGFlelBE?=
 =?utf-8?B?eWVrM28rdGN5ZWlwNkdkdGxHR1A4bW9IOVpVNFcvNjR4YU9jZkdFTm5zSkNr?=
 =?utf-8?B?Tm1MOFdBVU1tZ2IxWDE0RkxBWjQycTVGa1g4VmJKL0hZR1pCK2R2dmRVK1Fl?=
 =?utf-8?B?THhOc0ZGVzNVdERNd1hhbHRiUEtRYnRBYlZMQWFXZzNDZXk0aFFJSDNNZC84?=
 =?utf-8?B?V0tOM2VNbTdmTHF0UzZoVE1jUUFidHVORFFUT05EbkdkdlkvSHB5enRCUnly?=
 =?utf-8?B?SUViQ1gyQ242TzVTaUxZeGVORytheUE0c0hhQTJrVTlxNjh3eTc4Vm5uMkd2?=
 =?utf-8?B?WGh2OUxuQ0RpcTVXd1ArWExlUWtRd0ZxaWVrb2EwdlJ6eEIwVXU3TzU2b2hv?=
 =?utf-8?B?SmxvOWxBM0c5RFpmRXFLcUFrZ2tnUEs5cUJiVVJkV3FOZlYvRFQ3VmtTdzds?=
 =?utf-8?B?dURpbVZmTURRV3dCRkhxTXBmZ1J2eENFU201b1I0dkZ6Z3JBWGp1V2s2Vi95?=
 =?utf-8?B?cmhNcThsVkZLNlRBeDYxdE5XWkk3cmJnT3R0WHpmaEIzdXpObG5ac1l3cGRJ?=
 =?utf-8?B?VUtVSDNFRk9lZU16TU5ZODgvUnJWcWhWZnZpemp2SldsZlhuenRZV1hRWVpo?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ZrFGDKRHE7leeZULK482SGDUnJahzxfrsTPkmujIoSsUSsXSG99ld65CxbsVfcOWzSKxeCudmKt9V7NVSBtqq5miodbKIUzezrJucqozKzKXJgpoSgORb6wjn9qnkWE0rg8/ZC9U66iXvMgM4Br5d4PcClzu+N4botyP0TMTp8y+MRVFB2KBjOxmNPVw4tg7vqEcQEPXYaAyPluz9pzcAgqabKWMvNgTkO3LN+ybTYSPhwBYCZvOiq4i+rvH6HQwDuu1b5kfWAiqY5lsM6uvPWxAsp6N75xOflF42Gj+jbh7E2JMh7BBMM5UHQx+lZ/L7oGgDSmtZb9pa3WmmHdXlftoJU0czFQot6pyDv0LvZ9Vr3Gsb59H8VFq8ULbQBOEQkbsyP42nWD24sS3icunJew0HIrIIk028Jn/Rz+nWUCfgVdU2NXNhSjexXG8gZ2VohoARjGZZ+jQG1eWvaH/nBr13hgALlAtNP7RzC1Vkp4MBW5s3ONSHHX0WcKM2/Q/oJJtVPBTl3crTQp78tILNtrNbuUTWaNBhZLa0StzVS60cTuJzD18vxuLFcx2VsOooGnug2zx1LpLHCrazswpFoDZVprb4LBNF7H6YTiUXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4abb43f-abdd-4966-c7e1-08ddc528f639
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:56:27.8895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWbr6xhp8/y4G3IhA9b4140aqap8u1S/YYl8AOACD+sxYcJpdnEls8GMm28mwemoXupLWa3C0td1lE7DQbPoBVdzbHSoikDo7kKVFwqUB94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170104
X-Proofpoint-ORIG-GUID: -hX3HvSHbN5bGzyJYbKYsgFPeDEfmJX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwMyBTYWx0ZWRfXyyG/OeZbEixS CCTPIVM67gdE7LnAZ+f8xmpWp1mni2wWagkpv9kLuGEg2FQcGEtRfy7eMwCTmtm5bo+e8gCapS1 gqtuzJ4w5A3TUmmhMJMlt3voSGInxlwpUtpwsiQGLMEFVzemhYKWDwq3jkWQlDOJO88Z9DktTAR
 V4ugpZ+B561gFtwa2QoAXzZyIt0PgDV4zH4XjibDMn8S5KP405RGJXx+CzJ60kLM2UEIerWgKoK ALERygtj5Aod/IIHw9dJgQvX9DGkM2aAHRT4imtDwyRztNSayxM41XWX6rW/lp54jgoBmUs6/ye +3UYZV7EBCAt3pb5G06oHmkl9pRVfNK9wfpYVGcDArDIhUhsqU9RiuD1vGFrWAZeAFq3h3KhuGF
 EYoORWwujDURADYjgxTKlKArLhJ7znvh1w1/c9DxFms+Bbn+rcMKK7N+Zap2dmhbZH3+v+fi
X-Authority-Analysis: v=2.4 cv=Xtr6OUF9 c=1 sm=1 tr=0 ts=6878e4f0 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=y6bq20kG1_I7wEZIQgAA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12061
X-Proofpoint-GUID: -hX3HvSHbN5bGzyJYbKYsgFPeDEfmJX-

On 17/07/2025 13:26, Bagas Sanjaya wrote:
> On Thu, Jul 17, 2025 at 12:55:54PM +0200, Peter Zijlstra wrote:
>> On Thu, Jul 17, 2025 at 03:06:13PM +0700, Bagas Sanjaya wrote:
>>> Bagas Sanjaya (4):
>>>    Documentation: memory-barriers: Convert to reST format
>>>    Documentation: atomic_bitops: Convert to reST format
>>>    Documentation: atomic_t: Convert to reST format
>>>    Documentation: atomic_bitops, atomic_t, memory-barriers: Link to
>>>      newly-converted docs
>>
>> NAK
>>
>> If these are merged I will no longer touch / update these files.
> 
> Why? Do you mean these docs should be kept as-is (not converted)? Jon wrote
> in e40573a43d163a that the conversion were opposed but AFAIK I can't find
> the rationale on lore.

Here's one:

https://lore.kernel.org/all/20200806064823.GA7292@infradead.org/


Vegard

