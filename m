Return-Path: <linux-arch+bounces-7807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED73099416D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6254C28162F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EC1E1A07;
	Tue,  8 Oct 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="NW7TG0F6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Z7tJZAYr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF41E105E
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373896; cv=fail; b=YYr79fEsxInIiAF6HZMcfSuXecdJtL1zu3Yevt6uwIEp53SuvFSAeCmgaoHmOgxoTpjBN8kEWy1MuUqFcJFDyg0H079yehpVtESM+BjSUk2mXLsBeKZpXKeSy8aAx3fzv3nuGn22KGtw8napj3CzANg8Ov5nxSUzoAs1gSEVVKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373896; c=relaxed/simple;
	bh=LWuikBYwlpf0wv/2tAfgWPpF+Jc7W32ZNWnx4iLq8eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPN5HGmc5TtlYI+nVO4PGLJ3Ek0P3vYtddjNbQ6L4mJHVUZjxIwFpfWjS0uc4rWMvlIlJMqNhtZiQr+V3avOY7GZxFweuZWIi+whGspUoadg1m+FlF26+3kcyRn1hWQemGQb1Zhs/e7imbIbrRglMI4y7UCOElr3u7gliNmzhp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=NW7TG0F6; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Z7tJZAYr reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id D469145E191
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373886;
	bh=LWuikBYwlpf0wv/2tAfgWPpF+Jc7W32ZNWnx4iLq8eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NW7TG0F6i1NR+FBG3TsrEJJG5xzGk9Rzb2TNwD1DZ0v/Oorscf4cgip2TzZ4k2qea
	 W00uIozZgzQU94z+66jaAqnVpk/vkNRiCOMJ6LWATI1SMlFCbqSsHWlKUXorkj5sMO
	 vCVqkL6TPN/Na6PQ0HJok5MWylRuGiAWu9OHDENY=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 0530045DCB0; Tue, 08 Oct 2024 09:51:26 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012049.outbound.protection.outlook.com
 [40.93.76.49]) by fx301.security-mail.net (Postfix) with ESMTPS id
 8A72345DF1D; Tue, 08 Oct 2024 09:51:24 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB3357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 07:51:23 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:23 +0000
X-Secumail-id: <3233.6704e47c.88ae9.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urcsvCoODdu7d545FjgnId394A2ydXPewzbxrPfBkElf6iBEcXz4nITEbyRYlLrG+RdpM/8Q3yar77PMRQQ2Iq3Ij0fQHsVJSgvffd3Tr+jZ5Ulr+QOTEKsXWQCEL5pcqAaIqp6M7iTmSMEpP62ao4bV/fltHjCflUC3KhljKySnyTlFOJlCM9HkubcWxLFaQL8McDQVkm0qkzAOZShlL2qbBnr2TGfhSKY2yjMBQki4Gk446V3Ca4uf1Yk7D0xby/9+kLYqByqI4Ze2NpNi184bSrOnBwjiQP4PWQFOkiC6d7vnfIgXCG4+rmIGvfGCkD8GNckILuUmU0y8J7DMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWfCrWnkWmCC9HxsKfLPlnLuJdeuyxSIkifOPutqCyI=;
 b=qZTmpQvyD3cr0MnYOmpS7sIQgHtoanb2tr36dRwIEUjBkvWHrCkJqvu4D/6tEqE/O+8bMVm0LMN6gwE05T034UhcGiu9FqnqyrB/jQo4s40ITBKvotZ6SW5xJmhufKIEGiq0td9B2wEu3V2tteZGVi4yJggv2dDIDFuDg1hXhdfk8fGUxh9iND+0mChusl8KmmwEjPouVAsh5Bpkw0L+XE6pwiHasJzTgY1E/MLUids2nY962uPrT0mZyGxyTauYeHuHcAiS6G+mh+7fPd0dmG4DrA2W7hI4+QCM0T/NLXBM0fQ3y1L6hYLoCvm9noGLUAepr7ccLfzi5Pca/LAiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWfCrWnkWmCC9HxsKfLPlnLuJdeuyxSIkifOPutqCyI=;
 b=Z7tJZAYreJ2D8LahOk5nxpy2n7HZOhyt+bq46ZAJ5a2cEI3OXfEpAcPsS7d5GZ84nykZag4UEk42NYhJvWTEjDgjMA0n3RLJRyRga5fb7R2htTOOvDxK0htrnPYetNDiy1UmY4HQR/FjhMgxKQZatozJ5zTxPm2M1UF2xOGaWyQP5FWJncc7nqK8TRCxAvuY1wtP8ZmcanKHuPjTFZNQ4jvozNSfBUz2BR+GjUAC03hnJkzoNTTAo2EFadqt9+moQYZF39S8t3LtohZ8tIHQlP6J+PfZxx/17qDcx6xbTvooaWaHKVtVAMNKZYhmHtmaackhuv8oOjrJfmO3OHtqUw==
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
Subject: [PATCH v8 12/14] bus: mhi: ep: Add HAS_IOMEM || INDIRECT_IOMEM
 dependency
