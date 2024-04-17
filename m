Return-Path: <linux-arch+bounces-3778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE48A8D67
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 22:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB0D1C20E17
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5D1481AE;
	Wed, 17 Apr 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rBUtUvDb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840045957;
	Wed, 17 Apr 2024 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387516; cv=none; b=LJ/nRBXQbhilRibsNA0Ea04Zwu8e+QTFXfRLTNK0+16FzgiRxqDHWGYqh0cn+c+jUQA3CyLw1Q8j54mpX/lFJXy1tSzrHRChFXxfTWmBOuC3xk0xWQvaJud6GRCnB0qwFWjwCFhcEfXy01GcICH17vr9X+dyNgNhZThSyDlkSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387516; c=relaxed/simple;
	bh=/G8Iqs37GBkAK8vaiUnABP6RyRoopeVwYPON1UATVTY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g9yoR9QRNbOM+rIWD8iBGANrlsikmt/R9LD7Ud1lGLt1XAtEEoOCSHRTE+O3yvXORaidQCchv7pZgOeIe84FBj0PpSdWJdEPdaZUZ7NzchM6nsLzQbXGvbnby7xrBMUCktRCFHy3ZLwAMDE0EKxZk+7UbYOb6HjM3krFbxxhWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rBUtUvDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321EBC072AA;
	Wed, 17 Apr 2024 20:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713387515;
	bh=/G8Iqs37GBkAK8vaiUnABP6RyRoopeVwYPON1UATVTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBUtUvDbl6UG7yzmVQ/iST5gWFzeywD71GRe/vy5OKwwcg2ABLJWukkjQRMOaoVTx
	 5vHYLMtglr/LdvnhQ/u3LOx/c751i0tXzUvhyw0UNwcmksDAles2E2TIXrHo8eBOyI
	 9FVxZ0s/dvkB3WFAJbPeEXc/aS7aYLHq4ug/dTpc=
Date: Wed, 17 Apr 2024 13:58:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, David Hildenbrand
 <david@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, loongarch@lists.linux.dev,
 llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>, WANG Xuerui
 <kernel@xen0n.name>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] LoongArch/tlb: fix
 "error: parameter 'ptep' set but not used" due to __tlb_remove_tlb_entry()
Message-Id: <20240417135834.ddaa9c038a8a8af2bd9e39aa@linux-foundation.org>
In-Reply-To: <CAAhV-H5mt0GaaZ3s44CYb4aKqYeDYm+Q16hY__FdQ6xYJh+bgg@mail.gmail.com>
References: <20240416144926.599101-1-david@redhat.com>
	<CANiq72kACt+FfeYXJxfQpmGH=uPqkDA0oprfnebw52VSKyn7kQ@mail.gmail.com>
	<CAAhV-H5mt0GaaZ3s44CYb4aKqYeDYm+Q16hY__FdQ6xYJh+bgg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 11:18:27 +0800 Huacai Chen <chenhuacai@kernel.org> wrote:

> On Wed, Apr 17, 2024 at 3:25 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Apr 16, 2024 at 4:49 PM David Hildenbrand <david@redhat.com> wrote:
> > >
> > > With LLVM=1 and W=1 we get:
> >
> > Hmm... I didn't need W=1 to trigger it (LLVM 18.1.2).
> >
> > > Reported-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> >
> > Thanks, looks good to me -- built-tested:
> >
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> > Tested-by: Miguel Ojeda <ojeda@kernel.org>
> >
>
> Queued for loongarch-fixes, thanks.
> 

(top-posting repaired so I can sensibly reply to this.  Please avoid
top-posting!)

I'd rather carry this in mm.git with your ack please.  Otherwise mm.git
won't compile without it and if I retain this patch we'll get
duplicate-patch emails from Stephen and I won't be able to merge
mm.git's mm-nonmm-stable tree into Linus until loongarch-fixes has
merged.


