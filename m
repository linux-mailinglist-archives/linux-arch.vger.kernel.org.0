Return-Path: <linux-arch+bounces-7493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A898A501
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35F01F213CE
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0610A192D98;
	Mon, 30 Sep 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="T6WuN4Gk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Qf1arsY2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295B192D62
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702765; cv=fail; b=nVtE13hqJe1BSBv5fEzmwT5fZMRU+/WgfVsDBtOveTbi3/g11S0+EGPmytH8rNz9yKyoGOn3/uJUUjwW/AoEs09i/L3oYisURDWZBkvG3Ihct+PMoaPxgRM88c0voFd0pK8W8gvpFCcUt6dJihLzfdF5vHnAhaMQUoM4UMvBkHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702765; c=relaxed/simple;
	bh=c4ChCqy+77TD0CKHTWj1/BlD0cy+kDAVMgr6rbD7Vs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVelzbAdxe1yukuOvRbbCM1+f5KnMsE5rSVPjlQBCAJdUzv1I2TAWzRxfZ8Nn7vRjOzJyrFisenPvvlQb0prBs0cfnAbS/lpY9FJrtAjLfJgnEIlvetlKaZO68clSUxh7yzHqb/t7Exc02WN5uWMxisb93rQkf/sBWF/hJLUUKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=T6WuN4Gk; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Qf1arsY2 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 814413499B1
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702755;
	bh=c4ChCqy+77TD0CKHTWj1/BlD0cy+kDAVMgr6rbD7Vs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6WuN4GkLTBnOnQzjpXBsNjlyGZs8tMV9MZ7G5/EGuSDv6BDNgDWLck4Z+GNLuyaZ
	 i1anVWrf6Ah7RiQZBa33YazR3bPqwaYkWzr6pZ+8cVRhzkWmrrUl0bIX6kYruktJHP
	 CGhkeTxARFa3e24lxvrKLAqsXHksNYzhs0keoFfc=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 3CC6834991E; Mon, 30 Sep
 2024 15:25:55 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17010002.outbound.protection.outlook.com
 [40.93.76.2]) by fx409.security-mail.net (Postfix) with ESMTPS id
 968E13496DB; Mon, 30 Sep 2024 15:25:53 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3380.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:52 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:52 +0000
