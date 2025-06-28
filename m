Return-Path: <linux-arch+bounces-12497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0760AEC6A1
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 13:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03201BC2FC3
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3DA22FE15;
	Sat, 28 Jun 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YEwtxCuL"
X-Original-To: linux-arch@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38D4A3C;
	Sat, 28 Jun 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751109265; cv=none; b=BH/T8DviAVEAFyHx7sqDe+5/+9hs2rBBd+a7fSDs6rlRLsPMUVfZlJNPbCf7kjK9UHqK0wEjIAkNW0p3z7TFXDT1voE6r/VzJaicewKAZz1gaKoD+HAJj6eGIaFwUbWsdKOnkFxg1JRAb1cJxMXEXDSriMdJXq21p7MbxGeIX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751109265; c=relaxed/simple;
	bh=zFJU8fHXPwXv2ZDpvF+OAKpHFAL6aFjyAKXT832fIck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaWY38ceGW8sxI5H0tFmJmDroH9gPXR2wxBkom5HAAaHWKSdpbitnsaFt1NI7yIXDreJQbeYRvs4YaKiTE85PUoYVsVkYfATsaRhcmwR49O9azqjuLbtbASu197avgKP0TVdj4ZRuFG1Cgxx6ve5uTo6b63WLV2WJdZZUyu5lRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YEwtxCuL; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751109257; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TRpU/crHQJjkYyYdJiqwyqhIKtVuiXKZNmxFbHlR0lI=;
	b=YEwtxCuLKi51ws5dKisUcbpKWoJq+F2rEn2pkozFwBZw3tr3+kDegO8RjEPwAtBuioFg+dLvDmqB8BY7SGV9SllcrVjqjoypmaH0/QblQBDc3tkf46kAxGgN6SD9znmv3oQFeaaSKATCgupLdXx5ziUAnm/2GSRYEGrGqByIzk4=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0WfjBSB7_1751109237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 28 Jun 2025 19:14:16 +0800
From: cp0613@linux.alibaba.com
To: yury.norov@gmail.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	cp0613@linux.alibaba.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb extension
Date: Sat, 28 Jun 2025 19:13:57 +0800
Message-ID: <20250628111357.1627-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aFWKX4rpuNCDBP67@yury>
References: <aFWKX4rpuNCDBP67@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 12:20:47 -0400, yury.norov@gmail.com wrote:

> Can you add a comment about what is happening here? Are you sure it's
> optimized out in case of the 'legacy' alternative?

Thank you for your review. Yes, I referred to the existing variable__fls()
implementation, which should be fine.

> Here you wire ror/rol() to the variable_ror/rol() unconditionally, and
> that breaks compile-time rotation if the parameter is known at compile
> time.
> 
> I believe, generic implementation will allow compiler to handle this
> case better. Can you do a similar thing to what fls() does in the same
> file?

I did consider it, but I did not find any toolchain that provides an
implementation similar to __builtin_ror or __builtin_rol. If there is one,
please help point it out.
In addition, I did not consider it carefully before. If the rotate function
is to be genericized, all archneed to include <asm-generic/bitops/rotate.h>.
I missed this step.

