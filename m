Return-Path: <linux-arch+bounces-9376-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C89EFFF5
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2024 00:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57216286F4C
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747181DE88E;
	Thu, 12 Dec 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b="J7QtnUqN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out.freemail.hu (fmfe17.freemail.hu [46.107.16.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08F1DE3AC;
	Thu, 12 Dec 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.107.16.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045445; cv=none; b=cDJIF5On5vv02Rqc6Aj2tfetGs3HhOQGoGaYZZz/ptSA+WWZLq06sZRYM9HcOCJ8j+bRIekv1LFpIM5rJYdDiYbhol3VXYTPSC0CjmxlXRGZA8zqagAU9WKf8ywRAaSKM0uILX+ESvCiLTytEMn0v0HWFVH+kxfjVC1/iPMsMK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045445; c=relaxed/simple;
	bh=QY5/TILGKvX2t96LpmDncFb8f8MyiHmAME6toVPq4B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ1aP0pObMWWQrr/+buNebAD4rZhEzlrInWKOZij1RCp4cM7HPR04f/rhOBoWis7A23m0p+9yoZmlS+EusjR93HOmeyWkkjpvHX7IgozucVQITgtkN79qypI1zWaGQjeEmQIrO/m1QRD3leA6LDLA4eaNjVUdr5oMPOopXMcgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu; spf=pass smtp.mailfrom=freemail.hu; dkim=fail (2048-bit key) header.d=freemail.hu header.i=@freemail.hu header.b=J7QtnUqN reason="signature verification failed"; arc=none smtp.client-ip=46.107.16.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4Y8SqC0wj1zNDL;
	Fri, 13 Dec 2024 00:09:59 +0100 (CET)
Message-ID: <c46da2b3-bb86-4385-bffb-2edea61d79d0@freemail.hu>
Date: Fri, 13 Dec 2024 00:09:12 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc: parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
 j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
 dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev
References: <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
 <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>
 <75a5a694-1313-44b1-baff-d72559ac9039@rowland.harvard.edu>
 <de5485b8-6d88-46f6-b982-cdfb3cf80a13@paulmck-laptop>
 <25cee4ed-1115-42d4-8422-ed7f7f4ff389@rowland.harvard.edu>
 <e3a5aa0a-2c8b-4679-9344-64135df63fe1@paulmck-laptop>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <e3a5aa0a-2c8b-4679-9344-64135df63fe1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1734044999;
	s=20181004; d=freemail.hu;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=1699; bh=uaRvV0C+6MLqpebOkeDFkO1ucsP2gvpZZbpZV30r5RY=;
	b=J7QtnUqNG4PiMijq07V3BKyszUgxLpzw399DbB4MPUPoZrYIx93QFS8ivMxQF7qc
	jEHNSmF6sHimBgytsdpYFoSXYIuF9vpE5SxaIHClVTVZeykGIwuxeoQAse4EllIsX3q
	2Qj7I1MATn8yKZnIxPThtgncIjO+92dviFKITude+xAHwN68sHeSrRd4X5JbivKsWIu
	zIoPn6cYGHKlhABlkj934+FATO5NlXGW3Zs/82JXH7Di3x0DjeNoJtefVjxNNr622Jw
	uNbXa7Um4P6LERV/cU3NkN1HIt3b2b1TnNrObMirZvB12mINAeXTYD/cWc8j2dprtwJ
	cnPOjt6qAQ==

2024. 11. 12. 22:53 keltezéssel, Paul E. McKenney írta:
> On Tue, Nov 12, 2024 at 03:20:00PM -0500, Alan Stern wrote:
>> On Tue, Nov 12, 2024 at 10:26:37AM -0800, Paul E. McKenney wrote:
>>> We do have a rule for the filenames in that directory that most of
>>> them follow (I am looking at *you*, "dep+plain.litmus"!).  So we have
>>> a few options:
>>>
>>> 1.	Status quo.  (How boring!!!)
>>>
>>> 2.	Come up with a better rule mapping the litmus-test file
>>> 	contents to the filename, and rename things to follow that rule.
>>> 	(Holy bikeshedding, Batman!)
>>>
>>> 3.	Keep it simple and keep the current rule, but make the
>>> 	combination of spin_lock() and smp_mb__after_spinlock()
>>> 	have a greater Hamming distance from "lock".  Szőke's
>>> 	patch changed only one of the filenames containing "Lock".
>>> 	(Bikeshedding, but narrower scope.)
>>>
>>> 4.	One of the above, but bring the litmus tests not following
>>> 	the rule into compliance.
>>>
>>> 5.	Give up on the idea of the name reflecting the contents of the
>>> 	file, and just number them or something.  (More bikeshedding
>>> 	and a different form of confusion.)
>>>
>>> 6.	#5, but accompanied by some tool or script that allows easy
>>> 	searching of the litmus tests by pattern of interaction.
>>> 	(Easy for *me* to say!)
>>>
>>> 7.	Something else entirely.
>>>
>>> Thoughts?
>>
>> Thumbs up for 3.
> 
> Very good!  Any nominations for the lucky replacement for "Lock"?
> 
> 							Thanx, Paul

Subject: [PATCH] tools/memory-model: Fix litmus-tests's file names.
Makes a greater Hamming distance for name of Z6.0+pooncelock* files.
https://lore.kernel.org/lkml/20241209150044.766-1-egyszeregy@freemail.hu/


