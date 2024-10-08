Return-Path: <linux-arch+bounces-7803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3799414B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE2282385
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E321B1E0DEB;
	Tue,  8 Oct 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="W7Kmp5UM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="IG98X5sJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C391E0DCE
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373879; cv=fail; b=b8l9NmVlba1R3hdqPoMa43GCgnOE9zaaiLGZ7qoIJcpRJfyFObXWOa3zTOjXR0/B2JGa6FxAQzMALzgjuTqM0mjpvqcI0cgPVHim6LIYxDj1ob7AUWh0Gjdp8C/6XM9INGWqy4f6dcgsepXhuHaTdQ54+D6LYtcSBoIU0zFpuCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373879; c=relaxed/simple;
	bh=LYivk9CW+Nsc832uCfDcNGxjlnPymTiNja7AZMBw8+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRJuu3sfuzEPu0QfrueKvpKtOGJPwxs7jZz8qo/JGsIskk9CcSE/EqVSKR5/lDrhOqF7upoAoj9Y3Xjwm8kNN/grs2x38X0Xm25a1MwscVW3CG8RldcUVWT6Q+jG7Nlrk0kEie49PJ0rEdsydgFNj42395BSaXzg9b1GTWPRYtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=W7Kmp5UM; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=IG98X5sJ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id C0FDD322EBA
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373870;
	bh=LYivk9CW+Nsc832uCfDcNGxjlnPymTiNja7AZMBw8+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W7Kmp5UMtNTKwtL8nxXKVcrY0+LjqPSHqo85MB6TTZBj4oSlh5U7AWyNdJTJPy/c5
	 JXWk++vZSKOvHu1euZA9gKZ4Sw6TRgNky9HA9S/r5vb3NDoOFQWViQid+7jHBwriy9
	 DDDkrwAUbJ0vfI89Zz9Y4AcrFeexAVOggxmgDLAA=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 4E39C322B46; Tue, 08 Oct
 2024 09:51:10 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010004.outbound.protection.outlook.com
 [40.93.76.4]) by fx408.security-mail.net (Postfix) with ESMTPS id
 98AC9322B26; Tue, 08 Oct 2024 09:51:07 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:06 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:06 +0000
