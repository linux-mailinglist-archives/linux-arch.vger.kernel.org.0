Return-Path: <linux-arch+bounces-14962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B518BC70AC8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 19:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95A9D347D53
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B093254B4;
	Wed, 19 Nov 2025 18:38:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A32D7392;
	Wed, 19 Nov 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577512; cv=none; b=A+SaYOXfLD9tbz8YHEQkizP5ZSwDtFDPWzL0XQmDlB2yFuhtv4t4RVH4FeNMdqNEiAH3rw1ceJFI7pWYm3N3Mu0HDTnSQCT/Qy59bLQDrQN1vjfBXIX3GKySqo46ooTxhE2Le5Lo9b4RcCXFonz1dkNPa/2RjFt2/h7rrj3S4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577512; c=relaxed/simple;
	bh=7IgUbXwpQA4km+F7Dfoe93VgXivuE2hBFLK/C0BSZ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2IMp9Oux6J6b2+lTlNDfUigBj5+qQ1GEaz0fhCzCCufOiZoQrAJsuFzPNXweNnlE16gndimXJEFgGdb4k/w9FQXVitORewXIGMMj2qQROappeJ3QoWAOujRdoir/Rfx86lJKszaONGZlbA4PjLUgAZ5zdBSTuqiKOyQzoUiDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C8AB716060D;
	Wed, 19 Nov 2025 18:38:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 81EA330;
	Wed, 19 Nov 2025 18:38:06 +0000 (UTC)
Date: Wed, 19 Nov 2025 13:38:36 -0500
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
Message-ID: <20251119133836.47d9ae73@gandalf.local.home>
In-Reply-To: <b0102b82-9ae8-4e01-ba27-44b78b710fca@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
	<20251119131534.392277e3@gandalf.local.home>
	<b0102b82-9ae8-4e01-ba27-44b78b710fca@linaro.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cc1o33w6u6owrkxkfh83ifny9egjgrsa
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 81EA330
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18eQxzjFElSFMQBkWmqdnIUBJkOF0f6iiE=
X-HE-Tag: 1763577486-542771
X-HE-Meta: U2FsdGVkX18hYyFLn4NceFAtmtr2U9i2vMLdUUZa/XY9sbc18Qd8d0XqWxwjkyLUW391A4PmfVST6fTOPo9/v/GlV/882/v3PjE3Q5zfS5DD1vsLm+4ecyYB6S0zd8UbhIjnn5oMxPSN9iXqq6UxrC6D2V+tXEx8ZTe18jJnlx5L3nYf++HdtV6ezZc8QQOsd5Sji+bCYcQ6BWUI2yZNs93T38KE14+xuHs3A5shJ2l0kZqx610Kyw6apiwgHfwv9/5JD181MK+WYyNpUzWoatcjkFOIYbmW/eiebkRWkR1PTFbDxKfNL2AREBIQ9kzXso7tg4Agi6AvAp3c/q8HXYwDktY4Ul7c6O7qpQnkvKOsmFMGedUEWwFLRTKDlkmz

On Wed, 19 Nov 2025 20:24:23 +0200
Eugen Hristev <eugen.hristev@linaro.org> wrote:


> The problem is that all the meta-data is not allocated inside the
> preallocated buffer. The meta-data is kmalloced all around the code. I
> mean the structs that hold the information on what's in the buffer. You
> know what I mean.
> And all these kmalloced things, turn out to be in order of hundreds just
> on a kernel boot, which I tested. This is not feasible for the
> meminspect table, as it would get overcrowded very easily.
> I thought of perhaps trying to kmalloc all of them in a dedicated cache,
> but I haven't progressed on that. Another idea would be to try to
> recreate the meta, but I have not found a way to do it yet.>
> > That is, by using the persistent ring buffer code with the meminspect, if
> > the firmware doesn't save the memory across reboots but allows you to dump
> > it to disk, you can enable tracing within the persistent ring buffer, on
> > crash, extract the buffer, and then use trace-cmd to rebuild a trace.dat
> > file that you can now inspect, and see the trace that lead up to the crash.  
> I used 'crash' tool with trace plugin and I am able to see all the trace
> contents, but, with the limitation above. (To achieve this, I dumped a
> huge area to include it, so , not feasible for my goal )

Can't you at boot up just run:

   trace-cmd restore -c -o trace-head.dat

?

That records all the meta data of the running machine, and places it into a
trace-head.dat file. You can save that off anywhere.

Then after a crash, if you split the buffers up into individual cpu raw data
files, you can then run:

  trace-cmd restore -o trace.dat -i trace-head.dat trace-cpu0.raw trace-cpu1.raw ...

And it will create a trace.dat file for you that you can read with:

  trace-cmd report trace.dat

-- Steve

