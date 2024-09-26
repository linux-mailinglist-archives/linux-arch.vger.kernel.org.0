Return-Path: <linux-arch+bounces-7461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38AD987985
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 21:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208301C23446
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 19:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845A165EEF;
	Thu, 26 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh9pkrNu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A215D5C7;
	Thu, 26 Sep 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727377760; cv=none; b=KPHRUDGc5bhzTeuGZfAgvkr3hcuum48BoEMNGf0AfBLY274waZ3QTUUEyqbwOhGwr+6/W5AS03xYMLN/cl5mO0JFhprlHLXES2CzGfjkVxXg7WOd9o6+WW6t8b/PTvsp9Cn1uetTT1rrO+t4CkUuQbMH+b9m59e4yazL3d8iyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727377760; c=relaxed/simple;
	bh=bzsz4mKe+bMkyYh00tj6blj9L7O5imLZVIdT9B5Jv4Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WqJ1hBTAVLRpULrvz0WnpGYeaXBkUmML8yOyg8Fr7yaAyHMr6rXE9Dmqed4zVIl+bY6WaATAh+XoAADffmfOdTR7Bmq4eYOJwFDWRm1zemJK7RZFUktnmkcSZXFq9qBhsUoKU7q8o6IOYi1H7phZ9YnJxWGLdJwxNIwjcsKyjvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh9pkrNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3059BC4CEC5;
	Thu, 26 Sep 2024 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727377760;
	bh=bzsz4mKe+bMkyYh00tj6blj9L7O5imLZVIdT9B5Jv4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Uh9pkrNuLvsmvuzQcvxTe55Tm7D3E7Re8WP1FYdi4Aj/jR44EiI+Gyp/U6OkFR+f3
	 iLx0g/CrhgdJNmN5V/h/vmIYn5Irsy5zh3AFrA2jRhQiJynfN8IqNcBAmR0B9/75WW
	 MaX3Yo8pLG1BWwfW4ulbyB6D5zwkE3VAyLXTts5DuZJFEuC9EgIuEzTRcag3hS8WHB
	 Y7GNbpGeSMzF657OXaYaGAapzO670KNCJ01TkpsxWsHYdP0SX6qHg/KoK5Zv3xeRcW
	 +ZWRY76HjCBG6enDW7X9X2Yy7TBhF+7RQSTae2uEdTVFU3QIq0XRCWKUC/LINa8lzc
	 KJRKVMhp4F0ZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC923809A8F;
	Thu, 26 Sep 2024 19:09:23 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <3ae425d4-1cc5-43f8-84f0-501d31938a6f@app.fastmail.com>
References: <3ae425d4-1cc5-43f8-84f0-501d31938a6f@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ae425d4-1cc5-43f8-84f0-501d31938a6f@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.12
X-PR-Tracked-Commit-Id: 92a10d3861491d09e73b35db7113dd049659f588
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 348325d6444413caed020665b79603a2aaf00e2c
Message-Id: <172737776242.1364780.3752695529274943801.pr-tracker-bot@kernel.org>
Date: Thu, 26 Sep 2024 19:09:22 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 26 Sep 2024 15:54:33 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/348325d6444413caed020665b79603a2aaf00e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

