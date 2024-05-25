Return-Path: <linux-arch+bounces-4540-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147B8CF11C
	for <lists+linux-arch@lfdr.de>; Sat, 25 May 2024 21:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28801C2099E
	for <lists+linux-arch@lfdr.de>; Sat, 25 May 2024 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C06127B4D;
	Sat, 25 May 2024 19:37:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0C27854BE7
	for <linux-arch@vger.kernel.org>; Sat, 25 May 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716665843; cv=none; b=TYOcn1vixsVqIKQGcewzLlRNPls06RAwd2s0Nzmev0/ZmNpmbzogeMSlZ7tek14pz2LbO0sq+18xWUtmPiRiWMo2EkDO35sX7z/PmRPdEy7n/K5nZhHCx2rvueWp0NUPrQBJEWF7xq3d6+pGqN7MXoW+ryH1/ifJu9V7/+LCT78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716665843; c=relaxed/simple;
	bh=RiQOK8BJS10Xc4xLKZaufd84Et5CSNC4fnnN9TgwzZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM/DbGGNnGoiSlo2+tNH8NfRhqVp3U98cyHWDZyNU9F8CHtBpfHTd//4dd1ESHbQVnOeKZ2u2oXCpprTElTqSdOVmIvkFAESXGalob1CIx0kXwV0gB0QNXHPQSGCs5n9wQtNkz7IfxQiEV25puEaZKtmtaSIZUkOXU+iB/OiStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 613412 invoked by uid 1000); 25 May 2024 15:37:19 -0400
Date: Sat, 25 May 2024 15:37:19 -0400
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
Message-ID: <cf81a3c2-9754-4130-a67e-67d475678829@rowland.harvard.edu>
References: <20240524151356.236071-1-parri.andrea@gmail.com>
 <ZlC0IkzpQdeGj+a3@andrea>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlC0IkzpQdeGj+a3@andrea>

On Fri, May 24, 2024 at 05:37:06PM +0200, Andrea Parri wrote:
> > - While checking the information below using herd7, I've observed some
> >   "strange" behavior with spin_is_locked() (perhaps, unsurprisingly...);
> >   IAC, that's also excluded from this table/submission.
> 
> For completeness, the behavior in question:
> 
> $ cat T.litmus 
> C T
> 
> {}
> 
> P0(spinlock_t *x)
> {
> 	int r0;
> 
> 	spin_lock(x);
> 	spin_unlock(x);
> 	r0 = spin_is_locked(x);
> }
> 
> $ herd7 -conf linux-kernel.cfg T.litmus
> Test T Required
> States 0
> Ok
> Witnesses
> Positive: 0 Negative: 0
> Condition forall (true)
> Observation T Never 0 0
> Time T 0.00
> Hash=6fa204e139ddddf2cb6fa963bad117c0
> 
> Haven't been using spin_is_locked for a while...  perhaps I'm doing
> something wrong?  (IAC, will have a closer look next week...)

It turns out the problem lies in the way lock.cat tries to calculate the 
rf relation for RU events (a spin_is_locked() that returns False).  The 
method it uses amounts to requiring that such events must read from the 
lock's initial value or an LU event (a spin_unlock()) in a different 
thread.  This clearly is wrong, and glaringly so in this litmus test 
since there are no other threads!

A patch to fix the problem and reorganize the code a bit for greater 
readability is below.  I'd appreciate it if people could try it out on 
various locking litmus tests in our archives.

Alan


---
 tools/memory-model/lock.cat |   61 +++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

Index: usb-devel/tools/memory-model/lock.cat
===================================================================
--- usb-devel.orig/tools/memory-model/lock.cat
+++ usb-devel/tools/memory-model/lock.cat
@@ -54,6 +54,12 @@ flag ~empty LKR \ domain(lk-rmw) as unpa
  *)
 empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
 
+(*
+ * In the same way, spin_is_locked() inside a critical section must always
+ * return True (no RU events can be in a critical section for the same lock).
+ *)
+empty ([LKW] ; po-loc ; [RU]) \ (po-loc ; [UL] ; po-loc) as nested-is-locked
+
 (* The final value of a spinlock should not be tested *)
 flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
 
@@ -79,42 +85,47 @@ empty ([UNMATCHED-LKW] ; loc ; [UNMATCHE
 (* rfi for LF events: link each LKW to the LF events in its critical section *)
 let rfi-lf = ([LKW] ; po-loc ; [LF]) \ ([LKW] ; po-loc ; [UL] ; po-loc)
 
-(* rfe for LF events *)
+(* Utility macro to convert a single pair to a single-edge relation *)
+let pair-to-relation p = p ++ 0
+
+(*
+ * Given an LF event r outside a critical section, r cannot read
+ * internally but it may read from an LKW event in another thread.
+ * Compute the relation containing these possible edges.
+ *)
+let possible-rfe-noncrit-lf r = (LKW * {r}) & loc & ext
+
+(* Compute set of sets of possible rfe edges for LF events *)
 let all-possible-rfe-lf =
-	(*
-	 * Given an LF event r, compute the possible rfe edges for that event
-	 * (all those starting from LKW events in other threads),
-	 * and then convert that relation to a set of single-edge relations.
-	 *)
-	let possible-rfe-lf r =
-		let pair-to-relation p = p ++ 0
-		in map pair-to-relation ((LKW * {r}) & loc & ext)
+	(* Convert the possible-rfe relation for r to a set of single edges *)
+	let set-of-singleton-rfe-lf r =
+		map pair-to-relation (possible-rfe-noncrit-lf r)
 	(* Do this for each LF event r that isn't in rfi-lf *)
-	in map possible-rfe-lf (LF \ range(rfi-lf))
+	in map set-of-singleton-rfe-lf (LF \ range(rfi-lf))
 
 (* Generate all rf relations for LF events *)
 with rfe-lf from cross(all-possible-rfe-lf)
 let rf-lf = rfe-lf | rfi-lf
 
 (*
- * RU, i.e., spin_is_locked() returning False, is slightly different.
- * We rely on the memory model to rule out cases where spin_is_locked()
- * within one of the lock's critical sections returns False.
+ * Given an RU event r, r may read internally from the last po-previous UL,
+ * or it may read from a UL event in another thread or the initial write.
+ * Compute the relation containing these possible edges.
  *)
-
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
-		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+let possible-rf-ru r = (((UL * {r}) & po-loc) \
+			([UL] ; po-loc ; [UL] ; po-loc)) |
+		(((UL | IW) * {r}) & loc & ext)
+
+(* Compute set of sets of possible rf edges for RU events *)
+let all-possible-rf-ru =
+	(* Convert the possible-rf relation for r to a set of single edges *)
+	let set-of-singleton-rf-ru r =
+		map pair-to-relation (possible-rf-ru r)
+	(* Do this for each RU event r *)
+	in map set-of-singleton-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru


