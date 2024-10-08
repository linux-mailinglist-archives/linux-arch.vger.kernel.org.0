Return-Path: <linux-arch+bounces-7812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1AB9941B9
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0736C1F296C5
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A44209F45;
	Tue,  8 Oct 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="fq14XjRQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="T7t24dX5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2560220967A
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374111; cv=fail; b=TYkNxO4x8jKRQFL1cPBCIwGIGqSDd6jRhZLDAGoXXrqG29bbv36OOF53/TlSrCxlsM40k7igA6dLq0jGXS0yGIuhqNqecEkedJ7d5Yl+bLrAX5K9OYSz9Ufft1C+EWH6pJZ79OCFSXxYbm2sVLUfamjPy7ObrMdO0fowqVrqkpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374111; c=relaxed/simple;
	bh=XYkzHNi6HPf0Gc5AVj3xRylNaCqhT4t3l3BeSpbxBQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5h/fkxlZ0MLYjVn+CcSIeCiajkNw8NDB1ZYFL7v+UwxwS8nkmfVhwQ0NtgZMaDBteM5u75tTyI8v2kmuNO3XlQulc0pYxU5znMNCL5KNrJDueoFe0qmcolerQUlk5XNXHIjcV3ybIqPRt+uMMGppuz93+HlsOrNoRh8vBDAOyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=fq14XjRQ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=T7t24dX5 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id EC50945D773
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373884;
	bh=XYkzHNi6HPf0Gc5AVj3xRylNaCqhT4t3l3BeSpbxBQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fq14XjRQTGs5LBG01fNhsKB8pMfailuOrLWDY9fE+32hzybRHQqwe+Tb5zMG82z+s
	 FSy+u1yO4U3mwCanPHqUctiqahm0wWpBI5ZlBo5fDTNMhd6wxA2/JxBBkarbSC4+/r
	 IlEPaE7MlAUPO2Y9Ja59PNMPCQFmzIqGDkETTVa8=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 9397E45DF86; Tue, 08 Oct 2024 09:51:22 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx301.security-mail.net (Postfix) with ESMTPS id
 BB3FE45D85F; Tue, 08 Oct 2024 09:51:21 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB3290.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:258::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:19 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:19 +0000
