Return-Path: <linux-arch+bounces-10047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC18AA2B7D5
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 02:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951CA1888D65
	for <lists+linux-arch@lfdr.de>; Fri,  7 Feb 2025 01:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB4A13C80C;
	Fri,  7 Feb 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ez5EJ0Fh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xucQzS6o"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8EEAE7;
	Fri,  7 Feb 2025 01:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891585; cv=fail; b=EWGqyaD68YAfa/jy0Ryl+AigJSHRILNQe1UMoBEyWwsCSzChWAAvpX/Ul66pmatcI3RildDMvOnsZNq8+BVqXAq1iHskPF2o67ZZab3fcHCGN0KZ00pbUrbZdeERkF/O08W8ZlZZTlAquvlK1SLkkicHfziLIjh9wTbsGCsB6nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891585; c=relaxed/simple;
	bh=hz4VRirex91+1rnir8uMyiNGI9KFBegb+PgT+OrrPPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOj39JEiD/lmwUCxtFZuSbRGi1rwx93mTQg2Ey3gtApyxIp0t6fU9b3VskGlaKXoPytWsu03wdLTWDtsbShdkgxp91zINO+Fa+ByKVVCAKT4OfpoXX9er0d6juE13++jvDW+6lHcvib1QG9hgGkjJhiBRv8x4mzF7INq2+pfWTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ez5EJ0Fh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xucQzS6o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5170MrIK028581;
	Fri, 7 Feb 2025 01:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EP2Hn/sXtrQW0bAJVVC0x2JYgmzmC82Aum6zXqoz0Ag=; b=
	ez5EJ0FhXhGknxF7uahe8xvPiMTWXyo42DnYLSl2YmM+0yK9WAzp+84BaTt4WkyZ
	L3+lMKVPKLwW9fHpKvxjPjoTTw31IPxvIUN85PsIEVjeu9D3N6ZBVlmUtcvPNxGx
	2/M8bpkABcA4A4C0lOM9WSld3Q1yu/qQPKY7FG7NUPclyrd25SyhjxFcRE75UtOf
	ikDpbDAghTqIR7jnflnLwGRUZEgphAUQUrS5nmfQLk1asgp38C0p0eN5/Uhncavc
	+O60X8X9FoSBVVOVaNJlcG1B9j73tgoBoDpBr+eoABKzdnUDtAbwA2OCCw8UfSvl
	fnuhmZ/+E92WUXqIsuPyow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4wses-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5170p70U028002;
	Fri, 7 Feb 2025 01:20:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8dqx72n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Feb 2025 01:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0E47fV3bU8dcY2aqWlGdxIiy+/YldDpc4KJZEjIXYRjksJLJHJtq/lufA3VWC6Ph5+UOHEPG4T9O4SSZRdFjMb0Vm8sEkr+sbPdAIvxHGJpYK28SyKuZgdqhLGonochh2I9VBRuEt78mtuld5KXd8LlNZ+FPirHOgcmSZxhmbCXJ6iVt693BzCOG4+0gSy/16WFtAbkdtyt5D/XMIpTeDLnRT2GwgOFzPISKm/yzokIuBmTJ7zsq59WNaM0Z+UEQT0TiN+E4D9OZq7rTdCN6MIbcH7ZIpF0EcAazixJcUOScaGKN94H+/Kt0WWUE/7E/F+xkDvX5oGLKA8yhrJLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP2Hn/sXtrQW0bAJVVC0x2JYgmzmC82Aum6zXqoz0Ag=;
 b=utMYLZni2Ptb2qnDOodesnr+YgTga1YwGzoeZj0MXGepY2dYj1YCqF+4DAP3N9IhZcx6bM3+61KRvha9plDS1ATf2Isr4hAEtYZRkgVGZ5hwUkHge9TA6JqOQN1IsjX4xDopAcxE33fJ4SQ9vSp0OZrsF4FQ9B8xI3nxF73CGh+wLkh8ivWEQ17rbEitCrbNGXhOH0E/Dggnmm6cX/cs3EfPBCuDxQ0p5TLp4RSOwzctd9VmDztpTCNvQghuehzhBakY8OkDLUUgbwkDuwaxYcqfmRxTborLyCNDBLqINA4uqB/UX8sJhgH5xnXbTO4JRq6UUDyG2xbn3CeblTSIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP2Hn/sXtrQW0bAJVVC0x2JYgmzmC82Aum6zXqoz0Ag=;
 b=xucQzS6ocEl0fw8B0cdISgVx79PikqS9B0Xz26byyNoaoAxd3CdgosTB6g7zkkIEzZQYOvEL7bTZiKScTlmP155K2V1OFAXr8QRJPHIwm0t+fowaF0qDzL6OI61w3FEKxKVqYUDCXC6YtebUt5u69zjLSa+ksRlKb74b2BD9BEo=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by MN2PR10MB4319.namprd10.prod.outlook.com (2603:10b6:208:1d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 01:20:54 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 01:20:54 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <kees@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Sami Tolvanen <samitolvanen@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>, linux-arch@vger.kernel.org,
        Stanislav Fomichev <sdf@fomichev.me>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kbuild@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
        linux-debuggers@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/2] btf: Add the option to include global variable types
