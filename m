Return-Path: <linux-arch+bounces-13694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CECB8AC48
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 19:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906B21B215DB
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 17:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BB221D9E;
	Fri, 19 Sep 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xym9jlcA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LKb9raaF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9D3D6F;
	Fri, 19 Sep 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303098; cv=fail; b=NH3hvG1O/lYF1AU6GhY/775vrdf3Ei5d+tSwAhcBjiIU2ppqLm3fQxZPz5neHOBMNFIOpKIX0/jTATic7s4hSqs7dnLtIt1yFotrGw2LZjsChVcgDRM4XQAnQQdEB4ttUDurcT/rTJrhF68cDQ9HKaGAWB6tYlbLzUmj8OAyX2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303098; c=relaxed/simple;
	bh=jB2VJM62Hhz7pME4uQenmZYqQQhfqCS4jG3R4kXnJwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WTVJbIagmf+o/Vg5KyyqYtb0Bw5rxDuLeorlY7mzJtc9ZslJpIbyKVDupqhjPAyXV/9FrTZpaPKXzx+uQ/QC+JUFXjW0HvcWdSAn/H29GZF2sHqpyrulWnHATTe8W655nR03VaSqlA9moI4Bt0V0vm5Ep8jsu4XQ2e27RoKn+10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xym9jlcA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LKb9raaF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtwMA009128;
	Fri, 19 Sep 2025 17:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jB2VJM62Hhz7pME4uQenmZYqQQhfqCS4jG3R4kXnJwQ=; b=
	Xym9jlcAy2bbbPPCH+5trG2llzv92Xsp8GYUYqqBoa47LPgsu4SObzfFsW14l5yt
	VH46SZSvB0JDYj82bUMVuBpM9eSWnuaHuo9sCvp/jlqZZk7vGtLuGxrOVBGOGBNs
	0LSn0t76JLAJaVw4lSWCE5puACII8KBRGEdVoopOHsm1tfwqICutotls/+Z+GKQm
	PwXKDBwdnWzESv5rjTRi1fLmlPQdg5/pccFI64+FqG4IIirXVHA1HZv776G7gPD0
	eJ6opQqhjQ81kkGvVGcCQ24932kDUT7Cu75/vyKcBfmWKEACWP8bFpKR3qKxkwIa
	8VZCPFpT1eq9Gr+ILMzjBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxb60vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:30:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JGUSM9033697;
	Fri, 19 Sep 2025 17:30:45 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gpmnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFRbGaD5L9z1JkBlGT/LlN/Ft+YNaH9NFy0Ie59cw0YLz+4/H6G8wbjkZPxbH6UNjfyQhFG6WlbqOftfCEZBZ2OvVHhdou4/1kR4e0dqVTaDbtmd8vyYGN58QDCtcnxkcz9eNptERLJdN5aOMrEZEcuJKVoLG2aKg4uYG1MU46D8d2XAaWAKmjYyWLRkk7ok/NjeIuD7rMHJHfq+Ce49vHHIFdRluU/ZrYIfWWzeMWXzptcvXThXajPTTwh5j+VfJSs0gcyaUPNoinzWlLVvUzO4eo0UMlqGEK9vWDPc4II7VtiRT5LWN2U8yzJNaKuC/k4TWPq9VxcBKvJ/s3lofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB2VJM62Hhz7pME4uQenmZYqQQhfqCS4jG3R4kXnJwQ=;
 b=DXb54awbdYD9FIw//suI9Okz8+1YT28c7d/CFCKrhCt2+KSwPgLKUF2iYoXAV5+WFo5JxbouvNDCqiKk64uURt4z51H2T0xcGC3oQxysN8KvQCzFCe8PpVfAn/oI+XsT9QGUbjysHC5lzC/Qo9AtNRJMdaOIMHVN8icq+kDOAlJNNNMdICweRZs5ul2nopMaWTFeL6aJeOtOQza1Slm7XF0nDJDRIFiPyupleYCBV4Lypf+8/b/QhQhfrywy8Y6zsPtJsrY+Bm/T5YOMtLPKPLuixLl3hvwdpzWlJVFCDuF4J6FedRfsos2Qu53G7bcOl/MDbRhKz5v+i/IbJ/g5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jB2VJM62Hhz7pME4uQenmZYqQQhfqCS4jG3R4kXnJwQ=;
 b=LKb9raaFm16V0KYNecrYzqUHnKKFXREfrmeODJ0NSTI2gtOhveWB8Ox6pMPyAmp7HEFP5x8w9LanMdYhBUKkIM40z9afF/KUL+MHIxq7z1CDZwiIiavgVEOD+LCDyWC5hhGKntkBJAldXczJNTyuwkb3W7ezoVcpk/onuXoPfxo=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by SJ5PPF831D4660D.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7af) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 17:30:41 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 17:30:41 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Paul
 E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Florian Weimer
	<fweimer@redhat.com>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "libc-coord@lists.openwall.com" <libc-coord@lists.openwall.com>
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch 00/12] rseq: Implement time slice extension mechanism
Thread-Index:
 AQHcIRRQ6F4MTToGYU+vkRiA2yaxVbSOHuQAgABRXQCAARCIAIAAQm4AgAAw3gCAAScugIAJuMUA
