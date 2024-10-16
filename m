Return-Path: <linux-arch+bounces-8216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7199FE6F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BE91C2472D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034F61FCE;
	Wed, 16 Oct 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gpOc1Qlt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wmQxhziE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606B2AF1B;
	Wed, 16 Oct 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729043333; cv=fail; b=aGgTXRiRqmibnIs4r+L2x06vSMxVyKxIxa8RP3R/Dh4IJnfyJ6lYVMMiA7RjMV6dZPisXgb+P1Q6rQKhaQ1M/v0kdx5NT/xDIG129gO9+M/tlLkLdtBSOOwnziO0BgS8UP8m7jugt7eXGB7AigfihmPboFLCzkSKAfUAC1NCeKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729043333; c=relaxed/simple;
	bh=gDBhnF932Yv6Kr7/qXcrQJsIcqU/n2w0z3W8TT41APk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUMHXFSpIrwKVDaVzEGIJasxq8xfuv5q+5++byYJB0xFr9SV2X4/JiTMMomzjz2HgrdY0qumnNA50PqvbE9MDY7U8OuYFNgS1p8qOH+Q4DfN8gwC16Dks4+otVQGPjYUfAGD7HzdME01aK+ESkMHiyXzD9fanbsyJqIdGQfAbRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gpOc1Qlt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wmQxhziE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G1fdtd017591;
	Wed, 16 Oct 2024 01:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x1xSAlaieNZa4QvzBo
	mcWfaTOv/15856OVB5hmxd12Q=; b=gpOc1QltcaakFm9nPrPzDZZyOonkIU17hT
	9olMaAkakMYiDFKQ/azGnxuLsexhk8Oq4g6D6EkD/zxD8Dfkh3DslHtF5OQi14u9
	NpLUQj0OLaqVdp6OqCVpC0+MyX1p0TrUlDQS2RnoJLY+ltSA2mghTWIuCKbaWvzj
	zAVkLAewqwgmXs5Pl+97DO7pZhvQaRg71xXqtxSGSh4OiMoo3ifbW7ngD2SkbWLL
	BJgWLT4+NP1wG1JlqsZZWoMWBpvJ9L34JUU5Q0NqC08VkQyCDn/KpUlGHvLxOG+r
	VQksFMvI+IuwfufM7eUl9NCM8popW8W9ni4FOoECjhZ1AQMEdSeQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cjxcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 01:48:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49G0Rs0K013886;
	Wed, 16 Oct 2024 01:48:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj86td0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 01:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSfJ383x7XaK9+YkCfsYuPqhCOGLbrTmjdrF6INZmr5LhukhtayiKHdJTfkpROe120HWohzlFQUQ3fFSYRmsXPdINQtSUBoSejPehcLndK9dirKRB4wIcwx0bSUx4YTVYcLO9kmKA7eruMW9EQ0VSh2naQ60MPa2UXr8V64xJblAXEcAui7O0hym6qbKhuDTlLM5dx64cH7IivKoXGmWxXvUvmKkWYs4Hb2b87jW1MvnqALfcl+IBjXJhTjKi0WzuTL8FspkO7A14JTsRZ0qZ0KvWdusIyTSLn7App2Yq33K3ylE1jw8CPNfu18q5D9QJ+b9aKyZrID04RgkCYlusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1xSAlaieNZa4QvzBomcWfaTOv/15856OVB5hmxd12Q=;
 b=Uw0fO/0IFchsmnDtj3aCPdA6sJZvIwlbvFJqMQxxqYMoJyTNuUxIgSCaYEnE0IenfcyUIhR6QYmFaoEnMjY5vh4fdDk5bv5vXcaEx1GM8j6DiTa6ejs+RD3eB7HL7E9uQTJwWC8XrTomFUONReZPLbAyyfvO9WyblItzC2FFhR/C3PaNx00nP2i9hwzFwXv+u41DWZtvJdGw+0WWgCHvu6Ibm+pP05Q2d8daLnlM4bsoMAnInJdB2zWD/LIPD6gbszZJB0Lc84hqEULwuBLNYdteG+egMi5adeP+vICHTlXdpKq71tXApZFCEztZqK/6EwV/u4mniatRSVXsXR+yyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1xSAlaieNZa4QvzBomcWfaTOv/15856OVB5hmxd12Q=;
 b=wmQxhziE72f4G4WxY5C0MQ1C+lsXR3sZLMyWLgl5q1B/11+b2zOIEFfp7uzacL8M8mqMyaKLIPUo2heVxsfYeA4QAB8TkbxCSrozvfl2secykJmkLgujaFkfX6RK9ynDUiucronhspGY7lN83xtT8yCqwDLHMQIrHOB5n1lTies=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 01:48:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 01:48:06 +0000
