Return-Path: <linux-arch+bounces-13499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE51AB5380A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69304AA5BDC
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EE350833;
	Thu, 11 Sep 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HR5jd+5Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEB352FF9;
	Thu, 11 Sep 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605320; cv=fail; b=bm69ErLg501er7csfDeYazDcKl+5vT62L+uLeK0ofsf+SG7o9UJMRmj+OQqtN/0ROzg40VJUZGP3Nl7JPFpc1tCUL2mvU8Gv8Yxr5DVSKjNPl3usO5PFXDSAzje05WBWXZPYMFwgsVuqzko/dGNs6n2b4HfVTtKjpGh2ouULLes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605320; c=relaxed/simple;
	bh=B8U6X0jUncKiG6luQLjiCpV3o+XZg/027xwKVvcQPQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKfUB1I5JiewtwLYR0D7LwU8eMCxS2rOmYlcvzjNLloyfojVSUobTgQTqOra3nHbEM2Sx9MAn8zhoAPdVO9E54Kb3N95KeGaqALYzKERqrJ/4kyN5UAtLSdfJ9SdQlfukm262ar9HJQM8OMx70PcvNwmMfYrxwZvntF6r3J1tOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HR5jd+5Z; arc=fail smtp.client-ip=40.107.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReSC2pkeBXgNx4MPGMY7QkwBEj84eaWU1zHTnFEfXr7zqFshZWXjE+/2CIQYUNRnaE4qA+xZMJTbNx6oyJcK2SlYlZsPlMwd1m55o1+o6vOLSQyhspvNCOyiJY6QM7HTXJXQGmAt57d2WhCjs3jXXO20sga0EyNzPY08PRU9rYaMU3NgOi/55OPj+FS44Mzev+JFmCF6g0GNNyN5C5kqolrTzM7fI9Esmh34OuHWmfzZOFwtDVNSRXm7r1p5tMuHi7VPExkyWjTE4hE2BwlctvxMTauU7/ZAYru23KYPk8ZESY/CXaJOP6FpdRrmD/1Ax1TVubLjAh9rJPM64apaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTxQjfVHo8vOZJftDKUGIqKaTyBBlGjBepJoy3fjii0=;
 b=f77457CguHISqQ1iRluuU5JIJG9wSWneFpF9jd/EEAEO1rM8ibJU4wjBoVzjw17UmmtiNrxbYXHXnF8nBZlkILu1Y5jWUog8tnq/uTJiQyJwaHdVZpadSQd/oGo97iSx7IUyVvdFs9hMgd+3iL80pF2XHToq71OD7NXcmJvEDHkx9IOdck0VNRexPVpGtgxaj6l2RAUz78NCsp5ezA4QqIQ1C5d+0Y3coorAXRQ/2fGTXon5VH3mixHwDNgI9d6e8lOLVWJCsbzvtMssgk6Epdeu0f0nIkyR0QGZMs721zBw0UGE180z6GQYcN+XuW+nmj6feuPq4BR5zGKshV0G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTxQjfVHo8vOZJftDKUGIqKaTyBBlGjBepJoy3fjii0=;
 b=HR5jd+5ZV9lwCenFSzVwiP7NyOvXzL7UbfPht4Qm4npSSLYgsEtc91RzuYA0eJmiCe8xkOXFc6VTjVykU3zTfJ3xNfWWh4cA3YLO9OMaDDGGsB0L0cUdt0D1kY3TCQHY8oRtlS9xy4+LO3hHHYLUmvhuzsqGpecdwe9cMOHRgzdcHBk4702csdP8vvPI289YTPW032j7U7ANQZnkwJ+5K7aWty2fKk4HHU5evAwkufF77IFTxYiAFHLlS5Z7jJ79r0j1rC+Ro9moijVfkPJofhkLR0a3flWJfa8w6h7BxVqG8eMWlE+Rnp1Gu9hfoObUTwG1c20Qlo4b9Ky17UCNNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9947.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:41:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:41:54 +0000
Message-ID: <2ce887bd-f0f1-46bd-a56e-7e35d60880dc@efficios.com>
Date: Thu, 11 Sep 2025 11:41:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908225752.679815003@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::36) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9538e4-0890-4cda-2092-08ddf149bbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjJHeFh3cHJ4Zk10WHZ4Qy8xZTBEREpRTGxPaTZSb1VGanJ6c2pOWWxaMFVM?=
 =?utf-8?B?dXc3VzZXVmJrMkZmSWJ4dWYrSm51WTVCRnZuZnV4d2RWUnBpSHdwU0wwVFB1?=
 =?utf-8?B?UFdDK1lIYVpDeENvSGZnV1BMcGhPT2pUdGJUd2hnTEYzTmYzcVg5RGF0N3Nu?=
 =?utf-8?B?UXpycWRBTnFCUXd4aVNnZkJuTUZXOE9oSXNUdFVzNXUrVWtzS1JWSVFEQlZN?=
 =?utf-8?B?L1JhbDFjbzFvSEV4ZGVQWUhsNnFtaFlSK0ZKWjB2NjhxOGo1QnRORlY2OEZM?=
 =?utf-8?B?d3hSUjR3NG9ydkgrM0xTL3JXT3Q3Z2MrRDNSV1NZbmw4cjJFS1dOMXp6b2ZF?=
 =?utf-8?B?TThwdW4xaHZ6QUhIK00yMENWWEZXOHh6MHVsZ1lpSllWU1ZHMnUrbkFaR1o4?=
 =?utf-8?B?dVEyL2svc0NVeVJraWhOT0tkN2d3Slk3bnZBMncyVjFxTlhFMkRBNnE5VnVx?=
 =?utf-8?B?WG5RVHpIWkc5RUVNWTNPd1RWKzRLTys3c1JWU2ZvdFpIcVJWdjFEa0ZlcmFD?=
 =?utf-8?B?b1crTVlXYlQxcnpTcnJuVmh3REJ0dDNkdEpYWm8yaGtZMCtxczd1SWExZVhT?=
 =?utf-8?B?TEtLbTlGMzdUYng3Y21QNmExcXhwT0xOT3FidHZjZy92RmQvbUJUUDlyeE43?=
 =?utf-8?B?blNucHRlNTJTL2NvZTdtN21DUWUzVFU2K0loSGZDd1FOTjV5R0lpb0Jjbk1H?=
 =?utf-8?B?M2RtYm1wLzdId3dYTXBwTHdUd2VING9rK1lhdGVZN3I5bFVOMlFpb1UvdlhR?=
 =?utf-8?B?QW9uSmdkZkhTdEV6TDlpclU0eFpYR0dTRXNtVkVpM0Nsb1ZIRVZvZ2ZWT1hS?=
 =?utf-8?B?MU9obGFVaG94L1VPTUs3NjNNZXFJQ0pick1BWEdVYVk5emtaVnRqdERWY3NI?=
 =?utf-8?B?dFZGRlh4ME0xY2p6YVFYWUJMLytRZEcvVis2SVhWMGRvU1pBVXNSZUVQU05r?=
 =?utf-8?B?d0RPYys2bENyd3VtNVZTcmg1SWVnaVUya3ZZK2daQmx2bGdTU3U3eXhWdk5F?=
 =?utf-8?B?NnhIRTBUS3Nka3hraHBWaVFmNWZIa3BkZXVGMHppNk81WlNiT3Y0dkIxRXRY?=
 =?utf-8?B?QTFPai9IUXgvTko4ejhNUThudkZVZTc3SjJka25uMEVwSjJvVytQSitSYmZy?=
 =?utf-8?B?VTN0ZVozMUdVZDZmY0Yrbk1XYXZXdnArekdVbXI1cUtjM0Vyb2J0UlJFQmdw?=
 =?utf-8?B?REQ4RlZyVWlEMmV2K0Z1eG14VTF3NVZvb3Mxa0lOa0Y2U2VHc1lQTFRQVTBx?=
 =?utf-8?B?T2xYdjk5STY4a0lwRGdSRlU0cXE3WHBNM3RoODJCaWFRL1dyeUNOWFR6emVV?=
 =?utf-8?B?dkhsR3psRWxPVG51QlpCMjd2eWRwaXdvbUwwbVh0cHVTT0VqSEdCL0I5a0Ji?=
 =?utf-8?B?TkY0ZHVORW5Za0c0QkdycFVrbGplekZpdlZteEZpOEJJd3lGNksyQ2thdjhr?=
 =?utf-8?B?WEN2V1h2eTkwa3ZHNmk3ZFZNUVN5d3ZtOUJuK01zcWNxZU5lWHpzOHFEd1g4?=
 =?utf-8?B?cWxTdEVqd1hHaXFsZ3Nha2J1Rk1nVWNwRmZ0T2l2SGpBOHFKRHJxVmJzSGJx?=
 =?utf-8?B?aTZ5NjlyYTV6WkFFY1lQa2JsUE5MMVMybDJZR2J2MTZDdWJPTW9IOWdBbjJx?=
 =?utf-8?B?S3dSMm9OTEVUaUlyNFlqNXFxek5FWk02UDk1bEtmKzlNdVRQS2Mwd2c3d21T?=
 =?utf-8?B?Qy90SExXcHQwL3BOUGxwUldJT3ZMWkJ1b2lyaTZBVFNtTnJpZWxZVlhia1lF?=
 =?utf-8?B?elJKLzYzRDZKVFhaRXBMUThhelhreElFUSt2WmJxZkxRVHVKVXQxL09LZlhz?=
 =?utf-8?Q?C7GSc+hyV0davK6m0XpmJFYtz0DEaJ4HFNJLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXZiY0dmTDlWbmoreHFyNDVJNHpac1JKVDFoS0lJRm5NekN0UURMMEtLcWw3?=
 =?utf-8?B?RWZtVDN1MkZqRkp6UU5vU2xtWVhJbVBmWDFqbUwvK09mL3FJalJCQzNqaHox?=
 =?utf-8?B?TUNVWlBRQytGQ1Fvem9qS2RqT3BDYXpidWJDbDR0cXBJeEF4dmoyV2pnVlNu?=
 =?utf-8?B?QkdNa09ncnNHWnloeUFlQUowbmJtUFpmeHNwYjdGZk9lR3NqZDh5bU92QVUy?=
 =?utf-8?B?SmRtMWEzQlM3dm5BN1hZRmRmK05BNk96bElzcytKQThMZy9iQmZQdlFuTDNt?=
 =?utf-8?B?eG82aUdpMnQrcDJ4d0w3R01WVHVzVDhTVTdWZTVuN0xtUjREbTlNWjYyVmNK?=
 =?utf-8?B?akxNOERxTzAxTWJnOUdnMnM0R0FKMXNzNzg3UkhzNzE4QUc3bmVOZVVPeGl6?=
 =?utf-8?B?U0gvNlMxdnpzMjFQcy9qNjRjcVRHbmZvdmc1LzJLN2Y5YUFUclhDTXVMUG9a?=
 =?utf-8?B?aXZwMGlrczZsS2tQVlFMcU9vcTkvWmZCc081a2xjMjJ6SUFuSk9Ka1dHZ1lQ?=
 =?utf-8?B?aXEwa0FQRW5TUlkyR0k2TzFuN1BEaDc4c25kODFxSURHT2dsckdYeE5aYi9m?=
 =?utf-8?B?VWhEbGY4dVBmUXBzc0dUaUlhSVhYNHdvRVMvY0hBQjcxWWY1MEMyMDFiMDVm?=
 =?utf-8?B?SVlkSjNKUCtwOExVNVZpSUFsWFlWU25VcXRIR2NlK083T2dad0Y5V3RyZHFh?=
 =?utf-8?B?SklZR21CUGt5Z2JvNkRYUHUrT0srZGVoU1IzT2ZVNkJEWExiTmxaOTE4K0cx?=
 =?utf-8?B?OE1ZMGtIdnI3NDl5eERraTNISkdreTdaQlpMd3RRc2prbUtOcnAxcnRIdThr?=
 =?utf-8?B?SU1WczMxZVcvaE5tK0RWZFlGSnFXS05rNzFOSThVZHlBY29lMXlWYkw1RXlh?=
 =?utf-8?B?dVdUZFhIMGlwNzIvSUFJQWxrRE9JN0F1Qy9hNnROUHJ0bWN3R1lQbHh2NXhn?=
 =?utf-8?B?blM4dFpsbzNueFByUHpicVUvcnRKZHllamRWWXlNbG1sY3paekIxMVZJdVBp?=
 =?utf-8?B?SkFFbFNEQi9HandSM0VjN1NVNXdjVFlPNlVhY3d3QU8vdFU3VXQ1cnR3UFRn?=
 =?utf-8?B?TEI4QmVXSTk2U3UxdHhXQ01hQXBkdHZtcDFnYlBZUHFDRlJ5eFc1TG9HbG5Y?=
 =?utf-8?B?ZUxOZmVMZ0hSMTRtYm02Z0NHS0kzVm9naVEzZ2dYQzhQaHZ4aHVySGRGRWNy?=
 =?utf-8?B?RmhPNVUrdVovSUFjWjE5V01Fb1lOQmk0VVJyQ0pkUFBuc0pSWUtOaWpoVi8z?=
 =?utf-8?B?V0dLZjNsaXZtcVk3WHBLMzhKdVRCN0dsU3lGR1ZqVkprZFhUVHNpdmFMUExz?=
 =?utf-8?B?ZnhWY2NwcDk5OVppOVgyQk1MbXE5V0xoMDJlb1NtMWxjZzFmQkhDemorNWw5?=
 =?utf-8?B?ZEw4STA4b3R2U05nN0tIeTRqM3ZNSVM5WlBVY0NGbFlHVVlPOGVvZHZDQ1BU?=
 =?utf-8?B?ZCt2YmpQRGpnSHhhNG41bkpFajNiMjhiN2FQSFlzeHhzYzlycTIrQzVSTzAw?=
 =?utf-8?B?dUZxNG9QS3pveVExMEp2QXp2QU9xanh3aEFxTTFJV2pheWQ4ZEw4OUNXUUtR?=
 =?utf-8?B?K3BQK0ZnV1djc2tvSi95VkJKSmMvQ09Kd2xsWGRRdHJxZkZQZFBTMzY0dTF3?=
 =?utf-8?B?Sks3VGhKV0h1M2FEU2JsRUU4OXg1UUVtK1FLd0YrTjE0TXlPTGRnM2gwUlZu?=
 =?utf-8?B?ZUw1a0RycUxWNGkzVjg1NXEwMm01cjNZb2NBWUYzT0VidkFZMVl2b3VEa09G?=
 =?utf-8?B?OHBWMU10Q3FtVXJ0Yzd6czJvYWJJZE1LT1kyQ210OHpZZFRsdklCOXlESUN5?=
 =?utf-8?B?U3ZEbkxKTEt3QnZ5RnNJZzk1ZmVqZXVqSVJUaVd3MEIwL3p3TGRhM3lGMDVt?=
 =?utf-8?B?Wnl5WFZ6ZzFPU1lGZlpRVjNKVUJVd2xXL1pyREhLaTZqcWlxNzg4OC9yK2RY?=
 =?utf-8?B?NnZOSHBGK2RXU1dzWndvakE2ZTdYUzVDTXZnQTlpd0dzekkwTGkzTTVDOTYx?=
 =?utf-8?B?Sm9ZcEs2ZXR4NkgrWHJvd3BpRDVTeE1TODhMZzlwTTVzNUZabFdMQ1RSTWhU?=
 =?utf-8?B?RnJRWFRmSXdSZC85d2tTa1FxUkIxN1VDNUU5eExtQVYzbnhSZ2ZSelYxTEVW?=
 =?utf-8?B?bFA3QTdnWUZ2djM5c01DWjkzdXYvb1RzdHErdFpkRFdEWnJkSTNDb2ExYzVJ?=
 =?utf-8?Q?OPBoIm2YGTTze7RsoKdwOhM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9538e4-0890-4cda-2092-08ddf149bbe5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:41:54.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijqHO1g6GHLJ3MIusL2gFrjMpsvnTfAEqrcgVPUAnmxYphXWamAv8IyggZncFOg3BZdG/JOqKCeWTKI0DvpVbqmMN5+DLS7ygCN9YDlT0yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9947

