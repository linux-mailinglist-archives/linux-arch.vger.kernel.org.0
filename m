Return-Path: <linux-arch+bounces-7816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8819941C9
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE48287B09
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23020A5C3;
	Tue,  8 Oct 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Na4yRrR+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Vi7ZyTkY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A51209684
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374114; cv=fail; b=pd51K/stf1bCseQSKrKm14hCSeMbL8Xkpvgphj+RtoP7PIk5dhjjOIBKHstz2SB3Rp90N+Zma6eMoQlLl1P0S0k3cbzkXePiln2uSYkv1KqIHA0iwFNCbEJuX8wyn00aBBFLP8p81XHgd3DfKr4/twD70tj4gJIJ1FWL0WXG/TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374114; c=relaxed/simple;
	bh=MUu7vi7NHTIAmQnQI3t0zGB4U+3VWZwegjw8pXRa9Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ella4GKb4y2M7N9DILr0Xe46+eMukEy0qMDJH01UpGUdp2edy2Zxu973ZR0tg2yOVK6fQkPnZLf+6EbMAFkub5ol2fVRhIynvvq1SWKqcbVWGYqcv/8gOcsj2KmOZB1lzFhKeFfymF1dvALkl32kvzEg3Ue8rpPo/dQ/blEhlRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Na4yRrR+; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Vi7ZyTkY reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id B340D322C1D
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373868;
	bh=MUu7vi7NHTIAmQnQI3t0zGB4U+3VWZwegjw8pXRa9Gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Na4yRrR+bwq+3Nrk/BpNw19C+xb65pCMa++rtwMYEpuG1vOaGer+hcf9Aw3MWcBoU
	 NklgO0Z/ycnsZJuMOU0nEtUPcwsCZRZYMLkmPtVGg+8iaEwnCY6Ph7Rs+8xFmt5yDW
	 92JIlA5klfPjC/j7ng59lYnYv2K44BTlzLSERez0=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 320F2322B73; Tue, 08 Oct
 2024 09:51:07 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010004.outbound.protection.outlook.com
 [40.93.76.4]) by fx408.security-mail.net (Postfix) with ESMTPS id
 AC4263229E3; Tue, 08 Oct 2024 09:51:05 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:04 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:04 +0000
