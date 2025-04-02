Return-Path: <linux-arch+bounces-11225-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44C6A7935E
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 18:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AA51889776
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CD18DF80;
	Wed,  2 Apr 2025 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZ9/WGpi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5118C936;
	Wed,  2 Apr 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743612064; cv=none; b=EQTw1EJlqv6z545S0tJ8zEjTQWMuwd96MUrx4MRe/cD/TFtSZAkq8TBzFR4x6/KBTeAbDxjXAC8VAmAErcXymVyieHuvIcUEtj1sUqXyg5ZXr389+A007MLgvOlKhFx2ihiGbmG59UM/FIyp+a2aK9xRJWRJJ0yWNq5KVK+6lLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743612064; c=relaxed/simple;
	bh=JL3Fc6Tx+Y7KKkGF51EOD/8yZESEW5Hbu4AYBc2UUrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJuLUIgHZ5uDCweDuKyAefuDOfL4JyPalIlTltWr7GoKN0VEHbpRAWI13OSAqmmvEPp2oIREa3l37iBqCHHOys00fzy2JjokWiBMPkghHU1sADq36iKmAIlFcA+k/BkDUzwa6FxZTGwGBs3i/TFnWdyBO0mfWwY+rjxGbrjSafw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZ9/WGpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14142C4CEDD;
	Wed,  2 Apr 2025 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743612063;
	bh=JL3Fc6Tx+Y7KKkGF51EOD/8yZESEW5Hbu4AYBc2UUrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZ9/WGpiBdApatkU/d5aXIEl+WX0smTkXKrSB3ldd+SYl+KKwiJfRxS3Ffosk/QIE
	 A870YcJT/MKSH0geGokVXHyBKxhEKl1t0PSQ3m9qS+S+0lKlTK/PIZGvwzlGIQRB+l
	 5QEm0Een/ahWUEQpOxsWE83ohXUbfW86/OPkRrGjtLmUejFzt14QHVHVFqtcWsHjMl
	 loy/psVrs21p1kTL0YmeuH06KfbmZJdWlZJyQnzRhiVjfM2mIXmAXplt7qZgUOazFv
	 jsaeCLzl7m1UFch4Whr5CPBrxwEUTL9BO35nPnQ8R8vq/PPhNbLOOTlgoUUKvEZuak
	 m/O6nScePRV5g==
Date: Wed, 2 Apr 2025 09:41:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32
 and drop 'default y'
Message-ID: <20250402164101.GC1235@sol.localdomain>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-2-ebiggers@kernel.org>
 <2c1cbb51-cc16-4292-ad30-482d93935d91@infradead.org>
 <20250402035107.GA317606@sol.localdomain>
 <81aac5ff-8698-4059-92a2-bccb998eb000@infradead.org>
 <20250402050234.GB317606@sol.localdomain>
 <b5589b7d-d4a1-4b12-a845-afdbb26ed845@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5589b7d-d4a1-4b12-a845-afdbb26ed845@infradead.org>

On Tue, Apr 01, 2025 at 10:56:32PM -0700, Randy Dunlap wrote:
> 
> 
> On 4/1/25 10:02 PM, Eric Biggers wrote:
> > On Tue, Apr 01, 2025 at 09:50:57PM -0700, Randy Dunlap wrote:
> >>
> >>
> >> On 4/1/25 8:51 PM, Eric Biggers wrote:
> >>> On Tue, Apr 01, 2025 at 08:42:41PM -0700, Randy Dunlap wrote:
> >>>> Hi 
> >>>>
> >>>> On 4/1/25 3:15 PM, Eric Biggers wrote:
> >>>>> From: Eric Biggers <ebiggers@google.com>
> >>>>>
> >>>>> All modules that need CONFIG_CRC32 already select it, so there is no
> >>>>> need to bother users about the option, nor to default it to y.
> >>>>>
> >>>>
> >>>> My memory from 10-20 years ago could be foggy, but ISTR that someone made at least
> >>>> CRC16 and CRC32 user-selectable in order to support out-of-tree modules...
> >>>> FWIW.
> >>>> But they would not need to be default y.
> >>>
> >>> That's not supported by upstream, though.
> >>
> >> Which part is not supported by upstream?
> > 
> > Having prompts for library kconfig options solely because out-of-tree modules
> > might need them.
> 
> Well, I think that is was supported for many years. I don't see how it would become
> unsupported all of a sudden. IMHO.

Most kernel-internal options aren't user-selectable, though.  It's mainly just
some older ones that were made user-selectable for some reason, and that is a
mistake that has been getting cleaned up over time.

Consider that the upstream community has no visibility into out-of-tree modules
in general, so there is no reasonable policy that could be applied in deciding
which options should be user-selectable purely for the benefit of out-of-tree
modules.  The only reasonable policy is to consider in-tree users only.  Just
like we don't add EXPORT_SYMBOL() just because an out-of-tree module wants it.

And of course downstreams always can, and do, just add a new kconfig option that
selects any non-visible options they want.

- Eric