Date: Fri, 19 Sep 2025 17:30:40 +0000
Message-ID: <0BF9AF0D-EA88-4504-99E4-BB3674FA588F@oracle.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com> <87a52zr5sv.ffs@tglx>
 <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com> <874it6qzd0.ffs@tglx>
In-Reply-To: <874it6qzd0.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|SJ5PPF831D4660D:EE_
x-ms-office365-filtering-correlation-id: 2a2dd4a0-588b-4ca9-1e3f-08ddf7a2415b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WTFnOVV5MGtTcW5MTlY2b1daSlRMckZHRkp5NVRoTlhMUGRraE4yeWJmTUlF?=
 =?utf-8?B?cXdaTUpoRWl0QmJBWGtkdXdSN0RBV1M2NDNQc1VGdW5VTldrR3NWV0JQaWl4?=
 =?utf-8?B?S2k2UVlMV1RPT1N3SmJYQXpEWXZCZ0FwZU9lTE5Zc2JpYzFtYTc3RVlSdjh3?=
 =?utf-8?B?TzNhQXdVTzlXK0p0WXN2VUdHTzhHS2dYcVBqRlpyeDNMRjYydld4UUdEd1BN?=
 =?utf-8?B?MG5hMEt3Nmk0U0FySDZvcTRHaHY1c0twenJlYzUwRlBucW5BcWVhcUN4aEdo?=
 =?utf-8?B?RkpoTU1tT3VOa0RwT2VVNnpDU0dpK0dIcFBWYmRaYTkvcWIvUGRCelF4OFF3?=
 =?utf-8?B?RmtSMEt5UTRjV2ZUY3ZaRkxMZFpDd3RTekJSOHRwbzJiQTBScVVmclpkYlFN?=
 =?utf-8?B?TGJxYXlNZG5GemNOcUJLTEhXWEx5d2tJbXlPZHU2WmQyY2lqaDRZNUIzYzdv?=
 =?utf-8?B?eFNxUUYvclFHb1NJTFFNK2M4Uy93dEtsa1p2amdOeEx3NytNS3MrRkFmQ2di?=
 =?utf-8?B?VHhvWm16SC9JdjdRcnIvUHpHNDlBZHJ2K2FIQmk1Y0ZhMWl5ejRlOXovdzR5?=
 =?utf-8?B?a1NYbnROKzA4c1U4d3RZSlBwMHc0QUpJWTNHWnVBdGpPdnprR3Vkc2xMeVVV?=
 =?utf-8?B?TlhSa0labkJUbzJEYkhNWm1EeHduTEFYdWYwNmNPN3BHNjZGanlhUnhQMEJX?=
 =?utf-8?B?VjRrQVQzaHlmbFc2WktoN3d6bkRRNlBKWGhYTjlLRVRVSm9GL1JzS3pGcldm?=
 =?utf-8?B?Nm5tSFVKb0VvUmJNSzRqdCtjNDhzQWFDdVpMQ3JUeDlIeXhGM0diazRBK0sz?=
 =?utf-8?B?dVZySW9Xb0MxcjlVMWhPZ2tZNGNpaXBDRS81NmJ6NVIzRVFrU2hDZE9wVDVo?=
 =?utf-8?B?S1QzYUg5YXh5OGZRa0U1RlQ5UkswcG04UTZxTFVBUzZudkNVWUNQdys4NDI5?=
 =?utf-8?B?YjNKeDM0Skc5djU1Tll0QXFtY0dRVi9IQkZQYkRyejJaQ3Q1UHdneDM5eE1S?=
 =?utf-8?B?UElkZVkydGxuYnhhNVl4VkxWRG5PYXkxOWZuVlAxa1NTT0N1U0F1WTRGT0N0?=
 =?utf-8?B?aXBlYm1Ma1d1eWdtdUFlelhwS2RPbSsyandHT0NLNkhPSTlsTWlFcklHbVN1?=
 =?utf-8?B?aHpVbHhHaHkvN2xlTUNKcUFLR2ZGQVhRbElNaVlkYlNnalUrYkgyQVV6WDhJ?=
 =?utf-8?B?OThxblJsMXZvNTZTUGVLNkoxZUVmRkMxemxpVzRnSEZHTTUwSmhLU3N4U2VV?=
 =?utf-8?B?WUViR3NMSUlFRVBIN0FxVDhQenJBbXZTcTZUYVNIOTZJOGRlWWpWWlNRc0la?=
 =?utf-8?B?SEJVQWlzQkJKRXBHYXM0M201UTNCVkVGZTJmZkpxWHM4WXdDcGdRakFNMEJK?=
 =?utf-8?B?Z05HSE5XejV5RVJFSmtMblFPQW82MHh5Y3c0YVBUKzdrOGZvNEdwc29XczFk?=
 =?utf-8?B?Z2Z5NEZXMVArZmc4b0ZodVBWT05sVUlUL0N5QW5QT1NISGk0ZmpNMlFDLzk2?=
 =?utf-8?B?aFRRcE0zenlmVjVKbmZzUzJZcnhXYWs2aGNKdFlYcjlKZzJzOHpWMjBmS056?=
 =?utf-8?B?NHBhTU1RR0RBODlqMVBJOVcwRWE1Y0ZZSVFRRE52ZHVGNU5NeTgrNm9OcVRo?=
 =?utf-8?B?b3JJRmdOck0vRUdtenpUOHV3c0NxNlhKLzRoem5WZCtCeGtGSGs4TDIxdFRp?=
 =?utf-8?B?RWltaWpMOUM5M3lJQVM4M00xYTVnOFIxMEF3VzdaTFNEQTlkc1N3KzV6bzRN?=
 =?utf-8?B?TldKakVYVGhPNUlJOFd5OVVyMFhvN2Q3Y1pDaW5hVWM0NTZjRVJSZjl1VnVX?=
 =?utf-8?B?L05ZNVBPcFVETzJXa0hod3oxZXdJVGNZTGJIak12SUNxVXRCenFxeVVoTWNq?=
 =?utf-8?B?N1VzR2JsZVdYT01aVkZpazM1UGwxbmZSQ3lqS2hlVW9QTGg5RVpzS0JNUUMw?=
 =?utf-8?B?UkhTS0RpSGZIUUFENlhLcFg1eDBUUjdYdEVEcXNWREdyd1didGtOSldFQWZw?=
 =?utf-8?B?UitmYlo4d1FnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?US9RUld5bUV4NlVIK1NEZ0liNFMvckYvYXlleEh1S2VOcGZvVExIZnBxd1dj?=
 =?utf-8?B?L3VSc3ZhdUNNS0xHNGFzR3F4QitZcWZMS01mNzlNbzBRbmk1SUxtdVBnWW5L?=
 =?utf-8?B?OVp6MXpVNmdmaGtBZDFMTzZ5Z1V6cmtCN3gxZi9ocGNaVGdJK1FHT1RFeXAr?=
 =?utf-8?B?RmljS2RPek5XY3NtRldyRitGaW95WWQ3enYwa3hpeGZqMkJmanVGVGZrclBt?=
 =?utf-8?B?MjF2QUYzOVJ0TWltSFd0Tjd0NGVIOFNmZm5TaWhvcFFwWGE5SE4vdFNoaFBK?=
 =?utf-8?B?WWFtbmQ1UlZ2eFVIOXJhWERRNmxZM055YmFNc2Fac2FBV2I5MjB4MnViSlli?=
 =?utf-8?B?Wmc5M0lzbEh6bjJncXdvK0Fxc3NzVVNNVjRERHcwdTB0Yi8vWlVFblU4RFRJ?=
 =?utf-8?B?Ukk2Y1N0OXQxWkpsa1ZjVnVxbjdwMWZRa2hlTWhaWjVLWW54MzRhVG5Ca2FJ?=
 =?utf-8?B?TDhxZzFwVDkzZDBKWWZTQ25keW12aHFMQVJEZ3Y1RGR4WWFBTzJwR1I4T0Iy?=
 =?utf-8?B?eGZIRERvLzNoTDBHTEUyVlNlU1RmSjJWSmpaWHBRam1aOWtmNXRrNE5taGlY?=
 =?utf-8?B?RnpOM2xyTVh1UXVkWU9ZWlRGb0hvSkFiRGgzUUhZQXRkbjZwQVE3STJoN0t0?=
 =?utf-8?B?NUxleGxUdlBqdVo2S2dMWTV5bDBITWRaWU5HVzZhUkhzWnRmbVhZbldaaCt3?=
 =?utf-8?B?ZFFONXQvNEhDc0JxZG9XaHB6QVBGTm1pM0VZREVFcU1iTVJtOUpGbEJhckV6?=
 =?utf-8?B?LzdMRG5wem8rTUY2Nys3ZzVMV0o1bGNLUjFac29GNjVhT0lzeVU5Z29RTjRk?=
 =?utf-8?B?cUVFNnYzQS91dmRpZzdwdlh0T3IzbmUrUnFHdkJCdVYvcHZlUE1iWC9FckZ4?=
 =?utf-8?B?SzB2YzdQMHhxUDZRRk0yS0JLYkIyNjRENXZCYWFPYjhQSnRWQmRHOG1ka1d5?=
 =?utf-8?B?OHVZRVVHeG92Tm0xWWIyUVdhckJxc2x1WGI3VXFvWXM2ay9PcUJYMlNCblh5?=
 =?utf-8?B?VlQ5T054MytINnZhbEltNWVDK2RqUWVpRWkwdi85QjVQb0dUdEdENlNtUXJh?=
 =?utf-8?B?RmUrL1BXS2NKUnpJUWZGazBHYms5YVE4NFZxK1hZRCt6cnF3ZHdJVHA0MWtS?=
 =?utf-8?B?S3ZHZjlvOElTR1F4MGFCTzEwS2xscTVIL3dzTy9NWWJzREFEMnQwOXZsTXJJ?=
 =?utf-8?B?VlU0YnlUTURuZ2llaW0wM3dLWEw3U2I2bHF2NXYyRnM5WWsxUkU4c3JDcjlU?=
 =?utf-8?B?aitMaXdhUzB2ZHRHZWVYaVJ0MVRhSmJRdGNzWW83WVNYc3NjYTUwVVNucTll?=
 =?utf-8?B?N3pPRS9Ja2ZYMTljQ2xya29ScjUxcXA5Ti8zdTZpemhDOXYrcENTVVNkb0VL?=
 =?utf-8?B?Y1huaS9EdFh0NHM1YXptbFp4ZDVGNkdJSXNiampKMVFlY2FieFFHaEF1THpy?=
 =?utf-8?B?dVJHcmZ4b25PbWs1WVFsaXovUVBUSnN3WHgwTjJldUhxbmZmV1NYZXMvVGhK?=
 =?utf-8?B?YmJscE1lZ2NwbWMxdDBsSjBERDFLdEtnbUtaZ3BwaTJNeStSYjFiWnA5REhI?=
 =?utf-8?B?eUdYMEtma1VCZ2RrT2t5T2ZFZ3JpQWNoN1lhaUJVMGNQcXBFUitQbUFWSkpu?=
 =?utf-8?B?RkJVMDVpbUxZa3p2RHdGT3ZXZWV6WmVMNW1CbzZZdEdFQlBGZU5FeFR4RFlt?=
 =?utf-8?B?RTB1Um9aWFFOYlk2cFRuSmNWWTZlR3YrbWZva1ZwamVSZG9kUElvYXBmakpx?=
 =?utf-8?B?VEYxRHgyYXMxeWVMbGszVXlSd1NnV29Hcitkai84eTRFb2ZLZ2RXYTVFYUc3?=
 =?utf-8?B?aklzUFNHNmE4ZmFvbFJCZjA3MEIvTysrQ2RELzMxNFhzd045ZDVQZkFaV2hp?=
 =?utf-8?B?WGtJZEMzMEFrZ3Z1d3ljWGU4ZGlNMVEybnYrNUhYbDkyZ2FqUlNRWHU5ek95?=
 =?utf-8?B?VWZQQnZ6T0JJQmZZcDBBcTR1bXNyTHBJR0l1VFlTaDhlT3hhaEkzUlJJbkhF?=
 =?utf-8?B?WnladWhOaE5KZk5leE50NFVteEVMTkgvR0hpTGtRNzJDU0dSblZQN2NyTDdJ?=
 =?utf-8?B?UmNyWGhUY1F2cU5CQ2FGQUhpdDk0T1NrS0JBOHhDd0R3WHlCSmNrQ0F0eVc0?=
 =?utf-8?B?WXEwOVJvSjVKbFhnYXYxd1ZwakREd1dzZTF6RFBRT0NFWE5pRFVvbDRHTUtL?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A522A966050AB245B50FEC5A7D36EA2A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rqqBq8ot9qyRXEsCK/QITJ2Ww1UdzRjuuMQIXgbZ8TQdTSw2UekV2gaptP7d987m0U+r14cP3vdB7i6LiQ0H1y2eYZLeSgTD7JmHkaJHOzCICW8ji0QPjM46rnvn5dStK8OMatlhfx0xRGLMeVbOTxCdxprdsmyzy5ePGWSE0sKu29mjvqdNDxFZIxwX4mCUyuzxI+sq1vVfM9jmC7W6Ffzs+UfV9k2jYFY3sqYZtHdsr1W8yLH5L8g3y4snOXN4yFDC3dBhQ+JmGRWK1KK4YkgjMfCVYFoFVPDqCI/SlqTy7ROJzIxMpH7sFzUQrzlcM1ho5gghzYG8+kBMYvZiW+26x0L3EoRMQ+3wCHM0C2HfHMhtaIhs/svORGs2Rtb2bklo9Eun9tlQhVwEg9PQZGmaCVWLjs1l74kvaxfeBhYVqvlqscZpn6KYIHz4aoiQhG+RihAR9WrTHWVjlg7Hn4My3GBLvNNS/RAXWjmnwFz2flda9gAGNV1w0A8Z64YoZT63bFQE0HWAWEr+Syvc20HZyJdWbTPjJLdtGhM5z+dgySfGapIGE/F1Vycm0QihoRCiKItyAoF01/lCIdS8bbHxLlM0kpCnwEeIgGFDFq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2dd4a0-588b-4ca9-1e3f-08ddf7a2415b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 17:30:40.9622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qD7xSROnUCA+kFF57TcFlb+3ASpo90vLsxTeTClIzhvvs8PF4kaXh1pvqWqrCPVh1qF/34UkQds7qJARcKxrrQKGLwrZKiWhXx9WCAsEL6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF831D4660D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7eTXmk7H2VZ9
 gLB2XWhfNCwxjhDLidJ1RrgFza33l6EFvACt3I0Yg+l9rEBE5i+htJS2RqpzHgmVrcMRKquGLNj
 XRCqZb+hCxzC04hYmWfFc0pr7HA4xsHSHrGyTu0R8bZEWP+blBiAxbr6bRCP6S4JSoVnVOipyKg
 96R7PTU0d2clnM8J7CCdTH1fwWwEJmmIJFqkvJDZqQXcvfUbsdM7wqtXtlRZ3HNjfHAEvq68/W0
 KDpSU0Sd9txjINZrboEoFVgWe08n1nM2ZdzPruM80hQtDbb6RUnhVRP9sxOjFn3vfBEqcX2EnaV
 UuZH/K58f6b96lqJuMWQsr3QQpiAlQ5ZwCJPDmSm9E6UMpbN7rwxu3LKjk9/6+L373O9Ba7Cba8
 UxngSHmV
