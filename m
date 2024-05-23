Return-Path: <linux-arch+bounces-4496-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1C8CCEBB
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778EA1F23AC0
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216D13D276;
	Thu, 23 May 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W06XnCZk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14C13CF93;
	Thu, 23 May 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455064; cv=none; b=pFOrZI3cW89Fm/e5tpabDtHQVjwrpMJM3mHSm1SwskEUsyj05Sv8e7h3E7xN6A0UvVzPpop8NUBIUEAfptev3wTGW2Y5dye0pFRPbAgrTiFFu6OXZqjACgQQmQeSbtsr0k5ZPRLuAGBOMY3eQw6RAdV9jQIMZaeZhbuTQb4x48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455064; c=relaxed/simple;
	bh=mxjVwRe+KA59zffjuSJoN+F11EDx50GvARclkXrc3Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9vPa0IAo6j6RJudWX1wJ/fm35xP87W+Qgg5jvzhNAHrfW5o6IwjXiPrrtIqq7U9nEiPCa9JQH6HFrN2vcYFKYPRwkSbPME30Xik2w/7QiDNt9Q7JrIGsJ5Lf4/gf9TQ5bCtX2WFS4iX0aypVlTkbZioIFyemuPPqil973bLjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W06XnCZk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5cec2c2981so462873866b.1;
        Thu, 23 May 2024 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716455061; x=1717059861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwT/Yuq4OgMz2tzy/XuZk3iW6O1XSg4X5ai7w04Ljms=;
        b=W06XnCZkl5CALs2SemXvlwKTJ9wIktVuqysY4ZEgFSp1kA7tNE8NVfyTuee2TJEFdQ
         alB/7FhEujFTdWxhDkr6TNlhEm1hrt2zPOMXzsBrUyDdnQ46GAvBpmMA+SlczoLiRjrP
         dP3q7ReaL/elnBHMkvJsZaAZ87l/ACqRYvIB2eRKLH2ep4LabWOZ3LeuR4eem2SzXJfD
         K//07t0A/fTaPco9XB4KpH3dyRhcBl4VS0XKtqKAGWAPBTWwI63goF9J6nJN8YdIPO8K
         DfiK5mF4D6flY0fvIT59UBMgblS3VtTiRkLgQwYCoJp5NdWgYnjPMEDkmgpuqKQ6yI7c
         gNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716455061; x=1717059861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwT/Yuq4OgMz2tzy/XuZk3iW6O1XSg4X5ai7w04Ljms=;
        b=MhFuRRs8NBafoYuCCUh5eEAl+ycmEU/E/iBWzYJqvkFhx0REZdT/ATf19yg3FmIkN7
         4JZ8IyLsIIlET/xN851xoz3C/KqAZWWDLm5Gdtcdz/t87vZ5i/hKLSfY06E7Y//yFZJL
         /MkJHaDRSFG1bMcT3ueAxWQl5UDSp6RdEoHIBzQlTj6IAFCki8oXHj63jcQyQtbec2Cl
         FgyKnPT9ed5STJJ4eW/b+W79U6+mdvde7Bn5C1xQVbyBCKTZeKIgfUPatcQrBaV/EUUa
         TTJavr/xhibj06PuCSZziKCrW43JWHcSs0zCo+bRQVrntyPJimDTpL9CqYjzw2PpvS+c
         Udow==
X-Forwarded-Encrypted: i=1; AJvYcCXyoFzYSKHMPfYho1XPtpZ2gtAyI1W9NbGmGf6kfjn4ag/89iohC9dtRMUg/A47ghWjA2qwQ++21R6gjGw+/vby/3QSxowkC/gYSkqZdkyC81VXik3tcUWvpRAI3n4Gxa6n0Qd2QjQk4w==
X-Gm-Message-State: AOJu0YzWyC0yN1vAFe0MD/4FTbimqQrwQQyZQRS+unUtv6xYgKGjYCzp
	jum1tG10I0370Zxi4RYuwp2Ag8IgYN8yZ21ROAkfyKZdWcO0T1Ro
X-Google-Smtp-Source: AGHT+IEz4KSr9vaAY0Rypx/DggKHZh91zzLIw9ycm65PkqV/FxMezQ4VwE3rGO485BLUAsZ+USk94w==
X-Received: by 2002:a50:8e17:0:b0:573:55cc:2f50 with SMTP id 4fb4d7f45d1cf-57832c585c5mr3541161a12.37.1716455060827;
        Thu, 23 May 2024 02:04:20 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c322dc2sm19648156a12.88.2024.05.23.02.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:04:20 -0700 (PDT)
Date: Thu, 23 May 2024 11:04:16 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, boqun.feng@gmail.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <Zk8GkFlnKeyIgYQb@andrea>
References: <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <Zk4jQe7Vq3N2Vip0@andrea>
 <ba7120a5-9208-4506-bf99-2bfa165180c5@rowland.harvard.edu>
 <22b9837b-16c2-5413-3cd7-4d3a47252a6a@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b9837b-16c2-5413-3cd7-4d3a47252a6a@huaweicloud.com>

> It would be much simpler if
> one could find all the information to support lkmm in tools/memory-model/
> (in the form of the model + some comments or a .txt to cover those things we
> cannot move out of the tool implementation), rather than having to dive into
> herd7 code.

Got it.  And I do find that very relatable to LKMM developers who, like me,
are definitely not fluent in OCaml.  :-/

Let me draft some .txt to such effect, based on but expanding and hopefully
completing my previous remarks in

  https://lore.kernel.org/lkml/ZjrSm119+IfIU9eU@andrea/

Having something like that "on paper" can also help evaluate future changes
to the tool and/or model.

Thank you for the suggestion.

  Andrea

