Return-Path: <linux-arch+bounces-4525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A749B8CE723
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC4828197B
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3986643;
	Fri, 24 May 2024 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWhpdXMq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AB42AB7;
	Fri, 24 May 2024 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561251; cv=none; b=GZXEJAW63zDLMqKc+pGDc734mu32rRp5qqZabnqp/v1/FTFTz/DFepT/TTyHDnQh26P9q3E35EBbgZdodLEyRfRxxaZISOS1Jt6iIJSSRMqLU9qB1j/Q80FdeXC/BzNuSXZ7N9nOG608J3xv0huvo7FsuTuQg7CMac7NoJyjeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561251; c=relaxed/simple;
	bh=I2+v/Q1z59dUqcWNBqnyTuW1Jc7Qs0z4dRzAqGwlZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9iWfoRyq7a6IMSOkKR7l8rlm6y78VfN40xqw+0nO2kxoLLG3vHmW3isAgX5QhafHTGlTlLwKhIfUxg9cD5xaMpkDTEYlYmBM+/xuQcAPgHPlyCho35KktWaF63vYSfyPaIH0hlBzjdY+5GSz+c8GfiadjC9xKV18fcZH+NAnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWhpdXMq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7948b50225bso265706685a.3;
        Fri, 24 May 2024 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716561249; x=1717166049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lavIFKRIk7FHUjZ/QCzEd4xNbBSagRLiRaEukU2fFZU=;
        b=IWhpdXMq0kKJgeRYGGbAG1Wc2hCruP0E/Sh8EGswURaIc06g5PbEs1Q4SYa2gEhsGD
         RAcAfrpBoUePFq7uKJrPZHdK806fpg2BhwtQXyAxzPp0Qof1f9HhK7sgWZmL4zFbhRZ/
         1y35zEr7Y3ulwYq1FvDi8nY6jR8TvlpGILhLjNf2h8Nf0K4szf93M0FtQ8NQIrvGZag1
         zPV7gMkSdTLuZ3BH1OZYOnxPOvUs55HFzB4FZfCnnWbsKY+6c2+t6bSj082NqeINmnTT
         Ohe2/Pa7kPr06gjzB60jh4ZxU2TLtoSpHMaXL4gERjYY0Vwj9ckziVzBsB3bYnFi31I0
         5FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561249; x=1717166049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lavIFKRIk7FHUjZ/QCzEd4xNbBSagRLiRaEukU2fFZU=;
        b=aA/Mnjvo1Z4o1uKKjOVQnvQvFvOB7KnuftT9cw6jPG9hH6+hbKQRKNNLYlPfa8KunY
         9wmN5j6nF1nIo//z7RcpKTmyw4ZDH/1BnvETUEjQZcrNF3znbuD+N8Lxucpc1OeNJEGv
         pLuiFjD7I6MyI4x+qnn4XIkv4flBOeeMuqKj2VpwXtWAHs8gIGXndlHjV9NWYWtPBDVh
         jRW7C0SEpjxAKBJItnkMyBhSxsUYAyfXGUrCWT7ePpViwY6+SQQ3P1GTV5IxW7HJvQFt
         WVCwA9to2l0ZHb/Qo7mT0Tb530DgsDF1mvip21cD6vcSpg9H8tVf39U4bVZ9jav6UGHt
         PFaA==
X-Forwarded-Encrypted: i=1; AJvYcCXWxlV7JIERx9CLmIwAMaj3/R3377kOFxL4cJqm+Ea927wb86yo2mGKBPS5VE4NK51SL5y+9fneKBNFhdFH4J4GydUKuuZmc0Q8KiBkuYuB6JrGNwf3uZ23BbbpPOuNNX77dpIEYqxy+g==
X-Gm-Message-State: AOJu0YywEdWP0tTTHHvOLgYAmfyIjxHFAMQyHuHdi9cXAJ0TroJhwG9Q
	h16L9zwSHtz9tyfvmXVtruJ+SEjbzH3LfujC3+6W0dY4KurrF3R7Jf246Q==
X-Google-Smtp-Source: AGHT+IHJVDIqpjASk3yLVR9rTzk9Ct4pXr7InniiEPN9pPtGrfOY/9/IhzAB/b9qkQ6XJiZgtQVq5w==
X-Received: by 2002:a05:620a:a99:b0:793:292:ba41 with SMTP id af79cd13be357-794ab0f84e5mr259139185a.56.1716561248931;
        Fri, 24 May 2024 07:34:08 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abca595fsm68702085a.20.2024.05.24.07.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:34:08 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0B8611200066;
	Fri, 24 May 2024 10:34:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 10:34:08 -0400
X-ME-Sender: <xms:X6VQZpGAyFarDeUP7jTZVyABwvtuFpP-f2flyXSOwcFckdVXsP_GSQ>
    <xme:X6VQZuUfg6Kf02X6TkH09ZRYJSrMuzAktZYzrdFz_0RDw4Sw7rm9fXbzZOpf6upuM
    yPddy2jFUWjIodwsg>
X-ME-Received: <xmr:X6VQZrKq-PT13AwDlG27NLVAk-TpirofwJw0PMChefmhpL_RtdCKRAIVCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:X6VQZvEFOLSs2EXL7SxLkEUydwVE_vh09W3HNTPnJ3vvLeenWirUxw>
    <xmx:X6VQZvXRoMUvutPisOrFw2vWeOgkKlR06AxFiPO8anTkkDIjEW7uhw>
    <xmx:X6VQZqMf3iYE_Oc68IhTtg_Kw3k38izh-druHNS-SpIfWJQldW1RAg>
    <xmx:X6VQZu174RMJKFlmHhvvHS3UoPMQFIEqsWCy7AqKi-ol7D0n-o77gg>
    <xmx:YKVQZsV-hdlGj7Udns2Lgo54X75g9azVyTd61GTVpE_94y-rH3exqmU0>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 10:34:07 -0400 (EDT)
Date: Fri, 24 May 2024 07:34:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <ZlClXpjGga-6cv00@Boquns-Mac-mini.home>
References: <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
 <Zk9dXj-f4rANxPep@Boquns-Mac-mini.home>
 <da5241f5-0ae3-40dd-a2fb-8f5307d31dba@rowland.harvard.edu>
 <ZlAAY-BuXSs9xU0m@Boquns-Mac-mini.home>
 <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9256f95a-858b-435f-b40a-a4508a1096c9@rowland.harvard.edu>

On Fri, May 24, 2024 at 10:14:25AM -0400, Alan Stern wrote:
[...]
> > Not really, RMW events contains all events generated from
> > read-modify-write primitives, if there is an R event without a rmw
> > relation (i.e there is no corresponding write event), it's a failed RWM
> > by definition: it cannot be anything else.
> 
> Not true.  An R event without an rmw relation could be a READ_ONCE().  

No, the R event is already in the RWM events, it has come from a rwm
atomic.

> Or a plain read.  The memory model uses the tag to distinguish these 
> cases.
> 
> > > that it would work is merely an artifact of herd7's internal actions.  I 
> > > think it would be much cleaner if herd7 represented these events in some 
> > > other way, particularly if we can tell it how.
> > > 
> > > After all, herd7 already does generate different sets of events for 
> > > successful (both R and W) and failed (only R) RMWs.  It's not such a big 
> > > stretch to make the R events it generates different in the two cases.
> > > 
> > 
> > I thought we want to simplify the herd internal processing by avoid
> > adding mb events in cmpxchg() cases, in the same spirit, if syntactic
> > tagging is already good enough, why do we want to make herd complicate?
> 
> Herd7 already is complicated by the fact that it needs to handle 
> cmpxchg() instructions in two ways: success and failure.  This 
> complication is unavoidable.  Adding one extra layer (different tags for 
> the different ways) is an insignificant increase in the complication, 
> IMO. And it's a net reduction when you compare it to the amount of 
> complication currently in the herd7 code.
> 
> Also what about cmpxchg_acquire()?  If it fails, it will generate an R 
> event with an acquire tag not in the rmw relation.  There is no way to 
> tell such events apart from a normal smp_load_acquire(), and so the .cat 
> file would have no way to know that the event should not have acquire 
> semantics.  I guess we would have to rename this tag, as well.

No,

	let read_of_rmw = (RMW & R) 
	let fail_read_of_rmw = read_of_rmw / dom(rmw)
	let fail_cmpxchg_acquire = fail_read_of_rmw & [Acquire]

gives you all the failed cmpxchg_acquire() apart from a normal
smp_load_acquire().

Regards,
Boqun

> 
> Alan

