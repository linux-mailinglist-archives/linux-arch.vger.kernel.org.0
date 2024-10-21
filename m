Return-Path: <linux-arch+bounces-8345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADA9A6A6F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1613D1C23031
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96D1F8921;
	Mon, 21 Oct 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="XmIv0z3T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="NO++And6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688E1D1E61
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517705; cv=fail; b=k6te5eTHtB5wHclK2Bt9ibY4BQw3pC93DiAPuvM8KQOLfdhp7gEjPflpPxmGus4vZ2ASKAkuGVB8iPXd77h/cDxyNWI/ARyiRrMsXS1qpjs0HLHeyxVIwuNqRqgoyccdMRLfhMDfl9pg7iQo2kdL8EmJrTRLNXUMpkdzRNeY3qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517705; c=relaxed/simple;
	bh=w8lHspuafD0AH9HslKXyIp4SbJ251EihCRXteTVreYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4aqe/Paa6QRswA5pF/DmJhcr9UjOVDyqVf/SEyb00PWaB+NVAFu7oRrftif0Xl9Iw6AO4xBEmuFZwYm5byw/NAUXm5UDRY0KRkKtWBun9HMS7HWvT1HxAw2Or2LG0AKkcDcbVUrh4IVveTNOyfSpZrDzA5Mr0WRzBFPX+rUxQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=XmIv0z3T; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=NO++And6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id EB4C43494BD
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1729517588;
	bh=w8lHspuafD0AH9HslKXyIp4SbJ251EihCRXteTVreYo=;
	h=From:To:Cc:Subject:Date;
	b=XmIv0z3TI7l0GzavW7rrpP2CMISDzRLctke0bjxq29ELPCwpTfneG8gszqJjkOFjF
	 QeCudnKs8OtcJfB/dm7ySZ0spZd5Fm7l+JXgiru/Si3ewPkopBfr1ZQ8wdrfTEbTly
	 HnZH47t+SajBIr4HFlNNzGTdnlZeSzqOIACERHUI=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id AD2BC3493D9; Mon, 21 Oct
 2024 15:33:07 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011030.outbound.protection.outlook.com
 [40.93.76.30]) by fx601.security-mail.net (Postfix) with ESMTPS id
 ADEFA3496C7; Mon, 21 Oct 2024 15:33:06 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2339.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:33:05 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8069.027; Mon, 21 Oct
 2024 13:33:05 +0000
