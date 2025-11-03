Return-Path: <linux-arch+bounces-14494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9BC2E2DD
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F03D3BC864
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 21:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C52D594A;
	Mon,  3 Nov 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I8H19xRc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FzTsxKgD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C322D47E8;
	Mon,  3 Nov 2025 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206102; cv=fail; b=Nw6ZcsAs7BF2ZmhjXaSWZYiYI5J/A4nCCFmRP6xdy5toK6xemc9PBsqhZ97ILQU46Qwt5aG29s+A9Rxo2v3V/JPEPoYwdfMLknAIlM+gQ38/5SpnMteJCkQUM7LTpXo09sZkTyS+cl7Pw8TW9Rm645FzA+AKb7mIBej+9WR3PIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206102; c=relaxed/simple;
	bh=Sdel9PDKVajfNoVypKu7bLfooBfI/qk/11MvV5eCGL4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=JUF6Q10bwJ4k7Y898Z0RQ35mA5TFoD7kLb26JDuGEdp9kWGah8OhMKYWbO18YYq3HtaPOJHxaVjI82GQv7pFsZMDTTubGiCpua2/FRSVVSXN0PWpctZbsL3URnhxS9m1AFw6bGs7gk8ZynBHdq0nO+erzSntBguv4njoIfqPez4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I8H19xRc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FzTsxKgD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3LebeE017006;
	Mon, 3 Nov 2025 21:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=r/Yw6kBI2ztevT4HaE
	9BTxzCDpLpY4M/7/HB2RkCHA0=; b=I8H19xRcbpCDibgYjsT3E5Jgeowkl9oHPc
	LpHcA5DK6iiXm25BcIssVprglW64jBtL6Vy+qyh7/JzNKAmYDtFC1x7NQHzfkT+w
	CJx5CWwQ57uudOlbZtNL/TdyOjZoBcf6ANQ8z0tk65YMUvJdoO95L3RgPCxTAqMW
	Zf+FUcA7a2qlydvhAVapy1BFq5ZmGWXWc+9zkNVkKTvWzpfsrSYRQRZi3S0SIFKk
	XOZp2DVZZzF0MU5TGUw4tzU67HCRma4D1AC03BbZEC6Xldzt6sJosutgxKbBWbzd
	a3pUkQGGLgGA5oZtcCtieilu5IpvZySA2JHkHOMYLLe6EYCvSW7g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a74ger026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:41:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3K3v7e039712;
	Mon, 3 Nov 2025 21:41:08 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58njgvk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 21:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YREF1/YDY23yjCs/uyOr+V6oSo5ojQvhJ7EaVzdTHKyqnOSAkMxiJAgXzX357Q6+opuKlVL8+z9Ehe4jespeWLpt0dZWlCBlTrhuWklqIOQ3rE1vDa7//eAXRLLWiWQe3+heoZBjLIZiH9PmqaB69aeWDpZo4nTmZBPMZgq+S5Qm0uKPWNuy9v2yivOPqvsx7eOMswEdyjTx4MKLhdy52hGH0fz0Ud0+B+oj6EsEGyV16x/QaMIZePS1uvZENSgkG/q35oOe4S3d4O41zdwzmBpkBgE61pZRptIC2lM0f/q2pTzNiXbR0dDBwBBDVEDK9T6GS7EFAHLC293WHxynjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/Yw6kBI2ztevT4HaE9BTxzCDpLpY4M/7/HB2RkCHA0=;
 b=Oy6onPoxW88XuDOg0A/P/acD5Lgq10C/MheX/L8oRYwe4WZhzaxYQ7kFyHOW/flDzGOsRl4m4sxmw9hTTL/QLQdkRWSsHprI+nOla/177HGlnMsMNTi296i34dRd3YtooKabXLnogntah/vkfBwFMpDyXJsNIurMgyhHZK9aYT4cZ35ulPW5IGN57RGt+iNGXhuKeSPRFyJvX8DQ6goB3q3lOY62dfWD4aRLOTtB6DcJYP1qOUote1CoC7CAT//4FP8+u9ViLe04T+xkEJKjEkis1J8iZsHGjWfvoZpqSd+RPrzac2EEDgnuuyzwm089oJpeOfYJmarNfyco8YuCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Yw6kBI2ztevT4HaE9BTxzCDpLpY4M/7/HB2RkCHA0=;
 b=FzTsxKgD08PagmOGo7d96WOo52nRSMcdSIaJVtDZzQYSNtvlTkfMvv0XPPuzyiuoPiSUr/6E5VsuRpcrRcxtSAGfl1aWafouljaBmuicYSNzTwrReVcniWm5YTR3iw3A7ZcK6qsNzh4AbIr67j4W1vq3P9aeNBaIhoVGHkmIEUc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB997666.namprd10.prod.outlook.com (2603:10b6:510:382::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 21:41:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 21:41:05 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-2-ankur.a.arora@oracle.com>
 <4c87bbf8-00a3-4666-b844-916edd678305@app.fastmail.com>
 <874irimm6d.fsf@oracle.com>
 <84914748-4bf9-44a5-9e08-80528ca27177@app.fastmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Haris Okanovic <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <84914748-4bf9-44a5-9e08-80528ca27177@app.fastmail.com>
Date: Mon, 03 Nov 2025 13:41:04 -0800
Message-ID: <87a512eqvj.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:303:2b::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB997666:EE_
X-MS-Office365-Filtering-Correlation-Id: 717350f6-d7f4-40d4-2948-08de1b21b106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lH4Y36nZctOLp3qCmk+n4x3LkTtm+E3vIl2T4NJpDNgvOxSzeELEg6uhXsQT?=
 =?us-ascii?Q?uNGSy5dW+U/+oq5t7+Gv6WaF39gIGJYXzp82cNi1aUHWCDkpr1YScxEx2nFc?=
 =?us-ascii?Q?VRU8QFoPnOFGS1COw3F77b+TSZbesgHttMH9TSdy0cRNMFo98IUBbVQAYMtc?=
 =?us-ascii?Q?2tlXI/Ok6m+/RRqFJxS2+UTsnN5l/y65+fqWM5DNOzi/fbe1sZvGSk2O3zKY?=
 =?us-ascii?Q?3V1MeRhY+aZXyv2oJhcjXRLLInvTigm1PLCSglHaDwXtSMSJgsKJAo81GaLQ?=
 =?us-ascii?Q?LaVTkF67cYbz0/o35QzjG2KxhH60tiBxlPFmFU9+JBHoTzpI9CcmtSSAovpz?=
 =?us-ascii?Q?JNbA8Q1G6+FKqUhlFIhfd2+UdQqO7OXNGAWXq3fQ/ty9V1Radm6h+TdiDCUs?=
 =?us-ascii?Q?r0Qg7Bw89dWynR8Rg5aMfKlpUkG0mQ4/4jOt296VNh+RXAMeuo+ykNcE07je?=
 =?us-ascii?Q?WJZXFjPUDSG/0J1doR65DoZCF/qvuPGOdRBvYAeoChdNGblmErqDMXXJNxm6?=
 =?us-ascii?Q?iUnB8yHJGCRrbqW8LzEV1MJabXlRhW0NxT3Z1s/DCyl3DevCBzBx+ffo/9b1?=
 =?us-ascii?Q?wp6nNdZuteeXAwzlJSdylFmVrcoEFmDIyrDejx0R9PneaZU1WJVlrEYO6IDo?=
 =?us-ascii?Q?C7njYn9JCae/u0nmGSor6+8gCxTsaurMvAL6N8gGdlYrujlemlsp7BIWmSHY?=
 =?us-ascii?Q?fjyYH+/5gt5HwGShR/0/CRutcqYye9h9GeyJO3gvMy6nUt/Fz6ajlCh3cHFG?=
 =?us-ascii?Q?sbEPPc91kvgGH88AYZr2dNg8JswI8vthcfTG3Fk1vK6FTRm2p7I1Iapb3U5b?=
 =?us-ascii?Q?PUtzpNa2imZsWF7mnBFDcuhZYaon0XkuHXdGkn4aVz3HXF9Nhhg/3Efu0sNY?=
 =?us-ascii?Q?si6VCFAJG9na0Ljki7KeAlKFLZUNtvrim9WVfs680LCg/nfNalTnrNqgwiIp?=
 =?us-ascii?Q?136bsU0CoGLe1ocJheAI3qK39H+ybpQDn7kvSj4qVj3Xqw9l/21a/NR+0qOT?=
 =?us-ascii?Q?b616BWUnj/3pf4A9hIOei/zSXVjVfhP3yVfANPDPpIMeQP/E8Qs5L0QbCaMK?=
 =?us-ascii?Q?OTihtrPW4x4OhrvaPfcJ0mPH27jJ9/YqaA/SCEpmere7aah9I9SJuzyxG2uE?=
 =?us-ascii?Q?xA7eEseUOvWFqNDfWAUGjsZGgZzMCfYnA4xCZGVmcRcECUoiSb1VjKWBdSOo?=
 =?us-ascii?Q?iUpukRnfNIuBl/oq1IAELtsw/YHjuxdvf0xNjW3j6r7OF9Zmo1eMR496vjuO?=
 =?us-ascii?Q?BhHF1c2xHEiVD7SIG95EgqMCVVPRz/LSUIynQHSR9j++INtT/qivMBXptP43?=
 =?us-ascii?Q?GLhVW1i5s3jVUdObhCLggT2TjSs+bqRGRq65EExV5HXxMMRR4eiNtjSwyfWm?=
 =?us-ascii?Q?zz3Nk+j/yrbYHsAYPnPQt7IFZ7JQKLJ6O6PV+yRh52+0XjdseAV/t+00OlUs?=
 =?us-ascii?Q?QF+AdPLj7fxBXriRXZQzo7fES7prWh3U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0u4UOBp5Ra8hbUncAcTB2bK/LJUHMKjtD20HshFgi27CL71r2vi68vKGMN8S?=
 =?us-ascii?Q?wKlCflhH8x7lDx4JJJ/5Hr3PnSTfGhUu2RUi8gcXkpxPvGc+J/mL6r0L+HYZ?=
 =?us-ascii?Q?9ZLim/gkoSqpkgC8MWAKWwnOl6ooGJ9AAG8ODwlfsRPZDR2E4t1Sixn/cpJ0?=
 =?us-ascii?Q?/Taqz903d1etgb0gaew/NYKfEla2z+UJMqnGUh6ULvyzM6pzHDhOoaupBLO2?=
 =?us-ascii?Q?XX0vYC/2arNzIQwDwaMvuIC6FSwwNqW63W8u6HzayzcW1b94wqdXwqI4n+Jt?=
 =?us-ascii?Q?LYH74mtyG8GpkEySvCHdLaQxP5uFygDj4WcgYJUdjKF/f2iAriUMX5fCpnbu?=
 =?us-ascii?Q?EmVUbMAxX1SCKvSfeeFCITEQxntyx7CfWtLrOHFuHITKFCIVUPioraHd8XxF?=
 =?us-ascii?Q?SpwYV1dNBOljKyVBGizDezSmJRMVP31vpAkIXBCfmhSqTbrM+ysWiHceyqdL?=
 =?us-ascii?Q?qTStS2YIYx4cdjH3xKGtWYosobiIOlUlI5li8U5muJW9G7nY0gY+MYtjEjxj?=
 =?us-ascii?Q?C9poNHLSEpsAcngr2mCZvWR4CCsB+zFz4d7td+xW+PGG8CzhGbsoqf2J/moZ?=
 =?us-ascii?Q?md+MeQF5bdF5ifbLZ8kBMekk7MEV27g2iJASeVsO9ntoWeBAn6W3fZsZFMAu?=
 =?us-ascii?Q?la3fwi/hA/EB9UyUNLP9e1TGY0xsBAapiM1fwkkIzHu+8cPjBxSa/xOzFAjS?=
 =?us-ascii?Q?eF/jf3yePlNhifA5I27RrSTTTTCeBuD6efNWgvlyrH3vWKyF9JShXrQ/IgML?=
 =?us-ascii?Q?qkcyrrX8em/Y0Sa5S4UlhxqMh+5dJNoP+LYa5gDOLTA1RPPpw8BxDGY1wzS9?=
 =?us-ascii?Q?21DVvFnd1W+I3x/wmwf+ouhabLzlJj9JAwJV3B7hagV4ewGEfo8zc7meAvvH?=
 =?us-ascii?Q?QEKyE8aPHRTC+/roz+Ov9QYgYFBlh6CR/e1KTI9K3s0M0WoVxcR3jAY8qy/1?=
 =?us-ascii?Q?pO6wXLO5kG7lAKUJO3E1jcnF5wvEFnrNt/ji5fXhVbj50RcGScpPtva/wUO/?=
 =?us-ascii?Q?iiHSRmsq+BP1mPsYVWXIHMalJH6NZv5P5nBoDGUUcUrGak3C9+uhXvw6HRnn?=
 =?us-ascii?Q?skhmJUIdTeaKm6VS81l4kz6LMpwSEwHmnLCFt9wLFsAxIWPNL9jVrl8hxuZL?=
 =?us-ascii?Q?tw4CW2TSqi0PUVwjm4OI7zoeaxobzHzOHw0S0Tk/JrFYe1I6FpHllq8wh89R?=
 =?us-ascii?Q?cG2+X6jC39eq+T+fjsCOgeSt7FE2lqFpV64RDFYibO9W78ohpGlS8aLq3zPK?=
 =?us-ascii?Q?Rfd1syGINXygYoL5oEE19QV8a6x73faoItaZHM9LSFU6YgnL0fZRz6pNUXNs?=
 =?us-ascii?Q?PyCfEkEPAKej5X1tLyzKw2MnKTQRQ+RBX3NpO7/ztu9LoYHt0bTmi6k+Agjp?=
 =?us-ascii?Q?Ns325vnJltp5zeDylFXZ3iby+mmUeRM3Ml1hNVFfL0sEMZd+CMxHpuT9vYMY?=
 =?us-ascii?Q?xXhdIIYtabYSa/5G1YTPhKPiLtht5ysDYu1GQbykFXQhfCUnh3uwCfYxTq3J?=
 =?us-ascii?Q?hNjsTPhLvlApukii5oK13fV5irpQHueFnTS/+8QEzMwF7c2VHMW+fnG4Pmx2?=
 =?us-ascii?Q?+PYAY6QpSPol2MImC4WY5bBu0WX9o9woNbP4YgzbJX8iymfKA9rXS0wJ2kah?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NPIO/Y97cm/SUxMsrT4v+5WzbTz+SPUh+OTRMC745iFxOLcF0wng4XeWiLs9DWFJ1lFHj0PfBluA++YPm9F1f/xrdafmRiOHfsgJHWEfgW5f6I/+4Ux8rEjKQAtZmZooCy3Y3nqp6tiPrBRVJkmXFeoJk21QWWkczVhy4mvuUl9LRPDyNZoiO/hl3WMLS+R6qGleaPyR9gshZhKaER7ui17hJPKh3B9c0HzNzFQLJLng7Voe5702hYkZbeX50WmVx88GdfGr9Rq2tU7uJH2zaiMo/w3oOrDyLcrYl03DV0aoI9nUhJXrG78PFtHCedXc4fK8bJHj/+jaxHFAzuDnhngpA+7Hi4mkLR2MCw38BhdrwRHnadFfRfF5HEdkME7wDIkWxDKYSonQCXY1r8Puc9JLsjysBI91qrYTmBM5IaRFFMzjNU/6EeZRXzmu9Po1WXU3OL6o5wSuX7rZGA9nXXqDypUpTGIBHNsIPHIiGr+LJKhhOLzrNn+xbCnjx5hS7hbBoWzZhrYssyqKWQu/yWyS2M1thdkNGDLaxSZ3hTx5yetOn4e9WtCGBjXC0AFvg4wkOOYong2oKMTZIU3myhuqb8brLPFfRQcu8cPTaMA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717350f6-d7f4-40d4-2948-08de1b21b106
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 21:41:05.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1J6MWLdpc4jbWYaSBWPbH5zGJQEX8ZrCwhOnH3mXz7zZi3Ol+DgwM/0bO5ej6cqO1MyUDAngR6srTVTOoQgig33/DHmCOHgTZZRbMd/7Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_05,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030193
X-Proofpoint-GUID: U0AJRG1Z3peLAFmUG7clEDvEU5GQig6k
X-Proofpoint-ORIG-GUID: U0AJRG1Z3peLAFmUG7clEDvEU5GQig6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE5MyBTYWx0ZWRfX9HopL6ZKif2l
 /4iPEz3MJ8rg0SYb8sH63hURIcc6ouc9mSISrR2X+p0p8HzM/XL4OLrRtI+JZUgy09jWYYHAtR3
 g79F3ABzAFoq3R9U06+LTAkhkZllUsmWxr+H+xutdnvlu//uJGiVK/Cttkk4W797IVy/YSCOJ4C
 2wweAaEw+nkxQPVLadHrDMEqcJqhwC5tL9ANN1sNhNdxAKGOnVVCC/wfkC864137b/Q3D579l7D
 SnMziYE+7H9OTcZrU2cBAg1l4k+FG9PIc2/0NmHpbGp7GC9kQ8WxYqq6nWiggO0P9HAUgFYB6Z1
 f+u/50Iuacrtk7eHb+75leurJg+auYdxieSj0gZPNhJTJKmM9/iUhF/nAlgjBrj3LN6sRg9bpQU
 4zeTjdcsB06G38d36Yt5Ngj9Xzq4x3QD9eSi9bJWyKQZk0abKcY=
X-Authority-Analysis: v=2.4 cv=PJYCOPqC c=1 sm=1 tr=0 ts=69092174 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=ykiFF0ug30AnlUb8vswA:9 cc=ntf
 awl=host:12124


Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Oct 29, 2025, at 04:17, Ankur Arora wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
>>> The FEAT_WFXT version would then look something like
>>>
>>> static inline void __cmpwait_u64_timeout(volatile u64 *ptr, unsigned long val, __u64 ns)
>>> {
>>>    unsigned long tmp;
>>>    asm volatile ("sev; wfe; ldxr; eor; cbnz; wfet; 1:"
>>>         : "=&r" (tmp), "+Q" (*ptr)
>>>         : "r" (val), "r" (ns));
>>> }
>>> #define cpu_poll_relax_timeout_wfet(__PTR, VAL, TIMECHECK) \
>>> ({                                                    \
>>>        u64 __t = TIMECHECK;
>>>        if (__t)
>>>             __cmpwait_u64_timeout(__PTR, VAL, __t);
>>> })
>>>
>>> while the 'wfe' version would continue to do the timecheck after the
>>> wait.
>>
>> I think this is a good way to do it if we need the precision
>> at some point in the future.
>
> I'm sorry I wrote this in a confusing way, but I really don't
> care about precision here, but for power savings reasons I
> would like to use a wfe/wfet based wait here (like you do)
> while at the same time being able to turn off the event
> stream entirely as long as FEAR_WFXT is available, saving
> additional power.
>
>>> I have two lesser concerns with the generic definition here:
>>>
>>> - having both a timeout and a spin counter in the same loop
>>>   feels redundant and error-prone, as the behavior in practice
>>>   would likely depend a lot on the platform. What is the reason
>>>   for keeping the counter if we already have a fixed timeout
>>>   condition?
>>
>> The main reason was that the time check is expensive in power terms.
>> Which is fine for platforms with a WFE like primitive but others
>> want to do the time check only infrequently. That's why poll_idle()
>> introduced a rate limit on polling (which the generic definition
>> reused here.)
>
> Right, I misunderstood how this works, so this part is fine.
>
>>> - I generally dislike the type-agnostic macros like this one,
>>>   it adds a lot of extra complexity here that I feel can be
>>>   completely avoided if we make explicitly 32-bit and 64-bit
>>>   wide versions of these macros. We probably won't be able
>>>   to resolve this as part of your series, but ideally I'd like
>>>   have explicitly-typed versions of cmpxchg(), smp_load_acquire()
>>>   and all the related ones, the same way we do for atomic_*()
>>>   and atomic64_*().
>>
>> Ah. And the caller uses say smp_load_acquire_long() or whatever, and
>> that resolves to whatever makes sense for the arch.
>>
>> The __unqual_scalar_typeof() does look pretty ugly when looking at the
>> preprocesed version but other than that smp_cond_load() etc look
>> pretty straight forward. Just for my curiousity could you elaborate on
>> the complexity?
>
> The nested macros with __unqual_scalar_typeof() make the
> preprocessed version completely unreadable, especially when
> combined with other sets of complex macros like min()/max(),
> tracepoints or arm64 atomics.
>
> If something goes wrong inside of it, it becomes rather
> hard for people to debug or even read the compiler warnings.
> Since I do a lot of build testing, I do tend to run into those
> more than others do.
>
> I've also seen cases where excessively complex macros get
> nested to the point of slowing down the kernel build, which
> can happen once the nesting expands to megabytes of source
> code.

Thanks for the detail. Yeah, looking at the preprocessed code (as I had
to do when working on this) it all really feels quite excessive.
Combined with other complex macro constructs ...

--
ankur

