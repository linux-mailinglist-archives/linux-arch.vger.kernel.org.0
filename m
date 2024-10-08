Return-Path: <linux-arch+bounces-7815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59B9941C6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C80A1B2509E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 08:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4220899D;
	Tue,  8 Oct 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="eFooBVNe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ETbeZjMu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89920967F
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374113; cv=fail; b=H2ebgAIv1pubAXE/uJv6tlwQ4Vxi9ZK02bKKw/Le4XXG6i2bQY9TPlZoCFNjLLBx0z6qwR+6FKLyZ7oOwdNxB0YBg7RcJPURQvt9ZvJeBUN1Tp+9AS92Hf5hs7JhMH6nh+F9E0ofDrtU50pdO3ujP1rm1I+mKxV7llXDl91guSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374113; c=relaxed/simple;
	bh=K52sFCVR40cjX80xMzZQKAoa1YFmSTrfnUEfR/JO2Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lk4/0ZLW3Seo6ZWTZZhC88Uym3lyCjnJZrr1BKspdq2/r6hLj3l02v2mT0YZ16kCfX+vJVkEl9eZJCrTFYIXHIHxwyEtYyefJWys+DSzlN12N3Tbit0K86FGbPT6GVwtMM5rQgjGpAHgA3NkQp3H+2ppdNa2tJfLPPueIbzfe7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=eFooBVNe; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ETbeZjMu reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id B0A478A3289
	for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 09:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728373864;
	bh=K52sFCVR40cjX80xMzZQKAoa1YFmSTrfnUEfR/JO2Ys=;
	h=From:To:Cc:Subject:Date;
	b=eFooBVNeCa0wzpuh5Qh+PGmBfMWoOGpNopxyZigzhARoEn2III11FJaJjvFz7ODiO
	 0zXuVI7G3/o6wDfTVWOmUgSvrfNfL2tvqv7YP96JrYkfxsQ+XuOXaTElJ6LTr3PNTC
	 Q/ZdvrXlkX4SrKoTFD1Cr6CkXXbt3VzKb46fTS50=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id AD64A8A2B5B; Tue, 08 Oct 2024 09:51:03 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx403.security-mail.net (Postfix) with ESMTPS id
 5BA0A8A2F56; Tue, 08 Oct 2024 09:51:02 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 07:51:00 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 07:51:00 +0000
