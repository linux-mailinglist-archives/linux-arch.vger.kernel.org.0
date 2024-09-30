Return-Path: <linux-arch+bounces-7490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73798A4ED
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9851C203BA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F2D191496;
	Mon, 30 Sep 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="liQSeY76";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Bl1mMN6s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEE189902
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702758; cv=fail; b=U2g8QHVkB7pkrk9XCq2Zr2JHDgfMtaYMoKZe8UWrle6El3xHHHccusKJIW0JTbcmmLGC8Y+B2rPLtifRIUTgZoNt7Vz8G0YXvCRrdIQ4xK2xVVLwmADMUzo6eEF/B6T9IfzAf+mgM5IdBiwWScWLWsA66Sj9xLJ0p/Fb/7EWHXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702758; c=relaxed/simple;
	bh=l+6JbPPfcrbsjMc8VhGRP7eVT6FZ9RTFgE4HFSJ502w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sk/JFd3QES8nnZxtJ68BYUF7pQFUsWiU4EgTiNvjub3yAI51F1bdo9qUYZ8fOH/CBaFoCmjfRVMpiW3VkH1cMbJo8RYraMb7+ZclQ1f1NHBAZZHlJRb6dhtxyG0cxxU3foDOaLxADi8ZKC7R2G1LI7tSxQyEJJx8g9n1WgCC12A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=liQSeY76; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Bl1mMN6s reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id C4F392E7B73
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702748;
	bh=l+6JbPPfcrbsjMc8VhGRP7eVT6FZ9RTFgE4HFSJ502w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=liQSeY762Mi4UC/RpBsTTXaS+2EweMbvNm50/OZR+gS+U/aP4rgjpVATnEkkL6dyN
	 V9D504tkjXU7tXtHx8I3DK/tfHt+Wjps9tGR6wiQzZVCW171ukDqRnUL6LiAvEK+ti
	 QX3mTz3gess8HpAIdzaYvuE5Ug3CyvDX2cIebTHM=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 867A72E7B72; Mon, 30 Sep 2024 15:25:48 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx302.security-mail.net (Postfix) with ESMTPS id
 E0D682E888F; Mon, 30 Sep 2024 15:25:47 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:46 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:46 +0000