X-Secumail-id: <fc57.66faa6e1.959bd.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xeot45OEz7CM7wptuXcRLuw2nYlFLgnwNQOwQ4yys/Y83ggpfqS95eDmMf7YGl2TlniYOdFX6ilppVL51dT4ooh/BmsR/OOr2O59jd/hNlijrBygYh29+yCQE6nrAOGuBoRmHNmZ8V4Son8WuSJEiuC5hxeX1RbRr8eA2GGmF2Uh7eoPEC09w4G/hsPxYtthv9b3mGplgE+wd5eSwB9gbmVU41wM6gjrgb/6GnGMDto7SG0ceyzqNemzQ+uuyu/M9IfQxUVMgBQSTB+U4ZdJdPrn+CwfhWNX2qI/VL4z996W77cUw2XGFaiWbFOvpv5yIGKSu7fmRhIk/skCRMw5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dml8N6VAesR7nQQrYwXXCvPtteQRS7kBStRDFq4kmk=;
 b=s3etQKGZm0esZmVIXvgNadVHDSvsMZPLP+Ezc5fG1Tu6abwIkHB5WHw1/6arADlOEH/cmHChNmbdNec340FgqdYH7vg4jNco6mYYyIrpXSFeCFksngUj+HlhpHMSyLIGAhEQmleK25+1ptSQMYfDMokurDNTBLaAo9Ttwe1hmfKl/8gmqiFWHX6MmZEuOEnDUu/pnPjtnSx4n3LZc+L7fQ74Dm5utHnz7IKwy2ATrgPduwrj0ynywP8L6YrrwY6A52+Ej2cdqbi3lLG9TnbtyZn+4wwjbHZbJIOXujLbGJoOnGeY5UH+Fe4D6cMNk4Gs86f1Dxs24q9S4dWfTJQKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dml8N6VAesR7nQQrYwXXCvPtteQRS7kBStRDFq4kmk=;
 b=Qf1arsY2ccUd+Dxwsc80DVbRX0jG37Q9+evoXJ5VbLlj91JMm99NZb11253x1EEmbhy2EstFfbrF06Lxcx785CZz9uc5N7DdQ8+9ix3uAlKsSm4VHXbZolArnYOC5QJik8oYVKZ0PycZFW/plahCzw7Yr8rPHDtD7BiqHo6+HlDLzETLFFT245YcuwZeuJRdizueRykPhz50k1O5lgi4ELIgsG/mD8+kpyf95+NsWflo1FifgdTe5L7Vw6dKAgFstAmIbXePJw+UKuEanR2PwoSYCDuynHULmWm8w9X2jqdeX8CK89Ke4uB+gKrLdyqQIOwX4zrWpUQAVgowxRBBHw==
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
Subject: [PATCH v7 10/10] arm: Align prototype of IO memset
Date: Mon, 30 Sep 2024 15:23:21 +0200
Message-ID: <20240930132321.2785718-11-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0075e09f-0570-48e7-31b0-08dce1536818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: ziWkUfPe+9JCgk9UsXBq4m1bq7ieWhQcJA2ivdxLUV/SvGG0R4ENgGIqJlcTKPD9ag6guRj+iLZ471M+BU+bJXuKXdMoFqi8D364lFUUiWXnhqUtZbmvQBsF27LZ4Dp1ivrxbvr6Uo013AmdVJ32rgw5xp6kGs+mklWiBgmuW1/sEsKyK0y++Z1j2Z/WW5XvIuleYjH1KI7QBzyFebpBvbI6z58/sZbFXQJUnxz/017CAscVDHLf+qALqwA4Qz5nrO+TGReomcyMPWtl6Cjd/teV73CXo/sZkXt15HG+59Pg5NaA7p0eUXNwBC8xf4XqvyLT6dyQSSXPj5teWcDEJR5VqUDpFYsyHjNK3QaES/JXlCbD6lauHOFah5QrqvIFk5ophKGie81tscGiL59uIc0Rcvn9IyIKIVLgKb1Z8tDGA+hB8LlKuznz0uAmeLgOrzanhm4y/bLO4LdaSKca/Dj61TH3KBAWFXGWB+c1QFX3shxS8zHdFL4Pufi34rzBYRgT+ssnorw5xS1b8O/gXHtgbI+dapaWRlKLSW7DgdCNGSivvzIRlmeEe9GWIYszE4h8ndzMMxjw8+xDHHTbRY/o1+QgbavgUqoQs5LroFZNK5rbHYsdLefW4aSHOT67PhtP/DQ+o7TFF1AexnTctpu7/6dPDdIJ4KWpw77igkCnn0kDSFmCJmoCxHDQH0gAkb9RUbWE9rcZ/RzMyZdESa8KMFOINzmzF8InMgXntAfbXlGtWA1B9pmGWIRynBvqRgQUGeLFyUiJ31t9MLCkefjK26pT64sWJmKUBb8htRAAsKasZszzoAgkR4YRjMPAvkpGyn7oqOtNGpYHrbVKQzmoCX9nQmPoatXrRLFKbmuK25Ks6OVd+US8rmTavfbPhG3pEvvS1IloT3TB3+mDhSBQ2y5TyrusM+sH0NCxRUJj62CBnPR6FEtak0+qRi/hDIz
 rGAzLXNgXpMMmAsq83OnFCiv7umoGMCZQUFXAVS7JSfiTYiUEbmW0Hlj+xT53DWBUCQSjSYdToJsGtNAlSCfFiP2MP/6+XNMyR4EJdkY6HIAWbJjSk4letUCFSNaWOZmKR1IgvNaPGK1Jxf5ryye97YaloloxldD99Z7lCYIHLnYfKLQPUa71GWj7V/FM3FNZ9SbwgNYrS0x+suFnGfbepuC5AUiQFZ1bJT+6t45dxIxAiIx2k9HXkc+LqP6asx65Zl7LN4x04Q7QphH69RlGWQ6eHC0xHVb+bmTfsz0FgetyUKioGNIQbWOUMLqi9ZovBAbZ3iR0h9foc6xgixBJ3WM4vvrjLjFhgwS7ZWPE/fzAyk9gkdH+X+X2e7ClahXIys/qQWaCx1fIJLt3XRCTUYzyCvzsxmN9JAYTC3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EmUv5K4uQt7rTYirgV/nSy4/5mpZhe7gEobxnoh3Sv1tSllAphLiwyMmrK+q/3jsxhYqQtmgwkGHCpJRm8i9sSocx3ot0mnrjnpBHZ+YEdjrAv0s7HG75qpTo/6zAGsAaeV9pT5HRrpibS+Y97ZkluDNSAoOAkdl1Tl0wRm1h6Kb7kkIpI7rpgxpJRu3P1U3kZrFh+flZFpOe6BWVyae9qkPX++eSnX6DYEr5aenJ5NMM4cbIG6lNmlFi+VF3tH+CCty4rxEu00h4m2jQATVkvGlFYnvz4AomhZPB+CkO9eJy12M5kVEz2HrGmasjpnGyyc3obRQK7/PIg553Q099R55KcTLcgINBjaOY064EvfpNiMjoWks6Izou9CvY81B4PLhkqtOfFKhPiac6OuG8wOHSKGKFH6rESkEMKA1+QhiT+S4+YFyao84pwguj0w1sa3bEKg68tlDQO1HbfLzvoje8pZV3QU38cCapmXOKUBG4busaNh107ezQtu3OJoTLLI60sQ2L08sm9LVNoyK8VOdGa9yfIbJcWefvuUu1CQqOy6TIstsCUVYfXGcnVhaDKNmGkKLlcUYyRx0AHn6jbiKe95naPieUVgfUlw5WVub04IciT56SvzZdJNNuvkeNHLKFBNNVVpQc+YYrQvOUsjm6qJbeQQ1luIKqjzLZLPCLmcsS/d75idiJ37M6yGFE2lABoy8juoQy1MU3EavsDnKpLb2ZiHUkstAjtLPYpAG4hUVA9eX9J8SEQpK50NZiXuuGjucJ9baMPGhRKItx2N1fOnwZgWVc2L5WsXvFz4BqzvGH6AqNXxmPusMGBbnTsrcY9Zu3Aa9oMPVyqNPy+HaMlgQi51g1G00D4W50rpbmkrIzbMm0AFSTx1YzE763LBW7GopoyIq5rPSdD73LqP8HR890OqeWtX0MiDAQTH16oVBM16w6Cptt7ozvH6/
 Xgrv14DKVQwoxbfAkTmpMiBdheqagX9XYnFX9oJG/R11DWCMlSOueUZuuCxwVLP98kEhh9o5AqvTS35eokDQME9TEcGtstr/ZdKiDoSkVi0JLkf2F42wD3JOtHzf/BdfGE59jrAjjLLaAcoOH3/EM37xyxIg3klJJNq/OmHjul2NlZDzpRHFGCqCwKHi+r/jkY7NNKvYBn+9HyquDEFJCjvAyRWXgM4tkR1m6xXzDsZWi7+En9i3gYYfuS9UU4MbiVqOuef+OvTHuJ4dOFa+xN9XWIf8EJpCiJqOnITdNoAjqkGFIky0m7MwH1PN+ziSYU+GqS8OGt/d32QwQx+8T7Mvt375FNJNM2xUx6OzWH9vOqwwb97v7PRYlc2UO3tZZT1LD8uMGrG9wO9Lsu2QK2GfMN1Lbz0+PxcWeHjBw+SkNkCQrg3buEuy3bidnsf9w+dXtCzTxBrVfYZtg5C3+h/8v/3gXlnVcOkSmbF/thm/3J69YDK9HFSBSVZblYLEdGju5Idkl858pf3btOowUoqiiBzwRH8XTd9fD5JXsh68uYn4T/B9gex4bKfveUwOgBtJuwiYQWqzqRrq1LPLut2ZU7o+X/fvkQeH3C3B6W1Xx+Hfvqqi+7qTh/hd9teickdspYXWQ5c1PJ8UclryKQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0075e09f-0570-48e7-31b0-08dce1536818
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:52.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrP9+5lFU2nuOMW9S1J3P+62EhmCLQD/Q+V8EFLG8IUGzbBm/oV+8B/kri0RumysAoq0N8J5UnV592tGqbXjvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3380
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align prototype of the memset_io function with the new one from
iomap_copy.c

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- New patch
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