On 2025-09-08 18:59, Thomas Gleixner wrote:
> Aside of a Kconfig knob add the following items:
> 
>     - Two flag bits for the rseq user space ABI, which allow user space to
>       query the availability and enablement without a syscall.
> 
>     - A new member to the user space ABI struct rseq, which is going to be
>       used to communicate request and grant between kernel and user space.
> 
>     - A rseq state struct to hold the kernel state of this
> 
>     - Documentation of the new mechanism
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Prakash Sangappa <prakash.sangappa@oracle.com>
> Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   Documentation/userspace-api/index.rst |    1
>   Documentation/userspace-api/rseq.rst  |  129 ++++++++++++++++++++++++++++++++++
>   include/linux/rseq_types.h            |   26 ++++++
>   include/uapi/linux/rseq.h             |   28 +++++++
>   init/Kconfig                          |   12 +++
>   kernel/rseq.c                         |    8 ++
>   6 files changed, 204 insertions(+)
> 
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -21,6 +21,7 @@ System calls
>      ebpf/index
>      ioctl/index
>      mseal
> +   rseq
>   
>   Security-related interfaces
>   ===========================
> --- /dev/null
> +++ b/Documentation/userspace-api/rseq.rst
> @@ -0,0 +1,129 @@
> +=====================
> +Restartable Sequences
> +=====================
> +
> +Restartable Sequences allow to register a per thread userspace memory area
> +to be used as an ABI between kernel and user-space for three purposes:
> +
> + * user-space restartable sequences
> +
> + * quick access to read the current CPU number, node ID from user-space

