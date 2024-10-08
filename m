Return-Path: <linux-arch+bounces-7808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF501994172
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358581F26EB7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF11E1A1A;
	Tue,  8 Oct 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ZmJRDKN1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="dy9SRGVL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7743C1E1046
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373898; cv=fail; b=By2Mf48nhLTnWU+olb1spofwaGIpM1Ba0pwvsMa4I1b7BSJ3KMmPK/RJelvgUEYmKzRd4HS1050VJljG4/95RzEjaqEWeza1A8jXFO3i4GbqGd4WPr3DXfxPmYWncPfZmVvlTTn5CzJU29z5f9/fNs5qdSsb8M77Y2StPzSSshE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373898; c=relaxed/simple;
	bh=bcSSPgWzugyNeiqxbHvahbxLvGlpME0+W843bDE8iK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj70/U25ArupSzkjuq2McOrDuij/Kau11eX12bh8s7sQrwjYys7lCbC6TTiiZr1o7p2PCZbcX0qLeglU0cIAmduBnr+hyjBQutBb/fP7wbwSfcOxbZfYTNVpJ0yLkhWA9W2Wfym4hRq5lf/odt/TyokJe7XZFYSauqtaZI57a0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ZmJRDKN1; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=dy9SRGVL reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 0F5AA8A368A
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373891;
	bh=bcSSPgWzugyNeiqxbHvahbxLvGlpME0+W843bDE8iK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmJRDKN1bUE6o7LHZEuwJHrSkhjVgOn1WIeIR2y4h+WC60fFjtLIx1RsQTcrbm/8E
	 S6h9N8KnK+vFT40RqFqhWIiNxdqXgdZrSgYIjUkg3Ml1sdcQk8zYAmSrE+WIuO9GiO
	 yHLDoIGyLollBMsuPHcYwc0WdvdIEYJ/2JJk7Il8=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 508608A2D6A; Tue, 08 Oct 2024 09:51:30 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 7F50E8A3047; Tue, 08 Oct 2024 09:51:28 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:14 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:14 +0000
X-Secumail-id: <909d.6704e480.7e4d1.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUkjnRCVhpqF5uaBLnST2ng5sTgyh6NWnLi27KOftFHLBzprzb1d5UJWGbUk7mttfwQNG8j7KZsIpX2ybcFIY+LqicDy7A0OBsR0tozqlU7BJOrdXBlxBfA18G/1wj4spnZQSuvZfUxVXuXedDky4Kz+bEoVX7KumeHqn2SIvGLtwoVtjTVOEdlW3gBLazDdY88L1AgQfFXf+3TAobXk9DZM0IFrIaecBYvONhn8DbuJKT8Th+zss3zCIhPlQbd/NvbG0fQkqs7H3932pRKu6PfwPNl00Ao259ubF2h00BKv2GnUcGf9UJ5Pb4d6MfKa/8uJ7R+yGNo8KGVq9J2Kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cHiYe45w3b45Nd2OUmyyKZUv5SfBf1xGBrbAuNWENU=;
 b=f8kJkzG2mqJpnZzyfle7IKLIryLHhi8cZSwnenHalgSoe799jKeHYjdJHSC3ic1tPxLa9O4FGRKsh1ES2gHdUryh6PDfki95Kml9hpgV5PGXsGNAk25MTF0GlLPxzEr8W0oYTDlfQRTcTymF2gXPjw+0ZJNz5OLpOMyDnJG+76BW2jTR70rT0hY5CE7YNrr2E7P9LHsc0EoU9aHRQElwafDY7nTuO7DwTL+SJG4acNWwqth7/VYMv8wAuOCW3caDvQRoT/qhRF3lXw57ancNQ7eSwbnFoTAvhXNyTnajIe7WHse1c+7Uw/wQxH97MvYnI8/dbSt3NlCGpHUAJnAv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cHiYe45w3b45Nd2OUmyyKZUv5SfBf1xGBrbAuNWENU=;
 b=dy9SRGVL36IiRNTCakdJYdaoye5BYzk6sC+5zEcJFTvvvKEXF+rsEPSdTVOQUoBJcFwa6TS2puJh5wShSYUzzGG5BJO5HnKpGkIM4bKO1zpt3rHrlO0O1ky8SHRiHJRGxCcPA3d/G89sjbuAWI+bkuU3WdTo37Npfc7kitD36JnERznGummfg+46f2jPHBJ6ckdy0LR9T5pjiNhjJsm14r10RFWc2LItDmOkmq0lEumuSaWIPHBcgao//AwAz7RQf9Y0h2XdCQxT8VKphOq1rhgvI9/DKRSmnPejdJC7bqoHnXkJhqkzmrF81Cz0+eD0RTgLPh/EfnjyGMLEhqXeqA==
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
Subject: [PATCH v8 07/14] parisc: Align prototypes of IO memcpy/memset
Date: Tue,  8 Oct 2024 09:50:15 +0200
Message-ID: <20241008075023.3052370-8-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 916b92f8-0d03-4366-27d4-08dce76dfbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: YaEHEt8AGFw0xRy4Rg/k3U72Y2esrAG4MweKyPr5rU4u8x+rkVjCHA38iaYWF8FIJu9V4lAgwTJ8EEhHQwhv+FXHLRmc1qMGpm5NMWS0unlZiIQV1DzHc6BxJZSU09Ze9NIO6bUtvmAY+D0io2sWfPTcKhnXXYDJB0VMztdvLxVmmIYnvd3AvaM46yprWFDCCIl/0AOtdvOdO/igYbqTR2nDQhYrsirnKfX7nKkV2x9m2b4F9tT9zfdVcarVMtU+4efMrkYCHeeZG/0WUf2mgK3l4vQj8mCbtQay7sM63eSzzuZumyMSB56HmjPgA7DbxqjRH4mGQfVyeMWSH0DR7N4pdzqxV6UWr9YzFFt4OgGQX+5MOgyIPtKw2PStSAYHJv7JSTB2rK2Bh7RNZw/zNuxgX8BVkJcEDvkECYfTAijPMHYgnsojpT7ZNo6rt55Cl1UEzwAm0JPFqxUpCUCm2BToGPMSatQdmRHe5V6ssOvZq66l1cccKdUJdw1Ar5aaWhPNE5h/xDfIQlyQ3hV8Xmor385j7Nuendi+6BUTDrFI6fAo04Anq8WQwH1O3o548xghgqlOUOhGlgbAmxJX7OO31o7uQuqd+vDxgbxyjIwluj4UktNPg5pFScVbHZmnatX3AJTMusbtiqbQHjVOBJfpwmVEKu8lmIRTrc3yayyB3T5wI/C++IGu9thPnX176NjfU/Ywl/f7fjC/GTHhgF4UpsBAbxbdu/4Edryr65cm3fTU2ikO3/QsCC3XjaKehYmKdojX5Rf0xfVrhpj5QltLhloCIrFVCQfL2Jy1H8b0h5p8OroWghqezN0XUd2zQpGiiesp6YEdR0wxjdGnklWB/L1jF8dB+hEz1msbYTuPQwtLvJKyzhb0428Tm8K0P9HaNchpe2AWnZy8qSsxpFtsDwEhkfnwEK7DSJ/gmyDcovBjqDF3+Ygzg7gz3UbKCBe
 kKgcEAELSpHxzkAVsEj+071Xr4kZvN+ZEYx0FSQwtywwfuLcAMVBRNqTYV6fryQEzSRDs3bUR6+I6gcV+4fnrBwFmOTb1Ctun2U391XpzWTaHv4fBNqhFcgPL6OEdySmZ094zthnzdm6L0I2KaHWeRMqmaqq8ZALQRP0LCUjdwNrJkWybFh4bqdSlu3tV3uZYc9dNqCvVGjGWdQupMGlftElkJRt9IQiAp8vS3n/13vOL/aKnmIOZotfoHopD8Z6PsBqA7SYpffVGmqO5y41brJ58b5B7NMbDUVQgZItS45QD3HJec45Bmtp+5SKtxU13KGrMS0jw75nNaad1YQtmJLs0gyRb34+aOlmx4mGTMowuKQHy6V3cbWxwAzoSItnKBx+p13Qu/QnxpZKw1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Iy0k54g6nA8iygy3XkpPnk6IeolGOBV1v9vIGDL6zywJdJG3YC1QlEmHQukE6tL3yQTiZqcOdrwoqzg1FhVs2RY4slvGfS96mzfhsKd75+pgl7ggjNqqzddv+wN05I+LX7hhZuONNGKwF8NIQPoUu45H0KstvjYkzAH8fE2JZom8/GRWznRc25Z88tO3YjXnt2A3O/NT4S9RIpXRhW1ZAz8JKoeu0QB9IrnAwD9U64LffG6v9s5xI6JirrFCnHzdTAyYVvoF4PJZ3c5J6Xc4MjRyR62h0wyrmFgYaW+WD0uH5ueuu/WqF2FtENtWpD78L0JLvd5//Krl70RpsoUjeNhfdtxD8yGKyTvLl6xZk2grUx28s4UbzGZ955xW59gP6ZKIiJ7sAH8qidbG+m6pV1JCFqnHl4nhyX0yfbPPnLs6x6dyhS96T1hARTLUqSEItDEuNJMB9rSLOeVQMXqulx2psCFl1DFy2UGXlJC+HULYd7awM936VrMZVTmpWn+pzj4LYGJ4xWMgvz9R0nCda1hm9wxFX1poeC44ihbsA9+4t0QjMPhOJbpygOzFO8KtmsyKtRAuy5s8TwbmKT8iVGZnnmQax6BO5GMcP3l9b7lPMmGD625I9+W4+riWMB7Ij+bxDRwnFRzqJF4Zd2jnGYt0HWdPKUPwQsvAH8s4nrWUed2Fa/ME/BcRBPQBAtrMqmcVTdSB2YAmWe87Del/lTGpO6+DeYxQSoMgC3MQiKFvb0AKehWcTd0Tuj2vDLmFGISuTSpjp82zo9JxGF0V4Lb9RS44XXtsE0kp2Ky6JmakfIBDaSyYGj27qbCB0vVFUcoJpYvKJYwow4sKbajFEvQ6ClPRxmB5f/mpn5C7T7m9bN6LcrwsORIAm82MQqBtUe0UBVBEqBFQsY83I6q6EABwwquw2n8+4wCPZ71G1chzAiqhAX/3bIG43tM8p5AH
 RVVTMrLrqc5LSF5AMhXzdGKP/Dudk311WJLjHv/lohkUilKwPku/O6HJ+POyek3UWyMznhiBEuedFU7b7uXfJE4lVFgrncsOlEHQQTOJevVmB/Hv+GLq4Bnq0OQKWge8xwnpTgDmT4P68m+5GDrSMVS3Plpxgf4+SKiVyt6VvL8HKeKQ+nwJEL1SlQPGxMZ0zoiGoyJcxcGWfVyxg0+ZOXwqJ360VfPDcvJKxEVQx698iMErR1yq7YaMiDR9/rMwUeG9/nmNovCHTA3tJMxARL1DEC4FsvoHbxcZEU9jr86JsSXbR3cnCiJRUVvuZrZaDtScPJg/7LfSg+eeyfFOUu2U5AVWhx2KkIqxlyVNkd4c2QUR2KNPa8rWVpdzGE1T8XqVRG52l6VyyBCViwbjqaUL9xuMoGZN6be1mELt3QijBzx6uFzhcpcp4sldLk8EABRjnyBkdme7UurJHVjKcYrA/Qhuw5dp3CbGFgDuXZOgrQgWGMzE2s6yE804WjwUh2D4k8liFhkBruFu1KZXg0aSW4oC8dd8iAk6s8BakwAsQqwLhq8QCf1LUKCdoNX3VikQEhNr1ItzNb8RHXaardZbarQ/K0/vJz2gg6LOFfOgzLASDmVzvhDLxQ4d5ZF7
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916b92f8-0d03-4366-27d4-08dce76dfbb1
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:14.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VlYBA6UWscD+JHaREpG9gDJnMel1eyj25SA4tEjddLM+67x3kypI4mpdUze6EHqo09kdCMSu0QqxwAf84ZVoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c and remove function declarations,
because they are now declared in asm-generic/io.h.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- Mask the argument with 0xff because now it's an int and not a unsigned
  char anymore
