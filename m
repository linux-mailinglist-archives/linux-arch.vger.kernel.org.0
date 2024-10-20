Return-Path: <linux-arch+bounces-8300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FF19A550A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07827B22577
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0681193419;
	Sun, 20 Oct 2024 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qbl1skzW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b70TdbEY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473A1370;
	Sun, 20 Oct 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441267; cv=fail; b=ewa0/qYg4m7xCjXKBb7fk/q2Y4f1ZDgvm9X+82uswHmsqo1EmEcz6p12MdSbvOFxZwoIBt4dnQETZtuK8GGdYVslhTPRAcmA5KshP4OvzfZ0I9HkBPG8LoyZ65sotLrJb9dtwmLGSe6V3PVBRajHPdKWUFe3J/5Cg6HIzGXKsXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441267; c=relaxed/simple;
	bh=ACUNtPIZvF+aeRLwFmoU2XVPvNLugIa8fPicUy5I6K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtCulO5SG4m4xoyaGXMj6sIBaSUJeWFpqxyypOrKb+IqEBwXdedYE3/lPKY5sc1gTtfwOBtPYAoyW8g7mv28eCHQBpa3CWSdcM8YP6Kfexyu3uYQuJDsRhGr/1MLIBz1S8jI1PrhP5iYjMo4qfDn4mSAdYEAClyVP5Yy09S0aA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qbl1skzW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b70TdbEY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KEeO3W002389;
	Sun, 20 Oct 2024 16:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H8+OeiOA7LbXlMb4dJ93wFyuZQtE9inPfUq4/oA3sfE=; b=
	Qbl1skzWIjCs2U2rqn+M/SaB6YfE8SV0vY7REqEyWh5EhLXmAFr84Wxjo8hZPbVp
	ND7kDFe6Qk8OTWZ8p4hQSR/X0zOUga7Zm6SAj6N+kc3pcR/Vtp74bh3nrk+FxTJy
	+PvO6l6wg/FbUEdhx5DMpNVnbhbdNDAFCdFcf0YWyk7G7izNw/Ryw+NS0XaNymvw
	yhIp4/OY4u23e5/mHaC5d0sddjGo5dW+WQdZrecjr0uXE7KUNdX8DXmcFyzsWCcq
	RqnvL6rc8B3OyGuM/IG+tMzLaJNmMmB8mQjn6MHM2pfzjBTE6AhxBHEsbHUdA4vQ
	McXU6iq8guBxRd0PGlwGWw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ustxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KE3Tpg035552;
	Sun, 20 Oct 2024 16:20:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3768fqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXdfuzYabm0mIq96brROStUIdEHen6BpysgsPBPdjCtE1SvL/3RMm0AKjmHKCMdfpbID9eqa9gNzP5oguXKLKNMTG9UEdFI2ztS2Ku+aHhOlNIPFiyOTzPn37jB8IM96H//rBdtG6jAz3V7Uv5+MivGvUHZTZI36Cz9xp2DgWCv7WgZB13GCWX4q+5zXmiu0xhiWWsUtBBDrB5xZpR/UwLwYwC0555RsRuaHIbTSmOnMx7G1TyjdpgN+A4RWSKW9vHFw9FiUkbMyQnCwb3XtVXg0Zf1CwXHobp7RKMszFnFM9K9IYNWc+DHqV9fzTgQjVmVSLH5UtNcXo6bv+rEr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8+OeiOA7LbXlMb4dJ93wFyuZQtE9inPfUq4/oA3sfE=;
 b=judN2HQzkswrA92dXhajFIyIBcnV/M1A/p90YMyTqYUTkPzingyxJ4VtLVfP2KTLBZOjQj5Zl3nbH7qQ7WTPO97nXVYiSrPMKrU0v3TpwkK0ic7/bxyQNSCV8dEvFa3qJ9Pdzl65ENdP2hWFvzWSfpFwYW+tCoM8LMKlOVL2N9fqJWp48k++fH7767tEHelIehc4VeiA1S49bvrB8vRJLOk8hrgaTpjKR6yWiG0VFbaW6L2L/qBtRIYgBwKoTFUYmTmofrWDJ0tcTqKiA8y+VnQT/93qzcmJFbkOqAQT7+Tj+od/kKv1XHMqlIaB07k2t0+V1zNtVPRIPW1Vnn9u4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8+OeiOA7LbXlMb4dJ93wFyuZQtE9inPfUq4/oA3sfE=;
 b=b70TdbEYV7/Ifu9lQM3+dKj+egjgTeQ+nz4hgM4fSwEHGWZYtQaCwIbVI9B06fxwjsKYJnwrdzlROTFPsff3Z16vmuS1R8FUo+gb7yZ9Yu0ft3wLLdEXRi8OGGhtKuEhAVRstofPbXmi7uLAfEzB7DkxwtUrGkCmTGOOrtFHgDo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Date: Sun, 20 Oct 2024 17:20:02 +0100