X-Secumail-id: <d8dd.67165812.a9338.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH7as+UstBqEFhqfFUHYj0WYhIx93rtnG24ro6QgiQzWe8LFs9onILwy5nsiewmq+7QL6Pzpan0zKmkopfE5/LSGhyBc3/+IOChHpvfv+0o4FjisX784wyQ4S6fd6T9UqFZOgHPIc5ly3/Pt5rAzK2zJcdIGuhnhJ/pVPhO9a39P2TLBd0qFMXjomrw1IfgqhwH/Mw311y1K026uYmLisxBFsw6ag1HQxjJ/HCURSJrukpVmkJEJi74i1iuf07geTOasxH9m4SVdTlXW2G6ZfejB11W0NKhu+b0/2BLVmOgsKE+yhRsewqVHLPZ7IRpgpgtm9PJ3EK4CVEK4ohGnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NVIvkoKG8xDCqZTuSKM/Ypx5a94z7KHzKS38wlN8xI=;
 b=snSODrRlVabg7TmF21spx2Hmt6wWUaDDEyBvJW/0dSU5Y9xIxSaVtKOXaLFAh72NUXOUWmFO2xAGUbQ5Q4VKb/Ht0Cs1mTQmutLZR8tONLHwJ9tKM/y2fE8yKg/bJprqw0eHySQF9g3xZjljvAIz1sccNmDbiw3KII7otcJGMIl84zqtaogj6c7nJXq2p3fqSxALY5Kvnf1yycCn0eDk3SMao0ZcjuN+yMDmlRcUUdWLTwCbsdfLmAmmWRCSUy09ZafZnGXE1tPYYHBGYeS4Tb0WJsvHhumO6vqB2L39NkmyQeJxVI+q+9AaJhUAeLfMPrJWn8lr6uDwD+xZoDE0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NVIvkoKG8xDCqZTuSKM/Ypx5a94z7KHzKS38wlN8xI=;
 b=NO++And6ib1A+LNRInxvwjNVffa/PQODlz8+hOC8HqIlK8Du44PUuuFMeL63vb93bjpptHUzVrVQsvDgVIc/8iGoR1mgTt/CnYhRu+IvD8SM4tajgLzYFJdPPN8grxD1R2iqX4Z3NNEsmVxeDl5g/kNu1WoAsv5J3VOYXfsL8lVVDVJbFy0XzOdj83L/fKVBuxMlGqf7uEsO1sVR4wfTsCLoLFiq99MHYVoXnFU6aczV894mqxcXvyGImWaCwNjkFtDx2HguyWbdtBcJV6dPeurYkGCo7UQhVPI3cFpBJQwceoydqdbUfvBHq5uT/TQS/dq3lVVY+/GaZ0wb+EepSw==
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
Subject: [PATCH v10 0/4] Replace fallback for IO memcpy and IO memset
Date: Mon, 21 Oct 2024 15:31:50 +0200
Message-ID: <20241021133154.516847-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 8dbff9ac-02da-4c15-851c-08dcf1d4e48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: OUBxvrKN575Oug1dyNlHDPwKZPPpPeYxRb3qZ/ZytrqdrGDpZTxFa7RzWm/fenM/TA/R2+edST2ZbqS8+f+g9NkueZcf2U8ETjtGMgsTdjCt6jV28SbgKo6WDtQEXE43My1hWWNtR3afaKxnYGjDiUyOgTYUoOlN53ReViTLPY3+5yxmx2SmNumemRFkiU5TOOpPmaye/LkWdkLFOFPKWgbMFBghHkQrTz1SVOrl8Wz3rkivpvAAf/RCcW7eKYkjFwIcXRUh0GF3eTugG2EWUDUFCvwyMquuzTJRO4AKZI0ZK95Ya3O7eTubxYnw77w1y6qaK4TOtVHMpEb56qgK/WEF5ehKTiup7ofGTqHPFqnG60GDQy5MBUTq1fxP8+wVRaYfvxKyDdU49Z1UBm1YUD3hY3ihlYPI7+hjMt5K07LhUTdAWvl19KE3qluxDJ0ys8qcMyuDugBGQImIf6D82bQuAIF5smeuwOJNjHpRlVwk8WXp018I8eO/BPf3AMLqaH3+a150tVANONe/MsqFeGgEKEvRWWbd/D2RZiB0Z8mHC+X4pEbwZ1wc1bsgFqZAEXe9YMPM6keuN22OJrBXBHkt+t1IL0ypXRVza5cvoBtqqmLMqOqOlAOewVwqqTwPdcohRBSwIHGcr6NLPXZhPQVMjtOC8KCNEoQSotKmAGhvynJVf+D0JRKP1AXod5WM0c4glf1v1Jfu0jJP/VKXKDCnHG1C8poFzu95GJydvU90ILJOXxiqKhgI0a64W/6+VhB+TAASO1O84p7LKMUF634PopiKjf5/i5uyztWk1WOpN1UOvyRviHRq0p7u5YQUZGO2ogGybbhjINNWo8fRN5BpVIUScRCx2++jbSTt5Zb6zXBwJYS6i2Jk5/oKgeHAyZks0nE5riodWCv19glvJm1P1ECzz44XDhXH9TpJIhPiliVCqfjMRSuFgKVpDKbAmXC
 nu5D8VT1DsdYYa09VNA6ptf9+5Qj1T8sxC3PGaYAycvGdiiUDlw3yNGffCO6ZABdaUSBX94037JbA59NOCFePofm2vPyzNOmepBI/PtfQh8HcKuAgQkE0zuOggVQAEY7NkFgmvwnl+YUPzHbvA1u3WdP76tMC/6vrkHXrsHS1hX4ytnIn+u0vasQ61VwypS5uSORWUUQcyFEAx6MPjhaQBw9sJzqkC83UaaE4VwLn4QIf3ExY6gAUcsA5apa3+NsKpqRchhAo8idazgpCqRq3vhF25bdY2CtUzSrW69rUrpFSHd0ZNmS36HHLkbK8bt97oLIOSFJjxyvvsTLYOhmLL0uoUwr0Ow6Rv9wqjA3Z37asFkehZ+mv2LaSoqKAn+oDtX+xLnF7Zg4dtXHezjLjbO356ZF2cc7guUOT9bxKqssyO7mcUAfPSBSYNSet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Fn4yexOvOhI7DtK2+tDgoyvHKF8pCF00OIB076GFjlUA61OFpDt/OSyQuofAKuPdHJcGQTFKje1x7iRB5AgQ1nuE/4U53m+jxnhbfOsr0wxyBGmHlLt4i59oGaamNtV9iWLy5mbJerzV6C9g2PZy+Trj5loHHthsuFpAoYASVFdPDFUo8qxN0VYL5qSBc6gQXFoR+7J7LnvQskYwH8QFn0WzQUDiRSBxzTmHxktIEycpezKPqctnCD+vjtmlsLdjC3AKaHcA5pawrxpjC/LUEmLhQBmfsTZZfDOYQ4el7pwLU031tfj2BVeNsoKy+xDn8u/ksIASP7g968e2VEmUXMRf3wPHDOjlgZp6gEmzMa0gAiHx25g+STqjl3yH94MU/y4RHDzFgGR4tU3ogusGn6ievb+xSOYJSB9/dn72ZxdKN8pUMSxMHOi+0Fxd6+V21+Z57so7TZcvd7orTKHAhFJo5mi6qJITWJWADzY1UZcMqPULIfnEDiow6t8KgGIRaKBMGrqyMgN5jy5RtsEhi/SH1yAUdtRIRutBsbnn09+OHXXORFP4Ss1HDRnXeZpKvp+eT1lcTJ+b0BtJilsmmJvKQey8CHlrSNL7s1M3ybdZuch15zqiqeilzZyn8zyN/sECcuwHxAL+1qzJJrbx+F8X5RUE4jZajR4XxXpvMWeFPALgvnPE2Zu8GXMV9mqKWsK/1xnZhl6/xAPdrjl6biWVbstCdCwbjdYnEa5SZXkEmBGQu72F9kquBtvupjLBQ0KA/TnHsMbjjlm+B6WJvwGwgt6mDB/Fpa2Kqwi/gfYk8dvfUycjyKnqP9RBI5C0BnnwxjwRO+MuOdWb1VYYkG9nY9LIj5L7aYsz9gqOj6QkzDz5y4/zmK2t7l2VpimB1eqERwXAFdeCH9/SjzK6Ja2IxYL5fBDvbKX7AbLjezlkaVcsHvh9w3/deq2UJRK
 MAVs3nU+06C2yVML/ESf7AFTkuwN1YiC0IIGHwb5Fb96W5OeF5gTeRqbRnQKZzPlizHXAnQZ88ILbrvMH/fdmuJdrqu4driOvvbf5DaNO90w1QP6Mbx5UEB922pmcLdfTIctFJKryeAfO5al4f4bKsoxoT7cWAZl0RfQzv9x2m+A3E/p6+hKr6a/Vmsjn+CeSnyyhpCPtzgOrz11cuhDKVP26MfIf/GYQgqCAyRyhPqjzVhLedW4176ELZpNZ2UPt8DvbGFSbFzG/oyQKvBm+VTaIQsNzGAxNzqZh/+UdX+Y/bMZBnj+8xoXkaZyL/ttU6vEWc69k9VBiAXqfHXmrw2XjRxw4Vv3AioeqTmV+lDbmcXQhF0YZkq09WSfegL2K6aplrnQn6rvDeQsCKHPnJH+LEueColcwiAsjtpARmVmKPW8fhhe86+KCn48SWdAUfkN7i8Gl+FPUYSaVYARnFunUpt1s55sv5SCHI3rGKA7F/PuldCkUOBgXG4CILD33MUBDJ2p2jZOWLNhDles4R7i3vdg8dabJ3NhDjTX7Y5RMtlEsuSb0UpGY1JzsEg+5O5aeU9HqwiOBEcqgf1iT/8b89AGn6w1TS2SPxe1gf4I23DMulAYXTTX8vjWwzTsewlFFZIDzyi4Hd0yWshd0w==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbff9ac-02da-4c15-851c-08dcf1d4e48f
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:33:05.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8PnMctSz9zzkr8tF8wTBv3wMF3JidB2DfUH5pQnEK5r7DCKWFCzvrqfYsxYBlGrXWyfxHFw+N7EoruIIzqSzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2339
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you again for your remarks Arnd and Christoph! I have updated the
patchset, and placed the functions directly in asm-generic/io.h. I have
dropped the libs/iomem_copy.c and have updated/clarified the commit
message in the first patch.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v10:
- Removed libs/iomem_copy.c again
- Replaced the three functions in asm-generic/io.h directly
- Updated description for the first patch to clarify the matter
- Slightly updated description in patches 2 to 4

