Return-Path: <linux-arch+bounces-9144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E99D44B1
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 00:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9726B22A3C
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2024 23:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58A1CB31B;
	Wed, 20 Nov 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR+8d/u+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9E1C8FD2;
	Wed, 20 Nov 2024 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732146625; cv=none; b=UNMDTOTxThmumTmzlUYdAddhbx6TYrBVZeQpnYUfvqdcD4xRp/muoJlQJ2wbwmYDYEttpzRhClTBk7Z9WGX1+6aEpXhP8JqqXUkBZDM0tCfTmqoPLfmzO2u2/gRkATQ9NqNM0w3US5u69lfK1SMfyojoN3batRYLdSgLyPkJhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732146625; c=relaxed/simple;
	bh=GDSMeRF+qXvrkYVfLa5wUe1qZPScJNmWYWHVpcmZ3Ls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dGCwCLzP6z0lNxV8OqOg45/bEIomVzJAjqhsE9jZTRGF2hFjS2yLsx9ynLLDvsycCQjzQs1geb7eSWkdPFoqZM4SbKY3jreZW35ShGtkXzlYCq4+KWgKaJsd9fF1DiJwmYVIXqJO5IFVeByKRxlPi2CpRc6wEvHsh9PMhhJGFO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR+8d/u+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23943C4CECE;
	Wed, 20 Nov 2024 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732146625;
	bh=GDSMeRF+qXvrkYVfLa5wUe1qZPScJNmWYWHVpcmZ3Ls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jR+8d/u+MIG+DhNWWopX6Jxiv6z9/2w5vyhsnkDA3mUQg6ud9N9L/fLX5MRtZv/5A
	 UN8hdWtD4k4OH2/eWOXOpQS90LVtaXqHSY4tUdco3gyv4B6VcRmwc6vxwBkfK8usv9
	 wuSBNYEcDtow2qJfLbUcRS1JLonQ/h1Q59JSAiYDGBvx9EyWZ5fRodei/Nj/TSmPbs
	 ZdETimMjbIbOlBN8Tj4c1jHx96PqJMwS95GRpW3QRyBCkuBCLGiU9Go3wFY/xy2h7t
	 ObW8+rKAfCyX1c5uxXmuby59aYH6smGy0awrtfB0nwLJbL+aZdwPp46lYZ+mREZ61a
	 mgDWBktFHmkTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1F3809A80;
	Wed, 20 Nov 2024 23:50:38 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic updates for 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com>
References: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <c09168a6-23e7-40fd-afc2-4c3ac6deaff6@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-3.13
X-PR-Tracked-Commit-Id: 0af8e32343f8d0db31f593464fc140eaef25a281
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79caa6c88ac484111b24488eb9fe1c86a3d18016
Message-Id: <173214663696.1393168.4436714062176910731.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 23:50:36 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, Niklas Schnelle <schnelle@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Julian Vetter <jvetter@kalray.eu>, Nicolas Pitre <npitre@baylibre.com>, Christoph Hellwig <hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 20 Nov 2024 23:57:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-3.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79caa6c88ac484111b24488eb9fe1c86a3d18016

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

