Return-Path: <linux-arch+bounces-7491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C73398A4F1
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808BC1C2120F
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDD0192B7C;
	Mon, 30 Sep 2024 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hOzICAho";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="TPfwuSz6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192971922D7
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702762; cv=fail; b=Kwc463IvSpRPP/RJExzPRYwz2D06kj1IWQSuSfufO1L0MMvo2kNWJlTtv1T6801CgiAZnXMqspl/WhXEOOVib1zAYR5FfaRkD2uY9b1khmH9+ejVGLDOJpdtukFHByZwTfK0B7U/4bJsxt6iy0oAKGUmvrpbCTvQ0DAQdRniacE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702762; c=relaxed/simple;
	bh=LQk3toesTkM1HsGmEp6QZMyU3eu7E9giaCoxA2NhHvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sji0OMHh+k7IvCbIT7QUtB+V5dST6+rHzYt6mRbmIZf0fGRg3s3xhdlPARLCwdrnCkO4c+P1NCFobIJSn8HdU3YXmQnjww1nxIhV78yyXXpo/JUdwr1VXsqa7JzRgDkDf0MJlEtKirLrKn8Lm3FBvgBF0CDKLT0KgreATOZbVX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hOzICAho; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=TPfwuSz6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id E888B82E8EE
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702753;
	bh=LQk3toesTkM1HsGmEp6QZMyU3eu7E9giaCoxA2NhHvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOzICAhowCJ7LXV0TAegtJDs0jdQw6/mWFpUiACOKnZCeppNNvbPfDReCiq4szpXN
	 5pZsjJ0osDbzwVuirxskuVZxdidW1HqtuI+26smGRNkfdoxpnL3uHiiIaVyVvbgEt3
	 BU9me7l5EtbRnc06RtHWWwLKAFpeGWnR2aoNcySQ=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 151EA82EB8D; Mon, 30 Sep 2024 15:25:52 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx403.security-mail.net (Postfix) with ESMTPS id
 B3A1F82EC87; Mon, 30 Sep 2024 15:25:50 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:49 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:49 +0000
X-Secumail-id: <11e87.66faa6de.79cde.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeyeDGZCoK7p1Ea9VICXd8VQ9Gnj95jaLUvjmSfcB2R4yisPur1wumc/KMsXb/WQE3Zs/i65rlPeH9+9KwX7YvMxyJwnA5YC+GiwQ8VJTWa3fcyGNGUPD9E/jjbV1zkMg7y89QTGhXKxsr/ypIe2vlxaxlVFbfDhPv+eTc9ALKa8iIvGBbXDwjSBM54xMjYq+9FYx53ePY1b0bGUm1R5aRkVkVJ79WSSkno9+ScD1nYMK0gO3460dJ/dsYjjJR5mIorvVNsQ1sIWwInnETca0cYGpYZaaGK8Ym0JDQU7DI45Mc6s6yiLBELFxqZ3Cr1JzbkIXTtLhFLShkAsF2DZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0s90wsjMK/jbDfhdNxssM2YpIV2OeFiWfX+p7tsFW4=;
 b=NuEyr/5Lj2XLqseKRW6QUYcYBd/G8Zy0xtiz8ryLvJ4cy9EF4opvBlsXMc1akAcvVhUafu0VbntjdUQqAvXGQw0wL0sywep3utV7HaGZBu1oECkiBT911/XPB5BnG5/ckF+L7xl+yF+J0mYN2ysLg+8JeFCfvA/nnRZlgbGkt7Txiy9mnHcsZJGmgHWQJVOmtil8ppiyRcVXiD9GW4w9RgK4m2V8Jt+T9NuN1tSYgpASeuuuwaY0QQcdCY76Pt7F6aGkzhLU0RI/48l1urGW+f7wDb3PNfpxx7Jde4NcrIkCoaCYnwnc1lKVEO7voIZ8kMD6ztMik6h+1UerHF2v4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0s90wsjMK/jbDfhdNxssM2YpIV2OeFiWfX+p7tsFW4=;
 b=TPfwuSz6AG3tl1p16j4F7y4mS+QHb2dKYa0C/tV/hRgHDZ76Xq+oiCIK4glnYRjdTLHUEbNkEkH/aV2+j7pJH9Qd5VBl3EQFSE8UHzz7Y3KbWBL0lhbfbsFC6uMtdcajDQzcdP9Qm38TnYlKjWGLA2/LuX5IzIFa/rj8qBSsBejAFHUMXtbzCRMc8eSYn51a7E/wqx0nppuPlwxNh3UrmwDw5oE2LupyguPbp08KKWwCEt5v1jGuY9s3tCiY2yGVrHlsPPka0bJ0zY8Mw3PyHgBrl0XWLYM1eL5iQm7G4f/hlNziAEsr4dpTpoO5rthqvRBIXrdRdiipsSQUgm6Krg==
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
Subject: [PATCH v7 07/10] parisc: Align prototypes of IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:18 +0200
Message-ID: <20240930132321.2785718-8-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: d1ca20f0-dad7-44d5-440a-08dce1536603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 8mJUSTw3lI6CyovAfXKFhWQlKR89cSCqpD9cAPVZ4OhTQvm3an7C5TDx9wjQbnwN0MIBsIyCJUOUBY0efljUeORU3fnUGJYuo5gH0LLjDm0MlUdekWngqPsB0sGpsoBJy4aWeq2cBe3ANr2nq7P3m2bW8Hwj9EY3KMhZDouIEf9Tjr17oXxYFUIuJbn+U3HhazEMXfa5djKj+vgMwrUvnSDi7RIVeeMKn5NV2d/2URDcJQPMbzpKcrZ/90+FTInSjrx5f83fM+jSxy4rhb2N+LhOOhFLL/hIOj6FWHuBd9EwIAF8oqjt26CzVGtn2Ofy4S8S2als1gvC4nZSMf7jWDIfLTB/QfHvPGOZ4fRvL2LvBzRK60KlSkvXfQYoIK+1aQJjsPoP+PsPeFv4lIxbV5YyZfUnT8Q/56/1Is4u+hocUbgGAxxNxUGtOB8qWJgb4ZB1BOr+R5hxzESHdjIrGCl/LBYhSC2GDqzeW5W8hmIn1bgAH6RDoj59AIPi8t15N3OczaIpmdcIFwE+7ndNF9K1PaaRG8aXbgxYmMmFtarEH8WM6r+MWxZB0yvAb1JCAGikETAJv67rN3EM+6AL4i4UxTvhmzKgMvlARTAUrU09ary4QQcZb6TO0/jIu4LE7anZlQdA21PzuGKytTCV+HpwhSs2VzriCu/tnS/B0Odh21MKANXIzl2mIpHMFV6DVQ4OWxTDbc1LRAi8sbW4qE30KsMLaIAkoQC9sJ1nf7BExXUqnydwsZ1iyYmQLBH2f0JM1gdHQ2jWpqj8fb39Ag5CzjuFxZVRocsQnkIrx6z129o+YsxgsNZ3fqQgIxoNEW9kJ+f61H5fMKYTM0ktuqz7e3RVmdaFAu1Mv7+gV29Lhz3xoSgOFStWz+VXToY1i/BRX0Ey9u4koh//GooeJQHDHKQI7v5blauJal7iq22FKP5qGtiiqQaSVdbITzacxH1
 2znqE0ca//kq5zi1vVgVmhuNYyoODNAdcMtyP1acvJ/A6QvSCV4ZTuAV5Qk4SUr3o/tpLAxVvgZkezCvmroQTZbLdynMkf+G8Gg6W0GynHbFPMdHVivG60o+U6TgWwmsCg+TviWHg//ZyWS2G0QMsVoPat5T4vb6kp/i8+lbaJhJk9ujrUif5u0pZCLjEoPD+06CZrMbiaBbYR/KUx+NDANLAvnPpVEfN3ORyF04YJvkWdlcFUSXTNsm4DncT43jr7AdJP2blLbpfRdqOJIi0od4vtfayrslxQb1zq9jgoe3YRmdIB6e0u3R+exO1BsAIC3uuIW8P4H3xmW9i8jk7sGpRLhoC3mJgFNBtKqEqzMtu9fcypnbtUHpDBpCTjhkUQIbpxaoPl7GD5rTML/zxs2CRAwGNCOSVxizFsdtag8Qj62wG09n2/bFEHqrLCsaO9XNXRov6l6Jf6IbHvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1O1BpB0RZba5sDbTR3xpSYZ3lkz17dS2OaCRYIMO5k9Ohqj2JrLveWto3OHSKnIPE2Xfg7ybt3toNlUd/YQVNMKb8SbBMz4aG3H6weG3dysp48hn1rbBmibcyFI/F4Sah21T6Esi6MnL4BgDk0ygNwkWD7PzVQ44rfg0IIBL5vEPAZhkO/I3UNq1EW8Vy95L1nrXPuBWXbIYkMuN7v/YH+R3VpWPKvkaIrP5L90DL3ukivK9fFe6VARBozIacqFASRUgPDjFhut9tCqpIar9Lz1L3OlV2w8ZKVUnoDN1+R1sg0GpbfUZgMUyLsfbhpTAK9Ykd+sPS4nd+GdfZ+gk/X5b9GbK4HzjuneWNndrGRAq+lsW56UkXqobu9/h4XLt01SB9lrwVPtjtryV8pHBzN6GWZXQ7eBT5VD1UkxAt2QCQu/xl4eCy6zI0r4bRr0C8cVLu3WjWF49pw7tgRj7mGjNdPxVuFWbzjhDxq6V/Ef6Jg3pfgXyNRWFULsI0FlySuyOGrxUpDeTIc3ET95p6cgwEcQyQc9wUAzLa/SIklOLhVD/TaRvHqdrJEbgnPBk73r4YOv0JbnBLaPuaaUHLOPB53tDCTIps6uDQxaId9poYy7D2BHFM0t3ILBh0OlaeKvOZWoTa0L7Qh80NIk7LYWHa/W9+/QB40TrgOhea5TumIsPwjseSmJYVEstlttLtPjK9NpQLTJUPKGr5bOXUEm1EjW+qx5kAqRbTggu7lynv8rQ7z4Ue71b92vHUcZZJGVlCacUaqCyDkMoFac9yRN2W7siucYUJIFU0Arp6yd+zpic0lcRCa6r9A4dGKpGYGNUqabFwY7VolkqXzizXsmN1GP6aMX2dHRqpG1xIzti1Ox2+Pz1gE1e+zSy4i4/4zdajYCMvMPPgYTPm1WUOP7Qi/DHIf4km+d8P0J/uTdz9TecBUhMQn+MQnLfMvVi
 RpVWz1MTKdruZqUqCgMIKCw2oIj4YJ/Vl9aDTvFCCXMAJln69V6VquK5BeZz/RKp3BEq6dywjJlaPZZFdycxBpnmdUEtUpmdgg3g9XwstjDKIDQKSk4QILwayeZMg9DVsaplBLSvjPfAHXKHKLSD5tfWXpuDVJTq9wE3VStUxJy83EVoiXOx9vjsfE9iuweeRN6Tg7EX9tQEbcpwKSgPa3ViAxDMjQQaaIwljPjL4v9lacZKUred6EQ82rZLW+qrQd9BEFN01OtlF55w834iGJbqcm/EHuwxP7VPk5VwKsPMXX1TURU9Zif21oCjF8cJ7j48hNwhWePbgKImoMDAWWfOPfkdTJvxf4gT5p2QubyifeHZP7BaHk7ihOPzcJREHZ1uA2eO6pyq3Zge7GJhX+3fOIhWywEXbyFcACI0TmegW1XaRvKNla5SQ29xOSOVXHs9mVEZ9tdO2cAOEwAhgBvbXfuVM7tMa0rg5vJcs6SFtPsHajN4vxmVd0D5Z8EvBQU4uqk9kb7XDDVoOqoQCyyowYYv+lQXngmI1/pDdH8cJ08s6IwyvBpuIf3Uhyxl4yTWgr14ui13shLkx8bkZd99WhFs9vDfFj/0s0S8fcU3I/bfqUL/8P6nip+XRWkgoHRnYMFfXecBhVx2Ah3zgg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca20f0-dad7-44d5-440a-08dce1536603
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:49.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zNNeU/kvP6RhSuDsxHeQfR3UB+7aIcO+pjZsw4Z19RmU37ZqIHNaGZpQhes1HOE3EnPuf751sDp7txHdXOc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c and remove function declarations,
because they are now declared in asm-generic/io.h.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- New patch
---
 arch/parisc/include/asm/io.h | 3 ---
 arch/parisc/lib/io.c         | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index a63190af2f05..5cfaa76bb899 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -135,9 +135,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define pci_iounmap			pci_iounmap
 
