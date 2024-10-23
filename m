Return-Path: <linux-arch+bounces-8457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E169AC3A4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 11:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74807B2657F
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 09:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605F119DFB5;
	Wed, 23 Oct 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q7LkIsXk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YckudyU2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25019CC3D;
	Wed, 23 Oct 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675165; cv=fail; b=p6NT4V6mIRxnMuezh24J7pHrvtrkDnAqHMpUC/p4RnZNRF4KqjklC/xAuTc7PFQ1LHjnbpUlGMNipVYOtpVHrP/277sU69vA/cT/6ChTfTjWxw/g2Bi3qrkbUC+GWX2LZX4apgSWYNIAcCRM5nRueelBYroZTZieCrN0LIgimWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675165; c=relaxed/simple;
	bh=tNl/DNINggQV4Imugl14xu2i5MEyvbhXfRK2p0ANuDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MCSayoshuAoXBMhOwcGb2qxtjj+O8Cl/qAMgjmxmci5l+bQdIFEatSaaGwBE3NOpeYzYrCX+eP3V5gm9D6Ep8BoSthUxl36ZrDwuZHJ0mA3F0dPl5qk5B0hgbfCYbhqHl0uvqtHufL6sZ92nBNO78e7fwJCqmDcilsF0y2vjAcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q7LkIsXk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YckudyU2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7tjff015727;
	Wed, 23 Oct 2024 09:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=tNl/DNINggQV4Imugl
	14xu2i5MEyvbhXfRK2p0ANuDQ=; b=Q7LkIsXkRFYbyPb+czghfgTSM9C0v6NYmN
	aMXJb6le/rNDx+5qAPwJCbZe4VJJhQQ/apc4JuWWSuhIuAUPBudyW03V8djVujyV
	nH0+WXklkF84VN7DVKZk8Rw7tPfKcWrbsOoG37UtKBksOMFDO0O5jvo47ajqYsze
	n3XIgMSbHqZ87FFit8TQpMFegKNnUxS4YS+w/lOhIYFN+mlHkH6GjMeRuf+n/UlB
	bpMwNrX4zJQ7+AUvdsE/uZc87dVUaHz6okQ20Xo+/70AJXi6WQ5Fu7R9QS8CNbJg
	cItRO1GuU9oQhQDfgorVU8OOH87pVf/2XfgXF37THvQF5BdoQKEg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uqmsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 09:18:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8tkcL036138;
	Wed, 23 Oct 2024 09:18:39 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh295qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 09:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x04rzE5eeuhnZagLj3LIuS8U528PKemnEmKDtOTzJZkTem0W4a9IVWdBNeitjzLgh0z10R05OA6iYrgAzRICfg4hImuL4qH0Uj55tPsIiPzdAGXYyaa2MPOP+KdcpfyUfME2YJbGHS+heV1z7ZmeL47sXNdyYTszQm9WVdrvU4NwCporRYgVC0a0O2QZcoXAwMKd+SZL7btcR6hD9U7xtTQC930mNVdWna4aqws51gHgjbqpaiZjax5eeMS0NZ3NMJnvar3fDZFWDtufRzIgRYPAk9oOMu1eD39LdE7srvS6ZYy4mXSI+CTMQT8usy66no5DldBJc+4p59pzWXItNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNl/DNINggQV4Imugl14xu2i5MEyvbhXfRK2p0ANuDQ=;
 b=sPNTV8opkpOPnKZ4n4UcXxBgnG3+fZd8ISDTPYK7PgaWxpyAGE0nQ+1GBgpdjXOFCVsWhrCpiZuxCaYVRiTmje0x+650fXipSngshDwMCfROFzgCDcss4C621iUgJX0uLA2lqH+kfk/h3wn3kXb/wG29GMi/lVH2/pfQN3YUPYph/glwEl6XWa9wuVof99XuzEtgR2QqRecs+sPSRLPU6sFwYMC+9HVBVvHOfLMcRv++jMZdNdEY2GqcOiWFXzpH5k57bC0UPD4byIAslISAmQ9rooN0WQybJt3vOAQQ6ZiPzMeCz/oi/BgSMuO5gbnviSrqA22e3wzAnCBHPAWwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNl/DNINggQV4Imugl14xu2i5MEyvbhXfRK2p0ANuDQ=;
 b=YckudyU2sj2MDai0Lr0M0hdKubJ8Q8o3Pq5Riz4+Tlj3f9zuFGM0lTtxAim+XdDUuafmxaWoNKJJmM7JNWbKw9SyjbNbJsCuz1GC9bFQs5DrkSYm/3txvnYXpOa98B1pLLurELRIpn59yquxmlquyhHTJb2KrwrRMwRCAihFh/s=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH4PR10MB8146.namprd10.prod.outlook.com (2603:10b6:610:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 09:18:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 09:18:35 +0000
Date: Wed, 23 Oct 2024 10:18:32 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Dmitry Vyukov <dvyukov@google.com>,
        fw@deneb.enyo.de, James.Bottomley@hansenpartnership.com,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, arnd@arndb.de,
        brauner@kernel.org, chris@zankel.net, deller@gmx.de, hch@infradead.org,
        ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com,
        jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, mattst88@gmail.com,
        muchun.song@linux.dev, paulmck@kernel.org,
        richard.henderson@linaro.org, shuah@kernel.org,
        sidhartha.kumar@oracle.com, surenb@google.com,
        tsbogend@alpha.franken.de, willy@infradead.org, elver@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
Message-ID: <b5792b5f-298b-499f-abc2-db773ceeed36@lucifer.local>
References: <87a5eysmj1.fsf@mid.deneb.enyo.de>
 <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
 <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com>
 <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
 <f000d21f-dd04-462a-9d34-d0e7f0f7dc2e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f000d21f-dd04-462a-9d34-d0e7f0f7dc2e@redhat.com>
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH4PR10MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4a5e96-0c07-40f1-cda7-08dcf343ac25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MDeTHjLkHy649fMjqRQ8s2iqNtM4jcOKCpE8hX3z1R4t6+JSeCcAhtc0vc0r?=
 =?us-ascii?Q?pKA8XvExTrBvQ/jx2qSHZgykLVxFZ7yCe3xtF/F8JlJvtP0rE8OVrwprd8PY?=
 =?us-ascii?Q?xMHeFwYK/bDTICRo2Zv/2X9ybm+IQBaOwFSHjnBZ0j6vj970NqdeuKc3Nt5L?=
 =?us-ascii?Q?JvzyNlQJUuy+6s0RHCmweVXef0n9Asu17UF48K1Abm0EiwqyT/CCUuknS+27?=
 =?us-ascii?Q?p3MNxEbRYexZtencxDNR/cUX7hrQP4ed4wOBTdaRbdBjXSM0/CBj8SKSs25L?=
 =?us-ascii?Q?h7mqmfiVDyKW1WaiPvJ3d6JN7luEA4F9hnT+Jdjmt/A7G9vy5JqjWggsWEWH?=
 =?us-ascii?Q?i3DwQ13wLFJZCuUUFhRzk0SAVRPAg+/AIz8HOMOj8Jk3wr7jVDmOJ5jYcvq+?=
 =?us-ascii?Q?saGrZ2T32Z68LuWCxZyPHkgSjMVHS4OVNm7fr6RrBT7Eqv8w1zJ8cGwBIsbD?=
 =?us-ascii?Q?SRjnJpm1Wo53CY/jWjdbueBYAIJLEcl1eBg9D8vbu01PdxoL0NvaiJY6+XAE?=
 =?us-ascii?Q?5gYRpF1bFAG9BLruDqBOPg9dn3AYoO/L1aYPA6XzeRE6+x48/U0RTgkdCVBI?=
 =?us-ascii?Q?f73pbOSOc8aq/aOAJLGUm7KYx7pFZ0EzXiuWIT9EY4h/WgymzYw9YhNEEhfy?=
 =?us-ascii?Q?Z5jIQp09X3vOcM+Mmym6bAGsRmSn84CQ7HXoX84bCa7sjNpzd8sku1KOmvoN?=
 =?us-ascii?Q?O3ev9UWOauwV7fJPDhUl3iKefDBCtvT7kDBm0Vqe21FX1sUXe6dk7w4xa92G?=
 =?us-ascii?Q?UDGtY3rHZTFzNolo3ZYqrMDzv3rZbvqyK+JqMVm3zxNASGViC+6Z7j9j5J6n?=
 =?us-ascii?Q?GKoE1qb5ZkSBkPs1koIIoFDI54g3w3Ig8PvaSIPcV9mWA13OqVfWLWMTMwj1?=
 =?us-ascii?Q?hGus8k/axbbZ8/FExhBRZ9nrwTkU7REZhFj9N+KyDaUIkcs9LVCJkWQTrpPT?=
 =?us-ascii?Q?2OxEjswnNqUAVeUeIIq3+9KTzJ2LlD00g62S3UdrVdcsL7VBkAgZQV874raF?=
 =?us-ascii?Q?DzAsxFy6WB7F3fWNfCx56j1T8lDkMB6jziYZHeAYNlkIle21tuMEM4Q/BNmt?=
 =?us-ascii?Q?ToqU8yBGBlKc6UFyi9gcMTAP+S5MpQonXuZCxkKsNAhaQ+TqRtsaDcXH1tho?=
 =?us-ascii?Q?AiOArPTFrzJ8zroddkZ58vWzYXHaoKdNzyXli2eXuRaIxQXpdDvijbxqBG+3?=
 =?us-ascii?Q?oML4Soq4u/pRXUPPa4aRfg1BX2jT4W7o0HPuEsYGrHKZ7vEbKlZVXXc3ZvLy?=
 =?us-ascii?Q?ZuK0UbjRMQa6HsDNsj2YOzE8ffORNClumIPgMAINL/UXtqcBxkZjoEkZK/8t?=
 =?us-ascii?Q?3Yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqeHTMYrCu0Ve0H0Mt4JPYn578gCKDGOWGseKYhLm/G1nWTFaSfA6kVjiuJ0?=
 =?us-ascii?Q?Z/llLClPW4BmvVTexmtQYwumcF/8oFCYpav7uDtjEW8m2Ok59kwE6MAZsgRG?=
 =?us-ascii?Q?7mdWDHgcTTnWZ8PMQbtO7aeIPJ2hiVd/wExlpQRmVss+srRWUxzBeAKHuPf1?=
 =?us-ascii?Q?d3u9goZNI+zC7xurr/UTtvwwxtrMfvll1m2cj3p02zSwbIa5MJFesEUvTPez?=
 =?us-ascii?Q?q7iH42ll+g6pGK9g/pOncrwg3WxT1NzsWtRwCnTdgZLttgQxMrNUfNczWon2?=
 =?us-ascii?Q?EhrVi4rbcBx6GTnjk+6O3zuFvWaWJ9XkD9gGa4gPrwutpytQl3kRPtw8E5vE?=
 =?us-ascii?Q?xqosWiffCbPsADXscHf8cB29mz5Yb7GjK8fk8FkECUm6jNnyWOtgvisu3kbG?=
 =?us-ascii?Q?XyZuBA3XGG0bPwXRAkgR9tf3B/oCw2N4SCNoykKkLv6pE42OOSHTkqR3Giu1?=
 =?us-ascii?Q?05ZHTBb1Ql/DN99GkDbx0rXG0gNwevr2ZPENoMmj+LmLI9qtXaR4O/uvoS9H?=
 =?us-ascii?Q?Ri8plax57W9QfkLgsTpCX286LkxuBR/bMY/UfthRCN/IrCcUOYhC2Ib41yhA?=
 =?us-ascii?Q?xnZmIXY/a+GD7sMm1CWvm0634Jp2/KcdRfLylx9pPM5kuIDIX9Qvp0s1hP59?=
 =?us-ascii?Q?3DZ7ZsSPHA9mKrHI5h+BHN/9s+pCevQl1qdqzDiY0orK8lQiLCwHmnp3X0Ew?=
 =?us-ascii?Q?hXlVne9TQ/2tsyQKo+iL2BWI/DAhZG7xQ20PjrGLlerOJO2LuiR9FGNUt6A6?=
 =?us-ascii?Q?zo5RGDsnOMUMM7mAJYHTTw0Hx2JKmaRiuXTHruOr/wC97xFRxBQBD+ePuQkm?=
 =?us-ascii?Q?8VvJNC1dUDu1GpAdFvpB0bwRD8zKJI/sonW+6pKuNF4lV6saH4r19zaPm+yg?=
 =?us-ascii?Q?9fY69oQ1UIURFv10NLhkGJDIpVaeAxFyZTMIPPI+mLCofvmmWYEIUbFFJeRf?=
 =?us-ascii?Q?+zdIeqtFV73d+J51d5YEL/0PP3/gTElRY7iX8zal4bETeH/HtsoC9l6gLAJN?=
 =?us-ascii?Q?FA/m75w7qY5SdKkf85ts/2RejWOGP6gXE5Ndtr/6HiWC91m2JwRWZANS5QCP?=
 =?us-ascii?Q?76wcfeFA5PP3xJRAvknrXrltCAdL0GiQtxltaBRbCefTswrl13gRxeZadU9f?=
 =?us-ascii?Q?p82YjWWEHSt/wwl0ii2YqVuj8KZm1u0z9uaa4bKim0issdaIya6WujOpN0ek?=
 =?us-ascii?Q?NZ3Yx37ZuJpiebTYo82a3uZvNzHNt1RB/tpPH/tq4klTaAQ0rw0S5AVm5jKB?=
 =?us-ascii?Q?euVG0jxXDzQ/eJ3DgOErxofTZCrnfCiy0YUJrkm0yYoAJ3sj15tEXzyjdAfP?=
 =?us-ascii?Q?LMY/Qpp2lHsT8+J80b5W14kbbfG0QqE+fztxH6a+apkHxwvcswikTVhWgVav?=
 =?us-ascii?Q?/Aqznr20mUgPsJf1EjWd6i7WEbnU/hNewrMtIwzCUkY7ploFoWxib9El97QK?=
 =?us-ascii?Q?j+RBQQRyk3IZvSGsC9iP8ur2CxBRiuHoKzjQjNuxUW+pJinAQQBu85vSOL4u?=
 =?us-ascii?Q?UEB+pLobnwLTGCEOa41Ba8UuyOqfGW6swBH0mvpmGbE4oGr4+cfrIRy5IAin?=
 =?us-ascii?Q?ANwsyc/3F3vGiQBWmQ+SxBLK+i64nxpUkXXTGCIyfQBpJkTJRpYMO6ONlijI?=
 =?us-ascii?Q?7OPtb6NjqQbdzUsfGUoUsfc04xDGlXe/Zf/Q43mvDrmxkqEJlQiFKZST0Ds+?=
 =?us-ascii?Q?J+P9YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fN1yEN33LL2F2ePdeptZl5ixmvA7aYRu9o4HpYo7lBPNFhd3oSlh2LW1lhYP7C9/TtHMEjqSKwe/y84smBvnNG22e4M5CdYTUjNIajWIpCfY7VEdjh6nZPA5RBbctNLWqC5efw5MInPlO2gbYNpyZgvDZ1jssp3DcsolUhLzsttnAht+8zfykzhCW+Qd5ADSQpJ12ek9a87iZ2Q8Y0bvoCPv/048abOgM0Mwlm1WSHILDxJhgXRM3icbDfBWx1KL7Uzt6vKVeSCTexSlSvXitjQcWMKpeGfen/Sgsx5jclBiHEV9GHp3uuQkAuhMz0pUWERxwgH5XUacciiQGmz6GU8Z3Qtyxp8EpSRfsIRJ0ciq3li0fKk+EkQkuWKrd0hVd/eDdol2tz3SbHs0ODwx4Tiw/wzmxP9aHg6izBqzFHaXtP70qUQuDdrTUgWWWZjzIXKIHIN1HUkjf6CzXc9iJN5+b8/Dca/E3Vimr93Q5cbAA5YeYqrPzdTKtJDxn8tTFv+B7fGWWNQLa4RXiV4DcWDvHMEYSP9TOX4JkqchN1McVY4V3CpMzVG8RvZ0J2u/5Z7x3Cs5odmcloh3W2b+1QAsVbSt7cGXh6fr0Oss72Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a5e96-0c07-40f1-cda7-08dcf343ac25
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 09:18:35.8641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJ7oXfKMkzT4K7hqA0EDhv3rxokDABsPNCxM6qpj8ArFQAtBySxgZSkuVqrHODLQDmsRnA9+rmie9bMweQAg36xkJLeGXjqeitesp+LX87Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_08,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=600 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230057
X-Proofpoint-GUID: ASF0hi0yZ13PCCBiCgk4iSOrdHjQ5_q6
X-Proofpoint-ORIG-GUID: ASF0hi0yZ13PCCBiCgk4iSOrdHjQ5_q6

On Wed, Oct 23, 2024 at 11:13:47AM +0200, David Hildenbrand wrote:
> On 23.10.24 11:06, Vlastimil Babka wrote:
> > On 10/23/24 10:56, Dmitry Vyukov wrote:
> > > >
> > > > Overall while I sympathise with this, it feels dangerous and a pretty major
> > > > change, because there'll be something somewhere that will break because it
> > > > expects faults to be swallowed that we no longer do swallow.
> > > >
> > > > So I'd say it'd be something we should defer, but of course it's a highly
> > > > user-facing change so how easy that would be I don't know.
> > > >
> > > > But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> > > > guards' series is the place to also fundmentally change how user access
> > > > page faults are handled within the kernel :)
> > >
> > > Will delivering signals on kernel access be a backwards compatible
> > > change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> > > It's just somewhat painful to detect/update all userspace if we add
> > > this feature in future. Can we say signal delivery on kernel accesses
> > > is unspecified?
> >
> > Would adding signal delivery to guard PTEs only help enough the ASAN etc
> > usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> > whole ASANized process to deliver all existing segfaults as signals instead
> > of -EFAULT ?
>
> Not sure if it is an "instead", you might have to deliver the signal in
> addition to letting the syscall fail (not that I would be an expert on
> signal delivery :D ).
>
> prctl sounds better, or some way to configure the behavior on VMA ranges;
> otherwise we would need yet another marker, which is not the end of the
> world but would make it slightly more confusing.
>

Yeah prctl() sounds sensible, and since we are explicitly adding a marker
for guard pages here we can do this as a follow up too without breaking any
userland expectations, i.e. 'new feature to make guard pages signal' is not
going to contradict the default behaviour.

So all makes sense to me, but I do think best as a follow up! :)

> --
> Cheers,
>
> David / dhildenb
>

