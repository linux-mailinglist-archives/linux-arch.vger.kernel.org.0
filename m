Return-Path: <linux-arch+bounces-4535-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318168CEA03
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 20:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F0F1F212A3
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A43F9D2;
	Fri, 24 May 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHagTqPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB083EA64;
	Fri, 24 May 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576455; cv=none; b=hea6HQVGpDxrUoaMdu8u8wGuC0dNwZ9G8TKtbPF5GIqRaeoqbSV77Cb9Dxgzn+vy0SiDczMqTFj0qa1b4b1EK7Ax74Ylt9I8hJYF7/9jx294gz8NDlVVEN1KzUHliTqr+NpdxbxkOmtvD66EzaRP+lRqDQIgdtuc6KX+lspcVxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576455; c=relaxed/simple;
	bh=1eUPcYfUvzHImy1Hx+GxeS1K/8Y+4zJEcGDjgn/AoX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvTKkC1iIHnoKpAECOrL+QVgK9qVhgGicAVnzdPpAosY4OHx/OunhncDsOwXAdakac8mWsXgf3J5JbBH/3fJIAGMC17Vd0iAi4TejjfhFFnVTA7cblDpTOs/ytLfDLvhPn0OgqP8HoHOUOvevMxr7hV5rea3QT1XdYg1b45SOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHagTqPd; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f8cd25ebd5so780100a34.1;
        Fri, 24 May 2024 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716576453; x=1717181253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMOpKBRVbVR3rvyz1/uTygJW3fh5bMkxhvP5AmHg4S0=;
        b=VHagTqPdZfZvTcnmUn8RQ6o0RIkEbLYR7D9uJoAUQpXm2SeS/SDsZ+TjMdrR0f3vua
         vgzN71mUilFjEgzH66qbNbDSqtwwSp+exdtnQRQD+aVzGpEUtGbTc+YMNgyFPTHM/WQq
         AobTVQXkQzdtFZGVJhCfLyb974BaNO2QYQWQcYLfFYy6M2Im2CNAPbTIRMLNcp7oN6Pz
         8NYBIEabAf+fmxsQnYoThaoJIIHrVq6OBdfWGDum04lFdIpRnIpW8nnlg+BOI3wFB9wx
         JQSB2uH5iSe0VymB6+uOLUJCZeuhHE6/PNMNRE/WSajzexEFHQNbRHsKOCCm7PnbE5Lp
         9kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716576453; x=1717181253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMOpKBRVbVR3rvyz1/uTygJW3fh5bMkxhvP5AmHg4S0=;
        b=TTzZPADrJNoB1xf9+m4QMN1Rg2gOUsRe4m/o9G0mN47Wl0jakhOZGvKqKW75K8wZBu
         BbC9CNO7OKJNJN7fEYLUwWuE8vf+AfavTVwDu+1gs5hiZfiKX899mb0BAH39A3xYFyha
         PtNfYU5di/lFnxi0PLnburlKFRYO0JFve7MTFHk6+IpMbli7OtuOhnyyQFEpIlz1uYoi
         oWnnd+qUQQcdPfN61XCdU9o8KLqCAiQZIsjKhwPKoUmoINC6ONQQsAv++wh2fdKERWpg
         yAA3tUIuJsm7sl11fVg9Y2S5qy5xMGO1NTIv5Y3zuWdbwKjQ+4q7PP9LW0xtA/0qKdW5
         n0sA==
X-Forwarded-Encrypted: i=1; AJvYcCWhp12YSdLYMi/MvUeKbjxHLvr10IzEldDfKgsOnuJ7cr3upZSfj+a9pz4C83Fozsn9qM+hUAnRfT+XD3dQk9JRbKNpL3l0g6rSAWoqvwEBb1wNy0smmCDx/3DuCQS9cwq1HqVpyE3Jeg==
X-Gm-Message-State: AOJu0YznEtviloC/xIH4x/F17KRH6D44bJammiaZDjRslQzLcRnur9p5
	6mEyuRZKSp110B8U1Go+MfU0ChKHKddrxVZwzk/5+wvH1YH4cswp
X-Google-Smtp-Source: AGHT+IFVZKPXf6qlUyTFlWc3JDEfn0Ii4hBk6m5H1qLbTgIr+Hlr9uBcwThiYwie/OBBqSlpRnwLkQ==
X-Received: by 2002:a9d:5f13:0:b0:6f0:e596:5b52 with SMTP id 46e09a7af769-6f8d0a94003mr3453712a34.6.1716576452639;
        Fri, 24 May 2024 11:47:32 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18b1adcsm10302191cf.63.2024.05.24.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:47:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 75F6A1200066;
	Fri, 24 May 2024 14:47:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 24 May 2024 14:47:30 -0400
X-ME-Sender: <xms:wuBQZsRKDaL_s6J1xZGGO8eODttgkniigo_eWVt7MWBN3zOSgNe46A>
    <xme:wuBQZpwJex0UoLqsFV8kFd7JKsaoQONcBEB80Fc8C4_8YxDgSRK1WrZq3ZeUt78do
    xWgsftQeTnoXU78KQ>
X-ME-Received: <xmr:wuBQZp2XNTOeAsbwtdhWCCfbQhJq0-hPauhJkxgH2M4VflT-C551asigSZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedt
    ieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:wuBQZgAIqCOS_F1Pt5jwjkgXWeUB692F8KbCBy2b4uVt1FRyi8Ak-g>
    <xmx:wuBQZlgs_8F1Ej02FizkukmcQXrm_hz42mVMWpCJAjwn8fzh-he7Vw>
    <xmx:wuBQZsqNg41U0BL5BDJ-892c-zSvMWhkwhzq9lZCDIQzH6uVJva6vw>
    <xmx:wuBQZohsPMdxVb8EMfKaejCG1OGiyU0PUuSjOFw8NKE0_zRtYUjJqg>
    <xmx:wuBQZsQyTSRn9e1z69nFHF5A3cA1Yhk-T7D6LbBQwh8xrJlptCfB4qLM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 14:47:29 -0400 (EDT)
Date: Fri, 24 May 2024 11:47:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <ZlDgpp8blJO9L3JX@boqun-archlinux>
References: <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
 <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
 <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>
 <a3c10533-1d86-4945-8bda-c0bdf4b14935@rowland.harvard.edu>
 <99cc68a9-477a-4ebe-b769-465a4016bdf6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99cc68a9-477a-4ebe-b769-465a4016bdf6@huaweicloud.com>

On Fri, May 24, 2024 at 08:09:28PM +0200, Jonas Oberhauser wrote:
[...]
> > 
> > Question: Since R and RMW have different lists of allowable tags, how
> > does herd7 decide which tags are allowed for an event that is in both
> > the R and RMW sets?
> 
> After looking over the patch draft for herd7 written by Hernan [1], my best
> guess is: it doen't. It seems that after herd7 detects you are using LKMM it

Right, you can event put a 'acquire tag to WRITE_ONCE():

	-WRITE_ONCE(X,V) { __store{once}(X,V); }
	+WRITE_ONCE(X,V) { __store{acquire}(X,V); }		

, herd won't complain, but it may change the model behavior.

Here is what I know from the herd code:

*	First, normally herd just put whatever the tag you specify in
	.def file to the accesses event (it has to be one of the tags
	in Access list in .bell file).

*	An access event looks like:

	(read_or_write?, ..., anonatation, is_atomic?, ...)

	"is_atomic?" means whether the event comes from an rmw
	primitives. So a READ_ONCE() will look like:

	(read, ..., once, false, ...)

	and a WRITE_ONCE() will look like:

	(write, ..., once, false, ...)

	the read part of an atomic_add_return_relaxed() is:

	(read, ..., once, true, ...)

	note that the "is_atomic?" is how this event ends up in "RMW"
	set.

> simply drops all tags except 'acquire on read and 'release on store.

Right, herd does some extra work to filter out RELEASE reads and ACQUIRE
writes for rwm atomics, basically, when herd is generating events for an
rmw atomic, if it's not "mb", it will only kill 'acquire for read and
'release on store, otherwise, it changes the annotation part to 'once.
Funny example, if you do a __atomic_fetch_op{hello}(..), herd will treat
it as a __atomic_fetch_op{once}(..) because of this.

> Everything else becomes 'once (and 'mb adds some F[mb] sometimes).
> 
> That means that if one were to go through with the earlier suggestion to
> distinguish between the smp_mb() Mb and the cmpxchg() Mb, e.g. by calling
> the latter RmwMb, current herd7 would always erase the RmwMb tag because it
> is not called "acquire" or "release".
> The same would happen of course if you introduced an RmwAcquire tag.
> 
> So there are several options:
> 
> - treat the tags as a syntactic thing which is always present, and
>  specify their meaning purely in the cat file, analogous to what you
>  have defined above. This is personally my favorite solution. To
>  implement this in herd7 we would simply remove all the current special
>  cases for the LKMM barriers, which I like.
> 

Agreed.

>  However then we need to actually define the behavior of herd if
>  an inappropriate tag (like release on a load) is provided. Since the
>  restriction is actually mostly enforced by the .def file - by simply
>  not  providing a smp_store_acquire() etc. -, that only concerns RMWs,
>  where xchg_acquire() would apply the Acquire tag to the write also.
> 
>  The easiest solution is to simply remove the syntax for specifying
>  restrictions - it seems it is not doing much right now anyways - and
>  do the filtering inside .bell, with things like
> 
>     (* only writes can have Release tags *)
>     let Release = Release & W \ (RMW \ rng(rmw))
> 
>  One good thing about this way is that it would work even without
>  modifying herd, since it is in a sense idempotent with the

Well, we still need to turn off the "smart" annotation rewritting in
herd (e.g. -> once), but I think that's a good thing: it simplifies the
internal work herd does, and it also helps people on other tools
understand LKMM better.

>  transformations done by herd.
> 
>  FWIW, in our internal weak memory model in Dresden we did exactly this,

so the model doesn't work elsewhere even in Germany? ;-) Sorry, couldn'
t resist ;-) ;-) ;-)

>  and use REL for the syntax and Rel for the semantic release ordering to
>  make the distinction more clear, with things like:
> 
>     let Acq = (ACQ | SC) & (R | F)
>     let Rel = (REL | SC) & (W | F)
> 
>  (SC is our equivalent to LKMM's Mb)
> 
> - treat the tags as semantic markers that are only present or not under
>  some circumstances, and define the semantics fully based on the present
>  tags. The circumstances are currently hardcoded in herd7, but we should
>  move them out with some syntax like __cmpxchg{acquire}{once}.
> 
>  This requires touching the parser and of course still has the issue
>  with the acquire tag appearing on the store as well.
> 
> - provide a full syntax for defining the event sequence that is
>  expected. For example, for a cmpxchg we could do
> 
>     cmpxchg = { F[success-cmpxchg]; c = R&RMW[once]; if (c==v) {
> W&RMW[once]; } F[success-cmpxchg] }
> 
>  and then define in .bell that a success-cmpxchg is an mb if it is
>  directly next to a cmpxchg that succeeds.
> 
>  The advantage is that you can customize the representation to whatever
>  kernel devs thing is the most intuitive. The downside is that it
>  requires major rewrites to herd7, someone to think about a reasonable
>  language for specifying this etc.
> 

I no doubt am the fan of the first approach, herd is powerful because
the ability to customize the semantic rules for model ordering models,
moving more parts from herd internals to the cat file (or bell file) is
always a good thing to me.

Regards,
Boqun

> 
> 
> Best wishes,
>   jonas
> 
> 
> 
> [1] https://github.com/herd/herdtools7/pull/865
> 

