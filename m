Return-Path: <linux-arch+bounces-15087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9212C8C248
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 23:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 709BC3AE677
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC21133FE03;
	Wed, 26 Nov 2025 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NQZqg6f4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tl9dcqoc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B8430496A;
	Wed, 26 Nov 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194626; cv=fail; b=gqWIXRRogO/XMk50A5YR22mMEZWQ7O/RN0DodOZTB3VR8LAzrg54lpasQpaUvKiP4qB802QJQN6Z0YDptNp6jBZT+29+ZsC+HRxxFtGg3RqLmpq97wZdmJPeozzlrg/eIRO0py/eFYBg1wVpc+woP/1zUpwrEYgvKySe0Yqfyrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194626; c=relaxed/simple;
	bh=nwNPDA6GbBTvjO26EMT/2HXruFl2qeuRbKxJ3Fxd6OU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCVSutvP95YRcNpFeITfbSbWbOFG0e6HJO6U15xSl8ufNjTD+nVSL/jt12I6uABHkSU/7ySl4HFlCwBeH20W3lc/GVZIWZzgl0Tps39VaKhQOJRsRawRAMmq8wg2fBzsJywUgeYMC5phvpOIoVj3rMtbbFmnCIo+hQb2nX5hlFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NQZqg6f4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tl9dcqoc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQJvVbC2968355;
	Wed, 26 Nov 2025 22:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nwNPDA6GbBTvjO26EMT/2HXruFl2qeuRbKxJ3Fxd6OU=; b=
	NQZqg6f4Mnr3tRwcf6OyuRAHranRovVmJXtzAaGEdtNjKA70WfOlUQeDfAw3ceYY
	KzT+f/8zE3I87vankgquxMHOF0EMzKMOgL9d/XZJ8A+YYRd+8sjWBqQ0YVW2Eyuf
	J/WJobYLfkOXxu6uaO40QfGgd5i8R7qevvnjJW/9qjsZhig8sDjFPYQ9/XZIca41
	31v5uNmgoypOtzDU0P3vlfP8raJuwM1HzMtdLyqFNG/ar9V7CwEWY2ZfjbIRccjM
	Hq7VHNxwZwdyPboAlrPMedatpCVOqi9+dGAg7dlQQRaufirHNZ5xp6fDuUdFLhIf
	N/QbfE6eEnI1QnqFDB975A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkdegx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 22:03:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQKPL07022151;
	Wed, 26 Nov 2025 22:03:03 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mfa3uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 22:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tlMryeNXtuFJU3pomcE8u9E8HaDB3wEhYWf0UVdNWIyxigdH4g8pMtMDoxh2LMUVozTrMxn3iX9YLBQbI9qkYkZ95+1oXxTzLq1EN7GHPTPHkGqcYdfUbawDiAN3eUs7oCDEcRkVJC2+XH0pCmHEGT+9GFmEmG9Dok9t1hP0PpwFcgRkA70aq4w1WIFlD0KBG5/KsuxNmJIidHJ1rY5XNrk/jwgxtEhT3uMTka5ikDeEGxZ7wLC1ZF0NkC1yhgt+t06pz4p1vFbFBKt/y4XLNxyOj/64fu2PbxYU9So4l1jHSUP0u+HVorkLR2Ptwr9cYJATWj9apjuldqVLIcTmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwNPDA6GbBTvjO26EMT/2HXruFl2qeuRbKxJ3Fxd6OU=;
 b=TKPDaraAL7zirnn6Z29urRN4nwJ/UV3FDloDquumSoY/x/zr7CGKi4T9ftc9QleDLzmvAgHEGI9JrxQe34OzRFLeOGwM0z+31LyXI4NCxOBSf5j/wFyeJGOdGBtbuLHhnz03j7ZBefAJb9NjrSfDYHt5bHMbOBL7AfxxJ/1nZXYr/Gzt19bsNoPhV9r43JSbNxVRdhhBCqL+FMHgssGJtMuoS1L+UiNHnRJXUDnrK9EoAvm5rKm2sWYNZnkqNEiAIowEu72qr1WfLOzNV0A8T76LBNWrlh3grBYgI/3DxYbGAh5tzhZ6sHJZu84c4mCafmtkZyqiHw7PnnCpsTGewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwNPDA6GbBTvjO26EMT/2HXruFl2qeuRbKxJ3Fxd6OU=;
 b=tl9dcqoc7FPCDsVGSQO92X5VYGOErwiEKswibCS9QuTK/Mlqz44r0pWsDUQ/F02jV0KgzGOGq875vpew4sDSJ+cyl6yhNsc//posX40txlZ9G6pjIVFngE1l28Ey5BSVqx6ba8Bf2Dant8pwqqZsHGN/C7a9mRfAEFpksyMgAuw=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by CY5PR10MB6021.namprd10.prod.outlook.com (2603:10b6:930:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 22:02:59 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 22:02:59 +0000
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
Thread-Index:
 AQHcSNcVPmZlcazHA0W81AHywt8/IbT5QumAgAD8w4CAAQ+qgIAAQYYAgADUbICACUnXAA==
