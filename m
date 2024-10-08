Return-Path: <linux-arch+bounces-7810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31B994187
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BB81F26C72
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744DF1E22EA;
	Tue,  8 Oct 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GFmreuLU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ps0yI/4t"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC51E132C
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373902; cv=fail; b=R/U84eCKYwTQQhStY+KPGLllPAVF5pq+7+FPvZRBWvufetUZhyMguLKUurw18+g4FSK6Cw1Zg0W0iAYF2dM5KCaYMThaQymYRb7CNVjJUlxItsJL84KTFniNYCkL89l5AfuxSIULzCA1Do3ERsyOL9IZsaCLzwwPf27taTPk84w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373902; c=relaxed/simple;
	bh=tKW95tohOF+PLTDUj4O+r5KMe8/lEz/v6ZEO7YeNKWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnGW78OXcM2LxeZLUaTE11Rw82mwG0stbNoiolZ+SjetiXPMQtvyEvQaZdPE8upE/Zhu4nDoMQpzl0sh/9XBLgj5VrP0d4WfZoR/hEyA38hAfSwhAoo62DOve6BICCzyDBU1f+Vp5pwKnmiKVQVShRZBC7KM4hX3WnK40ix1QCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=GFmreuLU; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ps0yI/4t reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 99BDA8A3984
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373893;
	bh=tKW95tohOF+PLTDUj4O+r5KMe8/lEz/v6ZEO7YeNKWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFmreuLUZJwl26YcnNJ4y70yEXTox2TLCAY4H7piobgbaFPOt+eMNN1XlUCn/AQf9
	 j/C374bZTl3uhdm9JkIClVkTp+lZnsXI9PSyfWaEeQntcB5W8IWVOlXRyvTiwNiodH
	 5bV/02FygHi2Yla+TvUpIaKKk08E7QK0NpWvamMA=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 06DCB8A32EA; Tue, 08 Oct 2024 09:51:33 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx403.security-mail.net (Postfix) with ESMTPS id
 960CB8A3608; Tue, 08 Oct 2024 09:51:30 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:18 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:17 +0000
