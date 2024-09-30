Return-Path: <linux-arch+bounces-7497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5898A54C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512C41C20F13
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4B190056;
	Mon, 30 Sep 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="f85qV/rc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="QtTjuURl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803C190064
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703036; cv=fail; b=JinEmht8IZVTfb/plXxSY9pwF0Kt/09E5+Uf4aUoZp6Or7GqdyBIKKjSiD9gH0ibnRQMYWYvQSava+hN1a+c3fIuzUWfbsKm7VfXX7SINKKqk8FLyJNpA1HxbKLQntCsIvmFARFF5oQV4f/Y3gjxBf6Q+Sa975t6vGTvwGVToDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703036; c=relaxed/simple;
	bh=2WI6Ka2quUNMJwYPjK6pPtjSR8T9qX16oOE4MeX7F50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxGu3HDacnYGGbWosBuGsp8zQhNJynH5/yOzSQwHWtUPxSRTN6aqq7B/KPQfNR7SIpUD+eko989UgdIsttNPk+78WDSW+eyruSUFc4lA6QKFWDsQ4llH5YyMDwfWRt1lXc6fEnQi2MmPP9NrKMVUoPnm0KL5Z9C5BsTgczKCD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=f85qV/rc; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=QtTjuURl reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id DB4A1322BEB
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702745;
	bh=2WI6Ka2quUNMJwYPjK6pPtjSR8T9qX16oOE4MeX7F50=;
	h=From:To:Cc:Subject:Date;
	b=f85qV/rc3MkcpbUoJQwNmi4NMeYy/+vL8lBjfnX3fEDSXrTVfJ4iPsQLbqgpQb+0D
	 9SnwU14G8Duaf3SIMDAkXPgEy/wx5srWdGqe9QpQRwbqcPR/PJCpUuNGrWK4xkm7xh
	 qD8BqpPHQNWTuawJv/lRkNsYjhCA1dStN6e36ydA=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id C0246322B23; Mon, 30 Sep
 2024 15:25:43 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011030.outbound.protection.outlook.com
 [40.93.76.30]) by fx408.security-mail.net (Postfix) with ESMTPS id
 7D9D33224A7; Mon, 30 Sep 2024 15:25:42 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:40 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:40 +0000
X-Secumail-id: <1b70.66faa6d6.7c250.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj3scZG4qrzeNJ9PRD5PHpBbKhcyCM+adSqvmfnqteaYfixvvQces0qRNkJfsOjkmv49yV+qwCQxV5cagFLa8YIZLkhh3/hfbNFCnL0Vz6h0f28Jf1VgL17IMcVo+9BqJliATrEXzqB3pIOfSCInyjscG2btm/7Ui4GVb41hcC0X2OPPARO8BFC57wL/RufbpKbV48svKndlQhHdMbZotiPQzRZ9uzvgtx+keDaEZa4ad8Gjtb6+6IT6e0W8ciylJC9wytwq+gVIlmUub60G5xefJHhoXvkdrwJ4/o1mkddmxGsIfXt1mQqFGfec0uv2g38w6TDrC0Fkg12/jp8b+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmVbu2dEha9+EV/T9s1BGU6CWjCsqgyy/PIeBcxwdfQ=;
 b=EAGFXC2t3STzWH439N1D9bHbuO9o0SNrDXqZE642PR1sNpmrF/OQxSCUzE8yP3BQUdq5qBkdeVPcg8yESPrQBeARB9EOPXpWpTfhTf96b+AVHMVSw6L6o+kLO+R5SzpWQgEyzTkMOPSOsKVznyyVwUxDZzAJ3ihSFGG2P2ot4BwKDPmvKMgnhJ8JW7Ts2FWtExti39jA3Jf/91WLUxnhzbISBqCny9MJ4mYIlpbTzYXfAc7b7G2dUFsuGJfko2xKJ6LArRGZIq7GSXPBF/e4D+oHK3/84U2rggegUjJljfnPrZa4YRjowIXMCkllJfFt5crvHwNDlnrFNOrQhkwusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmVbu2dEha9+EV/T9s1BGU6CWjCsqgyy/PIeBcxwdfQ=;
 b=QtTjuURlJ7mHXWZZQlhCTv2vMhibBfnq1KygqGREZgCU8YjG+DrgKnps37XAkYTYrWcDgPDzYl7ta/rXLt0qzzNnaVkVh0+DQmoGtJZ4oQVlvocc4mJoH9Zl3BMtZUe7rYuiqSy3RZj00dWe6ftfr75mhdPNJ6l5ddsoj8RPtG1n5FrFIlRlCn6VCAZEsZc2neo1V4Z4R7Cq6ssKYyPtoKaXYsxLC8pVx8EQvmoqQ2L048QTFynLOcqNPOihNlsmxY4una7vxAuaADzXqit+hS+l+Nz7IR9QvL5LBZ6SJdhysHdaavA1vVhngETPaEKMex6yM+0m4/Ye9QIlOf57DQ==
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
 Berg <johannes@sipsolutions.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v7 00/10] Consolidate IO memcpy functions
Date: Mon, 30 Sep 2024 15:23:11 +0200
Message-ID: <20240930132321.2785718-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2707:EE_
X-MS-Office365-Filtering-Correlation-Id: 662361b3-9c13-4a1d-cb7d-08dce15360c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: CG6O+309e69F/vRJFj1HMf7YqV5KVd5rP9ZF/EGnewycIfoLIf8EnDyPgxtROI2DBb8JMPcYxIcnOJyybv9lmeblH0idv3jjjL2751TS3hkjtzyFncMVnRO5jWuIbjBR75x8DsBzSQNWA/EUQqF4qzbhbCDZjFn6fYWQFek15yB0Tahx58HhyatmlJWUGbUbO4w08dlxljoGeuf+zo76Gu4emqKpjHP76SX0Jsxpdx8wef34gEJnrQiOAXfYKv4kjjDwUJDKT9SwmxUTezMxFoS5T80US2WhG6N3TBy3R4OjStRTDXSiV12MoOfzb1ZWQKLYcShiUbQ5ZPgE4AMwKDEKM/u6Gl9yK/ELYkls704VFl2IVcLEkYqjV5SfjizYidSblXFRV76eLlh/15NP6g2Q9pzl0Nuf9VEQJjMMThyFvk/ff1NO5WfW3Bns4lcqud8Fqr/dRgoLOX39bACTr5hs4xzOTqR44qqMoKEzrxyr9vYq6fDsUktDqY8pXlWcFeJ9a8ydzXbr2mpA2F7d3g3VPz3Jib2aN/8Q7pETqtNZ0kINTHv0v5ChDwOGXT1KQ/JqMaHAeNo9iZ9/CgaZFiVwBVvxTYTlK9f5lLmcdNATYCek9eUwYdSXpxjZTmSOXf87rG0VfHNtvOVLP9Q21YPgZIIeXWbZ1ZrDJXz4+oF2F3qzfnFLtVEEgsE/OAwc379dC/BxwmXeYb8sge8pq9Yx9/1J1x3KbGzjtbRzenLqxELCvakRknGwgIfwLN4gwPSDSg07IOJCJbdUOCSRFxSiqtiEfYPx+l4NPICfPY7WdYUJB7RweuopXGqFjF9SJMSU2lmuiGxWyOc+AbTEJD6OjWSbCp4WB7zoW8XhIyKmgwyumoK5ffoD/BIM+nfG/bqYSxwfxNjg7s4FrB/S6EDRodUlMbJnWXWrH7l/YWhK5KpTMmjvcb+Lu9VezrEY8p3
 vC7Ac9zVkH5snznqthuTvJT5yrK8v9C11hy5gG6UPtSonl6ESpzJswmaQ7QSuPdKW+Cyfrn47FZEJ6geN4eH5e7zeOhrgaOW7/yjlcJ6fbMPDPK5VuDYOK2fxi2Pqa28WREchHMWuQmqJKW38Rmgqmq1JhTsV6T5M8pqu/LcILOQR2vEmtcDU+yyd64mngY4aR8fkITeo5Rl0tSCgM4i/JyhrncsTo7WkTznTZ6maz1/t6GKbURmxsWRYUjWBDNrg5ZUiWvsxuQDz2gDFlVxLXMDwYaeS5Nqw60bD+JM8wUkik0o7X1DwtDZSpUMYz2jqJgCUSbSKXlrYglKAwQAeaZU2NdHxkcNJzHHHL1SV6Zz7Zlnvv7MMPGZMxlkgyYS/K9WsV+ApXP6yrdDgJ618gxVN4FHfmiUPMNAXFO+lF0tKONAZmPYtY1Du/DaTleBBUIPKSP9fkUutk9Q5/NBaXWDC4gVhAzi5sU1xLgU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h2uQHx38iq6HNTGor32T0SdKMg4iMKiVC7BvzMf8CEAseOZ6LJgXpJqOQbS32Hx+oZ9G8TmVdzZnAFuJ5JIUEMN5c5AzELOterCygPh6tcsodrPCPuSQAq9jbeiLqzX53VGzvEwPn6zFBd/in/c9A1wfteEex/29T8oqW42Drmy+u7muK0WZvPJQ465ys8Q13N6to/aRfnRh4SxCLXz+SWVZw73b7yr26dmNQD/mjh+kha/+4DXwYQjPqmG6cs4odoPaOA2zGs25dQh9wBb8G5gJ5BnfXeNwGh60aSgOo9lAoDzE4dk0PdV7GXBc5x2ZbsDNYfopw2xi54Pum2JawAHN1t4te3PHBBXKY3ypOBogs6AmVBMdlCfcc8XAhOG8qtxdAyXG1jk5TrioSPXqACrczj2bleh8BgwUz74offxBAGFiuz0zlnv+rjv1VGl8hWZW4MEjv2EuaH9zVh/m2Zrd+YDa/5WMFV4gYeZDKVaNOrjdkHp/FzKjP5a/tf68je/r3Ts8AiIAUf33krZwTdAaOR7NuGXDwftpSm6AWFdBmNF84PhvaJFtnNM4kp+96mxSfr5ea6ZjF2wkcUUoVUX6BbFpmt/8C8oK3Q5k+hssqNfmc52ShaOcXGVqjhUMuFqskiLL2pA6h26o33UMQRVlTmGtDyxLIA6hhzfwMQM2yV1bdVVtqZSN6B/W04Udj1F4VkVijK6ecv3yLxs2Oe+HVbpQhV6uNTPVj4Sl2NDMNwkVLiPArrndogAbZ2K1zvCPvk6xMyyyWXNXSvznJi6FRHOzNNRM4+Thg80nH4wbOz1y1S+GeAwxMOqxHSnfzmKDn2HhETszARHYDb9fWpcX9U2wFTCR3d7xpPdyFZJSwsnzHEhQXKihxZnukZtwo3G7heTNc9Y6Erjw50dvT0xItvd9pXrZQARlbpG/K6pkjYW+TJjR4zI0RWPxr+AZ
 q3iDPFdLdAcsf3skSZTXDrwaqFinRt3je62dE7lr2Wd0NM489Ez89ZsFKuOCYWvLHnXNBJwvYio9eprsKslSU8GlxoJtdKSGtRpgg7pRu0zuX6T8TXY2B/BD8XYmspPfLBjmJqNmnuPfZTjtF4u8opd4fnMBkv4eIqTK7jgyMY0n2Zy1/pKPnyXaf8ZQI8exNmjfOWnWAzNZaE/P8nrm/qox27FN7FgncwM6mV7XbTyhtPWgkkflX1Hy5gVaJ1TRHGBQZunvpsqS98YMGES9dUXZE8Brje8M9jdHVasLAgS+UdYE9nc+cuhwSfZDo9HpZTVKRn0kP/b+JNQvxhFl42ZF+kK74YPSZvT5uqom3fe9Rr7mUnyoGGgX2dfk7qB0nKU9NHG8g2cpj+wGPlZqVt6h62lNaj/vu59mC8w1gEU8YkeJZ2RMJACepCYFjlwXZQ9qFo53YEI9vFGdpzgn4CPdTtHs2NSPXDKMPe59NiLc9RQ/QKcWgCtc7R4sWsM/8OUVjUMu1MPivTOg7WahslVV5cl6OfvJFsAVGZW3solqNFAh4quUCweLt05Obtajn1AhKFBd/I9ZlyWq0uilHCpfKvecRm5vbBcs06wKksN8h8aTCyXCGgmaEgyeBcIYY5SU1JDVjDnyFfrCd4ON7w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662361b3-9c13-4a1d-cb7d-08dce15360c9
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:40.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8U/IcxSuP8aj7LmDvTvqZ+uqckrxrEKGnWFZbeB49DDP44mZ2tN0Hdcj12lcqlzrivZv2gQCS6Dcyqoq25+lmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you all for your remarks. I have addressed your feedback. I have
also added the full history of the patchset, because it now targets
additional architectures.

