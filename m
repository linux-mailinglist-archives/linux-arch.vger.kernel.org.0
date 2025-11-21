Return-Path: <linux-arch+bounces-14995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA834C76B71
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 01:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 919EB208C5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544F54758;
	Fri, 21 Nov 2025 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r8lRYRrK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NkudG1tw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E221CD1F;
	Fri, 21 Nov 2025 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684051; cv=fail; b=etDWw9s+7/iEk32JFoJolt7gKRuSVpzw5BSpSV2V5IoxsdqXsE1LRWz8wztLCGZaNMazOvPhLSrR8WkPWm5WtZlkH1R0d8xPnOGCULq3EgLlZj8jpiLLhUFREIPeehhQaCZW9nhXrLjMAOAlc73zj4foVlSSXcRrpDLloVB15ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684051; c=relaxed/simple;
	bh=SFI+VJvwgAz5GOapvYDCddYa1c7PiIPAOLROlTSqfhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J3IZtPUFPx7p9qp/KdG0V7al+R/95+ZrSmtqYGZxaYDjdW16NPn5rgFphPthrgBE47mbuowyK1Ma23I6KUEWY0J9PlNMS45TYY76Y/0GT5YXiSzynLaUrx3trK8xkzeszjGvwrZV0bLober5rbyUogmqkZNLo5iV90j19OOVFXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r8lRYRrK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NkudG1tw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKJggOE009256;
	Fri, 21 Nov 2025 00:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SFI+VJvwgAz5GOapvYDCddYa1c7PiIPAOLROlTSqfhE=; b=
	r8lRYRrKkS1Oa68vdae7MHNhgvFqy/gjpMR7WzdW6V1w2nlMbGVTNMYTOBjFcfnO
	NlIVVoQP4G3zMhSjqEaBClkt15RH/CXJ8y1EjtjmEYYmD8wEw/Al+Ts+3Wsq0j0r
	KejMEfrdGZq1daQEzzCmIZs0eFNGL+3QN1SV3c6D3X4WzAKBfpUsJbVcpn3YCXUa
	qObXkYaY+awmXXCuwRn4q/cEdzvwpLmf/ZbUG8ay1vFo2saqUGWYF1avCSaLIghF
	v4bjTZgKBzJ6F6p2HuJDB8Omtq70t2+zNcQ6sf4uraP7F1klxXbWO9hzufyRy3GJ
	S8tKj0/3Z0U3Yg783ESu7A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1j7aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 00:12:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKNoZKj039837;
	Fri, 21 Nov 2025 00:12:25 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyq76bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 00:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YshvhBGuoLKIsp2nEv8QNJp8snFaSINbOMPLDZjOTozTFbt3PXDYkUexCse8ddFJMIoEyzAad2Sle5VdkdjAEujFAjc4ucb1nRPGHwdLUF53OCHfIGV3KdR7nAJpOWSk6bCfpzfHQbjLsXwBmjG0tXA4ditgdv2Y+yGeWG0gvx4nGk1Yhh7uML7APg2YdSQesU2GmY+fkSu72aQ6YgPatnLaoAlVXjvEByu8vVAtsrGfD+jzPGZGxjMVvTEgRmql83e3Amb1XYMvcEn6JmcS8T5rPWS49fz2iLo5EokoNMS3MtKy0Z+ZI6O4n2Eb8M/21uItwqvwQeSvcKRXbqGifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFI+VJvwgAz5GOapvYDCddYa1c7PiIPAOLROlTSqfhE=;
 b=L6DtQuYAOry5gVUHrPXzmkMqeiwZpqtf9iVsnMvYA6EcMu6F527sKUGPZP6oJn4zzSjx97QDZXiDzHNOg0sHA3S1XDuKDDwBKd87Ue6VSvNufIA4XjwTYANTHkiTgU5TCm1eSIjfy4g/A60zpSBSjK2UMNdDszpgoSmM3T/KaJSJoxYJ1o4PBIZ+nOy5M/StwmoAwrHyVX5aOu9TYlBD8mg4RXuA9KHgzYnvxZDSlXSFLSnlcY3e6sc6R2vJYXArEMAfWwRhv9quuMwxsAkOybxvKig9SPge/R0gZoDwJDytItjlAx+2YlkoISenj0mjyFW4Hqm0iYV9DoFHWYBG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFI+VJvwgAz5GOapvYDCddYa1c7PiIPAOLROlTSqfhE=;
 b=NkudG1twH5oiB3DtGUtvEAYJ3y7v40vxrFj3/vwPNBL9NipmZDHZX0sDPiJ7ondCrK4u2F55KUvNd7VioynvkecXKubCza4dCzKvirffAju92qkzbxYI8nqk9aFHV8nHX8D/KZ3hRtMvr/2eS7+odbdVJBvujn7qAyx2wE1WBrc=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by MN6PR10MB8072.namprd10.prod.outlook.com (2603:10b6:208:4ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 00:12:22 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::a6d8:a8aa:5923:57b9]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::a6d8:a8aa:5923:57b9%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 00:12:22 +0000
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
Thread-Index: AQHcSNcVPmZlcazHA0W81AHywt8/IbT5QumAgAD8w4CAAQ+qgIAAQYYAgADUbIA=
Date: Fri, 21 Nov 2025 00:12:22 +0000
Message-ID: <0EE4813D-9764-41C5-B38D-21222824B0E6@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.860155882@linutronix.de>
 <261A8604-DA8D-468A-83BB-F530D5639A43@oracle.com> <874iqqm4dr.ffs@tglx>
 <C9D3DC1A-CBF5-4AB3-B500-C932A6868B13@oracle.com> <874iqpkkid.ffs@tglx>