Date: Wed, 26 Nov 2025 22:02:58 +0000
Message-ID: <DB4125C7-F0C5-4413-9320-60543F0B20A6@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
 <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com> <874iqqm4dr.ffs@tglx>
 <C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com> <874iqpkkid.ffs@tglx>
 <0EE4813D-9764-41C5-B38D-21222824B0E6@oracle.com>
In-Reply-To: <0EE4813D-9764-41C5-B38D-21222824B0E6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|CY5PR10MB6021:EE_
x-ms-office365-filtering-correlation-id: f3733f64-d2f3-4423-16d5-08de2d378fba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?M2I3NE5ETHE3SnBoN1AzajF4RHpvK2pqaFdNQmFDb0lrNGx6cldqQzBYOUsy?=
 =?utf-8?B?bFNJRis3ajNLUS9ZRTk5ZWhJall5VTk3WWNsRjV1R1VJcmUrTU5LaFJONHd0?=
 =?utf-8?B?RHEwbHNhVE5qWlpkOHdueG1RTklIYmNXakRrTmRMeGdiUDFFSUlOVGRoUHJy?=
 =?utf-8?B?MmpPRE5nSXkrTm9QckQvaGQ4dnBHUXhlcVB1ZTljaXdMS3h0Yk5FU2hnaFgr?=
 =?utf-8?B?VHdTVGIweEk3RGpOTGxnUzRPMDZMbTdkSU1aUlBEQnNXQ0hUejlBUzlCczJu?=
 =?utf-8?B?Skk4V2FsSGUzbmwzL1JyVzV2bjJIM0NleWd3U0dMVHVoU2pKYkJobXQwSDdo?=
 =?utf-8?B?WjR3cW9vd3czYm93UTFGWFdlYnhGdk55MGNiUmJreENTV05qdnE0bGV1eEtV?=
 =?utf-8?B?NmR6aVpidml2M3NzQ1B4dkp1NmlrUzR4SzNjc0h2ZE42YjQ5d3UzTjFPeEdO?=
 =?utf-8?B?VlVmM0k3ZmlHUzQ2WXVEdS9XNFNybGd4U0hJNFhxTHBUVWt0amxBeWFRdExa?=
 =?utf-8?B?TFU5Q2ZuSzlEY010Wjh3aFJncEs1S0YyMEROSEt6NkFhVEFyWEdOZ3AyTlVR?=
 =?utf-8?B?Q2NDWmNnNUxGcWpMZFQzOWUzTVczVCs1ME80dHB4VkM5bzhOTWdZZUNTWTlL?=
 =?utf-8?B?NHllWmhUeGt4Wi9mNjZoWlM5SmxMOHhiai8xWHU2WG80QXNlMnh3em5FaVlE?=
 =?utf-8?B?WDBSY0tDLzdMR3NzYXB1alhBdUU3Vmt6d1pXVVhrSnl2UDlqTW1ubS81OUlE?=
 =?utf-8?B?NEVIM3NYOWh6cjRpMzEyRzViNngwVDQ5MFdtMTJKZE51R0RkbkxXM1A1eWZq?=
 =?utf-8?B?OVM3eVh2MXRCQU5nV2txdGxXcW5xamdJdC9lQVlhWDN3azA1d2JBYlFnZEgy?=
 =?utf-8?B?cTI0N05PNytWcGU4OWpPWWtMOWRjcS81ZkwyaXBQSHJvN0ZtVjFLSUlvZDIr?=
 =?utf-8?B?bDJjTndjMDRTL0gzSjVWa1pxMWNBbzVuUFM2cGNqamhXTUI2b1VUOTlTeCsy?=
 =?utf-8?B?VGV3eEVyS3FEbkVGcW5uRE1wdUxkSUllZE1aWkUxQWptWHd6aXU2c0lWbGhh?=
 =?utf-8?B?c1VnYkJJNngyQXREVVVyN0RFQTNHVm9sejVrbE5QcnlnKzhJaG84N0JjS3dz?=
 =?utf-8?B?V1Z0eDN4U3ExOGxveUJOd0o5OEh6SGNZZzNmU0xtdGhmY01TVFhHUUJWYkxT?=
 =?utf-8?B?TlNPcjYxN1owV3VzUVlYb3BKcUpXLzNIeW51aE91NHN0VVJNUXJaZzFTWXBt?=
 =?utf-8?B?TEdyNzFiakVBUmlOWjhTT3RPQnZPZ2s1K2NsZzNGVUxCaDcvdldZQTUwdVAw?=
 =?utf-8?B?OEdlaWp3azh5cVMrY0VuUi9UNmdPOXJ5d2pzMi9wSnNmc0VGRjBaWi9qS2dJ?=
 =?utf-8?B?YW5NS3hTN3IrU0c4d3pFcm1LQnFnckVzM2trQ2Y0c3B5aTVxQTY5MmFFb3Nr?=
 =?utf-8?B?WllZVEFtbzAvV2V1bVdCWDFBUnZQRmxsYUgzTHpvZkZKMDNFbzNPRytJUTgr?=
 =?utf-8?B?NVJvUFR1VmJWNnIyRUFlTnJCamV4ZGZtazZPK25oS0p0cUE4bmZRSkJYTmVW?=
 =?utf-8?B?cmhRNnZCUWl2NjBzb00yYytNRTdKd0dCTWxSRXZHN3dHWXltdmloemJEOW5p?=
 =?utf-8?B?akZpTlVWaEt4WXlUbGZnYnVyaktMM0VScHVUT1ZNQWRGTHMyQU5uQXhqd0JS?=
 =?utf-8?B?TzBkWUVWc3NsYmROR0UrS0FGUWdIemRycUNtdWEvMzFIVVBaZ2h2b0NrQUdY?=
 =?utf-8?B?NHN3ZHM4TzJ2M0RYaVV4VTlYT1dGTmlueFlJa2V6Smd3d0M3T2d3MStoNEgv?=
 =?utf-8?B?bUJCc0xhSVlYR04xelBLaml6ZUZmVXhUZjh5djUza3JLaWE4eExRSXBMM1M0?=
 =?utf-8?B?Tk9yTWhWRFllZUNSSHV0cUFzTUJxVGh6c2VyVDN5UFJkbHFBcklUSUd0bGhL?=
 =?utf-8?B?UzFCNUMrN2RtSUtkZGJvZDRXYUtFMkJYc3pZY0JKa2ZpR0JOd0pBeGRBYkFN?=
 =?utf-8?B?QmNnOGZmZWZtNElheDJSMGI5WkUzVHEzbjRpaklVNGJidDlYd092RXJrSjh3?=
 =?utf-8?Q?jmiSOk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVZkN2laM1pOTFY4cmwxTk9NeVcycy9mUmJhM0w4ZFVFcCt5U0UzZ1hvbEh4?=
 =?utf-8?B?cmZDYzBicUNQZHBJR1VOYzFkbWtvdjRMSGNoeXZLaHRoNmlhVTNVMEs1SVg0?=
 =?utf-8?B?NXdvRU5PaktaMytRMFlGcWpFTTBnRWdNQ29SMUQxUW9SUVdZbXFXRytYMHpB?=
 =?utf-8?B?TGRwNVNKQUFxanFpcHlINzg3cXVHNXRPNWwrRC9qOHhnVFRZajFqREpKMncy?=
 =?utf-8?B?OU42VzZkczl1YnppbWZFS3FzRjBOSkd5VC95bWdqcjFqN0NjOUE4RDcvcC84?=
 =?utf-8?B?OGlqYkhwL1k1Vkh6Y01zajRRMnNPMHIvL1J2TGl1VnF0SDZrVFFtRUE0NEhj?=
 =?utf-8?B?cFN1ZElSSUR6NG4wdW04c0tjMTFBaEdRSkZkeTk3akhqdUM5QXMzT3RYdjBY?=
 =?utf-8?B?SkZoNm9BcjV4bXQ4TDdnV0hseFBpSVNuZTBWZXB5dHUwb3hQTm1hSmRDR1hC?=
 =?utf-8?B?MEsrclFGdnBEZ1Vna0s3V0NrdjdOWHBobWp1MW1kTG9nR0VaUGRwUktzeDBY?=
 =?utf-8?B?bUR1V1djWFQ0b1kvUHFqUVk0WGpBdTMrL3dia3lRcS9EZHkyVVBxQndTRGJC?=
 =?utf-8?B?bysxbEdhUjlqcjNYeDJDZnhzbmNLUkhZa25sSzNpdWg3UWZtalpOK04yWWVi?=
 =?utf-8?B?RHZQZmFZcWdEazQ4OE50cXZHMkpZeCtmTGw0VExOK3c3b2c0b0FjQ3Z1dlpO?=
 =?utf-8?B?Z2FBOVEyQVRrcnV6K1A0bzhocXYySU0ySFVNZWtwY3FHTzJtVDJDckxkcEsr?=
 =?utf-8?B?SHNoUS9RWTBBU0REVFJzeFBVQmZQOCtnM3JHTFhKdm0zSjBRZDk2TklyV05C?=
 =?utf-8?B?M05ROURGWUhQUmIyNExQbThPbjRRRzI1eTVYSDRGOHFpMHg0ZFErd243NEtE?=
 =?utf-8?B?RzRaNmptUUhxaC9BUUlyWnpnZ2V5LzVmUG0yMENzeEdXWEVraXdaVFFlUURI?=
 =?utf-8?B?MEtJbFhnd244Zk1RNi9BUERjYkFLRWF5L2VndTc4dTl6VGdRc2U3VUovUDIz?=
 =?utf-8?B?WnhNUGFhYXZ1QktxV3kyR3padm1lNXU4QW4zRUZrSTZkVmhRTFp6UzFyL2xJ?=
 =?utf-8?B?SW5tZHFDZisyU2V4OU1VanpaOWRocVg4NnFsWm9yOFV6K0J0THlRTXRlZzlh?=
 =?utf-8?B?d3ZPVVJhNWNyZDBvQjNNSGdxR2M3cW1kSDBqNkF4TGhwS2g2U1pQdXI3SEJ2?=
 =?utf-8?B?OEgzUFNJTGtTRXVWZm4yejZ1QXh5bUV4MkxsS2l3b0tEZWNOU3VBaUppZk5U?=
 =?utf-8?B?R2hmeVRVRmlyUC81MjV4U0g0aHlkNDJHSy9ZdkhNanBXQ1gwdU9WbnlvYUR4?=
 =?utf-8?B?YkthREtrV0xwR0hta29JWnUyQkY0M0NBUjVUdnFtbDZOWVJyRWwvU3NIL0Q2?=
 =?utf-8?B?NFdPOGZCYnVxOEVqZVB6TGVMUzlHbHBNNGxjVjljQno5cmIxZ2N5cjIyY20r?=
 =?utf-8?B?ek84RFg2UDdQaEtGTFU5RmFnVkVPNjhqVG91VnRDSHBPclVCdk5PbkVZSk16?=
 =?utf-8?B?bVk5Y1o3QkJ2VlpXN3p2TzNJczVuTEZZVmthNkxvMHA3RW5zeTRkcVdIVElC?=
 =?utf-8?B?ZXRUcW5JN2gySDR5R2oyMHZuQ2Z6VFJ1MG9WUmtDYmgyRCtUOG5rMEZaUXQ1?=
 =?utf-8?B?YzRzdFNuQ3BwT0NKcngydE5zYldVQ2F5bS9nWTNUMDY5dzA4aGFhU25SbDBa?=
 =?utf-8?B?d3QvVUZPK3FITjhVV2VLV3YvZXZDbyt6WEQzM25kSDBvNSs5anNnL0RVeVpB?=
 =?utf-8?B?UXhYVExoc0ZWc3hFR0NLUnFwbTl3UUIxY0hibkZlTjFNTFRvQlZ1TmxCZGp2?=
 =?utf-8?B?TFRXb29vSzFjRUtHdUE5ZDFPRUw3NjBYM0RpUkxWamltaG1FdHFyVzFEY1NU?=
 =?utf-8?B?ZSt0a0kzYzErOXA2Uko0ZCtkQnpVdHIyNDZnV3dDcFI0VXJPenNwU3BCUzZn?=
 =?utf-8?B?MlJabmVNUUM5QkZFeDI5djNnSGxCelVaSjRxSEUvMk4rbHIxL0Nmcng5WHRC?=
 =?utf-8?B?RVBMbWdjVjNEalZuUXM3N2xwSGZjNzRRc1NLemVjcFpkdkdVbGVHbG9NVXF0?=
 =?utf-8?B?SXM4R2s3Q2x6UzFkdkZMaDFiYXpzbjR6cVkwYXhZclZPeExiaGdOUmM2QUQx?=
 =?utf-8?B?dEk3U29DSVFWMW5ST0x2aVdOK2VsRVlEV0QwSWJLdVVZeGhVdXc1WWFsRlZn?=
 =?utf-8?Q?wq3UqwqGEbZ7BL+xXrg0r1Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DE1F3AD4B172D4C90E5E71229BE3181@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bkxbkBIDl33fThI43vwyopDaUguKiLcwGGYycrGTF2VAwAe7RXmSh3vo1uwm89RbKIh8WTyKcelOoRP2omEkzc/X7pTTWIqA+dk7156FJ3afyorCkIexmdYQvvPUtP2RREtpyvH8mo70Dvc1iKCTOqBZODzsSzqR27cwgVW6JLxhr5HUsD0gkalQK3/baxz3Qw+aXOkN/u3OZDKUO88tBhI8kEeJFke8Q8aAdwa5OrZ63GdKw2zSRyvGCvk4+N+0wdhV6ATtfZqTZuToWtHJSYN9PK3kNybqTvxGB/FHlt8S8FYPZ/fDB+z5mfze/unrLUDZqGy+u9gdOCUlc/KYeLujKePGTcW8VcchnB/WedZ5zR5pXq8N9Q2/Xr9wPCEDqbyPeNGZzG+HWJHRQDsdy6kEFE2bYWYovCdnHWgjNSpM8GQiKoFUf+XD3lWu3U3PRKGW4dmGKG1jncxSdeaFG0YCpxO96Tp50jQsKYiGBP19Gv+9EHi2lKaXK9yhbZDpOiLJpiWK9OFEwuBFp+YkMMq++oRIok6UKnpCEmMCz5lriehnkDKy/j0/kECC5vV5KQjpVniam85JDfVcqtZp5ZEUDgd5CnqxlQkJ3ipSews=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3733f64-d2f3-4423-16d5-08de2d378fba
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 22:02:59.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sb3diLHSa3ZL0T9jfwfcYFjO68J/O+rFJ0vp+bRGVoOHlFXM5AwoEhAbfsQJjSMRBMxLJvcgd0aJCbJkueVQ3qW6TfuENlvj6HHda+SUyP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260178
X-Proofpoint-GUID: su4zoif3SA9geM1yihr-puGFfObfhQrP
X-Proofpoint-ORIG-GUID: su4zoif3SA9geM1yihr-puGFfObfhQrP
X-Authority-Analysis: v=2.4 cv=L+8QguT8 c=1 sm=1 tr=0 ts=69277917 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-Wzb-lrMAAAA:8 a=yPCof4ZbAAAA:8
 a=Bf9mSYbbghZAj78VpLgA:9 a=QEXdDO2ut3YA:10 a=vQ5u0XYZHfJtmRUo30Xe:22 cc=ntf
 awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OSBTYWx0ZWRfX+0cIMYzcbp5g
 iapImCNVpQaRNtxC9hLpfaZWGVCx3/rT0ByADWSQU6dEfQKVzl1NyL/ia2aOvRhz1Pyj7IYCwnK
 pxEOVmPR37d+8j6OG/6pUHeQxJFtcHBYYwZOJ0OPu7zp13cBecFu/eU2klubMnflcJhNd3gFZ9T
 a1cSUMPJHutaZhZoOxZwek3LwHlPEg4mjrRx1R9W7fWuKtQKucPXZN3t5Ac/xk7o4OY0G1CPNLV
 5eeDno4h4d7SsfUO0fFYzoEGCHXOSg48Tmv5UaqknXY7x3nW2d8uDoMNsn87XBTualLQyzH2K/9
 qpTSbEbSo/ZcGH8WrRFCwQ5k+l2eqOWqt/ip6ca2l+18pJJAp15nKCWcC/XkL1UOiKnSxiZ9+wL
 IEgt2IwYZn9pr3cbnhOkAxdl/GtU/efkqM3Sn+Cfyf0/j8UbNBw=

