Return-Path: <linux-arch+bounces-4690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5E8FBEA4
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 00:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939681F23EDB
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB91442FB;
	Tue,  4 Jun 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jET1b6dD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A998A2AEEC;
	Tue,  4 Jun 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539252; cv=none; b=b+UjjDP7r1m+7aWOnhooL9KvfUv7kOt7/dpmQfCgDgRhKEZ3VglkSChk7iUH112zGDRnwsvqnYkIOBvIJ4/D6fJIqZQ4VDicYeRaWqv4LQTPM9rl/kHgRJKqudHR0a9EBclQKpeu6XFlFnmek3Rjqny3b3K2NsfFCo5GUCENnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539252; c=relaxed/simple;
	bh=bUOsEDPQnmxdM2WgVeYh3t/PFaIuahUtbiya2U26DLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSupFwd4hyFLEeqIOqrbAMRCyIavceAPVefv0EWLy0yvWmXBfecyX8E4eBn8zie7wfjsJu6TcudGzFBlwg1Aq5NOAEVZFLG3xTKIQCI1VltpcgB1eQw+EnoVGFqKkPFgQ2ShBfnBYxUXR1XK6/eOZokJnXlel5aZmRfqbF3Sx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jET1b6dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115D3C2BBFC;
	Tue,  4 Jun 2024 22:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539252;
	bh=bUOsEDPQnmxdM2WgVeYh3t/PFaIuahUtbiya2U26DLQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=jET1b6dDAHPDRAqpQY6cppBUDv2yPVGBejsOgjGr6WHYEQj/e9UYDyJMGAAfBHsMb
	 3SJ/1B8tVa5oC5tZK8B+aK8Tmpyq2Ch2DTNWcnGTGLUzS1takKXcR3FStfjP4oa/6W
	 f7dCkXGgrsvioyefCClYwVE4WnBWtIUPqoLM0gukaRUcbJK44Ltj8AdeSgjTenXWfV
	 LE7wYubm/eVFcndtiqhj5/QluBlOgOhRYmhGIVcXkDXeoHfePLDkxM37dZuEO7kPAy
	 qndubwqMs/+PyTbBClIiKfN2KPBG56sSRYE2MTMcTi4/vjzMZyQ4eJgwbeJ5PbekDc
	 igNtEsRZhYjuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9CAF3CE3ED6; Tue,  4 Jun 2024 15:14:11 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:14:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH memory-model 0/3] LKMM updates for v6.11
Message-ID: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
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

This series adds a few atomic operations and some documentation:

1.	tools/memory-model: Add atomic_and()/or()/xor() and add_negative,
	courtesy of Puranjay Mohan.

2.	tools/memory-model: Add atomic_andnot() with its variants,
	courtesy of Puranjay Mohan.

3.	tools/memory-model: Add KCSAN LF mentorship session citation.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/memory-model/Documentation/access-marking.txt |   10 ++++++--
 b/tools/memory-model/linux-kernel.def                 |   21 ++++++++++++++++++
 tools/memory-model/linux-kernel.def                   |    6 +++++
 3 files changed, 34 insertions(+), 3 deletions(-)

