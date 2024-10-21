Return-Path: <linux-arch+bounces-8388-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6126F9A9073
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7867B1C22B8E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD71CF2B7;
	Mon, 21 Oct 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gjPeFI58";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z1McRkmw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CE1C7B68;
	Mon, 21 Oct 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540708; cv=fail; b=TWwsoNX8EFs6ZcfQ7GbFJ1pJOs1kqG7i7r1kW91t8i2uHiPlN2ah74z2hz+xGWSYPFPw8UR+QH9qPj0buJHGj3ARpolsTRQMok4S8vumPWV3GgJh/T/g/j+5BxkkGjbb66/Md6dZqAzA4mEETOoIbipnSdaye19fhquT9wMazFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540708; c=relaxed/simple;
	bh=KC0s1hvWlJVs2WX7Z0HgrB4zO2q0kGJaIft2eN2uZ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/93gka46IDE68jxXQucvWh9tkjBpTmLvVOYiMXElGIFPrNFYp404AzbKcmNUb05Y0N88SxU5zcqOI5rtAHpyTXro7fWUgp7jswVQZrHVP4H4BB2Yt8hHLJfvfHd4/UbkEQP8oQGeFF/kcXi1iGtKIFkcLXv4PSFiUVwedMJRVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gjPeFI58; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z1McRkmw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBdRt023217;
	Mon, 21 Oct 2024 19:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=lqARbpyBzMpSf/MT6l
	Up2rT1G3E/h3ZvfzkI4pw79Lg=; b=gjPeFI58TRKyteC7snpu1MfBhpzoq4WK/i
	a0FOy2Z0lkly61J9bR0M2hU2RIKzVv+1jdSiIib9nikS403ItoISSRunMweRruoN
	jFtgofNzk9k37uHal0oN1iReifAB3d7zr9YtXKO10RAMGCX60fj+3RHA5prcUcOk
	w5G7sxTwPOerncQVJuEs0fC3uqYuc32xY+SbhZaHQxcqIZAgPWua2uTyBtnylmfe
	NzrayfyPffFZCaJkAioI2hoelYOdnMDnyVH7t60DQahu69agMYA1wbdNCPVFOVwH
	0ymjijfTCYRdysXLRKplvV31NivYl4gn5pOX+R7i94Na8Mfcbnig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55ec06m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:57:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LIJg4h011943;
	Mon, 21 Oct 2024 19:57:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c376jhxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:57:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dck4CDRhipV6A9nJCa2BGRwDZGDbHJdxmlX/KuES5i/Y1FAdwRM52j0Hmp3ObeQYXgeNRHeDfxdpsEdMoUInTbIQOHkkzGyAaXg59x/z1mgVuAUIEfHMnA1pU2OFRjr+pWceEl0dclgbm7ohc67hpW/8tG9pLQBGpvZgAa45qcB4es9YC3CB5OCGIoEOQLRhtrlkfGFr8JW/qx8je6kFvPpSzEVnccrZAifuEALfjvvGBRv6tA7eghgCdXOyDtLaCgMLszZHiC5i92gEJN+pegMbiDC8x4xXuUVNct0WF2UIVhztdDf6/gSHh/ykkj2GofaDfzMySY6KBz6eFuDJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqARbpyBzMpSf/MT6lUp2rT1G3E/h3ZvfzkI4pw79Lg=;
 b=G+yzTEIQ+PQEu3DPA/cduh+RhTS1UHdf19fL5wSiRGu//lconCq3Wf9vB3PgQnT7ZPdI8wDzmIYbGmIy+9b6o7awykHojv0w9mfV4S7XTUa7ISLnf1a3oJfXjpRUeFVVDSBxiW/8/rIOUIYoW+1nU9AcGIwUBifopnVCMdbdev8J8s0csIj7hcRgv7rS8r0cPMbtpX2mSImjYzhkN4poxOzcVqghNX+kI3+eJcumRyMMRSvnhtLbU2CPcHz4TP5fO6qzBx2UalDEHBCdTSLEhyNusmB7P9GYDVRVkFYxKiu+8ZlYQTwY/QPQFer23WccsBnFiZilCLOb2GV7IokBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqARbpyBzMpSf/MT6lUp2rT1G3E/h3ZvfzkI4pw79Lg=;
 b=z1McRkmwpoqQKDt7usV9k0OdT9zXemT39fXeLlDTg4FoQh6Ovko9PS+5x585u8/0VSvQzVjwadntUNomECfzNsnIflzoUOa/87pIV0HNUBVB22p9ER5a3L27+GrSkap7ToV9fFbmAtgYPMbbfedeXZ3t5U0Vp/KZ+IOH26zXneM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:57:38 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:57:38 +0000
