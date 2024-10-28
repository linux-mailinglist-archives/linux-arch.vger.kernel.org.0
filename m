Return-Path: <linux-arch+bounces-8646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C09B31FE
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B78D1C21B8F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54424194080;
	Mon, 28 Oct 2024 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="jQdfVKCs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UQ15isMz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0051DDA14
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123015; cv=fail; b=Oc+F7DtmTK0rRfb4UyX7kXONyQtrwQvELlfpEqTbY/lpLbm/DhDL7K8ZhCtQC45GGG8N+X7zAvmyWGkOoWe9jWGZ3eWjQpGMN4lHAIo8tLsIjkoNXf4pPoprJQajdld8L4qk8nsLUVMa0LzsZxQilEMYTphnNJWUWsqhkv9RR7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123015; c=relaxed/simple;
	bh=QHFoNgkUo9YCmEuGqNTxd3p9a48LE4bj6A+pzdLQyTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU0UoJ8k7Qb5Hqfl0vteYtHbWc1Yebqz/uj1asTfcEHVFDEKN4MF0aL5EGP50LZ/wpH1b6HBWk0FUn4QNIls93rRt37ZCk+xWJmi/YGGTJoszjh4S//z3vFg2z+q30+L4RFi9X+UibS84+jJen4qNf1g1dRcllaseEGN04CJ5io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=jQdfVKCs; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UQ15isMz reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 2FD5E30F2BB
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 14:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1730122966;
	bh=QHFoNgkUo9YCmEuGqNTxd3p9a48LE4bj6A+pzdLQyTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQdfVKCs6AfoGsPX5Yehk4g23pzW30axR2Ax/lclez5yUWxruYeJv1ico1w4XIov/
	 Xv4pjAxiqn+1uA7S3HI6+FAb2b5mt5QVfgThr+MI+TWYx+O5laHVpRDJbPYGx7ZDjH
	 YCygyZR8zBlt4KlWMGyjCM/bDT2OWd3pxOXTUsK4=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 863A630F18C; Mon, 28 Oct
 2024 14:42:45 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx305.security-mail.net (Postfix) with ESMTPS id
 4E05A30F06E; Mon, 28 Oct 2024 14:42:43 +0100 (CET)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 13:42:41 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8093.024; Mon, 28 Oct
 2024 13:42:41 +0000
X-Secumail-id: <125b6.671f94d3.4bdc1.1>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7CPoRVstF7pgy1Q0PPGMHaM/+qUgnItX64BxxiV4DyrHtjTdL9elTYK5RIIRf6SNT+6uxdUAyMrGq8FAexPLXPkqNNq3EbjYujNLseQoQgssSpJOAnbCuPTucwlHKKwGYaF5J6nGm9CmycsxIdHWf8UU7ju6Q+cKjjGPyBr+Er7gYYwXiEmPCz4+CnFUhtn8tzRgPOwpfGuEVTVnFHGHGXiUL6MGXg1JpmA3damqs2Tt/1A4fnSolFYywA4a18XS62Wfo4KqvfGUOf0HG8Hj5wywGQyCGKZDYqrkYVs62se+evIdfHsba99c8IFEg+2RSCd9bmuvPH6lPdFmiGAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyFZmi0y0A5MN+FXOK1ha1lS+Fc63mnQn1q/Mv+V6o0=;
 b=OajFwbVyDcqLontzG6AXWuTxq6J9X+xR3P4lIbLyelOlorD/2Zz3LBOOK6ofZ/Lv3c48XoOrzKEnaroDL3dJf+NRRannbmt9WICppuDaV1SXJQOlebe8PT/MCSDEg+BWW+rqpLkMiRAcdBbliKcp1w1BdQFEs1ktRB86uN5eTJ/FLcpd9MjtVDEGL3XWjz/sK6HW5MOG93VjODdejLQUi5GaTZkcFQ0phMPCaVO8FGpngSauiqxCFQgDgDKr19ibkE/5AnPfBkHoJyqj97SOjGYCNKB8iqpyqXw46sxxjB4G5ojQZEpm1VeLPcFgdnWPm5ZqPi5JfuHFAVNMSrGu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyFZmi0y0A5MN+FXOK1ha1lS+Fc63mnQn1q/Mv+V6o0=;
 b=UQ15isMzFw4LZywfpOM+zNaAH8ksfRxW7q9N22iOMS0tpZPlkSp8Kh97DNrxNwdMdIp19iWDzleejANdygkrbgNTHv5a+Y4u+zfJL4mpNpinz8wEzMVNrTd60E3Kf3dhTHTqmq5yg8pjyMe14JU0dGDUV2UqaVKLNDLb0UFVX6MdHINbECtT4O65rBII5hnRsZbSNd3AAJ0rh8U67CK2BP4sAfkqIXWFOOO5ugDWRX6YdAe4uolZzfnk28lacyelWPcYJHZc1LRmoBs04X41yCz1ksDn8UNxEYX5iqHQnynZCrU1yf3mJaHB/yRS7BAFwCwleUtq3XL5i9KQ4BSbfg==
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
Subject: [PATCH v11 1/4] New implementation for IO memcpy and IO memset
Date: Mon, 28 Oct 2024 14:42:24 +0100
Message-ID: <20241028134227.4020894-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028134227.4020894-1-jvetter@kalrayinc.com>
References: <20241028134227.4020894-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::26) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2397:EE_
X-MS-Office365-Filtering-Correlation-Id: 7056dcfd-b3dc-4d88-68a1-08dcf7566520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: fgPd2ow7IV5vkao7SBLAJZfojBFSGkwAkbTFIF5UIJHTP3Y3/okdFhgE+dU3QYFU5oXT2FdwzG5pABeO0hbY1KkmRRe7i0fG6CL+Pn+M5xkwRt2RZClYqXpImKahgRAvCD+2wO7vO82Hd+OfRAC7lsXH8gUfOLLOhAjEMAFHOTto/lKUmREY9FchzxGFxA4cgYc6TXNbDYRstWmEyLUgB+BlPjBGDD7vJLHrFLdKe7vClTdzb/kTt7klpeegQYWpmpkoDkpk1fiGBwTp4jSr6zut0QFB2otJasjym7veZJXHeDg9KCan6tHFaZkCA7IWFQ/JMPtRvMHdbNj3M9MgpdZxHTBGcaoEIuCzbfJ/IGRNZ9y0WiCvbjPzQA5nkut6Hl0C1SqXsTyFS+IT4YQ+lcLgdoFMV3ID0T8Vai6EDXP/zwiD8yA9o8/DCXrM88+IBKkzHKJPkGuYcrpQpWSU1Q4IvnDRwLcGWVYtMgq93pPcoRFa9kne7EKOlEqYfax3xsxAZGiN//Js6ZVhxzPYoYPAJk+pklh3MEPsbD0PsuscfaGtBiPxFTgYF/P+zAVOrnCrTfBcMl2vHYUVBND941yHO0h8kwnhsbcuf0a5bwncj+tGQA3sTPXbIafJXG1wC7rQRbAgx+a1Y+0DHgkpMKVbV2rFKbTQq6wl/2L3gAKJcHmw54BemPOScEuxAJTMGgcgC6RPpKWocIq9wVLFeZ+t9l8qrtAvntAp+NW958U8f1zvqLePy8OzQZMssFLsEzSrvDMUabcfr5VDXz02Yl+wXSCY/433MRVpOEUWQwJM4eYt8uynnvINW55rlnGEEsDAGTJwRMl6o2Yn5L/Ylz7UYV9HV+P/j94qOU23vNTuiSAhU+P83IBEL43lFOKsu8ZA5j5Mmd6bwGv9zBxTun+QTX8Axj3M5THZIcYcjaEuzulcOXp2I31UMMZv44kk4wj
 6nLO6SUWOLbdjobvxqwkSRWlwW/nlNJ3VNUvE9Sdg2/1+krKqzPJsFH6EHA6HSk7fzhWgwm1rahtVm7mlNvUmRKqdzmEOr2304Ef5j7PnZtARDFIeDLeu2wHAeHXj7MOMikh4Gbnr3iYDywM+luk7Gcp6KKid0z3hjQRZoV3A1elF0mPgGBdeP7k/KOnHqSk2tgq5HHxJ5rmDY0QDfiMHfYGcZH8YOVoUNX0JgkDqG2zaDBwxmujb/eZO9TQPRnto4vn3upaJx8oEplUtRcJWpheddkqW4ca4y5tsug4hHyaExTmyd1dkA9SoiOEJyd5ZkSA3rsSTMCI8+f58YepNtyXc4Maosii6t4kbkkY2OGp/96GC7dHBu6c+eSH2YYIgrc9uq8i/kwbgiNXXxjll7LPZWw136tC2DBPr4Um1nuuxuApln+jzggKfuIk3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gy2PPmEOP+XPee8KYjXpDw6WcgdO/H2Da0dLBLbSdU5a88lZQwohsRHmDrNT+3rEuys6djsYm0yOgE4vlCqdelphjf5Yd2Ui/n5/PDvjJw+wsIcTt4emB/+AaEAb6a7Q/hmpWXSnMFNIY5BtNn3vGRSnf2hyjUmPgj85Tcw37RMEyJYZu6e7LSGZIYOuGIoJ8rd/DM/lbJu96t1bN/LBepFM7rR1189e5IlLLZojXmr0M8XkxSpyFg0BeLyWfOvhJY6EUxuyDKPMiEm3X8TL0EgKTlOaTe9Z43dg3kxbtTgtHSiLNP65NMWxytWZapt/f6bsUl7WpTwdIHsNudp6YJ5JyxO44YeueXY4oZDKQBuA4+gro7dOArvJMRg0v29m2cvBVNm4263zUFEb+YNT7irk1sGGccXJwtHhGlEmIXsyi0VmqqGGR7/vHlNgmUCjV+QIRt6eDGV6FJrHqIVAzGsiI9k1N/T4oYU1mheDsfiQF9Um8QvhAsEissdgXgVoS6ZoWIChh5hCjsknGORjm6TuH+apDYeT556x8v0fc7y931Qja18P2mxn1XU1BbTvFzc2Rk/Y69cUgT5bbnYxEVKsCsNg1OnnrO4QJdZAfScP5whdrR42SEI2wjSDaSKu0hg+DXEtWG3d4agyMKEfTBH5fQZVmkx2h5nA61+U1kwlshTXop1eeptMhamBG0l6zowd+g0Qgs0jDuq49tjxSM6XJd+/Ui/v0iUfKhJVIQ+u8YYY+FgYRG/IalO6+WtymoWba+uh/+4u21XNOTKk8OaWBKjBUm3mzo0ey6kBu/9kxdaxY9HEFDi2KFsrux0tRtPd0QsYQWQvYlPRaJMEEPaF0psTiKCibKJNn9ebdFBsf4YBk7o4cuUqmRIWII0ZsONvyBHHO+7TWKi0J9L9JUgzUHcl+nFonjzPirqU3PVvuIrJTb9agTPE17PkibFJ
 YtFGA56D4HNMGTSb0TJjzqxky5ld8T5kU2N56t6df+D/4KXJwJJLOGRyiObm47TOjB3hc+llLEy/p1CbC9ASq2T4Qzvk+2537S9oKdcfGLQPJisH/LbZnYpWSChjuE8KqNjXhguu6OZYdIwCcRSkZFu6b5U+9A0e9DcLs4AkLnLWr1Zwk7N3FRLJhi/AviL+4mEUNDzAjCG7dzrq447qVzTB9myFLQwPCxxm40PqzKhteNwTLZo2Ig+G6QLwS5QW+hIqvELYVQ3AW6YCv5IoZwmb0Gfby1Gnl1dxLLhtO7LYwmLv0qCfF4Zc209p36Fkcppdne9jnnpuEEVzAfgSNEFn8DR+H3ED+GHsMJJTzEJrGkvZSvXvqVeFM/GdY3bS3FviheKZWnZ0iqXCmoA83QEOpy+aNy7MqdEfVofkstwm5sPb7dxmQVKQcitPPA+AqC4NI9BuZp6/D2te2gse0JWnIMNH0Pm6gkMdZrI0jYS8syp+wRb1LDj7qSEuDMb5zbrVP8CAp2aE2qi2/HIwuloR/Rkoae3oVAXM4abE4Kb0OqywGZujWPL2R/iunsv+oE2Yt/y0/nz++sv5Mx4K6KwSYheSSRmpN0zD4DAXyfgZaMMURiEEzW/DeUm4TAnP
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7056dcfd-b3dc-4d88-68a1-08dcf7566520
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:42:41.7732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge6Pv8tZBkAejbXWs5r8s9JoEwFRLgA4NqWgxzRz082LNcoyRDgky4dRBnoMgfHVdQqRcHQpYd8rUx+MwomINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2397
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

