Return-Path: <linux-arch+bounces-11995-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AACABC8A8
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD88B4A3426
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3B218EA2;
	Mon, 19 May 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPvQAfIi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nYwMx27A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC827453;
	Mon, 19 May 2025 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688018; cv=fail; b=Sv4ikhUDLxjjopmYsK8yF3bnGuspCWb2dHL/RMUhhFPcvOVTKqiSW+tWKOhmVTxSsOACOnatIM6K7xJXQLI219EzBJqjV7h12s8Bk8HtbzGnqa5PnmZN1NxhfTTTxYiph6j4NgyNFqMRDqQkJ3wxBGTKkeVk0psM2kjLh2EsvqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688018; c=relaxed/simple;
	bh=8bAZDO8vteCq8yEUB3fkEIzMAWwpv3ENGMGTSmjqfm4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RwcHBHKOsUnuaymAqrL6YzcmkhhpBWJlTy6ZYUnQZN7x5umnKri3FTlqFsR6uacu0FnP/qd+DFoP4x3j9oLNAfwfmZY2jlYd2tissSeXSrTm+exs8zmdGN3lskUPwnM7VzJirip6uqThJXIfaAgJkQSJBhNMYY/Cu1FClIEDo4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cPvQAfIi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nYwMx27A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMpHu026242;
	Mon, 19 May 2025 20:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=5vTf+rFrt2iBPLz3
	kq2MyXsvCeXzrHMyylkbDuh2t+U=; b=cPvQAfIiOz74zbwUKGOy3f1j3vB0uoA3
	/PPjEeBX9It/GjjIGr20yKISGdMmS7P2Ob7MIwaGs/JEu7dFJJn7/ufKhN4ePm5j
	6ux8e601Yh+CaVMYrs5P1LMXV13yE/RB4pXRQHROkBkbrEZoqF+edzUQJp3tTrf3
	trHM8nmFzSg4ILDzAG3Wr1Bbj1JhmcIjEJGajrP8hab0OS3/jIbnk1XLP7yep7sL
	sZJ8MpfP5xZVIalgBuGisk/1rwdNG17EJiwNLi1UAfY4pCLKUmUZ7Znf5WHzHtEU
	+AtHvanwDk41Gn4+5Ok4rws2L+tRxVEDqMi9m3j+8pMGKhg8xFdayA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84kyj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JItVHC017346;
	Mon, 19 May 2025 20:53:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7e3p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDpIlrPXiNN9tOtpJsJFCs0y2fwIBCkn0IhZTJgoDl7FIY6swg8DPq8vwXbyPS/TQLS/YPUTaOwy2bsyfSr1wL4kBIf9UGH59IkDjcUL9DHsRquI2+yPpam4Sq6dJGkOddr/Qw6Qzhm1PBjxyNq6o5mzzpg7WCGI4t3ffVRxk8nIPdXwKk/j5Onz/zF8ZksqmK6CzpxZ3uqo7C/t/H2JhiPUSzw60gp3cNhS3xI4+GRDB92EL57U4L8ZU9TiN2kq4ojqHGMDpPS8uBZmFYJSm89cpGge6nZkTDyJthQ4CDC4x9FvSQBgA3r8330zmL38t6t8pjVSOckvws8CbahrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vTf+rFrt2iBPLz3kq2MyXsvCeXzrHMyylkbDuh2t+U=;
 b=rdbIyKsQZwrl5WHGRM0wagv8bXCpLgaaZSKoAwq0X5sAVz1OYT9IQCG4OgdME50eHHFk9u4luapzJLQNPizTSORUEt4Apjet6vV2VZOIAflwwVF7N9SHuCcGbLPN9/bmOqcg0t/GRFlaAqh774qhwVmGCWHdP8ngiaCneALcXAZ/timy2Me7OObXKnjTP09BvgpBaAYzcxhwvsOi5pmKwL8xOMn8j6/iDi+NaTgwWsRX6VAtKR3kLI3HwFWVtwQ37QM79IBDCOwgEdpqfloNoQK3s55FvREoRTMrOO4K5ctrh33XxCpXU10VMXMZyYS9oE5czLt3eqxXPhgvnqHexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vTf+rFrt2iBPLz3kq2MyXsvCeXzrHMyylkbDuh2t+U=;
 b=nYwMx27AjLddrWLdZGzC1D9FFauUDR0OPLKIgrdibp4+/TtnIjCX5ZkESsgUmvKh2Ib4JGYi9yTbg9agcb1zqBp2jy5A1DJqEq2/g9r4lR0a20KaWQ6YrU3JLnLzwWvahbMY4phu7NtENDT9GVotPyOiewQTjV28uQDO6TDljvE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:52:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:52:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Date: Mon, 19 May 2025 21:52:37 +0100
