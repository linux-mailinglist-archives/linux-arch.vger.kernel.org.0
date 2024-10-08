Return-Path: <linux-arch+bounces-7806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23493994162
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDFD1F26B7B
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411671E131C;
	Tue,  8 Oct 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Np/UvaRP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="jr4JltfP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBB1E103E
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373894; cv=fail; b=dOt2j3iwYq2zTqJQeL1nn8TQXnkrCux761W1SCvfKVjIH7nHHpYWMmPAN7vtWW4NuGDCAnDT+SLZwtIS2nCIOnGfzn9HKye1sW/dvv85/rqHnGmymaxJ8AWhgmiiEqqopH4cbzXjVo6K/ikgJ4pZ/0yyi3bfbzqI7u5WTKrk0cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373894; c=relaxed/simple;
	bh=Vugnc9JNjdRomyxy00yZbAjjGE3NVMfMf5WMnR6OLyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1G+BOWjUy4r3q/FGOmA0PZD10dhzPqKSLmoi+27uv6ld1b5nnEINavb+SNKD0i674dsKC96XKx2GuIG/AwUa5KmCyRkmXxA9uDCqvFDuaFlpjOOIevhuhkINvqVwLWNaRWQN21QYdxuEEYxrHevH/tFnPyr0TZztMfAvt+v1xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Np/UvaRP; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=jr4JltfP reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id 0506445DD3A
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373886;
	bh=Vugnc9JNjdRomyxy00yZbAjjGE3NVMfMf5WMnR6OLyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Np/UvaRP+3ooAmFso53sA6I63sLnfva2ZajgqIUNYGDmcgdbcihWDb6NPzZkmfSpP
	 AksSnblYLwWC/4pq1AFt2Mjv0wuDFHgt6GdYfHofcr4JY1piFdoozkcWsuTpy5/uc0
	 KnkKw2ATyzUqpzohZmvM3QK+H4SA0rqKbEYvcHkE=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 65ADE45E08D; Tue, 08 Oct 2024 09:51:25 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx301.security-mail.net (Postfix) with ESMTPS id
 98FEC45D8B3; Tue, 08 Oct 2024 09:51:23 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR1P264MB3357.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 07:51:21 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:21 +0000
