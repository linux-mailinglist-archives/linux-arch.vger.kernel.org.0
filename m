Return-Path: <linux-arch+bounces-9415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2819F57BF
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 21:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DFF1630BF
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9F1F9AAE;
	Tue, 17 Dec 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TdofIxka"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCABF1F9A8E;
	Tue, 17 Dec 2024 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467405; cv=none; b=EnaMw3AFm1DWVh8tf0e6LQ/cyBUW9WHIemxc5vOgvDbSR1mzTknr/qYDHJzNc1cT3AT4AtMm7YOw7gX9l3tXsjPOSCtwyvP2z864oNNzfEj4X5XLPH6MLyUHnpr4s4/j1Y/6fbdMFbRW8aZyuATAK2CAhup2ttPiPj3/tcIlnhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467405; c=relaxed/simple;
	bh=jhP8vOy834sZYpgHQQT0JC53Tqn3PchIqNrPMIlC7tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDtP6yQmZcZJBVFJgGj8cs3XszLwQSEdDzq1BUjMNAKbNGfjiM27VighqSdrXTmh7IPVexHx3rLriydW0bb4e7yiIHthF9wQRLPO69OnQIDcNtZoAXD4HDovRxHr/UpL+GnS2BiwIyLdFjWuhtLWclSRpRpW7FvSg4RpDW6VkCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TdofIxka; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=/v364bvrO8lfqCXGMi7TqSOwSVU8ULaOAM7RRdJHOaE=; t=1734467403; x=1735677003; 
	b=TdofIxkaKDCHR1JN5fU59IGigRzEGvzAMy0ZpVZCi05AFTuXcmz6q5EBJqtKgwW71LJDDYgIpTw
	nRreGQQOfebolQSP8WCn81JEdMvFHvaup8/xU23Ja+WjZlvxKQBIWrZKOdkkNzTGim+5LF3Bl0U+D
	bEoIVm0+WXRZ/8uDvH+gYD0mUPWWp0nx7Olh/heSZU8g32ZV2XcmDgpi6JPJ1l0Yd75avEG1YSng1
	lo3Lg+JKEtI0/aOqePDcTqVRru66ynErnOvWrqV9S/P9PXc8wsVPTYLA3m5nIHhrfUxV7F4DmHqYX
	grRzSghutR0V2mEYmzVwEBRBwoSfcjvW7J6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCd-00000002NwX-26Tm;
	Tue, 17 Dec 2024 21:29:59 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/3] KASAN fix for arch_dup_task_struct (x86, um)
Date: Tue, 17 Dec 2024 21:27:42 +0100
Message-ID: <20241217202745.1402932-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

On the x86 and um architectures struct task_struct is dynamically
sized depending on the size required to store the floating point
registers. After adding this feature to UML it sometimes triggered
KASAN errors as the memcpy in arch_dup_task_struct read past
init_task.

In my own testing, the reported KASAN error was for a read into the
redzone of the next global variable (init_sighand). Due to padding,
the reported area was already far past the size of init_task.

Note that on x86 the dynamically allocated area of struct task_struct
is quite a bit smaller and may not even exist. This might explain why
this error has not been noticed before.

This problem was reported by Brian Norris <briannorris@chromium.org>.

Benjamin

Benjamin Berg (3):
  vmlinux.lds.h: remove entry to place init_task onto init_stack
  um: avoid copying FP state from init_task
  x86: avoid copying dynamic FP state from init_task

 arch/um/kernel/process.c          | 10 +++++++++-
 arch/x86/kernel/process.c         | 10 +++++++++-
 include/asm-generic/vmlinux.lds.h |  1 -
 3 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.47.1