Message-ID: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0386.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a095e3-64f2-443a-7864-08dd971722ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SvoB1yIo/uwT1lrFzkmGSVeG2Vv6FVVECYHkdmGxe/qGIIdrYQkbY3E/Mqv4?=
 =?us-ascii?Q?8SqNlWx0rfU/8JzWnjdSYyYP+fq+ZHJWb3j0RksYptZp3b4aAen0/5comGxX?=
 =?us-ascii?Q?PPl4kBO5Wmhz/n2IVDNbkGknNtKpLG9e0hKnO2whx/xN3wDMkPpXSYBQNxF+?=
 =?us-ascii?Q?d6pmb6c0Sy1cdFvVc/9kdmC1Vo2JnbtwdyDgO+Ho5zAH2ttjK5oGrvGDJ0UH?=
 =?us-ascii?Q?zuJvLEZfWKtpzqdUcDwhUkemEldOaEuqp8kTIzcNpuUl56eYPlB7VyUI78W9?=
 =?us-ascii?Q?debC81G8ZsgywSAujXm7JX8pfD2G9Y33JBfKtw8E0Kt/5H85+gTsGVsjxkFD?=
 =?us-ascii?Q?Pd3ANZdwmmcemWAk+KxuKwJ4rElr3HjkmIQJJyz98o32v8AFBoQIbBS61EOg?=
 =?us-ascii?Q?ryOkttwZoKlt/LvJ7HDARiNiTTNynxmGkMedqOopNfnYH7os0ytqB5ShTL7j?=
 =?us-ascii?Q?M6D6vh6u4HeBORFuQgfyBQxFYvRvDMaj/FnJNZmrq95xDHIMamfBKkvY8zrO?=
 =?us-ascii?Q?1bHPwJHVHYx1wvjGUsVZu/eX7QJKdiI0ZrolkncyCUPMyXyj0A/HlyRhQTWX?=
 =?us-ascii?Q?z4bYwlQX+tjmcGgU/L1mvO62pGKfwuGwxIjPZiK7XeNuYEb1/9ZemYq4red4?=
 =?us-ascii?Q?M3qWNiqnGaPDIzhMgQ2tj3mOL4u0I/zAFv+BpYaqzQ2elf+HTbF9tniLCtbQ?=
 =?us-ascii?Q?Agu3G2MYvYFghXOgGLnQcXZmxIjvBipeMk/fGt3fEjkwGI5ywlfF1K41bGTL?=
 =?us-ascii?Q?xo0UeMiXcFwHw5zhq0K+YcEtxSGaKFukEv7hWL+VM+d+EsFU1Uc7KhLq7ff1?=
 =?us-ascii?Q?jxIoFyqgLBxnfJTJ5BkoNhOx3xRrL4JuX7p0Op2jumTDJ57fTXi/t4xv+mV4?=
 =?us-ascii?Q?lqy3IDemzMexzC5Xw9gGFukDnWSdnjZP+prY7c16Mu+bSnMermv+Q64cHEKm?=
 =?us-ascii?Q?K8UIxkj89yMrsh9k2oBpNiJnJ0ba++Tjv2Opr5BeVl0UlpQMya4Ctqv5oj7N?=
 =?us-ascii?Q?SQ3f+KrtwEkCAQ1BQpQW1rPuyCxiaPlkWz33DiiiYqF+qX9gckgiBRN1HGQC?=
 =?us-ascii?Q?JHNtQjpGGgVj6p6FkulneZC3CEpDeNDISvs6nNQpHzATkjaeMhYzaFkuudHf?=
 =?us-ascii?Q?HEVHvKXCvvY73kREbrJXFLY3MwvzQMNmOlHG36V7LorW+OpBfF75WthlLXDh?=
 =?us-ascii?Q?NU6DOA4q4gnZO37WoOCaKfckP9fzzoQtubSF/nCgJegDkNszY5LmLUj4kOfm?=
 =?us-ascii?Q?xHY5VjVZGsuEVUgQcjcZgbv46CUE614mErXb3U4W+gwgaFLiG0p0SjAwe8aY?=
 =?us-ascii?Q?EQgaYHk+3NcIwRTXzNXEnGp8JZZMt9bavoPlV+XbZ5GGyq54A6HE8q/61r5c?=
 =?us-ascii?Q?ky+nrXpUGEcdbbRSL2qbddPrwo7k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ybpw168li/RUI+ex9nYdNv/tZwBOae0ADDAy2HkOlQczw0NPezyjPEWk+6f+?=
 =?us-ascii?Q?5akEDFIDYFpz9cnfgriXnRLvS88KWNRL0FVacNtsinuuVBFHy+Dwx/DWQoux?=
 =?us-ascii?Q?2hakXSV9rQt8ZWVhSXuoKk8wgxLNnmL6e514zIUytd4kouadXhd8OPLlj04x?=
 =?us-ascii?Q?+c5cQ+VlHLQ2qCET4Sb9xXJtVaMO9SChbKZA1Dzpce/EayCOCRbC69ZScGYL?=
 =?us-ascii?Q?Rh8V0VOfxor3wkp9jPIwMhGTXkGJsMQejLGuqprbr1wJMYUlOQhvlf4PLLmS?=
 =?us-ascii?Q?7ObW1vY67NcSKX1cm/AfWSfxvbj+4XK1rk/Ne+udwqphPw309oWmhkGzF5mF?=
 =?us-ascii?Q?jhPbkQlbsMmDXq5kEkE4aljKm/TuCUyO7Omi004YeGJiMXsDhajelj+pHjuT?=
 =?us-ascii?Q?U4Wa+5WQJUAfvPsP1JvC/TkVQVBLpZdi5n60J52wYwoMD4BtUasFd2v81v8k?=
 =?us-ascii?Q?RZz2lGiBE0H3Yq6K+ypnRiD2FyqzN7rYZ8e8D4ouHlnrnJd34ziG1phmvhJL?=
 =?us-ascii?Q?8vBNcY6kG9d7dnPukd0AHH5Xd9y5tbPFSiba3CG1cGXHvDXhrMm4WdzJf2zC?=
 =?us-ascii?Q?CYoKFk3Qobt2W2llvxm3Y1u5CGr7pjl1ABQRi+xs58SSmjAzKCCHFxLhIVQp?=
 =?us-ascii?Q?4V5k29ymxskWHzqzeSqh3y3n1z9/pUeUTgUsxicAv1ohD0hqxcJ5na1l+cQQ?=
 =?us-ascii?Q?Nn4x/41v4WyAyUBiP5zh/W8t0bzui2YJduQvPwMaNhImMsdqTB29TjRApDP5?=
 =?us-ascii?Q?kxM4AnSuith+i0hRdWz2fi1X+ZNeWDQoFTkJf8d1+WVbYxikqCx/I4nYDPUl?=
 =?us-ascii?Q?bJc7/VmIIitKICi+3KKfq2bWaaPx2h+5VHvK/gAGLmAPQYeao7p8bPmezTJC?=
 =?us-ascii?Q?yCfXHaIwnFxpp2LfxCEVZ/luiwZQi4DibmdNn3d2kcqxZHTLIB0PIzJCwb9V?=
 =?us-ascii?Q?0LMftKbHCSlIgfXmq+sMntbHUgxWsD8LRP3qE7FabqGxKLC5jGpbLIEhOTff?=
 =?us-ascii?Q?qIRrARknw85/a+xz9wk6GAq3LD4177CTO3oBOtEfoJyrlYDtvZ3NqBwoR7CZ?=
 =?us-ascii?Q?rAWJxlsSmgo8rQCK+CG7qZiogVeI+npzSAvCNaAsnLivR5ie5xTFi37hkLmI?=
 =?us-ascii?Q?bLErH3rbVZm3+ZoqcU0nfHtGrwuBqt3eps84CWV42KLR/JX7h7xnNBwmg/FZ?=
 =?us-ascii?Q?5MQTKamV8cm63MWm+s+SLshm02iagVncFPNtnaGtaZQRj01wDl8zcNc8Gl24?=
 =?us-ascii?Q?Tof/RSpA7DBl0+2RmmhLGQsSHOpQl7GLynjvsnlSV8ckzxSjddzJAJe5FpVi?=
 =?us-ascii?Q?heXIysbFGNGQdTH5tHagBaiehrVSfWE7+DSs2Rg1F24FylpAwa/c0SK/plUH?=
 =?us-ascii?Q?bDoTWuxmwenE7x5QMO6SkznCxBcuncjPurmgY/1dU3zvlLEQwM3goFejjFHp?=
 =?us-ascii?Q?9d4SUuVxTSCTO1fSGnZiX1thx7ABYN/sdw5IEqE4b9LceDoF+MXDXAv3cpl1?=
 =?us-ascii?Q?wApPcdT2z9bifVR2xju5GUoMIh6nICpPfSIG27RD2ZM0B4ejmlQNCPT0yzbl?=
 =?us-ascii?Q?9vqgqIJLTNgYd5EJCPHm6mlZBco10Q+vs3/FINIJK63+hyGhGeo0lyTYA2wc?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ntst0crKiE5eSTvwlB+O5cVZwL9Cm3mahH+pEatQc6ifxzUdeu5v8DOLAlqu2m4DTnNPEY5p/IiXerdE+JOdLAdD5kYc/tOysilv7iRh5KP+QW3HrzQmxKE01Tr9m9ujqYN48YVwD+BTsIZLyUyN/h4E6aUdCknGuuc6m3POPZc7TGy8FvuBDAwcAZbE4w5VuomblFLA7zVzInO5fqlXxVAd8NyGG8p5Ym78hsrxEUl4OO2IOw9eaW0BZYH535AN6gzHgwLk01ZlX+DxWhA2R4xcExtGmVreMp3JSMgmsUdi2kIumvcj4yEsm4uBFV3RvKKTlnGqbACRynkD9HViTQ1SID/+4bdzHS9PXUbuh0mkO2VyI6+Lcsuzhq0d+kI3+HG0a60VEoI8j2JvP1yYTNAkf+u8mmkan//BOwpLqwMm1BjNOc2L2c/vxt38Hl+LOG9PrUOPNTvzQtrvp/O+B2nUcBppa/lmutQM5MDSkHFai+Xps32LgtTEDAmUx9ygu58md3o2wkmiPVpKZhMVGzXD+a65mUwaC2jwCrv+uTT5nTr7x42IzCNgEvBL14P3U/rdKW/5JazoVjcl5Dt4sVKcNAI1u3KwCcztrSAp3Iw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a095e3-64f2-443a-7864-08dd971722ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:52:57.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljXiMao5tc4woHaMFsEwI4Zi0nlW9hnhc7gw8RcXcHd0SkALsSMnsBonX3rP//8XXw1Hf/g1PnRqPY1SaoGF5LHXa0JZo73j0HvmGsE/2VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=986
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190194
X-Proofpoint-GUID: g-0men2GorQGtP4Jmu14qyAsmclOuFgv
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b9a41 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=dtEIkGSy9B9qLBsKTCUA:9 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: g-0men2GorQGtP4Jmu14qyAsmclOuFgv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5NCBTYWx0ZWRfXyKkjO9dsZ36J xzzsWEI6I+B8KwUAWqOUgubYXP3AI4mJcy71x4q/ogKNUxp4GHLWZNQQHN4WhMOc1BR2A/j781c 29tX3wwXjqcK9hX5VNQcV+RlFcofQQdAgljHdJeE4X8h06fvBO9RiTA1dSAG22qmR/eTCq+KzJ5
 BtC/NBw/Iq5kvX5clTJgaacwX+xGQieXzIqUvKBJ3I2piIBmFYR7ow/B08Hcb6EbCfviepEQlTX owustoZU9a8U3jZGU9ORctDWGL9Bi6h0d8RCBxJAwZ91+SKMIf9m6Fc+uQiLh5TA8nLBCr1TSJq N3bLk7IIX4eSjvNLoY+qz9W/K6X8uJzMNYOEQQ82I7WvP45Va+kWSJuY88jckuym73JBj+5XYF2
 2TxwqBaRANDQVvW1RKLNvMqJL6djdpPbL6kxT9opewmIO/Q3GMwb10ruQ9/5NoPTRwuYZE88

REVIEWERS NOTES:
================

This is a VERY EARLY version of the idea, it's relatively untested, and I'm
'putting it out there' for feedback. Any serious version of this will add a
bunch of self-tests to assert correct behaviour and I will more carefully
confirm everything's working.

This is based on discussion arising from Usama's series [0], SJ's input on
the thread around process_madvise() behaviour [1] (and a subsequent
response by me [2]) and prior discussion about a new madvise() interface
[3].

[0]: https://lore.kernel.org/linux-mm/20250515133519.2779639-1-usamaarif642@gmail.com/
[1]: https://lore.kernel.org/linux-mm/20250517162048.36347-1-sj@kernel.org/
[2]: https://lore.kernel.org/linux-mm/e3ba284c-3cb1-42c1-a0ba-9c59374d0541@lucifer.local/
[3]: https://lore.kernel.org/linux-mm/c390dd7e-0770-4d29-bb0e-f410ff6678e3@lucifer.local/

================

Currently, we are rather restricted in how madvise() operations
proceed. While effort has been put in to expanding what process_madvise()
can do (that is - unrestricted application of advice to the local process
alongside recent improvements on the efficiency of TLB operations over
these batvches), we are still constrained by existing madvise() limitations
and default behaviours.

This series makes use of the currently unused flags field in
process_madvise() to provide more flexiblity.

