Return-Path: <linux-arch+bounces-4506-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A17A38CD6D2
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159301F222E0
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD33F9CC;
	Thu, 23 May 2024 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U68Vj9hY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B99E545;
	Thu, 23 May 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716477284; cv=none; b=hTTGx7bqDBi3y7mSSUXjJ4NnOwQr2/KXo26yu4Xsj5BV8g7VJbxuXz37rUM0GLyoXhLADKP61gaBOGDxFsOi8pccQ9zn7Ik8pmnehg72oYyRej/txuwLohHHe7dzZrqJC+Nu3utn+/1YIv1xllVShVwXfHmSi1VFW9ZwRBuwkYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716477284; c=relaxed/simple;
	bh=UrWgmzHv1FvzYHZJUCRMrXiFsSf179Ng9+f1Nwk0uRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgAOMMBjmO9dvHAp3o0SUTH4F+lcFnpEoQHT2wYK1gXqmGwef+nbtTtrsJiogzy+nKjVJQ1xP11E4TvFhRMrTF+8x5/Z4DGZJXWav3xfNVNJftc3NUiHfv2TefmMuYlHdoUhPhdXdUVwEpHtDuLd6n70yJWvd6RVgr4IyZmp/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U68Vj9hY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7930531494aso176666085a.0;
        Thu, 23 May 2024 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716477282; x=1717082082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8tJgJ7tnegSk3eOfTcfQWXDGNN5K68hG1wm4R9804w=;
        b=U68Vj9hYXNmLD6tgzjigUEsT3alZ5frqdHkwNbDAh3tcWnHM00pwhxnNqZB+uGobA/
         0Zn1laokqTjz2KRasyN/mEkqBVxKZb9yWmExHi5t9GDnNZeFXHj5Kv7Xfzf2Rz6TldhS
         1B4TDvp8ycYAEwAnB0wi56UfuHVxYLI+OJq4ezgD6aUuFsUZJDDG/qJ91qlTX2fjdvAl
         YeUEA4/mKjaaOb21hzLx99H+U8JEGuCBz0cYaM1nPRqpnGsJ0WuVCdgokTmYQ82LXNa/
         NRSCIvX9AbYUrLAIar2JA0jCk3Th50E60Jg48FCXqg8OZ3JL+9FY0+QrKGeUrgbYoW1c
         DdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716477282; x=1717082082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8tJgJ7tnegSk3eOfTcfQWXDGNN5K68hG1wm4R9804w=;
        b=OV6+ryxen/0ueR+uECkec0qyfCHUnKaYR5QcZuTlkWnwSPA36NK9UBmNScNr7xZPwy
         FFkORYA5jTL3RZf/xTx/Lb228kFbVbcBNqnvyxMDQWpJSvlbJvDKAYOYYFWxAZPQS9pL
         Gbbp2UrHqO/W0ToYJs+/FC3ZFVTS2Pny/NdDuzgEaXPCMgZVgALVSBOl6/fCHxFOiIaO
         Xq1DpH3EXrsBAySkIvv+6cUbSh73jB9f3j3uaC9uS8LjbrWYia0Lltuo/+n+zq+qsqsy
         YlrzRKRnUvTnHv/wcttxPxSjavNhajmcrObQ7TvedxGEvsh6GX8EJ5O/8FCx2uVLTjwW
         3Iqw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/YgqFiWItvVyCloMIdRIwnXrpIDOqnnYqjVKbXv6rYx7maackWLmLTNqD97Tk5WJ2AFr/zQkCYtmcWrDcynBEs8fvrDDKUFJU5K6dvNA67HxW5hyL7AuUinBo6zA1vxlhkJ/Z9iLXg==
X-Gm-Message-State: AOJu0YxtW/81R1gc8h5RNOw1+K59CTJAE/79NbOVojx55GCWuCdiBYgg
	Uc568CKgnlvSB5iOJXca10hIoNsS/hTW0Roqj5lgHQWa8ohyD6w4
X-Google-Smtp-Source: AGHT+IG4+l/SaBj0IEGvVm91vS0aJMOfPCnw8bk773pySnINJ/OlT3nqC61iyIFrQm8ikavJ8A4ETw==
X-Received: by 2002:a37:f505:0:b0:793:d25:7b1 with SMTP id af79cd13be357-7949942d7aemr605246585a.23.1716477281641;
        Thu, 23 May 2024 08:14:41 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79319319b50sm629413085a.33.2024.05.23.08.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:14:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7A4051200068;
	Thu, 23 May 2024 11:14:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 May 2024 11:14:40 -0400
X-ME-Sender: <xms:YF1PZqfTlDsVhpypnBjzb5PZZJcZ_VAj1qM7V_UGH0E9lRe_RwFO1g>
    <xme:YF1PZkNEcEwtu3EpD6pxgPG-j-Val-oFZhWoE5Q2lkWDulkUWNnj3OODaYnN82X9j
    LoYuoJkcawyoilosw>
