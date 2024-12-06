Return-Path: <linux-arch+bounces-9290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689069E7892
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 20:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B74316C192
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 19:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB6198A06;
	Fri,  6 Dec 2024 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="RCN7PGZd"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2E213D516;
	Fri,  6 Dec 2024 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512082; cv=none; b=pJ6qlA5galhrNpRA/u5CWWWkx3MC9Y9ISoZ1LTUlRo61AD3ppD5PebRIdtYHVgoLax8LjzsVoTE7PtXqlW/Lh0okzrRe0SE3Wpo6NECoa5iuVJw33OSH4PApy1Yn/SsQK7FK2FU7pCYhadkpUi6WJl0nZ1n5kIVqvVAfQ9trwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512082; c=relaxed/simple;
	bh=RYs4O/itcc6UV040vJjiMZuKlMwHUk0GNi9y3x1mF/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ks89QZmG6i3XXBhtXqtRu+0PeFTXTcQP+wD0c7EJQlGufqzaGIh7IbRIPIXD/2YNwiQ/q2NdloRthE9nhWwRyjIVNJ6QW4GI1H/Wreou5xnmVXyqYuzm6VxX6pJKfJ7aXbQIzb+eOUKM4PT+tQFZlbvEK+EMQylfdQP6ILtbQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=RCN7PGZd; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1733512073;
	bh=RYs4O/itcc6UV040vJjiMZuKlMwHUk0GNi9y3x1mF/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RCN7PGZdTRamu8fhh/4+Vpby6pS5rzsBJiG5recGK66JHxnGaejhpaDjdAGuz7pAV
	 p2nTAkvisqzPT3VyB8b3iAIt6SML6WmWR+HtgAzIX3WIU9+nYz8EPfwlaKiLhPtuhz
	 WcKMfXQZlUwM+q9+v+w5CrmaLZpi9oqFT4QFyvqo=
Received: by gentwo.org (Postfix, from userid 1003)
	id C7B75401EE; Fri,  6 Dec 2024 11:07:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C4B19401E7;
	Fri,  6 Dec 2024 11:07:53 -0800 (PST)
Date: Fri, 6 Dec 2024 11:07:53 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Dennis Zhou <dennis@kernel.org>
cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
    linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
    Nadav Amit <nadav.amit@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
    Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
    Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
    Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/6] percpu: Repurpose __percpu tag as a named address
 space qualifier
In-Reply-To: <Z1KpWenJGqhjtNL9@V92F7Y9K0C.lan>
Message-ID: <b95641e3-39e1-01f0-54ff-000d860516cb@gentwo.org>
References: <20241205154247.43444-1-ubizjak@gmail.com> <20241205154247.43444-6-ubizjak@gmail.com> <Z1KpWenJGqhjtNL9@V92F7Y9K0C.lan>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 5 Dec 2024, Dennis Zhou wrote:

> I read through the series and I think my only nit would be here. Can we
> name this __percpu_qual? My thoughts are that it keeps it consistent
> with the old address space identifier and largely most of the core
> percpu stuff is defined with percpu as the naming scheme.

Yes lets keep it consistent.


