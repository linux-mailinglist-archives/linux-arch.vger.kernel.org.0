Return-Path: <linux-arch+bounces-8793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FFC9BA5A9
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 14:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03804281BBA
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E542170A29;
	Sun,  3 Nov 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KLF8HuA2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B1ABA42;
	Sun,  3 Nov 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730641042; cv=none; b=EuIFYB8XauCHhMeLtpHfMwAP23xSwT5dtmUQ/71YS43zeRabyUG9vW0C3Z1oWRlV9cwL3ZJlFH490gZF5/Hofte/8EjhsiicCbkzo0/oPFWB/AsMeUlg158Y8U6BjF5r2qlyuEmXyvUfLu+NMBy0flECPFUBJ+yD96d786kE+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730641042; c=relaxed/simple;
	bh=0u2qY5VmW02QoZQQ8PVGB0RvEt+gYfighmeowfpBp9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akCh/hWE7sNeulbTWRNXrTD4fAyTA8PjhMOHh380Yhb3j0P1jsSibQDr1Hbj6zmQFpvF+3WwukBEwXkVsii5JkR/tSuif/+KGdAt518ZhDsgWTCXsmEFwu4qWKdmJS+eXIuNHpAofXFQIbi9zFiD6CLVHtdNEwEnHgS9fPpXv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KLF8HuA2; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1730641022;
	bh=0u2qY5VmW02QoZQQ8PVGB0RvEt+gYfighmeowfpBp9Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=KLF8HuA2XZZA8PyiFIvxZyWe/QyPFXt7v/I0izyxgFtQDYw727X9/PTsC+BZn74Y0
	 mWRYJkxiA6zPS+DHh2CYqTkCl6rOZpFl9M65nsnUxXhTKvCMjUxLR4CJ4QUZsLa+Ci
	 r1taA2f3NHlHgNNy0bmBr+6w+ezN9xazZzSxWx9w=
X-QQ-mid: bizesmtpip2t1730641018t4vihmk
X-QQ-Originating-IP: OJFfFUb+TagDtWAwy6uc0+sLCBe0njxsmdHE22f+THA=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 03 Nov 2024 21:36:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16809586154877906677
From: WangYuli <wangyuli@uniontech.com>
To: ebiggers@kernel.org
Cc: ardb@kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	chenhuacai@kernel.org,
	xry111@xry111.site,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through lib
Date: Sun,  3 Nov 2024 21:36:55 +0800
Message-ID: <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025191454.72616-7-ebiggers@kernel.org>
References: <20241025191454.72616-7-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAXRuxnbzssegXhSBUmiIE6Ni8PjKv5CHWWsGTJU0o95Ea/t2pd6wnqu
	av3bthBKz45tsWOf6m/LRZbQSWTt7BcsFHtEyxKQKiMG/UONhlRAE+jREH3dkz5J2RCrn3L
	EbNOGompESEmaKd/JRKrIWo8YjKuybwCcZoQbJlwZLKdyOeketSff2EOXVVi197Q11ABGJj
	zCDVLr5RahkoLwstEJ+vqFDa14JyI0DM16D2s1izf/JZoWOsYMuhDx5NAlzWweFxdxW8iJN
	VOIhEiUl/8dvJ/QXdQCUu2f5le0cqfUepm11FxRrjAo1Habnb4GSCzeWanGtE76dDAIzK89
	OY8bTcZrACgJJyaasaaeXrLkuWqajEX5KrRt8689iMb4z0Qty1MYQEUokgx/tVBRJYO7ePL
	dF2C2KFfnT1ZNm2JWJNccTgd/07en/sJl8LazlcZen1MBts3mA8V0YNF1Rdpkb4o/Y54qc3
	j8jDPxQhsdG9y72GOs4QMaPR1/fVv59RW+Xm+4sfr1yn2ZoFUme8u5u3kez4CvZ8Bdh8sfJ
	Y/dbxn8T25Lf8NWjJG2BvDKM8jSC7HAEJvGJKUItnpI8z7m5TEq2Y7PNear4vrh24uVr3dW
	9YhZYMHCMT4Juxx8eaSJg7r5WfqgSqOg3ark4Q2lLXWELJ8XxcjmniURpSeuQL4xpMELCiJ
	gDbVnykSObxsNor/pBnDXf3bK3KCNZFgxQNJtWkbgM5ScOyo73BbeExW6vzdv+8R9LELDiP
	tpiVn3b02RS2f+C79pak5W9FN56GtXmwY0F1LA3+ewf2qDy53ROjE6xLkhVZmVsXzpW15YJ
	9dPYVLJTZftDqtbbXCu4JW5OsrQUPJSiy8gE1wMdIolddx6iRYquGlS1V2EaWe6ofSQvdRu
	R/ksWoSGNU/P1X87cIITRGob5HcXmjUmG5183YZTYAMUsBn4B9ub/nQ9dwH7swW9vZK4Pn6
	sIAhRQ3rzG9Mxm+a6HLoaOYfkMD2LhuDprb8k4DagQ4WCLUiNRAJJjSPdh6CdSaZNOIda5s
	B+fiPygXfSsV4idJTf
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Even though the narrower CRC instructions doesn't require GRLEN=64, they still *aren't* part of LA32 (LoongArch reference manual v1.10, Volume 1, Table 2-1).
Link: https://lore.kernel.org/all/0a7d0a9e-c56e-4ee2-a83b-00164a450abe@xen0n.name/

Therefore, we could not directly add ARCH_HAS_CRC32 to config LOONGARCH.

Thanks,
--
WangYuli

