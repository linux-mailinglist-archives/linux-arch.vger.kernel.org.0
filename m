Return-Path: <linux-arch+bounces-5307-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DC929A82
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D481C20ACD
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5A816;
	Mon,  8 Jul 2024 01:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gzAdJQLX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="XB7ljQXs"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AAAEDB;
	Mon,  8 Jul 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402075; cv=none; b=Sm10bVkSiEwosvUsP1mYP0WCn+QWhhtmajtg/ktpfAfI7SfIyxMnL6i1P86vHAsp+xBOZGqDAc1rkbxv9t2Rfd/BBqPFnpLUqRu9wkgRuz+9BIi6YLnqe6ltj9GbUQzP+YXOZTcWvF/Cfmf7QNg5E/kwpHZeVqa5WIzQg2muDgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402075; c=relaxed/simple;
	bh=/35G7Eq9Yo/h7aYs6YMQCuWDSWjHw5CetAaceDv0fl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1uOxeTqX0+JQNyzqoU4J5BNVlrfbyVqGSVcWjV8KEAz2FNj9N8duTquuedi815GHPPdIyqPSeef8hCHK+0lD1g7Wgm4KeOxRF/8LlSTIvxB2Fbpl2XVX9Y46zgV6nMlklNif/GFQMD3WUY0Z8Uj7zV0H2ZbVCY1xt1VdPNmM7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gzAdJQLX; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=XB7ljQXs reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB9201C32C;
	Sun,  7 Jul 2024 21:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=/35G7Eq9Yo/h7aYs6YMQCuWDSWjHw5CetAaceDv0fl4=; b=gzAd
	JQLXzzL8A8vyxhV93Tl/EQJHkPgtyOq1phtNPUNxH8+ahFvxsrEH4+7vBst07a1t
	ofAj4He0ehhywWfRs1b/1ysdremNjt4Hu5v8/oFCpOO6kKApa42rEuQi/u/mhvCt
	rro16qzz1Jd1f80e/9CiiCScFvuYoUkGF0n0GMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E12511C32B;
	Sun,  7 Jul 2024 21:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=vqc1TvpWQg2Zpoq5nKdcZe7n8d9ha238GvKRDH7RB68=;
 b=XB7ljQXs7YuRMJwTeUtQ/3PfMTPzqjBdr76VqhuNXt8+PMZuFuzGx0Ek12MoRAhom3HV/aiH1y5Y8EVTtL4i5vmqzcds229rChNktlvK4BJP1oMGrwjAW466O1f8Cauqk3+qhx4pFGmz3QumfaHoy63RhcNqLKMqEKMAn4QcJeA=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CDC81C329;
	Sun,  7 Jul 2024 21:27:52 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 5CB50D3BCFD;
	Sun,  7 Jul 2024 21:27:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] do_div() with constant divisor simplification
Date: Sun,  7 Jul 2024 21:27:13 -0400
Message-ID: <20240708012749.2098373-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4B80CD88-3CC9-11EF-B99B-965B910A682E-78420484!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

While working on mul_u64_u64_div_u64() improvements I realized that there
is a better way to perform a 64x64->128 bits multiplication with overflow
handling. This is not as lean as v1 of the series but still much better
than the existing code IMHO.

Change from v2:

- Fix last minute edit screw-up (missing one function return type).

Link to v2: https://lore.kernel.org/lkml/20240707171919.1951895-1-nico@fl=
uxnic.net/

Changes from v1:

- Formalize condition for when overflow handling can be skipped.
- Make this condition apply only if it can be determined at compile time
  (beware of the compiler not always inling code).
- Keep the ARM assembly but apply the above changes to it as well.
- Force __always_inline when optimizing for performance.
- Augment test_div64.c with important edge cases.

Link to v1: https://lore.kernel.org/lkml/20240705022334.1378363-1-nico@fl=
uxnic.net/

The diffstat is:

 arch/arm/include/asm/div64.h |  13 +++-
 include/asm-generic/div64.h  | 121 ++++++++++++-----------------------
 lib/math/test_div64.c        |  85 +++++++++++++++++++++++-
 3 files changed, 134 insertions(+), 85 deletions(-)