X-Secumail-id: <12ea9.66faa6db.dfc20.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7tKKzZgkgx+AUqbgE0gjkXFFh6B9n9mlKDIK4pTSdEX+zdSHE1Q/78MCfev4UVB9A//1+NPWdAMdpwzl5gNq+HPNueDs6atneoT0gcepPbBT18mcXOeFoUUUs0WMLdqespE+zIH1I9I11pPFvGoM/3ifXcaZfjZjIM6d7ca4boQgm0FKhvd/9F2kM1VjqjKzBeLaLWC2HyoFy8lkfbGL5Lt7R8+SH7jJ6RB0tBmqAMKapSyD8hM8vkRBsZ/aCLQg7R+qPzS3eug0GAshQyCYiue8dZICJS5CV/5k2VOhZRTRjak1W3RLJTiRJ0L+YmJcirfh+C+aRYlW/RA8Nd6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khkWHB3uDKKJinOrwNSgberVgDgBfvifmQLEzey/l6o=;
 b=B5sa+TlemI+A/Zutyu2CgtMQYwmiQ8Tkn1BvcV0qa8Tp9Z/jZLjCYiHF9kDK0g1AybaECUOYnJhN1Obf8NLIog/LK28SSpXm578XMUXXaz5zhxPTrXzBbo8Nxu32AzRaJD/ZsmZ9yqEuYs6vBCsK3jljLygkMS3tioiD4rtoWdsI+lgS4aFivxZZu/i8tVJgDhx7iebYbKcdkelFv1HiN4lDKKzNavUGVluvSEV7GWM8mQxzGS5gPcIDKE7zR1X6K2OlBXkJG8Z7WuJjjWQuE3yNtbuX2b75fkmbfL1RoxOTuO867xLl0w+mtvv6f4dRr43VQ/wut+d2usTIC68Kpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khkWHB3uDKKJinOrwNSgberVgDgBfvifmQLEzey/l6o=;
 b=Bl1mMN6scU6/FrHO9xBgqKFeI28AURnYsfb+BwyElfNu2kGywHegW7ujHGgo++A9fge25F0UF3f1QYO2ZMF5I/+nsx8dpSWdYZRJw94Gi1rXhXGdNgG8Fn55yB/RW1vibaKnkLipOdFGJh4noFW9r8jtcNOuJeHMvzCiWG9wU9nC1KkjlSdFPc+lAbPM+OHSI118/kQYkZ73+H3ubycmoiuHMzsRoCB+iKKoLtH+GVXsAHF0YSRBTKuIimN8mj0qy9Sg4ubvChnkLi5bkh95K50JKXDBL/YyzMdJ8ks59QRJhrMVtFh178CnCZo8oNFpMBqx/9xhyttCz3c5hTSApQ==
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
Subject: [PATCH v7 05/10] m68k: Align prototypes of IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:16 +0200
Message-ID: <20240930132321.2785718-6-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930132321.2785718-1-jvetter@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7767a78e-5900-4c5d-2f1f-08dce1536495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: GntdftAoWruSqVAcvCUiUF8q+yFeGzttAtsND0vQxF0q8usJHg6OQ5+6LSWA89L2VhWp2gN+W7WJoU26kQhi8yWGAsrXDq83rYomC5UavsxyuStA5brVJDKKhUYnwsGNj5xInUQlgSm6793Vz3Nm8UUExL7ooeGTbZO+L/JM/3Cz4k0HXin7cw/9EGCbRJsjHxW7qvSZEv6A7uyrv/qrOhltuWOwCsB8ZtpGJrcTaBNUnUTSvfsnX6v7eYJG9TUS4xu/VfB44V7dPPJNuDXln7i6aiFTthuq+F1yJ+Uz3yVcSFs15BSh7K52KXVnPVCb7MVuu7gJcHa9MI3XOTtEA3mCHa+Q0bIQCu4KDpuAAycBdCVzrZm4i+KuciKUoJiNTRV6Nvpoai5fQD7yi3kE7u0338p4Fyd4Q1vDdzMeC77vwhcWPRG+zQibZ7Zu9bYi588rbsLBXNZEyEfIIurEBHa4qUx6OQNjry2CzuKuD5IU426crF7uX+5vjvEA9Y9efcpZs/4kUcjzNXAmSH7faUolDd24JB5E2ST066cx9LFgrsovgYqC5Co+Llz8QXHY/RE0+Xqe121+EqkpHITtSh0bSr9FwZklD/OFa5asmtfr0cG3lPx33/kYL6AevVQ2I3pOhMDkwiiXjU84IOqPtHtVCNDVVYcYRX5onJunfc4uuzx8JxlY3iymV2btQ1BUXNRkbY+O6P32s7AZ8v1+wXHsvux2gV28ySYW6OK/qipnjiGg8ywH6zzHHqgWsXK7W0JsRvso420vGs5cP85c4/dyLwx9C9uOk1byZMXKr3cFImsJIq/VGJOk9CVxL0wYGUlhmhdXPIEDwGpFpdE7zaaCEEOwWg0YIdDktpQ5IFUIky12UR+jKOGYQq1BmNyIbtuprAF7nIcrqHLGamMGKrEr7LmPCLmCSfY/deahoVndWdcCFSiWl7So4GrLIbJZFWj
 3tTfV4Zg4StxQV8ym/2mps1x0nX0ncCj4KLpYtAomIuDSPfw/4ClIqw2LnBb6mTu4GiB+PZ6qGhVZC/SEWDJ8ZurcRwEfo0CDDHTsSQiIC7UkFQeOqGmeCLWARXckseg8Ms9xtuQeziysLPlrWbuxsyUGxOaUR+gMOBpNPzddXjqM7jKrhEck0O6eNhQPQOcw/NAoDDPPULTn+b8VzxugaiUtu7+ic0OnplNAzyq7NJObTaVx9fpI8He+YqFTr/t5+4/VfhrDWxFju7LhQnHKrgJ9UPkC55rJDVAkGWbtrxoqVOBo+M2jhKDYKiJwT06+x7kizP6kucWJjIg13pCsuT0XBNz/AftkBu5Dx4ZO3+AUtdroUp+t57W0siZc2MvU33zPpGg1k/QmrGuYpPaAri0ObYEIcNQtUL+ifjALiW1DAO1j0ZuWu4UChJSDgKa6hxe/XsBWfLQXWURU/KOpJSdfp9LcQ0PGo46DlUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lJmAdK003EAhJFT6TqNutNjyrksMGnu4truJwWBDtbg7pBa+46YuOLK4Oq45USdWRB+WrS2wFPfzANT5WPGFqVUscQJLY3K+fV8Fm8l8GQ/x3x2HDYmnpW19mtBVC0Jf21qhB7fMXqRb3rcwgrtktJFqpbuB0OOu/2zeG35+HdbZ5kFgRq0fVSL9bz3G0O40i3uc6DbRCbesNACh5Mr7VrbvPGo3vAKh5M9PNfGn6IvT6XgALOt3JgSBQb57aelfBjCgik5r+qvJ07+Inv7RW8sEWmQa9xiey6OVIkEyTp2oiOPC7r59JhHSxWINcMZjnVGfnGJqqAmZpiwTZFh69EUtooCRlHZN7U5K2VcjtdpiLidYlZYh3QOA/P82NlCjGnwDr7Bd35DuLHREcbb6pMoyasdjHd9WtUlVsPc6jFnWzscMVnbKL81PwnLAyf5U5ETUocHvTyPQRVxCI76n7F+lvco2/J1O2kBX0525b5ZC44c5ifrmSrhi6hAuIQJHR1V5lRXI3d8IK97Mi0zIp/2bgxKFiiU7ZkWVlU5oP7Km9H2rvZrmribnTMKyHCTcuNSHWCem/a1mHf2ayX2vTpCwQEHbMNfIQFucO/O9XP2Fpusp4Rn4LwBtFRYM+MWboA0H82bZOwoZdwmCV02sRHzg6ixpxjr/A9h7oY4/2/qlWFTzm9hvxY9pZY6WZXlpTqzOAG8r8o7SNjkkyIjgVFX+dRrjbPvPIrP1RxZ34eQQCgZZ+SN5O6wN3APMf8kBkgttuCmU4AM1WqLsFRAp7Ks7FxpIyx3iznxdV9r0kxk/o+Fz4s2VJPYlZU8iW3mxo1xwRasW/dj1boVMhBBQ+T0avWS8McmlujRw1OhgCYK3JepV9PpCNchxll7LRCVUG8ISvq4d55FHW3hvyt622WkFX333WmkDfcjLaz+twKh5LKM+wPLwKn8Sf9gJxtXz
 4p55dBYEJftSo3XFnMP3raLtRIWd3Wt4wL3t+Vw+3qNrViYNK3R61aIAk30ALfrDdLgnXnxe8rLQ5ySljbWKhdXeOy0TJn/CcHXFQGh5Kn4vGHPOjgmGVBwc9zbEr7BkhIHdeKyIR1pPCqgswRnlm0BsFq3a+iAPhLyqW6nA9KRD/JLAoTu5pUHw0tJDzTUNIQ1UsMZOsGpjEc4s3fIgUFI9MS2wHYBIcuVDE8M1BAr2587z1LxAB76gfA+bRn/NswQpS/fPhWImY2geITVlz8V67nH3pWn/djTy5y/7DKuWzl/n03iLeIArlG0Qlfy8j2McEDNGIr/O0wO1sWisuIBUL8WXpusO8dqMY+EkvT2GeTuqU9jnSDVAROCTvLmPxadX2iXEOB5hFeL+9vSFeWBRko+V2b57JxlZ6+YgPaEXxgdE+F+qS9aMo6VmyHykzXKJ9Fs7AdLClmpucNQvM/whytC3Ys63PoJtqMagKXfi5UilRldrq0kQJRJAi+N+0QFlOgVdkbC8n9YFTCx4lBv3iIhpHzDxqPeoJOjJYGAF2zpQHKD0RreOMidwf4cbNjkCPYL6aJOHogneKD0zV2TqQBCK98Hsq9wX/Y9nl5AmmFLYY9zftU06SSXGDFk+UsbFWIXMJgprfrOUe6FiLA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7767a78e-5900-4c5d-2f1f-08dce1536495
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:46.7066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qd7LrOhO6HKMCosUtaM5Uyo7hOJ/SkL4Nz2jRjeRDdhNMoYJL4vAn1fKGJk/Z1as41J9RnuBr3mjkxKrp0yGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- New patch
---
 arch/m68k/include/asm/kmap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index b778f015c917..e459f1911155 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -33,22 +33,22 @@ static inline void __iomem *ioremap_wt(unsigned long physaddr,
 }
 
 #define memset_io memset_io
-static inline void memset_io(volatile void __iomem *addr, unsigned char val,
-			     int count)
+static inline void memset_io(volatile void __iomem *addr, int val,
+			     size_t count)
 {
 	__builtin_memset((void __force *) addr, val, count);
 }
 
 #define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
-				 int count)
+				 size_t count)
 {
 	__builtin_memcpy(dst, (void __force *) src, count);
 }
 
 #define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
-			       int count)
+			       size_t count)
 {
 	__builtin_memcpy((void __force *) dst, src, count);
 }
-- 
2.34.1






