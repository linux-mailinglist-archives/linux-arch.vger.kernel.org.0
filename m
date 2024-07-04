Return-Path: <linux-arch+bounces-5244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D4D926E05
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 05:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4321B20F60
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 03:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B238DE9;
	Thu,  4 Jul 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM+/39Bz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C74381C7;
	Thu,  4 Jul 2024 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720063468; cv=none; b=BYPqM4HZzmQkeFBImsi2H6xBTIx19dqyZh2BbJSqdpbzPe5bXemyId1ZRQyxyjPN7gxW3h8Qp+3ltJ5QznpvTbDIKDSg6B7TASmK8uJuWudA4HU3l61VK3O9GZ3QYEzzXctw4q0iA7PHtMKgw+M/Sy/pcw3zxMpbXo3yuPYZW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720063468; c=relaxed/simple;
	bh=v3FrcAtYCGWyuTAihvF07Jd1wZmx30zVT7ZGNmJt84s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ1xGJjh988R0o/u6dTJeNDnfGI4JBqB3JJ8kGFago2LSxpbt3lksLzqK6xl3JYoe2O5QmOa9Id4yJsYoHWT3bglPlmo7LRigbIsTicsO6Lw2PjNu+cq1K++gbTJiLoY6VteBBHSRyexezU2B3sW2ZEFdS/gMSnQbfSsfc4YQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM+/39Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DE1C2BD10;
	Thu,  4 Jul 2024 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720063468;
	bh=v3FrcAtYCGWyuTAihvF07Jd1wZmx30zVT7ZGNmJt84s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fM+/39BzlhiefxhBcC8vC/AQXjwoiyC1ll4864bx8PM/Ptt4WYKpcLMWEtdCyyCdj
	 l/SEVDw/70kz/XDclACTGjxUMbMZ+QrQFduMsIG/mkO6/7HNaHp5U5rfvEhUZ5WOJT
	 8+5cGYCtq6bQOyK/s6okjzWo0s/gKwI4lYP5wlu4L8WCs16eEAgU3E9atRL12mwh/z
	 dCYDzKsKDTQD6UdZTp5cVObsteHg7enPBxjw0kjfkFynRZ16gNwlZl2tRDuMnDfbt3
	 4gWDIrE9gBRH2C04d6UAWtNmY8WpUj0XifRIo/x+qMq3/1XkxYMFVCku4pWsyAaZim
	 /hRIZUG1fIt/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C20BCE0A01; Wed,  3 Jul 2024 20:24:27 -0700 (PDT)
Date: Wed, 3 Jul 2024 20:24:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH lkmm] docs/memory-barriers.txt: Remove left-over
 references to "CACHE COHERENCY"
Message-ID: <9efe90fe-ea56-4c18-a4bb-a03d3ab4135e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>
 <ZoQFMqkRMDEZdvpa@andrea>
 <00b12ab0-611c-4006-91a3-229062ba2139@paulmck-laptop>
 <fd9c003a-b1ea-46cf-a6d1-b91b174bcf7b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9c003a-b1ea-46cf-a6d1-b91b174bcf7b@gmail.com>

On Thu, Jul 04, 2024 at 12:07:32PM +0900, Akira Yokosawa wrote:
> [Dropping most CCs]
> 
> On Tue, 2 Jul 2024 10:35:43 -0700, Paul E. McKenney wrote:
> > On Tue, Jul 02, 2024 at 03:48:34PM +0200, Andrea Parri wrote:
> >> On Tue, Jul 02, 2024 at 08:42:44PM +0900, Akira Yokosawa wrote:
> >>> Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
> >>> [smp_]read_barrier_depends()") removed the entire section of "CACHE
> >>> COHERENCY", without getting rid of its traces.
> >>>
> >>> Remove them.
> >>>
> >>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>
> >> Acked-by: Andrea Parri <parri.andrea@gmail.com>
> > 
> > Queued for the v6.12 merge window, thank you both!
> 
> Paul,
> 
> Commit 1b8aad080e48 in the dev tree doesn't have Andrea's Acked-by:
> 
> Can you please apply it on next rebase?

Apologies to you both and thank you for checking!  I have it on my list
for the next rebase.

							Thanx, Paul

