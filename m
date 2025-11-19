Return-Path: <linux-arch+bounces-14958-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E2C709BD
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 19:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id B04BB2FB37
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4693624DC;
	Wed, 19 Nov 2025 18:15:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1030F944;
	Wed, 19 Nov 2025 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576128; cv=none; b=V5As9vvUgw0yyttUhK6O0ko4ypBQanWyLKtvR2Y5hVy7XLetyUBAJLYd6rcTTI/L5zE2ZtRupIxRzPWua4+WlS4gz/guQ3z1tSR2j1yFl+5v9el01DoASB3ko21pN6ddXRowRZ8WsE5dVywgS3MANYndLaIYWstR8r9UVaE3HPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576128; c=relaxed/simple;
	bh=lY5mFtwwGbgj3Q3EQBdOWODm94hJkS96HwS5ihumAPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+pp6ryJxZXEVkW9wyVO7Ltyc7ggxvJwlnJZRjW8DlIXevKWr332OZtzXj5Kc9Y8rVqdaWZhbp/DHfcjWUmK5jYo54Z7RmKsgkYzwN5+XuoX/OXGdRVNA4D6dD8uh2fNAWyhi1I+FXh1/EoeFIe3XhBs1jW+VXJRTqDHSLnGGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CFF051605CB;
	Wed, 19 Nov 2025 18:15:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 4A57120025;
	Wed, 19 Nov 2025 18:15:04 +0000 (UTC)
Date: Wed, 19 Nov 2025 13:15:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
 tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 00/26] Introduce meminspect
Message-ID: <20251119131534.392277e3@gandalf.local.home>
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8ujf9qur1wz8byzryd9nrrsipdba6b4w
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4A57120025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18O9iohKxcGmRjhPgfwSwuiJ9rXjN3k9nI=
X-HE-Tag: 1763576104-213290
X-HE-Meta: U2FsdGVkX19/dF/WOecvGV6lYV2teK1CUApQEXvTil5LrDYtCitVtAX5Q8BoMR6TmtJI3K/ypigEykJDoh2wWRnxnwtvEhfPbYoAjQ7CBjAeAkHTNVC2+UPbuQJ52IMkbLqNh+TL98B+sVLbcP7iY87xUXSqyp7/t07x9SzdepLahdbj0fgfKmabVHXYF55/LhPrKLsmQxRGgcdQZc+VoLmHQAiPN84RAg7rXsAjcnFkeEgslDnLord92S38kLD1z8wtjeDd41ff0CQR7dsMu0jXGRqJkaVWYDB1/V+UlnbDyZgQu6Yb6HDVSBXDw9IZsLZGyvuBTwcfN01rmgeJINsoleI4q+rVGxJsLPdqn6YSut/diszZtd5o703j4Xy2

On Wed, 19 Nov 2025 17:44:01 +0200
Eugen Hristev <eugen.hristev@linaro.org> wrote:

> Once you have all the files simply use `cat` to put them all together,
> in the order of the indexes.
> For my kernel config and setup, here is my cat command : (you can use a script
> or something, I haven't done that so far):

Interesting.  Hmm, it seems this could be used with the persistent ring
buffer code as well. But if the firmware does not keep the memory around on
reboot (where the buffer would be reloaded), you could mark the persistent
ring buffer's memory to be inspected.

The persistent ring buffer creates a single allocation to hold all per-cpu
memory in a single region. That is, because on a crash and reboot, it
expects that memory to be at the same location and does a verification
check to see if it contains a valid buffer. If it does, it will recreate it
for view in the instance directory of choice.

Now if this same range is marked for inspection, you could then download
the entire contents of the persistent ring buffer after a crash. It would
be trivial to update trace-cmd's restore functionality to rebuild a
trace.dat file from it. It would require saving the event formats of the
running kernel before the crash, but that's not hard to do.

That is, by using the persistent ring buffer code with the meminspect, if
the firmware doesn't save the memory across reboots but allows you to dump
it to disk, you can enable tracing within the persistent ring buffer, on
crash, extract the buffer, and then use trace-cmd to rebuild a trace.dat
file that you can now inspect, and see the trace that lead up to the crash.

Now I don't have any hardware that uses this feature (not that I know of),
but if others find this useful, I would most definitely help them implement
it.

-- Steve