The IO memcpy and IO memset functions in asm-generic/io.h simply call
memcpy and memset. This can lead to alignment problems or faults on
architectures that do not define their own version and fall back to
these defaults.
This patch introduces new implementations for IO memcpy and IO memset,
that use read{l,q} accessor functions, align accesses to machine word
size, and resort to byte accesses when the target memory is not aligned.
For new architectures and existing ones that were using the old
fallbacks these functions are save to use, because IO memory constraints
are taken into account. Moreover, architectures with similar
implementations can now use these new versions, not needing to implement
their own.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v11:
- Updated asm-generic/io.h to just contain the changes suggested by Arnd
- Restored iomem_copy.c
  - Re-ordered functions to match the order in asm-generic/io.h
  - Aligned variable names (e.g., src and dst instead of to and from)
    with the ones from asm-generic/io.h
---
 include/asm-generic/io.h |  22 +------
 lib/Makefile             |   2 +-
 lib/iomem_copy.c         | 136 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 20 deletions(-)
 create mode 100644 lib/iomem_copy.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..7004c2e5e8f1 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1151,7 +1151,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 #endif
 
 #ifndef memset_io
-#define memset_io memset_io
 /**
  * memset_io	Set a range of I/O memory to a constant value
  * @addr:	The beginning of the I/O-memory range to set
@@ -1160,15 +1159,10 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
  *
  * Set a range of I/O memory to a given value.
  */
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
-{
-	memset(__io_virt(addr), value, size);
-}
+void memset_io(volatile void __iomem *addr, int val, size_t count);
 #endif
 
 #ifndef memcpy_fromio
