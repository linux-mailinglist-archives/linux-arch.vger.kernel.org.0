Return-Path: <linux-arch+bounces-7492-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D698A4FA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0105D281E05
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93198192D78;
	Mon, 30 Sep 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="l/XuGBWY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="l5gvVOV0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB821922F6
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702764; cv=fail; b=dxxjUFRKYwksv+X0D2lU9PsgDVTXvwlmRjTDkijqYE2HVhX8i7n/cLUb9uAT5T6kZ2enmrT7Ey72KTKr8k1r23UAqJw+o9S1UxNy5WUiWkWpy0r48iwW1yAeK0m3hHpgRcDhttTtfaUewbjlqY9RvWXktKfGQxXVpJl3Ul1WrLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702764; c=relaxed/simple;
	bh=CuaNgoBj7v4blNzKfFjWE0ZeVmzUEMMewgXdROghgU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYZ5n7vzNG6Jy/p8Y5shxXsu6IvRutfMzHUo/uQV6ceOqLVslg2334eA6Tvz9dKeqM+Bx0axNAzLHqN299tm6erFQQWFt2uAnFxzhgWv/eS5WW0CYpt//YFphuJSeTjOY+tcorJ2OdCJgKHZ3luPACBzsuh/mM5NdeMxgGuAxoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=l/XuGBWY; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=l5gvVOV0 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id E0B60349788
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702754;
	bh=CuaNgoBj7v4blNzKfFjWE0ZeVmzUEMMewgXdROghgU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l/XuGBWYQsS5e7vCBFiR8p4o5TCUovvXqyxKuoakK6DOfwS0zIaQeBZ1HYb1wl0Js
	 iMZ7246ULWFVyWvn00Ne4uhJijGA2xRPhJLR5jdoIiy8X2F0Jgne6Wn21TgYMlOm4a
	 sRFBkeDAHDaOeEu8YiS4uWEsMRDbDWUY2iRyStXM=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 0F55B349728; Mon, 30 Sep
 2024 15:25:54 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010001.outbound.protection.outlook.com
 [40.93.76.1]) by fx409.security-mail.net (Postfix) with ESMTPS id
 173183495D9; Mon, 30 Sep 2024 15:25:53 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3380.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:51 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:51 +0000
