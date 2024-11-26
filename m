Return-Path: <linux-arch+bounces-9161-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846899D9138
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 06:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7761653D8
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDE2746A;
	Tue, 26 Nov 2024 05:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HT7KfzGx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJaYkYWI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3D7E9;
	Tue, 26 Nov 2024 05:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732597372; cv=fail; b=kIbXHNKloKreYsNBKGUfKXFi0B+egA9HBWddBkN7rCMkaUVjR+IFcfokeXeBClFur4H2JzdshPUdtX6yGPlUJH2nmPbZM6txFmcxhXcd44wwz2ehQ2aSL96Oj3ofEaNDUj2O20yXJe99In8zh9tItJreNDh6PgTHLWPIGrSygxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732597372; c=relaxed/simple;
	bh=6Z3CCC6oqMLbbDj0SS7tx4LiJL1Tc7DbZNs6mWC84U8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=bkmjwtCq1ybTLVmQkOm80T9WUBobVn1VTXHFTPR3/3qBpvhOKwSDmOwKBuUpOQseDxewPodYKITqPG/lCUa+4YxgHN61oYffcM5Fq810V9E1J+BEkLtgR1U6JBXT1mRg+7e7oYWxewHp7TUTv5egxcn3+lUqWm0ryarqrfMAPY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HT7KfzGx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJaYkYWI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1NJm9022521;
	Tue, 26 Nov 2024 05:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SQ5YbuKh38i3Xypg10
	f8rrMr8F+CgJqva0XxeFO1bq4=; b=HT7KfzGxjFFAOb8kTy8m519jk3nd2UIzoX
	EObsIX2vWEoEs5mYA3GtfMvWMblku6Kqkw+jxuymuv02/PVhzLwOLi35YjoFJbUt
	g4KQCAWQwodj0Ab378Y7ipzXaofaQZeouA2dkrgbkUiGvgmc/ucq3S9KsyAJ+X3f
	qfd19jVi9+nTKOa3CcWSeqr+hc7fQk/bLuVpl6W50b6ByhLWsyqpg4gQ+aZR+WUL
	JrFEguiSI7y6nLD3gw3ljFMQf/krmmARjyTK4LX8uGNSTo3XOuKfM5HoIy+TsTGx
	bn7NwGBzGkZ78bG7Kl6gf2MtNG9WKyx+vUN4kuma0KtGdDqaJPYA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433874cmc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:02:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ40GSJ023429;
	Tue, 26 Nov 2024 05:02:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8ew2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxajXMncwVhza404MxKUb4HRkkUv3l7IzyjBzVHcolPy//K0UYI89o44xrU8496KXo5zx7JT8KJpDIedHWx2SarV6+MDQAGlL1JSTKAHA21KYdiYA2WVbilVwyxd06qOEonUrMbYLCXrSB7MGbOqr1AdCa4EZehkfekkEiAuhmK0ujf+OpWgDCa3w6PQtQLpvLAkkaCUlrPqV4TJjYMhih2jGu6oV/xcrGOwa97brfmZ1Ki6Xj1nyKKJ5f/rlbCqDGZPZV1RhABtkvj0KDHIk7+yxXs9VclHWiHzSERHRKN5dJCvNi6+39GFPZLaXfkUvGb/9mgEEXsghddMjkJH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ5YbuKh38i3Xypg10f8rrMr8F+CgJqva0XxeFO1bq4=;
 b=puO5OX1DFXklNNHyBSS8RDp4oM0Zby7JQbdpzAbeeFUIwp61ELp//1/ZICc/UNAJ0KRLlhouA2tKzo2aRXLbrj8XVhJMpU2Xcr//kIymogp+LQLMbvSUEJb1/Juc4LZGmp+e+7rHSNZDgWJRl+pxhW2wZ212GiX/yd/pJw2cvslIc1J7y/iAePOeu9QxNoVqrNJ6Rj8aSSD4cirxErHerV51Fwn+N8su1oWUBkPQPcXqcAUiTTASNR+lGI4lume+XA07S96TMnUnvPRwI/u2uzD8PJbhayEAkwm5vMTNl35zyBEQA4+dE98ph16QuZxtXfdZmoNHdPhWVb5P/Tnq6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ5YbuKh38i3Xypg10f8rrMr8F+CgJqva0XxeFO1bq4=;
 b=YJaYkYWIKBAQz0jEB/1HPRAPHGDFLpR94TlviNiRtBslSktTLHosI3vQKaSC173MOai7dVovtNdLyhaY7SHHVyVFSkqJvuEsMIsEh26EYNI9GDFN8oX9aRExPKmqeOyw+NhFwJxEG0+zBAG/sN+WnZZThxgZU70JnuCZMLRlLaU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 05:01:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 05:01:57 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pbonzini@redhat.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org, arnd@arndb.de,
        lenb@kernel.org, mark.rutland@arm.com, harisokn@amazon.com,
        mtosatti@redhat.com, sudeep.holla@arm.com, cl@gentwo.org,
        maz@kernel.org, misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-reply-to: <20241107190818.522639-2-ankur.a.arora@oracle.com>
