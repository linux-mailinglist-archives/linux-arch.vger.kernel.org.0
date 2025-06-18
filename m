Return-Path: <linux-arch+bounces-12362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B3ADE461
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 09:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1FF3B7CED
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB5EACD;
	Wed, 18 Jun 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlSte/tX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E422D2FB
	for <linux-arch@vger.kernel.org>; Wed, 18 Jun 2025 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750230970; cv=none; b=JP7TC7XJW1S5O0J/9wBOvu4U3P90B7DFYUCqld9pA5EUMLSFrhD9Tp+o/WACOqUFo1QCn/BTQPLxykMQbenCz0pdCAvAXusVRUOFEhFaDBGRVmMowBWH+0Lqv9KJ31H5s51GiMdPCZd3v+KjWL7gPxKfmjJydu4HJS456s/Nvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750230970; c=relaxed/simple;
	bh=Qx+WnuilhagaoCRXtkePk4/vD8if0pvz+hkVQ7p/NaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NkuLVwidkliWMZn1K3wTrTpjZLNA40QOlzajz1f26XaRKBOuFyUXFpugEP1n8J7xUlN4SLTeO3jdsymdm9917c9tMa/b9H39jgTEwrvyLTiPj3ilHNnla0z2HoDlwl2t/MNllWCioAsM3UQtWexJHVl05h+hL1sR50Hm22ZcPjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlSte/tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06417C4CEED;
	Wed, 18 Jun 2025 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750230970;
	bh=Qx+WnuilhagaoCRXtkePk4/vD8if0pvz+hkVQ7p/NaU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=KlSte/tXwzkp9bc6uZrKk0OisVMFWbU/zyRKKSRWLN5tI3Yr/8HKLZZBEs9SajQGg
	 FVUM2/VDr/Kix4hASct7GnWx32QZnz/P4CJHNsSqMQ5jwdT8j+IHkwVHie7p/2aGxn
	 o2CfZY8bRyXvgoXbXpll3LgAzLSTRZrRxN+iZpTKyPihz1BqXyBuyd2YiaBIpla8UI
	 CkbSbJGHe0eC+ORNfHmahkZjCv1htPHrUHxzFIKiZN/Qclm2Ld694OwUDCt3q1PIyw
	 SD5Ym7MSpeqtNUIVcqhriQWYAl27xqJWaPJhTD+G876U3RfcxFXdWSM0kTOZ4Nqdwn
	 c0FjM3oBaz0Gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 35A3ECE0C98; Wed, 18 Jun 2025 00:16:08 -0700 (PDT)
Date: Wed, 18 Jun 2025 00:16:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Subject: [Not urgent] Systems unable to do 16-bit stores?
Message-ID: <e8134255-806e-424a-bb86-68d3d6671536@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Arnd,

It has been about a year since the one-byte cmpxchg emulation hit
mainline, so I figured that I should check up on two-byte cmpxchg
emulation.  The issue that kicked it out of last year's patch series
was that there were systems that run Linux that lack 16-bit stores.

Not at all urgent, just figured I should ask.  ;-)

						Thanx, Paul