Date: Mon, 21 Oct 2024 20:57:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <0dd102ef-ada5-4c26-8836-bf91957ea907@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <9c0991db-9bf8-414c-b3b0-446023df2a7a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0991db-9bf8-414c-b3b0-446023df2a7a@suse.cz>
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: a6fc6c78-bdb5-4b5c-85b4-08dcf20a9d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BImgPss9Es1+PMvZ4xAx7FYt9Qst1181Eoukroe1vcmUSAAkXxcPQ+3+xZk2?=
 =?us-ascii?Q?g1NagUi+r9wTZow85l/awCSLWxBfJveBV88zCokuLJhwVoUKxl6JrUS3KL+C?=
 =?us-ascii?Q?2xWdnqvgIxT9GSDaa2udyvNxcBUZaUQvo6B48OeKONT25VQY2PaJRv62p7xT?=
 =?us-ascii?Q?NNMNU7E/OPu4GWMktc1q7Rho5esGRkrHYCKaGE2TwEXBnEPwvZYCF5VBjcdH?=
 =?us-ascii?Q?TkNACTzhrgho0lVY4GHxKiyl4gXIB//eT1vSBmZGr9jIa/I8maGnKO7MsuNB?=
 =?us-ascii?Q?VbDnhZLANH19CGEoEgUPsoUHrp9LozVN4Fq0B4Do1IyjbxQk9m0Wv3uKiQgU?=
 =?us-ascii?Q?OLTf5YFujjCLbLVoG+knCmcP/r48gjAR47mpnTALPF7rXYKs9msR5mQ6fL8K?=
 =?us-ascii?Q?az+oTRzqgOEaPiv0HRq7Mjqf8pPtkbx8ZMG0VKwTeAz5l4moPMO+QkXUoM+m?=
 =?us-ascii?Q?ZbRhTQ9PgFyfGQ5FWK8CcjHhGlgUAJVspGRG37KLMz+/DoYyX2uItptPLC1n?=
 =?us-ascii?Q?Ciy9erWxQjw9ZXXS2fiHjfRlVmqKtmKwSB3AnQLjqwmfg64KnhnxZECkTJBE?=
 =?us-ascii?Q?3yuvjFtSX5Q9LWqFSxId4XNauGgq02VD57mEy6VMeDzsXOkWWKU/ANR7t12e?=
 =?us-ascii?Q?3tiMcG202zY3c+d/uNpavAVE8wkfMaj/iC3K654rr8OuIRHUaSlzTX80URhg?=
 =?us-ascii?Q?zKEbryoNJfrFKE4NBloXNsq05MoXvaDXxUL/AYrbAIcO2ZbjDfcXRY3lqNoV?=
 =?us-ascii?Q?NH84V/abOrPPAhxCqOi4cwEFIjqyg/ffcxLXqamZf5a5kYqMUSumtGielDK9?=
 =?us-ascii?Q?n+OFNHDL6cehYuK0bBVb2P/lEIRvYnPZs48171FT+BhEcQNpRjLHSrPV+fXe?=
 =?us-ascii?Q?Rl3FU/thr09Z4ZSS9LUVOqqDlpksazRvv5ODVtpv5NdQnWB7Ve0XW14X1qpl?=
 =?us-ascii?Q?2VtbMDbaCMDz3mnbCdSmGWjMTPh5C+V3vXOs8ofLyofdZJ/a0FB+o0QSftXK?=
 =?us-ascii?Q?1C3b5xeo1KyK4NNTWcPt+bzUfnKqo6Q1dUC9OVqLxwWooqIvuMVt69/U+DIn?=
 =?us-ascii?Q?Djx6Loj9P3IdZgnx6HE21uz8O5q2Bb98tNdEMbeQ390tg86q1XwbxrGsSwjH?=
 =?us-ascii?Q?V/qMz7I0b1CYwhxxNtIrtCAIIYaPpnf4LPwnrtNpYF4qQMm/u4FoZHIMrENP?=
 =?us-ascii?Q?SHkWkcZLod2tdzc1qQplgsh6nW6nUJjREp9wbNhjkjix5ChkEU7WjWrg6z11?=
 =?us-ascii?Q?OZ6SYfg1M2cGrxob06i2JwSk1uv49S0pK1zRDysBxNHg3L1U/GNjZNZ75JEg?=
 =?us-ascii?Q?084sLR6fb3vbWU5cgXaWLbPR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4ClB55ynx3TyE83cwy1x2WjRmY/0/bLeiEZPhOaGyCq5jF0NXb5zLxiPwjM?=
 =?us-ascii?Q?/+pC6pXSHUa+h99vYh6krNS1kaqWfRreTugWA05cXtaWMi5RXiP5QVSSoWRg?=
 =?us-ascii?Q?0tY8/UO3MVjtYO7jQkCifurJB9cL4iqngMNMp0dxp+axh5pLZ9WiyPEuFXuJ?=
 =?us-ascii?Q?Zby93dZFByrNtmfX5hUPJeavLPWTT96y9a01ltGeGOtL4eH3o8SzqajYTUZs?=
 =?us-ascii?Q?I62Ky14ldGyGd+CMhmjzXmeV3SSqaU+WovuwwkG6664O0AvWNuJAvbHd8oxL?=
 =?us-ascii?Q?pyTBRX/Vjjp+vfDtFDJPT80KyJ5NSz3oL/pw5GV5tjey1XdMmn38HMc5jEQR?=
 =?us-ascii?Q?NQbh8knONpDF2crHyAfv+BkOMmo0fRJgzGNvZAat7j03u51yFUfPiwr+Xmjp?=
 =?us-ascii?Q?2o54wW3yiU+yTUOY++f2GZEXQnS16Jw5KFfUHMc7+HdbdjZB+xwJ2E4zgrVv?=
 =?us-ascii?Q?g0GKbqkYTDZkUJwWemgUwbPfMVy5e7cv7rgUsVqX9pWHWKey35evPuKfaRBS?=
 =?us-ascii?Q?D1ShjwfMDsQB6SImPn8Cjn/oXe54ZcspPHmVKc8VmZyCPjKhpVxKAJAhdeAD?=
 =?us-ascii?Q?MoYfez3FzKWKH5Q+1jXCPHEn6AH1FIHxhCxBWk4uW1VWAu8LTMhzzDpQMbWJ?=
 =?us-ascii?Q?XgMWAHSvgKu5nquJQ1hDVHNcUEN4wqpdNIHFxD14n9jzOPhqtq3TAItal6v3?=
 =?us-ascii?Q?swclAHrJOL2337frzVw+0FJtpp/r+IskDQLYXwr3wzZ5MorhCr664/UZ9Vt5?=
 =?us-ascii?Q?LrXdY64q5pe47omONFhmO2nGQEr/St/jHsZmUulqBA/8OtYtgNyplKaB7qq6?=
 =?us-ascii?Q?AtlPS89pNkP6b+F29QgqFwVHoWKOxpPFJOgxOgd9vrn1zScYzuqPy5iOgzCG?=
 =?us-ascii?Q?5B8JUGlGfeD7J4Cg4/MHvtATvdS/TC38BVOAnovRVBN8VQpNzMI9PR/V02Q8?=
 =?us-ascii?Q?HkEZ0SBCp5Kb8xs7xRUPRPQUZkEt1s0Oph4VunQHVaVbxQQ0fWMc7H4RL3sg?=
 =?us-ascii?Q?5ja7NZxhH7r2/oBoPUivlhfnVZcBND2Yp6+NqABa7qqxIFa6xPyjX7N1L0gj?=
 =?us-ascii?Q?5yz3s4UzaC0rMadichLe0A/hq6sYZWULB/14y5ywJbewy4f4PlBUvmfuJOta?=
 =?us-ascii?Q?Ty5vEx9cwjVGaVFiMdA5Pod89hWyOatV5In8RZcDPcA9JUGJVcJSjs6XBcBS?=
 =?us-ascii?Q?0XCXBkIIsNtux51Xqa3XWKuQuJBrPiYb4kuvB/aEtvEoUhERGEAPRGp/rKp6?=
 =?us-ascii?Q?rsGsONimJeYMEMRwd1P8/Y0Q6Ay/++/ayxcIgWMmDW1oK/+iYAiJ8zVVotHG?=
 =?us-ascii?Q?cNRdCwhy3sK0qzh/KZYD5uqP/11CoOJqejNuDVQpWX2Z7CE1RftCztfEAcnj?=
 =?us-ascii?Q?GLlrGNvnAkal2IZ4Frq3N92PwcxPLboPW0tJOIdi8JnsmTwbKAgkFrXSjrXU?=
 =?us-ascii?Q?uH7kk2t3t12wQ9mwEuBk0TGZmwbuR5TuTqchljXuEf4Y4yagrp61n+Ov4CGu?=
 =?us-ascii?Q?bGthGsjUir0Htr+5kY5tWPohiqJ94rtAQucbQdP9R89PtcUMMfmyFSJ2H0Tc?=
 =?us-ascii?Q?LqQSvNwIbVxSSsAiRyIpIh9/LDj9ONu0L4Hjtrzehh9l/I3zze/3MKRHn4AE?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0jofkiuG7VE1sHhVjxlOnv+0J2VUK/Dwx9HTSgxVdRrfZEhboS0ElyySlNWbvMGFYtqwYgSc6VAt+i7U+sZwTr/FCBVke//LEs7MI7ZHkdEod1dcgRAII8HRiEZUde/WA1BwVYqnugW0wqLhYHk7DlLBZz8D0hbS1CclzFbBvgznB4DvL0D40icOr9GzTQ13s3xt7cENjt+tEgeC2NH1Fo9XEUP1hB0w8lKxjyjLpEgawFqhbB4QtYgAeS1dTv+ExXUabKLrzOQNbkSDPN7UnBzWwV+/9yMf0JdF0T44oj/Anj4g9q/Lk9oy3o5uW1uuc1oWHqn4RhQj+hjfmCaBhuAMboV/GM4tUyq+K+Dzai4QA4RDiGQXocaM/EqDs8uQVZ8kaYrWIMjWQHy0zpGVTQD3qCZwfElJR0OITZo/Lc1+pUSVuKEAKzd7wGekfKlUNNakFGi67MWwd8p0Ouh4u5Un3BhPzIc8HhSf/K31qR4GJAxb8Doza69TPAIZLD2yjTsHLVVSnsrfFdvSgdtd/RGkIT/CFvR6d8U6/YVDhsP2yeqYrA4T/GJxfy+J1aFRGvxBR9AmjdgVK7vPL71guloklFKLWLiDPEDv4yKJuWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6fc6c78-bdb5-4b5c-85b4-08dcf20a9d0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:57:38.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqMXOC3wut9nppnWpHe2Ky2Rm1cjTuOF2c5+W2A6lI+dTXQqdo3QRimyyaSja9igcMXn3t/8VRalSxLgZyDYIIfhZVwyOAKfAMvOVOzgPdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_18,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=785
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210143
X-Proofpoint-ORIG-GUID: H-TW87B6ovBrnfGGd7x_A_qE33Te5bC5
X-Proofpoint-GUID: H-TW87B6ovBrnfGGd7x_A_qE33Te5bC5

On Mon, Oct 21, 2024 at 03:45:31PM +0200, Vlastimil Babka wrote:
[snip]
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> A nit below:
>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 906294ac85dc..50e3f6ed73ac 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  				ret = VM_FAULT_HWPOISON_LARGE |
> >  				      VM_FAULT_SET_HINDEX(hstate_index(h));
> >  				goto out_mutex;
> > +			} else if (marker & PTE_MARKER_GUARD) {
> > +				ret = VM_FAULT_SIGSEGV;
> > +				goto out_mutex;
>
> Given we don't support hugetlb, should we WARN_ON_ONCE() if such unexpected
> marker appears there?

Yes agreed, will add.

[snip]

