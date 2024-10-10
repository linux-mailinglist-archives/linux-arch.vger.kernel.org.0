Return-Path: <linux-arch+bounces-7964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59399862F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A17C282452
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF11C579A;
	Thu, 10 Oct 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="IvvlbauS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="JpWgF34b"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8A1C462D
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563820; cv=fail; b=RzXOMkGkPv1tt2JaA6f4mV72CYrMkwvpRsLAT76V2wG89rzJuWG9CCmiTQUVtQQhS5iaQSmy4336fdyAART9a+vGTL2nXNACxMJtJf4O2+ABtCGJJW+1IErH1h9OXlcgh0W/ZXLCJm6jzZKT7H8/onCF+Sb+CstUNS9xp5vFoq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563820; c=relaxed/simple;
	bh=ILZJ1vIiUQcAKV3c/k33LSzo3Xk7zJBeuBxAByYnphk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2hS2c48dWQ4yyRuRMmgrghmanPcszI2X/OKncTKynUvcnUBtboN0Vta3Gp0BxiAI4DnfbwFhDSzZ92B1a4LL8jLBkWR+AmevePV38kdlofHo7uDMkXLWfXmGnybA8wRAtGLgtVICYyI8wu+Hfsj3Lzc5NSp2UR++YxuRgvb4Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=IvvlbauS; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=JpWgF34b reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id 2C0F5511A85
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 14:36:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728563805;
	bh=ILZJ1vIiUQcAKV3c/k33LSzo3Xk7zJBeuBxAByYnphk=;
	h=From:To:Cc:Subject:Date;
	b=IvvlbauSsTVgG7N1+uinYuUmLPE+siqb3oEOVWxCCR5y/hERidaMIEW84o76AfjYi
	 TNcMH4CgaXLg1HwQ6hLcZxe3xtzdSY8hob4gkoOYDJO0Boysp9JRNWzxHcplZtXU+u
	 nrXsrpAStMDzCKCR7qCrFSO9h5VvmIPRy/fv9vFw=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id D3BFE511A08; Thu, 10 Oct 2024 14:36:44 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx301.security-mail.net (Postfix) with ESMTPS id
 245215115A1; Thu, 10 Oct 2024 14:36:44 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB4966.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:36:42 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:36:42 +0000