X-Secumail-id: <3233.6704e47b.96c09.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/x53jWi8aAsrvOh4D4dLiKsMOg4BrJQhsd5/Mn+1Ng5A3c95oki2n4NXYWff9/ce3vmGU6XUSro0eaPzCOrsneVomCoZGrlFYqMqJf//FjoVj6cnc0sTJvCPUX3xvswaUBVCZBbuC85zeeRV5KDOZRAALdXjh/hmFgpR85rTxgzskbwW51MNToRyxs4t5fI7xnlFK3OlExMZquSVSYTJemF09zKOzQN508gBcBFC3zBbHcWh7FKH0ZksC2GU2Xdm/FQg1M4DT2Y2nQtBJuPBQq2gJmNn1o7DtRR4jskLibZ2+ZY0Qhbzuva8G/Fu/zq2l6j86jd5smpCK30PwOCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24NFZOMeT6FafPTylyEnXkpcymOn4pxoBqjTMqt99s4=;
 b=xWg2gfw1krBK9FPdHOr/Ruy6WWIhNexPoMKyIEpeUTL3LEEXnDF2zeuenlo1bJth7/nI/5N9voYLyBPBBGT8VUE53+C4jbX1fr0NhNdE5RTd2GtgSgrEcBmUAYZQ9mmmWSQT/G6kz4SqiqyoSXfxGWcJA2yKC3eSZG6i2bOFyOR5B9ykqltOXQ1ieZX3vNt9TXofMbkBFmoAwUswtJnymv+fnCH3f4tXE6Fshdsd5un3wuXsAb8Ylk9p+BDCOC7BWLfa+zwTTfsJ6i3V30iP78HkLYiO5Uqp7LU9Rdl+Az2XfkTM0cfFd1bpI3AauoB9uG29Li74tSOj+czEe5W9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24NFZOMeT6FafPTylyEnXkpcymOn4pxoBqjTMqt99s4=;
 b=jr4JltfPTQlF6wUt6i2Vz/cbYZPUxEh2aIY6+TDHTX2SV46DNutd8Bja7Ik7lVJgtCHJj8x+Qm9/t2z/yIotblyJmZHMtZ6ORd4rKvdUGKUwGP9z92k5chGxALb5h36uvbb69E8y36ldYtnhXs1b6O2nblahM482/G02MN03JzWSheua2xyFQyKHXG9SJNj2iNbZcLSaO7Pq4602QAEpn+EkT3CB91MKbQW9bx8xe7xYyMCacsmdCy+Bn8hKM7g63I6Zra/P42dAz+r0ig6hHGIC5bbQy/pwKA088q3KIDnQDvXJ0W8luQCozWAQX+D4salUwmDvKJBRqdbPLZXzew==
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
Subject: [PATCH v8 11/14] s390: Add wrappers around zpci_memcpy/zpci_memset
Date: Tue,  8 Oct 2024 09:50:19 +0200
Message-ID: <20241008075023.3052370-12-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5a8046c-f4a5-49be-865a-08dce76e001e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: OatTSMHyljcbQh4QB2kQXsYpM9he7Ny4RdRKHV7173uvZ3BHZNdwbmh00wa/qAjKRvsY+28FnbOBtp/xdUYjYjr67J7ys+TjgQKK7B8Js4nKDyqXSP+PJhRoFkSryUTId2PxjWSCh7Baf+VHGMhKG7QFjdWeyx/sYRkaG0EgCf3Hdp8X3zIW8BtY9lC3V5bFEfrKFpqiQ18JmOmBmi/w/Q6o69f89+7MBpls3HA/NMjO63mNRLoHdiGjpLDPK3oEjbbWEYlX/LmkBWaAOTctEDzI5WTXC3QXcOr+wJJkYIgG0+LFtp7rd9Bwe78NbBa8lhgrWn7qC575CPHlpTiHoZe4nBwjROxlb1F/6A0LvYcTpWvdm/azdrvJjnAwGx6UbZqYawM+4bbwNeET81oHcz16tS29lJsOuc55mJjgTSZv4+DOmmv6v7PVPvmaL3C8TeVks952M84/4ridHJxJIG0G4p1xEmj+6hOhfVIxML17rPjfEfEOKTGjtKvhn/YdT2UdxljHs+GD3BzlpdPEchs2a8YQ/jcnrk0urx6+7dGiEJN6O/r/swQ8Kx6jy6y5ztKfLUKe71l3mMIxcWQMXXPzK6URBS7SV1CITDuqwEYS9QusjX+miqK9QubojefkcuKaYpAdYzOCNYf4JHS2taME+8RVPx6MrxBFW30CMD5cwZz8rIbdyxDq6CvzpKn5hYMWXgCKinrP1H17xYUi+I633fOhDouoeJgDyIRcETtyndcME7/PgDNgnEC3tI2S81FQJcvBOob/sNsUbyr8IaXT1M+sSBdIScgvikpGmhQPus5titFTx+0mNQa8We2rH/9v7c1wrrd/IV0RzAYVQ9NQyvE2uXBhL13JMo3WKLq35X2bI+gOmGG4Q0lS7vNUaxV16rg6Duc/Sdv0U/YOaWSQrPHgL1NzRMj9TOqVgtBlE+YV5b/cyF0prY3GgAWBAIp
 ZzfYC83jaBHjStlwrBA7MT+jGW3sRERUn4QA/bKFDrITc+Ts4JcNj8IM82v4aveD0sJFcN3RcS36z06WxzQ2yxqAEQoxqk1SS4U8Pw5Lgxd5MTiqT6DAao5t7a/tJpd4sLO8WuUEIHx/7d34wXcDHxK0PiE6pi/nKhdufEBDJXh+mFwsiSSb2HCQ432q0Zx/TYV2XhM6DDFC7aPg+WdTkNoZdbroO0NmaAH41lHXKspq2W9AXg6dujmKLN5ggU3iUumy3QY82EvGpKE629A2Yipf8XzGQtB8BOe2cPOp0GjxtoaY2r0oPqN8/I8NVKM3kNI981FVm/s0VdbSUQ5UV3LfyUY1TIwKCec7wDn33M5r7U3/DkSFxNS24u2XxSIwGA7/BNYloaoMhtHdJ9Q0H8C/Cr8JbERxQUyn/274=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oymbwlXR9pRYt8GdV4hHX8v5Ch11eMM677r4a4SnbFKpUZEm2SN20fj2aWpMqAppAn6AvAMZ4Z29LcPnPKqduJ06X0/5zjT2HFB/vxwC4/xFbqEAKxh+tDfFS9hxSIX99bZiriCbD75LI48+r5XYQoMRIijFWUa4OgJ/lkUwTP92UjEmwxUeRZCk4wpNe55JQhp5qaEJhWIIRk9XR9usCm+ydeK1ATkuNa5AC0Z2FbYOna2ctvuqrN/f9mz/2C2UVDEDZbQLuedTsEExgls2DiNB2HcLDaGJWWil4aaSj2mw88EFQnwH9SSxGoao6e800ebL5YceESTq57+qIZgP0wI0LLuAvMywHN44rwREb0VjaF5jhFmAnLzgECzRBjbHHaZHwljOA1yVJcFQDC00ktZXM74qh0hPc4BfkO6Er82tuRvbosIfZRaRU06Xh07tZ8aclldGMwKC42QMiUznVabJR2uwgC+PLI3Cntqq+MnlNDhbPuV2nVMNZvhBaJBwOLhRAdxLPDTMRqqixbwvIlbes3HF64TrWm3dxJONN2AD/oHmASU4sa2K8E4FI3SyC5sw1YS/yyxXeNDY9uUf1FbvDYfbxMlCg0a00sb08EpLhSxJ4bm8280eyW5jjJJDEVyAwt9OOwM78cSAGSjf2B071cW2KX+pw4lIoeeavaHLxHPfoV7CxVUXZm9s0iwpC+H8pPGvMsXuKNd3gyno0OGw2bZ4Pk6OSraH1zUSHA9nvY6jPS/d4W4ZEYg3PCRVnyXaqPrNNVgNlYn4OzPYzzJYZ7EtXbyyhPAnP3lSDktetZbu1RmHEuk2VsCjiXUGIKQW3NE1VDQVQT1Q0eHoh77JSZ3UXfFqdFVzeFlnvVAcSNZL3AdDk5ZtIu79m30dpovngRD247YzrvkzKhXreye+jNQzkbQrf/S/2T+GBtXb7NKXJ86NmHP1U2i+D0mQ
 6xOrGUtA9Soqxg8ZJE85OgsP/qDnhFCVzZclxXjcKt+PfhPMbn0rPCym+6tXGyolRecUMlL/+qkhwZscC3R5ol8uuBGa4ke5xmB0TCZSFOKy81A/HdvAuJxeoie9OlN6gOFmR5LMoTbfiJK9LUrbUONhYeKS5hsPqUuz7iga1xMVJzjdFUAQ8S26csgdFUnTTfA5lW3ks86cv8SCsu0/oZgTiuWBhmvpnasmrWhPe6zydz3PlDrZ4ESnsUrUPNgX8VwXwUKqMfwRdxn+5UcpkGcnjyGETOwxK7A+JF1XWYP50vNdPqXMh7pSGOkRMtZOLpIclfKlcrXe9DzwUbNIORKZbUm+1jycTAprK7I8tQX5OB/ydp+T92uIQf7S3kVga4CjdRjyXb3IZ3o9BQSJoBLkKIH0zU49kfPtKWoSNCGdznaqwncSfZcnw10uqAZff/h1vte2Uff/HvUh4deU+sdVnvYnkIKhHbHIRNl0LI19l3YUSLzgBaKiLXvNpFlyidjnM1uE+QmMWDNNCReTQ9Cp3qP6bBHE+KZWB4HNW2vQjFkKcSfjazs/0D0RohyYCtpzPlUmi3cmUdwFo8XvaPJ2eAMFkjg7Jt9CM6HUTq4vaD0TMptbW2A3xhGvWM3A
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a8046c-f4a5-49be-865a-08dce76e001e
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:21.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srSK9zKa7OBuWRE9rEsp5SZNrnp2Hx5sz3CNM7GYMItE12AnArnFqb9IY7mxJBF+ihhZZQJIsqw7VYXm52Uzsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3357
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Add wrapper functions around zpci_memcpy_{from,to}io and zpci_memset_io,
which have aligned prototypes with the ones from iomap_copy.c. These
wrappers are necessary because the prototypes of the zpci_ functions
can't be changed. In s390 arch code they are directly being called and
the return value is checked, At the same time they serve as generic
memcpy_{from,to}io and memset_io functions, without a return value.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- New patch
---
 arch/s390/include/asm/io.h     | 27 +++++++++++++++++++++++----
 arch/s390/include/asm/pci_io.h |  6 +++---
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 0fbc992d7a5e..f3ef6d4130b3 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -58,10 +58,6 @@ static inline void ioport_unmap(void __iomem *p)
 #define pci_iomap_wc pci_iomap_wc
 #define pci_iomap_wc_range pci_iomap_wc_range
 
