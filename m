Return-Path: <linux-arch+bounces-5274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7F928061
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 04:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B36CB25729
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 02:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73BD171B0;
	Fri,  5 Jul 2024 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lnX72Os5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="YWy+BNcC"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF314292;
	Fri,  5 Jul 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146260; cv=none; b=uwAiIHMBOpvs6g0AQxGnZTZNT1y8rhSjDbt+ZbGEVUZ/67aPTreNLG2UZFk/HC9WNExeX33vBYWrtMYWJz+mAZYSjWgrooJ3A4BkrKzCNMjKfYq71dXwci2wk5nii1YpvjPb25g2eeRf9F+gD565CrSYyX2jvMRehrGwpiv9s1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146260; c=relaxed/simple;
	bh=DrYr6hH0eKU8shFYoY+PokeRA+HwtHnNToUfsiaHibY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IApnQBfAY1P2GG7+a8PyU6DXszm5KfhMIvA7TFpCb0IQ4jj/GFIXotVACNTCj97w6KfALBkjUjlM4H+O27QI0XTki2u8FHEBTMAnqFog/W8V5w+G0f6z7+uP7+vMTX4f7h84qlpmy1gZM7VueXPNsbgmVxNSggU7eMr0kXEvrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lnX72Os5; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=YWy+BNcC reason="signature verification failed"; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D9D0367AF;
	Thu,  4 Jul 2024 22:24:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=DrYr6hH0eKU8shFYoY+PokeRA+HwtHnNToUfsiaHibY=; b=lnX7
	2Os59LYu2cwHIuFMQCzXsqYkDHtme0yoL121wPPOxPlKIIe1vH2WMBRleVwhtAXV
	GvuuGzFzer5YeE7th9u29H/CY7Zgat2s4rS7LuFu7T8FGUyZ/1knvAFAeQ6sVIAV
	HvlEDOmXOiTEaMEB+1biaCBEY9D2oElczz1JvWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 95796367AE;
	Thu,  4 Jul 2024 22:24:17 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=2016-12.pbsmtp; bh=DrYr6hH0eKU8shFYoY+PokeRA+HwtHnNToUfsiaHibY=;
 b=YWy+BNcCx2hCyd7aiR7Q3b1qjvgHegHBtTTFX0j6T2ytl4mmvIX2e6VYDPCyBp5xrjVYqVrvzNLacH22tAcKLlN5Z/z/HMiJuxDB98XsGBG3MUa1XD7bCvjwpnvNLUd6pckwoQTtQAvi3ZRiqqt/I10AaDLZLhlNloxbIoEenTU=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAA9A367AD;
	Thu,  4 Jul 2024 22:24:16 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id A7D78D35BC6;
	Thu,  4 Jul 2024 22:24:15 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] do_div() with constant divisor simplification
Date: Thu,  4 Jul 2024 22:20:27 -0400
Message-ID: <20240705022334.1378363-1-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 AD8DAB28-3A75-11EF-9AF3-5B6DE52EC81B-78420484!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

While working on mul_u64_u64_div_u64() improvements I realized that there
is a better way to perform a 64x64->128 bits multiplication that doesn't
involve any conditionals to handle overflows. It even produces equivalent
or better code than the provided ARM assembly alternative.

And the best part is:

 arch/arm/include/asm/div64.h |  52 -----------------
 include/asm-generic/div64.h  | 105 +++++++++++------------------------
 2 files changed, 31 insertions(+), 126 deletions(-)