X-Secumail-id: <ef8d.6707ca5c.64ac.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjkRdTlyf9lKbfqRAH5P0RtphafnyVKNws/lUt/GVMupec48Wo6dfSJsDRwXuPb7jUCx7Mxvu+hwhTXC8QvhAbkE9uOAJyctMWLZqI6ebw5c6BA8PXxDlTqAMMPX81/8wgayMUnV2EvrQi/j062aIs43zZ/rMy8snRNkpoCE5vgDtTpm+m5czvq+plfoSCb2yJGMGXcoilgJiXsKdyin3mNMggmnghDov+TXZbrmMUwxGJIsZU0pHdQb3ZRu6SQpEp6a4I4qBm9VEYIoPcavo5z5eeFK+FigjBFd4DM3ITCCEkiz6IuCEOo4oNjlwRh8cavF3gjoRMpVr5Mm3UILng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+D0MjTdxshzSgNoJiLKme6E4aRg6jw8gECE/x1R+ow=;
 b=DVg18AfzlXXV+s1wmZKm/fqUIop79lesz7iwSlIo4uk+nxYe/IowMtAdmir0IUb8a3Bn4UUYiOi5YVZUPrxXL67KW1sciuLfbWTGF5OLLkKoXwbZ8yyrgtC0O6S2PfU5JcCsYKQ1IeNSCqSN6G/wRjRCcWglPl4BLbamd87ir8BJkDzXdo67fi2Uvq8SGAGo7DQApbpkIwu1J2aNEQdgnz6naigRtmIYzd7D19tQdes4ab4jkd4dqQ8Imxz6aJC4JSwdufD8bvh7rEH10vTKQfMHkYrq15cpvgjNOprRzN31y7p9IhVLicavE93IIM40KOvRIGcNDDewIv49VUDUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+D0MjTdxshzSgNoJiLKme6E4aRg6jw8gECE/x1R+ow=;
 b=JpWgF34baMsVB36HeAxmM5ab/sHwFE29c+gvvT60PptiLCk2can8Zush4KYuv7/P9dDK3VI14YWrA/Mt8cZUJaFKBx/zav3zG+Qryb5QvmHvpIxUpYw5dqE7DDNNJ1nwqU5/+cgzC1NLJoqtzQ4m+v6bZ4LzTlKiPXtrqtK4poNxSlF8KssBmcczDIw5he3dPP9Km1WtkFlCeFUfm2HRVUgRUWsYcFUnu9Q68+RFPlr+xRP/r3QMINPdBqpAqOeoeDNXp2F4Qz+yFmb+qMwK8a5d8uY/F8/dXCzuElSSFFidjQMyvOdTBsmD5INjyJPN3wJUuDH5QUJPlUQj8JSDJg==
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
Subject: [PATCH v9 0/4] Consolidate IO memcpy functions
Date: Thu, 10 Oct 2024 14:36:23 +0200
Message-ID: <20241010123627.695191-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::9) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PATP264MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: d2594024-bbfa-4eac-8c00-08dce92830f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: b/QVXxLKgt3PiKA+ZY+Ppr7+QMpm6Zjxllcq0BKQvThz8zihO7538geUPGudR4EgQnz2o/xzD0rxbZpOiANZh24kIJGxar3qo6g88XaDXKtSVxijVi/XY069ql+wRB1AzZqnLaM7qxWFwpCRcRac4HGvGsCTrKCr3AeA/jjDyBK5nR/PBQvn/qA9Q0tyVr4PRqDa7w47y4iuSZ2ElIUm8KfZMvw0RucpUOAW2b/bdMn7RiJs/0P+ydAr26Gj9OGS93COT9F8V2a74V3vfd7KW0yOC94hKlYF3V5tgJj6Q8sqkbUPKpl5+l8i7V/6PA3oi+YdfNLi8O52WF+nNEAlBXoGnWwbobd+7u1Vh+a1OBCRrJ7fNjw8vALZH5XaH63pGc4KsnQLytuxFGAqM0hb3V5Bo7HRRi2K9CzItToIhkDgZeGZEu5uydtQsuAaymgt58kYaO2ZrKhVKtn7zK7cs2TmXSPtSLijhWYId7E4fxzdcxohb+1uIjaHT70rD4DEhrF15ZyjmecGwOIw8HhYsEw5HiF/EIQ1XYiFs6BtDbDSnPaoo06h5KKlzdv4gNlxqsmUuKfFNkMrmpU7xHBnHCnInCeV2+pUZuwk5RTfamcbs41z7xGw1V0kk7eRPrLBXcHXtvFhApy5a1C2nhZqCiCMS1u7rptftjpQiAlbUYvKUUrSwLluqnJR2zdBzdRwo5Z5gMLwPgqfxskyg+9GNHHuYx7GBXD8q170YjAeaXdNwVnYmMNAqb4ZcgnAqBUNGFQiOBYKbd79yrV7QSmTMDe3EQiro3o0WRA3HeudL01dM/7Wd7Qnhzn1/njG+XQVWAUTlEOXXyeDa4lrbkAdpAwh+HqiefcfTYX5OBDplUWs2GCEy0faBob7e/0pqo1zBmX0gSA2oS6Tul446DDoYEQ26MOl2uM6MwuqyXuwpdzPOwD8kbfcq/9Ksl1RJeiwDQN
 p/d3JvhkWT3XLo4iIl7cTEgAXMKr0r0YZy1nH+lcaaiynQPImOYKozxVd7WO5aPTgZpOwZLZ85TWHsZBUHYAdlUdOnGHDm3gikuxLkB2cURHrk5hxBIRhN8Yr0Tx8KE7P2cyPaNfYB8fBFDjSXTBeebTDgrLopXseJS5aVxVE5KUcj2y4eHU8Q7CfGY++/8GRGKc7TGs4IwYxsb4NOCYCpHG1B3DQMSe/C+YphvvWICHqBEjXwT3GcEI9tK+dwRBZmimDOAC8N7NkiY2QaGsFT9z1HDeO7pFfnw7smVcunTvcJOYYN/diwBsTNku5tXBSWhU0ETyShQVwh8LV4JCezpQcQopLYIbfw5bMo8r/1sDtfUj11XbI09u7F6jCJHdyvPdVlUHhdVrs0N95wD2cGlkDmRbnww+uK2km9zE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: APjsiRVZy31I60UqaMwVJHkLZXSbdcH5WU6WYZqZ0Oo2ndWJPcjOWJlvM9aHP2N4paLNLqjr4rJY0UzYlDToqmNRN+Uk0QNXv4bcp3l55zmWvVc2Rnloypw3GL7fR9tOAhwYR89tSsKmiXidlK1ZkkGOWCqWiSczrjOS2gueKNXAOUiWAK2Q4qQTJL6MLgzt4I246jmBIHMzvuIztdMqIxtjw8O0hk7uTP11J1XY9uvaLsSee+lXDpOCaGEgL+NzaTBZNHbcxVdyxG+J+2LVfznIoOY5CWR7LNYfVhsEUdv485KVYEF311DfXuRTgot7G2HJZMCegtu3QTuegUJoszX+mf+91VQSA0A+RmJN+ujHM5wSd4lIgavQGLvDfVocfxOrribfbCWTIng3bRO865iYGLxG7+j5c+35DuMqJnWkrKqzdlg68HFDgZZBMIGpz+w9D9gb5IsCBcdV8IIxQLc/C/7aOlrkRGBRDvoE1NoNuH0X2GYYn7lMe90T/c6+pwBz471nmYWr0lnrJv5eTCv31ZpKbz/b1IRFgnvwEt1RSjUL4850RIrlcTuqGQMkHNMOE136uJmcu1Upxo4kkjv4Yg9wqTQsMjMwMAlSJP5VYynV8CNg+lidku0g+4bJCTGuz82sqIX7augpCacREVg6hLbu3Y1hB24sIcQk2AvT/SIdW1hSoLyjo4q9jz6mxmQtaI7zsBafvhAN9yEqwdjZdFVdxGOQ8+aAoDtKZApuXouBJxVs7StJCdCV0rEaS5cnGtC0wob2ptdRKc6ZAOOq6C3/rKwaZSvBR/lV+l5E2a6hb+lxary47rpxF7/yGdVqfShRQIaBx/hwQHxf/7S+2GX5rshAJmRAUA8ZsKVvUlty3Qo7YInbwJ2WxHGeY9k9uF5bmaccgiQyMHjdLfqLyczcWkRm/0n+uH5yll/uGFo4Lf/On1EUBF/wvCqf
 Z6dLyF/mLNzs1I53u0Ixe3t00T5HAEOejMSF09DjKdVVwOj6yR/d0HifI+UPo0uZ4Uz7iFWEyNaO4rWQx/NYOGf6vSXDtgIvxafY1uqjLjeWuILVwsnC7UgxBQTGIX1nkTooplgrt9NiWjulze3X7PFF38/JduHcLp+7+XUjHzzFC782R3nvpUzwpQojoHJMdqV7knslcv3VSAFXip9ZtgoqG3AC1MdEC25FhDxY+2uLqIJEcV53h6a5coBbNjIpeGtFUn2vHuApVfZDAiZlkoXtIA1KzAQW9CJV3CSwRli61SsBzynEtD9nT5b5mALDgl9Ni9lP2XlOHaoZ8415xqXyZqA9Q14M9WE95JzaLk4WI/0QYmG4T/pvphb9vqzlpYyGBPcIwsVwvKokL0OofhRT8nWc9o96uFIU3eQm1h6e20PHv6PJEB4xBI10Zw4NjzzpNg5TX2qLQeIisuV1SyBf00Fr3mpzq24B16oJJkRuuAOfeIot9d/+i5FMk+Nia4H3J/7PyKR1Leh62l+3cKMoCcAje5NYxrwD4cM7dTLZYzjjgkMjbRiYG8PclykvrIxPiQMT0I1F3v4df9uXw9MTh5kRsSHAhR6guP0BLOk1Je5yWR6n8OvS9hyraZSy
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2594024-bbfa-4eac-8c00-08dce92830f3
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:36:42.3660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5v8fzLyzdrKJfoCFQb/uo++59ZVrSIkPzyXT9p3TBjcYHC2hCpRiey+NtNaXVI1xnwu1QUwvBzSsWz2PEhVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4966
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you for your remarks Arnd and Christoph. You're right the patches
got a bit out of hand. I have now guarded the prototypes as well with
'#ifndef' and I have dropped the other unnecessary patches for now.

Thank you Niklas for testing the changes on s390! I have dropped the
according patch for now. But I will send it to the s390 mailinglist as a
separate patch.

Thank you Takashi for ack'ing the patch 14. I will send this one as well
as a separate patch to the UM mailinglist.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
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
  Consolidate IO memcpy/memset into iomem_copy.c
  arm64: Use generic IO memcpy/memset
  csky: Use generic IO memcpy/memset
  loongarch: Use generic IO memcpy/memset

 arch/arm64/include/asm/io.h     |  11 ---
 arch/arm64/kernel/io.c          |  87 ---------------------
 arch/csky/include/asm/io.h      |  11 ---
 arch/csky/kernel/Makefile       |   2 +-
 arch/csky/kernel/io.c           |  91 ----------------------
 arch/loongarch/include/asm/io.h |  10 ---
 arch/loongarch/kernel/Makefile  |   2 +-
 arch/loongarch/kernel/io.c      |  94 ----------------------
 include/asm-generic/io.h        |  62 +++------------
 lib/Makefile                    |   2 +-
 lib/iomem_copy.c                | 134 ++++++++++++++++++++++++++++++++
 11 files changed, 147 insertions(+), 359 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/iomem_copy.c

-- 
2.34.1






