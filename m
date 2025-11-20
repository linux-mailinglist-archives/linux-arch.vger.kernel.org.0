Return-Path: <linux-arch+bounces-14980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CA4C72A1F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B873349EDE
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25196304980;
	Thu, 20 Nov 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kfICSChh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZUIAvmYc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA22D46A1;
	Thu, 20 Nov 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624426; cv=fail; b=FSiHpjH5Byh1JWu6UTpeO8fCW5gQMQn/bRELgu0ZgoTEHEEs+ekZWNjbYhS+O970RCrzM+qmOTSyAPQ3XYcFbFpeDvj96C3hQgzzTMl9XnViWqYxs8idwoBKIKrQYSTxdb4BhyP098KPN+W7I6T5KagpRbO1ort3j9Z1GGxEQn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624426; c=relaxed/simple;
	bh=D97R8+eDKd85AiobyXO14bV8Wa8+qcChI83zLZqevRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjAcpdxHFm1AjSOECrbuUrOcKijKDfiDUrz/4g9cxvhdwsWXSiuhP6umHys+UTpjFMPOS0H+/bawPbSgwoa9uh6goVAVr3mbZc+6ej6UuZpBqKJbk/iwTWMVhyLKfZ/n0vF4WhgDEdHq3vvDfjb2hxPA6vlbaKfV2K71Rak/q6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kfICSChh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZUIAvmYc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1Og48031011;
	Thu, 20 Nov 2025 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D97R8+eDKd85AiobyXO14bV8Wa8+qcChI83zLZqevRk=; b=
	kfICSChhnG6/CuMZ/y9SYzYTo1iJnJCJsy9SGn7r/CAJVU4xdJUAlrYM4zt0WYd/
	2Ao1HJKVAy1KSBB4U7swV4IU/FZ5LKG9CpD4LXIf6/nm5H0uA9x787zvshDhszYr
	5FwFa9+fDyC10XC7lGU9SWGoPt3xh7kkpnVICwbpWAVPl1haGLgOvKpzsyeJwT9n
	510ZycUdZrlK72UI/nnoz2m6Qg6r1MzfFWigL4+ty5TNI2KbwTpxaH6WtbEng2CR
	N+Y+nLHmKCQIG8X5WJC0m9QG+/1/lMtFFZlu1d7h9gO1sTQa1TY5gprdXyK4yBWJ
	cc6tuAPFE4TM6Ffr1gTjGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej968ja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 07:37:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK50QkS035973;
	Thu, 20 Nov 2025 07:37:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefynypcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 07:37:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgDxdTzEfcVZFHCjkMtpq29mxZ/P6xpLdCR41Blg+ZDIIyFUMDFTXCT44dH07G/JqIBqL/rxX0z2vbo1U5FddIboNieZdCoE6cbN9QjgngKqMCMFP9nx0BXTBx3K+N8HB5YLvEIZ1260cT0TvYbE6fI7AKp6EY/GRg4GQpRfg66EgKT/PY7JRgOI40+DAdhxW4uGXXf+mOpG0AXkW0peAWkYd9yl9+ISMdpBRyzOuPgR9w8kIVJrbEPDHc6D3G2J8HrYeFGwjSzOVzoOgc3SYDOo6QwdxnH3R+R48tub0By6CL+GORVnNFUgZXsNy2MDmzqrNcpAuSCLya97CcjJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D97R8+eDKd85AiobyXO14bV8Wa8+qcChI83zLZqevRk=;
 b=HhftDKNt8fQz+VfSIDF7A7YM3pqrFGKfTGPXphivSOB3KJnXbzU+5dwYfYYtUY1iSvc5unBI5yL/PRdClnbMp8Txv56Gkiy7cwUKkAZj1dJvDMe4TOZpCwfIcDc8ALRS7v3khjxsS1vOs8DbEVlNf4ak2K4Cf2/MMJiMEXWnnintZl+NOD2/onL95kNCqL0+hm09JRNS9r1v4nmkLArNCTE0r6Id/NiKIby8gLVVYCTZ+gtny0lUNsRO2ztH3+A4s2QeEunLHKC5G5NdtDmUhC+JMsH3HinDwt3t+LskohhRey9gEJOtXjmYeQZtqw1S9fp/5ii07/ohCVfKPfjDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D97R8+eDKd85AiobyXO14bV8Wa8+qcChI83zLZqevRk=;
 b=ZUIAvmYcgCJmr1rzuq/sjI5B3suL9OyTryk7vuUcXBl738ifBrmL1k5dsFHZLFr7GUBB7BusPSvWgEzg9wvWCO2GgmFHNmAVJ1ozfAGwr0FLxOrUnUM9XPoLnHL2geb9UglsBjZ25fTaArh0gA4pjGUziAJ8Ee1Y+tzzg/IYNcg=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Thu, 20 Nov
 2025 07:37:35 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::a6d8:a8aa:5923:57b9]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::a6d8:a8aa:5923:57b9%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:37:34 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
Thread-Topic: [patch V3 07/12] rseq: Implement syscall entry work for time
 slice extensions
Thread-Index: AQHcSNcVPmZlcazHA0W81AHywt8/IbT5QumAgAD8w4CAAQ+qgA==
Date: Thu, 20 Nov 2025 07:37:34 +0000
Message-ID: <C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
 <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com> <874iqqm4dr.ffs@tglx>
In-Reply-To: <874iqqm4dr.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|SA1PR10MB6663:EE_
x-ms-office365-filtering-correlation-id: 3231e3f3-ba4d-45b7-2104-08de2807abd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlZLcElnT2xiNjB1V3JxY1cvVkJnTWlxTzNMek15K2JjWW05RHlVSlBVc1pa?=
 =?utf-8?B?L0NvUmJsUlpqczBYZnAxTHNHblVzMFVmSEpwN2QrQmo2RU5LeHo3UlVYMlhS?=
 =?utf-8?B?SXF2ZUo0SlU4OFh0elRwbEhLSDVsSG5mOWtlckV2UFdjbURrUW00ZTFJcnJi?=
 =?utf-8?B?NEhsMWFkZHJZTVlRaFdEdUFNV3ZHUXk3cXo2S2NoYXJJVWpzQTNRTDkxU2p5?=
 =?utf-8?B?NmVMb0ZtaTY4TVJhdDlsQlViUnFjTERPTzVhVmk1R2ZEVCtINVJRWXB2c0lT?=
 =?utf-8?B?MG54RDV4ZTdQU3NQWVVwNjc4NVAzbmdhU2FTalY1cDc3TjgxbFFwNnpvWmt1?=
 =?utf-8?B?SE5sQTZsOGlHay90WFozZGFFQlZVd0E2Ym5NL2h6TU00d0g3ZXFCTVc3cTZD?=
 =?utf-8?B?cDVnTEVUWk5NUnJFek5YYXBacjZOekdNSEhIcmRRQ3VvU1Mvblc1eXBkYzJC?=
 =?utf-8?B?U2hYcXZrcy9pSzNnN3pFelU1T3hGdFR4aEhUK3hJNDJRU3BuV1I3Z1FhTmN0?=
 =?utf-8?B?L1NySTBSS0NuRzd6bmFnSzJqVTFLd0lZZktuZmlaK3BpSndYdjhobFZtbk9h?=
 =?utf-8?B?ZDdaVnJKeExpa1F3YjZ5WW5oSko3Y2duVjNiWnJpaDVGZkFHRmxYTnpUYWFh?=
 =?utf-8?B?YWtuRlUyZ21oajY0bFBRNmFoUTBlMHZ5OGxxK2Q3bWRGSS9CR2NXRTNJVFMy?=
 =?utf-8?B?RVFUUXo4Z1pEVHE0NVlUdGt5TlRlK2VlaURray9zeFp0RHZRT2Z4NTNUY3Bn?=
 =?utf-8?B?WEZFOXJSYmJObG5ubEYxcnZMU3RBT04rWHZYa2NaQkJpWkFQdEV4Um5QRDI2?=
 =?utf-8?B?aFNwa2xDMVU3MmltTi9DWnlERnVPY1JUK0pwSzZPZkRqaEt0TGYzQlh2UGJn?=
 =?utf-8?B?cUc3a0FrZGphZ29xZ3NWRWFNbDhDeVkzbGlMbklRckg2dmlna25hbWVVUThU?=
 =?utf-8?B?bFc1ejA2Y0crb2puSVZiUlFpNWsyanZhYkxucFZZSHROZ2FCRGxSNTR6cUtS?=
 =?utf-8?B?QWFKcGZ6V3M0WTRmTy9tL1FydXJ5L3hJOVl2ZWhCRkh2WHBGcVh3WU9PSW5G?=
 =?utf-8?B?Y2FxZEdJMzhIM09Cb0VZeWdNek5LK25vdTFuQjl4emhiM3I4NGJ1Q25PN3JZ?=
 =?utf-8?B?b2JnRU9HMUNMdS9KV002YzRzWXhEZWlCek9aNW9UWlVQQjUvdG4wanNPUGdN?=
 =?utf-8?B?RCt6cDlYekFSVU9oRHJTSm9VYktaazdqOEtKWUJ1eUdKekpEV1pnSFUyTlBt?=
 =?utf-8?B?d1FaOG0wc3pMTHNWQ3EreStQR2gxSUgxZnRCS2g2a1FMR0pVT2did3hZYWp4?=
 =?utf-8?B?amZpRlVvTkVaWUhsUWp2enI5bW5hRWRWYnJiNk5PVGFmanVMY0pmSUZ5N3NK?=
 =?utf-8?B?VTVQTlk1MFhOcFltTDVlVWxJZytYcU9oSlJ4NzhtanEvQlE5SVY1ZTcra2p3?=
 =?utf-8?B?bEhuUDAvZnUyL3dvTkJUTHlZcTZIUFR5bDlBVGt0MU14UVlTWlhRdkp3Mm9M?=
 =?utf-8?B?YTRCaGRXSGI5eFZDdmJHTUFCcGVaNnZESWpTYmsyTkRUdFJVdm55U09qcloy?=
 =?utf-8?B?aGg2SUVXTEd3OXo5Ri9md2ZXVlFZWmZiYVczTWJkU29vWURTaFc4dGxJWldG?=
 =?utf-8?B?NUZDdFJYc0FJVEtUV0c5MXVteFY0emVJdk5qcTIvT3l4NTN2OGcyMlEzaXVP?=
 =?utf-8?B?REVBdUY4MlJscm9JZFJkMFBvYTVMdnFNY3Faa3dibm9nTGJlL0ZQQ0RTNWQ0?=
 =?utf-8?B?YzFyckw3OVBaNUtFKzZ2R2IxK0xKUGRlbHlsRmlGSTdtODR2ZDhGbVExeG1U?=
 =?utf-8?B?R3R0dFFzTTdkZmVHa3Vld1BIVm0zUkdIc2ZFOEJNS3RQcjE4aHB2S1RPWWhl?=
 =?utf-8?B?dSt6V3R0UTdNbUl3VWRnVGJwOXNzaE1mYmM4U2pvUDd3ZDE5MzZITlhuRG9N?=
 =?utf-8?B?a2ZYVHdPR1hRQ2JzN2tBcXZxUlA5eFpUMzlQZm91UEkrSkV2SXQwUlpsYTAw?=
 =?utf-8?B?YVUwTW45ekx6R0NOZ0pBN2V5c1NCNDZUWUZwMkg3eEpmclNkekhIblo5WC9U?=
 =?utf-8?Q?qWnHXY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S0w3YkIwWGd4RjNnaVVkRzU4REtoVmZMRjVBWHEwWjJkVXJkMHJVdXdoeDYz?=
 =?utf-8?B?TGF0QVFudDQ1ZEpZdWNSMkwxeE84VXZtZzQ1TXUrWHd1bExGa05wY2NUUXZL?=
 =?utf-8?B?aEk2NEVmL1lGbzdQV3RXTlRzOWRvS0M4Zmw4cm9aMk9idjNLc2xEdkp0N3VX?=
 =?utf-8?B?OGRZZnAvY3lBanUwazNycHlDNlhiOUM5ZzVuRklVU1U2OFdaNTR5d09UYkVl?=
 =?utf-8?B?NldxWTg2SVkyWGVwYmVxWDVheUgyT0VtS1pKUW1DUVB1RmNMak4zS2RUbEdl?=
 =?utf-8?B?Umh6b1Zmd2VNYjU1ejc5cGNEdHdRTmNJaFJaY2NBNzNsU1JUQWFod2lzZW1a?=
 =?utf-8?B?UFFFRXBXbDRsOVBwbjlrenhMK0xQNVgwS3NWOW9MMVN3c2JyUzloLzBNMlp4?=
 =?utf-8?B?bElpQ3dvTVYxNFBRYWxYT1R5VUIyc0pKcHZNQTB0emZHaVVSd1p1bXBXaWd3?=
 =?utf-8?B?cWR3LyswOUdNWnlWSURyRWdKOHN3U0hWSStzdnRENzlUVmdlL2U1SE1jSm8v?=
 =?utf-8?B?ZWR0VmxrcmhCeUVoTlp3dE94cU1pa08wdkpidWFVdEpnR2ExL25sbUJlS0xP?=
 =?utf-8?B?M0ZQcURJV0d5THRZbE9MVFM0NGovU1VjQTkyR2JlSitDV3crUnlWczlDSkVz?=
 =?utf-8?B?MWJRTUlQUFFXSjArL0V0QnVXVlVuRUV6dk5icEJ2S3lwNFQ3SGxFVU9zQTNC?=
 =?utf-8?B?M1pOVmdGYnArcjloR2JSc2lkZmdraVhiUml6REVEWUVHdi84WkZ3LzhrdkdQ?=
 =?utf-8?B?RzZDbUJyZ0ZYUmhCUC9vNENlMGF3VGRuYXlLMWhKYmRPYjNzc0NLcjlMdjdu?=
 =?utf-8?B?aGNmY2srU2tIRmJvRVkwYWQ5V3JmTjQ4T1NzR21JcHcyMEoyL2FwZldBclc3?=
 =?utf-8?B?RDEyTEtocHRwTENrSk5ZNzlaS1JuSWdIQWZwLzFHR1JpcjBDN0NSeDNQSDVv?=
 =?utf-8?B?R0J3TUtLQ0R6em42MVJiSEZycUhpT3NlNWppMTNYNEhnblVGTFJrQUlEVnVM?=
 =?utf-8?B?cGdmZU5qUDVkNkxwOVExclJrVWlyamxPbStsckVocXNtUnlYWTBpb2wyempF?=
 =?utf-8?B?VFc4VXJiR1dLUmNLWW5QcmVWNjhGZDRQdjZSZXpEeTVDQURLQUtTaXFvdjQ2?=
 =?utf-8?B?aXp1WE55OTZrTzJhbkdyUy9MdFJTdzU4TTloYmowc1pOUVFrRXZwRHZDcnZL?=
 =?utf-8?B?M3o2YXNLemkwQXZYbGNOYjZkWTBSZlNDcEhjdDFJTWdVTVdlRW8wNGtmM0ZO?=
 =?utf-8?B?aWhpYXp3WG5hMGNNNjdFOC9mNkxGaVZOeEpMRWNiaEw0UXhEclhKejlDbVM5?=
 =?utf-8?B?ZVhTTWcrQkEyUXZOakl0RStjMUpLdEk5QXJVc3JlNTZFL2dKYU03ZWQvTjVx?=
 =?utf-8?B?NGdKYis5Q25HUXZvdDVxRXdRbVZ5Uy9TRCtRY1hxcFJDekZwdEhveWpvVGlI?=
 =?utf-8?B?d3UrYXFDdXUyTGM2d0FocEFLb0pPRjJwcW4yZHc5V0J2bWV4aW5SeFBBRUJL?=
 =?utf-8?B?cVRzUExvMFZMN25TRDFCMXBDMUQ5Qjd5cGhqNXM4L0xkT01LSUF0b1RMT080?=
 =?utf-8?B?MHFFdkN1Y2VGUVNDaDY0NkpkNEJoV25uK05QMGFJNGhVQmxXNmVyZFRDbGdY?=
 =?utf-8?B?TTJtcE1oRWdoc0ZoNzFOUjd1Wk9RZFFGbDdvM01jVkpId1VZdlhoTjVyREtF?=
 =?utf-8?B?VzN3V1JNdzJnY0FTT1QxcStTNHBTRDdrNko3YlFadC9CQlFGcGp1UkhEQkZ6?=
 =?utf-8?B?RTZrclA4VEEydm5HWVhtT1ZMVDZrSHpSaDFXN2wzOGUzT1Y4Vzd5VFJUZWlD?=
 =?utf-8?B?V2xlazZPeFZWZEkxMm52RVVvS2dNWkcrNmRvWUNyV3hUR2pMUmpaQ2dIOE52?=
 =?utf-8?B?U2lJaUdjRzU2RFpadlBxSmpmdUdETkpGOE1UaU1kQXR0dzF0KzhpcWsvaCtH?=
 =?utf-8?B?eWJ2dWE3S3RISHNiRkhXNzBFNmFjeTdRTXNxZ1A1VVVybWdPa09VTUJkcWNL?=
 =?utf-8?B?SlBvK2hzVzE1UnVoSG11WnAvK2dISkZnMkRKVWgwY1lQRDcyRTBHdEhKTWNE?=
 =?utf-8?B?QTRZYTVKRDlUcWdRQndmd2NnK3o0Q09URTA1dFNvdlBMcmxUc2tPZVA3TDBZ?=
 =?utf-8?B?RDlWaFlqQi9kMlpNWVNRbHhrazFzSHlOcGdXOXZrNWZRMWR0YUw0TmxwSXFV?=
 =?utf-8?Q?vcmjV9dSsSPwKpw3VMTg2XI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80DB26B5A427364680D1756DA7AE965F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TrjMqQX+B/KQDA0WB6p9GTPQdCWXg9LeDi8r/ROkS5hDe1Qx2PaTli7vrxb3Ll4HI8miosjzBX9MS9v/d88hq+UfRp/BQvLD3ko6pxd8C2jnbBJ5l/EAJorMaT732LZUekLqAOVcWMdlwtZXXID5yHOa/WYVvZIOXe41mzBlzIZpVPyNeJurT898tFVw1oBpEmucM9kPiRr0MpX4kmsmlUu+68YrNf6gZWnLsAvEA0vRw+jemwLJdzBc/J/j+yryZgqNo8MeR3aWy7EKbfCMxmrfCRXR2eiuEJvI3Ny3xACVrZ21tTQ+3/7W/FWim707ODvZTIPEx8aOJB216dVc4hr9hhsW62ppMyJcJki83nZ8gaRY6fn5YaWF0oXGhJ5nETXBvF4Xva66hQiKJV0eFDUbevMGuQY62PEoJlRW3V6vEwbEmomnEQFmf04XksTrlfhON5Ik7SunR3kVtsERUeaF6iNxPzr1osL2CJo8YQOKAdM6sHk53yC+zSZph/Yq0a93h19JcpmqxvwO368LSFGk4/QKtC9L1ondCeypA9EGRquKJWigshe2TzKgXlGXSAQP2z5t1Tl1vzUpG7E+8K2aTlaos0keOUny91NdbZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3231e3f3-ba4d-45b7-2104-08de2807abd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 07:37:34.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QxB9GHA4usn0ARFNiWQ1D9qkwmdvlc1xyWtTDbAstMHLE7gh5GLyy95jUdqUqrkThTmefzyAs2vUD96vjArM0ielLPyrXjb+JaxxOMTiSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200043
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691ec544 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-Wzb-lrMAAAA:8 a=YrZC5wctCiRq0MHBf-gA:9
 a=QEXdDO2ut3YA:10 a=vQ5u0XYZHfJtmRUo30Xe:22 cc=ntf awl=host:12098
