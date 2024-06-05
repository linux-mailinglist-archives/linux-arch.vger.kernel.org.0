Return-Path: <linux-arch+bounces-4701-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B790C8FC283
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 06:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E73371C2243A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 04:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8760263;
	Wed,  5 Jun 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDU30quT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C9433A9;
	Wed,  5 Jun 2024 04:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717560125; cv=none; b=ajc+sLQDAwuS7pnrRqBXvwVG2WJgdFsOLQxsTZQwuK+E5xOh0R1zKU0sk7LbQ1gh1IFT31Cbk8+vk+7bjGLAfAq1cIiD0Gr2FJHz6GXuLrIFIZQarZ4oZfh+b4SOoX6MIAKaStqmcrVqgoABN7G6wzfOoh+xSaMMqZzfDsiCjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717560125; c=relaxed/simple;
	bh=+XQEOkXmV5hn4UC+G5i97SUwBpiYoem3hsNIoHl3mw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRSUoahX4FFNWIehkQ2hMwz3iPdGeMNb302/7adVKZFirEnp3pkn9XU/vzVp+1uk8+sdOW/ffqPB9DgXKgZlLs3Hsc30QOeEJBK/WE51Q8Smi5e31k9TE3BaCwVaCw7YOSZjw5sd7R1v+B6fvPa1PjlDnCB11mZbsjBY1L22ews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDU30quT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B0EC32781;
	Wed,  5 Jun 2024 04:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717560125;
	bh=+XQEOkXmV5hn4UC+G5i97SUwBpiYoem3hsNIoHl3mw8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZDU30quTcsGgh3cHs5tZpPziTJhLGyG9dh9DosNLXDocsIqAWn18XuI1tDyU+oRbg
	 JPaI85xYtEOs5WPvaSkPnfnrOSoNZaevz2BQXwjB5oScbyBkSFGQwKZknHg2mdR0pk
	 DHdwnEE+QFgiZKsLpu4OWLHusRfwIhXde/qgjXjzm3eJndxdNypcx6okyzdimsEo+V
	 dXq9pzcTXxtJzAEP2DYV/iUTvNg/ul8aMSy25J8BISpOQv5SLq0pK1un/Gk0kIrM9l
	 BCLbiK3wNfxJk9nPraBYobUsEgWz0E501sTig0P+5CsR8zYptMquQCpLIb+2+xE+Li
	 qTbimaH4xv9Mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BDF70CE3ED6; Tue,  4 Jun 2024 21:02:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 21:02:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	Marco Elver <elver@google.com>, Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
Message-ID: <f11f7230-7c16-45a3-83be-9aba32e10a3b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop>
 <20240604221419.2370127-3-paulmck@kernel.org>
 <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fa4660-b3bf-4d09-bbad-064f9d4cc727@gmail.com>

On Wed, Jun 05, 2024 at 10:57:27AM +0900, Akira Yokosawa wrote:
> On Tue,  4 Jun 2024 15:14:19 -0700, Paul E. McKenney wrote:
> > Add a citation to Marco's LF mentorship session presentation entitled
> > "The Kernel Concurrency Sanitizer"
> > 
> > [ paulmck: Apply Marco Elver feedback. ]
> > 
> > Reported-by: Marco Elver <elver@google.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> 
> Paul,
> 
> While reviewing this, I noticed that
> tools/memory-model/Documentation/README has no mention of
> access-marking.txt.
> 
> It has no mention of glossary.txt or locking.txt, either.
> 
> I'm not sure where are the right places in README for them.
> Can you update it in a follow-up change?
> 
> Anyway, for this change,
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Thank you, and good catch!  Does the patch below look appropriate?

							Thanx, Paul

------------------------------------------------------------------------

commit 834b22ba762fb59024843a64554d38409aaa82ec
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 4 20:59:35 2024 -0700

    tools/memory-model: Add access-marking.txt to README
    
    Given that access-marking.txt exists, this commit makes it easier to find.
    
    Reported-by: Akira Yokosawa <akiyks@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
index db90a26dbdf40..304162743a5b8 100644
--- a/tools/memory-model/Documentation/README
+++ b/tools/memory-model/Documentation/README
@@ -47,6 +47,10 @@ DESCRIPTION OF FILES
 README
 	This file.
 
+access-marking.txt
+	Guidelines for marking intentionally concurrent accesses to
+	shared memory.
+
 cheatsheet.txt
 	Quick-reference guide to the Linux-kernel memory model.
 