In-Reply-To: <874iqpkkid.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81.1.3)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|MN6PR10MB8072:EE_
x-ms-office365-filtering-correlation-id: c2f2cfa9-4e16-45b1-6c05-08de2892a46e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWhFV3JCM3kybmE5bGI1WlRaNFhUSnFzLzVZWWp4SzE0OVR3ZkpGeXU4bjlP?=
 =?utf-8?B?MTZKeXY0VXFxTUtQUG5RdjQ0MVF5RldJU1RpMEJBN1VjQm94MjBRUTBsV2dX?=
 =?utf-8?B?QU1lYU8rd21FcXpXMTVjRUNVbHJKWXJybVdGZXZueU9VR0I5ZkRYQS9RdDVT?=
 =?utf-8?B?VlBDejNHMjNFQVFxakhldUthbGpuam9TNWc4bWZTRjBRWFY5SVJPTGpmVWxu?=
 =?utf-8?B?MEtTVjgvcWhjTzdnQVppdUhBTGkyOEFOMVlQc2R1bVJKWUtXV3d1TlZ4c2tV?=
 =?utf-8?B?UkhjcndhL3NtSUhWekRkYUlBS0FjcENjYldQWGJuMmtYMXVORW9IR05Wd1hS?=
 =?utf-8?B?WlZmOVZwVTl2RlR0OVRxcTF5VkNhb3k4NkJiWDdCdWFnQmoyNjBzMkpCbkR2?=
 =?utf-8?B?NS9LWTJramlDOTFBQXE5K1BKbWlCWXJHeTYzU2hZbTJkWEx0TVo0QWxtNVJa?=
 =?utf-8?B?TU5VTGNhTXZNSCtWWDJVbE14bllqMUFVa1RObTFzcGtSSkdUUDdTckF2UE5J?=
 =?utf-8?B?bFRPRThuQ21qWnZmbjdUS2p2S2phTGlwQ0k3SHBkL1hkVWsyR3FLM3kvQUQ3?=
 =?utf-8?B?RXV4dEx6TGg1UjR6cVRzUmNRR3h6YmdZanZvaHk1VURVK2RVaWNmdXc4TStY?=
 =?utf-8?B?TjJrY3dVQ0JENUp3T2FXR2RYdDBEZ0l0TGJ5aEp3d1p2VmFRd2RsNG5SdGdL?=
 =?utf-8?B?VzRBVVlnQnBEYmVZNkJRcjJYU1hXVjR4N2FVaDVzb3FSMWxjZ1RKM0hVU09o?=
 =?utf-8?B?NHUxVTNzNjJZc09YeTFZUDg4L01HQVJYV2VRVU1odWc5UFZYVXl6S1JSRUUr?=
 =?utf-8?B?eVRIZWlFbnpJVXh5RHBlOFdPTnJrcDBLLytDZHJibEYrNy92bno4ZDVPbmlB?=
 =?utf-8?B?b05jVzVBZ1hzQk15QzQ1VXhMWmZGTGI4d0pua1hNN1ZvODVKMXRqL0p4aUh2?=
 =?utf-8?B?OXBnQXZGZ0NWUmJIWUpHZFpyQVVUY1JWbGpXZHQzVUJUYTd4QzhHMmxlQVk1?=
 =?utf-8?B?NS9WSkxVS1NRamFFQlNBY1o0b1ZaUytuOE9ydGdzYWJhS285elVlb3VYUWp6?=
 =?utf-8?B?L1ZDWTlXWk5veDBQUm1taUNjMzZZaW9NRUtNKzFoQnIyZWJQdXY4K0IxRlpD?=
 =?utf-8?B?bFpZdmd3ZFoxWWI2Z1hnSWkwL3Roak02MXlaVW5EUkwvZjF1MWVUZG9zekRx?=
 =?utf-8?B?bU1xc2p2SzJqd2VObEZnU3pTclNjTEJpUEIwUzM5K3JyNnBDdkkwUDAxSWlU?=
 =?utf-8?B?YkllNVA0ZkFxZ0VDQSt1eUZlYlFmeTBTOHJ4SnkyUFdiK25ROWVETGxXUXAy?=
 =?utf-8?B?ZjFQR0NaSlBLT0Z1ZUVFSjVxZjNiV3lHd0R5ZTNMeTVMVUdUajhGNVF5aHFR?=
 =?utf-8?B?L3ppckNqSm40K2orejdPS3BjM24vOHFlUFZ4Z0xLcUJ2anJUd3pQc2FkdkI2?=
 =?utf-8?B?dURNeXBMd2plVFkzQTRyYkFGK2RlL3dUYnNmcEdab0NvMDhFWFpZQm9DTkc3?=
 =?utf-8?B?bjlnT3pYN05MaTJXM2t6eGw1QVd4SThLY2liSmhlV1llZkVuZ1Q5Y2psMUZv?=
 =?utf-8?B?Nm5XZmRyY3FENTRCZldOY211OFk5TkJVTGpkWGVCRitLRy9uL0NRTWVaWkRz?=
 =?utf-8?B?dFNzZHNXT20vV0dBWDRKem1QMG1oQzRxNU4wRmFnT2c4aUh4TGVqTnEwUzRr?=
 =?utf-8?B?TkZLNHo2aHpvNGhLZW5KL3VySVk0QzJ4TSsxTkdtWGhHbUFEdlhObEtsMitM?=
 =?utf-8?B?ZExTSnNXMllPQm83cFZua2FTWGxZK3NGVW00bTIzbGRTQlpBZ1ZuL3N3T0FJ?=
 =?utf-8?B?aVVVTHl5SzVLem4wZ05jOE91YWwvdnBwTkRnWDU5MTg4VGthQ044eElURlk1?=
 =?utf-8?B?aUVQQk1pRmx1MW1zNWErUUQ0UnVaZlIzWkc4N0pBT0d3a0tzTkdCdWwxMlhw?=
 =?utf-8?B?M3lZUlpSSnZwRmY0RXJTMy9yVGw5UDZvL2NCZzBZWkhSdlIxTnhXWWljVWNO?=
 =?utf-8?B?MTVlRlZsRGZrN1MvT0dsbVZZa0xPbTQ5bC9nMUNqSHpjMnJkb1VXN0tzV0RO?=
 =?utf-8?Q?hmVnWg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3VHUm9PWlByVXFHdUJTNVBnTU9adTFGbFRjS3R6WVhteGFBY1BjZ21oN3Uw?=
 =?utf-8?B?Ri9JZHIxZTE5MERreUhtdHA0U1lBeVkrL1YyUnVLWldHeXJ0RE1IUFRTblVL?=
 =?utf-8?B?bHBTRlBwcVRRU2ZZb0V4ZlNjVm5RcFowTGdiYjhnNktBYThOenZLd2FsUGhh?=
 =?utf-8?B?Z2tiUXV5YnE4dnRUQlhzSU9MamVHMk1XbG83dVB2YWtWeW1FOWlqZ2ZVTThx?=
 =?utf-8?B?dnhHVTd5VHgrMDhPL2t2U1VZYXlkUXdOditwek0zZWxYMzAzQUI1UWpGWmVn?=
 =?utf-8?B?SEFScE15YXJtTWpEOFBqM05GaTBpUUR6SVJNRE05TG81bVRBcTkyNG5hTGo2?=
 =?utf-8?B?MU1xaTk1OUpMM2U3Q1MwSllDQ0hLa0c4b3lWUDhzQVYwQW1GWnF4a1NGWmZk?=
 =?utf-8?B?WERkMlJBbmpJejZ3cHZVNTNKc2dyYVkrRk51aXNPVnBQUXM0YlFlMHhnV0I3?=
 =?utf-8?B?Nm82WVVyR3MyZHozTXExMC9JUjBrQmVXZUh4VWxXbGJoemxZOXBjU2F6cm1w?=
 =?utf-8?B?Qk9BVzB3RUhWT3BFRXNEWnAzM2NGTEE5VHhlNTVnd2hkVE9SUlFCcWhwOWNx?=
 =?utf-8?B?Z2JOVTNiZ29TMjVyQkVnM0dOUmNDOFB6NVJZMVNra1JJWktzUmtPa1R3alkx?=
 =?utf-8?B?M0JXSXRSQ0tVakh4WDBFQXd2WmMyUzhGY0hnckxTeHBXWlg2RGovN0phVGNL?=
 =?utf-8?B?T3o3QVJmME1icEFqNnZiRC9YcmpNNW5sTExrNWw3UWorZE4xQ1J3NkQ2czlN?=
 =?utf-8?B?MDFsdjJhdEw1V0JkbnZqN3BSbzd5cnBOYTVDVTF1blR5SGlva1BadjdmMkJ2?=
 =?utf-8?B?b0dOUWNXZjVUNk1vOElUZ3RRK0JnUEgxR1RHMzVBc1FRQjQwVCtFdC84OVF0?=
 =?utf-8?B?clM3b0s4VTFBcVpUR2daRWxhOVZ1azh2cWNJaTJrOXF4MlFUR21BVk1UcE8w?=
 =?utf-8?B?c2tkclFZN09ZbGs3ZEpVWUJzZXdNNktLUkFCNktKQnhoaFFHcldXOEE1Tk9m?=
 =?utf-8?B?T3dIRFRGaDR3ZTVicVM3Tkg2U1RqOHdvbjU5UFl2eFFoZ0ZsRTVLbW5kQ0pB?=
 =?utf-8?B?V1YrWnZrZFpqR1dHallSZHJJSHNldFIrQ3FLdTltR1ZtMldZbE81aENHNkl6?=
 =?utf-8?B?UndSM2NzRWZVNHl4Y3NzTzE1V21KWlFyb1N2aFd1a2pBT2F6a21qN29iRW8w?=
 =?utf-8?B?ZXlmM2lDeGMwYlFNRndOSXJaalBmUFJXUmJ2aVpHNXNkU2d3VXpqU0F5Qm9o?=
 =?utf-8?B?ZlRJR3Z3OXhPWk1CbmM4SlBaczNzTEhOaDRRSzgxbW5GdFpmbnlGMEpjYUh2?=
 =?utf-8?B?OUM0a3lOVVIvVUsyRE9NcEl0YkFpamw3TkdRdU9XVm1UN2NyeUJKTDZZMkpF?=
 =?utf-8?B?WkRTTXl5RmhqQjhXU09yR2hQUjhmZ1lDZmtySVJNMHU1R1l0NktsT2JPMVlu?=
 =?utf-8?B?SzVHZWxiUEdXZTY4bTVKVmJHblpUa0VZcGNRMEVQTGhFeVRLdmpsOHpISDkz?=
 =?utf-8?B?aENQN3kraGdubHd6QXlQdXFITFdibmgvL0FLM0U0QXRiVk95V1QvTjE5YTNK?=
 =?utf-8?B?dllYOWZhU2RPZm5MdzcrVFNZZDVEbE5vUjEwQ1ZaV2hQSU13N1Nqa0M2RmNW?=
 =?utf-8?B?d0k0bXAyd21UbDM3cUxkWE55L2JzREdFa1l5NUVRb1FJNEcxYURJYUx6VEd0?=
 =?utf-8?B?cWJOUkpVV3pHTVRGcjBzUkdoZVliZ2VpaXEwbVpsYVZ1QXRtMkZ6cytlVFhm?=
 =?utf-8?B?by83RGdFcWdOb2ViTTB2eVJUaW8yMTVwb0laUGdqY04zNk5YWWZ6dENXVHd1?=
 =?utf-8?B?S0Q4dERXbStvUWtYQi9pV2RPREJVakc3Vi9kNzh5ejJ4dlBOUlU0SndVM0d4?=
 =?utf-8?B?MDYzSVl3NVRBdUc3Tk1KRkwrRy96UFpBZkdSWjUvYlpaRFl0WHlVQUZzd3ZX?=
 =?utf-8?B?TXpWNWlRSEhya0F2TzFLVzFxellQdjg3RFZtS3VKN2JpbTF2SGNhQm03Tngr?=
 =?utf-8?B?ajRaS3EyOG5yUFJGRmpUZm9CS29tU2RKZ1VtUDhueFVJY3NxQ0VMb2JZaVha?=
 =?utf-8?B?c2xIVE9hN2p3SVVqK3Y5MEtjUzB1eFlhM05vcVFOZmxTNWRKMWlvM1lqT3lV?=
 =?utf-8?B?Rjh4VGVXR1c1NG9qUVJIWXAwYzlZS2taS1pJR2ExT1AwNmw0N2x0ZXJFYnVv?=
 =?utf-8?Q?Dqiv/8y/XZwib07ovcAA7UE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90EE33E665F2F14689FA023298C47E3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MHZQIUn7LM+AxRrgkBcL/L8gqYp+ZEDRs51ANdJvZaRH0PsTS4zJMKgOgtvxwdGlJVcThD0LENetAKoZ9jHirH+sJrazfM4r1oxbdht+Tk/i8Z6+q8QqG+RqlTyfJMcRCXfdiPbLx45YgIBOqCUpVIaXoYmubOIgWu6NaNtlIh2+X7yoDmcc1W6KWE0OAnvv/mt/Tqp6UfVGwKaxtkmAjPDRzBW0p7W+YF5LN58n52G7DYrU8PtX2sxUl5vKKTmTNdJJPOpCmusmLivJonRARiLHaEAiIBqnZDt4xzUh7p529yvINTI+fdwVMeaRu69qRZh/Qu5WC2oGqE5WFEK878rOX7IMxFD3/312AGwPnT1fKyjoKGfj2JCQRsRXIAiwjJ459dgqJykcgxz/voZ6he60vuutf6acV5gjaMXNSu3lIzX12p5LkrR8cmSMhMDC9hi882WvmC1AFeVclZQifO7u4h248mOHyFLdCx9lkbla7UrVCXDyu0ST0Vo9t+3nL9Z+misAd0hlCc087ZD8gGwuJy6wHGf6WUaXjES6auZeD2fyY/UlH1UvzPvBymnT6e27uC51cvQV3YWwb8/yrxaFz8ST3znQdMyulypWGWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f2cfa9-4e16-45b1-6c05-08de2892a46e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 00:12:22.2053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8HjSlnJ16SsgYV+LUKrPwENgl0HO5SBRSg99pYyo9Dpxn5S8He/UfmDebU4oLx7s5xO+ZBA1sPm1rg0dBy67trNwZbyjDURrJRly5HlOso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_10,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511200173
