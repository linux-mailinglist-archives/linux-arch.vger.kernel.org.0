Return-Path: <linux-arch+bounces-4276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B68C0544
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113161F21CBD
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB9128829;
	Wed,  8 May 2024 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIHesTbH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24944316A;
	Wed,  8 May 2024 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715197796; cv=none; b=FlJ7cqOBva2EejuZbzm4mmWDyqn8NNmwDWpw2iPjMHa1n7c3pgdsv9buwRDt6wikmqwdZ/84fpUOjQ1umkZtLziM1I+70yzfQMLt6WX57d9VWfof4o2ueOSrUJMYlMRk/HiPsv26+shoNBlC/tPxzzaxuG38o3LonS9O0/PjPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715197796; c=relaxed/simple;
	bh=0xmgJhVJefdoBl8v4cz1CxG3Tb76dy/UQNKncMchWE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me7t6TNYQX/jpktADrRUQUqfsA9Shg7oZxlnZ+Apr0CFghZkEjL9VxJLJeE035fpzm+Mdw8HeGX5aHnPfvKXdQc7D76SmX8+xjTyvrbbyFL8VaRqx3OGfWOuQj9b2U5U8f4SHNNoSJLn9SBPT+376RSEPpYjth6/gRAsFH+0b20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIHesTbH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61be4b986aaso1326977b3.3;
        Wed, 08 May 2024 12:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715197794; x=1715802594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIRuwcchnty1CBuL+Q3afkKdUuWXmceqML8Qpq5pbYU=;
        b=eIHesTbHJVnoyTNAK5VGgI9kLUwW2/WvJ/Lo6dHyiVTGz++zcgymQFS/gF7vf96nDg
         LFOQJh2RI2QVY/J4GuuenSQp608pG02m4TirXqWk/EIrveRj4nCI2lldM8XAvKo2kNwu
         3P3PqrFx5tD59e2FuP9KF9eMvqfi0R+orQ9D+M4vrUMdoi0M+7BUcDphiV3PuZk6KHOu
         HQRhKtRw4oyCI0AgicFEy7lrPMxkkS7ixxwhkab9tq7ATqxIu1dSYoIuPllia956D5g0
         hV/ZFTx67hawTA/jSkoUxDKQNdrWcccWBT2hmxE5YEiPf3xjq/VHIu/fWiqgG1GQop2r
         MMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715197794; x=1715802594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIRuwcchnty1CBuL+Q3afkKdUuWXmceqML8Qpq5pbYU=;
        b=A0uSR/f3Fwq5nR7Z00XFNvGBK3ra1sdP8azQkbRtSTYNuU20lVTlT49ZVbkA6vzCe9
         h0ysTAWeE5E5a/wk8ZHUv922lcqW0t2gwR4x/MI737J8zw1Lsmc6Z2UmctV5iwWkOx1m
         yW4jFsroHlA+JkY4O16yxgaFMQdxwfgGrLpMNN2X3adwvsGgw+sY95fRaj9HyWsLecqt
         P9COH/edjbQwuC/zMZ9CVuM+srls+xPh/W5XOrNYTffbCT+O6UG6xyQg1rpxWBiz8a7R
         +krukvh8+lk5j2Welop/sAh0lZ+UMmxpUfJxr9MA3Y5P0+Z8H7OH63NYzQszK77ciuVu
         sk5g==
X-Forwarded-Encrypted: i=1; AJvYcCWOJmWuk3QXpfjH/8Hp7mz7zxHsfz19sXApo9QJj1QBF4vTJ3t6pO5S/23fJEoMM+TOIKP1vzFCYtqR6IxCSJbp7ktML/e7vKYF9JYpRdlCVe8VldOwp8L15Eaip4aRRePIKgxRzmLn+w==
X-Gm-Message-State: AOJu0YwjJSgMKPFulpf2PTaLtJcKahGgyDGv0cYyqQONDva0UMAIuD5B
	SzP6BdIxOMLEeiygFEwPur24NilFQl9HLw3RSOszupTzW1VKVT+w
X-Google-Smtp-Source: AGHT+IFwO0FyIJvVWNl0UqGgCCFzwcaJB0ZKyEFT++ojhLJS6Y5XTFAReSN5anka0OQ362pgL2zXrA==
X-Received: by 2002:a0d:ccd4:0:b0:61b:748:55a1 with SMTP id 00721157ae682-62085a6a59dmr41813767b3.13.1715197793766;
        Wed, 08 May 2024 12:49:53 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id hf23-20020a05622a609700b0043d1fc9b7d9sm5575791qtb.48.2024.05.08.12.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:49:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B0C9D1200032;
	Wed,  8 May 2024 15:49:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 15:49:52 -0400
X-ME-Sender: <xms:YNc7ZgZPQdPj7pjhJGVL2QlHB-N3Jgw8QoP5f5ByyeOhU1NUpZlCZA>
    <xme:YNc7ZrYlTPWTeQwx3r5Nu71jcMdjDCK9bopV7HazUoicsPEBExTs5Z4KPBdStiO7t
    fR8jej64X84XpS0vg>