X-Secumail-id: <90a8.6704e466.58fd0.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ev40TVUTG5gm0ikQ31X521ft2AKH/nd/yYGU54O6WfUyhXxI200L3Kk5fghME8fqGONbhwlVTuJkKC82WiDZwY3wZGa+QnMrAsSAcF7KMaMxtmYxYo99c0za5eS61G28q0JWPcvGnvMRUQnJ/KNrlTLXk3D9qgLHqTp0fUT1DhzRQT31c/I/SZnWYcXfHGrBAXRjgZKuAFj2Bzmvm+6pFVpczwCp50cb4ylWiU8r51PZLy8Xk5xaGach+mdw5YOKt0mirLxr8YMMA+lY63c7HkC/m0rn6U2CRzMD0NZU7l4FngvPaUyK3RD314NPb5w4ccvDmpxZZtyly98hZ2nn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6sX696qZP1ndFsua0R+x9MDgsEnI65B6JAyYUl24Eo=;
 b=iOYojA7vBzefDEM7tVPQlbCOulQByo40toEad1UmDU0I0Xtumj3rdQ8elpSVpDcBSkQgz1BnsD/cSFgzI8dleMUNlhYKGzZ/P+EVIVmx8h56WDtuZpJiLBd4/jAnwVJ/76pcBFLfij/0/wUzcB4v4WCLqqwOQ9Zo+FRdzWbBu5TchhI5NDLTFWFp3bpg/2EJOSLC9OzP0SLGX9j10rrDMzknaQDsap6IdhTgJPzPexIWilj0DFcZ3S+aWtGKhzhuOK6temvSI0AuPr+GXlYBibyD2Ydx9XWK/WPZFD7eAiycX0mcv8xaL+qvBlC/4J+9maIzqMbYFwNbj2stMOu/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6sX696qZP1ndFsua0R+x9MDgsEnI65B6JAyYUl24Eo=;
 b=ETbeZjMu/PsoNEgqh1U85C2gtvW2PlkQsHTyebOJiedy88skQog52dL3wS8SNGtBnx/4dD9Wz1kfhhMm39SYgk/0qS7pJ5KEaUo3nOzKrQ8moNT8T7iqADuz54SD3trodk5qpGlcYtHwVJ1OvU/dYQhmu6FTVgm0qqUtC3GUP4Kc6qHdrjE3VNEyD8jLdR4kMl5lxmxd9PO30MFNaGZmOKyp49xy/+XGPIc01qib93XWqxMhCwN9K/OZ29JyLq1/AcVXG43p6umfLFRixTnR/pNKFSKYVKQ3Wvb0GKQzVgvLB3A+0gk2Yuz6XRtjx2hIK7Nu3Ee7y3f/PZQSFfhhPQ==
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
Subject: [PATCH v8 00/14] Consolidate IO memcpy functions
Date: Tue,  8 Oct 2024 09:50:08 +0200
Message-ID: <20241008075023.3052370-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 7803a017-ee44-43b7-3758-08dce76df3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: OgYTdyHDTYUkqfVxZC15bklhw2uc346fsM4qfWjmBFfEBpKiG43f0oVgyQLFqcGljBXMnQoR9IiWdQw/GwHPhS2jp5RxMTYLolU6yLVVBptkZJ6x0YF0g9Yg+UDtCzHA9VtxBnFIg9Pw3KvtpVC2xPsIm8vUjspvvOe0fNkAlu6iGlvUGuqhyUImTN65fjAFfFSjPNTfDazm8+NK6Lp7dA4yQOvNkvzWnBY9n9k6rF0d3CnEY6SvfFDjphJnGU2q/QuirIRg5CjIUGVyzFmG8Zfi/V5J3As2F7VinN+ZjQw+qLmxqX8I75O4WcRvdNp0dDs/md0wwl5ekdomNl6hSoDGrA41fS49D2VQf7FOxwgBdJwltE6i4Ux3aMKoPQ2e1YxRePh/HR3vj4IL/6SP8JU4GsENmAXzFgfE33dOcUDMLZcF3PDvnIqMbBdvv/T3GhWpmjLSqimnMlgkpwXLP0pRowA4bikVzPiG9tdtjg1gTBBE+U8obvREknSRZpdDNzQlKZBRBEtE5n5ERG3bgn+zZPLQYPvCbYDfDwiUGZyARqPs+NFHoLNVKGWzuGsG4BwwrfusmLNo3V8Dd7HLfVPR6QWMzIGL55BUAp22T4cKjaydpsGMqTvym8rcxy0vCQxI6Z2lw3Qz5xBIfk+igt2xdvQmeoYdEcK+/KczfiH3FzRkvKVsIJ/DbzAGCB4EKONW3VzET4kIYnPXJboCfztbU+e3mjavvYS3tbYt58pcd2QdPb+utnNXPGT2k66sINy7sn6cAjBLpUPTmo+22KAYBRuYXjbU+3ggC6XaVhP8mQuVb15Ttrduh71jOPKpuTlfe8cMdBNpy4G5YZNRO44ggIvDxPC+9Ib8Roa3g1vxlhentaS6vQv/7jrEVDo4EyS59Ba8hajTHxKo97DLy+jd/0X9WrE2nsXFKjZyrytL1mnzTFADCLC066pKji0z8K6
 bBZzRHlegZalsrQ2GpmXZBJyw7YR8F0Op5S3Lo7L3gNdtZry0kyLVV0VVpAJEOx98arKyK+NPyn6KOBTJEy7EzhrcQSNhVVVgqrbzGLes1LF2JiVeJgddJcO2kpDHUuQiqtuiOkmk1iqzWQ8myFgkHHixMTN+Qf99gThVr30VzkTJzYDCpZwmXB7nWlrC+/96WW0i/9At9tlY9ttXgsJdg2332AJBALxg+ClVBtg6DRmAaWL/EPHOOfH1pw5q/jFYuA05TUkOd7phGyVHiApxFO5AfVk7EEdy/gTP6OFl04OR7kMsEw6SBUByCanO1pk2imLyaM7kFj3FRGECYdyWVMLOrFeRYz2Zd5lCY61OeG92wFEA/nw8H/5q+SrCyboNmkk6oYGMXm9oH+Yf98fNv7LMb4QOJ4emBWxz8Yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JtngIlAsEZwFOhipiFeU/d2xRH+OGafZACAkF/ovbPzgjMzPFFVtT9jJXZZyTZymET0OcC2WQ5KfsfDTIM1QHM+wv7IMBuyixtUXyYaGgY5ayJ71THhAIFSJhK8Rwxm8ZVhyra+Eb1cPng8TznqWP5ppmyeiJGFexawO7TXuzuxnBZTcGcK0uD/HG0IJrX5//K2FR+NtYfsh3wlkEHoYS7LnHnrZwr/WEXe2AGrWRR7IGHePSnmAa99BQj/KuWYxpoLiBJkXdpWTgUvg3IVjIvu5AQ16urcK6HFgwGTO8Ktkm4IpxjEFZY1RV1pMHpQX1lOrGYNZhJ3GfIA6TiIbZFpbL2qIWmxWucS43K64TFIfxHn22p5c6wtwaPijUXTXzTfHyZ2DPCIbGPu4WSeqoxW96xFji4/sB9fNGbX3MB2H+HQ/lgg5hln3vRlHQlR6s1uRXWGRtE66PrTLzXjb1Fcee4pp51aI5rtC/2EipaYfCemcHiasFhxgIKdnnAIJvmIwE0v7yeS89hke0kUYgtMKMASs1Z+Auyfbb/yQMyPBv5cTuA32lDsOnxEWXFhsutj/D6QKGwvM4Bdo3QqBdq3PIBS6sW1PTT8UHJcR3YRT9XBpApsxNXxOjJ1D6F6HRcVLTT78A27/PoH8MemRKz75tgI8VF0wslCyU/O6/FeebIrdeL5f8984nZQXXtmizj0r1KJbTUPe49Kut8AHX3yX48l6NVSnMlyqqZcwq+aEb9bxzMdT9DwKVBnRA6VGjFy8NGu3yjymJg3WAHFzeqmXP1YI5nMxw+EvP+zRVr+xYmf/S9IwvfQYAFStbeh+8IYLF7Xm6MTLuWSDl/lDCyi7r+T2x3n1t0f3W7kVq5ts8bDTu4luAQHRS+551QCqAX0AXsfNTozrE6Ymxmoc0LN2pJpx2GCq3Uqt8HMaxqxf4xP4HAuA+DYvF8xZZwY1
 eHfDAoMHM8DIDoPp/AGF2AE4zMQueIvwsC2szIPSK38A7fjDWas32TC7wdDHXCTZJ1f5fkDmhpKz/a9P0MR0RkURjTbE/gRfndTv/1TzXkCV5sy3FSQwWQDEguS7iUaB6U4e79ycxEzjU739a6HVHaCUBZemLx5LWKj5e4E0PscgXeT9Awu99V4N8qhkUA091tczW87MWDZIR/VaxKeOUb7D/pbTCJr/Ik2RlXWsOOZbNND5UMTusOJQZAYiU1CmHWOlL1chG/F5xbtR/ApRb+nl4Bvob1THzdictm+6YyYkalf3XdTmPjrWA/MFtZ8JQpJl3WToppQqCdS0yRUpQOElaXuoNUPNzSiqGHjN5xoWuh4RPuso4G6DXUFrlNYY/hz9+6Q5momk3LuPTyrWSMhE6PlVcP0mXelKLGkpanQcn7sPIPyyB2dOLw85RBM4jiJhFxX88OqoRXtgVDSUy6drsbpQnFQQ6I/2rbpIxNNMUVuVHCwas3+p6wYZxRmfBa6UKWvpeKznRqYlgdYl34GP119MobOJCTn4JG/k8qTaLV2a5ghnwlVOpjOKq6DNc+uH/qaY7XM4GKe0FiaMZi1J+fSTzh2bKrqZUMEoQgLPwAr+RugGh8jtXbgmKn8y
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7803a017-ee44-43b7-3758-08dce76df3b0
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 07:51:00.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Srdp3qh/5Gay69C/17lCN25B6iD3z0PGj6spSRuzdscf3Rb1diPo7MF1XFNr70RydCWK7tnS4ERI8+9iLqTndQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2194
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

New patch set with all remarks taken into account.

Thank you Richard and David. I have masked the int with 0xff for alpha
and parisc, and I have replaced the shift operation by the
multiplication as you proposed.

Thank you Johannes for your remarks on the UM arch. Finally, I have
created an UM allyesconfig. I have manually disabled HAS_IOMEM and
INDIRECT_IOMEM. This way I was able to identify the drivers which don't
guard with 'depends on HAS_IOMEM || INDIRECT_IOMEM'. It was only a small
number. I changed them and added the patches to this series (see patch
12 to 14).

Thank you Niklas for your feedback. Unfortunately I was not able to
simply change the prototypes of the zpci_memcpy functions because they
return an int to indicate whether the pci transaction was successful. At
the same time they are used as generic memcpy IO functions in the driver
code. To resolve this, I implemented three wrapper functions and added
defines to overwrite the default. So, on s390 we always use the fast
zpci operations and don't fall back to the generic ones.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
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
Julian Vetter (14):
  Consolidate IO memcpy/memset into iomap_copy.c
  arm64: Use generic IO memcpy/memset
  csky: Use generic IO memcpy/memset
  loongarch: Use generic IO memcpy/memset
  m68k: Align prototypes of IO memcpy/memset
  alpha: Align prototypes of IO memcpy/memset
  parisc: Align prototypes of IO memcpy/memset
  sh: Align prototypes of IO memcpy/memset
  arm: Align prototype of IO memset
  powerpc: Align prototypes of IO memcpy and memset
  s390: Add wrappers around zpci_memcpy/zpci_memset
  bus: mhi: ep: Add HAS_IOMEM || INDIRECT_IOMEM dependency
  mtd: Add HAS_IOMEM || INDIRECT_IOMEM dependency
  sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

 arch/alpha/include/asm/io.h        |   6 +-
 arch/alpha/kernel/io.c             |   4 +-
 arch/arm/include/asm/io.h          |   2 +-
 arch/arm64/include/asm/io.h        |  11 ---
 arch/arm64/kernel/io.c             |  87 --------------------
 arch/csky/include/asm/io.h         |  11 ---
 arch/csky/kernel/Makefile          |   2 +-
 arch/csky/kernel/io.c              |  91 ---------------------
 arch/loongarch/include/asm/io.h    |  10 ---
 arch/loongarch/kernel/Makefile     |   2 +-
 arch/loongarch/kernel/io.c         |  94 ---------------------
 arch/m68k/include/asm/kmap.h       |   8 +-
 arch/parisc/include/asm/io.h       |   3 -
 arch/parisc/lib/io.c               |  12 ++-
 arch/powerpc/include/asm/io-defs.h |   6 +-
 arch/powerpc/include/asm/io.h      |   6 +-
 arch/powerpc/kernel/io.c           |   6 +-
 arch/s390/include/asm/io.h         |  27 +++++-
 arch/s390/include/asm/pci_io.h     |   6 +-
 arch/sh/include/asm/io.h           |   3 -
 arch/sh/kernel/io.c                |   6 +-
 drivers/bus/mhi/ep/Kconfig         |   1 +
 drivers/mtd/chips/Kconfig          |   4 +
 drivers/mtd/lpddr/Kconfig          |   1 +
 include/asm-generic/io.h           |  58 ++-----------
 lib/iomap_copy.c                   | 127 +++++++++++++++++++++++++++++
 sound/Kconfig                      |   2 +-
 27 files changed, 197 insertions(+), 399 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c

-- 
2.34.1