Date: Thu,  6 Feb 2025 17:20:44 -0800
Message-ID: <20250207012045.2129841-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|MN2PR10MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c335a4-4aad-491d-cd83-08dd4715aab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubLKzUphzFU6PFB9V8JOZErU31Qs2fs20J9lMFCxXjhFBjXIl11gagisPKRU?=
 =?us-ascii?Q?/KY95MFIMC2dk4zZep9HgaNYZfNcdI/MdCxqtKjhB6XIIyKPm05lVfboivEc?=
 =?us-ascii?Q?oXkXhuoTCN55QKVhaKELlnCOz6O10kTCyIX/R6lje70LH0gSAGvnLmr4i7IZ?=
 =?us-ascii?Q?JAmFrwnY33LbmTAELEygYe+oDErscpvduZnQsgtaC2sulyR/PSsi8KNvHT7J?=
 =?us-ascii?Q?0E4Z78+bGPsWziqZHISc9nuYvC7O4P48/w8ef0ODgBNDG2S/l1KadQZn+vVH?=
 =?us-ascii?Q?pQJGNypb8vYXsgjiaESEP520/yE5Zldfo7Zse62GBX+wkOlPMqNXLhrScGYm?=
 =?us-ascii?Q?6xW9DioIkIc3L4xjsippP9/2hm9VMSNivHauuzPKKo3J9gYtR9MkRHUc/G1H?=
 =?us-ascii?Q?SmK9tT13pfaAf/zFtgztS1C6vr0DGE9XkpNgfB6IwGfg4oS20oEt7YMBl1g+?=
 =?us-ascii?Q?URqUSHT4GjvlCdy8taKmXSM5tu5IR7m6M0472YBQ1MarWKa1fLF+bmIbQ3qn?=
 =?us-ascii?Q?Z2xmNi9TcgLBXcuGUWtBF3kNtDk0SUKPqTtXLznmRgVUglImPd8iG3S7dCH4?=
 =?us-ascii?Q?QkC69spEMj+G/M5ZsT+LGyZvP962zxeuwp3UmNAk0NiXWJRacLvbGn2N4YZN?=
 =?us-ascii?Q?5lg68gY59MimvsZ9THIT3aB8t68+jZqv2sPHBvICv9nH6PBR1mtjrqVXW+wV?=
 =?us-ascii?Q?EF0gmmttiL3S1ZjfLBtd/PC9QPr/og9BGlthkLWXg8uoSEmdEE2vjh2dStu1?=
 =?us-ascii?Q?e7aSwN8wCahmVdEdt7p/CaxM7bRvwS3VTVtIzq9BqPULCGQ/Oe0Ihd2yg4rF?=
 =?us-ascii?Q?bxuvJH0hSGnNP5MHuVBzXFFAlpGoVGu9nfCh3agNL6UpBt6l0XRy+BUqMGcb?=
 =?us-ascii?Q?gCq6YWorNE12IOf1sQ+1l+O6Lvest2BQjoBFZGDPP7WoBNVR/F/JPHvTkmlg?=
 =?us-ascii?Q?VkrgQlJ7ONZra6ub4LU+XA7TY30TXjYO+UawW7E5zH3lyf8O5ykR3KjBo18U?=
 =?us-ascii?Q?ngHhQjBNDVwQYwjIIKa9DbhShMetdVZbsHLaXsIq4mYDN4owKvnzDBQuQtw7?=
 =?us-ascii?Q?j+ogcdakq1RDQav+tRg5ENd3bB+Z0Xjhab9DLlwsw3Oy2MtESiglxcGYoTZh?=
 =?us-ascii?Q?DSR6eC7QlaypR3pYEC58kY5XxHN8BBjZbSkY7angx43XPDfC53J5Va1iqQE0?=
 =?us-ascii?Q?AkDt/GLSfMc7+S2AYKyjd8flyfnlxADL+/R3ALMnWHqrCdiaQgm0aO7h80YQ?=
 =?us-ascii?Q?HtBk802hfTJ4vjdjEgM2Au27fQkZzKHut1HiqHOWCYdWW+KFiTqPRcJ5gpnu?=
 =?us-ascii?Q?NIElq4oSq8sutS2SwWIBQH4fEVXKTw1yMx3RdUu8MX9Mob9XHUi0NXy2ajTy?=
 =?us-ascii?Q?QzEKQ/eBcFHkICggiBfzCBLOv3rBunpS/QZQDJAYZ57NA9C2Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?doOCtRuXLDH3PJggYdzdapfKUR1k+dWCC0t3n0cTJMtw1mXYBpOglyPkCv/D?=
 =?us-ascii?Q?672QHlLZkVCmhRxjO5hIaRGGQBij4/K6CW9Qle27hKLW/TjZ7b64pLGuyozW?=
 =?us-ascii?Q?0DpITDEc1OAsUFQ/cV6XJdhTyGg4YzVTbw93GFH0c29XN6hkf2iY4ka5o3v5?=
 =?us-ascii?Q?epEZOAjLwo187915TzgjxxnzfE5RIA9K9vjHzPS9Lto5SDNvI6crTwRpOpIj?=
 =?us-ascii?Q?ldwnp6WEj2E/pDXwowGDLD0hdDnEYmhrrcmU2Zcqldo2fdZht5UQn+hHDVuZ?=
 =?us-ascii?Q?LlJ1B8PLjeLIPfaoyImLqGSH4MiprJcDZMlokkFOdXp0+ofpfk9PMWXn79qX?=
 =?us-ascii?Q?zSmr9wed01B6BVwK9DHIy3lEFIkj/ni/RoCKEi6wAK+XDz5mp/fullW3U3O2?=
 =?us-ascii?Q?vwGvqcm0vmEOo0b77EJZiL3D8bvg064J/pR3tq927jedYrk1T8j9NWhwa+Vb?=
 =?us-ascii?Q?+epzbxgimGIQ2ckkR+Xk7CUl/WDwf8P7i4O4xdjLSCbjbdVAtMXExU0JDejk?=
 =?us-ascii?Q?d6LtgNX/3d7oWqsqBXSznVeJN7W5eToP00ETr8RwyA67gCsT9YMFAezPzg6q?=
 =?us-ascii?Q?5eTOkkc53uFdS0XOStvcPP8QkJOUaDUuykYtwxHrWjQMEx1x/n8aXlPdv1se?=
 =?us-ascii?Q?6ccN+PV7NdyCoSkyfVLht9aVVXUye3Th5NbXog2plfL72k/jr9OLoTYY8Uno?=
 =?us-ascii?Q?YsCY9Y6yUEKKxAfceAvQVlrFynLXDtVrjiPuVp84V/to7rT6/hBbZGrztsE4?=
 =?us-ascii?Q?niEzvBoycpfgx3u5i4QDFowrky8cuVa7KA9V2E4w6vk4JomQN7eRJDHWUoUV?=
 =?us-ascii?Q?I4SPBUD6YdTaBSNwJEq00DEGd9LRr5V5SByzrvdspe1oVKgMrNrcINhkdmRj?=
 =?us-ascii?Q?CdeTZvNj4VTcKj086adA/+TBrqtpGSvKRuOCNeGqy3gcf9r6sqmAFv0GKf3n?=
 =?us-ascii?Q?+PZNgdqaMPe9T7jIXUb38QdHln6JTaMXA72/5lE5R0e5M701A+p1wr06yphl?=
 =?us-ascii?Q?L8qnyD4Hjk9TlOV4EGuNaH7Lyz1f9ucApFZYexWAlBDWMKgsriujqYxs9wvK?=
 =?us-ascii?Q?8Ho+WHZ/1PhoHkW3LA2VAt2B1TMEimFpxNeKD7TQ11feNmlueekpDxTRMehD?=
 =?us-ascii?Q?V2LTcgu6Fe0eEEw5XmCBifSmwQKG74bAEiVLm7EP61Kh6shlQi/TdoxJ46Q7?=
 =?us-ascii?Q?eHkrJ1OfqtBrEX4iD///kC1IxTSg/BTZ1zLykprfeGpxytna5nmhTD5WcY83?=
 =?us-ascii?Q?Eu7SL+Xv0TYPj/PuW5ebfD8j4KDvehQKXmW0Erz1qnGpKnbdeu9TxSY06eiw?=
 =?us-ascii?Q?fKiyDsq4O93ivVlppow1t7+iizvoJVWW1h2ClcGqRa32yrx+FaR9FlTAcX2s?=
 =?us-ascii?Q?4v1ud3HT4bys+HtzYPV/O8nZ6RInJPXOh3mMhYGVLVCccs0FCSodqsyRjmB1?=
 =?us-ascii?Q?zh2VOPQMGDtKyAhOMQOlb1ozCYRr+QBmmG9zu+ef0rdDwRqA2YreuzwkEn2R?=
 =?us-ascii?Q?53NHg5mW2z5ZP1WtJUXeSMBoYopRGWxDwhGrOUtPpwWomOZ3t2Weg/G2vw9E?=
 =?us-ascii?Q?ffPrb7mOW5EAEtGSBe1444Ie/ZHnwCGqVyHpTTWEGWX7ypW37kYdJGnK+UnK?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zfgm/vDnlqsrrYPJwQsp1dB0lZuAVBeP1Q13YPIl6KyUvsCiC/gnDZ3kKdSByvbp7jxKzW+uMZRPDnh7kk6u3loZbXHKMFLNFwr5SAj+NYxtwQuyL2u8kfG5qQat0HS6X1hLlUwai6+MZBUdhrJWMb++1MRxfefw9/ZiaIsmzBOhMkdi/UQHKf8hcvlxYlXCHekYVuD/Ula1sjlgVikPQEIlcTeyfsywGk99+mqRdrkGkZ11I+10fpP7mN/lVgjCXWdNbol0gxthemb9atHc6BUcPCN4frpf1t17wHrgKewXxXW3/WAwEFdfvUueq5CgFcunczpsCqac7fFtoiSf57qvxzdjKA8QoxsGCzU/fxgZ6KOcErlOy1vNS3ozlTwMsorxo2gIevoh5jOv53Kist/+z7IBBjCVVukcOX3UypB38z1QY9q55Vv12MGt2QXXcrYHpPNVFpqGSX2SHFdW6DFW7ncSrELsFCA2A4DpKkJxiKRce/C9rKbLcuttSTIcy1ikpST6QaYLzm29stwVz8Yx9QS7jNJ7HHGTFIHv+FugcELPNpqVnABhY45kTf7FGHmmHcQq8KZOBpqDW/abjSZt1KeFFJ9Jz0wapK+YxG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c335a4-4aad-491d-cd83-08dd4715aab8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 01:20:54.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7GvahJSyX7O64+6xy3eyD3Z5FhB2pE70UJ2A6DCtTnTmw/5Yw3Yfwaf2tY0Em04wLB8FhozvX5HUcQ9D+VMK6m4Ulxgt53kvtME3H7fzUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_01,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502070008
