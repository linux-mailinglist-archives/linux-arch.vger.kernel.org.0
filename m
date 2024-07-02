Return-Path: <linux-arch+bounces-5219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B67E923F71
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 15:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1B7B20F95
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0C1B4C4B;
	Tue,  2 Jul 2024 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYks3CBj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD038F83;
	Tue,  2 Jul 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928122; cv=none; b=kSRALYIPmiFHyC1jr5ZVW8abBNmRrPvrVjtC3p/d4Vel/IbnV/y/qajHZa/kbmrBU8hzorMbRqP32Z6zB92B/dPuurdWwW1kN72kMgYVtNhFAMJRbfn+Tnm0tb+/Ov4i/bIuC9e77NTprZ1pEwLDLOIs8MckVRoggpfBNJyRZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928122; c=relaxed/simple;
	bh=gYjYJ1OgYyhZTiauU4B6L9oZe5HyqLXMnZR8R5ZoXPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJtOW4PkHMDEzwBsz6yqfMv0Te4Rm1tVUqH90DYx3FtLbaTvCGH4xfjuF/eCyAvs330DM9v/t7HZpEv15XVnM/R8SIien0jTAhsEN0/NlRCts9OPIqggOCr4aaHEDIIPGyR9wdmhG4zBchefb8So7BVRKupwK4y22HCDt+VjTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYks3CBj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d05e0017aso2031970a12.1;
        Tue, 02 Jul 2024 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719928119; x=1720532919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uY8L79zbQzX7wy4EzRLq4zwsFLBRGIqHhWkg0JBx8g=;
        b=TYks3CBjZKenkli2733LOJolsg1OASksRjklcykFJT1NR5UaeHbg2hI0WP0iTzxWmZ
         Zqr0Ib7Aa2aldwSjpZN56TyuodaAXI2VhS0ioMu5McIFxe9xP3ZqLE9HfAybSplKu0ZK
         j0L9EWK+7okd8X8E0SHJcOwqWKqXbuklDa2qaF7vq1h1Wv8Q/qSk1vCJ4KZZ4UcY3bRy
         po2GOm5bwQpAf2oxDptGSuEACtSpgmxCZYrxn09AxyJ9HUT5d4+DdEzmiqLMW9sQi4D8
         eD2ffw7Pr7CrIruw7bHlGM9+JwThtoK/0ZBcBhnPwUR2Aczv8yv+0fErBxLZtGGYJ23Q
         UpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719928119; x=1720532919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uY8L79zbQzX7wy4EzRLq4zwsFLBRGIqHhWkg0JBx8g=;
        b=UiyaUeBcrxlwE68KqBi2VI3WFPj/thFLGAtO1cfe06GOZDkaBJbwjiloK1nNLrA+et
         oVdVdog5FoHC65U3zQA5BLVp9DNeIxACD3DiJJeSPhg/VFKGRe3FgeTLgo2hMF1Dxd9U
         i1QKFk8/tTNjC3a5qdOji2aEj4mrDXj7ZzkwKXgqRocoAaKHnVcdBzParAEeXyFpDuWo
         TxNTlHxOLsd4y9+Z7/RikgwSn9gNtKRdIYEtDyAjPenyxiyyuv2Ycpg9GXhHcm0BnA6J
         H/nRvsFSLPN+NqXWIzSa8XCYXDKpMAKD4HxZLeXREd/daYEUlhVlNuvnrydDgTIQNdsf
         SFHw==
X-Forwarded-Encrypted: i=1; AJvYcCXwHMLIhiPvx/mphKjxhchitqgZ2DCBbl684Bk6HmkaXtJaIHQnxHb6tIdlv2OGoEOwsmWJ+7V4+ZtUzuAXBO22aZynKCNZ3/qN3REXRF1HuU378p1luITvpOCvAS9TEYPFZT/D58nBbA==
X-Gm-Message-State: AOJu0Yxv/itFI5HZZHx9zhkkL/zjiU1dSF8zBpS2NwpWwhdUY/0FIdie
	JRGq/Ozc1L7gjqsCHTMJA7ttXOYGzuaFqKUKtsDP8abpm+nbuFdAkaeFfVFP
X-Google-Smtp-Source: AGHT+IGQR5VjOzPpYggfc7lhuX3McNtnH1SFl+sf9EngMRwi+OmLJSDiMMUyGUe16w4yndNpRc//AA==
X-Received: by 2002:a17:907:7ea3:b0:a6f:6aa3:e378 with SMTP id a640c23a62f3a-a751443872emr746830566b.38.1719928119006;
        Tue, 02 Jul 2024 06:48:39 -0700 (PDT)
Received: from andrea (host-87-20-14-123.retail.telecomitalia.it. [87.20.14.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18508sm423015466b.32.2024.07.02.06.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:48:38 -0700 (PDT)
Date: Tue, 2 Jul 2024 15:48:34 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH lkmm] docs/memory-barriers.txt: Remove left-over
 references to "CACHE COHERENCY"
Message-ID: <ZoQFMqkRMDEZdvpa@andrea>
References: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5866a20e-4b36-4eb9-b589-8135f86ceb6a@gmail.com>

On Tue, Jul 02, 2024 at 08:42:44PM +0900, Akira Yokosawa wrote:
> Commit 8ca924aeb4f2 ("Documentation/barriers: Remove references to
> [smp_]read_barrier_depends()") removed the entire section of "CACHE
> COHERENCY", without getting rid of its traces.
> 
> Remove them.
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Will Deacon <will@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

