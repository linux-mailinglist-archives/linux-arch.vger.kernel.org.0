Return-Path: <linux-arch+bounces-7804-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1360994150
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590DA1F29A37
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63031E0DF3;
	Tue,  8 Oct 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="kIO+/MvD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="uv/zJqar"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220A1E0DD9
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373880; cv=fail; b=K3A3X4pI4rONQ8nsS/bvMnCsoRVefeOBeyMmEgR3WULQmAZTeh9TgDWKZ42utkCOZqKv7RoR0Kli6aLo0QerRNJeyfA/PUM2hHGMihnSKRgnH2iWOaeDnBjdlrMpwv1eTX1NXkuuMpEsk72KD0qK0OyR/waIwa9mxU8cEaZcTJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373880; c=relaxed/simple;
	bh=fzQCNF0Lt4UZeQy5Do66xXOMsFtRMkQ0EHm3X/BIOeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zzy5wN4ps7MAwHU1ZvxNiQMGbbIMgIr3aZHhBBwesXrT0kFn3ft4SjU3jZmDToaY8dv1/AR7132BCmtPYjGSitzgp264K+Huhp8jqfAFOHLYfAA0UhNeQ808VVLvLgNcucBa4FhaYRyaADTsbP6DOLNMSvApJf5gKIevJypVfBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=kIO+/MvD; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=uv/zJqar reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 853CA322F5C
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373876;
	bh=fzQCNF0Lt4UZeQy5Do66xXOMsFtRMkQ0EHm3X/BIOeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIO+/MvDZhVhbYmHnx4l27Xu8y4/Ekyh3JHMZI9i5UjvY3VLD0Azg3SeTG4vsNEGf
	 lOVCQFUeqNetdH7OIzamIK9m49CEvt7mWMBCEZQBH1Dm7FvH6OgBbrJ2cqPQ8daeAe
	 KP+bGkCXomHW3sKMuiQLkrPGi1eTCN5P9bLBNbC0=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 1CFA6322F15; Tue, 08 Oct
 2024 09:51:16 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010000.outbound.protection.outlook.com
 [40.93.76.0]) by fx408.security-mail.net (Postfix) with ESMTPS id
 99A7C322B79; Tue, 08 Oct 2024 09:51:09 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:08 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:08 +0000
X-Secumail-id: <421e.6704e46d.97145.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym5ILoNTihUfaok5xbEgrRB7vJ/CNd2wJyEsB39+vINPKMAeRuxdnCpJWVbl69r2mp2UzTwqD3ny13MxQRp6m9FVDeJbgCuYGDI33pezdJE/22PM0Co4wYOfVzYCwbHYKNtckrvCDlb2Y0uQcyFqJG2O5l9pNkoU+jyi5pAGYilNGrLpUA8UMmHZpbNhZ2nu/HbuRaLH3+rjnudI3QA8/YMHZOo0qv8ZAtxcDWInKD3b78asYkT08MgjiAnWNYtGP/c+dPXpjYUJvcnt+n5/EbK+Z9Qhc0ahckHPWnevnOz/kAhAxIN/mV7npj/Zr+8aKKKmj0G6indN9GuU7DOzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUJ1k5oY+MTFeWx/GNGErT3hEOFZaQgoN/v87RIJaQI=;
 b=EscJuzxLfcZy74Ghqtff/6ZLTU34T08RWAvTHUlY95mtRN8eLDrwDQGN/TroGWsnbDRjhiQ42ZHp8mg9y1FNavg2UtFdexFfz3okEKXv4/j8A1ORQ+odQPICCW6+CGztwpoJsr/hRGLHtHbKinbGkJ6O1QqAm/uOz9LJW5LIZeTveRKUR9UEd/eHDP3ZDBu1hHsyllYcQGaIpiGEqLpSYIWsNYHRsXL06ZyDPe5xGdpCjKu++EHte9lsJTtuHmJlsQqkj9Ztqz1SaQs7w2ioZpT0IZq0K0uFdDj/eVVYgnDaDXJyRv6ualKsqmBPcOdcHv0OXOyDFQr5osZxP8xf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUJ1k5oY+MTFeWx/GNGErT3hEOFZaQgoN/v87RIJaQI=;
 b=uv/zJqarCO4O0uz8vPOuCCVLfkGPqESd47Y0KaDw/fBZYymvfqDjmYT7lNX40fuZpcMPkC+Ze7X2eJevVU2iK+WrWEhVG4RHbU/iaQBOLB1vuCUOXk3mVY5hyfV7N+X0uu+/gCYtOUkC31qc4gbrrRS2TTwjn5RTbS64d4v7Cu218WJU51YP3rHPf/GDf+P4/C7yiDsrpqa9mEgnrUazY6TT/8dcVmfKAUaCqMRAXWb/VKdMofdEuYRqXV/kbnB8CNRnyUTOwse50ym9DHG8I6axNw4eNsP2kJd5FKVqsshlz0Ot2tt7MrGNtV3YPJeZzcalyAPebBU2LGz4rlonQg==
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
Subject: [PATCH v8 04/14] loongarch: Use generic IO memcpy/memset
Date: Tue,  8 Oct 2024 09:50:12 +0200
Message-ID: <20241008075023.3052370-5-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcf75996-7c02-4517-e27f-08dce76df84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: sNyrTNPsnMfMF/I+9jaQtv6LWD2nmieqhz71XKuyCKIggYosvFvt6lCQOoiPPcZlPoVItU5mCBQcalLkqbXHYbiF9StTeFaCc7Xz1HjzkXBju9Mtj/5zTzMFbn9X4bgqJeXQtsTOfiJLKS//g7JfXR41lUgAWkvddpP991z5/4Ncs9wd5vGxx519UgTvmDGMcA0rPaJp/+B5A/z+8qBXTG8XaurJzGSe/cWlFaixvzefArMguSfq4aq67xLQtDWS/XxRm1ahnm0ArgqZB/qaqSMM9NcnQLCFoDq3GmaxTI8g8jc4ck+sbY/h16W93lTnV59cuEL1u5hOq/fVOZrXKDqTvcw0QbL/lUHA6Mr8xzHnze3I2iUUa5KQp/pOE4f7dXj4MMrowxinzw/vgqOYJro2q1oS6f742eiXm3c1KQmzoGnF9g4H9Kka9oTqdwXTa1fVi6GI2bXImxvHxUQsVcFs7cjYHM+3LS9vza9yAew0KAa1ukFU3sjyjrTQ7SGT5nbiAcDdg1voNKIkQVdo+J6s++qg7sDiwkNGvCZitU96wTtPjrC2Hk18dQet1VR43YMmjR3Uq4rLOy3ciafAEjpv2UoUreu3uXO/KReQpxdhT/Df20byPIHjL5Jc6VvR3n0miuzrnrzxdq2h0w6LWbAztL9+QvybyzNkvhPC+cXSSq+u9s4HgdkU+XpHV/dRe5IkMFM9n5TXmIRzYRM75rXj9FuVTFNuq4JakSuxJnd2DP5rfGJuE/pCuW52HbbVvz+/1wKRAAcVbXFmHEQFYqW3O7V2TLZytXuFFywPRJvpbSnov33DP3x0BaFRCSnb6s21fOdXEp9WqU0d8zndOeS+pRQyb/y8Yfrl5gaVPx3fn8wR7fyimSriyzAXZgg4tufJPKy7rkW3ryh7HYpl3LBzZNBU5YeEhJaKrEeKAil4/4yu5NRhSpHL91YNqIlZRlI
 V0YzyDWgjfZ7Shnwh+F4d0yISv5IDC8DvEk5o22yDqkkL9dV3rrtvE2C5t3k+HYjwFiLQ9Ygm+kaOoQzvrSlxMsZAAlZhf5l/EV915/fyRCuG6WFfH/JHfFVcgJonAAdAt6B6athkJm5F8iynARWOKjHPJtqjTZoF1Ij/DP82DqLdA4g/CVHkx5KY5+ymLbUdAbnV4HhWD4oUZ2zVe1ciVsWK37qjYvSNk+kxZLN+BFvchgHEWmqPi+vEca3bANZ6Ovh/USsGUIbDZpY7MxSYw8ibzsYbeJBR41Gb/Vq+CyGRltPeH8yzej7yZou16yl2ibBaL3Zkq1IHEnUEdLnNAQ3WxcF+eAaE1L4zr6CxTfteQ/+QDfcMI5Zh4vNNQd3m4PzQau2std/7taQniBeOJGM3uSZtSAA1Bql5FMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecO91dWjag5DnGC34pzeZlbo+5QvqV9Kpn42Z8OntV1yDIqa7LviCkdt4M//YvVYChKqGh1bUPfXeDOiVQbx3GkHaIgkMIYiABBN++nxC58nOM7/EAPAgG5m7V2oXyCYOtiE2ZLFGJYb98X8So7qNI14JGauV5YZSd1u2h5+41pdTFs4VPNmJjXTLpPCjIMPs8ww8TFvC+OMM51ZCjr9HOQXtEiuUQ1UzjakhRhFfTL/3YjNm6AWtVFFcG+RJK3FcLiR1aF73T0JOCnNEi3d71iPe800uHmsIuqPHkxGCV0w+aKCehMSOemMCyfgQz3uvFipMUkDGzSJwmXgUcQqqEF6P5xiBZbdZcVpZyb4A+u/InMoqUZd7OUefK0IA+kTmyBYy/kbR+KI5duVmdIRQbJHukNyyrUg3wjtRBaxkbEbJWwdvf4MzwN3XST0aGFml8CvcAPYpON1CIpwxyX6hj3O59TxRJFRcpBaIwx0sGK5pVbDXao40alGPiBbsIvhqx72xALEJ2LhVOP+VaJAVLEOipq78O07rTGdgIgVZsqYsoYhySIealw90gMbrdriCQMBsYOCOjpy0OdFdQvZ73/JyVZ7Fi4e6exYgAM1yaagPnOvXqjcVFygb/BRtqEPripn6tsGnKWbL0lI1cJHm0fvolvPhlWqDo4G8wmChvJa9tK0Ey/2/+NAJgX0zmAF7PqzyBPymQaQh2yOa1EIR/TtsACgWaukmExTLGgM7m1H+TJqehK5FZK2EKgCBusguLcu6oZJcVjGa0oOX9nHsTGQJWROUY5OwBgqbui5xcDuO5lvZhOca0IEDbLOVYmhEKTsOhbZWAgxgmG0R+gSpolDDtJ7P7kG7DsykPWMmKaTr7Wl0WDH8suxH61NG6LP1sGFzMHJ2ZzO6TXErfiT7QeJrbrK6ysP7ZceBZSdsIqSH68wYwiG/nCkbkb8b2ki
 6rmHMob0sItQLWCMxzSmglaZauxEjdsE5giD4HIWh5BkSj0u7Dv8yllFLspurKnBVtFgZJ2PbVUxtgFp+XRhYHqaYsSBPjJHtBIH9wjbLeYOVSKqB1vsHpgdxQw3E9KQfKdqIqS6+uE4Yur1gue6gdPkX3dzg06KfkPlYeGKkwm4DbQ2TcgsU3QtUhgz16Ws1lU1b0E+2ViaJgvOjKcT4lx0DYH2eDsl7E1eWSdRFv/UF/11VKuQJSps8n8evwmpjPHy5yocF7CsIwOD8c8A6lMJzA0Y9SadGmyIhBW6mqoXQzI6wsGdj0xjLU75hfPQ0RTero4Pyeo571mJDgo6Q8wOO/OlPdX1eIupcunh8mGictvyUi+iQ/UkA6t53BJIH8+/1ja+YKq5jdJRNpO+lmoXV1fQFVAWFa01dHbMGbMw6mZr0LppLn+RNuck9HaG6l5e9Ig8Lb3OjCJpD+cNFN0Auh4wPzaEvSGXJVQ0one/BUZIZCjlNoPoDG6NCC61giU2G1jXaWhSKz4PiHfyi27GK7PuuULO1sTp1ElXsWONhaNRxKjjndtSlnxBJTk/ED4t/RpQVgKLxzspwGv1vIWhRSnT3nf5/tiYVozof2JNm1r3zwswFE677WIt/6rQ
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf75996-7c02-4517-e27f-08dce76df84e
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:08.4462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69qyA24s0qUedgwfGgRxJE2pP7U4HZl5IXNQ44IkAOQ4oHcN++8iCBY3C6k5qCQVOZWmSyC15UFZ1Wlls51wIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- No changes
---
 arch/loongarch/include/asm/io.h | 10 ----
 arch/loongarch/kernel/Makefile  |  2 +-
 arch/loongarch/kernel/io.c      | 94 ---------------------------------
 3 files changed, 1 insertion(+), 105 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 5e95a60df180..e77a56eaf906 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -62,16 +62,6 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 
 #define mmiowb() wmb()
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
-extern void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
-extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
-#define memset_io(c, v, l)     __memset_io((c), (v), (l))
-#define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
-#define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
-
 #define __io_aw() mmiowb()
 
 #ifdef CONFIG_KFENCE
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..9497968ee158 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ OBJECT_FILES_NON_STANDARD_head.o := y
 extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
 		   alternative.o unwind.o
 
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
deleted file mode 100644
index cb85bda5a6ad..000000000000
--- a/arch/loongarch/kernel/io.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
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
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
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
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
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