Message-ID: <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0050.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 452254f3-efb4-48c4-b0da-08dcf12317a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Is5Az2c4onPppbZN1/q6i4LLoPwhGu59ogzE7DZGh6CwzMvFUxR5A03skOik?=
 =?us-ascii?Q?/ss35mKvtCJAVARxaZrdSczfJhPi38XcrnAuULvFOpnNubT6QkDItjLeUW71?=
 =?us-ascii?Q?6Lui4lh3rLeEw3Be+32GS1BLTnXLsqIRvM1cL5X+hU+8nSZSb+wbpHq8Wwap?=
 =?us-ascii?Q?2P8LvCPOMSOQzsLM4cDq2FEWQweS8IcExbfNYCVW8VbqmP5F7M7CM6cXsq0l?=
 =?us-ascii?Q?EqIOF7YxAKWcLOFLG398ZkEq3s07w4//QkZnCNBtWgctRPSpi3WwVfh6FGem?=
 =?us-ascii?Q?yeRlMV/s1pMECfs61toHPqL9ZS5llRNlf7XuK6mvsyD0MCdmwmcz4/O9Im1b?=
 =?us-ascii?Q?WeFE6V+Fq/V/90q2GStw7qzr8YHPWGm/MHUfIGPQnFgJn3v6jyfBptiM3nae?=
 =?us-ascii?Q?XDDqe+YgsYXwQHoAQ+cZp0jfcOuy59KLC4oFgQa1rlOOIsBI4OsL6w9VICWz?=
 =?us-ascii?Q?vtcwWZr9hTEpYGn9lo0amWgOonAeK/9USS+rcfQmMJmG4jPwTKCKtRTJUnAN?=
 =?us-ascii?Q?KJ7/Z9JLKSGOz4rhgBmHYVrRCCxtpnMG7XBx1yi+R/QuT6FSRGd3x/LNTeV6?=
 =?us-ascii?Q?thPKuZebUd2ImaAJqjr/yhxTyM0aXp0eHERIYvNLHS1UorL23iqjRykJOIBy?=
 =?us-ascii?Q?ETiJpsXmbkqz2aRsbfdxFPKfITvCJJtScbH4iIKc3MsMOLVPrL8/Gny4tsSc?=
 =?us-ascii?Q?kLyqftYkHXr/oDIL6pUmPOs3h/gkeRX31rZFtWn+vDdpzgMoA4c2gf/Vu8Xp?=
 =?us-ascii?Q?hP9OOOnGn6FpPwc0Svcfr6dLlVb63PbqIxp7CMwuXu1ZfxVW4noTk+f5x53z?=
 =?us-ascii?Q?w3sjcUMn9OAUrYjdoGIuCE39FKxgYfAml6qA6/6xBfyY9jKfS4qDUZ7KR+kR?=
 =?us-ascii?Q?eUZUlTRaS6D/+9zfmlfeVH7qeFKdWpwRBjaYLxGkdu+nuR/a195FAlXH3xTk?=
 =?us-ascii?Q?Yc3PAPsQ+Wf6AtqRutYx82aiBjeL8+kyV4dtNiOJgKDu59ueN+3FVwagF7+j?=
 =?us-ascii?Q?18OAVWrFKU4iWB517RusJB4JoPcxAwfyrxM7B2kvz+KRC4EDutUDh7Edzndc?=
 =?us-ascii?Q?tcwvIRoNRxFoZkdd0zojQ1orXMBnPSVN+Z5atKlf5TW0ulhONQa/qxUQAzSQ?=
 =?us-ascii?Q?kU4BJq77en7Hit12m3o9kQUIiVZ7ZxEGRPJeWwx15NUyuOaBHGqUOPbEYcUA?=
 =?us-ascii?Q?rQ46aZmFOhjRimCQ0m05jvzKKFWD0t9bMejjdOGc/NpL1+B2TtmMuy6+zRuT?=
 =?us-ascii?Q?sJ7XXCUQKqSCuddV4Q/Um7yCE7QTx/o5e+epeRkyFj7qUkRJ5BxX0Meuvujs?=
 =?us-ascii?Q?alc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+siz7bM8do+NgkQnswhKBhf5ZsGCrBEJnBHJ08K/NqgT7ZJroZ6s6jAcMJR?=
 =?us-ascii?Q?W38UoLib94vYgHkteY5VOUFpFN3HQvag34yENUFzqF7WOQkUT4icF78LP4uV?=
 =?us-ascii?Q?1kmGURT9blUq6CKZmuu0kCRI2EmWFjaoRIndAd7o+9zNtifx7H+ht0wELV7n?=
 =?us-ascii?Q?OAbbIu5w6kyHPx3Iw/xX3namDiMzKS2eCinP/Lu4q3p1dvnyE2OVOus7esYu?=
 =?us-ascii?Q?kPjQPEqSC9dXg3+NIJRmZmLJj9jGF2L2LnXJHI49gJGvS3xU065eXkLSs8Fc?=
 =?us-ascii?Q?DTERrY0z/d/X8aPqTLHY/u9XLBDJKpybGsWKLRa+s7zYa7iptN84L87K0Vp3?=
 =?us-ascii?Q?+UK03P58A/j3EhHS+Cy1Klplvzkervu76zOLXXqVDb6rcc5YDU249y9+LuoL?=
 =?us-ascii?Q?mpxnS31G2NARQ/xrdAxZJ/hEV7rZKBmh7yyuxhrkx9ArpMIU5Y3Wk0r2tQkx?=
 =?us-ascii?Q?w4wZXrWRXhtWxIRZ4f49rI4ZZOLLKNV1X5MBpu2KujwW5iz5aL7idPSq7cdu?=
 =?us-ascii?Q?pWXUawQyGowxxU72Ls02fTvbdisKCg3taU0gozPeJVs0aVSTySwrLC3Prqkc?=
 =?us-ascii?Q?NoHcqPrN5SHH5jW1nvvA5oyYWvr5ar0OTyeyNUoGb13YWfbbkvaOKRTN3tWN?=
 =?us-ascii?Q?Z6jli7iWgLNOZl8QOxXpV0PAMTPdryy/XAaK95sHTZJ3Ry/vL7dsVpvNcw6Q?=
 =?us-ascii?Q?l4shkooAMUqLvWRs9d7eL+8YYvzSbcyVRslFcSS13KJxZm/uJ7O7f0MTuK6i?=
 =?us-ascii?Q?aA7bPxeSqom9yS6ut6c6j2aroimjlGqmcONIzQbwJLX4jEAkwXWRQmnxv2y/?=
 =?us-ascii?Q?TO4uG9N5qgR2zOzIZyVqMtuPpJWBqAZ4h+o1sqwTcWPMrqLRZpwWCMm5JTMR?=
 =?us-ascii?Q?4DESQqovt5HJoUPFc3cKI0ewIT72YNfP4gPQjvu+iAk7prbG5qAwTQDuGUoh?=
 =?us-ascii?Q?7Gn8QpBoUlkEBidItWRvhusfqaXE+Lh82ZEdESIDwEKvqm9Tr6v49J4l4P1m?=
 =?us-ascii?Q?hUNegY0d8vLWxvsrLBZR4NI078Nv2HMc9eayzSYbOl0rmRNTihZG41HHPEHL?=
 =?us-ascii?Q?3ExLqCEmuYGtmqwjdZfEeDbSK3xQG5+InXIvvH6d23P+N69EJec2k8fB4pAK?=
 =?us-ascii?Q?rHZT9szwjnvoH+Jux7RaCwDjOveWiYK+otjfcDnepzA+TApqJjRqmFbmqpkY?=
 =?us-ascii?Q?i+YmHIVY/gcVSaqsEg9ycqrigoft5vzvN+p6wRN9k7jMdzWxzF6kFNf8oexE?=
 =?us-ascii?Q?3+vSrAefl5AyU27oLlAxEDnQtzWrXPBWhbSsGUTKHJ8zu/2y3iE5K9gFEk7g?=
 =?us-ascii?Q?FEWR88QNNZlrZZRfvJitTyEsmIjFdcJzov3kyPZ00Ra3aF1qU55W+rwdVF6s?=
 =?us-ascii?Q?Pk6cFonogZ561NaOTGN+u3fGTMCXkmqnt7wqX4gkvk/Pr68NW92mf5DBNI8M?=
 =?us-ascii?Q?BLfLcxPJp/dg4CTSqjTTZv43IxWr3gkmYs0k5czEUMlwYk4XoVA2uI6tluNW?=
 =?us-ascii?Q?XXC0mLUU6qU2Kk+0kUjhlb8DsfMcZDC9AFxwAB7GZWszbiwWSbbdnBUKPybQ?=
 =?us-ascii?Q?tTm/0T/1ue/7j2Iy9LskVrXsef729AQEJZP2arJJhJ29Q/bXMEDFZJHqW4cs?=
 =?us-ascii?Q?VFfgyKFcD7eH1iNCDSRaVN4Zl3AWnaqU3g4v/4Xijydq9UOjElhY3sSPHhoU?=
 =?us-ascii?Q?UhFsRQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Bh9f2BmSEj9093E8wwVtwhrDCf+rsLoazHCJhiQpLn2KJ4YGIvv0ZV70PUH2hTMJyeFc7mBHQoTfTO3DDqdmv0pZV/qiwqAnw1Iqqwwc0LyN/7C3f7d87bjng/o7n5WxoAg/PZqEdCCu5XzwJOj5sN2RKQcnV8Be+WyFusuAlVMYrco/d4YiY/QEr5+MP7gs0zbh80FuC6El/3BmnFtAuL4wIs8xa1ZBOAW4tMYJVdW0yUKTWGO6mz5Rk2bY4zqgDNkdxwfpy6GSj4iv+3gu4vKTEdrFNUlhwt48nEHU8Rd+wwc97GmDE0DoA0w6wLi+DDhpKzcVKOoXaE9XAhWm41IjCWmtsPyYYNZkzF27ZbdhtIvdDI+ueh8H7beO47gKFXauLRSsf5LI70520DH8UKil63rrNix3tFuhMWOK3yBJAtsl5xE6sy5chjp2HV9zwowO+PpkKIAhDGZthCYAfrKDe+q8BvPeQSNYLVLDY2Ta6dBxvr2AcS3ckGpQGbGJMOnvm2DWePzpicbDHd8a+IMWhb8YKjAQo2e1zJ6VW5ARUOgu5wYyzTdn0s3RwD2hmQ5eyK3jl8QNZukp8Wgx8cPDmEiiBwfJ39JCZlCVdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452254f3-efb4-48c4-b0da-08dcf12317a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:20.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db7Hjelck6q8W+dPWCIEi0SvAayclm1APxneG4okPM6fGM8s1ru75q7Y4NwFHhCTO/9cXG9ijfgK/vyiWyC6d2ZgIlH1ncC1jpZ/sFXaCpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410200114