X-Secumail-id: <321e.6704e479.b9672.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W71sxR8prVQBiojJAId1M9XmBg4xq+/sEg87LkEGyw3eCfEd2LODXF5Cr6stYvA5oLqtvr2HDmGP0bv0c00Jco5H6Mvxf4CP8nFWe25WQ7yMzlQM1666PDSn6KLs7Xrk/PKvcbI4D4FqobTkgM5C8Z6gRiOzfvReBc94mcdaP9IV1idRgxs4oTbtZjrz/0pXpqbljnw9jLATdKpsQGW4ModDVFxRMjnDznRRitVzWI3VR7ktyC7lujvObvR0qVEAr2h0lhHSbghskPQvFyxUMxX3snba7jZWbOJwegjAwPNqCZlUqTNzokZjxo556oroeWPvt3Or5mYJBCBUxzEICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzphxynSWcnDmlj1YGFvS0M8pfPmEf1zIN7dxUVy03U=;
 b=OEw6CxIRfkCTl5dr7pGRM6nOIEjKZ1/lzyLaMvEl+BT/YdFo4LH26i6JPQ81U9Z5iTEt9aOhtBt0vDJTy3yg3zZqhNVWiVqXSXqT/x59KnheQK2ScIGQd0TeI9iKzRlAx7qbsugnSbqtM/77PJJDBUK+D1/NT4DArNq6my4SSnjlOltezotR0AA+3bwEb7X+mG/hB0dbuTJZodKpEBJojq9UV2URiMoH1VhJnYRqbuT/UJ0Pn8FSw0KJvpknfOSik+dvIPM1VVUIIv/kdBKJVO6oV7V7bHraR2ZAqzxPjVhOmGENYF2AAUx7dW3lElZFYBL5a2Eb1hIglAud5vLlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzphxynSWcnDmlj1YGFvS0M8pfPmEf1zIN7dxUVy03U=;
 b=T7t24dX5coUDJnIRcMzQqaUcvIy9XIfF9wcg1kcaYmXhYiNJhZ+gqpOX8xtfPzSVJGynFhsk1PeFl2vcylSfZGpZotGQYK6Or+/+gN4Mn1Qgrb6A/4fKnr061tg2WZkL/V363ST0WQc5IZ4aSmiepVARHG9aijvOWFjrXXsVNSc6Bx4vnOyrtiIlQKfovzcYiAGvmhn0NJ1f+MdqT8Iqkf8WkKwbEx9nrSyKT1CgXh8z5dxihk9ghgFij9aBKJCmW+ogxW1RbQ/lydBiY84qLiDLXhKcBFfYo6ThtxSkpY6R60tgyQDPj4imY4uFGw8r0Iw1AYmt986jitFtoumCng==
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
Subject: [PATCH v8 10/14] powerpc: Align prototypes of IO memcpy and memset
Date: Tue,  8 Oct 2024 09:50:18 +0200
Message-ID: <20241008075023.3052370-11-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB3290:EE_
X-MS-Office365-Filtering-Correlation-Id: 21befc1b-7caa-4cd6-d6f7-08dce76dff05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Q+hc4owPvEZNz47ohLoMqZscIn00xYhH89IbcUpVdaUkYZR7LU6WTNzYjPIlr8zGVOUZwdnvbuULnsetVIk1J2c4tiRb0XuRVSWQu3y9qtfNt/J5WXGgU5krUMFJNsdiC1XdeCerPmVKDWW+COBg1bdYMcBllb4rk1QDgSgxWm/S2JzNpoT6Ua2gkJXUFwjx040BRryx3qtg239zEfjGpNijRff5jqxkdtu+fWFshCpAWhvUs0aPO9oZEYKndO082zCpEk0kfTuwZ9/dltawCoHoQWjuQSy9O21t5iw8yEMnpFYlf/Fmm+Uapzc21rgV9ksP/BVRydJ9Px3jsciEWuRM7dsMJQkcJ/EwR7e5hRst9QgPVe1YScWER64nqKpBLLkA8GSGWfJXTr3p3igRC15P30cnVSa4xloQ0slQB0LIWLeb6ZidthH9DQ1c5A1lAg9ZN/V+798r01dZZ3PJpsRh0FQpMvQZqHfY0cVj8ssNwTVUe96PMpNPnESh2s1S+bqKIasUiDOwvEJq763EwmD/kzBLr+IaQY/cxVbOKllKKUNMy3PJ3gA9HLK94/2JwJkOf6shUUTZfE1aPLigKEHQS+mIZbkXIItatmvjOBv6JT6AJarf70/uav6xRTQrEaciVN/fuDxTRNJxAQT7U7VRxm07SjntY2JyxUlBnzMmLwGLLrmswqsNUTwoEycQUlnNF/fVx+ULoWTkFbdeQRHnZS3UUfd691LjCKANoyPt7CkYJ9f/VXGDSy0JMLrTgW758dHoQ1zy3/SICN5TLi/0GdYLgyQFkCYrbXx9JtReXzqbFA+iuq3+LhsVsfqJUKhDzluO/XrH0gDGPy/QMBn9eezdBbZ9t9Va2Pgx8K5kfMfFu0Aat7dc4kQ1CbQoGXlDwxjv95j9VW4UZ6Y8Uq2cKsdwG87NG26enanGpBzyr3Z1zSGk1WOjgcD9LUSjBVv
 fPPKh5BMYrdCqguRqu1Vg0VnjkOq0+Hx49p+ZWXrsAeBJCLkKcl0+ADLn7/TkhdMTN8+f9F5tP1laahppjC8ZsZz2OpLhtqE+95ScoGgKieVdVvF/TKq+PuosZP7UyReKe8IbFakneXOOFmfRYztXuMuXayPeL0+lsjuBgQ4UQLjFgEtC/dottyIugiiX+SewqwKkUM04651K6lkuvSwxGZOXMNbyxkg3CQTvEfPIjmVDuiT4QPwcBzl0sy9RZK5W8AqdOegy3waxPSEsN34mCodD1I8XpDZpZHXCzp2lDjo4qlpdEIirJzRjSPDq5hdqbBqxY/ReHBf1Ag3WLGm5sajsmbCPV9Hw6JDdVrLJg1q7XvFWnjG1m9UEyqGDuwKQ4gm8bRm1PO036IVMYmvym6qcYTDE72pihdJsqyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3cdefqHkCTh+e51W/kzbLKTnOyFN2r+c2lrHAzOcnKA4C4BqXl1Im1rqDGqr3kZWigSToeIfNXUh9lwhzsVXc0Xo5Po7yF+tNP4ky/j2zeG4KVOlGpaOw6dendAyj2zOqP8WOgpD95Ss7kUPNjj2hOLqIQLgEbhyF3bWUwTFN9cEe2HHjhVfkyjk1O4yl2sqYdkhJ+nZoSChQgJmg5pqPOyeERcpZQQ6jXT/DKm5PMTYBqp4xWDg+J9SJd/I7zCm5BFpXzvK0BZBi0XK5sUvUCC4VtrPAld7F94ycCaT00uHi8tyiVrLIFe7JSGNtE5ScHYljUQcZdT+Q3LvPjTso/z5peIZoTWd16sfT4KT2wXnRDBL8THNoi3KNsAoMhwlqVj4A6O+VGEMzHmbK+SPldskGX5J/kOcrCLeMmbj8CWoxVpKJMEK8lanw6F246J7KvjaYXqdo3DOx31YDyLg6NM5PUp0vueodr6cdzDmyigrA76bL5rsD9NRYXjKmCOfv7ltsgF2zxfkyO5aFayf7w0R4hSAyP1g7jq0DALRn62arn8uJDDB2tBWZiMUrkwbWOqAoXGxwXmu9OmUlMxPyogrQYpfXDTAR2uZHOLUhy/+dWrs3KiY97V8x8oUCUK5I3A/HNu7Bz7c/isFP6/qZIhEsVAwznjHwoQvlIO07IrfOytZwgal60S+4ier2QBv2q/qhDXop5prGH0k6T3y4aY5o6dOsiKtldEX0YvhKYB21b3sSAw9A5VWcNodT4AFSGCW/Wt+9IcaZoJnpE8BGUc3WawxNowH46MQM5EZkPf5eR5djNiMdt2mu7HZCrs/vYX5B5C5f3q8eTuQdNl3VUspSApcIl1uGbTAJ1eaIVg2ql8JUjKrCEKJ6DSjXax+DblB8XQBv0wK1EunMSBBb73mhVkeyYk5JtCn6eIXysf6kUMGb8wyh55heYEPeUi5
 +xNxApV2DY3vV8Al0duOIvY8FjXncposzVqSntXhE6JJhiuHAFjXHpPdyLeYp1biFLn2W2KylZ/K1KtrZOdkbdlRMJbmQzedWnDbfVoPASPEj1etPT9tOf+pY69J8bgBld/BbgY1Cww69EvvE49F4QLo+84Io7AYzx7+Uhn518Mt/butzACCkG6MZsGIFFHiSvvzrA8Q/+r25GypNTKy8l5H1oUcvK/Atc5WbQt0HB3cr3lUJVZnSYRmbK8gzeKqd2IemMQDwNjAxK/dkku6bTHamCOLPC+5503igyLiG+s1FLJ17g6ArcddYqufNYV5OrwsVkDmORsDUd9a8uE9WUVpYGa67Avud+kkQdJ0BQ0LFaQ/OKpD5b8vQXAp8MrhpiXjqHBmoJHUtDwwagz2RTvtvrP9DtdKYAsyamD82XL3TSGyVaF8uicn9X7CUD5m+7q4V0je15lc+T8ZZHXcTm3W0rLSE/WFb9U39WwGr0dWXmcGLk7y10h4bnJzDeRAgV82ZSsmp8CU92f728JjnKq9L9XsmyUv4gjyApksaY4qdH3nAzqK01mz3bIaN24F4Pn5Q7q1Iz4r8eNF2bq0QIaciJvHUU51TG2+3eyUlAlynKmiS11Mw4rN3Q5o+6GW
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21befc1b-7caa-4cd6-d6f7-08dce76dff05
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:19.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QP07i75M2ZkWywOT0uj+h2IRk/pzQKKH/yzZmVGcE7JwPI0WsZ6a2lH3X+7GQCazSxhGUEM/XHlfU16BY1fZhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3290
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- New patch
---
 arch/powerpc/include/asm/io-defs.h | 6 +++---
 arch/powerpc/include/asm/io.h      | 6 +++---
 arch/powerpc/kernel/io.c           | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/io-defs.h b/arch/powerpc/include/asm/io-defs.h
index faf8617cc574..20c3f2671da2 100644
--- a/arch/powerpc/include/asm/io-defs.h
+++ b/arch/powerpc/include/asm/io-defs.h
@@ -53,9 +53,9 @@ DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
 DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
 		 (p, b, c), pio, p)
 
-DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, unsigned long n),
+DEF_PCI_AC_NORET(memset_io, (PCI_IO_ADDR a, int c, size_t n),
 		 (a, c, n), mem, a)
-DEF_PCI_AC_NORET(memcpy_fromio, (void *d, const PCI_IO_ADDR s, unsigned long n),
+DEF_PCI_AC_NORET(memcpy_fromio, (void *d, const PCI_IO_ADDR s, size_t n),
 		 (d, s, n), mem, s)
-DEF_PCI_AC_NORET(memcpy_toio, (PCI_IO_ADDR d, const void *s, unsigned long n),
+DEF_PCI_AC_NORET(memcpy_toio, (PCI_IO_ADDR d, const void *s, size_t n),
 		 (d, s, n), mem, d)
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 52e1b1d15ff6..b41799a1e2a3 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -246,11 +246,11 @@ extern void _outsl_ns(volatile u32 __iomem *addr, const void *buf, long count);
  * memset_io, memcpy_toio, memcpy_fromio base implementations are out of line
  */
 
-extern void _memset_io(volatile void __iomem *addr, int c, unsigned long n);
+extern void _memset_io(volatile void __iomem *addr, int c, size_t n);
 extern void _memcpy_fromio(void *dest, const volatile void __iomem *src,
-			   unsigned long n);
+			   size_t n);
 extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
-			 unsigned long n);
+			 size_t n);
 
 /*
  *
diff --git a/arch/powerpc/kernel/io.c b/arch/powerpc/kernel/io.c
index 6af535905984..e1848184619b 100644
--- a/arch/powerpc/kernel/io.c
+++ b/arch/powerpc/kernel/io.c
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(_outsl_ns);
 #define IO_CHECK_ALIGN(v,a) ((((unsigned long)(v)) & ((a) - 1)) == 0)
 
 notrace void
-_memset_io(volatile void __iomem *addr, int c, unsigned long n)
+_memset_io(volatile void __iomem *addr, int c, size_t n)
 {
 	void *p = (void __force *)addr;
 	u32 lc = c;
@@ -148,7 +148,7 @@ _memset_io(volatile void __iomem *addr, int c, unsigned long n)
 EXPORT_SYMBOL(_memset_io);
 
 void _memcpy_fromio(void *dest, const volatile void __iomem *src,
-		    unsigned long n)
+		    size_t n)
 {
 	void *vsrc = (void __force *) src;
 
@@ -178,7 +178,7 @@ void _memcpy_fromio(void *dest, const volatile void __iomem *src,
 }
 EXPORT_SYMBOL(_memcpy_fromio);
 
-void _memcpy_toio(volatile void __iomem *dest, const void *src, unsigned long n)
+void _memcpy_toio(volatile void __iomem *dest, const void *src, size_t n)
 {
 	void *vdest = (void __force *) dest;
 
-- 
2.34.1






