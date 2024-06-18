Return-Path: <linux-arch+bounces-4964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3E90DBD0
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53323B21ACC
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 18:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1315ECC9;
	Tue, 18 Jun 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFVughGs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839615ECCD;
	Tue, 18 Jun 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736083; cv=none; b=Jyf7TP/NNY3SE+w60iXv++dlodomZCLrBDWU7DSISSUXZcKncr4VOCpx+lF5JlSiqGTRfKYtwk5fCR3s71n4yzi93NZjcHWYBUSJkYYEpXtmI71n6ZNMl4dmRNe+O/OzRQqJlzI1CQtsyvWDqlTnPlFV82USNOss4NtMmEvZjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736083; c=relaxed/simple;
	bh=JMFxk4gedX/JkDOE1WCSwvRaRUTU9VOuNxDvSueKDk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+lWkIZo3xm9UcYYnLk/quauUnlSrIav5iFCxkWVD4A5wcx2xyhLVZrFZ+2hCpfwzDtBUjWrBLf+fKV+CsFGC7eNwem/b9AHcmLLjBcoT3oAwHQooTCGT+MK1bCItA0jkzDNelQbKLiLyBt3pA5qOkmDsG9df57DqOCEWVFGy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFVughGs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-424720e73e0so7658325e9.0;
        Tue, 18 Jun 2024 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718736080; x=1719340880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fShwBivU5MiQwtwMMBw8OOKzgdZNWcvWKH6r/mBNk1Q=;
        b=LFVughGsTXlpwxfC66JjJo0cmwUlTzSK+1KuFqy/d3dlmhPSqHenp5fmSO7vVKJecb
         lY/ZTqbRAFrHjW+JtmBNmenM9HvJ4PHBosrerpiaGnBbVjJ7E1G0vGu7pphkI3z8s8Bh
         UNVrnG7v2zX6TFhuR5Ey4/7V4FucV+75Q4fltNgijEcQvQVCBuiQSf2Q8S5Rb2CXhNM4
         hT3rTvdKERXdUXx5pNqv+CJ9aOxZXdHCfqUltt8OJBbMxyVmKgMhOwSRzymK8SmbIsJA
         FO9tygJbZlBXsybOyAckTLmKhKDjyha6MPFfGqLiONQo0UGeSa6TIDw+MHo1Ny4KGfGW
         YNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718736080; x=1719340880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fShwBivU5MiQwtwMMBw8OOKzgdZNWcvWKH6r/mBNk1Q=;
        b=iQOEWEIXTpPUDHUcUqSlXNCy+JLdf52MnFEBGCT2ylrl2yFRhZ+jHyVqBjnkl4XwRc
         L5eXd2sVhorgYr9XE4CHaoSk6VKkJHf2SI+wSimaWYU7XCuVswartEK+FXmK9ZmUkLVQ
         N+odJh1PmCpHg+d22g9TPpEBcnKVzOLBsMydH2j7P1lJ316qhycbSKcP3Nr8eflfXac+
         K4briu3sUSWi68hWZh5MXfsh/B2n4tTNzAwlJc4KfnVtJ3CDy3enHZA/mQrL9PiZ4UhX
         aiB+pTFrqYm8dtRZdRf03zMTdAV9XuqADqXuiDlQMZK6VBtxqdP8YS0hYVZ/SieeIWgm
         Zgxw==
X-Forwarded-Encrypted: i=1; AJvYcCW3JVPewJgUCn7Z3A/ywD2a/kJ+jzCRRkNhsd+rpuPmGZ9pwfSS4hd0FeBzxQqeXNU4wyAkVoU62pAAWgF2zgHJBpf6Cyvv5yxJg7QoHz+m/ZNO0GbsduV6aHihbr10glG3NHu+f5GCsA==
X-Gm-Message-State: AOJu0YwAT+0M2888qOobMdeRSM3wF61fMqyNxZ7Jko1/uqy50Gks122A
	b5sIdlA1COKcHlbsdGfG9FJJCJyoI+TsX/xKluglxFxRITEB2OYD
X-Google-Smtp-Source: AGHT+IHeAEVjEsE1kkY9R+MitmYSlPQ8tkHSsPqpYx3gwfp5v3hEn4UBGB3rJiV4jDMaKpIqnB39dA==
X-Received: by 2002:a05:600c:4654:b0:422:5c5d:1b7e with SMTP id 5b1f17b1804b1-4247507a96emr1925455e9.5.1718736080045;
        Tue, 18 Jun 2024 11:41:20 -0700 (PDT)
Received: from andrea (host-79-51-73-205.retail.telecomitalia.it. [79.51.73.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362907048b0sm1344408f8f.24.2024.06.18.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:41:19 -0700 (PDT)
Date: Tue, 18 Jun 2024 20:41:15 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZnHUy2saXOgJr1Db@andrea>
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <6a7235ae-047d-484f-9180-1bd90e935468@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7235ae-047d-484f-9180-1bd90e935468@paulmck-laptop>

> Queued, thank you!
> 
> I added Boqun's and Hernan's Reviewed-by tags and did the usual
> wordsmithing.  Please check below to make sure that I did not mess
> anything up.

Thanks!  That does look good to me.

It is missing the small addition to the rmw description discussed
earlier in the thread [1]: feel free to squash it in your commit if
that works for you (alternatively, I can respin the entire thing
with that, JLMK what you prefer).


> Also, Puranjay added atomic_and()/or()/xor() and add_negative, which
> is slated to go in to the next merge window:
> 
> be98107ab8a5 ("tools/memory-model: Add atomic_and()/or()/xor() and add_negative")
> 
> Would you like to add the corresponding lines to this table?

atomic_and() and atomic_add_negative() (together with its variants)
should be listed in the table.

I did promise myself that I would have not done "or", "xor", "andnot"
as well as "sub", "inc", "dec", but never say never!  :-) Alternatively,
we could perhaps add a note along the lines of

  The table includes "add" and "and" operations; analogous/identical
  representations for "sub", "inc", "dec", "or", "xor" and "andnot"
  operations are omitted.

  Andrea

[1] https://lore.kernel.org/ZnFZPJlILp5B9scN@andrea