It introduces four flags:

1. PMADV_SKIP_ERRORS

Currently, when an error arises applying advice in any individual VMA
(keeping in mind that a range specified to madvise() or as part of the
iovec passed to process_madvise()), the operation stops where it is and
returns an error.

This might not be the desired behaviour of the user, who may wish instead
for the operation to be 'best effort'. By setting this flag, that behaviour
is obtained.

Since process_madvise() would trivially, if skipping errors, simply return
the input vector size, we instead return the number of entries in the
vector which completed successfully without error.

The PMADV_SKIP_ERRORS flag implicitly implies PMADV_NO_ERROR_ON_UNMAPPED.

2. PMADV_NO_ERROR_ON_UNMAPPED

Currently madvise() has the peculiar behaviour of, if the range specified
to it contains unmapped range(s), completing the full operation, but
ultimately returning -ENOMEM.

In the case of process_madvise(), this is fatal, as the operation will stop
immediately upon this occurring.

By setting PMADV_NO_ERROR_ON_UNMAPPED, the user can indicate that it wishes
unmapped areas to simply be entirely ignored.

3. PMADV_SET_FORK_EXEC_DEFAULT

It may be desirable for a user to specify that all VMAs mapped in a process
address space default to having an madvise() behaviour established by
default, in such a fashion as that this persists across fork/exec.

