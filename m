Return-Path: <linux-arch+bounces-7802-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2976994146
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C625C1C266A7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709771E0DC2;
	Tue,  8 Oct 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="YJbeK/2R";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="jPZoGRUe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4D1E0DB2
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373876; cv=fail; b=WwQtghX1lIfrNe3Utj6JEsA66j7neIg9HCN1KzZMYLxHJ5kwE4rMIzA8Kk0v0QSZW+w39zcRcyc/JdnuDg4y0riSbFGbRr+F9z5qf68/NL1Y3N2eJzGpOrcAiMEzhH4cifUZII/IuLsJH+KAmrCoWsZr20rlRmORG5T75dTtdko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373876; c=relaxed/simple;
	bh=qYgORECpsAPINkRpB+tvYiLmWpZFPn9QHwCQlwVNjhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnYq1+RFIypNHLM7G65yeBPMzNvneOCpu+6fUoUPU3OYLPXl4iKkpMrlI56n0MXgursTgB/1XVA/XnD+yBMEVRZeTqns+FWiCigYnDw61yb0FwLbVmsmF+rMjBkhwrVG987lOMmKgnvw5OV1PJtogFkEVq9bUgc+UM/648/Uv04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=YJbeK/2R; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=jPZoGRUe reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 05F3A8A26F9
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373866;
	bh=qYgORECpsAPINkRpB+tvYiLmWpZFPn9QHwCQlwVNjhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJbeK/2RTLCnR9SbOVoC3PnK2ka0n9PF/SV9jr5If2IB4zV2diAVfztr2IPn94JNw
	 0t91OKy/XPqdVFJXTfFI6o0DJzxq18mYIz3rnxaGN1FzCKVdIwQ3HCOFDO3rzfmXVw
	 qxOWnNAmc9i3DKLYG3KKCphOSmWrF+ghXjoSkrJY=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 8CE6C8A215D; Tue, 08 Oct 2024 09:51:05 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx403.security-mail.net (Postfix) with ESMTPS id
 CFC508A2C45; Tue, 08 Oct 2024 09:51:03 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:02 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:02 +0000
X-Secumail-id: <909d.6704e467.cadb3.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7ZJAI1LqXRCsR4arfo7oF1MUgFn4CmzqcpfroFD5iVqV72A9G2OHWoZNdSMK1yJlgraMd6QBP9nYbcq/BwLvAgWb28Y3yflEB3kbtll4IF4xbJ5UFfNUwXWBkqY5z9nof66ABczmejsgS0GZWm/hyKrvMmFW3AODVGyH6QQpDWmmBP62mn0cf22g4GgsO+txsxspoZoQCBOrLjVC+42ye0738ewd2i4UBx/p93CypiKuLgsF0OJAV2XqAWDstIQP0k6ZN8vZzOXdP+PEZ2N2VjRISHOVSgevvgJm3eyY4udsDvHj/yErZC0dizxjQrpNWjh3yVzZzgTBK2lSpKR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WLyosKI1vJsY93JSmy9zHVqPowSKC/w+daogUuRq5Q=;
 b=YounfNzwIyM2zFPgVLysVIdclGTpTJaML2+wz0ljcJKCTbDqqGgF7STmDCOhoyhIFF0/kl1qJeltI1ZWGVH4Y5aLRA2BeQhzhTxckw1gCCFBjexjDVvFuwoPdD/E+7la1P6CSkt/qrZwNSCfJeUbkh0DsGpqZgaG+jd7b7N7NFy/gX29YOPzsh7O4hm7+mO2axYG8cWcDFsDkgqGSHwfKc93+0IOv96CjdFM7tK16kE9ayjXtLcK9zoz9G0H1QdRvWONdUjGasWsOjht+qiEw3o6oo0RR0F4nHJHF4R+1vC+dfl/XsRrA+9B4bMBz0vnHhvu1V0QkSjtmjcaVqv4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WLyosKI1vJsY93JSmy9zHVqPowSKC/w+daogUuRq5Q=;
 b=jPZoGRUeypOCsBz9xfYGcZQgKjUqEaRByoai34gblY8OP4qUEjnibIYcrM5BvQgxUcZFbJrdIsH+BpiMZatJwVK+LjU3vW4XCGOwQGmBmGENfScP00aIiC+cw7iBPBSrt4dF1wEHjkkqmEZgt8jFgAqb6LpZTaxAV9TCQvpnVIbhHGaJfl1lx8Ugz4iyN9blg2QfMBmLew7fVAq4DE/7QNH/Z/JUAIG5bhrexW6t438cwBcZvMt6JcfdiDCvRPGrDuHULbsy+H1I7zbEbbX69rdk3gRHYavf7LpjB3eSNOaWfczFdo1Z2lkEXhxbBGdEViAIttDAaRmSHy9XwjQ1/A==
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
Subject: [PATCH v8 01/14] Consolidate IO memcpy/memset into iomap_copy.c
Date: Tue,  8 Oct 2024 09:50:09 +0200
Message-ID: <20241008075023.3052370-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 589e05f5-fb13-4baf-8e89-08dce76df4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: qhXyR9A+Cq+BOKEJt3ErUwIrXfeO8nStfnCi/l4ZU4VlhLxJ0RE02Tee+90WVC8Jz2AAGoNY6ntvU2F2F4bAkBHwQchK1vP8jO7hCG05z3+Y3LEMl6gIOEZVxuAxKKiYWL1w3ADBAH8H+/1U7ylZKSaYpAn3aghYTpoETwfWWxFMiyxVhM/LSn1Emt9wRX6f2ULSpKi1MoCGsLn//wX7pyAeiDApHo3K7CXugKw+biV/o2iA2o3Tj70ak4ISFsS74XbD6wmqZUaquiWB6R3e1eVAg4V9Y2yRqBiTpEjrP6Opd5qlLJcGfoYF047eeuhWdREsR0MZdMpdHIIL3GiVwsfwsaDPCD3Oi9a4VupQLraiAlfGokmxz2nbCGYG4Lg3K8XonJOfR5uG0ddMjtELwdfe0NUEirg4e9m8D6lYG2kPkLGANILi3yAF7Ay7snmqDqPNdV6xEebY+BjAQGKPFRLNseVrNK4JKZWeNlsIgQscjxWBKtOIBF9TwDvIn6U/utuFt/kYoCytemoo4FRUBy5JQPSJ5t66l+J4eYvp9gjyLcuOVOK3yrgoUtdQPHXkhRzYxXlbXpyzRgQsYOwMFWYZoRWo6vc2fMjLg2QEx1RTLciayFC4YFfyXgHbyr3b9ryDPyjWieZleyPv5v6bphMk2zU2SbcSH+ZKzFqc0gj7FStLxYRkCoaVz1riwr1qYa8LLO0NFbaBzdJGBs1tEOkTdtFCa9TqZBVyoKFfveDwoQQ/ku6L2FLTIkH+U5ThvDmAcM6eYh1+FeUhhUAxWRO0PKxJSC7CKMzTm5y9gO41ztSgxidNu9CFN56vLofd7ik+dZopdtAK2WE5uwTNcWWJpl+uSDAEGL1T9SA8d+fDkQMgJo/owFFwmEzHT/Mlqmjz8uxJJwYoPdcKqa7TVfW458mLGbMI+XpDDRHgX4Oy1HW2RMrmmelpCg57NclVHLO
 hFesZyOmTyr4lw55xnqXipHKO+J0X0VEG6RqTI8zmuH5hmY1t6IiHA7+rNL9Slfp4dnzInHkifYXNF3Wfmv142oWbUdBCVgJhQmSTxepedkVM3fzsE9DzGQAr3sm1mAfpGNcq6JuXyVw1/C2aXlVIIrofSj3xyZybuUABQ4wWgM288LxUukDGtOSgyUSBXkQkyfMGCZjhOAs3jNS6qyBC+uaYfnffTtCA95VMRAZKcSoM5yCY29sQXhCY1LD5Q4jkPhSj4F2tYilTmBeZlSaLsxNsMwi/9ByKVc0kbhTfinKzzIgonELgysqFPOxX5U1iH2L4Kx/TQaOT8nRM10UACm/YdOcPFYLXs7lju7ONilapz5OlInEiNHGDXDN7Sep6gJC6xrUS+PXKLLaG6PwEz3crKu5BOdIHrjqnjb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: clkmmmurDL2ymrQG41DMapIjTBRl2tD0iE7lcrv2Jn9EPe3hWaFhLQmKAOzpP1EoB+k2kEP0Mt3XZEHezjtTGWf8PKniPshzPc+rp+XAwhWMF37h9E2tEumgEFkZeHXz7/XOFXsz2Bka3PUO9i6tcbJptEWZ5OAoLNoz4p/ypYLiR41WOuGBpNS6fFLRdgW+5vx3TI6+rvCrRrYP0Cg3dY9iEx4RWzk6QxHSP48YqAB2jq2ZlNJ6eIG6JMC6Ld6sTT2On7vOrZSxEiobYtZfkZOxuWyjE/EsGQge7+Q4PaUekrOHzTSv85I7ihm4rdP/5FXXFkFlCauaXzNhnhw0ZTEyXFoqvT8H9+aw+/rU7mXkKycx7z7IQOiUO/jGVAG5K3aXDriobEs5DFXnmkzIqKB0zjjtO+ECL7Yt24K9qY11VV6uPeXRZWMJhm6Fn7mJuWf+e4abSSZ6vWw7h/YvFXFNuZ2eKP1ZrreXjB15WXMMuj3fFZoa45l8NmhZHe5ThKPgGsH5zAiU59e/zRKx0HinxrhJse9OiEkvuR3Vdjj0BOx2cvFBDCPfmYW3u9Lma6Ue/XpeiRy3z0k4UojNk/iQCOAYTB/0s2cwRmG/Z2ONFO9hx6W1fD3/xsLFCSSh+t45rcBIZl0OqUlNUH3lytpezooPiw0Tri9ZJkUY6ivy8GY7nPsWXoCk9Aa+19b42brCHEyzFEdsRVmuBP5qZC/qtujqDZDZdd1q9NxE7tS4r4CnUwIuplpE0EOeKRbve8aH5eD1lj06dA6VHVFsVpgBjsDFO9IEY7pl8FuAvRzfijfcFUSXXjobPejLtcDtKR/9W71PNLL0bf2xpIZ6A43V6gLvPK9JDlXGSLnCWvwyijuaGFcdATgw9fI9TNT0Wtir6rHvwBvB3ZKV9FhvKLbIPtJWhRae1mEpKgxmahRJUm1y5W01ip655kno0sFo
 xDLl0SKAf1OwMfMaUWr5oAqe4TOQjFUldEM8j7fE7ho/XENKMGQPSPV/qNph2X+sZVUtjBpeD07Zq8BrSfqhSfuiRw1M4LzxI+WDY499mnZhGALWNF2BjODako+bbndqpPNAepqEO1nHnBo+YBcVVWK16rxoiVdEHkWjDtyR24K0wZDGOsblTOSvwMqu1EwKiPTcLeK6LHqnv333lKbezn81lhSBaVU7+0rScBAF/j6l57xhrVjw28dJqCMQEYkOfhMjXMi6vZW5yF+ptFCEFwxaH6yUS+o11CP8unOo1xSHNNLWMt+up5CXPHFLmNsxRGdJjrngY1uyRysmTbtY4tTmu0x1qW6SflShSpNylesC1TzoNMBY7kvERSlHXZeAV/8UFXwEdjsp1ZZ8nReM4HeTNcpp5DXACwKIcyNbbMPwGIt8IdaU766pg9pdIS9Rwdk6prxLjk/pVx/1rZ0Df9wrVdJNiuubN3snJQwtToduI/iqdAh7skOpJ0LXrMTrQZcG+WgwXPmx4EGBcjWpHRa5kv9N//c0P+2jeVp3U4Onzk384PIj8LSMmdaEQYLfl1l4MRip3lpvca5sZjSP3sqDLwfvc9yol5b/DbODt407HYO4OgUQTyAnt1KoaMC4
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e05f5-fb13-4baf-8e89-08dce76df4d6
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:02.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlkUGVh+xpm47i2Esk1yw7YGpqb8meKGV+9HfVszLhR4o66ZKbNd5jIpmaB7Y0rTcGBTI5oWROYO97SVwv3fMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
memcpy_{to,from}io and memset_io functions. So, consolidate them
into the existing lib/iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- Replaced shifts by 'qc *= ~0UL / 0xff'
- Modification in v6.12-rc2: Include 'linux/unaligned.h' instead of
  'asm/unaligned.h'