X-Secumail-id: <1fff.6704e469.aab01.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lrv+q+tA4N9VSNGEtJi9gOV0e0WR3NjQAujW7WSQITDdTgty0mUSXMBr9iTwLjTS2qJHsr8xie9EjOASyLvlBFW4++wjPhFNmLHF/uypD4+WJbrIEIU6lqlsNmn/fG+QV1USnZ6y+wo4UzWj6w4fs4DTipxf8hEtWd4mcKMFaTpxXjmFT1rdXoz4cc6WoD2mJ4Hu7L5tcP4N7FrCG5+b9OM2xyNkOd4xO/9JOOlZ8wLiGII1WM09l6GfzyS3OJ9SkmK6COh4ZwkVI172d4UIJVGcjp44uyHtAqUgR8AFrnd8SeOXGRb5SeuWBFVjEJaqFnnk0Bhz79FFumi6oeAvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ4elliI+4P8/JCbkj2H25UmCcKJ5d4Q8c7tBGzy8lk=;
 b=k28tHjR7wD+9lNyvQXJuBlCUqUGmVIhnZCLZw6ptOwmWZVFNV0pM0V0c73QwlakRw+uWkxcp0dBiYUp9mij03oil62bASuBcaKMUxUL0cABA9cGNd3ebKkyPxtsFKIGcL1IvGflXh2kxptwVYvXVVTe9e24GEoXj/5dLRJ6nkhDHZxzkN/a8P9TCP4cGVdRrgBZevJRZpXMxVKjq6zDYlUJp5eEoKQCSgwYWjUsNbjcT6pvtY35XaJnzYFx7vu+WzriorjhtInVq9Zv3wXuUuGnEoIs6Jn5rxA/bgLwP7YIk2wj1kfTaIyAlR60ZbPziu8bx7i3Se03nd/IGhpT1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ4elliI+4P8/JCbkj2H25UmCcKJ5d4Q8c7tBGzy8lk=;
 b=Vi7ZyTkYuaHrF8hrbANfrCd4U0HqnymUaatxtGAJIPto/G0+6TAZeNBk05xlwtw1s6trEHhdAUi6vx7aG3PwapMOmiSi9D+1uOAxBj4I++u/Z872xHKOjogEJTH1JZwItrGkH6lRz/029DKDT0lxSk9mgHR/BWh/vFefbfqD/ir1bQ8fC1KsiO7f3iHQisrWMR7Zmdu4FM6iRrPgUkFzUto/zZLSV7fsqKO+AEeNwYBUMtleaaWtfP1Bpzec0ADFyPrU9dYc7NHicidw9+4eVTQPByMkMzuAuFDoYEpy0S8DWE8IgseI4baCeMElW5cfT1TI4bsUySFK9mTMo3d7nw==
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
Subject: [PATCH v8 02/14] arm64: Use generic IO memcpy/memset
Date: Tue,  8 Oct 2024 09:50:10 +0200
Message-ID: <20241008075023.3052370-3-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3c820fd-3f38-4534-5c04-08dce76df5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: g7kpiSlheEaCDr5GZyYkDIAP+olbp0bTYHVhNUqXF0KIqY3FJTRyDHXwHh4HudRqIZ8hokvPhKCGfSpykVdx13IZ96OI5Cpr3XiPqd5moojwtZ+QEtQ510n2EF6czSvIHUYaN3Sa7S+CSh2O5o39L6AUNrl2rJuKRcQs1dNoPaCvPI0j/3oIb8+BHiBsiq8iUVGCbXF4y/Y8YBGA5K0qlK8N/jpYi20Kg6E00Aua3eh7F7vEjgAUJKBgyAPInPnXrhFRms0eVYCffx4v0nY81k5g5ugGs7Tp38CRTM3hxs6DaoWkVObt5G31ekLmDoShHbQyNWUzB8qY1ZuiXd20CE+ukvvMu79f2Xx4g/A0yWTpTcOXvkCHuaYHgZ9mI1W+eXVRRlb+a0bS/BPgGtaEoqs8d8lbud/UQDHDcOXSbe3P7vbqN6moIW4KfKY91kk9Q/0+LdEWpVtpDuNEjX57E6+CzQ4FJbFdwazePnb7f4qdiK4jiyurh2l6gJQf/BDoup4oSYcUAC8bmpdTrv6H06Jukhqws3FjJ2OqgWOjF58KIQyXMFB0gAz6Jj3JACQtkEpz4oZFVihk3Q0Vm+f7/dc3zhwBGyFjBtZ5Pq2eUjhoM5bP8nWUs6L0TrXgMwd9Ja+G1yK0xbY9GJfSiUWfOEJU3i4+04bIX5Em/h7fV2bO8tArestJ23iSxhNvVtUEL9HmVDKg4OO7Mqy9QJ0+u+IdjEx0djS8bHbAsW6tNGK3lFf5yXOzF2G/SCgYzuQrJi4TkfnQ/LWfNYpZLrhZtQsJxLJMSlAhHA5nKWhXsw8lickm8+BGKtmldI2S8Ro3R2TidcW5Na8+Khp3HM1GSX6OqAhUlrT/Pn8UrQNy1xDoEiVwAKa7ASd0Fnk2FnyXixWvRjNl5qKmDMS0b4Hn9oWj4Cs4x/z2xdWAhnmZy5Hmd36011QlMz4aHgPZVEwhGdq
 W9fmLATkQQLkui5VESuJshokNPbPYIZNhm/0mkbkH2LtmtgNRoVVnaM94gkkvWbvDHrvgevQfBayvZ7Haii324U+7kPXXA23RxaCYUc2Fz6hVYxmTXJz0Vn2WIpzHK0S5ZWq+3HAZ/iraP09wbMFOfU7XtgqDbFd28DGx4Jsz16k1xavzLYulr0Ghfnnhv4YHuEGBHVR3M6AhZm486GHJF5UAYerlt4XG+c6dJIG3dcTo23GwC95v1gr+g55CXqhOvgc6H1eJmvC/SCyMZXr2RTT2LF0RZ6UZOk/ba0ijaCkNbReCp9VNPztXHwtKGLxK/lYm5tOme1Mrh/p0HJtczVO/GX8tWP8u8AA4MRTPdoaBYNus3q3fVzOI+Zh2LrjEUGKtgRPODyOaeH3CCTJ2pmqz1jexg5//BMusAEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U4yPh0LHUZ3/i3hXqkfuvpGe7zrqBhaIj2K9yaQbSelk6iDWwzhbhYt0Mpn55NzVkDqO5CaVLgpNWZ3iQ1IwqjFhWl2PJvvVY5UxnljD9Q6+yGktgGEl5YF3uKDxYy8XGWaD5x5aFhj69feIQKObKvlBa63BEl7jRrgH2TET2JyS4bPFAw+XWlLb4rxhb1Ld671j8JOnzo8uSlHIEuInpTmW3G01F6n1mUwpQkgSkS3qelNK/7vj+8GfvitujV8NXlFgpR96bZTXIr6HmbgJmyJrI8W6BzNc60ju+6sqmdYXMA6XHafsBNyVTdp3arAe6kORru+TDQjsulbZTJYWvWchveKzOuZImCt3rN+7bdTVV1bkg/NeSTw0oHfTQge56c/+CgumdcZ33MIzYtrKkahppIZKTrKOgNzxKpafyne+LLcaBIP9LEPPax5K46WHA7xWX6ikggwAdb/Zy624SdhNBLeEmkqrS1Hxndy1rz0ithozkl18Z8JrOGbcWuLHs0phVwL09N+kgrHDdLeSvvTByITZvEekArr/Z7iRQtJFz//0gdx9ALExDMMkmRBx5wO5dPeO4vvZ+SXiJqmV1PxIVQby2zMZLFnrtua0dsN9LjUEdEXlwWNYt0mKeiFLlC2xs5Wo22D5DFJIv4rJundYQdOHJMT4v1gbiPWlGUYkKz+2mXeXgoRsVts/SP0gxG/IBAe0is1/PH9XnblpagnQyj1kwHmBMP3M7LMnE49QzFrRg55hjI5Xb5SNQNuMAA0ObKW5kgsMDkg1kZOYlyL10ZnZuu88KkCHl7AKm+svEWwFa2vhZFcjjL1ukzMT3aGv7bMuZM2u0S6wCvI8nFnKn9xawgS6a1OCW8hfuvLz0IJKBsfqTD3CrvixDmgAEq+N9oD+ymzNAuriVY9xQY3ctgnJQKZjUZVIB+5tt241ARV/fdWchg4QdBwl6wEz
 CoBvdzMLHcD564opiUFFdmYqObV6ixdMVTC9iKVxlOvJZFen8QeNzJLPCj/qpv1ktytP699O3PDuikcbBVIvkSUJ+BhmCg1T79YKmJLy0XfjTBVICeHkBpsaLEmKBCX6FhvEWq96LEt5c6nt96zSNQzH2T5VXLC/Q4eQ3Ut1Bc4h7Su72tt1fuI3rag30WWzbeFDY+biuZCRMBJK6N8zM/OACnfFsjTXFpcD1lZq0bmc6IbhthLP/J3hG12butIsS3BynAYD3MNvEkxOJNcTPToMgttnTRo8Ge47Zb202fskWeVSB1yS7oeJB0Gx5KAMd7cOxCuStdBlm5e2mtPxYXwtENE3MCM8Ij98EoZw8JubcU4bSccczOGVHSjPSY8NemI/U6izUoEDO2YDqRNUm/hgolQib76Aj9icRa7qulbt5Wo8tgvUoDWDG/gHWFhooCr51dILVoTPfOJbCB7KftKMx8UPhMco3L2NWPox3ZhIXc7Krab4r1yuH0YnlEFh0RRBx+Zi+K8k/BxhJZR3QwpYOVTTeAVuyYt6pLg1T6+hxbWcaKiqmDdAaCONFq37vKyAvqySnaK5752o33Vd9eA9bQHD0p1heql+ODxVD2Coxi/LgNubul/rGsHlQ1Mq
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c820fd-3f38-4534-5c04-08dce76df5fc
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:04.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxNjnJMCg/J1F0a+jwAdQwnZh8Y5kT9dXYV3L74O6tMjmsFMCMjHmRK1VDR5KvmAwH7G2DAzBl/1warL5p5CzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- No changes
---
 arch/arm64/include/asm/io.h | 11 -----
 arch/arm64/kernel/io.c      | 87 -------------------------------------
 2 files changed, 98 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 1ada23a6ec19..463067bffdfd 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -128,17 +128,6 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t);
-extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
-extern void __memset_io(volatile void __iomem *, int, size_t);
-
-#define memset_io(c,v,l)	__memset_io((c),(v),(l))
-#define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
-#define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
-
 /*
  * The ARM64 iowrite implementation is intended to support drivers that want to
  * use write combining. For instance PCI drivers using write combining with a 64
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index ef48089fbfe1..fe86ada23c7d 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -9,34 +9,6 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
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
 /*
  * This generates a memcpy that works on a from/to address which is aligned to
  * bits. Count is in terms of the number of bits sized quantities to copy. It
@@ -78,62 +50,3 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
 	dgh();
 }
 EXPORT_SYMBOL(__iowrite32_copy_full);
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