X-Proofpoint-GUID: GgymYiPjGIEJ4_m5oHCLm5m4ENflImHR
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691fae6b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-Wzb-lrMAAAA:8 a=sBZjihi7UBify0GJqVQA:9
 a=QEXdDO2ut3YA:10 a=vQ5u0XYZHfJtmRUo30Xe:22 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/mOn97XU61MD
 elNcpOuQ8M1LJriJZv1G3LCmg2/iSkyGV4P4i7203pC860HMih9mPfzRBZw6550IijQe5FeJnhh
 ncdCsQl6y8L6rBt3HYumCbKC64G5/lYLp6tBkZcmW3Xz3IR/J67R1snyr/60pc3NfM93q6J3Ybr
 6nqebzHGTxBTe3PVLd+QD2H1VQHziBuaNwUJ29v5dNUw6uP10IhEInor5o7QBXudOBVGh5ziG8X
 ogPH8y6pgRye+V7NuWPIeax3XWZ4qEnpxY02ta/BWnNnF6jQYX/6Qu2ssjhylD5SqYpl/jApwOR
 ouHjhKwi6bCAbvyMd+JaVw5ApLgmS+a0KLielug3R4GUku1uprkCkgmpB3CXfeGX/vstZSKKl70
 ySF/hJC44Fc+VBeBg5CtgifBslnk5LlYpRiISr0yFJRHwJTsxSM=
