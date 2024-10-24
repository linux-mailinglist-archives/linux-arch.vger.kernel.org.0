Return-Path: <linux-arch+bounces-8514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C75B9ADD8D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 09:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3B8B227DD
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16216DED2;
	Thu, 24 Oct 2024 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSFBx0e+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jnYSn5Mn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139018B485;
	Thu, 24 Oct 2024 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754807; cv=fail; b=YlOt6uXtmfx9MQIymNC8sLqEdqQ2r4fqYljCoM76cuuxKKtsYqef8FSS25myWat2LV5X8I8+TnPELT1uam3X3gTELDqn/6731S6PUsI29Pg+SixXi8EzBtIqFneBIt6kRkWZiEfndHT9LC0//ZfUP39LtK8h1KUVy4AMxrduV/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754807; c=relaxed/simple;
	bh=VRW/nFfK3w4WzY2yLXb/PJp0kD7MUtVKdoDwJqzOWCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBhv0ym+gI5iDSntKP3WQU1+u7E8JwUgsPk0RFNM8+gDyfPpFAXuNOMcALF4Md2cQrCdkkDMRXnv82eGMWymOCbzs7Ej1erK3q2bjNmZu8jqDVRUrzNOHxE5NXuTjDXBUIc88x6v4jhJBpFf2CO+25KgdIzXkR0R59HbKnNSvUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSFBx0e+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jnYSn5Mn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2fqTK008684;
	Thu, 24 Oct 2024 07:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VRW/nFfK3w4WzY2yLX
	b/PJp0kD7MUtVKdoDwJqzOWCQ=; b=eSFBx0e+eq1OWqRBddQoxBMfDmeZWl/+6C
	B3T6F4fu80xw2GlCrvnvxsruBpLUwVPZ21RT39F2dgnPPIaHxXG4dqw+5i/CCOaF
	XlSjAjGb7T3NL3il5kwWDbxDBV+BN4zSfCDtErSY1n94StLJxec6TgPMhZDcQn5P
	bJ+2C2W2T/CD8tP7YA988hNhkxERT3WAdITeUGdjNd/K+G7gaUa5noQOz+wzGmxf
	0dYs8wV8YXr391KfrOa1d9f0avAAQxko0qBF3tDvsplHzyjbdFNGJvnbfzQQ0IQe
	NRFj0WfG7vPYdncJskmdLhzNhcHk/MundO7TXyjg5+nUL3XDzfTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v1ut9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 07:25:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49O71ZXF018830;
	Thu, 24 Oct 2024 07:25:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhkjn0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 07:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if/86WDjGmQxMUX1mHIn8TukqXlDj0TWBVPZ9PDxV6RjMnAfajtNKJTHYpKSV082uCcJiSeLiRmXdA8C+j5ByIivmisuXgJS8NJ/+eeMxG3F1KIL3c9inf8E4XbM/ZieNPJYTuPTqpQ94nIQ43jLuX0ZtCVU163XpbctQxQqaRKWQO+1vSiyCIZlYsUNBXPq1/BMUfjn3MP1vmlmURzu/rZLQ27VreTlWjnp/j+LMuUEAw1f+Dn4/pJVoUwkoQzqktW8VXPMjOLxqQ0d0xAxiKNCGKxfGfzbNIvLdjsxcwhOmlXBXnbhplnLLsWbHvXjqhxfzXcPDrYk+WGhODl2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRW/nFfK3w4WzY2yLXb/PJp0kD7MUtVKdoDwJqzOWCQ=;
 b=EoJXXDryQXQpsKRVLGo8PROKJ64VmLQAfgBfkUjWQ0s0rRoQovS6JQtx+9646YTgJ1uRHiWsPrbpa7TIybDpjdI932+cGSi5po7qf4A6JiqzXle0viM4NeqZjDbNFTTy2dmZG2JIfV8dfh4UwCbxy8ghgPTOAGtKqkqLO3dhAMfREus1EhsJd03H80Cj1qhD5h3VcRDumKdSTkVBT8I6OpCI2mPzP0LYl8rx3eyh+veG5cewuOlkDOEvybHUpDI4faLHlAyh+tv1WrVj/47tRusC4/ui5jvirW5z//oHzti1mfaUUejx0unZWYnUyBksjIa5n8jdX2GjJIor1Jy66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRW/nFfK3w4WzY2yLXb/PJp0kD7MUtVKdoDwJqzOWCQ=;
 b=jnYSn5MnRAEbbuT631F2sjD9N6XdfNgl9IaDutmGM+y0QTNq0BPmn6PmuyjYHac9rPlER4n7duOkvFa+Ffk9Xel33XsK5NyT8Su4Qr6V2H3BMyndEEj9UPaf7J3S0plnF3bEFJH8x0kurC/mNL8XNVZ9U2OWh81HoyeI2wod5ZQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5105.namprd10.prod.outlook.com (2603:10b6:208:325::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:25:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:25:50 +0000
Date: Thu, 24 Oct 2024 08:25:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <a10c26ea-3a48-452c-a02d-7522eefd494d@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023161205.003ad735d5f6ec50ec2eb054@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023161205.003ad735d5f6ec50ec2eb054@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0113.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8e9342-1e64-41b3-75f8-08dcf3fd15f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dRMTVz/aA7WGkgPyvJQmy34JC8c5B44YSfAfbfgLdRTh4wA6V0Co4ggpeV07?=
 =?us-ascii?Q?fByl4Hg5WOtKn+ED6VWIPoZabRi2oQp2ktCcGsSZfPkV7wUTkD8M3d4YN3UA?=
 =?us-ascii?Q?VgffFIvoIvX2DH4qeE758AJYi8A1VcKECPtJCDgVtZDY4SgxidQMS5SdfeAK?=
 =?us-ascii?Q?CN1FaWgBdC0UbS/jqaWyZ/G1WPaXPiP1NToliS/N8t36s6m29SOoPLm9cXk8?=
 =?us-ascii?Q?MaQrs0i43UTh0ntpeIFxiYB8JjmcI6/zsAYxAcKJC6l5/TNQfuCJJC8766RB?=
 =?us-ascii?Q?UlhEa3usbRQul3fI2p2SxjhhPE4Jup5YonrYhPAjdwmY6F/VrYD+jLKxEPL+?=
 =?us-ascii?Q?DXmDxjfjNxGM0qUnTbk4qm+49yXt7MAbE8LI6/R//Ynz8oc49AleRoE762UA?=
 =?us-ascii?Q?QvGE+RfuqeDOegbmIIViLwGqJIyCvHLX5IBzdsxWBkHF0KndEcI5MyDIWXKH?=
 =?us-ascii?Q?Ob2qCOQGGOzvi1AH017xa7rLN/ioQQ02cIhzyOs8CMu0qG6ohDWwMChzf1vi?=
 =?us-ascii?Q?ftjsG4aHatEYGGKo2z3eU7+3XzY47NmmuyOr8G1Q2SNsYN3VPFC12ryWfu7Y?=
 =?us-ascii?Q?Kk7ozfvUAT/9s88396TUIdPb3vQGFViRCHigSqLPtb+5L77k6kCz89TXP7Ui?=
 =?us-ascii?Q?iysNf3rfS5EGu2D4yzWuQsxSpMnv74ZRYhzh1dOzhvuWr5MR+L5AZuhFh7/O?=
 =?us-ascii?Q?6ogedHg4H+pBo3mEyE53whd1j1Lo5bH1JIQa49Bxm3J2ytf3SnJYiT//RW97?=
 =?us-ascii?Q?6XD2C64lzOOU7r6EMRwB4CNWx2PNRhGcq6WJviS/kEdZXr57h2mXnc/NYr11?=
 =?us-ascii?Q?4uvjuNYeKlc08hZj1Av65BFKvMmagh4LPwwdvCrsaUpuz7TQngj4o4F0wqkm?=
 =?us-ascii?Q?csIYh3DYv22RbWmIuj+++EsjHXm6SEZXoIgVUvtMlNg3Vl297yTKj7/GJQmb?=
 =?us-ascii?Q?f91RX0d2Mjn7A7OsWV+HQ8CR02KxucNoKJ7LAw58E9rzzbULzlxEfO9twaMN?=
 =?us-ascii?Q?VLlKrnzr5iPrQ9Ce5/+zfbgB+9+h2p7vMvNPPJqpgP6X434Wm7i/1vzrPwhL?=
 =?us-ascii?Q?eKI2c95RYFiH5cGF2arX5iTbJtebTxn49Omg4AmMcwaeok8aAFpTxp9rxfX6?=
 =?us-ascii?Q?HWqka1qAD4V5yLOHNGbXcSGEv6QkR08GgFhGV2odpu7WmmTV0fKZo1uzI+h/?=
 =?us-ascii?Q?PGUBObxN/J0v7W61BVDATYrWApYJeuqOX8jqIo/HOsXNjqoOHbYzdoX1tEBH?=
 =?us-ascii?Q?wEn+avGk6jhFzIqMZ7IdtRxbhoiHRP3JZefMcJXC3Vp2rBSe4D5fj7UHC82d?=
 =?us-ascii?Q?ZYPDKWa9k1gnduXkje1vYsUe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpKZ5s1d283euepXCzkt5zx3jJl+aPnMJKTMuad/7KLKpDdQCb3+gHoHBc8a?=
 =?us-ascii?Q?6RRrEgEqkg6fd88s+piNY6sxFs0X79HfIeluy2lAOtrFFAVowgFq3yL1QlyW?=
 =?us-ascii?Q?UFe2Mx9J3TggOw+0Sa3f1fayZFcPFxuQiDeiKalWHa2v1BAqtwpZ6t/YJLwl?=
 =?us-ascii?Q?PADh5LB3aHzwJBNOJmQQ+40pQTslk3tYdN1uu2BnNejtFHVosl9GLGL5oeah?=
 =?us-ascii?Q?KXdODf/mc8F8J3sjCfQMSS48bjWAFuO2s/2NjUnZ/ExWGBiXO2vLyGTAwro4?=
 =?us-ascii?Q?K45fD58GeZsD/Kw+GQNTFkEVZ7e+0TCAMuKd3yKN9gWhk4/xIRXi37Z9On1f?=
 =?us-ascii?Q?70qNkibG4VV2I+XhNrFUb6/arGjujNnGFUh7VTk/kZffY9ZkRunicJYvndtJ?=
 =?us-ascii?Q?B5BBT5CcwI2zed8QxyBOi7DXWDqtB1rrOX2Kpl+Yh1oYyxJNmbO5DYgR+n/1?=
 =?us-ascii?Q?qVdgO/Gb1eBcB3/RirXrkdp1oroGe4K8odeYmIGYhobgp4oR1dz+uu7PxKL4?=
 =?us-ascii?Q?hXUDiYyHSlwoccGa4T9iIhtnFsdqA1i/3tU/FVr/92feDEqeRzg/mBjtm/HS?=
 =?us-ascii?Q?tKhY/yj6Glpu1oS1GPmFsuCK0O59nTWlcSDkqNav1g9yBsL4SnFgizRMJCbE?=
 =?us-ascii?Q?FeFlmensyxE4Em34PX/PpJi5oUYiY95sn13g6K/eBCswF3WjUyP1ck3pthhU?=
 =?us-ascii?Q?R0lii2ujs3pU8LaZ/p56ofS9TrF51SJ9F+qTTj+tfMtIBUXY2r6QnY2k2nNk?=
 =?us-ascii?Q?6tlxgnVYuOYw3p/hRccEcOgQx0kVT13CYnDZhgRshUF3TX3xA3YJGxSumwpc?=
 =?us-ascii?Q?pm0aFIAOkqJIRQe7FhRck9mkKZvdsRGXa2FBMMciik+4EB4wbnzRM2d292V7?=
 =?us-ascii?Q?LftOXUH6/cJz4+0Ver4GBE41lU3nTA6EEWMsOc4cxH1hAURCZoNUBebCYuFe?=
 =?us-ascii?Q?SrEPJncEfdLtnlgTeahOQHLSLddyfmTv5UCBlbfv5h/wa3yX8GQoPrWeeeGD?=
 =?us-ascii?Q?U+uh0VKHrkGcrvgK6A2U0yJuMnCpFb85W2pMCyOw4MFRIcSrmPLxEDPE8Vys?=
 =?us-ascii?Q?crgg8rqP3R6Pnzfhse/Gb7GMpLfcgHYCIcoz+t8pkmZQ/iy5lNSPSFmfMFG3?=
 =?us-ascii?Q?1X39DqcPCI88HtVxpXtFzsJsZXPGWZf/hHCRVmcQZPejtBeaWJ1UsgJ4zq2m?=
 =?us-ascii?Q?yNbPcdzuL6Zf45G3sq3g/xOEespgrBz//2K5lm1q3Jyiq8ucJ+qN3t+wlPOv?=
 =?us-ascii?Q?CljtZ3VBH5Eo3HASEKBbyq9Fhzy6+2oyHOLDpfeQD5uBLzlGRPQiipE1m90t?=
 =?us-ascii?Q?EXusFgpKr5y3MUOH1GzhmCbcyMxZ73D6b13FVRm0LgFWO2DGp3H2Zgxm5cO2?=
 =?us-ascii?Q?VnepCueCafnYTcgkcQGZ8Fh655t1P1XJTD8DC+2J4fD3WV97Ghnwr/gOfI+c?=
 =?us-ascii?Q?W4fbMwwV3Gjv1W1H6P8OPTLDrQYXmTjNaQmGJ1gBhkbO5yECS1z3A83TwWzy?=
 =?us-ascii?Q?54u7YvadB7H5Zcm+ByZ+B7mjxhOmffv+G7Oe6tkcoZj21reds00ma3YQBLyO?=
 =?us-ascii?Q?lFMOuZ5UpdxREyo+O3FBLkhWfkOv+L0VWRiHQef5B1/dQ4GLgn5LfPSgYmol?=
 =?us-ascii?Q?G+AcA+TLxSNfkr9/eD2ZqxKh4n7zGVHFTEBLbALIC6HmkzfVMm59mw+Gtu41?=
 =?us-ascii?Q?u9jyjA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+QybDt8Nr2OluMRtaRvsEGqEM5mPRzkJAX1v+HRHPSWcQC/0BQnpFeWYVSUM6L1UKMTUex6O4UAb7MzjI9YCG7yPRkgySAEPffVMdQlWMdxLIKJkIHyG4XQKhdxB9PEO9G4RLrowUZSKLxK++bfJ89LyBKtsyA9aHe3hVX6OhSYQAaaCmABrGXrCfyTk/Z+k5IDyL++YX50otNaLCdL1wykCAZKia/G9WN/7dilyYq1ODclTcDlceIW95EXfiAYHPHm2gcYSnNHe+HkdFddxml7caecdRfbwG64U6hb27IPfYR1LUV+iJRpQsJyhqvrXbLrBe8zH28BaZlc+5fg5JKrQ5hFequ5hSJPsZZp8wmSn7N5bmSrTYRPotPMR43q2HKFdNbOm91j3kdmAhgmLih63S1FoQuOfAQiwpLjQc0pOhoxJnxOe7ISVNb+B1/eZQscKLgzUxBG8fWvmgT8Uu+PNnSQpr7We/SEnqHZWuHwy2Y+Goc3dVs+KrlQ8EZgBfF+RKS7ERc08oiQaMR5YWD9mrknPCms/h8q5RX60EJsS8FkntFhzPpxSF9ztmhM8v4Ktbd6erOEnY3ZBl0dnjkkKhPRiBoJYYRh0wNRUoWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8e9342-1e64-41b3-75f8-08dcf3fd15f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:25:50.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UKd7vw3stjcdya77ITw8ajdAH6vqcDxm59NOUHnkssBv36JfUmuUygeEydW2crowUfOCH0gn8cVHRQF5ZGag8srG0WpkFX9LJ3yi98Lcm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_07,2024-10-24_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=697 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240056
X-Proofpoint-GUID: CAFHZIWPdh4Wdhq55zwAe4JHtkoBAvN0
X-Proofpoint-ORIG-GUID: CAFHZIWPdh4Wdhq55zwAe4JHtkoBAvN0

On Wed, Oct 23, 2024 at 04:12:05PM -0700, Andrew Morton wrote:
> On Wed, 23 Oct 2024 17:24:40 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > We permit this operation on anonymous memory only
>
> What is the reason for this restriction?

At this stage it's a simplification as there are numerous issues that would
need to be overcome to support file-backed mappings.

I actually do plan to extend this work to support shmem and file-backed
mappings in the future as a revision to this work.

>
> (generally, it would be nice to include the proposed manpage update at
> this time, so people can review it while the code change is fresh in
> their minds)

It'd be nice to have the man pages live somewhere within the kernel so we
can do this as part of the patch change as things evolve during review, but
obviously moving things about like that is out of scope for this discussion
:)

I do explicitly intend to send a manpage update once this series lands
however.

