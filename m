Return-Path: <linux-arch+bounces-15641-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80844CEFC86
	for <lists+linux-arch@lfdr.de>; Sat, 03 Jan 2026 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F48B3009D77
	for <lists+linux-arch@lfdr.de>; Sat,  3 Jan 2026 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEA2DA749;
	Sat,  3 Jan 2026 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOKf0f3A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F92D9EF3
	for <linux-arch@vger.kernel.org>; Sat,  3 Jan 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767426758; cv=none; b=mk6rjnJvIPVQhpJxejjmA8wKizSF6SGk8j7AUZm9qqfUK/QkrRsGrirA1Bd9ZJTHzbM+C5G7fn3CYfrmSqYNEHfa72Yt4Xd5FOV776NqQdYplsT3DkD5L6Zv1555JLihHRr8d9iLE81MBaEr5j+mxThjITOu+Wp2F4H+7J+DW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767426758; c=relaxed/simple;
	bh=OepI/2038pytnntbQ7eE+t9COIVaBah8qJlJ0ntVqJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXbO2x3g4iC7qwgoSEUbDsSb71x3DMkp2Le982I1giQEOPL1YuZcUhctpjRHw36DLILAPhmCTKx1/++p86gLCCP+KiQVTQ57vxqqNZyuZHKVdiRTjnEJlLi14QzLO37mL8sQzUO+8zhhWwmiTh4uXRbAg+XbY464Y09608lliow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOKf0f3A; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a288811a4so144622716d6.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Jan 2026 23:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767426755; x=1768031555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUiqiRrm6Mi1XumTouM00ZTDy0NSIsiEbxISr8TIwlk=;
        b=OOKf0f3Ab/MDHqpX8lvlvZQT+T1D5v5//7gN2uCvCU5fYddZX5BsIdsI9bcGTMEQOQ
         5JlWTYAVkIPw7n593HjkE7YSo2MdPhASrud8U3CZzxfbsdZBWfROPiy1Sgs+9ZcIhQ6J
         PHaZvL+OHYYcgoqbvhUEQgZpSl0XmGR/y9RgKn8vP0G7C2nuCTAbuilOLgJBne2fTdaQ
         2naU+zsapG35sU778RFGf2mCbhHrVdxZSytNVxDCol0g5F9cnpfyJH8/59Z7MjWudgeT
         ppSTYalxlj5u0ycKCjV1B7AMIIgkoh+jJUm1R1mbOxqXb0SXZNuIxcC2bIY2qvujDh+F
         ZE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767426755; x=1768031555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hUiqiRrm6Mi1XumTouM00ZTDy0NSIsiEbxISr8TIwlk=;
        b=EwP5yTHwRWck4PzawejvlgkHfxxkbAROlLAoaz1MDKz/6NYRJY/i8WZPO2O2bF1t9q
         35GN8nTXp8bzwP9sgDRUIKk/j8Aq/Z4+r3kpLqTKrXs2sGYaJogk7/Z3tCgK/VH4lrEx
         83Um4vWkVfuc5x5tfiwEP52nd1Sp/o56auyJnHH7Yh2oVeiaWLmsJKzY4/C/N2La0ZYv
         PAjSwu62OYvMij/VTuoTlsSQqIaZWjCZ8IOPHOeFZ3t5+shCfwD8LTU1XWwID8DsmJh7
         8GEhYh8cjBQOEaJeKkVViDYrUut+gmKsPhl+7NBTw4x4lqcqjPPUx2DIQUyVIww1CQlR
         qy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVScEfZHe4GJoNAFeC2wpMLOr2eKtRFn3UIR54ptep08azyjkLrmCwvdlmCL4lauRBpTrogHk13+LEe@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1uzJJ8v6/biYGAMVYTnChvRyIXo3tqCt1Jf5Dv0qiQv1MwiJ
	liCfwCSqnicyj/irg/UITIFGXwKr9TuY4UF5vLbtBQqLqNfOBTCh64gd
X-Gm-Gg: AY/fxX5/PJwYHI0WND1Wr3VNc4+20d9plmPS9DmmxMdijRGAKO9oeVOLxINYVDUVjwr
	8QMEv9cROOIZM/cAAkphbDrTA8DNWS/BEQkM0nkoAS65cfSBxAj4AkbVv7n+wfK/XT0Vsv2hsuN
	pFwlWR5ld4dRLdhxgq6vYSaIgSZsAJtZj+fKnzp8V9Nc6xiDHkYrZKeRpCiwpBlEOuxUnThrJ6m
	pr4xQtCBD7vakax5pE1hLf1T+dvlNd2RbUM8n645zZg4f3ane1pGDgvbCfNcXibD1lACP6paYje
	4CnLWOamVqTudDcxZuBwJzzrhWKRUfe+gQzojz4PQ4BMFCjMDIgxGxf+/BEcmuj1a6DbX0rk2SS
	jrP+stkQc2c1TpHEWqcXeZ18E4mIQDXlMyuol8cMe7GjXna6EG6EXRJQAlIxfpkviKNydmnymab
	MLMTfeSFYIZ3hjY/ABS3xlksx7O29/138OXXJL5sSHd+O+GmnTsZRvzk5kwqyuj4p/NaT9Nklgk
	41fEPw4t8jYe+x068AM6r6g9w==