Date: Tue, 15 Oct 2024 21:48:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
        arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
        thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
        xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
        pasha.tatashin@soleen.com, souravpanda@google.com,
        keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com,
        yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com,
        kaleshsingh@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/5] maple_tree: add mas_for_each_rev() helper
Message-ID: <o3jak2i7ohhxi53xlthv7yy3oop62qpfscel36szn4sctg67ip@ctrntnrcauav>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, vbabka@suse.cz, 
	mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, pasha.tatashin@soleen.com, souravpanda@google.com, 
	keescook@chromium.org, dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-2-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014203646.1952505-2-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: a0de8fc3-939c-4dda-f1e4-08dced8494a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?su24yFOTxkPxJHmSY3AYyS230uDWR7M3GZ3PE1PtsyA5VT1a/MSBTJMatcmv?=
 =?us-ascii?Q?hNsZGMtlNdumgS9Tz5UAaMCQFHkXEAi2fFlSRs3lzQm/3bZq5Ngx828PHctR?=
 =?us-ascii?Q?Y/4ArOs58PsszH5u+0Ge1jlr0BWMxfuSefHzduFM8LVsKOp/05wykofyxy1E?=
 =?us-ascii?Q?pnfjDBQSKQb6dazN+NCSMhJRletlira93iRJkwTud9c5UUekQwLP2ICvmDgk?=
 =?us-ascii?Q?GhsjalSUHC1Bd875JAJay1yJFaxPAXGov6T4l0IcHoIN6jC6FyZLmvke6/mw?=
 =?us-ascii?Q?/RwM1MpbIfpwcYc8wj5H2LZ3zhz8hjdqcEecF8MuYnq7Sfttf2kN8NHeenIw?=
 =?us-ascii?Q?8Y6FFw4xbI9cyFi0Rp9ZmSJDBWWUKZMBzhhV1yIP2gZ/OFpgkvptu9/SuK0i?=
 =?us-ascii?Q?SHH1GoZf14EXR/aCLFbh/M2AhUMcvugiX2uNFWv7z23iPW5AVuthy7GI3Pq5?=
 =?us-ascii?Q?AahJGdXZs+AtlOFafH7Vms9QyVENzOjAdFy/sfXnB4DWgzAYxoXoeagj3n37?=
 =?us-ascii?Q?rPw/ZOL5jVhbstNlzlIsM9lgU7U1rorovWBasV6DYyMTKXQL0x7EsIoV2O87?=
 =?us-ascii?Q?GNuwAjxsV+cyYhH190oyL+XnbQx0i3tl9kRkJFk1ICQHdV0bcmIZV6ODXztC?=
 =?us-ascii?Q?PioEK7/Cf6floiIlBvQwLWGJk6iidb5JssMPz33NKLzbPJywoYWU9uSKkbXX?=
 =?us-ascii?Q?A8VEmYjfz5TIjy/2bxdrUoIqcZkFO5af1URe+ns1gHEFDhsc0bs0P9gCB+Dr?=
 =?us-ascii?Q?tN/C+odK/y0EnO832gbwdocGpXMrDVyxlmBqJz66FPk2s5xB95PRAKxrze/O?=
 =?us-ascii?Q?cUIhMcLcs8q7rwirgRsqTRz0zV/qQGIiwSg/LxylWG3ozwKSMl4ktI95BLLu?=
 =?us-ascii?Q?jIM6rZyuD4tU5bUH2IfSpyrcn026PzMH8Y7IbHg7098noqng/rgazWjTP9ES?=
 =?us-ascii?Q?OrucV0AFgxOv4IOZnMXVqFK/3aW4eHXIY8CQ1Yut2vyrk7W7aDpjBR/ZN/Bp?=
 =?us-ascii?Q?OrNAbKhC3rlZEoRTpsRkgr80ZPgEqssoNDKtIbvnnt6IpeH0KyFNpZSKEXmy?=
 =?us-ascii?Q?fe+Jfe/lXsXDjQ9k8WpThj8XgqTtT7ynkz1OMFjum0NQ7Yr5vXlY3yYRAqDS?=
 =?us-ascii?Q?WWxmAed9Eb1M/EFCZ0fsZdNfdWB2lmRt/q2Gusf22Ly3KtEzjD9nJWszY+Nl?=
 =?us-ascii?Q?badZ0Bl0PKxk0epuSFfQBJE0pItxRVIX+Q6HcBXW0MqxU3uMb7h4t5achMlp?=
 =?us-ascii?Q?Wo69dfIZappLEiTmffw/Ex4lBCB+LsHu/hjkZZPAr4wZh03GlU/BkCEPycGu?=
 =?us-ascii?Q?cGsykdrPjYeaEpaPQzlTQq93cO3JpTrEhXP6VXqPriY2rA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?odYK+OVSGjS/YT0dzqGpn46LWblscXzccVshqcTsSuoLfpAOe8yntBKkTw/Z?=
 =?us-ascii?Q?+PTJPEqR6aGcMKCXilg2EIO/PXcJw7/Bx2MZ33ThehLhGVQ/njpPrnjJCJR9?=
 =?us-ascii?Q?E/8IuHICbMjayEb8K9jvPjz0Z3/dLC5GQ9GAAgr1+NvT3dTb2H4GY1PcuArd?=
 =?us-ascii?Q?R0iiNuYkIzG0wTuZjPDxCvO5MuBSIpfpl4I6DjvweSoRrIVerFkXoyhibnTn?=
 =?us-ascii?Q?W01KY7l8qyJWpsr5mEOxr4jfkUO3LLDyRLCSPrj//JJcKafTe6zQYhCGzRRJ?=
 =?us-ascii?Q?PxDIBrEEsYQHKK1C2MGMpvCoWiSBEhyZM4FUynVn6caeNuAiOndo6HMcv5M2?=
 =?us-ascii?Q?TdnBDBM30/MabPs+d2tgjkY38Xyxac5y4lngpA95hyqw05F+C7nKOQJeW8oG?=
 =?us-ascii?Q?qj2Xclj8aBhPHtGHVmyraWnlQ2xmT77reIg9DXr/zpYmo2Swm11LG9R0DW5T?=
 =?us-ascii?Q?rH2JU0zPBcUO/WCmNjbSCyrWOo0lQlF9jF3/6rxo5NtoGODQminUAkAwnG9A?=
 =?us-ascii?Q?LgBWkT2SX8qrfBR6YkAfZqa/bl8J0nee6eDRFfdZ3ZUqIns/1LwNMrHgPGWw?=
 =?us-ascii?Q?R9RY0XLXQ5O3YohL2Z2EfQ3NSCF+PZO3kos6r8UbQrXYbqxegP4L3iM9zJM/?=
 =?us-ascii?Q?EdOqEHelo+ZIm5xSS5Bi5VTnnn7PYm+gaVf02N29JMQD3WQhFrXKUjvcJW7q?=
 =?us-ascii?Q?UmpH68PnWQAE3VnlgMVVfgPoVXqj/L7kf7XB/FstJlTr6Bsa90OvHEvlzriu?=
 =?us-ascii?Q?wTo+bov0slLvs4zjAGLJkGvpVxRMwD4KzgxtbRoNvUP9zi/+goJwBoqOsYlt?=
 =?us-ascii?Q?hncF88NIn3dtsD2FSJ+j7maZBjWp/0YO0p0UJTCJMBrpRpS8hXC6GGnxPl9I?=
 =?us-ascii?Q?hNcRBCrd0Fq4MXTLM4+3QQxwhOpd3lHOE+9BWmtTFSDFcKOtMvZSFpD7cucs?=
 =?us-ascii?Q?PtTkPZBO8lyhzglqn3LIWe+a2uxn3UOEaORl7vsx9JeE/RzBVRGEFSlPPO8/?=
 =?us-ascii?Q?tb1NyLAxkfAl1NwUQUNdmJlC4qRuxFwey00EuOIMMsqH43eI342FTcCsIWd2?=
 =?us-ascii?Q?RE+HRE5uQLHLmbyk5binjTIG9kUwU5Z6kwqcYfVazziVB8Zjl9gznhwVARJo?=
 =?us-ascii?Q?lFCBhVkxehNzpU8ljwejo8nMZN973IY3nxxL14TstwX9YD84nkhecX6jzc0b?=
 =?us-ascii?Q?yrgIgAkdXZu//Ob4Zf4eHX9gc8GXmEAJ0UovaiipI3HrY1VUpVC/nHeQcZKs?=
 =?us-ascii?Q?kQ/hJohYdixxuoDj1cM3LA54gRL/VlHKC5d5kjHiA8mYVpQSpSe+eVdr5rlR?=
 =?us-ascii?Q?IrhlKjCBmAF7ZDph2jTSBiwOvsb5Zu7oTyIxN55A4q+ccBf7mJF7Pq3PMicI?=
 =?us-ascii?Q?A1kgHGvqCFCvPuyjecmQTR1ol9sdP9nnbiKH7kmwTjOh836uz8SwCWEGI3Hy?=
 =?us-ascii?Q?iXypYPaU75SPCkgvn0g6tLAGn/0HahM4WPBRCiJp+XM7etaFOIfZ8S9roNZo?=
 =?us-ascii?Q?vzh+KlcoE9cXGASAk5Y8DPPSL0y7DdXRllvNZvA9UO8k91Ls/vM9itTkudfh?=
 =?us-ascii?Q?Rm/zmRs0HZMM5Vbwh1QXidGVelP7zAhlFS8mXwtqIf4VNhiN8Wck1c/e8hW7?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oYj7tDMQzVp6ndclh+zkn7rh8AYhMdS4Q3IGrAG+V9zT3A7isWs1YuYHpzg9Ecsj74kNa/6XH6XvmjHELTS/auV+yu+GwgHNGyjCyNtG+s+bIOZf3fqTJVcMIJuvvOCI+SRGoxkz8isOrnBboQ43DjDuYN7AxT+NxKCgLvNr/KNKUkWlUOBHDGyMbLC+ic1LB1KWpyTdSGXY9CRouZHz/8K3lFDEaVsrcjbuzNDajIoU+c1aKmLazT0S7GLkvTQUe+AIjdAXBGq6oEopSxZVR6uBTGSZWgUgM/u9TEvWLOfulMmGzYOuox3ZBE3YOBhP1bRIW+/AxsDcHz2MCcOkIIF7JIHVoqkk3raFVtjMnvDKMUPlKUmkYeS1V3qALmNTmwj56b1J1VN+oLWQWpWK1BZ6OGrLhgA+5RQYp2b1m/bB8e0vkNmNcdD7Ffx5nWMyjf3SdVKihcaFXZmq9BedlbYBRoS4uJDtqGWxv2GYh7imOizT8mCVaZmvmqvAItXudtPvI9N2t6PRD6ghHRWzD651TUAndQx7bhXHIRxQlm0t+x4mIcxaK+a5rE4kg8gRBRyLovo9gbiqG+9qge/IBTITP/A3ceEdz4PsotPcI6c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0de8fc3-939c-4dda-f1e4-08dced8494a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 01:48:06.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCDDfG0sGa0EPKag4uK8WxSFfAKQA+MQijLcstot1YnE5Pzc0M6Zxfkr8y1UFwjbiDZt7MUtuURfVpyJYvBlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_21,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160010
X-Proofpoint-ORIG-GUID: R9u_vo9A_bPZf6XGSHwDyhRsfl_Y1E4P
X-Proofpoint-GUID: R9u_vo9A_bPZf6XGSHwDyhRsfl_Y1E4P

* Suren Baghdasaryan <surenb@google.com> [241014 16:36]:
> Add mas_for_each_rev() function to iterate maple tree nodes in reverse
> order.
> 
> Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I am now sure I added a R-B in a reply to this :)

> ---
>  include/linux/maple_tree.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index c2c11004085e..e7e2caa1a95a 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -592,6 +592,20 @@ static __always_inline void mas_reset(struct ma_state *mas)
>  #define mas_for_each(__mas, __entry, __max) \
>  	while (((__entry) = mas_find((__mas), (__max))) != NULL)
>  
> +/**
> + * mas_for_each_rev() - Iterate over a range of the maple tree in reverse order.
> + * @__mas: Maple Tree operation state (maple_state)
> + * @__entry: Entry retrieved from the tree
> + * @__min: minimum index to retrieve from the tree
> + *
> + * When returned, mas->index and mas->last will hold the entire range for the
> + * entry.
> + *
> + * Note: may return the zero entry.
> + */
> +#define mas_for_each_rev(__mas, __entry, __min) \
> +	while (((__entry) = mas_find_rev((__mas), (__min))) != NULL)
> +
>  #ifdef CONFIG_DEBUG_MAPLE_TREE
>  enum mt_dump_format {
>  	mt_dump_dec,
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