X-Proofpoint-GUID: s4U2EX79zP2XzG6g-Ni_jijnYsSH0jm0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXwjsV507IxkVY
 /csGC5n/8T547B4+mPBjVp9Ivv++mW1UPgfqJHvLyi9orkZrwzPaXf/TlYq3UZdpSZyzkJJ3Bgk
 j0fsx04m1VZF0qX4Js5sFKbHV9Ql6mDui74ot1RpumtC7jctD6bgRXO5VIcg/2levOQPHrljbzJ
 cU4JnXdaNXTYzE0AX4GNte65LyTLb5RwDfRUS/QFK7nEawNIZp5Sq0SHdeC8KNgUuEQgNivFDFR
 5nlR7fUlFob7+k/kBRUSfUaqPuyBnTt2MNVQ34FvU03MqkEHnOVU2run/+UfYIgSmZrHylkp7Te
 xowk2LiodQvQOMflN3mDUXWA8Ho6mYLqlukf43HZydvrMKgN8SqzSQoHPJ69hsOiap2ywEOA4Kp
 +AtImerMl/WyFb8FS0hkgp07iLbNgoJQhMkLAk2KZRFEmy+PLrQ=
X-Proofpoint-ORIG-GUID: s4U2EX79zP2XzG6g-Ni_jijnYsSH0jm0

