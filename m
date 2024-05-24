Return-Path: <linux-arch+bounces-4513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1237E8CDF92
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 04:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABB1282AE6
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 02:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0B381B9;
	Fri, 24 May 2024 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Kf61+D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C9376E4;
	Fri, 24 May 2024 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716519017; cv=none; b=dnXobr+7naucR9V+WTNp79ROANXTa7gTrzZ7bEadX96GIxREJB4+BjoSXMsA1YSivXa519Z596/yqLsLOpyOihIPiYUEejSupnmFxaOnq6ucW84QIDcXjTqwL2ERFcvu9AGeBXd9xMia/Q6eaD2MEoW24mVWtC97NT1mcGGbmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716519017; c=relaxed/simple;
	bh=rxqVUwJ5ATZzy7sz/+sU7NReE/sV38HKpHu7OnrM0Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlZfhYUkHTI5xFIl2OQVuphr48ce8bZlGf5rrljDpBgHVEebgj5wtKlEgj4XLbfWCSTD6vnyq/vQYGdVN5i4QFdbTqRt8CLGoRHZjUMAh8DCXpprVpQg6dkDgStpAGpaqJJq2vMAFIjl5k1zDLr54qItNXx7/RtfW5XIPJhl08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Kf61+D; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a08092c4dso4592467b3.0;
        Thu, 23 May 2024 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716519014; x=1717123814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxbRcf4yYw0BI0Vhm8N1Ed1WRrK48AEnOujMwZFhAeM=;
        b=l5Kf61+DPQ1A8b2V6BdvDwJQxKJ8KK2xa1WhYpeEj/b5UVs+At5aDDX3bTQwKcQ5hW
         YTZLLvmMFo/ccMOPzDdCFVBvrY2o04nEJx1QyYKECggJeh11NA51leuMZdkkbqcWUMPC
         a/xY7JX0Dz//tozLA2r8p95AljJ4I0VloB+EHbG3pGwgjI/lRSKSGf9rM2CS2BdFjQ+X
         hrOauREAzZOngRWgePFN0lKTTAZejsVq1w9sTp4uPPSnNAdst+yTIkuANoynSN8lPOW6
         bKROwetjUSUEuvl2DCbBFNZ7qwVQLTzy6FULvAxaTycs7AbeblidlFC519LOkkC6JVpp
         8fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716519014; x=1717123814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxbRcf4yYw0BI0Vhm8N1Ed1WRrK48AEnOujMwZFhAeM=;
        b=iS6XimRRqJ52IxD+o18DnhW55i3TD9w4y5bMRT76dqvg4LgYBPdalXtqtpEaf919Gz
         bBXaD5FdLUrFyyy78xIMhz3YYiJNnmMyd0pLJHFLM6NuaNnd0uInFuEvQOIMSNG3FNUC
         miZ1D/rOP1g0bh3dtrhkxIpglFnBuoQt8ZenTb3QTbvxBRiPdgDiAzoBuBUg2I6r/4Tb
         VujlcRW66Q5WlOIZSSkhqIfp9hLfg5Umm9hvv3CXn1DBDcgQW/dg8CIDlJ6m7b/voedq
         XwOvdL6Y3tWLTnVmPjCzS5gv5LcqDTFu51QCZIwuG4MEbpkNDRlRjbmuz2D35XGPUY2C
         4Huw==
X-Forwarded-Encrypted: i=1; AJvYcCUTllov04w+IjQszPPeauPQfOhhRVRQKB+IKPKQksYmHtSYIbQrI529wp5273yr4u6QdjMyz0Ptvguvl7hrP67nWLN00AkdUxxBX21+n1eTE8TLU7/fCE1dxibl6HIioJFnhxNOCws6Hw==
X-Gm-Message-State: AOJu0Yz+RJvArr8s63zeQYIW6hdtvFM/ZutoxEARs6Jt6LjGlBpvs2pW
	OYIhk7xjdIlGTzvEcyqNnnRU/VSOeyfE/tEhaYBuyw+3OK9SJe3/