Since this is a very powerful option that would make no sense for many
advice modes, we explicitly only permit known-safe flags here (currently
MADV_HUGEPAGE and MADV_NOHUGEPAGE only).

4. PMADV_ENTIRE_ADDRESS_SPACE

It can be annoying, should a user wish to apply madvise() to all VMAs in an
address space, to have to add a singular large entry to the input iovec.

So provide sugar to permit this - PMADV_ENTIRE_ADDRESS_SPACE. If specified,
we expect the user to pass NULL and -1 to the vec and vlen parameters
respectively so they explicitly acknowledge that these will be ignored,
e.g.:

	process_madvise(PIDFD_SELF, NULL, -1, MADV_HUGEPAGE,
			PMADV_ENTIRE_ADDRESS_SPACE | PMADV_SKIP_ERRORS);

Usually a user ought to prefer setting PMADV_SKIP_ERRORS here as it may
well be the case that incompatible VMAs will be encountered that ought to
be skipped.

If this is not set, the PMADV_NO_ERROR_ON_UNMAPPED (which was otherwise
implicitly implied by PMADV_SKIP_ERRORS) ought to be set as of course, the
entire address space spans at least some gaps.

Lorenzo Stoakes (5):
  mm: madvise: refactor madvise_populate()
  mm/madvise: add PMADV_SKIP_ERRORS process_madvise() flag
  mm/madvise: add PMADV_NO_ERROR_ON_UNMAPPED process_madvise() flag
  mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT process_madvise() flag
  mm/madvise: add PMADV_ENTIRE_ADDRESS_SPACE process_madvise() flag

 include/uapi/asm-generic/mman-common.h |   6 +
 mm/madvise.c                           | 206 +++++++++++++++++++------
 2 files changed, 168 insertions(+), 44 deletions(-)

--
2.49.0

