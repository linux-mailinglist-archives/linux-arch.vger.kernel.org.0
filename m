Return-Path: <linux-arch+bounces-13498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA60B537AC
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0C916404B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF434A32B;
	Thu, 11 Sep 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="K7sACu5t"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021134.outbound.protection.outlook.com [40.107.192.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D831E11F;
	Thu, 11 Sep 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604436; cv=fail; b=L1B5H4m72W44x5La2I1+YdEPHx45tLeb0QO7Lg9wF41p8sWkbi4U/dWamt6Do4gmjbl8VRyFtEuoHlQI8NU4NEeirw8g5KaXMK/biKPm7FOuR2BIT3ieDg7z5RxqV9fEcTNV9hKQqU6SWBWkHn3AqcWcFQIfPQ/6RDihoLUqaQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604436; c=relaxed/simple;
	bh=JTRSEtLdY9y8JJMJGwF6qTesXYBLY035szsyoqm4tX8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPJHI6/O6DVOhvJpaM+5sEwF9s+4z1vqXHD5bzh/Ju4x38ijyentSnB3yOPSH5WXYSDAMTXSy8LqES+Eryfxx4wBZOQRpVosj8wAmXjn6Qje882SOmuUMO0RTPp4bb5NHf5DOrYLlh74e7EugMWJ4mpbscoF4dMji6VcbmxN5i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=K7sACu5t; arc=fail smtp.client-ip=40.107.192.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uf+I7Bk9KBysLO/TJqSPoebTbK1EueIumETGYLduVf0OLRuzYBwqctMyJCij3FJ6m+eqGuGNxtrr72ZUBXs6IMHMToVoeMZOBK7rWIsoedVIclovTyRD5s+aiCIbm5pmoSPcy8CDAZkXfpk96k0P6LduOO0yFJPmHz4AyVRCw34Wtd0GhMlaLanQMUifkM5y3Ji5vE/eCUdvxfvCFluDDnK/qioE3n2VttjVzbPXaN060BsE+wrJLhAkyltjxn2smUAsasaUUHO7fd7vKaPFmjnvI/7B3qZwoK+ve195NoTppIV7JpVNPeax4jSnsIcOjm6qcEuqyuE1mXKPab530A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD4vnVuGjCDZuxor0h5hCVob6s07cdSXWhJcYNLwdjs=;
 b=QcDT+solXfhHxyn49f5YCuC+tKG63I4KI4iApkok6xb7aYO1O7P78Hw3I3BN1OhHzqIb8mTXTTlPh0SmevKNO4j5UQXRNfDS2phOELTsVj/0w7WKdYO+6N6548JoU60suo7zIRAsbYgDQpvpQgIq8sp8Xesc1CuK1Kw5iUTKfvydPIhwx5Xx6V5oZXa5dKQfh7o2WgSA21NO58LtZsFHteXf/ftKZiUQ3lAxVP22fIs5BkqufxM1YgPw6FL5kBeuvTJleAtIt/w/cN3moKThoio6v1tMHVDSMb8ZPfdwm7UwY22jejFBTs8aHDiQOLYNwHJELSAnNdj+igQuvIJXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD4vnVuGjCDZuxor0h5hCVob6s07cdSXWhJcYNLwdjs=;
 b=K7sACu5t5SyvjUZ9a/kIUPnHBdnnxU8XYiZ0AORwAic/O/JHS2maGr38/xRxI0lMwN+/aGouh7sHfM4c15mvgjgWnAZw+FlQOzXHZ+2zxfU2loos6k5RSccoE2Ip10ABgGpaJ27NY7mzVRFgCnl/x6CWQNVRc5BIFpqUQ/QGm4dXxGJs6qJGgkvUslRvz8CyJXNXXUQ+WBglw0oMqk3FF8Q9ujWvHBnyFyiUQvdzcYKV+dXOVKBDs3UcDClhVSTCk7DlODi8C4jws4QMSCYaxacaDmMUON75nHDsiBLcaXcaSzPAq4n1ezgF6IqqlmM48AJNAuW9krHfOj6Fdd3+ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB11127.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:27:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:27:05 +0000
Message-ID: <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com>
Date: Thu, 11 Sep 2025 11:27:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908225709.144709889@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB11127:EE_
X-MS-Office365-Filtering-Correlation-Id: d92221a3-73a0-47c6-9b43-08ddf147aa2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzh5LzJrb0c5MWhXTHkvbkhoSFZnaFN3WjIwcG42bE1WT3JpQUFZd29PZDhN?=
 =?utf-8?B?b2xOZEMxdUV4WnY0enhRU2ZGWEFDVThUY3ZpbVF1bFdJVUF0K0wxUlFjUHRX?=
 =?utf-8?B?NHRzdUx2RG0vZHphUzREZ1VUa29yU21EWWE0ZFRhQnVwZE9lVy9JNkd1UHo4?=
 =?utf-8?B?OENXQmdXN3RVY3dEekdoUmgxaVdBTnY3NnIxM0VrVW5XamhuSTZrNnBzK01t?=
 =?utf-8?B?NGRxRVdmT1pxWWk1ODBnR1RLenh0UGJtRTR0emZKd0RwWUx2QllURkxrbmIx?=
 =?utf-8?B?ZTVXYW1oWFBmWS9pR2FTWU5XeTk0YUY5cUJqVEpVMzg4dGxhUFJWY1JsemVQ?=
 =?utf-8?B?dlI3bnI2RzZPWFZvVXpTMXRjWXBFYWFieXA2UE1oVmp5L3ZaRzVCajUvcURE?=
 =?utf-8?B?VGtKcjFOOVEzYUZXaWVsdHlHSS9JbFVyaUplaW1NdUtDakhiU2d4cGJBeE05?=
 =?utf-8?B?NFR5Tk9kSVdTdmpGNjFxTUdXeHNKcUZOc0JSWXJhSHg0ekIyM24zVWpTQ2RF?=
 =?utf-8?B?TjNxNzE4TkN6NU1iZU9WKzY3VlJjZU9Hc1dkUXdFT29FQ0x5MzlVTkhZekVS?=
 =?utf-8?B?UEJOaExHdGtHSjd0WWo4VTkxMURqMytJOVRpcEsyQkkxbnBGbDBvaGJESlNj?=
 =?utf-8?B?T05oMWxxTVQ3dWVJY25uVVlWRFZjTk00bzF2VXFzbDdFdzJiamNibER3bnJQ?=
 =?utf-8?B?TWlucmZvT1RHVEx2RnFKNFhpMDdQY3g0dnBxdEJQUTRldVpPc2szVmJPdnRk?=
 =?utf-8?B?WkJXTGNHMUx2K1Eya25XWktkUTFYU1l1UnVUSFI3dHFoK2ltL3pKZ1BWcWtD?=
 =?utf-8?B?c0RJS2VIZnVtZHBRcFVnWlNsM0tZbVBjRXlzMkZNS3FXcHFudWxFV2JrbkFX?=
 =?utf-8?B?aldEbld1VGJsV1hGbnFmMS9wRmVPQjNRcmVNOFgzSHhMc3BsRS9XZ3lZYTR1?=
 =?utf-8?B?VkJhLzFUV3lxZC9pL2hqUFlibVY3RmZPZ04raXBNQTl5MktZQXF0WlF0aktP?=
 =?utf-8?B?TU1uQlhoMWI1aTgwZkhCQWx4WU8xS3V0dTZhS3QvbGI5bzkva3d1Qk9rQXEr?=
 =?utf-8?B?SXUwVFhoM0RmVUpLTzhCWWpyQ20wdGV6ejJucGNsWlA0SzZIaFM4Q083bUho?=
 =?utf-8?B?b29hektqR1EwVUR2SDBxUXNaMXNTSS9zc2ZmZ2xsNUFacnMvR0w2TlQzdnBS?=
 =?utf-8?B?Q01peUZWcThMMjlZeXJwTy95QVdOUXVRdW5KaUtBN05lYllVQ2dHZnNjOWZS?=
 =?utf-8?B?VjJaVDBvN2VBR0JDT3QvMUtPKzlkL2cvZ0Rib2cxZ2JBcllzOGFBaVVjdEhH?=
 =?utf-8?B?VmtiL3BpWlJITHZZQWphb0V2eEhPRzIySWVSZUplL0hKNEt1TGxKV1NGTkJO?=
 =?utf-8?B?ZGtzMkdlNkVRQWV0cERScGFrWXppeHpjVlc1aEZZRVdLZS9wcE91UU5HYkVZ?=
 =?utf-8?B?L0x4ZDdvWXVOdkdmSDJweTZWTnRBeUZVby9lZEwrN2xZczcreitDc3RWM2xj?=
 =?utf-8?B?YWNtTk5uRTh4dEJvZy82M1phT3NzNHpocENVRnpVRVBnV1hZa2VBdEVFbXZO?=
 =?utf-8?B?bjVUVHl5enQybm1lUmx1U21xZVoyK05vU1VLaWtFRXN0SmIxSEVJeHhnOTN5?=
 =?utf-8?B?cjFTQ0lXK0s3M3hSVVFTNWJyQjFHYk5RUG56cGlhUTRSR2lha295OXc3VG14?=
 =?utf-8?B?YWJQSEVOdHVlQ1FVZHFkZVdLdG9HV0R0am5NZ1h0Smw2Ym5MWkZMUGdsa1RF?=
 =?utf-8?B?S3hHNFoyR0p1Tlp2dFY4WUFmYnJZWTV0OElySW1TbTMxVDUyMG9MRG93L2k3?=
 =?utf-8?Q?Q8x92xGhpO5bjAYMQvJ4hwXR1ywtvqVlaTTxk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHNPYkx2K0ZkWnlSbmtiZGdJM1lySzZEMkNFdXVOVjZOL2JxMzRqR25ZNXE0?=
 =?utf-8?B?dUJCNDMwdExaWnpFZGk3ZGx3MVhyWkZteTdWSDF0UEl5VVhHeHlvdGpFVnFL?=
 =?utf-8?B?UFlNRm1odkZ0dW5XWk1oUmg0TDFLNmNvZmFiY2trcUdTR0Z6MzllMFY0S041?=
 =?utf-8?B?Q2MveVFXZ1ZMekxtcFdtUzYxaFdsSjRIQXBmMFRnNi95bWorQkdySVd3enI4?=
 =?utf-8?B?MDNtVnloODFsRlJDTW5Nc1lXUHc0WVFncXdKZmRDcU9KK1dhZUhGcE9vaW5t?=
 =?utf-8?B?L2JzK0FDa3R0ZDV0RVdMRVd2eVN2V1ExMVlZdk03Tk04VVFLTzNyTUhQemxM?=
 =?utf-8?B?QU9KMDNVaTZpNW9IWVRpUmVxTVIvR3MxNnNLRVl4UkJ2ZXpzY2xodEczcXMx?=
 =?utf-8?B?aytrUTNwUkpYaTMrY2x6MXBXMTNZSWtiWlpvLzdGTy8wYnhNTHZ3ejFpVVZm?=
 =?utf-8?B?dXA5QUNva0JmR2FIbit6NmZwU0NVcm5XWlVzSGxvZjZ1NnZsY2p0QWRmMXRQ?=
 =?utf-8?B?UjZNWVBMZ3ZLMVdBUHlid0RFWG55WW9ob0R3eVo1c2xGeFoyOGxNSnR0K0ky?=
 =?utf-8?B?M2VZblc5L0hpUEgyalF5dzBKUnVTUzN2M1hIVHppSmlBeFFCMDVqZTBYcjds?=
 =?utf-8?B?TWF1aEJmN3FyUFZLNmpaSFNLM2NTWkRiZy96OU5nTCt1cXYvR1BOMHEvL1VW?=
 =?utf-8?B?eWd6ZCt2RjB4dXdXTHBZaHRYTTE4Z1ZDR1lYZTBEdy9OUFlYcGN1L0FEdy8y?=
 =?utf-8?B?ODlPVmFNT3RyMFBJeS9aUHhIZGtYLzFET1dlUzIrdzMwazR5Zy8rTjhrOEcr?=
 =?utf-8?B?Tm9CTExNWVJ1N0lKMGFpUytEcVY0SlppekRLSEdhNjhRZFFqb0piNDN3dStK?=
 =?utf-8?B?cW5qR05yVWNOOUFEblFkSG52RjJXdmJXalFEZmdPY1Vod2R5V1MrakVTaldQ?=
 =?utf-8?B?N0Fnd3ZaSHM0N0RGa2tRUVMrQ29xTVpPdi9LRlh1WEtOWVU0Nk5uekpPUlZE?=
 =?utf-8?B?V2ZGQlAvOGdlOFpMbkcrT3FacENoeDFPVUk5S0FhNDA2UW94NFcwcUR5QmZ1?=
 =?utf-8?B?WUU1VEg2a0QrSCtiS0VqN1J1c2xSczNIakZjWDNLRGZ2S0Z4S2VLb3hld1hh?=
 =?utf-8?B?MnN3Mm9qaE4wcS8zUlpMQzZYaUtOVXgyR3ZJZmZDV0VyTTF6eDVFU2ZEaDFi?=
 =?utf-8?B?YkxwaUU2SGI5M09wOWR2YUFCd2I1OTloTXBrVDdZTEUxaG56bDNCdE9UQjU2?=
 =?utf-8?B?RXhOMlE1Z2JYNVBQMmtSMThjOE41NFdqNEtlZ0IzN3BCaVAyeUJRRHRYS2dk?=
 =?utf-8?B?NU5TTXdLaHRvN2hXSEpKZktZYWkwYXhRL0pMcHpuUEdYZzRnWGVxVkZYVmJx?=
 =?utf-8?B?VjV5dDhKRlBqYlBNaTJKNk9LNEJ1YllOdFcvaGJ3M3ZJUUVndFNuODVNK0g4?=
 =?utf-8?B?YWhQMms4OFhLVHVUbUkvdDNDdjY4dnQrM2pOeXFZNkxUK3E5VDhrdThmR0FX?=
 =?utf-8?B?Nlg3RkJXVExPZzYyRXJsRDArVi9qZjUrMFY3QTcramxMaEVKcHoxdGtlU2pr?=
 =?utf-8?B?aDJPTUo1SHdLVDJwWS9JbTYzQlFhb0dDRDBzd2hpOHFRTVBEVkVNcE5JUFkz?=
 =?utf-8?B?ejdmWlN2VFptcmhBd0k3TkJzeVBWbS90d3hLY01ZaXFjaXYvMUN0VU5JSWdF?=
 =?utf-8?B?T1Vac0JKeTZqNmhCQkZUYnNHcFpQaTBVMVRqMXNocnBBS0M4RDF6U29qcVhV?=
 =?utf-8?B?OG9wM0dMKzNmaWlZcG1STElCNEp0Tms3RTBlZ1lLMlBIK3JZcW1KQkkwcmN6?=
 =?utf-8?B?c0o2emorTHorbzJLdUtNbDErTDFwRVkvdzQzZGZoa0ZxZUxFQTU4NEJYRE1L?=
 =?utf-8?B?bzNwK0R3THFqQ0dZTnRXNU5FdnlwRnlaZ3hZR2hoU2NNTFpVVS9ubU52SDhh?=
 =?utf-8?B?MGNDL1VteFN0eHU1SmkxdHN0cTVEY1ArYU5sMjYwOFhIRzJyc1dNdmdaTmhJ?=
 =?utf-8?B?aWQrQmpKQkJGVFhLMXdMZElDR2dtdXRKenIrOS92c0xCd0xoSDRYRnpGa0Vs?=
 =?utf-8?B?aWpFL3RKVDlseTRLMy9PYktodU5xdXd3Nm8rNEJYWllTQytxSCtSSUl4bkpy?=
 =?utf-8?B?Ty9JbXp3a1NGakRQTzVuY3lieHBmbElweEZXN045dThxMkxnL3E0NEhUYUc2?=
 =?utf-8?Q?oPQWthB5iF/X1UnVDTg/0QE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92221a3-73a0-47c6-9b43-08ddf147aa2b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:27:05.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4L4duUUbNLbRNImXCZv9WJa8eWiyhlCK7Gouw4wlrqGjSJtW5MftyEeWDegyHHnybS3Vxb7AToVUx7enEqqAnvTAAlDWHyGwZyHnNb/dRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11127

On 2025-09-08 18:59, Thomas Gleixner wrote:
> This is the proper implementation of the PoC code, which I posted in reply
> to the latest iteration of Prakash's time slice extension patches:
> 
>       https://lore.kernel.org/all/87o6smb3a0.ffs@tglx
> 
> Time slice extensions are an attempt to provide opportunistic priority
> ceiling without the overhead of an actual priority ceiling protocol, but
> also without the guarantees such a protocol provides.
> 
> The intent is to avoid situations where a user space thread is interrupted
> in a critical section and scheduled out, while holding a resource on which
> the preempting thread or other threads in the system might block on. That
> obviously prevents those threads from making progress in the worst case for
> at least a full time slice. Especially in the context of user space
> spinlocks, which are a patently bad idea to begin with, but that's also
> true for other mechanisms.
> 
> This has been attempted to solve at least for a decade, but so far this
> went nowhere.  The recent attempts, which started to integrate with the
> already existing RSEQ mechanism, have been at least going into the right
> direction. The full history is partially in the above mentioned mail thread
> and it's ancestors, but also in various threads in the LKML archives, which

it's -> its

> require archaeological efforts to retrieve.
> 
> When trying to morph the PoC into actual mergeable code, I stumbled over
> various shortcomings in the RSEQ code, which have been addressed in a
> separate effort. The latest iteration can be found here:
> 
>       https://lore.kernel.org/all/20250908212737.353775467@linutronix.de
> 
> That is a prerequisite for this series as it allows a tight integration
> into the RSEQ code without inflicting a lot of extra overhead into the hot
> paths.
> 
> The main change vs. the PoC and the previous attempts is that it utilizes a
> new field in the user space ABI rseq struct, which allows to reduce the
> atomic operations in user space to a bare minimum. If the architecture
> supports CPU local atomics, which protect against the obvious RMW race
> vs. an interrupt, then there is no actual overhead, e.g. LOCK prefix on
> x86, required.

Good!

> 
> The kernel user space ABI consists only of two bits in this new field:
> 
> 	REQUEST and GRANTED
> 
> User space sets REQUEST at the begin of the critical section. If it

beginning

> finishes the critical section without interruption then it can clear the
> bit and move on.
> 
> If it is interrupted and the interrupt return path in the kernel observes a
> rescheduling request, then the kernel can grant a time slice extension. The
> kernel clears the REQUEST bit and sets the GRANTED bit with a simple
> non-atomic store operation. If it does not grant the extension only the
> REQUEST bit is cleared.
> 
> If user space observes the REQUEST bit cleared, when it finished the
> critical section, then it has to check the GRANTED bit. If that is set,
> then it has to invoke the rseq_slice_yield() syscall to terminate the

Does it "have" to ? What is the consequence of misbehaving ?

> extension and yield the CPU.
> 
> The code flow in user space is:
> 
>     	  // Simple store as there is no concurrency vs. the GRANTED bit
>        	  rseq->slice_ctrl = REQUEST;
> 
> 	  critical_section();
> 
> 	  // CPU local atomic required here:
> 	  if (!test_and_clear_bit(REQUEST, &rseq->slice_ctrl)) {
> 	     	// Non-atomic check is sufficient as this can race
> 		// against an interrupt, which revokes the grant
> 		//
> 		// If not set, then the request was either cleared by the kernel
> 		// without grant or the grant was revoked.
> 		//
> 		// If set, tell the kernel that the critical section is done
> 		// so it can reschedule
> 	  	if (rseq->slice_ctrl & GRANTED)
> 			rseq_slice_yield();

I wonder if we could achieve this without the cpu-local atomic, and
just rely on simple relaxed-atomic or volatile loads/stores and compiler
barriers in userspace. Let's say we have:

union {
	u16 slice_ctrl;
	struct {
		u8 rseq->slice_request;
		u8 rseq->slice_grant;
	};
};

With userspace doing:

rseq->slice_request = true;  /* WRITE_ONCE() */
barrier();
critical_section();
barrier();
rseq->slice_request = false; /* WRITE_ONCE() */
if (rseq->slice_grant)       /* READ_ONCE() */
   rseq_slice_yield();

In the kernel interrupt return path, if the kernel observes
"rseq->slice_request" set and "rseq->slice_grant" cleared,
it grants the extension and sets "rseq->slice_grant".

rseq_slice_yield() clears rseq->slice_grant.


> 	  }
> 
> The other details, which differ from earlier attempts and the PoC, are:
> 
>      - A separate syscall for terminating the extension to avoid side
>        effects and overloading of the already ill defined sched_yield(2)
> 
>      - A separate per CPU timer, which again does not inflict side effects
>        on the scheduler internal hrtick timer. The hrtick timer can be
>        disabled at run-time and an expiry can cause interesting problems in
>        the scheduler code when it is unexpectedly invoked.
> 
>      - Tight integration into the rseq exit to user mode code. It utilizes
>        the path when TIF_RESQ is not set at the end of exit_to_user_mode()

TIF_RSEQ

>        to arm the timer if an extension was granted. TIF_RSEQ indicates that
>        the task was scheduled and therefore would revoke the grant anyway.
> 
>      - A futile attempt to make this "work" on the PREEMPT_LAZY preemption
>        model which is utilized by PREEMPT_RT.

Can you clarify why this attempt is "futile" ?

Thanks,

Mathieu

> 
>        It allows the extension to be granted when TIF_PREEMPT_LAZY is set,
>        but not TIF_PREEMPT.
> 
>        Pretending that this can be made work for TIF_PREEMPT on a fully
>        preemptible kernel is just wishful thinking as the chance that
>        TIF_PREEMPT is set in exit_to_user_mode() is close to zero for
>        obvious reasons.
> 
>        This only "works" by some definition of works, i.e. on a best effort
>        basis, for the PREEMPT_NONE model and nothing else. Though given the
>        problems PREEMPT_NONE and also PREEMPT_VOLUNTARY have vs. long
>        running code sections, the days of these models should be hopefully
>        numbered and everything consolidated on the LAZY model.
> 
>        That makes this distinction moot and everything restricted to
>        TIF_PREEMPT_LAZY unless someone is crazy enough to inflict the slice
>        extension mechanism into the scheduler hotpath. I'm sure there will
>        be attempts to do that as there is no lack of crazy folks out
>        there...
> 
>      - Actual documentation of the user space ABI and a initial self test.
> 
> The RSEQ modifications on which this series is based can be found here:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf
> 
> For your convenience all of it is also available as a conglomerate from
> git:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice
> 
> Thanks,
> 
> 	tglx
> ---
>   Documentation/userspace-api/index.rst       |    1
>   Documentation/userspace-api/rseq.rst        |  129 ++++++++++++
>   arch/alpha/kernel/syscalls/syscall.tbl      |    1
>   arch/arm/tools/syscall.tbl                  |    1
>   arch/arm64/tools/syscall_32.tbl             |    1
>   arch/m68k/kernel/syscalls/syscall.tbl       |    1
>   arch/microblaze/kernel/syscalls/syscall.tbl |    1
>   arch/mips/kernel/syscalls/syscall_n32.tbl   |    1
>   arch/mips/kernel/syscalls/syscall_n64.tbl   |    1
>   arch/mips/kernel/syscalls/syscall_o32.tbl   |    1
>   arch/parisc/kernel/syscalls/syscall.tbl     |    1
>   arch/powerpc/kernel/syscalls/syscall.tbl    |    1
>   arch/s390/kernel/syscalls/syscall.tbl       |    1
>   arch/s390/mm/pfault.c                       |    3
>   arch/sh/kernel/syscalls/syscall.tbl         |    1
>   arch/sparc/kernel/syscalls/syscall.tbl      |    1
>   arch/x86/entry/syscalls/syscall_32.tbl      |    1
>   arch/x86/entry/syscalls/syscall_64.tbl      |    1
>   arch/xtensa/kernel/syscalls/syscall.tbl     |    1
>   include/linux/entry-common.h                |    2
>   include/linux/rseq.h                        |   11 +
>   include/linux/rseq_entry.h                  |  176 ++++++++++++++++
>   include/linux/rseq_types.h                  |   28 ++
>   include/linux/sched.h                       |    7
>   include/linux/syscalls.h                    |    1
>   include/linux/thread_info.h                 |   16 -
>   include/uapi/asm-generic/unistd.h           |    5
>   include/uapi/linux/prctl.h                  |   10
>   include/uapi/linux/rseq.h                   |   28 ++
>   init/Kconfig                                |   12 +
>   kernel/entry/common.c                       |   14 +
>   kernel/entry/syscall-common.c               |   11 -
>   kernel/rcu/tiny.c                           |    8
>   kernel/rcu/tree.c                           |   14 -
>   kernel/rcu/tree_exp.h                       |    3
>   kernel/rcu/tree_plugin.h                    |    9
>   kernel/rcu/tree_stall.h                     |    3
>   kernel/rseq.c                               |  293 ++++++++++++++++++++++++++++
>   kernel/sys.c                                |    6
>   kernel/sys_ni.c                             |    1
>   scripts/syscall.tbl                         |    1
>   tools/testing/selftests/rseq/.gitignore     |    1
>   tools/testing/selftests/rseq/Makefile       |    5
>   tools/testing/selftests/rseq/rseq-abi.h     |    2
>   tools/testing/selftests/rseq/slice_test.c   |  217 ++++++++++++++++++++
>   45 files changed, 991 insertions(+), 42 deletions(-)
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

