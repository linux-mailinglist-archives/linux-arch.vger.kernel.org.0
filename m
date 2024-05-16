Return-Path: <linux-arch+bounces-4442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A818C7017
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 03:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4E0B2282D
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C49137E;
	Thu, 16 May 2024 01:43:26 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EEAD3110A
	for <linux-arch@vger.kernel.org>; Thu, 16 May 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823806; cv=none; b=LQiHCRD6OkdSwaXMFBVpbbnlyia6xKUeVXXXRWJ/yuz+wIKKcruX3nO+ClyQM76xps6laQ5cfQD9jmdJ3p9taLW/b+Fj9JIrS5rsUHQF9XMesDfW/mKqw+9Hm8DphYLigCncZP6r4IBMJ+Kc2ZApfv+5l9z5yv6sficrXIdbVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823806; c=relaxed/simple;
	bh=aJ1HYO2k1NY8pFcW+T62qja/tqE9SP8PlX9DwyFk8VU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VO4ARn4V/JhWBeYQoBTFUVECYoYRrBJONmWkjeGNmafSt4MqdyaNrT/nB1timIT+kAXn3eiSDE193GkGd2SUWOplc7a1tpCrGJS0D0h9UVqqd/jKudVComTwuO5qBEBKEqGA9JzK56F5EJoadNZbN8iRXWskI0dr+FcMrIr8rIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 246864 invoked by uid 1000); 15 May 2024 21:43:17 -0400
Date: Wed, 15 May 2024 21:43:17 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
  Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: LKMM: Making RMW barriers explicit
Message-ID: <72c804c8-2511-4349-a823-bc1de8bb729e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hernan and Jonas:

Can you explain more fully the changes you want to make to herd7 and/or 
the LKMM?  The goal is to make the memory barriers currently implicit in 
RMW operations explicit, but I couldn't understand how you propose to do 
this.

Are you going to change herd7 somehow, and if so, how?  It seems like 
you should want to provide sufficient information so that the .bell 
and .cat files can implement the appropriate memory barriers associated 
with each RMW operation.  What additional information is needed?  And 
how (explained in English, not by quoting source code) will the .bell 
and .cat files make use of this information?

Alan

