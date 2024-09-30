Return-Path: <linux-arch+bounces-7496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9798A515
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAB02817D0
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1118FDBD;
	Mon, 30 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="kCviy5yK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="lzlxZN6Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9B518FDA3
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703005; cv=fail; b=K9aiiwUgjb9rOpwJEiZmau1G2oYyw1Ob7mfNllkeiR2O157WEhQSI3vblOhZ6uIYC1AEOW372EzdyLnrrOg+dhrZa45FLXgxib7H03x4MGmi65idDaecWyqt9t0+qWP3e7DDr+1Hh7dW9gg0vct+QojnfzISQgsRYESnbsbB3vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703005; c=relaxed/simple;
	bh=xivhX7aNbNGNQcqRTxIwIer/jFy70+PhapOQh6M46qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxVsrAnfFvC7n0brdiPEuxYNMUfqYr4/URpu8DfjEmhiiNrTdp5FGNtaptt5GPBWbAoWHljiqOsZRNov2dxABLWChXCPN4P4mFdECRXf+JjywTeLjeFR4YmNtt4d6Pdsrlqzgi/qrl/2bYD5WqbPtNaxkHw5BDyOydwlY+CAhH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=kCviy5yK; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=lzlxZN6Z reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 642D03361EB
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702747;
	bh=xivhX7aNbNGNQcqRTxIwIer/jFy70+PhapOQh6M46qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCviy5yKA4UVv0ofoWev6VuEGoyTS81PzBeCTn4gob5wfw/+YdoBpkdwyVod/3Nsx
	 VG8wnTdHBiKSDxeRC0+vFvp+pKvu10yBQQsAef8++QSl7+z2Y8/ArYDFikmIxij89z
	 nad1VLSz5sx3va+BqYAQ0v00LUd3g6cp1A8HCKq8=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id E691B33619F; Mon, 30 Sep
 2024 15:25:46 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011030.outbound.protection.outlook.com
 [40.93.76.30]) by fx405.security-mail.net (Postfix) with ESMTPS id
 8C58E33605D; Mon, 30 Sep 2024 15:25:45 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:44 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:44 +0000
X-Secumail-id: <30fe.66faa6d9.896c8.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHfA0i22CYlXjjFZT1SEyub8Pl5e1Z2K+a7x6SCXCvBTq0qO2xpwqet2FCAwNLerOGEj/Wf/Q+gdW8rrWdzLJtnxhv2f5s83PjbdDwKK83Td3fFUyEEz1gCBH9zoBgha8F+vW8H5uiolHD3ORH/GT6aRpNzrGLQdMqbRcHLinNsU9ik98K4nzpD58SY/OAn3XUwO1IuIx7rCQ6ipr3UtB/UPuFUZAykCijbldRo4Ug9fiAtjK0ySpZIAenxkPMYZg4ePdz3lOAlqVvE+TNP2LJ+CVxIFWmfjUi5M5neAYWrXIQvfq9NwF71C2Hvz4I7VhVey4MVbP7Vjl/9AVd/28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spCv/bR+JcqV2e5ucsninHEP0vTjsvoB2z1Gy5lijzQ=;
 b=mjtaMc1TdZCErvLD12CM2o79/5O4DTMubtRCW31X29rsX9kVDSWdI+RYp76JvL2+M0BiQvuVco4Msie/WgM1paLhiD+Ze0Ke5By6dRJBmHXbYXpKQWa/YCB8gg6YYiSRzJAqxZIZkEe7oCSIl+Z4pK6XZ4Kc/PqNJcYaNxMSO+DWaVpTevHOWYG1SqAK7eHXiHaFC9fQ6NdKUb9qNbyDGqUWAeRwbV5qwJYmpkTL0q73S6FN5GWA4RsQ0JemNcezddgWFIfIXbzFlvURUBQRAg9CJRvAuVR3ZtF6yVCmeJI7TtF49SQRAzaPEwND0st5bMgXkqSY+I6j1B1ioAKizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spCv/bR+JcqV2e5ucsninHEP0vTjsvoB2z1Gy5lijzQ=;
 b=lzlxZN6ZeTFxydFEoLG9kKSMEZOeqL+buoTkzlsIDfUlr/qyRl6VoF6qJTSRqZlOXlpk/hyqzWMhGhqHAVgCVAruvxB6d3eoF4pHkFtitbtQvgHTBSkUypAC4m0+bPDVuiW7YVEb2LfFp632kGHRbdWXmeKJSu9r5bktgMJum4ZQxdCjEYruYsrKqn/KGIyVSp3PPl5SU+dUULju+FHy3QwlMW+8GTRzOYau4xltLIMg+EtD/1EwlASfuyXq/ZjV3LIZJIk+vRbLPaCcNBs7UM3b1SNWHV4703XLRqg4ZUt2psye3W/w9XOKXNZC3QpKcUMRERqTw7XyjeuGuDIc7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v7 03/10] csky: Use generic IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:14 +0200
Message-ID: <20240930132321.2785718-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930132321.2785718-1-jvetter@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2707:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f2a20b-0370-4a4e-b431-08dce1536317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: jWnQmodSjNYcgyDfGJTdOgrfOpThpccJUXGWZPRKVHwu/ULby0YaZeVlrvMcguOjka6YJCA5F5td9tzQHgVq5xVHvAxNq+mJ2rX3LEtWPHPih65JqeRVCVhGmrL5WrgkkmNP4p4dBs+i/fPqUBysRidMcRG+WZRe/DqMe6z6sXOJpS+6sKHUJ+JZtvGU5A2jkf/47kJLjWJqd/KTvAyQQN60Tn0SVfKOcMlPychldwjjI4QyedlRT8FJtEU5pPePld7IXJE1IJtyDjH5L6WePrcRNrXapfb7twonFjq8EG5Ino7MhqpdtxRuUu0T3/8C19AhgpCVr4x8qiQhRSNSFKG10Xc+KSvyGG59bnVpjdyYIM/ku5jy5KvCr1tTZDzdT6b8oxMINjzHNhsYmdY/CwWP6TNC+WynjC+fYVb7pw4nTbDHhFHTOAq9bJL3zYRsdLdLJMY+ML3mtUaaq4Kc2zuGUWV97+TfsCkUAlSUE17i92TDPdOQam0Gz4ySgPZEMI2c+wbPCgzOxVO1eWvu1+7rNXom33Wfn+4X/SNcG3C0LriW3WN9rw5RN6BRHgya2ja5jX754xOV7OXfFaRSCPF2tFfzE9lALOmBY/0Shj76aqO6+WzicgHgeyamRSjqAqhX1jilSZfHlcelty17e+Y3Q8vy4IBAT1cBEi4E1x9NI1P35NIU5MbIc+Q0WjSRvq8Cly0UPBTVbFA0wpqP3Me1Feg/vns+m4yhWWj4Ta1NyB+i/G/RdgjhHbcTeR7THingoZq/fEHZ4c2rv2tAPMpO/SvBVTfwMGyJSiqXcCWJNfc03PD8mtD213/thEGhTU8V77holOolSl1F3OvW48HgaINFUX+WVvXsx5LqgHE3JZ83U1raHhdjdGYgXDU83i5x8CPJfVupc/+VqxRhQjo86HHUEaP8foA78qdcdR/8GTZFxicpuvj04vEeWR1z0WQ
 1sgKRUvHu0WkgpnVByLzcb382qXaVi1PtlrwMTZpkCl97s9N8jSoRjInObPOqGBDLiDAP9fXa/7wSrHCNaIAxz/wM2REMTdTN6v0T6htC2pMxw5M680ruMu2+5pn4h9U52+bfboSstZWT30p4KoLAcsTV7Vyv1CnknGz9sGYrtQ8zkYXahS3bxRdOoI/+CvDmDgOGcq0LDYqzJsyOIxnLb23jEiJGuj6Bs2niLhVmtIHGUvpR/pY/7xKMCyryBFD0Px+tM3l6vblbqmdu+wg8j4yMdxv/LNH5Ke2d1IpmAqgrdLuML8YMnOAD4QvRWGshz9bZC5e/5SstnBVWODpj1HCLlEQ7TTFaDynUhBwjS5S6c4gr8t5rG3Qc1Gjx0eJICKZRNqkQ2B/xAG1FTzsCpRvOpaXCxyB2+n7UjQSGuSRvPvwR1aRb+6KPR2Yu0F/4mhmA6/A5rly0AlXEkOeaE498BVy8F4/0VKR5EhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PPSm1gWspI7BRdT3pjWX/e4azN4QSaTanmPdBZABT4izVkL7nGJFNs3k7GFhl8Zs7HRljhLb0wtLJbOYh8/FU/biX5YqQDFw/jq2YjZZ9mXY59w1+IAbpG8pU/lV+Ks277JiuY0f136nt+roAf8zR/ZY/wo6ylFBGYN3/LDKP9nHj5xhCVrcAtbFomVRItq51VlsopaOTuucVTjryW8PzYUDCGWOtHGUVEUYJIFJcWNJJRDUigdbpgdQ0L48lwQBglDkueSAa7wMo7H3o83T75e3I/AAqM65ejBraCycUAAz+EBMBxfpO2Cuh7n8HIPs/22U+axym7JnfXdLIW/MPUbIE8hxW+mmi1PbXyGx2OvDFN7TI+mqVqPZ2NC2Gkv06LqADMvcE+xMoEEb1FhmB/fuQVtLUlsu0atgKCwgulMnRHVZhMpG2TVTlHTzZoiVx7nZxwg1xHKeaz+aLpZFIdtCkQiJoIwu3xxVu5FBGjTOg2ocqrn8n2Mugufh53xFKl0xJ1p5IPvtuvrQ1cO585792bri9bhGu2SWCmv10uxBDBnkBxyN15soVvhqLVhmMDstbyPIfQsj7JxNH3VsKEwh2yjbQVGp/YWB1v/TpQTCUSeMQwtykpFHCbFy8tWtl5F8lrheHUG+5cY31JVdUOJWSnPTkmyAHKw9y/bblP1vFrx/gPr9nJIFvQrGYY+dJhspN+3qEzLlehHDVlPUt3GMnBWAUTfMaA72uivaTjJ6JARCi0TupKws5pzhDp6NDNQRItGAAMzXhhmRgDYT5QmdGHq/gPiBZUepwNorR2ZGWR/1bQUMeSx3Pv7WxC3nLDIjxd/jPbf3CV2WTvIu74B8bfDtzjL6/c90YLJgQyR/L7/P9KZDvetegBzYZuc8xaLX/IUguNYnL5hXhzmI0gBZwnr3sabB7Ojtiz++o6Kwa0/t1WpbxFu1IAKLJBm0
 9bEcco6TwhzYV4AawD0mpZvKJzYPLWfd7tBpnEtHS55sLTdipf5Hzg8xPJCb2KNCVsYwBeSaV7/jVKz7z6gewdnBmmnSLXSJJL+4y7fKSZEC1mUcnvuSqHM1fRsNAj7tenTmzK5qCUxTNz3ZSn2a3qDgxBy6u/Kw9mybYOspfwcb0q8wDxMx2TlRUxTLcTS1q+18btlWHUNvODLiGUPM9PzzCzXd9pJR5nVI/3G96mW80xSpW1Pq4Ta/2NuQwi6UvJSMkn5R2nKcte3e6rh+gQKfJzMhVNkZEuohCJVvn5Yz7e8JgDTMyIBhL9ZnVOTgJOznKYrrCdv0DOmdqGeeKTKvHtCENp8nbRZEzPZL767PeL8tWFPdjCafyJC4yuPGlXcOe4zIJHawzUcxQvzD9G41kCseoIAn3ZyQ3hhnMsHDN7HgfhYKN2hIbp++Dc11xHUM+DB+fLXmGB9DfwQhPxgJPkB653LxNUwHwsP0SNmJBQIqHhAruIJJymJUSwEWjDjcQOSf62S7IFM/jGb0z9B5aM5ordGp080JRQRR7kdrxLUa7C5ivZHhDNQPKtH2VTYCnHwxhPFxDWLqwitAQSUFSo5j9sdKincewEMNsWZEKQVlja2Dg/1aN0GJ5MubGPl81aP9fYkFF6sOzIzOJg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f2a20b-0370-4a4e-b431-08dce1536317
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:44.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWpJie2WFzIpLduXQ4+Z3KOSsKmZN4Jy8UsWu8mbToXT19OOQ1/V7ATdPXoGrkftm/piV3w5pN0RfLsbO+QUjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the csky
processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- No changes
---
 arch/csky/include/asm/io.h | 11 -----
 arch/csky/kernel/Makefile  |  2 +-
 arch/csky/kernel/io.c      | 91 --------------------------------------
 3 files changed, 1 insertion(+), 103 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index 4725bb977b0f..ed53f0b47388 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -31,17 +31,6 @@
 #define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
 #endif
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t);
-extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
-extern void __memset_io(volatile void __iomem *, int, size_t);
-
-#define memset_io(c,v,l)        __memset_io((c),(v),(l))
-#define memcpy_fromio(a,c,l)    __memcpy_fromio((a),(c),(l))
-#define memcpy_toio(c,a,l)      __memcpy_toio((c),(a),(l))
-
 /*
  * I/O memory mapping functions.
  */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 8a868316b912..de1c3472e8f0 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -2,7 +2,7 @@
 extra-y := vmlinux.lds
 
 obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
-obj-y += power.o syscall.o syscall_table.o setup.o io.o
+obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
deleted file mode 100644
index 5883f13fa2b1..000000000000
--- a/arch/csky/kernel/io.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 4)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		*(u32 *)to = __raw_readl(from);
-		from += 4;
-		to += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 4)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(*(u32 *)from, to);
-		from += 4;
-		to += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u32 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(qc, dst);
-		dst += 4;
-		count -= 4;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






