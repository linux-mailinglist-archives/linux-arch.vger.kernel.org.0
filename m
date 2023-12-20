Return-Path: <linux-arch+bounces-1143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC781A759
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 20:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6461D2862F0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 19:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704B48780;
	Wed, 20 Dec 2023 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c3l/w81O"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2048482F8;
	Wed, 20 Dec 2023 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uSs9ugn4xX2syOMWcNQR3J7dtI3OSeKcZNKPuVvX3e4=; b=c3l/w81OMzy6jVcp2UuJtQ47AU
	5qZofDQgBokGRMTk0plHbY9mKYht878jdPOgiQhPZ3A22yZ4qKmtJ6M4PExkDTnMeyi4NOfP8UgbL
	5A+jvoS+GNRtZvTTJVuyfNyVJqYXOkB7JZsV9T4S2yW/kiQC6kbEp20sBdtS3reKp137yft3bfuKQ
	mYrkrz57/+u0eh4y5ezdr60oWaNlJD0IZ49TT2HZx74+XtijHPaOTVAljIDP9nxqFbQy7nDh0P8OQ
	Usw8gDGJT8VZlomBzwcGXlbfZi1TFrBZF6WOSl+utu3FZdnWeIw3u+tCOFnVbmsubfC9h/d2GsC8y
	vGQ20Ycw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rG2Qe-000mTL-1b;
	Wed, 20 Dec 2023 19:40:28 +0000
Date: Wed, 20 Dec 2023 11:40:28 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: deller@kernel.org
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] Section alignment issues?
Message-ID: <ZYNDLEzkjfrpgu7U@bombadil.infradead.org>
References: <20231122221814.139916-1-deller@kernel.org>
 <ZYIKmQj0H1YAJWlz@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYIKmQj0H1YAJWlz@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Dec 19, 2023 at 01:26:49PM -0800, Luis Chamberlain wrote:
> On Wed, Nov 22, 2023 at 11:18:10PM +0100, deller@kernel.org wrote:
> > From: Helge Deller <deller@gmx.de>
> > My questions:
> > - Am I wrong with my analysis?
> 
> This would typically of course depend on the arch, but whether it helps
> is what I would like to see with real numbers rather then speculation.
> Howeer, I don't expect some of these are hot paths except maybe the
> table lookups. So could you look at some perf stat differences
> without / with alignment ? Other than bootup live patching would be
> a good test case. We have selftest for modules, the script in selftests
> tools/testing/selftests/kmod/kmod.sh is pretty aggressive, but the live
> patching tests might be better suited.
> 
> > - What does people see on other architectures?
> > - Does it make sense to add a compile- and runtime-check, like the patch below, to the kernel?
> 
> The chatty aspects really depend on the above results.
> 
> Aren't there some archs where an unaligned access would actually crash?
> Why hasn't that happened?

I've gone down through memory lane and we have discussed this before.

It would seem this misalignment should not affect performance, and this
should not be an issue unless you have a buggy exception hanlder. We
actually ran into one before. Please refer to merge commit

e74acdf55da6649dd30be5b621a93b71cbe7f3f9

  Luis