Date: Mon, 25 Nov 2024 21:01:56 -0800
Message-ID: <878qt6h9kr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab392a0-7435-4687-cb3e-08dd0dd7741d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0WYQV7DumcoI/hVO9JqAMlDI5Fe+5MStTSnmYikzEBM4tR9Bo1OHTYOXl+9?=
 =?us-ascii?Q?++5XZxHpfgkBivVf+2/xfxn0amjd/n8HpUTgbc3y5crSW6gDXlqgMYHA0b1Q?=
 =?us-ascii?Q?8DAgSRCo+uPLqzjgK92yZvl7oxlMLBEq+QDVtHidk1um8zQpSD9mxoG5IL2A?=
 =?us-ascii?Q?5DuQwPQP88bdN4hDbhVxScBDWIFkIeFQZX8wDwOtFimdRsshzCwLtb46sM1C?=
 =?us-ascii?Q?GEvF0j9mH3uIRbuXjtJ56EwCwpndUy+EmqzqDn5dVOBzq/CbtL1gHdDmQj6N?=
 =?us-ascii?Q?QjrgvL+Cpcwy9TJQR2tzYLoYntz5CMSnVWoKYRKgt32b1pbhIQ5skEbkJQZe?=
 =?us-ascii?Q?apF8jtBkKOMRBGrn6OL2sMq1nfvWdPn+9dGUBwx1snHPGx6KRKPPjNxJV4JA?=
 =?us-ascii?Q?bc1IjGvApyhGtbm9ZdRFK/kyrdbJfVBzz47JdeXE+OWPuXQMa9nIVXNBmPKw?=
 =?us-ascii?Q?Qo6sKYEJHCE5QSBe02xZk+mG19dsHUj1nWn/kvH+gHxEvpb/7++7Z93yiCjy?=
 =?us-ascii?Q?/bGRUIn4XUuANChbYKPTI6WkNlF6iadBpl/0oB/x9Kc/3tyDQujwFJ/slPGa?=
 =?us-ascii?Q?3WSf9kTd+PoZ37S4CWgqlOwOSkyKYWcPjPDIZBwMt5oD6RJ5bwo+JcNpGiW6?=
 =?us-ascii?Q?kqycGhEPc69MC/4Z3q+sNRA8ZKu0y3zIUqUhjbga7it0gEMsOpaTK1MxHRvT?=
 =?us-ascii?Q?bIadGezpqPYP+foID8xf2DJpGPLPjDFwaylO+PvWiEf/m8W1D0We7QxQYTjP?=
 =?us-ascii?Q?o5MdjI/Fk45bzAo1hPOZN9qRFWcJU7bmf/aexHcAHm+cSIsjks1ha0nRpKPR?=
 =?us-ascii?Q?qe+qGqmyTDwlmiy/+fpfSo9wan/rFNaUANh/QgdztiseoIPffd1RbOktM9o3?=
 =?us-ascii?Q?RgEFJC2zetvATdEmn5edcHZStyfnsNlWSI9m0vgW+HDQft8SAe49IvoFqFJC?=
 =?us-ascii?Q?IapBXbnRLaA0Mfbd9aCE9JvuUAtBKZHDe232l1OotjlNRbqS1ufHm0Ft4NFc?=
 =?us-ascii?Q?vq+ReRZNbBcGDJRqdqlFH2h82ud3c1Weszs9xK+zdilc9rESM5+MegRjvF3h?=
 =?us-ascii?Q?kY52i79ltVjoM20KuryW6GOy/x+DFr7rP1Dfo6vYwaO3H6ydtD71B+bvzFbd?=
 =?us-ascii?Q?ez/hdyPzpsPSDg7VRElursBe7VMGOMrUl6J9Ir4ZGirk7FZEgLDKR2q/iJKR?=
 =?us-ascii?Q?zYPC6ONbUNRje5P3ysEeJC5VoLuB3qR445NBLMl0sdc6flBCNRCrHfArBK+z?=
 =?us-ascii?Q?sNgco+qiFZq0deOHJINTA5MFFRgHSnV3TwN4cXPqPy6ibO27TheFqPXESTSW?=
 =?us-ascii?Q?4G9jpDX6JjSXWcQU0r5iRhiR2es5tnseP/3FePG/9Dz7nw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bzh5Z4Ab7EgZRsCcWiAoBG9dShx9bjxWu81nPwcml7xfR30tGC6uvm7Ruif7?=
 =?us-ascii?Q?83r2UIUbhB9FxrrZ7nHuHhjrYI6HmWr0tAfIJKUYC2FjpLsR9Ep/LwBssHQv?=
 =?us-ascii?Q?u/RJTDQdXcA9nlUzasQ6j+LSnNWSrtxZqr84s3rm54SXwh/mbV2t5wC49x0n?=
 =?us-ascii?Q?zME/oQShSZxd5OMLrAowOEbBKjJ7RvuOUTv3ORyHZI/PMAy3wAmz+TaW1LMC?=
 =?us-ascii?Q?oq6p6OZn2BrBQAlY1sYvINxvmQuqn5II/qxmpTDW9xPeFQJZwauOR5nHL36l?=
 =?us-ascii?Q?v+o9iwDG1YY3oILaE8EUI2v+i+ZLHEauYpqCkAbzrfTJAaL+enpegkXJrGgh?=
 =?us-ascii?Q?4D4ZVUoqzgnc+N5Q0ZfDld515Mt5pw53ezVihDHGiVkdHC05HPmwaXC5MbOM?=
 =?us-ascii?Q?9jbdf1j2WDC20SaAAzvwNARlTOhNxjpbmKPhvY1LTNGe3Z2Xw9nlslFgHMCp?=
 =?us-ascii?Q?k+g1Bu+xRimMfiae/7jFQDWkQFvLu8mliTYQxTvXf3HpY0O7RFlOl0wCX7pH?=
 =?us-ascii?Q?wcBaVjptuO+QMK0yqjQzSliB5pQMe+FIUXUKnQuJEUJgM8uzleQldayhancp?=
 =?us-ascii?Q?bUTk5KEtEcH7sTBtxDuI7jrHT7y1lx5NHi/nf55SWx7D10A6+6PfvtX5r7Tc?=
 =?us-ascii?Q?CktkNXIisWAj67oiFIG0Kju3037o+l37Qo5onpwmxzRJc5cIsCmtKvP404P5?=
 =?us-ascii?Q?qv41C7j4NU8+zEyhxLysXTwIjpRoO4MLkhAZaJbvcbD9gs1YjCP5W1fnXKMF?=
 =?us-ascii?Q?ltNlqJSvN1Kdpok78cchYtBZjeM/5GFhhLkgdZKqJs86W3sRIu6LDa8poTmy?=
 =?us-ascii?Q?nFWHN3JA0lAG4a0Q+xJ23D0XGig9r9s44UBN1rrASVsY5DvzgkXri6rl7K7e?=
 =?us-ascii?Q?wuQKfvKln5fD/CfAaXvMCXf4VRqzgTHk0qTBnNZ2TXWPMMUZGlyU8ZYSZvRF?=
 =?us-ascii?Q?Diy5cHljctui/AwwvIhF33OERVfw09xxoLGbA+nbaghR2oW/hG1aP5fFsadu?=
 =?us-ascii?Q?6L/jze5P8XGxdEg8X6obm+JPZx8OPchnFMmiy+RIIicooA80CSmIY86dxSRQ?=
 =?us-ascii?Q?bJhRV+5MdJA0+n1Hejc9mGIsdh09hlJ2FUSiHuUgzorvQpqW26dP/6y8T6WP?=
 =?us-ascii?Q?zPo72XgqgX0x6kI+7vVO3phFX5GZjTZ0AKa+mv755duV5bSN611gflk1OwqN?=
 =?us-ascii?Q?HJcYPis1lgwOt1KqLVVLbFKKhK9YCAdgSLRo2YBfqXDEV6xSz8AvqvZLRfU0?=
 =?us-ascii?Q?VOTNHDyTZY59YmlmiMcYXxtL6x/f2rt/48O26d8GHEGI7Ho9v7XpQDTLjgO1?=
 =?us-ascii?Q?iZLNPrM5LARZGorLv5KTeU4INtmVZvYIcAxCq1vFxmlh/kHvVQ/7XD63sRqo?=
 =?us-ascii?Q?aPi1YbrGUrICZUE1ClHFDE1Z02yK86mkmfc1F2lQ7KvMF8R0kqyXQHVrTZBn?=
 =?us-ascii?Q?TrZnAdqMXZD0lKn/O16WgsjFZ8OuwYNQLvnmXibBdGcdTpu/VoETJdiCw35G?=
 =?us-ascii?Q?KrNipnIMdGFFP6xaF0T2OdGJ9IdWzS23QEk+ItgfEZsKlAyUXUlYdhjgYMyD?=
 =?us-ascii?Q?7efpdlVzAvgMSM74dTTuSkHxZgdXYUulqIbe/0RtLzKOGvLux0Se8q7B9M9n?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1RGyrbYL/15HTNJC4xkNdKO+kLobcGXlYZBdIF/Bipf1vGtqKnMld9ZJZaTROhv9JuhOPNI3Tbwvx6MNgbad0PWfxpZGH1EjY/Io9wC77JqZ2WGzxk6xB6m7Uzs9mbTwHj+ovoTDNZITXW0KK70SDb6C0z79iuViYOs5A5bR+s3aesj0IYAaPtD+prpzIxsV/DrpDDdBWaj2wU0hph5z9JHVN3TZb3wHGp5R0WfNLON2rckRf5b2+OUvvzgInGCosAlL5rWHnu3jhmO8L7cgs0RSDPwLx/fl3VMsMF5yKaz7RixdnCONuWLWCbJNJZ1aYJCXRwLk1Ok4lCl0lfYDQoiy03ZlfUWzIp5srulwlo4pK5n2EVgtwk0COWiBT/u2DV0sHOyhC2Gw8wErGUidfz187x9HIRc/mcEo7Tm5NOkDsw7HFQ+riuvX+JOQuIgKHzRhodmX1zdiMvyUr5UOcO9ldlNWSdPsf100TBFHNOw7F8e0vjnkkhi3A21MJ7vlHgvd9ouhA/N9EOQ2rZYvMKQovyIUz2QjDDEZuGtCQAf+SGututgkk7yroDY1G4jaCMpZkikZKRo4Yvl13zwUCIj1NoZvzIvh2WhUFdqD3m8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab392a0-7435-4687-cb3e-08dd0dd7741d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 05:01:57.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brlZA5+7PsdDFvV2mV4JzuOPXImIqE+U+Vn5cyW8My10jUbLgbTSzOaElI1vLaVhUBO4seqr0Cc8Nt99GeKJgTO+akZQKb5LwaJ+w0EYuwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_04,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260039