X-Authority-Analysis: v=2.4 cv=KOJaDEFo c=1 sm=1 tr=0 ts=68cd9346 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=-NTrPL43UqBZmBr_ZAgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EcelY5XiiQmWsGSrIxVzeUzioNYwaoH9
X-Proofpoint-ORIG-GUID: EcelY5XiiQmWsGSrIxVzeUzioNYwaoH9

DQoNCj4gT24gU2VwIDEzLCAyMDI1LCBhdCA2OjAy4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgU2VwIDEyIDIwMjUgYXQgMTU6
MjYsIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPj4gT24gMjAyNS0wOS0xMiAxMjozMSwgVGhv
bWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4+PiAyKSBTbGljZSByZXF1ZXN0cyBhcmUgYSBnb29kIGZp
dCBmb3IgbG9ja2luZy4gTG9ja2luZyB0eXBpY2FsbHkNCj4+Pj4gICAgIGhhcyBuZXN0aW5nIGFi
aWxpdHkuDQo+Pj4+IA0KPj4+PiAgICAgV2Ugc2hvdWxkIGNvbnNpZGVyIG1ha2luZyB0aGUgc2xp
Y2UgcmVxdWVzdCBBQkkgYSA4LWJpdA0KPj4+PiAgICAgb3IgMTYtYml0IG5lc3RpbmcgY291bnRl
ciB0byBhbGxvdyBuZXN0aW5nIG9mIGl0cyB1c2Vycy4NCj4+PiANCj4+PiBNYWtpbmcgcmVxdWVz
dCBhIGNvdW50ZXIgcmVxdWlyZXMgdG8ga2VlcCByZXF1ZXN0IHNldCB3aGVuIHRoZQ0KPj4+IGV4
dGVuc2lvbiBpcyBncmFudGVkLiBTbyB0aGUgc3RhdGVzIHdvdWxkIGJlOg0KPj4+IA0KPj4+ICAg
ICAgcmVxdWVzdCAgICBncmFudGVkDQo+Pj4gICAgICAwICAgICAgICAgIDAgICAgICAgICAgICAg
ICBOZXV0cmFsDQo+Pj4+IDAgICAgICAgICAwICAgICAgICAgICAgICAgUmVxdWVzdGVkDQo+Pj4+
ID0wICAgICAgICAxICAgICAgICAgICAgICAgR3JhbnRlZA0KPj4gDQo+IA0KPiBTZWNvbmQgdGhv
dWdodHMgb24gdGhpcy4NCj4gDQo+IFN1Y2ggYSBzY2hlbWUgbWVhbnMgdGhhdCBzbGljZV9jdHJs
LnJlcXVlc3QgbXVzdCBiZSByZWFkIG9ubHkgZm9yIHRoZQ0KPiBrZXJuZWwgYmVjYXVzZSBvdGhl
cndpc2UgdGhlIHVzZXIgc3BhY2UgZGVjcmVtZW50IHdvdWxkIG5lZWQgdG8gYmUgYW4NCj4gYXRv
bWljIGRlY19pZl9ub3RfemVybygpLiBXZSBqdXN0IGFyZ3VlZCB0aGUgb25lIGF0b21pYyBvcGVy
YXRpb24gYXdheS4gOikNCj4gDQo+IFRoYXQgbWVhbnMsIHRoZSBrZXJuZWwgY2FuIG9ubHkgc2V0
IGFuZCBjbGVhciBHcmFudGVkLiBUaGF0IGluIHR1cm4NCj4gbG9zZXMgdGhlIGluZm9ybWF0aW9u
IHdoZXRoZXIgYSBzbGljZSBleHRlbnNpb24gd2FzIGRlbmllZCBvciByZXZva2VkLA0KPiB3aGlj
aCB3YXMgc29tZXRoaW5nIHRoZSBPcmFjbGUgcGVvcGxlIHdhbnRlZCB0byBoYXZlLiBJJ20gbm90
IHN1cmUNCj4gd2hldGhlciB0aGF0IHdhcyBhIGZ1bmN0aW9uYWwgb3IgbW9yZSBhIGluc3RydW1l
bnRhdGlvbiBmZWF0dXJlLg0KDQpUaGUgZGVuaWVkIGluZGljYXRpb24gd2FzIG1haW5seSBpbnN0
cnVtZW50YXRpb24gZm9yIG9ic2VydmFiaWxpdHkgdG8gc2VlDQppZiBhIHVzZXIgYXBwbGljYXRp
b24gd291bGQgYXR0ZW1wdCB0byBzZXQg4oCYUkVRVUVTVCcgYWdhaW4gd2l0aG91dCB5aWVsZGlu
Zy4gDQoNCj4gDQo+IEJ1dCB3aGF0J3Mgd29yc2U6IHRoaXMgaXMgYSByZWNlaXBlIGZvciBkaXNh
c3RlciBhcyBpdCBjcmVhdGVzIG9idmlvdXNseQ0KPiBzdWJ0bGUgYW5kIGhhcmQgdG8gZGVidWcg
d2F5cyB0byBsZWFrIGFuIGluY3JlbWVudCwgd2hpY2ggbWVhbnMgdGhlDQo+IHJlcXVlc3Qgd291
bGQgc3RheSBhY3RpdmUgZm9yZXZlciBkZWZlYXRpbmcgdGhlIHdob2xlIHB1cnBvc2UuDQo+IA0K
PiBBbmQgbm8sIHRoZSBrZXJuZWwgY2Fubm90IGtlZXAgdHJhY2sgb2YgdGhlIGNvdW50ZXIgYW5k
IG9ic2VydmUgd2hldGhlcg0KPiBpdCBiZWNhbWUgemVybyBhdCBzb21lIHBvaW50IG9yIG5vdC4g
WW91IHN1cmVseSBjb3VsZCBjb21lIHVwIHdpdGggYQ0KPiBjb252b2x1dGVkIHNjaGVtZSB0byB3
b3JrIGFyb3VuZCB0aGF0IGluIGZvcm0gb2Ygc2VxdWVuY2UgY291bnRlcnMgb3INCj4gd2hhdGV2
ZXIsIGJ1dCB0aGF0IGp1c3QgY3JlYXRlcyBleHRyYSBjb21wbGV4aXR5IGZvciBhIHZlcnkgZHVi
aW91cw0KPiB2YWx1ZS4NCj4gDQo+IFRoZSBwb2ludCBpcyB0aGF0IHRoZSB0aW1lIHNsaWNlIGV4
dGVuc2lvbiBpcyBqdXN0IHByb3ZpZGluZyBhbg0KPiBvcHBvcnR1bmlzdGljIHByaW9yaXR5IGNl
aWxpbmcgbWVjaGFuaXNtIHdpdGggbG93IG92ZXJoZWFkIGFuZCB3aXRob3V0DQo+IGd1YXJhbnRl
ZXMuDQo+IA0KPiBPbmNlIGEgcmVxdWVzdCBpcyBub3QgZ3JhbnRlZCBvciByZXZva2VkLCB0aGUg
cGVyZm9ybWFuY2Ugb2YgdGhhdA0KPiBwYXJ0aWN1bGFyIG9wZXJhdGlvbiBnb2VzIHNvdXRoIG5v
IG1hdHRlciB3aGF0LiBOZXN0aW5nIGRvZXMgbm90IGhlbHANCj4gdGhlcmUgYXQgYWxsLCB3aGlj
aCBpcyBhIHN0cm9uZyBhcmd1bWVudCBmb3IgdXNpbmcgS0lTUyBhcyB0aGUgcHJpbWFyeQ0KPiBl
bmdpbmVlcmluZyBwcmluY2lwbGUgaGVyZS4NCj4gDQo+IFRoZSBzaW1wbGUgYm9vbGVhbiByZXF1
ZXN0L2dyYW50ZWQgcGFpciBpcyBzaW1wbGUgYW5kIHZlcnkgd2VsbA0KPiBkZWZpbmVkLiBJdCBk
b2VzIG5vdCBzdWZmZXIgZnJvbSBhbnkgb2YgdGhvc2UgcHJvYmxlbXMuDQoNCkFncmVlLCBJIHRo
aW5rIGtlZXBpbmcgdGhlIEFQSSBzaW1wbGUgd2lsbCBiZSBwcmVmZXJhYmxlLiBUaGUgcmVxdWVz
dC9ncmFudGVkDQpzZXF1ZW5jZSBtYWtlcyBzZW5zZS4gDQoNCg0KPiANCj4gSWYgdXNlciBzcGFj
ZSB3YW50cyBuZXN0aW5nLCB0aGVuIGl0IGNhbiBkbyBzbyBvbiBpdHMgb3duIHdpdGhvdXQNCj4g
Y3JlYXRpbmcgYW4gaWxsIGRlZmluZWQgYW5kIGZyYWdpbGUga2VybmVsL3VzZXIgQUJJLiBXZSBj
cmVhdGVkIGVub3VnaA0KPiBvZiB0aGVtIGluIHRoZSBwYXN0IGFuZCBhbGwgb2YgdGhlbSByZXN1
bHRlZCBpbiBsb25nIHRlcm0gaGVhZGFjaGVzLg0KDQpHdWVzcyB1c2VyIHNwYWNlIHNob3VsZCBi
ZSBhYmxlIHRvIGhhbmRsZSBuZXN0aW5nLCBwb3NzaWJseSB3aXRob3V0IHRoZSBuZWVkIG9mIGEg
Y291bnRlcj8NCg0KQUZBSUNTIGNhbuKAmXQgdGhlIG5lc3RlZCByZXF1ZXN0LCB0byBleHRlbmQg
dGhlIHNsaWNlLCBiZSBoYW5kbGVkIGJ5IGNoZWNraW5nIA0KaWYgYm90aCDigJhSRVFVRVNU4oCZ
ICYg4oCYR1JBTlRFROKAmSBiaXRzIGFyZSB6ZXJvPyAgSWYgc28sICBhdHRlbXB0IHRvIHJlcXVl
c3QNCnNsaWNlIGV4dGVuc2lvbi4gIE90aGVyd2lzZSBJZiBlaXRoZXIgUkVRVUVTVCBvciBHUkFO
VEVEIGJpdCBJcyBzZXQsIHRoZW4gYSBzbGljZQ0KZXh0ZW5zaW9uIGhhcyBiZWVuIGFscmVhZHkg
cmVxdWVzdGVkIG9yIGdyYW50ZWQuIA0KDQo+IA0KPj4gSGFuZGxpbmcgc3lzY2FsbCB3aXRoaW4g
Z3JhbnRlZCBleHRlbnNpb24gYnkga2lsbGluZyB0aGUgcHJvY2Vzcw0KPiANCj4gSSdtIGFic29s
dXRlbHkgbm90IG9wcG9zZWQgdG8gbGlmdCB0aGUgc3lzY2FsbCByZXN0cmljdGlvbiB0byBtYWtl
DQo+IHRoaW5ncyBlYXNpZXIsIGJ1dCB0aGlzIGlzIHRoZSB3cm9uZyBhcmd1bWVudCBmb3IgaXQ6
DQoNCktpbGxpbmcgdGhlIHByb2Nlc3Mgc2VlbXMgZHJhc3RpYywgYW5kIGNvdWxkIGRldGVyIHVz
ZSBvZiB0aGlzIGZlYXR1cmUuDQpDYW4gdGhlIGNvbnNlcXVlbmNlIG9mIGNhbGxpbmcgdGhlIHN5
c3RlbSBiZSBoYW5kbGVkIGJ5IGNhbGxpbmcgc2NoZWR1bGUoKQ0KaW4gc3lzY2FsbCBlbnRyeSBw
YXRoIGlmIGV4dGVuc2lvbiB3YXMgZ3JhbnRlZCwgYXMgeW91IHdlcmUgaW1wbHlpbmc/DQoNClRo
YW5rcw0KLVByYWthc2gNCg0KPiANCj4+IHdpbGwgbGlrZWx5IHJlc2VydmUgdGhpcyBmZWF0dXJl
IHRvIHRoZSBuaWNoZSB1c2UtY2FzZXMuDQo+IA0KPiBIYXZpbmcgdGhpcyB1c2VkIG9ubHkgYnkg
cGVvcGxlIHdobyBhY3R1YWxseSBrbm93IHdoYXQgdGhleSBhcmUgZG9pbmcgaXMNCj4gYWN0dWFs
bHkgdGhlIHByZWZlcnJlZCBvdXRjb21lLg0KPiANCj4gV2UndmUgc2VlbiBpdCBvdmVyIGFuZCBv
dmVyIHRoYXQgc3VwcG9zZWRseSAiZWFzeSIgZmVhdHVyZXMgcmVzdWx0IGluDQo+IG1pbmRsZXNz
IG92ZXJ1dGlsaXphdGlvbiBiZWNhdXNlIGV2ZXJ5b25lIGFuZCBoaXMgZG9nIHRoaW5rcyB0aGV5
IG5lZWQNCj4gdGhlbSBqdXN0IGJlY2F1c2UgYW5kIGZvciB0aGUgdmVyeSB3cm9uZyByZWFzb25z
LiBUaGUgdW5jb25kaXRpb25hbA0KPiB1c2FnZSBvZiB0aGUgbW9zdCBwb3dlciBodW5ncnkgZmxv
YXRpbmcgcG9pbnQgZXh0ZW5zaW9ucyBqdXN0IGJlY2F1c2UNCj4gdGhleSBhcmUgYXZhaWxhYmxl
LCBpcyBvbmx5IG9uZSBleGFtcGxlIG9mIG1hbnkuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAgICAg
ICAgdGdseA0KDQo=