-#define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
-#define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
-#define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
-
 #define mmiowb()	zpci_barrier()
 
 #define __raw_readb	zpci_read_u8
@@ -73,6 +69,10 @@ static inline void ioport_unmap(void __iomem *p)
 #define __raw_writel	zpci_write_u32
 #define __raw_writeq	zpci_write_u64
 
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
+#define memset_io memset_io
+
 /* combine single writes by using store-block insn */
 static inline void __iowrite32_copy(void __iomem *to, const void *from,
 				    size_t count)
@@ -88,6 +88,25 @@ static inline void __iowrite64_copy(void __iomem *to, const void *from,
 }
 #define __iowrite64_copy __iowrite64_copy
 
+static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
+			    size_t n)
+{
+	zpci_memcpy_fromio(dst, src, n);
+}
+
+static inline void memcpy_toio(volatile void __iomem *dst,
+			      const void *src, size_t n)
+{
+	zpci_memcpy_toio(dst, src, n);
+}
+
+static inline void memset_io(volatile void __iomem *dst,
+			    int val, size_t count)
+{
+	zpci_memset_io(dst, val, count);
+}
+
+
 #endif /* CONFIG_PCI */
 
 #include <asm-generic/io.h>
diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index 2686bee800e3..43a5ea4ee20f 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -143,7 +143,7 @@ static inline int zpci_get_max_io_size(u64 src, u64 dst, int len, int max)
 
 static inline int zpci_memcpy_fromio(void *dst,
 				     const volatile void __iomem *src,
-				     unsigned long n)
+				     size_t n)
 {
 	int size, rc = 0;
 
@@ -162,7 +162,7 @@ static inline int zpci_memcpy_fromio(void *dst,
 }
 
 static inline int zpci_memcpy_toio(volatile void __iomem *dst,
-				   const void *src, unsigned long n)
+				   const void *src, size_t n)
 {
 	int size, rc = 0;
 
@@ -187,7 +187,7 @@ static inline int zpci_memcpy_toio(volatile void __iomem *dst,
 }
 
 static inline int zpci_memset_io(volatile void __iomem *dst,
-				 unsigned char val, size_t count)
+				 int val, size_t count)
 {
 	u8 *src = kmalloc(count, GFP_KERNEL);
 	int rc;
-- 
2.34.1