-#define memcpy_fromio memcpy_fromio
 /**
  * memcpy_fromio	Copy a block of data from I/O memory
  * @dst:		The (RAM) destination for the copy
@@ -1177,16 +1171,10 @@ static inline void memset_io(volatile void __iomem *addr, int value,
  *
  * Copy a block of data from I/O memory.
  */
-static inline void memcpy_fromio(void *buffer,
-				 const volatile void __iomem *addr,
-				 size_t size)
-{
-	memcpy(buffer, __io_virt(addr), size);
-}
+void memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count);
 #endif
 
 #ifndef memcpy_toio
-#define memcpy_toio memcpy_toio
 /**
  * memcpy_toio		Copy a block of data into I/O memory
  * @dst:		The (I/O memory) destination for the copy
@@ -1195,11 +1183,7 @@ static inline void memcpy_fromio(void *buffer,
  *
  * Copy a block of data to I/O memory.
  */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-			       size_t size)
-{
-	memcpy(__io_virt(addr), buffer, size);
-}
+void memcpy_toio(volatile void __iomem *dst, const void *src, size_t count);
 #endif
 
 extern int devmem_is_allowed(unsigned long pfn);
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..db4717538fad 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,7 +35,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o union_find.o
+	 buildid.o objpool.o union_find.o iomem_copy.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/iomem_copy.c b/lib/iomem_copy.c
new file mode 100644
index 000000000000..24c2b59a0ad2
--- /dev/null
+++ b/lib/iomem_copy.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Kalray, Inc.  All Rights Reserved.
+ */
+
+#include <linux/align.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#ifndef memset_io
+/**
+ * memset_io		Set a range of I/O memory to a constant value
+ * @addr:		The beginning of the I/O-memory range to set
+ * @val:		The value to set the memory to
+ * @count:		The number of bytes to set
+ *
+ * Set a range of I/O memory to a given value.
+ */
+void memset_io(volatile void __iomem *addr, int val, size_t count)
+{
+	long qc = (u8)val;
+
+	qc *= ~0UL / 0xff;
+
+	while (count && !IS_ALIGNED((long)addr, sizeof(long))) {
+		__raw_writeb(val, addr);
+		addr++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		__raw_writeq(qc, addr);
+#else
+		__raw_writel(qc, addr);
+#endif
+
+		addr += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(val, addr);
+		addr++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memset_io);
+#endif
+
+#ifndef memcpy_fromio
+/**
+ * memcpy_fromio	Copy a block of data from I/O memory
+ * @dst:		The (RAM) destination for the copy
+ * @src:		The (I/O memory) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data from I/O memory.
+ */
+void memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count)
+{
+	while (count && !IS_ALIGNED((long)src, sizeof(long))) {
+		*(u8 *)dst = __raw_readb(src);
+		src++;
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		long val = __raw_readq(src);
+#else
+		long val = __raw_readl(src);
+#endif
+		put_unaligned(val, (long *)dst);
+
+
+		src += sizeof(long);
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		*(u8 *)dst = __raw_readb(src);
+		src++;
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_fromio);
+#endif
+
+#ifndef memcpy_toio
+/**
+ * memcpy_toio		Copy a block of data into I/O memory
+ * @dst:		The (I/O memory) destination for the copy
+ * @src:		The (RAM) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data to I/O memory.
+ */
+void memcpy_toio(volatile void __iomem *dst, const void *src, size_t count)
+{
+	while (count && !IS_ALIGNED((long)dst, sizeof(long))) {
+		__raw_writeb(*(u8 *)src, dst);
+		src++;
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+		long val = get_unaligned((long *)src);
+#ifdef CONFIG_64BIT
+		__raw_writeq(val, dst);
+#else
+		__raw_writel(val, dst);
+#endif
+
+		src += sizeof(long);
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)src, dst);
+		src++;
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_toio);
+#endif
+
+
-- 
2.34.1






