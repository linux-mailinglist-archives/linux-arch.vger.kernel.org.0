Return-Path: <linux-arch+bounces-7489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBCD98A4EA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAF1C21267
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D81819048C;
	Mon, 30 Sep 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hABHCGPe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="OGtRbjUl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2A18E360
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702757; cv=fail; b=gkDOTyLlwR5viHmNfh/I1ku3opgkcyav1IKrCJl1MlPSoqsBm0Nab2nd1BwHrSqJufWXkbS9btBSkVHZ9wR5RM3cFDCH9zsyJUo5mQWyCq1gbJ04RQfsXuxz6isNYYt2ptvCVneIdsEv8NN9yWGkDwXwzuy/HkRQ5DHCeefWfBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702757; c=relaxed/simple;
	bh=nWqO0QL+65fm+WurM0NlniQ15NKAr4KJ+9V15ogPZbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeVQ4o57yYQLBXQEwO03bOq/SXiaO50GN8UYu9J+1DyqzmpbAQcQeox/qKuPfgPzeLW1l9BXFrtCPfx7IfERPiYJvACGx+98uN8q60If1S7nQlE0HZKAPyR5TBlkgjxdWv032dt8FsKfeqPmrko9tv/z3di3yBgbiQ0+aX0hbYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hABHCGPe; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=OGtRbjUl reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 0009D322E50
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702746;
	bh=nWqO0QL+65fm+WurM0NlniQ15NKAr4KJ+9V15ogPZbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hABHCGPeYYVJclb2nqIyWrVkmwwiwDmJiBisj6XF7VKgz9ud1FpLaHWVI2jVc9iLX
	 vRd3FsLdydkW/obzFsoysyBpIJ0TdzLQ4cNhttzqqO4mxgpEtiqxFh9YruxpCdkYMZ
	 atUvm/mRfjHIeMvvd+XQfdWBf1wzCAdR1uN0niOE=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id D8430322C13; Mon, 30 Sep
 2024 15:25:44 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011030.outbound.protection.outlook.com
 [40.93.76.30]) by fx408.security-mail.net (Postfix) with ESMTPS id
 2489D3229BF; Mon, 30 Sep 2024 15:25:43 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:41 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:41 +0000