---
 include/asm-generic/io.h |  58 ++----------------
 lib/iomap_copy.c         | 127 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+), 52 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..f14655ed4d9d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -102,6 +102,12 @@ static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __i
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
+extern void memcpy_fromio(void *to, const volatile void __iomem *from,
+			  size_t count);
+extern void memcpy_toio(volatile void __iomem *to, const void *from,
+			size_t count);
+extern void memset_io(volatile void __iomem *dst, int c, size_t count);
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
@@ -1150,58 +1156,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 }
 #endif
 
-#ifndef memset_io
-#define memset_io memset_io
-/**
- * memset_io	Set a range of I/O memory to a constant value
- * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
- *
- * Set a range of I/O memory to a given value.
- */
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
-{
-	memset(__io_virt(addr), value, size);
-}
-#endif
-
-#ifndef memcpy_fromio
-#define memcpy_fromio memcpy_fromio
-/**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data from I/O memory.
- */
-static inline void memcpy_fromio(void *buffer,
-				 const volatile void __iomem *addr,
-				 size_t size)
-{
-	memcpy(buffer, __io_virt(addr), size);
-}
-#endif
-
-#ifndef memcpy_toio
-#define memcpy_toio memcpy_toio
-/**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data to I/O memory.
- */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-			       size_t size)
-{
-	memcpy(__io_virt(addr), buffer, size);
-}
-#endif
-
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif /* __KERNEL__ */
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 2fd5712fb7c0..175d6930c293 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -3,8 +3,11 @@
  * Copyright 2006 PathScale, Inc.  All Rights Reserved.
  */
 