---
 arch/parisc/include/asm/io.h |  3 ---
 arch/parisc/lib/io.c         | 12 ++++++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index a63190af2f05..5cfaa76bb899 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -135,9 +135,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define pci_iounmap			pci_iounmap
 
-void memset_io(volatile void __iomem *addr, unsigned char val, int count);
-void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 #define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
diff --git a/arch/parisc/lib/io.c b/arch/parisc/lib/io.c
index 7c00496b47d4..aef9b0124811 100644
--- a/arch/parisc/lib/io.c
+++ b/arch/parisc/lib/io.c
@@ -16,7 +16,7 @@
  * Assumes the device can cope with 32-bit transfers.  If it can't,
  * don't use this function.
  */
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
+void memcpy_toio(volatile void __iomem *dst, const void *src, size_t count)
 {
 	if (((unsigned long)dst & 3) != ((unsigned long)src & 3))
 		goto bytecopy;
@@ -51,7 +51,7 @@ void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
 **      Minimize total number of transfers at cost of CPU cycles.
 **	TODO: only look at src alignment and adjust the stores to dest.
 */
-void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
+void memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count)
 {
 	/* first compare alignment of src/dst */ 
 	if ( (((unsigned long)dst ^ (unsigned long)src) & 1) || (count < 2) )
@@ -103,9 +103,13 @@ void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
  * Assumes the device can cope with 32-bit transfers.  If it can't,
  * don't use this function.
  */
-void memset_io(volatile void __iomem *addr, unsigned char val, int count)
+void memset_io(volatile void __iomem *addr, int val, size_t count)
 {
-	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;
+	u32 val32;
+
+	val &= 0xff;
+	val32 = (val << 24) | (val << 16) | (val << 8) | val;
+
 	while ((unsigned long)addr & 3) {
 		writeb(val, addr++);
 		count--;
-- 
2.34.1