Arnd: Unfortunately when adding the prototypes as 'extern ..' into
asm-generic/io.h they conflict with some individual implementations
(namely m68k, alpha, parisc, and sh). So, I have aligned these functions
to match the prototypes in asm-generic/io.h.
For the um problem, unfortunately there are A LOT of drivers that use
these IO memcpy functions, so I went a bit the lazy route and added
dummy functions to um's io.h.

David: Thank you for your remarks. I have replaced the mix of long,
uintptr_t, etc. all by long + sizeof(long). I have also split the
read/write operation from the put/get_unaligned into two lines for
better readability.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- Added dummy implementations for memcpy_{to,from}io and memset_io on um
  architecture so drivers that use these functions build for um
- Replaced all accesses and checks by long type
- Added function prototypes as extern to asm-generic/io.h
- Removed '__' from the 3 new function names
- Some archs implement their own version of these IO functions with
  slightly different prototypes. So, I added 3 new patches to align
  prototypes with new ones in iomap_copy.c + io.h

Changes for v6:
- Added include of linux/align.h to fix build on arm arch
- Replaced compile-time check by ifdef for the CONFIG_64BIT otherwise we
  get a warning for the 'qc << 32' for archs with 32bit int types
- Suffixed arch commits by arch name

Changes for v5:
- Added functions to iomap_copy.c as proposed by Arndt
- Removed again the new io_copy.c and related objects
- Removed GENERIC_IO_COPY symbol and instead rely on the existing
  HAS_IOMEM symbol