X-Secumail-id: <7729.66faa6d7.22950.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO4Qv1qFhBDS2Fz0gn/Yh7qXmluyvMRUxNisuFWi4utrmGYtkIjGlvUa8IRbRbpTS6tPPBKrD8PJkuCBblrFEgu9boS7/dXrvtJrdMx6AS7p16XLrQQ3kOKAhbUGN2YI0VQ3rbhjMihIhf+BYf01DuhRepEDxTQ4rHect9xcK8IeQtFoi/edxyYqzA0yFXVNPOXqIXGEleUeWly7WwUazpB5d+eREWmXemJxY3ikhMBFT/rmoc72p55QDqXUVkpn4bcD2zixUobFToboiyDnz5380m61oLb7TMjjcP4L/ECSQkvTEmL9tl0a+fkBR6zZglIQpyKIAE1xFqgVp5imJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f3WmYjXpaO6AIkIfl3JK5mS1Des+a2xdPN2jq9sLaw=;
 b=jwGcOhW34bSreeIKlsM0HDgDW9oFpm2BDanENrNfJIEm2AhcTy4ZDstPcObK2jwxFEJdtSr4jJLwu8m77mh43pi3gI+iYBe21EbsAlIH34PxR6KcUYwLkjXjd4jpkziizRUdnoso0Wno1EWL3cNbCgRPEt8qeqCnOQl3T4ml75Usw+Bt+JOZKGOo84zmYCbGRUNbu5yyWmlsLNFQ1iyr0INK3NtUcLRxs2XkmOF5FsR7qTb+PDQbL8ybuYgNe6QfHGeH4elvEmMXsGJlPnKp8/nmsgkdNUAoHz0KQ1ERSovS77dmIJZjzEScICPa33t66uJ4JgTKdSckUVzowWYxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f3WmYjXpaO6AIkIfl3JK5mS1Des+a2xdPN2jq9sLaw=;
 b=OGtRbjUlJ43aP2I+pw3gzdi7GdTp1Ygdfm7Ui//5vreJoFjCmCJja6RegRbtMTKlAgPnZDbjWT/3clBCUrn/013/6EjctA9U3waYea0RU9BUWqhMexUqe2p6oP1pFPSJj7aXSCVRl7nsLv6xjs11JybEvhfXLAQCazSbFSSnMJWI3MnVW2YyMd0b/MXGtsEoyK52lEUZFtBfLai+Lwtw9jALSw1Yhls0z/szoWHOHT20XHNK79QmpXkEerKSf0ritl5P6poRtKHVpb0uBCC8G+H+5Humo4RjcZe7u6b7QjmGOSmslK2QmNuCpX+o+47f+qGdLAPk/V6zkyAPhxHRzQ==
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
Subject: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Date: Mon, 30 Sep 2024 15:23:12 +0200
Message-ID: <20240930132321.2785718-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: c587103e-6762-412c-95fa-08dce153618b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: sUNv8+mg9YLPy/ODfDMP8eSEj7GsC/envdXj0km9XhIkhlbRcZ0Mj/Pkdjp1R5GAN9CsRqSSRJXaV61FYMSFQ4cWQB5kMAwJKLkzGj2eF6Q9yOU9LZyc9r4o99TyBLtbcP12t1rFey9dFHjhnQwLALb0pwY5Oc2YVy4nUvLyNIjjpErRMJWX98zSqi+fVoi5ySa88Yvq0IyZFWdusUASfCq4j3DeJBq8aXksWmjBQyLvjebmof2RPhPp5VvR8lw3ts96Lxd7e3goZTQawNHzNlQ8s+KAaU/TDBhgFDNl+Fdl6IKEQGNhMLV+9kaZWEb+h8VrWVypWbB6zhMtENbHR3bvUsBTy+MLJbpm4SufZCfTHiyNd1cyZ/E9P3Hc0VskPL9OUqvMFtfBwDRM6VCRHATRiUcnmg/QyNGStlx4ghIRClPzmRqRDUN9SHYz233oPwNEUtWDynEj0q2dAZpK+aMJo7HJghHnW8xM5HPqAUOpMPtPh/DK241jU8w0nyCqWS0K1+Dw05HLv5y/t0vaW0o+nKBbRMTFrsYz0G9JbwBRGYiJSqB4cf3MhAVu2Fc8fafoz/lAXIljER/eaYmAW2XwXD6ujFyGFAdk3xz/2U0YjupduUVWHslb4z6uszUS1h6J20h8jqXK70PE8axpaEf5pmZW7wgHFutCVfZ3OLdHGk/rLYTJqsVdl95tVzQSAX4mZ5OitURn/BxVPN7GTxulvk6V1ZSiEunrQ4n84zWmwHQdBsEVn8WphX9FT6Zc4jmMjTCGAM0ruRxwlMLBaWul0YxUtsgtQzx02wTwjzr/tYtI+B7rXoCdyfwMrdBNt7zcFj9LCLGS6Ttp1YXJtg78bvuMEMsyTvSuLhnVawPO5IqFEXDB2I1Y72u07hq20xkeX4SQGTmw5sVa79ZqvN/wFisfpSaKuOXBy7dlfA5N8WWvhWpaTUkltIgVywfYiy+
 piw8yKRFHRdebc289KxPxSJaRMAFgN6K/0F/9Zc2Ymj/tEvOnjLQs8lUFfDPJK1yZ34u5br6X4t9hMvH/akceodizJixqnPNHzXRCtMmSFhzrGM9HRhra+XHVCdBPGK9r6Gpas186gEsQhHC/U1oTxQ51pfO0kV7kOSZCh9HLgcH4K2yoQcv0SDWJVKcIGx8fuMb4V6veuXpxgJTCC0+WqAu4o9AGtEOPaboabrjkp+QYTUf0AazVQOPgmm4noxcBADdqpG5L+wnyxws93RlBA+FmSbU5tVN5U/2+LuP+8vRNQ1qwEqlZ3WBg8QwHY8hDgAUoiG4m9Vpky0ZCFbwWsLQo/MECoEQ56KXgqnLDVoYpYMYnvVEIqWcyZWukxWA3w+/Zv5oxsJtBgrOywdY6YQYrrpm9U2UycTNo3LGRVLX15+CkdieJemzjD76KAQDfvjAN/X8GLBwKyLV4L7f1n+lTWKcQR4zxBQqJrbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FeZHzqOhHpCPEgdvRPF3Yh85cvqpSqAAjIPPxkXtjETtrISedYOX7b15nfrG5AhUGnNnyMg7TfCxqHVbODRRm461nicdTvkh2Lb2tOQqoOI8anra+KSLdDvrHx692j9p2RTmU0fgttibc2lpL/1WBp/fRADHnKDAZnhIQT21msdXUs3it6++2u7NVp11a+NBKJ+Q/BQY3gOeUHG8uYWx4xUDLQ1mqLCOG2GtC2yxnjgKKawAd6257bf/Ul1bdJeApkAU6poQQ+tueyKGknS1HQvuffCDTQ/T0nX0Z9cU0kuK+4VsiLiLl9PHfVjDKjX0OR9TkHv7KdXWZbaulTxwsWxBclwGB2KUkq0risa+VhkN4wFL+knw0QSTMONj6n8RANlFjSLW1TxFGS5Qm+DOI/+aq563LPjzQpmovh0fRUueK268wXpqnAwOKK7zVVPzNVTI/sa6SPptFLCMQWUEkI+PUcTUWrHPW0qUZ51XWKvK0CKORjoxAc1DuLtN5nPu1TClcch2fMQM/fktteBL6jOsDv3Y9oZwDReR8lyhsgqlWqInBhtOZwq38HPLIirB0kx+rNZINEGAWXC21Q+k9QuNquPB2w6puo1yBKpegZW83ssKPYhmp0Jv8G/n+A/59TxRjA3q2xBkERaJux+Wdx1qYgLbYD/p/lEPdMYG/eQ/i95EeWx1hPNr2akgeCH9pYLVEXthayMB0fAtXiF5nesIPCwXKjmXdeDm5LbIoQwd+d0A9QFJaLMuF6dwtDWs0kYqHO8bEJrhaS9McXGu6Gsj14QrvC36+K8NZnyo0V+CCVmTW1S636GhpTEMuPGuWo1JXq60r96bYoyfpnnXilAmLZeg/Fi4a3XtKn5zHLH/fJbho3IuK6BzK4P/8x+C4N/cvnWSTRGCp1wA8TCXlsP/EFobeIQzZ0SgBJ9QwYg8cSzFi2Yz+Qye/RUdzs1d
 veZUCJUqtGk6ZhZw1FyZ5GheAQgSIbg3aKH6Q+hbyrkt1JtVFmbTsMJqgSs2uO9d4vKNql+YZaC5uAXA/gUf9StO69urhtbTFeaVAD7PdcLJx4kqDv0m8OhFCUqlPmlxqXTPj2Cxrel9zVh93Xu/XeRmSxBeBFqJnsKX9yJBCosDQqf3bdP2QZoDm0agybsC5NlbxYw4sJbmD7CwxYd9+X4rFjs/BqA5doxolOdwE+ulpdE4LtEajnBylMbgtf8bmETpfa8YgXjaJIXknUSiCmUhWC8zCKr1atHVWEPbSo2wjpr5EO3rQZ3rSN8kSWnJBwvBaJvXGftEHie24Xds30Mxt/5gDaRw3sJLE3A7rfWJPvc/AxrLBtjEDFAmsXXaZzGerJNDAMlh32gVNg87BApkbJILHO1xRZ2QQSQ+KW5PkiirT3a1pnUsw4u/ysioCOvMVntOMk2LlNkC/4Mzy9i4ALMvWvWTKKbNusVfe9Xlq1cyn8kRqL5rq5jIPqbmh+peU/GmphW5AVRhij7jVHJiS7XzPamyJ2RDuwSPJTVYoDqBExzwMQI3I8yZ0xfW9nep3y6OxHw4bk9/N49ICiJri3RWCJmxgKwqSywPRFPAGMg8i5ymGNCZkYOIDkLStnhCUcAv3GCIZStF+3ae+Q==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c587103e-6762-412c-95fa-08dce153618b
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:41.6500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDewbMFfEj0e8o14LVwdAKJw0MTmOF97EXD8chBcf+x6hJryfqbL6nXvh5qfwvTjFIdldvBCHz6w3ZZRFAKrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
memcpy_{to,from}io and memset_io functions. So, consolidate them
into the existing lib/iomap_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- Addressed reviewer comments from David:
  - Replaced NATIVE_STORE_TYPE and uintptr_t by long
  - Split the read/write and the {get,put}_unaligned into two different
    lines for readability