X-Proofpoint-ORIG-GUID: GgymYiPjGIEJ4_m5oHCLm5m4ENflImHR

DQoNCj4gT24gTm92IDIwLCAyMDI1LCBhdCAzOjMx4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTm92IDIwIDIwMjUgYXQgMDc6
MzcsIFByYWthc2ggU2FuZ2FwcGEgd3JvdGU6DQo+Pj4gT24gTm92IDE5LCAyMDI1LCBhdCA3OjI1
4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4+PiBT
b21ldGhpbmcgbGlrZSB0aGUgdW5jb21waWxlZCBhbmQgdW50ZXN0ZWQgYmVsb3cgc2hvdWxkIHdv
cmsuIFRob3VnaCBJDQo+Pj4gaGF0ZSBpdCB3aXRoIGEgcGFzc2lvbi4NCj4+IA0KPj4gVGhhdCB3
b3Jrcy4gSXQgYWRkcmVzc2VzIERCIGlzc3VlLg0KPj4gDQo+PiBXaXRoIHRoaXMgY2hhbmdlLCBo
ZXJlIGFyZSB0aGUg4oCZc3dpbmdiZW5jaOKAmSBwZXJmb3JtYW5jZSByZXN1bHRzIEkgcmVjZWl2
ZWQgZnJvbSBvdXIgRGF0YWJhc2UgdGVhbS4NCj4+IGh0dHBzOi8vd3d3LmRvbWluaWNnaWxlcy5j
b20vc3dpbmdiZW5jaC8NCj4+IA0KPj4gS2VybmVsIGJhc2VkIG9uIHJzZXEvc2xpY2UgdjMgKyBh
Ym92ZSBjaGFuZ2UuDQo+PiBTeXN0ZW06IDIgc29ja2V0IEFNRC4NCj4+IENhY2hlZCBEQiBjb25m
aWcgLSBpLmUgREIgZmlsZXMgY2FjaGVkIG9uIHRtcGZzLg0KPj4gDQo+PiBSZXNwb25zZSBmcm9t
IERhdGFiYXNlIHBlcmZvcm1hbmNlIGVuZ2luZWVyOi0NCj4+IA0KPj4gT3ZlcmFsbCB0aGUgcmVz
dWx0cyBhcmUgdmVyeSBwb3NpdGl2ZSBhbmQgY29uc2lzdGVudCB3aXRoIHRoZSBlYXJsaWVyDQo+
PiBmaW5kaW5ncywgd2Ugc2VlIGEgY2xlYXIgYmVuZWZpdCBmcm9tIHRoZSBvcHRpbWl6YXRpb24g
cnVubmluZyB0aGUNCj4+IHNhbWUgdGVzdHMgYXMgZWFybGllci4NCj4+IA0KPj4g4oCiIFRoZSBz
Z3JhbnQgZmlndXJlIGluIC9zeXMva2VybmVsL2RlYnVnL3JzZXEvc3RhdHMgaW5jcmVhc2VzIHdp
dGggdGhlDQo+PiAgREIgc2lkZSBvcHRpbWl6YXRpb24gZW5hYmxlZCwgd2hpbGUgaXQgc3RheXMg
ZmxhdCB3aGVuIGRpc2FibGVkLiAgSQ0KPj4gIGJlbGlldmUgdGhpcyBpbmRpY2F0ZXMgdGhhdCBi
b3RoIHRoZSBrZXJuZWwtc2lkZSBjb2RlICYgdGhlIERCIHNpZGUNCj4+ICB0cmlnZ2VycyBhcmUg
d29ya2luZyBhcyBleHBlY3RlZC4NCj4gDQo+IENvcnJlY3QuDQo+IA0KPj4g4oCiIER1ZSB0byB0
aGUgY29udGVudGlvdXMgbmF0dXJlIG9mIHRoZSB3b3JrbG9hZCB0aGVzZSB0ZXN0cyBwcm9kdWNl
DQo+PiAgaGlnaGx5IGVycmF0aWMgcmVzdWx0cywgYnV0IHRoZSBvcHRpbWl6YXRpb24gaXMgc2hv
d2luZyBpbXByb3ZlZA0KPj4gIHBlcmZvcm1hbmNlIGFjcm9zcyAzeCB0ZXN0cyB3aXRoL3dpdGhv
dXQgdXNlIG9mIHRpbWUgc2xpY2UgZXh0ZW5zaW9uLg0KPj4gDQo+PiDigKIgU3dpbmdiZW5jaCB0
aHJvdWdocHV0IHdpdGggdXNlIG9mIHRpbWUgc2xpY2Ugb3B0aW1pemF0aW9uDQo+PiDigKIgUnVu
IDE6IDUwLDAwOC4xMA0KPj4g4oCiIFJ1biAyOiA1OSwxNjAuNjANCj4+IOKAoiBSdW4gMzogNjcs
MzQyLjcwDQo+PiDigKIgU3dpbmdiZW5jaCB0aHJvdWdocHV0IHdpdGhvdXQgdXNlIG9mIHRpbWUg
c2xpY2Ugb3B0aW1pemF0aW9uDQo+PiDigKIgUnVuIDE6IDM2LDQyMi44MA0KPj4g4oCiIFJ1biAy
OiAzMywxODYuMDANCj4+IOKAoiBSdW4gMzogNDQsMzA5LjgwDQo+PiDigKIgVGhlIGFwcGxpY2F0
aW9uIHBlcmZvcm1zIDU1JSBiZXR0ZXIgb24gYXZlcmFnZSB3aXRoIHRoZSBvcHRpbWl6YXRpb24u
DQo+IA0KPiA1NSUgaXMgaW5zYW5lLg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBhc2sgeW91ciBw
ZXJmb3JtYW5jZSBndXlzIHRvIHByb3ZpZGUgbnVtYmVycyBmb3IgdGhlDQo+IGJlbG93IGNvbmZp
Z3VyYXRpb25zIHRvIHNlZSBob3cgdGhlIGRpZmZlcmVudCBwYXJ0cyBvZiB0aGlzIHdvcmsgYXJl
DQo+IGFmZmVjdGluZyB0aGUgb3ZlcmFsbCByZXN1bHQ6DQo+IA0KPiAxKSBMaW51eCA2LjE3IChu
byByc2VxIHJld29yaywgbm8gc2xpY2UpDQo+IA0KPiAyKSBMaW51eCA2LjE3ICsgeW91ciBpbml0
aWFsIGF0dGVtcHQgdG8gZW5hYmxlIHNsaWNlIGV4dGVuc2lvbg0KPiANCj4gV2UgYWxyZWFkeSBo
YXZlIHRoZSBudW1iZXJzIGZvciB0aGUgZnVsbCBuZXcgc3RhY2sgYWJvdmUgKHdpdGggYW5kDQo+
IHdpdGhvdXQgc2xpY2UpLCBzbyB0aGF0IHNob3VsZCBnaXZlIHVzIHRoZSBmdWxsIHBpY3R1cmUu
DQo+IA0KDQpPaywgd2lsbCBhc2sgaGltIHRvIHJ1biB0aGVzZS4gDQotUHJha2FzaC4NCg0KPiBU
aGFua3MsDQo+IA0KPiAgICAgICAgdGdseA0KDQo=

