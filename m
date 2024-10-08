Return-Path: <linux-arch+bounces-7814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BF69941BF
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3A028775E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98CF209F55;
	Tue,  8 Oct 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="lwpH5/TQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="S+ANc6NG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout34.security-mail.net (smtpout34.security-mail.net [85.31.212.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227C20899C
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374112; cv=fail; b=bQv0aSvMR8tNUMTYKmXxmSVQg/2IlP0VoTmYKIk79VopAY/jsh59Thmq0Fnbed9PDP9bX3Gc7SQEJavTzJPtE2fViFsXidy5fzaphwuwAPWAX58XlMNDoL09itAf7pTZu7SLOX5IQPDqBxiYD32RucUJXUQw0Zy3X6y9/oS0Uk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374112; c=relaxed/simple;
	bh=BKKWhz25faOWoQ6zroTQq7XupXuZc3xR2RH+nj77IvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psqQBUXIDtqLaORzit6wEZQ6bVa47PEUFmpGRapEsX+BEFu/tnJMKIejA+HZZ4Bw06uFET3lBIKr38i4/oP/fjyNbzECqFMk+1PgXT15IW7GPapIOzBQxTQ5szwxGk+yHrxi6mULmZAMHlHIzUi+JmOQN8k56rJcmOQ7N7+nWps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=lwpH5/TQ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=S+ANc6NG reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id 7BDF14BE98F
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373872;
	bh=BKKWhz25faOWoQ6zroTQq7XupXuZc3xR2RH+nj77IvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwpH5/TQFwmFNyUAynsg2Gsg54rjM+nqhOSegknO1O2xR+Yjoi7JmTZGb/Opur/2f
	 qCFhs/zPJeNODJgRm/KmhOdMthD7i7FUh7FBrH+wQCB51kmUiAdWu7fexmKa5m7uOg
	 DbCCSmKgzBkFN2wBKILsQ+2xrGNhb7Z7VyW0UAWE=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 437664BE98D; Tue, 08 Oct 2024 09:51:12 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx304.security-mail.net (Postfix) with ESMTPS id
 798864BE629; Tue, 08 Oct 2024 09:51:11 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:10 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:10 +0000
X-Secumail-id: <d04d.6704e46f.77b48.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+Vi19xWvd8MzDI+tobbF8SzJ/GXkNoqS2LeeR+1+lXKztETeGfw1Ou0zPuX0fekxcIHhfZCn7tIc5lHpfWpyS8PqGhHfInqwnAqbPX935y4lbJ/7tloXnFQ9gZ8ukt0gkWmmt7fRQDElT1lQzqWYNz9yCfQ7ULSQvVVPAF6UHbK6IjtO0qjm0cXOIBsoR4f6b2/TbAmawsTMqFjbeAIBArhvGz8u0X0i/Q7gosX1NMWYOFVa/WlqyjqlDArKannqGggUWU18GFLqQkD5cgbm3dMxbN26YNYN8D3AuP9F0oUr7eqWLHZdv+HJItkdPFGr7diRf0xfo31Y4oSw7Fp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF1Jl0/C1ySGsMy9onqxSouX9VKOHM2w2dB+P8E17EY=;
 b=id5m7FSKYF1y5yuXH28FYDHij/wdRjydkp/aKXkbRay1zl/jStP2uU61anr9KzxUepfSPtUmH8c7YWi20UF0sa/Sio7ugp18rkkuP/37HEta/je4nmVod771GRbzVUum6yuC6tphce+7uTqea8nT/yZsGNGWsuBxdxuH1OGVSW19RzL+UAqZptZjLpW3pL7MnclXu7joZJ/ibqIZJzYoaWFKq2VYHPvqbSjIRgBTNaraBhkalaI1WkHZPZ5gNFwYfWn4HvNAO41JMtEYzjx6pgITHAjMbJaBL0KckoANoH+LdnRFM8MUmLquNVF8OamRzdirwEvOmX4y/+d4Z1AckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF1Jl0/C1ySGsMy9onqxSouX9VKOHM2w2dB+P8E17EY=;
 b=S+ANc6NGIp3o4SWkpR7YiPyLGV+GNFCH9RH4t1vRTYus+ut7s9VZbmDR5hXRsaABIIgqzS8cwOdGFBMZtOHEKEusXuw2HM1pp3wQTy3+Yy05iRN+rg7u/towyIVSX2y54RovCrGl5j3SCoGiBPXxvgcpT9exxspyIKgJLcXyrPqnAVtI1bzPazhuo0GqycqdALxMmbuZhJy07di7I6eXMhQh/TBeUdtulxx3LCWd3NbBt9vTZVY3AmENiTSsikPUEpGXs0TTAxkGejXKo/IFYAeUzndh/UEUuOI1aWVYrlTXbYueZC8FOYk7PUJWHLx5IhHcl4KzkynUsk2+0J53SA==
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
 Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-sound@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v8 05/14] m68k: Align prototypes of IO memcpy/memset
Date: Tue,  8 Oct 2024 09:50:13 +0200
Message-ID: <20241008075023.3052370-6-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008075023.3052370-1-jvetter@kalrayinc.com>
References: <20241008075023.3052370-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR07CA0019.eurprd07.prod.outlook.com
 (2603:10a6:205:1::32) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2194:EE_
X-MS-Office365-Filtering-Correlation-Id: bda1260c-b31a-4324-78cf-08dce76df96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: ZqlVGUKmQACxEAnJNJvxLlHS69hIkk3f8Nhgj1Wgtr1Pxh6J9N/gBh3f+6Ghte/vrSmACGKjVccb4648/SWM7jWj6gRo8ZtvXbVpxbS15hvXNO/nI6gNOg3WMDkkwEkNVXcdG2YA/79TOurMBDB+mKN1208TpFFjceaGamR8zXBueDx64bxKiqVdpR8cqsJGaQCboKvlbCCp4CjB8TG3nSBF+R+e7YhAbfF9hG2vShGIYURtVrXfB5KkzsJ0QOhrbrz2/sQu3eUBixSZUSf2lGPe1troQLnFgqoY9UUBCcgu49ou728SCJX9AnjG8f36ll55SbAbdymISg9cS2EdTyjmP0iXibVYS9u4tOFU+ps1XbNCnWKsaoXnOOh8QvnvMeLPfSMmXGsDuZNWh7RPy9bosqG41UrFjfoEFhiyebkoQ8eV7LrMZxmT54QOxN8oCM/Zso3UBC440m0sUAmxLSCWJcJRxEh3z40GzLXbUwpstncM7PYcijtcaVeoRN6tiVAXFjXujw02msJn2YenK4yKNGgt/CVnVN8iRwMTTG3IQU380PP8ZhxkvwEJL7wpfxWZt0kYqg1x+/vpyV3FTa9HWDPcAXolIH33JiILdm+rYzAAcEFdMvIsk+Bsaj1Sm06hDqqwymLncyZ0ZbOza3iv2AluvMB4pxFyjer7GPoaI+OSXYXieiPMgpyf+a4tq46c1AfaFkhBFPoD/S9TkZr2A8GeyXNEh4ZGziW5t3jTDirxtd7NBo3PVmO6YeQXTxWMhZ5Xl4YJ8VBBK2hjm4e99AU4KIi2wbAZfIV4zrelzENOSB2L0V75YgrY5tU7eqf0BhGm/aWmMzd+PjJgXwRmPSMl1+fSyDucHWOrW8J6r4XJtDba+r8ReLZWeXuWZMJQ0Ia23kfLDOrg9pMiZTbANGOzXwt5y/8qOBiLCXos+l1VkZ3iaDD4qVTjUxud3yd
 JjD2k4xIClH6kDbl1Dpy00IQvnqm8/mT7ps+6V5lyZ0G9j93+JeAnpS6vOunyn/r+RmGoN+9f3OvSol+xylJT7f0BXen7R7Xv7aV2YWpU1sFJweLrIAKazrWJxNh3OSfEaPB4gL/QqLfv9hWrQ6WKRMuZmkwHp2EWie17uKU9KFu4p4gVQrsOaGKx2A/d7MABjp2BgAwV4pIrLjFQbjUGpc3diW0YiUt1lfXJzPaTkE8Bsocfcmx2usaM5QdYqj6KxVO05TaGMKJFfwhJbp9UrWWCCzS8ax34rAFCy1HnjbH8yAUNmnesaHYeJyGfSOf+JPuF+/2xy3l36e0bmlLoQMmS40gXV9WMrAkRazf77q3+3+nKT+0oFAkrEATCi9SJcjMg7rKRFqgMaxFuSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +7GwnP6xReRVsEkvTE1fMhZ6QEHzvFDTzYRYAZBWSZnSATDI+DEvCMOfNyrAk1tX2b9g8JgC9JLp5dmYEWD+FLXU0iG5d1Iemrg73KmL8slBPDgaT8P5X3zy6DIUF42bAoBpgnFkJqWaD13vHeUnebzBwRjC4SWLCqK5jt+Y01OjDZInpgSdnVWM/GqWwJvwXmGIKqg/yMzdUM2nElVW/8LkhQJdqVjDbd8RO2T0UAJl29wb6m0hyZInw6x/KPuDx0Xzx8AYibDeqWrV4b9BOrVashhyrSe4VY8jv+9hkngiL/ZQIXbtiNbZLwiLXN1iX2cMoVyLSE3wvswAjWww8TK6S4OjFPNvUZdkpZA/pjuqbxQTPbd2NezEawiwqnmiNfVIkQZYSweQaS1Nz1XNfQNl5ftdO4v7Td8yD95SkoPv5GC3nvTPvjwIJZArInCa4bkqzToGNrW1ETxcscp4PGZ9fwdOCXXtof8U2zuRlfStJL5kPJUrljisbp1EoyMAvGPdyCSL4zcm1X6V6PQrtiHfY5va7t41zxc3FFBPqnChKwZr5mFFb0vv4x4ui7+xD6uLRw/S+x2rEJY1111QdFzZuQfZVp5wDxEMC39UfiO88fPzoUmtDJRyOn+fLOyH7zfIQ4EqBpvHEekgF5ivq6BkCVsbXMeFjYciLDyXqoWi/Rll3InaYfAO8MPMvraAnC2vAsMfI7UaJdnLlQYcA3fY/ZcqO8KEOYJvKLKTdhsI1xE3GO708YNXO5raInToMoh3rMe8Tx+3SPALvcraijtAn4kUCztGgi8FuFVdQiXPGL6kjGrjefuODd+a+HMv1jMnMOVvfbuaJmUR9x0sVPPXT5LuSuKECpHu6I8HwBvqYAwpoZjbdi46iyy98sc4T8WzcAkA8/GCco/m9z87l4gH+ITlETusarZfNxx5A0r+ZnLbhxXcD4MNOESRSiks
 Thv7t0AY5MyCUdHJeV3PVAgqHFH6oB2s8BHGMT2OJlkzF6SefvbRLfz3r1Gdc1bKAF94KkvCRUT/jhAKeY5tToRg1ErhB0jNThQhDNkM6tVYxzb0LW0SVfiht80loureLr4IKL4248JmkwZif7yzXrYUzJJyvUtac3EbU1i/Bcy+n6WEEHbZ9tSQUie/cijmohvMCSoIM3QAF+RUhYzAch1RrSHhKOO2dbJ21nJSd+SV1KdEYfaqy2TCdf0dde3ULYeQ9Zol5Pqsm+hElJg295wPcpAQBBKkhhh0OICFjs4sA+JAQuGBOeMUhh4jdL63unFGSqrtwJM4DDoRwETCw84IXBAtrzO2L+K8O3tBgyaSkObntmQkphhydnnYTBNFqhtDn0CeMGSme5+23NHWsTZyRlIknDlAia/fexyPqMj5AksbO0cbbMZ37QJG/KohMFkqQ1PsjhAPkwF8GlKLQqfeH6brT9xd6HhmzxOPhlbXVI/OB0+jGVEfDlV3/9PrFOasnrJm+lYF12cQwm6qgRQ3vGEquGf91SSY7fDBDfvx7WiEwmd0WFuLR0RsmvgtT5hKIKh/usA6fZZL5rY+ET5W7EeZ60lGcGMoI97B+4nQf8IsdibakmtCaVvCDS2N
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda1260c-b31a-4324-78cf-08dce76df96e
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:10.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLOovuTCBByY61VxOmshHfg7ViNVTYOMuqaVtsJioU/0iVksGQQ6Abixbidgm1m2J+HgcJhI7YcufZGb/ktQ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- No changes
---
 arch/m68k/include/asm/kmap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index b778f015c917..e459f1911155 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -33,22 +33,22 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr,
 }
 
 #define memset_io memset_io
-static inline void memset_io(volatile void __iomem *addr, unsigned char val,
-			     int count)
+static inline void memset_io(volatile void __iomem *addr, int val,
+			     size_t count)
 {
 	__builtin_memset((void __force *) addr, val, count);
 }
 
 #define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
-				 int count)
+				 size_t count)
 {
 	__builtin_memcpy(dst, (void __force *) src, count);
 }
 
 #define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
-			       int count)
+			       size_t count)
 {
 	__builtin_memcpy((void __force *) dst, src, count);
 }
-- 
2.34.1