Changes for v9:
- Moved functions into a new file iomem_copy.c which is built
  unconditionally
- Guard prototypes with '#ifndef memcpy_fromio', etc.
- Dropped patches 5 to 14 for now. I will send some of the changes in
  separate patches or patchsets to the appropriate mailinglists
- Added proper reviewed-by and acked-by to arm64 and csky patches

Changes for v8:
- Dropped the arch/um patch that adds dummy implementations for IO
  memcpy functions
- Added 3 new patches that fix the dependency problem for UM (added
  dependencies on HAS_IOMEM || INDIRECT_IOMEM)
- Added new patch for s390 to internally call the zpci_memcpy functions
  and not the generic ones from libs/iomap_copy.c
- Addressed reviewer comments and replaced 2 or 3 shifts by
  'qc *= ~0UL / 0xff;'
- Addressed reviewer comments on pasrisc (masking the int value)
- Addressed reviewer comments on alpha (masking the int value)

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
Julian Vetter (4):
  Replace fallback for IO memcpy and IO memset
  arm64: Use new fallback IO memcpy/memset
  csky: Use new fallback IO memcpy/memset
  loongarch: Use new fallback IO memcpy/memset

 arch/arm64/include/asm/io.h     |  11 ---
 arch/arm64/kernel/io.c          |  87 ------------------------
 arch/csky/include/asm/io.h      |  11 ---
 arch/csky/kernel/Makefile       |   2 +-
 arch/csky/kernel/io.c           |  91 -------------------------
 arch/loongarch/include/asm/io.h |  10 ---
 arch/loongarch/kernel/Makefile  |   2 +-
 arch/loongarch/kernel/io.c      |  94 --------------------------
 include/asm-generic/io.h        | 116 ++++++++++++++++++++++++++------
 9 files changed, 98 insertions(+), 326 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c

-- 
2.34.1