X-Proofpoint-GUID: iX_W0srb_wC0cISVUGMtD1It4TYlLpxT
X-Proofpoint-ORIG-GUID: iX_W0srb_wC0cISVUGMtD1It4TYlLpxT

Add a new PTE marker that results in any access causing the accessing
process to segfault.

This is preferable to PTE_MARKER_POISONED, which results in the same
handling as hardware poisoned memory, and is thus undesirable for cases
where we simply wish to 'soft' poison a range.

This is in preparation for implementing the ability to specify guard pages
at the page table level, i.e. ranges that, when accessed, should cause
process termination.

Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
purpose was simply incorrect.

We then reuse the same logic to determine whether a zap should clear a
guard entry - this should only be performed on teardown and never on
MADV_DONTNEED or the like.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_inline.h |  2 +-
 include/linux/swapops.h   | 26 ++++++++++++++++++++++++--
 mm/hugetlb.c              |  3 +++
 mm/memory.c               | 18 +++++++++++++++---
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 355cf46a01a6..1b6a917fffa4 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
 {
 	pte_marker srcm = pte_marker_get(entry);
 	/* Always copy error entries. */
-	pte_marker dstm = srcm & PTE_MARKER_POISONED;
+	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
 
 	/* Only copy PTE markers if UFFD register matches. */
 	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index cb468e418ea1..4d0606df0791 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -426,9 +426,15 @@ typedef unsigned long pte_marker;
  * "Poisoned" here is meant in the very general sense of "future accesses are
  * invalid", instead of referring very specifically to hardware memory errors.
  * This marker is meant to represent any of various different causes of this.
+ *
+ * Note that, when encountered by the faulting logic, PTEs with this marker will
+ * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
+ * logic.
  */
 #define  PTE_MARKER_POISONED			BIT(1)
-#define  PTE_MARKER_MASK			(BIT(2) - 1)
+/* Indicates that, on fault, this PTE will case a SIGSEGV signal to be sent. */
+#define  PTE_MARKER_GUARD			BIT(2)
+#define  PTE_MARKER_MASK			(BIT(3) - 1)
 
 static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
 {
@@ -461,9 +467,25 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
 }
 
 static inline int is_poisoned_swp_entry(swp_entry_t entry)
+{
+	/*
+	 * We treat guard pages as poisoned too as these have the same semantics
+	 * as poisoned ranges, only with different fault handling.
+	 */
+	return is_pte_marker_entry(entry) &&
+		(pte_marker_get(entry) &
+		 (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
+}
+
+static inline swp_entry_t make_guard_swp_entry(void)
+{
+	return make_pte_marker_entry(PTE_MARKER_GUARD);
+}
+
+static inline int is_guard_swp_entry(swp_entry_t entry)
 {
 	return is_pte_marker_entry(entry) &&
-	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
+		(pte_marker_get(entry) & PTE_MARKER_GUARD);
 }
 
 /*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 906294ac85dc..50e3f6ed73ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 				ret = VM_FAULT_HWPOISON_LARGE |
 				      VM_FAULT_SET_HINDEX(hstate_index(h));
 				goto out_mutex;
+			} else if (marker & PTE_MARKER_GUARD) {
+				ret = VM_FAULT_SIGSEGV;
+				goto out_mutex;
 			}
 		}
 
diff --git a/mm/memory.c b/mm/memory.c
index 0f614523b9f4..551455cd453f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
 	return !folio_test_anon(folio);
 }
 
-static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
+static inline bool zap_drop_markers(struct zap_details *details)
 {
 	if (!details)
 		return false;
@@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	if (vma_is_anonymous(vma))
 		return;
 
-	if (zap_drop_file_uffd_wp(details))
+	if (zap_drop_markers(details))
 		return;
 
 	for (;;) {
@@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			 * drop the marker if explicitly requested.
 			 */
 			if (!vma_is_anonymous(vma) &&
-			    !zap_drop_file_uffd_wp(details))
+			    !zap_drop_markers(details))
+				continue;
+		} else if (is_guard_swp_entry(entry)) {
+			/*
+			 * Ordinary zapping should not remove guard PTE
+			 * markers. Only do so if we should remove PTE markers
+			 * in general.
+			 */
+			if (!zap_drop_markers(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_poisoned_swp_entry(entry)) {
@@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (marker & PTE_MARKER_POISONED)
 		return VM_FAULT_HWPOISON;
 
+	/* Hitting a guard page is always a fatal condition. */
+	if (marker & PTE_MARKER_GUARD)
+		return VM_FAULT_SIGSEGV;
+
 	if (pte_marker_entry_uffd_wp(entry))
 		return pte_marker_handle_uffd_wp(vmf);
 
-- 
2.47.0


