Return-Path: <linux-arch+bounces-13341-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946CB3C514
	for <lists+linux-arch@lfdr.de>; Sat, 30 Aug 2025 00:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF5FA662C5
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0DC29E115;
	Fri, 29 Aug 2025 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VD3Pi4Ws";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wOxawcO1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D927B343;
	Fri, 29 Aug 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507159; cv=fail; b=kFjSGOIEN90WFrNrrurfGSkMtwTLZQa9SCJrmHrPi9O5j/22L+QidXjTx1K0XWwkYr5Pen87XvmmKa0nvFchs1XBO9Ampt1ttKQtfjE1W4YnWxM2VYLQyUklaUWTZe9ggY6rpufhkHKbyKcQ+GhOsW7cFxNgoqhFAbEM4t6ponQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507159; c=relaxed/simple;
	bh=bcWiOGkJ2qrNPBa1YW8dfu3lNF3HbNcX8TcBekh/z68=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=joOEJ6g696xSyUc21MdRut6z1azuuvNSyJi0nFdh6AUM6BJmdvLXyq5I0qtxNBuOad7LHop5+e9k+qUx7fj6I0NVYWAL3xx1YVw3gh5EpHNCeQG2RF8VivYQV+hXrIN0DAsPMGpLCKGQrhEii/3gyWhEDALhsuPZYyfXU2hmizU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VD3Pi4Ws; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wOxawcO1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TGg7LH010079;
	Fri, 29 Aug 2025 22:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8oEu9iH/opr+3A4TH8
	5AlemGz1402PTcjIZHlz92jDA=; b=VD3Pi4WsjVpRn1BQWNZGl9BqYpQY0yCGy0
	Jslfd0k8qVKAz1kaa9sFGwhDTmGw3UFEqbKvZ1+EVZHY4aLjpFhcO1852+tqkiSa
	C2OLrI9s/Rzvb7vV79V56rlvQMnqsupZOFGOlBPPN3pjyKrW8axbZbwCTP6VggL3
	0eq7u3tFiKj2AHAfX1Al/1wPEvUijdl9jV30OgdSkifFcBlcWdzV0WuhqgU1xRRF
	HT4Kmi+g6Q1mpInlDKrdtsSRt4NCsoGWFKoNtI7iIpXzOPBo9nNg1amcYoiRN9am
	+mDlyGheoFjhBolswyuXFyzXkt5Xrc2krx8HUfLYXk6zLNygGjUA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twj1aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 22:38:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TKcdxs019697;
	Fri, 29 Aug 2025 22:38:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43dq6uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 22:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEJxVHIjaYNoAsgrVxnOY67pMlgItoEJFt5O53I2MmH4Ax7oU7c699tiVEyjB6v87AnnX9G3/L/blZpK6fnXR1kEPtHcWMBZv0b/24LMbZoKUIdyovKiQqBGX/o9YHACjbvKVeNW/JjBlnoaKLkp++hpl/Q8HgP+wHDkgO5RqM8knjSz7zztA0UIPFIjPbLngGDiCaLHGCtu2FLYpIxKCtbHSAp38ZPQw9a+Zsgx0XlR3o52D6HszyIIcDaHsx6ONao9Ils3dIKlxzKKQLiEWSfO1YD3mu5R0D7rjgRl5kipZo498rbs4Ww6Ezb9HjTW3iPk5e/iKRNeRgCtFT8/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oEu9iH/opr+3A4TH85AlemGz1402PTcjIZHlz92jDA=;
 b=GXTsSW2XwOJlkOeKO2SXkyNGxVSkRe5h1ENgRBaOQ9Rnd35Q4puARPWrGaQFxQQztH0ZxCcvasPc7YZuEZl9N1JndJrq8D7soq477xQdVwxpq36UcPm3PZ0smZKkmM0D+5Cwx9L4SHa+qlHvlVJU1jc2INoPp9URL8hdF2g1qeu76YmITWVVizJvvj4hQ0JL6HKQjwmoxZp2uadBwiBst2IHtv0eIb2twjwSfzskg/IWS3QESkyBgbI6x3Fd7PpsVnuxbrkJrVtgplLwdgpOol1eNNfhMzcTc3tH4ssal/9dge43OXRoz39AX4snqJZSD7UyYDKnw6Vxj/BqG5Ytww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oEu9iH/opr+3A4TH85AlemGz1402PTcjIZHlz92jDA=;
 b=wOxawcO1RGmLHwKKAiNw0A4wZG+gcISpYQQ2W0ccUtRNlkgHnCYlImUNz+hviqS0D0YUPCJlNaQ/8qIt/ZIzNFBfKzfToPdDNipYV0UP5e/X01smbafbzL82Qy8YWkpJUXXKeNRYm6ShQxotNCXkvyNv/XJGOVrHdsqj8d7OR3Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB7444.namprd10.prod.outlook.com (2603:10b6:208:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 22:38:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 22:38:37 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Okanovic, Haris" <harisokn@amazon.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>,
        "ankur.a.arora@oracle.com"
 <ankur.a.arora@oracle.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "cl@gentwo.org" <cl@gentwo.org>,
        "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>,
        "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,
        "peterz@infradead.org"
 <peterz@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "memxor@gmail.com" <memxor@gmail.com>,
        "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "will@kernel.org" <will@kernel.org>,
        "zhenglifeng1@huawei.com"
 <zhenglifeng1@huawei.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
In-reply-to: <2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com>
Date: Fri, 29 Aug 2025 15:38:35 -0700
Message-ID: <875xe5sqhg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df89cac-cc63-4021-f19f-08dde74ccb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfqqBhCR2bp7FGgT/ws/eC2W8ZMddxSiBizBd17bnDKXF3YM/T4uJEjY+CMI?=
 =?us-ascii?Q?pAQ7DTBlBNglPkd6Yfzdg2ncBAf3YwZppqso3k12axDhxoyoJreioUCYSmf1?=
 =?us-ascii?Q?btmROchDIswVGaH+azXwoBtTwJu85FbqbQij0adM6U4qF3KrxIKcd+LsDz70?=
 =?us-ascii?Q?iSqxwFHN48lzDz1YzgbFedSxvjxsMONOiq0Q03VdYjb4zNOOkgphFy5M/uzm?=
 =?us-ascii?Q?V/I1fiCTDa2qtGCiHxPEPFYf2Sxvr8DsFmbWKRNLxbp2/EOVrVEaAwUTZLcs?=
 =?us-ascii?Q?IuNawsSa96PFW2mjBnBpNCCFl9ZHXt4l396a+sFczgYHl2mu5OLr6wwdCKgi?=
 =?us-ascii?Q?ygMP8IkEepBRNAXlSUr+UsVybrnhKk2nCxxH/eUE+h7N3U+lJcL0u35C52NB?=
 =?us-ascii?Q?nbjorojRpIlGgA6gKJQ2ZCPRPrue+IWPhGkU0zKUL2uG6vbu/UpwrSx07Zfy?=
 =?us-ascii?Q?ckAj4LVUcpho3YW4P3e7b30Qgrd+PI4bj4b9Yx6KZdEeCgszSeaMG1pkMFwO?=
 =?us-ascii?Q?XzDDLkkHvRZvkrHogwNMZdyt4o2PX5RCyHoOsMcm/+8zoxnf+QJpx2kpqFNh?=
 =?us-ascii?Q?1oqrTFruZe+LQW5ojXKZEbQ74Fys3rF/NumF10nB+f2V+hdpyVrz2FmGSkMk?=
 =?us-ascii?Q?XybdGUi4CjW37pBbWJ1kWF7i7CT3h++vOqt8+6C4laNS04a/F2ppwnJPc0s4?=
 =?us-ascii?Q?rYT2e2pNn2qNKu94f8iXtkMxNhPTCJEldg+BsqI9bA7NKzQdeVtvVtc8HJhh?=
 =?us-ascii?Q?L06iV2XLjBcYntz/pQ9sMNEG14ClW1LXh9Ov3FzLQpptMndgUC5TLinaPVE6?=
 =?us-ascii?Q?7UXLss9V5JooHJgifG1NlrKhqjZs3xx6r5fRSOu8WUMIqQnfw5mbDdXrxtON?=
 =?us-ascii?Q?cJ4YLdZsUPMJM3bzbiCFzQYPrDjDltDw67QhSw9e/ZOE1VZEV1+lwsYIvLeC?=
 =?us-ascii?Q?B8P6ExXQXi/RJYqKU/m03bVT/abXJL/S9F3NPNR2yeqOWrUlHpEbIs+S3aV1?=
 =?us-ascii?Q?VEpt7soG4L8m/Dmx4QexE093fgWCVOAN1p5HwBE4wImU5RAN2tJhLyHyEgSp?=
 =?us-ascii?Q?nkhS0A7DF+T5vQQssJWRbZEB3vgiNlAJa3olWlrjMEnY43FI+KeZ4Xp1E0Eo?=
 =?us-ascii?Q?drIp2/YVLpusUWwTTtOm/LKsF8LO8qkUKGmObWB06INGhsGnH55h+aSOIZAf?=
 =?us-ascii?Q?gpEhYaoOY0hKW9cXA2AHn67zOknnJob19qKUS2i3sgwyJ4Tu97OqiI2d5E82?=
 =?us-ascii?Q?ETGP5UGMcKgWIovMAriu86/PFPkM9lj3L5zQReCUyNAe1UpgWiKgvG83eot5?=
 =?us-ascii?Q?URyJ7v2ZRn6S2+Ym2YXeOzMkr070xhRYEL8q4KYzYNUSji5RTZhU2niM91o8?=
 =?us-ascii?Q?Pi9XlNhsDX1wMdv4adLdfp8mAejbZSD/Gs4LSZJ+H//cYFU+5vRzYfc8s8mU?=
 =?us-ascii?Q?URkL8+L5dHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+/klBV2iBQo+ScKYqeSqIlbVq4andNMuYm9TTzMqnd+Q9OOJ2vLTEc/8iJIq?=
 =?us-ascii?Q?SxGkn77sitFIVPvTl0zOhHSbQeAWzrtZxHJRhgBoBLkzpJ4YYsTTeTnJsEqX?=
 =?us-ascii?Q?EwydjZ1EjR+LoNjaw1xMqNsVHKzm017V6JoPPVA3w37fqbze3uL/8sV5akzu?=
 =?us-ascii?Q?Fl5v69bChSW0NQqrFHbvGbJpdliKYr6kqNtQmB3IQYkP9JXQMI5GxpJ8YMW0?=
 =?us-ascii?Q?Qnfx/1G2xP9Cq7MImzk3sd4MiQWBoFp1jIcrAIk9O70tlCyYYrS3FdKaniLj?=
 =?us-ascii?Q?ASIM5XHrPgL63nV9R7R4eanuL3+HaJuKD4nIce6FYAE7JH70we0qfbJu+wiA?=
 =?us-ascii?Q?HWW1A6MvtKvbHD1OywoT9dsvJAoJpQgtcgs5jZyS9bmqrlVKFAhKsLu0e0CS?=
 =?us-ascii?Q?qP8CPfNxr3dMgYXAb3F8k+KbS0I1rtbnmfFBWr+nbxNv/0mmF0QOrUqZbfE8?=
 =?us-ascii?Q?aaWSXFObcALfyRrHDVPgGc92HCzEW/q6NJYiwalLGvuVw8C2QnI7qIFeEfEn?=
 =?us-ascii?Q?qknLAtCsKBa0oKe/FTd2FI2maVrfX1sJZo32HupzcvmWCmff4IfDW2zBt8Wz?=
 =?us-ascii?Q?FwbeR5yGlv7VhDN2vH+7gapE+gp1M7mgnjc+T/TfrOzzANXQMyUQpcxVQatO?=
 =?us-ascii?Q?uxsR3TjqEbaYDWsCA1UDcUgpL1AFdIuMnFTdzuqYcraXVpzJQbJwYJZVL9zg?=
 =?us-ascii?Q?MOq72Rd9DQiIlfdzAe//HSAfyRhB4QVvr/6dc0uiGXQkEaNtUSBInxQRmpey?=
 =?us-ascii?Q?UWP4ysNJDLjzlGQSY0/gia9cZz0LWq3nTYd4a0JY0k5st0ejP0EFJj0N9arH?=
 =?us-ascii?Q?fLjmpAJtV5ZAI4CpNeqJYExIi7yh29TMqpLi+1fgOHREMRR+BgBzr0AedS0t?=
 =?us-ascii?Q?zibd9bkaLm02pKg5aL3iG5LOIRe7fwCMXAjY0nQCTzrNkHG3uE/FIY5Xcg9O?=
 =?us-ascii?Q?Xrj6wif89mOZ0gPv/1ewK04MIsW7NfrIvaQV9X+25Jo5Ou6OGFvSuFCAAnQ9?=
 =?us-ascii?Q?A2l6VXNtfYmUjtAoFJUuYt8bnSa9L9JzdzzCfDxu20acvmmQ36TjWW3JEakt?=
 =?us-ascii?Q?XtOizVa51AhyvfA6Lty0AXMrJsf+QSjKRsUuNKs3Mc93AGTcvUjBhJIDo7rj?=
 =?us-ascii?Q?ow1/VwQePCfaJQXtxWsPvUwDtH0xDeXibBKF+z2EXM59PyomtBqQ0tP0zLl/?=
 =?us-ascii?Q?0UKQQt/jq4Uvk1rSSUeNqO9XheAmIdLDJ3lxtnJ+ZSrZ5HmcbtFgh7BBo7PK?=
 =?us-ascii?Q?DAEpxUdz5pasAGTiQMqE6VUsuOCKGeBM4goqnmCsPL+1/s6AOhQzNvkFr19i?=
 =?us-ascii?Q?rc4ZDvm9oe9TkHnw1v+o3tTrabAb0diCdkFzMzoEC/y6Gbu17DrUCDi9mWvT?=
 =?us-ascii?Q?zCSWuEysa2yPDXp6VjPPH3qXLVOW3vC6WS/DPgnaiepWP+YIf57nmCilfjxX?=
 =?us-ascii?Q?0qRct+YxZg+TEdvpRSzVjb7VNQtb2c2MI+EgGINelsZcajpX6z8CL1ASu0Ax?=
 =?us-ascii?Q?hqZ28GMXqkSTZaTRpmntMldiep3X0lkmYAXdNDIyxNEMJhV+9yEuSMuW/Ejx?=
 =?us-ascii?Q?aV8EZZgi0jHLN0PyR8vAqY9X7mmLqLAu9+0mOOgEanmiQoswulTnFvCRaY8p?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VRuw75u1f5IwI+VQ4nBnh9V2L42LXCFI/jnUlaZEhGia/pKvb76Z0rCJvdo7pHNvlRjU33Y8HUrLllLrcE3hJpKe2ih4bLf1x+9Q9K7lmpdN7Reg5DHkw0lQmoR4IjtKL5EQT61hJUzwd/mDjNKCz58UJDg0Q/Q5ZOiryi97ewlRgTbrvpSxTwPgxC4SpriJnU/mL5s/IO6aJHuXifVlnpZCULRlocD9xt2A/u5NX51lnDqIj07Sr3kZqgxJH/gbPaS+3H0khrIuwcIOnBSH5Yi15SnAuChpC5S5FWLERmVEhxGTpqJntr9e4Ar4OOHVjIsCPvtrJAzFMq1k4b2gxeTtXYnmx1Uyhc9hC5FnM44M6jzqMiJGTUttKa2kux/oNxwQipzb9YdLNALGav3CU2ZGH17WBkEOAF3LLuf7ObLSVWea/PCWoLfSWo81dWx6hQTlDXj94J90MIr5oksSOb0oAb+gMqMICMcCtW9YeghREqTdZoWkcWZJL9mizY8VoB9kCTLKUlEO0yvyVQTmDMECSm7L2X39hqeNQL3YHjUhg9HsxmUbY3F9QNeIbOwy79OFdg+5vO5XNSArdcyqBs37Ad+hkds4Fs7bcPXZ16o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df89cac-cc63-4021-f19f-08dde74ccb2f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:38:37.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRZgnTGhSY1dp3KeSr8DyR9AgvlWS2EjCb+cDIzkO9u2bcU0Z5/r178f05VXiEEo5MicHzGBvQ4AbDlRiqQkFfezsSEUX6tC3FILlHm1vCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290206
X-Proofpoint-ORIG-GUID: DnNSTJrLSrF9_FnQEPcMEZoRjOTz6tmN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX+ruIOBUZupPm
 wgLD8hbhxIf5gBocYpTFZgrI3lXc1CDFHAWtZb8wlfcE3L3g+Xhc8aqYi6FgGXEx2NHlu5oxfMK
 yai9YJM3mbMbOEqyMgzJ133hqZQAe2XB1T8/IVuELdo7wFOb9tkYAgarGqAIuPzNvP1wySIKwcW
 WkqIgBwsByh4xlrp2ZU24Zd4vhaFvCuy92RE0XN/0R4Xoek2G7Ae+piOJfqH+PEG+0iLjz+arWb
 FiE+PmKntTrfDnJstsYcbkrh4GJoFHCPTCdtlKvEQpXVZr89njvxqietBv9fDmoqqLzgpo3TcXz
 oWdHYN+msoueztSHEjNyiRr/TXIeuNBDG4sLF/Vl7fZmcU9CU6jHbsXXTo3M/FcIClOfy7kVbm7
 DEbUqPjs
X-Proofpoint-GUID: DnNSTJrLSrF9_FnQEPcMEZoRjOTz6tmN
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68b22bf6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=e94R3hap6TdcED3pnI4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22


Okanovic, Haris <harisokn@amazon.com> writes:

> On Fri, 2025-08-29 at 01:07 -0700, Ankur Arora wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> Hi,
>>
>> This series adds waited variants of the smp_cond_load() primitives:
>> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>>
>> Why?: as the name suggests, the new interfaces are meant for contexts
>> where you want to wait on a condition variable for a finite duration.
>> This is easy enough to do with a loop around cpu_relax(). However,
>> some architectures (ex. arm64) also allow waiting on a cacheline. So,
>> these interfaces handle a mixture of spin/wait with a smp_cond_load()
>> thrown in.
>>
>> There are two known users for these interfaces:
>>
>>  - poll_idle() [1]
>>  - resilient queued spinlocks [2]
>>
>> The interfaces are:
>>    smp_cond_load_relaxed_timewait(ptr, cond_expr, time_check_expr)
>>    smp_cond_load_acquire_spinwait(ptr, cond_expr, time_check_expr)
>>
>> The added parameter, time_check_expr, determines the bail out condition.
>>
>> Changelog:
>>   v3 [3]:
>>     - further interface simplifications (suggested by Catalin Marinas)
>>
>>   v2 [4]:
>>     - simplified the interface (suggested by Catalin Marinas)
>>        - get rid of wait_policy, and a multitude of constants
>>        - adds a slack parameter
>>       This helped remove a fair amount of duplicated code duplication and in hindsight
>>       unnecessary constants.
>>
>>   v1 [5]:
>>      - add wait_policy (coarse and fine)
>>      - derive spin-count etc at runtime instead of using arbitrary
>>        constants.
>>
>> Haris Okanovic had tested an earlier version of this series with
>> poll_idle()/haltpoll patches. [6]
>>
>> Any comments appreciated!
>>
>> Thanks!
>> Ankur
>>
>> [1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
>> [2] Uses the smp_cond_load_acquire_timewait() from v1
>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
>> [3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>> [4] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>> [5] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>> [6] https://lore.kernel.org/lkml/f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: linux-arch@vger.kernel.org
>>
>> Ankur Arora (5):
>>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>>   arm64: barrier: Add smp_cond_load_relaxed_timewait()
>>   arm64: rqspinlock: Remove private copy of
>>     smp_cond_load_acquire_timewait
>>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>>   rqspinlock: use smp_cond_load_acquire_timewait()
>>
>>  arch/arm64/include/asm/barrier.h    | 22 ++++++++
>>  arch/arm64/include/asm/rqspinlock.h | 84 +----------------------------
>>  include/asm-generic/barrier.h       | 57 ++++++++++++++++++++
>>  include/asm-generic/rqspinlock.h    |  4 ++
>>  kernel/bpf/rqspinlock.c             | 25 ++++-----
>>  5 files changed, 93 insertions(+), 99 deletions(-)
>>
>> --
>> 2.31.1
>>
>
> Tested on AWS Graviton 2, 3, and 4 (ARM64 Neoverse N1, V1, and V2) with
> your V10 haltpoll changes, atop 6.17.0-rc3 (commit 07d9df8008).
> Still seeing between 1.3x and 2.5x speedups in `perf bench sched pipe`
> and `seccomp-notify`; no change in `messaging`.

Great.

> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Tested-by: Haris Okanovic <harisokn@amazon.com>

Thank you.

--
ankur

