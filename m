Return-Path: <linux-arch+bounces-5667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135C993EBA5
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C416D2840FF
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 02:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4061E49E;
	Mon, 29 Jul 2024 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="df87FzB0"
X-Original-To: linux-arch@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CA78C83
	for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2024 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221284; cv=none; b=U0tcsfoVJghNqY+GCTIAaCMOsgHVwA1SkKsY+h2FMwuVzpxES0HCtD8foMutzwexqcNSxV5cb2t9SrZe04FKoCxC3b66NaIYwztjIp6BOdzlocXF/Ni+jfYcurmEfIpZywn1J5MIR1wNNI8u3tF/8YtF8FWRMPlcxbMfWyDl+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221284; c=relaxed/simple;
	bh=Kdt6tHey8gjeuF2bi0Ivsf014EmroNcC0suQ3NvwC/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2eGBZK6GmIJXrmU1JqtiUqFzAJD6VzZVBESzZuA36gusixe+W1eq0LvpzQ5jlNZU+dpWfZNDj4njnZ7FuxiNbbavUIjW3mxzAP5kodMwI1O77bayWUBKGme/Mg6KJHznTQw1udwHclKUBje9zTr2cqzsTt0bDowbS3tVFDQdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=df87FzB0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46T2iCas021007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jul 2024 22:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722221058; bh=fZHb/SHRE/3ifgSnWXUU6RdFOsOVMjHd4oou3IInJ8M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=df87FzB0ozVVH+CgTcwMEcs4I/QMupH1v5UaCu+eKWsYipPHqwNfq+xoU+AwbmFES
	 XglYWyH2T0bqfGMKiqqb7f8BgPWc99J0X9tvy+FhESpTBF1L22xiC2FC1f446oODjt
	 iBuqmBBV3DQqo6zCK0EzNk7/t2+XUDshY7jru35GK2K9PEOXLH3OMamaNseC0BCt/d
	 /oC2H8CyBUQgK28PS9XyjbgX5JMrmtd4HLTu5K6dVVUmTuTMeWBJVJ3eXz5Hc47MNG
	 WfInu203XLvfCVgBGrYGUutstQSXJjCLXUGwtKKoa113i/ylRKEI9glPd25dXhsd7G
	 poAxlPts/cE+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D00BE15C02D3; Sun, 28 Jul 2024 22:44:12 -0400 (EDT)
Date: Sun, 28 Jul 2024 22:44:12 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Youling Tang <youling.tang@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, David Sterba <dsterba@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, kreijack@inwind.it,
        Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <20240729024412.GD377174@mit.edu>
References: <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
 <ZqPmPufwqbGOTyGI@infradead.org>
 <20240727145232.GA377174@mit.edu>
 <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23862652-a702-4a5d-b804-db9ee9f6f539@linux.dev>

On Mon, Jul 29, 2024 at 09:46:17AM +0800, Youling Tang wrote:
> 1. Previous version implementation: array mode (see link 1) :
>    Advantages:
>    - Few changes, simple principle, easy to understand code.
>    Disadvantages:
>    - Each modified module needs to maintain an array, more code.
> 
> 2. Current implementation: explicit call subinit in initcall (see link 2) :
>    Advantages:
>    - Direct use of helpes macros, the subinit call sequence is
>      intuitive, and the implementation is relatively simple.
>    Disadvantages:
>    - helper macros need to be implemented compared to array mode.
> 
> 3. Only one module_subinit per file (not implemented, see link 3) :
>    Advantage:
>    - No need to display to call subinit.
>    Disadvantages:
>    - Magic order based on Makefile makes code more fragile,
>    - Make sure that each file has only one module_subinit,
>    - It is not intuitive to know which subinits the module needs
>      and in what order (grep and Makefile are required),
>    - With multiple subinits per module, it would be difficult to
>      define module_{subinit, subexit} by MODULE, and difficult to
>      rollback when initialization fails (I haven't found a good way
>      to do this yet).
> 
>
> Personally, I prefer the implementation of method two.

But there's also method zero --- keep things the way they are, and
don't try to add a new astraction.

Advantage:

 -- Code has worked for decades, so it is very well tested
 -- Very easy to understand and maintain

Disadvantage

 --- A few extra lines of C code.

which we need to weigh against the other choices.

      	      	       	       	   - Ted