-void memset_io(volatile void __iomem *addr, unsigned char val, int count);
-void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 #define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
diff --git a/arch/parisc/lib/io.c b/arch/parisc/lib/io.c
index 7c00496b47d4..1e63112ba9c9 100644
--- a/arch/parisc/lib/io.c
+++ b/arch/parisc/lib/io.c
@@ -16,7 +16,7 @@
  * Assumes the device can cope with 32-bit transfers.  If it can't,
  * don't use this function.
  */
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
+void memcpy_toio(volatile void __iomem *dst, const void *src, size_t count)
 {
 	if (((unsigned long)dst & 3) != ((unsigned long)src & 3))
 		goto bytecopy;
@@ -51,7 +51,7 @@ void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
 **      Minimize total number of transfers at cost of CPU cycles.
 **	TODO: only look at src alignment and adjust the stores to dest.
 */
-void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
+void memcpy_fromio(void *dst, const volatile void __iomem *src, size_t count)
 {
 	/* first compare alignment of src/dst */ 
 	if ( (((unsigned long)dst ^ (unsigned long)src) & 1) || (count < 2) )
@@ -103,7 +103,7 @@ void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
  * Assumes the device can cope with 32-bit transfers.  If it can't,
  * don't use this function.
  */
-void memset_io(volatile void __iomem *addr, unsigned char val, int count)
+void memset_io(volatile void __iomem *addr, int val, size_t count)
 {
 	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;
 	while ((unsigned long)addr & 3) {
-- 
2.34.1