X-Google-Smtp-Source: AGHT+IEOq/wwkTzOd1NhRjZygxY+EDrhCjN6YqGTDQzerar9HxKd5WEYHfrUIAjR1WtVKfqVdejxuw==
X-Received: by 2002:a0c:e991:0:b0:888:853c:4f55 with SMTP id 6a1803df08f44-88d844308f5mr576862066d6.70.1767426755336;
        Fri, 02 Jan 2026 23:52:35 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aeff4sm338510706d6.29.2026.01.02.23.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 23:52:34 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8DB69F40068;
	Sat,  3 Jan 2026 02:52:34 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 03 Jan 2026 02:52:34 -0500
X-ME-Sender: <xms:wspYaUEa5qjDTjbXIRiFxW-wWRO3Ub3vthbdSDb7H-LuMtgBtGWVew>
    <xme:wspYaT0z6ZxP1WP4De_eSMfg46Zp3lCy7DptaNzQrsrA8SQVIxo9gcWD-lrn_7CY6
    nbD3P5TyvDEaJcGxSM_f37qB9YViMhWe9KU7yY5TcjR3mwOD__6>
X-ME-Received: <xmr:wspYacKpeQ4r-Qcs8973mScAuMemBxXiiRV6Z-aZFtiBpkRMM3xnlbYsUFE5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeltdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepvdejleeukeekudfhieegjeduteffkeevleeuieevffefieduuddtveettdeugfdv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehfuhhjihhtrgdrthho
    mhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegurghk
    rheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:wspYaY3f00ByQumClIFZAn7JkhhL4frdto6WQYRqgIOIZwmcLt6b8A>
    <xmx:wspYaQnA-Mpz421Ufo_WzljlmhNGlzLLfy1yV6pK8Cyfr6PefO-wLg>
    <xmx:wspYaTjNg1x80qt6qJ9vkJ60dMZxjR8SiI9LixBbnnNkvtqESLBQfw>
    <xmx:wspYaXT-lVXSbTEE7MP-_UMy9yd226C1bELaK9UP5lXd2Io5WmM34w>
    <xmx:wspYad_W6Y7GJ6R7ooz-HpVctbH__34AjIAdmGAzmHye3xcEwSEbH6nn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 02:52:32 -0500 (EST)
Date: Sat, 3 Jan 2026 15:52:30 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, ojeda@kernel.org,
	a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, lossin@kernel.org,
	tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add atomic bool support
Message-ID: <aVjKvpzWbAXxzBlO@tardis-2.local>
References: <20260101034922.2020334-1-fujita.tomonori@gmail.com>
 <20260102112000.714ac16d.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102112000.714ac16d.gary@garyguo.net>

On Fri, Jan 02, 2026 at 11:20:00AM +0000, Gary Guo wrote:
> On Thu,  1 Jan 2026 12:49:20 +0900
> FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:
> 
> > This adds `bool` support to the Rust LKMM atomics.
> > 
> > Rust specifies that `bool` has size 1 and alignment 1 [1], so it can
> > be represented using an `i8` backing type.
> > 
> > [1] https://doc.rust-lang.org/reference/types/boolean.html
> > 
> > v2:
> > - remove AtomicImpl
> > - remove Safety comment about the bit patterns
> > - remove from_ptr() comment in cover letter
> > v1: https://lore.kernel.org/rust-for-linux/20251230045028.1773445-1-fujita.tomonori@gmail.com/
> > 
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Queued with the unnecessary impl AtomicIpml removed, thank you both!

Regards,
Boqun

> Thanks!
> 
> - Gary
> 
> > 
> > FUJITA Tomonori (2):
> >   rust: sync: atomic: Add atomic bool support via i8 representation
> >   rust: sync: atomic: Add atomic bool tests
> > 
> >  rust/kernel/sync/atomic/internal.rs  |  1 +
> >  rust/kernel/sync/atomic/predefine.rs | 27 +++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > 
> > base-commit: dafb6d4cabd044ccd7e49cea29363e8526edc071
> 