Also reading the "concurrency ID" (mm_cid).

> +
> + * scheduler time slice extensions
> +
> +Restartable sequences (per-cpu atomics)
> +---------------------------------------
> +
> +Restartables sequences allow user-space to perform update operations on
> +per-cpu data without requiring heavy-weight atomic operations. The actual
> +ABI is unfortunately only available in the code and selftests.

Note that I've done a man page available here:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/man/rseq.2

which describes the ABI.

> +
> +Quick access to CPU number, node ID
> +-----------------------------------
> +
> +Allows to implement per CPU data efficiently. Documentation is in code and
> +selftests. :(

At what level should we document this here ? Would it be OK to show examples
that rely on librseq helpers ?

> +
> +Scheduler time slice extensions
> +-------------------------------
> +

Note: I suspect we'll also want to add this section to the rseq(2) man page.

> +This allows a thread to request a time slice extension when it enters a
> +critical section to avoid contention on a resource when the thread is
> +scheduled out inside of the critical section.
> +
> +The prerequisites for this functionality are:
> +
> +    * Enabled in Kconfig
> +
> +    * Enabled at boot time (default is enabled)
> +
> +    * A rseq user space pointer has been registered for the thread
> +
> +The thread has to enable the functionality via prctl(2)::
> +
> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
> +
> +prctl() returns 0 on success and otherwise with the following error codes:
> +
> +========= ==============================================================
> +Errorcode Meaning
> +========= ==============================================================
> +EINVAL	  Functionality not available or invalid function arguments.
> +          Note: arg4 and arg5 must be zero
> +ENOTSUPP  Functionality was disabled on the kernel command line
> +ENXIO	  Available, but no rseq user struct registered
> +========= ==============================================================
> +
> +The state can be also queried via prctl(2)::
> +
> +  prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_GET, 0, 0, 0);
> +
> +prctl() returns ``PR_RSEQ_SLICE_EXT_ENABLE`` when it is enabled or 0 if
> +disabled. Otherwise it returns with the following error codes:
> +
> +========= ==============================================================
> +Errorcode Meaning
> +========= ==============================================================
> +EINVAL	  Functionality not available or invalid function arguments.
> +          Note: arg3 and arg4 and arg5 must be zero
> +========= ==============================================================
> +
> +The availability and status is also exposed via the rseq ABI struct flags
> +field via the ``RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT`` and the
> +``RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT``. These bits are read only for user
> +space and only for informational purposes.

