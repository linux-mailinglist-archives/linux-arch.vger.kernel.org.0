Return-Path: <linux-arch+bounces-5899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C06945547
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B695E1C20FCE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B1134D1;
	Fri,  2 Aug 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHVqF1JU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E28134AC;
	Fri,  2 Aug 2024 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558125; cv=none; b=VBuCQvl4XexK2sXyjp5QS2RAPCLj/C9GyeTKrfwx6BD5RNAAvLRkUP9o2v0JN/G2rqrncq1y32fnVSoy58n35Gx9Tj56zzC5voSc4v7VVEuvcWSEfKWLIZFLyaGsVVaqIeuZq/in843tSkgPOnqVmjys4skNCh7ciQE20x7v6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558125; c=relaxed/simple;
	bh=rEoWPFpPS2fkdkiCezt44NzRUl97kQ26hPkj1rdopps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kzdUUTdwRD3JQ9DRb0l4jXbZ5kcaMdQ0jIQ3+1j4udSv+CjBsOawNnhHGU/JOjZXW8EQS+RKXXjekCkJ56hq9BtxNfxtKiWHlNDtLEUGS1dg40nlecE4ws7kfuhNpDF2Hpjiv5qY1yOSF2/Sr5VOGmf4k1xW6cmZjPf4byT9YaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHVqF1JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C2CC32786;
	Fri,  2 Aug 2024 00:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558124;
	bh=rEoWPFpPS2fkdkiCezt44NzRUl97kQ26hPkj1rdopps=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=KHVqF1JUdFPtkL4Jd9AJS2DWDWCHzUu23KAz1mY0dwTtckMo6lzL5MY0RGog2l/nI
	 s9Q08TOpmQ3hGaUJ+aKayp/eP0+yfSdr4m4Iw1mkeuoncJErm9VyMAGUB33wGh3Sk2
	 /5Zbe2DEP3dessKk20sFtlrY25OhmV9oXoQkA3fOdhzzGprb9NIyt+gXBDO3dTea/z
	 bcL8aZk9heE+Nq0FJNFOWOkJhvgHIoslMt4B1um9XdjmYKjF64EX2J4GaDNmr0rbnb
	 ahGNSZjNxlU3GkyElqsQQ8kzbt4Jp15xr4HqbmMabQhygUiErDJJNEK3N1Fop10KX0
	 /ybM6xCpDxv8Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5526FCE09F8; Thu,  1 Aug 2024 17:22:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:22:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH memory-model 0/7] LKMM updates for v6.12
Message-ID: <e384a9ac-05c1-45d6-9639-28457dd183d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds a few atomic operations, some documentation, and updates
the MAINTAINERS file.

1.	Add atomic_and()/or()/xor() and add_negative, courtesy of
	Puranjay Mohan.

2.	Add atomic_andnot() with its variants, courtesy of Puranjay Mohan.

3.	Document herd7 (abstract) representation, courtesy of Andrea
	Parri.

4.	Add locking.txt and glossary.txt to README, courtesy of Akira
	Yokosawa.

5.	simple.txt: Fix stale reference to recipes-pairs.txt, courtesy
	of Akira Yokosawa.

6.	docs/memory-barriers.txt: Remove left-over references to "CACHE
	COHERENCY", courtesy of Akira Yokosawa.

7.	MAINTAINERS: Add the dedicated maillist info for LKMM, courtesy
	of Boqun Feng.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/memory-barriers.txt                        |    3 
 b/MAINTAINERS                                              |    1 
 b/tools/memory-model/Documentation/README                  |    7 
 b/tools/memory-model/Documentation/herd-representation.txt |  110 +++++++++++++
 b/tools/memory-model/Documentation/simple.txt              |    2 
 b/tools/memory-model/linux-kernel.def                      |   21 ++
 tools/memory-model/Documentation/README                    |   17 ++
 tools/memory-model/linux-kernel.def                        |    6 
 8 files changed, 162 insertions(+), 5 deletions(-)