DQoNCj4gT24gTm92IDE5LCAyMDI1LCBhdCA3OjI14oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTm92IDE5IDIwMjUgYXQgMDA6
MjAsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gT24gT2N0IDI5LCAyMDI1LCBhdCA2OjIy
4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4+PiAr
IGlmIChwdXRfdXNlcigwVSwgJmN1cnItPnJzZXEudXNycHRyLT5zbGljZV9jdHJsLmFsbCkgfHwg
c3lzY2FsbCAhPSBfX05SX3JzZXFfc2xpY2VfeWllbGQpDQo+Pj4gKyBmb3JjZV9zaWcoU0lHU0VH
Vik7DQo+Pj4gK30NCj4+IA0KPj4gSSBoYXZlIGJlZW4gdHJ5aW5nIHRvIGdldCBvdXIgRGF0YWJh
c2UgdGVhbSB0byBpbXBsZW1lbnQgY2hhbmdlcyB0bw0KPj4gdXNlIHRoZSBzbGljZSBleHRlbnNp
b24gQVBJLiAgVGhleSBlbmNvdW50ZXIgdGhlIGlzc3VlIHdpdGggYSBzeXN0ZW0NCj4+IGNhbGwg
YmVpbmcgbWFkZSB3aXRoaW4gdGhlIHNsaWNlIGV4dGVuc2lvbiB3aW5kb3cgYW5kIHRoZSBwcm9j
ZXNzIGRpZXMNCj4+IHdpdGggU0VHVi4NCj4gDQo+IEdvb2QuIFdvcmtzIGFzIGRlc2lnbmVkLg0K
PiANCj4+IEFwcGFyZW50bHkgaXQgd2lsbCBiZSBoYXJkIHRvIGVuZm9yY2Ugbm90IGNhbGxpbmcg
YSBzeXN0ZW0gY2FsbCBpbiB0aGUNCj4+IHNsaWNlIGV4dGVuc2lvbiB3aW5kb3cgZHVlIHRvIGxh
eWVyaW5nLg0KPiANCj4gV2h5IGRvIEkgaGF2ZSBhIHNtZWxsIG9mIHJvdHRlbiBvbmlvbnMgaW4g
bXkgbm9zZSByaWdodCBub3c/DQo+IA0KPj4gRm9yIHRoZSBEQiB1c2UgY2FzZSwgSXQgaXMgZmlu
ZSB0byB0ZXJtaW5hdGUgdGhlIHNsaWNlIGV4dGVuc2lvbiBpZiBhDQo+PiBzeXN0ZW0gY2FsbCBp
cyBtYWRlLCBidXQgdGhlIHByb2Nlc3MgZ2V0dGluZyBraWxsZWQgd2lsbCBub3Qgd29yay4NCj4g
DQo+IFRoYXQncyBub3QgYSBxdWVzdGlvbiBvZiBiZWluZyBmaW5lIG9yIG5vdC4NCj4gDQo+IFRo
ZSBwb2ludCBpcyB0aGF0IG9uIFBSRUVNUFRfTk9ORS9WT0xVTkFUUlkgdGhhdCBhcmJpdHJhcnkg
c3lzY2FsbCBjYW4NCj4gY29uc3VtZSB0b25zIG9mIENQVSBjeWNsZXMgdW50aWwgaXQgZWl0aGVy
IHNjaGVkdWxlcyBvdXQgdm9sdW50YXJpbHkgb3INCj4gcmVhY2hlcyBfX2V4aXRfdG9fdXNlcl9t
b2RlX2xvb3AoKSwgd2hpY2ggaXMgZGVmZWF0aW5nIHRoZSB3aG9sZQ0KPiBtZWNoYW5pc20uIFRo
ZSB0aW1lciBkb2VzIG5vdCBoZWxwIGluIHRoYXQgY2FzZSBiZWNhdXNlIG9uY2UgdGhlIHRhc2sg
aXMNCj4gaW4gdGhlIGtlcm5lbCBpdCB3b24ndCBiZSBwcmVlbXB0ZWQgb24gcmV0dXJuIGZyb20g
aW50ZXJydXB0Lg0KPiANCj4gc3lzX3JzZXFfc2NoZWRfeWllbGQoKSBpcyB0aW1lIGJvdW5kLCB3
aGljaCBpcyB3aHkgaXQgd2FzIGltcGxlbWVudGVkDQo+IHRoYXQgd2F5Lg0KPiANCj4gSSB3YXMg
YWJzb2x1dGVseSByaWdodCB3aGVuIEkgYXNrZWQgdG8gdGllIHRoaXMgbWVjaGFuaXNtIHRvDQo+
IFBSRUVNUFRfTEFaWXxGVUxMIGluIHRoZSBmaXJzdCBwbGFjZS4gVGhhdCB3b3VsZCBuaWNlbHkg
YXZvaWQgdGhlIHdob2xlDQo+IHByb2JsZW0uDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGUgdW5j
b21waWxlZCBhbmQgdW50ZXN0ZWQgYmVsb3cgc2hvdWxkIHdvcmsuIFRob3VnaCBJDQo+IGhhdGUg
aXQgd2l0aCBhIHBhc3Npb24uDQoNClRoYXQgd29ya3MuIEl0IGFkZHJlc3NlcyBEQiBpc3N1ZS4N
Cg0KDQo+ICsgKiBHcnVkZ2luZ2x5IHN1cHBvcnQgb25pb24gbGF5ZXIgYXBwbGljYXRpb25zIHdo
aWNoIGNhbm5vdA0KPiArICogZ3VhcmFudGVlIHRoYXQgcnNlcV9zbGljZV95aWVsZCgpIGlzIHVz
ZWQgdG8geWllbGQgdGhlIENQVSBmb3INCj4gKyAqIHRlcm1pbmF0aW5nIGEgZ3JhbnQuIFRoaXMg
aXMgYSBOT1Agb24gUFJFRU1QVF9GVUxML0xBWlkgYmVjYXVzZQ0KPiArICogZW5hYmxpbmcgcHJl
ZW1wdGlvbiBhYm92ZSBhbHJlYWR5IHNjaGVkdWxlZCwgYnV0IHJlcXVpcmVkIGZvcg0KPiArICog
UFJFRU1QVF9OT05FL1ZPTFVOVEFSWSB0byBwcmV2ZW50IHRoYXQgdGhlIHNsaWNlIGlzIGZ1cnRo
ZXINCj4gKyAqIGV4cGFuZGVkIHVwIHRvIHRoZSBwb2ludCB3aGVyZSB0aGUgc3lzY2FsbCBjb2Rl
IHNjaGVkdWxlcw0KPiArICogdm9sdW50YXJpbHkgb3IgcmVhY2hlcyBleGl0X3RvX3VzZXJfbW9k
ZV9sb29wKCkuDQo+ICovDQo+IC0gaWYgKHB1dF91c2VyKDBVLCAmY3Vyci0+cnNlcS51c3JwdHIt
PnNsaWNlX2N0cmwuYWxsKSB8fCBzeXNjYWxsICE9IF9fTlJfcnNlcV9zbGljZV95aWVsZCkNCj4g
LSBmb3JjZV9zaWcoU0lHU0VHVik7DQo+ICsgaWYgKHN5c2NhbGwgIT0gX19OUl9yc2VxX3NsaWNl
X3lpZWxkKQ0KPiArIGNvbmRfcmVzY2hlZCgpOw0KPiB9DQoNCldpdGggdGhpcyBjaGFuZ2UsIGhl
cmUgYXJlIHRoZSDigJlzd2luZ2JlbmNo4oCZIHBlcmZvcm1hbmNlIHJlc3VsdHMgSSByZWNlaXZl
ZCBmcm9tIG91ciBEYXRhYmFzZSB0ZWFtLg0KaHR0cHM6Ly93d3cuZG9taW5pY2dpbGVzLmNvbS9z
d2luZ2JlbmNoLw0KDQpLZXJuZWwgYmFzZWQgb24gcnNlcS9zbGljZSB2MyArIGFib3ZlIGNoYW5n
ZS4NClN5c3RlbTogMiBzb2NrZXQgQU1ELg0KQ2FjaGVkIERCIGNvbmZpZyAtIGkuZSBEQiBmaWxl
cyBjYWNoZWQgb24gdG1wZnMuDQoNClJlc3BvbnNlIGZyb20gRGF0YWJhc2UgcGVyZm9ybWFuY2Ug
ZW5naW5lZXI6LQ0KT3ZlcmFsbCB0aGUgcmVzdWx0cyBhcmUgdmVyeSBwb3NpdGl2ZSBhbmQgY29u
c2lzdGVudCB3aXRoIHRoZSBlYXJsaWVyIGZpbmRpbmdzLCB3ZSBzZWUgYSBjbGVhciBiZW5lZml0
IGZyb20gdGhlIG9wdGltaXphdGlvbiBydW5uaW5nIHRoZSBzYW1lIHRlc3RzIGFzIGVhcmxpZXIu
DQoNCuKAoiBUaGUgc2dyYW50IGZpZ3VyZSBpbiAvc3lzL2tlcm5lbC9kZWJ1Zy9yc2VxL3N0YXRz
IGluY3JlYXNlcyB3aXRoIHRoZSBEQiBzaWRlIG9wdGltaXphdGlvbiBlbmFibGVkLCB3aGlsZSBp
dCBzdGF5cyBmbGF0IHdoZW4gZGlzYWJsZWQuICBJIGJlbGlldmUgdGhpcyBpbmRpY2F0ZXMgdGhh
dCBib3RoIHRoZSBrZXJuZWwtc2lkZSBjb2RlICYgdGhlIERCIHNpZGUgdHJpZ2dlcnMgYXJlIHdv
cmtpbmcgYXMgZXhwZWN0ZWQuDQoNCuKAoiBEdWUgdG8gdGhlIGNvbnRlbnRpb3VzIG5hdHVyZSBv
ZiB0aGUgd29ya2xvYWQgdGhlc2UgdGVzdHMgcHJvZHVjZSBoaWdobHkgZXJyYXRpYyByZXN1bHRz
LCBidXQgdGhlIG9wdGltaXphdGlvbiBpcyBzaG93aW5nIGltcHJvdmVkIHBlcmZvcm1hbmNlIGFj
cm9zcyAzeCB0ZXN0cyB3aXRoL3dpdGhvdXQgdXNlIG9mIHRpbWUgc2xpY2UgZXh0ZW5zaW9uLg0K
DQrigKIgU3dpbmdiZW5jaCB0aHJvdWdocHV0IHdpdGggdXNlIG9mIHRpbWUgc2xpY2Ugb3B0aW1p
emF0aW9uDQoJ4oCiIFJ1biAxOiA1MCwwMDguMTANCgnigKIgUnVuIDI6IDU5LDE2MC42MA0KCeKA
oiBSdW4gMzogNjcsMzQyLjcwDQrigKIgU3dpbmdiZW5jaCB0aHJvdWdocHV0IHdpdGhvdXQgdXNl
IG9mIHRpbWUgc2xpY2Ugb3B0aW1pemF0aW9uDQoJ4oCiIFJ1biAxOiAzNiw0MjIuODANCgnigKIg
UnVuIDI6IDMzLDE4Ni4wMA0KCeKAoiBSdW4gMzogNDQsMzA5LjgwDQrigKIgVGhlIGFwcGxpY2F0
aW9uIHBlcmZvcm1zIDU1JSBiZXR0ZXIgb24gYXZlcmFnZSB3aXRoIHRoZSBvcHRpbWl6YXRpb24u
DQoNCi1QcmFrYXNoDQoNCg0KDQoNCg==