Do those flags have a meaning within the struct rseq_cs @flags field as
well, or just within the struct rseq flags field ?

> +
> +If the mechanism was enabled via prctl(), the thread can request a time
> +slice extension by setting the ``RSEQ_SLICE_EXT_REQUEST_BIT`` in the struct
> +rseq slice_ctrl field. If the thread is interrupted and the interrupt
> +results in a reschedule request in the kernel, then the kernel can grant a
> +time slice extension and return to user space instead of scheduling
> +out.
> +
> +The kernel indicates the grant by clearing ``RSEQ_SLICE_EXT_REQUEST_BIT``
> +and setting ``RSEQ_SLICE_EXT_GRANTED_BIT`` in the rseq::slice_ctrl
> +field. If there is a reschedule of the thread after granting the extension,
> +the kernel clears the granted bit to indicate that to user space.
> +
> +If the request bit is still set when the leaving the critical section, user
> +space can clear it and continue.
> +
> +If the granted bit is set, then user space has to invoke rseq_slice_yield()
> +when leaving the critical section to relinquish the CPU. The kernel
> +enforces this by arming a timer to prevent misbehaving user space from
> +abusing this mechanism.
> +
> +If both the request bit and the granted bit are false when leaving the
> +critical section, then this indicates that a grant was revoked and no
> +further action is required by user space.
> +
> +The required code flow is as follows::
> +
> +    rseq->slice_ctrl = REQUEST;
> +    critical_section();
> +    if (!local_test_and_clear_bit(REQUEST, &rseq->slice_ctrl)) {
> +        if (rseq->slice_ctrl & GRANTED)
> +                rseq_slice_yield();
> +    }
> +
> +local_test_and_clear_bit() has to be local CPU atomic to prevent the
> +obvious RMW race versus an interrupt. On X86 this can be achieved with BTRL
> +without LOCK prefix. On architectures, which do not provide lightweight CPU
> +local atomics this needs to be implemented with regular atomic operations.
> +
> +Setting REQUEST has no atomicity requirements as there is no concurrency
> +vs. the GRANTED bit.
> +
> +Checking the GRANTED has no atomicity requirements as there is obviously a
> +race which cannot be avoided at all::
> +
> +    if (rseq->slice_ctrl & GRANTED)
> +      -> Interrupt results in schedule and grant revocation
> +        rseq_slice_yield();
> +
> +So there is no point in pretending that this might be solved by an atomic
> +operation.

See my cover letter comments about the algorithm above.

Thanks,

Mathieu

> +
> +The kernel enforces flag consistency and terminates the thread with SIGSEGV
> +if it detects a violation.
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -71,12 +71,35 @@ struct rseq_ids {
>   };
>   
>   /**
> + * union rseq_slice_state - Status information for rseq time slice extension
> + * @state:	Compound to access the overall state
> + * @enabled:	Time slice extension is enabled for the task
> + * @granted:	Time slice extension was granted to the task
> + */
> +union rseq_slice_state {
> +	u16			state;
> +	struct {
> +		u8		enabled;
> +		u8		granted;
> +	};
> +};
> +
> +/**
> + * struct rseq_slice - Status information for rseq time slice extension
> + * @state:	Time slice extension state
> + */
> +struct rseq_slice {
> +	union rseq_slice_state	state;
> +};
> +
> +/**
>    * struct rseq_data - Storage for all rseq related data
>    * @usrptr:	Pointer to the registered user space RSEQ memory
>    * @len:	Length of the RSEQ region
>    * @sig:	Signature of critial section abort IPs
>    * @event:	Storage for event management
>    * @ids:	Storage for cached CPU ID and MM CID
> + * @slice:	Storage for time slice extension data
>    */
>   struct rseq_data {
>   	struct rseq __user		*usrptr;
> @@ -84,6 +107,9 @@ struct rseq_data {
>   	u32				sig;
>   	struct rseq_event		event;
>   	struct rseq_ids			ids;
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +	struct rseq_slice		slice;
> +#endif
>   };
>   
>   #else /* CONFIG_RSEQ */
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -23,9 +23,15 @@ enum rseq_flags {
>   };
>   
>   enum rseq_cs_flags_bit {
> +	/* Historical and unsupported bits */
>   	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
>   	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
>   	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
> +	/* (3) Intentional gap to put new bits into a seperate byte */
> +
> +	/* User read only feature flags */
> +	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT	= 4,
> +	RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT	= 5,
>   };
>   
>   enum rseq_cs_flags {
> @@ -35,6 +41,22 @@ enum rseq_cs_flags {
>   		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
>   	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
>   		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> +
> +	RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE	=
> +		(1U << RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT),
> +	RSEQ_CS_FLAG_SLICE_EXT_ENABLED		=
> +		(1U << RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT),
> +};
> +
> +enum rseq_slice_bits {
> +	/* Time slice extension ABI bits */
> +	RSEQ_SLICE_EXT_REQUEST_BIT		= 0,
> +	RSEQ_SLICE_EXT_GRANTED_BIT		= 1,
> +};
> +
> +enum rseq_slice_masks {
> +	RSEQ_SLICE_EXT_REQUEST	= (1U << RSEQ_SLICE_EXT_REQUEST_BIT),
> +	RSEQ_SLICE_EXT_GRANTED	= (1U << RSEQ_SLICE_EXT_GRANTED_BIT),
>   };
>   
>   /*
> @@ -142,6 +164,12 @@ struct rseq {
>   	__u32 mm_cid;
>   
>   	/*
> +	 * Time slice extension control word. CPU local atomic updates from
> +	 * kernel and user space.
> +	 */
> +	__u32 slice_ctrl;
> +
> +	/*
>   	 * Flexible array member at end of structure, after last feature field.
>   	 */
>   	char end[];
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1908,6 +1908,18 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>   
>   	  If unsure, say N.
>   
> +config RSEQ_SLICE_EXTENSION
> +	bool "Enable rseq based time slice extension mechanism"
> +	depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
> +	help
> +          Allows userspace to request a limited time slice extension when
> +	  returning from an interrupt to user space via the RSEQ shared
> +	  data ABI. If granted, that allows to complete a critical section,
> +	  so that other threads are not stuck on a conflicted resource,
> +	  while the task is scheduled out.
> +
> +	  If unsure, say N.
> +
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -387,6 +387,8 @@ static bool rseq_reset_ids(void)
>    */
>   SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags, u32, sig)
>   {
> +	u32 rseqfl = 0;
> +
>   	if (flags & RSEQ_FLAG_UNREGISTER) {
>   		if (flags & ~RSEQ_FLAG_UNREGISTER)
>   			return -EINVAL;
> @@ -448,6 +450,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	if (put_user_masked_u64(0UL, &rseq->rseq_cs))
>   		return -EFAULT;
>   
> +	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
> +		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> +
> +	if (put_user_masked_u32(rseqfl, &rseq->flags))
> +		return -EFAULT;
> +
>   	/*
>   	 * Activate the registration by setting the rseq area address, length
>   	 * and signature in the task struct.
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

