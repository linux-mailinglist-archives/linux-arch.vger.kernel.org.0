Return-Path: <linux-arch+bounces-13718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6015BB93C41
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 02:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150613B5BE4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 00:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7D91C7015;
	Tue, 23 Sep 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAibh9Mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f27uJ3n7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EE38FB9;
	Tue, 23 Sep 2025 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589088; cv=fail; b=mpOnOjFqvUNHAek8zAmAUe7nIGEUvmbbfNisThxaHUebknWiYAE19rZbkFsUMWOtBUlYHHMf+4YTK58xtvcsdWWoEr1e/vpO5veK6BJ4RfuNNrWisvHTdpSpU/CdERAisJaOYvfWGu8ZYx7tz4C3nN0rddMSypO1XZpT+bSVjDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589088; c=relaxed/simple;
	bh=mdWtK4XG5h4aC3WvLQsl4VEwkgvrcyszv/9irBJyvVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNJ/vuGv4s5zsNZsfl13OI4X9rKz4xd2aoUFpcH7x9j4CZINM7RXaD8D1Ls0fL++sXdtFvH2u+8irPxHaIBNyiJF+La/7wFYWp2xv9/80AMth0tZeEOFf6C1ZJYA4/PQj2h1MqamK1zauy/KNnSX6u/ImNJ/dLlbJE/+L4Cfwig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAibh9Mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f27uJ3n7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MNBqTw002835;
	Tue, 23 Sep 2025 00:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mdWtK4XG5h4aC3WvLQsl4VEwkgvrcyszv/9irBJyvVs=; b=
	HAibh9MbgaysXbnOXXRJn15F9Ni9p1k97PT5upw059afizY5zjHCzyUtkygLXEBC
	twKURh6Wb0z7OQQ9cYG5pyb3c7SsVgCzpDoA7XecuolnmUpG5k3OWswKgugUHylP
	VD5j7KBYlO2om9+NX3vaNpx0Nq2LyUD/YG7HzjH9ic8zhKvh/MBsHl0bz2gs0mbA
	+T4/caKgQD6pYMKk/lNpmYvarDXVY4WdoP9QLuwGFB4M6xXL5/Uf8qbxKjytPzM/
	HOfvNn8kJja7aYKA9QT5oGPQwyMVM65cQD9INNaNNk3LK9HHBlAuL202bpouAzPk
	+P1GoSYY2NpGcJcqRnLsQA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdkhws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 00:57:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MNbbbR028429;
	Tue, 23 Sep 2025 00:57:45 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq7smcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 00:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5UnAcT93oEJwi2zkICf1QyEdbaqFgMLrryHXkHYOoWIJ8PLqkfuvidZu2I4vv9HQDmAB7hB3R7mBbWIE5gpSkb6GvR3kIBNMhOURrMUE9PwgxDDqeAj4KQP9M+KORfWxOdKxDK4t2s/FcsuiKL3iZ44lpK+PCDPoLxPkMoMf4Qs7FxkALcCynDgDcx2VtsTFKoTQ+aSEzL1wM90HdQBlm6S4f0MxQd6vnZ99uHh+qMn13/8xl432LO2yQyujqQSvRstrjR+msCkt2H4OBAvpJ4svtyFUZrFhijG73PGv2/VT5Ia5XCW+lHR10p/T17YeElTStMDJ3mkpx3jf1D4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdWtK4XG5h4aC3WvLQsl4VEwkgvrcyszv/9irBJyvVs=;
 b=Oer3sN2phRhw3f5cJRMZWhU9Vtle1nFfQ4oXOoHE8aosO4Tu/9RaspmmUCtFrLE4wmtxw95Or18PBgXY6ooBvTnwf3AWqZMGK6Ifb78/mdAl9PaIto5AhL+Wr4b1Q4pAm/2ALwqtcevu3J2FaJt+XJCFHoOG4h4ymHVU+w3fDDlmNsIwGr46PpCogYs+26GrIjEw2DvQJuLJgfGhuTRxOophQ2IJjlFQJJMcJpC7nVRUkqFCsOIBoU9sP1zz5enp2uQu62K7Z2BrMAx74GrfZ9hMHbqMg0y7G3fHW2tmGBE2T8agrgvbBLaHCIDoF+3wYZ4uy+oH129XzESJZCu+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdWtK4XG5h4aC3WvLQsl4VEwkgvrcyszv/9irBJyvVs=;
 b=f27uJ3n7obJVY4zjfSbUpJnODyvPej5hCGZGzpSLrXz/J0ZrNf/wJTQPIsX8exD6p40y6InGRq7YNVBthO2lEU5MwcpIbwZzFFnlvrYySKAy7cPQJiWjVRUl/aeV6/8BaK14y7rig3+8+iOEqcaqIXg++sIXXKnTSCuHMJxr5Ho=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by PH7PR10MB6201.namprd10.prod.outlook.com (2603:10b6:510:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 23 Sep
 2025 00:57:42 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5%4]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 00:57:42 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        K Prateek
 Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Topic: [patch 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Index: AQHcIRRRjeNzxyNt9EyaVRMsclvzdrSewVyAgACNeoCAALkUAA==
Date: Tue, 23 Sep 2025 00:57:42 +0000
Message-ID: <C03529C4-4431-4702-BAC5-68823A65AD6D@oracle.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
 <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
 <d4b25a25-f336-40eb-b9de-3e370050b60c@efficios.com>
In-Reply-To: <d4b25a25-f336-40eb-b9de-3e370050b60c@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|PH7PR10MB6201:EE_
x-ms-office365-filtering-correlation-id: d72edb5b-dd4f-44ca-4a9a-08ddfa3c336c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TncxOEQzMkFMY3M4T2dQTVpGUnRqdC9TeGlMLzBvb2tsRFhPMUVRQ2NLTUVw?=
 =?utf-8?B?WlNYQitpZmFNTFN4Z1kzU2phaEo3NlorMXh1RXNmTDdMMWRlUVMvSHU1SE5P?=
 =?utf-8?B?YzhiOFdZbVVwVXFMZE5vVU9wOThQMDVCWjhXZXNIemdrNms3azB3M1hIL3Jh?=
 =?utf-8?B?US9DUFpZUmJsMWNIekxxTGtSZjQ0R1dLMkN1QkJ3aGRMYXVFMnVTeW1Xa2lM?=
 =?utf-8?B?YVJtT2RPNGZXT1FXY1dvTzIvKzFnNTZjY1Azb01hTzRta01aN0pWMVBoUTQr?=
 =?utf-8?B?K20zd0lkKy9lMCtzS3JDREFCYk1BZThVK1BkRTZkT2xMSTg4ZFE2d1dwenM0?=
 =?utf-8?B?MDRaYmZCRjF4c2NDcUZkMEVKeFRBU3hqZVhxeEs2a1lrMjFGRUJWemdtb0tp?=
 =?utf-8?B?alFCNFNSZlVQUmZjdHl4RnRGUkt6NDIxYWthNjdvTFpOdXZCdUZ3WlFmYW1S?=
 =?utf-8?B?SUhGS3lRRGxvYjF6R1J2UEErVUJDczZUcTdGN2N2dlpaRkIvei9MSkF6Qnc2?=
 =?utf-8?B?SGU4NjhrUkxaaE1SeHVNWEh2M0ZzMk9ycWR2Qkc3SHNuM2hvdDA5OGhON2tM?=
 =?utf-8?B?LzZOWnZaeHF3R0tzNXpFNDlxVVVoV0ZaWHMyL2JpRFpQRTN0b2ozaVJuZDVm?=
 =?utf-8?B?b2tBZExiNmFnOXk1U2VTaHAwKy9KbUhsNXkvUnFOYjh0dlhDQmRVRzhBMHZJ?=
 =?utf-8?B?dkJRajhjbG12a09DM0pnN2NuenVhL2tuRDN6WkZmS2VKYUZaMExNWnVVU0Vl?=
 =?utf-8?B?Nm1oNkhwb0hraVhwZmV2dFFxMkV0TktzMW82YmJ6ZVgrYmVVZ1QyakN6N0t6?=
 =?utf-8?B?a3RxMnZIRVowWlFmdWIxZXdUTTdyY3lSdE52Si8xNDVFdERocm5TWmltczVy?=
 =?utf-8?B?T1h5S05sVzJKeFVCcWJqbXNxVjhUdXJGNGxLaE1PaXg3UUx1QndLREZRNGoy?=
 =?utf-8?B?RVRJS0pFRzRUeDFDWFh2d0JERWZHbXlFUEFJSnpUaE5xZWlTemNuVVRCM1NL?=
 =?utf-8?B?UGtpWjhYQSthN1lLeitRajE3amFtb0tkK3NuMTV6MkFKbk1STXJKdjZMMjM4?=
 =?utf-8?B?VDBjdFhuWXA2ekgyTk1nTGFVVlJ1dWJOanoxZUxnMTkyb3dsbC9Xc09xR0ZV?=
 =?utf-8?B?Mjk1UE9FT1RlSGV5ejRwa1RJNU1VWTM0MDdCSVg1WVVSRWxuTkFocDUrUFJ3?=
 =?utf-8?B?TVpIenBIeThPSkRlNTlKQzVsWUNFTjJMTk9vc2pNSE1jSFRXblBLVlBSeVJz?=
 =?utf-8?B?N2cxRVczV0d1aXZJamJOV0FJUFg0SkJocnYvaUdOd0RsNDd4dG5seE04azhU?=
 =?utf-8?B?ODF4SGVwSjB2K1BGNkdtVHNZbEhvd1ZlcEphNDNWOHNSQlIwUUNuNXJLWTZQ?=
 =?utf-8?B?OFdCVzR0T2pVa3BYdDRiTkNIZ1AzYklJYkthSjZMd1FjcXNmbkN3Y29WZzJh?=
 =?utf-8?B?WXp0VDdLWWsxZjdsNTFDa2tPMlpJZzU3Q0JhRDhjSWR6R2dVd0tLczdoRUFs?=
 =?utf-8?B?SXAvbG54Y2lVMDBqalhNRjdRVW55LzZNM0pkQkVVbEtVcG9jUmxyWGJFQmJK?=
 =?utf-8?B?Nk9QR2QvVnQ0eEZpQWFwSmZoTklRcGIrb0JnNzM4NFFvYXhZMXU3Rm1Gb3lz?=
 =?utf-8?B?eWhSUHora0d6OW42MExaYlprc1BaMjlOZmMxSTgyZ0l3d1JoWlNDSUVIMHVE?=
 =?utf-8?B?NmE1OVNPZTlMRFhXQ0FKNjFuMEFmbjExdWJyVEZFc2RleWoyODJYQW1ud0ov?=
 =?utf-8?B?RTdhaXVrVXVQRjRSeEltWXAzdkpwSGcxL0l3NkQxSWZKM0lKMkZSTVF4ZUM4?=
 =?utf-8?B?eTYrdjlzSXpBU2ZtblBibWNiUEtyNDA1M3UrYjlCUzEvcWhBR1ZycUF3OEpa?=
 =?utf-8?B?Q3ppeHJ6bWtqWFd5VXdPTGpMMlQ0cWNXeXd2RzVZSDIweDZ6MlpGbDNYR2tN?=
 =?utf-8?Q?ROqKhByTLHTXJpPZbdzs6/CRHiX1k5hM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2dPNlJxYzZqZ3E1dktBMXBHeGlpdHRWRXNaSVFuZlY1clFKTnFoZHdhODVL?=
 =?utf-8?B?SlRvN0hSYkNyT05rUTZiSWhLR0pVSFBuL1R6S2hBb0ZtQ2pxNmYrMkd6WGw4?=
 =?utf-8?B?YVlmZXhoQnUxSi9EOUpYNDl3KzJyZm5Pc0MyMXFVa3VjNHplUGJxSkdFRDV5?=
 =?utf-8?B?RzdMckxtVlpvUWpUSitFR1ZRblV4VmlHYWRadzUrRWtvZnJrNHZlemZiU2dF?=
 =?utf-8?B?ZHF1UUx1WmxOQlRNS0tpY2pJTm90cVpoUE8xdFZmVnhIdmVEMU51SEIycEh3?=
 =?utf-8?B?NFA4MzZ6V0luVHRPOENTeHdSN05nNmszT3p2RzRxb0hRTWE0NFBjYVFFUnR1?=
 =?utf-8?B?NkdGaC9tVjNmc1dhKzNzaitTa3N2VVEzUkNScWtZUGhXUUFxWVVvKzY3eWRN?=
 =?utf-8?B?WFR6QmtTTldoY2szY3A1L1BZVFEzd0hDSTVGMEhmcW4xSmlQU3J3SThLd1pT?=
 =?utf-8?B?eGxyV0tsV050ajU3L0ZwQU1nMjRWeTg2MWhFWjM2WStvNnJNSmVNaWJyRHQz?=
 =?utf-8?B?aUZ1SzFoM2tOYXFEajZ2K0VWYk8rZUQxZTVDUk9mUGh4YXpRNmZhb0ZvTWZL?=
 =?utf-8?B?YXRpS2dpSExYRUsvUzdPUzJhNnB0V0Z4bXNoZWRMbGtVMTByeGtkdXlRcXNa?=
 =?utf-8?B?UmpOc0V1S1MweWxZRitQS1hFOVBoZy9BQ2dsNlJObG82bXdoOWhVaG9PWWJq?=
 =?utf-8?B?dTlwSWRoMEFpZkg3M1lwbFhVSGUzc0kyMHV1SzJaaEJDWW55eUwxY1puYmIx?=
 =?utf-8?B?T0N3L3ZtdDh0dWtuTUJWcjhaY3YwZWJMZWNUNGFBZTAyR1BEbWs1WUMrSURu?=
 =?utf-8?B?VDFnQWNsQ0k4elNVUzdmYVdOK2d1THhwOHByNGFwWFFKVUJqMlF3MVU3SUZ2?=
 =?utf-8?B?aGVpbEJ1Slp0Tk5vaGsvZWNITWFLY2ZIaWhEYTdkUys3WTlnU0xrUitncDY5?=
 =?utf-8?B?bWJvRnRvVmdncnRWOTN4bS9xUXpPWENndDhjRWNrQlg0dkxUVHVxc0lIeVZm?=
 =?utf-8?B?NEU1Nmora2lDSGJSZmRlbXJ5Q3doT2xtVnNhL1d0dEFOeTJIOTdnVHpZNGh6?=
 =?utf-8?B?U3gzVWpWTlovR3E2RnlIUXVOWmZWWW1Zem00SFozRXZtQW1KWm81UUcyT0ZL?=
 =?utf-8?B?dlhhRE5UZnNPdjZaQzJPcWVLWktzY0lqaEtvcit3Unc1a0RDYW03MTRGOXhi?=
 =?utf-8?B?UmpaeHQzSG9xbE82S0ZlUXFaZ05URWszR09xT3dqR3h3YUx2WnJTZnJqYXUv?=
 =?utf-8?B?alp4UzRxOXhjaE94TXhYa0ltS0UwVThoaldVZFViV0FLaWMvcWR5SVFnNkwy?=
 =?utf-8?B?YUhuU1crbjFoUXJ3aDNIa2t5M2h0QWJHTVRhV0hESnBFUCtYMXl5WVJCRmxI?=
 =?utf-8?B?K1JZTTFCVUYweGJoamJGdzg1dExwR0lCVmduSDdpeHdpWVZtMnFWZzlkMHN3?=
 =?utf-8?B?azM3eFNXN0s2M3VMMjNER3B4UmxJanJ1RGFZOVNYWFhtNXpuODRmQkZzZGY1?=
 =?utf-8?B?YjRtMUZocHFTaVNTTDNHT0RWak5qRFVUZDVqY3AxL1hPbFVLeGdUbC9VY0Vs?=
 =?utf-8?B?TTRkaSsvd040QUsxa2JLV1U1TXkvYk1iaS9rZkV1U2htS05qcnI5NlZsNDRl?=
 =?utf-8?B?VDFORHE0aXU2aHlMamp0ODY4czEzR05OemNvTVlaSUo5cVVJVndRMWwySUVh?=
 =?utf-8?B?VmJseSsrM1NtS0YxeVFkTHY4am4rNzRkdVBWUUVlR2JTQTQyUFEzaW4xektr?=
 =?utf-8?B?TmxqYlhqUTB0d3F4SHpxK1NEOHM2bFNuc2pKaEpFZDBDU2pSaE9DWlJJTTdW?=
 =?utf-8?B?TndrNitjUCtGVFVKdHF5b0FCT3lGa2ZDcmorUERRN1p6RDg4SlBZdnVpazl2?=
 =?utf-8?B?cUUyQXhwVWdNRTlsTUdlQnNabW16djhtU3pjRVhqSUVWdFRKd1hvb2UyNndG?=
 =?utf-8?B?bTBnWjB5bG1FMTBwcndKR0l6T2U2bzFmTU1nZmdudjAvc1Z6bytWSXJNNG1s?=
 =?utf-8?B?VTlVR1FWOW5FSXhpOHJPdGRuRkZqMmg0akdHZGszN0d1SGYybXdLZ0t3OFVB?=
 =?utf-8?B?RVVXOXgrdG16cnQ5am04UzJTK0pvRnB2TXBEa2VuWENxV0xSTEJTUkFGd1JN?=
 =?utf-8?B?WnpqS0p3TkhMdGZ4eU5mYnBYcFJraU5acUR3Wk1KWnRLczEvd1FLdVZlVEU5?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62FB5A129E78834883BA22DBAD0F70A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EV1V89cESvPH8bMNrLnRb0z+O7f5N+70ZacCZ4IUm1TBI/xaOsW8zqBzxQ78VxFc4MZAfYiIBvwNhFhf5lZzJv6s+VbkxyV3ZqlPEkGVPnBwXQvMoKOZu67fia8whWB/uw4U+845YJeQZuKpyGkmWJz2de/RhfGkfc+IZmLq9AyHWfyMFXWAjIF04Uc5jQJKmYjv3rzJlNwpo7BD+CzlmZ1aYRxObcQV6UxMME6yJLS/KIpWyFnEbmn4VWVQ/2osafbB0zCYYMavPXo5j/GBoRGf2n6AnCVMlG7VnS0aIcyy5M9m6U2MW96lMBgKcJ682x/Sr01fLesgUfVDYSFNwx/KMxa2c/TxL2KxKnnfYHksFZqxob9KNagPyqWt7DaZpu2bEtEbp9FYxr7PkmwgG5p7apTc0EVXYfc3IWDfGsjTQNWg1ddhB1G9VJuwvg8pfHMxG3BHmZFSkyNT2Mxx9CeboZ43Qc77dDQfiR++8jhcko1MB8igJx0iOsnktLmnBWuIOm89mPUUZ8EkBCeT8/fSslSazFwk2ZmDSsOB9/SytubXfBkJ+FqZQ/vZ8dXdbJ2ayInRfSseOf3oY/C40upXcbYRRbbLY7gvIG0mbbU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72edb5b-dd4f-44ca-4a9a-08ddfa3c336c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 00:57:42.3738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTlrypbjrWpBhbmqFErbLOZDWKrNSyV6bGmYldRCh/7kJNLq5UgNLiz9erF0LRbU2t5acAV9jyPxBNJIf1SL4LdVJDe+zdH2YQpE6gZlDKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_05,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230006
X-Proofpoint-GUID: 6JaAJnZDx-T0_alnYyq70tpi2CXpb7W7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfX78cWmxopLag2
 qa+hBPFs0gXmn/bRqTeEbUunZa62DBCml1XVDmW4ez9opW6aP/vtpDU6F5EuC1NcHBgknvoq7fy
 4ZmsiYBRZAe1KYZY7GX0jHQZf5voi6dmyqjmRw5SZ0/Z8isLqaosjBX+rcAhny2i2nIJyiRqUrC
 y6a9yS3Uh6z3YihlZrnetuyWXYqz1CgASr0uJl2gGMF5+jAXZPJk2bJ6xVfusW/QlN6LLdR0ayJ
 TXAlvKHs+SuxzDS3Md8i4fVboXg5Majr2cq4zXFyJu8rkbVjL2BdC0U+osPLcTmub0ikTaLl/MF
 I5hLBqK3xtVs7kYDmDb6gfNKEQvA5jOsNXrpByKMYAJC1xd0DvE1l4KshmsZNgZQICnX9febvyr
 kHILMbjq
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d1f08a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=7d_E57ReAAAA:8
 a=gPAGPcMh8M1HmuQQAGUA:9 a=QEXdDO2ut3YA:10 a=jhqOcbufqs7Y1TYCrUUU:22
X-Proofpoint-ORIG-GUID: 6JaAJnZDx-T0_alnYyq70tpi2CXpb7W7

DQoNCj4gT24gU2VwIDIyLCAyMDI1LCBhdCA2OjU14oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyNS0wOS0y
MiAwMToyOCwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+PiBPbiBTZXAgOCwgMjAyNSwgYXQg
Mzo1OeKAr1BNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+
Pj4gDQo+PiAuLg0KPj4+ICtlbnVtIHJzZXFfc2xpY2VfbWFza3Mgew0KPj4+ICsgUlNFUV9TTElD
RV9FWFRfUkVRVUVTVCA9ICgxVSA8PCBSU0VRX1NMSUNFX0VYVF9SRVFVRVNUX0JJVCksDQo+Pj4g
KyBSU0VRX1NMSUNFX0VYVF9HUkFOVEVEID0gKDFVIDw8IFJTRVFfU0xJQ0VfRVhUX0dSQU5URURf
QklUKSwNCj4+PiB9Ow0KPj4+IA0KPj4+IC8qDQo+Pj4gQEAgLTE0Miw2ICsxNjQsMTIgQEAgc3Ry
dWN0IHJzZXEgew0KPj4+IF9fdTMyIG1tX2NpZDsNCj4+PiANCj4+PiAvKg0KPj4+ICsgKiBUaW1l
IHNsaWNlIGV4dGVuc2lvbiBjb250cm9sIHdvcmQuIENQVSBsb2NhbCBhdG9taWMgdXBkYXRlcyBm
cm9tDQo+Pj4gKyAqIGtlcm5lbCBhbmQgdXNlciBzcGFjZS4NCj4+PiArICovDQo+Pj4gKyBfX3Uz
MiBzbGljZV9jdHJsOw0KPj4gV2UgaW50ZW5kIHRvIGJhY2twb3J0IHRoZSBzbGljZSBleHRlbnNp
b24gZmVhdHVyZSB0byBvbGRlciBrZXJuZWwgdmVyc2lvbnMuDQo+PiBXaXRoIHVzZSBvZiBhIG5l
dyBzdHJ1Y3R1cmUgbWVtYmVyIGZvciBzbGljZSBjb250cm9sLCBjb3VsZCB0aGVyZSBiZSBkaXNj
cmVwYW5jeQ0KPj4gd2l0aCByc2VxIHN0cnVjdHVyZSBzaXplKG9sZGVyIHZlcnNpb24pIHJlZ2lz
dGVyZWQgYnkgbGliYz8gIEluIHRoYXQgY2FzZSB0aGUgYXBwbGljYXRpb24NCj4+IG1heSAgbm90
IGJlIGFibGUgdG8gdXNlIHNsaWNlIGV4dGVuc2lvbiBmZWF0dXJlIHVubGVzcyBMaWJj4oCZcyB1
c2Ugb2YgcnNlcSBpcyBkaXNhYmxlZC4NCj4gDQo+IFRoZSByc2VxIGV4dGVuc2lvbiBzY2hlbWUg
YWxsb3dzIHRoaXMgdG8gc2VhbWxlc3NseSB3b3JrLg0KPiANCj4gWW91IHdpbGwgbmVlZCBhIGds
aWJjIDIuNDErLCB3aGljaCB1c2VzIHRoZSBnZXRhdXh2YWwoMykNCj4gQVRfUlNFUV9GRUFUVVJF
X1NJWkUgYW5kIEFUX1JTRVFfQUxJR04gdG8gcXVlcnkgdGhlIGZlYXR1cmUgc2l6ZQ0KPiBzdXBw
b3J0ZWQgYnkgdGhlIExpbnV4IGtlcm5lbC4gSXQgYWxsb2NhdGVzIGEgcGVyLXRocmVhZCBtZW1v
cnkNCj4gYXJlYSB3aGljaCBpcyBsYXJnZSBlbm91Z2ggdG8gc3VwcG9ydCB0aGF0IGZlYXR1cmUg
c2V0LCBhbmQNCj4gcmVnaXN0ZXJzIGl0IHRvIHRoZSBrZXJuZWwgdGhyb3VnaCByc2VxKDIpIG9u
IHRocmVhZCBjcmVhdGlvbi4NCg0KT2ssIA0KDQo+IA0KPiBOb3RlIHRoYXQgYmVmb3JlIHdlIGhh
ZCB0aGUgZXh0ZW5zaWJsZSByc2VxIHNjaGVtZSwgZ2xpYmMgcmVnaXN0ZXJlZA0KPiBhIDMyLWJ5
dGUgc3RydWN0dXJlIChpbmNsdWRpbmcgcGFkZGluZyBhdCB0aGUgZW5kKSwgd2hpY2ggaXMgY29u
c2lkZXJlZA0KPiBhcyB0aGUgcnNlcSAib3JpZ2luYWwiIHJlZ2lzdHJhdGlvbiBzaXplLg0KPiAN
Cj4gVGhlICJtbV9jaWQiIGZpZWxkIGVuZHMgYXQgMjggYnl0ZXMsIHdoaWNoIGxlYXZlcyA0IGJ5
dGVzIG9mIHBhZGRpbmcgYXQNCj4gdGhlIGVuZCBvZiB0aGUgb3JpZ2luYWwgcnNlcSBzdHJ1Y3R1
cmUuIENvbnNpZGVyaW5nIHRoYXQgdGhlIHRpbWUgc2xpY2UNCj4gZXh0ZW5zaW9uIGZpZWxkcyB3
aWxsIGxpa2VseSBmaXQgd2l0aGluIHRob3NlIDQgYnl0ZXMsIEkgZXhwZWN0IHRoYXQNCj4gYXBw
bGljYXRpb25zIGxpbmtlZCBhZ2FpbnN0IGdsaWJjIFsyLjM1LCAyLjQwXSB3aWxsIGFsc28gYmUg
YWJsZSB0byB1c2UNCj4gdGhvc2UgZmllbGRzLiBUaG9zZSBhcHBsaWNhdGlvbnMgc2hvdWxkIHVz
ZSBnZXRhdXh2YWwoMykNCj4gQVRfUlNFUV9GRUFUVVJFX1NJWkUgdG8gdmFsaWRhdGUgd2hldGhl
ciB0aGUga2VybmVsIHBvcHVsYXRlcyB0aGlzIGZpZWxkDQo+IG9yIGlmIGl0J3MganVzdCBwYWRk
aW5nLg0KDQpUaGUgcXVlc3Rpb24gd2FzIGFib3V0IHRoZSBzaXplIG9mIHJzZXEgc3RydWN0dXJl
IHJlZ2lzdGVyZWQgYnkgZ2xpYmMuIElmIGl0IGlzIHVzaW5nDQpBVF9SU0VRX0ZFQVRVUkVfU0la
RSB0byBhbGxvY2F0ZSB0aGUgcGVyLXRocmVhZCBhcmVhIGZvciByc2VxLCBJIHN1cHBvc2UgdGhh
dA0Kc2hvdWxkIGJlIGZpbmUuICBIb3dldmVyIGFwcGxpY2F0aW9uIHdvdWxkIGhhdmUgdG8gdmVy
aWZ5IHRoYXQgX19yc2VxX3NpemUgc2l6ZSBpcyBsYXJnZSANCmVub3VnaC4NCg0KQXMgZm9yIHRo
ZSBLZXJuZWwgc3VwcG9ydGluZyBzbGljZSBleHRlbnNpb24sIEkgZXhwZWN0IHRoZSBwcmN0bCgu
LixQUl9SU0VRX1NMSUNFX0VYVF9FTkFCTEUpDQp3b3VsZCByZXR1cm4gYW4gZXJyb3IgaWYgaXQg
aXMgbm90IHN1cHBvcnRlZCwgd29u4oCZdCB0aGF0IGJlIHN1ZmZpY2llbnQgb3Igc2hvdWxkIGl0
IGNoZWNrDQpBVF9SU0VRX0ZFQVRVUkVfU0laRT8NCg0KDQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBh
bGwgd29ya3MgZXZlbiBpZiB5b3UgYmFja3BvcnQgdGhlIGZlYXR1cmUgdG8gYW4gb2xkZXIga2Vy
bmVsOg0KPiB0aGUgcnNlcSBleHRlbnNpb24gc2NoZW1lIGRvZXMgbm90IGRlcGVuZCBvbiBxdWVy
eWluZyB0aGUga2VybmVsIHZlcnNpb24gYXQNCj4gYWxsLiBZb3Ugd2lsbCBob3dldmVyIGJlIHJl
cXVpcmVkIHRvIGJhY2twb3J0IHRoZSBzdXBwb3J0IGZvciBhZGRpdGlvbmFsDQo+IHJzZXEgZmll
bGRzIHRoYXQgY29tZSBiZWZvcmUgdGhlIHRpbWUgc2xpY2UsIHN1Y2ggYXMgbm9kZV9pZCBhbmQg
bW1fY2lkLA0KPiBpZiB0aGV5IGFyZSBub3QgaW1wbGVtZW50ZWQgaW4geW91ciBvbGRlciBrZXJu
ZWwuDQoNClllcywgbmVlZCB0byBsb29rIGF0IHRob3NlIGNoYW5nZXMgdGhhdCBuZWVkcyB0byBi
ZSBiYWNrcG9ydGVkLiBBbHNvLCB0aGUgZGVwZW5kZW50IA0KJ3JzZXE6IE9wdGltaXplIGV4aXQg
dG8gdXNlciBzcGFjZeKAmSBjaGFuZ2VzIGZyb20gb3RoZXIgcGF0Y2ggc2VyaWVzLiANCg0KPiAN
Cj4+IEFwcGxpY2F0aW9uIHdvdWxkIGhhdmUgdG8gdmVyaWZ5IHN0cnVjdHVyZSBzaXplLCBzbyBz
aG91bGQgaXQgYmUgbWVudGlvbmVkICBpbiB0aGUNCj4+IGRvY3VtZW50YXRpb24uDQo+IA0KPiBZ
ZXMsIGFwcGxpY2F0aW9ucyBzaG91bGQgY2hlY2sgdGhhdCB0aGUgZ2xpYmMncyBfX3JzZXFfc2l6
ZSBpcyBsYXJnZSBlbm91Z2ggdG8gZml0DQo+IHRoZSBuZXcgc2xpY2UgZmllbGQocyksICphbmQq
IGZvciB0aGUgb3JpZ2luYWwgcnNlcSBzaXplIHNwZWNpYWwgY2FzZQ0KPiAoMzIgYnl0ZXMgaW5j
bHVkaW5nIHBhZGRpbmcpLCB0aG9zZSB3b3VsZCBuZWVkIHRvIHF1ZXJ5IGdldGF1eHZhbCgzKQ0K
PiBBVF9SU0VRX0ZFQVRVUkVfU0laRSB0byBtYWtlIHN1cmUgdGhlIGZpZWxkIGlzIGluZGVlZCBz
dXBwb3J0ZWQuDQo+IA0KPiBBbHNvLCBwZXJoYXBzIG1ha2UgdGhlIHByY3RsKCkgZW5hYmxlIGNh
bGwgcmV0dXJuIGVycm9yLCBpZiBzdHJ1Y3R1cmUgc2l6ZQ0KPj4gZG9lcyBub3QgbWF0Y2g/DQo+
IA0KPiBUaGF0J3Mgbm90IGhvdyB0aGUgZXh0ZW5zaWJsZSBzY2hlbWUgd29ya3MuDQo+IA0KPiBF
aXRoZXIgZ2xpYmMgcmVnaXN0ZXJzIGEgMzItYnl0ZSBhcmVhIChpbiB3aGljaCB0aGUgdGltZSBz
bGljZSBmZWF0dXJlIHdvdWxkDQo+IGZpdCksIG9yIGl0IHJlZ2lzdGVycyBhbiBhcmVhIGxhcmdl
IGVub3VnaCB0byBmaXQgYWxsIGtlcm5lbCBzdXBwb3J0ZWQgZmVhdHVyZXMsDQo+IG9yIGl0IGZh
aWxzIHJlZ2lzdHJhdGlvbi4gQW5kIHByY3RsKCkgaXMgcGVyLXByb2Nlc3MsIHdoZXJlYXMgdGhl
IHJzZXEgcmVnaXN0cmF0aW9uDQo+IGlzIHBlci10aHJlYWQsIHNvIGl0J3Mga2luZCBvZiB3ZWly
ZCB0byBtYWtlIHByY3RsKCkgZmFpbCBpZiB0aGUgY3VycmVudA0KPiB0aHJlYWQncyByc2VxIGlz
IG5vdCByZWdpc3RlcmVkLg0KDQpJIG1lYW50IHRoZSBwcmN0bCguLiwgUFJfUlNFUV9TTElDRV9F
WFRfRU5BQkxFKSBjYWxsIGlzIHBlciB0aHJlYWQgYW5kDQpzZXRzIHRoZSBlbmFibGVkIGJpdCBp
biBwZXIgdGhyZWFkIHJzZXEuIFRoaXMgY291bGQgZmFpbCBpZiAgcnNlcSBzdHJ1Y3Qgc2l6ZSBp
cyBub3QgbGFyZ2UgZW5vdWdoPw0KDQo+IA0KPj4gV2l0aCByZWdhcmRzIHRvIGFwcGxpY2F0aW9u
IGRldGVybWluaW5nIHRoZSBhZGRyZXNzIGFuZCBzaXplIG9mIHJzZXEgc3RydWN0dXJlDQo+PiBy
ZWdpc3RlcmVkIGJ5IGxpYmMsIHdoYXQgYXJlIHlvdSB0aG91Z2h0cyBvbiBnZXR0aW5nIHRoYXQg
dGhydSB0aGUgcnNlcSgyKQ0KPj4gc3lzdGVtIGNhbGwgb3IgYSBwcmN0bCgpIGNhbGwgaW5zdGVh
ZCBvZiBkZWFsaW5nIHdpdGggdGhlIF9fd2VlayBzeW1ib2xzIGFzIHdhcyBkaXNjdXNzZWQgaGVy
ZS4NCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9GOURCQUJBRC1BQkYwLTQ5QUEtOUEz
OC1CRDREMkJFNzhCOTRAb3JhY2xlLmNvbS8NCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGUgb3RoZXIg
bGVnIG9mIHRoYXQgZW1haWwgdGhyZWFkIGdvdCB0byBhIHJlc29sdXRpb24gb2YgYm90aCBzdGF0
aWMgYW5kDQo+IGR5bmFtaWMgdXNlLWNhc2VzIHRocm91Z2ggdXNlIG9mIGFuIGV4dGVybiBfX3dl
YWsgc3ltYm9sLCBubyBbMV0gPyBOb3QgdGhhdCBJIGFtIGFnYWluc3QNCj4gYWRkaW5nIGEgcnNl
cSgyKSBxdWVyeSBmb3IgcnNlcSBhZGRyZXNzLCBzaXplLCBhbmQgc2lnbmF0dXJlLCBidXQgSSBq
dXN0IHdhbnQgdG8gZG91YmxlDQo+IGNoZWNrIHRoYXQgaXQgd291bGQgYmUgdGhlcmUgZm9yIGNv
bnZlbmllbmNlIGFuZCBpcyBub3QgYWN0dWFsbHkgbmVlZGVkIGluIHRoZSB0eXBpY2FsDQo+IHVz
ZS1jYXNlcy4NCg0KWWVzLCBtYWlubHkgZm9yIGNvbnZlbmllbmNlLiANCg0KVGhhbmtzLA0KLVBy
YWthc2gNCg0KPiANCj4gVGhhbmtzLA0KPiANCj4gTWF0aGlldQ0KPiANCj4gWzFdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9hS1BGSVF3ZzV6eFNTNW9TQGdvb2dsZS5jb20vDQo+IA0KPiAt
LSANCj4gTWF0aGlldSBEZXNub3llcnMNCj4gRWZmaWNpT1MgSW5jLg0KPiBodHRwczovL3d3dy5l
ZmZpY2lvcy5jb20NCg0K

