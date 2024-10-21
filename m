Return-Path: <linux-arch+bounces-8343-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0239A6A6A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B656281D76
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FD1E0DD6;
	Mon, 21 Oct 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Omjxj7Ml";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="L/J9OjrL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout34.security-mail.net (smtpout34.security-mail.net [85.31.212.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF01F8F04
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517625; cv=fail; b=aJFNRXAlKaFNdK1g3whsbQyxBfa/gIw2wpkKszvo0diApFn2L26+xMzVC60Bo8HuuqCv00U4K+fQeQCM8h6IU7WEEaIdezMFfxKBiPaYtN4m0AeLIlilh8iOEH9pkK94Wt1sFL+0yuVx0lA5idlp/K93mow9ibzIVAStww3eMh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517625; c=relaxed/simple;
	bh=/ocSKZKP1X1oscswsJlqywTbmenaHDpKiNI1VPu/Qp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkIZG7DqBEx9Ckg93XEDV39ldtJpkoYL/kIPDyA+K34m9n3qfvgFEvVmCHf+j/maA+tb5cn1vZMfA8imu8A0690R41PK0jdpHj5JGEmRZh3yX0jgXFuMaxkN6Sk4TRKYD3zM94PtNN57ahkX9OpvhZlqlFLlDaX7MhvhcD/yNiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Omjxj7Ml; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=L/J9OjrL reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id D2E1C2A3ADB
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1729517588;
	bh=/ocSKZKP1X1oscswsJlqywTbmenaHDpKiNI1VPu/Qp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Omjxj7MlpOpYtYHF/CtwYtN6ApmbbScLxy2FFjfT4DQyTHAYPtTVTCcpLmbkSOZo0
	 AjlO/QaTaE7qzXEs71i9Xyuw2eClX8BXFfOV7YX0e4Jbz4Dvv4vTlDrpqcs8oBty8G
	 SCNuS70cNmHVsI9hIY8YbF9XGJqOA6XU0TwBzvso=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 8F6772A4580; Mon, 21 Oct 2024 15:33:08 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx304.security-mail.net (Postfix) with ESMTPS id
 E7A2A2A3BEA; Mon, 21 Oct 2024 15:33:07 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2339.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:33:06 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8069.027; Mon, 21 Oct
 2024 13:33:06 +0000
X-Secumail-id: <106e4.67165813.e5c9e.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOEwvfpp4QNRW6gno77VwtnPc1kRrVfoUKXBbtcx3oSxzZw91WvEJhRk9ytKQd9byZx5ftZBhPiBYnVtjn27Yhnf040F7hdw4Pwt+n3Tg+YnnE3il/qKZ9EpMc4g/jbvqyzf6gbJeYk7IAED1rYtC2pXXGLAy7+MthQqgZtWegFsUqYLrBWq2xM7IPpT2S/j1RoXgfN7Ye+g+f4lIMbdkLIgIWzmqJuRPW8iofSqbR93fd2zTuEqPlaBxHoDoJsB03ogs9LHs3T0VwIELxjT3b3WM8F9x0GAXEoQqi/68Gc3m0SZ+scBtaVCupg/jFjGM3Wxo/yxbN06GH1Ei0zw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/Pgfr4aqWNaoWCaK9VM3FAG6Mrhm2a/4ETZWcrPJJs=;
 b=okkVWtDIhjrzPP/MXE9GnmqCzMR0tA1SpCOspsylsKHZHTK0+xYpzafYplbrz4XUdEc0VZpb9PuaAj5HmQcRd0CeOWfa42bqcv9+7ManuT7WOcp+YcAzLuJL/Itp/cOdRb+5s+Njm5UfKTivNKq3WsbO07AcN4iHCRGaB+ANToVtUknNMIYGqCYU1j5GKyUGPtayFxz1blR7xxnTzfLIHSceyxhZp6+Uld2bv8+IUsDpufMrKKQ/LGmzawa073iX8/tllbSlhcpku02aWPBKEGtn5DVDQlikKHY06ySPAExOq6WeTuGuocz1oM1VoSJof/rUPs9uS9l5JlK0omMIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/Pgfr4aqWNaoWCaK9VM3FAG6Mrhm2a/4ETZWcrPJJs=;
 b=L/J9OjrLY8hmAKFnRwd9IQIXt/O9SLNkfcmhJhF96apdywjybuDg6m4udCjGJRe8nMqFcGBWV4fFoRVVjI+T8gmIbkfCIpzzDwE2RVc92RTExsiXxcD3CWNHL7PpScuN+YqMqRXsY8uUR1wr+hr0edLeUbHpzm5+fTuXGra0hqY6K3q9wlu8dXGTFX7CoIbzRuarFQ1/q5pR1N4njETbLzhEQRKVLalloXD/NOLFcEe0eRxB/giWM7UBgkm1YmPPckqZDoy0hY87mMtxl6ebCSN9tABv+IGXfU71uvvLfptOW+eyWpSPkmxkxtRUEnAqhMRAUPLnhp1NQPFcv5ID4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Takashi Iwai <tiwai@suse.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 David Laight <David.Laight@aculab.com>, Johannes Berg
 <johannes@sipsolutions.net>, Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arch@vger.kernel.org, Yann Sionneau <ysionneau@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v10 2/4] arm64: Use new fallback IO memcpy/memset
Date: Mon, 21 Oct 2024 15:31:52 +0200
Message-ID: <20241021133154.516847-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021133154.516847-1-jvetter@kalrayinc.com>
References: <20241021133154.516847-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2339:EE_
X-MS-Office365-Filtering-Correlation-Id: fc60c16d-29d3-412a-034e-08dcf1d4e59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: rjEBdPkcjo9OxI80XBkwvNTCZtI2Ptdbu5x9pib1LLPRJz+YhwzOgfzvcb4Jf+Yk57mGGGPRSkjczQb3VqHsuDhp1wvY9xe+K4y94KgeQXqsw3CML89qnXu2KjwlnLJVjzN6sQJCJ3lfAcJ7Al0dZjAR7FC81GjTAZ3iwsuvCbbJa/PHmX5agOsCjJAFKxVtF4eHa8qZgAVWRo+W3px4/2iUpEnwWjZZQDa1+davy/bpyXw96RbD7hzD965gQbPXWH6XPTC0WnYnr+HEkLnEUVRXVF0a16rM3vOkLIm1MbDjpepExtOdAWtIdvVp9CYDyN/9jVLU1bE1ZNlOzJrGGPHfHua0h51TgqN7hJve+7afX9pWXQPOWyxyGPdn/N01aBqgRW7W3QSRWigC4DonW2Sz35toNxALYXtVu4EQMGI9OZJe94E7ryzx/RVO33J65sXcUZcsVebjOAePOVIu+YEcKtsHLlNd09ldNAJyiSFaqCLOjV33fTuJhrWbaJWatKFKhCAs/EP4oko9I20dR0GS5Xc9IJK3MB4UnWEuelq0DDcg8dIKxb72v+NR0+/iu4pfDBVxpYhTtcpJrERWNcy5Lyz9ipoKLBogRPQzr6eAuZZsYFZOp/Ij0zJ5SOCTMboZeXTqZy5XW6wzWdTIF2yFjCTnpdQx1+gbuGGBJraXrqeX6BiQKwvZhyi5qRpRdf/ylg1Jd+4mhTHGROG7RB71KOtrxz1AZugIOl4hvSPa50yJaL+k/cuhhX/dkmPWGkXpicDeUrBC981fMfqX4renW4Lzm2puZQHKYU2PayQTXOt+P7M3uBQfm8AdJ474bYeUtgV7rcmyWE8etUDjDZ88xf3AZiv4OnUHZewVLk1OteBqVQRtDAooU2a1c6oz41jNlgcWJtEm+TpHQVvDrgfeANb/SS0vK9hvs2/YXdFOFPnp7PSZWUD2j3rAKEE93VO
 4U5CF2EF39Ib3BYsg4g8B3GrKjuartZ3ZJ4XI9gzDM+aPddADIZv06/jQZvt+s0JMEdg6uTBTOZGkELhEEQuRJiaqPPZZCs2oy+97ohncjcQ+NuLUBfg3u9pWNotNBl+sIMElWxAQAW5AkDGA1asuwa8niwpj0aMgS6lm+QitOEmCIYahDP8WoEDQEFA6GzYIGMVJ8XMAzTSj69Di5vmg0yIBvV0kjKL6D7bJXzyAhuY2xnlK459TBWS9mVQOOZAHPcPUKPFWAXIghX/i4Hxposvywtwyu9Zzz03A02UoPpSoClLypTUfRmC1nxcQdGjE7aBRfVYFR9TiHM2drmGyCz1lj2K/p1r1WuRuVDLOjEEM8CF3L+aEjt8I+jOwFQwr3U1sY16CzH0yub2wRRGux926cjZWF2qLt4oX4cZ/GBK6b8CoCkO6kyqEZGMe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kihkfdOx2VIAk8sd6cb64EACsa7B02KKJJI5DBhSQWcj5rDnOImgN0F/u7ZDariI+7AJa/xwgoME51qCJUDAuX/EsgV4qoHFnXwpSV9n3uh7GeNivH7jZk3lPbaU51rB96vr3owAlBj/M/G+Tba/5EHMIe8XO7Vvl39zFgvAHThEef7KhpdLGfom8TygzLiCx8/LfcFoDAY8Mzvp9GwvMjutSouVcqU7RckRthDlPsA9I3Ky2aF+wpNslnJbgS/6IbYp7HL84FvT2+3CpBZ/w/HJh0GucMedGWGakG7R0TcOzcsMsN7/7BuX4W9JxTKdWUuEMbOzfgmP1STANPdPsdhSl4A+MnSwcisUzhPFJM3mxvfTZJtcJ/c4t+o1GeND6pKOkKJc6nMcwtDJDQknqBQf/81dX6A5/LO+039QK6GHmANKln0Org51p/YTRrwJ16elK6bsAGGcMkQr28NdqFXBX43wzprQcbWA6EG5RfNeQR0Na5DGDcrGhMgWcSTKXuTbn/tas7piU48WOyHkBkXxnp1dj5Chj6BcMOWmjD8GeWV42rkc/CKR4UorT2HIfZGJZ4cS8eVizjk+6/aeeZqOE/3CUISFjqlHHt8OWPa6ZLstWut52jiqvW5Z/qa3eG95EbPZ4aCijHMB0WSr3riAFJht/xTFJJwop6IR2c1R0pj1Eu8esnBk0ydW01tlmEL0z0mdDk3G5MuKMeG2EML226XLPYlZEfimyhP+FaJhWtCFtHLPtrGOlpTHS7gSfZK5Fb0eX//trk4SejOoN8IsHlw24sTme6RVVRolrKbJCBmsDFpGjonQ+iC+frSKRc/vkNDF8fQLyJldqJ+HIO5ggifZaVL1oh1FfozqO/T61nmHb8EJNX+weU8/Saqbysnjyp4xzbyyuX59fG55WbsfS/room7fy7w+PnCnt/wAehMyrkY8Jhsg5Rsa6yTl
 lcJIqhh64KnRIcyweiuNTqMvwGbc3vaYresH62/yTC7cTPp3xiLuWT6t1MuY6l9judXeicfHtmDCKkGXQloZRUb+/peYTKy6oY6bFach1Np0CaMwhWQO5DsudAQdPeY0bunjrVRSI9w7ShVMZA27pjolLbf2HFPbOM8FbpPUAgcpo+oHMm3qqs6EW4+tN2gE+3JO4kKHS4nO7mO5goNSP/6g8W31m6Zei6t7VVav6LNWZknjD0i0+27b/y5HRp2Q8JgjNx+80f3ihKHpOE8S1Hx6fyX89vC8QyJL2piHJWx/8GfYLiJZtNuxZZoHNKsiLHntMsJD8XM7obZUrGmmq3Nki8qXrJt5qtB+rvT3DHEKGLZ2SGGv5tEYOZPdn0sJANdiaM8yVR3LIomlCaBcRjm16FzxnXIRWX/BaSsTGcaT+nqM/rgiwRUPLwB/3gWBfV+CNlp88dwu4I28OlIV5TJ8S5wcRGlAS90jmqOVRyTeKkOXSgxYPcr3Rgtfqlp0PZte2AZz9FIURxwUwuF6n95ZBqUzDWZ/4L4YBw7XE+cQPz21PpjZcgJ2HQUq6knq/BXOlnonZw0S51jVqIvrhciWsLqoGKl5uxyWTqI4XaBFOefzxkFKLYIvShtxQA4B
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc60c16d-29d3-412a-034e-08dcf1d4e59c
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:33:06.8276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnaTTzpXO2SCGPJxy8dnp5t4ejw6OX2zAQyKgRia29BmnLMnMhtUkjDrMZY6XkKitmJmV5j2GQ7NYJSiNS2aow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2339
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
asm-generic/io.h on the arm64 processor architecture.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v10:
- Slightly updated commit message to clarify that on arm64 we now use
  the fallback from asm-generic/io.h
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