Date: Tue,  8 Oct 2024 09:50:20 +0200
Message-ID: <20241008075023.3052370-13-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR1P264MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b1fc99-df2e-41ab-276f-08dce76e0136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: kuYiD5v5IrOeWxtoleTFtOwnYos6Q9UbrrGlyMAbqP3+tK/KNc37kwimxPf+cdUlFIEgwrJGmkUKWZlMfQz5vZDI7u6MQ0Ep+Z8t6HU5UnzrhVrC1g0jXQyp9G76zDd1QkUQk3Rvy+5TbQOb8TFiH8IsUSD7g9yvNONti8EugLbMLL4RZdmOzSLRIlBgIkrl93L/K9qHHoeaMhnvnBoNSbMxDMGJJllSGbT5eoGr/HXNJExsJgdLR2xXtL/ohTnByww+faAzr5qt++nb4jZUiV90RWI2GUxxVGFO+XWwtPAphTXWqQ0fZtMmp8XIN77ZjZSF03rOitxuoTRU7Icay2oxnF4m5I+CS1in3ssxqCxS+KkYReDU7wYRx9nzFU//Mo9929PP3pK3iD0QcP3AJuQI9uEsrpj8ZuYrc5vXaYb+RdMWSsYK6mi6rTcbKDL2+vG2qZRC/fnb/AQtdJdHsJEehcGtf/W+tmViZuYQeXfly7gyufanEo3JNdk04/dQnlNDih0Nj/d/J3OROfqP3YVTnmYLbHfzllQ3VOxd/D5G04dCnlc7ZINXy3qUeBc2n5NTpZk3sqTVgnQUulW1BGuVsnbO4ypbTh0P+jrkPInZ/MjyiQNvNPo1hLn8mWo3dY4mNbB6F9UWTXHTZkzWB7GCbAQru98NrM4hw17tLtdLO93d8OLxrr5icOlljLLpHgaRnVstWutLw66NsM2EOfseP5byN9t8oRfUPQcr5Fn8b9gd5iIDcvhwaH5mMLs2dQdhjnOckF9/eKxcvMEW2oVts+9ZD9m0YtMeLu4lO3SO6X6xTy3Gc2Wh3HrIexGcnBh15ujAj6xir/P5bzRpN8FSDFWQCpnIbKHqYFdpcUvzwObJx8pTlOCCmIZdrvqUR7cWc2SG6D1oac/cJxn4wVHe23gfT+/E0uM7zhD+udKHi+IUYfdTcvXnTzugDCXwulW
 mAU/hCNxEfG9mUiOr25jVNsmJ+0BdYIrcXOSYiJljMga9B2o04KAoRxmFSVcmBOjGTrpHlXSWWPVgeU9wJUQUGf+f/nuMOsxPfQXjcbAvtrkKVzdCHLPUFx00HbOnBuB7iyY1FYb4zeq774QqbjozSp6u6oR94rmV1Z2vJqAgZErQjMrwDYgA1PUNw/rV+LFe/OPkOaZdAICdZTeZP0RBX/o5sLkbTHWt8qTtMfA7ciGWexLqcoO+tx1siT4f7jfglhxiAVFLAedeDk2jlLRvJ5CJbPYvU41MMqHLyk+ZDzNQwETYbQ2Q46aH6vXF6ulyxHLSnfpOOF0CPYzIt2P6ZzZeh0GW0r/0SHW8wixcoAEjmJwxyksX/GKWSenapa7sPWdHy4NtwRiksCQBWptk9mUlDBZEZC5S4BKy1cA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4jhPljjqx6yvADYnDm3t6bq27VFEhmq9pZBjWoYrhjoI2MidCXhwEodSTttTqgh/ax5dWpU7JVvSMeeMQOZ7U3070rgNFX3O62/0y7xAvaR1suwRH3t0CteNltYpDV2tuG7xLfULMlWbk7MSl9UaHhNgz9tB6GbPszUM1LQKcihkTxjIH7+7N5vJO1uVe03l8xiiTFH4bD2JMeMAbdycCSWCuM1ACOaiA/H1EzD4owRDubtzAxxcVaZxGPO9bjrh7/CUg5ttGAnxYT5xaIdfnvaCN6briumd8IdpLAAc4vfuDo09Kw2Jd8oqO4EG8cxHdp3KfJhpH6fVY42P773X8LKiV/DCW7CDFFB5SbrtBWjKj+f8dE5t4L/99aappxf/GBEz3czUE6cbd61TFgX1LAXI8Rsdq1xACC2IIMvkZLENMswM527haxdr/URaNR6bPQLfO1Ick9YPG6DhfhclF/mgnoQqFopqj1TWg8uf3RUNZE+T4HbHF+gKEX2zVe4NAyf5fysuRMbyt659zZ0d1+CebYavU/EutmgP16rioWMgHpk1Ehr6GPiC3HeTvswkyMKqY4W5NqdZm2QAuXqEwtjAY4yg7zOJ9gMYay9RLIBxeImEkbvywWlQC/LC42rTiWy56tOUDgIsiGJK1Odbyv2t8B9APjsPJPnRKApfdGVLobUI85aaBlz7jraXXzsAHtaVtDoIEgHjduf+6GVrODJOtZfmtjLjHHQxfGbbuVIutx193okeqYwELHsavWdecHslSFCErTbsvDwmiR1FZ7HkzWThwzRar38G5qVy73Yj4Bwo+MMGg45wCEJ40l+JR3uS5No+oDJDS/nsCB3ttvFeZHpVlrz+hTMeJsYjwn2xHHLjwYqkXM1crlXo0OIoXPw7LTeV+cI/KVAsQgvDVcz3CEs1u8VeiSz3Il2m30Rbb0bnlX7VqtcLyL8v6vlg
 86Mn70dGpgDmgt3dAf8u9NWEAVqdjbAwRobUgZmuEq1c+m84vDe46TsLQulwroCc1YlRYM531+QjB0RTr4slp0nNGwVxWaCEJzmB2UOXXaj73YIBdudtu99cGcuwKmQlf53MyeYNclIguiOO97Jtuz9CpCZc18jJcyZWXeBDZQ2Fa1dUidkNsau87XeUKeatFIfqRA8Z8JwDCOkHt5d5yTZxKROsOpVtrkyYDDaDzDu15EXr8srGSW8lto2Dtg76O7qJnunRCRlS+xLoOITtqC0F5Hcjq5ghsB3TAPKMOuCMkjL5KPxjrDQRWGGmh8ZPzYmNIubQwflPKKD3tvBSc20dDG2nNtqUrkL05sldSxh6UOUXFnZdb0o/z4Ehed/3gJYoW9CLRAvBredlhk0T/1rs32NEUGHC+I/Ezu/ZTyrMj4RuACq1I9E2Fy05sIFmuzRXQ+Fiu3yXlSyoOhQte3RgZGUBkDvYtCuL6xsr2pkJRYF/Cm2RZszKqCtYI140275SMdqFxMOx/chrzhv+hG1lS3rY4/G+MLWFbj9ExkTOmWEh6ortFIZ76gAdvnItOyjix3eWbeIKIs8xGeajjfUM/wY7hh689gVsLA3k/EgRNUTAnj8Tbryi1mm/ScAI
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b1fc99-df2e-41ab-276f-08dce76e0136
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:23.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GL4xEnxwRuQDkb71TbKqlFm/Ry3S9yPApeAw0k4Bt8dutumm+qdVYoqYl0+2qxm/FtoYC+Cv/rSYlXztuo6t6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3357
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

The symbol MHI_BUS_EP neither depends on HAS_IOMEM, nor on
INDIRECT_IOMEM. But, the function mhi_ep_ring_num_elems in
drivers/bus/mhi/ep/ring.c is using a IO memcpy operation. So, when
building for UM which doesn't have CONFIG_HAS_IOMEM=y, the build fails.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- New patch
---
 drivers/bus/mhi/ep/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/ep/Kconfig b/drivers/bus/mhi/ep/Kconfig
index 90ab3b040672..dba95fb95eeb 100644
--- a/drivers/bus/mhi/ep/Kconfig
+++ b/drivers/bus/mhi/ep/Kconfig
@@ -1,5 +1,6 @@
 config MHI_BUS_EP
 	tristate "Modem Host Interface (MHI) bus Endpoint implementation"
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
 	  communication protocol used by a host processor to control
-- 
2.34.1






