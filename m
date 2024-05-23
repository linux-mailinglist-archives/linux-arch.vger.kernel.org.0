Return-Path: <linux-arch+bounces-4507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C008CD815
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 18:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3E1F229FC
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2024 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADD14A82;
	Thu, 23 May 2024 16:05:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4FD4A1173F
	for <linux-arch@vger.kernel.org>; Thu, 23 May 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480359; cv=none; b=oziBeJnixmkRYwumQSuIVu41dmbCLZWxc1BZ/IdbSHsCbGkZBR7QBbeowyNqXL//RX6EOyHkJ6Uj30OlfgpHD4H++fhQQBJn9n76ZQgDu21qq+hOCa96TVZYATX/9/c7CciAlz+totuACBh7SOWbsNm7LBHGa3jo31BsKCNmI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480359; c=relaxed/simple;
	bh=FAOMe+aep0lPGuVjWYzGeu3BN1Pr/SLhZKdfHzZPEiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSyZH1KIB2w2r2qd00TkYTwZ9BavYgfC9rCtud3pWqoq/l/Oq7bRE1GuAUjd/1sLdKIlGiemIWgIZJ3kLmijmVReh+b6dgEykOZ06/mYMmzp/wDm06qamKQogFNkz1pi8CUjQ6c7IPY3EDDj95ygQHK0Ltca36aC8amH7y3q0t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 542996 invoked by uid 1000); 23 May 2024 12:05:52 -0400
Date: Thu, 23 May 2024 12:05:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
  "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, kernel-team@meta.com, parri.andrea@gmail.com,
  boqun.feng@gmail.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  Joel Fernandes <joel@joelfernandes.org>
Subject: Re: LKMM: Making RMW barriers explicit
Message-ID: <adc97697-9a71-4ec8-a9fa-1558a7a1d181@rowland.harvard.edu>
References: <e030f7a4-97e7-4e91-bbae-230ee5c97763@huaweicloud.com>
 <a9bf972c-b5ee-f1c2-36bf-30ba62f419d7@huaweicloud.com>
 <2f20e7cf-7c67-4ad3-8a0c-3c1d01257ae4@rowland.harvard.edu>
 <0c309dd3-f8c1-4945-b8f1-154b2a775216@huaweicloud.com>
 <4286e5b2-5954-4c77-a815-c1c2735d9509@rowland.harvard.edu>
 <58042cf3-e515-4e5f-ab48-1d0d6123c9e9@huaweicloud.com>
 <6174fd09-b287-49ae-b117-c3a36ef3800a@rowland.harvard.edu>
 <7bd31eca-3cf3-4377-a747-ec224262bd2e@huaweicloud.com>
 <35b3fd07-fa85-4244-b9cb-50ea54d9de6a@rowland.harvard.edu>
 <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25f9654-e681-1bad-47ae-ddc519610504@huaweicloud.com>

On Thu, May 23, 2024 at 04:26:23PM +0200, Hernan Ponce de Leon wrote:
> On 5/23/2024 4:05 PM, Alan Stern wrote:
> > Overall, it seems better to have herd7 assign the right tag, but change
> > the way the .def file works so that it can tell herd7 which tag to use
> > in each of the success and failure cases.
> 
> I am not fully sure how herd7 uses the .def file, but I guess something like
> adding a second memory tag to __cmpxchg could work
> 
> cmpxchg(X,V,W) __cmpxchg{mb, once}(X,V,W)
> cmpxchg_relaxed(X,V,W) __cmpxchg{once, once}(X,V,W)
> cmpxchg_acquire(X,V,W) __cmpxchg{acquire, acquire}(X,V,W)
> cmpxchg_release(X,V,W) __cmpxchg{release, release}(X,V,W)

Right, except that the last two should be:

cmpxchg_acquire(X,V,W) __cmpxchg{acquire, once}(X,V,W)
cmpxchg_release(X,V,W) __cmpxchg{release, once}(X,V,W)

Alan