DQoNCj4gT24gTm92IDIwLCAyMDI1LCBhdCA0OjEy4oCvUE0sIFByYWthc2ggU2FuZ2FwcGEgPHBy
YWthc2guc2FuZ2FwcGFAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBOb3Yg
MjAsIDIwMjUsIGF0IDM6MzHigK9BTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+IHdyb3RlOg0KPj4gDQo+PiBPbiBUaHUsIE5vdiAyMCAyMDI1IGF0IDA3OjM3LCBQcmFrYXNo
IFNhbmdhcHBhIHdyb3RlOg0KPj4+PiBPbiBOb3YgMTksIDIwMjUsIGF0IDc6MjXigK9BTSwgVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPj4+PiBTb21ldGhpbmcg
bGlrZSB0aGUgdW5jb21waWxlZCBhbmQgdW50ZXN0ZWQgYmVsb3cgc2hvdWxkIHdvcmsuIFRob3Vn
aCBJDQo+Pj4+IGhhdGUgaXQgd2l0aCBhIHBhc3Npb24uDQo+Pj4gDQo+Pj4gVGhhdCB3b3Jrcy4g
SXQgYWRkcmVzc2VzIERCIGlzc3VlLg0KPj4+IA0KPj4+IFdpdGggdGhpcyBjaGFuZ2UsIGhlcmUg
YXJlIHRoZSDigJlzd2luZ2JlbmNo4oCZIHBlcmZvcm1hbmNlIHJlc3VsdHMgSSByZWNlaXZlZCBm
cm9tIG91ciBEYXRhYmFzZSB0ZWFtLg0KPj4+IGh0dHBzOi8vd3d3LmRvbWluaWNnaWxlcy5jb20v
c3dpbmdiZW5jaC8NCj4+PiANCj4+PiBLZXJuZWwgYmFzZWQgb24gcnNlcS9zbGljZSB2MyArIGFi
b3ZlIGNoYW5nZS4NCj4+PiBTeXN0ZW06IDIgc29ja2V0IEFNRC4NCj4+PiBDYWNoZWQgREIgY29u
ZmlnIC0gaS5lIERCIGZpbGVzIGNhY2hlZCBvbiB0bXBmcy4NCj4+PiANCj4+PiBSZXNwb25zZSBm
cm9tIERhdGFiYXNlIHBlcmZvcm1hbmNlIGVuZ2luZWVyOi0NCj4+PiANCj4+PiBPdmVyYWxsIHRo
ZSByZXN1bHRzIGFyZSB2ZXJ5IHBvc2l0aXZlIGFuZCBjb25zaXN0ZW50IHdpdGggdGhlIGVhcmxp
ZXINCj4+PiBmaW5kaW5ncywgd2Ugc2VlIGEgY2xlYXIgYmVuZWZpdCBmcm9tIHRoZSBvcHRpbWl6
YXRpb24gcnVubmluZyB0aGUNCj4+PiBzYW1lIHRlc3RzIGFzIGVhcmxpZXIuDQo+Pj4gDQo+Pj4g
4oCiIFRoZSBzZ3JhbnQgZmlndXJlIGluIC9zeXMva2VybmVsL2RlYnVnL3JzZXEvc3RhdHMgaW5j
cmVhc2VzIHdpdGggdGhlDQo+Pj4gREIgc2lkZSBvcHRpbWl6YXRpb24gZW5hYmxlZCwgd2hpbGUg
aXQgc3RheXMgZmxhdCB3aGVuIGRpc2FibGVkLiAgSQ0KPj4+IGJlbGlldmUgdGhpcyBpbmRpY2F0
ZXMgdGhhdCBib3RoIHRoZSBrZXJuZWwtc2lkZSBjb2RlICYgdGhlIERCIHNpZGUNCj4+PiB0cmln
Z2VycyBhcmUgd29ya2luZyBhcyBleHBlY3RlZC4NCj4+IA0KPj4gQ29ycmVjdC4NCj4+IA0KPj4+
IOKAoiBEdWUgdG8gdGhlIGNvbnRlbnRpb3VzIG5hdHVyZSBvZiB0aGUgd29ya2xvYWQgdGhlc2Ug
dGVzdHMgcHJvZHVjZQ0KPj4+IGhpZ2hseSBlcnJhdGljIHJlc3VsdHMsIGJ1dCB0aGUgb3B0aW1p
emF0aW9uIGlzIHNob3dpbmcgaW1wcm92ZWQNCj4+PiBwZXJmb3JtYW5jZSBhY3Jvc3MgM3ggdGVz
dHMgd2l0aC93aXRob3V0IHVzZSBvZiB0aW1lIHNsaWNlIGV4dGVuc2lvbi4NCj4+PiANCj4+PiDi
gKIgU3dpbmdiZW5jaCB0aHJvdWdocHV0IHdpdGggdXNlIG9mIHRpbWUgc2xpY2Ugb3B0aW1pemF0
aW9uDQo+Pj4g4oCiIFJ1biAxOiA1MCwwMDguMTANCj4+PiDigKIgUnVuIDI6IDU5LDE2MC42MA0K
Pj4+IOKAoiBSdW4gMzogNjcsMzQyLjcwDQo+Pj4g4oCiIFN3aW5nYmVuY2ggdGhyb3VnaHB1dCB3
aXRob3V0IHVzZSBvZiB0aW1lIHNsaWNlIG9wdGltaXphdGlvbg0KPj4+IOKAoiBSdW4gMTogMzYs
NDIyLjgwDQo+Pj4g4oCiIFJ1biAyOiAzMywxODYuMDANCj4+PiDigKIgUnVuIDM6IDQ0LDMwOS44
MA0KPj4+IOKAoiBUaGUgYXBwbGljYXRpb24gcGVyZm9ybXMgNTUlIGJldHRlciBvbiBhdmVyYWdl
IHdpdGggdGhlIG9wdGltaXphdGlvbi4NCj4+IA0KPj4gNTUlIGlzIGluc2FuZS4NCj4+IA0KPj4g
Q291bGQgeW91IHBsZWFzZSBhc2sgeW91ciBwZXJmb3JtYW5jZSBndXlzIHRvIHByb3ZpZGUgbnVt
YmVycyBmb3IgdGhlDQo+PiBiZWxvdyBjb25maWd1cmF0aW9ucyB0byBzZWUgaG93IHRoZSBkaWZm
ZXJlbnQgcGFydHMgb2YgdGhpcyB3b3JrIGFyZQ0KPj4gYWZmZWN0aW5nIHRoZSBvdmVyYWxsIHJl
c3VsdDoNCj4+IA0KPj4gMSkgTGludXggNi4xNyAobm8gcnNlcSByZXdvcmssIG5vIHNsaWNlKQ0K
Pj4gDQo+PiAyKSBMaW51eCA2LjE3ICsgeW91ciBpbml0aWFsIGF0dGVtcHQgdG8gZW5hYmxlIHNs
aWNlIGV4dGVuc2lvbg0KPj4gDQo+PiBXZSBhbHJlYWR5IGhhdmUgdGhlIG51bWJlcnMgZm9yIHRo
ZSBmdWxsIG5ldyBzdGFjayBhYm92ZSAod2l0aCBhbmQNCj4+IHdpdGhvdXQgc2xpY2UpLCBzbyB0
aGF0IHNob3VsZCBnaXZlIHVzIHRoZSBmdWxsIHBpY3R1cmUuDQo+PiANCj4gDQoNCk15IHByZXZp
b3VzKGluaXRpYWwpIGltcGxlbWVudGF0aW9uIG9uIHY2LjE3IGtlcm5lbCB3YXMgc2hvd2luZyBo
aWdoZXIgbnVtYmVycy4NClNvLCB0byBrZWVwIHRoaW5ncyBzaW1pbGFyIHRvIHRoZSByc2VxL3Ns
aWNlIGtlcm5lbCwgZ290IGZvbGxvd2luZyBudW1iZXJzIEZyb20gREIgZW5naW5lZXINCndpdGgg
dGhlICBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiAgYnVpbHQgb24gdjYuMTgtcmM0IGtlcm5lbC4N
Cg0KU3dpbmdiZW5jaCB0aG91Z2h0IHB1dCB3aXRoIHVzZSBvZiBzbGljZSBleHRlbnNpb24ocHJl
dmlvdXMgaW1wbGVtZW50YXRpb24pDQoJKiBSdW4gMTogNTA4MjQuMTANCgkqIFJ1biAyOiA1NDA1
OC4zMA0KCSogUnVuIDM6IDMwMjEyLjUwDQpTd2luZ2JlbmNoIHRocm91Z2ggcHV0IHdpdGhvdXQg
dXNlIG9mIG9wdGltaXphdGlvbi4NCgkqIFJ1biAxOiAzMzAzNi41MA0KCSogUnVuIDI6IDM1OTM5
LjYwDQoJKiBSdW4gMzogNDA0NjEuNzAgDQpQZXJmb3JtcyAyMyUgYmV0dGVyIHdpdGggdGltZSBz
bGljZSBvcHRpbWl6YXRpb24uDQoNClRoZSB3b3JrbG9hZCBzaG93cyBsb3Qgb2YgdmFyaWFiaWxp
dHkuIEhvd2V2ZXIgb3ZlcmFsbCB0cmVuZCBzZWVtcyBjb25zaXN0ZW50KGllIHdlIHNlZQ0KIGlt
cHJvdmVtZW50IHdpdGggc2xpY2UgZXh0ZW5zaW9uKS4NCkkgdGhpbmsgYWJvdmUgc2hvdWxkIGdp
dmUgYW4gaWRlYSBvZiBwb3RlbnRpYWwgZ2FpbnMgdGhlIHVuZGVybHlpbmcgcnNlcSBmcmFtZXdv
cmsgb3B0aW1pemF0aW9uIGFkZHMuIA0KDQpUaGFua3MsDQotUHJha2FzaA0KDQo+IE9rLCB3aWxs
IGFzayBoaW0gdG8gcnVuIHRoZXNlLiANCj4gLVByYWthc2guDQo+IA0KPj4gVGhhbmtzLA0KPj4g
DQo+PiAgICAgICB0Z2x4DQo+IA0KDQo=