+#include <linux/align.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
 
 /**
  * __iowrite32_copy - copy data to MMIO space, in 32-bit units
@@ -76,3 +79,127 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 }
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
 #endif
+
+#ifndef memcpy_fromio
+/**
+ * memcpy_fromio	Copy a block of data from I/O memory
+ * @to:			The (RAM) destination for the copy
+ * @from:		The (I/O memory) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data from I/O memory.
+ */
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)from, sizeof(long))) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		long val = __raw_readq(from);
+#else
+		long val = __raw_readl(from);
+#endif
+		put_unaligned(val, (long *)to);
+
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_fromio);
+#endif
+
+#ifndef memcpy_toio
+/**
+ * memcpy_toio		Copy a block of data into I/O memory
+ * @to:			The (I/O memory) destination for the copy
+ * @from:		The (RAM) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data to I/O memory.
+ */
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)to, sizeof(long))) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+		long val = get_unaligned((long *)from);
+#ifdef CONFIG_64BIT
+		__raw_writeq(val, to);
+#else
+		__raw_writel(val, to);
+#endif
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_toio);
+#endif
+
+#ifndef memset_io
+/**
+ * memset_io		Set a range of I/O memory to a constant value
+ * @dst:		The beginning of the I/O-memory range to set
+ * @c:			The value to set the memory to
+ * @count:		The number of bytes to set
+ *
+ * Set a range of I/O memory to a given value.
+ */
+void memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	long qc = (u8)c;
+
+	qc *= ~0UL / 0xff;
+
+	while (count && !IS_ALIGNED((long)dst, sizeof(long))) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		__raw_writeq(qc, dst);
+#else
+		__raw_writel(qc, dst);
+#endif
+
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memset_io);
+#endif
-- 
2.34.1