- Addressed reviewer comments from Arnd:
  - Placed "extern" definitions in asm-generic/io.h
  - Renamed functions from __memcpy_{to,from}io and __memset_io
    to memcpy_{to,from}io and memset_io
  - Removed the guarding '#ifndef __memcpy_fromio', etc.
---
 include/asm-generic/io.h |  58 ++---------------
 lib/iomap_copy.c         | 133 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 52 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..f14655ed4d9d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -102,6 +102,12 @@ static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __i
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
+extern void memcpy_fromio(void *to, const volatile void __iomem *from,
+			  size_t count);
+extern void memcpy_toio(volatile void __iomem *to, const void *from,
+			size_t count);
+extern void memset_io(volatile void __iomem *dst, int c, size_t count);
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
@@ -1150,58 +1156,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 }
 #endif
 
-#ifndef memset_io
-#define memset_io memset_io
-/**
- * memset_io	Set a range of I/O memory to a constant value
- * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
- *
- * Set a range of I/O memory to a given value.
- */
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
-{
-	memset(__io_virt(addr), value, size);
-}
-#endif
-
-#ifndef memcpy_fromio
-#define memcpy_fromio memcpy_fromio
-/**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data from I/O memory.
- */
-static inline void memcpy_fromio(void *buffer,
-				 const volatile void __iomem *addr,
-				 size_t size)
-{
-	memcpy(buffer, __io_virt(addr), size);
-}
-#endif
-
-#ifndef memcpy_toio
-#define memcpy_toio memcpy_toio
-/**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data to I/O memory.
- */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-			       size_t size)
-{
-	memcpy(__io_virt(addr), buffer, size);
-}
-#endif
-
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif /* __KERNEL__ */
diff --git a/lib/iomap_copy.c b/lib/iomap_copy.c
index 2fd5712fb7c0..5567bf8db8bc 100644
--- a/lib/iomap_copy.c
+++ b/lib/iomap_copy.c
@@ -3,7 +3,11 @@
  * Copyright 2006 PathScale, Inc.  All Rights Reserved.
  */
 
