Return-Path: <linux-arch+bounces-5299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7964929923
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95C41C208E6
	for <lists+linux-arch@lfdr.de>; Sun,  7 Jul 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C1D6F2F8;
	Sun,  7 Jul 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q66UZuaU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="tjftYmuM"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C66A8BE;
	Sun,  7 Jul 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372773; cv=none; b=fcsWWbt4/yquqpgT3S+AbxRbzQM/HjL3xtaBhNQgqqw9HP4OVJLvHdYR65LdK2RRNM5X8h4qEe0mIiAo9aPgIZLkZz5Xt9w7+bJ4t02Yv2lsAHw23jL1fgAQJVMU+kAoC3n3qiRm7IhTV4JyjfAkuu5Ux5apzGWH1W5GySmIZMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372773; c=relaxed/simple;
	bh=Wvb+Vn4lROGh7zULPRLJ0/y1kO2X/fYwxN0sgAcujaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8VDDd2otKsAIQVmDhH359VybV/NbWxN/HTfrfI1Ru3giaLs51GMO8OzUna9BngJ9uM9VQjmHY9noJ9y5mQYcQyY1VFJNNk8Q/T9G3BYvXVNA1fXV8C/+P8z2FwtaztcjPjZIVGM4zCaJHQmGNhefHenAqE3ysm20ZfRSbwCmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=q66UZuaU; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=tjftYmuM reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 36AF22D821;
	Sun,  7 Jul 2024 13:19:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=Wvb+Vn4lROGh7zULPRLJ0/y1kO2X/fYwxN0sgAcujaU=; b=q66U
	ZuaUnHOA6wiTDUCASWYGi7jsPc6YOQPCWTfyQjZCeusnYRPbqDd/VOJbP2pQ/5Z0
	cnXRj6wPHXP+2dF0tIg/9yfj63qV5EeOKmB9dIkt5q+1agAH1ZH96wT+RkDO7RXz
	XXN9Q+5oge0zMfw+oljONYQDyts5+tRN9NJgd5g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EE802D820;
	Sun,  7 Jul 2024 13:19:31 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=OKKMTFAfldo0lBdjlf8CjAfHfITmKkHhDKlvSVqT+nM=;
 b=tjftYmuMK6QOrWFmUZcAqqMtkuLzedeQZqG0LlrWZZjfrs7h98wvwyOGbOyhybaLs5zQi3dK+6TX1JNQIbMyTq5Fi+0tVKN0xLZC4IdRuIhH/4iILDqtpkiWCeQaqMpLOn69uEMV6lAlcPXmCI6TZOOADlRu2NR0XMp5QgOS3mU=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 312B22D81E;
	Sun,  7 Jul 2024 13:19:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 16A30D3B289;
	Sun,  7 Jul 2024 13:19:25 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] do_div() with constant divisor simplification
Date: Sun,  7 Jul 2024 13:17:32 -0400
Message-ID: <20240707171919.1951895-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1037ACAE-3C85-11EF-89FD-C38742FD603B-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

While working on mul_u64_u64_div_u64() improvements I realized that there
is a better way to perform a 64x64->128 bits multiplication with overflow
handling. This is not as lean as v1 of the series but still much better
than the existing code IMHO.

Changes from v1:

- Formalize condition for when overflow handling can be skipped.
- Make this condition apply only if it can be determined at compile time
  (beware of the compiler not always inling code).
- Keep the ARM assembly but apply the above changes to it as well.
- Simplify generic C code for __arch_xprod64() further.
- Force __always_inline when optimizing for performance.
- Augment test_div64.c with important edge cases.

Link to v1: https://lore.kernel.org/lkml/20240705022334.1378363-1-nico@fl=
uxnic.net/

The diffstat is:

 arch/arm/include/asm/div64.h |  13 +++-
 include/asm-generic/div64.h  | 121 ++++++++++++-----------------------
 lib/math/test_div64.c        |  85 +++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 85 deletions(-)

