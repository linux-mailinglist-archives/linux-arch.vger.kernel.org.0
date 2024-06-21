Return-Path: <linux-arch+bounces-4999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC02911E95
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4521F21650
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A0155C82;
	Fri, 21 Jun 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVekqMff"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF1127B5A;
	Fri, 21 Jun 2024 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958219; cv=none; b=F7bei61yQRtubjyqnHhntyClIUDjPdarHIk2aj+8cJDeCUA7tpUiE+3ZhrBwNvjPTftcjj6uXEm8XnNfWD2BQH1hwNYsMFrxl1aYsf96xIGDOxLUTEDGJMl4CbN7/o4+vxFcQYsaHqVeK/s2NnTidOh4n8qCXtZ0cCX69pfIVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958219; c=relaxed/simple;
	bh=ePrxxgryd/7FzegnkgHpqwceMtBAXBZvcz3wII1dPSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3+pCn+eGff2k/p26MKOElADsTi9jFsWlXi/rGqA+8//RgwbIE9gLmHnWhS9MPf2iWPkL7az6csh1OLDRN+epkq6E4AQMkl6qqVbSLivvYSf8+v18R0H+exLbAjNPmkDIP1gr+k2GGtGbn6+SoXjC7xyl1sCKlmEf1kyrm/FrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVekqMff; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a63359aaaa6so243183766b.2;
        Fri, 21 Jun 2024 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718958216; x=1719563016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nbBOwJgSwHet5zGetbp8psP9VLRM440EvYC4FeqP2lk=;
        b=iVekqMffl1bf9Sd6q0hIorJZfSCDw2PPUYs2t20w/5ifQG5E6EMIAtAM+lh2UbduQR
         TzK2KJOnXYf0qziHB/ZuTAV26xXeqkx+rIN0Jxb9u4RMYa7p7RxSq1VtRm1IfdhT/X+h
         APP4eRC/TgPaVvqRYPNypFOM1FbYmeFyzKUaKbd0AbMwBzrwhowgrW9oUsHKQ6+upfmG
         iGeQbvaYuZzgUuh3FrEEzVs5TpO6fQb3ONo/hX3axH0OpRZXR7UeTyUa/LUCySB1uIcH
         0VC9fqOcRZiWj0OYGlXaDGhLH0hRsHFYokDtCPocQB3KUn6GLhBdiaqkzoOg6sw6Kok5
         leSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958216; x=1719563016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbBOwJgSwHet5zGetbp8psP9VLRM440EvYC4FeqP2lk=;
        b=u8i+6D06Z0Wd/qFmp1eNbcdooTopjJIuDD4AAPF9vgWQMwNW09HkIgCmVzVTw236yG
         U2/daiWOqSHkm3gxI4clHX9dGjf/7J/tmaNaGzBGydhg7YG98SxyEkcTfjfp8U8STrG+
         UmGtgCMBq7UwtFp8OSa4XtOlGoX390ItQ4QcMOFkSyIFH4JuKArgMV5hMcNPi6fBsf6I
         P3EAOisgaAb4f5BWQwsFMyLZuJ4x/YIuMwGeLxFCuZioIl6S3Jtw6L0lZ25rEfC67LeY
         TxL39IhhiQaOiM4U2ZIf+scRHQBi49M0r5YESSG3PDIDTO80DByMvLcScXFlme0zFgAD
         OVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw8CfKRA8dqoh90awkIn2++Mud4veXsNUoZorMpk5yfmjZZa07VLydF9IMbKzGKtkQlbET2+0XgEHC8kRCXfuFusJaOv3e5jpNxPqg2aC1EBOgySwVsaM/NjQNR3scGQFW2EgrDBEWOw==
X-Gm-Message-State: AOJu0YwKEqeXXmi+p4/jeGiTGaICfV0kNAucvzFdC8onwP2axnf8cutG
	0P1ky1MFmbInGCVMwnrTcGhmwSwroLqZOW/4LhZhilS2UvqpydnO
X-Google-Smtp-Source: AGHT+IHD5G0x+UDvvWQKLy0OgQRXOfYYf+1EbCyu7B+fCvtM9QvTCKDqyhEyTIoEjpyQiNOL1W55yQ==
X-Received: by 2002:a17:906:6a15:b0:a66:c338:65cc with SMTP id a640c23a62f3a-a6fab62bbe3mr533490166b.19.1718958215296;
        Fri, 21 Jun 2024 01:23:35 -0700 (PDT)
Received: from andrea (host-82-50-195-19.retail.telecomitalia.it. [82.50.195.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf56efcfsm56550066b.200.2024.06.21.01.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:23:34 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:23:28 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH lkmm 0/2] tools/memory-model: Add locking.txt and
 glossary.txt to README
Message-ID: <ZnU4gE+OB+xvvW+I@andrea>
References: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>

On Fri, Jun 21, 2024 at 01:08:24PM +0900, Akira Yokosawa wrote:
> Hi all,
> 
> [+CC: Marco, as Patch 1/2 includes update related to access-marking.txt.]
> 
> Looks to me like Andrea's herd-representation.txt has stabilized.
> Patch 1/2 fills missing pieces in docs/README.
> 
> While skimming through documents, I noticed a typo in simple.txt.
> Patch 2/2 fixes it.
> 
>         Thanks, Akira
> --
> Akira Yokosawa (2):
>   tools/memory-model: Add locking.txt and glossary.txt to README
>   tools/memory-model: simple.txt: Fix dangling reference to
>     recipes-pairs.txt

For the series,

Acked-by: Andrea Parri <parri.andrea@gmail.com>

I do get some "trailing whitespace" warning, for patch #1, you might
want to clean up when applying/reposting the series.

  Andrea