X-ME-Received: <xmr:YNc7Zq_qdWrTfZa4PtcCADweiOY74IvgMSapKnNdWhpPIllaxJgT3iSXDZX3aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffdtiefhieegtddvueeuffeiteevtdegjeeuhffhgfdugfefgefgfedt
    ieeghedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:YNc7ZqqSRaXsesu2Eq2zHFDnCXP_Lw8y3ndvQMu_Z0u7XrvP3KaC6g>
    <xmx:YNc7ZrryX71zZ2nfoI3TYKIojAl4bUJ0mJ0-ZHqWpKH82FFC0xs-zA>
    <xmx:YNc7ZoQRTGZlXlJzesz3i60nJ70diqWrO3ts7wwFHXNM_wfUu811_g>
    <xmx:YNc7ZrqebfZ-x90UsThWqNVa0DpXfWGsPTAHaQZTi4gGqOHfUKxR1Q>
    <xmx:YNc7Zg5-cBFe4JB-rDujAaWmHc_FXkLwJ_S_kqQQ0g2ZRGhMeNqqS7Kw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 15:49:52 -0400 (EDT)
Date: Wed, 8 May 2024 12:49:57 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and
 add_negative
Message-ID: <ZjvXZZiew_shyQA3@boqun-archlinux>
References: <20240508143400.36256-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508143400.36256-1-puranjay@kernel.org>

On Wed, May 08, 2024 at 02:34:00PM +0000, Puranjay Mohan wrote:
> Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> atomics operations.
> 
> Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> all their ordering variants.
> 
> atomic_add_negative() is already available so add its acquire, release,
> and relaxed ordering variants.
> 
> [1] https://github.com/herd/herdtools7/pull/849

A newer version of herd is required for this feature, right? So please
also do a change in tools/memory-model/README "REQUIREMENTS" session
when the new version released.

Needless to say, this patch looks good to me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/memory-model/linux-kernel.def | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> index 88a39601f525..d1f11930ec51 100644
> --- a/tools/memory-model/linux-kernel.def
> +++ b/tools/memory-model/linux-kernel.def
> @@ -65,6 +65,9 @@ atomic_set_release(X,V) { smp_store_release(X,V); }
>  
>  atomic_add(V,X) { __atomic_op(X,+,V); }
>  atomic_sub(V,X) { __atomic_op(X,-,V); }
> +atomic_and(V,X) { __atomic_op(X,&,V); }
> +atomic_or(V,X)  { __atomic_op(X,|,V); }
> +atomic_xor(V,X) { __atomic_op(X,^,V); }
>  atomic_inc(X)   { __atomic_op(X,+,1); }
>  atomic_dec(X)   { __atomic_op(X,-,1); }
>  
> @@ -77,6 +80,21 @@ atomic_fetch_add_relaxed(V,X) __atomic_fetch_op{once}(X,+,V)
>  atomic_fetch_add_acquire(V,X) __atomic_fetch_op{acquire}(X,+,V)
>  atomic_fetch_add_release(V,X) __atomic_fetch_op{release}(X,+,V)
>  
> +atomic_fetch_and(V,X) __atomic_fetch_op{mb}(X,&,V)
> +atomic_fetch_and_relaxed(V,X) __atomic_fetch_op{once}(X,&,V)
> +atomic_fetch_and_acquire(V,X) __atomic_fetch_op{acquire}(X,&,V)
> +atomic_fetch_and_release(V,X) __atomic_fetch_op{release}(X,&,V)
> +
> +atomic_fetch_or(V,X) __atomic_fetch_op{mb}(X,|,V)
> +atomic_fetch_or_relaxed(V,X) __atomic_fetch_op{once}(X,|,V)
> +atomic_fetch_or_acquire(V,X) __atomic_fetch_op{acquire}(X,|,V)
> +atomic_fetch_or_release(V,X) __atomic_fetch_op{release}(X,|,V)
> +
> +atomic_fetch_xor(V,X) __atomic_fetch_op{mb}(X,^,V)
> +atomic_fetch_xor_relaxed(V,X) __atomic_fetch_op{once}(X,^,V)
> +atomic_fetch_xor_acquire(V,X) __atomic_fetch_op{acquire}(X,^,V)
> +atomic_fetch_xor_release(V,X) __atomic_fetch_op{release}(X,^,V)
> +
>  atomic_inc_return(X) __atomic_op_return{mb}(X,+,1)
>  atomic_inc_return_relaxed(X) __atomic_op_return{once}(X,+,1)
>  atomic_inc_return_acquire(X) __atomic_op_return{acquire}(X,+,1)
> @@ -117,3 +135,6 @@ atomic_sub_and_test(V,X) __atomic_op_return{mb}(X,-,V) == 0
>  atomic_dec_and_test(X)  __atomic_op_return{mb}(X,-,1) == 0
>  atomic_inc_and_test(X)  __atomic_op_return{mb}(X,+,1) == 0
>  atomic_add_negative(V,X) __atomic_op_return{mb}(X,+,V) < 0
> +atomic_add_negative_relaxed(V,X) __atomic_op_return{once}(X,+,V) < 0
> +atomic_add_negative_acquire(V,X) __atomic_op_return{acquire}(X,+,V) < 0
> +atomic_add_negative_release(V,X) __atomic_op_return{release}(X,+,V) < 0
> -- 
> 2.40.1
> 

