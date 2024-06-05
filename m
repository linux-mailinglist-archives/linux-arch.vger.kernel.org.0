Return-Path: <linux-arch+bounces-4712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95B8FD1B1
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 17:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40D81C22A29
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C18F27450;
	Wed,  5 Jun 2024 15:31:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4F74239AC3
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601514; cv=none; b=DrYCTHCtRJSq9jOGmzXGUO4Fvux/tYzDaroBBeF6ZqWEljtJrtC5RDmw8QEyyiocAZ1uoUhFbBflsL1Ed/am52TG2ynu53a4ENC7iDGHok6zI7/VzAv0I4/1q84KMlHehtxk1WtSfuH4H97m7IP9oGuY43rVLwny6R547N1oNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601514; c=relaxed/simple;
	bh=iRlfwxeaSfwteupu42k4XO0pgXSHyGiyHXTbklvGMgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4joUcwQgAXUh7mVglqT5K0DAWn2SdysejYpsyhEWoE3XtZvt9akR/y1jTUqtAOEj8LLI7McfdbkbBrgiB1m0MJhxDeUbxlnXCANVph/jab0NQ2IB/EmiqwnEbJ4tySj1ccyo9aBSgi0HHURxdzAE9uH5MS6fnXmWDPW2lF+E0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 200282 invoked by uid 1000); 5 Jun 2024 11:31:51 -0400
Date: Wed, 5 Jun 2024 11:31:51 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
  npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
  luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
  dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH] tools/memory-model: Document herd7 (internal)
 representation
Message-ID: <28bdcf4c-6903-4555-8cbc-a93704ec05f9@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
 <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
 <ZlQ/Ks3I2BYybykD@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ/Ks3I2BYybykD@andrea>

On Mon, May 27, 2024 at 10:07:06AM +0200, Andrea Parri wrote:
> > It turns out the problem lies in the way lock.cat tries to calculate the 
> > rf relation for RU events (a spin_is_locked() that returns False).  The 
> > method it uses amounts to requiring that such events must read from the 
> > lock's initial value or an LU event (a spin_unlock()) in a different 
> > thread.  This clearly is wrong, and glaringly so in this litmus test 
> > since there are no other threads!
> > 
> > A patch to fix the problem and reorganize the code a bit for greater 
> > readability is below.  I'd appreciate it if people could try it out on 
> > various locking litmus tests in our archives.
> 
> Thanks for the quick solution, Alan.  The results from our archives look
> good.

Here's a much smaller patch, suitable for the -stable kernels.  It fixes 
the bug without doing the larger code reorganization (which will go into 
a separate patch).  Can you test this one?

Alan



Index: usb-devel/tools/memory-model/lock.cat
===================================================================
--- usb-devel.orig/tools/memory-model/lock.cat
+++ usb-devel/tools/memory-model/lock.cat
@@ -102,19 +102,19 @@ let rf-lf = rfe-lf | rfi-lf
  * within one of the lock's critical sections returns False.
  *)
 
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
+(*
+ * rf for RU events: an RU may read from an external UL or the initial write,
+ * or from the last po-previous UL
+ *)
+let all-possible-rf-ru =
+	let possible-rf-ru r =
 		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
+			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
+	in map possible-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru


