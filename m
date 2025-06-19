Return-Path: <linux-arch+bounces-12408-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF90AE0CBF
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C021C234FA
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5682F5491;
	Thu, 19 Jun 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="GYUwGMt+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC972F4A16
	for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356301; cv=none; b=lB7I+nnOg4qMQ8CkZTyqIlGjA/rsZ2ZyW5+rx3mPqPTWn4/zQZ2PVjw2+qK0da3t8LefZp7CtY2WGaCnOXzO7ng6bpQNwClrAoAV/+rMyPYYin/fUJoe/U4MXItuylcFtNCzjiedtFJE6kO3xF+7utV2mwY2ah53YVRBjsOlxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356301; c=relaxed/simple;
	bh=1dJVx9uawlA9hJYDvC4nybtTSvTD1cO2bZ9M1c+EVuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvFzTLM670UkX0+A/SF0GGPsjdrukoI/wXIJKBE+lW4zTihzjKk/8DOA/Bbyu2AeBmMtAtAd8BaNY+TOtGsQZ+N/+cfolN1cfox62G/oDwHEIvtbyvxBqEMCdKDfpgLYFdPC8PyuwNNDD7JUMCQ+tzQnGPG4RUdg/8CWpHaO1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=GYUwGMt+; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad3400ea3so9976946d6.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Jun 2025 11:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1750356297; x=1750961097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju0rK1YrXezG8RMPatgIQGMIY6rdX0cs7akdNztgfu4=;
        b=GYUwGMt+Me/R2P1+TrGCqwGFsiJmYOM240kgzncIKaBqh85tQJh2KwK4INZBUlLM0v
         GYf/DgQMZEaSpBRhzk6jUIdvahCLK9PZOfI9xOl4VaAnHMeK7mrmEblsTAwrghk72j0k
         HP8ZqQM8llTy9iTBykYLa5csHFj/3AJLaIDL+QsXRrWAuRMYdDVGcejlmWryKy3OoRoS
         x+sbMxdpNrdgxxgwXbbcpbD01xyQfqMYSnV9z2TC+/ZnLkLEmqMMTC2T73wklHCNdKAr
         9PlY1bDWrtaJBWum/87pmoK9ivqYCMgXLwfOb7H+jD30LFc7Mw1TVCyhEkdwET9x5bNq
         RdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750356297; x=1750961097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju0rK1YrXezG8RMPatgIQGMIY6rdX0cs7akdNztgfu4=;
        b=B04yqqCo8t/a/L7jqLHqVcs+GktmGeU9KFKkroNWBHgiOG64x8zGn57zKK121FhjRI
         qTsxr1RsUDig2J7nwvsDjFKfx+lkUnQoH8DxU8nlGPwhv1/bKjClCwTxMbNdWKTSqZUZ
         I+d7jgAnAeViX2wwSLLAwvb6krXS8u3/ObrU1sDcnx3UCQmQelkRTvv+BEXR2JRGPZca
         DDovisH6LEeUQ2P5AXigcH6PmB1YyFiEXLJ2XjH95+xSF3zANXihQXx200oRcIq+qs51
         SWn03cL5ZijsoOaYTnsg+VJg6xaLO+HZ4NfRT40JzH2RRjG4HZI50kv0I0vyjSO4TlFk
         AHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqnOsFlgvxG/tjSJagsPnPvUaWd0h8CbkcEgmsAmDJpHkmbzZStVz72CR8YJ5FS6pVms7ocTsy1vo8@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsNqiGmjPgYZukgczX4XfyH4rEcDQ8oSklWawz/JNMpO18T1w
	r0pyLC18JlUi2psqYgzOrU8T0YUVtB7/SaZ/xzo4bfd0Xsiu9vvp0td/bUUzab6q1w==
X-Gm-Gg: ASbGncvgRNEUXoWLKUGZ8ObesiapLPwnJoezeA7+P0xOsFm2F1tsoKBIeDH07iBeflU
	NKtzgrtEuj9LaRd+D8JfvJ0lod3rc60ax+5c2SgUo3ziWlJPfaqqrVrRXZEmgeiLZ+oZRkhhL2W
	qYX/1xa0DdBz6X5RDaVL6hkywy8fOYmI6qDPC9/IJwBrcG2uLKSahbgWCuERU/xo4D37csoaNxi
	WVKE2YRBhjHAEV2vilh4qibm6Yqbj3t679cp6Z39HCuD+tGrh0oQvcj368yT8MDKcqAQA3mUtJK
	qWElpFHdWWubzuC/wcBL27Bp1+Bq/15WdZEi8ytkxyMw1zh8JYB34iL9uaLQtBk=
X-Google-Smtp-Source: AGHT+IHYQPCClOz6CKzGdC08frCU41q/Xam4KfyuktRr18N70eT9mCmlX3M2z1ua5tmNIo2PbaShTw==
X-Received: by 2002:a05:6214:4598:b0:6f8:a978:d46 with SMTP id 6a1803df08f44-6fd0a49c0e7mr3871256d6.19.1750356297608;
        Thu, 19 Jun 2025 11:04:57 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::9ca8])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09544e75sm2440186d6.70.2025.06.19.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:04:57 -0700 (PDT)
Date: Thu, 19 Jun 2025 14:04:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <d84ae4de-3fde-4097-a42b-9dec0902f27d@rowland.harvard.edu>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
 <aFQQuf44uovVNFCV@Mac.home>
 <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>
 <aFQmDoRSEmUuPIQG@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQmDoRSEmUuPIQG@Mac.home>

On Thu, Jun 19, 2025 at 08:00:30AM -0700, Boqun Feng wrote:
> Make sense, so something like this in the model should work:
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index d7e7bf13c831..90cb6db6e335 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -27,7 +27,7 @@ include "lock.cat"
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
> +let po-unlock-lock-po = po ; (([UL] ; (po|rf) ; [LKR]) | ([Release]; (po;rf); [Acquire & RMW])) ; po
> 
>  (* Fences *)
>  let R4rmb = R \ Noreturn       (* Reads for which rmb works *)
> 
> 
> although I'm not sure whether there will be actual users that use this
> ordering.

If we do end up making a change like this then we should also start 
keeping careful track of the parts of the LKMM that are not justified by 
the operational model (and vice versa), perhaps putting something about 
them into the documentation.  As far as I can remember, 
po-unlock-lock-po is the only current example, but my memory isn't 
always the greatest -- just one reason why it would be good to have 
these things written down in an organized manner.

Alan