+#include <asm/unaligned.h>
+
+#include <linux/align.h>
 #include <linux/export.h>
+#include <linux/types.h>
 #include <linux/io.h>
 
 /**
@@ -76,3 +80,132 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
 }
 EXPORT_SYMBOL_GPL(__iowrite64_copy);
 #endif
+
+#ifndef memcpy_fromio
+/**
+ * memcpy_fromio	Copy a block of data from I/O memory
+ * @to:			The (RAM) destination for the copy
+ * @from:		The (I/O memory) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data from I/O memory.
+ */
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)from, sizeof(long))) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		long val = __raw_readq(from);
+#else
+		long val = __raw_readl(from);
+#endif
+		put_unaligned(val, (long *)to);
+
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_fromio);
+#endif
+
+#ifndef memcpy_toio
+/**
+ * memcpy_toio		Copy a block of data into I/O memory
+ * @to:			The (I/O memory) destination for the copy
+ * @from:		The (RAM) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data to I/O memory.
+ */
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)to, sizeof(long))) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+		long val = get_unaligned((long *)from);
+#ifdef CONFIG_64BIT
+		__raw_writeq(val, to);
+#else
+		__raw_writel(val, to);
+#endif
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_toio);
+#endif
+
+#ifndef memset_io
+/**
+ * memset_io		Set a range of I/O memory to a constant value
+ * @dst:		The beginning of the I/O-memory range to set
+ * @c:			The value to set the memory to
+ * @count:		The number of bytes to set
+ *
+ * Set a range of I/O memory to a given value.
+ */
+void memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	uintptr_t qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+
+#ifdef CONFIG_64BIT
+	qc |= qc << 32;
+#endif
+
+	while (count && !IS_ALIGNED((long)dst, sizeof(long))) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		__raw_writeq(qc, dst);
+#else
+		__raw_writel(qc, dst);
+#endif
+
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memset_io);
+#endif
-- 
2.34.1