X-ME-Received: <xmr:YF1PZriaRWhVYQvx2DPYcl8mpySrw1sr_C_FQz8AW_ZDXj3kXFmv6d4kww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YF1PZn-cJ2XfxNgbZ3vE0NIEl2JPLIYH6m5dULNYyik1_M7ppM6RJg>
    <xmx:YF1PZmuAz0ssgv505BGjSjwWHYh64vTVpHqXTP0iPyABfX6acV2qEQ>
    <xmx:YF1PZuFrRGJWCv_R4NHdcU6Vu1fCONUy55R89QzHU3B_NLltXv2Q2A>
    <xmx:YF1PZlOmF1R8U6Bqa650p31jLEaxh2AhmDKPqQFuH6EbztiY29c7WQ>
    <xmx:YF1PZjMwtWRTwEEYYki2w8O1Kk6jH2l-8V0stTUc4KzsOeYynIGsp_B->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 11:14:39 -0400 (EDT)
Date: Thu, 23 May 2024 08:14:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
References: <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>

On Thu, May 23, 2024 at 04:26:23PM +0200, Hernan Ponce de Leon wrote:
> On 5/23/2024 4:05 PM, Alan Stern wrote:
> > On Thu, May 23, 2024 at 02:54:05PM +0200, Jonas Oberhauser wrote:
> > > 
> > > 
> > > Am 5/22/2024 um 4:20 PM schrieb Alan Stern:
> > > > It would be better if there was a way to tell herd7 not to add the 'mb
> > > > tag to failed instructions in the first place.  This approach is
> > > > brittle; see below.
> > > 
> > > Hernan told me that in fact that is actually currently the case in herd7.
> > > Failing RMW get assigned the Once tag implicitly.
> > > Another thing that I'd suggest to change.
> > 
> > Indeed.
> > 
> > > > An alternative would be to have a way for the .cat file to remove the
> > > > 'mb tag from a failed RMW instruction.  But I don't know if this is
> > > > feasible.
> > > 
> > > For Mb it's feasible, as there is no Mb read or Mb store.
> > > 
> > > Mb = Mb & (~M | dom(rmw) | range(rmw))
> > > 
> > > However one would want to do the same for Acq and Rel.
> > > 
> > > For that one would need to distinguish e.g. between a read that comes from a
> > > failed rmw instruction, and where the tag would disappear, or a normal
> > > standalone read.
> > > 
> > > For example, by using two different acquire tags, 'acquire and 'rmw-acquire,
> > > and defining
> > > 
> > > Acquire = Acquire | Rmw-acquire & (dom(rmw) | range(rmw))
> > > 
> > > Anyways we can do this change independently. So for now, we don't need
> > > RMW_MB.
> > 
> > Overall, it seems better to have herd7 assign the right tag, but change
> > the way the .def file works so that it can tell herd7 which tag to use
> > in each of the success and failure cases.
> 
> I am not fully sure how herd7 uses the .def file, but I guess something like
> adding a second memory tag to __cmpxchg could work
> 
> cmpxchg(X,V,W) __cmpxchg{mb, once}(X,V,W)
> cmpxchg_relaxed(X,V,W) __cmpxchg{once, once}(X,V,W)
> cmpxchg_acquire(X,V,W) __cmpxchg{acquire, acquire}(X,V,W)
> cmpxchg_release(X,V,W) __cmpxchg{release, release}(X,V,W)
> 

Note that cmpxchg_acquire() and cmpxchg_release() don't have _acqurie
or _release ordering if they fails.

Besides, I'm not sure this is a good idea. Because the "{mb}, {once},
etc" part is a syntax thing, you write a cmpxchg(), it should be
translated to a cmpxchg event with MB tag on. As to failed cmpxchg()
doesn't provide ordering, it's a semantics thing, as Jonas showed that
it can be represent in cat file. As long as it's a semanitc thing and we
can represent in cat file, I don't think we want herd to give a special
treatment.

What you and Jonas looks fine to me, since it moves the semantic bits
from herd internal to cat file.

Regards,
Boqun

> Hernan
> 
> > 
> > > > 	[M] ; po ; [RMW_MB]
> > > > 
> > > > 	[RMW_MB] ; po ; [M]
> > > > 
> > > > This is because events tagged with RMW_MB always are memory accesses,
> > > > and accesses that aren't part of the RMW are already covered by the
> > > > fencerel(Mb) thing above.
> > > 
> > > This has exactly the issue mentioned above - it will cause the rmw to have
> > > an internal strong fence that on powerpc probably isn't there.
> > 
> > Oops, that's right.  Silly oversight on my part.  But at least you
> > understood what I meant.
> > 
> > > We could do (with the assumption that Mb applies only to successful rmw):
> > > 
> > >   	[M] ; po ; [Mb & R]
> > >   	[Mb & W] ; po ; [M]
> > 
> > That works.
> > 
> > Alan
> 