X-Secumail-id: <7633.6704e46b.97503.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OButzswDsjyOfitLrmYmsdnDdBsd6rLH5BrfbngRZbACZNRCdwlKrPAw/M3Lgs1wuhGcqYHXwulQ4WNAB33smd98/XJmnKawrif3SemcT13tWjyVnnG91ZwmTJglBF76QATs9pnnN4JuGLoaebNQR00EOO+1V3zcXx4S+f7wLQBwe/cT6LVAXG1+qxkQTLaLRxi/jmBGidNVvMIC5VtQMl2Cy7BbZPO7//dAeQwuuOL1V3lAGj2YwbiMVFngWGEFJS/O8yymF7B5rzE1Kpj3SXUR3hILSeMgh5ZkVa6k0kwO3ra1g46Hkzfo1ml8bHnlkapNQeQoDwJur5Q1fxu0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZFVOS3KT6KCXlOD3A7zZJ7JauWX6wsLvFhd/x3nNuc=;
 b=kBprZjz9EyZp3JpO3aAsIOhVVS6/cXrsvu1+4s4pEt1W0YKIXaL8Qx+m1Qtv/dqKAMmQ7LNGDvT3AbEqXezmd8ADvXQvuMlgzsMsrwJg9RMA9Mbtr3HyEW8bQVjTvA+MhsyMn6oHx61sIDNvRyv/5uvq9X3MtdLwLni/XALRTdg3ZEsiL5nCA4VBnTtBFxIePdKx+K14JaUYLdS/EwlZOxRm5HBeJrsPkav13YeiFr3vGRQgZ7WT79zGmh5+mS7EhrvVlrTKFeZkCADLKp3s4AtBxioOoChU2Cit1/EE9g2tXceZhWL8K7UNdv+WEyMCM2lBlIBFrinQHHohwVWZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZFVOS3KT6KCXlOD3A7zZJ7JauWX6wsLvFhd/x3nNuc=;
 b=IG98X5sJ8gHn6qkPiCwnKIwwxt2f2h8kA+TJs5gUc7Do+gXt1HKM1G/zYzxfb7n8lECXLF6JFBsJw8Y+z8z/d887jnfQs+oOO1h1yKbQ12sLBwNg3ekPDlPPPSD6xz1P8ZMKkM0YApEzw5tLvN/BBWpUVPKuGpayPDO8XQWjFvHD8Jw2sERxMsS1l6C184JmHRDILbWds/pQMltP3LF14FRYSGqJJG6e274cveX8x3cyFjwDeLZsR8yyUvqoKgQPjafXQIDzRpSUaiYQA9lBdUUJdmPbg0GgpU/nRdUJzbP2vT7ur1AHnWo1L6BwC2eMg65KuV+9MPIBo8T1OSt6MQ==
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
Subject: [PATCH v8 03/14] csky: Use generic IO memcpy/memset
Date: Tue,  8 Oct 2024 09:50:11 +0200
Message-ID: <20241008075023.3052370-4-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ead3207-16af-4e2c-62e4-08dce76df714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: ArvDbCn9Bkbz4mELP7GtMQkcJ+xSzXird1PXUqcufOspjz8m7lJcOjW60rBR+PQ0eEXNmyepcvezlaFHYJCNxXpWG/NUqX9HwEfNW88gr2quB37NFjd/dDyTt7H2VLymXDYk9IrNgBiZ7VyqTF0+HIVDK6bP1qny+qemX8LBiWGjMUKgo58S2681qNf33yEpHE23HnBgC8pEVX9qCG1NE8Ag76keMOkXBOVrgGPQ6HTdU+SqmAGL9QWTS4ZbMNL0bhoBXZEzLamuawt1F49XMiV/ZD706Ji97STrdWT93DgLEqz6lQSjQJBEVpp9Hg1aCvXF2dTi6NnBIbWNkA8l5sKQs9ypJGGWOAKa+O2WJh1hF3nmtblzZ4bmatHeIXOkRuvqJfXNuX6SqwE/rtjR6Jx4qcJnnWrzL8MHsvYxIt785xVczQzTTnmWRNj6VOuuRJndDbwQiaN/BBPI5zZnxIw/MPkXCTXcyE8NtBHQjzYfxq8oOqWuX4uLVqhGdBDbU5JlC7+ye7bY+2Dayqpwgp1DOqc1yAo8R44CqTEJKiYAkX0LM008ZrKLgx1SE5csz3Rq1U5pXHFFfWhkOPgQl2vUBwl6PHZOTfWQSPwE5WATFoHL4ro9bWsB2VisBXNjM/SMbexom76ASA1ckwZkCRGvsmeKsim9QSXRrBMB3G3vhEtpxEDXEMQE/OIzCdj0AC/8VCsT72pRWiUz+E/aZ+zXXWahLzcEo+PpOGefB/XmvKqa5dkGKwKaq22yBnD53CUYl+yHyp7Tf/SyoOtfCzXR2pCRAoZ+S1FxHUPYmBVU53LJNRhI2WUpbFZ8xC6TTG0b+J624lSup643oWa/9iLk8hXR/t3sUWrNBuQKgmr78Shq7YRYQF0NzZJMttBuqM0jVTZoH4kQ1ncf6Nno+5q/fhiQJOcBqpmX0VaKNThD0YueS3GrVqIReey58BV37Uj
 9zjE56KnL0KxQqiuJN3iJ+HEDo4HR5+x658Ans/mO2TawCQmWjw4FySdnXma6G5Qgm3V2CPzgEHNlsgpTQZVJ1qqECyHv5EjeAJI1ThWIKgcLh8cHA0rBGmPIeWLmskHqFqf3ZeUi6Z2hXcwNzUkjP6AXhvgt7+ztEUvIvBAEE2lQDKsMQai6UvxhjnoWWjW7AGks7lQ1K+s3V5+EglHzUbYhWGI4uAIB27hNX0dOmokIgfjJZiLRJnCoqKn6/9BBXcALEPvY6df1NhrgiBNlwIeoAO8NrgF90vC5eL9vHrXuNzuibm3hiAq5hNjOiGG6s9nXae3Kiv5mUzxOSNwCalSk9ikHO5YkVeF4SrniSRpGjhfX7TbBxEq2Q/WBXX98tyOiSmjWWnpqYlFiACZAO90Hb+bOtJ1ieS+IIug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nc1THfgcMwuXx1LCnZ82WagFDR4TrcXSaoFzXmNOoX5+rmw5FwBm9MvNywD4IScID9cF4zYi73vQ1WeKUbbu0Y5+FeICBVBeBSxMZ8eRlF3R49bpQYScpEbzl6bgUf6bm+tPbOWP9+RDV5DFsjkdD9itTWm5wcFWdcDbLW+lKwb2L4VOfKid+6SUaMvJeuV37sMbh5TTtocp9rLlLMMV+gW5noB1kSsBuAhVVJrj9yIBkI3Gfvdn9Achgr+1AxozUKrmlYkf/sl1Snn8qX6mukLM/UWE0ITYTiyxQ4V74oRqnCvTFPyLnvPfYvdmJOjRi7nOfmpK5uNmVb39KbjWs9wA0kCyDczEUraGAojnwuW/NFJgxNJ9BNCsonXzvYGMYwkR5VPk8ro5/FRSqrwddA3ww3lUVcQzzzkWvL7x7FZrpWLbTdtP5Suvms+n1OyU5+oT3ivgKlW+pHShxvuNNB2fgEzlYEBT2/NCtVMiD62BKZuPK/Ac1I6sn0k41nWt4T6EvgJzdcXHDhKyn1dh+1C5GWL3iCTEJnPmuxSgsXWrXvHOkcjxVe+teotuJHybxfGmx2KIVVk9Zqf1wipCEknYtAGw1oigsL7VQXQmjdpeI2z1I5hrjYh61ctDVvqdNmZwBDPMo8W/3f2LDSaccB2fse8nxWPaJa5BXsgGC6WWwj80JJwiMXs4YNEX5sABrL0mXgMRmEZmRPEX528pAXkI1GznkGg5L1nBPRSjl7d9zfbhOeoSxEnm2yHK4U2bGPosh/eTA3LYE3COHDDppTLrLnZzMHzpcu/8RKsswnkn4K3g2mwOQU9nNvLkK2FXOOTiSKWlC74e7JCt2FyC7lX1SXK/7j7IjJJ+FAkLQOOB7Js8ZYBjdP30oqpBOcRgrQHMZ9hH1UYiqpxJsnzQdkYboUtWjKG+69dGsFPtCRip5ForwakUQrUArK5L/ZEW
 ACoBKA03QtJYSmhMydEV63R80irXYmoDSRi/fUlQScRMzInUeoqHDKuPCOHXqtb3wtQjA6m5921w3VZSDRCGIEPQV93wfbmbzOa8yEVsG22xlNfrEnbzyzupY2Jmbn9cyF0d43Vci71DlKT97QuWo9sHuPHuAcKJtilY1bDtApwN+erCVajb3RzWFKIjKGsalQ2BGQKiu5+kB/jSe0XThuFgT5i58biJyfSgZ0Gb717M2pV6PHUF5/0ONkFOlj5q36Ldta755K/p529XTkdR5CWXZLhm9DJs7FVzJ/OqRahTlWwlSBYgKT997EE7eS26SmbKmEyf0R0cvv+PMYO16Su9kpj+eEFH2gYTErZz9BSdE5aqOw3WSPACrKExxEX9o7zN4bfUJqRGPKlgdXYw1AP+LcgqWswcIVFHVQUZckzMVMCr6q63w9iiYhlGH28OWTgYRrmGAd8TjsrYcFgfTL0ovjq0gIWE3ajveB5XeHDmrzwy+F+kRJ7sf8uslS3KKaszZDjTyu6/MPO8PK+0dUeLcc3MctTXhdRS7RK5zDuF8mUgEhEc6LarqWPU0BHua77nRDVrmsTI3O4cvB0Jxvji96Cpn1zMZqU3eKB7PGRKTNaFDEv2c2j8LKKd+Vj1
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ead3207-16af-4e2c-62e4-08dce76df714
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:06.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feilWmrlYcZFlfo/olYQE2ZBgR4Psw29H8i+pJrcd1mga3NAOkg+HykIO1oP+QwBt6GGPSkSrahjZDMm4o87Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the csky
processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
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