X-Secumail-id: <909d.6704e482.947c6.2>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+xLm8zTLlyRZLD8vnRMyT+vGlRT9dadU+uMUbwU+N8FVN4sWcZh4JWlkK05vLe2N/rsq9aZxgAkLWR4kb3wEkdkWNJvRC9VxEm8xk0KyzJbWRm6HWFdnGrzvLkzO43w38wLFf/UYudQvlmtzxnsMsEfo/pQ72vt3z2ychpCrlLT+Zto5nPyd+2V9+OSOIEdetY4Dp+KbT88kTCGFmCS24omCzutyCbVaOP+Glg8p2KtwuxjjkZlXnsR5xyp5Cf8HRd6zABs+aq0wAz/srqr4kN/4Sm9/lvaL2eh3jbn41xFacn8ZXqVBYiKH++hHfecsEULFi67Yn5b6RDuelTFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7247XoRh+Ek+w9KNHOU0AbM6ZRpvjI2pHX6slg+3jYA=;
 b=nUAEPPJyKGhERXiaVfz4U5NnK0vr6er4BB85o6ce3Omo2bWlmbOPETJCvKQ0rknc2kAzi05OMudRz3EPMf4kg1OEGxJ99Km4OHBmb92n+dpm5EeeQh2cY7LWek8CNp6shaVfqulsnjtc+/tk8nJpyYs1uSiiZnVUPz6PcE7JSENPyfAZYukzsSmJj6hE5wkX3SYV+tx1kpM9ISUPoe3vDhkisuN7WN1c2W8a5l0txG6u7bo21imEO3m7HvoDhwQ2GBDCz9d3bz+vetnwxVBhL7FI5cDxyYdZH6qjPIf/fpsB8q8IV0hhECBqpOjkW4B05DtU8QVsKq48kVrUd1k0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7247XoRh+Ek+w9KNHOU0AbM6ZRpvjI2pHX6slg+3jYA=;
 b=ps0yI/4tLi8N5XjvSlu/tWnCws+HGnn42VkV0xFZNrVZDxpfmnqh7MmqGJ1yV4hAUaH161FqCFJY0Rjd81bAGRSge+p5EC+D4Sgze0QfdorqD7unbuSSWvTsDvSVQZpS3oATjrmcA7l4gmK0gwf+or1yfCyAcH7wwCkc8ALWojFs9M5pUUM3dHOznKG/GXdzqXChQhQs/QHKd9Bm6rnD+wrjmFhgx91s7PnY7ln1kw9Dukq9/KyhShgamwQzedczSCb4YtvgN449dTz8Ze8jR7cHGNC6tXcePenZdC1TzBe7wV9bdG34TJwwXjo2SnqqcfuOL53gnYHTI/+RXPUPag==
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
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v8 09/14] arm: Align prototype of IO memset
Date: Tue,  8 Oct 2024 09:50:17 +0200
Message-ID: <20241008075023.3052370-10-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4ef03365-71b5-45bb-2bfa-08dce76dfdee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: sXrwJw7615JTSS9YgUcVtm2Y3GEPp728OdpQULw+BUETVjiYpHQ1YWPbKgf7bNjW5DkLxDo3NVVvDK3F7Ocdr6AaeMT4r6Qs8Jl7sQmPqMxg9e8asguMr55GoYZfgjDe74IF/8BI6nG0BSiysNPmJhU0gZBlAEwkXAD5Kb2/DQQLcSyMKnQnbyvQu6dTf8ue3aYKgX2PJnqCM+D2fL83r5lGDAsYuE+TPn6vna5M5zWW9W8H49IBFzB23DSnRYSb0iNYYNPrxH94qX+AXdPx1AkzslnSdhg0T4m0BHFpVJ6557W0rF04Fky5NbqWp8xVdW+73Z3JL3CEriTXEweuOaLbf5ZMrqkwHvIx9BtDEa0maxsaulcv6ADOgR30KpyBpbQC2etlPUezpheqC0B3i+/Y3WXWZfNqZIN3Merxcih75RcwGY1Aae4HgkBiJ1CPER9d5dGd/nBTigzk0vmlmNofbRSWObCCJI5PfPk6Utx4EFkKanylcwFAyLYZ7F7JyurTcaT4tXGYLrajSgNMBEiKaP012rbTly4cL0hGKsHK2s4eAPBOqAWJtXhyknEedd+tfPmasjauNIFauYJ5ctvqWdtHDu08ixHJVaWbVWtdvo/yPMfZaXmGCNpsQvKpDPZsrC7aZJAiLhaAyOIIpc7JluXpdW3tTDNK4zwguE0pmY7fIU5v7FFP9Ng8NcNM3UinGpL1Iuxh9H8MFsWMqfhwSsbBEywfSmcgKPxSri6bh3EvV9YxWiE1INkP7I79MbhjMZH/19XiHvH+iEKeyFR7POZT4rdyBx5eCkYiFX9AsYdcV+115+mMXZPtPAz/Q0pNr8KnhBoqrWgd60rFDXcWvqmscSw+mEHNLHo2nCuvpsH/Wl1ejIJ9tRBaL8Islp+LwvL1SNopvuUUzg7oEO9atapfOppLiUL2+VG9T+tAAbakjZMNYTu5buOfPmM+rYB
 fHtCoXTCodUJnFSNg56tfnhe2nN5gql3Im5aXd9lJoN4J4yFKTEQbdpfVmUBUgkR4Wuua7M7B4k/M8E32PUBLdT0iowzmYisXV3kgGDvChmw3/SB2Hx7/ctkembZUR2pUcGtW3B72tCkzPDOmNH/3utQVqUfTZXzyJuU1LTk5NcZ4IFSU81+GEDhdLtvOw2MN4BUIcO55pZDEiLuFImGqGchwfCcgwjfvABcX0NRRt5Ul0u+lunAYXa7BtekB1dNpkQrg3ZkrRpxalwWbTJ1HgD1JfjF8UnrKeg75wRKNvtYD+75qZlD/NjoGxWA/q55k7gJwHrSI4ZQQclb+rIvXJ5i3lNEzcVErryrvsHwodHXoC7Xr4PRXkHOfFS45dVhs4MG73x3rdnKzlXgQ/+UigAARNWgFv9uwMbT5dWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G1FxzNodOsTieJFe4U4jIHG6EF23+TLJVkrPJkBhFcNwhdcfTzStCBAL6G/DYFCqip+oU8VcX8c+6Y2N7ROUpdRuHvPmWWhIWdDRe49yPtvqdR/kOjK/0IGmfYJMjMgpCQB6oHQVxhywqW4Ep9HgtJdSEQoPaROEDkYmHqcSIgAiE1S+gR/27vseU7jdGDL0eoPLpn0GQusxZWQna3wPuHjOW5xHI96A6teFsE2L9dkLTm96Y7STHkk0tzaJEpylVjVUrC7UBAmIOEkaMCl5cYyiK0pX1nxddrWBpG+FtajC/XU2UlL0U0ZDC+Q84/eg5H83Y+k+5cc84LMcVvluWYR4tWVx0T3AKQM5WxHtuYv5ckP5FB4YmKhlYoix9HZRjkgfSBkHVIdPeiRsxyQ9QRzQ44KW9U/udrFP2gfInTE7/tzNzprnm6TtKoLyPKFpKq4JJp8vxF/oTs4XYtjSbM+F0sC1Kdb/Bu3Dd/cti9zFSc7LxtsGrWnv/QBbF0BHSZ2yFBJojpoqMchFQsguSUANT5a+cIirUJpbFZ9OqlZtp/IDccq3QtDjLie44vj3UGt8wNxfYfAhLk5PCcybbRbwp8I34n8YTSIbciB79LYRdSR4eGOzxuIsoK6v9kWjADGocu+wA30rn8fs/5y+fXiTIxQ9qdxd0oBokBs69+4Z3eI57RViS4hRUJtg1CZ3E3G920Q0AXsvCV7wiVqOOiS0kJylGNYI0frWwlfKS07YFfnmw/rHY8niEBNrS52PA9pT3LtTlpipc8uHivTLHuQZKBhe39KJLScJK1UnqzYI4H3vsPvK3hLCvM48uZ7Ckawe1SpSOHlWsW5uA05ItQPObQnTJid1TrW8xPek6/I333fZI5vHnpqH0J+OXklJFvQkMBATy9IOhX61qkUorJtr8T99Nk2d99B/XOdufDktpHO1mRTxmaw0Jsp+sfFa
 dyT2jlSh0UPdSzZnchaF9/sfXXCxpKvZBaNHWpLD/Hn1Xr3LCiyrIJxOKrslhTSZpgMu/R8ltpXCrU37v1MVWton0/NXRIic+1y4Lovg/7uYjexDVEMGUg7wQBpa4KPYbDeP9vrb045ynDqL+HLQYRsQ8I7Zm9iMpCovl/zMMVF41VUlelaBZ3NdMX1o3fgDOn/SVrUugUbV/43//+33Z/vMFWTjsjrLqKRi95c552zb+Ow9aodHw1C6DwsCnNYXadhM6rvPfCW0QLq7+uRJysrbk3qYSdW3RUuKKAOxiECxhsMgnhONlS0nXQ5/eYsAiLWYhZ+D5UXGfcP+XOTAT/Arr0qirX27BmtMcMPisvGN6Q2AdwL4g6Z3vT+j30QBKkGaleEkj7aWODmw03TCwbGHc4k+1klteiORJvnE90dmrc24qVpe7GbceRue8SoKU/sCTJxG5IDIe7m49gkTOJZpn+9XHjC6iLTePOH/CK/+OE7V4gEF7OToPPuE82YzySgNwyBhus4LekqGbruPtHFlMEayxsrvgStpkeHXADxlkQRfeMmhyDBk93KrKohKMZrsl1NmiZpW4MKDLXG7r5m9gVuP7GshjUuOQSEnYUmnbc1/ceRs0QaWoMM81q2/
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef03365-71b5-45bb-2bfa-08dce76dfdee
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:17.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1PKAD3QTVX64cgWMSBR8e6TvvXrBmkWK/wBzkx6INGYwYsfeV34gyyVtL/8BrTaOE2jbJdPnIz5wwR5CJVumw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align prototype of the memset_io function with the new one from
iomap_copy.c

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v8:
- No changes
---
 arch/arm/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748f5d2a..5cff929c3e40 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -298,7 +298,7 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
 #define writesl(p,d,l)		__raw_writesl(p,d,l)
 
 #ifndef __ARMBE__
-static inline void memset_io(volatile void __iomem *dst, unsigned c,
+static inline void memset_io(volatile void __iomem *dst, int c,
 	size_t count)
 {
 	extern void mmioset(void *, unsigned int, size_t);
-- 
2.34.1






