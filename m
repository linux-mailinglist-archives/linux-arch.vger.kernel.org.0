Return-Path: <linux-arch+bounces-15414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E927CBDDCE
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 13:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92C830321D0
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD292E7637;
	Mon, 15 Dec 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgW9AhqD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kq6pS1yE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932112E1726;
	Mon, 15 Dec 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802400; cv=fail; b=HV7AZhQpkTLmaos1kRANcIf7Rtc7hhJYsup30jT0283jSaoBw5VFPb4NUmHCOJYrFo9R9L/xAMRpxDID4+lxGn0WpsS+2mABD+OocegcM2TcjBP65uVEmEiCFXpMWgV/Ln62jHOP6sPdHhgLHq1mXUJkFbyhV2aAOLYpRvsHnH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802400; c=relaxed/simple;
	bh=I8LVBXQETnMwVOYj8nHdKi16ygL4N+rmtt8YArgAGJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MzQ1ul1+aBqIhzy1lVOYxxmlUmY+21UjeS5zUPpx13xmL0om9ICeel+pfPQXNJ5KsaCkH9ckg6mG7Sx9+GQER69OgFLwjn/lkum2DksIpZd7u6Ed/ZWciEr9OqmJKnpnz1kIWOuvooFxPfzUO5CJZC5AbqoAo2G5cRKjt4kurbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NgW9AhqD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kq6pS1yE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF9unSx2105944;
	Mon, 15 Dec 2025 12:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TKD27jf41J4ncopmkS
	DMCsFeGCNWD5rJT48YOglCbmU=; b=NgW9AhqD2YITRar5u4/ITxGQ1J/CAshoRl
	h1QtqnX2wJESE9wEzzHM+jdEtyUWNu3UhiPIYAm5zqt6IhlpY6tfE7DzAEMWHvXm
	vVCzoA8G8KmHhwleGAgeGSYT6kKQfFecPwq9MO8hIg3Y/bBi0fHnPg/LvUIMjqJw
	EfFFplopmEydeVtoahpwXmPbQUAZ47gXX748ai3xMLR2ddrNRsDQaYisQL2skwo5
	dm4D7HmKAMNp8/pitX9aAUxbhgAs35ZGgTYWOf8RX+ui78lcoVnptJWAVNcyw1cv
	VJ88VWBf+gl/AWYRWmlLenRBAIWiQqllWBxZkXHeBQ+SwwfzB56Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106c9wp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 12:39:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFBT63x024537;
	Mon, 15 Dec 2025 12:39:37 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk957x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 12:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHUK1UBe63ZC5vUjwe2MjTCOa9WTTS5gmYtiuy3zyH5TqsfjeUuFe+/LRZv+kbdjoPT4V6t7sn3ImC73ZaJnVpJsOWChkgtidk1PyMDgTdUT+8fJPJ8Fzdyf9Je+67HIEfajJIE8s0AcFPwdBMf7wKCJ3YafTTQVma/ic9RD0hvH3agi8dMWkUotPevM/SLz1Ku8LAUmvhGF3AI0zjsgOrpf3x1P1ioPs6t8070UqGdRd6e6GvCPZ120CS4IUFbWBVZnSids/OuNZdc+3TnVQz47x/+1Jj/Yd50A9vGger6aW4bFUWmwO0Ld//HYwsXVQ77OCXmr5aC0OPRpokJeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKD27jf41J4ncopmkSDMCsFeGCNWD5rJT48YOglCbmU=;
 b=f9I6oTW41qBbRGAOVDSnvcJ+uVaqeQlsskg+1pKB2zmjBvgUxxXhASPdln03HdtH6tXgovyG2nH5MYaYgkYscTv4tEslFkapU52jVPFvHzfcux0nC4iOt6KRfIbCj/G8odtodl9lYgJ4CIarl4CM/xvA2RSXWk2aGYBBMo1umV+Pw+li3k7P34UDjAH06oARJDoGcM8sxsDy/7hjrz2HfwhqmWNsda9OJWbqekuslcnpSi95J3wj4tx3w7UNTZw19/7pfqCYYt0klZQ1dKWXeLfVvY/vtqvoBzPDmKkkNUS6JdmTu6Ez4/DPCeZzJKxngBtqnL2zUWk35oHvfQavfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKD27jf41J4ncopmkSDMCsFeGCNWD5rJT48YOglCbmU=;
 b=kq6pS1yEzF5LQw3/jTiJJ8KKd3mkheaC7OzbQxYCLzezykmNFpEpjUClgH+X691uUpqI5NPpoAcTKUfJ1mYf2jcHAUFNbjSSxzLsFbeCnB0rsBBrkqzIykhqU9sjxmyYM4rqXZlS9kHC2u62f1s1Mltx+ux8/mQ3OMtC2RxTvp8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5102.namprd10.prod.outlook.com (2603:10b6:5:38c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:39:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:39:33 +0000
Date: Mon, 15 Dec 2025 12:39:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/tlb/trace: Export the TLB_REMOTE_WRONG_CPU
 enum
Message-ID: <ba711df8-ff67-47ea-a154-32df16fa1c98@lucifer.local>
References: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
 <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5102:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7caccb-a857-4a4f-6b59-08de3bd6ffdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5RjbA3V2Rf+/6t2NN8d6uLXGypd1EPIUF04KexMI/31AvccOMdtTVCS2Q1wR?=
 =?us-ascii?Q?UPRWZFsvDPwdHwD2AqEQ8FFV8F3Om/eWXiyQPl93IM0JZD6JD6OINDDw8FC1?=
 =?us-ascii?Q?Ob9tkbnUiPIREFV79abQlQwuxBva3uaOnSvubxAimtDO+4bMa8K+S+eGDirk?=
 =?us-ascii?Q?lWN25Kvk10ikKVXEXsTLsfk7WIxxrdJmYzeWP2Je4bBpR80iLu22xTrqi2LP?=
 =?us-ascii?Q?HyTqIO8GIFNibq5K9f3jFhZ2EQMcdT1B/TfKrPJT31MvnfRLMOopVfcxF9oM?=
 =?us-ascii?Q?v2XAY3S2oQIhyrDodvXmcREUHAWxRcTtfgS8H++WQO6KBJpCdn7Xgl6b9qhI?=
 =?us-ascii?Q?vMZDZPA/RkwfLr8wD/ykeADXdW3+KMCMqQyvWMuAj2xDg6shafDb/Cn4JbyY?=
 =?us-ascii?Q?cWPn+w+sAOPQzBDA3TmbA8fm2uDL0Fa/YSBqjNUtRexx0XoUCt3Atkau0dcz?=
 =?us-ascii?Q?ggPoJ5gYw/O8Sm62CMGtbH9B4aZbYmudCqY3ff+XkCmXZd1as6CL9Km1cKZZ?=
 =?us-ascii?Q?gYGTCd8eQfWh8i51xhGo7r+uZ32aeEqQNPlv86Uu4L4UbGatGaNCiro4rWvY?=
 =?us-ascii?Q?9t7T0Vs2aiHO/yNn8Hk8pK1cOCVWVJAdXxhEzDMy45PIvCse1wDChuhv48fd?=
 =?us-ascii?Q?wQhFkIrqUZ5WHhT98GHUV5Jx/BG+ih6xW/AueFrRTai9sTwWtJ5DVpiHp02V?=
 =?us-ascii?Q?zI54Dq0NP6qSV72lXhBFuIYq5AG76K0MlzHH42KwoOViVVm3NHcahuWW6h52?=
 =?us-ascii?Q?mUzHahXgC1F2YYwQby0Xda1yeN5ruE7sKk+vIGSqAs70kYtxIhdEbbG/fkGX?=
 =?us-ascii?Q?AH4o4jVSjIfgZco+hxeRm13aitg9X+nrWQc4cFfJu5GKz66EaYYiZ/KmodNT?=
 =?us-ascii?Q?61+9VvZSyc3o4y+NZJJC62ERoW1WZtszguvTXtqQwDNUVJLGJY+rFIfKPteG?=
 =?us-ascii?Q?AtWFmHZsSxpd/+Sw6JoU5N9fvt4kV4K7O8F9Mx7gETdKxSvG5zG6NcFKyBAe?=
 =?us-ascii?Q?9IUQFN2mYmCt4EyuTNJ2M7arVpmuyKmAF+d1VH0fGWcVKR5cNy0+6tBcua1r?=
 =?us-ascii?Q?t3217BtGYCntZEuieT3VUvq6NVWNXZxALMe5knQocl5FQdhHHVW7zbIQ80wl?=
 =?us-ascii?Q?+CM2/s+6/5ZWAGYYLzUljzPTXPNxX4g9oTTyPFHQpo3MJz6h4R/UCQk04vLt?=
 =?us-ascii?Q?GF8ZG6Grvaiu1kwcuNOqR12SLZvZo5sYoHjhwZNE2R2dp6EksD7rl7LK0RaB?=
 =?us-ascii?Q?Kl8/ZFWoGx9SIKHsQTxrGwti/DT3iuPSd4AbqljAn4yLWFN2Y+kOP1Gf8AKR?=
 =?us-ascii?Q?8dMtZcjBtDb4lT/nTF6UkqIf0iZE7iU1QPtJogZXYLaIgicXUZ8rKeN+zaNY?=
 =?us-ascii?Q?r2D7F2aN4u5LrvpiT5FXYRH1xCgNTyTogM2ys6yH/3+oXfYTczSig+s550Cy?=
 =?us-ascii?Q?/ID6fatdAE04rmDVvVSab17UZ93Bgv+C6Zif+LMu3zDGTkPPw8sFpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x2nX7lN5W3neB91dnOr94oOnfLSanjVz+pikMxdbri/6g2iB7OyRd39cWHjJ?=
 =?us-ascii?Q?sqSg7vkafO8KIbt0eKLojglfTqp80FAgPfBK5rtrvupK7PoAqp//S3fIUZBE?=
 =?us-ascii?Q?qFZ1jwuTcjOuCwXoGMeJi2A1XDY2CLiLS1oJ4d/NtVJFH0tfrr8C2OQI3yrR?=
 =?us-ascii?Q?URVIL6Fj+yURjYZqR04LtKHNaKLQb1sB3zxVr/4rrLIRzHcQMm4wEQIasSY5?=
 =?us-ascii?Q?ArYwZjr+4DRwK+k/G4DaMMg9lSpfBDJMh16TXcveJU6NCWg3zIuKuZ5K10md?=
 =?us-ascii?Q?lbBFXLVNi8niveAagIXKtxHjmOqb53D+6HCu6MkpiJF/nxs2fO2CJUaETHGf?=
 =?us-ascii?Q?zn0Q2VgDxfN87Hp/2RQVFl3Y4IUxsedy+ihHSIo7QzvZSaJiH6LRj/u4/ajO?=
 =?us-ascii?Q?qB3PJIduVOVoJHmFBPpO2tY3t0eHNNWEax/8dDDGLOhtOFqLUpqllYlsWA+8?=
 =?us-ascii?Q?UdPeQrpQBodpDOZkIsgH7r3Juc1fpRpP/DYowP+DmJbXmu+n58ttReGB8zkX?=
 =?us-ascii?Q?VA2aY+Vz1rUcKiCAWRHUAA1pEu6CzNsa0Fc4iO7YybkRaseBvL1eTAWxbjGO?=
 =?us-ascii?Q?/UR1dU55LjtBPFFCD6Q7in1Q4ey8yRKKuPsyKOf6Ri/eQ6AraxXW9uOjsAMf?=
 =?us-ascii?Q?5aeu8SR/gxS01ZSCbtKAAorhHerHSom4qdWwSAg75dSrDYD+GV5Ve1BiUf+5?=
 =?us-ascii?Q?TV/YRmD04d2lHnslK5WWMQwtwajFlY/Xuq3VGxphospUZ60KvGvkw4/bVtGC?=
 =?us-ascii?Q?Fdo4wYPAwNh/PENSImYrCp4DNTeFSZAjM4TWkUZjBZIeeMJntoyWqpHT23Rg?=
 =?us-ascii?Q?nnfTskvTbI9pmIRI5GH64dOl/ZTiRy+PrOeK3lE5xzgM5TjH9XGy1BlZVoCd?=
 =?us-ascii?Q?PAvKR4XzcgtWrJKu774SNW2QXX8b9tQHDMXqtnW4++Yt96SSHww0vftA7R25?=
 =?us-ascii?Q?Cp20cRwz9yAC3i1OrGymGySZFR5ruocuQ/wLufrgpYRbRzctvEwFRbKSs9Cj?=
 =?us-ascii?Q?SEWF9zwN160upL9yOav248W+sXaIpOhW5/OqF84fzbuT1YHka0RZX2CZgcZx?=
 =?us-ascii?Q?qZd3qMBH7AXfUth7AeZOIFwodz5pqCoM3WONtNeADErTkvrFo/dsYQyMgJFx?=
 =?us-ascii?Q?RpACJ9KLDLv1fR/NulIYyh8XwFA0kaT7ZMnPCiymiCi/AVe8hDfnuKi8ajv9?=
 =?us-ascii?Q?mRggas1fh/YJvjfAOHinEcwpNRIOJ3pooz/2buuUDfpcL4t8KVFWc6PjUHHQ?=
 =?us-ascii?Q?AIS6741ApBma9wtFeyRVwFS8VYNgvquKujXDO/X1Mx07vNC4ryLkFCGelfSp?=
 =?us-ascii?Q?O2G21uHsynYuv+wjm9jDaOz2LMfwAFKULz+JTNh9lqu84jZP4Rg4meTlzo8F?=
 =?us-ascii?Q?+RGxIgNsWHg/tUNZ6MnQU1ltZVQsBKSNLgJ5JQqfdZApieRfkVhPPyZEjh0L?=
 =?us-ascii?Q?0TkTMxzuVUPIcJIf7vQwiYdDawRL9KdrY1xm0H19lh97J/SOp5/GBXNLv0K3?=
 =?us-ascii?Q?Pb+Iz4rz4j3EoTRmPtF8nHes8/duNCXUQ34gEPiHTahL/xJP2FJy+2V7nqAQ?=
 =?us-ascii?Q?SnctRbkYNM0gbAX8Yqo3cKoCiEXVdj2WGNKubMRSY3Ej16hVTBCu47IIghEe?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OLxX8K8mHXTSYNPTVPAOjmchYV07sQzcxszXW1vs2RrDl6Bgs4n4Z4A+o/A2B60rMunR2NYnl1LrjdEtKGHTjifYiauGExUhKx0N/bw/rs3MrW8hQdHi85nOVtzooSfXpNz8/zc2WIwPSAtAjFiBhJp5uF21gTsvsRVdfUfy7v4tDn8Sizvg6eMCzdrCsotTPbsDPJW0kOqPOAw6eJnyQQWg9v0dA5cRAgfe07hVkDmsdFi0/YeXKNuWF7930Qc+K6/yIGT5vithA0ZYZbQKCFRS8HeKHNL8Dws4ggNSlkav0YWGWTDPKQLZOkKAcYOFLm4YmW/ni8S1YCJi+sJ53j9Pm2V3McGM8c5S3MA7lzb0xIfUmutQwWeJU7vfa9GaKHHR92HcmRr4ip6/bmrYQQuyEuHR/uKnjK/rHj49Xx7E0GvBmgWRIFbwQUFxx2+piFTr6CmqBhmlspq2P/ODEHdFdZaW4oDe/wk2/25Zs3wVOUlTsUlTOlBzKlttl0deDxZD9VVl+nKWM1hj7qj2cEs14acYgFJ2WDh4iZ4FkNwuH5btC43cCf5EDUFygqLaPRs8iPCafNF+twx3M0sY8UWQUX97w5lmeIMD5vteIJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7caccb-a857-4a4f-6b59-08de3bd6ffdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:39:33.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZmYS7JOM7U9d1g4YLEgQoQ4xVE0bdWO5J0A9Ds3inQiax8Qn0Kjj2MMchN8wPQBPRYR+OXmQCqfeQe11rMcukMsidmPmX8vjGLhmBMcx0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_02,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150109
X-Proofpoint-ORIG-GUID: bR4Pedu_612uNqQf4xfGRKUZZhhgU6cg
X-Proofpoint-GUID: bR4Pedu_612uNqQf4xfGRKUZZhhgU6cg
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=6940018a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=fwyzoN0nAAAA:8
 a=yPCof4ZbAAAA:8 a=uH9q6I_UeC1O0RwEo7EA:9 a=CjuIK1q_8ugA:10
 a=2JgSa4NbpEOStq-L5dxp:22 a=Sc3RvPAMVtkGz6dGeUiH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEwOSBTYWx0ZWRfX3MH0ZLGfD8vu
 53g7SM9I01jnT4C9/kFcWTjCA01QIEYazci4KcEFDJUB+qTk54xnVKwoQYDAjjr+viKh33SEABw
 5Yrvb/HJ4DJvWu8gmMTpu+cWtrKphjVXUr4Kdwx7msggfADx94JkqdWA5nP70OB/i19oGvSzkYs
 CLdK3vyCG/2x0KEATnK4v9DQfZeQ6uOQ8TZkHytJdy9S3WMLyjx142n9xx4aKo6jRwF5kTgOFlz
 aezMlKRVNsMmxENMG25S3waW6LQV6///+nT2ZOM5qsOLh6WYXgo0aDYZPwZKi5kP9dudFp56a7N
 NO1cvZMIm1BE47Cq2Dagr8zWPke7c2EtKynY9AuwwWHTCf9reVq5j32e/ks4jf7inp+gERLD7Nk
 APTO8BJoIGNRrpHGJ6Bkq0mV+wvNXw==

On Fri, Dec 12, 2025 at 04:08:07AM -0500, Tal Zussman wrote:
> When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
> tracepoint, the enum was not exported to userspace. Add it to the
> appropriate macro definition to enable parsing by userspace tools, as
> per [0].
>
> [0] Link: https://lore.kernel.org/all/20150403013802.220157513@goodmis.org
>
> Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU")
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/trace/events/tlb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
> index b4d8e7dc38f8..725a75720a23 100644
> --- a/include/trace/events/tlb.h
> +++ b/include/trace/events/tlb.h
> @@ -13,7 +13,8 @@
>  	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
>  	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
>  	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
> -	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
> +	EM(  TLB_REMOTE_SEND_IPI,	"remote ipi send" )		\
> +	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )
>
>  /*
>   * First define the enums in TLB_FLUSH_REASON to be exported to userspace
>
> --
> 2.39.5
>