X-Proofpoint-GUID: hPoWFgLcPviu_JqjnR5VD5G7rxUCmnJQ
X-Proofpoint-ORIG-GUID: hPoWFgLcPviu_JqjnR5VD5G7rxUCmnJQ


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Add a timed variant of smp_cond_load_relaxed().
>
> This is useful because arm64 supports polling on a conditional variable
> by directly waiting on the cacheline instead of spin waiting for the
> condition to change.
>
> However, an implementation such as this has a problem that it can block
> forever -- unless there's an explicit timeout or another out-of-band
> mechanism which allows it to come out of the wait state periodically.
>
> smp_cond_load_relaxed_timeout() supports these semantics by specifying
> a time-check expression and an associated time-limit.
>
> However, note that for the generic spin-wait implementation we want to
> minimize the numbers of instructions executed in each iteration. So,
> limit how often we evaluate the time-check expression by doing it once
> every smp_cond_time_check_count.
>
> The inner loop in poll_idle() has a substantially similar structure
> and constraints as smp_cond_load_relaxed_timeout(), so define
> smp_cond_time_check_count to the same value used in poll_idle().
>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  include/asm-generic/barrier.h | 42 +++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index d4f581c1e21d..77726ef807e4 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -273,6 +273,48 @@ do {									\
>  })
>  #endif
>
> +#ifndef smp_cond_time_check_count
> +/*
> + * Limit how often smp_cond_load_relaxed_timeout() evaluates time_expr_ns.
> + * This helps reduce the number of instructions executed while spin-waiting.
> + */
> +#define smp_cond_time_check_count	200
> +#endif
> +
> +/**
> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> + * guarantees until a timeout expires.
> + * @ptr: pointer to the variable to wait on
> + * @cond: boolean expression to wait for
> + * @time_expr_ns: evaluates to the current time
> + * @time_limit_ns: compared against time_expr_ns
> + *
> + * Equivalent to using READ_ONCE() on the condition variable.
> + *
> + * Due to C lacking lambda expressions we load the value of *ptr into a
> + * pre-named variable @VAL to be used in @cond.

Based on the review comments so far I'm planning to add the following
text to this comment:

  Note that in the generic version the time check is done only coarsely
  to minimize instructions executed while spin-waiting.

  Architecture specific variations might also have their own timeout
  granularity.

Meanwhile, would appreciate more reviews.

Thanks
Ankur

> + */
> +#ifndef smp_cond_load_relaxed_timeout
> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr_ns,	\
> +				      time_limit_ns) ({			\
> +	typeof(ptr) __PTR = (ptr);					\
> +	__unqual_scalar_typeof(*ptr) VAL;				\
> +	unsigned int __count = 0;					\
> +	for (;;) {							\
> +		VAL = READ_ONCE(*__PTR);				\
> +		if (cond_expr)						\
> +			break;						\
> +		cpu_relax();						\
> +		if (__count++ < smp_cond_time_check_count)		\
> +			continue;					\
> +		if ((time_expr_ns) >= time_limit_ns)			\
> +			break;						\
> +		__count = 0;						\
> +	}								\
> +	(typeof(*ptr))VAL;						\
> +})
> +#endif
> +
>  /*
>   * pmem_wmb() ensures that all stores for which the modification
>   * are written to persistent storage by preceding instructions have