X-Proofpoint-GUID: rIbtNf9CUdZ5l7EuMHTwbCPTfpixSnrU
X-Proofpoint-ORIG-GUID: rIbtNf9CUdZ5l7EuMHTwbCPTfpixSnrU

Since pahole 1.28, BTF can now include types for all global variables.
Previously, BTF has only included types for functions, as well as percpu
variables.

There are a few applications for this type information. For one, runtime
debuggers like drgn[1] can consume it in the absence of DWARF debuginfo.
The support in drgn is currently implemented and moving through the
review process, see [2]. For distributions which don't distribute DWARF
debuginfo, or for situations where it can't be made available, the
compact BTF, combined with ORC for stack unwinding, and the kallsyms
symbol table, can be used for simple runtime debugging and
introspection.

Another application is verifying types of ksyms in BPF programs. libbpf
already supports resolving global variables with "__ksym", but they must
be declared as void. For example, in
tools/bpf/bpftool/skeleton/pid_iter.bpf.c we have:

    extern const void bpf_map_fops __ksym;

With global variable information, declarations like these would be able
to use the actual variable types, for example:

    extern const struct file_operations bpf_map_fops __ksym;

When the feature was implemented in pahole, my measurements indicated
that vmlinux BTF size increased by about 25.8%, and module BTF size
increased by 53.2%. Due to these increases, the feature is implemented
behind a new config option, allowing users sensitive to increased memory
usage to disable it.

[1]: https://github.com/osandov/drgn
[2]: https://github.com/osandov/drgn/issues/176

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 lib/Kconfig.debug    | 10 ++++++++++
 scripts/Makefile.btf |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06f..3fbdc5ba2d017 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -409,6 +409,16 @@ config PAHOLE_HAS_LANG_EXCLUDE
 	  otherwise it would emit malformed kernel and module binaries when
 	  using DEBUG_INFO_BTF_MODULES.
 
+config DEBUG_INFO_BTF_GLOBAL_VARS
+	bool "Generate BTF type information for all global variables"
+	default y
+	depends on DEBUG_INFO_BTF && PAHOLE_VERSION >= 128
+	help
+	  Include type information for all global variables in the BTF. This
+	  increases the size of the BTF information, which increases memory
+	  usage at runtime. With global variable types available, runtime
+	  debugging and tracers may be able to provide more detail.
+
 config DEBUG_INFO_BTF_MODULES
 	bool "Generate BTF type information for kernel modules"
 	default y
diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index c3cbeb13de503..ad3c05a96a010 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -31,5 +31,8 @@ endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
 
+# Requires v1.28 or later, enforced by KConfig
+pahole-flags-$(CONFIG_DEBUG_INFO_BTF_GLOBAL_VARS)	+= --btf_features=global_var
+
 export PAHOLE_FLAGS := $(pahole-flags-y)
 export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
-- 
2.43.5