X-Google-Smtp-Source: AGHT+IHZJFIKyd1koWosmYysmGPr0A3/bMNDhspgG3i6pvkXWU8Om1lGJpitSo6UtHy4JpRTyFxIpQ==
X-Received: by 2002:a81:4913:0:b0:618:ce0e:b915 with SMTP id 00721157ae682-62a08dd36e7mr9912767b3.27.1716519014554;
        Thu, 23 May 2024 19:50:14 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070daa84sm2926836d6.37.2024.05.23.19.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 19:50:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8DD581200066;
	Thu, 23 May 2024 22:50:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 May 2024 22:50:13 -0400
X-ME-Sender: <xms:ZQBQZprEtrqsMAc_9Nj0NrSYqv978xIOEYIlZvVfADLeibHOXxRhcA>
    <xme:ZQBQZrotYsbaPRLrJGfddubdlvx689z9GV8q8-zrb9Nt3VxL6GC1FLf4gnOIExxFt
    0q7qou4vJ6NQVL12w>
X-ME-Received: <xmr:ZQBQZmPsuheq7KoBxpnUGbxZdg00Ek7Jh4Pmjseh4_OBr_9xEwKcylbmGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ZQBQZk4EHxVErdgasEpRM7aoiYfrva-ID6Lun2WwgenFo_TkJBcC3Q>
    <xmx:ZQBQZo6tPrQBFSvp6At7TfiQd0udpQfJxLClPYaiqXxLfQGPCOFZGQ>
    <xmx:ZQBQZsgVbLIgJCqdwpdZbNkHV3qcws4WBU5p7azAXl7EloYWQDUfiA>
    <xmx:ZQBQZq6HlAoTKVAGm8461xAb1yk84dmhiSqxrpSI1Np8tHuiTPLZCA>
    <xmx:ZQBQZvLlPPSR703Vy9iqJbBR6UPouQExZsZB9UwyCUB8z6VA7a6iSKFV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 22:50:13 -0400 (EDT)
Date: Thu, 23 May 2024 19:50:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
References: <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>

On Thu, May 23, 2024 at 09:38:05PM -0400, Alan Stern wrote:
> On Thu, May 23, 2024 at 08:14:38AM -0700, Boqun Feng wrote:
> > Besides, I'm not sure this is a good idea. Because the "{mb}, {once},
> > etc" part is a syntax thing, you write a cmpxchg(), it should be
> > translated to a cmpxchg event with MB tag on. As to failed cmpxchg()
> > doesn't provide ordering, it's a semantics thing, as Jonas showed that
> > it can be represent in cat file. As long as it's a semanitc thing and we
> > can represent in cat file, I don't think we want herd to give a special
> > treatment.
> 
> I don't really understand the distinction you're making between 
> syntactic things and semantic things.  For most instructions there's no 

Syntax is how the code is written, and semantic is how the code is
executed (in each execution candidate). So if we write a cmpxchg{mb}(),
and in execution candiates, it could generates a read{MB} event and a
write{MB} event (succeed case), or a read{MB} event (fail case), "{MB}"
here doesn't mean it's a full barrier, it only means the event comes
from a no suffix API. Here "{MB}" only has syntactic meaning (no
semantic meaning).

> problem, because the instruction does just one thing.  But a cmpxchg 
> instruction can do either of two things, depending on whether it 
> succeeds or fails, so it makes sense to tell herd7 how to represent 
> both of them.
> 
> > What you and Jonas looks fine to me, since it moves the semantic bits
> > from herd internal to cat file.
> 
> Trying to recognize failed RMW events by looking for R events with an mb 
> tag that aren't in the rmw relation seems very artificial.  That fact 

Not really, RMW events contains all events generated from
read-modify-write primitives, if there is an R event without a rmw
relation (i.e there is no corresponding write event), it's a failed RWM
by definition: it cannot be anything else.

> that it would work is merely an artifact of herd7's internal actions.  I 
> think it would be much cleaner if herd7 represented these events in some 
> other way, particularly if we can tell it how.
> 
> After all, herd7 already does generate different sets of events for 
> successful (both R and W) and failed (only R) RMWs.  It's not such a big 
> stretch to make the R events it generates different in the two cases.
> 

I thought we want to simplify the herd internal processing by avoid
adding mb events in cmpxchg() cases, in the same spirit, if syntactic
tagging is already good enough, why do we want to make herd complicate?

Regards,
Boqun

> Alan