X-Secumail-id: <8771.66faa6e1.14b42.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQ36pEGSgSs6ZY9QZwmKy+EBKZQIdfZW2nATql7cG1bVyluO/lybVBcJ4QENP7R6VBgP1TZZ+fMZyOZnDq4NjFMXgSaEeHtZ7SrznO0eRY4ITt4GGS0MkO8/z64o5uqH1FuCI5hxvpwo4T7PG8t8L4wXLAEtGYqiB1lfg+7US7gfeBjfS+6z6rNoGvOWx6GZ+P9Tnp+2d2UNdyunuwr0FUDH2xEas7JGpucx6dtQVVaIZFSILF7uF0N0FHDnN2kAPTZr8OCyjOAxU4CO48R5BpHiLdcoS0tk6PAeJeN/eNYb6ocR7fKvM9m1/Zu7qsvBBgXhSPKh2W8wehBcG/bttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2kFgx3OrKGb95rD8xCYpED1FNXXzNuS6G1ZkVVXriY=;
 b=E4X6p56B0/KK2fYxyGk3cD9xxZLcHnGLWbfan2wR7L0pzxzAhWnUMAycEZwGrfw8dMgOzAQLfeNMbNstzn0ePyb7gzD2JqdlgNVfS8mERvfMyHB5psTHQmis+17732zkZJkrhsl2LH/wNQhTwzApWrLJl6oCRi/rmR4dVMRk44GhlWUFQ21LzQ3EX7Skqtkt79t8XJMY0K6xm0n88JqQ+YEpDH+Oiq8aPhFOcgDjnuDpKJ7NDPXKOKUlBZGhL/IqmGlENoFzotgcdlPYP5XgDOsHjQpA4ahjiumpXaE5F2lf29bFTTf0UM7rvDfMK1fMwKC2uLOM5I2odaKgfBV5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2kFgx3OrKGb95rD8xCYpED1FNXXzNuS6G1ZkVVXriY=;
 b=l5gvVOV0ME0roygqYyc0B53P3TiBBSy9Cz8+T4BN79cd+9YORy3fnZkB7bDeBVBZy5PlzL+3+sGvBWL+R0+sJ8p9z/nAQPISKVkhc6iYxJmOX5o5qqzyEsoFTdYWb4XXZK+lotfHPTI7fofp77c5AC3H7oxzv4O08mK3TSM+HGFKkPFJV3shL8H/p7V1fzWRJNRcLIxUACSnRilMb4tCDqKwr16uUpc+27kCBJnm27qJKkMEpq6pafKvA2iwtLzS4E8hsuz9jXQm4aHyvl1JNKQ5KCi4eSaCHc6RpchPnlH8TlFKcVf9Aa/LXxoT3PC/D5oYPZka7qF+YsHi+/XWQg==
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
Subject: [PATCH v7 09/10] um: Add dummy implementation for IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:20 +0200
Message-ID: <20240930132321.2785718-10-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3380:EE_
X-MS-Office365-Filtering-Correlation-Id: aac416ad-a2cd-4e99-766d-08dce1536763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: LI8ZPFclKTl5xU5wCc8mTuw/lE96ZR66Dt7zRXmXjreWQuZuRemU32ZvPIVxz3oTlwZBGY70WnGpRAkaSJE27fIsqoM2enjcAUjbSB8UQ9lshVQOYpBEQSSmwVv0RHEyChviuQ/qMJzoOybHvLMTvnzuypbZvEA44/kzlvHnUsbfE5gWKMTFNg3lIx3DT5sqgN+wmR0sLylB7jsOcS2TAiun9+OGBVihDW7b2wNW8+/67Pu28G45/5XhdqOgv8n/JaDQujY6555pk9sL1J/FnnK+AudPnO8IXpcoeL3ddnngDdF3aSslyYyJ1Z5nTxltJHAc1ifRxEI9+0jG4nRiFzZxROIFLCHFkedFsBA+UqLOx/uct2BmkkRDhoxgyqdFzX29gClI2u2+LcMxVX7naAhuG/Mmips4pe/XeScW3w1cQG30VnZxkZz+l8Nd/lHSXtUiQuYaQkLs2KCzFIC+qQJKAEzqHSERhaEqbPkiDXrVu7D6SlHGXQeXW/nY0bkLYOeEcu4NXGhb5DDumfJYT617XmGWspqtdVaHWDhVpDf3Nf8IkMVWWpiI4BqOEJrsRjNC7qR3LkOLHtjeoP7JVbv8RI7kA1ZcADzvu1zKGtDAeRyKO/WZW5NbqPBq/cF5/wd15xweQ0tY8XUyugCEs4Kocm/bVLlKkoAfNuatSejzihqUY/e9P9MLPHsvDNXWKYVQxcMw6j4EaOaUrNEZ70VNp8Kd2LmafseUqDZHZDnqhECv1qMp/siOgYZkukWDKlfyFmuY2NjxaggFITExKJLmd4Rl07doK4hckjO3SRx3F3tnfryVeA6u1oegX4ZaG8kBlgl5gWg0+JKSaeV+ogbJVTYdmwVngGtFu+MfY7Od+iHOgd8TMnM5yeuPxOkdovMOojUwAGl/wRg3tNT4dSZAi3mJTfpueND0glIOIYgLMw8sK4Z1OSoLbv7URltoh/I
 Vk3gGVeNTWPKHSJvFxYDL09wQ4PHusx0eIilTvCzfiQ6s3HFcRpj9eaiurq4XVip0rg9VqKEm5BiwFMKK+6nxN6yew/6YXhi3KbCEAkWJhykd1zjzKSNK9rjGTN9z8YZcvTAYSb9xUxYNtZOiSG56+gSrDJIVO0PtcPb7p8C7Swet8JOLFUJJfNIkdxyYtWTTeKwTMxMzH8Hotm63+lLsKitEwKMHObRl/z/ZvThYNpP3xcRgGzTkcTCNmWbE9VQ6zd3eh2DCwb4OVD9mFBDoo8Y855XxUFq9vSDPeUOuw0CpEPzBrwk6TkOdaKlkIBqJpnmWE6zyzRsPfxPf7Dj8Yp3F+ObpCbK7VNycnbR3uahHCgBA9cBS7Flrgtd58sopCDT9NutTnqcKG/+gFLikoLt5xPISDTxsbwgH/Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c2uoOZCorMrgrZTz+vyTyAYJFSqenhohl2WXrqFYGOLCN170+9Ry94zxTZFoIR0iPN7gC97nxLSk6wCa42FOTSBqVb73Gd7bsFi77k0ZZkcVOs2xMuUOP35bc3rMU0/IqIbwta+GPvU0OpK/i0V4zQhY5JL6FCa2U7hsWZxeXHUJ+/qnFxuSuSHsjQKHkHCRcfh+5MsnRg9xDtP/RMWJG1mxYM81QbHwhNuH/wcthHfb5oSh/bjAfSpToRqoE4CFKGqfvkbzZ4ej8iKlbPkgsmAG1RjjqH0RvwYai0Y5ZgJyf/u9xBOi2/HKMxAwHyGU837cY1YedoQdrmO9TTsaoSW4FlmdUUsFBsmvnk2MKRfLpKW8TqCD6sc23f40kT/g0TmQp0ZDK9penFz2mr1tTshGat28xN93GqfDBTE1NLcWU/o+42vH5p8znHo2Lps2Lt5RUJQVv0de5ifhviAbw+0V7e0DmBgOhLBr0qM+k3h2/1WAux2n9zzQeBWTWpQjO98k5oQ3GjIH/NCnDW2tBQKL42XPXZadVdFci6rmh0qLVrlz4YDNWDOQcTFLOcexwzZrxrIHpsCdgMyO9DqHvUm0DJuFhLOdPSDTh36VsKOM43QWo1tPae1GTnt8Wnnt6zD6kcIkKXmgdmJPFFR/kClF2HNMl9NwR9q7WSrxX5TGm22ZfIhr+YKhL3smwE7mGNQssRfVOtncOUC0rMhWXfAK8JWF3/aDFE9n4M+q3DPnANHUAiWcl3ro5yY4ONE9hUVPRdL5hDuiYwJjHv9nXs8HBFIJRn6oMrF1Tw7EbcG3GTau/QucoLM7Z9jKxyDr2jKIUTyKG5245EJYIH+SgjW3ilaCcNqaQzSs+hwB7FHGNZpYfcuC1Zq5H2QVPmyVrY5MBaUBtwWd39SoG/1uhmdN/SmKXGXbC0lhGfYo0zHBlTB4YlpIaznVnEQ4/uGW
 4X7VbLPy1GPUONoDm5BMPf/sD8Js0OKR8kg1DSS46WV69LZvTbarP53ml+85Hk941QQZD0UGfHpzoxQXps+X1O8hrnVjKhRh432e2UtDreDhJpYLlFAlDlZn0IbEj24vD2Cz2KKE3pxY/OtI0p4922Mg08uKd0hIjWfwwFkpEy4C5Gn+6VHamQfLCUGYZojRde6CLQnP9UlCiKjvXWdGXs01aj5HGzY7aZ+q5toNgfM5AnfDS0RLBfPu4c2VeFGza8k646GvPs4BXH9iB5bmA2BaO9DzdXR0f6ADNC3DeHVsr9UxsKXal2ToazAz1D+FGksI1qGRKtObG8iaAVT2Rc6xGnSdc8wNYwVhsxfSzyFe9L7JZQ4OIRzm7L65FJJHUSrLpbx+KUOYCQMwIzuQi9tPe2dzMP/mJkbGvO6NgaxNMB8bInXi9pFqvg6jTB/KcwPPfRbAYfwtf68R8vqGbcdE0cYk3s+57kN9zdFgZ/uOd6mcRGgcbWMTcnm/ubB2GKe1OAkepYWhyyp99iNHsBere3+2mxhw5iaJyiR1M82T0S0kHZ27TbAOt8+q3rNa7Ahf8FfMETTrFmPdMYQvY277sGwHc+p8QcdWttmxT3mSQ2NvayU6IWEINAO7ejif35jF0dgfb5rHzDBKiO+Olw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac416ad-a2cd-4e99-766d-08dce1536763
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:51.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfUq9OYb9VLcx/SkvEWJ8eaFZY6bHvzjcpncZLGrW5mE/dkB2zoOkphDbhtS3tXq+0w31Dtp69m/dmcjp9qwlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3380
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

The um arch is the only architecture that sets the config 'NO_IOMEM',
yet drivers that use IO memory can be selected. In order to make these
drivers happy we add a dummy implementation for memcpy_{from,to}io and
memset_io functions.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- New patch
---
 arch/um/include/asm/io.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/um/include/asm/io.h b/arch/um/include/asm/io.h
index 9ea42cc746d9..f02f40609798 100644
--- a/arch/um/include/asm/io.h
+++ b/arch/um/include/asm/io.h
@@ -21,6 +21,23 @@ static inline void iounmap(void __iomem *addr)
 }
 #endif /* iounmap */
 
+static inline void memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	memset((void *)dst, c, count);
+}
+
+static inline void memcpy_toio(volatile void __iomem *to, const void *from,
+			       size_t count)
+{
+	memcpy((void *)to, from, count);
+}
+
+static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
+				 size_t count)
+{
+	memcpy(to, (void *)from, count);
+}
+
 #include <asm-generic/io.h>
 
 #endif
-- 
2.34.1