- Added prototypes of __memcpy_{to,from}io and __memset_io functions to
  asm-generic/io.h

Changes for v4:
- Replaced memcpy/memset in asm-generic/io.h by the new
  __memcpy_{to,from}io and __memset_io, so individual architectures can
  use it instead of using their own implementation.

Changes for v3:
- Replaced again 'if(IS_ENABLED(CONFIG_64BIT))' by '#ifdef CONFIG_64BIT'
  because on 32bit architectures (e.g., csky), __raw_{read,write}q are
  not defined. So, it leads to compilation errors

Changes for v2:
- Renamed io.c -> io_copy.c
- Updated flag to 'GENERIC_IO_COPY'
- Replaced pointer dereferences by 'put_unaligned()'/'get_unaligned()'
- Replaced '#ifdef CONFIG_64BIT' by 'if(IS_ENABLED(CONFIG_64BIT))'
- Removed '__raw_{read,write}_native' and replaced by
  'if(IS_ENABLED(CONFIG_64BIT))' -> '__raw_write{l,q}'
---
Julian Vetter (10):
  Consolidate IO memcpy/memset into iomap_copy.c
  arm64: Use generic IO memcpy/memset
  csky: Use generic IO memcpy/memset
  loongarch: Use generic IO memcpy/memset
  m68k: Align prototypes of IO memcpy/memset
  alpha: Align prototypes of IO memcpy/memset
  parisc: Align prototypes of IO memcpy/memset
  sh: Align prototypes of IO memcpy/memset
  um: Add dummy implementation for IO memcpy/memset
  arm: Align prototype of IO memset

 arch/alpha/include/asm/io.h     |   6 +-
 arch/alpha/kernel/io.c          |   4 +-
 arch/arm/include/asm/io.h       |   2 +-
 arch/arm64/include/asm/io.h     |  11 ---
 arch/arm64/kernel/io.c          |  87 ---------------------
 arch/csky/include/asm/io.h      |  11 ---
 arch/csky/kernel/Makefile       |   2 +-
 arch/csky/kernel/io.c           |  91 ----------------------
 arch/loongarch/include/asm/io.h |  10 ---
 arch/loongarch/kernel/Makefile  |   2 +-
 arch/loongarch/kernel/io.c      |  94 ----------------------
 arch/m68k/include/asm/kmap.h    |   8 +-
 arch/parisc/include/asm/io.h    |   3 -
 arch/parisc/lib/io.c            |   6 +-
 arch/sh/include/asm/io.h        |   3 -
 arch/sh/kernel/io.c             |   6 +-
 arch/um/include/asm/io.h        |  17 ++++
 include/asm-generic/io.h        |  58 ++------------
 lib/iomap_copy.c                | 133 ++++++++++++++++++++++++++++++++
 19 files changed, 173 insertions(+), 381 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c

-- 
2.34.1






